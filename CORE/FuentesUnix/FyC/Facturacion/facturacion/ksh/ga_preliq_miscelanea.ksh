###########################################################################################################
# Nombre de SHELL  : ga_preliq_miscelania.ksh                                                             #
# Fecha de Creacion: Noviembre-2005                                                                       #
# Descripcion      : Ejecuta el procedimiento almacenado GA_PRELIQ_MISCELANEA_PG 			  #
# Salida           : Codigo de error = 0 indica que fue exitoso		    				  #
###########################################################################################################


FEC=`date +%d%m%Y`
HOR=`date +%H%M%S`
USR=$1
RCH=$XPF_LOG/GA_PRELIQ_${FEC}${HOR}.log
SQL=${XPF_SQL}
echo "EJECUTA PRELIQUIDACION" >> $RCH 2>&1
echo "#########################################################" >> $RCH 2>&1
echo "Inicio Proceso: " `date +%d-%m-%y `  `date +%H:%M:%S` >> $RCH 2>&1
echo "#########################################################" >> $RCH 2>&1
SALIDA_PL=`sqlplus -s ${USR} @${SQL}/pl_ga_preliq_miscelanea.sql `  >> $RCH 2>&1
echo "sqlplus -s ${USR} @${SQL}/pl_ga_preliq_miscelanea.sql" >> $RCH 2>&1
echo $SALIDA_PL >> $RCH 2>&1
echo "#########################################################" >> $RCH 2>&1
echo "Fin Proceso: " `date +%d-%m-%y `  `date +%H:%M:%S` >> $RCH 2>&1
echo "#########################################################" >> $RCH 2>&1



