CREATE OR REPLACE PACKAGE        AL_PRO_ALARMA IS
  --
  -- Retrofitted
  PROCEDURE p_alarma_minmax(
  v_minmax IN al_minimos_maximos%rowtype )
;
  --
  -- Retrofitted
  PROCEDURE p_alarma_stock(
  v_stock IN al_stock%rowtype )
;
  --
  -- Retrofitted
  PROCEDURE p_select_numero(
  v_numero IN OUT al_alarmas_stock.num_alarma%type )
;
  --
  -- Retrofitted
  PROCEDURE p_lee_minmax(
  v_stock IN al_stock%rowtype ,
  v_can_minima IN OUT al_minimos_maximos.can_minima%type )
;
  --
  -- Retrofitted
  PROCEDURE p_lee_stock(
  v_minmax IN al_minimos_maximos%rowtype ,
  v_can_stock IN OUT al_stock.can_stock%type )
;
  --
  -- Retrofitted
  PROCEDURE p_crea_alarma(
  v_alarma  al_alarmas_stock%rowtype )
;
--
   exception_alarma exception;
--
-----------------
END AL_PRO_ALARMA;
/
SHOW ERRORS
