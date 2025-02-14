CREATE OR REPLACE TRIGGER AL_AUDIT_CELNUMREUT_BEINDE_TG
BEFORE INSERT OR DELETE
ON AL_CELNUM_REUTIL
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
     v_audit_ser_to      al_audit_celnum_reutil_to%rowtype;

begin

    if inserting then
        v_audit_ser_to.nom_tabla         := 'AL_CELNUM_REUTIL';
        v_audit_ser_to.cod_operacion     := 'I';
        v_audit_ser_to.fec_operacion     := sysdate;
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
    elsif deleting then
         v_audit_ser_to.nom_tabla         := 'AL_CELNUM_REUTIL';
        v_audit_ser_to.cod_operacion     := 'D';
        v_audit_ser_to.fec_operacion     := sysdate;
        v_audit_ser_to.num_celular_old   := :old.num_celular;
        v_audit_ser_to.cod_subalm_old    := :old.cod_subalm;
        v_audit_ser_to.cod_producto_old  := :old.cod_producto;
        v_audit_ser_to.cod_central_old   := :old.cod_central;
        v_audit_ser_to.cod_cat_old       := :old.cod_cat;
        v_audit_ser_to.cod_uso_old       := :old.cod_uso;
        v_audit_ser_to.fec_baja_old      := :old.fec_baja;
        v_audit_ser_to.ind_equipado_old  := :old.ind_equipado;
        v_audit_ser_to.num_proceso_old  := :old.num_proceso;
        v_audit_ser_to.num_celular   := :old.num_celular;
        v_audit_ser_to.cod_subalm    := :old.cod_subalm;
        v_audit_ser_to.cod_producto  := :old.cod_producto;
        v_audit_ser_to.cod_central   := :old.cod_central;
        v_audit_ser_to.cod_cat       := :old.cod_cat;
        v_audit_ser_to.cod_uso       := :old.cod_uso;
        v_audit_ser_to.fec_baja      := :old.fec_baja;
        v_audit_ser_to.ind_equipado  := :old.ind_equipado;
        v_audit_ser_to.num_proceso  := :old.num_proceso; 
    end if;
     BEGIN
        
        AL_PAC_NUMERACION.p_audit_insert_celnumreutil (v_audit_ser_to);
          
        EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003,'ERROR TRIGGER AL_AUDIT_GACELLNUM_REUTIL_TG : '|| 'ERROR'||' ORA'||TO_CHAR(SQLCODE),TRUE);
    END;

END;
/

