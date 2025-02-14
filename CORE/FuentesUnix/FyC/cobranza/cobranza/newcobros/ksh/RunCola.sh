#######################################################################################
# Shell que ejecuta el proceso y espera que termine para validar su Valor de Retorno
# $1: ejecutable (con PATH)
# $2: nivel de log (con -l)
# $3: usuario
# $4: nobre de los archivos de LOG y de la Cola
# $RET : valor de Retorno de la ejecucion
######################################################################################
szEjecutable=$1
szNivLog=$2
szUsuario=$3
szCola=$4
iNivLog=`echo ${szNivLog}|awk '{printf"%d",substr($1,3,length($1)-2)*1}'`
szAppName=$szEjecutable
######################################################################################
# Rutina que escribe el Log
WriLog()
{
	set $@
	iNivel=$1
	shift
	if test ${iNivel} -le ${iNivLog}
	then
		printf "\n$(date +[%T]) "
		if test ${iNivel} -eq 1
		then
			printf "     Error (${szAppName}) : "
		elif test ${iNivel} -eq 2
		then
			printf "     Aviso (${szAppName}) : "
		fi
		print $@
	fi
}
#######################################################################################
# Ejecuta el ejecutable asociado a la cola
$szEjecutable $szNivLog $szUsuario $szCola
# Obtiene el valor de Retorno
RET=$?
#######################################################################################
# Si el valor de Retorno es > 0, invoca al proceso regucola 
if test $RET -gt "0"
then
	WriLog 1 "Retorno Valor ${RET}"
	WriLog 1 "Ejecuta regucola ${szCola}"
# deja la cola en estado W
	$XPC_EXE/regucola $szCola $szNivLog $szUsuario
fi
