---
title: Analyse des fichiers
---

## Combien y-a-t-til de lignes dans chaque fichier ?

```
wc -l file
```

**athlete_events.csv** : 271 117 lignes.
**noc_regions** : 230 lignes.

## Afficher uniquement la première ligne du fichier athlète

```
head -1 athlete_events.csv
```

"ID","Name","Sex","Age","Height","Weight","Team","NOC","Games","Year","Season","City","Sport","Event","Medal"

## Quel est le séparateur de champs ?

Le séparateur de champs est la virgule.

## Que représente une ligne ?

Une ligne représente une participation d'un athlète à une compétition.

## Combien y-a-t-il de colonnes ?

```
head -1 athlete_events.csv |tr " " _ |tr , " " |wc -w
```

Il y a 15 colonnes.

## Quelle colonne distingue les jeux d'été et d'hivers ? 

La colonne **Season**.

## Combien de lignes font référence à Jean-Claude Killy ?

```
cat athlete_events.csv |grep "Jean-Claude Killy" |wc -l
```

Il y a 6 lignes qui font références à Jean-Claude Killy.

## Quel encodage est utilisé pour ce fichier ?

```
file -b -i  athlete_events.csv
```

Ce fichier est encodé en **us-ascii**.

## Comment envisagez-vous l'import de ces données ?

- Convertir de fichier en utf-8
```
iconv -f us-ascii  -t utf-8 athlete_events.csv > athlete_events_utf8.csv
```

- Importer les données
\copy import from 'athlete_events_utf8.csv' with (FORMAT csv, NULL 'NA', HEADER, ENCODING 'UTF-8')


### Colonne de la table import 

n1 = INT 
n2 = TEXT -> CHAR(108) : SELECT MAX(LENGTH(n2)) FROM import;
n3 = TEXT -> CHAR(1) : SELECT MAX(LENGTH(n3)) FROM import;
n4 = INT
n5 = INT
n6 = FLOAT
n7 = TEXT -> CHAR(47) : SELECT MAX(LENGTH(n7)) FROM import;
n8 = TEXT -> CHAR(3) : SELECT MAX(LENGTH(n8)) FROM import;
n9 = TEXT -> CHAR(11) : SELECT MAX(LENGTH(n9)) FROM import;
n10 = INT
n11 = TEXT -> CHAR(6) : SELECT MAX(LENGTH(n11)) FROM import; 
n12 = TEXT -> CHAR(22) : SELECT MAX(LENGTH(n12)) FROM import;
n13 = TEXT -> CHAR(25) : SELECT MAX(LENGTH(n13)) FROM import;
n14 = TEXT -> CHAR(85) : SELECT MAX(LENGTH(n14)) FROM import;
n15 = TEXT -> CHAR(6) : SELECT MAX(LENGTH(n15)) FROM import;



## 