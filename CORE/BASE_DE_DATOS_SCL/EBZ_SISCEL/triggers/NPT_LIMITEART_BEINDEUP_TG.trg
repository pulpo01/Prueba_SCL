CREATE OR REPLACE TRIGGER NPT_LIMITEART_BEINDEUP_TG
BEFORE DELETE  OR UPDATE
ON NPT_LIMITE_ARTICULO_TD 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    v_limite_reg_to         NPT_LIMITE_ARTICULO_TD%ROWTYPE;
    v_limite_usuario        NPT_LIMITE_ARTICULO_TD.COD_USUARIO%TYPE ;
    v_limite_articulo       NPT_LIMITE_ARTICULO_TD.COD_ARTICULO%TYPE ;
    v_limite_stock          NPT_LIMITE_ARTICULO_TD.TIP_STOCK%TYPE ;
    v_limite_uso            NPT_LIMITE_ARTICULO_TD.COD_USO%TYPE ;
    v_limite_cantidad       NPT_LIMITE_ARTICULO_TD.CANTIDAD%TYPE ;
    v_limite_creacion       NPT_LIMITE_ARTICULO_TD.USU_CREACION%TYPE ;
    v_limite_fec_creacion   NPT_LIMITE_ARTICULO_TD.FEC_CREACION%TYPE ;
    v_limite_accion         NPT_LIMITE_ARTICULO_TH.IND_ACCION%TYPE ;
    v_limite_fec_desde      NPT_LIMITE_ARTICULO_TD.FEC_DESDE%TYPE;  --CSR-11017 
    v_limite_fec_hasta      NPT_LIMITE_ARTICULO_TD.FEC_HASTA%TYPE;  --CSR-11017 
    
BEGIN

    IF :OLD.cod_usuario IS NOT NULL THEN 
    
        v_limite_usuario        :=  :OLD.cod_usuario;
        v_limite_articulo       :=  :OLD.cod_articulo;
        v_limite_stock          :=  :OLD.tip_stock;
        v_limite_uso            :=  :OLD.cod_uso;
        v_limite_cantidad       :=  :OLD.cantidad;
        v_limite_creacion       :=  :OLD.usu_creacion;
        v_limite_fec_creacion   :=  :OLD.fec_creacion;
        v_limite_accion         :=  NULL;                    
        v_limite_fec_desde      :=  :OLD.fec_desde;           --CSR-11017 
        v_limite_fec_hasta      :=  :OLD.fec_hasta;           --CSR-11017 

    ELSE 
        
        v_limite_usuario        :=  :NEW.cod_usuario;
        v_limite_articulo       :=  :NEW.cod_articulo;
        v_limite_stock          :=  :NEW.tip_stock;
        v_limite_uso            :=  :NEW.cod_uso;
        v_limite_cantidad       :=  :NEW.cantidad;
        v_limite_creacion       :=  :NEW.usu_creacion;
        v_limite_fec_creacion   :=  :NEW.fec_creacion;
        v_limite_accion         :=  NULL;
        v_limite_fec_desde      :=  :NEW.fec_desde;           --CSR-11017 
        v_limite_fec_hasta      :=  :NEW.fec_hasta;           --CSR-11017 

    END IF;

    IF  DELETING THEN
        v_limite_accion:='D';
 
    ELSIF UPDATING THEN
        v_limite_accion:='U'; 
    END IF;
 
   
     BEGIN
        INSERT INTO NPT_LIMITE_ARTICULO_TH
        (COD_USUARIO,
        COD_ARTICULO,
        TIP_STOCK,
        COD_USO,
        CANTIDAD,
        USU_CREACION,
        FEC_CREACION,
        IND_ACCION,
        FEC_DESDE,
        FEC_HASTA,
        FEC_MODIFICACION) 
        VALUES
        (   v_limite_usuario,
            v_limite_articulo,
            v_limite_stock,
            v_limite_uso,
            v_limite_cantidad,
            v_limite_creacion,
            v_limite_fec_creacion,
            v_limite_accion,
            v_limite_fec_desde,
            v_limite_fec_hasta,
            SYSDATE
        );
 
        EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003,'ERROR NPT_LIMITEART_BEINDEUP_TG : '||TO_CHAR(SQLCODE),TRUE);
    END;
END;
/
SHOW ERRORS