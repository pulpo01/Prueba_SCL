# Programa : delToldetfactura.sh
# Author   : CAOH 
# Date     : 15/05/2007
# Remarks  : Elimina los Registros de la tabla TOL_DETFACTURA_0X, donde
#            X es un valor pasado como parametro, para el ciclo ingresado.
# =============================================================================

echo "Entrando a delToldetfactura.sh"

if [ $# -ne 2 ]
then
	echo "ERROR: Se debe ingresar el Ciclo y Modulo a procesar"
	exit 1
fi

if [ $2 -gt 9 ]
then
	echo "ERROR: Modulo no debe ser mayor a 9"
	exit 2
fi

if [ $2 -lt 0 ]
then
	echo "ERROR: Modulo no debe ser menor a 0"
	exit 2
fi

#$HOME/. .profile AFGS - 42377
. $HOME/.profile

TEMP=`cat $HOME/.archivo.dat`

export WORKDIR=$HOME/facturacion/sql/ciclo/borra_TOLDet
echo $ORACLE_HOME
export ORACLE_SID=SCEL
PATH=$PATH:.

sqlplus -s siscel/$TEMP @$WORKDIR/val_ciclo.sql $1 > /dev/null

if [ `wc -l $WORKDIR/val_ciclo.dat | awk '{print $1}'` = 1 ] 
then
        codCiclo=`cat $WORKDIR/val_ciclo.dat|awk '{print $1}'`
        sqlplus -s siscel/$TEMP @$WORKDIR/cuenta_TOLDet.sql $1 $2 $codCiclo > /dev/null 
        cuentaHist=`cat $WORKDIR/cuenta_TOLDet.dat|awk '{print $1}'`                    
    
        if [ `wc -l $WORKDIR/cuenta_TOLDet.dat | awk '{print $1}'` = 1 ]                
        then                                                                            
#                sqlplus -s siscel/$TEMP @$WORKDIR/cuenta_PFTOL.sql $1 $2 > /dev/null   # AFGS - 42377
#                cuentaTT=`cat $WORKDIR/cuenta_PFTOL.dat|awk '{print $1}'`              # AFGS - 42377
#                echo "\n Totales registros TOL[$cuentaTT] DET[$cuentaHist]"            # AFGS - 42377
#                if [ $cuentaHist = $cuentaTT ]                                         # AFGS - 42377
#                then                                                                   # AFGS - 42377
	  		sqlplus -s siscel/$TEMP @$WORKDIR/erase_TOLDet.sql $1 $2 $codCiclo
#                else                                                                   # AFGS - 42377
#                    echo "\nHay diferencia de Registros Paso de llamadas no se eliminan registros " # AFGS - 42377
#        fi                                                                               # AFGS - 42377
	else
		echo "\n[ERROR] No existe Tabla de detalle TOL"
	fi
  else 
    echo "\n[ERROR] El ciclo ingresado no es valido, verifique por favor..."
fi

exit
