CREATE OR REPLACE TRIGGER AL_AUDIT_CABNUM_BEINDEUP_TG
BEFORE INSERT OR DELETE OR UPDATE
ON AL_CAB_NUMERACION
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE
 	v_audit_reg_to      AL_AUDIT_CAB_NUMERACION_TO%ROWTYPE;
	v_audit_username    AL_AUDIT_CAB_NUMERACION_TO.COD_USUARIO%TYPE ;
	v_audit_osuser      AL_AUDIT_CAB_NUMERACION_TO.COD_OSUSUARIO%TYPE ;
	v_audit_program     AL_AUDIT_CAB_NUMERACION_TO.DES_PROGRAM%TYPE ;
	v_audit_module      AL_AUDIT_CAB_NUMERACION_TO.DES_MODULO%TYPE ;
	v_audit_logon_time  AL_AUDIT_CAB_NUMERACION_TO.FEC_LOGIN%TYPE ;
BEGIN
    SELECT username, osuser, program, MODULE, logon_time
    INTO   v_audit_username,
		   v_audit_osuser,
		   v_audit_program,
		   v_audit_module,
		   v_audit_logon_time
    FROM   v$session
    WHERE  audsid = USERENV('sessionid');
	IF INSERTING THEN
		v_audit_reg_to.des_modulo        := v_audit_module;
		v_audit_reg_to.cod_usuario		 := v_audit_username;
		v_audit_reg_to.cod_osusuario	 := v_audit_osuser;
		v_audit_reg_to.des_program		 := v_audit_program;
		v_audit_reg_to.fec_login		 := v_audit_logon_time;
		v_audit_reg_to.num_numeracion    := :NEW.num_numeracion;
		v_audit_reg_to.cod_estado_ori    := NULL;
		v_audit_reg_to.cod_estado_des    := :NEW.cod_estado;
		v_audit_reg_to.cod_operacion     := 'I';
		v_audit_reg_to.fec_operacion	 := SYSDATE;

    ELSIF DELETING THEN
		v_audit_reg_to.des_modulo        := v_audit_module;
		v_audit_reg_to.cod_usuario		 := v_audit_username;
		v_audit_reg_to.cod_osusuario	 := v_audit_osuser;
		v_audit_reg_to.des_program		 := v_audit_program;
		v_audit_reg_to.fec_login		 := v_audit_logon_time;
		v_audit_reg_to.num_numeracion    := :OLD.num_numeracion;
		v_audit_reg_to.cod_estado_ori    := :OLD.cod_estado;
		v_audit_reg_to.cod_estado_des    := NULL;
		v_audit_reg_to.cod_operacion     := 'D';
		v_audit_reg_to.fec_operacion	 := SYSDATE;

	ELSIF UPDATING THEN
		v_audit_reg_to.des_modulo        := v_audit_module;
		v_audit_reg_to.cod_usuario		 := v_audit_username;
		v_audit_reg_to.cod_osusuario	 := v_audit_osuser;
		v_audit_reg_to.des_program		 := v_audit_program;
		v_audit_reg_to.fec_login		 := v_audit_logon_time;
		v_audit_reg_to.num_numeracion    := :OLD.num_numeracion;
		v_audit_reg_to.cod_estado_ori    := :OLD.cod_estado;
		v_audit_reg_to.cod_estado_des    := :NEW.cod_estado;
		v_audit_reg_to.cod_operacion     := 'U';
		v_audit_reg_to.fec_operacion	 := SYSDATE;

    END IF;

	BEGIN
        INSERT INTO AL_AUDIT_CAB_NUMERACION_TO
		(DES_MODULO,
		COD_USUARIO,
		COD_OSUSUARIO,
		DES_PROGRAM,
		FEC_LOGIN,
		NUM_NUMERACION,
		COD_ESTADO_ORI,
		COD_ESTADO_DES,
		COD_OPERACION,
		FEC_OPERACION
		)
        VALUES
		(v_audit_reg_to.des_modulo,
		v_audit_reg_to.cod_usuario,
		v_audit_reg_to.cod_osusuario,
		v_audit_reg_to.des_program,
		v_audit_reg_to.fec_login,
		v_audit_reg_to.num_numeracion,
		v_audit_reg_to.cod_estado_ori,
		v_audit_reg_to.cod_estado_des,
		v_audit_reg_to.cod_operacion,
		v_audit_reg_to.fec_operacion
		);

        EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003,'ERROR AL_AUDIT_CABNUM_BEINDEUP_TG : '||TO_CHAR(SQLCODE),TRUE);
	END;

END;
/
SHOW ERRORS
