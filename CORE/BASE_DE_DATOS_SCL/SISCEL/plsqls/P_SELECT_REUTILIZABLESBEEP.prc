CREATE OR REPLACE PROCEDURE        P_SELECT_REUTILIZABLESBEEP(
  VP_CENTRAL IN VARCHAR2 ,
  VP_USO IN VARCHAR2 ,
  VP_BEEPER IN OUT VARCHAR2 ,
  VP_FECBAJA IN OUT DATE ,
  VP_ERROR IN OUT VARCHAR2 )
IS
   V_ROWID ROWID;
   V_DIAS GA_DATOSGENER.NUM_RESNUM%TYPE;
   CURSOR C2 IS
   SELECT ROWID
     FROM GA_BEEPNUM_REUTIL
    WHERE COD_CENTRAL = VP_CENTRAL
      AND COD_USO     = VP_USO
      AND FEC_BAJA + V_DIAS <= SYSDATE;
--    ORDER BY NUM_BEEPER;
BEGIN
    SELECT NUM_RESNUM
      INTO V_DIAS
      FROM GA_DATOSGENER;
    OPEN C2;
    LOOP
      IF VP_ERROR <> '2' THEN
         EXIT;
      END IF;
      BEGIN
         FETCH C2 INTO V_ROWID;
         EXIT WHEN C2%NOTFOUND;
         SELECT NUM_BEEPER,FEC_BAJA
           INTO VP_BEEPER,VP_FECBAJA
           FROM GA_BEEPNUM_REUTIL
          WHERE ROWID = V_ROWID
            FOR UPDATE  NOWAIT;
         DELETE GA_BEEPNUM_REUTIL WHERE ROWID = V_ROWID;
         VP_ERROR := '0';
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
              NULL;
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
