CREATE OR REPLACE PROCEDURE        P_REPONER_NUMERACIONTREK (VP_TRANSAC IN VARCHAR2,
                                                      VP_TABLA IN VARCHAR2,
                                                      VP_CENTRAL IN VARCHAR2,
                                                      VP_CLIENTE IN VARCHAR2,
                                                      VP_MAN IN VARCHAR2,
                                                      VP_FECBAJA IN VARCHAR2,
                                                      VP_TIPSUSC IN VARCHAR2) is
   V_ROWID ROWID;
   V_NUM_DES GA_TREKNUM_CLTE.NUM_DESDE%TYPE;
   V_NUM_HAS GA_TREKNUM_CLTE.NUM_HASTA%TYPE;
   V_NUM_SIG GA_TREKNUM_CLTE.NUM_SIGUIENTE%TYPE;
   V_NUM_LIBRES GA_TREKNUM_CLTE.NUM_LIBRES%TYPE;
   V_ERROR CHAR(1) := '0';
   V_CENTRAL GA_TREKNUM_CLTE.COD_CENTRAL%TYPE;
   V_CLIENTE GA_TREKNUM_CLTE.COD_CLIENTE%TYPE;
   V_FECBAJA GA_TREKNUM_REUTIL.FEC_BAJA%TYPE;
   V_MAN GA_TREKNUM_CLTE.NUM_DESDE%TYPE;
   V_FIJA GA_TREKNUM_CLTE.IND_FIJA%TYPE;
BEGIN
    V_CENTRAL := TO_NUMBER(VP_CENTRAL);
    V_MAN := TO_NUMBER(VP_MAN);
    V_CLIENTE     := TO_NUMBER(VP_CLIENTE);
    V_FECBAJA := TO_DATE(VP_FECBAJA,'dd-mm-yyyy');
    dbms_output.put_line ('numero: '||v_man);
--
    IF VP_TABLA = 'R' THEN
       dbms_output.put_line ('reutil: antes del insert');
       INSERT INTO GA_TREKNUM_REUTIL
                   (NUM_MAN,COD_PRODUCTO,
                    COD_CENTRAL,COD_CLIENTE,
                    IND_TIPSUSC,FEC_BAJA)
            VALUES (V_MAN,4,
                    V_CENTRAL,V_CLIENTE,
                    VP_TIPSUSC,V_FECBAJA);
       dbms_output.put_line ('reutil: despues del insert');
    ELSE
       dbms_output.put_line ('select 1');
       SELECT ROWID,NUM_DESDE,NUM_HASTA,
              NUM_SIGUIENTE,NUM_LIBRES,DECODE(VP_TIPSUSC,'F',0,IND_FIJA)
         INTO V_ROWID,V_NUM_DES,V_NUM_HAS,
              V_NUM_SIG,V_NUM_LIBRES,V_FIJA
         FROM GA_TREKNUM_CLTE
        WHERE COD_CENTRAL = V_CENTRAL
          AND COD_CLIENTE = V_CLIENTE
          AND V_MAN BETWEEN
              NUM_DESDE AND NUM_HASTA
          FOR UPDATE OF NUM_SIGUIENTE NOWAIT;
       dbms_output.put_line ('sale select 1');
        IF VP_TIPSUSC = 'F' THEN
           UPDATE GA_TREKNUM_CLTE
              SET IND_FIJA = 0
            WHERE ROWID = V_ROWID;
        ELSE
           IF V_MAN = V_NUM_DES AND V_MAN = V_NUM_HAS THEN
          dbms_output.put_line ('update 1');
              UPDATE GA_TREKNUM_CLTE
                 SET NUM_LIBRES = NUM_LIBRES + 1
               WHERE ROWID = V_ROWID;
           ELSIF V_MAN = V_NUM_DES THEN
                 IF V_MAN + 1 = V_NUM_SIG AND V_NUM_LIBRES > 0 THEN
       dbms_output.put_line ('update 2');
                    UPDATE GA_TREKNUM_CLTE
                       SET NUM_SIGUIENTE = V_MAN,
                           NUM_LIBRES    = NUM_LIBRES + 1
                     WHERE ROWID = V_ROWID;
                 ELSE
          dbms_output.put_line ('update 3');
                    UPDATE GA_TREKNUM_CLTE
                       SET NUM_DESDE = NUM_DESDE + 1
                     WHERE ROWID = V_ROWID;
                    INSERT INTO GA_TREKNUM_CLTE
                               (NUM_DESDE,NUM_HASTA,
                                COD_PRODUCTO,COD_CENTRAL,
                                COD_CLIENTE,NUM_LIBRES,
                                NUM_SIGUIENTE,IND_FIJA)
                        VALUES (V_MAN,V_MAN,
                                4,V_CENTRAL,
                                V_CLIENTE,1,
                                V_MAN,1);
                 END IF;
           ELSIF V_MAN = V_NUM_HAS THEN
          dbms_output.put_line ('update 4');
                 UPDATE GA_TREKNUM_CLTE
                    SET NUM_LIBRES = NUM_LIBRES + 1
                  WHERE ROWID = V_ROWID;
           ELSE
                 IF V_MAN + 1 = V_NUM_SIG AND V_NUM_LIBRES > 0 THEN
                   dbms_output.put_line ('update 5');
                    UPDATE GA_TREKNUM_CLTE
                       SET NUM_SIGUIENTE = V_MAN,
                           NUM_LIBRES    = NUM_LIBRES + 1
                     WHERE ROWID = V_ROWID;
                 ELSIF V_MAN + 1 = V_NUM_SIG AND V_NUM_LIBRES = 0 THEN
                    UPDATE GA_TREKNUM_CLTE
                       SET NUM_SIGUIENTE = V_MAN,
                           NUM_LIBRES    = NUM_LIBRES + 1
                     WHERE ROWID = V_ROWID;
                    INSERT INTO GA_TREKNUM_CLTE
                               (NUM_DESDE,NUM_HASTA,
                                COD_PRODUCTO,COD_CENTRAL,
                                COD_CLIENTE,NUM_LIBRES,
                                NUM_SIGUIENTE,IND_FIJA)
                        VALUES (V_MAN + 1,V_MAN + 1,
                                4,V_CENTRAL,
                                V_CLIENTE,0,
                                V_MAN + 1,1);
                 ELSE
                   dbms_output.put_line ('update 6');
                    UPDATE GA_TREKNUM_CLTE
                       SET NUM_HASTA = V_MAN - 1,
                           NUM_SIGUIENTE = V_MAN - 1,
                           NUM_LIBRES    = 0
                     WHERE ROWID = V_ROWID;
                   dbms_output.put_line ('insert 1');
                    INSERT INTO GA_TREKNUM_CLTE
                               (NUM_DESDE,NUM_HASTA,
                                COD_PRODUCTO,COD_CENTRAL,
                                COD_CLIENTE,NUM_LIBRES,
                                NUM_SIGUIENTE,IND_FIJA)
                        VALUES (V_MAN,V_MAN,
                                4,V_CENTRAL,
                                V_CLIENTE,1,
                                V_MAN,1);
                   dbms_output.put_line ('insert 2');
                    INSERT INTO GA_TREKNUM_CLTE
                               (NUM_DESDE,NUM_HASTA,
                                COD_PRODUCTO,COD_CENTRAL,
                                COD_CLIENTE,NUM_LIBRES,
                                NUM_SIGUIENTE,IND_FIJA)
                        VALUES (V_MAN + 1,V_NUM_HAS,
                                4,V_CENTRAL,
                                V_CLIENTE,((V_NUM_HAS - V_NUM_SIG) + 1),
                                V_NUM_SIG,1);
                 END IF;
           END IF;
       END IF;
       dbms_output.put_line ('insert 3');
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
            P_REPONER_NUMERACIONTREK (VP_TRANSAC ,
                                      VP_TABLA ,
                                      VP_CENTRAL ,
                                      VP_CLIENTE ,
                                      VP_MAN ,
                                      VP_FECBAJA ,
                                      VP_TIPSUSC );
         ELSE
            ROLLBACK;
       dbms_output.put_line ('insert 4');
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
