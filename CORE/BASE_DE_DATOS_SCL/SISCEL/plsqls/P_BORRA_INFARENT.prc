CREATE OR REPLACE PROCEDURE        P_BORRA_INFARENT(
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
-- con facturacion
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; El borrado se ha realizado correctamente
--         - "4" ; Error en el proceso
--
BEGIN
   VP_PROC := 'P_BORRA_INTARENT';
   VP_TABLA := 'GA_INFACRENT';
   VP_ACT := 'D';
   DELETE GA_INFACRENT WHERE NUM_ALQUILER = VP_ALQUILER
     AND NUM_ABONADO = VP_ABONADO;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
