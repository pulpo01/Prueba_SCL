CREATE OR REPLACE PROCEDURE        P_SELECT_RANGOSBEEP(
  VP_CENTRAL IN VARCHAR2 ,
  VP_USO IN VARCHAR2 ,
  VP_BEEPER IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
   V_LIBRES GA_BEEPNUM_USO.NUM_LIBRES%TYPE;
   V_NUM_HASTA GA_BEEPNUM_USO.NUM_HASTA%TYPE;
   V_ROWID ROWID;
   CURSOR C2 IS
   SELECT ROWID
     FROM GA_BEEPNUM_USO
    WHERE COD_CENTRAL = VP_CENTRAL
      AND COD_USO     = VP_USO
      AND NUM_LIBRES > 0;
--    ORDER BY NUM_DESDE;
BEGIN
   OPEN C2;
   LOOP
     IF VP_ERROR <> '2' THEN
        EXIT;
     END IF;
     BEGIN
       FETCH C2 INTO V_ROWID;
       EXIT WHEN C2%NOTFOUND;
       SELECT NUM_SIGUIENTE,NUM_LIBRES,NUM_HASTA
         INTO VP_BEEPER,V_LIBRES,V_NUM_HASTA
         FROM GA_BEEPNUM_USO
        WHERE ROWID = V_ROWID
          FOR UPDATE  NOWAIT;
       IF VP_BEEPER = V_NUM_HASTA THEN
          UPDATE GA_BEEPNUM_USO
             SET NUM_LIBRES = NUM_LIBRES - 1
           WHERE ROWID = V_ROWID;
       ELSE
          UPDATE GA_BEEPNUM_USO
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
/
SHOW ERRORS
