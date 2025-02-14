CREATE OR REPLACE TRIGGER AL_AUDIT_GACELNUMUSO_BEINUP_TG
BEFORE INSERT OR UPDATE
ON ga_celnum_uso
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
    v_audit_ser_to     al_audit_celnum_uso_to%rowtype;

begin

if inserting then

        v_audit_ser_to.num_desde         := :new.num_desde;
        v_audit_ser_to.num_hasta         := :new.num_hasta;
        v_audit_ser_to.num_libres_ori    :=  null;
        v_audit_ser_to.num_siguiente_ori :=  null;
        v_audit_ser_to.num_libres_des    := :new.num_libres;
        v_audit_ser_to.num_siguiente_des := :new.num_siguiente;
        v_audit_ser_to.cod_operacion     := 'I';
        v_audit_ser_to.fec_operacion     := systimestamp;
        v_audit_ser_to.cod_subalm        := :new.cod_subalm;
        v_audit_ser_to.cod_producto      := :new.cod_producto;
        v_audit_ser_to.cod_central       := :new.cod_central ;
        v_audit_ser_to.cod_cat           := :new.cod_cat; 
        v_audit_ser_to.cod_uso           := :new.cod_uso;
        v_audit_ser_to.ind_contaminado   := :new.ind_contaminado;
        v_audit_ser_to.cod_subalm_old    := :old.cod_subalm;
        v_audit_ser_to.cod_producto_old  := :old.cod_producto;
        v_audit_ser_to.cod_central_old   := :old.cod_central ;
        v_audit_ser_to.cod_cat_old           := :old.cod_cat; 
        v_audit_ser_to.cod_uso_old           := :old.cod_uso;
        v_audit_ser_to.ind_contaminado_old   := :old.ind_contaminado;  
    elsif updating then

        v_audit_ser_to.num_desde         := :old.num_desde;
        v_audit_ser_to.num_hasta         := :old.num_hasta;
        v_audit_ser_to.num_libres_ori    := :old.num_libres;
        v_audit_ser_to.num_siguiente_ori := :old.num_siguiente;
        v_audit_ser_to.num_libres_des    := :new.num_libres;
        v_audit_ser_to.num_siguiente_des := :new.num_siguiente;
        v_audit_ser_to.cod_operacion     := 'U';
        v_audit_ser_to.fec_operacion     := systimestamp;
        v_audit_ser_to.cod_subalm        := :new.cod_subalm;
        v_audit_ser_to.cod_producto      := :new.cod_producto;
        v_audit_ser_to.cod_central       := :new.cod_central; 
        v_audit_ser_to.cod_cat           := :new.cod_cat; 
        v_audit_ser_to.cod_uso           := :new.cod_uso;
        v_audit_ser_to.ind_contaminado   := :new.ind_contaminado;
        v_audit_ser_to.cod_subalm_old        := :old.cod_subalm;
        v_audit_ser_to.cod_producto_old      := :old.cod_producto;
        v_audit_ser_to.cod_central_old       := :old.cod_central ;
        v_audit_ser_to.cod_cat_old           := :old.cod_cat; 
        v_audit_ser_to.cod_uso_old           := :old.cod_uso;
        v_audit_ser_to.ind_contaminado_old   := :old.ind_contaminado;           
    end if;
     BEGIN

      AL_PAC_NUMERACION.p_audit_insert_celnumuso (v_audit_ser_to);  

        EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003,'ERROR TRIGGER AL_AUDIT_GACELLNUM_USO_TG : '|| 'ERROR'||' ORA'||TO_CHAR(SQLCODE),TRUE);
    END;

END;
/

