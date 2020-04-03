@ECHO OFF

mysql -u root -p -e "SELECT sistema.PeriocidadeImportacaoExportacao FROM sistema WHERE IDSistema = 1;" g12_museum > temp.txt

more +1 <temp.txt >val_temp.txt

set /P p= < val_temp.txt

del "temp.txt"
del "val_temp.txt"

schtasks /create /sc minute /mo %p% /tn "Log Migration" /tr .migrate.bat

ECHO Log migration scheduled to happen every %p% minutes.

PAUSE