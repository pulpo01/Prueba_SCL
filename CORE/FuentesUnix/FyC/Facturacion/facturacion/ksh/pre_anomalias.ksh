#===========================================================================#
# Script: pre_anomalias.ksh						    #
#									    #
# Script destinado a detectar y marcar errores a nivel de tablas de         #
# interfaz con anterioridad a la facturacion de ciclo. Invoca al script de  # 
# pre_ciclo y tiene por objetivo permitir la reduccion de anomalias al      #
# minimo antes de facturar el ciclo.					    #
#									    #
# Periodicidad: Debe ejecutarse antes de cada facturacion de ciclo.	    #
# Puede hacerse varias veces.						    #
# Autor: William Sepulveda V.                                               #
#---------------------------------------------------------------------------#
# Version 1 - Revision 00                                                   #
# Miercoles 19 de mayo de 1999.                                             #
#===========================================================================#
# SAAM-20030502 Se omite todo lo asociado a respaldos remotos               #
#===========================================================================#


#---------------------------------------------------------------------------#
# Hard information                                                          #
#---------------------------------------------------------------------------#
VER=1
REV=00
GLOSA_PROG="PRE-ANOMALIAS"
USERID=/
BASE_PREFAC=prefac

#---------------------------------------------------------------------------#
# Defines & Macros                                                          #
#---------------------------------------------------------------------------#
RCMD=remsh 
CREATEDIR="mkdir -p"
RM="rm -fr"
SQLPLUS="sqlplus -s"
#SQLLOAD="sqlload"
SQLLOAD="sqlldr"

#---------------------------------------------------------------------------#
# Traza define's                                                            #
#---------------------------------------------------------------------------#
COD_PROCESO=1000
STAT_INI=1
STAT_FAIL=2
STAT_OK=3
OBS_INI="Proceso de anomalias en ejecucion"
OBS_FAIL="Proceso de anomalias terminado anormalmente"
OBS_OK="Proceso de anomalias finalizado normalmente"

#---------------------------------------------------------------------------#
# SQL Scripts & Executable Progs & Shell Scripts                            # 
#---------------------------------------------------------------------------#
KSH_PRECICLO=pre_ciclo.ksh
SQL_INSPECT_TRAZA=inspect_traza
SQL_CLEAN_TRAZA=clean_traza

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
FILE_LOG_PREANOM=${LOG}/${CICLFACT}/pre_anomalias_${CICLFACT}.log
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
status="$(${SQLPLUS} ${USERID} @${SQL}/${SQL_INSPECT_TRAZA} ${CICLFACT} ${COD_PROCESO})"
[ "${status}" = "" ] && 
{ 
  status=0
}
[ ${status} -eq ${STAT_INI} ] &&
{
   print La tabla de trazas indica que existe otro proceso de pre-anomalias en curso.
   print Esta ejecucion se cancela.
   print 
   exit 1
}


PrintLog Insertando informacion en tabla de trazas de facturacion ...
FEC_INI="$(date +'%Y%m%d%H%M%S')"
${SQLPLUS} ${USERID} @${SQL}/${SQL_CLEAN_TRAZA} ${CICLFACT} ${COD_PROCESO}
print "${CICLFACT}|${COD_PROCESO}|${STAT_INI}|${FEC_INI}||${OBS_INI}||||" > ${FILE_DAT_TRAZA}
${SQLLOAD} ${USERID} control=${FILE_CTL_TRAZA}, log=${FILE_LOG_TRAZA}, data=${FILE_DAT_TRAZA}  > /dev/null

PrintLog Ejecutando proceso de pre_ciclo ...
${KSH}/${KSH_PRECICLO} ${CICLFACT} > /dev/null 
RET=$? 
print "Proceso de pre_ciclo retorna: " ${RET}
[ ${RET} -ne 0 ] &&
{
   print
   print Proceso pre_ciclo termino con problemas.
   print "Valor de retorno:" ${RET}
   print Se cancela ejecucion del script pre_anomalias.ksh.
   PrintLog Actualizando informacion en tabla de trazas de facturacion ...
   ${SQLPLUS} ${USERID} @${SQL}/${SQL_CLEAN_TRAZA} ${CICLFACT} ${COD_PROCESO}
   FEC_FIN="$(date +'%Y%m%d%H%M%S')"
   printf "${CICLFACT}|${COD_PROCESO}|${STAT_FAIL}|${FEC_INI}|${FEC_FIN}|${OBS_FAIL}||||" > ${FILE_DAT_TRAZA}
   ${SQLLOAD} ${USERID} control=${FILE_CTL_TRAZA}, log=${FILE_LOG_TRAZA}, data=${FILE_DAT_TRAZA} > /dev/null
   exit 1
}

PrintLog Actualizando informacion en tabla de trazas de facturacion ...
${SQLPLUS} ${USERID} @${SQL}/${SQL_CLEAN_TRAZA} ${CICLFACT} ${COD_PROCESO}
FEC_FIN="$(date +'%Y%m%d%H%M%S')"
printf "${CICLFACT}|${COD_PROCESO}|${STAT_OK}|${FEC_INI}|${FEC_FIN}|${OBS_OK}||||" > ${FILE_DAT_TRAZA}
${SQLLOAD} ${USERID} control=${FILE_CTL_TRAZA}, log=${FILE_LOG_TRAZA}, data=${FILE_DAT_TRAZA} > /dev/null

${RM} ${FILE_DAT_TRAZA} ${FILE_LOG_TRAZA}

PrintLog Proceso Finalizado OK.
) | tee ${FILE_LOG_PREANOM} 
