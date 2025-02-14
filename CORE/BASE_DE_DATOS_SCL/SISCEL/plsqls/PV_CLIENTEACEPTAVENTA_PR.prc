CREATE OR REPLACE PROCEDURE PV_CLIENTEACEPTAVENTA_PR (
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
	 FROM GE_CLIENTES
	 WHERE COD_CLIENTE = vCodCliente
	 AND IND_ACEPVENT = 1;

	 IF vCantidad <> 0 THEN
	 	bRESULTADO := 'TRUE';
	 ELSE
	 	 bRESULTADO := 'FALSE';
     	 vMENSAJE   := 'El Cliente No posee la venta Acpetada';
	 END IF;


	 EXCEPTION
	 WHEN OTHERS THEN
	 	  bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_CLIENTEACEPTAVENTA_PR: NO SE PUEDE VALIDAR EL CLIENTE.'||to_char(vCodCliente);

END;
/
SHOW ERRORS
