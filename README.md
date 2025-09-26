# Workshop di Deployment su OpenShift

Un workshop completo per apprendere il deployment di applicazioni containerizzate su OpenShift attraverso un'applicazione 3-tier moderna.

## � Panoramica del Workshop

Questo workshop ti guida attraverso il deployment di un'applicazione containerizzata completa su OpenShift utilizzando:

- **Frontend**: React TypeScript SPA con interfaccia moderna
- **Backend**: Python FastAPI con operazioni CRUD complete  
- **Database**: MariaDB con storage persistente
- **Containerization**: Container Docker per tutti i servizi
- **Orchestration**: Deployment nativo Kubernetes/OpenShift

## 🚀 Accesso al Workshop

**👉 [INIZIA IL WORKSHOP](./docs/README.md)**

Il workshop è organizzato in **9 passi incrementali** che ti guideranno dal setup iniziale al deployment completo dell'applicazione:

| Passo | Titolo | Focus |
|-------|--------|-------|
| **[Passo 1](./docs/passo-1-configurazione.md)** | Configurazione dell'Ambiente | Setup repository e tool OpenShift |
| **[Passo 2](./docs/passo-2-esplorazione.md)** | Esplorazione dell'ambiente | Web GUI e CLI di OpenShift |
| **[Passo 3](./docs/passo-3-primi-passi.md)** | Primi passi | Pod e Deployment fondamentali |
| **[Passo 4](./docs/passo-4-applicazione.md)** | L'applicazione del workshop | Architettura 3-tier |
| **[Passo 5](./docs/passo-5-database.md)** | Deployment del Database | MariaDB con storage persistente |
| **[Passo 6](./docs/passo-6-backend.md)** | Deployment dell'API Backend | FastAPI con REST API |
| **[Passo 7](./docs/passo-7-frontend.md)** | Deployment del Frontend | React SPA con routing |
| **[Passo 8](./docs/passo-8-osservabilita.md)** | Osservabilità | Metriche e monitoring |
| **[Passo 9](./docs/passo-9-database-switch.md)** | Migrazione database | Switch a database centralizzato |

## ✨ Caratteristiche del Workshop

### 📚 **Struttura Modulare**
- **Guide step-by-step** con obiettivi chiari per ogni passo
- **Navigazione interconnessa** tra le sezioni
- **Checkpoint di verifica** per validare i progressi
- **Troubleshooting dedicato** per ogni componente

### 🛠️ **Tecnologie Pratiche**
- **OpenShift/Kubernetes** - Pattern di deployment enterprise
- **Container Docker** - Best practices per containerizzazione
- **Storage Persistente** - Gestione dati con PVC e StatefulSet
- **Service Mesh** - Comunicazione sicura tra servizi
- **Osservabilità** - Metriche e monitoring con OpenTelemetry

### 🎯 **Obiettivi di Apprendimento**
Al termine del workshop, sarai in grado di:

- ✅ Deployare applicazioni 3-tier su OpenShift
- ✅ Gestire storage persistente e database
- ✅ Configurare networking e routing
- ✅ Implementare osservabilità e monitoring  
- ✅ Gestire configurazioni e secrets
- ✅ Eseguire migrazioni e scaling di applicazioni

## 🚀 Quick Start

### Prerequisiti
- Accesso a cluster OpenShift
- Docker Desktop installato
- VS Code installato

### Come iniziare

**👉 [ACCEDI AL WORKSHOP COMPLETO](./docs/README.md)**

1. **Clona il repository**
2. **Segui la guida passo-passo** iniziando dal [Passo 1](./docs/passo-1-configurazione.md)
3. **Completa i checkpoint** per verificare i progressi
4. **Deploy dell'applicazione completa** su OpenShift

## 📁 Struttura del Progetto

```
workshop/
├── docs/                    # 📚 Workshop modulare
│   ├── README.md           # Indice principale del workshop
│   ├── passo-1-configurazione.md
│   ├── passo-2-esplorazione.md
│   ├── ... (passi 3-9)
│   └── passo-9-database-switch.md
├── backend/                 # ⚙️ Python FastAPI backend
│   ├── app/                # Moduli applicazione
│   │   ├── config/         # Configurazione database
│   │   ├── models/         # Modelli dati
│   │   ├── repositories/   # Layer accesso dati
│   │   └── routes/         # Endpoint API
│   ├── Dockerfile          # Configurazione container backend
│   ├── requirements.txt    # Dipendenze Python
│   └── README.md          # Documentazione backend
├── frontend/               # 🖥️ React TypeScript frontend
│   ├── src/               # Codice sorgente
│   │   ├── components/    # Componenti React
│   │   ├── services/      # Integrazione API
│   │   └── types/         # Definizioni TypeScript
│   ├── public/            # Asset statici
│   ├── Dockerfile         # Configurazione container frontend
│   ├── package.json       # Dipendenze Node.js
│   └── README.md         # Documentazione frontend
├── openshift/              # 🚢 Manifesti Kubernetes/OpenShift
│   ├── test-pod.yaml      # Pod di test
│   ├── local-db.yaml      # Database MariaDB
│   ├── backend-deployment.yaml    # Deployment backend
│   ├── backend-network.yaml       # Service e Route backend
│   └── frontend-deployment.yaml   # Deployment frontend
├── db-init/               # 🗄️ Script inizializzazione DB
└── setup-scripts/        # 🛠️ Script automazione
```

## 🔧 Componenti dell'Architettura

### 🖥️ Frontend (React TypeScript)
- **React 18 moderno** con TypeScript
- **Design responsivo** con CSS personalizzato
- **Configurazione runtime** - URL API configurabile senza rebuild
- **Containerizzazione Docker** con Nginx
- **Gestione errori** con feedback user-friendly
- **Interfaccia CRUD** per gestione ordini

### ⚙️ Backend (FastAPI Python)
- **API RESTful** con operazioni CRUD complete
- **Integrazione Database** con supporto MariaDB/MySQL
- **Configurazione CORS** per compatibilità browser
- **Documentazione API** con generazione automatica Swagger
- **Supporto Docker** con build multi-stage
- **Configurazione ambiente** tramite variabili d'ambiente
- **Metriche Prometheus** per osservabilità

### 🗄️ Database (MariaDB)
- **Storage persistente** con StatefulSet
- **Schema strutturato** con indexing appropriato
- **Dati di esempio** per dimostrazione
- **Docker ready** con script di inizializzazione

## 🔄 Scenari del Workshop

Il progetto dimostra:

1. **🐳 Containerizzazione**: Best practice Docker per applicazioni web
2. **🔗 Microservizi**: Servizi frontend/backend separati
3. **💾 Integrazione Database**: Dati persistenti con MariaDB
4. **⚙️ Gestione Configurazioni**: Configurazione basata su ambiente
5. **📡 Sviluppo API**: Servizi RESTful con documentazione
6. **🖥️ Frontend Moderno**: React con TypeScript e design responsivo
7. **📊 Osservabilità**: Metriche e monitoring applicativo
8. **🔐 Gestione Secrets**: Credenziali e configurazioni sensibili

## 🔗 Risorse e Riferimenti

### 📚 **Documentazione Ufficiale**
- **[OpenShift Documentation](https://docs.openshift.com/)** - Documentazione completa OpenShift
- **[Kubernetes Documentation](https://kubernetes.io/docs/)** - Guida ufficiale Kubernetes
- **[12-Factor App Methodology](https://12factor.net/)** - Best practices per applicazioni cloud-native

### 🛠️ **Tool e Servizi**
- **OpenShift CLI**: [Download oc](https://developers.redhat.com/learning/learn:openshift:download-and-install-red-hat-openshift-cli/resource/resources:download-and-install-oc)
- **Cluster OpenShift del Workshop**: https://console.ocp4azexp2.cloudsvil.poste.it/
- **Container Best Practices**: [10 Things to Avoid](https://developers.redhat.com/blog/2016/02/24/10-things-to-avoid-in-docker-containers)

### 🚢 **Deployment e DevOps**
L'applicazione è progettata per deployment facile su:
- **🐳 Docker locale** (sviluppo)
- **📦 Docker Compose** (testing)
- **☸️ Kubernetes** (produzione)
- **🔴 OpenShift** (enterprise)

Ogni servizio include health check appropriati, limiti di risorse e capacità di scaling.

## 🤝 Contribuire

Questo è un progetto workshop per apprendere i pattern di deployment Kubernetes/OpenShift. Sentiti libero di estendere e modificare per le tue esigenze di apprendimento.

---

## 🚀 Inizia Subito

**👉 [ACCEDI AL WORKSHOP COMPLETO](./docs/README.md)**

Oppure vai direttamente al primo passo:

**🎯 [Passo 1: Configurazione dell'Ambiente →](./docs/passo-1-configurazione.md)**