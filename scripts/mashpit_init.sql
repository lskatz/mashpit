CREATE TABLE IF NOT EXISTS TAXONOMY(
  taxid     INTEGER PRIMARY KEY, /* same as NCBI taxid wherever possible */
  genus     TEXT,
  species   TEXT,
  subspecies TEXT,
  UNIQUE    (genus, species, subspecies),
  UNIQUE    (taxid)
);

CREATE TABLE IF NOT EXISTS BIOSAMPLE(
  biosample_acc TEXT PRIMARY KEY, /* Usually starts with SAMN, SAME, or something similar */
  strain    TEXT, /* Allow it to be null */
  isolate   TEXT,
  taxid     INTEGER,
  collected_by TEXT,
  collection_date TEXT,
  latitude  FLOAT,
  longitude FLOAT,
  host_taxid INTEGER,
  host_disease TEXT,
  isolation_source TEXT,
  serovar   TEXT,
  UNIQUE    (strain),
  FOREIGN KEY (taxid) REFERENCES TAXONOMY(taxid)
  FOREIGN KEY (host_taxid) REFERENCES TAXONOMY(taxid)
);

CREATE TABLE IF NOT EXISTS SKETCH(
  sketchid  INTEGER PRIMARY KEY AUTOINCREMENT,
  biosample_acc INTEGER NOT NULL,
  path      TEXT NOT NULL,
  source    TEXT NOT NULL, /* aribitrary string describing where this sketch came from */
  software  TEXT NOT NULL, /* usually the value here is "mash" */
  seed      INTEGER NOT NULL, /* The mash random seed default is 42 */
  
  UNIQUE    (path),
  FOREIGN KEY (biosample_acc) REFERENCES BIOSAMPLE(biosample_acc)
);
