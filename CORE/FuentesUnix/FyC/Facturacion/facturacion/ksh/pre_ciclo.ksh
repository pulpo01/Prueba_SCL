#===========================================================================#
# Script: pre_ciclo.ksh														#
#									    									#
# Script destinado a detectar y marcar errores a nivel de tablas de         #
# interfaz con anterioridad a la facturacion de ciclo. Es invocado por      # 
# el script de prefacturacion y tambien es autoinvocado.                    #
#									    									#
# Periodicidad: Debe ejecutarse antes de cada facturacion de ciclo.	    	#
# Autor: William Sepulveda V.                                               #
#---------------------------------------------------------------------------#
# Version 1 - Revision 00                                                  	#
# Jueves 11 de marzo de 1999.                                              	#
#---------------------------------------------------------------------------#
# Version 2 - Revision 00                                                  	#
# Jueves 22 de abril de 1999.                                               #
#									    									#
# - Cambios en el proceso intarcel y en generacion de archivo de anomalias  #
#---------------------------------------------------------------------------#
# Version 2 - Revision 10                                                   #
# Viernes 23 de abril de 1999.                                              #
#									    									#
# - Cambios en los scripts SQL y en la shell, para que se actualicen en la  #
#   la tabla FA_CICLOCLI los abonados con errores con distinto num_proceso  #
#   respecto de los abonados del mismo cliente, que estan sin errores       #
# - Cambios en intarcel, en el mismo sentido				    			#
#---------------------------------------------------------------------------#
# Version 3 - Revision 00													#
# Viernes 30 de abril de 1999.						    					#
#									    									#
# - Se definen nuevas anomalias y se realiza organizacion de rangos de      #
#   anomalias por producto y por procedencia.				    			#
# - La deteccion de nulos en GA_INFACCEL/GA_INFACBEEP pasa a formar parte   #
#   del programa de identificacion de anomalias en tablas de interfaz       #
#   ("intarcel").  							    							#
# - Debido a ello, desaparace la ejecucion de algunos scripts SQL.          #
#---------------------------------------------------------------------------#
# Version 3 - Revision 10						    						#
# Miercoles 05 de mayo de 1999.						    					#
#									    									#
# - Se corrige el problema de copiado remoto de logs a maquina startel2.    #
# - Ahora se marcan todos los abonados en FA_CICLOCLI con num_proceso=0,    #
#   cuando comienza el pre_ciclo, dado que las bajas se detectan mas        #
#   adelante.								    							#
# - Se modifica el programa intarcel para que marque tambien a los abonados #
#   dados de alta con posterioridad a la fecha de termino del periodo.      #
#---------------------------------------------------------------------------#
# Version 3 - Revision 20						    						#
# Lunes 17 de mayo de 1999.    						    					#
#									    									#
# - Se agrega validacion de fecha de proceso versus fecha de corte superior #
#   del ciclo, a fin de que la posibilidad de ejecucion del script sea      #
#   condicionada por esa comparacion de fechas.				    			#
# - Se agrega marcacion de mascara en tabla FA_CICLOCLI, para caracterizar  #
#   a los abonados que deberian ser facturados en el periodo en cuestion.   #
#---------------------------------------------------------------------------#
# Version 4 - Revision 00						    						#
# Martes 18 de mayo de 1999.   						    					#
#									    									#
# - Pierde algunas funcionalidades tales como: Insercion en FA_RANGO_TABLA, #
#   actualizacion del indicativo de mascara, etc.			    			#
# - Se ha mantenido la historia casi por una cuestion nostalgica. 	    	#
#---------------------------------------------------------------------------#
# Version 4 - Revision 10						    						#
# Miercoles 16 de junio de 1999.					    					#
#																			#
# - Se incorpora programa "check_empresas", destinado a detectar anomalias e#
#   inconsistencias en el nivel de los clientes empresa.					#
#---------------------------------------------------------------------------#
# Version 4 - Revision 20						    						#
# Miercoles 23 de junio de 1999.					    					#
#																			#
# - set tabstop=3.															#
# - Se incorpora programa "check_supertel", destinado a detectar anomalias e#
#   inconsistencias en el nivel de los abonados de tipo supertelefono.		#
# - Cambios posicionales de directorios "dat" y "log", representados por las #
#   nuevas variables de ambiente "XPF_DAT" y "XPF_LOG", que reemplazaron a   #
#   a las antiguas "XPFACTUR_DAT" y "XPFACTUR_LOG", respectivamente.         #
#----------------------------------------------------------------------------#
# Version 4 - Revision 30                                                    #
# Martes 27 de julio de 1999.                                                #
#                                                                            #
# - El programa "intarcel" es reemplazado por "check_interfaz", el cual tiene #
#   varias mejoras y particularmente, contempla el nuevo tratamiento de los   #
#   abonados de baja.                                                         #
#=============================================================================#


#---------------------------------------------------------------------------#
# Hard information                                                          #
#---------------------------------------------------------------------------#
VER=4
REV=30
GLOSA_PROG="DETECCION DE ANOMALIAS PREVIAS A FACTURACION DE CICLO"
USERID=/
BASE_PREFAC=prefac

#---------------------------------------------------------------------------#
# Defines & Macros                                                          #
#---------------------------------------------------------------------------#
EXIT_0=0
EXIT_1=1
EXIT_2=2
EXIT_3=3
ANOM20=-20
ANOM50=-50
RESTO=-77
RCMD=remsh
CREATEDIR="mkdir -p"
SQLPLUS="sqlplus -s"

#---------------------------------------------------------------------------#
# SQL Scripts & Executable Progs                                            # 
#---------------------------------------------------------------------------#
SQL_CLEAN=limpia_ciclocli
SQL_CICLFACT=fa_ciclfact
SQL_DUPINFACCEL=dupli_infaccel
SQL_DUPINFACBEEP=dupli_infacbeep
SQL_MARKCICLOCLI=marca_ciclocli
SQL_MARKRESTOABO=marca_restoabo
EXE_CHECK_INTERFAZ=check_interfaz
EXE_CHECK_EMPRESAS=check_empresas
EXE_CHECK_SUPERTEL=check_supertel

#---------------------------------------------------------------------------#
# Environment                                                               #
#---------------------------------------------------------------------------#
EXE=${XPF_EXE}
SQL=${XPF_SQL}
KSH=${XPF_KSH}  
CTL=${XPF_CTL}
export DAT=${XPF_DAT}/${BASE_PREFAC}
export LOG=${XPF_LOG}/${BASE_PREFAC}


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
FILE_ANOM=${DAT}/${CICLFACT}/anomalias_${CICLFACT}.dat
cat /dev/null > ${FILE_ANOM}
FILE_LOG_CHECKINT=${LOG}/${CICLFACT}/check_int_${CICLFACT}.log
FILE_LOG_CHECKEMP=${LOG}/${CICLFACT}/check_emp_${CICLFACT}.log
FILE_LOG_CHECKSTB=${LOG}/${CICLFACT}/check_stb_${CICLFACT}.log
FILE_LOG_PRECIC=${LOG}/${CICLFACT}/pre_ciclo_${CICLFACT}.log
FILE_CTL_PRECIC=${CTL}/pre_ciclo_${CICLFACT}.ctl
cat /dev/null > ${FILE_CTL_PRECIC}

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
PrintLog Busqueda de  informacion en tabla FA_CICLFACT ...
${SQLPLUS} ${USERID} @${SQL}/${SQL_CICLFACT} ${CICLFACT} | read CICLO FEC_HASTA_CICLO IND_FACTUR
[ "${CICLO}" = "" ] &&
{
   print "\n"Ciclo ${CICLFACT} no es valido. Se cancela.
   print ${EXIT_1} > ${FILE_CTL_PRECIC}
   exit 1
}
print "Ciclo de Facturacion             : " ${CICLO}
print "Periodo de Facturacion           : " ${CICLFACT}
print "Fecha de Corte superior del ciclo: " ${FEC_HASTA_CICLO}


[ ${IND_FACTUR} -ne 0 ] &&
{
   print "\n"Ciclo ${CICLFACT} ya ha sido facturado. Se cancela.
   print ${EXIT_2} > ${FILE_CTL_PRECIC}
   exit 2
}

print ${EXIT_0} > ${FILE_CTL_PRECIC}

PrintLog Limpieza de num_proceso y de indicativo de mascara en tabla FA_CICLOCLI ...
num_up="$(${SQLPLUS} ${USERID} @${SQL}/${SQL_CLEAN} ${CICLO} | grep -v complete | awk '{print $1}')"
print Cantidad de abonados actualizados: ${num_up}

PrintLog Deteccion y marcacion de registros duplicados en tabla GA_INFACCEL ...
${SQLPLUS} ${USERID} @${SQL}/${SQL_DUPINFACCEL} ${CICLFACT} | awk '{printf "%d %d", $1, $2}' |
while read CLIENTE ABONADO
do
   print Marcando cliente ${CLIENTE} - abonado ${ABONADO} en tabla FA_CICLOCLI
   printf "%.6d %.6d ${ANOM20}\n" ${CLIENTE} ${ABONADO} >> ${FILE_ANOM}
   ${SQLPLUS} ${USERID} @${SQL}/${SQL_MARKCICLOCLI} ${ANOM20} ${CLIENTE} ${ABONADO} ${CICLO}
   ${SQLPLUS} ${USERID} @${SQL}/${SQL_MARKRESTOABO} ${RESTO} ${CLIENTE} ${CICLO} ${FEC_HASTA_CICLO} 
done

PrintLog Deteccion y marcacion de registros duplicados en tabla GA_INFACBEEP ...
${SQLPLUS} ${USERID} @${SQL}/${SQL_DUPINFACBEEP} ${CICLFACT} | awk '{printf "%d %d", $1, $2}' |
while read CLIENTE ABONADO
do
   print Marcando cliente ${CLIENTE} - abonado ${ABONADO} en tabla FA_CICLOCLI
   printf "%.6d %.6d ${ANOM50}\n" ${CLIENTE} ${ABONADO} >> ${FILE_ANOM}
   ${SQLPLUS} ${USERID} @${SQL}/${SQL_MARKCICLOCLI} ${ANOM50} ${CLIENTE} ${ABONADO} ${CICLO}
   ${SQLPLUS} ${USERID} @${SQL}/${SQL_MARKRESTOABO} ${RESTO} ${CLIENTE} ${CICLO} ${FEC_HASTA_CICLO} 
done

PrintLog Deteccion y marcacion de anomalias en tablas de interfaz ...
${EXE}/${EXE_CHECK_INTERFAZ} -u${USERID} -c${CICLFACT} 2> ${FILE_LOG_CHECKINT}
RET=$?
[ ${RET} -ne 0 ] &&
{
   print Proceso check_interfaz termino con problemas.
   print "Valor de retorno:" ${RET}
   print Se cancela ejecucion del script pre_ciclo.ksh.
   print ${EXIT_3} > ${FILE_CTL_PRECIC}
   exit 3
}

# Inc 147989 PPV Se quita validacion para clientes empresa segun lo solicitado por la operadora.
#PrintLog Deteccion y marcacion de inconsistencias para clientes empresa ...
#${EXE}/${EXE_CHECK_EMPRESAS} -c${CICLFACT} 2> ${FILE_LOG_CHECKEMP}
#RET=$?
#[ ${RET} -ne 0 ] &&
#{
#   print Proceso check_empresas termino con problemas.
#   print "Valor de retorno:" ${RET}
#   print Se cancela ejecucion del script pre_ciclo.ksh.
#   print ${EXIT_3} > ${FILE_CTL_PRECIC}
#   exit 3
#}

PrintLog Deteccion y marcacion de inconsistencias para abonados de tipo supertelefono ...
${EXE}/${EXE_CHECK_SUPERTEL} -c${CICLFACT} 2> ${FILE_LOG_CHECKSTB}
RET=$?
[ ${RET} -ne 0 ] &&
{
   print Proceso check_supertel termino con problemas.
   print "Valor de retorno:" ${RET}
   print Se cancela ejecucion del script pre_ciclo.ksh.
   print ${EXIT_3} > ${FILE_CTL_PRECIC}
   exit 3
}

PrintLog Proceso Finalizado.
) | tee ${FILE_LOG_PRECIC}
[ -s ${FILE_CTL_PRECIC} ] &&
{
  RET="$(cat ${FILE_CTL_PRECIC})"
  exit ${RET}
}
