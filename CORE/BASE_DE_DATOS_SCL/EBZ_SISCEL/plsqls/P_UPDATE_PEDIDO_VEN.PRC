CREATE OR REPLACE PROCEDURE P_UPDATE_PEDIDO_VEN
(vp_cod_pedido               in  npt_pedido.cod_pedido%TYPE ,
 vp_con_vendedor   	     in  npt_pedido.cod_vendedor%TYPE
)

is

-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : P_UPDATE_PEDIDO_VEN
-- * Descripcion        : Procedimiento que actualiza el codigo del vendedor en caso de requerirse,
-- *                      aplicable a TMM.
-- * Fecha de creacion  : 31-07-2003
-- * Responsable        : Freddy Zavala G.
-- *************************************************************

BEGIN
  update npt_pedido
  set cod_vendedor = vp_con_vendedor
  where cod_pedido = vp_cod_pedido;

END;
/
SHOW ERRORS
