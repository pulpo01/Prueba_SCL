CREATE OR REPLACE TRIGGER GC_APUNTE_AFUP_TG
AFTER UPDATE
ON GC_APUNTE_TO
FOR EACH ROW
     
WHEN (OLD.COD_ESTADO_APUNTE <> NEW.COD_ESTADO_APUNTE
     OR NVL(OLD.IND_ACEPCLIE,-1) <> NVL(NEW.IND_ACEPCLIE, -1)
          )
DECLARE
  vBitacora gc_bitacora_to%ROWTYPE;
BEGIN
  vBitacora.nom_tabla := 'GC_APUNTE_TO';
  vBitacora.id_tabla := :new.id_apunte;
  vBitacora.gls_observaciones := :new.gls_observaciones;

  IF :OLD.COD_ESTADO_APUNTE  <> :NEW.COD_ESTADO_APUNTE  THEN
     vBitacora.nom_campo := 'COD_ESTADO_APUNTE';
     vBitacora.val_anterior := :old.cod_estado_apunte;
  vBitacora.val_nuevo := :new.cod_estado_apunte;
  vBitacora.usu_modif := :new.usu_estado_apunte;
  gc_contactos_pG.GC_agregarCambioEnBitacora_PR(vBitacora.nom_tabla, vBitacora.nom_campo, vBitacora.id_tabla, vBitacora.val_anterior,
                                          vBitacora.val_nuevo, vBitacora.usu_modif, vBitacora.gls_observaciones);
  END IF;

  IF (:OLD.IND_ACEPCLIE <> :NEW.IND_ACEPCLIE
      OR NVL(:OLD.IND_ACEPCLIE,-1) <> NVL(:NEW.IND_ACEPCLIE, -1) )  THEN
     vBitacora.nom_campo := 'IND_ACEPCLIE';
     vBitacora.val_anterior := NVL(:old.ind_acepclie, -1);
  vBitacora.val_nuevo := NVL(:new.ind_acepclie, -1);
  vBitacora.usu_modif := USER;
  gc_contactos_pG.GC_agregarCambioEnBitacora_PR(vBitacora.nom_tabla, vBitacora.nom_campo, vBitacora.id_tabla, vBitacora.val_anterior,
                                          vBitacora.val_nuevo, vBitacora.usu_modif, vBitacora.gls_observaciones);
  END IF;

END;
/
SHOW ERRORS
