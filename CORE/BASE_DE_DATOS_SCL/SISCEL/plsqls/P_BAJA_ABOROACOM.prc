CREATE OR REPLACE PROCEDURE        P_BAJA_ABOROACOM(
  VP_ESTADIA IN NUMBER ,
  VP_TIPBAJA IN NUMBER ,
  VP_FECSYS IN DATE ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que actualiza o da de baja las tablas de interfase con
-- tarificacion de abonados roaming de la compania
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
BEGIN
   VP_PROC := 'P_BAJA_ABOROACOM';
   IF VP_TIPBAJA = 0 THEN
      VP_TABLA := 'GA_INTAROACOM';
      VP_ACT := 'D';
      DELETE GA_INTAROACOM
       WHERE NUM_ESTADIA = VP_ESTADIA;
   ELSE
      VP_TABLA := 'GA_INTAROACOM';
      VP_ACT := 'U';
      UPDATE GA_INTAROACOM
         SET FEC_HASTA = VP_FECSYS
       WHERE NUM_ESTADIA = VP_ESTADIA
  AND SYSDATE BETWEEN FEC_DESDE
    AND FEC_HASTA;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
