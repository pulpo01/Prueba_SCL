CREATE OR REPLACE TRIGGER al_afup_cabextra
AFTER UPDATE
ON AL_CAB_ES_EXTRAS
FOR EACH ROW

WHEN (
NEW.COD_ESTADO = 'CE' AND       NEW.COD_ESTADO <> OLD.COD_ESTADO
      )
DECLARE
   v_cabextra  al_cab_es_extras%rowtype;
BEGIN
   v_cabextra.num_extra       := :new.num_extra;
   v_cabextra.cod_bodega      := :new.cod_bodega;
   v_cabextra.fec_extra       := :new.fec_extra;
   v_cabextra.cod_motivo      := :new.cod_motivo;
   v_cabextra.cod_estado      := :new.cod_estado;
   v_cabextra.des_observacion := :new.des_observacion;
   v_cabextra.nom_usuario     := :new.nom_usuario;
   v_cabextra.ind_entsal      := :new.ind_entsal;
   IF v_cabextra.ind_entsal ='E' OR v_cabextra.ind_entsal='S' THEN
      al_proc_es_extra.p_trata_extra (v_cabextra);
   END IF;
END;
/
SHOW ERRORS
