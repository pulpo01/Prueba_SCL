CREATE OR REPLACE FUNCTION SISCEL.Fn_Val_MigTecnologia (sNUMABONADO VARCHAR2)
/******************************************************************************
CREADO   : 11/02/2003
AUTOR    : MANUEL ACEVEDO
AREA     : POSTVENTA
EMPRESA  : TELEFONICA MOVIL SOLUTION S.A.
******************************************************************************/
RETURN VARCHAR2 IS

nNUM_ABONADO	GA_ABOCEL.NUM_ABONADO%TYPE;
sTEC_ACTUAL		GA_ABOCEL.COD_TECNOLOGIA%TYPE;
sTEC_ORIGEN		GA_ABOCEL.COD_TECNOLOGIA%TYPE;
nCELU_ACTUAL	GA_ABOCEL.NUM_CELULAR%TYPE;
nCENTRAL_ORI	GA_CELNUM_USO.COD_CENTRAL%TYPE;
sRESULTADO		VARCHAR2(5);

sMSGERROR	 	VARCHAR2(200);
vParametro      VARCHAR2(200);

BEGIN

        Select  VAL_PARAMETRO INTO vParametro FROM GED_PArametros Where COD_Producto = 1 AND COD_Modulo = 'IC' AND NOM_PARAMETRO = 'VALIDAR_MIGRACION';
        
	 	nNUM_ABONADO := TO_NUMBER(sNUMABONADO);

        IF vParametro <> 'FALSE' THEN
            sMSGERROR := 'Error, al obtener Tecnologia para el abonado: ' || sNUMABONADO;

    		SELECT COD_TECNOLOGIA,NUM_CELULAR
    		INTO   sTEC_ACTUAL, nCELU_ACTUAL
    		FROM   GA_ABOCEL
    		WHERE  NUM_ABONADO = nNUM_ABONADO;

            sMSGERROR := 'Error, al obtener Central para el celular: ' || nCELU_ACTUAL;

    		SELECT COD_CENTRAL
    		INTO   nCENTRAL_ORI
    		FROM   GA_CELNUM_USO
    		WHERE  nCELU_ACTUAL BETWEEN NUM_DESDE AND NUM_HASTA;

            sMSGERROR := 'Error, al obtener Tecnologia para la central: ' || nCENTRAL_ORI;

    		SELECT COD_TECNOLOGIA
    		INTO   sTEC_ORIGEN
    		FROM   ICG_CENTRAL
    		WHERE  COD_CENTRAL =  nCENTRAL_ORI
    		AND    COD_PRODUCTO = 1;

    		if sTEC_ORIGEN <> sTEC_ACTUAL then
    		    RETURN 'TRUE';
    		else
    			RETURN 'FALSE';
    		end if;
        ELSE
            RETURN 'FALSE';
        END IF;

EXCEPTION
WHEN OTHERS THEN
   RETURN sMSGERROR;
END;
/
