# Passo 9: Collegare il database esterno

## 🎯 Obiettivi di questo passo

- Switchare il backend dal database locale a quello centralizzato
- Comprendere la gestione delle configurazioni in OpenShift
- Testare la migrazione dei dati
- Sperimentare con notifiche email

---

In questo passo finale migreremo l'applicazione dal database MariaDB locale ad un database MSSQL centralizzato già deployato nell'infrastruttura.

## 🔄 Panoramica della migrazione

### Architettura attuale vs target

**PRIMA (Architettura attuale):**
```mermaid
graph LR
    Frontend --> Backend
    Backend --> MariaDB_Local[MariaDB<br/>Local Container]
```

**DOPO (Architettura target):**
```mermaid
graph LR
  Frontend --> Backend
  Backend --> MSSQL_Central[MSSQL<br/>Central Database]
  MSSQL_Central --> EmailService[Email Service<br/>Notification]
```

### Vantaggi del database centralizzato

- **Scalabilità**: Gestito da team DBA specializzati
- **Backup/Recovery**: Strategie enterprise-grade
- **Sicurezza**: Controlli di accesso centralizzati
- **Performance**: Hardware dedicato e ottimizzato
- **Compliance**: Audit trail e governance

---

## 🔧 Configurazione del nuovo database

### 1. Aggiornamento ConfigMap backend

```bash
# Edit della ConfigMap per puntare al nuovo database MSSQL centralizzato
oc edit configmap/workshop-backend-config

# sostituire
# database-connection-string: 'mssql+pymssql://defaultMssqladmin:Y%6fcn0_C8L_ekmg@saiworkshopsql01azwe.database.windows.net:1433/db01'
```

---

## 🔄 Processo di migrazione

### 2. Restart del backend per applicare le nuove configurazioni

```bash
# Trigger restart per caricare nuova configurazione
oc rollout restart deployment workshop-backend

# Monitorare il rollout
oc rollout status deployment workshop-backend

```

---

## 🧪 Test della nuova configurazione

### 3. Test completo dell'applicazione migrata

1. **Accedere all'applicazione web**
2. **Creare un nuovo ordine** - dovrebbe:
   - Essere salvato nel database MSSQL centrale
   - Triggerare notifica email (se configurata)
3. **Verificare persistenza** - ricaricare la pagina e controllare che l'ordine sia ancora visibile
4. **Test performance** - l'app dovrebbe rispondere normalmente

---

## ✅ Checkpoint finale

Al termine di questo passo, verifica che:

- [ ] Il backend si connette al database MSSQL centralizzato
- [ ] Gli ordini vengono salvati nel nuovo database
- [ ] L'applicazione web funziona normalmente

**Test finale completo:**
1. Creare un ordine tramite web app
2. Verificare che appaia nella lista
4. Verificare eventuale email di notifica
5. Ricaricare la pagina - ordine deve essere persistente

---

## 🎊 Congratulazioni!

Hai completato con successo il workshop di deployment su OpenShift! 

Ora hai esperienza pratica con:
- ✅ Deployment di applicazioni 3-tier
- ✅ Gestione di database e storage persistente
- ✅ Configurazione di servizi e routing
- ✅ Osservabilità e monitoring
- ✅ Gestione di configurazioni e secrets

## 🔙 Navigazione

- [← Passo 8: Osservabilità](./passo-8-osservabilita.md)
- [← Indice Workshop](./README.md)
