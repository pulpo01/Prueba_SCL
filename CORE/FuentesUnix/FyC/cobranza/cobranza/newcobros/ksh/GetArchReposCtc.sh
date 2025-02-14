exit 0
######################################################################################
szAppName=$0
iNivLog=$1
aux=0  
#Hoy=$(date +%d-%b-%Y)
Hoy=$(date +%Y%m%d)

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
        print $@ 
    fi 
}
######################################################################################
WriLog 5 "COMIENZA RESCATE DE LOS ARCHIVOS DE REPOSICIONES :"

# SETEO DE VARIABLES DE AMBIENTE ( NECESARIO ??? )
# export PATH=$PATH:/users1/proyectos/siscel/startel/cobros/unix/bin
# export ORACLE_HOME=/soft/app/oracle73/product/7.3.4
# export ORACLE_SID=scel
# export TWO_TASK=scel


#------------------------------------------------------------------------------------#
# CAMBIO AL DIRECTORIO DE TRABAJO EN XPCOBROS                                        #
#------------------------------------------------------------------------------------#
#cd /interactivo/produccion/xpcobros/SUPERTEL/REHA_CTC
PATH_WORK=${XPC_DAT}"/SUPERTEL/REHA_CTC"
cd ${PATH_WORK}

#------------------------------------------------------------------------------------#
# SI EXISTE UN ARCHIVO DE PAGOS PREVIO, LO BORRO                                     #
#------------------------------------------------------------------------------------#
ARCHPAGOS="NuevosPagos.dat"
WriLog 5 "ARCHPAGOS : '${ARCHPAGOS}'"
if test -r ${ARCHPAGOS}
then
    rm -r ${ARCHPAGOS}
    WriLog 5 "\nBorrado '${ARCHPAGOS}' Anterior"
fi


#------------------------------------------------------------------------------------#
# ME CONECTO A LA CUENTA TRASPASO E INTENTO RECUPERAR ARCHIVO DE PAGOS               #
#------------------------------------------------------------------------------------#
ftp -n <<!
open 166.75.72.14
user traspaso Traspaso
mget srep*.dat
!


#------------------------------------------------------------------------------------#
# VERIFICO SI SE HA COPIADO UN ARCHIVO                                               #
#------------------------------------------------------------------------------------#
WriLog 5 "a=ls srep*.dat 2> /dev/null | wc -l"
a=$(ls srep*.dat 2> /dev/null | wc -l )
WriLog 5 "a=${a}"
if test ${a} = 0
then
    WriLog 3 ">>  FIN  <<  : No encontro archivo con nuevos pagos en 'traspaso'"
    exit 0
fi    


#------------------------------------------------------------------------------------#
# RECUPERACION DEL ARCHIVO DE PAGOS A PROCESAR                                       #
#------------------------------------------------------------------------------------#
ARCHRECIENTE=$(ls -1art srep*.dat | awk '{ARCH=$0}; END{print ARCH}' )
WriLog 5 "\nARCHRECIENTE : '${ARCHRECIENTE}'"
if test -r ${ARCHRECIENTE}
then
    aux=0    
    WriLog 5 "Procesando pagos del archivo : '${ARCHRECIENTE}'"
else
    WriLog 1 "Hay Problemas con el archivo '${ARCHRECIENTE}' revisar"
    exit -1
fi


#------------------------------------------------------------------------------------#
# CORTA A 54 CHAR EL ARCHIVO A PROCESAR                                              #
#------------------------------------------------------------------------------------#
WriLog 5 "Cortando el archivo a 54 caracteres por registro"
WriLog 5 "cat ${ARCHRECIENTE} | awk '{ printf ("%54s\n",substr(${ARCHRECIENTE},001,054)) } ' > ${ARCH}"
ARCH=${ARCHRECIENTE}".aux"
cat ${ARCHRECIENTE} | awk '{ printf ("%54s\n",substr($0,001,054)) } ' > ${ARCH}
if test $? != 0
then
    WriLog 1 "Fallo el Corte del archivo '${ARCHRECIENTE}' a 54 caracters, revisar"
    exit -1
fi

mv -f ${ARCH} ${ARCHRECIENTE}
if test $? != 0
then
    WriLog 1 "Fallo al mover el archivo cortado al archivo reciente"
    exit -1
fi

#------------------------------------------------------------------------------------#
# VERIFICA EL ARCHIVO A PROCESAR CONTRA EL ARCHIVO DE PAGOS DEL DIA DE HOY           #
#------------------------------------------------------------------------------------#
ARCHDEHOY="RepoCtc-"${Hoy}".dat"
WriLog 5 "ARCHDEHOY    : '${ARCHDEHOY}'" 

if test -r ${ARCHDEHOY}
then

#------ ARCHIVO DE PAGOS DE HOY SI EXISTE Y ES LEGIBLE : PROCESA LA DIFERENCIA ------#

    WriLog 5 "diff ${ARCHDEHOY} ${ARCHRECIENTE} | grep '< ' | wc -l"
    aux=$(diff ${ARCHDEHOY} ${ARCHRECIENTE} | grep '< ' | wc -l)
    WriLog 5 "aux: ${aux}"
    if test ${aux} != 0
    then
        WriLog 2 "En el archivo reciente no hay algunos pagos que si estan en el respaldo de hoy"
#        exit -1
    fi

    WriLog 5 "diff ${ARCHDEHOY} ${ARCHRECIENTE} | grep '> ' | wc -l"
    aux=$(diff ${ARCHDEHOY}  ${ARCHRECIENTE} | grep '> ' | wc -l )
    WriLog 5 "aux: ${aux}"
    if test ${aux} = 0
    then
        WriLog 1 "No hay pagos nuevos"
        exit -1
    fi 

    WriLog 5 "diff ${ARCHDEHOY} ${ARCHRECIENTE} | grep '> ' | awk '{printf("%s\n",$2);}' > ${ARCHPAGOS}"
    diff ${ARCHDEHOY} ${ARCHRECIENTE} | grep '> ' | awk '{printf("%s\n",$2);}' > ${ARCHPAGOS} 
    if test $? != 0 
    then
        WriLog 1 "Fallo la Generacion de archivo de pagos (diferencia de los archivos)"
        exit -1
    else
        WriLog 3 ">>  OK!  <<  : Archivo '${ARCHPAGOS}' Generado (por diferencia de los archivos)"
    fi

else

#---- ARCHIVO DE PAGOS DE HOY NO EXISTE O NO ES LEGIBLE: PROCESA TODO EL ARCHIVO ----#

    WriLog 5 "cp ${ARCHRECIENTE} ${ARCHPAGOS}"
    cp ${ARCHRECIENTE} ${ARCHPAGOS}
    if test $? != 0 
    then
        WriLog 1 "Fallo la Generacion de archivo de pagos (copia de los archivos)"
        exit -1
    else
        WriLog 3 ">>  OK!  <<  : Archivo '${ARCHPAGOS}' Generado (por copia de los archivos)"
    fi
fi

#------------------------------------------------------------------------------------#
# ACTUALIZA EL ARCHIVO DE RESPALDO DE HOY CON LOS ULTIMOS PAGOS                      #
#------------------------------------------------------------------------------------#
WriLog 5 "Actualizando las versiones de los archivos de pagos"
# version alternativa del tema respaldo pagos del dia
# mv ${ARCHRECIENTE} ${ARCHDEHOY}
# cp ${ARCHDEHOY} RESP_REHA/${ARCHDEHOY}.OK
# la nueva version del tema podria ser :
cat ${ARCHPAGOS} >> ${ARCHDEHOY}
cp ${ARCHDEHOY} RESP_REHA/${ARCHDEHOY}.OK
rm ${ARCHRECIENTE}

WriLog 5 "Respaldando archivos recogidos de CTC"
PATH_WORK="/hsz50/users/traspaso"

X="$(ls ${PATH_WORK}/srep*.dat)"
for I in $X
do
# renombra el archivo agregando la extencion .OK
   J=${I}.OK
   mv -f ${I} ${J}
# mueve el archivo renombrado al directorio de respaldo   
   mv -f ${J} ${PATH_WORK}/RESP_REHA
done

WriLog 3 "\n>>  FIN  <<  : Listos para procesar archivo con los pagos recientes"
exit 0

######################################################################################
