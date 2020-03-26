

CREATE PROCEDURE `exportar` ()
BEGIN
	SELECT 
   *
FROM
    logalerta,logcartao,logmedicaosensores,logronda
INTO OUTFILE 'C:/Users/joaof/OneDrive - ISCTE-IUL/SID/teste_exportacao.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';
END;

