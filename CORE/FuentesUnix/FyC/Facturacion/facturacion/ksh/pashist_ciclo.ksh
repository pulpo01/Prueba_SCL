#===========================================================================#
# Script: pashist_llamciclo.ksh							                    #
#									                                        #
# Script que ejecuta proceso de paso historico de facturas de ciclo         #
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
#   - Inserta los registros de factuars en la tabla FA_HISTDOCU             #
#   - Crea tabla historica con detalle de Clientes FA_HISTCLIE_CICLO        #
#   - Crea tabla historica con detalle de Abonados FA_HISTABON_CICLO        #
#   - Crea tabla historica con detalle de Conceptos FA_HISTCONC_CICLO       #
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
GLOSA_PROG="PASO HISTORICO DE FACTURACION DE CICLO"
SHELL_REMOTE=crea_res.sh
#---------------------------------------------------------------------------#
# Defines & Macros                                                          #
#---------------------------------------------------------------------------#
RCMD=sudo 
RMACH=
RPARAM="-u explota"
RPATH=/produccion/cergte/explota/paso_hist/

#
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
