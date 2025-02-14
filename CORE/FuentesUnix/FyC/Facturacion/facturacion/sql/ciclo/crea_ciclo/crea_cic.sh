#!/usr/bin/ksh

# Programa : crea_cic.sh tenia usuario siscel cambiar despues
export HOME=/produccion/cergte/explota
. $HOME/.profile

export OOP_PAR=/produccion/cergte/explota
TEMP=`cat $OOP_PAR/.archivo`
## ---End DB Settings---
echo "Entrando a crea_cic.sh"
echo $ORACLE_HOME
export WORKDIR=$OOP_PAR/crea_ciclo

export ORACLE_SID=CERGTE
export TWO_TASK=CERGTE
PATH=$PATH:.
echo exporta path local $PATH
export PATH=.:$ORACLE_HOME/bin:$PATH
echo rexporta path a maquina $PATH
echo "Verificando ciclo...."
sqlplus -s siscel/$TEMP @$WORKDIR/ciclo.sql $1 # > /dev/null
  if [ `wc -l $WORKDIR/ciclo.dat | awk '{print $1}'` = 1 ]
  then
        rm -f $WORKDIR/tab_*.lst
        echo "Creando tablas...."
        sqlplus  siscel/$TEMP @$WORKDIR/fatabcon.sql $1 # > /dev/null
        echo password $TEMP
        sqlplus -s siscel/$TEMP @$WORKDIR/fatabcli.sql $1 # > /dev/null
        sqlplus -s siscel/$TEMP @$WORKDIR/fataconc.sql $1 # > /dev/null
        sqlplus -s siscel/$TEMP @$WORKDIR/fatabtecno.sql $1 # > /dev/null
        sqlplus -s siscel/$TEMP @$WORKDIR/fafadocu.sql $1 # > /dev/null
        sqlplus -s siscel/$TEMP @$WORKDIR/crea_fk.sql $1 # > /dev/null
#       sqlplus -s siscel/$TEMP @$WORKDIR/borra_ultpago.sql $1 # > /dev/null

# Creacion de tabla de detalle de trafico ciclo
        sqlplus -s siscel/$TEMP @$WORKDIR/cr_pftoltarifica.sql $1 # > /dev/null
        
# Creacion de tabla historica consumo ciclo
        sqlplus -s siscel/$TEMP @$WORKDIR/cr_histconsumo.sql $1 # > /dev/null        
        
# Creacion de tabla descuento locutorios
	sqlplus -s siscel/$TEMP @$WORKDIR/detdctoclieloc.sql $1 # > /dev/null                

        ksh $WORKDIR/revisa.sh
  else
    echo "\nEl ciclo ingresado no es valido, verifique por favor..."
  fi




