CREATE OR REPLACE PROCEDURE PV_PRC_VALSITUABO_CLIENTE(
--Verifica si existe OoSs pendiente
    	  v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nCLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;

------------------------------------------------

     --vCantidad         NUMBER(3); --72682/05-11-2008/EFR
     vCantidad         NUMBER(6); --72682/05-11-2008/EFR



BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nCLIENTE       := -1;
     nCLIENTE       := TO_NUMBER(string(6));

     bRESULTADO  := 'TRUE';
     vMENSAJE   := 'OK';
     vCantidad   := 0;


     BEGIN
         SELECT COUNT(1) INTO vCantidad
         FROM GA_ABOCEL
         WHERE cod_cliente = nCLIENTE
         AND cod_situacion NOT IN ('BAA','BAP','TAP');


	     If vCantidad > 0 Then
	        bRESULTADO := 'TRUE';
         Else
	        bRESULTADO := 'FALSE';
            vMENSAJE   := 'NO SE ENCONTRO ABONADOS CON SITUACION DISTINTA A (BAA,BAP,TAP)';
	     End If;

	 EXCEPTION
		 WHEN NO_DATA_FOUND THEN
                      bRESULTADO := 'FALSE';
                      vMENSAJE   := 'NO SE ENCONTRO ABONADOS CON SITUACION DISTINTA A (BAA,BAP,TAP)';
    END;
END;
/
SHOW ERRORS
