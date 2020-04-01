DROP TABLE IF EXISTS test;
CREATE TABLE test (
	tableid varchar(20),
    field1 varchar(30),
    field2 varchar(30),
    field3 varchar(30),
    field4 varchar(30),
    field5 varchar(30), 
    field6 varchar(30), 
    field7 varchar(30), 
    field8 varchar(30), 
    field9 varchar(30), 
    field10 varchar(30),
	  field11 varchar(30), 
    field12 varchar(30), 
    field13 varchar(30), 
    field14 varchar(30), 
    field15 varchar(30)
);


LOAD DATA INFILE 'C:\\Users\\Bernardo\\Desktop\\Iscte\\3Ano\\ProjetoSIDESII\\implementacao_g15\\auditor_server\\export\\insert_table.sql'
INTO TABLE test
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'
(tableid, field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13, field14, field15);