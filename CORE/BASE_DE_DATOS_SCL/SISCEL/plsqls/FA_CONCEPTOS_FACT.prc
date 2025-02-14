CREATE OR REPLACE PROCEDURE        FA_CONCEPTOS_FACT(
 vp_num_transaccion IN VARCHAR2,
 vp_cod_concepto IN VARCHAR2,
 vp_tipo_AL IN VARCHAR2
 ) IS
cantidad        NUMBER;
producto        NUMBER;
tipconce        NUMBER;
modulo	        VARCHAR2(2);
vp_salida       NUMBER;
vp_des_cadena   VARCHAR2(255);
vp_cod_grpservi NUMBER;
vp_cod_conccobr NUMBER;
vp_cod_grupo    VARCHAR2(2);
vp_error        NUMBER;
usuario	        VARCHAR2(30);
gls_error       VARCHAR2(50);
orden	        NUMBER;
fecha           VARCHAR(19);
VP_SQLCODE      VARCHAR2(5);
VP_SQLERRM      VARCHAR2(50);
cod_concepto    FA_CONCEPTOS.COD_CONCEPTO%TYPE;
Cursor C IS
        SELECT DISTINCT a.COD_CICLO
        FROM FA_CICLFACT a, FA_CICLOS b
        WHERE a.COD_CICLO = b.COD_CICLO;
ERROR_PROCESO EXCEPTION;
BEGIN
  	vp_cod_grpservi := 1;
  	vp_cod_conccobr := 3;
  	vp_error := '0';
  	tipconce := 0;
  	modulo := '';
  	producto := 0;
  	usuario := '';
  	vp_error := 0;
  	gls_error := '';
        SELECT user, RTRIM(to_char(SYSDATE, 'dd-mm-yyyy hh24:mi:ss')) INTO usuario, fecha
        FROM DUAL;
        SELECT cod_producto, cod_tipconce, cod_modulo
        INTO   producto, tipconce, modulo
        FROM   FA_CONCEPTOS
        WHERE  cod_concepto=to_number(vp_cod_concepto);
        IF (tipconce = 2 OR tipconce = 3)                    AND
           (modulo = 'GA' or modulo = 'AL' or modulo = 'ST') AND
           (producto = 1 or producto = 2)                    THEN
           IF producto = 1 THEN
           	vp_cod_grupo := '01';
           ELSE
              IF producto = 2 THEN
           	 vp_cod_grupo := '02';
              END IF;
           END IF;
           INSERT INTO FA_GRPSERCONC
           (COD_CONCEPTO,FEC_DESDE,COD_GRPSERVI,FEC_HASTA,NOM_USUARIO,FEC_ULTMOD)
           VALUES
           (TO_NUMBER(vp_cod_concepto),TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'),vp_cod_grpservi,to_date('01-01-3000', 'dd-mm-yyyy'), RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
	   INSERT INTO FA_FACTCOBR
           (COD_CONCFACT, COD_CONCCOBR,NOM_USUARIO,FEC_ULTMOD)
           VALUES
           (TO_NUMBER(vp_cod_concepto), vp_cod_conccobr, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss') );
           FOR i IN C LOOP
               INSERT INTO FA_GRUPOCOB
               (COD_GRUPO,COD_PRODUCTO,COD_CICLO,COD_CONCEPTO,TIP_COBRO,FEC_DESDE,FEC_HASTA,TIP_COBROANT,NOM_USUARIO,FEC_ULTMOD)
               VALUES
               (RTRIM(vp_cod_grupo), producto, i.cod_ciclo, TO_NUMBER(vp_cod_concepto), 0, TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'), TO_DATE('01-01-3000', 'dd-mm-yyyy'), 0, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
           END LOOP;
           UPDATE FA_CONCEPTOS
           SET    IND_ACTIVO = 1, nom_usuario = RTRIM(usuario), fec_ultmod = TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss')
           WHERE  COD_CONCEPTO = TO_NUMBER(vp_cod_concepto);
	   IF tipconce = 3 THEN
	      IF producto = 1 THEN
	         IF modulo = 'GA' or modulo = 'ST' THEN
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 15;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 15, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 6;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 6, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 30;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 30,orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
	         ELSE
	            IF vp_tipo_AL = 'V' THEN
		       SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		       FROM   FA_IMPCONCEPTOS
		       WHERE  COD_SUBGRUPO = 19;
	   	       INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	       VALUES (TO_NUMBER(vp_cod_concepto), 19, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
	            ELSE
		       SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		       FROM   FA_IMPCONCEPTOS
		       WHERE  COD_SUBGRUPO = 20;
	   	       INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	       VALUES (TO_NUMBER(vp_cod_concepto), 20, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
	            END IF;
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 6;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 6, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 30;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 30, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
	         END IF;
	      ELSE
	         IF modulo = 'GA' or modulo = 'ST' THEN
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 18;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 18, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 13;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 13, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 32;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 32, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
	         ELSE
	            IF vp_tipo_AL = 'V' THEN
		       SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		       FROM   FA_IMPCONCEPTOS
		       WHERE  COD_SUBGRUPO = 22;
	   	       INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	       VALUES (TO_NUMBER(vp_cod_concepto), 22, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
	            ELSE
		       SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		       FROM   FA_IMPCONCEPTOS
		       WHERE  COD_SUBGRUPO = 23;
	   	       INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	       VALUES (TO_NUMBER(vp_cod_concepto), 23, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
	            END IF;
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 13;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 13, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 32;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 32, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
	         END IF;
	      END IF;
	   ELSE
	      IF producto = 1 THEN
	         IF modulo = 'GA' or modulo = 'ST' THEN
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 15;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 15, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 7;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 7, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 31;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 31, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
	         ELSE
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 21;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 21, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 7;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 7, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 31;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 31, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
	         END IF;
	      ELSE
	         IF modulo = 'GA' or modulo = 'ST' THEN
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 18;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 18, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 14;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 14, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 33;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 33, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
	         ELSE
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 24;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 24, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 14;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 14, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
		    SELECT nvl(MAX(num_orden),0) + 1 INTO orden
		    FROM   FA_IMPCONCEPTOS
		    WHERE  COD_SUBGRUPO = 33;
	   	    INSERT INTO FA_IMPCONCEPTOS (COD_CONCEPTO, COD_SUBGRUPO, NUM_ORDEN, NOM_USUARIO, FEC_ULTMOD)
	   	    VALUES (TO_NUMBER(vp_cod_concepto), 33, orden, RTRIM(usuario), TO_DATE(fecha, 'dd-mm-yyyy hh24:mi:ss'));
	         END IF;
	      END IF;
	   END IF;
        ELSE
           IF (tipconce != 2 AND tipconce != 3) THEN
 	      	vp_error := 1;
 	      	gls_error := 'Concepto no corresponde a Cargo o Descuento.';
 	        RAISE ERROR_PROCESO;
           END IF;
           IF (modulo != 'GA' AND modulo != 'AL' AND modulo != 'ST') THEN
           	vp_error := 2;
           	gls_error := 'Modulo no corresponde a Abonados o Almacen.';
                RAISE ERROR_PROCESO;
           END IF;
           IF (producto != 1 AND producto != 2) THEN
                vp_error := 3;
                gls_error := 'Producto es distinto a Celular y Beeper.';
                RAISE ERROR_PROCESO;
           END IF;
        END IF;
        RAISE ERROR_PROCESO;
   EXCEPTION
      WHEN ERROR_PROCESO THEN
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_num_transaccion), vp_error, gls_error);
      WHEN DUP_VAL_ON_INDEX THEN
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_num_transaccion), 4, 'Duplicado');
      WHEN NO_DATA_FOUND THEN
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_num_transaccion), 5, 'Datos No Fueron Encontrados');
      WHEN OTHERS THEN
      	   INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_num_transaccion), 6, 'Otros Errores No Esperados');
END FA_CONCEPTOS_FACT;
/
SHOW ERRORS
