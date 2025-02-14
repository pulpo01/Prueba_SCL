CREATE OR REPLACE PROCEDURE        P_NUMERACION_MANUALBEEP(
  VP_TRANSAC IN VARCHAR2 ,
  VP_TABLA IN VARCHAR2 ,
  VP_CENTRAL IN VARCHAR2 ,
  VP_USO IN VARCHAR2 ,
  VP_BEEPER IN VARCHAR2 )
IS
   V_ERROR CHAR(1) := '0';
   V_NUM_DES GA_BEEPNUM_USO.NUM_DESDE%TYPE;
   V_NUM_HAS GA_BEEPNUM_USO.NUM_HASTA%TYPE;
   V_NUM_SIG GA_BEEPNUM_USO.NUM_SIGUIENTE%TYPE;
   V_ROWID ROWID;
   V_CADENA GA_TRANSACABO.DES_CADENA%TYPE;
   V_FECBAJA GA_BEEPNUM_REUTIL.FEC_BAJA%TYPE;
   V_DIAS GA_DATOSGENER.NUM_RESNUM%TYPE;
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
         SELECT NUM_RESNUM
           INTO V_DIAS
           FROM GA_DATOSGENER;
         BEGIN
            SELECT ROWID,FEC_BAJA
              INTO V_ROWID,V_FECBAJA
              FROM GA_BEEPNUM_REUTIL
             WHERE NUM_BEEPER  = VP_BEEPER
               AND COD_CENTRAL = VP_CENTRAL
               AND COD_USO     = VP_USO
               AND FEC_BAJA + V_DIAS <= SYSDATE
               FOR UPDATE OF NUM_BEEPER NOWAIT;
            DELETE GA_BEEPNUM_REUTIL WHERE ROWID = V_ROWID;
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
           FROM GA_BEEPNUM_USO
          WHERE COD_CENTRAL = VP_CENTRAL
            AND COD_USO     = VP_USO
            AND NUM_LIBRES  > 0
            AND VP_BEEPER BETWEEN NUM_SIGUIENTE AND NUM_HASTA
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
         IF VP_BEEPER = V_NUM_SIG THEN
            IF VP_BEEPER = V_NUM_HAS THEN
               UPDATE GA_BEEPNUM_USO
                  SET NUM_LIBRES    = NUM_LIBRES - 1
                WHERE ROWID = V_ROWID;
            ELSE
               UPDATE GA_BEEPNUM_USO
                  SET NUM_SIGUIENTE = NUM_SIGUIENTE + 1,
                      NUM_LIBRES    = NUM_LIBRES - 1
                WHERE ROWID = V_ROWID;
            END IF;
         ELSIF VP_BEEPER = V_NUM_HAS THEN
            UPDATE GA_BEEPNUM_USO
               SET NUM_HASTA  = NUM_HASTA - 1,
                   NUM_LIBRES = NUM_LIBRES - 1
             WHERE ROWID = V_ROWID;
            INSERT INTO GA_BEEPNUM_USO
                   (NUM_DESDE,NUM_HASTA,
                    COD_PRODUCTO,COD_CENTRAL,
                    COD_USO,NUM_LIBRES,
                    NUM_SIGUIENTE)
            VALUES (VP_BEEPER,VP_BEEPER,
                    2,VP_CENTRAL,
                    VP_USO,0,
      VP_BEEPER);
         ELSE
            UPDATE GA_BEEPNUM_USO
               SET NUM_HASTA = VP_BEEPER - 1,
                   NUM_LIBRES = ((VP_BEEPER - 1) - NUM_SIGUIENTE) + 1
             WHERE ROWID = V_ROWID;
            INSERT INTO GA_BEEPNUM_USO
                   (NUM_DESDE,NUM_HASTA,
                    COD_PRODUCTO,COD_CENTRAL,
                    COD_USO,NUM_LIBRES,
                    NUM_SIGUIENTE)
            VALUES (VP_BEEPER,VP_BEEPER,
                    2,VP_CENTRAL,
                    VP_USO,0,
      VP_BEEPER);
            INSERT INTO GA_BEEPNUM_USO
                   (NUM_DESDE,NUM_HASTA,
                    COD_PRODUCTO,COD_CENTRAL,
                    COD_USO,NUM_LIBRES,
                    NUM_SIGUIENTE)
            VALUES (VP_BEEPER + 1,V_NUM_HAS,
                    2,VP_CENTRAL,
                    VP_USO,(V_NUM_HAS - (VP_BEEPER + 1)) + 1,
                    VP_BEEPER + 1);
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
