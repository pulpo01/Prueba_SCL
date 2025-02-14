CREATE OR REPLACE TRIGGER al_beup_cabguia
BEFORE UPDATE
ON AL_CAB_GUIAS
FOR EACH ROW
     
WHEN ( NEW.NUM_FOLIO <> NVL(OLD.NUM_FOLIO,0) )
DECLARE
   v_numguia    al_cab_guias.num_guia%type;
   v_venta      al_cab_guias.num_venta%type;
   v_folio      al_cab_guias.num_folio%type;
   v_usuario    al_cab_guias.usu_folio%type;
   v_detalle    al_cab_guias.ind_detalle%type;
   v_operadora   al_cab_guias.cod_operadora%type;
   v_prefijo    al_cab_guias.pref_plaza%type;
BEGIN
   v_numguia    := :new.num_guia;
   v_venta      := :new.num_venta;
   v_folio      := :new.num_folio;
   v_usuario    := :new.usu_folio;
   v_detalle    := :new.ind_detalle;
   v_operadora  := :new.cod_operadora;
   v_prefijo    := :new.pref_plaza;
   al_pac_folios_guias.p_asigna_folio (v_numguia,
                                       v_venta,
                                       v_operadora,
                                       v_prefijo,
                                       v_folio,
                                       v_usuario,
                                       v_detalle);
   :new.cod_estado := 'AF';
END AL_BEUP_CABGUIA;
/
SHOW ERRORS
