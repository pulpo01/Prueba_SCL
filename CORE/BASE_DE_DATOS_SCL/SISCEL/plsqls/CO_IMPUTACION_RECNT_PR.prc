CREATE OR REPLACE PROCEDURE Co_Imputacion_Recnt_Pr
(p_vCodOficina_Arg		IN VARCHAR2				  /* Codigo de Oficina */
,p_nCodCaja_Arg			IN VARCHAR2		   		  /* Codigo de Caja */
,p_vNumEjercicio_Arg	IN VARCHAR2		   		  /* Numero de Paso Cobros */
,p_vCodOperadora_Arg	IN VARCHAR2 DEFAULT NULL  /* Codigo Operadora OPCIONAL */
)
IS
PRAGMA AUTONOMOUS_TRANSACTION;

/* Constantes */
c_nCodEvento CONSTANT SC_EVENTO.COD_EVENTO%TYPE := 77;

/* Variables */
v_nCodCaja			CO_HISTMOVCAJA.COD_CAJA%TYPE;
v_vIdLote			SC_ENT_LOTE.ID_LOTE%TYPE;
v_vOper				SC_ENT_CAB_LOTE.COD_OPERADORA_SCL%TYPE;
v_nConcepto			SC_ENT_LOTE.COD_CONCEPTO%TYPE;

v_nCodError			SC_ERROR_INGRESO.COD_ERROR%TYPE;
v_vUbicError		SC_ERROR_INGRESO.DES_ERROR%TYPE;

v_vCantError		NUMBER(2);
v_nERROR_CRITICO	NUMBER(1);

/* Cursor de Lotes por Operadora */

CURSOR C_LOTE ( v_vCodOfi IN VARCHAR2, v_nCodCaj IN VARCHAR2, v_vNumEjercicio IN VARCHAR2 ) IS
SELECT DISTINCT B.EMP_RECAUDADORA|| '/' ||A.NUM_EJERCICIO   ID_LOTE,
	   SUBSTR( A.NUM_EJERCICIO, 0, 6 ) 				   		PER_CONTABLE,
	   A.COD_OPERADORA_SCL		   	 						COD_OPERADORA_SCL
  FROM CO_ACUM_CIERECAUDA A, CO_EMPRESAS_REX B
 WHERE A.COD_OFICINA = v_vCodOfi
	   AND A.COD_OFICINA = B.COD_OFICINA
	   AND A.COD_CAJA = v_nCodCaj
	   AND A.COD_CAJA = B.COD_CAJA
	   AND A.NUM_EJERCICIO = v_vNumEjercicio
	   AND A.FEC_GENINTCON IS NOT NULL
	   AND A.FEC_IMPUTCONTABLE IS NULL;

/* ******************************************************************************************** */
/* Procedimiento Local para Registro de Errores     											*/
/* ******************************************************************************************** */

PROCEDURE MANEJO_ERROR
( p_vIdLote 		  IN 	 VARCHAR2
, p_vCodOperadora 	  IN 	 VARCHAR2
, p_nCodError 		  IN 	 NUMBER
, p_vDesError 		  IN     VARCHAR2
, p_nERROR_CRITICO	  IN 	 NUMBER
) IS

v_vErrorOra VARCHAR2(100);
v_vDesError VARCHAR2(200);

BEGIN

	v_vErrorOra := SUBSTR(SQLERRM, 1, 100 );
	v_vDesError := p_vDesError;

	v_vDesError := v_vDesError || ' ' ||v_vErrorOra;

	DBMS_OUTPUT.PUT_LINE(v_vDesError);

	SELECT COUNT(1)
	  INTO v_vCantError
	FROM SC_ERROR_INGRESO
	WHERE COD_OPERADORA_SCL = p_vCodOperadora
		  AND COD_EVENTO = c_nCodEvento
		  AND ID_LOTE = p_vIdLote;

	DBMS_OUTPUT.PUT_LINE('Errores encontrados en SC_ERROR_INGRESO = '||v_vCantError);

	IF( v_vCantError = 0 ) AND v_nERROR_CRITICO != 1 THEN

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
			c_nCodEvento,
			p_vIdLote,
			p_nCodError,
			SYSDATE,
			SUBSTR(v_vDesError, 1, 100 ),
			p_vCodOperadora
		);

		DBMS_OUTPUT.PUT_LINE('Nuevo Error Registrado...');

		COMMIT;
	END IF;

	DBMS_OUTPUT.PUT_LINE(' ');
END MANEJO_ERROR;

/* ******************************************************************************************** */
/* (0) * MODULO PRINCIPAL    																	*/
/* ******************************************************************************************** */
BEGIN

	/* VALIDA_ARGUMENTOS */
	IF (  p_vCodOficina_Arg  IS NULL ) OR ( p_nCodCaja_Arg  IS NULL ) OR ( p_vNumEjercicio_Arg IS NULL )  THEN
		RAISE_APPLICATION_ERROR( -20101, 'CO_IMPUTACION_RECNT_PR - No se aceptan valores en null');
	END IF;

	v_nCodCaja := TO_NUMBER(p_nCodCaja_Arg);

	v_nERROR_CRITICO:= 0;

	v_vOper := 'NEx';

	v_vUbicError := 'CO_IMPUTACION_RECNT_PR - Extrae Id Lote';

	DBMS_OUTPUT.PUT_LINE( v_vUbicError);

	BEGIN
		SELECT DISTINCT B.EMP_RECAUDADORA|| '/' ||A.NUM_EJERCICIO   ID_LOTE
		   INTO v_vIdLote
		  FROM CO_ACUM_CIERECAUDA A, CO_EMPRESAS_REX B
		 WHERE A.COD_OFICINA = p_vCodOficina_Arg
			  AND A.COD_OFICINA = B.COD_OFICINA
			  AND A.COD_CAJA = v_nCodCaja
			  AND A.COD_CAJA = B.COD_CAJA
			  AND A.NUM_EJERCICIO = p_vNumEjercicio_Arg;
	EXCEPTION
		WHEN OTHERS THEN
		   DBMS_OUTPUT.PUT_LINE( v_vUbicError||SQLERRM);
		   RAISE_APPLICATION_ERROR( -20102, v_vUbicError||SQLERRM);
	END;

	v_nCodError := -1;
	v_vUbicError := '1.Llama Cursor de Lotes X Operadora ('||p_vCodOficina_Arg||'-'
        			 			   			   			   ||v_nCodCaja||'-'
        												   ||p_vNumEjercicio_Arg||')';
	DBMS_OUTPUT.PUT_LINE(v_vUbicError);

	DBMS_OUTPUT.PUT_LINE('Argumento Operadora = '||p_vCodOperadora_Arg);

	/* Por cada Lote/Operadora se llama a la PL de ingreso de lotes y se inserta en tablas temporales */

	FOR Z IN C_LOTE( p_vCodOficina_Arg, v_nCodCaja, p_vNumEjercicio_Arg ) LOOP

		BEGIN --Control de Errores por operadora.

			/* Solo cuando se quiere procesar todas las Operadoras (p_vCodOperadora_Arg IS NULL)
			   o solamente la Operadora pasada por argumento */
			IF p_vCodOperadora_Arg IS NULL OR p_vCodOperadora_Arg = Z.COD_OPERADORA_SCL THEN

				v_nERROR_CRITICO := 0;

				v_vOper := Z.COD_OPERADORA_SCL;
				v_vIdLote := Z.ID_LOTE;

				v_nCodError := -2;
				v_vUbicError := '2.Inserta Cabecera en SC_ENT_CAB_LOTE ('||p_vCodOficina_Arg||'-'
							 			   			   				   	 ||v_nCodCaja||'-'
																		 ||p_vNumEjercicio_Arg||'-'
																		 ||Z.COD_OPERADORA_SCL||')';
		        DBMS_OUTPUT.PUT_LINE('');
				DBMS_OUTPUT.PUT_LINE(v_vUbicError);

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
			    	c_nCodEvento,
			    	Z.ID_LOTE,
			    	Z.PER_CONTABLE,
			    	USER,
			    	SYSDATE,
			    	Z.COD_OPERADORA_SCL
			    );

				v_nCodError := -3;
				v_vUbicError := '3.Inserta Detalle en SC_ENT_LOTE ('||p_vCodOficina_Arg||'-'
	    		                                                    ||v_nCodCaja||'-'
	    															||p_vNumEjercicio_Arg||'-'
	    															||Z.COD_OPERADORA_SCL||')';

	           	DBMS_OUTPUT.PUT_LINE( v_vUbicError);

				/* Si falla algun detalle todo el Lote/Operadora queda con error */

				INSERT INTO SC_ENT_LOTE
				(
					COD_EVENTO,
					ID_LOTE,
					COD_CONCEPTO,
					IMP_MOVIMIENTO,
					DES_TRANSACCION,
					COD_OPERADORA_SCL
				)
				 SELECT c_nCodEvento   					  	 	  				 COD_EVENTO,
				 		Z.ID_LOTE	  											 ID_LOTE,
				 		Sc_Conceptogrp_Fn(c_nCodEvento
										  ,'GE_TIPDOCUMEN', C.COD_TIPDOCUM
										  ,'CED_EMPRESAS',B.EMP_RECAUDADORA)  COD_CONCEPTO,
					    A.IMPORTE											 	 IMP_CONCEPTO,
					   	SUBSTR( c_nCodEvento||'-'||Z.ID_LOTE, 1, 30 )			 DES_TRANSACCION,
						Z.COD_OPERADORA_SCL					 	   				 COD_OPERADORA_SCL
				   FROM CO_ACUM_CIERECAUDA A
				   		, CO_EMPRESAS_REX B
						, GE_TIPDOCUMEN C
				  WHERE A.COD_OFICINA = p_vCodOficina_Arg
					   AND A.COD_OFICINA = B.COD_OFICINA
					   AND A.COD_CAJA = v_nCodCaja
					   AND A.COD_CAJA = B.COD_CAJA
					   AND A.FEC_GENINTCON IS NOT NULL
					   AND A.FEC_IMPUTCONTABLE IS NULL
					   AND A.NUM_EJERCICIO = p_vNumEjercicio_Arg
					   AND B.EMP_RECAUDADORA|| '/' ||A.NUM_EJERCICIO = Z.ID_LOTE
					   AND A.COD_OPERADORA_SCL = Z.COD_OPERADORA_SCL
					   AND A.COD_TIPDOCUM = C.COD_TIPDOCUM;


				v_nCodError := -4;
				v_vUbicError := '4.Ejecuta SC_P_INGRESA_LOTE ('||c_nCodEvento||'-'
		    		                                           ||v_vIdLote||'-'
		    										           ||Z.COD_OPERADORA_SCL||')';
				DBMS_OUTPUT.PUT_LINE(v_vUbicError);

				/****************************************************************************/

				Sc_P_Ingresa_Lote( TO_CHAR( c_nCodEvento ), v_vIdLote, Z.COD_OPERADORA_SCL );

				--Verificar si SC_P_INGRESA_LOTE genero error.
				SELECT COUNT(1)
				   INTO v_vCantError
				  FROM SC_ERROR_INGRESO
				 WHERE COD_OPERADORA_SCL = Z.COD_OPERADORA_SCL
				 	   AND COD_EVENTO    = c_nCodEvento
					   AND ID_LOTE 		 = v_vIdLote;

				DBMS_OUTPUT.PUT_LINE('Errores en SC_P_INGRESA_LOTE = '||v_vCantError);

				/****************************************************************************/

				IF v_vCantError != 0 THEN
					--Hubo error.
					v_nERROR_CRITICO := 1;
				ELSE
					--NO hubo error.
			        v_nCodError := -5;
					v_vUbicError := '5.Actualiza FEC_IMPUTCONTABLE ('||p_vCodOficina_Arg||'-'
			    		                                           ||v_nCodCaja||'-'
																   ||p_vNumEjercicio_Arg||'-'
			    										           ||Z.COD_OPERADORA_SCL||'-'
																   ||c_nCodEvento||'-'
																   ||v_vIdLote||')';
					DBMS_OUTPUT.PUT_LINE(v_vUbicError);

					UPDATE CO_ACUM_CIERECAUDA A
					   SET A.FEC_IMPUTCONTABLE = SYSDATE
					 WHERE A.COD_OFICINA = p_vCodOficina_Arg
					   AND A.COD_CAJA = v_nCodCaja
					   AND A.NUM_EJERCICIO = p_vNumEjercicio_Arg
					   AND A.COD_OPERADORA_SCL = Z.COD_OPERADORA_SCL
					   AND NOT EXISTS (	SELECT 1
										  FROM SC_ERROR_INGRESO B
										 WHERE B.COD_EVENTO = c_nCodEvento
										   AND B.ID_LOTE = v_vIdLote
										   AND B.COD_OPERADORA_SCL = Z.COD_OPERADORA_SCL
										   AND ROWNUM < 2 );
				END IF;

			END IF; --Operadora Opcional.

		EXCEPTION
			WHEN OTHERS THEN
					MANEJO_ERROR ( v_vIdLote, v_vOper, v_nCodError, v_vUbicError, v_nERROR_CRITICO);
		END;

	END LOOP; --Cursor LOTE.

	DBMS_OUTPUT.PUT_LINE( 'TERMINO PL OK' );

	COMMIT;

EXCEPTION
	WHEN OTHERS THEN
		 MANEJO_ERROR ( v_vIdLote, v_vOper,  v_nCodError, v_vUbicError, v_nERROR_CRITICO);

		 RAISE_APPLICATION_ERROR( -20107, 'ERROR INESPERADO EN PL CO_IMPUTACION_RECNT_PR : ORA-'||SQLERRM||'.', TRUE );

END Co_Imputacion_Recnt_Pr;
/
SHOW ERRORS
