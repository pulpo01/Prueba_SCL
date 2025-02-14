CREATE OR REPLACE PROCEDURE        GA_P_ABRE_RANGOSTREK (VP_TRANSAC IN VARCHAR2, VP_CENTRAL IN VARCHAR2,
                                                 VP_CLIENTE IN VARCHAR2) is
-- PL QUE ABRE RANGOS PARA UNA CENTRAL Y UN CLIENTE PASADOS COMO
-- PARAMETROS
-- Los valores del codigo de retorno seran los siguientes:
--              "0":  correcto
--              "4":  error
--              "3":  no existen rangos para la central
--
        V_LIBRES GA_TREKNUM_CLTE.NUM_LIBRES%TYPE;
        V_SIGUIENTE GA_TREKNUM_CLTE.NUM_SIGUIENTE%TYPE;
        V_HASTA GA_TREKNUM_CLTE.NUM_HASTA%TYPE;
        V_ROWID ROWID;
        V_FIJA GA_TREKNUM_CLTE.IND_FIJA%TYPE;
        ERROR_PROCESO EXCEPTION;
        V_ERROR GA_TRANSACABO.COD_RETORNO%TYPE;
        V_CADENA GA_TRANSACABO.DES_CADENA%TYPE;
        V_CENTRAL ICG_CENTRAL.COD_CENTRAL%TYPE;
        V_CLIENTE GE_CLIENTES.COD_CLIENTE%TYPE;
        CURSOR C1 IS
                SELECT NUM_SIGUIENTE,NUM_HASTA,ROWID
                FROM GA_TREKNUM_CENTRAL
                WHERE COD_CENTRAL = V_CENTRAL
                FOR UPDATE OF NUM_SIGUIENTE;
BEGIN
        V_ERROR         := 3;
        V_CENTRAL       :=  TO_NUMBER(VP_CENTRAL);
        V_CLIENTE       :=  TO_NUMBER(VP_CLIENTE);
OPEN C1;
        LOOP
                FETCH C1 INTO V_SIGUIENTE, V_HASTA, V_ROWID;
                EXIT WHEN C1%NOTFOUND;
                dbms_output.put_line ('s3');
                IF V_HASTA - V_SIGUIENTE < 100 THEN
                        V_ERROR := '3';
                ELSE
                        V_ERROR := '0';
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
                                 V_CENTRAL,V_CLIENTE,99,
                                 V_SIGUIENTE + 1,0);
                        EXIT;
                END IF;
        END LOOP;
CLOSE C1;
dbms_output.put_line ('sale i1');
RAISE ERROR_PROCESO;
EXCEPTION
   WHEN ERROR_PROCESO THEN
        INSERT INTO GA_TRANSACABO
              (NUM_TRANSACCION,
               COD_RETORNO,
               DES_CADENA)
       VALUES (VP_TRANSAC,
               V_ERROR,V_CADENA);
        COMMIT;
    WHEN OTHERS THEN
         ROLLBACK;
         V_ERROR := 4;
         RAISE ERROR_PROCESO;
END;
/
SHOW ERRORS
