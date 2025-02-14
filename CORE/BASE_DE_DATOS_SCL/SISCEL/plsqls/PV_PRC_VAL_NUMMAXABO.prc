CREATE OR REPLACE PROCEDURE        PV_PRC_VAL_NUMMAXABO (
-- Valida si el cliente posee cantidad  maxima de abonados por plan.
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
     vACTABO     GA_ACTABO.COD_ACTABO%TYPE;
	 nCODCLIENTE GA_ABOCEL.COD_CLIENTE%TYPE;

------------------------------------------------
	 vTipPlanTarif  		ga_abocel.tip_plantarif%TYPE;
	 vCodPlanTarif  		ga_abocel.cod_plantarif%TYPE;
	 nAbonPermitidos		ta_plantarif.num_abonados%TYPE;
	 nTotalAbonados			NUMBER;


BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO 		:= TO_NUMBER(string(5));
	 nCODCLIENTE	:= TO_NUMBER(string(6));


     bRESULTADO := 'TRUE';


	   SELECT TIP_PLANTARIF, COD_PLANTARIF
	   INTO   vTipPlanTarif, vCodPlanTarif
	   FROM   GA_ABOCEL
	   WHERE  NUM_ABONADO = nABONADO;

	   IF vTipPlanTarif = 'E' THEN

		  SELECT NUM_ABONADOS
		  INTO   nAbonPermitidos
		  FROM   TA_PLANTARIF
		  WHERE  COD_PRODUCTO = 1
		  AND    COD_PLANTARIF = vCodPlanTarif;

		  SELECT COUNT(*)
		  INTO   nTotalAbonados
		  FROM   GA_ABOCEL
		  WHERE  COD_CLIENTE= nCODCLIENTE
		  AND    COD_PLANTARIF = vCodPlanTarif
		  AND    COD_SITUACION NOT IN ('BAA', 'BAP');


	   	   IF (nTotalAbonados >= nAbonPermitidos) THEN
		   	  bRESULTADO := 'FALSE';
       		  vMENSAJE   := 'EL CLIENTE YA POSEE CANTIDAD MAXIMA DE ABONADOS EN AAA';
		   END IF;

	   END IF;


     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN Pv_Prc_TIP_PLANTARIF: NO SE PUEDE VALIDAR PLAN TARIFARIO DEL ABONADO.';


END PV_PRC_VAL_NUMMAXABO;
/
SHOW ERRORS
