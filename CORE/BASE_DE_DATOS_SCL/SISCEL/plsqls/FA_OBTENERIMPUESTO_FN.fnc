CREATE OR REPLACE FUNCTION FA_ObtenerImpuesto_FN(sCodCliente IN NUMBER, sUser IN VARCHAR2 )	 RETURN NUMBER
IS
	vCodAbonocel NUMBER;
	vCodCatimpos NUMBER;
	vCodTipconce NUMBER;
	vCodIeps NUMBER;
	vNumProceso NUMBER;
	vPrcImpuesto NUMBER;
	vCodOficina ge_seg_usuario.cod_oficina%TYPE;
	ERROR_CODCONCEPTO EXCEPTION;
	ERROR_CATIMPOSITIVA EXCEPTION;
	ERROR_TIPCONCEPTO EXCEPTION;
	ERROR_CODOFICINA EXCEPTION;
	ERROR_CODIEPS EXCEPTION;
	ERROR_INSERT EXCEPTION;
	ERROR_NUMPROCESO EXCEPTION;
	ERROR_PROCESURE EXCEPTION;
	ERROR_PRCIMPUESTO EXCEPTION;
	VP_PROC VARCHAR2(50);
	VP_TABLA VARCHAR2(50);
    VP_ACT VARCHAR2(50);
    VP_SQLCODE VARCHAR2(50);
    VP_SQLERRM VARCHAR2(50);
    VP_ERROR VARCHAR2(50);

	BEGIN

		-- Numero de Proceso
		BEGIN
			SELECT fas_presuptemp.NEXTVAL INTO vNumProceso FROM DUAL;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
			   RAISE ERROR_NUMPROCESO;
		END;

		-- Codigo de concepto para el cargo basico
		BEGIN
			SELECT cod_abonocel INTO vCodAbonocel
			FROM fa_datosgener;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
			   RAISE ERROR_CODCONCEPTO;
		END;

		-- Categoria impositiva del cliente
		BEGIN
			SELECT cod_catimpos INTO vCodCatimpos
			FROM ge_catimpclientes
			WHERE cod_cliente = sCodCliente
			AND SYSDATE BETWEEN fec_desde AND fec_hasta;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
			   RAISE ERROR_CATIMPOSITIVA;
		END;

		-- Tipo de concepto
		BEGIN
			SELECT cod_tipconce INTO vCodTipconce
			FROM fa_conceptos
			WHERE cod_concepto = vCodAbonocel;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
			   RAISE ERROR_TIPCONCEPTO;
		END;

		-- Concepto IEPS
		BEGIN
			SELECT val_numerico INTO vCodIeps
			FROM fad_parametros
			WHERE cod_parametro = 102;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
			   RAISE ERROR_CODIEPS;
		END;

		-- Obtencion de la oficina del usuario
		BEGIN
			SELECT cod_oficina INTO vCodOficina
			FROM ge_seg_usuario
			WHERE nom_usuario = sUser;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
			   RAISE ERROR_CODOFICINA;
		END;

		BEGIN
			INSERT INTO fat_presuptemp (num_proceso,cod_concepto,columna,
			cod_cliente,fec_efectividad,imp_concepto,imp_facturable,cod_tipconce)
			VALUES (vNumProceso, vCodAbonocel, 1, sCodCliente, SYSDATE, 100, 100, vCodTipconce);
		EXCEPTION
			WHEN OTHERS THEN
			   RAISE ERROR_INSERT;
		END;

		BEGIN
 			fa_proc_imptos(vNumProceso, vCodCatimpos, vCodOficina, VP_PROC,	VP_TABLA, VP_ACT, VP_SQLCODE, VP_SQLERRM, VP_ERROR);
 		EXCEPTION
			WHEN OTHERS THEN
			   RAISE ERROR_PROCESURE;
		END;

		BEGIN
	  		SELECT SUM(prc_impuesto) INTO vPrcImpuesto
			FROM fat_presuptemp
			WHERE num_proceso = vNumProceso
			AND (cod_tipconce = 1 OR cod_tipconce = 2)
			AND cod_concepto <> vCodIeps;
		EXCEPTION
			WHEN OTHERS THEN
			   RAISE ERROR_PRCIMPUESTO;
		END;

		return vPrcImpuesto;
	EXCEPTION
		WHEN ERROR_CODCONCEPTO THEN
	  		RAISE_APPLICATION_ERROR (-20002, 'No se pudo obtener la informacion del Codigo de Concepto');
	  		RETURN -1;
	  	WHEN ERROR_CATIMPOSITIVA THEN
	  		RAISE_APPLICATION_ERROR (-20002, 'No se pudo obtener la informacion de la Categoria Impositiva');
	  		RETURN -1;
	  	WHEN ERROR_TIPCONCEPTO THEN
	  		RAISE_APPLICATION_ERROR (-20002, 'No se pudo obtener la informacion del Tipo de Concepto');
	  		RETURN -1;
	  	WHEN ERROR_CODIEPS THEN
	  		RAISE_APPLICATION_ERROR (-20002, 'No se pudo obtener la informacion del Codigo IEPS');
	  		RETURN -1;
	  	WHEN ERROR_CODOFICINA THEN
	  		RAISE_APPLICATION_ERROR (-20002, 'No se pudo obtener la informacion del Codigo de Oficina');
	  		RETURN -1;
	  	WHEN ERROR_INSERT THEN
	  		RAISE_APPLICATION_ERROR (-20002, 'No se pudo realizar el insert en la tabla FAT_PRESUPTEMP');
	  		RETURN -1;
	  	WHEN ERROR_PROCESURE THEN
	  		RAISE_APPLICATION_ERROR (-20002, 'Fallo la llamada el procedimiento almacenado FA_PROC_IMPTOS');
	  		RETURN -1;
	  	WHEN ERROR_PRCIMPUESTO THEN
	  		RAISE_APPLICATION_ERROR (-20002, 'No se pudo obtener la informacion del Impuesto');
	  		RETURN -1;
	  	WHEN OTHERS THEN
	    	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Obtener el Impuesto');
	    	RETURN -1;
	END;
/
SHOW ERRORS
