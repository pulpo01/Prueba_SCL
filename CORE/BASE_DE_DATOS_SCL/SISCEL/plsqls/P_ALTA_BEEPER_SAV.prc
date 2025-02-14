CREATE OR REPLACE PROCEDURE        P_ALTA_BEEPER_SAV(
  VP_ABONADO IN NUMBER ,
  VP_CLASEABO IN VARCHAR2 ,
  VP_FECSYS IN DATE )
IS
--
-- Procedimiento de Actualizacion de parametros en la tabla de abonados
-- de la red beeper al activarles desde la venta en terreno.
--
   V_PROCED VARCHAR2(25) := NULL;
BEGIN
   V_PROCED := 'P_ALTA_BEEPER_SAV';
   UPDATE GA_ABOBEEP
      SET COD_SITUACION  = 'ATA',
          FEC_ACTCEN     = VP_FECSYS,
          PERFIL_ABONADO = VP_CLASEABO
    WHERE NUM_ABONADO    = VP_ABONADO;
EXCEPTION
   WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20222,V_PROCED||' '||SQLERRM);
END;
/
SHOW ERRORS
