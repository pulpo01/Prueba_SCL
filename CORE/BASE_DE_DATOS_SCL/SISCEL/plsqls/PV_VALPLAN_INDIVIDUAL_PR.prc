CREATE OR REPLACE PROCEDURE PV_VALPLAN_INDIVIDUAL_PR (
   	   	  		  			v_param_entrada IN  VARCHAR2,
							bRESULTADO      OUT VARCHAR2,
							vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
    						)
IS
-- *************************************************************
-- * procedimiento      : PV_VALPLAN_INDIVIDUAL_PR
-- * Descripcion        : Valida que el plan tarifario del abonado sea Individual.
-- *
-- * Fecha de creacion  : 15-01-2004
-- * Responsable        : Area Postventa
-- *************************************************************

    string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

    sCodPlanTarif  GA_PLANUSO.COD_PLANTARIF%TYPE;
	sCodPlanT	   GA_PLANUSO.COD_PLANTARIF%TYPE;

BEGIN
    GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
    sCodPlanTarif := string(12);

    bRESULTADO:='TRUE';

	SELECT TIP_PLANTARIF INTO sCodPlanT FROM TA_PLANTARIF WHERE COD_PLANTARIF = sCodPlanTarif AND TIP_PLANTARIF = 'I';

EXCEPTION WHEN NO_DATA_FOUND THEN
	 bRESULTADO :='FALSE';
     vMENSAJE   :='El abonado no cumple las condiciones que exige el mantenimiento, ';
     vMENSAJE   := vMENSAJE || 'ya que su Tipo de Plan Tarifario No es Individual ' ;
WHEN OTHERS  THEN
     bRESULTADO :='FALSE';
     vMENSAJE   :='Error de Acceso';

END PV_VALPLAN_INDIVIDUAL_PR;
/
SHOW ERRORS
