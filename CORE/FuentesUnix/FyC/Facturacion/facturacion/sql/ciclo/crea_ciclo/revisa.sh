##############################################
# Programa : revisa.sh
##############################################
#!/usr/bin/ksh
. $HOME/.profile

export HOME=/produccion/cergte/explota

#export WORKDIR=$HOME/bin/crea_ciclo
export WORKDIR=/produccion/cergte/explota/crea_ciclo
#export TEMP=`cat $HOME/.archivo.dat`
export TEMP=`cat /produccion/cergte/explota/.archivo`

grep -l "Table created" /produccion/cergte/explota/crea_ciclo/*.lst > $WORKDIR/salida
export ciclo=`cat  /produccion/cergte/explota/crea_ciclo/ciclo.dat`
export cantidad=`cat $WORKDIR/salida|wc -l`

if [ "$cantidad" -eq "8" ]
    then
        glosa="'OK, CREACION DE TABLAS DEL CICLO'"
        cod_estad=3
else
        glosa="'ERROR, CREACION DE TABLAS DEL CICLO'"
        cod_estad=2
fi

sqlplus -s << EOF
siscel/$TEMP
@$WORKDIR/inserta_traza.sql $cod_estad $glosa $ciclo
exit;
EOF
exit;
