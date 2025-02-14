CREATE OR REPLACE PROCEDURE        PV_PRC_VAL_SITUACION (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
     vACTABO     GA_ACTABO.COD_ACTABO%TYPE;

------------------------------------------------

     vCantidad NUMBER(2) := 0;

BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO 		:= TO_NUMBER(string(5));
     vACTABO  		:= string(4);

     bRESULTADO := 'TRUE';

     SELECT COUNT(*)
     INTO   vCantidad
     FROM   GA_ABOCEL A
     WHERE  A.NUM_ABONADO    = nABONADO
     AND    A.COD_SITUACION IN (SELECT COD_SITUACION
                                FROM   PVD_ACTUACION_SITUACION B
                                WHERE  B.COD_PRODUCTO  = A.COD_PRODUCTO
                                AND    B.COD_ACTABO    = vACTABO
                                AND    B.COD_SITUACION = A.COD_SITUACION);

     IF vCantidad = 0 THEN
        SELECT COUNT(*)
        INTO   vCantidad
        FROM   GA_ABOAMIST A
        WHERE  A.NUM_ABONADO    = nABONADO
        AND    A.COD_SITUACION IN (SELECT COD_SITUACION
                                   FROM   PVD_ACTUACION_SITUACION B
                                   WHERE  B.COD_PRODUCTO  = A.COD_PRODUCTO
                                   AND    B.COD_ACTABO    = vACTABO
                                   AND    B.COD_SITUACION = A.COD_SITUACION);
        IF vCantidad = 0 THEN
           bRESULTADO := 'FALSE';
           vMENSAJE   := 'SITUACION DE ABONADO NO ES PERMITIDA PARA ESTA OPERACION';
        END IF;
     END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_PRC_VAL_SITUACION: NO SE PUEDE VALIDAR SITUACION DEL ABONADO.';


END;
/
SHOW ERRORS
