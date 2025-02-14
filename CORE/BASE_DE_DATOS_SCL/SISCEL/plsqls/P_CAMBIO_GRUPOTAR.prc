CREATE OR REPLACE PROCEDURE        P_CAMBIO_GRUPOTAR(
  VP_PRODUCTO IN NUMBER ,
  VP_TIPPLAN IN VARCHAR2 ,
  VP_EMPRESA IN NUMBER ,
  VP_HOLDING IN NUMBER ,
  VP_OPERADOR IN VARCHAR2 ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de actualizacion de datos de holdings
-- afectados por transacciones del modulo.
--
-- Los valores del codigo de retorno (VP_ERROR), seran los siguientes :
--         - "0" ; Los holdings han sido actualizados correctamente
--         - "4" ; Error en el proceso interno
--
BEGIN
    VP_PROC := 'P_CAMBIO_GRUPOTAR';
    IF VP_TIPPLAN = 'H' THEN
       VP_TABLA := 'GA_HOLDING';
       VP_ACT := 'U';
       UPDATE GA_HOLDING
          SET NUM_ABONADOS = NUM_ABONADOS + (DECODE(VP_OPERADOR,'1',1,-1))
        WHERE COD_PRODUCTO = VP_PRODUCTO
          AND COD_HOLDING  = VP_HOLDING;
    ELSE
       VP_TABLA := 'GA_EMPRESA';
       VP_ACT := 'U';
       UPDATE GA_EMPRESA
          SET NUM_ABONADOS = NUM_ABONADOS + (DECODE(VP_OPERADOR,'1',1,-1))
        WHERE COD_PRODUCTO = VP_PRODUCTO
          AND COD_EMPRESA  = VP_EMPRESA;
    END IF;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
