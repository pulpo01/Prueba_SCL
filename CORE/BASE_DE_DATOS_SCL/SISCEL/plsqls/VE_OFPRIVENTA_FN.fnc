CREATE OR REPLACE FUNCTION VE_OFPRIVENTA_FN (sCodCliente IN NUMBER) RETURN VARCHAR2
IS
	vCodOficina ge_clientes.cod_oficina%TYPE;
	ERROR_CODOFICINA EXCEPTION;

	BEGIN

		-- Obtencion de la oficina de la primera venta
		-- Si el codigo de oficina es blanco o nulo, se retornan 2 caracteres blancos.
		BEGIN
			SELECT NVL(COD_OFICINA,'  ') INTO vCodOficina
			FROM   GE_CLIENTES
			WHERE  COD_CLIENTE = sCodCliente;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				 RAISE ERROR_CODOFICINA;
		END;

		return vCodOficina;
	EXCEPTION

	  	WHEN ERROR_CODOFICINA THEN
	  		RAISE_APPLICATION_ERROR (-20002, 'No se pudo obtener la informacion del codigo de la oficina de la primera venta');
	  		RETURN -1;
	  	WHEN OTHERS THEN
	    	RAISE_APPLICATION_ERROR (-20002, 'No se pudo obtener la Oficina');
	    	RETURN -1;
	END;
/
SHOW ERRORS
