@ECHO OFF
::Environment variables
set server=localhost
set db=museum
set table=test_export_result
set user=root
set pass=teste123

::Delete the old export file/files that are in the directory
IF EXIST *.csv (
	del *.csv
	ECHO FILE DELETED
)

::Import control line to the DB
mysql -u %user% -p%pass% %db% < "C:\Users\joaof\Documents\GitHub\ProjetoSIDESII\implementacao_g15\origin_server\origin_export\import_control.sql"
::Prints the updated Control Table
mysql -u %user% -p%pass% -h %server% -e "SELECT * FROM %table%;" %db%

PAUSE