\! echo Q1
/*SELECT nom, genre, COUNT(*) AS nb_participation FROM athlete JOIN participe USING (id)
GROUP BY nom, genre
ORDER BY nb_participation DESC
LIMIT 20;*/

\! rm Ressource/Stats/Q1.csv
\copy (SELECT nom, genre, COUNT(*) AS nb_participation FROM athlete JOIN participe USING (id) GROUP BY nom, genre ORDER BY nb_participation DESC LIMIT 20) to Ressource/Stats/Q1.csv with csv

\! echo Q2-a
/*SELECT regions, ROUND(AVG(age)) AS moyenne_age, COUNT(DISTINCT id) AS nb_sportif, MIN(age) AS min_age, MAX(age) AS max_age
FROM regions JOIN participe USING(noc)
WHERE annee = 1992 AND saison = 'Summer'
GROUP BY regions;*/

\! rm Ressource/Stats/Q2-a.csv
\copy (SELECT regions, ROUND(AVG(age)) AS moyenne_age, COUNT(DISTINCT id) AS nb_sportif, MIN(age) AS min_age, MAX(age) AS max_age FROM regions JOIN participe USING(noc) WHERE annee = 1992 AND saison = 'Summer' GROUP BY regions) to Ressource/Stats/Q2-a.csv with csv


\! echo Q2-b
/*SELECT ROUND(AVG(age)) AS moyenne_age FROM participe 
WHERE annee = 1992 AND saison = 'Summer'
GROUP BY regions;*/

\! rm Ressource/Stats/Q2-b1.csv
\copy (SELECT ROUND(AVG(age)) AS moyenne_age FROM participe WHERE annee = 1992 AND saison = 'Summer') to Ressource/Stats/Q2-b1.csv with csv

/*SELECT ROUND(AVG(age)) AS moyenne_age_medaille
FROM participe JOIN regions USING(noc) JOIN resultat USING(id)
WHERE annee = 1992 AND saison = 'Summer' AND medaille IS NOT NULL;*/

\! rm Ressource/Stats/Q2-b2.csv
\copy (SELECT ROUND(AVG(age)) AS moyenne_age_medaille FROM participe JOIN regions USING(noc) JOIN resultat USING(id) WHERE participe.annee = 1992 AND participe.saison = 'Summer' AND medaille IS NOT NULL) to Ressource/Stats/Q2-b2.csv with csv

\! echo Q2-c
\! echo Poids des femmes
/*SELECT ROUND(AVG(poids)) AS moyenne_poids_femme
FROM athlete
WHERE genre = 'F';*/

\! rm Ressource/Stats/Q2-c1.csv
\copy (SELECT ROUND(AVG(poids)) AS moyenne_poids_femme FROM athlete WHERE genre = 'F') to Ressource/Stats/Q2-c1.csv with csv

/*SELECT ROUND(AVG(poids)) AS moyenne_poids_femme_medaille
FROM athlete JOIN resultat USING (id)
WHERE genre = 'F' AND medaille IS NOT NULL;*/

\! rm Ressource/Stats/Q2-c2.csv
\copy (SELECT ROUND(AVG(poids)) AS moyenne_poids_femme_medaille FROM athlete JOIN resultat USING (id) WHERE genre = 'F' AND medaille IS NOT NULL) to Ressource/Stats/Q2-c2.csv with csv

\! echo Poids des hommes
/*SELECT ROUND(AVG(poids)) AS moyenne_poids_homme
FROM athlete
WHERE genre = 'M';*/

\! rm Ressource/Stats/Q2-c3.csv
\copy (SELECT ROUND(AVG(poids)) AS moyenne_poids_homme FROM athlete WHERE genre = 'M') to Ressource/Stats/Q2-c3.csv with csv

/*SELECT ROUND(AVG(poids)) AS moyenne_poids_homme_medaille
FROM athlete JOIN resultat USING (id)
WHERE genre = 'M' AND medaille IS NOT NULL;*/

\! rm Ressource/Stats/Q2-c4.csv
\copy (SELECT ROUND(AVG(poids)) AS moyenne_poids_homme FROM athlete JOIN resultat USING (id) WHERE genre = 'M' AND medaille IS NOT NULL) to Ressource/Stats/Q2-c4.csv with csv

\! echo Q3-a
/*SELECT regions, COUNT(medaille) AS nbr_medaille
FROM resultat JOIN participe USING (id) JOIN regions USING (noc)
WHERE annee BETWEEN 1992 AND 2016 AND medaille IS NOT NULL
GROUP BY regions
ORDER BY COUNT(medaille) DESC
LIMIT 15;*/

\! rm Ressource/Stats/Q3-a.csv
\copy (SELECT regions, COUNT(medaille) AS nbr_medaille FROM resultat JOIN participe USING (id) JOIN regions USING (noc) WHERE participe.annee BETWEEN 1992 AND 2016 GROUP BY regions ORDER BY COUNT(medaille) DESC LIMIT 15) to Ressource/Stats/Q3-a.csv with csv

\! echo Q3-b-12
/*SELECT regions AS pays, COUNT(id) AS nbr_participant, COUNT(medaille) AS nbr_medaille
FROM FROM resultat JOIN participe USING (id) JOIN regions USING (noc)
WHERE annee BETWEEN 1992 AND 2016
AND (regions = 'China'
OR regions = 'South Korea' 
OR regions = 'Australia' 
OR regions = 'USA' 
OR regions = 'France')
GROUP BY regions
ORDER BY COUNT(medaille) DESC;*/

\! rm Ressource/Stats/Q3-b12.csv
\copy (SELECT regions AS pays, COUNT(id) AS nbr_participant, COUNT(medaille) AS nbr_medaille FROM resultat JOIN participe USING (id) JOIN regions USING (noc) WHERE participe.annee BETWEEN 1992 AND 2016 AND (regions = 'China' OR regions = 'South Korea' OR regions = 'Australia' OR regions = 'USA' OR regions = 'France') GROUP BY regions ORDER BY COUNT(medaille) DESC) to Ressource/Stats/Q3-b12.csv with csv

\! echo Q3-b-3-5
/*SELECT noc.n2 AS pays,COUNT(*) AS nbr_femme,COUNT(n15)*1.0/COUNT(*)*1.0 AS proportion_medaille_femme
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