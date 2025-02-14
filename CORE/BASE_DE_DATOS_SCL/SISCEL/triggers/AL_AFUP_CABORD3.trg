CREATE OR REPLACE TRIGGER SISCEL.al_afup_cabord3
AFTER UPDATE
ON SISCEL.AL_CABECERA_ORDENES3
FOR EACH ROW
 
WHEN (
NEW.COD_ESTADO IN ('PA','PE','CE') AND              NEW.COD_ESTADO <>  OLD.COD_ESTADO
      )
DECLARE
   v_orden         al_cabecera_ordenes3.num_orden%type;
   v_estorden      al_cabecera_ordenes3.cod_estado%type;
   V_bodega        al_cabecera_ordenes3.cod_bodega%type;
   v_cabord3       al_cabecera_ordenes3%rowtype;
   v_fec_historico DATE := SYSDATE;
BEGIN
   dbms_output.put_line ('afup cabord3');
 if (:new.cod_estado = 'CE'  and
       :old.cod_estado = 'PA') or
       :new.cod_estado = 'PA'  or
       :new.cod_estado = 'PE'  then
     v_orden     := :new.num_orden;
     v_estorden  := :new.cod_estado;
     v_bodega    := :new.cod_bodega;
     al_proc_devolucion.p_trata_devprov(v_orden,
                                          v_estorden,
                                          v_bodega);
   end if;
 if :new.cod_estado = 'CE' then
     v_cabord3.num_orden       := :new.num_orden;
      v_cabord3.tip_orden       := :new.tip_orden;
     v_cabord3.cod_bodega      := :new.cod_bodega;
       v_cabord3.cod_proveedor   := :new.cod_proveedor;
     v_cabord3.fec_creacion    := :new.fec_creacion;
     v_cabord3.cod_sector      := :new.cod_sector;
     v_cabord3.cod_transp      := :new.cod_transp;
     v_cabord3.tip_pedido      := :new.tip_pedido;
     v_cabord3.fec_autoriza    := :new.fec_autoriza;
     v_cabord3.fec_embarque    := :new.fec_embarque ;
     v_cabord3.fec_arribo      := :new.fec_arribo;
     v_cabord3.cod_moneda      := :new.cod_moneda;
     v_cabord3.cod_estado      := :new.cod_estado;
     v_cabord3.pct_iva         := :new.pct_iva;
     v_cabord3.tot_arancel_est := :new.tot_arancel_est;
     v_cabord3.tot_flete_est   := :new.tot_flete_est;
     v_cabord3.tip_orden_ref   := :new.tip_orden_ref;
     v_cabord3.num_orden_ref   := :new.num_orden_ref;
     v_cabord3.usu_creacion    := :new.usu_creacion;
     v_cabord3.usu_autoriza    := :new.usu_autoriza;
     v_cabord3.num_orden_prov  := :new.num_orden_prov;
     al_pasohis_ord.p_pasohis_ord(v_cabord3,
                            v_fec_historico);
 end if;
--
END;
/
SHOW ERRORS
