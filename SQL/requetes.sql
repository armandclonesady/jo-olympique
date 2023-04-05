-- QUESTION 1
SELECT COUNT(*) AS nbcolumns
FROM information_schema.columns
WHERE table_name = 'import';

-- QUESTION 2
SELECT COUNT(*) AS nbrows
FROM import;

-- QUESTION 3
SELECT COUNT(n1)
FROM noc;

-- QUESTION 4
SELECT COUNT(DISTINCT n2) 
FROM import;

-- QUESTION 5
SELECT COUNT(n15)
FROM import
WHERE n15='Gold';

-- QUESTION 6
SELECT *
FROM import
WHERE n2 LIKE 'Carl Lewis%';


-- QUESTION 7
SELECT noc, COUNT(*) AS nbParticipation
FROM participe AS p NATURAL JOIN resultat AS r
GROUP BY noc
ORDER BY nbParticipation DESC;