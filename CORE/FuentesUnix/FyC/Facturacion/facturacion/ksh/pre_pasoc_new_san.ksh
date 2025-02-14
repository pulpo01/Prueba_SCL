set -x
################################################################################
#       PROCESO PREVIO A INTERCALACION
#
#  Autor                : Jorge Lizama
#
################################################################################
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

echo ' ESPERE MIENTRAS PROCESO.'
################################################################################
# Definicion de simbolos
#
# define archivo de salida
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
        archivo=${dir_log}/pre_pasoc_${documento}_${fecejecu}.log;
        echo 'INFORME ANTES DE INTERCAR' > ${archivo};
#
## Calcula saldo de la Cta. Cte. antes de Intercalar
#
        echo "Consultando Saldo de la Cartera antes de intercalar ..."; 
        echo 'SALDO DE LA CARTERA ANTES DE INTERCALAR' >> $archivo;
        sqlplus -s / @${XPF_SQL}/saldo_new        ${dir_dat}/repcartera_antint_${fecejecu}.dat >>  $archivo ;
        sqlplus -s / @${XPF_SQL}/saldo_pagos_new  ${dir_dat}/reppagos_antint_${fecejecu}.dat   >>  $archivo ;
#
## Calcula Monto de la Facturacion a Intercalar
#
        echo "Consultando Monto de la Facturacion a intercalar ..."; 
        echo 'MONTO A INTERCALAR' >> $archivo;
    if [ $documento  = '2'  ]
    then
        sqlplus -s / @${XPF_SQL}/tot_ciclo_new   ${dir_dat}/repfactura_antint_${fecejecu}.dat  ${ciclo} >> $archivo;
    else
        sqlplus -s / @${XPF_SQL}/tot_nociclo_new ${dir_dat}/repfactura_antint_${fecejecu}.dat           >> $archivo;
        sqlplus -s / @${XPF_SQL}/tot_nociclo_pend ${dir_dat}/repfactura_antintpend_${fecejecu}.dat      >> $archivo;
    fi
#
# Fin de Proceso
#

