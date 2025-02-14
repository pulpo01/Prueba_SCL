CREATE OR REPLACE FUNCTION Ca_Fn_Valida_Estado_Pedido (cod_serie VARCHAR2) RETURN NUMBER IS
v_Est_Pedido   NUMBER;
-- PL/SQL Specification
--
-- *************************************************************
-- * Funcion            : CA_FN_VALIDA_ESTADO_PEDIDO
-- * Salida             : 0- Pedido no se encuentra recepcionado por el Dealer
-- *                      1- Pedido se encuentra recepcionado por el Dealer
-- * Descripcion        : Funcion que chequea el estado del pedido
-- * Fecha de creacion  : Marzo 2003
-- * Responsable        : Rodrigo Araneda B.
-- *************************************************************
BEGIN
			SELECT SUM(cant) INTO v_Est_Pedido
			FROM (
			SELECT COUNT(1) AS cant
			FROM npt_estado_pedido a, npt_serie_pedido b, AL_COMPONENTE_KIT c
			WHERE b.cod_serie_pedido = c.num_kit
			AND    c.num_serie = cod_serie
			AND    a.cod_pedido = b.cod_pedido
			AND    a.cod_estado_flujo IN ( 14,83)
			UNION
			SELECT COUNT(1) AS cant
			FROM npt_estado_pedido a, npt_serie_pedido b
			WHERE b.cod_serie_pedido = cod_serie
			AND    a.cod_pedido = b.cod_pedido
			AND    a.cod_estado_flujo IN ( 14,83));

--*********************************************************
RETURN v_Est_Pedido;
--*********************************************************
EXCEPTION

   WHEN VALUE_ERROR THEN
   RETURN -1;

   WHEN INVALID_NUMBER THEN
   RETURN -1;

   WHEN OTHERS THEN
   RETURN -1;
END;
/
SHOW ERRORS
