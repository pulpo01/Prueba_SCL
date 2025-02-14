CREATE OR REPLACE PROCEDURE        P_SELECT_RANGOS
(
  VP_ACTABO IN VARCHAR2 ,
  VP_SUBALM IN VARCHAR2 ,
  VP_CENTRAL IN NUMBER ,
  VP_USO IN NUMBER ,
  VP_CELULAR IN OUT NUMBER ,
  VP_CAT IN OUT NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
   V_LIBRES GA_CELNUM_USO.NUM_LIBRES%TYPE;
   V_CAT GA_CELNUM_USO.COD_CAT%TYPE;
   V_NUM_HASTA GA_CELNUM_USO.NUM_HASTA%TYPE;
   V_ROWID ROWID;
   CURSOR C1 IS
   SELECT COD_CAT
     FROM GA_CATACTABO
    WHERE COD_ACTABO = VP_ACTABO;
   CURSOR C2 IS
   SELECT ROWID
     FROM GA_CELNUM_USO
    WHERE COD_SUBALM  = VP_SUBALM
      AND COD_CENTRAL = VP_CENTRAL
      AND COD_CAT     = V_CAT
      AND COD_USO     = VP_USO
      AND NUM_LIBRES > 0;
BEGIN
    OPEN C1;
    LOOP
      IF VP_ERROR <> '2' THEN
         EXIT;
      END IF;
      BEGIN
         FETCH C1 INTO V_CAT;
         EXIT WHEN C1%NOTFOUND;
         OPEN C2;
         LOOP
           IF VP_ERROR <> '2' THEN
              EXIT;
           END IF;
           BEGIN
             FETCH C2 INTO V_ROWID;
             EXIT WHEN C2%NOTFOUND;
             SELECT NUM_SIGUIENTE,COD_CAT,NUM_LIBRES,NUM_HASTA
               INTO VP_CELULAR,VP_CAT,V_LIBRES,V_NUM_HASTA
               FROM GA_CELNUM_USO
              WHERE ROWID = V_ROWID
                FOR UPDATE NOWAIT;
             IF VP_CELULAR = V_NUM_HASTA THEN
                UPDATE GA_CELNUM_USO
                   SET NUM_LIBRES = NUM_LIBRES - 1
                 WHERE ROWID = V_ROWID;
             ELSE
                UPDATE GA_CELNUM_USO
                   SET NUM_SIGUIENTE = NUM_SIGUIENTE + 1,
                       NUM_LIBRES    = NUM_LIBRES - 1
                 WHERE ROWID = V_ROWID;
             END IF;
             VP_ERROR := '0';
           EXCEPTION
             WHEN OTHERS THEN
                  IF SQLCODE = -54 THEN
                     NULL;
                  ELSE
                     VP_ERROR := '4';
                  END IF;
           END;
         END LOOP;
         CLOSE C2;
      EXCEPTION
         WHEN OTHERS THEN
              VP_ERROR := '4';
      END;
    END LOOP;
    CLOSE C1;
EXCEPTION
    WHEN OTHERS THEN
         VP_ERROR := '4';
END;
/
SHOW ERRORS
