CREATE OR REPLACE PROCEDURE        PV_PRC_CHEQUEOVENTAS (
-- Valida que el Abonado no tenga equipo en Servicio Tecnico
-- por lo tanto si GA_ABOCEL.IND_DISP= '0 ==> FALSE
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nNUMVENTA    GA_VENTAS.NUM_VENTA%TYPE;

------------------------------------------------

     vEstVta       VARCHAR(4);
	 nIndDisp      NUMBER;
     rAceptaVenta  ROWID;

BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nNUMVENTA 		:= TO_NUMBER(string(8));

     vEstVta := 'AC';

     bRESULTADO := 'TRUE';

     SELECT ROWID
	 INTO rAceptaVenta
	 FROM GA_VENTAS
	 WHERE NUM_VENTA  = nNUMVENTA
	 AND IND_ESTVENTA = vEstVta;

     IF rAceptaVenta = '' THEN

         bRESULTADO := 'FALSE';
         vMENSAJE   := 'ANTES DE REALIZAR LA BAJA SE DEBE ACEPTAR LA VENTA';

     END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PRC_CHEQUEOVENTAS: NO SE PUEDE VALIDAR SI ESTA ACEPTADA LA VENTA.' || SQLERRM || '.';


END;
/
SHOW ERRORS
