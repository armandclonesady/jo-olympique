DROP TABLE IF EXISTS import CASCADE;
DROP TABLE IF EXISTS noc;
DROP TABLE IF EXISTS athlete CASCADE;
DROP TABLE IF EXISTS measurement CASCADE;

CREATE temp TABLE import (
    n1 INT, n2 TEXT, n3 TEXT, n4 INT, n5 INT, n6 FLOAT,
    n7 TEXT, n8 TEXT, n9 TEXT, n10 INT, n11 TEXT, n12 TEXT,
    n13 TEXT, n14 TEXT, n15 TEXT
    );
    
\copy import from 'Ressource/athlete_events_utf8.csv' with (FORMAT csv, NULL 'NA', HEADER, ENCODING 'UTF-8')

ALTER TABLE import ALTER n2 TYPE CHAR(108);
ALTER TABLE import ALTER n3 TYPE CHAR(1);
ALTER TABLE import ALTER n7 TYPE CHAR(47);
ALTER TABLE import ALTER n8 TYPE CHAR(3);
ALTER TABLE import ALTER n9 TYPE CHAR(11);
ALTER TABLE import ALTER n11 TYPE CHAR(6);
ALTER TABLE import ALTER n12 TYPE CHAR(22);
ALTER TABLE import ALTER n13 TYPE CHAR(25);
ALTER TABLE import ALTER n14 TYPE CHAR(85);
ALTER TABLE import ALTER n15 TYPE CHAR(6);

DELETE FROM import WHERE n10 < 1920 OR n13 = 'Art Competitions';

-- SELECT COUNT(*) FROM import; -> 255.080

CREATE temp TABLE noc (
    n1 TEXT, n2 TEXT, n3 TEXT
    );

\copy noc from 'Ressource/noc_regions_utf8.csv' with (FORMAT csv, HEADER, ENCODING 'UTF-8')

/*ALTER TABLE import ALTER n16 TYPE CHAR(3);
ALTER TABLE import ALTER n17 TYPE CHAR(32);
ALTER TABLE import ALTER n18 TYPE CHAR(27);*/


SELECT DISTINCT n1 AS id, n2 AS name, n3 AS gender, n4 AS age, n7 AS team, n8 AS noc
INTO athlete FROM import;

ALTER TABLE athlete ADD CONSTRAINT pk_athele PRIMARY KEY (id);

SELECT DISTINCT n1 AS id, n5 AS height, n6 AS weight, n10 AS year
INTO measurement FROM import;

ALTER TABLE measurement ADD CONSTRAINT fk_athete FOREIGN KEY (id) REFERENCES athlete(id);

SELECT DISTINCT n9 AS games, n10 AS year, n11 AS season, n12 AS city
INTO olympics FROM import;

ALTER TABLE olympics ADD CONSTRAINT pk_olympics PRIMARY KEY (year, season, city);

SELECT DISTINCT n14 AS wording, n13 AS sport, n15 AS medal, n1 AS id
INTO events FROM import;

ALTER TABLE events ADD CONSTRAINT pk_events PRIMARY KEY (wording);
ALTER TABLE events ADD CONSTRAINT fk_olympics FOREIGN KEY (id) REFERENCES athlete(id);