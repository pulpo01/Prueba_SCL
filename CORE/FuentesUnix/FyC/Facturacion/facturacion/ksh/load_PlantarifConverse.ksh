#===========================================================================#
# Script: load_PlantarifConverse.ksh                                               #
#===========================================================================#

#---------------------------------------------------------------------------#
# Hard information                                                          #
#---------------------------------------------------------------------------#
VER=1
REV=1
GLOSA_PROG="PROCESO DE CARGA DE PLANES TARIFARIOS DE CONVERSE"
USERID=/

#---------------------------------------------------------------------------#
# Defines & Macros                                                          #
#---------------------------------------------------------------------------#
RCMD=remsh 
CREATEDIR="mkdir -p"
RM="rm -fr"
SQLPLUS="sqlplus -s"
SQLLOAD="sqlload"
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

#---------------------------------------------------------------------------#
# Environment                                                               #
#---------------------------------------------------------------------------#
KSH=${XPF_KSH}  
CTL=${XPF_CTL}
TMP=${XPF_TMP}
SQL=${XPF_SQL}

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
# File Names                                                                #
#---------------------------------------------------------------------------#
FILE_CTL=./loadPlantarifConverse.ctl
FILE_DAT=./loadPlantarifConverse.dat
FILE_LOG=./loadPlantarifConverse.log

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
${SQLLOAD} ${USERID} control=${FILE_CTL}, log=${FILE_LOG}, data=${FILE_DAT} > /dev/null

# ${RM} ${FILE_DAT} ${FILE_LOG}

PrintLog Proceso Finalizado OK.
) | tee ${FILE_LOG} 
[ -s ${FILE_LOG} ]

