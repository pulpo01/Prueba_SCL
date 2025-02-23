CREATE OR REPLACE PROCEDURE        P_BAJA_ROACOM
IS
--
-- Procedimiento que realiza el paso a historicos de los abonados
-- roaming de la compania que han sobrepasado su periodo de servicio
-- y el paso de la numeracion a reutilizables
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
  CURSOR C1 is
  SELECT ROWID,NUM_ESTADIA,NUM_CELULAR,COD_OPERADOR,COD_PAIS,COD_ZONA
    FROM GA_ABOROACOM
   WHERE FEC_BAJA < SYSDATE;
  V_ROWID ROWID;
  V_CELULAR GA_ABOROACOM.NUM_CELULAR%TYPE;
  VAR1 GA_ABOROACOM.NUM_CELULAR%TYPE;
  V_OPERADOR GA_ABOROACOM.COD_OPERADOR%TYPE;
  V_PAIS GA_ABOROACOM.COD_PAIS%TYPE;
  V_ZONA GA_ABOROACOM.COD_ZONA%TYPE;
  V_ESTADIA GA_ABOROACOM.NUM_ESTADIA%TYPE;
BEGIN
   OPEN C1;
   LOOP
     FETCH C1 INTO V_ROWID,V_ESTADIA,V_CELULAR,V_OPERADOR,V_PAIS,V_ZONA;
     EXIT WHEN C1%NOTFOUND;
     BEGIN
        INSERT INTO GA_HABOROACOM
        (NUM_ESTADIA,NUM_ABONADO,FEC_HISTORICO,
      NUM_CELULAR,COD_OPERADOR,COD_PAIS,
      COD_ZONA,FEC_SOLICITUD,FEC_ALTA,
      FEC_BAJA,NUM_ABONADOCEL,NUM_SOLROA,
      NOM_USUARORA,IMP_LIMCONSUMO,COD_DIRECCION,
      DES_DIRECCION,NUM_TELCONTAC,OBS_ABONADO)
            (SELECT NUM_ESTADIA,NUM_ABONADO,SYSDATE,
      NUM_CELULAR,COD_OPERADOR,COD_PAIS,
      COD_ZONA,FEC_SOLICITUD,FEC_ALTA,
      FEC_BAJA,NUM_ABONADOCEL,NUM_SOLROA,
      NOM_USUARORA,IMP_LIMCONSUMO,COD_DIRECCION,
      DES_DIRECCION,NUM_TELCONTAC,OBS_ABONADO
               FROM GA_ABOROACOM
              WHERE ROWID = V_ROWID);
        DELETE GA_ABOROACOM WHERE ROWID = V_ROWID;
        INSERT INTO GA_HMODABOROACOM
     (NUM_ESTADIA,FEC_MODIFICA,FEC_HISTORICO,
      FEC_ALTA,FEC_BAJA,IMP_LIMCONSUMO,
      NOM_USUARORA,COD_DIRECCION,DES_DIRECCION,
      NUM_TELCONTAC,OBS_ABONADO)
            (SELECT NUM_ESTADIA,FEC_MODIFICA,SYSDATE,
      FEC_ALTA,FEC_BAJA,IMP_LIMCONSUMO,
      NOM_USUARORA,COD_DIRECCION,DES_DIRECCION,
      NUM_TELCONTAC,OBS_ABONADO
               FROM GA_MODABOROACOM
              WHERE NUM_ESTADIA = V_ESTADIA);
        DELETE GA_MODABOROACOM WHERE NUM_ESTADIA = V_ESTADIA;
        BEGIN
                        SELECT NUM_CELULAR
                         INTO VAR1
                        FROM GA_NUMRESROA
                             WHERE NUM_CELULAR = V_CELULAR;
                        EXCEPTION
                            WHEN NO_DATA_FOUND THEN
                             INSERT INTO GA_REUTNUMROA
                              (NUM_CELULAR,COD_OPERADOR,COD_PAIS,
                              COD_ZONA,FEC_BAJA)
                              VALUES (V_CELULAR,V_OPERADOR,V_PAIS,
                              V_ZONA,SYSDATE);
                            WHEN OTHERS THEN
                              NULL;
                        END;
     EXCEPTION
 WHEN OTHERS THEN
      NULL;
     END;
   END LOOP;
   CLOSE C1;
   COMMIT;
EXCEPTION
   WHEN OTHERS THEN
        NULL;
END;
/
SHOW ERRORS
