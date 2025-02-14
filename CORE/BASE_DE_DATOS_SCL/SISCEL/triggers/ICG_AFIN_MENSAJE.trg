CREATE OR REPLACE TRIGGER ICG_AFIN_MENSAJE
AFTER INSERT
ON ICG_MENSAJE
FOR EACH ROW

DECLARE
   V_TABLA VARCHAR2(35):=NULL;
   v_cod_men icg_mensaje.cod_mensaje%type;
   v_des_men icg_mensaje.des_mensaje%type;
BEGIN
  V_TABLA := 'IC_PR_MULTIIDIOMA_MENSAJES';
  v_cod_men := :new.cod_mensaje;
  v_des_men := :new.des_mensaje;
  BEGIN
    ic_pr_multiidioma_mensajes(v_cod_men, v_des_men);
  END;
  EXCEPTION
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20010,'ERROR TRIGGER ICG_AFIN_MENSAJE: '||V_TABLA||' ORA'||TO_CHAR(SQLCODE),TRUE);
END;
/
SHOW ERRORS
