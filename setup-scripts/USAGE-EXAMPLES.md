# Workshop Scripts - Esempi di Utilizzo

Questa cartella contiene script per la gestione automatica dei namespace OpenShift per workshop.

## 📁 File disponibili

- `create-namespaces.ps1` - Crea namespace per utenti
- `delete-namespaces.ps1` - Cancella namespace del workshop  
- `users.txt` - Lista degli utenti del workshop
- `users-example.txt` - Esempio di file utenti
- `README-namespaces.md` - Documentazione script creazione
- `README-delete-namespaces.md` - Documentazione script cancellazione

## 🚀 Workflow Completo

### 1. Preparazione Workshop
```powershell
# Test di creazione (dry-run)
.\create-namespaces.ps1 .\users.txt -DryRun

# Creazione effettiva dei namespace
.\create-namespaces.ps1 .\users.txt
```

### 2. Durante il Workshop
```powershell
# Verifica namespace creati
oc get namespaces -l nal-ws=true

# Verifica rolebinding per un utente specifico
oc get rolebinding -n ws-mario.rossi
```

### 3. Pulizia Post-Workshop
```powershell
# Test di cancellazione (dry-run)
.\delete-namespaces.ps1 -DryRun

# Cancellazione effettiva
.\delete-namespaces.ps1

# Verifica pulizia completata
oc get namespaces -l nal-ws=true
```

## 🔄 Reset Completo

Per fare un reset completo del workshop (cancella e ricrea tutto):

```powershell
# Script di reset completo
.\delete-namespaces.ps1 -Force
Start-Sleep -Seconds 15
.\create-namespaces.ps1 .\users.txt
```

## 📋 Comandi di Verifica Utili

```powershell
# Lista tutti i namespace del workshop
oc get namespaces -l nal-ws=true

# Conta namespace del workshop
(oc get namespaces -l nal-ws=true --no-headers).Count

# Lista namespace con dettagli
oc get namespaces -l nal-ws=true -o wide

# Verifica un namespace specifico
oc describe namespace ws-mario.rossi

# Lista tutti i rolebinding nei namespace del workshop
oc get rolebinding --all-namespaces | findstr "ws-"

# Verifica risorse in un namespace
oc get all -n ws-mario.rossi
```

## 🛠️ Personalizzazioni

### File utenti personalizzato
```powershell
# Crea il tuo file utenti
echo "user1`nuser2`nuser3" > miei-utenti.txt

# Usa il file personalizzato
.\create-namespaces.ps1 miei-utenti.txt
```

### Label personalizzato
```powershell
# Cancella namespace con label diverso
.\delete-namespaces.ps1 -LabelSelector "workshop=test"
```

## 🚨 Troubleshooting

### Namespace bloccato in "Terminating"
```powershell
# Forza rimozione finalizers (usare con cautela)
oc patch namespace ws-username -p '{"metadata":{"finalizers":null}}' --type=merge
```

### Verifica privilegi utente
```powershell
# Verifica chi sei
oc whoami

# Verifica privilegi in un namespace
oc auth can-i create pods -n ws-mario.rossi --as=mario.rossi
```

### Debug problemi di rete
```powershell
# Test di connettività al cluster
oc cluster-info

# Verifica versione client/server
oc version
```