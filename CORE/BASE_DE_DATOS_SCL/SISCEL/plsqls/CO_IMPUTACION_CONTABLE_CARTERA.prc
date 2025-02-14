CREATE OR REPLACE PROCEDURE CO_IMPUTACION_CONTABLE_CARTERA
(iEvento IN NUMBER
) IS

v_vIdLote       SC_ENT_LOTE.ID_LOTE%TYPE;
v_vDescripcion  SC_ENT_LOTE.DES_TRANSACCION%TYPE;
v_nConcepto		SC_ENT_LOTE.COD_CONCEPTO%TYPE;
v_vTipoApertura	GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_vSeContabiliza GED_PARAMETROS.VAL_PARAMETRO%TYPE; -- XO-200508090324 25-08-2005 Soporte RyC

CURSOR CRSR_ChequePagare1 IS
SELECT COD_TIPDOCUM										AS TipoDocto,
	   NOM_USUARIO										AS Usuario,
	   TO_CHAR( FECHA_DEPOSITO, 'YYYYMMDD' )			AS FecDepto,
	   NUM_SECUENCI										AS NroSecuencia,
	   NUM_SEC_CUOTA									AS NroCuota,
	   COD_BANCO										AS CodBanco,
	   IMPORTE_DOCUM									AS ImporteMovto,
	   NUM_DOCUMENTO									AS NroDocumento,
	   NVL( COD_OPERADORA_SCL, 'NULO' )					AS CodOperadora,
	   COD_OFICINA		  		 						AS CodOficina
  FROM CO_DOCUMENTOS
 WHERE FEC_IMPUTACION_CONT IS NULL
   AND ( COD_TIPDOCUM = '59' AND COD_TIPVALOR = 2 )
   AND FECHA_DEPOSITO <= SYSDATE
ORDER BY COD_TIPDOCUM;

CURSOR CRSR_ChequePagare2 IS
SELECT COD_TIPDOCUM										AS TipoDocto,
	   NOM_USUARIO										AS Usuario,
	   TO_CHAR( FEC_PROTESTO, 'yyyymmdd' )				AS FecDepto,
	   NUM_SECUENCI										AS NroSecuencia,
	   NUM_SEC_CUOTA									AS NroCuota,
	   COD_BANCO										AS CodBanco,
	   IMPORTE_DOCUM									AS ImporteMovto,
	   NUM_DOCUMENTO									AS NroDocumento,
	   NVL( COD_OPERADORA_SCL, 'NULO' )					AS CodOperadora,
	   COD_OFICINA		  		 						AS CodOficina
  FROM CO_DOCUMENTOS
 WHERE FEC_IMPUTACION_CONT IS NULL
   AND ( ( COD_TIPDOCUM = '5' AND COD_ESTADO = 5 ) OR
	   ( COD_TIPDOCUM = '60' AND COD_ESTADO = 5 ) OR
	   COD_TIPDOCUM = '85' )
   AND FEC_PROTESTO <= SYSDATE
ORDER BY COD_TIPDOCUM;

/* ******************************************************************************************** */
/* (0) * MODULO PRINCIPAL    																	*/
/* ******************************************************************************************** */
BEGIN

 -- XO-200508090324 25-08-2005 Soporte RyC
    -- Obtiene parametro para contabilizar
	SELECT VAL_PARAMETRO
	INTO v_vSeContabiliza
	FROM GED_PARAMETROS
	WHERE COD_MODULO = 'CO'
	AND NOM_PARAMETRO = 'SE_CONTABILIZA';
 --  Fin XO-200508090324

 IF ( v_vSeContabiliza = 'S') THEN  -- XO-200508090324 25-08-2005 Soporte RyC

	-- Obtiene Indicador de Apertura
	SELECT VAL_PARAMETRO
	INTO v_vTipoApertura
	FROM GED_PARAMETROS
	WHERE COD_MODULO = 'SC'
	AND NOM_PARAMETRO = 'IND_APERTURA';

	v_vTipoApertura := TRIM( v_vTipoApertura );

	IF iEvento = 76 THEN

		FOR R IN CRSR_ChequePagare1 LOOP

			/*Obtiene Concepto*/
			SELECT Sc_Conceptogrp_Fn( iEvento, 'GE_TIPDOCUMEN', R.TipoDocto, 'GE_OFICINAS', R.CodOficina )
			INTO v_nConcepto
			FROM DUAL;

			v_vIdLote := R.FecDepto || '/' || R.NroSecuencia;
			IF v_vTipoApertura = 'OFICINA' THEN
			    v_vIdLote := v_vIdLote || '/' || R.CodOficina;
			END IF;
			v_vDescripcion := R.NroDocumento || '/' || R.CodBanco;

			DELETE FROM SC_ERROR_INGRESO
			 WHERE COD_EVENTO = iEvento
			   AND ID_LOTE = v_vIdLote
			   AND COD_OPERADORA_SCL = R.CodOperadora;

			IF( R.CodOperadora = 'NULO' ) THEN

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
					iEvento,
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
					iEvento,
					v_vIdLote,
					TO_NUMBER(SUBSTR(R.FecDepto,1,6)),
					R.Usuario,
					SYSDATE,
					R.CodOperadora
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
				VALUES
				(
					iEvento,
					v_vIdLote,
					v_nConcepto,
					R.ImporteMovto,
					v_vDescripcion,
					R.CodOperadora
				);

				Sc_P_Ingresa_Lote( TO_CHAR( iEvento ), v_vIdLote, R.CodOperadora );

				UPDATE CO_DOCUMENTOS
				   SET FEC_IMPUTACION_CONT = SYSDATE
				 WHERE NUM_SECUENCI = R.NroSecuencia
				   AND NUM_DOCUMENTO = R.NroDocumento
				   AND COD_OPERADORA_SCL = R.CodOperadora;

			END IF;

		END LOOP;

	ELSE

		FOR R IN CRSR_ChequePagare2 LOOP
			/*Obtiene Concepto*/
			SELECT Sc_Conceptogrp_Fn( iEvento, 'GE_TIPDOCUMEN', R.TipoDocto, 'GE_OFICINAS', R.CodOficina )
			INTO v_nConcepto
			FROM DUAL;

			IF R.TipoDocto = '60' THEN
				v_vIdLote := R.FecDepto || '/' || R.NroSecuencia;
				IF v_vTipoApertura = 'OFICINA' THEN
				   v_vIdLote := v_vIdLote || '/' || R.CodOficina;
				END IF;
				v_vDescripcion := R.NroDocumento || '/' || R.CodBanco;
			ELSE
				v_vIdLote := R.FecDepto || '/' || R.NroSecuencia || '/' || R.NroCuota;
				IF v_vTipoApertura = 'OFICINA' THEN
				   v_vIdLote := v_vIdLote || '/' || R.CodOficina;
				END IF;
				v_vDescripcion := R.NroDocumento || '/' || R.NroCuota || '/' || R.CodBanco;
			END IF;

			DELETE FROM SC_ERROR_INGRESO
			 WHERE COD_EVENTO = iEvento
			   AND ID_LOTE = v_vIdLote
			   AND COD_OPERADORA_SCL = R.CodOperadora;

			IF( R.CodOperadora = 'NULO' ) THEN

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
					iEvento,
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
					iEvento,
					v_vIdLote,
					TO_NUMBER( SUBSTR( R.FecDepto, 1, 6 ) ),
					R.Usuario,
					SYSDATE,
					R.CodOperadora
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
				VALUES
				(
					iEvento,
					v_vIdLote,
					v_nConcepto,
					R.ImporteMovto,
					v_vDescripcion,
					R.CodOperadora
				);

				Sc_P_Ingresa_Lote( TO_CHAR( iEvento ), v_vIdLote, R.CodOperadora );

				UPDATE CO_DOCUMENTOS
				   SET FEC_IMPUTACION_CONT = SYSDATE
				 WHERE NUM_SECUENCI = R.NroSecuencia
				   AND NUM_DOCUMENTO = R.NroDocumento
				   AND COD_OPERADORA_SCL = R.CodOperadora;

			END IF;

		END LOOP;
	END IF;

	COMMIT;

 END IF; -- XO-200508090324 25-08-2005 Soporte RyC

	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR( -20104, 'Error : WHEN OTHERS :' || SQLERRM );
			ROLLBACK;
END CO_IMPUTACION_CONTABLE_CARTERA;
/
SHOW ERRORS
