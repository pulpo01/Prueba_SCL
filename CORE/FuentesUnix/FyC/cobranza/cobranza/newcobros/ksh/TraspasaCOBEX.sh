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
        printf "\n$(date +[%T]) "
        if test ${iNivel} -eq 1
        then
            printf "     Error (${szAppName}) : "
        elif test ${iNivel} -eq 2
        then
            printf "     Aviso (${szAppName}) : "
        fi
	#	printf "%s \n", $@
           echo "\n $@"
    fi
}
######################################################################################
ORIGEN=$XPC_DAT/${szCodProceso}
DESTINO=$XPC_TRP
cd $ORIGEN

x=0

WriLog 3 "Traspasando archivos generados para la cobranza externa "
for I in `ls`
do
    WriLog 3 "Copiando archivos del directorio ${I}"
    cd $ORIGEN/$I
    if test -f ${szCodProceso}_${I}_*.txt
    then 
       for J in `ls ${szCodProceso}_${I}_*.txt`
   	   do
           WriLog 5 "Archivo ${J}"
           a=`ls -l $J | awk '{print $5}'`
           if test $a -eq "0"
           then
              WriLog 5 "0 bytes, se elimina"
              rm -f $J
              x=$?
           else
              WriLog 5 "$a bytes, se copia y se comprime"
              cp -p $J $DESTINO
              x=$?
              compress -f $J
              x=$?
           fi
       done
    else
       WriLog 3 "No hay archivos para traspasar en $ORIGEN/$I"
    fi
done
#return $x
######################################################################################
