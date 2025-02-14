CREATE OR REPLACE PROCEDURE AL_CONTROL_PASOTRASVEN_PR
(v_cod_pedido IN npt_pedido.cod_pedido%TYPE,
v_des_cadena IN VARCHAR2,
v_num_seq_proc IN al_control_trasven_to.num_seq_proc%TYPE) IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   INSERT INTO AL_CONTROL_TRASVEN_TO
   (COD_PEDIDO,
   DES_CADENA,
   FEC_PROCESO,
   NUM_SEQ_PROC)
   VALUES
   (v_cod_pedido,
   v_des_cadena,
   SYSDATE,
   v_num_seq_proc);

   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR (-20712,
      'Error Insert en AL_CONTROL_TRASVEN_TO ' || TO_CHAR(SQLCODE));
END;
/
SHOW ERRORS
