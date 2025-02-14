#=============================================================================#
# Script: forfac.ksh											  						    	   #
#									    																#
# Plataforma de ejecucion del proceso "forfac" (para liquidacion de trafico   #
# carrier).                                                                 	# 
#                                                                             #
# Autor: William Sepulveda V.                                               	#
#-----------------------------------------------------------------------------#
# Version 1 - Revision 00                                                   	#
# Jueves 16 de marzo de 1999.                                               	#
#=============================================================================#


#---------------------------------------------------------------------------#
# Hard information                                                          #
#---------------------------------------------------------------------------#
VER=1
REV=00
GLOSA_PROG="LIQUIDACION DE TRAFICO CARRIER (FORFAC)"
USERID=/
BASE_CARRIER=carrier
BASE_FORFAC=${BASE_CARRIER}/forfac
UNIX_HP=HP-UX

#---------------------------------------------------------------------------#
# Error's Code                                                              #
#---------------------------------------------------------------------------#
RET_OK=0
INVOC_ERR=1
MKDIR_LOGDIR_FAILURE=2
EXE_FORFAC_FAILURE=3



#---------------------------------------------------------------------------#
# Defines & Macros                                                          #
#---------------------------------------------------------------------------#
CREATEDIR="mkdir -p"
SQLPLUS="sqlplus -s"

REPRO_OPT=REPROCESO
NORM_OPT=NORMAL
OPT_R=""
PROG_INVOC="$(basename $0)""  <ind_orden> [${REPRO_OPT}]"
FLAG_PROC="${NORM_OPT}"


#---------------------------------------------------------------------------#
# SQL Scripts & Executable Progs                                            #
#---------------------------------------------------------------------------#
EXE_FORFAC=forfac_2000

#---------------------------------------------------------------------------#
# Environment                                                               #
#---------------------------------------------------------------------------#
EXE=${XPF_EXE}
SQL=${XPF_SQL}
KSH=${XPF_KSH}  
CTL=${XPF_CTL}
export LOG=${XPF_LOG}/${BASE_FORFAC}


#---------------------------------------------------------------------------#
# Machine detection                                                         #
#---------------------------------------------------------------------------#
MACHINE="$(uname -n)"

#---------------------------------------------------------------------------#
# Date and time of process                                                  #
#---------------------------------------------------------------------------#
FECHA="$(date +'%d%b%Y')"_"$(date +'%H%M%S')"


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
	print -u2 "Uso es: " "${PROG_INVOC}"
	print -u2
	exit ${INVOC_ERR}
}


#---------------------------------------------------------------------------#
# Language's definition for date messages                                   #
#---------------------------------------------------------------------------#
[ "$(uname)" = "${UNIX_HP}" ] &&
{
	export LC_TIME=es_ES.iso88591
}

#---------------------------------------------------------------------------#
# Evaluation of external arguments                                          #
#---------------------------------------------------------------------------#
print -u2 Evaluando argumentos recibidos ...
[ $# -eq 0 -o $# -gt 2 ] &&
{
	OutErr Numero de argumentos [$#] no es admisible.
}
[ $# -eq 1 ] &&
{
	[[ $1 = +([0-9]) ]] || 
	{ 
		[ "$1" = "${REPRO_OPT}" ] &&
		{
			OutErr Debe indicar el ind_orden que desea reprocesar.
		} ||
		{
			OutErr Valor no numerico o fuera de rango [$1].
		}
	}
	IND_ORDEN=$1
}
[ $# -eq 2 ] &&
{
	[[ $1 = +([0-9]) ]] || 
	{ 
		[ "$1" = "${REPRO_OPT}" ] &&
		{
			[[ $2 = +([0-9]) ]] ||
			{
				OutErr Valor no numerico o fuera de rango [$2].
			}	
			FLAG_PROC="${REPRO_OPT}"
			IND_ORDEN=$2
			OPT_R="-r"
		}||
		{
			OutErr Valor no numerico o fuera de rango [$1].
		}
	}
	[ "${FLAG_PROC}" = "${NORM_OPT}" ] &&
	{
		[ "$2" = "${REPRO_OPT}" ] &&
		{
			IND_ORDEN=$1
			FLAG_PROC="${REPRO_OPT}"
			OPT_R="-r"
		}||
		{
			OutErr No se admiten 2 argumentos, a menos que uno de ellos sea la opcion de reproceso.
		}
	}	
}

	

#---------------------------------------------------------------------------#
# Output Environment Creation                                               #
#---------------------------------------------------------------------------#
MONTH="$(date +'%B')"
LOGDIR=${LOG}/${MONTH}
${CREATEDIR} ${LOGDIR}
[ $? -ne 0 ] &&
{
	LOGTEMP=${LOG}/forfac_"${FECHA}".log
	print [mkdir]: No fue posible crear directorio ${LOGDIR}. Se cancela. > ${LOGTEMP}
	exit ${MKDIR_LOGDIR_FAILURE}
}

#---------------------------------------------------------------------------#
# File Names                                                                #
#---------------------------------------------------------------------------#
FILE_LOG=${LOGDIR}/forfac_${IND_ORDEN}_"${FECHA}".log

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
PrintLog Argumentos de invocacion para FORFAC:
print "Numero de ind_orden: " ${IND_ORDEN}
print "Modo de Ejecucion  : " ${FLAG_PROC}

PrintLog Ejecutando proceso "${EXE_FORFAC}" ...
) | tee ${FILE_LOG}

${EXE}/${EXE_FORFAC} -i${IND_ORDEN} ${OPT_R} 2>> ${FILE_LOG}

(
RET=$?
[ ${RET} -ne 0 ] &&
{
   PrintLog Proceso ${EXE_FORFAC} termino con problemas.
   print "Valor de retorno:" ${RET}
   print Se cancela ejecucion de "$(basename $0)".
   exit ${EXE_FORFAC_FAILURE}
}

PrintLog Proceso Finalizado OK.
) | tee -a ${FILE_LOG}