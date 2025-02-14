CREATE OR REPLACE PROCEDURE        P_ACTUALIZA_CAM_CICLOCLI
(
  VP_CLIENTE IN NUMBER ,
  VP_CICLO IN NUMBER ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de actualizacion de tabla de abonados a facturar en ciclo
-- a un nuevo ciclo
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; El cambio se ha realizado correctamente
--         - "4" ; Error en el proceso
--
IND_VALOR NUMBER;
BEGIN
    VP_PROC := 'P_ACTUALIZA_CICLOCLI';
    VP_TABLA := 'FA_CICLOCLI';
    VP_ACT := 'U';
    IND_VALOR := 1;
    UPDATE FA_CICLOCLI
    SET IND_CAMBIO = IND_VALOR,COD_CICLONUE = VP_CICLO
    WHERE COD_CLIENTE = VP_CLIENTE;
EXCEPTION
   WHEN OTHERS THEN
        VP_SQLCODE := SQLCODE;
        VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
