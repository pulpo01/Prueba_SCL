CREATE OR REPLACE TRIGGER AL_LIMITEART_BEINDEUP_TG
BEFORE DELETE  OR UPDATE
ON AL_LIMITE_ARTICULO_TD 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    v_limite_reg_to         AL_LIMITE_ARTICULO_TD%ROWTYPE;
    v_limite_bodega         AL_LIMITE_ARTICULO_TD.COD_BODEGA%TYPE ;
    v_limite_articulo       AL_LIMITE_ARTICULO_TD.COD_ARTICULO%TYPE ;
    v_limite_stock          AL_LIMITE_ARTICULO_TD.TIP_STOCK%TYPE ;
    v_limite_uso            AL_LIMITE_ARTICULO_TD.COD_USO%TYPE ;
    v_limite_cantidad       AL_LIMITE_ARTICULO_TD.CANTIDAD%TYPE ;
    v_limite_creacion       AL_LIMITE_ARTICULO_TD.USU_CREACION%TYPE ;
    v_limite_fec_creacion   AL_LIMITE_ARTICULO_TD.FEC_CREACION%TYPE ;
    v_limite_accion         AL_LIMITE_ARTICULO_TH.IND_ACCION%TYPE ;
    v_limite_fec_desde      AL_LIMITE_ARTICULO_TD.FEC_DESDE%TYPE;  --CSR-11017 
    v_limite_fec_hasta      AL_LIMITE_ARTICULO_TD.FEC_HASTA%TYPE;  --CSR-11017 
    
BEGIN

    IF :OLD.cod_bodega IS NOT NULL THEN 
    
        v_limite_bodega         :=  :OLD.cod_bodega;
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
        
        v_limite_bodega         :=  :NEW.cod_bodega;
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
        INSERT INTO AL_LIMITE_ARTICULO_TH
        (COD_BODEGA,
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
        (   v_limite_bodega,
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
        RAISE_APPLICATION_ERROR(-20003,'ERROR AL_LIMITEART_BEINDEUP_TG : '||TO_CHAR(SQLCODE),TRUE);
    END;
END;
/