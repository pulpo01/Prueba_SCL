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
#ORIGEN=${XPC_DAT}"/DICOM/envios"
#DESTINO="/produccion/explotacion/srfactur/dicom/envios"

MAQUINA=`uname -n`
echo " \n MAQUINA : " $MAQUINA
if [ "$MAQUINA" = "startel1" ] || [ "$MAQUINA" = "prd1016" ] || [ "$MAQUINA" = "prd1019" ]
then
        ORIGEN=${XPC_DAT}"/DICOM/envios"
        DESTINO=${XPC_EXT}"/dicom/envios"

else
        ORIGEN=${XPC_DAT}"/"${szCodProceso}
        DESTINO=${XPC_DAT}"/TRASPASO"
fi

cd $ORIGEN

WriLog 3 "Traspasando Archivo Dicom, desde carpeta " ${ORIGEN}
cd $ORIGEN
for J in `ls *.txt`
do
   if test -f ${J}
   then
	WriLog 5 "Moviendo Archivo ${J}"
	a=`ls -l $J | awk '{print $5}'`
	if test $a -eq "0"
	then 
		WriLog 5 "0 bytes, se elimina"
		rm -f $J
	else
		WriLog 5 "$a bytes, se mueve y se comprime"
		cp -p $J $DESTINO
		compress -f $J
	fi
   else
     WriLog 3 "NO hay archivos para mover"
   fi
done
echo
######################################################################################
