CREATE OR REPLACE PROCEDURE pv_valida_siniestros_pr (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------
     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
------------------------------------------------
	LV_cod_situacion		ga_abocel.cod_situacion%TYPE;
	LV_cod_grupo			al_tecnologia.cod_grupo%TYPE;
	LV_cod_grupo_gsm		ged_parametros.val_parametro%TYPE;

	LN_cantidad				INTEGER;


BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);

     nABONADO 		:= TO_NUMBER(string(5));

	 SELECT val_parametro
	 INTO LV_cod_grupo_gsm
	 FROM ged_parametros
	 WHERE cod_producto = 1
	 AND cod_modulo = 'GA'
	 AND nom_parametro = 'GRUPO_TEC_GSM';

	 SELECT cod_situacion, GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(cod_tecnologia)
	 INTO	LV_cod_situacion,LV_cod_grupo
	 FROM ga_abocel
	 WHERE num_abonado = nABONADO
	 UNION
	 SELECT cod_situacion, cod_tecnologia
	 FROM ga_aboamist
	 WHERE num_abonado = nABONADO;

	 IF LV_cod_situacion = 'SAA' THEN

		 SELECT COUNT(1) INTO LN_cantidad
		 FROM ga_siniestros
		 WHERE num_abonado = nABONADO;

		 IF LV_cod_grupo_gsm = LV_cod_grupo THEN--ES GSM

			IF LN_cantidad = 2 THEN
			   bRESULTADO := 'FALSE';
			   vMENSAJE := 'EL ABONADO YA CUENTA CON SINIESTROS DEL EQUIPO y SIMCARD.';
			ELSE
				bRESULTADO := 'TRUE';
			END IF;

		 ELSE
			IF LN_cantidad = 1 THEN
			   bRESULTADO := 'FALSE';
			   vMENSAJE := 'EL ABONADO YA CUENTA CON SINIESTRO DEL EQUIPO.';
			ELSE
				bRESULTADO := 'TRUE';
			END IF;
		 END IF;
	ELSE
		bRESULTADO := 'TRUE';
	END IF;
EXCEPTION
    WHEN OTHERS THEN
         bRESULTADO := 'FALSE';
         vMENSAJE   := 'ERROR EN pv_valida_siniestros_pr.';

END;
/
SHOW ERRORS
