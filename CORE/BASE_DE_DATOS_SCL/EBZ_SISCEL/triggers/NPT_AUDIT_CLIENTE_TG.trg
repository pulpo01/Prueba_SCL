CREATE OR REPLACE TRIGGER NPT_AUDIT_CLIENTES_TG
BEFORE INSERT OR DELETE OR UPDATE
ON EBZ_SISCEL.npt_usuario_cliente REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
    v_audit_reg_to      npt_audit_cliente_th%rowtype;
    v_audit_username    npt_audit_cliente_th.cod_usuario%type ;
    v_audit_osuser      npt_audit_cliente_th.cod_osusuario%type ;
    v_audit_program     npt_audit_cliente_th.des_program%type ;
    v_audit_module      npt_audit_cliente_th.des_modulo%type ;
    v_audit_logon_time  npt_audit_cliente_th.fec_login%type ;
BEGIN
--
    SELECT username, osuser, program, MODULE, logon_time
    INTO   v_audit_username,
           v_audit_osuser,
           v_audit_program,
           v_audit_module,
           v_audit_logon_time
    FROM   v$session
    WHERE  audsid = USERENV('sessionid');
--
        v_audit_reg_to.des_modulo        := v_audit_module; 
        v_audit_reg_to.cod_usuario       := v_audit_username;
        v_audit_reg_to.cod_osusuario     := v_audit_osuser;
        v_audit_reg_to.des_program       := v_audit_program;
        v_audit_reg_to.fec_login         := v_audit_logon_time;
        v_audit_reg_to.fec_operacion     := SYSDATE;
        --    
    IF INSERTING THEN        
        v_audit_reg_to.cod_cliente          := :NEW.cod_cliente;
        v_audit_reg_to.cod_usuarionpw       := :NEW.cod_usuario;
        v_audit_reg_to.ptj_equ_usu_cliente  := :NEW.ptj_equ_usu_cliente;
        v_audit_reg_to.ptj_acc_usu_cliente  := :NEW.ptj_acc_usu_cliente;
        v_audit_reg_to.num_dias             := :NEW.num_dias;
        v_audit_reg_to.cod_operacion        := 'I';
    ELSIF DELETING THEN        
        v_audit_reg_to.cod_cliente          := :OLD.cod_cliente;
        v_audit_reg_to.cod_usuarionpw       := :OLD.cod_usuario;
        v_audit_reg_to.ptj_equ_usu_cliente  := :OLD.ptj_equ_usu_cliente;
        v_audit_reg_to.ptj_acc_usu_cliente  := :OLD.ptj_acc_usu_cliente;
        v_audit_reg_to.num_dias             := :OLD.num_dias;
        v_audit_reg_to.cod_operacion        := 'D';

    ELSIF UPDATING THEN        
        v_audit_reg_to.cod_cliente          := :NEW.cod_cliente;
        v_audit_reg_to.cod_usuarionpw       := :NEW.cod_usuario;
        v_audit_reg_to.ptj_equ_usu_cliente  := :NEW.ptj_equ_usu_cliente;
        v_audit_reg_to.ptj_acc_usu_cliente  := :NEW.ptj_acc_usu_cliente;
        v_audit_reg_to.num_dias             := :NEW.num_dias;
        v_audit_reg_to.cod_operacion        := 'U';

    END IF;

    BEGIN
        INSERT INTO npt_audit_cliente_th
        (des_modulo,
        cod_usuario,
        cod_osusuario,
        des_program,
        fec_login,        
        cod_cliente,
        cod_usuarionpw,
        ptj_equ_usu_cliente,
        ptj_acc_usu_cliente,
        num_dias,   
        cod_operacion,
        fec_operacion
        )
        VALUES
        (v_audit_reg_to.des_modulo,
        v_audit_reg_to.cod_usuario,
        v_audit_reg_to.cod_osusuario,
        v_audit_reg_to.des_program,
        v_audit_reg_to.fec_login,                
        v_audit_reg_to.cod_cliente,
        v_audit_reg_to.cod_usuarionpw,
        v_audit_reg_to.ptj_equ_usu_cliente,
        v_audit_reg_to.ptj_acc_usu_cliente,
        v_audit_reg_to.num_dias,
        v_audit_reg_to.cod_operacion,
        v_audit_reg_to.fec_operacion
        );

        EXCEPTION WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20003,'NPT_AUDIT_CLIENTES_TG : '||TO_CHAR(SQLCODE),TRUE);
    END;

END;
/
SHOW ERRORS