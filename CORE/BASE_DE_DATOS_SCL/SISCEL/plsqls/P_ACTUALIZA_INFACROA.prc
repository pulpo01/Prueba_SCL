CREATE OR REPLACE PROCEDURE        P_ACTUALIZA_INFACROA(
  VP_ABONADO IN NUMBER )
IS
--
-- Procedimiento de Actualizacion de indicador de estado del abonado
-- roaming visitante en las tablas de interfase con facturacion
--
   V_PROCED VARCHAR2(25) := NULL;
BEGIN
   V_PROCED := 'P_ACTUALIZA_INFACROA';
   UPDATE GA_INFACROAVIS
      SET IND_ACTUAC  = 2
    WHERE NUM_ABONADO = VP_ABONADO;
EXCEPTION
   WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20224,V_PROCED||' '||SQLERRM);
END;
/
SHOW ERRORS
