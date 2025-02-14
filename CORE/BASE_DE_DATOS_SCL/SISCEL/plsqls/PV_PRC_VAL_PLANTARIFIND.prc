CREATE OR REPLACE PROCEDURE        PV_PRC_VAL_PLANTARIFIND (
-- Valida que el Tipo de Plan Tarifario del Abonado no sea Empresa
-- por lo tanto si GA_ABOCEL.TIP_PLANTARIF = 'E' ==> FALSE
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
     vACTABO     GA_ACTABO.COD_ACTABO%TYPE;

------------------------------------------------



	 vTipPlanTarif VARCHAR2(1) := '0';

BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO 		:= TO_NUMBER(string(5));
     vACTABO  		:= string(4);


     bRESULTADO := 'TRUE';

     SELECT A.TIP_PLANTARIF
     INTO   vTipPlanTarif
     FROM   GA_ABOCEL A
     WHERE  A.NUM_ABONADO    = nABONADO
     AND    A.COD_SITUACION IN (SELECT COD_SITUACION
                                FROM   PVD_ACTUACION_SITUACION B
                                WHERE  B.COD_PRODUCTO  = A.COD_PRODUCTO
                                AND    B.COD_ACTABO    = vACTABO
                                AND    B.COD_SITUACION = A.COD_SITUACION);

     IF vTipPlanTarif = 'E' THEN

         bRESULTADO := 'FALSE';
         vMENSAJE   := 'OPERACION PERMITIDA SOLO PARA PLAN TARIFARIO INDIVIDUAL';

     END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_PRC_VAL_PLANTARIFIND: NO SE PUEDE VALIDAR PLAN TARIFARIO DEL ABONADO.' || SQLERRM || '.';


END;
/
SHOW ERRORS
