CREATE OR REPLACE PROCEDURE        P_NUMERACION_CELULAR
IS
--
-- Procedimiento de recuperacion de numeracion reservada en ventas incompletas
--
   V_ROWID ROWID;
   V_CELULAR GA_RESNUMCEL.NUM_CELULAR%TYPE;
   V_SUBALM GA_RESNUMCEL.COD_SUBALM%TYPE;
   V_PRODUCTO GA_RESNUMCEL.COD_PRODUCTO%TYPE;
   V_CENTRAL GA_RESNUMCEL.COD_CENTRAL%TYPE;
   V_CAT GA_RESNUMCEL.COD_CAT%TYPE;
   V_USO GA_RESNUMCEL.COD_USO%TYPE;
   V_TABLA GA_RESNUMCEL.IND_PROCNUM%TYPE;
   V_FECBAJA VARCHAR2(10);
   V_TRANSAC GA_TRANSACABO.NUM_TRANSACCION%TYPE;
   CURSOR C1 IS
   SELECT ROWID,
          NUM_CELULAR,
          COD_SUBALM,
          COD_PRODUCTO,
          COD_CENTRAL,
          COD_CAT,
          COD_USO,
          IND_PROCNUM,
          TO_CHAR(FEC_BAJA,'DD-MM-YYYY')
     FROM GA_RESNUMCEL
     WHERE TRUNC(FEC_RESERVA) <= SYSDATE -1;
BEGIN
    OPEN C1;
    LOOP
      FETCH C1 INTO V_ROWID,V_CELULAR,V_SUBALM,V_PRODUCTO,
                    V_CENTRAL,V_CAT,V_USO,V_TABLA,V_FECBAJA;
      EXIT WHEN C1%NOTFOUND;
      BEGIN
        SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO V_TRANSAC FROM DUAL;
        P_REPONER_NUMERACION (V_TRANSAC,V_TABLA,V_SUBALM,V_CENTRAL,V_CAT,V_USO,V_CELULAR,V_FECBAJA);
        DELETE GA_RESNUMCEL WHERE ROWID = V_ROWID;
        DELETE GA_TRANSACABO WHERE NUM_TRANSACCION = V_TRANSAC;
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
      END;
    END LOOP;
    CLOSE C1;
EXCEPTION
   WHEN OTHERS THEN
        ROLLBACK;
END;
/
SHOW ERRORS
