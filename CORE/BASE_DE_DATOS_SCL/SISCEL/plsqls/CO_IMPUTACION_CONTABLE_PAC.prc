CREATE OR REPLACE PROCEDURE Co_Imputacion_Contable_Pac (
p_vCodBanco			IN VARCHAR2,      /* Codigo Origen de Pago */
p_vFecValor			IN VARCHAR2,      /* Numero de proceso */
p_vPerContable		IN VARCHAR2,      /* SAAM-20030404 */
p_vIdLote			IN VARCHAR2,      /* SAAM-20030404 */
p_vCodOperadoraScl	IN VARCHAR2,      /* SAAM-20030404 */
p_nCodEvento		IN NUMBER
) IS

/* Variables */
v_nCodError			SC_ERROR_INGRESO.COD_ERROR%TYPE;
v_vDesError			SC_ERROR_INGRESO.DES_ERROR%TYPE;
v_nLenConcepto		SC_DOMINIO_CTO.LEN_CONCEPTO%TYPE;
v_vDesErrorOut		VARCHAR2(100);

/* ******************************************************************************************** */
/* (0) * MODULO PRINCIPAL    																	*/
/* ******************************************************************************************** */
BEGIN

	SELECT B.LEN_CONCEPTO
	  INTO v_nLenConcepto
	  FROM SC_EVENTO A, SC_DOMINIO_CTO B
	 WHERE A.COD_DOMINIO_CTO = B.COD_DOMINIO_CTO
	   AND A.COD_EVENTO = p_nCodEvento;

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
		TO_NUMBER( p_vPerContable ),
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
		COD_OPERADORA_SCL
	)
	SELECT p_nCodEvento							  COD_EVENTO,
		   p_vIdLote							  ID_LOTE,
		   Sc_Conceptogrp_Fn( p_nCodEvento, 'GE_BANCOS', COD_BANCO ) COD_CONCEPTO,
		   SUM( IMPORTE_DEBE )					  IMP_CONCEPTO,
		   p_vCodOperadoraScl					  COD_OPERADORA_SCL
	  FROM CO_PAGOSPAC
	 WHERE TRUNC( FEC_VALOR ) = TO_DATE( p_vFecValor, 'YYYYMMDD' )
	   AND COD_BANCO = p_vCodBanco
	   AND IND_CANCELADO = 1
	   AND FEC_IMPUTCONTABLE IS NULL
	   AND COD_OPERADORA = p_vCodOperadoraScl
	GROUP BY COD_BANCO, COD_OPERADORA;

	Sc_P_Ingresa_Lote( TO_CHAR( p_nCodEvento ), p_vIdLote, p_vCodOperadoraScl );

	v_nCodError := 0;

	SELECT COUNT(1)
	  INTO v_nCodError
	  FROM SC_ERROR_INGRESO
	 WHERE COD_EVENTO = p_nCodEvento
	   AND ID_LOTE = p_vIdLote
	   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

	IF v_nCodError = 0   THEN

		/* ACTUALIZO TRANSACCION DE CO_PAGOSPAC EN SU FECHA DE IMPUTACION CONTABLE */
		UPDATE CO_PAGOSPAC
		   SET FEC_IMPUTCONTABLE = SYSDATE
		 WHERE FEC_VALOR = TO_DATE( p_vFecValor, 'YYYYMMDD' )
		   AND COD_BANCO = p_vCodBanco
		   AND IND_CANCELADO = 1
		   AND FEC_IMPUTCONTABLE IS NULL
		   AND COD_OPERADORA = p_vCodOperadoraScl;

	END IF;

	COMMIT;

	DBMS_OUTPUT.PUT_LINE( 'Proceso Termino Ok' );

END Co_Imputacion_Contable_Pac;
/
SHOW ERRORS
