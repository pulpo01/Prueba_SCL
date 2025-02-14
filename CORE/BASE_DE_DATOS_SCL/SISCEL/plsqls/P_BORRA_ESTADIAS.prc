CREATE OR REPLACE PROCEDURE        P_BORRA_ESTADIAS(
  VP_ESTADIA IN NUMBER ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de borrado de estadias en tablas interfase tarificacion
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; El cambio se ha realizado correctamente
--         - "4" ; Error en el proceso
--
BEGIN
   DELETE GA_INTAROACOM WHERE NUM_ESTADIA = VP_ESTADIA;
EXCEPTION
   WHEN OTHERS THEN
        VP_ERROR := '4';
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
END;
/
SHOW ERRORS
