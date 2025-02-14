CREATE OR REPLACE PROCEDURE        P_NUMERACION_MANUALROA
(
  VP_TRANSAC IN VARCHAR2 ,
  VP_TABLA IN VARCHAR2 ,
  VP_OPERADOR IN VARCHAR2 ,
  VP_PAIS IN VARCHAR2 ,
  VP_ZONA IN VARCHAR2 ,
  VP_CELULAR IN VARCHAR2 )
IS
   V_ERROR CHAR(1) := '0';
   V_NUM_DES GA_NUMROAOPER.NUM_DESDE%TYPE;
   V_NUM_HAS GA_NUMROAOPER.NUM_HASTA%TYPE;
   V_NUM_SIG GA_NUMROAOPER.NUM_SIGUIENTE%TYPE;
   V_ROWID ROWID;
   V_FECBAJA GA_REUTNUMROA.FEC_BAJA%TYPE;
   V_CADENA GA_TRANSACABO.DES_CADENA%TYPE;
   V_DIAS GA_DATOSGENER.NUM_DIASREUTIL%TYPE;
   V_CELULAR GA_REUTNUMROA.NUM_CELULAR%TYPE;
   V_OPERADOR GA_NUMROAOPER.COD_OPERADOR%TYPE;
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
   V_CELULAR := TO_NUMBER(VP_CELULAR);
   V_OPERADOR := TO_NUMBER(VP_OPERADOR);
   IF VP_TABLA = 'R' THEN
      BEGIN
         SELECT NUM_DIASREUTIL
           INTO V_DIAS
           FROM GA_DATOSGENER;
         BEGIN
            SELECT ROWID,FEC_BAJA
              INTO V_ROWID,V_FECBAJA
              FROM GA_REUTNUMROA
             WHERE NUM_CELULAR  = V_CELULAR
               AND COD_OPERADOR = V_OPERADOR
               AND COD_PAIS     = VP_PAIS
               AND COD_ZONA     = VP_ZONA
               AND FEC_BAJA + V_DIAS <= SYSDATE
               FOR UPDATE NOWAIT;
            DELETE GA_REUTNUMROA WHERE ROWID = V_ROWID;
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
      EXCEPTION
         WHEN OTHERS THEN
              V_ERROR := 4;
              RAISE ERROR_PROCESO;
      END;
   ELSE
      BEGIN
         SELECT NUM_DESDE,NUM_HASTA,NUM_SIGUIENTE,ROWID
           INTO V_NUM_DES,V_NUM_HAS,V_NUM_SIG,V_ROWID
           FROM GA_NUMROAOPER
          WHERE COD_OPERADOR = V_OPERADOR
            AND COD_PAIS     = VP_PAIS
            AND COD_ZONA     = VP_ZONA
            AND NUM_LIBRES  > 0
            AND V_CELULAR BETWEEN NUM_SIGUIENTE AND NUM_HASTA
            FOR UPDATE NOWAIT;
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
         IF V_CELULAR = V_NUM_SIG THEN
            IF V_CELULAR = V_NUM_HAS THEN
               UPDATE GA_NUMROAOPER
                  SET NUM_LIBRES    = NUM_LIBRES - 1
                WHERE ROWID = V_ROWID;
            ELSE
               UPDATE GA_NUMROAOPER
                  SET NUM_SIGUIENTE = NUM_SIGUIENTE + 1,
                      NUM_LIBRES    = NUM_LIBRES - 1
                WHERE ROWID = V_ROWID;
            END IF;
         ELSIF V_CELULAR = V_NUM_HAS THEN
            UPDATE GA_NUMROAOPER
               SET NUM_HASTA  = NUM_HASTA - 1,
                   NUM_LIBRES = NUM_LIBRES - 1
             WHERE ROWID = V_ROWID;
            INSERT INTO GA_NUMROAOPER
                   (NUM_DESDE,NUM_HASTA,
                    COD_OPERADOR,COD_PAIS,
                    COD_ZONA,NUM_LIBRES,
                    NUM_SIGUIENTE)
            VALUES (V_CELULAR,V_CELULAR,
                    V_OPERADOR,VP_PAIS,
                    VP_ZONA,0,
      V_CELULAR);
         ELSE
            UPDATE GA_NUMROAOPER
               SET NUM_HASTA = V_CELULAR - 1,
                   NUM_LIBRES = ((V_CELULAR - 1) - NUM_SIGUIENTE) + 1
             WHERE ROWID = V_ROWID;
            INSERT INTO GA_NUMROAOPER
                   (NUM_DESDE,NUM_HASTA,
                    COD_OPERADOR,COD_PAIS,
                    COD_ZONA,NUM_LIBRES,
                    NUM_SIGUIENTE)
            VALUES (V_CELULAR,V_CELULAR,
                    V_OPERADOR,VP_PAIS,
                    VP_ZONA,0,
      V_CELULAR);
            INSERT INTO GA_NUMROAOPER
                   (NUM_DESDE,NUM_HASTA,
                    COD_OPERADOR,COD_PAIS,
                    COD_ZONA,NUM_LIBRES,
                    NUM_SIGUIENTE)
            VALUES (V_CELULAR + 1,V_NUM_HAS,
                    V_OPERADOR,VP_PAIS,
                    VP_ZONA,(V_NUM_HAS - (V_CELULAR + 1)) + 1,
                    V_CELULAR + 1);
         END IF;
      EXCEPTION
          WHEN OTHERS THEN
               V_ERROR := 4;
               RAISE ERROR_PROCESO;
      END;
   END IF;
   V_CADENA := '/'||TO_CHAR(V_FECBAJA,'DD-MM-YYYY');
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
