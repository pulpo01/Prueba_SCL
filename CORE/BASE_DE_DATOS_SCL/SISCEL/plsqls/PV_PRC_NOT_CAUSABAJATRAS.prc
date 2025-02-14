CREATE OR REPLACE PROCEDURE        PV_PRC_NOT_CAUSABAJATRAS (
--- Valida que la causa de baja del abonado no sea por transpaso
--- por lo tanto si GA_ABOCEL.COD_CAUSABAJA = GA_DATOSGENER.COD_CAUTRAS ==> FALSE
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

	 nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
	 vACTABO     GA_ACTABO.COD_ACTABO%TYPE;

------------------------------------------------



	 vCodCausaBaja VARCHAR2(2) := 'XX';
	 vGenCodCausaBaja VARCHAR2(2) := 'XX';


BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO := TO_NUMBER(string(5));
     vACTABO  := string(4);

     bRESULTADO := 'TRUE';

	 SELECT COD_CAUTRAS
	 INTO   vGenCodCausaBaja
	 FROM   GA_DATOSGENER;



     SELECT A.COD_CAUSABAJA
     INTO   vCodCausaBaja
     FROM   GA_ABOCEL A
     WHERE  A.NUM_ABONADO    = nABONADO
     AND    A.COD_SITUACION IN (SELECT COD_SITUACION
                                FROM   PVD_ACTUACION_SITUACION B
                                WHERE  B.COD_PRODUCTO  = A.COD_PRODUCTO
                                AND    B.COD_ACTABO    = vACTABO
                                AND    B.COD_SITUACION = A.COD_SITUACION);

     IF vCodCausaBaja = vGenCodCausaBaja THEN

         bRESULTADO := 'FALSE';
         vMENSAJE   := 'EL ABONADO HA SIDO DADO DE BAJO POR TRASPASO';

     END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_PRC_VAL_CAUSABAJATRAS: NO SE PUEDE VALIDAR CAUSA BAJA DE TRASPASO DEL ABONADO. ' ||  SQLERRM || '.';

END;
/
SHOW ERRORS
