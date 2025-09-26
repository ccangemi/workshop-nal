# Passo 5: Deployment del Database

## 🎯 Obiettivi di questo passo

- Deployare un database MariaDB persistente
- Comprendere la differenza tra StatefulSet e Deployment
- Configurare storage persistente
- Inizializzare il database con dati di esempio

---

Iniziamo creando il database nel quale verranno registrati permanentemente gli ordini.

## 🚀 Deploy del Database

### 1. Creazione delle risorse database

```bash
oc create -f ./openshift/local-db.yaml
```

### 2. Monitoraggio del processo di startup

Osserva l'inizializzazione del database:

```bash
# Monitoraggio in tempo reale (Ctrl+C per interrompere)
oc get pod -w
```

**Cosa osservare:**
- Status del pod: `Pending` → `ContainerCreating` → `Running`
- Eventuale download dell'immagine container

**Alternativa - Web GUI:**
- Navigare a: Workloads → Pods
- Monitorare lo status del pod MariaDB

### 3. Verifica degli oggetti creati

```bash
# Verificare il servizio di rete
oc get service

# Verificare il claim per lo storage persistente  
oc get pvc

# Verificare il StatefulSet
oc get statefulset
```

---

## 📚 Concetti teorici

### StatefulSet vs Deployment - Quando usare cosa?

| Aspetto | **StatefulSet** | **Deployment** |
|---------|----------------|----------------|
| **Identità Pod** | Stabile e ordinata | Intercambiabile |
| **Storage** | Persistente per Pod | Condiviso o effimero |
| **Startup** | Sequenziale | Parallelo |
| **DNS** | Predicibile | Load-balanced |
| **Uso tipico** | Database, storage | App stateless, API |

### Perché StatefulSet per il Database?

- **Identità stabile**: Il database ha sempre lo stesso nome di host
- **Storage persistente**: I dati sopravvivono al restart del pod
- **Startup ordinato**: Garantisce inizializzazione corretta
- **Network identity**: DNS predicibile per connessioni

---

## 🔧 Inizializzazione del Database

### 4. Eseguire lo script di inizializzazione

```bash
./openshift/init-db.bat
```

**Cosa fa questo script:**
- Si connette al database MariaDB
- Crea le tabelle necessarie
- Inserisce dati di esempio
- Configura permessi e utenti

### 5. Verifica dell'inizializzazione

Controlliamo che il database sia stato inizializzato correttamente:

```bash
# Connettersi al pod del database
oc exec -it <nome-pod-mariadb> -- mysql -u root -p

# All'interno del database MySQL:
SHOW DATABASES;
USE orders_db;
SHOW TABLES;
SELECT * FROM orders LIMIT 5;
EXIT;
```

---

## 🔍 Esplorazione delle risorse create

### Storage Persistente

```bash
# Dettagli del PersistentVolumeClaim
oc describe pvc mariadb-data

# Visualizzare i volumi disponibili
oc get pv
```

### Servizi di rete

```bash
# Dettagli del servizio MariaDB
oc describe service mariadb

# Testare la connettività interna
oc run mysql-client --image=mysql:5.7 -it --rm --restart=Never -- mysql -h mariadb -u root -p
```

### Logs del database

```bash
# Visualizzare i log del database
oc logs <nome-pod-mariadb>

# Seguire i log in tempo reale
oc logs -f <nome-pod-mariadb>
```

---

## 🛠️ Troubleshooting comune

### Pod rimane in stato Pending

**Possibili cause:**
- Risorse insufficienti nel cluster
- PVC non può essere creato

**Debug:**
```bash
oc describe pod <nome-pod-mariadb>
oc get events --sort-by='.lastTimestamp'
```

### Database non si inizializza

**Possibili cause:**
- Script di init fallito
- Permessi incorretti

**Debug:**
```bash
oc logs <nome-pod-mariadb>
oc exec -it <nome-pod-mariadb> -- bash
```

---

## ✅ Checkpoint

Prima di procedere al passo successivo, verifica che:

- [ ] Il pod MariaDB sia in stato `Running`
- [ ] Il PVC sia `Bound`
- [ ] Il database sia inizializzato con le tabelle
- [ ] Puoi connetterti al database da un pod di test

**Comandi di verifica rapida:**
```bash
oc get pods | grep mariadb
oc get pvc | grep mariadb  
oc get svc | grep mariadb
```

---

## 🚀 Prossimo passo

**Continua con:** [Passo 6: Deployment dell'API Backend →](./passo-6-backend.md)

## 🔙 Navigazione

- [← Passo 4: L'applicazione del workshop](./passo-4-applicazione.md)
- [← Indice Workshop](./README.md)
- [Passo 6: Deployment dell'API Backend →](./passo-6-backend.md)