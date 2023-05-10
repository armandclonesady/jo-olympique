\! echo Q1
SELECT id, nom, genre, COUNT(*) AS nb_participation FROM import
GROUP BY id, nom, genre
ORDER BY nb_participation DESC
LIMIT 20;

\! echo Q2-a
SELECT regions, ROUND(AVG(age)) AS moyenne_age, COUNT(DISTINCT id) AS nb_sportif, MIN(age) AS min_age, MAX(age) AS max_age
FROM import
JOIN noc USING(noc)
WHERE annee = 1992 AND saison = 'Summer'
GROUP BY regions;

/*\! echo création du CSV
\COPY (SELECT noc.n2,AVG(n4),COUNT(DISTINCT import.n1),MIN(n4),MAX(n4) FROM import JOIN noc ON n8 = noc.n1 WHERE n10 = 1956 GROUP BY noc.n2) TO 'Q2-a.csv'

\! echo Q2-b
SELECT n8 AS pays,AVG(n4) AS moyenne_age
FROM import
WHERE n10 = 1956
GROUP BY n8;

SELECT n8 AS pays,AVG(n4) AS moyenne_age_medaille
FROM import
WHERE n15 IS NOT NULL
AND n10 = 1956
GROUP BY n8;

\! echo Q2-c
\! echo les femmes
SELECT n8 AS pays,AVG(n6) AS moyenne_poid_femme
FROM import
WHERE n3 = 'F'
AND n10 = 1956
GROUP BY n8;

SELECT n8 AS pays,AVG(n6) AS moyenne_poid_femme_medaille
FROM import
WHERE n3 = 'F'
AND n10 = 1956
AND n15 IS NOT NULL
GROUP BY n8;

\! echo les hommes
SELECT n8 AS pays,AVG(n6) AS moyenne_poid_homme
FROM import
WHERE n3 = 'M'
AND n10 = 1956
GROUP BY n8;

SELECT n8 AS pays,AVG(n6) AS moyenne_poid_homme_medaille
FROM import
WHERE n3 = 'M'
AND n10 = 1956
AND n15 IS NOT NULL
GROUP BY n8;

\! echo Q3-a
SELECT noc.n2 AS pays,COUNT(n15) AS nbr_medaille
FROM import
JOIN noc ON n8 = noc.n1
WHERE n10 BETWEEN 1992 AND 2016
GROUP BY noc.n2
ORDER BY count(n15) DESC
LIMIT 15;

\! echo Q3-b-1-2
SELECT noc.n2 AS pays,COUNT(import.n1) AS nbr_participant,COUNT(n15) AS nbr_medaille
FROM import
JOIN noc ON n8 = noc.n1
WHERE n10 BETWEEN 1992 AND 2016
AND (noc.n2 = 'USA' 
OR noc.n2 = 'France' 
OR noc.n2 = 'UK' 
OR noc.n2 = 'Japan' 
OR noc.n2 = 'Spain' )
GROUP BY noc.n2
ORDER BY count(n15) DESC;

\! echo Q3-b-3-5
SELECT noc.n2 AS pays,COUNT(*) AS nbr_femme,COUNT(n15)*1.0/COUNT(*)*1.0 AS proportion_medaille_femme
FROM import
JOIN noc ON n8 = noc.n1
WHERE n10 BETWEEN 1992 AND 2016
AND import.n3 = 'F'
AND (noc.n2 = 'USA' 
OR noc.n2 = 'France' 
OR noc.n2 = 'UK' 
OR noc.n2 = 'Japan' 
OR noc.n2 = 'Spain' )
GROUP BY noc.n2
ORDER BY count(n15) DESC;

\! echo Q3-b-6
SELECT noc.n2 AS pays,COUNT(15) AS nbr_medaille_femme
FROM import
JOIN noc ON n8 = noc.n1
WHERE n10 BETWEEN 1992 AND 2016
AND import.n3 = 'F'
AND (noc.n2 = 'USA' 
OR noc.n2 = 'France' 
OR noc.n2 = 'UK' 
OR noc.n2 = 'Japan' 
OR noc.n2 = 'Spain' )
GROUP BY noc.n2
ORDER BY count(n15) DESC;*/