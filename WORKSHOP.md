# Workshop di Deployment su OpenShift

## Panoramica del Workshop

Questo workshop ti guida attraverso il deployment di un'applicazione containerizzata completa a 3 livelli su OpenShift. L'applicazione è composta da:
- **Frontend**: React TypeScript SPA
- **Backend**: Python FastAPI REST API
- **Database**: MariaDB

## Prerequisiti

- OpenShift CLI (`oc`) installato
- Accesso a un cluster OpenShift
- Immagini Docker costruite o accesso a container registry

## Passi del Workshop

### Passo 1: Configurazione dell'Ambiente
- [ ] Login al cluster OpenShift
- [ ] Creazione di un nuovo progetto/namespace
- [ ] Verifica dell'accesso al cluster

### Passo 2: Deployment del Database
- [ ] Deploy di MariaDB
- [ ] Configurazione dello storage persistente
- [ ] Impostazione delle credenziali del database
- [ ] Verifica della connettività del database

### Passo 3: Deployment dell'API Backend
- [ ] Deploy dell'applicazione FastAPI
- [ ] Configurazione delle variabili d'ambiente
- [ ] Impostazione della connessione al database
- [ ] Creazione del service e esposizione delle route

### Passo 4: Deployment del Frontend
- [ ] Deploy dell'applicazione React
- [ ] Configurazione dell'endpoint API
- [ ] Impostazione del serving con Nginx
- [ ] Creazione del service e delle route

### Passo 5: Test di Integrazione
- [ ] Test del flusso completo dell'applicazione
- [ ] Verifica della comunicazione tra i servizi
- [ ] Controllo della funzionalità dell'applicazione

### Passo 6: Scaling e Gestione
- [ ] Scaling dei componenti dell'applicazione
- [ ] Monitoraggio dell'utilizzo delle risorse
- [ ] Configurazione degli health check
- [ ] Impostazione del logging

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