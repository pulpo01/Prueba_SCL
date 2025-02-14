CREATE OR REPLACE PROCEDURE        P_BORRA_INTARENT(
  VP_ALQUILER IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de borrado de tabla de interfase de abonados rent a phone
-- con tarificacion
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; El borrado se ha realizado correctamente
--         - "4" ; Error en el proceso
--
BEGIN
   dbms_output.put_line ('entra a borra intarent');
   VP_PROC := 'P_BORRA_INTARENT';
   VP_TABLA := 'GA_INTARENT';
   VP_ACT := 'D';
   DELETE GA_INTARENT WHERE NUM_ALQUILER = VP_ALQUILER
   AND NUM_ABONADO = VP_ABONADO;
   dbms_output.put_line ('sale de borra intarent');
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
