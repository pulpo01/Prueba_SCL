#!/usr/bin/ksh
# Nomble :crea_res.sh
# Fecha  : 13/03/2000
# Remarks: Permite generar tablas historicas a partir de las tablas de ciclo.
# Funciona: crea_res.sh DDMMYY Nombre_Base_de_Datos
#        Ejm : crea_res.sh 51101 SCEL
# #############################################################################


export HOME=/produccion/explotacion/explota
. $HOME/.profile

TEMP=`cat $HOME/.archivo`

WORKDIR=$HOME/paso_hist
export WORKDIR
ORACLE_SID=SCLGTE
export ORACLE_SID

tbs_tab='HTL_faAbonCiclo'
tbs_ind='i'
export tbs_tab
export tbs_ind='i'


echo $WORKDIR
echo $ORACLE_SID
echo $TEMP

  sqlplus -s siscel/$TEMP @$WORKDIR/ciclo.sql $1 > /dev/null
  if [ `wc -l $WORKDIR/ciclo.dat | awk '{print $1}'` = 1 ]
  then

    echo "Empieza proceso : "`date` > $WORKDIR/registro_$1

#   Cuenta la cantidad de filas de las tablas de ciclo
#   ==================================================

    sqlplus -s siscel/$TEMP @$WORKDIR/cuenta_tecno.sql $1 > /dev/null
    sqlplus -s siscel/$TEMP @$WORKDIR/cuenta_cli.sql $1 > /dev/null
    sqlplus -s siscel/$TEMP @$WORKDIR/cuenta_abo.sql $1 > /dev/null
    sqlplus -s siscel/$TEMP @$WORKDIR/cuenta_con.sql $1 > /dev/null
    sqlplus -s siscel/$TEMP @$WORKDIR/cuenta_doc.sql $1 > /dev/null
    sqlplus -s siscel/$TEMP @$WORKDIR/cuenta_his.sql $1 > /dev/null

    sqlplus -s siscel/$TEMP @$WORKDIR/cuenta_pag.sql $1 > /dev/null        #P-COL-07041

    cuentaold_tecno=`cat $WORKDIR/cuenta_tecno.dat|awk '{print $1}'`
    cuentaold_cli=`cat $WORKDIR/cuenta_cli.dat|awk '{print $1}'`
    cuentaold_abo=`cat $WORKDIR/cuenta_abo.dat|awk '{print $1}'`
    cuentaold_con=`cat $WORKDIR/cuenta_con.dat|awk '{print $1}'`
    cuentaold_doc=`cat $WORKDIR/cuenta_doc.dat|awk '{print $1}'`
    cuentaold_his=`cat $WORKDIR/cuenta_his.dat|awk '{print $1}'`

    cuentaold_pag=`cat $WORKDIR/cuenta_pag.dat|awk '{print $1}'`           #P-COL-07041

    echo "\na pasar $cuentaold_tecno registros old_tecno"
    echo "Registros old_tecno : "$cuentaold_tecno >> $WORKDIR/registro_$1
    echo "\na pasar $cuentaold_cli registros old_cli"
    echo "Registros old_cli   : "$cuentaold_cli >> $WORKDIR/registro_$1
    echo "\na pasar $cuentaold_abo registros old_abo"
    echo "Registros old_abo   : "$cuentaold_abo >> $WORKDIR/registro_$1
    echo "\na pasar $cuentaold_con registros old_con"
    echo "Registros old_con   : "$cuentaold_con >> $WORKDIR/registro_$1
    echo "\na pasar $cuentaold_doc registros old_doc"
    echo "Registros old_doc   : "$cuentaold_doc >> $WORKDIR/registro_$1

    echo "\na pasar $cuentaold_pag registros old_pag"                      #P-COL-07041
    echo "Registros old_pag   : "$cuentaold_pag >> $WORKDIR/registro_$1

#   Crea la tablas historicas a partir de las tablas de ciclo
#   =========================================================

    sqlplus -s siscel/$TEMP @$WORKDIR/cr_fa_histecno.sql  $1 > /dev/null
    sqlplus -s siscel/$TEMP @$WORKDIR/cr_fa_histabon.sql  $1 > /dev/null
    sqlplus -s siscel/$TEMP @$WORKDIR/cr_fa_histaconc.sql $1 > /dev/null
    sqlplus -s siscel/$TEMP @$WORKDIR/cr_fa_histdocu.sql  $1 > /dev/null
    sqlplus -s siscel/$TEMP @$WORKDIR/cr_fa_histclie.sql  $1 > /dev/null

    sqlplus -s siscel/$TEMP @$WORKDIR/cr_fa_histpago.sql  $1 > /dev/null   #P-COL-07041

#   Cuenta las filas de las tablas historicas.
#   ==========================================

    sqlplus -s siscel/$TEMP @$WORKDIR/cuenta_tecno_n.sql $1 > /dev/null
    sqlplus -s siscel/$TEMP @$WORKDIR/cuenta_cli_n.sql $1 > /dev/null
    sqlplus -s siscel/$TEMP @$WORKDIR/cuenta_abo_n.sql $1 > /dev/null
    sqlplus -s siscel/$TEMP @$WORKDIR/cuenta_con_n.sql $1 > /dev/null
    sqlplus -s siscel/$TEMP @$WORKDIR/cuenta_doc_n.sql $1 > /dev/null

    sqlplus -s siscel/$TEMP @$WORKDIR/cuenta_pag_n.sql $1 > /dev/null       #P-COL-07041


    cuentanew_tecno=`cat $WORKDIR/cuenta_tecno_n.dat|awk '{print $1}'`
    cuentanew_cli=`cat $WORKDIR/cuenta_cli_n.dat|awk '{print $1}'`
    cuentanew_abo=`cat $WORKDIR/cuenta_abo_n.dat|awk '{print $1}'`
    cuentanew_con=`cat $WORKDIR/cuenta_con_n.dat|awk '{print $1}'`
    cuentanew_doc=`cat $WORKDIR/cuenta_doc_n.dat|awk '{print $1}'`

    cuentanew_pag=`cat $WORKDIR/cuenta_pag_n.dat|awk '{print $1}'`          #P-COL-07041


#   Muestra la cantidad de filas de las tablas historicas
#   =====================================================

    echo "Registros new_tecno : "$cuentanew_tecno >> $WORKDIR/registro_$1
    echo "Registros new_cli   : "$cuentanew_cli >> $WORKDIR/registro_$1
    echo "Registros new_abo   : "$cuentanew_abo >> $WORKDIR/registro_$1
    echo "Registros new_con   : "$cuentanew_con >> $WORKDIR/registro_$1
    echo "Registros new_doc   : "$cuentanew_doc >> $WORKDIR/registro_$1

    echo "Registros new_pag   : "$cuentanew_pag >> $WORKDIR/registro_$1    #P-COL-07041

    echo "\n pasados $cuentanew_tecno registros new_tecno"
    echo "\n pasados $cuentanew_cli registros new_cli"
    echo "\n pasados $cuentanew_abo registros new_abo"
    echo "\n pasados $cuentanew_con registros new_con"
    echo "\n pasados $cuentanew_doc registros new_doc"

    echo "\n pasados $cuentanew_pag registros new_pag"                      #P-COL-07041

    if [ $cuentaold_cli = $cuentanew_cli ]
    then
       sqlplus -s siscel/$TEMP @$WORKDIR/drop_cli.sql $1
       sqlplus -s siscel/$TEMP @$WORKDIR/permiso_cli.sql $1
       sqlplus -s siscel/$TEMP @$WORKDIR/indice_cli.sql $1
    else
        echo "\nContactarse con el DBA de Turno... Hay diferencia de Registros (Fa_histclie)"
        echo "\nContactarse con el DBA de Turno... Hay diferencia de Registros (Fa_histclie)" >> $WORKDIR/registro_$1
    fi

    if [ $cuentaold_pag = $cuentanew_pag ]     #P-COL-07041
    then
       sqlplus -s siscel/$TEMP @$WORKDIR/drop_pag.sql $1
       sqlplus -s siscel/$TEMP @$WORKDIR/permiso_pag.sql $1
       sqlplus -s siscel/$TEMP @$WORKDIR/indice_pag.sql $1
    else
        echo "\nContactarse con el DBA de Turno... Hay diferencia de Registros (Fa_histpago)"
        echo "\nContactarse con el DBA de Turno... Hay diferencia de Registros (Fa_histpago)" >> $WORKDIR/registro_$1
    fi


    echo "\n pasados $cuentanew registros"
    if [ $cuentaold_abo = $cuentanew_abo ]
    then
       sqlplus -s siscel/$TEMP @$WORKDIR/drop_bon.sql $1
       sqlplus -s siscel/$TEMP @$WORKDIR/permiso_bon.sql $1
       sqlplus -s siscel/$TEMP @$WORKDIR/indice_bon.sql $1
    else
        echo "\nContactarse con el DBA de Turno... Hay diferencia de Registros (Fa_histabon)"
        echo "\nContactarse con el DBA de Turno... Hay diferencia de Registros (Fa_histabon)" >> $WORKDIR/registro_$1
    fi

    if [ $cuentaold_tecno = $cuentanew_tecno ]
    then
       sqlplus -s siscel/$TEMP @$WORKDIR/drop_tecno.sql $1
       sqlplus -s siscel/$TEMP @$WORKDIR/permiso_tecno.sql $1
    else
        echo "\nContactarse con el DBA de Turno... Hay diferencia de Registros (Fa_histecno)"
        echo "\nContactarse con el DBA de Turno... Hay diferencia de Registros (Fa_histecno)" >> $WORKDIR/registro_$1
    fi

    echo "\n pasados $cuentanew registros"
    if [ $cuentaold_con = $cuentanew_con ]
    then
       sqlplus -s siscel/$TEMP @$WORKDIR/drop_con.sql $1
       sqlplus -s siscel/$TEMP @$WORKDIR/permiso_con.sql $1
       sqlplus -s siscel/$TEMP @$WORKDIR/indice_con.sql $1
    else
        echo "\nContactarse con el DBA de Turno... Hay diferencia de Registros (Fa_histconc)"
        echo "\nContactarse con el DBA de Turno... Hay diferencia de Registros (Fa_histconc)" >> $WORKDIR/registro_$1
    fi

    if [ $cuentaold_tecno = $cuentanew_tecno ]
    then
       sqlplus -s siscel/$TEMP @$WORKDIR/indice_tecno.sql $1
    else
        echo "\nContactarse con el DBA de Turno... Hay diferencia de Registros (Fa_histecno)"
        echo "\nContactarse con el DBA de Turno... Hay diferencia de Registros (Fa_histecno)" >> $WORKDIR/registro_$1
    fi

    echo "Termina proceso : "`date`>> $WORKDIR/registro_$1

    if [ $cuentanew_doc = $cuentaold_his ]
    then
       sqlplus -s siscel/$TEMP @$WORKDIR/drop_doc.sql $1
    else
        echo "\nContactarse con el DBA de Turno... Hay diferencia de Registros (Fa_histdocu)"
        echo "\nContactarse con el DBA de Turno... Hay diferencia de Registros (Fa_histdocu)" >> $WORKDIR/registro_$1
    fi

  else
    echo "\nEl ciclo ingresado no es valido, verifique por favor..."
  fi


