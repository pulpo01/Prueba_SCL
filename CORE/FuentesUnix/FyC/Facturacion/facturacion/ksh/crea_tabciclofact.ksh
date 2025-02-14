#===========================================================================#
# Script: crea_tabciclofact.ksh						    #
#									    #
#  Crea Tablas del Proceso de Facturacion de Ciclo:                         #
#   FA_FACTDOCU_CICLO   Facturas                                            #
#   FA_FACTCLIE_CICLO   Datos de Clietes Facturados                         #
#   FA_FACTABON_CICLO   Datos de Abonados Facturados                        #
#   FA_FACTCONC_CICLO   Conceptos Facturados                                #
#                                                                           #
# Periodicidad: Debe ejecutarse al Inicio de cada facturacion de ciclo.	    #
# Autor: Mauricio Vi|llagra Villalobos.                                     #
#---------------------------------------------------------------------------#
# Version 1 - Revision 00                                                   #
# Jueves  04 de Octubre de 1999.                                            #
#---------------------------------------------------------------------------#
# Version 1 - Revision 01                                                   #
# 27-09-2005. PGG SOPORTE	                                            #
#                                                                           #
# Se obtienen los datos referentes a la maquina, path, etc. desde el archivo#
# de configuracion ubicado en $XPF_KSH/configura.txt			    #
#                                                                           #
# La data que contiene esta compuesta de la sgte. forma:		    #
# <variable>=<valor>							    #
# Ejemplo:                                                                  #
# 									    #
# 									    #
#	RCMD=remsh							    #
#	RMACH="$(uname -n)"                                                 #
#	RPARAM="-n -l xpfactur"                                             #
#	RPATH=/produccion/explotacion/xpfactur/facturacion/bin/crea_ciclo/  #
#	SPATH_PASOHIST=$HOME/facturacion/bin/paso_hist/                     #
#	TPATH_PASOHIST_LLAMCICLO=$HOME/facturacion/bin/crea_fadet/          #
# 									    #
# 									    #
#---------------------------------------------------------------------------#
# Hard information                                                          #
#---------------------------------------------------------------------------#
VER=1
REV=00
GLOSA_PROG="CREACION DE TABLAS PARA FACTURACION DE CICLO"
SHELL_REMOTE=crea_cic.sh
#---------------------------------------------------------------------------#
# Defines & Macros                                                          #
#---------------------------------------------------------------------------#

RCMD=$(awk '/RCMD/  {print substr($0, (length("RCMD")+2)  , ((length($0)) - (length("RCMD")   + 1)))}' $XPF_KSH/configura.txt)		# PGG SOPORTE 27-09-2005 XO-200508100330
RMACH=$(awk '/RMACH/ {print substr($0, (length("RMACH")+2) , ((length($0)) - (length("RMACH")  + 1)))}' $XPF_KSH/configura.txt)  	# PGG SOPORTE 27-09-2005 XO-200508100330
RPARAM=$(awk '/RPARAM/{print substr($0, (length("RPARAM")+2), ((length($0)) - (length("RPARAM") + 1)))}' $XPF_KSH/configura.txt) 	# PGG SOPORTE 27-09-2005 XO-200508100330
RPATH=$(awk '/RPATH/ {print substr($0, (length("RPATH")+2) , ((length($0)) - (length("RPATH")  + 1)))}' $XPF_KSH/configura.txt) 	# PGG SOPORTE 27-09-2005 XO-200508100330


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
CICLFACT=${1:?Cod_CiclFact}

#---------------------------------------------------------------------------#
# Create Command                                                            #
#---------------------------------------------------------------------------#

RCMD_SHELL="${RCMD} ${RMACH} ${RPARAM} ${RPATH}${SHELL_REMOTE} ${CICLFACT}"

#---------------------------------------------------------------------------#
# Header                                                                    #
#---------------------------------------------------------------------------#
print
print "======================================================================"
print "PROCESO     : " ${GLOSA_PROG}
print "CICLOFACT   : " ${CICLFACT}
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
