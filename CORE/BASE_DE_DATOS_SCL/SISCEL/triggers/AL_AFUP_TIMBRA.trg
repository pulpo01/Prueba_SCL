CREATE OR REPLACE TRIGGER SISCEL.al_afup_timbra
AFTER UPDATE
ON SISCEL.AL_CAB_TIMBRADO
FOR EACH ROW
 
WHEN (
NEW.COD_ESTADO IN ('PR','RE') AND       NEW.COD_ESTADO <>  OLD.COD_ESTADO
      )
DECLARE
   v_timbra   al_cab_timbrado%rowtype;
BEGIN
--
   v_timbra.num_orden        := :new.num_orden;
   v_timbra.fec_creacion     := :new.fec_creacion;
   v_timbra.usu_creacion     := :new.usu_creacion;
   v_timbra.cod_bodega       := :new.cod_bodega;
   v_timbra.cod_estado       := :new.cod_estado;
   v_timbra.fec_envio        := :new.fec_envio;
   v_timbra.usu_envio        := :new.usu_envio;
   v_timbra.tip_movim_envio  := :new.tip_movim_envio;
   v_timbra.fec_recepcion    := :new.fec_recepcion;
   v_timbra.usu_recepcion    := :new.usu_recepcion;
   v_timbra.tip_movim_recep  := :new.tip_movim_recep;
   al_trata_timbrado.p_proceso_timbre (v_timbra);
--
END;
/
SHOW ERRORS
