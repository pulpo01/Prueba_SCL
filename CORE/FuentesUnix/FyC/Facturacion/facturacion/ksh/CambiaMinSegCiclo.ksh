#===============================================================================#
# Script: CambiaMinSegCiclo.ksh                                                 #
#                                                                               # 
# Script destinado a cambiar la cantidad de minutos por segundos                # 
# Periodicidad: Una vez que se haya ejecutado la Tasacion                       #
# Autor       : Sebastian Acuna (20030123)                                      #
# Parametros  : Cilco de Facturacion                                            #
#===============================================================================#

#---------------------------------------------------------------------------#
# Version 1 - Revision 00                                                   #
# Jueves 23 de Enero de 2002.                                               #
#===========================================================================#

#---------------------------------------------------------------------------#
# Hard information                                                          #
#---------------------------------------------------------------------------#
VER=1
REV=00
GLOSA_PROG="CAMBIA UNIDAD DE TIEMPO"
#USERID=/
#Usuario de Desarrollo
USERID=factura/factura
CAMBIAMINSEG=CambiaMinSegCiclo

#---------------------------------------------------------------------------#
# Defines & Macros                                                          #
#---------------------------------------------------------------------------#
CREATEDIR="mkdir -p"
RM="rm -fr"
SQLPLUS="sqlplus"
NIVLOG=3

#---------------------------------------------------------------------------#
# SQL Scripts & Executable Progs & Shell Scripts                            # 
#---------------------------------------------------------------------------#
EXE_CAMBIAMINSEG=CambiaMinSegCiclo
SQL_CAMBIAMINSEG=CambiaMinSegCiclo.sql

#---------------------------------------------------------------------------#
# Environment                                                               #
#---------------------------------------------------------------------------#
KSH=${XPF_KSH}  
CTL=${XPF_CTL}
TMP=${XPF_TMP}
SQL=${XPF_SQL}
EXE=${XPF_EXE}
export DAT=${XPFACTUR_DAT}/${CAMBIAMINSEG}/$(date +'%Y%m%d')
export LOG=${XPFACTUR_LOG}/${CAMBIAMINSEG}/$(date +'%Y%m%d')

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
CICLOFACT=${1:?Falta Parametro Ciclo de Facturacion}

#---------------------------------------------------------------------------#
# Output Environment Creation                                               #
#---------------------------------------------------------------------------#

set -A OUT_ARR ${DAT} ${LOG}
for OUT_DIR in "${OUT_ARR[@]}"
do
   ${CREATEDIR} ${OUT_DIR}/
   [ $? -ne 0 ] &&
   {
     print [mkdir]: No fue posible crear directorio ${OUT_DIR}/. Se cancela.
     exit 1
   }
done

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
print "PARAMETROS  : "
print "        Clico de facturacion : " ${CICLOFACT}          
print "======================================================================"

#---------------------------------------------------------------------------#
# Main                                                                      #
#---------------------------------------------------------------------------#

#---------------------------------------------------------------------------#
# Proceso de cambio de segundos por minutos                                 #
#---------------------------------------------------------------------------#

PrintLog "  ==>  Comienzo del Proceso SQL......"
print


${SQLPLUS} -s ${USERID} @${SQL}/${CAMBIAMINSEG} ${CICLOFACT} 

RET=$? 
print "SQL de Cambio de Unidad de Tiempo retorna: " ${RET}

[ ${RET} -ne 0 ] &&
{
    print
    print "Proceso" ${SQL_CAMBIAMINSEG} "de Cambio de Unidad de Tiempo termino con problemas."
    print "Valor de retorno:" ${RET}
    print Se cancela ejecucion del script CambiaMinSegCiclo.ksh.
    print
    exit 1
}


print
PrintLog "  ==>  Termino del Proceso de Cambio de Unidad de Tiempo tabla TOL_ACUMOPER de Archivos......"
print
PrintLog "  ==>    Proceso Finalizado OK."
print






