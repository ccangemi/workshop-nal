# Script per cancellare namespace OpenShift del workshop
# Autore: Workshop NAL
# Data: 23 Settembre 2025

param(
    [switch]$DryRun = $false,
    [switch]$Force = $false,
    [string]$LabelSelector = "nal-ws=true"
)

function Test-OCCommand {
    try { $null = oc version 2>$null; return $true } catch { return $false }
}

function Test-OCLogin {
    try { $null = oc whoami 2>$null; return $true } catch { return $false }
}

function Get-WorkshopNamespaces {
    param([string]$Selector)
    try {
        $namespaces = oc get namespaces -l $Selector -o name 2>$null | ForEach-Object { $_ -replace "namespace/", "" }
        if ($LASTEXITCODE -ne 0) { throw "Failed to get namespaces" }
        return $namespaces | Where-Object { $_ -match "^ws-" }
    }
    catch {
        Write-Host "Error getting namespaces: $($_.Exception.Message)" -ForegroundColor Red
        return @()
    }
}

function Remove-WorkshopNamespace {
    param([string]$NamespaceName, [bool]$DryRunMode)
    
    Write-Host "Processing namespace: $NamespaceName" -ForegroundColor Yellow
    
    if ($DryRunMode) {
        Write-Host "[DRY RUN] Would delete namespace: $NamespaceName" -ForegroundColor Cyan
        return $true
    }
    
    try {
        Write-Host "Deleting namespace: $NamespaceName" -ForegroundColor Red
        oc delete namespace $NamespaceName --timeout=60s
        if ($LASTEXITCODE -ne 0) { throw "Failed to delete namespace" }
        Write-Host "Namespace deleted successfully: $NamespaceName" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "Error deleting namespace $NamespaceName : $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

function Get-UserConfirmation {
    param([string[]]$NamespacesToDelete, [bool]$ForceMode)
    
    if ($ForceMode) {
        Write-Host "Force mode - skipping confirmation" -ForegroundColor Magenta
        return $true
    }
    
    Write-Host ""
    Write-Host "WARNING: This will permanently delete the following namespaces:" -ForegroundColor Red
    $NamespacesToDelete | ForEach-Object { Write-Host "   $_" -ForegroundColor Red }
    Write-Host ""
    Write-Host "This action cannot be undone!" -ForegroundColor Red
    Write-Host ""
    
    do {
        $confirmation = Read-Host "Type DELETE to confirm (or cancel to abort)"
        if ($confirmation -eq "cancel") { return $false }
    } while ($confirmation -ne "DELETE")
    
    return $true
}

Write-Host "OpenShift Workshop Namespace Cleaner" -ForegroundColor Red
Write-Host "====================================" -ForegroundColor Red

if (-not (Test-OCCommand)) {
    Write-Host "ERROR: oc command not found" -ForegroundColor Red
    exit 1
}

if (-not (Test-OCLogin)) {
    Write-Host "ERROR: Not logged into OpenShift" -ForegroundColor Red
    exit 1
}

Write-Host "Prerequisites OK" -ForegroundColor Green

if ($DryRun) {
    Write-Host "DRY RUN MODE - No changes will be made" -ForegroundColor Magenta
}

if ($Force) {
    Write-Host "FORCE MODE - No confirmation prompts" -ForegroundColor Magenta
}

Write-Host "Searching for workshop namespaces..." -ForegroundColor Yellow
$namespacesToDelete = Get-WorkshopNamespaces -Selector $LabelSelector

if ($namespacesToDelete.Count -eq 0) {
    Write-Host "No workshop namespaces found with label: $LabelSelector" -ForegroundColor Green
    exit 0
}

Write-Host "Found $($namespacesToDelete.Count) workshop namespaces:" -ForegroundColor Yellow
$namespacesToDelete | ForEach-Object { Write-Host "   $_" -ForegroundColor Gray }

if (-not $DryRun -and -not (Get-UserConfirmation -NamespacesToDelete $namespacesToDelete -ForceMode $Force.IsPresent)) {
    Write-Host "Operation cancelled" -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "Processing namespaces..." -ForegroundColor Red

$successCount = 0
$errorCount = 0

foreach ($namespace in $namespacesToDelete) {
    $result = Remove-WorkshopNamespace -NamespaceName $namespace -DryRunMode $DryRun.IsPresent
    if ($result) { $successCount++ } else { $errorCount++ }
}

Write-Host ""
Write-Host "Operation Summary:" -ForegroundColor Cyan
Write-Host "Successfully deleted: $successCount" -ForegroundColor Green
Write-Host "Errors: $errorCount" -ForegroundColor Red

if ($DryRun) {
    Write-Host "This was a dry run. Use without -DryRun to execute deletion." -ForegroundColor Magenta
}

if ($errorCount -eq 0) {
    if ($DryRun) {
        Write-Host "Dry run completed successfully!" -ForegroundColor Green
    } else {
        Write-Host "All deletions completed successfully!" -ForegroundColor Green
    }
} else {
    Write-Host "Some operations failed. Please check the output above." -ForegroundColor Yellow
}

if (-not $DryRun -and $successCount -gt 0) {
    Write-Host ""
    Write-Host "Final verification..." -ForegroundColor Yellow
    $remainingNamespaces = Get-WorkshopNamespaces -Selector $LabelSelector
    
    if ($remainingNamespaces.Count -eq 0) {
        Write-Host "All workshop namespaces have been successfully removed." -ForegroundColor Green
    } else {
        Write-Host "Warning: $($remainingNamespaces.Count) namespaces still exist:" -ForegroundColor Yellow
        $remainingNamespaces | ForEach-Object { Write-Host "   $_" -ForegroundColor Yellow }
    }
}
