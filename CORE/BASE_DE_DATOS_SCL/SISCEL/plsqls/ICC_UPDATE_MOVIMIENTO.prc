CREATE OR REPLACE PROCEDURE ICC_UPDATE_MOVIMIENTO(lNumMov IN number) IS

sErr varchar2(50):=NULL;

BEGIN

   UPDATE
   	    icc_movimiento
   SET
   			cod_estado = 0,
   	    fec_ejecucion=SYSDATE,
   	    des_respuesta = 'OK'
   WHERE
   			num_movimiento = lNumMov;


EXCEPTION
WHEN OTHERS THEN
   ROLLBACK;

   sErr := 'ERROR TRIGGER ICC_BEUP_MOVIMIENTO:  ORA'||TO_CHAR(SQLCODE);

   UPDATE
   			icc_movimiento
   SET
   			cod_estado = 14,
   	    fec_ejecucion=SYSDATE,
        des_respuesta = sErr
   WHERE
   			num_movimiento = lNumMov;

   COMMIT;

   RAISE_APPLICATION_ERROR(-20002,'Error',TRUE);

END;
/
SHOW ERRORS
