---
title: Rapport BDD
author: Armand SADY, Raphaël KIECKEN
---

![](Logo.png)

# Introduction 

Voici notre rapport concernant la partie base de donnée de la SAE 2.04.


# Exploitation des données

## Compréhension

### Combien y-a-t-til de lignes dans chaque fichier ?

``` bash
wc -l file
```

**athlete_events.csv** : 271 117 lignes.  
**noc_regions** : 230 lignes.  

### Afficher uniquement la première ligne du fichier athlète

``` bash
head -1 athlete_events.csv
```

"ID","Name","Sex","Age","Height","Weight","Team","NOC","Games","Year","Season","City","Sport","Event","Medal"

### Quel est le séparateur de champs ?

Le séparateur de champs est la virgule.

### Que représente une ligne ?

Une ligne représente une participation d'un athlète à une compétition.

### Combien y-a-t-il de colonnes ?

``` bash
head -1 athlete_events.csv |tr " " _ |tr , " " |wc -w
```

Il y a 15 colonnes.

### Quelle colonne distingue les jeux d'été et d'hivers ? 

La colonne **Season**.

### Combien de lignes font référence à Jean-Claude Killy ?

``` bash
cat athlete_events.csv |grep "Jean-Claude Killy" |wc -l
```

Il y a 6 lignes qui font références à Jean-Claude Killy.

### Quel encodage est utilisé pour ce fichier ?

``` bash
file -b -i  athlete_events.csv
```

Ce fichier est encodé en **us-ascii**.

### Comment envisagez-vous l'import de ces données ?

- Convertir de fichier en utf-8  
``` bash
iconv -f us-ascii  -t utf-8 athlete_events.csv > athlete_events_utf8.csv
```

- Importer les données  

**athlete_events_utf8.csv**  
``` SQL
\copy import from 'athlete_events_utf8.csv' with (FORMAT csv, NULL 'NA', HEADER, ENCODING 'UTF-8')
```

**noc_regions_utf8.csv**
``` SQL
\copy noc from 'Ressource/noc_regions_utf8.csv' with (FORMAT csv, NULL '', HEADER, ENCODING 'UTF-8')
```


Stocké dans une table temporaire import ayant les colonnes suivantes :  
``` SQL
id INT, nom TEXT, genre TEXT, age INT, taille INT, poids INT,
-> VARCHAR(108) : SELECT MAX(LENGTH(nom)) FROM import;
genre = TEXT -> VARCHAR(1) : SELECT MAX(LENGTH(genre)) FROM import;
age = INT
taille = INT
poids = FLOAT
equipe = TEXT -> VARCHAR(47) : SELECT MAX(LENGTH(equipe)) FROM import;
noc = TEXT -> VARCHAR(3) : SELECT MAX(LENGTH(noc)) FROM import;
label = TEXT -> VARCHAR(11) : SELECT MAX(LENGTH(label)) FROM import;
annee = INT
saison = TEXT -> VARCHAR(6) : SELECT MAX(LENGTH(saison)) FROM import; 
ville = TEXT -> VARCHAR(22) : SELECT MAX(LENGTH(ville)) FROM import;
sport = TEXT -> VARCHAR(25) : SELECT MAX(LENGTH(sport)) FROM import;
elabel = TEXT -> VARCHAR(85) : SELECT MAX(LENGTH(elabel)) FROM import;
medaille = TEXT -> VARCHAR(6) : SELECT MAX(LENGTH(medaille)) FROM import;

**noc_regions_utf8.csv**
Stocké dans une table temporaire noc ayant les colonnes suivantes :  
noc = TEXT -> VARCHAR(3) : SELECT MAX(LENGTH(noc)) FROM import;
regions = TEXT -> VARCHAR(32) : SELECT MAX(LENGTH(regions)) FROM import;
notes = TEXT
``` 

## Importer les données

Voici le code SQL qui permet d'importer les données des .csv directement dans les tables temporaire, il est trouvable dans le script "importation.sql". Ce script est idempotent, il produit toujours le même résultat.  

``` SQL
DROP TABLE IF EXISTS import CASCADE;
DROP TABLE IF EXISTS noc;
DROP TABLE IF EXISTS athlete CASCADE;
DROP TABLE IF EXISTS regions CASCADE;
DROP TABLE IF EXISTS olympics CASCADE;
DROP TABLE IF EXISTS epreuves CASCADE;
DROP TABLE IF EXISTS participe;
DROP TABLE IF EXISTS resultat;

CREATE temp TABLE import (
    id INT, nom TEXT, genre TEXT, age INT, taille INT, poids FLOAT,
    equipe TEXT, noc TEXT, label TEXT, annee INT, saison TEXT, 
    ville TEXT, sport TEXT, elabel TEXT, medaille TEXT);
    
\copy import from 'Ressource/athlete_events_utf8.csv' with (FORMAT csv, NULL 'NA', HEADER, ENCODING 'UTF-8')

DELETE FROM import WHERE n10 < 1920 OR n13 = 'Art Competitions';

CREATE temp TABLE noc (
    noc TEXT, regions TEXT, notes TEXT);

\copy noc from 'Ressource/noc_regions_utf8.csv' with (FORMAT csv, NULL '', HEADER, ENCODING 'UTF-8')
```

## Exercice 4
### Modèles Conceptuel de Donnée

![Olympics MCD](Image/MCD.png)

Nous avons 

### Modèles Logiques de Donnée
De la même manière, voici un extrait d'Olympics.mld : 
![Olympics MLD](Image/MLD.png)
# Exercice 5
