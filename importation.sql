DROP TABLE IF EXISTS import;

CREATE temp TABLE import (
    n1 INT, n2 TEXT, n3 TEXT, n4 INT, n5 INT, n6 FLOAT,
    n7 TEXT, n8 TEXT, n9 TEXT, n10 INT, n11 TEXT, n12 TEXT,
    n13 TEXT, n14 TEXT, n15 TEXT
    );

\copy import from 'athlete_events_utf8.csv' with (FORMAT csv, NULL 'NA', HEADER, ENCODING 'UTF-8')

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

DELETE FROM import WHERE n10::INT < 1920;

ALTER TABLE import ADD n16 TEXT;
ALTER TABLE import ADD n17 TEXT;
ALTER TABLE import ADD n18 TEXT;

\copy import (n16, n17, n18) from 'noc_regions_utf8.csv' with (FORMAT csv, NULL 'NA', HEADER, ENCODING 'UTF-8')