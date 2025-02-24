CREATE OR REPLACE PROCEDURE        PV_EMISIONFACTGLOBAL(
V_SECUENCIA  	  IN VARCHAR2,
V_CODVENTA   	  IN VARCHAR2,
V_CODCLIENTE 	  IN VARCHAR2,
V_CODACTABO		  IN VARCHAR2,
V_CODPRODUCTO	  IN VARCHAR2,
V_CODTIPMODI	  IN VARCHAR2) IS
/******************************************************************************
AUTOR    :  MANUEL ACEVEDO
AREA     :  POSTVENTA
EMPRESA  :  TELEFONICA MOVIL SOLUTION S.A.
******************************************************************************/

V_IND_ORDENTOTAL	   FA_HISTDOCU.IND_ORDENTOTAL%TYPE;
V_CICLFACT 			   FA_HISTDOCU.COD_CICLFACT%TYPE;
V_TIPDOCUM			   FA_HISTDOCU.COD_TIPDOCUM%TYPE;
V_SECUENCI			   FA_HISTDOCU.NUM_SECUENCI%TYPE;
V_VENDEDOR_AGENTE	   FA_HISTDOCU.COD_VENDEDOR_AGENTE%TYPE;
V_LETRA				   FA_HISTDOCU.LETRA%TYPE;
V_CENTREMI			   FA_HISTDOCU.COD_CENTREMI%TYPE;
V_FOLIO				   FA_HISTDOCU.NUM_FOLIO%TYPE;
V_TOT_FACTURA		   FA_HISTDOCU.TOT_FACTURA%TYPE;
V_SUPERTEL			   FA_HISTDOCU.IND_SUPERTEL%TYPE;
V_CLIENTE 	 		   FA_HISTDOCU.COD_CLIENTE%TYPE;
V_PREF				   FA_FACTDOCU_NOCICLO.PREF_PLAZA%TYPE;

V_CODTIPDOCUM		   FA_HISTDOCU.COD_TIPDOCUM%TYPE;
V_NPROCESO	    	   FA_HISTDOCU.NUM_PROCESO%TYPE;
V_NUM_TRANS_NC		   GA_TRANSACABO.NUM_TRANSACCION%TYPE;

V_NUM_TRANS_BILL	   GA_TRANSACABO.NUM_TRANSACCION%TYPE;
V_CAT_CLIENTE		   VARCHAR2(1);

V_SEC_NCPARCIAL		   FA_NCPARCIAL.NUM_SECUENCIA%TYPE;
V_NUM_PROCESO  		   FA_NCPARCIAL.NUM_PROCESO%TYPE;
VP_CADENA  			   GA_TRANSACABO.DES_CADENA%TYPE;

V_COD_CONCEPTO		   FA_FACTCONC_NOCICLO.COD_CONCEPTO%TYPE;
V_IMP_CONCEPTO		   FA_FACTCONC_NOCICLO.IMP_CONCEPTO%TYPE;
V_FCOD_CONCEPTO		   FA_FACTCONC_NOCICLO.COD_CONCEPTO%TYPE;
V_FIMP_CONCEPTO		   FA_FACTCONC_NOCICLO.IMP_CONCEPTO%TYPE;
V_FCOLUMNA			   FA_FACTCONC_NOCICLO.COLUMNA%TYPE;
V_FIMP_FACTURABLE	   FA_FACTCONC_NOCICLO.IMP_FACTURABLE%TYPE;

V_RETORNO_NC		   GA_TRANSACABO.COD_RETORNO%TYPE;

V_TIP_FOLIACION		   GE_TIPDOCUMEN.TIP_FOLIACION%TYPE; -- MAM 13/02/2003
V_DIFERENCIA		   FA_FACTCONC_NOCICLO.IMP_FACTURABLE%TYPE; -- MAM 13/03/2003

CURSOR_NAME			   INTEGER;
V_RESUL				   INTEGER;

SSQL  	   	   		   VARCHAR2(512);
V_VALOR 			   NUMBER(1);
V_TABLA 			   VARCHAR2(1);
VP_ERROR		   	   VARCHAR2(1);
V_SIGUE 			   BOOLEAN;
V_POSEE_NC		   	   BOOLEAN;
V_TABLA_CONCEP 		   VARCHAR2(30);

V_NUMVENTA			   GA_ABOCEL.NUM_VENTA%TYPE;
V_NUMCLIENTE		   GA_ABOCEL.COD_CLIENTE%TYPE;

V_CODOFICINA		   GA_VENTAS.COD_OFICINA%TYPE;
V_CODMODVENTA		   GA_VENTAS.COD_MODVENTA%TYPE;
V_MODGENER			   FA_GENCENTREMI.COD_MODGENER%TYPE;

V_CODDOCGUIA		   VARCHAR2(1);
V_FLAGCENTREMI		   VARCHAR2(1);
V_FECACTUAL			   VARCHAR2(8);

V_NTRANSACCION		   GA_VENTAS.NUM_TRANSACCION%TYPE; -- MAM 26/02

V_TIPDOCUM_FG		   FA_HISTDOCU.COD_TIPDOCUM%TYPE;

V_CODVENDEDOR          GA_VENTAS.COD_VENDEDOR%TYPE;
V_CODCENTREMI		   AL_DOCUM_SUCURSAL.COD_CENTREMI%TYPE;
v_seqmiscelanea        fa_procesos.num_secuag%TYPE;

V_CODOPERADORA		   GA_VENTAS.COD_OPERADORA%TYPE;
V_CODPLAZA			   GA_VENTAS.COD_PLAZA%TYPE;

v_seq_transacabo   	   ga_transacabo.num_transaccion%TYPE;

v_sal_proc             VARCHAR (5);

V_CODCUOTA			   GA_VENTAS.COD_CUOTA%TYPE;
V_NUMCUOTAS            GE_TIPCUOTAS.NUM_CUOTAS%TYPE;

v_cod_catimpos         ge_catimpclientes.cod_catimpos%TYPE;

CURSOR CRS_CARGOS IS
   	SELECT COD_CONCEPTO, IMP_CARGO
	FROM   GE_CARGOS
	WHERE NUM_VENTA =TO_NUMBER(V_CODVENTA); -- MAM 08/01



BEGIN -- 1

-- ERROR:0	VP_CADENA:='OK,SIN ERROR'
-- ERROR:1	VP_CADENA:='ERROR AL OBTENER DATOS GENERALES';
-- ERROR:2	VP_CADENA:='ERROR NO EXISTE FACTURA';
-- ERROR:3	VP_CADENA:='ERROR NO EXISTEN CONCEPTOS POR FACTURAR';
-- ERROR:4	VP_CADENA:='ERROR DE INSERT EN NC PARCIAL';
-- ERROR:5	VP_CADENA:='ERROR PROCESO FA_PRE_NCPARCIAL';
-- ERROR:6	VP_CADENA:='NOTA DE CREDITO TOTAL AFECTUADA ANTERIORMENTE';
-- ERROR:7  VP_CADENA:='ERROR, AL EJECUTAR PROCESO : P_INTERFASES_ABONADOS';
-- ERROR:8	VP_CADENA:='ERROR DE UPDATE EN FA_INTERFACT';
-- ERROR:9  VP_CADENA:='ERROR DE UPDATE EN GA_VENTAS';
-- ERROR:10 VP_CADENA:='ERROR DE INSERT EN GA_MODCLI';
-- ERROR:11 VP_CADENA:='ERROR NO EXISTEN IMPORTES POR CONCEPTO PARA ESTA VENTA';
-- ERROR:12 VP_CADENA:='ERROR DE UPDATE EN GE_CARGOS';
-- ERROR:13 VP_CADENA:='ERROR AL OBTENER SECUENCIA EN GA_TRANSACABO';
-- ERROR:14 VP_CADENA:='ERROR AL EJECUTAR FA_INS_INTERFACT';
-- ERROR:15 VP_CADENA:='ERROR DE INSERT EN FA_PROCESOS';
-- ERROR:16 VP_CADENA:='ERROR DE INSERT EN FA_PREFACTURA';

    v_sal_proc := 0;
	V_VALOR:=2;
	VP_ERROR:=0;
	VP_CADENA:='OK,SIN ERROR';
	V_SIGUE:=TRUE;

	V_NUMVENTA	:= TO_NUMBER(V_CODVENTA);
    V_NUMCLIENTE:= TO_NUMBER(V_CODCLIENTE);

	BEGIN -- OK
		SELECT COD_MISCELA
		INTO   V_CODTIPDOCUM
		FROM   FA_DATOSGENER;

		SELECT NUM_PROCESO,COD_OFICINA,COD_MODVENTA,NUM_TRANSACCION, COD_VENDEDOR,COD_OPERADORA, COD_PLAZA, NVL(COD_CUOTA,' ')  -- MAM 26/02/03
		INTO   V_NPROCESO,V_CODOFICINA,V_CODMODVENTA,V_NTRANSACCION, V_CODVENDEDOR, V_CODOPERADORA, V_CODPLAZA, V_CODCUOTA
		FROM   GA_VENTAS
		WHERE  NUM_VENTA = V_NUMVENTA;

	    SELECT FA_SEQ_NUMPRO.NEXTVAL,GA_SEQ_TRANSACABO.NEXTVAL
		INTO   V_NUM_PROCESO,V_NUM_TRANS_NC
   	   	FROM   DUAL;

	EXCEPTION
	   WHEN NO_DATA_FOUND THEN
	   		VP_ERROR:='1';
			VP_CADENA:='ERROR AL OBTENER DATOS GENERALES';
			V_SIGUE:=FALSE;
	END;-- OK

	IF V_SIGUE THEN
	BEGIN -- 3 OK
	    BEGIN -- OK
			SELECT IND_ORDENTOTAL,COD_CICLFACT,'H',COD_TIPDOCUM,NUM_SECUENCI,
				   COD_VENDEDOR_AGENTE,LETRA,COD_CENTREMI,NUM_FOLIO,TOT_FACTURA,
				   IND_SUPERTEL,COD_CLIENTE,PREF_PLAZA
			INTO   V_IND_ORDENTOTAL,V_CICLFACT,V_TABLA,V_TIPDOCUM,V_SECUENCI,
				   V_VENDEDOR_AGENTE,V_LETRA,V_CENTREMI,V_FOLIO,V_TOT_FACTURA,
				   V_SUPERTEL,V_CLIENTE,V_PREF
			FROM   FA_HISTDOCU
			WHERE  NUM_SECUENCI > 0
			AND    COD_TIPDOCUM = V_CODTIPDOCUM
			AND    NUM_PROCESO = V_NPROCESO;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
			  BEGIN
			   SELECT IND_ORDENTOTAL,COD_CICLFACT,'N',COD_TIPDOCUM,NUM_SECUENCI,
			          COD_VENDEDOR_AGENTE,LETRA,COD_CENTREMI,NUM_FOLIO,TOT_FACTURA,
					  IND_SUPERTEL,COD_CLIENTE,PREF_PLAZA
    		   INTO   V_IND_ORDENTOTAL,V_CICLFACT,V_TABLA,V_TIPDOCUM,V_SECUENCI,
				      V_VENDEDOR_AGENTE,V_LETRA,V_CENTREMI,V_FOLIO,V_TOT_FACTURA,
					  V_SUPERTEL,V_CLIENTE,V_PREF
			   FROM   FA_FACTDOCU_NOCICLO
			   WHERE  NUM_SECUENCI > 0
			   AND    COD_TIPDOCUM = V_CODTIPDOCUM
			   AND    NUM_PROCESO = V_NPROCESO;
			  EXCEPTION
				WHEN NO_DATA_FOUND THEN
					VP_ERROR:='2';
					VP_CADENA:='ERROR NO EXISTE FACTURA';
					V_SIGUE:=FALSE;
				END;

	   END;-- OK

	   IF V_SIGUE THEN
	   BEGIN -- OK

			SELECT FA_SEQ_NCPARCIAL.NEXTVAL
			INTO V_SEC_NCPARCIAL
			FROM DUAL;

			IF V_TABLA ='H' THEN
		   	   BEGIN
		   		   SELECT FA_HISTCONC
		   		   INTO   V_TABLA_CONCEP
		   		   FROM   FA_ENLACEHIST
		   		   WHERE  COD_CICLFACT=V_CICLFACT;
		   	   EXCEPTION
		   		   WHEN NO_DATA_FOUND THEN
				   		VP_ERROR:='3';
						VP_CADENA:='ERROR NO EXISTEN CONCEPTOS POR FACTURAR';
						V_SIGUE:=FALSE;
		   	   END;
			ELSE
		   	   V_TABLA_CONCEP:='FA_FACTCONC_NOCICLO';
			END IF;

			IF V_SIGUE THEN

			   OPEN CRS_CARGOS;
			   LOOP
			   	   FETCH CRS_CARGOS
			   	   		 INTO V_COD_CONCEPTO,V_IMP_CONCEPTO;
			       EXIT WHEN CRS_CARGOS%NOTFOUND;

	   			   V_POSEE_NC:=FALSE;

				   BEGIN
					--SSQL:='SELECT  F.COD_CONCEPTO, F.COLUMNA, F.IMP_FACTURABLE, NVL(A.IMP_CONCEPTO,0) FROM ';
					--SSQL:=SSQL || V_TABLA_CONCEP || ' F, FA_AJUSTECONC A ';
					--SSQL:=SSQL ||' WHERE F.IND_ORDENTOTAL = :V_IND_ORDENTOTAL';
					--SSQL:=SSQL || ' AND F.COD_TIPCONCE > :V_VALOR';
					--SSQL:=SSQL || ' AND A.PREF_PLAZA(+) = :V_PREF';
					--SSQL:=SSQL || ' AND A.NUM_FOLIO(+) = :V_FOLIO';
					--SSQL:=SSQL || ' AND A.COD_CLIENTE(+) = :V_CLIENTE';
					--SSQL:=SSQL || ' AND A.COD_TIPDOCUM(+) = :V_TIPDOCUM';
					--SSQL:=SSQL || ' AND F.COD_CONCEPTO = :V_COD_CONCEPTO';
					--SSQL:=SSQL || ' AND F.COD_CONCEPTO=A.COD_CONCEPTO(+)';
					--SSQL:=SSQL || ' AND F.IMP_FACTURABLE = :V_IMP_CONCEPTO';
					--SSQL:=SSQL || ' AND A.IMP_CONCEPTO(+)=0';
					--SSQL:=SSQL || ' AND F.COLUMNA=A.COLUMNA(+)';
					--SSQL:=SSQL || ' AND ROWNUM<=1';

					SSQL:='SELECT  F.COD_CONCEPTO, F.COLUMNA, F.IMP_FACTURABLE, NVL(A.IMP_CONCEPTO,0) FROM ';
					SSQL:=SSQL || V_TABLA_CONCEP || ' F, FA_AJUSTECONC A ';
					SSQL:=SSQL ||' WHERE F.IND_ORDENTOTAL = :V_IND_ORDENTOTAL';
					SSQL:=SSQL || ' AND F.COD_TIPCONCE > :V_VALOR';
					SSQL:=SSQL || ' AND A.PREF_PLAZA = :V_PREF';
					SSQL:=SSQL || ' AND A.NUM_FOLIO = :V_FOLIO';
					SSQL:=SSQL || ' AND A.COD_CLIENTE = :V_CLIENTE';
					SSQL:=SSQL || ' AND A.COD_TIPDOCUM = :V_TIPDOCUM';
					SSQL:=SSQL || ' AND F.COD_CONCEPTO = :V_COD_CONCEPTO';
					SSQL:=SSQL || ' AND F.COD_CONCEPTO=A.COD_CONCEPTO';
					SSQL:=SSQL || ' AND F.IMP_FACTURABLE = :V_IMP_CONCEPTO';
					SSQL:=SSQL || ' AND A.IMP_CONCEPTO=0';
					SSQL:=SSQL || ' AND F.COLUMNA=A.COLUMNA';
					SSQL:=SSQL || ' AND ROWNUM<=1';

					CURSOR_NAME := DBMS_SQL.OPEN_CURSOR;
					DBMS_SQL.PARSE(CURSOR_NAME,SSQL, DBMS_SQL.NATIVE);

					-- FASE BINDING
					DBMS_SQL.BIND_VARIABLE(CURSOR_NAME, ':V_IND_ORDENTOTAL', TO_CHAR(V_IND_ORDENTOTAL));
					DBMS_SQL.BIND_VARIABLE(CURSOR_NAME, ':V_VALOR', TO_CHAR(V_VALOR));
					DBMS_SQL.BIND_VARIABLE(CURSOR_NAME, ':V_PREF', V_PREF);
					DBMS_SQL.BIND_VARIABLE(CURSOR_NAME, ':V_FOLIO', TO_CHAR(V_FOLIO));
					DBMS_SQL.BIND_VARIABLE(CURSOR_NAME, ':V_CLIENTE', TO_CHAR(V_CLIENTE));
					DBMS_SQL.BIND_VARIABLE(CURSOR_NAME, ':V_TIPDOCUM', TO_CHAR(V_TIPDOCUM));
					DBMS_SQL.BIND_VARIABLE(CURSOR_NAME, ':V_COD_CONCEPTO', TO_CHAR(V_COD_CONCEPTO));
					DBMS_SQL.BIND_VARIABLE(CURSOR_NAME, ':V_IMP_CONCEPTO', TO_CHAR(V_IMP_CONCEPTO));

					DBMS_SQL.DEFINE_COLUMN(CURSOR_NAME, 1,V_FCOD_CONCEPTO);
					DBMS_SQL.DEFINE_COLUMN(CURSOR_NAME, 2,V_FCOLUMNA);
					DBMS_SQL.DEFINE_COLUMN(CURSOR_NAME, 3,V_FIMP_FACTURABLE);
					DBMS_SQL.DEFINE_COLUMN(CURSOR_NAME, 4,V_FIMP_CONCEPTO);

					V_RESUL:=DBMS_SQL.EXECUTE(CURSOR_NAME);

					LOOP
						BEGIN

						IF DBMS_SQL.FETCH_ROWS(CURSOR_NAME) = 0 THEN
						   EXIT;
						END IF;

						DBMS_SQL.COLUMN_VALUE(CURSOR_NAME, 1,V_FCOD_CONCEPTO);
						DBMS_SQL.COLUMN_VALUE(CURSOR_NAME, 2,V_FCOLUMNA);
						DBMS_SQL.COLUMN_VALUE(CURSOR_NAME, 3,V_FIMP_FACTURABLE);
						DBMS_SQL.COLUMN_VALUE(CURSOR_NAME, 4,V_FIMP_CONCEPTO);

						-- INICIO  MAM 13/03/2003
						V_DIFERENCIA:= V_FIMP_FACTURABLE - V_FIMP_CONCEPTO;
						IF V_DIFERENCIA > 0 AND V_FIMP_FACTURABLE = V_IMP_CONCEPTO THEN
							BEGIN
								INSERT INTO FA_NCPARCIAL
								(NUM_SECUENCIA,COD_CLIENTE,IND_ORDENTOTAL,
								COD_TIPDOCUM,COD_CONCEPTO,COLUMNA,IMP_CONCEPTO,
								FLG_EMINC,FEC_SOLICITUD,NOM_USUARIO,NUM_PROCESO)
								VALUES(V_SEC_NCPARCIAL,V_CLIENTE,V_IND_ORDENTOTAL,
								V_TIPDOCUM,V_FCOD_CONCEPTO,V_FCOLUMNA,V_FIMP_FACTURABLE,--V_DIFERENCIA,
								0,SYSDATE,USER,V_NUM_PROCESO);
								VP_ERROR:='0';
								VP_CADENA:=TO_CHAR(V_NUM_PROCESO);
								V_POSEE_NC:=TRUE;
							EXCEPTION
								WHEN OTHERS THEN
									VP_ERROR:='4';
									VP_CADENA:='ERROR DE INSERT EN NC PARCIAL';
									V_SIGUE:=FALSE;
						    END;

						-- FIN  MAM 13/03/2003
						END IF;
						END;
					END LOOP;

					DBMS_SQL.CLOSE_CURSOR(CURSOR_NAME);


				EXCEPTION
				   WHEN OTHERS THEN
					   VP_ERROR:='6';
					   VP_CADENA:='NOTA DE CREDITO TOTAL AFECTUADA ANTERIORMENTE';
					   V_SIGUE:=FALSE;
				END;

			   END LOOP;

			   IF V_POSEE_NC THEN

				      fa_pre_notacredparcial(V_NUM_TRANS_NC,V_SEC_NCPARCIAL);

		 			  SELECT COD_RETORNO, DES_CADENA INTO V_RETORNO_NC,VP_CADENA
					  FROM GA_TRANSACABO
					  WHERE NUM_TRANSACCION=V_NUM_TRANS_NC;

					  IF V_RETORNO_NC = 0 THEN
			   		   	 VP_ERROR:='0';
		 			   	 VP_CADENA:=TO_CHAR(V_NUM_PROCESO);
					  ELSE
			   		   	 VP_ERROR:='5';
						 V_SIGUE:=FALSE;
						 VP_CADENA:='ERROR PROCESO FA_PRE_NCPARCIAL';
					  END IF;
			   ELSE
		   	   	   VP_ERROR:='11';
				   VP_CADENA:='ERROR NO EXISTEN IMPORTES POR CONCEPTO PARA ESTA VENTA';
				   V_SIGUE:=FALSE;
			   END IF;
			END IF;

	   END; -- OK
	   END IF;
  EXCEPTION
	WHEN NO_DATA_FOUND THEN
		 VP_ERROR:='2';
		 VP_CADENA:='ERROR NO EXISTE FACTURA';
		 V_SIGUE:=FALSE;
  END;
  END IF; -- 3 OK

  --************************************
  -- GENERACION DE FACTURA AL CLIENTE
  --************************************
  IF V_SIGUE THEN

  	BEGIN -- OK

		SELECT TO_CHAR(SYSDATE,'DDMMYYYY')
		INTO   V_FECACTUAL
		FROM   DUAL;

		-- NUMERO GENERADO PARA EL BILLING
	    SELECT FA_SEQ_NUMPRO.NEXTVAL,GA_SEQ_TRANSACABO.NEXTVAL
		INTO   V_NUM_PROCESO,V_NUM_TRANS_BILL
   	   	FROM   DUAL;

		SELECT VAL_PARAMETRO
		INTO   V_CAT_CLIENTE
		FROM   GED_PARAMETROS
		WHERE  NOM_PARAMETRO = 'CAT_TRIB_FACT' AND
		       COD_MODULO = 'GA'               AND
			   COD_PRODUCTO = 1;

		SELECT VAL_PARAMETRO
		INTO   V_FLAGCENTREMI
		FROM   GED_PARAMETROS
		WHERE  NOM_PARAMETRO = 'FLAG_CENTREMI_FA' AND
		       COD_MODULO = 'GA'                  AND
			   COD_PRODUCTO = 1;

		SELECT TIP_FOLIACION
        INTO   V_TIP_FOLIACION
       	FROM   GE_TIPDOCUMEN
       	WHERE  COD_TIPDOCUM = V_CODTIPDOCUM;

		SELECT B.COD_CENTREMI
		INTO   V_CODCENTREMI
		FROM   AL_DOCUM_SUCURSAL B
		WHERE  B.COD_OFICINA = V_CODOFICINA
		AND    B.COD_TIPDOCUM = V_CODTIPDOCUM;

        SELECT cod_catimpos
        INTO v_cod_catimpos
        FROM ge_catimpclientes
        WHERE cod_cliente = V_NUMCLIENTE
        AND SYSDATE BETWEEN fec_desde AND fec_hasta;

		SELECT letra
        INTO v_letra
        FROM ge_letras
       	WHERE cod_tipdocum = V_CODTIPDOCUM
        AND cod_catimpos = v_cod_catimpos;

		SELECT fa_seq_miscelanea.NEXTVAL
        INTO v_seqmiscelanea
        FROM DUAL;

		IF V_FLAGCENTREMI= '1' THEN
		   BEGIN
			SELECT A.COD_MODGENER
			INTO   V_MODGENER
			FROM   FA_GENCENTREMI A
			WHERE  A.COD_CENTREMI IN (SELECT B.COD_CENTREMI
				   				      FROM   AL_DOCUM_SUCURSAL B
								      WHERE  B.COD_OFICINA = V_CODOFICINA
								      AND    B.COD_TIPDOCUM = V_CODTIPDOCUM)
			AND    A.COD_TIPMOVIMIEN = 1
			AND    A.COD_CATRIBUT = V_CAT_CLIENTE
			AND    A.COD_MODVENTA = V_CODMODVENTA
			AND    A.TIP_FOLIACION= V_TIP_FOLIACION;-- MAM 13/02/2003
		   END;
		ELSE
		   BEGIN
			SELECT A.COD_MODGENER
			INTO   V_MODGENER
			FROM   FA_GENCENTREMI A
			WHERE  A.COD_CENTREMI IN (SELECT B.COD_CENTREMI
				   				      FROM   AL_DOCUM_SUCURSAL B
								      WHERE  B.COD_OFICINA = V_CODOFICINA
								      AND    B.COD_TIPDOCUM = V_CODTIPDOCUM)
			AND    A.COD_TIPMOVIMIEN = 1
			AND    A.COD_CATRIBUT = V_CAT_CLIENTE
			AND    A.TIP_FOLIACION= V_TIP_FOLIACION;-- MAM 13/02/2003
		   END;
		END IF;
	EXCEPTION
	   WHEN NO_DATA_FOUND THEN
	   		VP_ERROR:='1';
			VP_CADENA:='ERROR AL OBTENER DATOS GENERALES';
			V_SIGUE:=FALSE;
	END;

	IF V_SIGUE THEN
	   BEGIN

		INSERT INTO fa_procesos
                  (num_proceso, cod_tipdocum, cod_vendedor_agente,
                   cod_centremi, fec_efectividad, nom_usuarora, letraag,
                   num_secuag, cod_tipdocnot, cod_vendedor_agentenot,
                   letranot, cod_centrnot, num_secunot, ind_estado,
                   cod_ciclfact)
        VALUES (v_num_proceso, V_CODTIPDOCUM, V_CODVENDEDOR,
                V_CODCENTREMI, SYSDATE, USER, v_letra,
                v_seqmiscelanea, NULL, NULL,
                NULL, NULL, NULL, 0,
                NULL);

	   EXCEPTION
	   	  WHEN OTHERS THEN
		  	  VP_ERROR:='15';
	    	  VP_CADENA:='ERROR DE INSERT EN FA_PROCESOS';
			  V_SIGUE:=FALSE;
	   END;
	END IF;

	IF V_SIGUE THEN
	   BEGIN
        INSERT INTO fa_prefactura
                     (num_proceso, cod_cliente, cod_concepto, columna,
                      cod_producto, cod_moneda, fec_valor, fec_efectividad,
                      imp_concepto, imp_facturable, imp_montobase, cod_region,
                      cod_provincia, cod_ciudad, cod_modulo, cod_plancom,
                      ind_factur, cod_catimpos, cod_portador, ind_estado,
                      cod_tipconce, num_unidades, num_seriele, flag_impues,
                      flag_dto, ind_modventa)
        SELECT v_num_proceso, V_NUMCLIENTE, ccg.cod_concepto,
                   ROWNUM AS columna, ccg.cod_producto, ccg.cod_moneda,
                   SYSDATE, SYSDATE, ccg.imp_cargo, ccg.imp_cargo, 0, a.cod_region,
                   a.cod_provincia, b.cod_ciudad, 'AL', c.cod_plancom,
                   ccg.ind_factur, v_cod_catimpos, 0, 0, 3, ccg.num_unidades,
                   '0', 0, 0, 1
        FROM ge_cargos ccg,
             ge_oficinas a,
             ge_direcciones b,
             ga_cliente_pcom c
        WHERE ccg.num_venta = V_NUMVENTA
        AND c.cod_cliente = V_NUMCLIENTE
        AND SYSDATE BETWEEN c.fec_desde
        AND NVL (c.fec_hasta,   SYSDATE + 1)
        AND a.cod_oficina = V_CODOFICINA
        AND a.cod_direccion = b.cod_direccion;

	   EXCEPTION
	   	  WHEN OTHERS THEN
		  	  VP_ERROR:='16';
	    	  VP_CADENA:='ERROR DE INSERT EN FA_PREFACTURA';
			  V_SIGUE:=FALSE;
	   END;
	END IF;

	IF V_SIGUE THEN
	   BEGIN

	   		SELECT ga_seq_transacabo.NEXTVAL
        	INTO v_seq_transacabo
        	FROM DUAL;

	   EXCEPTION
	   	  WHEN OTHERS THEN
		  	  VP_ERROR:='13';
	    	  VP_CADENA:='ERROR AL OBTENER SECUENCIA EN GA_TRANSACABO';
			  V_SIGUE:=FALSE;
	   END;
	END IF;

	BEGIN
		SELECT NUM_CUOTAS
		INTO   V_NUMCUOTAS
		FROM   GE_TIPCUOTAS
		WHERE  COD_CUOTA = V_CODCUOTA;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 V_NUMCUOTAS := 0;
	END;


    BEGIN
         Fa_Ins_Interfact (
            v_seq_transacabo,
            v_num_proceso,
            0,
            V_MODGENER,
            V_CODTIPDOCUM,
            V_CAT_CLIENTE,
            '',
            '100',
            '3',
            SYSDATE,
            v_sal_proc,
            V_CODMODVENTA, -- contado, regalo, consignacion
            V_NUMCUOTAS,  -- num cuotas
            '',
            V_TIP_FOLIACION,
            V_CODTIPDOCUM
         );
   END;

   SELECT cod_retorno
   INTO   V_RETORNO_NC
   FROM   ga_transacabo
   WHERE  num_transaccion = v_seq_transacabo;

   IF V_RETORNO_NC != 0 THEN
		VP_ERROR:='14';
		V_SIGUE:=FALSE;
		VP_CADENA:='ERROR AL EJECUTAR FA_INS_INTERFACT';
   END IF;

   IF V_SIGUE THEN
	   BEGIN

		  UPDATE FA_INTERFACT
		  SET    COD_ESTADOC = 100,
		  		 COD_ESTPROC = 3
		  WHERE	 NUM_PROCESO = V_NUM_PROCESO;--V_NUM_TRANS_BILL;

	   EXCEPTION
	   	  WHEN OTHERS THEN
		  	  VP_ERROR:='8';
	    	  VP_CADENA:='ERROR DE UPDATE EN FA_INTERFACT';
			  V_SIGUE:=FALSE;
	   END;
	END IF;


	IF V_SIGUE THEN
	   BEGIN

		  UPDATE GA_VENTAS
		  SET    NUM_PROCESO = NULL
		  WHERE	 NUM_VENTA = V_NUMVENTA;

	   EXCEPTION
	   	  WHEN OTHERS THEN
		  	  VP_ERROR:='9';
	    	  VP_CADENA:='ERROR DE UPDATE EN GA_VENTAS';
			  V_SIGUE:=FALSE;
	   END;
	END IF;

	IF V_SIGUE THEN
	   BEGIN

		  INSERT INTO GA_MODCLI(COD_CLIENTE,COD_TIPMODI,FEC_MODIFICA,NOM_USUARORA)
		  VALUES (V_NUMCLIENTE,V_CODTIPMODI,SYSDATE,USER);

	   EXCEPTION
	   	  WHEN OTHERS THEN
		  	  VP_ERROR:='10';
	    	  VP_CADENA:='ERROR DE INSERT EN GA_MODCLI';
			  V_SIGUE:=FALSE;
	   END;
	ELSE
	  ROLLBACK;
	END IF;

  ELSE
  	  ROLLBACK;
  END IF;

  INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)
  VALUES(TO_NUMBER(V_SECUENCIA),VP_ERROR,VP_CADENA);

END; --1
/
SHOW ERRORS
