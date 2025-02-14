#!/usr/bin/ksh

export HOME=/produccion/cergte/explota
. $HOME/.profile

TEMP=`cat /produccion/cergte/explota/.archivo`


export WORKDIR=/produccion/cergte/explota/paso_hist
ORACLE_SID=CERGTE;export ORACLE_SID;

ORACLE_BASE=/app10/oracle/OracleHomes/db_1; export ORACLE_BASE
PATH=$PATH:.
ORACLE_HOME=/app10/oracle/OracleHomes/db_1; export ORACLE_HOME;
export PATH=.:$ORACLE_HOME/bin:$PATH


  sqlplus -s siscel/$TEMP @$WORKDIR/ciclo.sql $1 > /dev/null
  if [ `wc -l $WORKDIR/ciclo.dat | awk '{print $1}'` = 1 ]
  then
	cp /dev/null exp_paso.par
	echo "userid=siscel/$TEMP"> exp_paso.par
	echo "file=/siscel/arcorac/export/exp_paso_"$1 >>exp_paso.par
	echo "log=/siscel/arcorac/export/exp_paso_"$1 >>exp_paso.par
	echo "tables=fa_factabon_"$1>>exp_paso.par
	echo ",fa_factclie_"$1 >>exp_paso.par
	echo ",fa_factconc_"$1 >>exp_paso.par
	echo ",fa_factdocu_"$1 >>exp_paso.par
	echo "buffer=1048576">>exp_paso.par
	echo "compress=y">>exp_paso.par

        exp parfile=$WORKDIR/exp_paso.par  
  else
    echo "\nEl ciclo ingresado no es valido, verifique por favor..."
  fi

