# Passo 5: Deployment del Database

## 🎯 Obiettivi di questo passo

- Deployare un database MariaDB persistente
- Comprendere la differenza tra StatefulSet e Deployment
- Configurare storage persistente
- Inizializzare il database con dati di esempio

---

Iniziamo creando il database nel quale verranno registrati permanentemente gli ordini.

## 🚀 Deploy del Database

> Analizzare il contenuto del file `./openshift/local-db.yaml`  
> Notare le sezioni riguardanti `env`, `liveness|readinessProbe`, `resources`, `volumeClaimTemplates`, il `Service` ed il `Secret`

### 1. Creazione delle risorse database

```bash
oc create -f ./openshift/local-db.yaml
```

### 2. Monitoraggio del processo di startup

Osserva l'inizializzazione del database:

```bash
# Monitoraggio in tempo reale
oc get pod -owide -w 

# Ctrl+C per interrompere)
```

**Alternativa - Web GUI:**
- Navigare a: Workloads → Pods
- Monitorare lo status del pod MariaDB

### 3. Verifica degli oggetti creati

> Analizzare gli oggetti creati, specialmente i concetti di PersistenceVolumeClaim e PersistenceVolume

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

- **Identità stabile**: Il database ha sempre lo stesso nome di host (eg: mariadb-0)
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
# Connettersi al pod del database (tramite comando lanciato direttamente da dentro pod mariadb)
# password: workshop123
oc exec -it mariadb-0 -- mariadb -u root -p

# All'interno del database MySQL:
SHOW DATABASES;
USE workshop_db;
SHOW TABLES;
SELECT * FROM ORDERS LIMIT 5;
EXIT;
```

---

## ✅ Checkpoint

Prima di procedere al passo successivo, verifica che:

- [ ] Il pod MariaDB sia in stato `Running`
- [ ] Il PVC sia `Bound`
- [ ] Il database sia inizializzato con le tabelle

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