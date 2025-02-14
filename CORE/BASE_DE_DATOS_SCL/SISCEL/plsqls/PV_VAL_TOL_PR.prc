CREATE OR REPLACE PROCEDURE PV_VAL_TOL_PR (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VAL_TOL_PR
-- * Descripcion        : Procedimiento que valida si esta Tol On-Line
-- * Fecha de creacion  : 13-01-2003 12:42
-- * Responsable        : Area Postventa
-- *************************************************************
     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

     vRESP VARCHAR2(6);
BEGIN
     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
	    bRESULTADO := 'TRUE';
     vRESP:= PV_VAL_EXIST_TOL_FN();
     IF vRESP = 'TRUE' THEN
           bRESULTADO := 'TRUE';
           vMENSAJE   := 'TOL ON-LINE EN BASE DE DATOS HABILITADO';
					ELSIF vRESP = 'FALSE' OR vRESP = 'ERROR' THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_VAL_TOL_PR: BASE DE DATOS INDICA TOL ON-LINE NO HABILITADO.';
     END IF;
     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_VAL_TOL_PR: BASE DE DATOS INDICA TOL ON-LINE NO HABILITADO.';

END;
/
SHOW ERRORS
