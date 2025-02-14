CREATE OR REPLACE TRIGGER NPT_AUDIT_PRECIOS_TG
BEFORE INSERT OR DELETE OR UPDATE
ON EBZ_SISCEL.npt_precio_articulo REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
    v_audit_reg_to      npt_audit_precio_th%rowtype;
    v_audit_username    npt_audit_precio_th.cod_usuario%type ;
    v_audit_osuser      npt_audit_precio_th.cod_osusuario%type ;
    v_audit_program     npt_audit_precio_th.des_program%type ;
    v_audit_module      npt_audit_precio_th.des_modulo%type ;
    v_audit_logon_time  npt_audit_precio_th.fec_login%type ;
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
        v_audit_reg_to.cod_articulo             := :NEW.cod_articulo;
        v_audit_reg_to.tip_stock                := :NEW.tip_stock;
        v_audit_reg_to.cod_uso                  := :NEW.cod_uso;
        v_audit_reg_to.mto_pre_articulo         := :NEW.mto_pre_articulo;
        v_audit_reg_to.cod_operacion            := 'I';
    ELSIF DELETING THEN        
        v_audit_reg_to.cod_articulo             := :OLD.cod_articulo;
        v_audit_reg_to.tip_stock                := :OLD.tip_stock;
        v_audit_reg_to.cod_uso                  := :OLD.cod_uso;
        v_audit_reg_to.mto_pre_articulo         := :OLD.mto_pre_articulo;
        v_audit_reg_to.cod_operacion            := 'D';

    ELSIF UPDATING THEN        
        v_audit_reg_to.cod_articulo             := :NEW.cod_articulo;
        v_audit_reg_to.tip_stock                := :NEW.tip_stock;
        v_audit_reg_to.cod_uso                  := :NEW.cod_uso;
        v_audit_reg_to.mto_pre_articulo         := :NEW.mto_pre_articulo;
        v_audit_reg_to.cod_operacion            := 'U';

    END IF;

    BEGIN
        INSERT INTO npt_audit_precio_th
        (des_modulo,
        cod_usuario,
        cod_osusuario,
        des_program,
        fec_login,        
        cod_articulo,
        tip_stock,
        cod_uso,
        mto_pre_articulo,   
        cod_operacion,
        fec_operacion
        )
        VALUES
        (v_audit_reg_to.des_modulo,
        v_audit_reg_to.cod_usuario,
        v_audit_reg_to.cod_osusuario,
        v_audit_reg_to.des_program,
        v_audit_reg_to.fec_login,                
        v_audit_reg_to.cod_articulo,
        v_audit_reg_to.tip_stock,
        v_audit_reg_to.cod_uso,
        v_audit_reg_to.mto_pre_articulo,
        v_audit_reg_to.cod_operacion,
        v_audit_reg_to.fec_operacion
        );


        EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003,'ERROR NPT_AUDIT_PRECIOS_TG : '||TO_CHAR(SQLCODE),TRUE);
    END;

END;
/
SHOW ERRORS