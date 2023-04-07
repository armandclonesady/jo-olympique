-- EXERCICE 3
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
ORDER BY nbGold DESC;

-- QUESTION 3
SELECT rg.regions, COUNT(*) AS nbMedailles
FROM participe NATURAL JOIN resultat AS rs NATURAL JOIN regions AS rg
WHERE rs.medaille IS NOT NULL
GROUP BY rg.regions
ORDER BY nbGold DESC;