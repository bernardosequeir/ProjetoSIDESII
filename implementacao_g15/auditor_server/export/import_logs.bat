
@Echo off
::IF NOT EXIST *.csv (
  ::ECHO "Não tem para importar"
  ::EXIT
::)
mysql --user=root auditor -e "call soma_logs" > tempfile 
powershell -command "& {get-content tempfile |select-object -last 1}" > beforeImport
echo beforeImport
del tempfile
mysql --user=root auditor < "C:\Users\Bernardo\Desktop\Iscte\3Ano\ProjetoSIDESII\implementacao_g15\auditor_server\export\insert_table.sql"
mysql --user=root auditor -e "call importacao" > tempfile 
echo tempfile

::cleanup

del beforeImport