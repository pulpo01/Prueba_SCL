CREATE OR REPLACE PROCEDURE        GA_P_NUMMANUAL_TREK (VP_TRANSAC IN VARCHAR2,
                                                 VP_TABLA IN VARCHAR2,
                                                 VP_CENTRAL IN VARCHAR2,
                                                 VP_CLIENTE IN VARCHAR2,
                                                 VP_MAN IN VARCHAR2) is
   V_ERROR CHAR(1) := '0';
   V_NUM_DES GA_TREKNUM_CLTE.NUM_DESDE%TYPE;
   V_NUM_HAS GA_TREKNUM_CLTE.NUM_HASTA%TYPE;
   V_NUM_SIG GA_TREKNUM_CLTE.NUM_SIGUIENTE%TYPE;
   V_MAN GA_TREKNUM_CLTE.NUM_SIGUIENTE%TYPE;
   V_CENTRAL GA_TREKNUM_CLTE.COD_CENTRAL%TYPE;
   V_CLIENTE GA_TREKNUM_CLTE.COD_CLIENTE%TYPE;
   V_ROWID ROWID;
   V_FECBAJA GA_TREKNUM_REUTIL.FEC_BAJA%TYPE;
   V_CADENA GA_TRANSACABO.DES_CADENA%TYPE;
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
   V_MAN := TO_NUMBER(VP_MAN);
   V_CENTRAL := TO_NUMBER(VP_CENTRAL);
   V_CLIENTE := TO_NUMBER(VP_CLIENTE);
   IF VP_TABLA = 'R' THEN
      BEGIN
         dbms_output.put_line ('select de datosgener');
         SELECT NUM_RESNUM
           INTO V_DIAS
           FROM GA_DATOSGENER;
         dbms_output.put_line ('sale select de datosgener');
         BEGIN
         dbms_output.put_line ('select de reutil');
            SELECT ROWID,FEC_BAJA
              INTO V_ROWID,V_FECBAJA
              FROM GA_TREKNUM_REUTIL
             WHERE NUM_MAN  = V_MAN
               AND COD_CENTRAL  = V_CENTRAL
               AND IND_TIPSUSC  = 'M'
               AND FEC_BAJA + V_DIAS <= SYSDATE
               FOR UPDATE OF NUM_MAN NOWAIT;
         dbms_output.put_line ('sale de select reutil');
         dbms_output.put_line ('delete de reutil');
            DELETE GA_TREKNUM_REUTIL WHERE ROWID = V_ROWID;
         dbms_output.put_line ('select de delete de reutil');
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
         dbms_output.put_line ('se pira por el no data found');
                 V_ERROR := 2;
         dbms_output.put_line ('le pone un 2 asin de grande');
         dbms_output.put_line ('se pira a error_proceso');
                 RAISE ERROR_PROCESO;
            WHEN OTHERS THEN
         dbms_output.put_line ('others');
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
              dbms_output.put_line ('odio esta mierda');
              IF V_ERROR = '0' THEN
                 V_ERROR := 4;
              END IF;
              RAISE ERROR_PROCESO;
      END;
   ELSE
      BEGIN
         dbms_output.put_line ('select de libre');
         SELECT NUM_DESDE,NUM_HASTA,NUM_SIGUIENTE,ROWID
           INTO V_NUM_DES,V_NUM_HAS,V_NUM_SIG,V_ROWID
           FROM GA_TREKNUM_CLTE
          WHERE
            COD_CENTRAL = V_CENTRAL
            AND COD_CLIENTE = V_CLIENTE
            AND NUM_LIBRES  > 0
            AND V_MAN BETWEEN NUM_SIGUIENTE AND NUM_HASTA
            FOR UPDATE OF NUM_SIGUIENTE NOWAIT;
         dbms_output.put_line ('sale de select de libre');
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
         IF V_MAN = V_NUM_SIG THEN
            IF V_MAN = V_NUM_HAS THEN
               UPDATE GA_TREKNUM_CLTE
                  SET NUM_LIBRES    = NUM_LIBRES - 1
                WHERE ROWID = V_ROWID;
            ELSE
               UPDATE GA_TREKNUM_CLTE
                  SET NUM_SIGUIENTE = NUM_SIGUIENTE + 1,
                      NUM_LIBRES    = NUM_LIBRES - 1
                WHERE ROWID = V_ROWID;
            END IF;
         ELSIF V_MAN = V_NUM_HAS THEN
            UPDATE GA_TREKNUM_CLTE
               SET NUM_HASTA  = NUM_HASTA - 1,
                   NUM_LIBRES = NUM_LIBRES - 1
             WHERE ROWID = V_ROWID;
            INSERT INTO GA_TREKNUM_CLTE
                   (NUM_DESDE,NUM_HASTA,
                    COD_PRODUCTO,
                    COD_CENTRAL,
                    NUM_LIBRES,
                    NUM_SIGUIENTE,COD_CLIENTE, IND_FIJA)
            VALUES (V_MAN,V_MAN,
                    4,
                    V_CENTRAL,
                    0,V_MAN, V_CLIENTE, 0);
         ELSE
            UPDATE GA_TREKNUM_CLTE
               SET NUM_HASTA = V_MAN - 1,
                   NUM_LIBRES = ((V_MAN - 1) - NUM_SIGUIENTE) + 1
             WHERE ROWID = V_ROWID;
            INSERT INTO GA_TREKNUM_CLTE
                   (NUM_DESDE,NUM_HASTA,
                    COD_PRODUCTO,
                    COD_CENTRAL,
                    NUM_LIBRES,
                    NUM_SIGUIENTE, COD_CLIENTE, IND_FIJA)
            VALUES (V_MAN,V_MAN,
                    4,
                    V_CENTRAL,
                    0,V_MAN, V_CLIENTE, 0);
            INSERT INTO GA_TREKNUM_CLTE
                   (NUM_DESDE,NUM_HASTA,
                    COD_PRODUCTO,
                    COD_CENTRAL,
                    NUM_LIBRES,
                    NUM_SIGUIENTE, COD_CLIENTE, IND_FIJA)
            VALUES (V_MAN + 1,V_NUM_HAS,
                    1,
                    V_CENTRAL,
                    (V_NUM_HAS - (V_MAN + 1)) + 1,
                    V_MAN + 1, V_CLIENTE, 0);
         END IF;
      EXCEPTION
          WHEN OTHERS THEN
               IF V_ERROR = '0' THEN
                  V_ERROR := 4;
               END IF;
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
EXCEPTION
   WHEN ERROR_PROCESO THEN
        dbms_output.put_line ('antes rollback');
        ROLLBACK;
        dbms_output.put_line ('despues rollback');
        dbms_output.put_line ('antes insert');
        INSERT INTO GA_TRANSACABO
                   (NUM_TRANSACCION,
                    COD_RETORNO,
                    DES_CADENA)
            VALUES (VP_TRANSAC,
                    V_ERROR,NULL);
        dbms_output.put_line ('despues insert');
        dbms_output.put_line ('antes commit');
        dbms_output.put_line ('despues commit');
   WHEN OTHERS THEN
        dbms_output.put_line ('ahhhhhhhhhhhhhh');
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
--
--
END;
/
SHOW ERRORS
