CREATE OR REPLACE PROCEDURE P_VALIDA_SERIE_GSM(
  V_TRANSAC IN GA_TRANSACABO.NUM_TRANSACCION%TYPE ,
  V_SERIE IN GA_ABOCEL.NUM_SERIE%TYPE )
IS
--
-- *************************************************************
-- * procedimiento      : P_VALIDA_SERIE_GSM
-- * Descripcisn        :
--                      Procedimiento inicial de recopilacion de parametros que arranca el proceso
--                      de validacion de series celulares
--
--                      Realiza llamadas a los siguientes procedimientos y/o funciones:
--                               - GE_FN_LUHN ; Funcisn que valida que el formato de la serie
--                                              en decimal para tecnologia GSM sea el correcto
--                               - P_VALIDA_REPETICION ; Valida que la serie no pertenezca al equipo
--                                                       de otro abonado celular
--                               - P_VALIDA_ROBADAS ; Valida que la serie no se encuentre catalogada
--                                                    como robada
-- * Fecha de creacisn  : Noviembre 2002
-- * Responsable        : CRM
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Serie correcta y convertida
--         - "1" ; Formato de serie incorrecta
--         - "2" ; Serie repetida
--         - "3" ; Serie robada
--         - "4" ; Error en el proceso
-- *************************************************************
--
    V_ERROR GA_TRANSACABO.NUM_TRANSACCION%TYPE := 0;
        V_SERIE_AUX  CHAR(14);
        V_DIGITO     CHAR(1);
        V_DIGITO_AUX CHAR(1);
        v_respuesta    CHAR (1)      := '0';
        TRANSAC GA_TRANSACABO.NUM_TRANSACCION%TYPE;
        V_SERIE_NEGATIVA BOOLEAN;


BEGIN

   V_ERROR := 0;

   V_SERIE_AUX := SUBSTR(V_SERIE, 1, (LENGTH(V_SERIE) - 1));
   V_DIGITO_AUX := SUBSTR(V_SERIE, LENGTH(V_SERIE), 1);
   v_respuesta  := Ge_Vluhn_Fn (v_serie);
   IF v_respuesta = '0' THEN
       v_error := '1';
   END IF;

   IF V_ERROR = '0' THEN
      ve_valida_repeticion_gsm_pr (v_serie, v_error);

      IF V_ERROR = '0' THEN
                 -- ini p-col-06054 y.o.
           --P_VALIDA_ROBADAS (V_SERIE,V_ERROR);

                               -- Inicio Modif. INC-60667 - Juan Gonzalez C. - 27/12/2007
                                --PV_SERIES_NEGATIVAS_PG.PV_SERIES_NEGATIVAS_PR(V_TRANSAC,V_SERIE,'S','0','0','PLVS');

                                --SELECT COD_RETORNO INTO V_ERROR FROM GA_TRANSACABO WHERE NUM_TRANSACCION = V_TRANSAC;
           --                     PV_CONSULTA_SERIENEGATIVAS_PG.PV_SERIES_NEGATIVAS_PR(V_SERIE,V_SERIE_NEGATIVA);
           --                     IF V_SERIE_NEGATIVA THEN
            --                            V_ERROR := 3;
            --                   ELSE
                                       V_ERROR := 0;
            --                    END IF;
                               -- Fin Modif. INC-60667 - Juan Gonzalez C. - 27/12/2007

             -- fin p-col-06054 y.o.
      END IF;
   END IF;

   INSERT INTO GA_TRANSACABO
   VALUES (V_TRANSAC,V_ERROR,NULL);
EXCEPTION
   WHEN OTHERS THEN
        V_ERROR := '4';
END; 
/
SHOW ERRORS
