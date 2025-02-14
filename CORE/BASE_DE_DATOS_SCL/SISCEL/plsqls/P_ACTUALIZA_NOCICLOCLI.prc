CREATE OR REPLACE PROCEDURE        P_ACTUALIZA_NOCICLOCLI(
  VP_ABONADO IN NUMBER ,
  VP_CICLO IN NUMBER ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de actualizacion de tabla de abonados no facturables
-- a un nuevo ciclo
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; El cambio se ha realizado correctamente
--         - "4" ; Error en el proceso
--
BEGIN
    VP_PROC := 'P_ACTUALIZA_NOCICLOCLI';
    VP_TABLA := 'FA_CICLOCLINOFAC';
    VP_ACT := 'U';
    UPDATE FA_CICLOCLINOFAC
       SET IND_CAMBIO = 1,
    COD_CICLONUE = VP_CICLO
     WHERE NUM_ABONADO = VP_ABONADO;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
