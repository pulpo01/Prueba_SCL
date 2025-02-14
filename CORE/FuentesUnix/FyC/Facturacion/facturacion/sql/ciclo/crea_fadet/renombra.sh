#!/usr/bin/ksh
# Programa : renombra.sh
# Author   : Ricardo Mondaca.
# Date     : 28/10/2005
# Remarks  : Crea tablas fa_detcelular_<ciclo> a partir de la tabla pf_tarificadas.
# =================================================================================


export HOME=/produccion/cergte/explota
. $HOME/.profile

TEMP=`cat $HOME/.archivo.dat`

WORKDIR=/produccion/cergte/explota/crea_fadet
export WORKDIR

ORACLE_SID=CERGTE
export ORACLE_SID

PATH=$PATH:.
export PATH=.:$ORACLE_HOME/bin:$PATH

  sqlplus -s siscel/$TEMP @$WORKDIR/ciclo.sql $1 > /dev/null
  if [ `wc -l $WORKDIR/ciclo.dat | awk '{print $1}'` = 1 ]
  then

# Validacion de traza, codigo de proceso 9150
    sqlplus -s siscel/$TEMP @$WORKDIR/GetTrazaproc.sql $1 9150 > /dev/null
	if [ `wc -l $WORKDIR/GetTrazaproc.dat | awk '{print $1}'` = 1 ]
  	then
  		codEstadoProc=`cat $WORKDIR/GetTrazaproc.dat|awk '{print $1}'`
  		if [ "$codEstadoProc" -eq "1" ]
    	then
	        echo "\nProceso se encuentra iniciado puede todavia encontrase en ejecucion"
			exit
		fi
	    sqlplus -s siscel/$TEMP @$WORKDIR/GetProcFact.sql 9150 > /dev/null
		if [ `wc -l $WORKDIR/GetProcFact.dat | awk '{print $1}'` = 1 ]
	  	then
	  		indReproceso=`cat $WORKDIR/GetProcFact.dat|awk '{print $1}'`
	  		if [ "$indReproceso" -eq "0" ]
	  		then 
		        echo "\nProceso no puede ser reprocesado"
				exit
			fi
		fi
	fi

	sqlplus -s siscel/$TEMP @$WORKDIR/GetProcFactPrec.sql 9150 > /dev/null
	if [ `wc -l $WORKDIR/GetProcFactPrec.dat | awk '{print $1}'` = 1 ]
	then
		cantProcOKReq=`cat $WORKDIR/GetProcFactPrec.dat|awk '{print $1}'`
	fi

	sqlplus -s siscel/$TEMP @$WORKDIR/GetTrazaProcPrec.sql $1 9150 > /dev/null
	if [ `wc -l $WORKDIR/GetTrazaProcPrec.dat | awk '{print $1}'` = 1 ]
	then
		cantProcOKEjec=`cat $WORKDIR/GetTrazaProcPrec.dat|awk '{print $1}'`
	fi

	if [ $cantProcOKReq != $cantProcOKEjec ]
    then
	    echo "\nProcesos precedentes no completados "
		exit
	fi
	
	glosa="'Paso a historico de llamadas inicio'"
	sqlplus -s siscel/$TEMP @$WORKDIR/insertTrazaProc.sql $1 9150 1 $glosa > /dev/null
	
	
# Fin validacion

    sqlplus -s siscel/$TEMP @$WORKDIR/cuentao.sql $1 > /dev/null
    cuentaold=`cat $WORKDIR/cuentao.dat|awk '{print $1}'`
    echo "\na pasar $cuentaold registros"
    sqlplus -s siscel/$TEMP @$WORKDIR/copia.sql $1
    sqlplus -s siscel/$TEMP @$WORKDIR/cuentan.sql $1 > /dev/null
    cuentanew=`cat $WORKDIR/cuentan.dat|awk '{print $1}'`
    echo "\n pasados $cuentanew registros"
    if [ $cuentaold = $cuentanew ]
    then
       sqlplus -s siscel/$TEMP @$WORKDIR/trunca.sql $1
       sqlplus -s siscel/$TEMP @$WORKDIR/permiso.sql $1
       sqlplus -s siscel/$TEMP @$WORKDIR/indice.sql $1
    else
        echo "\nContactarse con el DBA de Turno... Hay diferencia de Registros Paso de llamadas"
    fi
  else
    echo "\nEl ciclo ingresado no es valido, verifique por favor..."
  fi
  
  glosa="'Paso a historico de llamadas Fin'"
  sqlplus -s siscel/$TEMP @$WORKDIR/updateTrazaProc.sql $1 9150 3 > /dev/null
exit

