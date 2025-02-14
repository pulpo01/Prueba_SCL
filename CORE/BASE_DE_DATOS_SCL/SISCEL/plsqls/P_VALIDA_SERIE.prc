CREATE OR REPLACE PROCEDURE P_VALIDA_SERIE(
  V_TRANSAC IN GA_TRANSACABO.NUM_TRANSACCION%TYPE ,
  V_SERIE IN GA_ABOCEL.NUM_SERIE%TYPE )
IS
    V_ERROR GA_TRANSACABO.NUM_TRANSACCION%TYPE := 0;
        TRANSAC GA_TRANSACABO.NUM_TRANSACCION%TYPE;
BEGIN
--
-- Procedimiento inicial de recopilacion de parametros que arranca el proceso
-- de validacion de series celulares
--
-- Realiza llamadas a los siguientes procedimientos :
--         - P_VALIDA_FORMATO ; Valida que el formato de la serie en decimal
--                              sea el correcto
--         - P_VALIDA_REPETICION ; Valida que la serie no pertenezca al equipo
--                                 de otro abonado celular
--         - P_VALIDA_ROBADAS ; Valida que la serie no se encuentre catalogada
--                              como robada
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Serie correcta y convertida
--         - "1" ; Formato de serie incorrecta
--         - "2" ; Serie repetida
--         - "3" ; Serie robada
--         - "4" ; Error en el proceso
--
   P_VALIDA_FORMATO (V_SERIE,V_ERROR);

   IF V_ERROR = '0' THEN

      P_VALIDA_REPETICION (V_SERIE,V_ERROR);

      IF V_ERROR = '0' THEN
          -- ini p-col-06054 y.o.
        --P_VALIDA_ROBADAS (V_SERIE,V_ERROR);

                PV_SERIES_NEGATIVAS_PG.PV_SERIES_NEGATIVAS_PR(V_TRANSAC,V_SERIE,'S','0','0','PLVS');

                SELECT COD_RETORNO INTO V_ERROR FROM GA_TRANSACABO WHERE NUM_TRANSACCION = V_TRANSAC;

          -- fin p-col-06054 y.o.
      END IF;
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
