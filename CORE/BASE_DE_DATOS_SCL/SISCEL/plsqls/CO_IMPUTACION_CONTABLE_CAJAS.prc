CREATE OR REPLACE PROCEDURE Co_Imputacion_Contable_Cajas
	(p_vCodOficina_Arg	IN VARCHAR2		/* Codigo de Oficina */
	,p_vCodCaja_Arg		IN VARCHAR2		/* Codigo de Caja */
	,p_vNumEjercicio_Arg	IN VARCHAR2		/* Ejercicio de Recaudación AAAAMMDD */
	)
IS

TERMINO_CON_ERROR           EXCEPTION;

/* Variables */
v_nCodCaja		CO_HISTMOVCAJA.COD_CAJA%TYPE;
v_nCodEvento		SC_EVENTO.COD_EVENTO%TYPE;
v_vIdLote		SC_ENT_LOTE.ID_LOTE%TYPE;
v_nCodError		SC_ERROR_INGRESO.COD_ERROR%TYPE;

CURSOR c_OPERADORAS ( v_vCodOficina IN VARCHAR2, v_nCodCaj IN VARCHAR2, v_vNumEjercicio IN VARCHAR2 ) IS
      SELECT DISTINCT A.COD_OPERADORA_SCL
      FROM CO_ACUM_CIERECAUDA A
      WHERE COD_OFICINA = v_vCodOficina
      AND COD_CAJA = v_nCodCaj
      AND NUM_EJERCICIO = v_vNumEjercicio
      AND COD_OPERADORA_SCL IS NOT NULL
      AND COD_PLAZA IS NOT NULL;

/* ******************************************************************************************** */
/* (0) * MODULO PRINCIPAL    																	*/
/* ******************************************************************************************** */
BEGIN
       IF GE_FN_DEVVALPARAM('CO', 1, 'SE_CONTABILIZA') = 'S' THEN		/*Soporte RyC CGLagos 01/09/2005 XO-200508300523. */

		/* VALIDA_ARGUMENTOS */
	      IF (  p_vCodOficina_Arg  IS NULL ) OR ( p_vCodCaja_Arg  IS NULL ) OR ( p_vNumEjercicio_Arg IS NULL )  THEN
			RAISE_APPLICATION_ERROR( -20101, 'No se aceptan valores en null');
	      END IF;

		/* Cajas Forma de Pago */
		v_nCodCaja := TO_NUMBER( p_vCodCaja_Arg );
		v_nCodEvento := 1;
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
	      SELECT DISTINCT 1			   		COD_EVENTO,
			v_vIdLote			 		ID_LOTE,
		   	SUBSTR( NUM_EJERCICIO, 0, 6 ) 	PER_CONTABLE,
		   	USER				 		NOM_USUARIO_LOTE,
		   	SYSDATE			 			FEC_LOTE,
		   	COD_OPERADORA_SCL		 	COD_OPERADORA_SCL
	      FROM CO_ACUM_CIERECAUDA
	      WHERE COD_OFICINA = p_vCodOficina_Arg
	      AND COD_CAJA = v_nCodCaja
		AND NUM_EJERCICIO = p_vNumEjercicio_Arg
		AND COD_OPERADORA_SCL IS NOT NULL
		AND COD_PLAZA IS NOT NULL;

		/* Se elimina conversión de moneda 12/06/2003 */

	       INSERT INTO SC_ENT_LOTE
		(
			COD_EVENTO,
			ID_LOTE,
			COD_CONCEPTO,
			IMP_MOVIMIENTO,
			COD_OPERADORA_SCL
		)
	       SELECT 1												COD_EVENTO,
			   v_vIdLote											ID_LOTE,
			   Sc_Conceptogrp_Fn( v_nCodEvento, 'GE_TIPDOCUMEN', COD_TIPDOCUM, 'GE_OFICINAS', p_vCodOficina_Arg )	COD_CONCEPTO,
			   IMPORTE											IMP_CONCEPTO,
			   COD_OPERADORA_SCL								COD_OPERADORA_SCL
	      FROM CO_ACUM_CIERECAUDA A
	      WHERE COD_OFICINA = p_vCodOficina_Arg
	      AND COD_CAJA = v_nCodCaja
	      AND NUM_EJERCICIO = p_vNumEjercicio_Arg
	      AND COD_OPERADORA_SCL IS NOT NULL
	      AND COD_PLAZA IS NOT NULL;

		-- por cada operadora se llama a la PL de ingreso de lotes
	      FOR Z IN c_OPERADORAS( p_vCodOficina_Arg, v_nCodCaja, p_vNumEjercicio_Arg ) LOOP

			Sc_P_Ingresa_Lote( TO_CHAR( v_nCodEvento ), v_vIdLote, Z.COD_OPERADORA_SCL );

		      UPDATE CO_ACUM_CIERECAUDA a
		      SET FEC_IMPUTCONTABLE = SYSDATE
		      WHERE COD_OFICINA = p_vCodOficina_Arg
		      AND COD_CAJA = v_nCodCaja
		      AND NUM_EJERCICIO = p_vNumEjercicio_Arg
		      AND COD_OPERADORA_SCL = Z.COD_OPERADORA_SCL
		      AND COD_OPERADORA_SCL IS NOT NULL
		      AND COD_PLAZA IS NOT NULL
		      AND NOT EXISTS (  SELECT 1
						       FROM SC_ERROR_INGRESO
						       WHERE COD_EVENTO = v_nCodEvento
					   	       AND ID_LOTE = v_vIdLote
					   	       AND COD_OPERADORA_SCL = Z.COD_OPERADORA_SCL);
                 			 		--Homologación / CH-200404161834
                 			 		--AND ROWNUM     < 2);

	      END LOOP;

	      INSERT INTO SC_ERROR_INGRESO
		(
			COD_EVENTO,
			ID_LOTE,
			COD_ERROR,
			FEC_ERROR,
			DES_ERROR,
			COD_OPERADORA_SCL
		)
	      SELECT 1,
			   v_vIdLote,
			   99,
			   SYSDATE,
			   'OPERADORA Y/O PLAZA NULO',
			   'NEx'
	      FROM CO_ACUM_CIERECAUDA
	      WHERE COD_OFICINA = p_vCodOficina_Arg
	      AND COD_CAJA = v_nCodCaja
	      AND NUM_EJERCICIO = p_vNumEjercicio_Arg
	      AND COD_OPERADORA_SCL IS NULL
	      AND COD_PLAZA IS NULL;

	      COMMIT;
      END IF;		/*Soporte RyC CGLagos 01/09/2005 XO-200508300523. */

END Co_Imputacion_Contable_Cajas;
/
SHOW ERRORS
