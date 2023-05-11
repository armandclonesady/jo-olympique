\! echo Q1

\! rm Ressource/Stats/Q1.csv
\copy (SELECT nom, genre, COUNT(*) AS nb_participation FROM athlete JOIN participe USING (id) GROUP BY nom, genre ORDER BY nb_participation DESC LIMIT 20) to Ressource/Stats/Q1.csv with csv;

\! echo Q2-a

\! rm Ressource/Stats/Q2-a.csv
\copy (SELECT regions, ROUND(AVG(age)) AS moyenne_age, COUNT(DISTINCT id) AS nb_sportif, MIN(age) AS min_age, MAX(age) AS max_age FROM regions JOIN participe USING(noc) WHERE annee = 1992 AND saison = 'Winter' GROUP BY regions) to Ressource/Stats/Q2-a.csv with csv;

\! echo Q2-b

\! rm Ressource/Stats/Q2-b1.csv
\copy (SELECT ROUND(AVG(age)) AS moyenne_age FROM participe WHERE annee = 1992 AND saison = 'Winter') to Ressource/Stats/Q2-b1.csv with csv;

\! rm Ressource/Stats/Q2-b2.csv
\copy (SELECT ROUND(AVG(age)) AS moyenne_age_medaille FROM participe AS p JOIN regions USING(noc) JOIN resultat USING(id) WHERE p.annee = 1992 AND p.saison = 'Winter' AND medaille IS NOT NULL) to Ressource/Stats/Q2-b2.csv with csv;

\! echo Q2-c
\! echo Poids des femmes

\! rm Ressource/Stats/Q2-cf1.csv
\copy (SELECT ROUND(AVG(poids)) AS moyenne_poids_femme FROM athlete WHERE genre = 'F') to Ressource/Stats/Q2-cf1.csv with csv;

\! rm Ressource/Stats/Q2-cf2.csv
\copy (SELECT ROUND(AVG(poids)) AS moyenne_poids_femme_medaille FROM athlete JOIN resultat USING (id) WHERE genre = 'F' AND medaille IS NOT NULL) to Ressource/Stats/Q2-cf2.csv with csv;

\! echo Poids des hommes

\! rm Ressource/Stats/Q2-ch1.csv
\copy (SELECT ROUND(AVG(poids)) AS moyenne_poids_homme FROM athlete WHERE genre = 'M') to Ressource/Stats/Q2-ch1.csv with csv;

\! rm Ressource/Stats/Q2-ch2.csv
\copy (SELECT ROUND(AVG(poids)) AS moyenne_poids_homme FROM athlete JOIN resultat USING (id) WHERE genre = 'M' AND medaille IS NOT NULL) to Ressource/Stats/Q2-ch2.csv with csv;

\! echo Q3-a

\! rm Ressource/Stats/Q3-a.csv
\copy (SELECT regions, COUNT(medaille) AS nbr_medaille FROM resultat JOIN participe AS p USING (id) JOIN regions USING (noc) WHERE p.annee BETWEEN 1992 AND 2016 AND medaille IS NOT NULL GROUP BY regions ORDER BY COUNT(medaille) DESC LIMIT 15) to Ressource/Stats/Q3-a.csv with csv;

\! echo Q3-b1

\! rm Ressource/Stats/Q3-b1.csv
\copy (SELECT regions, p.annee, p.saison, COUNT(DISTINCT id) AS nbr_participant FROM participe AS p JOIN regions USING (noc) WHERE p.annee BETWEEN 1992 AND 2016 AND regions IN ('China', 'South Korea', 'Australia', 'USA', 'France') GROUP BY regions, p.annee, p.saison ORDER BY regions, p.saison, p.annee) to Ressource/Stats/Q3-b1.csv with csv;

\! echo Q3-b2

\! rm Ressource/Stats/Q3-b2.csv
\copy (SELECT regions, p.annee, p.saison, COUNT(DISTINCT id) AS nbr_medaille FROM participe AS p JOIN regions USING (noc) JOIN resultat USING (id) WHERE p.annee BETWEEN 1992 AND 2016 AND regions IN ('China', 'South Korea', 'Australia', 'USA', 'France') AND medaille IS NOT NULL GROUP BY regions, p.annee, p.saison ORDER BY regions, p.saison, p.annee) to Ressource/Stats/Q3-b2.csv with csv;

\! echo Q3-b3

\! rm Ressource/Stats/Q3-b3.csv
\copy (SELECT regions, p.annee, p.saison, COUNT(DISTINCT id) AS nbr_femme FROM athlete JOIN participe AS p USING (id) JOIN regions USING (noc) WHERE p.annee BETWEEN 1992 AND 2016 AND regions IN ('China', 'South Korea', 'Australia', 'USA', 'France') AND genre = 'F' GROUP BY regions, p.annee, p.saison ORDER BY regions, p.saison, p.annee) to Ressource/Stats/Q3-b3.csv with csv;

\! echo Q3-b4

\! rm Ressource/Stats/Q3-b4.csv
\copy (SELECT regions, p.annee, p.saison, COUNT(DISTINCT id) AS nbr_homme FROM athlete JOIN participe AS p USING (id) JOIN regions USING (noc) WHERE p.annee BETWEEN 1992 AND 2016 AND regions IN ('China', 'South Korea', 'Australia', 'USA', 'France') AND genre = 'M' GROUP BY regions, p.annee, p.saison ORDER BY regions, p.saison, p.annee) to Ressource/Stats/Q3-b4.csv with csv;

\! echo Q3-b5

\! rm Ressource/Stats/Q3-b5.csv
\copy (SELECT regions, p.annee, p.saison, COUNT(DISTINCT id) AS nbr_femme_medaille FROM athlete JOIN resultat USING(id) JOIN participe AS p USING (id) JOIN regions USING (noc) WHERE p.annee BETWEEN 1992 AND 2016 AND regions IN ('China', 'South Korea', 'Australia', 'USA', 'France') AND genre = 'F' AND medaille IS NOT NULL GROUP BY regions, p.annee, p.saison ORDER BY regions, p.saison, p.annee) to Ressource/Stats/Q3-b5.csv with csv;