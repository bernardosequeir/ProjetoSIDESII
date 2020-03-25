@ECHO OFF
set server=localhost
set db=test_export
set table=test_export_result
set user=root
set pass=teste123

mysql -u %user% -p%pass% %db% < "C:\Users\Nuno Rego\Desktop\ProjetoSIDESII\import_export_bats\import_control.sql" 

mysql -u %user% -p%pass% -h %server% -e "SELECT * FROM %table%;" %db%

PAUSE