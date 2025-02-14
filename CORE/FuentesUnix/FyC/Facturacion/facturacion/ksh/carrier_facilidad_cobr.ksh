set -x
################################################################################
#
#
################################################################################

mflag=${1:?Mes_Proceso}
aflag=${2:?Ano_Proceso}
#
# Definicion de simbolos
###########################################################################
#
if [ "$mflag" = "" ]  ||  [ "$aflag" = "" ]
then
    print -u2  "Error : Usar ConcFactCobr.ksh MM AAAA ";
    exit 1;
fi
#
###########################################################################
#
if [ $mflag -lt 1 ]  ||  [ $mflag -gt 12 ]
then
    print -u2 "Error de Parametro : Mes de Proceso [ 1 .. 12 ]";
    exit 1;
fi
#
###########################################################################

#
if [ $aflag -lt 1999 ] || [ $aflag -gt 2002 ]
then
    print -u2 "Error de Parametro : Ano de Proceso [ 1999 .. 2002  ]"
    exit 1
fi
#
###########################################################################
fec_desde="01"$mflag$aflag
###########################################################################
typeset -i mes_fin
typeset -i ano_fin
mes_fin=$mflag+1
ano_fin=$aflag
###########################################################################
if [ "$mflag" = "12" ]
then
    mes_fin=1
    ano_fin=$aflag+1
fi
fec_hasta=$(echo $mes_fin $ano_fin | awk '{printf("01%02d%04d\n",$1,$2)}')
#
###########################################################################
#
# define archivo de salida
    dir_log=${XPF_LOG}/carrier/${aflag}${mflag}
    dir_dat=${XPF_DAT}/carrier/${aflag}${mflag}
    mkdir -p ${dir_log}
    mkdir -p ${dir_dat}

	fecejecu=$(date "+%y%m%d_%H%M")
	archivo=${dir_log}/recaudacion_${fecejecu}.log;
	echo 'INFORME DE RECUADCACION DE CONCEPTOS CARRIER ' > ${archivo};
#
## Genera resumen de Reacuadcion de facturas con conceptos carrier 
#
	echo "Analizando Pagos de Facturas con Conceptos Carrier ..."; 
	sqlplus -s / @${XPF_SQL}/carrier_facilidad_cobr ${fec_desde} ${fec_hasta} ${dir_dat}/recaudacion_${mflag}_${aflag}_${fecejecu}.dat >>  ${archivo}
#
# Fin de Proceso
#

