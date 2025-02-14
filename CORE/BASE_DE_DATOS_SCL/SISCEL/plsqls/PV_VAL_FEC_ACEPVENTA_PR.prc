CREATE OR REPLACE PROCEDURE PV_VAL_FEC_ACEPVENTA_PR (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;

------------------------------------------------

     vfec_acepventa ga_abocel.fec_acepventa%TYPE;

BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO 		:= TO_NUMBER(string(5));

     bRESULTADO := 'TRUE';

	 BEGIN

	 	  SELECT FEC_ACEPVENTA into vfec_acepventa FROM GA_ABOCEL WHERE NUM_ABONADO = nABONADO;

     EXCEPTION
	 		  WHEN NO_DATA_FOUND THEN
			  BEGIN

			  	   SELECT FEC_ACEPVENTA into vfec_acepventa FROM GA_ABOAMIST WHERE NUM_ABONADO = nABONADO;

			  EXCEPTION
			  	   WHEN NO_DATA_FOUND THEN
          			 	  bRESULTADO := 'FALSE';
          				  vMENSAJE   := 'ERROR EN PV_VAL_FEC_ACEPVENTA_PR: EL ABONADO ' || nABONADO || ' NO EXISTE.';
			  END;
	 END;

	 IF bRESULTADO = 'TRUE' THEN
	 	IF vfec_acepventa is NULL THEN
		 	  bRESULTADO := 'FALSE';
			  vMENSAJE   := 'VENTA DEL ABONADO N? ' || nABONADO || ' NO SE ENCUENTRA ACEPTADA.';
		END IF;
	 END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_VAL_FEC_ACEPVENTA_PR: NO SE PUEDE VALIDAR FECHA ACEPTACION DE VENTA DEL ABONADO.';

END;
/
SHOW ERRORS
