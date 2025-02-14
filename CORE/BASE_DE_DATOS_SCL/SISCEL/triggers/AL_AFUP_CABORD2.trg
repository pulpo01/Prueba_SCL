CREATE OR REPLACE TRIGGER al_afup_cabord2
AFTER UPDATE
ON AL_CABECERA_ORDENES2
FOR EACH ROW
 
WHEN (NEW.COD_ESTADO = 'CE' AND
NEW.COD_ESTADO <>  OLD.COD_ESTADO)
DECLARE
   v_orden_ing  al_cabecera_ordenes.num_orden%type;
   v_tipord_ref al_cabecera_ordenes.tip_orden%type;
   v_orden_ref  al_cabecera_ordenes.num_orden%type;
   v_bodega     al_cabecera_ordenes.cod_bodega%type;
   v_usuario    al_cabecera_ordenes.usu_creacion%type;
   v_moneda     al_cabecera_ordenes.cod_moneda%type;
BEGIN
--
   v_orden_ing  := :new.num_orden;
   v_tipord_ref := :new.tip_orden_ref;
   v_orden_ref  := :new.num_orden_ref;
   v_bodega     := :new.cod_bodega;
   v_usuario    := :new.usu_creacion;
   v_moneda     := :new.cod_moneda;
   if v_orden_ing <> 3245 then	-- esta hay que ajustarla a mano
	   al_proc_ingreso.p_trata_cierre (v_orden_ing,
                                   v_tipord_ref,
                                   v_orden_ref,
                                   v_bodega,
                                   v_usuario,
                                   v_moneda);
   end if;
END;
/
SHOW ERRORS
