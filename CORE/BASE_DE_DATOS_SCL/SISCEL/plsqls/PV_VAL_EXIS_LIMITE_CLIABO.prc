CREATE OR REPLACE PROCEDURE PV_VAL_EXIS_LIMITE_CLIABO(V_PARAM_ENTRADA IN  VARCHAR2,
          		  									  bRESULTADO      OUT VARCHAR2,
        											  vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE)

IS

	string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
	nCLIENTE	GA_ABOCEL.COD_CLIENTE%TYPE;
	vCodModulo  GA_SUSPREHABO.COD_MODULO%TYPE;
	vCOUNT          INT;

BEGIN

	bRESULTADO := 'TRUE';
	vMENSAJE   := '';

	Ge_Pac_Arreglopr.GE_PR_RetornaArreglo(v_param_entrada, string);
	nABONADO   := TO_NUMBER(string(5));
	nCLIENTE   := TO_NUMBER(string(6));

	SELECT COUNT(*)
	INTO VCOUNT
	FROM GA_LIMITE_CLIABO_TO
	WHERE COD_CLIENTE =  nCLIENTE
	AND NUM_ABONADO = nABONADO;

	IF VCOUNT = 0 THEN
		bRESULTADO := 'FALSE';
		vMENSAJE   := 'No Existen Datos de Limite de Consumo para Cliente/Abonado (GA_LIMITE_CLIABO_TO) ';
	END IF;

EXCEPTION

    WHEN OTHERS THEN

		bRESULTADO := 'FALSE';
		vMENSAJE   := 'ERROR EN PV_VAL_EXIS_LIMITE_CLIABO: NO SE PUEDE VALIDAR EXISTENCIA DE DATOS.';


END;
/
SHOW ERRORS
