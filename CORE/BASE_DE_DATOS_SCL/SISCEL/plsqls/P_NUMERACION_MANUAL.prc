CREATE OR REPLACE PROCEDURE        P_NUMERACION_MANUAL(
  VP_TRANSAC IN VARCHAR2 ,
  VP_TABLA IN VARCHAR2 ,
  VP_SUBALM IN VARCHAR2 ,
  VP_CENTRAL IN VARCHAR2 ,
  VP_CAT IN VARCHAR2 ,
  VP_USO IN VARCHAR2 ,
  VP_CELULAR IN VARCHAR2 )
IS
   V_ERROR CHAR(1) := '0';
   V_NUM_DES GA_CELNUM_USO.NUM_DESDE%TYPE;
   V_NUM_HAS GA_CELNUM_USO.NUM_HASTA%TYPE;
   V_NUM_SIG GA_CELNUM_USO.NUM_SIGUIENTE%TYPE;
   V_ROWID ROWID;
   V_FECBAJA GA_CELNUM_REUTIL.FEC_BAJA%TYPE;
   V_CADENA GA_TRANSACABO.DES_CADENA%TYPE;
   V_FORMAT_FECHA  GA_TRANSACABO.DES_CADENA%TYPE;
   ERROR_PROCESO EXCEPTION;
BEGIN
--
-- Procedimiento de validacion de numeracion seleccionada manualmente
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Numero Localizado y Reservado
--         - "1" ; Numero Bloqueado Temporalmente
--         - "2" ; Numero Asignado por Otro Usuario
--         - "4" ; Error en el proceso
--
     IF VP_TABLA = 'R' THEN
      BEGIN
            SELECT A.ROWID ,FEC_BAJA
            INTO V_ROWID,V_FECBAJA
            FROM GA_CELNUM_REUTIL A, AL_USOS B
            WHERE NUM_CELULAR   = VP_CELULAR
               AND COD_SUBALM   = VP_SUBALM
               AND COD_CENTRAL  = VP_CENTRAL
               AND COD_CAT      = VP_CAT
               AND USO_ANTERIOR = VP_USO
	       AND A.COD_USO    = B.COD_USO
               AND IND_EQUIPADO = 1
               AND FEC_BAJA + B.NUM_DIAS_HIBERNACION <= SYSDATE
               FOR UPDATE OF NUM_CELULAR NOWAIT;
           DELETE GA_CELNUM_REUTIL WHERE ROWID = V_ROWID;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
              V_ERROR := 2;
              RAISE ERROR_PROCESO;
         WHEN OTHERS THEN
              IF SQLCODE = -54 THEN
                 V_ERROR := 1;
              ELSE
                 V_ERROR := 4;
                 ROLLBACK;
              END IF;
              RAISE ERROR_PROCESO;
      END;
   ELSIF VP_TABLA = 'S' THEN
   	  BEGIN
            SELECT ROWID,FEC_BAJA
              INTO V_ROWID,V_FECBAJA
              FROM GA_RESERVA
             WHERE NUM_CELULAR  = VP_CELULAR
               AND COD_USO      = VP_USO
               FOR UPDATE OF NUM_CELULAR NOWAIT;

			   INSERT INTO GA_HRESERVA (COD_CLIENTE, COD_VENDEDOR, ORIGEN, FEC_RESERVA, NUM_CELULAR,
			   COD_SUBALM, COD_PRODUCTO, COD_CENTRAL, COD_CAT, COD_USO, FEC_BAJA,IND_EQUIPADO, USO_ANTERIOR,
			   FECHA_DESRESERVA, CAUSAL_DESRESERVA, NOM_USUARORA)
			   SELECT COD_CLIENTE, COD_VENDEDOR, ORIGEN, FEC_RESERVA, NUM_CELULAR, COD_SUBALM, COD_PRODUCTO,
			   COD_CENTRAL, COD_CAT, COD_USO, FEC_BAJA,IND_EQUIPADO, USO_ANTERIOR, SYSDATE, 1,USER
			   FROM GA_RESERVA
			   WHERE ROWID = V_ROWID;

               DELETE GA_RESERVA WHERE ROWID = V_ROWID;
      EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 V_ERROR := 2;
                 RAISE ERROR_PROCESO;
            WHEN OTHERS THEN
                 IF SQLCODE = -54 THEN
                    V_ERROR := 1;
                 ELSE
                    V_ERROR := 4;
                    ROLLBACK;
                 END IF;
                 RAISE ERROR_PROCESO;
     END;
   ELSE
      BEGIN
         SELECT NUM_DESDE,NUM_HASTA,NUM_SIGUIENTE,ROWID
           INTO V_NUM_DES,V_NUM_HAS,V_NUM_SIG,V_ROWID
           FROM GA_CELNUM_USO
          WHERE COD_SUBALM  = VP_SUBALM
            AND COD_CENTRAL = VP_CENTRAL
            AND COD_CAT     = VP_CAT
            AND COD_USO     = VP_USO
            AND NUM_LIBRES  > 0
            AND VP_CELULAR BETWEEN NUM_SIGUIENTE AND NUM_HASTA
            FOR UPDATE OF NUM_SIGUIENTE NOWAIT;
      EXCEPTION
          WHEN NO_DATA_FOUND THEN
               V_ERROR := 2;
               RAISE ERROR_PROCESO;
          WHEN OTHERS THEN
               IF SQLCODE = -54 THEN
                  V_ERROR := 1;
               ELSE
                  V_ERROR := 4;
               END IF;
               RAISE ERROR_PROCESO;
      END;
      BEGIN
         IF VP_CELULAR = V_NUM_SIG THEN
            IF VP_CELULAR = V_NUM_HAS THEN
               UPDATE GA_CELNUM_USO
                  SET NUM_LIBRES    = NUM_LIBRES - 1
                WHERE ROWID = V_ROWID;
            ELSE
               UPDATE GA_CELNUM_USO
                  SET NUM_SIGUIENTE = NUM_SIGUIENTE + 1,
                      NUM_LIBRES    = NUM_LIBRES - 1
                WHERE ROWID = V_ROWID;
            END IF;
         ELSIF VP_CELULAR = V_NUM_HAS THEN
            UPDATE GA_CELNUM_USO
               SET NUM_HASTA  = NUM_HASTA - 1,
                   NUM_LIBRES = NUM_LIBRES - 1
             WHERE ROWID = V_ROWID;
            INSERT INTO GA_CELNUM_USO
                   (NUM_DESDE,NUM_HASTA,
                    COD_SUBALM,COD_PRODUCTO,
                    COD_CENTRAL,COD_CAT,
                    COD_USO,NUM_LIBRES,
                    NUM_SIGUIENTE)
            VALUES (VP_CELULAR,VP_CELULAR,
                    VP_SUBALM,1,
                    VP_CENTRAL,VP_CAT,
                    VP_USO,0,VP_CELULAR);
         ELSE
            UPDATE GA_CELNUM_USO
               SET NUM_HASTA = VP_CELULAR - 1,
                   NUM_LIBRES = ((VP_CELULAR - 1) - NUM_SIGUIENTE) + 1
             WHERE ROWID = V_ROWID;
            INSERT INTO GA_CELNUM_USO
                   (NUM_DESDE,NUM_HASTA,
                    COD_SUBALM,COD_PRODUCTO,
                    COD_CENTRAL,COD_CAT,
                    COD_USO,NUM_LIBRES,
                    NUM_SIGUIENTE)
            VALUES (VP_CELULAR,VP_CELULAR,
                    VP_SUBALM,1,
                    VP_CENTRAL,VP_CAT,
                    VP_USO,0,VP_CELULAR);
            INSERT INTO GA_CELNUM_USO
                   (NUM_DESDE,NUM_HASTA,
                    COD_SUBALM,COD_PRODUCTO,
                    COD_CENTRAL,COD_CAT,
                    COD_USO,NUM_LIBRES,
                    NUM_SIGUIENTE)
            VALUES (VP_CELULAR + 1,V_NUM_HAS,
                    VP_SUBALM,1,
                    VP_CENTRAL,VP_CAT,
                    VP_USO,(V_NUM_HAS - (VP_CELULAR + 1)) + 1,
                    VP_CELULAR + 1);
         END IF;
      EXCEPTION
          WHEN OTHERS THEN
               V_ERROR := 4;
               RAISE ERROR_PROCESO;
      END;
   END IF;

   SELECT VAL_PARAMETRO INTO V_FORMAT_FECHA FROM GED_PARAMETROS
   WHERE COD_PRODUCTO = 1  AND COD_MODULO = 'GE' AND NOM_PARAMETRO = 'FORMATO_SEL2';

   V_CADENA := '/'||TO_CHAR(V_FECBAJA,V_FORMAT_FECHA);

   INSERT INTO GA_TRANSACABO
              (NUM_TRANSACCION,
               COD_RETORNO,
               DES_CADENA)
       VALUES (VP_TRANSAC,
               V_ERROR,V_CADENA);
   COMMIT;
EXCEPTION
   WHEN ERROR_PROCESO THEN
        ROLLBACK;
        INSERT INTO GA_TRANSACABO
                   (NUM_TRANSACCION,
                    COD_RETORNO,
                    DES_CADENA)
            VALUES (VP_TRANSAC,
                    V_ERROR,NULL);
        COMMIT;
   WHEN OTHERS THEN
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
--
--
END;
/
SHOW ERRORS
