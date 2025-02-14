CREATE OR REPLACE TRIGGER GC_CLIENTE_AFUP_TG
AFTER UPDATE
ON GC_CLIENTE_TO
FOR EACH ROW
     
WHEN (OLD.DES_IDENT <> NEW.DES_IDENT
     OR NVL(OLD.NUM_FONO_CONTACTO,0) <> NVL(NEW.NUM_FONO_CONTACTO,0)
  OR NVL(OLD.COD_CUENTA,0) <> NVL(NEW.COD_CUENTA,0) )
DECLARE
  vBitacora gc_bitacora_to%ROWTYPE;
BEGIN
  vBitacora.nom_tabla := 'GC_CLIENTE_TO';
  vBitacora.id_tabla := :new.id_cliente_gc;
  vBitacora.usu_modif := :new.nom_usuarora;
  vBitacora.gls_observaciones := :new.gls_observacion;

  IF :OLD.DES_IDENT <> :NEW.DES_IDENT THEN
     vBitacora.nom_campo := 'DES_IDENT';
     vBitacora.val_anterior := NVL(:old.des_ident,' ') ;
  vBitacora.val_nuevo := :new.des_ident;
  gc_contactos_pG.GC_agregarCambioEnBitacora_PR(vBitacora.nom_tabla, vBitacora.nom_campo, vBitacora.id_tabla, vBitacora.val_anterior,
                                          vBitacora.val_nuevo, vBitacora.usu_modif, vBitacora.gls_observaciones);
  END IF;

  IF NVL(:OLD.NUM_FONO_CONTACTO,0) <> NVL(:NEW.NUM_FONO_CONTACTO,0) THEN
     vBitacora.nom_campo := 'NUM_FONO_CONTACTO';
     vBitacora.val_anterior := NVL(:old.num_fono_contacto,' ');
  vBitacora.val_nuevo := :new.num_fono_contacto;
  gc_contactos_pG.GC_agregarCambioEnBitacora_PR(vBitacora.nom_tabla, vBitacora.nom_campo, vBitacora.id_tabla, vBitacora.val_anterior,
                                          vBitacora.val_nuevo, vBitacora.usu_modif, vBitacora.gls_observaciones);
  END IF;

  IF NVL(:OLD.COD_CUENTA,0) <> NVL(:NEW.COD_CUENTA,0) THEN
     vBitacora.nom_campo := 'COD_CUENTA';
     vBitacora.val_anterior := NVL(:old.cod_cuenta, -1);
  vBitacora.val_nuevo := NVL(:new.cod_cuenta, -1);
  gc_contactos_pG.GC_agregarCambioEnBitacora_PR(vBitacora.nom_tabla, vBitacora.nom_campo, vBitacora.id_tabla, vBitacora.val_anterior,
                                          vBitacora.val_nuevo, vBitacora.usu_modif, vBitacora.gls_observaciones);
  END IF;

END;
/
SHOW ERRORS
