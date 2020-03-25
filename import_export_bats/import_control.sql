LOAD DATA INFILE 'C:/Users/Nuno Rego/Desktop/ProjetoSIDESII/import_export_bats/ficheirocontrolo.csv'
INTO TABLE test_export_result
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\N';