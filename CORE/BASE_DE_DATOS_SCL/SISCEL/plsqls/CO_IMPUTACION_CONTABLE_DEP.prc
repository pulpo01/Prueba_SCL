CREATE OR REPLACE PROCEDURE Co_Imputacion_Contable_Dep
(p_vCodOficina_Arg		IN VARCHAR2		/* Codigo de Oficina */
,p_vCodCaja_Arg			IN VARCHAR2		/* Codigo de Caja */
,p_vNumEjercicio_Arg	IN VARCHAR2		/* Ejercicio de Recaudacion AAAAMMDD*/
) IS

TERMINO_CON_ERROR           EXCEPTION;

CURSOR c_OPERADORAS ( v_vCodOficina IN VARCHAR2, v_nCodCaj IN VARCHAR2, v_vNumEjercicio IN VARCHAR2 ) IS
	SELECT DISTINCT COD_OPERADORA_SCL
  	FROM CO_ACUM_DEPRECAUDA
 	WHERE COD_OFICINA = v_vCodOficina
   	AND COD_CAJA = v_nCodCaj
   	AND NUM_EJERCICIO = v_vNumEjercicio
   	AND COD_OPERADORA_SCL IS NOT NULL
   	AND COD_PLAZA IS NOT NULL;

v_nCodCaja				CO_HISTMOVCAJA.COD_CAJA%TYPE;        		/* NUMBER(2) */
v_nCodEvento				SC_EVENTO.COD_EVENTO%TYPE;				/* NUMBER(2) */
v_vIdLote				SC_ENT_LOTE.ID_LOTE%TYPE;	   	   	      /* VARCHAR2(30) */
v_vDesError				SC_ERROR_INGRESO.DES_ERROR%TYPE;
v_nCodError				SC_ERROR_INGRESO.COD_ERROR%TYPE;
v_vCodOperadoraScl		SC_ENT_CAB_LOTE.COD_OPERADORA_SCL%TYPE;

/* ******************************************************************************************** */
/* (0) * MODULO PRINCIPAL    																	*/
/* ******************************************************************************************** */
BEGIN
       IF GE_FN_DEVVALPARAM('CO', 1, 'SE_CONTABILIZA') = 'S' THEN	/*Soporte RyC CGLagos 01/09/2005 XO-200508300523. */

		/* VALIDA_ARGUMENTOS */
	      IF( p_vCodOficina_Arg  IS NULL ) OR ( p_vCodCaja_Arg IS NULL ) OR ( p_vNumEjercicio_Arg IS NULL ) THEN
			RAISE_APPLICATION_ERROR( -20101, 'No se aceptan valores en null' );
	      END IF;

		/* Cajas Depssito */
		v_nCodCaja :=TO_NUMBER(p_vCodCaja_Arg);
		v_nCodEvento := 2;
		v_vIdLote := p_vCodOficina_Arg || '/' || LTRIM( TO_CHAR( v_nCodCaja, '000' ), ' ' ) || '/' || p_vNumEjercicio_Arg;

	       INSERT INTO SC_ENT_CAB_LOTE
		(
			COD_EVENTO,
			ID_LOTE,
			PER_CONTABLE,
			NOM_USUARIO_LOTE,
			FEC_LOTE,
			COD_OPERADORA_SCL
		)
	      SELECT DISTINCT 2					COD_EVENTO,
		   	v_vIdLote						ID_LOTE,
		   	SUBSTR( NUM_EJERCICIO, 0, 6 )		PER_CONTABLE,
		   	USER							NOM_USUARIO_LOTE,
		   	SYSDATE							FEC_LOTE,
		   	COD_OPERADORA_SCL				COD_OPERADORA_SCL
	      FROM CO_ACUM_DEPRECAUDA
	      WHERE COD_OFICINA = p_vCodOficina_Arg
	      AND COD_CAJA = v_nCodCaja
	      AND NUM_EJERCICIO = p_vNumEjercicio_Arg
	      AND COD_OPERADORA_SCL IS NOT NULL
	      AND COD_PLAZA IS NOT NULL;

	      INSERT INTO SC_ENT_LOTE
		(
			COD_EVENTO,
			ID_LOTE,
			COD_CONCEPTO,
			IMP_MOVIMIENTO,
			DES_TRANSACCION,
			COD_OPERADORA_SCL
		)
	      SELECT 2																COD_EVENTO,
		   	v_vIdLote														ID_LOTE,
		   	Sc_Conceptogrp_Fn( v_nCodEvento, 'GE_BANCO_CTA_CTE',B.COD_CTA_CTE, 'GE_OFICINAS', p_vCodOficina_Arg )  COD_CONCEPTO,
		   	SUM( A.IMPORTE * CAMBIO )										IMP_CONCEPTO,
		   	TO_CHAR( A.FEC_GENINTCON, 'yyyymmdd' ) || '-' || TO_CHAR( SUM( A.IMPORTE * CAMBIO ) ) DES_TRANSACCION,
		   	COD_OPERADORA_SCL
	      FROM GE_BANCO_CTA_CTE B,CO_ACUM_DEPRECAUDA A, CO_TIPVALOR C, GE_CONVERSION G
	      WHERE A.COD_OFICINA = p_vCodOficina_Arg
	      AND A.COD_CAJA = v_nCodCaja
	      AND A.NUM_EJERCICIO = p_vNumEjercicio_Arg
	      AND A.COD_BANCO = B.COD_BANCO
	      AND A.CTA_CORRIENTE = B.NUM_CTA_CTE
	      AND COD_OPERADORA_SCL IS NOT NULL
	      AND COD_PLAZA IS NOT NULL
	      AND A.TIP_VALOR = C.TIP_VALOR
	      AND C.COD_MONEDA = G.COD_MONEDA
	      AND A.FEC_GENINTCON BETWEEN G.FEC_DESDE AND G.FEC_HASTA
	      GROUP BY B.COD_CTA_CTE, A.FEC_GENINTCON, A.NUM_DEPOSITO, COD_OPERADORA_SCL, COD_PLAZA, CAMBIO;

		v_vDesError := '0';

		-- por cada operadora se llama a la PL de ingreso de lotes
	      FOR Z IN c_OPERADORAS( p_vCodOficina_Arg, v_nCodCaja, p_vNumEjercicio_Arg ) LOOP

			Sc_P_Ingresa_Lote( TO_CHAR( v_nCodEvento ), v_vIdLote, Z.COD_OPERADORA_SCL );

			/* ACTUALIZO TRANSACCION DE CO_ACUM_DEPRECAUDA EN SU FECHA DE IMPUTACION CONTABLE */
		      UPDATE CO_ACUM_DEPRECAUDA
		      SET FEC_IMPUTCONTABLE = SYSDATE
		      WHERE COD_OFICINA = p_vCodOficina_Arg
		      AND COD_CAJA = v_nCodCaja
		      AND NUM_EJERCICIO = p_vNumEjercicio_Arg
		      AND COD_OPERADORA_SCL = Z.COD_OPERADORA_SCL
		      AND COD_OPERADORA_SCL IS NOT NULL
		      AND COD_PLAZA IS NOT NULL
		      AND NOT EXISTS ( SELECT 1
						      FROM SC_ERROR_INGRESO
						      WHERE COD_EVENTO = v_nCodEvento
						      AND ID_LOTE = v_vIdLote
						      AND COD_OPERADORA_SCL = Z.COD_OPERADORA_SCL);
							--Homologación / CH-200404161834
							--AND ROWNUM < 2 );
		END LOOP;

		--    BEGIN
		--            SELECT count(*), COD_ERROR
		--              INTO v_vDesError, v_nCodError
		--              FROM SC_ERROR_INGRESO
		--             WHERE COD_EVENTO = 1
		--               AND ID_LOTE    = v_vIdLote
		--               AND ROWNUM     < 2
		--
		--               AND COD_OPERADORA_SCL = v_vCodOperadoraScl
		--               AND COD_PLAZA  = szhCodPlaza
		--             GROUP BY COD_ERROR;

		--            EXCEPTION
		--                WHEN NO_DATA_FOUND THEN
		--                     v_vDesError:='0';
		--                     v_nCodError:= 0;
		--    END;
		--       IF v_vDesError='0'  THEN

		--       ELSE
		--          IF (v_vDesError <>'0') and (v_nCodError=10) THEN-
		--	     --NADA
		--	     v_vDesError:=v_vDesError;
		--          ELSE-
		--	     /* INGRESO DE LOTE GENERO ERROR */
		--	     v_vDesError:=v_vDesError;
		--	     raise_application_error(-20102, 'Error al generar Imputacion contable DEPOSITOS PL SC_P_INGRESA_LOTE');
		--         END IF;
		--       END IF;

	       INSERT INTO SC_ERROR_INGRESO
		(
			COD_EVENTO,
			ID_LOTE,
			COD_ERROR,
			FEC_ERROR,
			DES_ERROR,
			COD_OPERADORA_SCL
		)
	      SELECT v_nCodEvento,
		   	v_vIdLote,
		   	99,
		   	SYSDATE,
		   	'OPERADORA Y/O PLAZA NULO',
		   	'NEx'
	      FROM CO_ACUM_DEPRECAUDA
	      WHERE COD_OFICINA = p_vCodOficina_Arg
	      AND COD_CAJA = v_nCodCaja
	      AND NUM_EJERCICIO = p_vNumEjercicio_Arg
	      AND COD_OPERADORA_SCL IS NULL
	      AND COD_PLAZA IS NULL;

	      COMMIT;
      END IF;	/*Soporte RyC CGLagos 01/09/2005 XO-200508300523. */

END Co_Imputacion_Contable_Dep;
/
SHOW ERRORS
