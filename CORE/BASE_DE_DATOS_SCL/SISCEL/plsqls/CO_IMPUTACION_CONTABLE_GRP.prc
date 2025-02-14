CREATE OR REPLACE PROCEDURE CO_IMPUTACION_CONTABLE_GRP
(p_nNumProcPasoCob		IN NUMBER		-- Numero de Paso Cobros
,p_vCodOperadoraScl		IN VARCHAR2		-- Operadora
) IS

v_nCodEvento		SC_EVENTO.COD_EVENTO%TYPE;            -- NUMBER(2)
v_vIdLote			SC_ENT_LOTE.ID_LOTE%TYPE;             -- VARCHAR2(30)
p_nConcepto			SC_ENT_LOTE.COD_CONCEPTO%TYPE;        -- VARCHAR2(6)

v_vTrazaError		VARCHAR2(60);
v_nCodError			SC_ERROR_INGRESO.COD_ERROR%TYPE;
v_vTipoApertura		GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_vCantError		NUMBER(2);
v_vUbicError		SC_ERROR_INGRESO.DES_ERROR%TYPE;

v_nERROR_CRITICO	NUMBER(1);
v_nERROR_LOTE		NUMBER(1);
v_vAperTecnologia	VARCHAR2(1);
v_vAperOficina		VARCHAR2(1);
v_vAperComisionista	VARCHAR2(1);
v_iExiste 			NUMBER(2);

ERROR_PL_IMP EXCEPTION;

------------------------------------------------
-- CURSOR DE LOTES DEL PASOCOBROS.
------------------------------------------------
CURSOR CURSOR_LOTES( vp_vApertura VARCHAR2 ) IS
SELECT B.NUM_PROCPASOCOBRO || DECODE( A.COD_CICLFACT, 0, '/' || B.PER_CONTABLE,NULL ) ||
	   DECODE( vp_vApertura, 'TECNOLOGIA', '/' || B.COD_APERTURA || '/' || B.COD_TECNOLOGIA, 'OFICINA', '/' || B.COD_APERTURA) AS ID_LOTE,
	   B.PER_CONTABLE AS PER_CONTABLE,
	   A.COD_CICLFACT AS CICLO,
	   A.COD_TIPDOCUM AS DOCUMENTO
  FROM FA_DETPASOCOBROS B, FA_REPPASOCOBROS A, FA_REPDETALLE_TO D
 WHERE A.NUM_PROCPASOCOB = p_nNumProcPasoCob
   AND A.NUM_PROCPASOCOB = D.NUM_PROCPASOCOBRO
   AND D.COD_OPERADORA_SCL = p_vCodOperadoraScl
   AND D.NUM_PROCPASOCOBRO = B.NUM_PROCPASOCOBRO
   AND D.COD_OPERADORA_SCL = B.COD_OPERADORA_SCL
GROUP BY B.NUM_PROCPASOCOBRO || DECODE( A.COD_CICLFACT, 0, '/' || B.PER_CONTABLE, NULL ) ||
		 DECODE( vp_vApertura, 'TECNOLOGIA', '/' || B.COD_APERTURA || '/' || B.COD_TECNOLOGIA, 'OFICINA', '/' || B.COD_APERTURA),
		 B.PER_CONTABLE,
		 A.COD_CICLFACT,
		 A.COD_TIPDOCUM;

------------------------------------------------
-- LOTES DE FACTURACION CICLO.
------------------------------------------------
CURSOR CURSOR_CICLOS( vp_vApertura VARCHAR2, vp_Id_Lote VARCHAR2 ) IS
SELECT TO_NUMBER( D.DES_VALOR ) AS COD_EVENTO,
	   B.NUM_PROCPASOCOBRO || DECODE( vp_vApertura, 'TECNOLOGIA', '/' || B.COD_APERTURA || '/' || B.COD_TECNOLOGIA, 'OFICINA', '/' || B.COD_APERTURA) AS ID_LOTE,
	   B.COD_CONCEPTO AS COD_CONCEPTO,
	   B.COD_CATEGORIA AS COD_CATEGORIA,
	   B.COD_TIPCOMIS AS COD_TIPCOMIS,
	   SUM( B.IMP_CONCEPTO ) AS IMP_CONCEPTO,
	   B.COD_APERTURA AS COD_APERTURA,
	   B.COD_TECNOLOGIA AS COD_TECNOLOGIA
  FROM CO_CODIGOS D,
  	   FA_CICLFACT C,
  	   FA_DETPASOCOBROS B,
  	   FA_REPPASOCOBROS A,
  	   FA_REPDETALLE_TO F
 WHERE A.NUM_PROCPASOCOB = p_nNumProcPasoCob
   AND A.NUM_PROCPASOCOB = F.NUM_PROCPASOCOBRO
   AND F.COD_OPERADORA_SCL = p_vCodOperadoraScl
   AND F.FEC_GENINTCON IS NOT NULL
   AND F.FEC_IMPUTCONTABLE IS NULL
   AND A.COD_CICLFACT > 0
   AND A.COD_CICLFACT = C.COD_CICLFACT
   AND C.COD_CICLO = TO_NUMBER( D.COD_VALOR )
   AND D.NOM_TABLA = 'FA_CICLOS'
   AND D.NOM_COLUMNA = 'COD_CICLO'
   AND F.NUM_PROCPASOCOBRO = B.NUM_PROCPASOCOBRO
   AND F.COD_OPERADORA_SCL = B.COD_OPERADORA_SCL
   AND B.NUM_PROCPASOCOBRO || DECODE( vp_vApertura, 'TECNOLOGIA', '/' || B.COD_APERTURA || '/' || B.COD_TECNOLOGIA, 'OFICINA', '/' || B.COD_APERTURA) = vp_Id_Lote
GROUP BY D.DES_VALOR,
		 B.NUM_PROCPASOCOBRO || DECODE( vp_vApertura, 'TECNOLOGIA', '/' || B.COD_APERTURA || '/' || B.COD_TECNOLOGIA, 'OFICINA', '/' || B.COD_APERTURA),
		 B.COD_CONCEPTO,
		 B.COD_CATEGORIA,
		 B.COD_TIPCOMIS,
		 B.COD_APERTURA,
		 B.COD_TECNOLOGIA;

------------------------------------------------
-- LOTES DE FACTURACION NO CICLO.
------------------------------------------------
CURSOR CURSOR_NOCICLO( vp_vApertura VARCHAR2, vp_Id_Lote VARCHAR2 ) IS
SELECT D.DES_VALOR AS COD_EVENTO,
	   B.NUM_PROCPASOCOBRO || '/' || B.PER_CONTABLE || DECODE( vp_vApertura, 'TECNOLOGIA', '/' || B.COD_APERTURA || '/' || B.COD_TECNOLOGIA, 'OFICINA', '/' || B.COD_APERTURA) AS ID_LOTE,
	   B.COD_CONCEPTO AS COD_CONCEPTO,
	   B.COD_CATEGORIA AS COD_CATEGORIA,
	   B.COD_TIPCOMIS AS COD_TIPCOMIS,
	   SUM( B.IMP_CONCEPTO ) AS IMP_CONCEPTO,
	   B.COD_APERTURA  AS COD_APERTURA,
	   B.COD_TECNOLOGIA AS COD_TECNOLOGIA
  FROM CO_CODIGOS D,
  	   FA_DETPASOCOBROS B,
  	   FA_REPPASOCOBROS A,
  	   FA_REPDETALLE_TO F
 WHERE A.NUM_PROCPASOCOB = p_nNumProcPasoCob
   AND A.NUM_PROCPASOCOB = F.NUM_PROCPASOCOBRO
   AND F.COD_OPERADORA_SCL = p_vCodOperadoraScl
   AND F.FEC_GENINTCON IS NOT NULL
   AND F.FEC_IMPUTCONTABLE IS NULL
   AND A.COD_CICLFACT < 1
   AND A.COD_TIPDOCUM = TO_NUMBER( D.COD_VALOR )
   AND D.NOM_TABLA ='FA_TIPMOVIMIEN'
   AND D.NOM_COLUMNA ='COD_TIPDOCUM'
   AND F.NUM_PROCPASOCOBRO = B.NUM_PROCPASOCOBRO
   AND F.COD_OPERADORA_SCL = B.COD_OPERADORA_SCL
   AND B.NUM_PROCPASOCOBRO || '/' || B.PER_CONTABLE || DECODE( vp_vApertura, 'TECNOLOGIA', '/' || B.COD_APERTURA || '/' || B.COD_TECNOLOGIA, 'OFICINA', '/' || B.COD_APERTURA) = vp_Id_Lote
GROUP BY D.DES_VALOR,
		 B.NUM_PROCPASOCOBRO || '/' || B.PER_CONTABLE || DECODE( vp_vApertura, 'TECNOLOGIA', '/' || B.COD_APERTURA || '/' || B.COD_TECNOLOGIA, 'OFICINA', '/' || B.COD_APERTURA),
		 B.COD_CONCEPTO,
		 B.COD_CATEGORIA,
		 B.COD_TIPCOMIS,
		 B.COD_APERTURA,
		 B.COD_TECNOLOGIA;

BEGIN

	v_nCodEvento	:= 0;
	v_vIdLote := '0';
	v_nCodError := -2;

	v_nERROR_CRITICO:= 0;

	-- Valida los argumentos
	IF( p_nNumProcPasoCob IS NULL ) THEN
		RAISE_APPLICATION_ERROR( -20101, 'Parametro de Paso Cobro con valor Null');
	END IF;

	v_vUbicError := 'Obtieniendo Indicador de Apertura ' || TO_CHAR( p_nNumProcPasoCob );

	-- Obtiene Indicador de Apertura

	SELECT APER_TECNOLOGIA, APER_OFICINA, APER_COMISIONISTA
	INTO   v_vAperTecnologia, v_vAperOficina, v_vAperComisionista
	FROM   SC_INDAPERTURA_TD
	WHERE  COD_MODULO = 'FA'
	AND	   ROWNUM <= 1;

	IF ((UPPER(TRIM(v_vAperTecnologia)) = 'S') AND (UPPER(TRIM(v_vAperOficina)) = 'S')) THEN
       v_vTipoApertura := 'TECNOLOGIA';
	ELSIF UPPER(TRIM(v_vAperOficina)) = 'S' THEN
       v_vTipoApertura := 'OFICINA';
	ELSIF UPPER(TRIM(v_vAperComisionista)) = 'S' THEN
       v_vTipoApertura := 'COMISIONISTA';
	END IF;

	v_vTipoApertura := TRIM( v_vTipoApertura );

	v_vUbicError := 'Ajustando Concepto ' || TO_CHAR( p_nNumProcPasoCob );
	Sc_Ajusta_Concepto_Pr( p_nNumProcPasoCob, p_vCodOperadoraScl );

	------------------------------------------------
	-- CURSOR POR ID_LOTE.
	------------------------------------------------
	FOR LOTE IN CURSOR_LOTES( v_vTipoApertura ) LOOP

		v_nERROR_LOTE := 0;

		v_vIdLote := LOTE.ID_LOTE;

		IF LOTE.CICLO > 0 THEN  -- Imputacion por Ciclos

			v_vUbicError := '1.Imputacion Ciclos. Obtiene Evento, para paso cobro ' || TO_CHAR(p_nNumProcPasoCob);
			SELECT TO_NUMBER( DES_VALOR ) AS COD_EVENTO
			  INTO v_nCodEvento
			  FROM CO_CODIGOS A, FA_CICLFACT B
			 WHERE A.COD_VALOR = TO_CHAR(B.COD_CICLO)
			   AND B.COD_CICLFACT = LOTE.CICLO
			   AND NOM_TABLA = 'FA_CICLOS'
			   AND NOM_COLUMNA = 'COD_CICLO';

			v_vUbicError := '2.Imputacion Ciclos. Inserta Cabecera SC_ENT_CAB_LOTE';
			BEGIN
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
					LOTE.ID_LOTE,
					LOTE.PER_CONTABLE,
					USER,
					SYSDATE,
					p_vCodOperadoraScl
				);

				v_vUbicError := '2.Imputacion Ciclos. Inserta sc_cobros_lote';
				-- Incidencia PFCO0004  15.11.2004 - MQG

				v_iExiste := 0;
				SELECT COD_EVENTO
			  	INTO v_iExiste
				FROM SC_COBROS_LOTE_TD
				WHERE COD_EVENTO        = v_nCodEvento
				AND   NUM_PROCPASOCOBRO = p_nNumProcPasoCob
				AND	  ID_LOTE           = LOTE.ID_LOTE
				AND   ROWNUM            = 1;

				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					BEGIN
						INSERT INTO SC_COBROS_LOTE_TD
						(
							COD_EVENTO,
							NUM_PROCPASOCOBRO,
							ID_LOTE
						)
						VALUES
						(
							v_nCodEvento,
							p_nNumProcPasoCob,
							LOTE.ID_LOTE
						);

						EXCEPTION
							WHEN OTHERS  THEN
								--registrar error pero seguir con siguiente lote.
								v_nERROR_CRITICO := 1;
								v_nERROR_LOTE := 1;

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
							LOTE.ID_LOTE,
							v_nCodError,
							SYSDATE,
							v_vUbicError,
							p_vCodOperadoraScl
						);
					END;
			END;

			------------------------------------------------------------------------------------------------
			-- Genera la imputacisn para Ciclos, insertando ahora en el detalle de entrada.
			------------------------------------------------------------------------------------------------
			BEGIN --registrar error pero seguir con siguiente lote.

				v_vUbicError := '3. Cursor Ciclos sin datos para Id_Lote:'||LOTE.ID_LOTE;

				FOR X IN CURSOR_CICLOS( v_vTipoApertura, LOTE.ID_LOTE ) LOOP

					v_vIdLote := X.ID_LOTE;

					v_vUbicError := '4.Obtiene Concepto desde SC_CONCEPTOGRP_FN. ID_LOTE:'||X.ID_LOTE;
                    v_vTrazaError :='(CO: '||X.COD_CONCEPTO||';'||'CA: '||X.COD_CATEGORIA||';'||'TE: '||X.COD_TECNOLOGIA||';'||'OF: '||X.COD_APERTURA;

					IF v_vTipoApertura = 'COMISIONISTA' THEN

						v_vTrazaError := v_vTrazaError ||';'||'TIPCOMIS: '||X.COD_TIPCOMIS;
						SELECT Sc_Conceptogrp_Fn( X.COD_EVENTO, 'FA_CONCEPTOS', X.COD_CONCEPTO, 'GE_CATEGORIAS', X.COD_CATEGORIA, 'VE_TIPCOMIS', X.COD_TIPCOMIS )
						  INTO p_nConcepto
						  FROM DUAL;

					ELSIF v_vTipoApertura = 'OFICINA' THEN

						SELECT Sc_Conceptogrp_Fn( X.COD_EVENTO, 'FA_CONCEPTOS', X.COD_CONCEPTO, 'GE_CATEGORIAS', X.COD_CATEGORIA, 'GE_OFICINAS', X.COD_APERTURA )
						  INTO p_nConcepto
						  FROM DUAL;

					ELSIF v_vTipoApertura = 'TECNOLOGIA' THEN

						SELECT Sc_Conceptogrp_Fn( X.COD_EVENTO, 'FA_CONCEPTOS', X.COD_CONCEPTO, 'GE_CATEGORIAS', X.COD_CATEGORIA, 'GE_OFICINAS', X.COD_APERTURA, 'AL_TECNOLOGIA', X.COD_TECNOLOGIA )
						  INTO p_nConcepto
						  FROM DUAL;

					END IF;

					v_vUbicError := '5.Imputacion Ciclos. Inserta Detalle SC_ENT_LOTE ' ||p_nConcepto||','||X.IMP_CONCEPTO;
					IF p_nConcepto IS NULL THEN
						v_vUbicError := 'Sin Codigo de Concepto Agrupado '||v_vTrazaError||')';
						v_nCodError := -3;
						RAISE ERROR_PL_IMP;
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
						VALUES
						(
							X.COD_EVENTO,
							X.ID_LOTE,
							p_nConcepto,
							X.IMP_CONCEPTO,
							SUBSTR( v_vTrazaError, 1, 30 ),
							p_vCodOperadoraScl
						);
					END IF;

				END LOOP;  /*CURSOR_CICLOS*/

				EXCEPTION
					WHEN OTHERS  THEN
						v_nERROR_CRITICO := 1;
						v_nERROR_LOTE := 1;

				--registrar error pero seguir con siguiente lote.
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
					LOTE.ID_LOTE,
					v_nCodError,
					SYSDATE,
					v_vUbicError,
					p_vCodOperadoraScl
				);
			END;

		ELSE  -- Imputacion por NO Ciclo

			v_vUbicError := '6.Imputacion NO Ciclos. Obtiene Evento, para paso cobro ' || TO_CHAR(p_nNumProcPasoCob);

			SELECT TO_NUMBER(DES_VALOR) AS COD_EVENTO
			  INTO v_nCodEvento
			  FROM CO_CODIGOS
			 WHERE COD_VALOR = TO_CHAR(LOTE.DOCUMENTO)
			   AND NOM_TABLA = 'FA_TIPMOVIMIEN'
			   AND NOM_COLUMNA = 'COD_TIPDOCUM';

			v_vUbicError := '7.Imputacion NO Ciclos. Inserta Cabecera SC_ENT_CAB_LOTE ';

			BEGIN
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
					LOTE.ID_LOTE,
					LOTE.PER_CONTABLE,
					USER,
					SYSDATE,
					p_vCodOperadoraScl
				);

				v_vUbicError := '7.Imputacion NO Ciclos. Inserta sc_cobros_lote ';
				-- Incidencia PFCO0004  15.11.2004 - MQG
				v_iExiste := 0;
				SELECT COD_EVENTO
			  	INTO v_iExiste
				FROM SC_COBROS_LOTE_TD
				WHERE COD_EVENTO  = v_nCodEvento
				AND   NUM_PROCPASOCOBRO = p_nNumProcPasoCob
				AND	  ID_LOTE     = LOTE.ID_LOTE
				AND   ROWNUM      = 1;

				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					BEGIN
						INSERT INTO SC_COBROS_LOTE_TD
						(
							COD_EVENTO,
							NUM_PROCPASOCOBRO,
							ID_LOTE
						)
						VALUES
						(
							v_nCodEvento,
							p_nNumProcPasoCob,
							LOTE.ID_LOTE
						);

						EXCEPTION
							WHEN OTHERS  THEN
								--registrar error pero seguir con siguiente lote
								v_nERROR_CRITICO := 1;
								v_nERROR_LOTE := 1;

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
							LOTE.ID_LOTE,
							v_nCodError,
							SYSDATE,
							v_vUbicError,
							p_vCodOperadoraScl
						);
					END;
			END;

			------------------------------------------------------------------------------------------------
			-- Genera la imputacion para NO Ciclos, insertando ahora en el detalle de entrada.
			------------------------------------------------------------------------------------------------
			BEGIN --registrar error pero seguir con siguiente lote.

				v_vUbicError := '8. Cursor No Ciclos sin datos para Id_Lote:'||LOTE.ID_LOTE;

				FOR Y IN CURSOR_NOCICLO( v_vTipoApertura, LOTE.ID_LOTE ) LOOP

					v_vIdLote := Y.ID_LOTE;

					v_vUbicError := '9.Obtiene Concepto desde SC_CONCEPTOGRP_FN. ID_LOTE:'||Y.ID_LOTE;
                    v_vTrazaError := '(CO: '||Y.COD_CONCEPTO||';'||'CA: '||Y.COD_CATEGORIA||';'||'TE: '||Y.COD_TECNOLOGIA||';'||'OF: '||Y.COD_APERTURA;

					IF v_vTipoApertura = 'COMISIONISTA' THEN

						v_vTrazaError := v_vTrazaError ||';'||'TIPCOMIS: '||Y.COD_TIPCOMIS;
						SELECT Sc_Conceptogrp_Fn( Y.COD_EVENTO, 'FA_CONCEPTOS', Y.COD_CONCEPTO, 'GE_CATEGORIAS', Y.COD_CATEGORIA, 'VE_TIPCOMIS', Y.COD_TIPCOMIS)
						  INTO p_nConcepto
						  FROM DUAL;

					ELSIF v_vTipoApertura = 'OFICINA' THEN

						SELECT Sc_Conceptogrp_Fn( Y.COD_EVENTO, 'FA_CONCEPTOS', Y.COD_CONCEPTO, 'GE_CATEGORIAS', Y.COD_CATEGORIA, 'GE_OFICINAS', Y.COD_APERTURA)
						  INTO p_nConcepto
						  FROM DUAL;

					ELSIF v_vTipoApertura = 'TECNOLOGIA' THEN

						SELECT Sc_Conceptogrp_Fn( Y.COD_EVENTO, 'FA_CONCEPTOS', Y.COD_CONCEPTO, 'GE_CATEGORIAS', Y.COD_CATEGORIA,'GE_OFICINAS', Y.COD_APERTURA, 'AL_TECNOLOGIA', Y.COD_TECNOLOGIA)
						  INTO p_nConcepto
						  FROM DUAL;

					END IF;

                    v_vUbicError := '10.NO Ciclos.Ins:'||Y.COD_EVENTO||','||Y.ID_LOTE||','||p_nConcepto||','||Y.IMP_CONCEPTO;

					IF p_nConcepto IS NULL THEN
						v_vUbicError := 'Sin Codigo de Concepto Agrupado '||v_vTrazaError||')';
						v_nCodError := -3;
						RAISE ERROR_PL_IMP;
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
						VALUES
						(
							Y.COD_EVENTO,
							Y.ID_LOTE,
							p_nConcepto,
							Y.IMP_CONCEPTO,
							SUBSTR( v_vTrazaError, 1, 30 ),
							p_vCodOperadoraScl
						);
					END IF;

				END LOOP;  /*CURSOR_NOCICLO*/

				EXCEPTION
					WHEN OTHERS  THEN
						v_nERROR_CRITICO := 1;
						v_nERROR_LOTE := 1;

				--registrar error pero seguir con siguiente lote.
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
					LOTE.ID_LOTE,
					v_nCodError,
					SYSDATE,
					v_vUbicError,
					p_vCodOperadoraScl
				);
			END;

		END IF;  /*LOTE.CICLO*/

		v_vUbicError := '11. Llama a PL SC_P_INGRESA_LOTE';

		IF v_nERROR_LOTE != 1 THEN

			Sc_P_Ingresa_Lote( TO_CHAR( v_nCodEvento ), LOTE.ID_LOTE, p_vCodOperadoraScl );

			SELECT COUNT(1)
			  INTO v_vCantError
			  FROM SC_ERROR_INGRESO
			 WHERE ID_LOTE = LOTE.ID_LOTE;

			IF v_vCantError != 0 THEN
				v_nERROR_CRITICO := 1;
			END IF;

		END IF;

	END LOOP; --CURSOR POR ID_LOTES.

	IF v_nERROR_CRITICO = 0 THEN
		DBMS_OUTPUT.PUT_LINE( 'TERMINO PL OK' );
	END IF;

EXCEPTION
	WHEN OTHERS THEN
		SELECT COUNT(1)
		  INTO v_vCantError
		  FROM SC_ERROR_INGRESO
		 WHERE ID_LOTE = v_vIdLote;

		IF( v_vCantError = 0 ) AND v_nERROR_CRITICO != 1 THEN
			v_vUbicError := v_vUbicError || ' ' ||TO_CHAR( SQLCODE );

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
				v_nCodError,
				SYSDATE,
				SUBSTR( v_vUbicError, 1, 100 ),
				SUBSTR( p_vCodOperadoraScl, 1, 5 )
			);

			COMMIT;
		END IF;

		RAISE_APPLICATION_ERROR( -20107, 'ERROR INESPERADO EN PL CO_IMPUTACION_CONTABLE : ORA-'||TO_CHAR(SQLCODE)||'.', TRUE );

END CO_IMPUTACION_CONTABLE_GRP;
/
SHOW ERRORS
