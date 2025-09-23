# Script per creare namespace OpenShift per workshop
# Autore: Workshop NAL  
# Data: 23 Settembre 2025

param(
    [Parameter(Position=0, Mandatory=$true)]
    [string]$UsersFile,
    [switch]$DryRun = $false
)

function Test-OCCommand {
    try { $null = oc version 2>$null; return $true } catch { return $false }
}

function Test-OCLogin {
    try { $null = oc whoami 2>$null; return $true } catch { return $false }
}

function New-WorkshopNamespace {
    param([string]$Username, [bool]$DryRunMode)
    $namespaceName = "ws-$($Username.ToLower())"
    Write-Host "Processing user: $Username -> $namespaceName" -ForegroundColor Yellow
    
    if ($DryRunMode) {
        Write-Host "[DRY RUN] Would create namespace: $namespaceName" -ForegroundColor Cyan
        return $true
    }
    
    try {
        $existing = oc get project $namespaceName 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Namespace already exists: $namespaceName" -ForegroundColor Yellow
        } else {
            Write-Host "Creating namespace: $namespaceName" -ForegroundColor Green
            oc new-project $namespaceName --display-name="Workshop $Username"
            if ($LASTEXITCODE -ne 0) { throw "Failed to create namespace" }
        }
        
        Write-Host "Adding labels..." -ForegroundColor Green
        oc label namespace $namespaceName nal-ws=true admission-webhook=false --overwrite
        if ($LASTEXITCODE -ne 0) { throw "Failed to add labels" }
        
        Write-Host "Creating rolebinding..." -ForegroundColor Green
        oc create rolebinding "$Username-admin" --clusterrole=admin --user=$Username -n $namespaceName 2>$null
        if ($LASTEXITCODE -ne 0) {
            oc patch rolebinding "$Username-admin" -n $namespaceName --type=merge -p="{\"subjects\":[{\"kind\":\"User\",\"name\":\"$Username\",\"apiGroup\":\"rbac.authorization.k8s.io\"}]}" 2>$null
        }
        
        Write-Host "User setup completed: $Username" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "Error processing user $Username : $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

Write-Host "OpenShift Workshop Namespace Creator" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

if (-not (Test-OCCommand)) {
    Write-Host "ERROR: oc command not found" -ForegroundColor Red
    exit 1
}

if (-not (Test-OCLogin)) {
    Write-Host "ERROR: Not logged into OpenShift" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $UsersFile)) {
    Write-Host "ERROR: Users file not found: $UsersFile" -ForegroundColor Red
    exit 1
}

Write-Host "Prerequisites OK" -ForegroundColor Green

if ($DryRun) {
    Write-Host "DRY RUN MODE - No changes will be made" -ForegroundColor Magenta
}

try {
    $users = Get-Content $UsersFile | Where-Object { $_.Trim() -ne "" } | ForEach-Object { $_.Trim() }
    
    if ($users.Count -eq 0) {
        Write-Host "ERROR: No users found in file" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "Found $($users.Count) users to process" -ForegroundColor Green
    
    if (-not $DryRun) {
        $confirmation = Read-Host "Proceed? (y/N)"
        if ($confirmation -notmatch '^[Yy]$') {
            Write-Host "Operation cancelled" -ForegroundColor Yellow
            exit 0
        }
    }
    
    $successCount = 0
    $errorCount = 0
    
    foreach ($user in $users) {
        if ([string]::IsNullOrWhiteSpace($user)) { continue }
        if ($user -notmatch '^[a-zA-Z0-9_.-]+$') {
            Write-Host "Skipping invalid username: $user" -ForegroundColor Yellow
            $errorCount++
            continue
        }
        
        $result = New-WorkshopNamespace -Username $user -DryRunMode $DryRun.IsPresent
        if ($result) { $successCount++ } else { $errorCount++ }
    }
    
    Write-Host ""
    Write-Host "Operation Summary:" -ForegroundColor Cyan
    Write-Host "Successful: $successCount" -ForegroundColor Green
    Write-Host "Errors: $errorCount" -ForegroundColor Red
    
    if ($DryRun) {
        Write-Host "This was a dry run. Use without -DryRun to execute." -ForegroundColor Magenta
    }
}
catch {
    Write-Host "ERROR reading users file: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
