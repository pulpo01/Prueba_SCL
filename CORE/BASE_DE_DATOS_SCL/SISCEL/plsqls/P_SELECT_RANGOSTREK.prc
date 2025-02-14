CREATE OR REPLACE PROCEDURE        P_SELECT_RANGOSTREK (VP_CENTRAL IN NUMBER,
                                                 VP_CLIENTE IN NUMBER,
                                                 VP_MAN IN OUT NUMBER,
                                                 VP_TIPSUSC IN VARCHAR2,
                                                 VP_RANGO IN OUT NUMBER,
                                                 VP_ERROR IN OUT VARCHAR2) is
   V_LIBRES GA_TREKNUM_CLTE.NUM_LIBRES%TYPE;
   V_SIGUIENTE GA_TREKNUM_CLTE.NUM_SIGUIENTE%TYPE;
   V_HASTA GA_TREKNUM_CLTE.NUM_HASTA%TYPE;
   V_ROWID ROWID;
   V_FIJA GA_TREKNUM_CLTE.IND_FIJA%TYPE;
   CURSOR C1 is
   SELECT NUM_SIGUIENTE,NUM_HASTA,ROWID
     FROM GA_TREKNUM_CENTRAL
    WHERE COD_CENTRAL = VP_CENTRAL
      FOR UPDATE OF NUM_SIGUIENTE;
BEGIN
   IF VP_TIPSUSC = 'F' THEN
      BEGIN
         dbms_output.put_line ('s1');
         SELECT NUM_DESDE,NUM_HASTA,ROWID,IND_FIJA
           INTO VP_MAN,V_HASTA,V_ROWID,V_FIJA
           FROM GA_TREKNUM_CLTE
          WHERE COD_CENTRAL = VP_CENTRAL
            AND COD_CLIENTE = VP_CLIENTE
            AND IND_FIJA = 0
            AND ROWNUM = 1
            FOR UPDATE OF IND_FIJA;
         dbms_output.put_line ('u1');
         UPDATE GA_TREKNUM_CLTE
            SET IND_FIJA = 1
          WHERE ROWID = V_ROWID;
         VP_ERROR := '0';
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
              BEGIN
         dbms_output.put_line ('s2');
                 SELECT IND_FIJA
                   INTO V_FIJA
                   FROM GA_TREKNUM_CLTE
                  WHERE COD_CENTRAL = VP_CENTRAL
                    AND COD_CLIENTE = VP_CLIENTE
                    AND IND_FIJA = 1
                    AND NUM_LIBRES > 0;
                 VP_ERROR := 5;
              EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                    BEGIN
                       VP_ERROR := 3;
                       OPEN C1;
                       LOOP
                          FETCH C1 INTO V_SIGUIENTE, V_HASTA, V_ROWID;
                          EXIT WHEN C1%NOTFOUND;
         dbms_output.put_line ('s3');
                          IF V_HASTA - V_SIGUIENTE < 100 THEN
                             VP_ERROR := '3';
                          ELSE
         dbms_output.put_line ('u2');
                             UPDATE GA_TREKNUM_CENTRAL
                                SET NUM_SIGUIENTE = NUM_SIGUIENTE + 100
                              WHERE ROWID = V_ROWID;
         dbms_output.put_line ('i1');
                             INSERT INTO GA_TREKNUM_CLTE
                                        (NUM_DESDE,NUM_HASTA,COD_PRODUCTO,
                                         COD_CENTRAL,COD_CLIENTE,NUM_LIBRES,
                                         NUM_SIGUIENTE,IND_FIJA)
                                 VALUES (V_SIGUIENTE,V_SIGUIENTE + 99,4,
                                         VP_CENTRAL,VP_CLIENTE,99,
                                         V_SIGUIENTE + 1,1);
                             VP_MAN := V_SIGUIENTE;
                             VP_RANGO := 1;
                             VP_ERROR := '0';
                             EXIT;
                          END IF;
                      END LOOP;
                      CLOSE C1;
         dbms_output.put_line ('sale i1');
                    EXCEPTION
                       WHEN NO_DATA_FOUND THEN
                            VP_ERROR := '3';
                       WHEN OTHERS THEN
                            IF SQLCODE = -54 THEN
                               VP_ERROR := 1;
                            ELSE
                               VP_ERROR := '4';
                            END IF;
                    END;
                 WHEN OTHERS THEN
                    VP_ERROR := 4;
              END;
         WHEN OTHERS THEN
            VP_ERROR := 4;
      END;
   ELSE
      BEGIN
         dbms_output.put_line ('s4');
         SELECT NUM_SIGUIENTE,NUM_HASTA,ROWID,NUM_LIBRES
           INTO VP_MAN,V_HASTA,V_ROWID,V_LIBRES
           FROM GA_TREKNUM_CLTE
          WHERE COD_CENTRAL = VP_CENTRAL
            AND COD_CLIENTE = VP_CLIENTE
            AND NUM_LIBRES > 0
            AND ROWNUM = 1
            FOR UPDATE OF NUM_LIBRES;
            IF VP_MAN = V_HASTA THEN
         dbms_output.put_line ('u3');
               UPDATE GA_TREKNUM_CLTE
                  SET NUM_SIGUIENTE = V_HASTA,
                      NUM_LIBRES = NUM_LIBRES - 1
                WHERE ROWID = V_ROWID;
            ELSE
         dbms_output.put_line ('u4');
               UPDATE GA_TREKNUM_CLTE
                  SET NUM_SIGUIENTE = NUM_SIGUIENTE + 1,
                      NUM_LIBRES = NUM_LIBRES - 1
                WHERE ROWID = V_ROWID;
            END IF;
            VP_ERROR := '0';
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
              BEGIN
         dbms_output.put_line ('s5');
                 SELECT NUM_SIGUIENTE,NUM_HASTA,ROWID
                   INTO V_SIGUIENTE,V_HASTA,V_ROWID
                   FROM GA_TREKNUM_CENTRAL
                  WHERE COD_CENTRAL = VP_CENTRAL
                    FOR UPDATE OF NUM_SIGUIENTE;
                    IF V_HASTA - V_SIGUIENTE < 100 THEN
                       VP_ERROR := '3';
                    ELSE
         dbms_output.put_line ('u5');
                       UPDATE GA_TREKNUM_CENTRAL
                          SET NUM_SIGUIENTE = NUM_SIGUIENTE + 100
                        WHERE ROWID = V_ROWID;
                       INSERT INTO GA_TREKNUM_CLTE
                                  (NUM_DESDE,NUM_HASTA,COD_PRODUCTO,
                                   COD_CENTRAL,COD_CLIENTE,NUM_LIBRES,
                                   NUM_SIGUIENTE,IND_FIJA)
                           VALUES (V_SIGUIENTE,V_SIGUIENTE + 99,4,
                                   VP_CENTRAL,VP_CLIENTE,99,
                                   V_SIGUIENTE + 2,0);
                       VP_MAN := V_SIGUIENTE + 1;
                       VP_RANGO := 1;
                       VP_ERROR := '0';
                    END IF;
              EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                      VP_ERROR := '3';
                 WHEN OTHERS THEN
                      IF SQLCODE = -54 THEN
                         VP_ERROR := 1;
                      ELSE
                         VP_ERROR := '4';
                      END IF;
              END;
        WHEN OTHERS THEN
           IF SQLCODE = -54 THEN
              VP_ERROR := 1;
           ELSE
              VP_ERROR := '4';
           END IF;
     END;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -54 THEN
         VP_ERROR := 1;
      ELSE
         VP_ERROR := '4';
      END IF;
END;
/
SHOW ERRORS
