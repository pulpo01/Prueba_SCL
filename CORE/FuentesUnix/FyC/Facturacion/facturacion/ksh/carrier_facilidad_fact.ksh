set -x
################################################################################
#
#
################################################################################
ciclo=${1:?Cod_CiclFact}
# Definicion de simbolos
#
# define archivo de salida
    dir_log=${XPF_LOG}/carrier/${ciclo}
    dir_dat=${XPF_DAT}/carrier/${ciclo}
    mkdir -p ${dir_log}
    mkdir -p ${dir_dat}

	fecejecu=$(date "+%y%m%d_%H%M")
	archivo=${dir_log}/facturacion_${fecejecu}.log;
	echo 'INFORME DE FACTURAS DE CONCEPTOS CARRIER ' > ${archivo};
#
## Genera resumen de facturas con conceptos carrier por ciclo de facturacion
#
	echo "Analizando Facturas con Conceptos Carrier ..."; 
	sqlplus -s / @${XPF_SQL}/carrier_facilidad_fact ${ciclo} ${dir_dat}/facturacion_${ciclo}_${fecejecu}.tmp >>  ${archivo} ;
	awk 'NR > 2 {print $0}' ${dir_dat}/facturacion_${ciclo}_${fecejecu}.tmp > ${dir_dat}/facturacion_${ciclo}_${fecejecu}.dat
	rm -f ${dir_dat}/facturacion_${ciclo}_${fecejecu}.tmp
#
# Fin de Proceso
#

