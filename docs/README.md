# Workshop di Deployment su OpenShift

## 🎯 Panoramica del Workshop

Questo workshop ti guiderà nella familiarizzazione con OpenShift, su come consultare e deployare risorse all'interno di un cluster; in particolare rilasceremo un'applicazione 3-tier utilizzando costrutti tipici di Kubernetes.

## 📋 Prerequisiti

Prima di iniziare il workshop, assicurati di avere:

- Abilitazione accesso a OpenShift
- Docker Desktop installato ed avviato
- VS Code installato

## 🔗 Riferimenti

- **Repo del workshop**: https://github.com/ccangemi/workshop-nal
- **Cluster OpenShift del workshop**: https://console.ocp4azexp2.cloudsvil.poste.it/

## 📚 Indice del Workshop

Segui i passi nell'ordine indicato:

| Passo | Titolo | Descrizione |
|-------|--------|-------------|
| [**Passo 1**](./passo-1-configurazione.md) | Configurazione dell'Ambiente | Setup del repository e dei tool OpenShift |
| [**Passo 2**](./passo-2-esplorazione.md) | Esplorazione dell'ambiente | Web GUI e CLI di OpenShift |
| [**Passo 3**](./passo-3-primi-passi.md) | Primi passi | Creazione e gestione di Pod e Deployment |
| [**Passo 4**](./passo-4-applicazione.md) | L'applicazione del workshop | Panoramica dell'app 3-tier |
| [**Passo 5**](./passo-5-database.md) | Deployment del Database | Configurazione e deploy del database MariaDB |
| [**Passo 6**](./passo-6-backend.md) | Deployment dell'API Backend | Deploy del backend FastAPI Python |
| [**Passo 7**](./passo-7-frontend.md) | Deployment del Frontend | Deploy del frontend React TypeScript |
| [**Passo 8**](./passo-8-osservabilita.md) | Osservabilità | Setup delle metriche e monitoraggio |
| [**Passo 9**](./passo-9-database-switch.md) | Collegare il database | Switch verso database centralizzato |

---

## 🎯 Risultati Attesi

Al termine di questo workshop, i partecipanti avranno:

1. ✅ Fatto il deploy di un'applicazione completa a 3 livelli su OpenShift
2. ✅ Compreso i pattern di deployment di OpenShift
3. ✅ Configurato lo storage persistente per i database
4. ✅ Impostato la comunicazione tra servizi e il routing
5. ✅ Implementato strategie di monitoraggio e scaling

## 📖 Risorse Aggiuntive

Per approfondimenti e ulteriori informazioni:

- **[Documentazione OpenShift](https://docs.openshift.com/)**
- **[Best Practice per Container](https://developers.redhat.com/blog/2016/02/24/10-things-to-avoid-in-docker-containers)**
- **[Metodologia 12-Factor App](https://12factor.net/)**
- **[Observability 2.0](https://gitlab.alm.poste.it/hybridcloud/gen3/observability-2.0/otel-for-metrics-app.git)**

---

**🚀 Inizia il workshop:** [Passo 1: Configurazione dell'Ambiente →](./passo-1-configurazione.md)