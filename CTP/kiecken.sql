-- NOM    : KIECKEN
-- Prenom : Raphaël
-- Groupe : D


-- Remplacez les lignes 'non réalisé' par vos réponses

-- exemple de commande Unix
-- \! wc -l world.data

---------------------
DROP TABLE IF EXISTS world CASCADE;
DROP TABLE IF EXISTS ville CASCADE;
DROP TABLE IF EXISTS pays CASCADE;
DROP TABLE IF EXISTS langues CASCADE;

\echo '\n EXO 1  -   Q1 '

CREATE temp TABLE world (
    id INT, cityname TEXT, countrycode CHAR(3), district TEXT, 
    population INT, code CHAR(3), countryname TEXT, continent TEXT, 
    region TEXT, surfacearea NUMERIC(10,2), indepyear INT, countrypopulation INT,
    capital INT, countrycode2 CHAR(3), language TEXT, 
    isofficial CHAR(1), percentage NUMERIC(4,1));

\echo '\n EXO 1  -   Q2 '
\echo 'non réalisé'

-- \! cat world.data |tr "#" "\a0"|head -2 > new_world.csv
-- \copy world from 'new_world.csv' with (FORMAT csv, HEADER, DELIMITER ';', ENCODING 'UTF-8');

--------------------

\echo '\n EXO 2  -   Q3 '

CREATE TABLE ville (
    id INT,
    cityname TEXT,
    countrycode CHAR(3),
    district TEXT,
    population INT);

INSERT INTO ville
    SELECT DISTINCT id, name, countrycode, district, population
    FROM mathieu.world ORDER BY id;

CREATE TABLE pays (
    code CHAR(3),
    countryname TEXT,
    continent TEXT,
    region TEXT,
    surfacearea NUMERIC(10,2), 
    indepyear INT,
    countrypopulation INT,
    capital INT);

INSERT INTO pays
    SELECT DISTINCT code, name2, continent, region, surfacearea, indepyear, population2, capital
    FROM mathieu.world ORDER BY code;

CREATE TABLE langues (
    countrycode CHAR(3),
    language TEXT,
    isofficial CHAR(1),
    percentage NUMERIC(4,1));

INSERT INTO langues
    SELECT DISTINCT countrycode2, language, isofficial, percentage
    FROM mathieu.world ORDER BY countrycode2;


\echo '\n EXO 2  -   Q4 '

ALTER TABLE ville ADD CONSTRAINT pk_ville PRIMARY KEY (id);
ALTER TABLE pays ADD CONSTRAINT pk_pays PRIMARY KEY (code);

ALTER TABLE ville ADD CONSTRAINT fk_pays1 FOREIGN KEY (countrycode) REFERENCES pays(code);
ALTER TABLE pays ADD CONSTRAINT fk_ville FOREIGN KEY (capital) REFERENCES ville(id);
ALTER TABLE langues ADD CONSTRAINT fk_pays2 FOREIGN KEY (countrycode) REFERENCES pays(code);

--------------------

\echo '\n EXO 3  -   Q5 '

SELECT cityname, countryname 
FROM ville, pays
WHERE countrycode = code AND population > 7000000
ORDER BY population DESC;

\echo '\n EXO 3  -   Q6 '

SELECT COUNT(*)
FROM pays, langues
WHERE code = countrycode AND language = 'French';

\echo '\n EXO 3  -   Q7 '

SELECT countryname, COUNT(*)
FROM pays, langues
WHERE code = countrycode
GROUP BY countryname
HAVING COUNT(*) > 10
ORDER BY COUNT(*) DESC;

\echo '\n EXO 3  -   Q8 '

SELECT language, COUNT(*)
FROM pays, langues
WHERE code = countrycode
GROUP BY language
ORDER BY COUNT(*) DESC
LIMIT 1;

\echo '\n EXO 3  -   Q9 '

SELECT cityname, countryname, population
FROM ville, pays
WHERE countrycode = code 
AND population < (SELECT population
                    FROM ville
                    WHERE cityname = 'Lille')
ORDER BY population DESC;

\echo '\n EXO 3  -   Q10 '

SELECT countryname, language, percentage
FROM pays as p, langues
WHERE p.code = countrycode
AND continent = 'Europe'
AND percentage = (SELECT MAX(percentage)
    FROM pays , langues
    WHERE p.code = countrycode);