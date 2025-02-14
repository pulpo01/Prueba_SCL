CREATE OR REPLACE PROCEDURE Co_Imputacion_Contable_Regu3
IS

CURSOR c_Regulacion IS
SELECT NUM_DOC_RESPALDO,
	   TO_CHAR( FEC_REGULARIZA, 'YYYYMMDD' )	AS FECHA_REGU,
	   USER_REGULARIZA							AS NOM_REGU,
	   NVL( COD_OPERADORA_SCL_ORI, 'NULO' )		AS COD_OPERADORA_ORIGEN,
	   NVL( COD_OPERADORA_SCL_DEST, 'NULO' )	AS COD_OPERADORA_DESTINO,
	   NVL( APERTURA_ORIGEN, 'NULO' )			AS APERTURA_ORIGEN,
	   NVL( APERTURA_DESTINO, 'NULO' )			AS APERTURA_DESTINO,
	   TIPO_REGULARIZA							AS TIP_REGULARIZACION
  FROM CO_HIST_REGULARIZA
 WHERE ( ( TIPO_REGULARIZA IN ( 65, 67, 68 ) AND STS_REGULARIZA = 'O' )	-- Aplicaciones OK
	   OR ( TIPO_REGULARIZA = 66 AND STS_REGULARIZA = 'D' ) )			-- Desaplicaciones OK
   AND FEC_IMPUTACION_CONT IS NULL                                  	-- No Esta Contabilizado
   AND FEC_REGULARIZA <= SYSDATE
GROUP BY NUM_DOC_RESPALDO,
		 TO_CHAR( FEC_REGULARIZA, 'YYYYMMDD' ),
		 USER_REGULARIZA,
		 COD_OPERADORA_SCL_ORI,
		 COD_OPERADORA_SCL_DEST,
		 APERTURA_ORIGEN,
		 APERTURA_DESTINO,
		 TIPO_REGULARIZA
ORDER BY 3 DESC, 1;

CURSOR c_Regularizaciones( v_nNumDocto IN NUMBER, v_vFechaReg IN VARCHAR ) IS
SELECT TO_CHAR( TIPO_REGULARIZA )	   	  		  			AS TIP_REGU,
	   TO_CHAR( FEC_REGULARIZA, 'YYYYMM' )					AS FEC_REGU,
	   TO_CHAR( FEC_REGULARIZA, 'YYYYMMDD' )				AS FECHA_REGU,
	   TO_CHAR( NUM_DOC_RESPALDO )							AS AUT_REGU,
	   USER_REGULARIZA										AS NOM_REGU,
	   SUM( NVL( IMPORTE_PAGO_ORIGEN, 0 ) )					AS PAGO_ORIGEN,
	   SUM( NVL( IMPORTE_PAGO_DESTINO, 0 ) )				AS PAGO_DESTINO,
	   SUM( NVL( MONTO_REGULARIZA, 0 ) )					AS PAGO_REGULARIZA,
	   COD_OPERADORA_SCL_ORI	   	   						AS COD_OPERADORA_ORIGEN,
	   COD_OPERADORA_SCL_DEST								AS COD_OPERADORA_DESTINO,
	   APERTURA_ORIGEN										AS APERTURA_ORIGEN,
	   APERTURA_DESTINO										AS APERTURA_DESTINO
  FROM CO_HIST_REGULARIZA
 WHERE NUM_DOC_RESPALDO = v_nNumDocto
   AND ((TIPO_REGULARIZA IN (65, 67, 68 ) AND STS_REGULARIZA = 'O' )
	   OR ( TIPO_REGULARIZA = 66 AND STS_REGULARIZA = 'D' ) )
   AND FEC_IMPUTACION_CONT IS NULL
   AND FEC_REGULARIZA <= SYSDATE
   AND TO_CHAR( FEC_REGULARIZA, 'YYYYMMDD' ) = v_vFechaReg
GROUP BY TO_CHAR( TIPO_REGULARIZA ),
		 TO_CHAR( FEC_REGULARIZA, 'YYYYMM' ),
		 TO_CHAR( FEC_REGULARIZA, 'YYYYMMDD' ),
		 TO_CHAR( NUM_DOC_RESPALDO ),
		 USER_REGULARIZA,
		 COD_OPERADORA_SCL_ORI,
		 COD_OPERADORA_SCL_DEST,
		 APERTURA_ORIGEN,
		 APERTURA_DESTINO;

v_nCodEvento			SC_EVENTO.COD_EVENTO%TYPE;
v_nCodDominio			SC_EVENTO.COD_DOMINIO_CTO%TYPE;
v_vIdLote				SC_ENT_LOTE.ID_LOTE%TYPE;
v_vTipoReg				VARCHAR2(6);
v_vFechaReg				VARCHAR2(8);
v_vMsgError				VARCHAR2(100);
v_nExisteCodigo			NUMBER;
v_vCodOperadoraScl_t	SC_ENT_LOTE.COD_OPERADORA_SCL%TYPE;
v_vCodOperadoraScl_r	SC_ENT_LOTE.COD_OPERADORA_SCL%TYPE;
v_nInsertaRegistro		NUMBER;
v_vTipoApertura			VARCHAR2(40);
v_vApertura				VARCHAR2(40);
v_nCodConcepto			SC_ENT_LOTE.COD_CONCEPTO%TYPE;

/* ******************************************************************************************** */
/* (0) * MODULO PRINCIPAL    																	*/
/* ******************************************************************************************** */
BEGIN
	-- Define el evento asociado
	v_nCodEvento := 68; -- 'CONTABILIZACION DE REGULARIZACIONES'
	-- Obtiene del dominio a partir del evento
	BEGIN
		SELECT COD_DOMINIO_CTO
		  INTO v_nCodDominio
		  FROM SC_EVENTO
		 WHERE COD_EVENTO = v_nCodEvento;

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				RAISE_APPLICATION_ERROR( -20104, 'Error inesperado, Codigo:' || SQLCODE || '  Descripcion:' || SQLERRM );
	END;
	-- Indicador de Apertura
		SELECT VAL_PARAMETRO
		INTO v_vTipoApertura
	  	FROM GED_PARAMETROS
	    WHERE COD_MODULO = 'SC'
	    AND NOM_PARAMETRO = 'IND_APERTURA';

		v_vTipoApertura := TRIM (v_vTipoApertura);

	-- Recorre las REGULARIZACIONES no contabilizadas
	FOR R IN c_Regulacion LOOP

		v_vFechaReg := R.FECHA_REGU;

		IF R.APERTURA_DESTINO = 'NULO' THEN
			v_vApertura := R.APERTURA_ORIGEN;
		ELSE
		    v_vApertura := R.APERTURA_DESTINO;
		END IF;

		-- Define la identificacion del lote
		v_vIdLote := R.FECHA_REGU || '/' || R.num_doc_respaldo;
		IF v_vTipoApertura='OFICINA' THEN
		   v_vIdLote := v_vIdLote  || '/' ||v_vApertura;
		END IF;
		v_nExisteCodigo := 0;
		v_nInsertaRegistro := 0;


		IF TO_NUMBER( R.TIP_REGULARIZACION ) = 66 THEN
			IF R.COD_OPERADORA_ORIGEN <> 'NULO' THEN
				v_vCodOperadoraScl_t := R.COD_OPERADORA_ORIGEN;
			ELSE
				v_nInsertaRegistro := 1;
			END IF;
		ELSE
			IF R.COD_OPERADORA_DESTINO <> 'NULO' THEN
				v_vCodOperadoraScl_t := R.COD_OPERADORA_DESTINO;
			ELSE
				v_nInsertaRegistro := 1;
			END IF;
		END IF;

		IF v_nInsertaRegistro = 1 THEN

			INSERT INTO SC_ERROR_INGRESO
			(
				COD_EVENTO,
				ID_LOTE,
				COD_ERROR,
				FEC_ERROR,
				DES_ERROR,
				COD_OPERADORA_SCL
			)
			VALUES
			(
				v_nCodEvento,
				v_vIdLote,
				99,
				SYSDATE,
				'OPERADORA NULA',
				'NEx'
			);

		ELSE

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
				v_nCodEvento,
				v_vIdLote,
				TO_NUMBER( SUBSTR( R.FECHA_REGU, 1, 6 ) ),
				R.NOM_REGU,
				SYSDATE,
				v_vCodOperadoraScl_t
			);

			FOR S IN c_Regularizaciones( R.num_doc_respaldo, v_vFechaReg ) LOOP
				IF v_vTipoApertura='OFICINA' THEN
		   		   v_nCodConcepto := Sc_Conceptogrp_Fn( v_nCodEvento, 'CO_ORIGENPAGO', S.TIP_REGU, 'GE_OFICINAS', v_vApertura );
				ELSE
				   v_nCodConcepto := Sc_Conceptogrp_Fn( v_nCodEvento, 'CO_ORIGENPAGO', S.TIP_REGU );
		   		END IF;
				v_vTipoReg := S.TIP_REGU;

				IF TO_NUMBER( R.TIP_REGULARIZACION ) = 66 THEN
					v_vCodOperadoraScl_r := S.COD_OPERADORA_ORIGEN;
				ELSE
					v_vCodOperadoraScl_r := S.COD_OPERADORA_DESTINO;
				END IF;

				IF TO_NUMBER( S.TIP_REGU ) = 68 THEN

					INSERT INTO SC_ENT_LOTE
					(
						COD_EVENTO,
						ID_LOTE,
						COD_CONCEPTO,
						IMP_MOVIMIENTO,
						DES_TRANSACCION,
						COD_OPERADORA_SCL
					)
					SELECT v_nCodEvento,
						   v_vIdLote,
						   v_nCodConcepto,
						   S.PAGO_ORIGEN - S.PAGO_DESTINO,
						   SUBSTR( ORI.DES_ORIPAGO, 1, 30 ),
						   v_vCodOperadoraScl_r
					  FROM CO_ORIGENPAGO ORI
					 WHERE ORI.COD_ORIPAGO = S.TIP_REGU;

				ELSE

					INSERT INTO SC_ENT_LOTE
					(
						COD_EVENTO,
						ID_LOTE,
						COD_CONCEPTO,
						IMP_MOVIMIENTO,
						DES_TRANSACCION,
						COD_OPERADORA_SCL
					)
					SELECT v_nCodEvento,
						   v_vIdLote,
						   v_nCodConcepto,
						   S.PAGO_REGULARIZA,
						   SUBSTR( ORI.DES_ORIPAGO, 1, 30 ),
						   v_vCodOperadoraScl_r
					  FROM CO_ORIGENPAGO ORI
					 WHERE ORI.COD_ORIPAGO = S.TIP_REGU;

				END IF;

				UPDATE CO_HIST_REGULARIZA
				   SET FEC_IMPUTACION_CONT = SYSDATE
				 WHERE NUM_DOC_RESPALDO = R.num_doc_respaldo
				   AND TIPO_REGULARIZA = S.TIP_REGU
				   AND ( ( TIPO_REGULARIZA IN (65, 67, 68 ) AND STS_REGULARIZA = 'O' )
					   OR ( TIPO_REGULARIZA = 66 AND STS_REGULARIZA = 'D' ) )
				   AND FEC_IMPUTACION_CONT IS NULL
				   AND FEC_REGULARIZA <= SYSDATE
				   AND TO_CHAR( FEC_REGULARIZA, 'YYYYMMDD' ) = v_vFechaReg;

			END LOOP;

			Sc_P_Ingresa_Lote( TO_CHAR( v_nCodEvento ), v_vIdLote, v_vCodOperadoraScl_r );

		END IF;

	END LOOP;

	COMMIT;

	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR( -20104, 'Error :WHEN OTHERS:' || SQLERRM );
			v_vMsgError := SQLCODE;
			ROLLBACK;
END;
/
SHOW ERRORS
