CREATE OR REPLACE PROCEDURE Co_Imputacion_Contable_Anomext
(p_vCodOriPago_Arg  IN VARCHAR2			/* Codigo Origen de Pago */
,p_vCodRecExt_Arg   IN VARCHAR2			/* Numero de proceso */
)
IS

TERMINO_CON_ERROR           EXCEPTION;

/* Variables */
v_nCodOriPago		CO_RECAUDAEXT.COD_ORIPAGO%TYPE;
v_nCodRecExt		CO_RECAUDAEXT.COD_RECEXT%TYPE;
v_nCodEvento		SC_EVENTO.COD_EVENTO%TYPE;
v_vIdLote			SC_ENT_LOTE.ID_LOTE%TYPE;
v_vCodOperadoraScl	SC_ENT_LOTE.COD_OPERADORA_SCL%TYPE;
v_nCodError			SC_ERROR_INGRESO.COD_ERROR%TYPE;
v_vDesError			SC_ERROR_INGRESO.DES_ERROR%TYPE;
v_vDesErrorOut		VARCHAR2(100);

/* ******************************************************************************************** */
/* (0) * MODULO PRINCIPAL    																	*/
/* ******************************************************************************************** */
BEGIN
	/* VALIDA_ARGUMENTOS */
	IF (  p_vCodOriPago_Arg  IS NULL ) OR ( p_vCodRecExt_Arg  IS NULL ) THEN
		RAISE_APPLICATION_ERROR( -20101, 'No se aceptan valores en null' );
	END IF;

	SELECT A.COD_OPERADORA_SCL
	  INTO v_vCodOperadoraScl
	  FROM GE_OPERADORA_SCL_LOCAL A, GE_OPERPLAZA_TD B
	 WHERE A.COD_OPERADORA_SCL = B.COD_OPERADORA_SCL;

	/* Cajas Forma de Pago */
	v_nCodRecExt := TO_NUMBER( p_vCodRecExt_Arg );
	v_nCodOriPago := TO_NUMBER( p_vCodOriPago_Arg );
	v_nCodEvento := 23;
	v_vIdLote := p_vCodOriPago_Arg || '/' || p_vCodRecExt_Arg || '/' || TO_CHAR( SYSDATE, 'yyyymmddhh24mi' );

	INSERT INTO SC_ENT_CAB_LOTE
	(
		COD_EVENTO,
		ID_LOTE,
		PER_CONTABLE,
		NOM_USUARIO_LOTE,
		FEC_LOTE,
		COD_OPERADORA_SCL
	)
	SELECT DISTINCT v_nCodEvento			COD_EVENTO,
		   v_vIdLote						ID_LOTE,
		   TO_CHAR( A.FEC_VALOR, 'YYYYMM' ) PER_CONTABLE,
		   USER								NOM_USUARIO_LOTE,
		   SYSDATE							FEC_LOTE,
		   v_vCodOperadoraScl				COD_OPERADORA_SCL
	  FROM CO_ANOMALIAREXT B, CO_RECAUDAEXT A
	 WHERE A.COD_ORIPAGO = v_nCodOriPago
	   AND A.COD_RECEXT = v_nCodRecExt
	   AND A.COD_RECEXT = B.COD_RECEXT
	   AND B.COD_ANOMALIA IN (-1)
	   AND B.FEC_IMPUTCONTABLE IS NULL;

	INSERT INTO SC_ENT_LOTE
	(
		COD_EVENTO,
		ID_LOTE,
		COD_CONCEPTO,
		IMP_MOVIMIENTO,
		COD_OPERADORA_SCL
	)
	SELECT v_nCodEvento										COD_EVENTO,
		   v_vIdLote										ID_LOTE,
		   Sc_Conceptogrp_Fn( v_nCodEvento, 'CO_ORIGENPAGO', v_nCodOriPago ) AS COD_CONCEPTO,
		   SUM( TO_NUMBER( SUBSTR( B.VALOR, 37, 10 ) ) )	IMP_CONCEPTO,
		   v_vCodOperadoraScl								COD_OPERADORA_SCL
	  FROM CO_ANOMALIAREXT B, CO_RECAUDAEXT A
	 WHERE A.COD_ORIPAGO = v_nCodOriPago
	   AND A.COD_RECEXT = v_nCodRecExt
	   AND A.COD_RECEXT = B.COD_RECEXT
	   AND B.COD_ANOMALIA IN ( -1 )
	   AND B.FEC_IMPUTCONTABLE IS NULL;

	Sc_P_Ingresa_Lote( TO_CHAR( v_nCodEvento ), v_vIdLote, v_vCodOperadoraScl );

	SELECT COUNT(1)
	  INTO v_nCodError
	  FROM SC_ERROR_INGRESO
	 WHERE COD_EVENTO = v_nCodEvento
	   AND ID_LOTE = v_vIdLote;

	IF v_nCodError > 0 THEN

		ROLLBACK;

		SELECT COD_ERROR, DES_ERROR
		  INTO v_nCodError, v_vDesError
		  FROM SC_ERROR_INGRESO
		 WHERE COD_EVENTO = v_nCodEvento
		   AND ID_LOTE = v_vIdLote;

		v_vDesErrorOut := TO_CHAR( v_nCodError, '09' ) || ' - ' || v_vDesError;
		RAISE_APPLICATION_ERROR( -20102, v_vDesErrorOut );

	END IF;

	/* ACTUALIZO TRANSACCION DE CO_ANOMALIAREXT EN SU FECHA DE IMPUTACION CONTABLE */
	UPDATE CO_ANOMALIAREXT
	   SET FEC_IMPUTCONTABLE = SYSDATE
	 WHERE COD_RECEXT = v_nCodRecExt
	   AND COD_ANOMALIA IN ( -1, -2 )
	   AND FEC_IMPUTCONTABLE IS NULL;

	COMMIT;

	DBMS_OUTPUT.PUT_LINE('Proceso Termino Ok');

END Co_Imputacion_Contable_Anomext;
/
SHOW ERRORS
