DROP TABLE IF EXISTS import CASCADE;
DROP TABLE IF EXISTS noc;
DROP TABLE IF EXISTS athlete CASCADE;
DROP TABLE IF EXISTS regions CASCADE;
DROP TABLE IF EXISTS olympics CASCADE;
DROP TABLE IF EXISTS epreuves CASCADE;
DROP TABLE IF EXISTS participe;
DROP TABLE IF EXISTS resultat;
DROP TABLE IF EXISTS contient;

CREATE temp TABLE import (
    n1 INT, n2 TEXT, n3 TEXT, n4 INT, n5 INT, n6 FLOAT,
    n7 TEXT, n8 TEXT, n9 TEXT, n10 INT, n11 TEXT, n12 TEXT,
    n13 TEXT, n14 TEXT, n15 TEXT
    );
    
\copy import from 'Ressource/athlete_events_utf8.csv' with (FORMAT csv, NULL 'NA', HEADER, ENCODING 'UTF-8')

DELETE FROM import WHERE n10 < 1920 OR n13 = 'Art Competitions';

-- SELECT COUNT(*) FROM import; -> 255.080

CREATE temp TABLE noc (
    n1 TEXT, n2 TEXT, n3 TEXT
    );

\copy noc from 'Ressource/noc_regions_utf8.csv' with (FORMAT csv, NULL '', HEADER, ENCODING 'UTF-8')

-- 

CREATE TABLE athlete (
    id INT,
    nom CHAR(108) NOT NULL,
    genre CHAR(1),
    taille INT,
    poids FLOAT,
    CONSTRAINT pk_athele PRIMARY KEY (id));

INSERT INTO athlete
    SELECT DISTINCT n1, n2, n3, n5, n6
    FROM import ORDER BY n1;


CREATE TABLE regions (
    noc CHAR(3),
    regions CHAR(32),
    note CHAR(27),
    CONSTRAINT pk_region PRIMARY KEY (noc));

INSERT INTO regions
    SELECT DISTINCT n1, n2, n3
    FROM noc ORDER BY n1;

UPDATE regions SET noc = 'SGP' WHERE noc = 'SIN';


CREATE TABLE olympics (
    annee INT,
    saison CHAR(6),
    ville CHAR(22),
    label CHAR(11),
    CONSTRAINT pk_olympics PRIMARY KEY (annee, saison, ville));

INSERT INTO olympics 
    SELECT DISTINCT n10, n11, n12, n9
    FROM import ORDER BY n10;


CREATE TABLE epreuves (
    label CHAR(85),
    sport CHAR(25),
    CONSTRAINT pk_events PRIMARY KEY (label));

INSERT INTO epreuves
    SELECT DISTINCT n14, n13
    FROM import ORDER BY n13;


CREATE TABLE participe (
    id INT,
    annee INT,
    saison CHAR(6),
    ville CHAR(22),
    noc CHAR(3),
    age INT,
    CONSTRAINT fk_athlete FOREIGN KEY (id) REFERENCES athlete(id),
    CONSTRAINT fk_olympics FOREIGN KEY (annee, saison, ville) REFERENCES olympics(annee, saison, ville),
    CONSTRAINT fk_regions FOREIGN KEY (noc) REFERENCES regions(noc));

INSERT INTO participe
    SELECT DISTINCT n1, n10, n11, n12, n8, n4 
    FROM import ORDER BY n1;


CREATE TABLE resultat (
    id INT,
    label CHAR(85),
    annee INT,
    saison CHAR(8),
    ville CHAR(22),
    equipe CHAR(47),
    medaille CHAR(6),
    CONSTRAINT fk_athlete FOREIGN KEY (id) REFERENCES athlete(id),
    CONSTRAINT fk_epreuves FOREIGN KEY (label) REFERENCES epreuves(label),
    CONSTRAINT fk_olympics FOREIGN KEY (annee, saison, ville) REFERENCES olympics(annee, saison, ville));

INSERT INTO resultat
    SELECT DISTINCT n1, n14, n10, n11, n12, n7, n15
    FROM import ORDER BY n1;
