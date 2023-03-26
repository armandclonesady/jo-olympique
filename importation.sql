DROP TABLE import;

CREATE temp TABLE import (
    n1 INT, n2 CHAR(108), n3 TEXT,
    n4 INT, n5 INT, n6 FLOAT,
    n7 TEXT, n8 TEXT, n9 TEXT,
    n10 INT, n11 TEXT, n12 TEXT,
    n13 TEXT, n14 TEXT, n15 TEXT
    );

\copy import from 'athlete_events_utf8.csv' with (FORMAT csv, NULL 'NA', HEADER, ENCODING 'UTF-8')

SELECT * FROM import LIMIT 10;