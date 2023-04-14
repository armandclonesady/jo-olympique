/*-- EXERCICE 3
-- QUESTION 1
SELECT COUNT(*) AS nbcolumns
FROM information_schema.columns
WHERE table_name = 'import';

-- QUESTION 2
SELECT COUNT(*) AS nbrows
FROM import;

-- QUESTION 3
SELECT COUNT(noc)
FROM noc;

-- QUESTION 4
SELECT COUNT(DISTINCT nom) 
FROM import;

-- QUESTION 5
SELECT COUNT(medaille)
FROM import
WHERE medaille='Gold';

-- QUESTION 6
SELECT *
FROM import
WHERE nom LIKE 'Carl Lewis%';

-- EXERCICE 5
-- QUESTION 1
SELECT r.regions, COUNT(*) AS nbParticipation
FROM participe NATURAL JOIN resultat NATURAL JOIN regions AS r
GROUP BY r.regions
ORDER BY nbParticipation DESC;

-- QUESTION 2
SELECT rg.regions, COUNT(*) AS nbOr
FROM participe NATURAL JOIN resultat AS rs NATURAL JOIN regions AS rg
WHERE rs.medaille = 'Gold'
GROUP BY rg.regions
ORDER BY nbOr DESC;

-- QUESTION 3
SELECT rg.regions, COUNT(*) AS nbMedailles
FROM participe NATURAL JOIN resultat AS rs NATURAL JOIN regions AS rg
WHERE rs.medaille IS NOT NULL
GROUP BY rg.regions
ORDER BY nbMedailles DESC;

-- QUESTION 4
SELECT a.id, a.nom, COUNT(*) AS nbMedaillesOr
FROM athlete AS a NATURAL JOIN resultat AS r
WHERE r.medaille = 'Gold'
GROUP BY a.id, a.nom
ORDER BY nbMedaillesOr DESC;

-- QUESTION 5
SELECT rg.regions, COUNT(*) AS nbMedailles
FROM participe NATURAL JOIN resultat AS rs NATURAL JOIN regions AS rg
WHERE rs.ville = 'Albertville' AND rs.medaille IS NOT NULL
GROUP BY rg.regions
ORDER BY nbMedailles DESC;

-- QUESTION 6
SELECT COUNT(DISTINCT a.id)
FROM participe AS parun JOIN participe AS pardeux USING (id) NATURAL JOIN athlete AS a
WHERE parun.annee < pardeux.annee
AND pardeux.noc = 'FRA' AND parun.noc <> pardeux.noc;

-- QUESTION 7
SELECT COUNT(DISTINCT a.id)
FROM participe AS parun JOIN participe AS pardeux USING (id) NATURAL JOIN athlete AS a
WHERE parun.annee < pardeux.annee
AND parun.noc = 'FRA' AND parun.noc <> pardeux.noc;

-- QUESTION 8
SELECT p.age, COUNT(*) AS nbOr
FROM participe AS p NATURAL JOIN resultat AS rs
WHERE rs.medaille = 'Gold' AND p.age IS NOT NULL
GROUP BY p.age;

-- QUESTION 9
SELECT e.sport, COUNT(*) AS nbMedailles
FROM epreuves AS e NATURAL JOIN resultat AS rs NATURAL JOIN participe AS p
WHERE p.age >= 50 AND rs.medaille IS NOT NULL
GROUP BY e.sport
ORDER BY nbMedailles DESC;

-- QUESTION 10
SELECT o.label, o.ville, COUNT(DISTINCT e.elabel) AS nbEpreuves
FROM olympics AS o JOIN resultat USING(annee, saison, ville) NATURAL JOIN epreuves AS e
GROUP BY o.label, o.ville;

-- QUESTION 11
SELECT o.annee, COUNT(*) AS nbMedaillesFemme
FROM olympics AS o NATURAL JOIN resultat as r NATURAL JOIN athlete AS a
WHERE a.genre = 'F' AND o.saison = 'Summer'
GROUP BY o.annee;

-- EXERCICE 6
-- Les requêtes sont faites pour la Chine et le tennis de table:
-- Requête 
SELECT o.annee, COUNT(*) AS nELECT a.nom, COUNT(*) AS nbMedaillesOr
FROM resultat AS r, athlete AS a
WHERE r.id = a.id 
AND r.equipe = 'China' 
AND r.medaille = 'Gold' 
AND r.elabel LIKE 'Table Tennis%'
GROUP BY a.nom
HAVING COUNT(*) = (SELECT COUNT(a.nom) AS nbMedaillesOr
                    FROM resultat AS r, athlete AS a
                    WHERE r.id = a.id 
                    AND r.equipe = 'China' 
                    AND r.medaille = 'Gold' 
                    AND r.elabel LIKE 'Table Tennis%'
                    GROUP BY a.nom *
                    ORDER BY nbMedaillesOr 
                    DESC LIMIT 1);bMedaillesFemme

-- Requête 
SELECT COUNT(DISTINCT r.id)
FROM resultat AS r
WHERE r.equipe = 'China'
AND r.label LIKE 'Table Tennis%';

-- Requête 
SELECT ROUND(AVG(a.taille)::numeric, 2) AS tailleMoyenne, ROUND(AVG(a.poids)::numeric, 2) AS poidsMoyen, ROUND(AVG(p.age)::numeric, 2) AS ageMoyen
FROM athlete AS a, resultat AS r, participe AS p
WHERE a.id = r.id AND a.id = p.id
AND r.equipe = 'China'
AND r.label LIKE 'Table Tennis%'
AND a.genre = 'M';

-- Requête 
SELECT DISTINCT a.nom
FROM resultat AS r, athlete AS a
WHERE r.id = a.id
AND r.equipe = 'China'
AND r.label LIKE 'Table Tennis%'
AND r.medaille IS NULL;
