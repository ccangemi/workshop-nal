# Workshop di Deployment su OpenShift

## Panoramica del Workshop

Questo workshop ti guida attraverso il deployment di un'applicazione containerizzata completa a 3 livelli su OpenShift. L'applicazione è composta da:
- **Frontend**: React TypeScript SPA
- **Backend**: Python FastAPI REST API
- **Database**: MariaDB

## Prerequisiti

- Abilitazione accesso a OpenShift
- Docker Desktop installato
- VS Code installato

## Riferimenti

- Repo del workshop: https://github.com/ccangemi/workshop-nal
- Cluster OpenShift del workshop: https://console.ocp4azexp2.cloudsvil.poste.it/

## Passi del Workshop

### Passo 1: Configurazione dell'Ambiente

#### Setup del repo del progetto su Visual Studio Code
- Accedere a `https://github.com/ccangemi/workshop-nal/blob/master/WORKSHOP.md`
- Aprire VS Code sul proprio computer
- Espandere il menù a sinistra di VSCode -> Explorer
- Selezionare "Clone Repository" ed inserire `https://github.com/ccangemi/workshop-nal.git`
- Selezionare una cartella dove scaricare il repo sulla propria macchina locale
- Una volta terminato il clone, scegliere "Open" per aprire il repo appena scaricato
- Confermare con "Yes, I trust the authors" in caso di popup di autorizzazione

#### Setup dei tool di OpenShift
- Accedere a: `https://console.ocp4azexp2.cloudsvil.poste.it/` ed effettuare login tramite SSO aziendale (selezionare il pulsante AAD)
- Selezionare il pulsante (?) in alto a destra e scegliere la voce "Command Line Tools"
- Scaricare la versione del client `oc` compatibile col proprio sistema
  Ad esempio, per Windows: 
  - Selezionare "Download oc for Windows for x86_64"
  - Una volta scaricato lo zip estrarre il suo contenuto (`oc.exe`) nella directory `C:\Users\<username>\AppData\Local\Microsoft\WindowsApps` (sostituire con il proprio username)
  - Scaricare `https://developers.redhat.com/content-gateway/file/pub/openshift-v4/clients/helm/3.17.1/helm-windows-amd64.exe` nella stessa directory di sopra
  - Verificare il corretto funzionamento:
    - Aprire terminale da VS Code: Menu Terminal -> New Terminal
    - Digitare `oc version` e `helm version`

### Passo 2: Esplorazione dell'ambiente (Web + CLI)

#### Web GUI
- _GUI OpenShift e come muoversi_
- _Gli oggetti che verranno utilizzati_:
  - `Deployment`
  - `ReplicaSet`
  - `Pod`
  - `ConfigMap`
  - `Secret`
  - `Service`
  - `Route`
  - `PersistentVolume(Claim)`

#### oc CLI
- Effettuare login su terminale:
    - Nella web GUI di Openshift, fare click su menu proprio user in alto a destra
    - Copy login command -> SSO (AAD) - > Display token -> Copia comando `oc login ...`
    - Esecuzione del comando di login su proprio terminale VS Code
    - Confermare con `y` alla domanda "Use insecure connections?"
- _Sintassi dei comandi della CLI_; es: `oc project`, `oc get`, `oc apply`

### Passo 3: Primi passi
In questa sezione proveremo a creare un pod di prova utilizzando sia la CLI che la Web GUI.
- Accedere al proprio namespace: `oc project wsnal-<user>`
- Test comando: `oc get pod` che risultarà ovviamente vuoto
- Creare un pod di prova: `oc create -f ./openshift/test-pod.yaml`
- Analizzare il pod appena creato:
  - `oc get pods`
  - `oc get pod example -o yaml`
- _Struttura di un pod_
- Analizzare il pod nell'interfaccia web: Workloads -> Pods -> `example`
    - Analizzare i tab: Details, Metrics, Logs...
    - Analizzare menu Actions
- Eliminare il pod: `oc delete pod example`

- Creare un deployment di prova: `oc create -f ./openshift/test-deployment.yaml`
- _Struttura del Deployment (replicas, selector) e vantaggi_:
    - Scaling: Può facilmente aumentare/diminuire il numero di repliche 
    - Self-healing: Riavvia automaticamente i pod che falliscono 
    - Rolling updates:  Può aggiornare l'applicazione senza tempi di inattività 
    - Declarative management: Kubernetes garantisce che lo stato desiderato venga mantenuto
- Visualizzare l'elenco dei pod: `oc get pods -l app=httpd` (segnarsi il nome di un pod)
- Eliminare un pod: `oc delete pod <nome_pod>`
- Scalare il deployment: `oc scale deployment example-deployment --replicas=4`
- Eliminare il deployment: `oc delete deployment example-deployment`

### Passo 4: L'applicazione oggetto del workshop

### Passo 5: Deployment del Database
Iniziamo creando il DB nel quale verranno registrati permanentemente gli ordini

- Nel terminale eseguire: `oc create -f ./openshift/local-db.yaml`
- Controllare lo stato di inizializzazione del pod: `oc get pod -w` (ctrl+c per interrompere). 
  Osservare anche da web UI
- Verificare gli oggetti creati: `oc get service`, `oc get pvc`, `oc get statefulset`
- _StefulSet vs Deployment_
- Eseguire script di inizializzazione del DB: `./openshift/init-db.bat`

### Passo 3: Deployment dell'API Backend
Procediamo creando lo strato di backend dell'applicazione. Questo container sa collegarsi al DB ed espone i propri servizi tramite REST API

- Buildiamo l'immagine: `docker build .\backend\ -t postesviluppo.azurecr.io/cangem/workshop-backend`
- _L'immagine va pushata sul registry_
- Creare il deployment del backend: `oc create -f ./openshift/backend-deployment.yaml`
- _Osserviamo gli oggetti creati: Deployment, ConfigMap_
- Creare gli oggetti di rete del backend: `oc create -f ./openshift/backend-network.yaml`
- _Osserviamo gli oggetti creati: Service, Route_
- Visualizzare le REST APIs esposte dal backend: 
    - Aprire il browser su: https://workshop-backend-<namespace>.apps.ocp4azexp2.cloudsvil.poste.it/docs
- Provare ad interrogare la rotta per ottenere la lista degli ordini: `curl.exe 'https://workshop-backend-test.apps.ocp4azexp2.cloudsvil.poste.it/api/v1/orders/'`  
  **Usare `curl.exe` su Windows non semplicemente `curl`**
- Scalare il deployment: `oc scale deployment workshop-backend --replicas=3`
- _Verificare che la curl continui a funzionare. Il service fa da smistatore_

### Passo 4: Deployment del Frontend
Completiamo lo stack aggiungendo l'ultimo layer: il frontend

- Creare il deployment del frontend: `oc create -f ./openshift/frontend-deployment.yaml`
- Visualizzare la url per accedere alla web app appena deployata: `oc get route workshop-frontend -o jsonpath='{.spec.host}'`
- Aprire browser e andare all'indirizzo prelevato da HOST/PORT
- Testare l'app creando/visualizzando/editando/cancellando gli ordini

### Passo 5: Osservabilità
In questa ultima sezione installeremo un collettore che si occupa di raccogliere le metriche applicative esposte dal backend.

- Per visualizzare le metriche esposte, collegarsi alla rotta del backend: `oc get route workshop-backend -o jsonpath='{.spec.host}'` e aggiungere il path `/metrics` all'url appena estratta.
- _Verificare le metriche ed il loro scopo_
- _Osservare le annotation del Deployment/Pod del backend_: `oc get deployment workshop-backed -oyaml`
- Aprire una nuova istanza di VSCode: File -> New Window`
- Espandere il menù a sinistra di VSCode -> Explorer
- Selezionare "Clone Repository" ed inserire `https://gitlab.alm.poste.it/hybridcloud/gen3/observability-2.0/otel-for-metrics-app.git`
- Selezionare una cartella dove scaricare il repo sulla propria macchina locale
- Una volta terminato il clone, scegliere "Open" per aprire il repo appena scaricato
- Confermare con "Yes, I trust the authors" in caso di popup di autorizzazione

- _Cosa è un chart_
- Aprire il file ./deploy-cli/values.yaml
- Personalizzare l'attributo: 
  ```yaml
  [...]
  regex_metric_relabel_configs: "orders.*"
  [...]
  ```
- effettuare l'installazione del chart nel proprio namespace: `helm upgrade otel --install .\.helm\ -n <proprio_namespace> -f .\deploy-cli\values.yaml`
- Le metriche da ora in poi sono collezionate nel sistema centralizzato
- _Visualizzare la dashboard (**solo l'istruttore**)_

# Passo 6: collegare il database
- _Cambiare il puntamento del backend affinché salvi su DB creato precedentemente tramite IaC (**solo l'istruttore**)_
- _Simulare la creazione di un ordine con successivo invio di email

## Risultati Attesi

Al termine di questo workshop, i partecipanti avranno:
- Fatto il deploy di un'applicazione completa a 3 livelli su OpenShift
- Compreso i pattern di deployment di OpenShift
- Configurato lo storage persistente per i database
- Impostato la comunicazione tra servizi e il routing
- Implementato strategie di monitoraggio e scaling

## Risorse Aggiuntive

- [Documentazione OpenShift](https://docs.openshift.com/)
- [Best Practice per Container](https://developers.redhat.com/blog/2016/02/24/10-things-to-avoid-in-docker-containers)
- [Metodologia 12-Factor App](https://12factor.net/)
- [Observability 2.0](https://gitlab.alm.poste.it/hybridcloud/gen3/observability-2.0/otel-for-metrics-app.git)