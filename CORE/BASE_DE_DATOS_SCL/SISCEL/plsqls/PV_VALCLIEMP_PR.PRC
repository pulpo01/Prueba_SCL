CREATE OR REPLACE PROCEDURE PV_VALCLIEMP_PR  (
    v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
        )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALEMPCLI_PR
-- * Descripcion        : Valida si el Cliente esta definido encontrandose en tabla ga_empresa
-- *
-- * Fecha de creacion  : 27-02-2004 09:58
-- * Responsable        : Area Postventa
-- *************************************************************

        string siscel.GE_TABTYPE_VCH2ARRAY:= siscel.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

		nCodCli                  GA_EMPRESA.COD_CLIENTE%TYPE;
		vCantidad NUMBER(2) := 0;
BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nCodCli                :=TO_NUMBER(STRING(6));

     bRESULTADO:='TRUE';
     dbms_output.PUT_LINE('CLIENTE   =' || nCodCli);

     SELECT COUNT(*)
         into
         vCantidad
         FROM GA_EMPRESA
     WHERE COD_CLIENTE = nCodCli;

        IF vCantidad > 0  THEN
           bRESULTADO := 'FALSE';
           vMENSAJE   := 'CLIENTE SE ENCUENTRA EN TABLA GA_EMPRESA. NO SE REALIZARA OPERACION';
        END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR DE ACCESO.';

END PV_VALCLIEMP_PR;
/
SHOW ERRORS
