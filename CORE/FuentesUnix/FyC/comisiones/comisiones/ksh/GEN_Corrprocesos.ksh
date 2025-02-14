#!/bin/ksh
#=============================================================================
# Script: GEN_Corrprocesos.ksh							
# Script que ejecuta proceso de Correlaciones 
#                                         
# Autor: Richard Troncoso C.				
#-----------------------------------------------------------------------------
# Version 1 - Revision 00             
# Miercoles, 19 de Diciembre del 2001      
#=============================================================================


#---------------------------------------------------------------------------#
# Hard information                                                          #
#---------------------------------------------------------------------------#
VER=1
REV=00
GLOSA_PROG="            CORRELACION DE PROCESOS    "
USERID=/

UNIX_HP=HP-UX
EXT_FILE=.txt

#---------------------------------------------------------------------------#
# Error's Code                                                              #
#---------------------------------------------------------------------------#
RET_OK=0
INVOC_ERR=1
FILE_NOTFOUND=2
EXE_ERR=3
KSH_GENHAB_ERR=4

#---------------------------------------------------------------------------#
# Defines & Macros                                                          #
#---------------------------------------------------------------------------#
CREATEDIR="mkdir -p"
CD="cd"
MV="mv"
LS="ls -l"
REMOVE="rm -fr"
SQLPLUS="sqlplus -s"

PROG_INVOC="$(basename $0)""  IdPeriodo  LineaProceso ReversaSeleccion"


#---------------------------------------------------------------------------#
# SQL Scripts & Executable Progs & Config Files                             #
#---------------------------------------------------------------------------#
NOM_EXE=Comisiones
#---------------------------------------------------------------------------#
# Environment                                                               #
#---------------------------------------------------------------------------#
SQL=${XPCM_SQL}
EXE=${XPCM_EXE}
KSH=${XPCM_KSH}
CTL=${XPCM_CTL}  
LOG=${XPCM_LOG}
DAT=${XPCM_DAT}
TMP=${XPCM_TMP}

#---------------------------------------------------------------------------#
# Machine detection                                                         #
#---------------------------------------------------------------------------#
MACHINE="$(uname -n)"
#---------------------------------------------------------------------------#
# Language's definition for date messages                                   #
#---------------------------------------------------------------------------#
[ "$(uname)" = "${UNIX_HP}" ] &&
{
	export LC_TIME=es_ES.iso88591
}
#---------------------------------------------------------------------------#
# Date and time of process                                                  #
#---------------------------------------------------------------------------#
FECHA="$(date +'%d%b%Y')"_"$(date +'%H%M%S')"
TESTIGO=${DAT}/testigo.tmp

#---------------------------------------------------------------------------#
# Environment Functions                                                     #
#---------------------------------------------------------------------------#
PrintLog()
{
   print "\n$(date +'[%d-%m-%Y][%H:%M:%S]') $@"
}

OutErr()
{
	print -u2 "$@"
	print -u2 "Se cancela.\n"
	print -u2 "Uso: " "${PROG_INVOC}"
	print -u2
	exit ${INVOC_ERR}
}

PrintSep()
{
	print
	print "************************************************************************************************"
}


#---------------------------------------------------------------------------#
# Evaluation of external arguments                                          #
#---------------------------------------------------------------------------#
print Evaluando argumentos recibidos ...
[ $# -ne 3 ] &&
{
	OutErr Numero de argumentos [$#] no es admisible.
}

FEC_PERIODO=$1
LINEA_PROCESO=$2
REVERSA_SELECCION=$3

FILE_LOG=${LOG}/KSH/GEN_Corrprocesos_ksh_"${FECHA}".log
(
#---------------------------------------------------------------------------#
# Header                                                                    #
#---------------------------------------------------------------------------#
print
print "======================================================================"
print "PROCESO     : " "$(basename $0)"
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
PrintLog Argumentos de invocacion:
print "Periodo          : " ${FEC_PERIODO}
print "Linea Proceso    : " ${LINEA_PROCESO}
print "Reversa Seleccion: " ${REVERSA_SELECCION}  " (Solo considerado para Lineas de Reproceso)"

	PrintLog Ejecutando Correlacion de Procesos "[""${NOM_EXE}""]" ...
	PrintSep
# --------------------------------------------------------------------
# Ejecuta el ProC
# --------------------------------------------------------------------
	${EXE}/${NOM_EXE} -u${USERID} -i${FEC_PERIODO} -l${LINEA_PROCESO} -f${REVERSA_SELECCION}
	RET=$?
	[ ${RET} -ne 0 ] &&
	{
   	   print Proceso ${NOM_EXE} termino con problemas.
   	   print "Valor de retorno:" ${RET}
   	   print Se cancela ejecucion de "$(basename $0)".
			echo ${RET} > ${TESTIGO}
   	   exit ${EXE_ERR}
	}
	PrintSep
	
	PrintLog Script "[""$(basename $0)""]" Finalizado OK.
	echo ${RET} > ${TESTIGO}
	exit ${RET_OK}

) | tee -a ${FILE_LOG}




#******************************************************************************************
#** Información de Versionado *************************************************************
#******************************************************************************************
#** Pieza                                               : 
#**  %ARCHIVE%
#** Identificador en PVCS                               : 
#**  %PID%
#** Producto                                            : 
#**  %PP%
#** Revisión                                            : 
#**  %PR%
#** Autor de la Revisión                                :          
#**  %AUTHOR%
#** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : 
#**  %PS%
#** Fecha de Creación de la Revisión                    : 
#**  %DATE% 
#** Worksets ******************************************************************************
#** %PIRW%
#** Historia ******************************************************************************
#** %PL%
#******************************************************************************************

