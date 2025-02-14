#===========================================================================#
# Script: pre_facturacion.ksh                                               #
#									                                        #
# Aqui se agrupan los scripts y procesos que son necesarios para llevar a   #
# cabo la facturacion de ciclo. Entre otras cosas, contempla acciones sobre #
# tablas de entrada de la facturacion y, tambien, acciones de deteccion de  #
# errores a nivel de tablas de interfaz (invoca al script de pre-ciclo).    #
#                                                                           #
# Periodicidad: Debe ejecutarse antes de cada facturacion de ciclo.         #
# Autor: William Sepulveda V.                                               #
#---------------------------------------------------------------------------#
# Version 1 - Revision 00                                                   #
# Jueves 20 de mayo de 1999.                                                #
#---------------------------------------------------------------------------#
# Version 1 - Revision 10                                                   #
# Lunes 08 de noviembre de 1999.                                            #
#                                                                           #
# - Se elimina insercion de registros en FA_RANGO_TABLA, la cual deja de    #
#   usarse a partir de la entrada en vigencia del proyecto Facturacion      #
#   etapa 2.                                                                #
# - Se incluye nueva etapa, encargada de marcar en las tablas GA_INFACCEL y #
#   GA_INFACBEEP el indicador de cargos, a partir de los registros de la    #
#   tabla GE_CARGOS.                                                        #
#---------------------------------------------------------------------------#
# Version 1 - Revision 20                                                   #
# Jueves 18 de noviembre de 1999.                                           #
#                                                                           #
# - Se incorpora marcacion en tabla de trazas para procesamiento de carrier #
#   (FA_TRAZAFORDET).                                                       #
#---------------------------------------------------------------------------#
# Version 1 - Revision 21                                                   #
# Jueves 25 de noviembre de 1999.                                           #
#                                                                           #
# - Se modifica el orden en que se produce la actualizacion del indicativo  #
#   de cargos. Esta queda posterior a la marcacion del ind_facturacion      #
#   sobre la tabla FA_CICLFACT.                                             #
#===========================================================================#


#---------------------------------------------------------------------------#
# Hard information                                                          #
#---------------------------------------------------------------------------#
VER=1
REV=21
GLOSA_PROG="PROCESO DE PRE-FACTURACION"
USERID=/
BASE_PREFAC=prefac

#---------------------------------------------------------------------------#
# Defines & Macros                                                          #
#---------------------------------------------------------------------------#
CREATEDIR="mkdir -p"
RM="rm -fr"
SQLPLUS="sqlplus -s"
#SQLLOAD="sqlload"
SQLLOAD="sqlldr"
SYSDATE=$(date +'%Y%m%d')

#---------------------------------------------------------------------------#
# Traza define's                                                            #
#---------------------------------------------------------------------------#
COD_PROCESO=2000
COD_PROCESO_PREV=1000
STAT_INI=1
STAT_FAIL=2
STAT_OK=3
OBS_INI="Proceso de pre-facturacion en ejecucion"
OBS_FAIL="Proceso de pre-facturacion terminado anormalmente"
OBS_OK="Proceso de pre-facturacion finalizado normalmente"

#---------------------------------------------------------------------------#
# SQL Scripts & Executable Progs & Shell Scripts                            # 
#---------------------------------------------------------------------------#
KSH_PRECICLO=pre_ciclo.ksh
SQL_INSPECT_TRAZA=inspect_traza
SQL_CLEAN_TRAZA=clean_traza
SQL_MARKMASK=marca_mascara
SQL_CICLFACT=fa_ciclfact
SQL_INSERT_RANGO=insert_fa_rango_tabla
SQL_IND_FACTUR=update_fa_ciclfact
SQL_UP_CARGOS_INTERFACES=up_cargos_interfaces
SQL_UP_TRAZAFORDET=up_trazafordet

#---------------------------------------------------------------------------#
# Environment                                                               #
#---------------------------------------------------------------------------#
KSH=${XPF_KSH}  
CTL=${XPF_CTL}
TMP=${XPF_TMP}
SQL=${XPF_SQL}
DAT=${XPFACTUR_DAT}/${BASE_PREFAC}
export DAT
LOG=${XPFACTUR_LOG}/${BASE_PREFAC}
export LOG


#---------------------------------------------------------------------------#
# Machine detection                                                         #
#---------------------------------------------------------------------------#
MACHINE="$(uname -n)"

#---------------------------------------------------------------------------#
# Environment Functions                                                     #
#---------------------------------------------------------------------------#
PrintLog()
{
   print "\n$(date +'[%d-%m-%Y][%H:%M:%S]') $@"
}

#---------------------------------------------------------------------------#
# External arguments                                                        #
#---------------------------------------------------------------------------#
CICLFACT=${1:?Cod_CiclFact}

#---------------------------------------------------------------------------#
# Output Environment Creation                                               #
#---------------------------------------------------------------------------#
set -A OUT_ARR ${DAT} ${LOG}
for OUT_DIR in "${OUT_ARR[@]}"
do
   ${CREATEDIR} ${OUT_DIR}/${CICLFACT}
   [ $? -ne 0 ] &&
   {
     print [mkdir]: No fue posible crear directorio ${OUT_DIR}/${CICLFACT}. Se cancela.
     exit 1
   }
done

#---------------------------------------------------------------------------#
# File Names                                                                #
#---------------------------------------------------------------------------#
FILE_LOG_PREFAC=${LOG}/${CICLFACT}/pre_facturacion_${CICLFACT}.log
FILE_CTL_TRAZA=${CTL}/fa_trazaproc.ctl
FILE_DAT_TRAZA=${TMP}/fa_trazaproc.dat
FILE_LOG_TRAZA=${TMP}/fa_trazaproc.log

(
#---------------------------------------------------------------------------#
# Header                                                                    #
#---------------------------------------------------------------------------#
print
print "======================================================================"
print "PROCESO     : " $0
print "DESCRIPCION : " ${GLOSA_PROG} 
print "VERSION     : " ${VER}
print "REVISION    : " ${REV}
print "MAQUINA     : " ${MACHINE}
print "FECHA       : " "$(date +'%d-%B-%Y')"
print "HORA        : " "$(date +'%X')"
print "======================================================================"

#---------------------------------------------------------------------------#
# Main                                                                      #
#---------------------------------------------------------------------------#
PrintLog Revisando estado en tabla de trazas de facturacion ...
status="$(${SQLPLUS} ${USERID} @${SQL}/${SQL_INSPECT_TRAZA} ${CICLFACT} ${COD_PROCESO_PREV})"
[ "${status}" = "" ] &&
{
  status=0
}
[ ${status} -ne ${STAT_OK} ] &&
{
   print La tabla de trazas indica que el proceso precedente [anomalias] no termino correctamente.
   print Esta ejecucion se cancela.
   print 
   exit 1
}
status="$(${SQLPLUS} ${USERID} @${SQL}/${SQL_INSPECT_TRAZA} ${CICLFACT} ${COD_PROCESO})"
[ "${status}" = "" ] && 
{ 
  status=0
}
[ ${status} -eq ${STAT_INI} ] &&
{
   print La tabla de trazas indica que existe otro proceso de pre-facturacion en curso.
   print Esta ejecucion se cancela.
   print 
   exit 1
}


PrintLog Busqueda de informacion en tabla FA_CICLFACT ...
${SQLPLUS} ${USERID} @${SQL}/${SQL_CICLFACT} ${CICLFACT} | read CICLO FEC_HASTA_CICLO IND_FACTUR
[ "${CICLO}" = "" ] &&
{
   print "\n"Ciclo ${CICLFACT} no es valido. Se cancela.
   PrintLog Actualizando informacion en tabla de trazas de facturacion ...
   ${SQLPLUS} ${USERID} @${SQL}/${SQL_CLEAN_TRAZA} ${CICLFACT} ${COD_PROCESO}
   FEC_FIN="$(date +'%Y%m%d%H%M%S')"
   printf "${CICLFACT}|${COD_PROCESO}|${STAT_FAIL}|${FEC_INI}|${FEC_FIN}|${OBS_FAIL}||||" > ${FILE_DAT_TRAZA}
   ${SQLLOAD} ${USERID} control=${FILE_CTL_TRAZA}, log=${FILE_LOG_TRAZA}, data=${FILE_DAT_TRAZA} > /dev/null
   exit 1
}
print "Ciclo de Facturacion             : " ${CICLO}
print "Periodo de Facturacion           : " ${CICLFACT}
print "Fecha de Corte superior del ciclo: " ${FEC_HASTA_CICLO}

[ ${IND_FACTUR} -ne 0 ] &&
{
   print "\n"Ciclo ${CICLFACT} ya ha sido facturado. Se cancela.
   exit 1
}

PrintLog Insertando informacion en tabla de trazas de facturacion ...
FEC_INI="$(date +'%Y%m%d%H%M%S')"
${SQLPLUS} ${USERID} @${SQL}/${SQL_CLEAN_TRAZA} ${CICLFACT} ${COD_PROCESO}
printf "${CICLFACT}|${COD_PROCESO}|${STAT_INI}|${FEC_INI}||${OBS_INI}||||" > ${FILE_DAT_TRAZA}
${SQLLOAD} ${USERID} control=${FILE_CTL_TRAZA}, log=${FILE_LOG_TRAZA}, data=${FILE_DAT_TRAZA}  > /dev/null

[ ! ${SYSDATE} -gt ${FEC_HASTA_CICLO} ] &&
{
   print "\nLa fecha de proceso [${SYSDATE}] es menor que la fecha de corte superior del ciclo."
   print Se cancela.
   PrintLog Actualizando informacion en tabla de trazas de facturacion ...
   ${SQLPLUS} ${USERID} @${SQL}/${SQL_CLEAN_TRAZA} ${CICLFACT} ${COD_PROCESO}
   FEC_FIN="$(date +'%Y%m%d%H%M%S')"
   printf "${CICLFACT}|${COD_PROCESO}|${STAT_FAIL}|${FEC_INI}|${FEC_FIN}|${OBS_FAIL}||||" > ${FILE_DAT_TRAZA}
   ${SQLLOAD} ${USERID} control=${FILE_CTL_TRAZA}, log=${FILE_LOG_TRAZA}, data=${FILE_DAT_TRAZA} > /dev/null
   exit 1
}


PrintLog Ejecutando proceso de pre_ciclo ...
${KSH}/${KSH_PRECICLO} ${CICLFACT} > /dev/null 
RET=$? 
print "Proceso de pre_ciclo retorna: " ${RET}
[ ${RET} -ne 0 ] &&
{
   print
   print Proceso pre_ciclo termino con problemas.
   print "Valor de retorno:" ${RET}
   print Se cancela ejecucion del script pre_facturacion.ksh.
   PrintLog Actualizando informacion en tabla de trazas de facturacion ...
   ${SQLPLUS} ${USERID} @${SQL}/${SQL_CLEAN_TRAZA} ${CICLFACT} ${COD_PROCESO}
   FEC_FIN="$(date +'%Y%m%d%H%M%S')"
   printf "${CICLFACT}|${COD_PROCESO}|${STAT_FAIL}|${FEC_INI}|${FEC_FIN}|${OBS_FAIL}||||" > ${FILE_DAT_TRAZA}
   ${SQLLOAD} ${USERID} control=${FILE_CTL_TRAZA}, log=${FILE_LOG_TRAZA}, data=${FILE_DAT_TRAZA} > /dev/null
   exit 1
}

PrintLog Actualizacion del indice de facturacion en la tabla FA_CICLFACT ...
${SQLPLUS} ${USERID} @${SQL}/${SQL_IND_FACTUR} ${CICLFACT}

PrintLog Actualizando indicativo de cargos en interfaces ...
${SQLPLUS} ${USERID} @${SQL}/${SQL_UP_CARGOS_INTERFACES} ${CICLFACT}

PrintLog Actualizacion del estado de la traza de carrier FA_TRAZAFORDET ...
${SQLPLUS} ${USERID} @${SQL}/${SQL_UP_TRAZAFORDET} ${CICLFACT}

PrintLog Marcacion del indicativo de mascara en tabla FA_CICLOCLI ...
${SQLPLUS} ${USERID} @${SQL}/${SQL_MARKMASK} ${CICLO}

PrintLog Actualizando informacion en tabla de trazas de facturacion ...
${SQLPLUS} ${USERID} @${SQL}/${SQL_CLEAN_TRAZA} ${CICLFACT} ${COD_PROCESO}
FEC_FIN="$(date +'%Y%m%d%H%M%S')"
printf "${CICLFACT}|${COD_PROCESO}|${STAT_OK}|${FEC_INI}|${FEC_FIN}|${OBS_OK}||||" > ${FILE_DAT_TRAZA}
${SQLLOAD} ${USERID} control=${FILE_CTL_TRAZA}, log=${FILE_LOG_TRAZA}, data=${FILE_DAT_TRAZA} > /dev/null

${RM} ${FILE_DAT_TRAZA} ${FILE_LOG_TRAZA}

PrintLog Proceso Finalizado OK.
) | tee ${FILE_LOG_PREFAC} 

