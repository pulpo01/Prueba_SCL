#!/bin/bash

if [[ "$#" = "5" || "$#" = "7" ]]
then
        if [ "$#" = "5" ]
        then
                ARGUMENT[0]=$1
                shift
                ARGUMENT[1]=$1
                shift
                ARGUMENT[2]=$1
                shift
                ARGUMENT[3]=$1
                shift
                ARGUMENT[4]=$1
                shift
                MINPARAMS=5
        fi
        if [ "$#" = "7" ]
        then
                ARGUMENT[0]=$1
                shift
                ARGUMENT[1]=$1
                shift
                ARGUMENT[2]=$1
                shift
                ARGUMENT[3]=$1
                shift
                ARGUMENT[4]=$1
                shift
                ARGUMENT[5]=$1
                shift
                ARGUMENT[6]=$1
                shift
                MINPARAMS=7
        fi
else
        echo
        echo "Uso: coordinador_MC -n=[x instancias] -f=[cod_ciclfact] -s=[log_size] -l=[detalle_log] -u=[user_oracle]."
        echo
        exit
fi

COMIENZO=0
while [ $COMIENZO -lt $MINPARAMS ]
do
        case "${ARGUMENT[$COMIENZO]:1:1}" in
                [n]     ) CANT_LECTORES=${ARGUMENT[$COMIENZO]:3:10};;
                [f]     ) FACTURA=${ARGUMENT[$COMIENZO]:3:10};;
                [s]     ) LOGSIZE=${ARGUMENT[$COMIENZO]:3:10};;
                [l]     ) LOGLEVEL=${ARGUMENT[$COMIENZO]:3:10};;
                [u]     ) USER=${ARGUMENT[$COMIENZO]:3:70};;
                [g]     ) CLIENTEINI=${ARGUMENT[$COMIENZO]:3:10};;
                [h]     ) CLIENTEFIN=${ARGUMENT[$COMIENZO]:3:10};;
        esac
        COMIENZO=`expr $COMIENZO + 1`
done

if [ "$CANT_LECTORES" == "" ]
then
        echo
        echo "Uso: coordinador_MC -n=[x instancias] -f=[cod_ciclfact] -s=[log_size] -l=[detalle_log] -u=[user_oracle]."
        echo "Falta parametro: -n."
        echo
        exit
fi

if [ "$FACTURA" == "" ]
then
        echo
        echo "Uso: coordinador_MC -n=[x instancias] -f=[cod_ciclfact] -s=[log_size] -l=[detalle_log] -u=[user_oracle]."
        echo "Falta parametro: -f."
        echo
        exit
fi

if [ "$LOGSIZE" == "" ]
then
        echo
        echo "Uso: coordinador_MC -n=[x instancias] -f=[cod_ciclfact] -s=[log_size] -l=[detalle_log] -u=[user_oracle]."
        echo "Falta parametro: -s."
        echo
        exit
fi

if [ "$LOGLEVEL" == "" ]
then
        echo
        echo "Uso: coordinador_MC -n=[x instancias] -f=[cod_ciclfact] -s=[log_size] -l=[detalle_log] -u=[user_oracle]."
        echo "Falta parametro: -l."
        echo
        exit
fi

if [ "$USER" == "" ]
then
        echo
        echo "Uso: coordinador_MC -n=[x instancias] -f=[cod_ciclfact] -s=[log_size] -l=[detalle_log] -u=[user_oracle]."
        echo "Falta parametro: -u."
        echo
        exit
fi

if [ "$CLIENTEINI" = "" ]
then
        CLIENTEINI=-1
fi

if [ "$CLIENTEFIN" = "" ]
then
        CLIENTEFIN=0
fi

echo
rm -f core
clear

# --- Ejecuta la cant de lectores pedida --- #
#-----------------------------------------------------------------------------
# Seteo de ambiente y variables
#-----------------------------------------------------------------------------

SCRIPT=`basename $0 .sh`
FECHALOG=`date +%d%m%Y%H%M%S`

FECHALOGDIR=`date +%Y%m%d`
mkdir -p $XPF_LOG/coordinador/$FECHALOGDIR

BATCHLOG=$XPF_LOG/coordinador/$FECHALOGDIR/${SCRIPT}_$FECHALOG.log

echo `date` > $BATCHLOG

PATH_BIN="./"
echo "$PATH_BIN" >> $BATCHLOG
# echo "coordinador_MC Version [1.02] 01-06-07" >> $BATCHLOG PGG SOPORTE 68367 - CAMBIO DE VERSION - 25-08-2008
echo "coordinador_MC Version [1.03] 25-08-08" >> $BATCHLOG
echo "" >> $BATCHLOG
echo "INICIO GENERAL: `date`" >> $BATCHLOG
echo "" >> $BATCHLOG
echo "PARAMETROS:" >> $BATCHLOG
echo "  - X INSTANCIAS (-n): "$CANT_LECTORES >> $BATCHLOG
echo "  - FACTURA (-f): "$FACTURA >> $BATCHLOG
echo "  - LOGSIZE (-s): "$LOGSIZE >> $BATCHLOG
echo "  - LOGLEVEL (-l): "$LOGLEVEL >> $BATCHLOG
echo "  - USER (-u): "$USER >> $BATCHLOG

#------------------------------------------------------------------------------
# CARGA RANGO DE CLIENTES POR HOST_ID
#------------------------------------------------------------------------------
if [ -s ${XPF_CFG}/host_id.dat ] ;then 
HostId=$(head -1 ${XPF_CFG}/host_id.dat) ;
echo "HOST" $HostId

cod_clienteini=`cat <<! | sqlplus -s /
set PAGESIZE 0
select cod_clienteini from fa_rangoshost_to where(cod_ciclfact=$FACTURA and host_id='${HostId}');
! `
echo "COD_CLIENTEINI"
echo $cod_clienteini

cod_clientefin=`cat <<! | sqlplus -s /
set PAGESIZE 0
select cod_clientefin from fa_rangoshost_to where(cod_ciclfact=$FACTURA and host_id='${HostId}');
! `
echo "COD_CLIENTEFIN"
echo $cod_clientefin

CLIENTEINI=`expr $cod_clienteini - 1`
CLIENTEFIN=$cod_clientefin

echo "COD_CLIENTEINI-1"
echo $CLIENTEINI

fi
#------------------------------------------------------------------------------
# CARGA INICIAL DE MEMORIA
#------------------------------------------------------------------------------

echo "INICIO DE CARGA INICIAL DE MEMORIA: `date`" >> $BATCHLOG

echo `pwd` >> $BATCHLOG
echo "Se ejecutara proceso: CARGA INICIAL" >> $BATCHLOG
# PGG SOPORTE - 68367 - 25-08-08 ($XPF_EXE)
$XPF_EXE/carga_inicial -mc -u $USER -c $FACTURA -g $CLIENTEINI -h $CLIENTEFIN >> $BATCHLOG 2>&1
SALIDA=`echo $?`

echo "Fin CARGA INICIAL: `date` SALIDA NUEVA CARGA INICIAL: ${SALIDA}" >> $BATCHLOG

if [ $SALIDA -ne 0 ]
then
        echo "ERROR EN CARGA INICIAL" >> $BATCHLOG
        exit $SALIDA
fi

#------------------------------------------------------------------------------
# FACTURADORES
#------------------------------------------------------------------------------

echo "INICIO DE LAS INSTANCIAS DEL FACTURADOR: `date`" >> $BATCHLOG

echo `pwd` >> $BATCHLOG
echo "Se ejecutara proceso: facturaC" >> $BATCHLOG

######### INI CO-200608300353
#######################################################################
# Validacion de la Fa_trazaproc para cod_proceso 3000
#######################################################################

echo "PASO_1"
if [ -s ${XPF_CFG}/host_id.dat ] ;then 
echo "host_id"$host_id

can_pend=`cat <<! | sqlplus -s /
set PAGESIZE 0
select count(1) from fa_trazaproc where(cod_ciclfact=$FACTURA and cod_proceso=3000 and host_id='${HostId}');
! `
echo "TRAZAPROC CON HOST"
echo $can_pend
if [ $can_pend = 0 ]
then
sqlplus -s / << !
insert into fa_trazaproc values($FACTURA,3000,1,sysdate,null,'Proceso Iniciado',0,0,0,'${HostId}' );
commit;
exit;
!
else
echo "Registro ya existia en la FA_TRAZAPROC con HOST"
fi
else

can_pend=`cat <<! | sqlplus -s /
set PAGESIZE 0
select count(1) from fa_trazaproc where(cod_ciclfact=$FACTURA and cod_proceso=3000);
! `
echo "TRAZAPROC SIN HOST"
echo $can_pend

if [ $can_pend = 0 ]
then
sqlplus -s / << !
insert into fa_trazaproc values($FACTURA,3000,1,sysdate,null,'Proceso Iniciado',0,0,0,null);
commit;
exit;
!
else
echo "Registro ya existia en la FA_TRAZAPROC"
fi
fi
######### FIN CO-200608300353
######### INI 33933 ###########
can_reg=`cat <<! | sqlplus -s /
set PAGESIZE 0
select count(1) from fa_procesos where(cod_ciclfact=$FACTURA);
! `
echo $can_reg
if [ $can_reg = 0 ]
then
lnumproceso=`cat <<! | sqlplus -s /
set PAGESIZE 0
SELECT FA_SEQ_NUMPRO.NEXTVAL
FROM DUAL;
! `
echo $lnumproceso
sqlplus -s / << !
insert into fa_procesos values($lnumproceso,2,999999,1,sysdate,USER,NULL,0,0,0,NULL,0,0,3,$FACTURA,0);
commit;
exit;
!
else
echo "Registro ya existia en la FA_PROCESOS"
fi
######### FIN 33933 ###########

NUM_LECTOR=0

while [ $NUM_LECTOR -lt $CANT_LECTORES ]
do
				# PGG SOPORTE - 68367 - 25-08-08 ($XPF_EXE)
        $XPF_EXE/facturaC -ciclo -mc -u $USER -f $FACTURA -s $LOGSIZE -l $LOGLEVEL & >> $BATCHLOG 2>&1
        sleep 8
        NUM_LECTOR=`expr $NUM_LECTOR + 1`
done

wait

SALIDA=`echo $?`

echo "Fin de ejecucion de las instancias del Facturador: `date` SALIDA facturaC: ${SALIDA}" >> $BATCHLOG
echo "se lanzaron: ${CANT_LECTORES} instancias del Facturador..." >> $BATCHLOG

if [ $SALIDA -ne 0 ]
then
        echo "ERROR EN facturaC" >> $BATCHLOG
fi

#------------------------------------------------------------------------------
# LIMPIAR MEMORIA
#------------------------------------------------------------------------------

echo "" >> $BATCHLOG
echo "Limpiando memoria..." >> $BATCHLOG
# PGG SOPORTE - 68367 - 25-08-08 ($XPF_EXE)
$XPF_EXE/limpiar_shared 
SALIDA=`echo $?`

if [ $SALIDA -ne 0 ]
then
        echo "ERROR EN limpiar_shared" >> $BATCHLOG
        exit $SALIDA
fi

#------------------------------------------------------------------------------
# FIN
#------------------------------------------------------------------------------

echo "" >> $BATCHLOG
echo "Salida del Modulo Coordinador $SALIDA - `date`" >> $BATCHLOG
echo "FIN GENERAL: `date`" >> $BATCHLOG
exit $SALIDA

