set -x
################################################################################
#       PROCESO POSTERIOR A LA INTERCALACION
#
#  Autor                : Jorge Lizama
#
################################################################################
if [[ -z $1 ]]
then 
    echo ' INGRESE TIPO DE DOCUMENTO  '
    read documento
    echo ' UD: INGRESO : '
    echo ' TIPO DOCUMENTO  :' $documento
    echo ' ESTA CORRECTO ???? :(S/N)'
    read resp
         [  $resp != 'S' -a  $resp != 's' ] && 
            { print DEBE EJECUTAR NUEVAMENTE 
              exit 
           	}
    if [ $documento  = '2'  ]
    then 
        echo  ' INGRESO CICLO A PROCESAR : '
        read ciclo
        echo ' UD: INGRESO : '
        echo ' CICLO   :' $ciclo
        echo ' ESTA CORRECTO ???? :(S/N)'
        read resp
             [  $resp != 'S' -a  $resp != 's' ] && 
                { print DEBE EJECUTAR NUEVAMENTE 
                  exit 
                }
    fi
else
    ciclo=$1
    documento=$2
fi

################################################################################
	echo ' ESPERE MIENTRAS PROCESO.'
###########################################
    if [ $documento  = '2'  ]
    then
        dir_log=${XPF_LOG}/pasocobros/${ciclo}
        dir_dat=${XPF_DAT}/pasocobros/${ciclo}
    else
        dia_ejecu=$(date "+%Y%m%d")
        dir_log=${XPF_LOG}/pasocobros/NoCiclo/${dia_ejecu}
        dir_dat=${XPF_DAT}/pasocobros/NoCiclo/${dia_ejecu}
    fi
    mkdir -p ${dir_log}
    mkdir -p ${dir_dat}

    fecejecu=$(date "+%y%m%d_%H%M")
	archivo=${dir_log}/pos_pasoc_${documento}_${fecejecu}.log;
	echo 'INFORME DESPUES DE INTERCAR' > $archivo;
#
## Calcula saldo de la Cta. Cte. despues de Intercalar
#
	echo "Consultando Saldo de la Cartera despues de intercalar ..."; 
	echo 'SALDO DE LA CARTERA DESPUES DE INTERCALAR' >> $archivo;
	sqlplus -s / @${XPF_SQL}/saldo_new          ${dir_dat}/repcartera_desint_${fecejecu}.dat >> $archivo;
	sqlplus -s / @${XPF_SQL}/saldo_pagos_new    ${dir_dat}/reppagos_desint_${fecejecu}.dat   >> $archivo;
#
## Calcula Monto de la Facturacion Intercalado
#
	echo "Consultando Monto Intercalado de la Facturacion ..."; 
	echo 'MONTO INTERCALADO' >> $archivo;
    if [ $documento  = '2'  ]
    then
        sqlplus -s / @${XPF_SQL}/tot_ciclo_new   ${dir_dat}/repfactura_desint_${fecejecu}.dat ${ciclo}  >> $archivo;
    else
        sqlplus -s / @${XPF_SQL}/tot_nociclo_new ${dir_dat}/repfactura_desint_${fecejecu}.dat           >> $archivo;
    fi
exit;
