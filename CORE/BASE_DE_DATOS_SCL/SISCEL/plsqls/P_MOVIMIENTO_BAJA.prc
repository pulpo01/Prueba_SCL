CREATE OR REPLACE PROCEDURE        P_MOVIMIENTO_BAJA(
  VP_ALQUILER IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_OPER IN NUMBER ,
  VP_MOVBAJA IN NUMBER ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de actualizacion de la fecha de activacion de los
-- movimientos de baja de abonados Rent a Phone
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; El cambio se ha realizado correctamente
--         - "4" ; Error en el proceso
--
  V_FECHA ICC_MOVIMIENTO.FEC_INGRESO%TYPE;
  V_ROWID CHAR(18);
  V_MOVPOS ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
BEGIN
    VP_PROC := 'P_MOVIMIENTO_BAJA';
    VP_TABLA := 'ICC_MOVIMIENTO';
    VP_ACT := 'S';
    SELECT ROWID,NUM_MOVPOS
      INTO V_ROWID,V_MOVPOS
      FROM ICC_MOVIMIENTO
     WHERE NUM_MOVIMIENTO = VP_MOVBAJA;
    IF VP_OPER = 0 THEN
       VP_TABLA := 'GA_PERABORENT';
       VP_ACT := 'S';
       SELECT MAX(FEC_BAJA)
  INTO V_FECHA
  FROM GA_PERABORENT
        WHERE NUM_ABONADO = VP_ABONADO;
       IF V_FECHA IS NOT NULL THEN
   VP_TABLA := 'ICC_MOVIMIENTO';
   VP_ACT := 'U';
   UPDATE ICC_MOVIMIENTO
      SET FEC_INGRESO = V_FECHA
           WHERE ROWID = V_ROWID;
          IF V_MOVPOS IS NOT NULL THEN
      VP_TABLA := 'ICC_MOVIMIENTO';
      VP_ACT := 'U';
             UPDATE ICC_MOVIMIENTO
  SET FEC_INGRESO = V_FECHA
              WHERE NUM_MOVIMIENTO = V_MOVPOS;
          END IF;
       ELSE
   VP_TABLA := 'ICC_MOVIMIENTO';
   VP_ACT := 'U';
   UPDATE ICC_MOVIMIENTO
      SET COD_ESTADO = 10
           WHERE ROWID = V_ROWID;
          IF V_MOVPOS IS NOT NULL THEN
      VP_TABLA := 'ICC_MOVIMIENTO';
      VP_ACT := 'U';
             UPDATE ICC_MOVIMIENTO
  SET COD_ESTADO = 10
              WHERE NUM_MOVIMIENTO = V_MOVPOS;
          END IF;
       END IF;
    ELSE
       VP_TABLA := 'GA_PERABORENT';
       VP_ACT := 'U';
       SELECT FEC_BAJA
  INTO V_FECHA
  FROM GA_PERABORENT
        WHERE NUM_ALQUILER = VP_ALQUILER
   AND NUM_ABONADO = VP_ABONADO;
       VP_TABLA := 'ICC_MOVIMIENTO';
       VP_ACT := 'U';
       UPDATE ICC_MOVIMIENTO
   SET FEC_INGRESO = V_FECHA
 WHERE ROWID = V_ROWID;
       IF V_MOVPOS IS NOT NULL THEN
          UPDATE ICC_MOVIMIENTO
      SET FEC_INGRESO = V_FECHA
           WHERE NUM_MOVIMIENTO = V_MOVPOS;
       END IF;
    END IF;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
