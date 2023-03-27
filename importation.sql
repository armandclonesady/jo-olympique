DROP TABLE import;

CREATE temp TABLE import (
    n1 INT, n2 CHAR(108), n3 CHAR(1),
    n4 INT, n5 INT, n6 FLOAT,
    n7 CHAR(47), n8 CHAR(3), n9 CHAR(11),
    n10 INT, n11 CHAR(6), n12 CHAR(22),
    n13 CHAR(25), n14 CHAR(85), n15 CHAR(6)
    );

\copy import from 'athlete_events_utf8.csv' with (FORMAT csv, NULL 'NA', HEADER, ENCODING 'UTF-8')

DELETE FROM import WHERE n10 < 1920;