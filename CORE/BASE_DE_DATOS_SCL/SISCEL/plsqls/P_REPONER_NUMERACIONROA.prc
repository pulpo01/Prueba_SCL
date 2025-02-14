CREATE OR REPLACE PROCEDURE        P_REPONER_NUMERACIONROA(
  VP_TRANSAC IN VARCHAR2 ,
  VP_TABLA IN VARCHAR2 ,
  VP_OPERADOR IN VARCHAR2 ,
  VP_PAIS IN VARCHAR2 ,
  VP_ZONA IN VARCHAR2 ,
  VP_CELULAR IN VARCHAR2 ,
  VP_FECBAJA IN VARCHAR2 )
IS
   V_ROWID ROWID;
   V_NUM_DES GA_NUMROAOPER.NUM_DESDE%TYPE;
   V_NUM_HAS GA_NUMROAOPER.NUM_HASTA%TYPE;
   V_NUM_SIG GA_NUMROAOPER.NUM_SIGUIENTE%TYPE;
   V_NUM_LIBRES GA_NUMROAOPER.NUM_LIBRES%TYPE;
   V_ERROR CHAR(1) := '0';
   V_OPERADOR GA_NUMROAOPER.COD_OPERADOR%TYPE;
   V_FECBAJA GA_BEEPNUM_REUTIL.FEC_BAJA%TYPE;
   V_CELULAR GA_NUMROAOPER.NUM_DESDE%TYPE;
BEGIN
    V_CELULAR  := TO_NUMBER(VP_CELULAR);
    V_OPERADOR := TO_NUMBER(VP_OPERADOR);
    V_FECBAJA  := TO_DATE(VP_FECBAJA,'dd-mm-yyyy');
--
    IF VP_TABLA = 'R' THEN
       INSERT INTO GA_REUTNUMROA
                   (NUM_CELULAR,COD_OPERADOR,
      COD_PAIS,COD_ZONA,
      FEC_BAJA)
            VALUES (V_CELULAR,V_OPERADOR,
      VP_PAIS,VP_ZONA,
      V_FECBAJA);
    ELSE
       SELECT ROWID,NUM_DESDE,NUM_HASTA,
              NUM_SIGUIENTE,NUM_LIBRES
         INTO V_ROWID,V_NUM_DES,V_NUM_HAS,
              V_NUM_SIG,V_NUM_LIBRES
         FROM GA_NUMROAOPER
        WHERE COD_OPERADOR = V_OPERADOR
          AND COD_PAIS     = VP_PAIS
          AND COD_ZONA     = VP_ZONA
          AND V_CELULAR BETWEEN
              NUM_DESDE AND NUM_HASTA
          FOR UPDATE OF NUM_SIGUIENTE NOWAIT;
        IF V_CELULAR = V_NUM_DES AND V_CELULAR = V_NUM_HAS THEN
           UPDATE GA_NUMROAOPER
              SET NUM_LIBRES = NUM_LIBRES + 1
            WHERE ROWID = V_ROWID;
        ELSIF V_CELULAR = V_NUM_DES THEN
              IF V_CELULAR + 1 = V_NUM_SIG AND V_NUM_LIBRES > 0 THEN
                 UPDATE GA_NUMROAOPER
                    SET NUM_SIGUIENTE = V_CELULAR,
                        NUM_LIBRES    = NUM_LIBRES + 1
                  WHERE ROWID = V_ROWID;
              ELSE
                 UPDATE GA_NUMROAOPER
                    SET NUM_DESDE = NUM_DESDE + 1
                  WHERE ROWID = V_ROWID;
                 INSERT INTO GA_NUMROAOPER
                            (NUM_DESDE,NUM_HASTA,
                             COD_OPERADOR,COD_PAIS,
                             COD_ZONA,NUM_LIBRES,
                             NUM_SIGUIENTE)
                     VALUES (V_CELULAR,V_CELULAR,
                             V_OPERADOR,VP_PAIS,
                             VP_ZONA,1,
        V_CELULAR);
              END IF;
        ELSIF V_CELULAR = V_NUM_HAS THEN
              UPDATE GA_NUMROAOPER
                 SET NUM_LIBRES = NUM_LIBRES + 1
               WHERE ROWID = V_ROWID;
        ELSE
              IF V_CELULAR + 1 = V_NUM_SIG AND V_NUM_LIBRES > 0 THEN
                 UPDATE GA_NUMROAOPER
                    SET NUM_SIGUIENTE = V_CELULAR,
                        NUM_LIBRES    = NUM_LIBRES + 1
                  WHERE ROWID = V_ROWID;
              ELSIF V_CELULAR + 1 = V_NUM_SIG AND V_NUM_LIBRES = 0 THEN
                 UPDATE GA_NUMROAOPER
                    SET NUM_SIGUIENTE = V_CELULAR,
                        NUM_LIBRES    = NUM_LIBRES + 1
                  WHERE ROWID = V_ROWID;
                 INSERT INTO GA_NUMROAOPER
                            (NUM_DESDE,NUM_HASTA,
                             COD_OPERADOR,COD_PAIS,
                             COD_ZONA,NUM_LIBRES,
                             NUM_SIGUIENTE)
                     VALUES (V_CELULAR + 1,V_CELULAR + 1,
                             V_OPERADOR,VP_PAIS,
                             VP_ZONA,0,
        V_CELULAR + 1);
              ELSE
                 UPDATE GA_NUMROAOPER
                    SET NUM_HASTA = V_CELULAR - 1,
                        NUM_SIGUIENTE = V_CELULAR - 1,
                        NUM_LIBRES    = 0
                  WHERE ROWID = V_ROWID;
                 INSERT INTO GA_NUMROAOPER
                            (NUM_DESDE,NUM_HASTA,
                             COD_OPERADOR,COD_PAIS,
                             COD_ZONA,NUM_LIBRES,
                             NUM_SIGUIENTE)
                     VALUES (V_CELULAR,V_CELULAR,
                             V_OPERADOR,VP_PAIS,
                             VP_ZONA,1,
        V_CELULAR);
                 INSERT INTO GA_NUMROAOPER
                            (NUM_DESDE,NUM_HASTA,
                             COD_OPERADOR,COD_PAIS,
                             COD_ZONA,NUM_LIBRES,
                             NUM_SIGUIENTE)
                     VALUES (V_CELULAR + 1,V_NUM_HAS,
                             V_OPERADOR,VP_PAIS,
                             VP_ZONA,((V_NUM_HAS - V_NUM_SIG) + 1),
                             V_NUM_SIG);
              END IF;
        END IF;
    END IF;
    INSERT INTO GA_TRANSACABO
               (NUM_TRANSACCION,
                COD_RETORNO,
                DES_CADENA)
        VALUES (VP_TRANSAC,
                0,NULL);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
         IF SQLCODE = -54 THEN
            P_REPONER_NUMERACIONROA (VP_TRANSAC ,
                                     VP_TABLA ,
                                     VP_OPERADOR ,
                                     VP_PAIS ,
                                     VP_ZONA ,
                                     VP_CELULAR ,
                                     VP_FECBAJA );
         ELSE
            ROLLBACK;
            INSERT INTO GA_TRANSACABO
                       (NUM_TRANSACCION,
                        COD_RETORNO,
                        DES_CADENA)
                VALUES (VP_TRANSAC,
                        4,NULL);
            COMMIT;
         END IF;
END;
/
SHOW ERRORS
