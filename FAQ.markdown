## FAQ: Risposte alle domande frequenti

**Nota**: Dal momento che Symphony 2.0.7 è in fase stabile, il 90% di queste FAQ non è più necessario. Molte delle informazioni contenute in questa pagina non sono più vere pertanto usatele con cautela!

### 1. La traduzione non funziona, l'interfaccia è ancora in inglese. Perché?

Innanzi tutto, quali parti dell'interfaccia sono ancora in inglese?

**1° caso**: Se si tratta del menù di navigazione (per intenderci: "*Content*", "*Blueprints*", "*System*"), probabilmente sei incappato in un [problema di compatibilità](http://symphony-cms.com/discuss/thread/29602/4/#position-67) con l'estensione "[Localisation Manager](http://symphony-cms.com/download/extensions/view/29645/)".

Prima di procedere, controlla di star utilizzando la versione del Localisation Manager più adatta alla tua copia di Symphony.

* se usi Symphony v2.0.6 o minore: Localisation Manager v[1.0.2](http://github.com/nilshoerrmann/localisationmanager/tree/1.0.2)
* se usi Symphony v2.0.7: [1.1](http://github.com/nilshoerrmann/localisationmanager)

Se stai usando una versione del *Localisation Manager* che ***non*** corrisponde a quella suggerita per la tua versione di Symphony, assicurati di:

 - Disattivare il *Localisation Manager* selezionandolo dalla lista delle estensioni (`Preferences` -> `Extensions`) e cliccando su "*Uninstall*".
 - Sovrascrivere il *Localisation Manager* con la versione prevista per la tua copia di Symphony (i file si trovano all'interno della cartella `/extensions/localisationmanager`).
 - Attivare nuovamente il *Localisation Manager* selezionandolo dalla lista delle estensioni (inizialmente in grigio) e cliccando su "*Enable*".

**2° caso**: Se il menù è interamente tradotto a esclusione di "*Content*", allora non c'è da allarmarsi: la traduzione non copre, per motivi dovuti all'architettura interna del sistema, l'intero contenuto dell'interfaccia. Infatti:

 - Gran parte del contenuto rimasto in Inglese è sensibile alle modifiche dell'utente e può essere pertanto modificato normalmente attraverso l'interfaccia di amministrazione (es. il nome delle *sezioni*, degli *eventi*, delle *sorgenti dati* e dei *servizi*)
 - Alcune stringhe in determinate aree dell'interfaccia non sono state ancora [esposte ai meccanismi di traduzione](http://symphony-cms.com/discuss/issues/view/178/), rendendo impossibile la loro sostituzione. Tuttavia, il pacchetto italiano fornisce già un equivalente italiano per queste stringhe, in attesa dei futuri rilasci di Symphony che provvederanno a sistemare questo problema.

**Nota**: Per sistemare la *descrizione* degli eventi (che generalmente rimane in Inglese), un buon metodo è quello di salvarli nuovamente tutti quanti, uno per uno. In questo modo il sistema provvederà a sostituire tutti i testi con il loro equivalente Italiano.

### 2. Ho installato il file XSLT per avere le date in Italiano, ma i giorni mi vengono mostrati in forma ordinale. Perché?

Se usi una copia fresca di Symphony (ovvero non hai ancora applicato modifiche sostanziali al sistema dopo l'installazione), probabilmente il formato delle date è rimasto quello più consono per la lingua inglese, che per l'appunto specifica i giorni in forma ordinale. Se hai familiarità con XSLT, puoi andare a sostituire manualmente tutte le chiamate alla funzione `date-time-it` assicurandoti che il parametro `format` contenga una "`d`" (numero cardinale) al posto della "`D`" (numero ordinale).
