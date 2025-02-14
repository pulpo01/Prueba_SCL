CREATE OR REPLACE TRIGGER GC_TAREAAPUNTE_AFUP_TG
AFTER UPDATE
ON GC_TAREA_APUNTE_TO
FOR EACH ROW
     
WHEN (OLD.COD_ESTADO_TAREA <> NEW.COD_ESTADO_TAREA
     OR NVL(OLD.IND_ACTIVA,-1) <> NVL(NEW.IND_ACTIVA,-1)
  OR NVL(OLD.USU_ASIG,' ') <> NVL(NEW.USU_ASIG,' ')
  OR NVL(OLD.COD_SECTOR_ASIG,-1) <> NVL(NEW.COD_SECTOR_ASIG,-1))
DECLARE
  vBitacora gc_bitacora_to%ROWTYPE;
BEGIN
  vBitacora.nom_tabla := 'GC_TAREA_APUNTE_TO';
  vBitacora.id_tabla := :old.id_tarea;
  vBitacora.usu_modif := USER;
  vBitacora.gls_observaciones := :new.gls_observaciones;

  IF :OLD.COD_ESTADO_TAREA <> :NEW.COD_ESTADO_TAREA THEN
     vBitacora.nom_campo := 'COD_ESTADO_TAREA';
     vBitacora.val_anterior := :old.cod_estado_tarea ;
  vBitacora.val_nuevo := :new.cod_estado_tarea;
     vBitacora.usu_modif := :new.usu_estado_tarea;
  gc_contactos_pG.GC_agregarCambioEnBitacora_PR(vBitacora.nom_tabla, vBitacora.nom_campo, vBitacora.id_tabla, vBitacora.val_anterior,
                                          vBitacora.val_nuevo, vBitacora.usu_modif, vBitacora.gls_observaciones);
  END IF;

  IF NVL(:OLD.IND_ACTIVA,-1) <> NVL(:NEW.IND_ACTIVA,-1) THEN
     vBitacora.nom_campo := 'IND_ACTIVA';
     vBitacora.val_anterior := NVL(:old.ind_activa, -1) ;
  vBitacora.val_nuevo := NVL(:new.ind_activa, -1);
  gc_contactos_pg.GC_agregarCambioEnBitacora_PR(vBitacora.nom_tabla, vBitacora.nom_campo, vBitacora.id_tabla, vBitacora.val_anterior,
                                          vBitacora.val_nuevo, vBitacora.usu_modif, vBitacora.gls_observaciones);
  END IF;

  IF NVL(:OLD.USU_ASIG,' ') <> NVL(:NEW.USU_ASIG,' ')  THEN
     vBitacora.nom_campo := 'USU_ASIG';
     vBitacora.val_anterior := NVL(:old.usu_asig, ' ') ;
  vBitacora.val_nuevo := NVL(:new.usu_asig, ' ');
  gc_contactos_pg.GC_agregarCambioEnBitacora_PR(vBitacora.nom_tabla, vBitacora.nom_campo, vBitacora.id_tabla, vBitacora.val_anterior,
                                          vBitacora.val_nuevo, vBitacora.usu_modif, vBitacora.gls_observaciones);
  END IF;

  IF NVL(:OLD.COD_SECTOR_ASIG,-1) <> NVL(:NEW.COD_SECTOR_ASIG,-1) THEN
     vBitacora.nom_campo := 'COD_SECTOR_ASIG';
     vBitacora.val_anterior := NVL(:old.cod_sector_asig, -1) ;
  vBitacora.val_nuevo := NVL(:new.cod_sector_asig, -1);
  gc_contactos_pg.GC_agregarCambioEnBitacora_PR(vBitacora.nom_tabla, vBitacora.nom_campo, vBitacora.id_tabla, vBitacora.val_anterior,
                                          vBitacora.val_nuevo, vBitacora.usu_modif, vBitacora.gls_observaciones);
  END IF;
END;
/
SHOW ERRORS
