archivorigen="./perm_extr_conc.sql"
archivopermiso="./perm_extr_conc.sql"
if [ ! -f $archivorigen ]
	then
    	print "prompt no existen permisos externos a ejecutar" >$archivopermiso
	exit
else
	cp $archivorigen $archivopermiso
fi
