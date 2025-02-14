#!/usr/bin/ksh
. .profile 
#-------------------------------------------------------------------------------#
# SCHEDULER (primitivo)  13/09/1999 - 23/09/1999
# Recorre la FA_INTERVENTA y para cada proceso que encuentra en estado OK 
# gatilla la composicion de la factura contado
# Estoy ejecutandola en la Maquina Startel1 desde la cuenta  xpfactur
# MODIFICACION : 19/11/1999 Se incluyen Notas de Credito.
# MODIFICACION : 01/12/1999 Se incluyen Miscelaneas (y compras comentadas).
#-------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------#
# DEFINICION DE VARIABLES  (Nota: Tomar Directorios que correspondan)
#-------------------------------------------------------------------------------#
SQLPLUS="sqlplus -s"
MAKEDIR="mkdir -p "

PREFIJO1="facturaC -u/ -contado -composicion -n"
PREFIJO18="facturaC -u/ -miscelanea -l5 -n"
#PREFIJO21="facturaC -u/ -compra -l5 -n"
PREFIJO25="facturaC -u/ -notac -l5 -n"

USERID="/"
AHORA=$(date +%H%M%S)
UBICACION=$(date +%d/%m/%Y-%H:%M:%S)

HOYDIA=$(date +%Y%m%d)
DIR_SQL="facturacion/sql"
DIR_LOG="facturacion/log/factura/no_ciclo/"${HOYDIA}
NOM_LOG="Scheduler.log"
ARCH_LOG=${DIR_LOG}"/"${NOM_LOG}

INGRESADA=1
FACTURADA=2
SIN_PROCESAR=0
PROCESANDO=1
ERROR=2
OK=3
#-------------------------------------------------------------------------------#
# DEFINICION DE FUNCIONES
#-------------------------------------------------------------------------------#
SQL_SELECT=SchedulerSelectNumProceso
SQL_UPDATE=SchedulerUpdateInterventa
#-------------------------------------------------------------------------------#
# main  ( Estoy en Startel1, con el usuario xpfactur )
#-------------------------------------------------------------------------------#
${MAKEDIR}${DIR_LOG}
print ${UBICACION}"--------" >> ${ARCH_LOG}
${SQLPLUS} ${USERID} @${DIR_SQL}/${SQL_SELECT} ${INGRESADA} ${SIN_PROCESAR} | awk '{printf "%d %d\n", $1, $2}' |
while read NUM_PROCESO TIP_DOCUM
do
#   print "[" ${NUM_PROCESO} "][" ${TIP_DOCUM} "]" >> ${ARCH_LOG} 
   COMANDO=""
   MENSAJE=""
   [ ${NUM_PROCESO} -ne 0 ] &&
   {
      [ ${TIP_DOCUM} -eq 1 ] &&
      {
        COMANDO=${PREFIJO1}${NUM_PROCESO}
        MENSAJE="COMPOSICION......["${NUM_PROCESO}"]"
      }
      
      [ ${TIP_DOCUM} -eq 18 ] &&
      {
        COMANDO=${PREFIJO18}${NUM_PROCESO}
        MENSAJE="F. MISCELANEA....["${NUM_PROCESO}"]"
      } 

#      [ ${TIP_DOCUM} -eq 21 ] &&
#      {
#        COMANDO=${PREFIJO21}${NUM_PROCESO}
#        MENSAJE="F. COMPRA........["${NUM_PROCESO}"]"
#      } 

      [ ${TIP_DOCUM} -eq 25 ] &&
      {
        COMANDO=${PREFIJO25}${NUM_PROCESO}
        MENSAJE="NOTA DE CREDITO..["${NUM_PROCESO}"]"
      } 
      
      ${SQLPLUS} ${USERID} @${DIR_SQL}/${SQL_UPDATE} ${NUM_PROCESO} ${INGRESADA} ${PROCESANDO}
      ${COMANDO}
      RETORNO=$?
      [ ${RETORNO} -ne 0 ] &&
      {
        print ${MENSAJE} "= FALLO !" >> ${ARCH_LOG}
        ${SQLPLUS} ${USERID} @${DIR_SQL}/${SQL_UPDATE} ${NUM_PROCESO} ${FACTURADA} ${ERROR}
      }||
      {
        print ${MENSAJE} "= OK !"  >> ${ARCH_LOG}
        ${SQLPLUS} ${USERID} @${DIR_SQL}/${SQL_UPDATE} ${NUM_PROCESO} ${FACTURADA} ${OK}
      }
   }
done
#-------------------------------------------------------------------------------#
# fin del main 
#-------------------------------------------------------------------------------#

