# Passo 6: Deployment dell'API Backend

## 🎯 Obiettivi di questo passo

- Buildare l'immagine Docker del backend
- Deployare l'API FastAPI
- Configurare la comunicazione con il database
- Esporre il servizio all'esterno tramite Route
- Testare le API REST

---

Procediamo creando lo strato di backend dell'applicazione. Questo container sa collegarsi al DB ed espone i propri servizi tramite REST API.

## 🐳 Build dell'immagine Docker

### 1. Build dell'immagine del backend

```bash
docker build .\backend\ -t postesviluppo.azurecr.io/cangem/workshop-backend
```

**Nota importante:** L'immagine deve essere pushata su un registry accessibile da OpenShift.

### 2. Push dell'immagine (se necessario)

```bash
# Login al registry (se richiesto)
docker login postesviluppo.azurecr.io

# Push dell'immagine
docker push postesviluppo.azurecr.io/cangem/workshop-backend
```

---

## 🚀 Deploy del Backend

### 3. Creare il deployment del backend

```bash
oc create -f ./openshift/backend-deployment.yaml
```

**Oggetti creati:**
- **Deployment**: Gestisce i pod del backend
- **ConfigMap**: Contiene configurazioni dell'applicazione (URL database, parametri, ecc.)

### 4. Verificare gli oggetti creati

```bash
# Visualizzare tutti gli oggetti
oc get all

# Focus su deployment e configmap
oc get deployment,configmap

# Dettagli del deployment
oc describe deployment workshop-backend
```

---

## 🌐 Configurazione di rete

### 5. Creare gli oggetti di rete

```bash
oc create -f ./openshift/backend-network.yaml
```

**Oggetti creati:**
- **Service**: Endpoint interno per comunicazione inter-pod
- **Route**: Endpoint esterno per accesso dall'esterno del cluster

### 6. Verificare gli oggetti di rete

```bash
# Visualizzare servizi e route
oc get service,route

# Dettagli della route
oc describe route workshop-backend
```

---

## 🧪 Testing delle API

### 7. Visualizzare la documentazione Swagger

Le API FastAPI generano automaticamente una documentazione interattiva:

1. Aprire il browser sull'URL: `https://workshop-backend-<namespace>.apps.ocp4azexp2.cloudsvil.poste.it/docs`
2. Esplorare le API disponibili
3. Testare alcune chiamate direttamente dal browser

### 8. Test tramite cURL

```bash
# Ottenere lista degli ordini
curl.exe 'https://workshop-backend-<tuo-namespace>.apps.ocp4azexp2.cloudsvil.poste.it/api/v1/orders/'

# Creare un nuovo ordine (esempio)
curl.exe -X POST 'https://workshop-backend-<tuo-namespace>.apps.ocp4azexp2.cloudsvil.poste.it/api/v1/orders/' \
  -H 'Content-Type: application/json' \
  -d '{"customer_name":"Test Customer","product":"Test Product","quantity":1}'
```

> **Importante su Windows:** Usare `curl.exe` non semplicemente `curl`

---

## 📈 Scaling e Load Balancing

### 9. Testare lo scaling del backend

```bash
# Scalare a 3 repliche
oc scale deployment workshop-backend --replicas=3

# Verificare che i pod siano stati creati
oc get pods -l app=workshop-backend

# Verificare distribuzione del carico
for i in {1..10}; do
  curl.exe -s 'https://workshop-backend-<namespace>.apps.ocp4azexp2.cloudsvil.poste.it/api/v1/health' | grep hostname
done
```

**Cosa osservare:**
- I pod vengono distribuiti su nodi diversi (se disponibili)
- Le richieste vengono bilanciate tra le repliche
- Il Service fa da load balancer interno

---

## 🔍 Monitoraggio e debugging

### Log dell'applicazione

```bash
# Log di tutti i pod del backend
oc logs -l app=workshop-backend

# Log di un pod specifico
oc logs <nome-pod-backend>

# Seguire i log in tempo reale
oc logs -f <nome-pod-backend>
```

### Connessione al container

```bash
# Shell nel container
oc exec -it <nome-pod-backend> -- /bin/bash

# Verificare connettività al database
oc exec -it <nome-pod-backend> -- curl http://mariadb:3306
```

### Health checks

```bash
# Verificare endpoint di health
curl.exe 'https://workshop-backend-<namespace>.apps.ocp4azexp2.cloudsvil.poste.it/health'

# Metrics endpoint (se abilitato)
curl.exe 'https://workshop-backend-<namespace>.apps.ocp4azexp2.cloudsvil.poste.it/metrics'
```

---

## 🛠️ Troubleshooting comune

### Pod rimane in CrashLoopBackOff

**Possibili cause:**
- Errore di connessione al database
- Configurazione errata nelle variabili d'ambiente
- Immagine non trovata o corrotta

**Debug:**
```bash
oc describe pod <nome-pod-backend>
oc logs <nome-pod-backend>
```

### Route non raggiungibile

**Possibili cause:**
- DNS non risolto
- Certificati SSL
- Firewall o policy di rete

**Debug:**
```bash
oc describe route workshop-backend
nslookup workshop-backend-<namespace>.apps.ocp4azexp2.cloudsvil.poste.it
```

---

## ✅ Checkpoint

Prima di procedere al passo successivo, verifica che:

- [ ] Il deployment del backend sia in stato `Available`
- [ ] Ci siano 3 repliche in esecuzione
- [ ] La Route sia raggiungibile dall'esterno
- [ ] Le API REST rispondano correttamente
- [ ] La documentazione Swagger sia accessibile

**Comandi di verifica rapida:**
```bash
oc get deployment workshop-backend
oc get pods -l app=workshop-backend
oc get route workshop-backend
curl.exe 'https://workshop-backend-<namespace>.apps.ocp4azexp2.cloudsvil.poste.it/health'
```

---

## 🚀 Prossimo passo

**Continua con:** [Passo 7: Deployment del Frontend →](./passo-7-frontend.md)

## 🔙 Navigazione

- [← Passo 5: Deployment del Database](./passo-5-database.md)
- [← Indice Workshop](./README.md)
- [Passo 7: Deployment del Frontend →](./passo-7-frontend.md)