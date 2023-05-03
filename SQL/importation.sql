DROP TABLE IF EXISTS import CASCADE;
DROP TABLE IF EXISTS noc;
DROP TABLE IF EXISTS athlete CASCADE;
DROP TABLE IF EXISTS regions CASCADE;
DROP TABLE IF EXISTS olympics CASCADE;
DROP TABLE IF EXISTS epreuves CASCADE;
DROP TABLE IF EXISTS participe;
DROP TABLE IF EXISTS resultat;
\! echo ""


\! echo "Création de la table temporaire import"
CREATE temp TABLE import (
    id INT, nom TEXT, genre TEXT, age INT, taille INT, poids FLOAT,
    equipe TEXT, noc TEXT, label TEXT, annee INT, saison TEXT, ville TEXT,
    sport TEXT, elabel TEXT, medaille TEXT);
\! echo ""


\! echo "Import des données d'athlete_events_utf8.csv"
\copy import from 'Ressource/athlete_events_utf8.csv' with (FORMAT csv, NULL 'NA', HEADER, ENCODING 'UTF-8')
\! echo ""


\! echo "Suppression des données inutiles"
DELETE FROM import WHERE annee < 1920 OR sport = 'Art Competitions';
\! echo ""


\! echo "Création de la table temporaire noc"
CREATE temp TABLE noc (
    noc TEXT, regions TEXT, notes TEXT);
\! echo ""


\! echo "Import des données d'noc_regions_utf8.csv"
\copy noc from 'Ressource/noc_regions_utf8.csv' with (FORMAT csv, NULL '', HEADER, ENCODING 'UTF-8')
\! echo ""

\! echo "Création de la table athlete"
CREATE TABLE athlete (
    id INT,
    nom VARCHAR(108) NOT NULL,
    genre VARCHAR(1),
    taille INT,
    poids FLOAT,
    CONSTRAINT pk_athele PRIMARY KEY (id));
\! echo ""

\! echo "Ajout des données dans athlete"
INSERT INTO athlete
    SELECT DISTINCT id, nom, genre, taille, poids
    FROM import ORDER BY id;
\! echo ""

\! echo "Création de la table regions"
CREATE TABLE regions (
    noc VARCHAR(3),
    regions VARCHAR(32),
    note VARCHAR(27),
    CONSTRAINT pk_region PRIMARY KEY (noc));
\! echo ""

\! echo "Ajout des données dans regions"
INSERT INTO regions
    SELECT DISTINCT noc, regions, notes
    FROM noc ORDER BY noc;
\! echo ""

\! echo "Transformation du noc 'SIN' en 'SGP' pour coller au données d'import"
UPDATE regions SET noc = 'SGP' WHERE noc = 'SIN';
\! echo ""

\! echo "Création de la table olympics"
CREATE TABLE olympics (
    annee INT,
    saison VARCHAR(6),
    ville VARCHAR(22),
    label VARCHAR(11),
    CONSTRAINT pk_olympics PRIMARY KEY (annee, saison, ville));
\! echo ""

\! echo "Ajout des données dans regions"
INSERT INTO olympics 
    SELECT DISTINCT annee, saison, ville, label
    FROM import ORDER BY annee;
\! echo ""

\! echo "Création de la table epreuves"
CREATE TABLE epreuves (
    elabel VARCHAR(85),
    sport VARCHAR(25),
    CONSTRAINT pk_events PRIMARY KEY (elabel));
\! echo ""

\! echo "Ajout des données dans epreuves"
INSERT INTO epreuves
    SELECT DISTINCT elabel, sport
    FROM import ORDER BY sport;
\! echo ""

\! echo "Création de la table participe"
CREATE TABLE participe (
    id INT,
    annee INT,
    saison VARCHAR(6),
    ville VARCHAR(22),
    noc VARCHAR(3),
    age INT,
    CONSTRAINT fk_athlete FOREIGN KEY (id) REFERENCES athlete(id),
    CONSTRAINT fk_olympics FOREIGN KEY (annee, saison, ville) REFERENCES olympics(annee, saison, ville),
    CONSTRAINT fk_regions FOREIGN KEY (noc) REFERENCES regions(noc));
\! echo ""

\! echo "Ajout des données dans participe"
INSERT INTO participe
    SELECT DISTINCT id, annee, saison, ville, noc, age 
    FROM import ORDER BY id;
\! echo ""

\! echo "Création de la table resultat"
CREATE TABLE resultat (
    id INT,
    elabel VARCHAR(85),
    annee INT,
    saison VARCHAR(8),
    ville VARCHAR(22),
    equipe VARCHAR(47),
    medaille VARCHAR(6),
    CONSTRAINT fk_athlete FOREIGN KEY (id) REFERENCES athlete(id),
    CONSTRAINT fk_epreuves FOREIGN KEY (elabel) REFERENCES epreuves(elabel),
    CONSTRAINT fk_olympics FOREIGN KEY (annee, saison, ville) REFERENCES olympics(annee, saison, ville));
\! echo ""

\! echo "Ajout des données dans resultat"
INSERT INTO resultat
    SELECT DISTINCT id, elabel, annee, saison, ville, equipe, medaille
    FROM import ORDER BY id;
\! echo ""
