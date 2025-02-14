CREATE OR REPLACE PROCEDURE        P_FACTURA_ROABAJA(
  VP_ESTADIA IN NUMBER ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que actualiza el estado de los abonados roaming visitantes
-- al facturarles x baja
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
BEGIN
   VP_PROC := 'P_FACTURA_ROABAJA';
   VP_TABLA := 'GA_ABOROAVIS';
   VP_ACT := 'U';
   UPDATE GA_ABOROAVIS
      SET COD_SITUACION = 'BAA'
    WHERE NUM_ESTADIA = VP_ESTADIA;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
