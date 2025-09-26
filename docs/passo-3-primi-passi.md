# Passo 3: Primi passi

## 🎯 Obiettivi di questo passo

- Creare il primo Pod utilizzando CLI e Web GUI
- Comprendere la differenza tra Pod e Deployment
- Sperimentare con scaling e resilienza

---

In questa sezione proveremo a creare un pod di prova utilizzando sia la CLI che la Web GUI.

## Creazione e gestione di un Pod

### Setup iniziale

1. Accedere al proprio namespace se non lo si è già fatto: 
   ```bash
   oc project ws-<user>
   ```
2. Verificare che il namespace sia vuoto:
   ```bash
   oc get pod
   ```
   Il comando dovrebbe restituire: `No resources found in ws-<username> namespace.`

### Creazione del Pod

> Visualizzare il contenuto del file `./openshift/test-pod.yaml` da VSCode

3. Creare un pod di prova:
   ```bash
   oc create -f ./openshift/test-pod.yaml
   ```

4. **Analizzare il pod appena creato:**
   ```bash
   # Visualizzare i pod nel namespace
   oc get pods
   
   # Ottenere dettagli completi del pod in formato YAML
   oc get pod example -o yaml
   ```

> Analizzeremo la struttura del pod nel prossimo passo, tramite interfaccia Web

### Analisi tramite Web GUI
5. Tornare alla GUI di OpenShift (selezionare il tab della console web di OpenShift in caso non sia già quello attivo)

6. **Analizzare il pod nell'interfaccia web:** 
   - Navigare a: Workloads → Pods → `example`
   - **Esplorare i vari tab:**
     - **Details**: Informazioni generali e configurazione
     - **Metrics**: Metriche di CPU, memoria, rete
     - **Logs**: Log output del container
     - **Terminal**: Accesso shell al container
   - **Esplorare il menu Actions**: Delete, Edit, ecc.

7. Eliminare il pod:
   ```bash
   oc delete pod example
   ```

---

## Creazione e gestione di un Deployment

### Perché usare un Deployment invece di un Pod singolo?

Un **Deployment** offre vantaggi significativi rispetto a un Pod standalone:

- **Scaling:** Può facilmente aumentare/diminuire il numero di repliche
- **Self-healing:** Riavvia automaticamente i pod che falliscono
- **Rolling updates:** Può aggiornare l'applicazione senza tempi di inattività
- **Declarative management:** Kubernetes garantisce che lo stato desiderato venga mantenuto

### Creazione del Deployment

> Analizzare la struttura del file `./openshift/test-deployment.yaml`:
> - `replicas`
> - `selector`
> - `template`

1. Creare un deployment di prova:
   ```bash
   oc create -f ./openshift/test-deployment.yaml
   ```

2. Osservare la creazione automatica dei pod:
   ```bash
   # Visualizzare il deployment creato
   oc get deployment example-deployment
   
   # Visualizzare solo i pod con label specifico
   oc get pods -l app=httpd
   ```

> Analizzare la struttura di un deployment dalla Web GUI: Workloads -> Deployments -> example-deployment

### Esperimenti di resilienza e scaling

3. **Test di Self-healing:** Eliminare un pod e osservare la ricreazione automatica:
   ```bash
   # Segnarsi il nome di un pod
   oc get pods -l app=httpd
   
   # Eliminare il pod
   oc delete pod <nome_pod>
   
   # Osservare che viene ricreato automaticamente
   oc get pods -l app=httpd
   ```

4. **Test di Scaling:** Aumentare il numero di repliche:
   ```bash
   oc scale deployment example-deployment --replicas=4
   
   # Verificare che siano stati creati 4 pod
   oc get pods -l app=httpd
   ```

5. **Test di Rollout:** Effettuare un aggiornamento del deployment a caldo:
   ```bash
   oc rollout restart deployment workshop-backend
   
   # Visualizzare lo stato dei pod/ReplicaSet anche nella Web GUI (Deployment)
   oc get pods -l app=httpd
   ```

> E' possibile eseguire le stesse operazione da Web console.



6. **Cleanup:** Eliminare il deployment (eliminerà anche tutti i pod):
   ```bash
   oc delete deployment example-deployment
   ```

---

## 💡 Concetti chiave appresi

- **Pod**: Unità base, ma fragile se gestita manualmente
- **Deployment**: Gestore intelligente che garantisce disponibilità e scalabilità
- **Labels e Selectors**: Meccanismo per raggruppare e selezionare risorse
- **Declarative vs Imperative**: Kubernetes mantiene lo stato desiderato

---

## ✅ Checkpoint

Prima di procedere al passo successivo, verifica che:

- [ ] Hai creato e analizzato un Pod tramite CLI e Web GUI
- [ ] Comprendi la differenza tra Pod e Deployment
- [ ] Hai sperimentato con scaling e self-healing
- [ ] Il tuo namespace è pulito (no risorse residue)

---

## 🚀 Prossimo passo

**Continua con:** [Passo 4: L'applicazione del workshop →](./passo-4-applicazione.md)

## 🔙 Navigazione

- [← Passo 2: Esplorazione dell'ambiente](./passo-2-esplorazione.md)
- [← Indice Workshop](./README.md)
- [Passo 4: L'applicazione del workshop →](./passo-4-applicazione.md)