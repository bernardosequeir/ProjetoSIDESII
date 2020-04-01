LOAD DATA INFILE 'C:/Users/joaof/OneDrive - ISCTE-IUL/SID/ficheirocontrolo.csv'
INTO TABLE test_export_result
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\N';