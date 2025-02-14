#!/bin/ksh
##########################################################################################
#        BalanceoClientes : Generador de Rangos de Clientes en tabla FA_RANGOSHOST_TO.
###########################################################################################
#       Autor    :  Alvaro Gonzalez S.
#       Fecha    :  25 Octubre de 2006
##########################################################################################

function Glosa_Err {
   print -u2 "Uso : BalanceoClientes";
   print -u2 "\t Cod_CiclFact (CCMMAA) ==> Codigo de Ciclo de Facturacion ";
   print -u2 "\t Cantidad de Maquinas a procesar clientes";
   print -u2 "\nFaltan Parametros de Entrada"
   return 0;
}
#
ERR001="Codigo de Ciclo "
ERR002="Maquinas a Utilizar "
##########################################################################################
#
if [ "$ORACLE_SID" = "" ];then printf "\nBase de Datos Utilizada   ==> %s\n\n"  $TWO_TASK;fi;
if [ "$TWO_TASK" = "" ];then printf "\nBase de Datos Utilizada   ==> %s\n\n"  $ORACLE_SID;fi;
#
###########################################################################################
#
CODCICLFACT=$1
INSTANCIAS=$2

if [ "$CODCICLFACT" = "" ];then Glosa_Err "$ERR001"; exit 1; fi
if [ "$INSTANCIAS" = "" ];then Glosa_Err "$ERR002"; exit 1; fi

nombre_salida=balanceoclientes_${CODCICLFACT}
#
###########################################################################################
#
echo "Creando Directorio de LOG en xpfactur"
#
DIR_BASE=${XPF_LOG}/BalanceoClientes
DIR_LOG=${DIR_BASE}/${CODCICLFACT}

if [ ! -d ${DIR_BASE} ]
then
   mkdir ${DIR_BASE}
   ret=$?
   if [ $? != 0 ]
   then
       echo "ERROR EN LA CREACION DE DIRECTORIO BASE "${DIR_BASE}
       exit $ret
   fi
fi

if [ ! -d ${DIR_LOG} ]
then
   mkdir ${DIR_LOG}
   ret=$?
   if [ $? != 0 ]
   then
       echo "ERROR EN LA CREACION DE DIRECTORIO DE LOG "${DIR_LOG}
       exit $ret
   fi
fi

#
###########################################################################################
#
print $(date) "  ==>  Inicio del Proceso de Generacion de Archivos......" > ${DIR_LOG}/${nombre_salida}.log
###########################################################################################
#
echo "Generando Archivo LOG" ${DIR_LOG}/${nombre_salida}".log"
sqlplus -s / @${XPF_SQL}/Balanceo_Clientes.sql ${CODCICLFACT} ${INSTANCIAS}  >> ${DIR_LOG}/${nombre_salida}.log 2>&1
#
###########################################################################################
#
print $(date) "  ==>  Termino del Proceso de Generacion de Archivos......" >> ${DIR_LOG}/${nombre_salida}.log
#
###########################################################################################

