CREATE OR REPLACE procedure P_SELECT_REUTILIZABLES
(
  VP_ACTABO IN VARCHAR2 ,
  VP_SUBALM IN VARCHAR2 ,
  VP_CENTRAL IN NUMBER ,
  VP_USO IN NUMBER ,
  VP_CELULAR IN OUT NUMBER ,
  VP_CAT IN OUT NUMBER ,
  VP_FECBAJA IN OUT DATE ,
  VP_ERROR IN OUT VARCHAR2 )
IS
   V_ROWID ROWID;
   V_CAT  GA_CATACTABO.COD_CAT%TYPE;
   V_DIAS GA_DATOSGENER.NUM_RESNUM%TYPE;
  CURSOR C1 IS
   SELECT COD_CAT
     FROM GA_CATACTABO
    WHERE COD_ACTABO = VP_ACTABO;

   CURSOR C2 IS
   SELECT A.ROWID
   FROM GA_CELNUM_REUTIL A, AL_USOS Y
   WHERE A.COD_USO = Y.COD_USO
   AND COD_SUBALM  = VP_SUBALM
   AND COD_CENTRAL = VP_CENTRAL
   AND COD_CAT     = V_CAT
   AND USO_ANTERIOR     = VP_USO
   AND FEC_BAJA + Y.NUM_DIAS_HIBERNACION <= SYSDATE
   AND NOT EXISTS
   (SELECT NUM_CELULAR
   FROM GA_ABOAMIST B
   WHERE A.NUM_CELULAR=B.NUM_CELULAR
   --Incidencia RA-200602240839, Se cambia filtro para la validación del rescate de números, solo deben
   --tomarse en cuenta los números que están con situación BAA [PAAA 06-03-2006, soporte]
   --AND B.COD_SITUACION NOT IN ('BAA','BAP'))
   AND B.COD_SITUACION <>'BAA')
   --Fin incidencia RA-200602240839
   AND NOT EXISTS
   (SELECT NUM_CELULAR
   FROM GA_ABOCEL C
   WHERE A.NUM_CELULAR=C.NUM_CELULAR
   --Incidencia RA-200602240839, Se cambia filtro para la validación del rescate de números, solo deben
   --tomarse en cuenta los números que están con situación BAA [PAAA 06-03-2006, soporte]
   --AND C.COD_SITUACION NOT IN ('BAA','BAP'))
   AND C.COD_SITUACION <>'BAA')
   --Fin incidencia RA-200602240839
   AND NOT EXISTS
   (SELECT NUM_TELEFONO
   FROM AL_SERIES D
   WHERE A.NUM_CELULAR=D.NUM_TELEFONO)
   AND NOT EXISTS
   (SELECT NUM_CELULAR
   FROM AL_CELNUM_REUTIL E
   WHERE A.NUM_CELULAR=E.NUM_CELULAR);
BEGIN
    SELECT NUM_RESNUM
      INTO V_DIAS
      FROM GA_DATOSGENER;
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
                SELECT NUM_CELULAR,COD_CAT,FEC_BAJA
                INTO VP_CELULAR,VP_CAT,VP_FECBAJA
                FROM GA_CELNUM_REUTIL A
                WHERE ROWID = V_ROWID
                FOR UPDATE NOWAIT;
             DELETE GA_CELNUM_REUTIL WHERE ROWID = V_ROWID;
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
    END LOOP;
    CLOSE C1;
EXCEPTION
    WHEN OTHERS THEN
         VP_ERROR := '4';
END;
/
SHOW ERRORS
