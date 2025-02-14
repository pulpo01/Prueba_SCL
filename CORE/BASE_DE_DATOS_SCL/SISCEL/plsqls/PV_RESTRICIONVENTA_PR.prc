CREATE OR REPLACE PROCEDURE PV_RESTRICIONVENTA_PR (
							v_param_entrada IN  VARCHAR2,
							bRESULTADO      OUT VARCHAR2,
							vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
							)
IS
		  string GE_TABTYPE_VCH2ARRAY := GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

		  ---- parametros reales de entrada --------------
		  vCodCliente VE_VENDEDORES.COD_CLIENTE%TYPE;
		  --

		  vCantidad NUMBER(2) := 0;
BEGIN
	 GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
	 vCodCliente	:= TO_NUMBER(string(6));

	 SELECT COUNT(*)
	 INTO vCantidad
	 FROM VE_VENDEDORES
	 WHERE COD_CLIENTE = vCodCliente;

	 IF vCantidad = 0 THEN
	 	bRESULTADO := 'TRUE';
	 ELSE
	 	 bRESULTADO := 'FALSE';
     	 vMENSAJE   := 'CLIENTE ES VENDEDOR, NO ESTA PERMITIDO PARA REALIZAR ESTA OPERACION';
	 END IF;


	 EXCEPTION
	 WHEN OTHERS THEN
	 	  bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_RESTRICIONVENTA_PR: NO SE PUEDE VALIDAR EL CLIENTE.'||to_char(vCodCliente);

END;
/
SHOW ERRORS
