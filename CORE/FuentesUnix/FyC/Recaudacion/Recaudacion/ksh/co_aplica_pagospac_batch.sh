cod_proc=$1 		#Codigo del proceso
cod_spro=$2 		#Codigo del subproceso
num_jobs=$3 		#Numero de proceso
cod_usua=$4  		#Codigo de Usuario
cod_pass=$5  		#Codigo de Password
instancia=$6 		#Coneccion a una instancia remota de Base de Datos
echo  "+-----------------------------------------------------------------------+"
echo  "          SHELL PROCESO SCHEDULER-BATCH PAC               		"
echo  "+-----------------------------------------------------------------------+"
echo  " Instancia                : "$instancia
echo  " Codigo de Usuario        : "$cod_usua
echo  " Fecha Inicio Ejecucion   : "$(date)
echo  "+-----------------------------------------------------------------------+"
#--------------------------------------------------------------------
# Inclusion funciones imprimir LOG y ERRORES
#--------------------------------------------------------------------
. $SCH_PRO/actujobs/tol_printlog.sh
#--------------------------------------------------------------------
# Inclusion MACROS de actualizacion JOBS, PROFILE e Indicador TAREA
#--------------------------------------------------------------------
. $SCH_PRO/actujobs/tol_defactu.sh
#--------------------------------------------------------------------
# Actualizacion SCH_JOBS - STATUS = EJEC
#--------------------------------------------------------------------
$EXEACTUPROFINI
#--------------------------------------------------------------------
# Ejecucion de los script y/o subscrpts (subtareas)
#--------------------------------------------------------------------
PrintLog " Ejecutando script $cod_scri "$(date)
#--------------------------------------------------------------------
# Ejecucion del Proceso en SI 
#--------------------------------------------------------------------
PrintLog ""
PrintLog "	Ejecutando PL CO_APLICA_PAGOSPAC..."
sqlplus $cod_usua/$cod_pass@$instancia <<EOF
DECLARE
	vp_retorno	NUMBER;
	vp_glosa	VARCHAR2(255);
	vp_retorno_aux	NUMBER;
	vp_glosa_aux	VARCHAR2(255);
	ERROR_PROCESO	EXCEPTION;
	desc_sql	VARCHAR2(255);
	vp_error	VARCHAR2(255);
	CURSOR PAC_BATCH IS
		SELECT 
			TO_CHAR(FEC_VALOR,'DD-MM-YYYY') FECHA_VALOR,
			COD_BANCO
		FROM
			CO_PAC_COLASBATCH_TD
		WHERE
			IND_PROCESADO=1
			AND
			COD_ESTADO=0;
BEGIN	
	vp_retorno:=-1;
	vp_glosa:=' ';
	FOR RREG IN PAC_BATCH LOOP
		BEGIN
			desc_sql:='CO_APLICA_PAGOSPAC('''||RREG.FECHA_VALOR||''','''||RREG.COD_BANCO||''',0,0,vp_retorno,vp_glosa)';
			CO_APLICA_PAGOSPAC(
				RREG.FECHA_VALOR,
				RREG.COD_BANCO,
				0,				
				0,				
				vp_glosa,
				vp_retorno
			);
			IF (vp_retorno!=0) THEN
				UPDATE CO_PAC_COLASBATCH_TD SET
					COD_RETORNO=vp_retorno,
					DESC_RETORNO=vp_glosa
				WHERE
					FEC_VALOR=RREG.FECHA_VALOR
					AND
					COD_BANCO=RREG.COD_BANCO;
				COMMIT;
			ELSE
				UPDATE CO_PAC_COLASBATCH_TD SET
					COD_ESTADO=1,
					COD_RETORNO=0,
					DESC_RETORNO='Ok.'
				WHERE
					FEC_VALOR=RREG.FECHA_VALOR
					AND
					COD_BANCO=RREG.COD_BANCO;
				COMMIT;
			END IF;
		END;
	END LOOP;
END;
/
exit
EOF
PrintLog ""
PrintLog " Fin Ejecucion script $cod_scri "$(date)
#--------------------------------------------------------------------
# Actualizacion SCH_JOBS - STATUS = FINAL
#--------------------------------------------------------------------
$EXEACTUPROFFIN
exit 0