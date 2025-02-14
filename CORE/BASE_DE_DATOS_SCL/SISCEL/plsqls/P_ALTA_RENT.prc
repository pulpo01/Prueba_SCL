CREATE OR REPLACE PROCEDURE        P_ALTA_RENT(
  VP_ABONADO IN NUMBER ,
  VP_CLASEABO IN VARCHAR2 ,
  VP_FECSYS IN DATE )
IS
--
-- Procedimiento de Actualizacion de parametros en la tabla de abonados
-- de la red celular al activarles desde la venta en oficina.
--
   V_PROCED VARCHAR2(25) := NULL;
BEGIN
   V_PROCED := 'P_ALTA_CELULAR_OFI';
   UPDATE GA_ABORENT
      SET COD_SITUACION  = 'AAA',
          FEC_ACTCEN     = VP_FECSYS,
          PERFIL_ABONADO = VP_CLASEABO
    WHERE NUM_ABONADO    = VP_ABONADO;
EXCEPTION
   WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20218,V_PROCED||' '||SQLERRM);
END;
/
SHOW ERRORS
