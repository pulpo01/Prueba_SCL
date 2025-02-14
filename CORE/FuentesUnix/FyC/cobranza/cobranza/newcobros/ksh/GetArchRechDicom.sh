######################################################################################
iNivLog=$1
szCodProceso=$2
######################################################################################
WriLog()
{
    set $@
    iNivel=$1
    shift
    if test ${iNivel} -le ${iNivLog}
    then
        printf "\n`date +[%T]` "
        if test ${iNivel} -eq 1
        then
            printf "     Error (${szAppName}) : "
        elif test ${iNivel} -eq 2
        then
            printf "     Aviso (${szAppName}) : "
        fi
        printf "%s " $@ 
    fi 
}
######################################################################################
MAQUINA=`uname -n`
echo "\n MAQUINA : " $MAQUINA
if [ "$MAQUINA" = "startel1" ] || [ "$MAQUINA" = "prd1016" ] || [ "$MAQUINA" = "prd1019" ]
then
	#ORIGEN="/produccion/explotacion/srfactur/dicom/rechazos"
	ORIGEN=${XPC_EXT}"/dicom/rechazos"
	DESTINO=${XPC_DAT}'/DICOM/rechazos'

else
	ORIGEN=${XPC_DAT}"/DEVUELTOS/"${szCodProceso}
	DESTINO=${XPC_DAT}"/"${szCodProceso}"/rechazos"
fi

if [ "$MAQUINA" = "startel1" ] 
then
	WriLog 3 "Convirtiendo Archivos .txt de " ${ORIGEN}
	remsh startel1 -l srfactur "chown xpcobros:explota dicom/rechazos/*.txt"
fi

#ORIGEN="/produccion/explotacion/srfactur/dicom/rechazos"
#DESTINO=${XPC_DAT}'/DICOM/rechazos'

#WriLog 3 "Convirtiendo Archivos .txt de " ${ORIGEN}
#remsh startel1 -l srfactur "chown xpcobros:explota dicom/rechazos/*.txt"

WriLog 3 "Recuperando Archivos de Rechazos Dicom, desde carpeta " ${ORIGEN}
cd $ORIGEN
for J in `ls *.txt`
do  
	WriLog 5 "Archivo ${J}"
	a=`ls -l $J | awk '{print $5}'`
	WriLog 5 "$a bytes, se mueve y se comprime"
	cp -p $J $DESTINO
	compress $J
done                                    
#se crea archivo con archivos del directorio
WriLog 3 "Creando archivo Archivos.dat en " ${DESTINO}
cd $DESTINO 
rm -f Archivos.dat
WriLog 3 "Eliminando Archivos.dat en " ${DESTINO}
ls *.txt>Archivos.dat
WriLog 3 "archivo Archivos.dat creado en " ${DESTINO}
######################################################################################

