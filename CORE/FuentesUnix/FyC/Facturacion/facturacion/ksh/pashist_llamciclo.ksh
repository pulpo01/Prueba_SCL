#===========================================================================#
# Script: pashist_llamciclo.ksh							                    #
#									                                        #
# Script que ejecuta proceso de paso historico de llamadas para el proceso  #
# de ciclo.                                                                 #
# Este proceso consiste en ejecutar una shell remota en la maquina          #
# startel3 , en donde se encuentra el motor de la base de datos, utilizando #
# el comando rmsh.                                                          #
# Esta Shell remota se ejecuta con permisos de Usuario de Sistema de Oracle #
# por lo cual el acceso a esta shell debe ser controlada via S.O.           #
# La Shell remota recibe como parametro en codigo del ciclo de facturacion  #
# y realiza las siguientes validacciones :                                  #
#   - Valida que el Indicador de Facturacion de la tabla FA_CICLFACT este   #
#     en proceso de facturacion. (IND_FACTURACION == 1)                     #
# Las operaciones que realiza son las siguientes:                           #
#   - Crea la tabla de trafico definitiva FA_DETCELULAR_CICLO con un SQL    #
#     create table as select desde la tabla PF_TARIFICADAS. Con el cual no  #
#     utiliza area de rollback con lo cual el tiempo de respuesta es menor  #
#   - Compara los registros insertados en la tabla Historica con los        #
#     registros de la tabla PF_TARIFICADAS.                                 #
#   - Si la compracion Anterior indicaque igualdad de registros entonces    #
#     trunca la tabla PF_TARIFICADAS.                                       #
#   - Crea los sinonimos, permisos necesarios  para la tabla de trafico     #
#     historica.
#                                                                           #
# Periodicidad: Debe ejecutarse al cierre de cada facturacion de ciclo.	    #
# Autor: Mauricio Vi|llagra Villalobos.                                     #
#---------------------------------------------------------------------------#
# Version 1 - Revision 00                                                   #
# Jueves 27 de Mayo de 1999.                                                #
#---------------------------------------------------------------------------#
# Hard information                                                          #
#---------------------------------------------------------------------------#
VER=1
REV=00
GLOSA_PROG="PASO HISTORICO DE LLAMADAS DE FACTURACION DE CICLO"
RMACH=arica
SHELL_REMOTE=renombra.sh
#---------------------------------------------------------------------------#
# Defines & Macros                                                          #
#---------------------------------------------------------------------------#
RCMD=ssh 
RPARAM="-n -l explota"
#RPATH=/produccion/explotacion/xpfactur/facturacion/sql/ciclo/crea_fadet/
RPATH=/usr/explota/cergte/crea_fadet/
#---------------------------------------------------------------------------#
# Environment                                                               #
#---------------------------------------------------------------------------#
EXE=${XPF_EXE}
SQL=${XPF_SQL}
KSH=${XPF_KSH}  
CTL=${XPF_CTL}


#---------------------------------------------------------------------------#
# Machine detection                                                         #
#---------------------------------------------------------------------------#
MACHINE="$(uname -n)"

#---------------------------------------------------------------------------#
# Environment Functions                                                     #
#---------------------------------------------------------------------------#
PrintLog()
{
   print "\n$(date +'[%d-%m-%Y][%H:%M:%S]') $@\n"
}

#---------------------------------------------------------------------------#
# External arguments                                                        #
#---------------------------------------------------------------------------#
#CICLFACT=${1:?Cod_CiclFact}
CICLFACT=${1}
if [ "$CICLFACT" = "" ]
then
    echo "Debe Ingresar Ciclo facturacion---"
    exit 0
fi

#---------------------------------------------------------------------------#
# Create Command                                                            #
#---------------------------------------------------------------------------#

RCMD_SHELL="${RCMD} ${RMACH} ${RPARAM} ${RPATH}${SHELL_REMOTE} ${CICLFACT}"
#RCMD_SHELL="${RPATH}${SHELL_REMOTE} ${CICLFACT}"

#---------------------------------------------------------------------------#
# Header                                                                    #
#---------------------------------------------------------------------------#
print
print "======================================================================"
print "PROCESO     : " $GLOSA_PROG
print "VERSION     : " ${VER}
print "REVISION    : " ${REV}
print "MAQUINA     : " ${MACHINE}
print "FECHA       : " "$(date +'%d-%B-%Y')"
print "HORA        : " "$(date +'%X')"
print "======================================================================"

#---------------------------------------------------------------------------#
# Main                                                                      #
#---------------------------------------------------------------------------#
PrintLog Ejecutando shell remota de Paso a Historico de LLamadas...

#
PrintLog ${RCMD_SHELL}
#
${RCMD_SHELL}
#
if [ "$?" = "0" ]
then
    PrintLog Comando Remoto Ejecutado Correctamente ...
    exit 0
else
    PrintLog Comando Remoto Ejecutado Con Errores ...
    exit 1
fi
