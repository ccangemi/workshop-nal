# Workshop di Deployment su OpenShift

## Panoramica del Workshop

Questo workshop ti guiderà nella familiarizzazione con OpenShift, come consultare e deployare risorse all'interno di un cluster, in particolare rilasceremo un'applicazione 3-tier utilizzando costrutti tipici di Kubernetes.

## Prerequisiti

Prima di iniziare il workshop, assicurati di avere:

- Abilitazione accesso a OpenShift
- Docker Desktop installato
- VS Code installato

## Riferimenti

- **Repo del workshop**: https://github.com/ccangemi/workshop-nal
- **Cluster OpenShift del workshop**: https://console.ocp4azexp2.cloudsvil.poste.it/

## Passi del Workshop

### Passo 1: Configurazione dell'Ambiente

#### Setup del repo del progetto su Visual Studio Code

1. Accedere a `https://github.com/ccangemi/workshop-nal/blob/master/WORKSHOP.md`
2. Aprire VS Code sul proprio computer
3. Espandere il menù a sinistra di VSCode → Explorer
4. Selezionare "Clone Repository" ed inserire `https://github.com/ccangemi/workshop-nal.git`
5. Selezionare una cartella dove scaricare il repo sulla propria macchina locale
6. Una volta terminato il clone, scegliere "Open" per aprire il repo appena scaricato
7. Confermare con "Yes, I trust the authors" in caso di popup di autorizzazione

#### Setup dei tool di OpenShift

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

### Passo 2: Esplorazione dell'ambiente (Web + CLI)

#### Web GUI

Panoramica dell'interfaccia OpenShift e degli oggetti che verranno utilizzati:

- _Panoramica GUI OpenShift e come muoversi_
- _Panoramica sugli oggetti che verranno utilizzati:_
  - `Deployment`
  - `ReplicaSet`
  - `Pod`
  - `ConfigMap`
  - `Secret`
  - `Service`
  - `Route`
  - `PersistentVolume(Claim)`

#### oc CLI

**Effettuare login su terminale:**

1. Nella web GUI di OpenShift, fare click su menu proprio user in alto a destra
2. Copy login command → SSO (AAD) → Display token → Copia comando `oc login ...`
3. Esecuzione del comando di login su proprio terminale VS Code
4. Confermare con `y` alla domanda "Use insecure connections?"

**Sintassi dei comandi della CLI:** esempi: `oc project`, `oc get`, `oc apply`

### Passo 3: Primi passi

In questa sezione proveremo a creare un pod di prova utilizzando sia la CLI che la Web GUI.

#### Creazione e gestione di un Pod

1. Accedere al proprio namespace: `oc project wsnal-<user>`
2. Test comando: `oc get pod` che risultarà ovviamente vuoto
3. Creare un pod di prova: `oc create -f ./openshift/test-pod.yaml`
4. **Analizzare il pod appena creato:**
   - `oc get pods`
   - `oc get pod example -o yaml`
5. **Struttura di un pod** (analisi teorica)
6. **Analizzare il pod nell'interfaccia web:** Workloads → Pods → `example`
   - Analizzare i tab: Details, Metrics, Logs...
   - Analizzare menu Actions
7. Eliminare il pod: `oc delete pod example`

#### Creazione e gestione di un Deployment

1. Creare un deployment di prova: `oc create -f ./openshift/test-deployment.yaml`
2. **Struttura del Deployment (replicas, selector) e vantaggi:**
   - **Scaling:** Può facilmente aumentare/diminuire il numero di repliche
   - **Self-healing:** Riavvia automaticamente i pod che falliscono
   - **Rolling updates:** Può aggiornare l'applicazione senza tempi di inattività
   - **Declarative management:** Kubernetes garantisce che lo stato desiderato venga mantenuto
3. Visualizzare l'elenco dei pod: `oc get pods -l app=httpd` (segnarsi il nome di un pod)
4. Eliminare un pod: `oc delete pod <nome_pod>`
5. Scalare il deployment: `oc scale deployment example-deployment --replicas=4`
6. Eliminare il deployment: `oc delete deployment example-deployment`

### Passo 4: L'applicazione oggetto del workshop

L'applicazione è composta da:

- **Frontend**: React TypeScript SPA
- **Backend**: Python FastAPI REST API
- **Database**: MariaDB (successivamente switcheremo verso il DB MSSQL deployato precedentemente)

### Passo 5: Deployment del Database

Iniziamo creando il DB nel quale verranno registrati permanentemente gli ordini.

1. Nel terminale eseguire: `oc create -f ./openshift/local-db.yaml`
2. Controllare lo stato di inizializzazione del pod: `oc get pod -w` (ctrl+c per interrompere)
   - Osservare anche da web UI
3. Verificare gli oggetti creati: `oc get service`, `oc get pvc`, `oc get statefulset`
4. **StatefulSet vs Deployment** (differenze concettuali)
5. Eseguire script di inizializzazione del DB: `./openshift/init-db.bat`

### Passo 6: Deployment dell'API Backend

Procediamo creando lo strato di backend dell'applicazione. Questo container sa collegarsi al DB ed espone i propri servizi tramite REST API.

1. Buildiamo l'immagine: `docker build .\backend\ -t postesviluppo.azurecr.io/cangem/workshop-backend`
2. **L'immagine va pushata sul registry**
3. Creare il deployment del backend: `oc create -f ./openshift/backend-deployment.yaml`
4. **Osserviamo gli oggetti creati:** Deployment, ConfigMap
5. Creare gli oggetti di rete del backend: `oc create -f ./openshift/backend-network.yaml`
6. **Osserviamo gli oggetti creati:** Service, Route
7. **Visualizzare le REST APIs esposte dal backend:**
   - Aprire il browser su: `https://workshop-backend-<namespace>.apps.ocp4azexp2.cloudsvil.poste.it/docs`
8. Provare ad interrogare la rotta per ottenere la lista degli ordini:
   ```bash
   curl.exe 'https://workshop-backend-test.apps.ocp4azexp2.cloudsvil.poste.it/api/v1/orders/'
   ```
   > **Nota:** Usare `curl.exe` su Windows, non semplicemente `curl`
9. Scalare il deployment: `oc scale deployment workshop-backend --replicas=3`
10. **Verificare che la curl continui a funzionare.** Il service fa da smistatore

### Passo 7: Deployment del Frontend

Completiamo lo stack aggiungendo l'ultimo layer: il frontend.

1. Creare il deployment del frontend: `oc create -f ./openshift/frontend-deployment.yaml`
2. Visualizzare la url per accedere alla web app appena deployata:
   ```bash
   oc get route workshop-frontend -o jsonpath='{.spec.host}'
   ```
3. Aprire browser e andare all'indirizzo prelevato da HOST/PORT
4. Testare l'app creando/visualizzando/editando/cancellando gli ordini

### Passo 8: Osservabilità

In questa ultima sezione installeremo un collettore che si occupa di raccogliere le metriche applicative esposte dal backend.

#### Visualizzazione delle metriche esistenti

1. Per visualizzare le metriche esposte, collegarsi alla rotta del backend:
   ```bash
   oc get route workshop-backend -o jsonpath='{.spec.host}'
   ```
   e aggiungere il path `/metrics` all'url appena estratta.
2. **Verificare le metriche ed il loro scopo**
3. **Osservare le annotation del Deployment/Pod del backend:**
   ```bash
   oc get deployment workshop-backend -oyaml
   ```

#### Setup del collettore di metriche

4. Aprire una nuova istanza di VSCode: File → New Window
5. Espandere il menù a sinistra di VSCode → Explorer
6. Selezionare "Clone Repository" ed inserire `https://gitlab.alm.poste.it/hybridcloud/gen3/observability-2.0/otel-for-metrics-app.git`
7. Selezionare una cartella dove scaricare il repo sulla propria macchina locale
8. Una volta terminato il clone, scegliere "Open" per aprire il repo appena scaricato
9. Confermare con "Yes, I trust the authors" in caso di popup di autorizzazione

#### Configurazione e installazione

10. **Cosa è un chart** (spiegazione teorica)
11. Aprire il file `./deploy-cli/values.yaml`
12. Personalizzare l'attributo:
    ```yaml
    [...]
    regex_metric_relabel_configs: "orders.*"
    [...]
    ```
13. Effettuare l'installazione del chart nel proprio namespace:
    ```bash
    helm upgrade otel --install .\.helm\ -n <proprio_namespace> -f .\deploy-cli\values.yaml
    ```
14. Le metriche da ora in poi sono collezionate nel sistema centralizzato
15. **Visualizzare la dashboard** (**solo l'istruttore**)

### Passo 9: Collegare il database

1. **Cambiare il puntamento del backend** affinché salvi su DB creato precedentemente tramite IaC (**solo l'istruttore**)
2. **Simulare la creazione di un ordine** con successivo invio di email

## Risultati Attesi

Al termine di questo workshop, i partecipanti avranno:

1. Fatto il deploy di un'applicazione completa a 3 livelli su OpenShift
2. Compreso i pattern di deployment di OpenShift
3. Configurato lo storage persistente per i database
4. Impostato la comunicazione tra servizi e il routing
5. Implementato strategie di monitoraggio e scaling

## Risorse Aggiuntive

Per approfondimenti e ulteriori informazioni:

- **[Documentazione OpenShift](https://docs.openshift.com/)**
- **[Best Practice per Container](https://developers.redhat.com/blog/2016/02/24/10-things-to-avoid-in-docker-containers)**
- **[Metodologia 12-Factor App](https://12factor.net/)**
- **[Observability 2.0](https://gitlab.alm.poste.it/hybridcloud/gen3/observability-2.0/otel-for-metrics-app.git)**