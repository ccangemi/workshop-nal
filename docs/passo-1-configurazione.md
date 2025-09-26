# Passo 1: Configurazione dell'Ambiente

## 🎯 Obiettivi di questo passo

- Configurare l'ambiente di sviluppo
- Scaricare il repository del workshop
- Installare e configurare i tool OpenShift

---

## Setup del repo del progetto su Visual Studio Code

1. Accedere a `https://github.com/ccangemi/workshop-nal/blob/master/WORKSHOP.md`
2. Aprire VS Code sul proprio computer
3. Espandere il menù a sinistra di VSCode → Explorer
4. Selezionare "Clone Repository" ed inserire `https://github.com/ccangemi/workshop-nal.git`
5. Selezionare una cartella dove scaricare il repo sulla propria macchina locale
6. Una volta terminato il clone, scegliere "Open" per aprire il repo appena scaricato
7. Confermare con "Yes, I trust the authors" in caso di popup di autorizzazione

## Setup dei tool di OpenShift

1. Accedere a: `https://console.ocp4azexp2.cloudsvil.poste.it/` ed effettuare login tramite SSO aziendale (selezionare il pulsante AAD)
2. Selezionare il pulsante (?) in alto a destra e scegliere la voce "Command Line Tools"
3. Scaricare la versione del client `oc` compatibile col proprio sistema
   
   **Ad esempio, per Windows:**
   1. Selezionare "Download oc for Windows for x86_64"
   2. Una volta scaricato lo zip estrarre il suo contenuto (`oc.exe`) nella directory `C:\Users\<username>\AppData\Local\Microsoft\WindowsApps` (sostituire con il proprio username)
   3. Scaricare `https://developers.redhat.com/content-gateway/file/pub/openshift-v4/clients/helm/3.17.1/helm-windows-amd64.exe` nella stessa directory di sopra

4. **Verificare il corretto funzionamento:**
   1. Aprire terminale da VS Code: Menu Terminal → New Terminal
   2. Digitare `oc version` e `helm version`

---

## ✅ Checkpoint

Prima di procedere al passo successivo, verifica che:

- [ ] VS Code sia aperto con il repository clonato
- [ ] Il comando `oc version` restituisca una versione valida
- [ ] Il comando `helm version` restituisca una versione valida

---

## 🚀 Prossimo passo

**Continua con:** [Passo 2: Esplorazione dell'ambiente →](./passo-2-esplorazione.md)

## 🔙 Navigazione

- [← Indice Workshop](./README.md)
- [Passo 2: Esplorazione dell'ambiente →](./passo-2-esplorazione.md)