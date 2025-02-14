CREATE OR REPLACE PROCEDURE Co_Imputacion_Contable_Depext (
p_vCodOriPago_Arg               IN VARCHAR2     ,      /* Codigo Origen de Pago */
p_vCodRecExt_Arg                IN VARCHAR2     ,      /* Numero de proceso */
p_nCodEvento                    IN NUMBER       ,      /* Codigo de Evento  */
p_vIdLote                       IN VARCHAR2     ,      /* Id. Lote          */
p_vFecValor                     IN VARCHAR2     ,      /* Fecha Valor       */
p_vCodOperadoraScl              IN VARCHAR2     ,      /* Operadora         */
p_vCodPlaza                     IN VARCHAR2            /* Plaza             */
) IS

TERMINO_CON_ERROR           EXCEPTION;

/* Variables */
v_nCodOriPago    CO_DEPOSITO_EXT.COD_ORIPAGO%TYPE;                         /* VARCHAR2 */
v_nCodRecExt     CO_DEPOSITO_EXT.COD_RECEXT%TYPE;                          /* NUMBER(2) */
v_nCodError      SC_ERROR_INGRESO.COD_ERROR%TYPE;
v_vDesError      SC_ERROR_INGRESO.DES_ERROR%TYPE;
v_nLenConcepto   SC_DOMINIO_CTO.LEN_CONCEPTO%TYPE;
v_vDesErrorOut   VARCHAR2(100);

/* ******************************************************************************************** */
/* (0) * MODULO PRINCIPAL    																	*/
/* ******************************************************************************************** */
BEGIN
	/* VALIDA_ARGUMENTOS */
	IF(  p_vCodOriPago_Arg  IS NULL ) OR ( p_vCodRecExt_Arg  IS NULL ) THEN
		RAISE_APPLICATION_ERROR( -20101, 'No se aceptan valores en null' );
	END IF;

	/*Extrae Largo del Concepto */
	SELECT B.LEN_CONCEPTO
	  INTO v_nLenConcepto
	  FROM SC_EVENTO A, SC_DOMINIO_CTO B
	 WHERE A.COD_DOMINIO_CTO = B.COD_DOMINIO_CTO
	   AND A.COD_EVENTO = p_nCodEvento;

	/* Cajas Forma de Pago */
	v_nCodRecExt := TO_NUMBER( p_vCodRecExt_Arg );
	v_nCodOriPago := TO_NUMBER( p_vCodOriPago_Arg );

	INSERT INTO SC_ENT_CAB_LOTE
	(
		COD_EVENTO,
		ID_LOTE,
		PER_CONTABLE,
		NOM_USUARIO_LOTE,
		FEC_LOTE,
		COD_OPERADORA_SCL
	)
	VALUES
	(
		p_nCodEvento,
		p_vIdLote,
		p_vFecValor,
		USER,
		SYSDATE,
		p_vCodOperadoraScl
	);

	INSERT INTO SC_ENT_LOTE
	(
		COD_EVENTO,
		ID_LOTE,
		COD_CONCEPTO,
		IMP_MOVIMIENTO,
		DES_TRANSACCION,
		COD_OPERADORA_SCL
	)
	SELECT p_nCodEvento                                                          COD_EVENTO,
		   p_vIdLote                                                             ID_LOTE,
		   Sc_Conceptogrp_Fn( p_nCodEvento, 'GE_BANCO_CTA_CTE', C.COD_CTA_CTE ) AS COD_CONCEPTO,
		   B.IMP_DEPOSITO                                                        IMP_DEPOSITO,
		   TO_CHAR( B.FEC_PAGO, 'yyyymmdd' ) || '-' || TO_CHAR( B.IMP_DEPOSITO ) DES_TRANSACCION,
		   p_vCodOperadoraScl                                                    COD_OPERADORA_SCL
	  FROM GE_BANCO_CTA_CTE C, CO_DEPOSITO_EXTDEP B , CO_DEPOSITO_EXT A
	 WHERE A.COD_RECEXT = v_nCodRecExt
	   AND A.FEC_IMPUTCONTABLE IS NULL
	   AND A.COD_RECEXT = B.COD_RECEXT
	   AND B.COD_BANCO = C.COD_BANCO
	   AND B.NUM_CUENTACTE= C.NUM_CTA_CTE;

	v_nCodError := 0;

	Sc_P_Ingresa_Lote( TO_CHAR( p_nCodEvento ), p_vIdLote, p_vCodOperadoraScl );

	SELECT COUNT(1)
	  INTO v_vDesError
	  FROM SC_ERROR_INGRESO
	 WHERE COD_EVENTO = p_nCodEvento
	   AND ID_LOTE = p_vIdLote
	   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

	IF v_nCodError <> 0   THEN

		SELECT COD_ERROR, DES_ERROR
		  INTO v_nCodError, v_vDesError
		  FROM SC_ERROR_INGRESO
		 WHERE COD_EVENTO = p_nCodEvento
		   AND ID_LOTE = p_vIdLote
		   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

		v_vDesErrorOut := TO_CHAR( v_nCodError, '09' ) || ' - ' || v_vDesError;
		RAISE_APPLICATION_ERROR( -20102, v_vDesErrorOut );

	END IF;

	UPDATE CO_DEPOSITO_EXT
	   SET FEC_IMPUTCONTABLE = SYSDATE
	 WHERE COD_ORIPAGO = v_nCodOriPago
	   AND COD_RECEXT = v_nCodRecExt;

	COMMIT;

	DBMS_OUTPUT.PUT_LINE('Proceso Termino Ok');

END Co_Imputacion_Contable_Depext;
/
SHOW ERRORS
