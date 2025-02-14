CREATE OR REPLACE PROCEDURE Pv_Prc_Cliente_Val_Situacion (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

         nCLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
     vACTABO     GA_ACTABO.COD_ACTABO%TYPE;

------------------------------------------------

     vCantidad    NUMBER(2) := 0;
     --Inicio RA-200601190618 PBR, 26-01-2006
     --vCantidadAAA NUMBER(2) := 0;
     vCantidadAAA NUMBER(5) := 0;
     --Fin RA-200601190618 PBR, 26-01-2006
BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
         nCLIENTE               := TO_NUMBER(string(6));
     vACTABO            := string(4);

     bRESULTADO := 'TRUE';

     SELECT COUNT(*)
     INTO   vCantidad
     FROM   GA_ABOCEL A
     WHERE  A.COD_CLIENTE    = nCLIENTE
     AND    A.COD_SITUACION NOT IN (SELECT COD_SITUACION
                                    FROM   PVD_ACTUACION_SITUACION B
                                    WHERE  B.COD_PRODUCTO  = A.COD_PRODUCTO
                                    AND    B.COD_ACTABO    = vACTABO
                                    AND    B.COD_SITUACION = A.COD_SITUACION);

     IF vCantidad > 0 THEN
        bRESULTADO := 'FALSE';
            vMENSAJE   := 'CLIENTE CUENTA CON ABONADOS QUE TIENE UNA SITUACION NO PERMITIDA PARA ESTA OPERACION';
     END IF;

         -- Se cuenta los abonados con situacion = 'AAA'
     SELECT COUNT(*)
     INTO   vCantidadAAA
     FROM   GA_ABOCEL A
     WHERE  A.COD_CLIENTE    = nCLIENTE
     AND    A.COD_SITUACION = 'AAA';

     IF vCantidadAAA = 0 THEN
           bRESULTADO := 'FALSE';
                   vMENSAJE   := 'CLIENTE DEBE TENER AL MENOS UN ABONADO CON SITUACION : ALTA ACTIVA ABONADO.';
     END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
                  vMENSAJE   := 'ERROR EN PV_PRC_VAL_SITUACION_CLIENTE: NO SE PUEDE VALIDAR SITUACION DEL CLIENTE.';


END;
/
SHOW ERRORS
