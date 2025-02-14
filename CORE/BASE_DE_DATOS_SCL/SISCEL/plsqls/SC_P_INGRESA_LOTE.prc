CREATE OR REPLACE PROCEDURE SC_P_INGRESA_LOTE
(p_vCodEvento		IN VARCHAR2
,p_vIdLote			IN SC_ENT_CAB_LOTE.ID_LOTE%TYPE
,p_vCodOperadoraScl	IN VARCHAR2
)
IS
v_nCodEvento			SC_ENT_CAB_LOTE.COD_EVENTO%TYPE;
v_vCodConcepto			SC_ENT_LOTE.COD_CONCEPTO%TYPE;
v_nExisteError			NUMBER;
v_nPerContable			SC_ENT_CAB_LOTE.PER_CONTABLE%TYPE;
v_nPerContableOld		SC_ENT_CAB_LOTE.PER_CONTABLE%TYPE;
v_vPerContableChar		VARCHAR2(6);
v_dDateContable			DATE;
v_nUltPerCont			SC_ENT_CAB_LOTE.PER_CONTABLE%TYPE;
v_vUltPerContChar		VARCHAR2(6);
v_dUltDateCont			DATE;
v_vNomUsuarioLote		SC_ENT_CAB_LOTE.NOM_USUARIO_LOTE%TYPE;
v_dFecLote				SC_ENT_CAB_LOTE.FEC_LOTE%TYPE;
v_dFecLoteOld			SC_ENT_CAB_LOTE.FEC_LOTE%TYPE;
v_nNumLoteOld			SC_CAB_LOTE.NUM_LOTE%TYPE;
v_vIndEsttransit		SC_PER_CONT.IND_ESTTRANSIT%TYPE;
v_cIndEstdefinit		SC_PER_CONT.IND_ESTDEFINIT%TYPE;
v_nNuevoNumLote			SC_CAB_LOTE.NUM_LOTE%TYPE;
v_vNomUsuarioCont		SC_CAB_LOTE.NOM_USUARIO_CONT%TYPE;
v_dFecCont				SC_CAB_LOTE.FEC_CONT%TYPE;
v_vNomUsuarioOK			SC_CAB_LOTE.NOM_USUARIO_OK%TYPE;
v_dFecOK				SC_CAB_LOTE.FEC_OK%TYPE;
v_vNomArchivo			SC_PROCARCH.NOM_ARCHIVO%TYPE;
v_nExiste				NUMBER;
v_vNomTabla				VARCHAR2(30);
v_vDesOperacion			VARCHAR2(6);
v_nCodError				SC_ERROR_INGRESO.COD_ERROR%TYPE;
v_vDesError				SC_ERROR_INGRESO.DES_ERROR%TYPE;
v_nIndGrpDominio		SC_EVENTO.IND_GRP_DOMINIO%TYPE;
v_vIdLote				SC_ENT_CAB_LOTE.ID_LOTE%TYPE;

ERROR_INGRESO           EXCEPTION;

BEGIN

	v_nCodEvento := TO_NUMBER( LTRIM( RTRIM( p_vCodEvento ) ) );

	v_vIdLote := p_vIdLote;

	SELECT COUNT(1)
	  INTO v_nExisteError
	  FROM SC_ERROR_INGRESO
	 WHERE COD_EVENTO = v_nCodEvento
	   AND ID_LOTE = v_vIdLote
	   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

	IF v_nExisteError = 1 THEN

		DELETE FROM SC_ERROR_INGRESO
		 WHERE COD_EVENTO = v_nCodEvento
		   AND ID_LOTE = v_vIdLote
		   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

		COMMIT;
	END IF;

	-- Valida que se haya movido el lote a tablas de entrada
	BEGIN
		-- Consulta si el lote especificado existe en tablas de entrada
		SELECT PER_CONTABLE,
			   NOM_USUARIO_LOTE,
			   FEC_LOTE
		  INTO v_nPerContable,
		  	   v_vNomUsuarioLote,
		  	   v_dFecLote
		  FROM SC_ENT_CAB_LOTE
		 WHERE COD_EVENTO = v_nCodEvento
		   AND ID_LOTE = p_vIdLote
		   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

		v_vPerContableChar := SUBSTR( TO_CHAR( v_nPerContable, '099999' ), 2, 6 );
		v_dDateContable := TO_DATE( v_vPerContableChar || '01', 'YYYYMMDD' );

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				-- Lote especificado no existe en tablas de entrada
				v_nCodError := 10;
			RAISE ERROR_INGRESO;
	END;

	-- Valida si se trata de un evento de dominio simple o de un grupo de dominio
	SELECT NVL( IND_GRP_DOMINIO, 0 )
	  INTO v_nIndGrpDominio
	  FROM SC_EVENTO
	 WHERE COD_EVENTO = v_nCodEvento;

	IF v_nIndGrpDominio = 0 THEN  -- evento de dominio simple
		--  Consulta si los conceptos estn registrados como contabilizables en el MISC.
		SELECT COUNT(1)
		  INTO v_nExisteError
		  FROM SC_ENT_LOTE EL
		 WHERE EL.COD_EVENTO = v_nCodEvento
		   AND EL.ID_LOTE = p_vIdLote
		   AND EL.COD_OPERADORA_SCL = p_vCodOperadoraScl
		   AND NOT EXISTS ( SELECT C.ROWID
							  FROM SC_CONCEPTO C, SC_EVENTO E, SC_ENT_CAB_LOTE ECL
							 WHERE C.IND_CONTABILIZA = 0
							   AND C.COD_DOMINIO_CTO = E.COD_DOMINIO_CTO
							   AND C.COD_CONCEPTO = EL.COD_CONCEPTO
							   AND E.COD_EVENTO = ECL.COD_EVENTO
							   AND ECL.COD_EVENTO = EL.COD_EVENTO
							   AND ECL.ID_LOTE = EL.ID_LOTE
							   AND ECL.COD_OPERADORA_SCL = p_vCodOperadoraScl );

		IF v_nExisteError > 0 THEN
			-- Existe un concepto (al menos) sin cuenta asociada
			-- Busca el concepto
			SELECT EL.COD_CONCEPTO
			  INTO v_vCodConcepto
			  FROM SC_ENT_LOTE EL
			 WHERE EL.COD_EVENTO = v_nCodEvento
			   AND EL.ID_LOTE = p_vIdLote
			   AND EL.COD_OPERADORA_SCL  = p_vCodOperadoraScl
			   AND NOT EXISTS ( SELECT C.ROWID
								  FROM SC_CONCEPTO C, SC_EVENTO E, SC_ENT_CAB_LOTE ECL
								 WHERE C.IND_CONTABILIZA = 0
								   AND C.COD_DOMINIO_CTO = E.COD_DOMINIO_CTO
								   AND C.COD_CONCEPTO = EL.COD_CONCEPTO
								   AND E.COD_EVENTO = ECL.COD_EVENTO
								   AND ECL.COD_EVENTO = EL.COD_EVENTO
								   AND ECL.ID_LOTE = EL.ID_LOTE
								   AND ECL.COD_OPERADORA_SCL = p_vCodOperadoraScl )
			   AND ROWNUM = 1;

			v_nCodError := 05;
			RAISE ERROR_INGRESO;
		END IF;
	 ELSE -- evento de dominio agrupado
		--  Consulta si los conceptos estn registrados como contabilizables en el MISC.
		SELECT COUNT(1)
		  INTO v_nExisteError
		  FROM SC_ENT_LOTE EL
		 WHERE EL.COD_EVENTO = v_nCodEvento
		   AND EL.ID_LOTE = p_vIdLote
		   AND EL.COD_OPERADORA_SCL = p_vCodOperadoraScl
		   AND NOT EXISTS ( SELECT C.ROWID
							  FROM SC_GRP_DOMINIO_DET C, SC_EVENTO E, SC_ENT_CAB_LOTE ECL
							 WHERE C.IND_CONTABILIZA_GRP = 0
							   AND C.COD_GRP_DOMINIO = E.COD_DOMINIO_CTO
							   AND C.COD_CTO_GRP = EL.COD_CONCEPTO
							   AND E.COD_EVENTO = ECL.COD_EVENTO
							   AND ECL.COD_EVENTO = EL.COD_EVENTO
							   AND ECL.ID_LOTE = EL.ID_LOTE
							   AND ECL.COD_OPERADORA_SCL = p_vCodOperadoraScl );

	    IF v_nExisteError > 0 THEN
			-- Existe un concepto (al menos) sin cuenta asociada
			-- Busca el concepto
			SELECT EL.COD_CONCEPTO
			  INTO v_vCodConcepto
			  FROM SC_ENT_LOTE EL
			 WHERE EL.COD_EVENTO = v_nCodEvento
			   AND EL.ID_LOTE = p_vIdLote
			   AND EL.COD_OPERADORA_SCL  = p_vCodOperadoraScl
			   AND NOT EXISTS ( SELECT C.ROWID
								  FROM SC_GRP_DOMINIO_DET C, SC_EVENTO E, SC_ENT_CAB_LOTE ECL
								 WHERE C.IND_CONTABILIZA_GRP = 0
								   AND C.COD_GRP_DOMINIO = E.COD_DOMINIO_CTO
								   AND C.COD_CTO_GRP = EL.COD_CONCEPTO
								   AND E.COD_EVENTO = ECL.COD_EVENTO
								   AND ECL.COD_EVENTO = EL.COD_EVENTO
								   AND ECL.ID_LOTE = EL.ID_LOTE
								   AND ECL.COD_OPERADORA_SCL = p_vCodOperadoraScl )
			   AND ROWNUM = 1;

			v_nCodError := 05;
			RAISE ERROR_INGRESO;
		END IF;
	END IF;

	-- Consulta si el lote ha sido ingresado antes al MISC
	SELECT COUNT(1)
	  INTO v_nExiste
	  FROM SC_CAB_LOTE
	 WHERE COD_EVENTO = v_nCodEvento
	   AND ID_LOTE = v_vIdLote
	   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

	IF v_nExiste = 1 THEN
		-- Lote ha sido ingresado antes al MISC, se chequeara si esta contabilizado OK o no
		SELECT NUM_LOTE,
			   NOM_USUARIO_CONT,
			   FEC_CONT,
			   NOM_USUARIO_OK,
			   FEC_OK,
			   PER_CONTABLE,
			   FEC_LOTE
		  INTO v_nNumLoteOld,
			   v_vNomUsuarioCont,
			   v_dFecCont,
			   v_vNomUsuarioOK,
			   v_dFecOK,
			   v_nPerContableOld,
			   v_dFecLoteOld
		  FROM SC_CAB_LOTE
		 WHERE COD_EVENTO = v_nCodEvento
		   AND ID_LOTE = v_vIdLote
		   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

		IF v_vNomUsuarioOK IS NOT NULL  AND  v_dFecOK IS NOT NULL THEN
			-- Si el lote esta contabilizado
			v_nCodError := 01;
			RAISE ERROR_INGRESO;
		ELSE
			-- Lote NO esta contabilizado, se puede eliminar versisn anterior para reemplazar
			BEGIN
				v_vNomTabla := 'SC_ASIENTO_LOTE';
				v_vDesOperacion := 'DELETE';

				DELETE FROM SC_ASIENTO_LOTE
				 WHERE NUM_LOTE  = v_nNumLoteOld
				   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

				v_vNomTabla := 'SC_LOTE';
				v_vDesOperacion := 'DELETE';

				DELETE FROM SC_LOTE
				 WHERE NUM_LOTE = v_nNumLoteOld;

				v_vNomTabla := 'SC_CAB_LOTE';
				v_vDesOperacion := 'DELETE';

				DELETE FROM SC_CAB_LOTE
				 WHERE NUM_LOTE = v_nNumLoteOld;

				IF v_vNomUsuarioCont IS NOT NULL  AND  v_dFecCont IS NOT NULL THEN
					--Si el lote esta procesado
					-- Chequea que se haya generado un archivo
					v_vNomTabla := 'SC_PROCARCH';
					v_vDesOperacion := 'SELECT';

					SELECT COUNT(1)
					  INTO v_nExiste
					  FROM SC_PROCARCH
					 WHERE IND_ACCION = 'C'
					   AND COD_EVENTO = v_nCodEvento
					   AND ID_LOTE = v_vIdLote
					   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

					IF v_nExiste = 1 THEN
						-- Se da la orden de eliminar el archivo de la version anterior
						-- 1) busca nombre del archivo
						v_vNomTabla := 'SC_PROCARCH';
						v_vDesOperacion := 'SELECT';

						SELECT LTRIM( RTRIM( NOM_ARCHIVO ) )
						  INTO v_vNomArchivo
						  FROM SC_PROCARCH
						 WHERE IND_ACCION = 'C'
						   AND COD_EVENTO = v_nCodEvento
						   AND ID_LOTE = v_vIdLote
						   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

						-- 2) da la orden de eliminacion
						v_vNomTabla := 'SC_PROCARCH';
						v_vDesOperacion := 'INSERT';

						INSERT INTO SC_PROCARCH
						(
							COD_EVENTO,
							ID_LOTE,
							IND_ACCION,
							NOM_ARCHIVO,
							FEC_TRANSAC,
							IND_ESTADO,
							COD_OPERADORA_SCL
						)
						VALUES
						(
							v_nCodEvento,
							v_vIdLote,
							'E',
							v_vNomArchivo,
							SYSDATE,
							'P',
							p_vCodOperadoraScl
						);
					END IF;
				END IF;

				EXCEPTION
					WHEN OTHERS THEN
						v_nCodError := 99;
					RAISE ERROR_INGRESO;
			END;
		END IF;
	ELSE
		-- Lote NO ha sido ingresado antes al MISC
		-- Consulta si el periodo existe
		SELECT COUNT(1)
		  INTO v_nExiste
		  FROM SC_PER_CONT
		 WHERE PER_CONTABLE = v_nPerContable;

		IF v_nExiste = 0 THEN
			-- Periodo contable NO existe, se intenta crearlo
			SELECT NVL( MAX( PER_CONTABLE ), TO_NUMBER( TO_CHAR( ADD_MONTHS( SYSDATE, -1 ), 'YYYYMM' ) ) )
			  INTO v_nUltPerCont
			  FROM SC_PER_CONT;

			v_vUltPerContChar := SUBSTR( TO_CHAR( v_nUltPerCont, '099999' ), 2, 6 );
			v_dUltDateCont := TO_DATE( v_vUltPerContChar || '01', 'YYYYMMDD' );

			IF v_dDateContable <> ADD_MONTHS( v_dUltDateCont, 1 ) OR
				v_dDateContable > TRUNC( SYSDATE, 'MONTH' ) THEN
				-- Periodo contable del lote es erroneo
				v_nCodError := 04;
				RAISE ERROR_INGRESO;
			ELSE
				-- Periodo contable del lote puede ser creado abierto
				BEGIN
					-- Inserta nuevo periodo contable
					v_vNomTabla := 'SC_PER_CONT';
					v_vDesOperacion := 'INSERT';

					INSERT INTO SC_PER_CONT
					(
						PER_CONTABLE,
						IND_ESTTRANSIT,
						FEC_ESTTRANSIT,
						IND_ESTDEFINIT,
						FEC_ESTDEFINIT,
						NOM_USUARIO
					)
					VALUES
					(
						v_nPerContable,
						'A',
						SYSDATE,
						'A',
						SYSDATE,
						v_vNomUsuarioLote
					);

					EXCEPTION
						WHEN OTHERS THEN
							v_nCodError := 99;
						RAISE ERROR_INGRESO;
				END;
			END IF;
		ELSE
			-- Periodo contable existe, debe chequearse que esti abierto
			SELECT IND_ESTTRANSIT,
				   IND_ESTDEFINIT
			  INTO v_vIndEsttransit,
			  	   v_cIndEstdefinit
			  FROM SC_PER_CONT
			 WHERE PER_CONTABLE = v_nPerContable;

			IF v_cIndEstdefinit = 'C' THEN
				v_nCodError := 02;
				RAISE ERROR_INGRESO;
			ELSIF v_vIndEsttransit = 'C' THEN
				v_nCodError := 03;
				RAISE ERROR_INGRESO;
			END IF;
		END IF;
	END IF;

	-- Se ingresa el lote
	-- Obtiene nuevo numero de lote
	SELECT SC_SEQ_LOTE.NEXTVAL
	  INTO v_nNuevoNumLote
	  FROM DUAL;

	BEGIN
		-- Inserta encabezado del lote
		v_vNomTabla     := 'SC_CAB_LOTE';
		v_vDesOperacion := 'INSERT';

		INSERT INTO SC_CAB_LOTE
		(
			COD_EVENTO,
			ID_LOTE,
			PER_CONTABLE,
			NOM_USUARIO_LOTE,
			FEC_LOTE,
			NUM_LOTE,
			NOM_USUARIO_CONT,
			FEC_CONT,
			NOM_USUARIO_OK,
			FEC_OK,
			COD_OPERADORA_SCL
		)
		SELECT COD_EVENTO,
			   v_vIdLote,
			   PER_CONTABLE,
			   NOM_USUARIO_LOTE,
			   FEC_LOTE,
			   v_nNuevoNumLote,
			   NULL,
			   NULL,
			   NULL,
			   NULL,
			   COD_OPERADORA_SCL
		  FROM SC_ENT_CAB_LOTE
		 WHERE COD_EVENTO = v_nCodEvento
		   AND ID_LOTE = p_vIdLote
		   AND COD_OPERADORA_SCL = p_vCodOperadoraScl
		   AND EXISTS ( SELECT 1
						  FROM SC_ENT_LOTE
						 WHERE COD_EVENTO = v_nCodEvento
						   AND ID_LOTE = p_vIdLote
						   AND COD_OPERADORA_SCL = p_vCodOperadoraScl
				           AND IMP_MOVIMIENTO != 0 );

		-- Inserta masivamente detalle del lote
		v_vNomTabla := 'SC_LOTE';
		v_vDesOperacion := 'INSERT';

		INSERT INTO SC_LOTE
		(
			NUM_LOTE,
			COD_CONCEPTO,
			IMP_MOVIMIENTO,
			DES_TRANSACCION--,
			--COD_PLAZA
		)
		SELECT v_nNuevoNumLote,
			   COD_CONCEPTO,
			   SUM( NVL( IMP_MOVIMIENTO, 0 ) ),
			   DES_TRANSACCION--,
			   --COD_PLAZA
		  FROM SC_ENT_LOTE
		 WHERE COD_EVENTO = v_nCodEvento
		   AND ID_LOTE = p_vIdLote
		   AND COD_OPERADORA_SCL = p_vCodOperadoraScl
         GROUP BY COD_CONCEPTO, DES_TRANSACCION--, COD_PLAZA
         HAVING SUM( NVL( IMP_MOVIMIENTO, 0 ) ) != 0;

		-- Elimina detalle del lote de tabla de paso
		v_vNomTabla := 'SC_ENT_LOTE';
		v_vDesOperacion := 'DELETE';

		DELETE FROM SC_ENT_LOTE
		 WHERE COD_EVENTO = v_nCodEvento
		   AND ID_LOTE = p_vIdLote
		   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

		-- Elimina encabezado del lote de tabla de paso
		v_vNomTabla     := 'SC_ENT_CAB_LOTE';
		v_vDesOperacion := 'DELETE';

		DELETE FROM SC_ENT_CAB_LOTE
		 WHERE COD_EVENTO = v_nCodEvento
		   AND ID_LOTE = p_vIdLote
		   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

		EXCEPTION
			WHEN OTHERS THEN
				v_nCodError := 99;
			RAISE ERROR_INGRESO;
	END;

	COMMIT;

EXCEPTION
	WHEN OTHERS THEN
		-- ROLLBACK;
		IF v_nCodError = 01 THEN
			v_vDesError := 'LOTE ESPECIFICADO YA HA SIDO CONTABILIZADO '||SUBSTR(TO_CHAR(v_nCodEvento,'09'),2,2)||' - '
			||p_vIdLote;
		ELSIF v_nCodError = 02 THEN
			v_vDesError := 'PERIODO CONTABLE ESTA CERRADO DEFINITIVAMENTE '||SUBSTR(TO_CHAR(v_nCodEvento,'09'),2,2)||' - '
			||p_vIdLote||' - '||SUBSTR(TO_CHAR(v_nPerContable,'099999'),2,6);
		ELSIF v_nCodError = 03 THEN
			v_vDesError := 'PERIODO CONTABLE ESTA CERRADO TRANSITORIAMENTE '||SUBSTR(TO_CHAR(v_nCodEvento,'09'),2,2)||' - '
			||p_vIdLote||' - '||SUBSTR(TO_CHAR(v_nPerContable,'099999'),2,6);
		ELSIF v_nCodError = 04 THEN
			v_vDesError := 'PERIODO CONTABLE ES ERRONEO '||SUBSTR(TO_CHAR(v_nCodEvento,'09'),2,2)||' - '
			||p_vIdLote||' - '||SUBSTR(TO_CHAR(v_nPerContable,'099999'),2,6);
		ELSIF v_nCodError = 05 THEN
			v_vDesError := 'CONCEPTO NO CONTABILIZABLE EN MISC '||SUBSTR(TO_CHAR(v_nCodEvento,'09'),2,2)||' - '
			||p_vIdLote||' - '||v_vCodConcepto; /* 09 - 12668 - 000001 */
		ELSIF v_nCodError = 10 THEN
			v_vDesError := 'LOTE ESPECIFICADO NO ESTA EN TABLAS DE ENTRADA '||SUBSTR(TO_CHAR(v_nCodEvento,'09'),2,2)||' - '
			||p_vIdLote;
		ELSE   --v_nCodError := 99;
			v_vDesError := 'ERROR EN ACTUALIZACION DE TABLA '||v_vNomTabla||' - '||v_vDesOperacion;
		END IF;


		IF v_nCodError != 0 THEN
			INSERT INTO SC_ERROR_INGRESO
			(
				COD_EVENTO,
				ID_LOTE,
				COD_ERROR,
				FEC_ERROR,
				DES_ERROR,
				COD_OPERADORA_SCL--,
				--COD_PLAZA
			)
			VALUES
			(
				v_nCodEvento,
				p_vIdLote,
				v_nCodError,
				SYSDATE,
				v_vDesError,
				p_vCodOperadoraScl--,
				--' '
			);
		END IF;

		COMMIT;

END SC_P_INGRESA_LOTE;
/
SHOW ERRORS
