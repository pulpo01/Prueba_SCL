CREATE OR REPLACE TRIGGER AL_AUDIT_CELNUMREUT_BEUP_TG
BEFORE UPDATE
ON AL_CELNUM_REUTIL
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
     v_audit_ser_to      al_audit_celnum_reutil_to%rowtype;

begin

        v_audit_ser_to.nom_tabla         := 'AL_CELNUM_REUTIL';
        v_audit_ser_to.cod_operacion     := 'U';
        v_audit_ser_to.fec_operacion     := systimestamp;
        v_audit_ser_to.num_celular_old   := :old.num_celular;
        v_audit_ser_to.cod_subalm_old    := :old.cod_subalm;
        v_audit_ser_to.cod_producto_old  := :old.cod_producto;
        v_audit_ser_to.cod_central_old   := :old.cod_central;
        v_audit_ser_to.cod_cat_old       := :old.cod_cat;
        v_audit_ser_to.cod_uso_old       := :old.cod_uso;
        v_audit_ser_to.fec_baja_old      := :old.fec_baja;
        v_audit_ser_to.ind_equipado_old  := :old.ind_equipado;
        v_audit_ser_to.num_proceso_old  := :old.num_proceso; 
        v_audit_ser_to.num_celular   := :new.num_celular;
        v_audit_ser_to.cod_subalm    := :new.cod_subalm;
        v_audit_ser_to.cod_producto  := :new.cod_producto;
        v_audit_ser_to.cod_central   := :new.cod_central;
        v_audit_ser_to.cod_cat       := :new.cod_cat;
        v_audit_ser_to.cod_uso       := :new.cod_uso;
        v_audit_ser_to.fec_baja      := :new.fec_baja;
        v_audit_ser_to.ind_equipado  := :new.ind_equipado;
        v_audit_ser_to.num_proceso  := :new.num_proceso;  
     BEGIN

    AL_PAC_NUMERACION.p_audit_insert_celnumreutil (v_audit_ser_to);
 
        EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003,'ERROR TRIGGER GA_AUDIT_CELNUMREUT_BEUP_TG : '|| 'ERROR'||' ORA'||TO_CHAR(SQLCODE),TRUE);
    END;

END;
/

