CREATE OR REPLACE PROCEDURE        P_AL_CONS_REGALO
( VP_COD_ARTICULO IN AL_ARTICULOS.COD_ARTICULO%TYPE,
    VP_ERR IN OUT NUMBER ) is
BEGIN
-- PL para verificacion de modo de venta por articulo
-- Los equipos en siscel no se venden en modalidad de venta regalo
-- Los Accesorios si admiten modalidad de venta regalo
-- Entrada :  Codigo articulo
-- Devuelve : VP_ERR  0   El articulo admite modalidad de venta regalo
--            1   Error , El articulo no admite modalidad de venta regalo
--            SQL_ERR Error Oracle
VP_ERR := 1;
SELECT DECODE(IND_EQUIACC, 'E', 1, 'A', 0, 1)
  INTO VP_ERR FROM AL_ARTICULOS WHERE
  COD_ARTICULO = VP_COD_ARTICULO;
EXCEPTION
  when OTHERS then
      VP_ERR:= SQLCODE;
        raise;
END;
/
SHOW ERRORS
