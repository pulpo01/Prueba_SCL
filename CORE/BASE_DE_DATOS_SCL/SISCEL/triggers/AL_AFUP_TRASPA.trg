CREATE OR REPLACE TRIGGER SISCEL.al_afup_traspa
AFTER UPDATE
ON SISCEL.AL_TRASPASOS
FOR EACH ROW
 
WHEN (
NEW.COD_ESTADO IN ('AU','EN','RM') AND       NEW.COD_ESTADO <>  OLD.COD_ESTADO
      )
DECLARE
 v_traspa al_traspasos%rowtype;
BEGIN
 v_traspa.num_traspaso      := :new.num_traspaso;
 v_traspa.num_peticion   := :new.num_peticion;
 v_traspa.cod_bodega_ori  := :new.cod_bodega_ori;
 v_traspa.cod_bodega_dest := :new.cod_bodega_dest;
 v_traspa.fec_autoriza  := :new.fec_autoriza;
 v_traspa.usu_autoriza  := :new.usu_autoriza;
 v_traspa.cod_estado   := :new.cod_estado;
 v_traspa.tip_movim_aut  := :new.tip_movim_aut;
 v_traspa.tip_movim_env  := :new.tip_movim_env;
 v_traspa.tip_movim_rec  := :new.tip_movim_rec;
 v_traspa.fec_despacho   := :new.fec_despacho;
 v_traspa.usu_despacho   := :new.usu_despacho;
 v_traspa.fec_recepcion  := :new.fec_recepcion;
 v_traspa.usu_recepcion  := :new.usu_recepcion;
 v_traspa.des_observacion  := :new.des_observacion;
 dbms_output.put_line ('antes llamada');
 al_trata_traspa.p_tratamiento(v_traspa);
--
END;
/
SHOW ERRORS
