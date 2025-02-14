CREATE OR REPLACE PROCEDURE Pv_Val_Grupo_Tecno_Abonado_Pr (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE

) IS

	string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

	---- parametros reales de entrada --------------

	     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
	     vACTABO     GA_ACTABO.COD_ACTABO%TYPE;
	------------------------------------------------

	vCantidad NUMBER(2) := 0;
	codGSM	VARCHAR2(10) := '';

 	BEGIN

		GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
		nABONADO:= TO_NUMBER(string(5));
		bRESULTADO := 'TRUE';

       		codGSM:= ge_fn_devvalparam('GA',1,'TECNOLOGIA_GSM');

		SELECT COUNT(*) INTO vCantidad
		FROM   GA_ABOCEL A
		WHERE  A.NUM_ABONADO = nABONADO
		AND cod_tecnologia = codGSM;

     		IF vCantidad = 0 THEN
			SELECT COUNT(*)  INTO vCantidad
			FROM   GA_ABOAMIST A
			WHERE  A.NUM_ABONADO    = nABONADO
			AND cod_tecnologia = codGSM;


			IF vCantidad = 0 THEN
				bRESULTADO := 'FALSE';
				vMENSAJE   := 'EL ABONADO NO PERTENECE AL GRUPO TECNOLOGICA GSM';
			END IF;
		END IF;


		EXCEPTION
		WHEN OTHERS THEN
			bRESULTADO := 'FALSE';
			vMENSAJE   := 'ERROR EN PV_VAL_GRUPO_TECNO_ABONADO_PR: NO SE PUEDE VALIDAR LA TECNOLOGIA DEL ABONADO.';


END;
/
SHOW ERRORS
