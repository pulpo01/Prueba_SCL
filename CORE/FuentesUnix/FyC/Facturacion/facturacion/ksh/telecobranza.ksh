#===============================================================================#
# Script: telecobranza.ksh    							#
#	    									# 
# Script destinado a ejecutar el proceso telecobranzas y generar archivos   	# 
# de bajas para Telecobranza					  		#
# Periodicidad: Cuando se solicite						#
# 		Puede hacerse varias veces.				        #
# Autor       : Manuel García G.						#
# Parametros  : Dias Morosidad Inicial                                      	#
#               Dias Morosidad Final						#
#		Monto Deuda Vencida						#
#===============================================================================#

#---------------------------------------------------------------------------#
# Version 1 - Revision 00                                                   #
# Miercoles 14 de Febrero de 2001.                                          #
#===========================================================================#

#---------------------------------------------------------------------------#
# Hard information                                                          #
#---------------------------------------------------------------------------#
VER=1
REV=00
GLOSA_PROG="TELECOBRANZA"
USERID=/
TELECOBRANZA=telecobranza

#---------------------------------------------------------------------------#
# Defines & Macros                                                          #
#---------------------------------------------------------------------------#
RCMD=remsh 
CREATEDIR="mkdir -p"
RM="rm -fr"
SQLPLUS="sqlplus -s"
SQLLOAD="sqlload"
NIVLOG=3

#---------------------------------------------------------------------------#
# SQL Scripts & Executable Progs & Shell Scripts                            # 
#---------------------------------------------------------------------------#
EXE_TELECOBRANZA=telecobranza
SQL_TELECLIENTES=telecob_clientes.sql
SQL_TELECARTERA=telecob_cartera.sql

#---------------------------------------------------------------------------#
# Environment                                                               #
#---------------------------------------------------------------------------#
KSH=${XPF_KSH}  
CTL=${XPF_CTL}
TMP=${XPF_TMP}
SQL=${XPF_SQL}
EXE=${XPF_EXE}
export DAT=${XPFACTUR_DAT}/${TELECOBRANZA}/$(date +'%Y%m%d')
export LOG=${XPFACTUR_LOG}/${TELECOBRANZA}/$(date +'%Y%m%d')

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
DIASMOROSIDADINI=${1:?Dias Morosidad Inicial}
DIASMOROSIDADFIN=${2:?Dias Morosidad Final}
DEUDAVENCIDA=${3:?Monto Deuda Vencida}

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
print "        Dias Morosidad Inicial : " ${DIASMOROSIDADINI}          
print "        Dias Morosidad Inicial : " ${DIASMOROSIDADFIN}
print "        Monto Deuda Vencida    : " ${DEUDAVENCIDA}          
print "======================================================================"

#---------------------------------------------------------------------------#
# Main                                                                      #
#---------------------------------------------------------------------------#

#---------------------------------------------------------------------------#
# Proceso de preparacion de tablas con clientes en morosidad                #
#---------------------------------------------------------------------------#

PrintLog "  ==>  Comienzo del Proceso EXE......"

${EXE}/${EXE_TELECOBRANZA} -u${USERID} -l ${NIVLOG} -d ${DIASMOROSIDADINI} -e ${DIASMOROSIDADFIN} -v ${DEUDAVENCIDA}  

RET=$? 
print "Proceso de telecobranza retorna: " ${RET}

[ ${RET} -ne 0 ] &&
{
	print
    print Proceso telecobranza termino con problemas.
    print "Valor de retorno:" ${RET}
    print Se cancela ejecucion del script telecobranza.ksh.
	print
    exit 1
}

PrintLog "  ==>  Termino del Proceso EXE......"

#---------------------------------------------------------------------------#
# Proceso de bajada de Archivos                                             #
#---------------------------------------------------------------------------#

print
PrintLog "  ==>  Comienzo del Proceso de Generacion de Archivos......"        
print

nombre_salida=TeleClientes${DIASMOROSIDADINI}${DIASMOROSIDADFIN}${DEUDAVENCIDA} 
echo "Generando Archivo " ${nombre_salida}".lst"
print

${SQLPLUS} -s / @${SQL}/${SQL_TELECLIENTES} > ${DAT}/${nombre_salida}".lst"

RET=$? 
print "SQL de telecobranza retorna: " ${RET}

[ ${RET} -ne 0 ] &&
{
	print
    print "Proceso" ${SQL_TELECLIENTES} "de telecobranza termino con problemas."
    print "Valor de retorno:" ${RET}
    print Se cancela ejecucion del script telecobranza.ksh.
    print
    exit 1
}


nombre_salida=TeleCartera${DIASMOROSIDADINI}${DIASMOROSIDADFIN}${DEUDAVENCIDA}
print
echo "Generando Archivo " ${nombre_salida}".lst"
print

${SQLPLUS} -s / @${SQL}/${SQL_TELECARTERA} > ${DAT}/${nombre_salida}".lst"

RET=$? 
print "SQL de telecobranza retorna: " ${RET}
[ ${RET} -ne 0 ] &&
{
	print
    print "Proceso" ${SQL_TELECARTERA} "de telecobranza termino con problemas."
    print "Valor de retorno:" ${RET}
    print Se cancela ejecucion del script telecobranza.ksh.
    print
    exit 1
}

print
PrintLog "  ==>  Termino del Proceso de Generacion de Archivos......"
print
PrintLog "  ==>    Proceso Finalizado OK."
print






