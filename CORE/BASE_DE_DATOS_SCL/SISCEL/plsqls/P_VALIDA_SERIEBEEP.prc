CREATE OR REPLACE PROCEDURE        P_VALIDA_SERIEBEEP(
  V_TRANSAC IN GA_TRANSACABO.NUM_TRANSACCION%TYPE ,
  V_SERIE IN GA_ABOBEEP.NUM_SERIE%TYPE )
IS
    V_ERROR GA_TRANSACABO.NUM_TRANSACCION%TYPE := 0;
BEGIN
--
-- Procedimiento inicial de recopilacion de parametros que arranca el proceso
-- de validacion de series beeper
--
-- Realiza llamadas a los siguientes procedimientos :
--         - P_VALIDA_REPETICIONBEEP ; Valida que la serie no pertenezca
--                         al equipo de otro abonado beeper
--         - P_VALIDA_ROBADASBEEP ; Valida que la serie no se encuentre
--                      catalogada como robada
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Serie correcta y convertida
--         - "2" ; Serie repetida
--         - "3" ; Serie robada
--         - "4" ; Error en el proceso
--
   P_VALIDA_REPETICIONBEEP (V_SERIE,V_ERROR);
   IF V_ERROR = '0' THEN
      P_VALIDA_ROBADASBEEP (V_SERIE,V_ERROR);
   END IF;
   INSERT INTO GA_TRANSACABO
   VALUES (V_TRANSAC,V_ERROR,NULL);
EXCEPTION
   WHEN OTHERS THEN
        V_ERROR := '4';
--
--
END;
/
SHOW ERRORS
