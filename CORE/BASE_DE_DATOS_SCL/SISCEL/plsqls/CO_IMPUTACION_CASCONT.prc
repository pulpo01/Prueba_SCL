CREATE OR REPLACE PROCEDURE CO_IMPUTACION_CASCONT
(p_vProceso			IN VARCHAR2       /* Numero Proceso    */
,p_vFecProceso		IN VARCHAR2       /* Fecha Proceso     */
,p_vFecTransaccion	IN VARCHAR2       /* Fecha Transaccion */
,p_nTipMovimiento	IN NUMBER         /* Tipo de Movimiento*/
,p_vIdLote			IN VARCHAR2       /* Identificador Lote*/
,p_nCodEvento		IN NUMBER         /* Tipo de Movimiento*/
,p_vPeriodo			IN VARCHAR2       /* Periodo COntable  */
,p_vCodOperadoraScl	IN VARCHAR2       /* Operadora         */
) IS

/* Variables */
v_nCodError		SC_ERROR_INGRESO.COD_ERROR%TYPE;
v_vDesError		SC_ERROR_INGRESO.DES_ERROR%TYPE;
v_vDesErrorOut	VARCHAR2(100);
v_vTipoApertura	GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_vCodOficina	CO_CASTIGO_CONTABLE.COD_APERTURA%TYPE;
v_vIdLote       SC_ENT_CAB_LOTE.ID_LOTE%TYPE;


/*Cursor de Oficinas del Proceso*/
CURSOR CURSOR_OFICINASCASTIGOS IS
    SELECT DISTINCT COD_APERTURA
    FROM CO_CASTIGO_CONTABLE
    WHERE  NUM_PROCESO = p_vProceso
	   AND TO_CHAR( FEC_PROCESO, 'DDMMYYYY' ) = p_vFecProceso
	   AND TO_CHAR( FEC_TRANSACCION, 'DDMMYYYY' ) = p_vFecTransaccion
	   AND TIP_MOVIMIEN = p_nTipMovimiento
	   AND FEC_IMPUTCONTABLE IS NULL;

/* ******************************************************************************************** */
/* (0) * MODULO PRINCIPAL    																	*/
/* ******************************************************************************************** */
BEGIN

	-- Obtiene Indicador de Apertura
	SELECT VAL_PARAMETRO
	INTO v_vTipoApertura
	FROM GED_PARAMETROS
	WHERE COD_MODULO = 'SC'
	AND NOM_PARAMETRO = 'IND_APERTURA';

	v_vTipoApertura := TRIM( v_vTipoApertura );

	IF v_vTipoApertura = 'OFICINA' THEN
	   FOR OFICINAS IN CURSOR_OFICINASCASTIGOS LOOP
	   	   v_vCodOficina := OFICINAS.COD_APERTURA;
	   	   v_vIdLote := p_vIdLote || '/' || v_vCodOficina;
			/*Encabezado */
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
				v_vIdLote,
				p_vPeriodo,
				USER,
				SYSDATE,
				p_vCodOperadoraScl
			);

			/*Detalle */
			INSERT INTO SC_ENT_LOTE
			(
				COD_EVENTO,
				ID_LOTE,
				COD_CONCEPTO,
				IMP_MOVIMIENTO,
				DES_TRANSACCION,
				COD_OPERADORA_SCL
			)
			SELECT p_nCodEvento,
				   v_vIdLote,
				   Sc_Conceptogrp_Fn( p_nCodEvento, 'CO_TIPMOV_CASTIGO', TIP_MOVIMIEN, 'GE_OFICINAS', v_vCodOficina ) AS COD_CONCEPTO,
				   SUM( IMPORTE ),
				   'IMPUTACION CASTIGOS CONTABLES',
				   p_vCodOperadoraScl
			  FROM CO_CASTIGO_CONTABLE
			 WHERE NUM_PROCESO = p_vProceso
			   AND TO_CHAR( FEC_PROCESO, 'DDMMYYYY' ) = p_vFecProceso
			   AND TO_CHAR( FEC_TRANSACCION, 'DDMMYYYY' ) = p_vFecTransaccion
			   AND TIP_MOVIMIEN = p_nTipMovimiento
			   AND COD_APERTURA = v_vCodOficina
			GROUP BY TIP_MOVIMIEN;

			Sc_P_Ingresa_Lote( TO_CHAR( p_nCodEvento ), v_vIdLote, p_vCodOperadoraScl );
		END LOOP;
		v_nCodError := 0;

		SELECT COUNT(1)
		  INTO v_nCodError
		  FROM SC_ERROR_INGRESO
		 WHERE COD_EVENTO = p_nCodEvento
		   AND ID_LOTE LIKE p_vIdLote || '/%'
		   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

		IF v_nCodError <> 0   THEN

			SELECT Cod_Error, Des_Error
			  INTO v_nCodError, v_vDesError
			  FROM SC_ERROR_INGRESO
			 WHERE COD_EVENTO = p_nCodEvento
			   AND ID_LOTE LIKE p_vIdLote || '/%'
			   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

			v_vDesErrorOut := TO_CHAR( v_nCodError, '09' ) || ' - ' || v_vDesError;
			RAISE_APPLICATION_ERROR( -20102, v_vDesErrorOut );

		END IF;
	ELSE
		v_vIdLote := p_vIdLote;
		/*Encabezado */
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
			v_vIdLote,
			p_vPeriodo,
			USER,
			SYSDATE,
			p_vCodOperadoraScl
		);

		/*Detalle */
		INSERT INTO SC_ENT_LOTE
		(
			COD_EVENTO,
			ID_LOTE,
			COD_CONCEPTO,
			IMP_MOVIMIENTO,
			DES_TRANSACCION,
			COD_OPERADORA_SCL
		)
		SELECT p_nCodEvento,
			   v_vIdLote,
			   Sc_Conceptogrp_Fn( p_nCodEvento, 'CO_TIPMOV_CASTIGO', TIP_MOVIMIEN ) AS COD_CONCEPTO,
			   SUM( IMPORTE ),
			   'IMPUTACION CASTIGOS CONTABLES',
			   p_vCodOperadoraScl
		  FROM CO_CASTIGO_CONTABLE
		 WHERE NUM_PROCESO = p_vProceso
		   AND TO_CHAR( FEC_PROCESO, 'DDMMYYYY' ) = p_vFecProceso
		   AND TO_CHAR( FEC_TRANSACCION, 'DDMMYYYY' ) = p_vFecTransaccion
		   AND TIP_MOVIMIEN = p_nTipMovimiento
		GROUP BY TIP_MOVIMIEN;

		Sc_P_Ingresa_Lote( TO_CHAR( p_nCodEvento ), v_vIdLote, p_vCodOperadoraScl );

		v_nCodError := 0;

		SELECT COUNT(1)
		  INTO v_nCodError
		  FROM SC_ERROR_INGRESO
		 WHERE COD_EVENTO = p_nCodEvento
		   AND ID_LOTE = p_vIdLote
		   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

		IF v_nCodError <> 0   THEN

			SELECT Cod_Error, Des_Error
			  INTO v_nCodError, v_vDesError
			  FROM SC_ERROR_INGRESO
			 WHERE COD_EVENTO = p_nCodEvento
			   AND ID_LOTE = p_vIdLote
			   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

			v_vDesErrorOut := TO_CHAR( v_nCodError, '09' ) || ' - ' || v_vDesError;
			RAISE_APPLICATION_ERROR( -20102, v_vDesErrorOut );

		END IF;
    END IF;


	UPDATE CO_CASTIGO_CONTABLE
	   SET FEC_IMPUTCONTABLE = SYSDATE
	 WHERE FEC_IMPUTCONTABLE IS NULL
	   AND NOT EXISTS ( SELECT 1
						  FROM SC_ERROR_INGRESO
						 WHERE COD_EVENTO = p_nCodEvento
						   AND ID_LOTE = v_vIdLote
						   AND COD_OPERADORA_SCL = p_vCodOperadoraScl );

	COMMIT;

	DBMS_OUTPUT.PUT_LINE('Proceso Termino Ok');

END CO_IMPUTACION_CASCONT;
/
SHOW ERRORS
