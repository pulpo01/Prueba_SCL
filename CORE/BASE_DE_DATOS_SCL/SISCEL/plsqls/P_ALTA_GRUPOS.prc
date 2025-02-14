CREATE OR REPLACE PROCEDURE        P_ALTA_GRUPOS(
  VP_ABONADO IN NUMBER ,
  VP_FECSYS IN DATE )
IS
--
-- Procedimiento de Actualizacion de fecha de activacion en central
-- de las suscripciones tipo grupo de beeper.
--
   V_PROCED VARCHAR2(25) := NULL;
BEGIN
   V_PROCED := 'P_ALTA_GRUPOS';
   UPDATE GA_GRPBEEP
      SET FEC_ALTACEN = VP_FECSYS
    WHERE COD_GRUPO   = VP_ABONADO;
EXCEPTION
   WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20226,V_PROCED||' '||SQLERRM);
END;
/
SHOW ERRORS
