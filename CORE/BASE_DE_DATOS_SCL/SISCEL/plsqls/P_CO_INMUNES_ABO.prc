CREATE OR REPLACE PROCEDURE P_CO_INMUNES_ABO(
 vp_num_secuencia   IN VARCHAR2,
 vp_cod_accion      IN VARCHAR2,
 vp_cod_cliente     IN VARCHAR2,
 vp_cod_causa       IN VARCHAR2,
 vp_nom_usuario     IN VARCHAR2,
 vp_fec_desde       IN VARCHAR2,
 vp_fec_hasta       IN VARCHAR2,
 vp_lista_acciones  VARCHAR2 DEFAULT NULL
) IS
 vp_retorno		NUMBER;
 vp_gls_error	VARCHAR2(50);
 vp_ind_morosos	NUMBER;
 sz_cod_causa  VARCHAR2(4);
 --sz_fec_hasta  VARCHAR2(4);
 sz_modulo     VARCHAR2(4);
 sz_cadena	VARCHAR2(2000);
 i_pos             NUMBER(4);
 i_existe_pv       NUMBER(1);
 szhaccion     CO_RUTINAS.COD_RUTINA%TYPE;
ERROR_PROCESO EXCEPTION;

CURSOR C_INMUNES_COB (VP_CLIENTE NUMBER) IS
SELECT COD_CLIENTE, COD_ACCION
  FROM	CO_INMUNES
 WHERE	COD_CLIENTE = VP_CLIENTE
   AND	COD_CAUSA IS NULL;
   --AND    FEC_HASTA IS NULL;

CURSOR C_INMUNES_PV (VP_CLIENTE NUMBER) IS
SELECT COD_CLIENTE, COD_ACCION
  FROM	CO_INMUNES
 WHERE	COD_CLIENTE = VP_CLIENTE
   AND	COD_CAUSA IS NOT NULL
   AND    FEC_HASTA IS NOT NULL;

PROCEDURE ELIMINA_INMUNES_PV(VP_CLIENTE  NUMBER, VP_ACCION  VARCHAR2) IS
BEGIN
	DELETE
       FROM CO_INMUNES
	 WHERE COD_CLIENTE = VP_CLIENTE
	   AND COD_ACCION = VP_ACCION
	   AND COD_CAUSA IS NOT NULL
	   AND FEC_HASTA IS NOT NULL;
END;

PROCEDURE ELIMINA_INMUNES_COB(VP_CLIENTE  NUMBER, VP_ACCION VARCHAR2) IS
BEGIN
	DELETE
       FROM CO_INMUNES
	 WHERE COD_CLIENTE = VP_CLIENTE
	   AND COD_ACCION = VP_ACCION
	   AND COD_CAUSA IS NULL;
	   --AND FEC_HASTA IS NULL;
END;

PROCEDURE CREA_NVA_ACCION(VP_CLIENTE  NUMBER, VP_ACCION  VARCHAR2) IS
shNumSeq   NUMBER(8);
CURSOR C_ACCIONES ( p_cliente NUMBER, p_accion VARCHAR2 ) IS
SELECT B.COD_RUTINA,B.COD_CLIENTE,A.NUM_IDENT, A.COD_TIPIDENT, A.DEU_VENCIDA, A.DEU_NOVENC
  FROM
	(SELECT UNIQUE P.COD_RUTINA, M.COD_CLIENTE, M.NUM_IDENT, M.COD_TIPIDENT, M.DEU_VENCIDA, M.DEU_NOVENC
	  FROM CO_PTOSRUTINAS P, CO_MOROSOS M
	      ,CO_RUTINAS A
	 WHERE M.COD_CLIENTE = p_cliente -- parametro cliente
	   AND P.COD_CATEGORIA = M.COD_CATEGORIA
	   AND A.TIP_RUTINA = 'A'
	   AND A.COD_RUTINA = p_accion -- parametro accion
	   AND A.COD_RUTINA = P.COD_RUTINA
	   AND P.NUM_DIAS <= TRUNC(SYSDATE) - NVL( M.FEC_DEUDVENC, SYSDATE )
	   AND M.SEC_MOROSO > 0) A
	 ,CO_ACCIONES B
WHERE B.COD_CLIENTE = A.COD_CLIENTE
  AND B.COD_RUTINA = A.COD_RUTINA
  AND B.COD_ESTADO = 'INM'
  AND NOT EXISTS (SELECT 1
  	  	  		 	FROM CO_ACCIONES C
				   WHERE C.COD_CLIENTE = B.COD_CLIENTE
					 AND C.COD_RUTINA = B.COD_RUTINA
					 AND C.COD_ESTADO = 'PND');
BEGIN
   FOR C1 IN C_ACCIONES(VP_CLIENTE,VP_ACCION) LOOP
	 SELECT CO_SEQ_ACCION.NEXTVAL INTO shNumSeq FROM DUAL;
	 INSERT INTO CO_ACCIONES (COD_CLIENTE, NUM_SECUENCIA, COD_RUTINA, COD_ESTADO,
						FEC_ESTADO,  FEC_EJECPROG,  NOM_USUARIO, CNT_ABOCELU,
						CNT_ABOBEEP, NUM_IDENT,    COD_TIPIDENT, DEU_VENCIDA, DEU_NOVENC )
				  VALUES (C1.COD_CLIENTE, shNumSeq, C1.COD_RUTINA, 'PND',
				  		SYSDATE, SYSDATE, USER, 0,
				  		0, C1.NUM_IDENT, C1.COD_TIPIDENT, C1.DEU_VENCIDA, C1.DEU_NOVENC);
   END LOOP;
END;

BEGIN
	IF UPPER(vp_cod_causa) = 'NULL' THEN
		sz_modulo := 'COB';
		sz_cod_causa := NULL;
		--sz_fec_hasta := NULL;
		vp_retorno := 9;
		vp_gls_error := 'Existe reg. PV CO_INMUNES';
		SELECT SIGN(NVL(COUNT(1),0))
		  INTO i_existe_pv
		  FROM CO_INMUNES
		WHERE COD_CLIENTE = TO_NUMBER(vp_cod_cliente)
		  --AND FEC_HASTA IS NOT NULL
		  AND COD_CAUSA IS NOT NULL;
	ELSE
	   sz_modulo := 'POST';
	END IF;
	IF vp_cod_accion = 'BAJA' AND vp_lista_acciones IS NULL THEN
		IF sz_modulo = 'POST' THEN /*es de POST-VENTA */
			vp_retorno := 1;
			vp_gls_error := 'Delete CO_INMUNES Post-Venta';
			FOR C1 IN C_INMUNES_PV(TO_NUMBER(vp_cod_cliente)) LOOP
			  vp_retorno := 1;
			  vp_gls_error := 'Elimina inmunes Post-Venta';
			  ELIMINA_INMUNES_PV(C1.COD_CLIENTE, C1.COD_ACCION);
			  vp_retorno := 1;
			  vp_gls_error := 'Crea nueva accion Post-Venta';
			  CREA_NVA_ACCION(C1.COD_CLIENTE,C1.COD_ACCION);
               END LOOP;
		ELSE 				/*es de COBRANZA */
			IF i_existe_pv = 0 THEN
				vp_retorno :=  2;
				vp_gls_error := 'Delete CO_INMUNES Cobranza';
				FOR C1 IN C_INMUNES_COB(TO_NUMBER(vp_cod_cliente)) LOOP
				  vp_retorno := 2;
				  vp_gls_error := 'Elimina inmunes cobranza';
				  ELIMINA_INMUNES_COB(C1.COD_CLIENTE, C1.COD_ACCION);
				  vp_retorno := 2;
				  vp_gls_error := 'Crea nueva accion Cobranza';
				  CREA_NVA_ACCION(C1.COD_CLIENTE,C1.COD_ACCION);
	               END LOOP;
			ELSE
			   	vp_retorno :=  9;
				vp_gls_error := 'Existe inmunidad de Post-Venta';
				RAISE ERROR_PROCESO;
			END IF;
		END IF;
	ELSIF vp_cod_accion = 'BAJA' AND vp_lista_acciones IS NOT NULL THEN /* la o las acciones vienen en la lista */
		IF sz_modulo = 'POST' THEN /*es de POST-VENTA */
			vp_retorno := 3;
			vp_gls_error := 'Delete CO_INMUNES Post-Venta';
			sz_cadena:=vp_lista_acciones;
			i_pos:=instr(sz_cadena,';');
			WHILE i_pos > 0 LOOP
				szhaccion:=substr(sz_cadena,1,i_pos-1);
				sz_cadena:=substr(sz_cadena,i_pos+1,length(sz_cadena)-i_pos);
				i_pos:=instr(sz_cadena,';');
				ELIMINA_INMUNES_PV(TO_NUMBER(vp_cod_cliente), szhaccion);
				CREA_NVA_ACCION(TO_NUMBER(vp_cod_cliente),szhaccion);
			END LOOP;
			IF i_pos = 0 and length(sz_cadena) > 0 THEN
				szhaccion:=sz_cadena;
				ELIMINA_INMUNES_PV(TO_NUMBER(vp_cod_cliente), szhaccion);
				CREA_NVA_ACCION(TO_NUMBER(vp_cod_cliente),szhaccion);
			END IF;
		ELSE 				/*es de COBRANZA */
			IF i_existe_pv = 0 THEN
				vp_retorno :=  4;
				vp_gls_error := 'Delete CO_INMUNES Cobranza';
				sz_cadena:=vp_lista_acciones;
				i_pos:=instr(sz_cadena,';');
				WHILE i_pos > 0 LOOP
					szhaccion:=substr(sz_cadena,1,i_pos-1);
					sz_cadena:=substr(sz_cadena,i_pos+1,length(sz_cadena)-i_pos);
					i_pos:=instr(sz_cadena,';');
					ELIMINA_INMUNES_COB(TO_NUMBER(vp_cod_cliente), szhaccion);
				     CREA_NVA_ACCION(TO_NUMBER(vp_cod_cliente), szhaccion);
				END LOOP;
				IF i_pos = 0 and length(sz_cadena) > 0 THEN
					szhaccion:=sz_cadena;
					ELIMINA_INMUNES_COB(TO_NUMBER(vp_cod_cliente), szhaccion);
				     CREA_NVA_ACCION(TO_NUMBER(vp_cod_cliente), szhaccion);
				END IF;
			ELSE
			   	vp_retorno :=  9;
				vp_gls_error := 'Existe inmunidad de Post-Venta';
				RAISE ERROR_PROCESO;
			END IF;
		END IF;
     ELSIF vp_cod_accion = 'ALTA' AND vp_lista_acciones IS NULL THEN /* la o las acciones vienen en la lista */ /* ALTA */
          vp_retorno := 5;
          vp_gls_error := 'Insert CO_INMUNES';
		IF sz_modulo = 'POST' THEN /*es de POST-VENTA */
			INSERT INTO CO_INMUNES ( COD_CLIENTE, COD_ACCION, FEC_ULTMOD, FEC_HASTA,   COD_CAUSA,  NOM_USUARIO )
			SELECT	TO_NUMBER(vp_cod_cliente),
					COD_RUTINA,
					TO_DATE(vp_fec_desde,'ddmmyy'),
					TO_DATE(vp_fec_hasta,'ddmmyy'),
					vp_cod_causa,
					vp_nom_usuario
			FROM	CO_RUTINAS
			WHERE	TIP_RUTINA = 'A'
			AND		COD_RUTINA NOT IN (	SELECT	COD_ACCION
										FROM	CO_INMUNES
										WHERE	COD_CLIENTE = TO_NUMBER(vp_cod_cliente)
										AND		NVL(FEC_HASTA,SYSDATE) >= TRUNC(SYSDATE) );
		ELSE/*es de COBRANZA */
			vp_retorno := 6;
        		vp_gls_error := 'Insert CO_INMUNES';
			INSERT INTO CO_INMUNES ( COD_CLIENTE, COD_ACCION, FEC_ULTMOD, FEC_HASTA,   COD_CAUSA,  NOM_USUARIO )
			SELECT	TO_NUMBER(vp_cod_cliente),
					COD_RUTINA,
					TO_DATE(vp_fec_desde,'ddmmyy'),
					TO_DATE(vp_fec_hasta,'ddmmyy'),
					sz_cod_causa,
					vp_nom_usuario
			FROM	CO_RUTINAS
			WHERE	TIP_RUTINA = 'A'
			AND		COD_RUTINA NOT IN (	SELECT	COD_ACCION
										FROM	CO_INMUNES
										WHERE	COD_CLIENTE = TO_NUMBER(vp_cod_cliente)
										AND		NVL(FEC_HASTA,SYSDATE) >= TRUNC(SYSDATE) );
		END IF;
	ELSIF vp_cod_accion = 'ALTA' AND vp_lista_acciones IS NOT NULL THEN
		IF sz_modulo = 'POST' THEN /*es de POST-VENTA */
			vp_retorno := 7;
			vp_gls_error := 'Insert CO_INMUNES Post-Venta';
			sz_cadena:=vp_lista_acciones;
			i_pos:=instr(sz_cadena,';');
			WHILE i_pos > 0 LOOP
				szhaccion:=substr(sz_cadena,1,i_pos-1);
				sz_cadena:=substr(sz_cadena,i_pos+1,length(sz_cadena)-i_pos);
				i_pos:=instr(sz_cadena,';');
				INSERT INTO CO_INMUNES ( COD_CLIENTE, COD_ACCION, FEC_ULTMOD, FEC_HASTA,   COD_CAUSA,  NOM_USUARIO )
				SELECT	TO_NUMBER(vp_cod_cliente),
						COD_RUTINA,
						TO_DATE(vp_fec_desde,'ddmmyy'),
						TO_DATE(vp_fec_hasta,'ddmmyy'),
						vp_cod_causa,
						vp_nom_usuario
				FROM	CO_RUTINAS
				WHERE	TIP_RUTINA = 'A'
				  AND COD_RUTINA = szhaccion
				  AND COD_RUTINA NOT IN ( SELECT COD_ACCION
									   FROM CO_INMUNES
									  WHERE COD_CLIENTE = TO_NUMBER(vp_cod_cliente)
									    AND NVL(FEC_HASTA,SYSDATE) >= TRUNC(SYSDATE) );
			END LOOP;
			IF i_pos = 0 and length(sz_cadena) > 0 THEN
				szhaccion:=sz_cadena;
				INSERT INTO CO_INMUNES ( COD_CLIENTE, COD_ACCION, FEC_ULTMOD, FEC_HASTA,   COD_CAUSA,  NOM_USUARIO )
				SELECT	TO_NUMBER(vp_cod_cliente),
						COD_RUTINA,
						TO_DATE(vp_fec_desde,'ddmmyy'),
						TO_DATE(vp_fec_hasta,'ddmmyy'),
						vp_cod_causa,
						vp_nom_usuario
				FROM	CO_RUTINAS
				WHERE	TIP_RUTINA = 'A'
				  AND COD_RUTINA = szhaccion
				  AND COD_RUTINA NOT IN ( SELECT COD_ACCION
									   FROM CO_INMUNES
									  WHERE COD_CLIENTE = TO_NUMBER(vp_cod_cliente)
									    AND NVL(FEC_HASTA,SYSDATE) >= TRUNC(SYSDATE) );
			END IF;
		ELSE /*es de COBRANZA */
			vp_retorno := 8;
			vp_gls_error := 'Insert CO_INMUNES COBRANZA';
			sz_cadena:=vp_lista_acciones;
			i_pos:=instr(sz_cadena,';');
			WHILE i_pos > 0 LOOP
				szhaccion:=substr(sz_cadena,1,i_pos-1);
				sz_cadena:=substr(sz_cadena,i_pos+1,length(sz_cadena)-i_pos);
				i_pos:=instr(sz_cadena,';');
				INSERT INTO CO_INMUNES ( COD_CLIENTE, COD_ACCION, FEC_ULTMOD, FEC_HASTA,   COD_CAUSA,  NOM_USUARIO )
				SELECT	TO_NUMBER(vp_cod_cliente),
						COD_RUTINA,
						TO_DATE(vp_fec_desde,'ddmmyy'),
						TO_DATE(vp_fec_hasta,'ddmmyy'),
						sz_cod_causa,
						vp_nom_usuario
				FROM	CO_RUTINAS
				WHERE	TIP_RUTINA = 'A'
				  AND COD_RUTINA = szhaccion
				  AND COD_RUTINA NOT IN ( SELECT COD_ACCION
									   FROM CO_INMUNES
									  WHERE COD_CLIENTE = TO_NUMBER(vp_cod_cliente)
									    AND NVL(FEC_HASTA,SYSDATE) >= TRUNC(SYSDATE) );
			END LOOP;
			IF i_pos = 0 and length(sz_cadena) > 0 THEN
				szhaccion:=sz_cadena;
				INSERT INTO CO_INMUNES ( COD_CLIENTE, COD_ACCION, FEC_ULTMOD, FEC_HASTA,   COD_CAUSA,  NOM_USUARIO )
				SELECT	TO_NUMBER(vp_cod_cliente),
						COD_RUTINA,
						TO_DATE(vp_fec_desde,'ddmmyy'),
						TO_DATE(vp_fec_hasta,'ddmmyy'),
						sz_cod_causa,
						vp_nom_usuario
				FROM	CO_RUTINAS
				WHERE	TIP_RUTINA = 'A'
				  AND COD_RUTINA = szhaccion
				  AND COD_RUTINA NOT IN ( SELECT COD_ACCION
									   FROM CO_INMUNES
									  WHERE COD_CLIENTE = TO_NUMBER(vp_cod_cliente)
									    AND NVL(FEC_HASTA,SYSDATE) >= TRUNC(SYSDATE) );
			END IF;
		END IF;
    ELSIF vp_cod_accion = 'MODI' THEN /* Actualiza Fecha de Inmunidad (Cobranza)*/
        vp_gls_error := 'Actualiza Co_inmunes';
        UPDATE co_inmunes
        SET fec_ultmod = TO_DATE(vp_fec_desde,'ddmmyy'),
        fec_hasta = TO_DATE(vp_fec_hasta,'ddmmyy'),
        nom_usuario = vp_nom_usuario
        WHERE cod_cliente = TO_NUMBER(vp_cod_cliente)
        AND cod_accion = vp_lista_acciones;    
	END IF;
	vp_retorno := 0;
	vp_gls_error := 'OK';
	RAISE ERROR_PROCESO;
	EXCEPTION
	 WHEN ERROR_PROCESO THEN
	      INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
	      VALUES (TO_NUMBER(vp_num_secuencia), vp_retorno, vp_gls_error);
	 WHEN DUP_VAL_ON_INDEX THEN
	      ROLLBACK;
	      INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
	      VALUES (TO_NUMBER(vp_num_secuencia), vp_retorno, vp_gls_error);
	 WHEN NO_DATA_FOUND THEN
	      ROLLBACK;
	      INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
	      VALUES (TO_NUMBER(vp_num_secuencia), vp_retorno, vp_gls_error);
	 WHEN OTHERS THEN
	      ROLLBACK;
	      INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
	      VALUES (TO_NUMBER(vp_num_secuencia), vp_retorno, vp_gls_error);
END P_CO_INMUNES_ABO; 
/
SHOW ERRORS