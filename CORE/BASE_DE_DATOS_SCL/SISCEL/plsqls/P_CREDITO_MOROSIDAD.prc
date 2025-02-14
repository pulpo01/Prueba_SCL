CREATE OR REPLACE PROCEDURE        P_CREDITO_MOROSIDAD(
  VP_ABONADO IN NUMBER ,
  VP_CREDMOR IN NUMBER ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que refleja el credito de morosidad en la tabla de abonados
-- facturables (FA_CICLOCLI)
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
BEGIN
   VP_PROC := 'P_CREDITO_MOROSIDAD';
   VP_TABLA := 'FA_CICLOCLI';
   VP_ACT := 'U';
   UPDATE FA_CICLOCLI
      SET COD_CREDMOR = VP_CREDMOR
    WHERE NUM_ABONADO = VP_ABONADO;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
