CREATE OR REPLACE PROCEDURE        PV_PRC_NOT_CAUSABAJAAMIS (
-- Valida que la causa de baja del abonado no sea OPTA POR AMISTAR
-- Por lo tanto si GA_ABOCEL.COD_CAUSA = GED_PARAMETROS.NOM_PARAMETRO('COD_OPTAAMISTAR') ==> FALSE
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------


	 nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
	 vACTABO     GA_ACTABO.COD_ACTABO%TYPE;

------------------------------------------------



	 vCodCausaAmis VARCHAR2(2) := 'XX';
	 vGenCodCausaAmis VARCHAR2(2) := 'XX';

BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO 		:= TO_NUMBER(string(5));
     vACTABO  		:= string(4);

     bRESULTADO := 'TRUE';

	 SELECT VAL_PARAMETRO
	 INTO   vGenCodCausaAmis
	 FROM   GED_PARAMETROS
	 WHERE  NOM_PARAMETRO = 'COD_OPTAAMISTAR';



     SELECT A.COD_CAUSABAJA
     INTO   vCodCausaAmis
     FROM   GA_ABOCEL A
     WHERE  A.NUM_ABONADO    = nABONADO
     AND    A.COD_SITUACION IN (SELECT COD_SITUACION
                                FROM   PVD_ACTUACION_SITUACION B
                                WHERE  B.COD_PRODUCTO  = A.COD_PRODUCTO
                                AND    B.COD_ACTABO    = vACTABO
                                AND    B.COD_SITUACION = A.COD_SITUACION);

     IF vCodCausaAmis = vGenCodCausaAmis THEN

         bRESULTADO := 'FALSE';
         vMENSAJE   := 'EL ABONADO HA SIDO DADO DE BAJA OPTA POR AMISTAR';

     END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_PRC_VAL_CAUSABAJAAMIS : NO SE PUEDE VALIDAR CAUSA BAJA OPTA POR AMISTAR ABONADO.';


END;
/
SHOW ERRORS
