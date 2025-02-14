CREATE OR REPLACE TRIGGER SISCEL.al_afup_lintra
AFTER UPDATE
ON SISCEL.AL_LIN_TRASPASO
FOR EACH ROW
 
WHEN (
NEW.CAN_TRASPASO <> OLD.CAN_TRASPASO
      )
DECLARE
 v_traspaso al_lin_traspaso.num_traspaso%type;
 v_tstock   al_lin_traspaso.tip_stock%type;
 v_articulo al_lin_traspaso.cod_articulo%type;
 v_uso      al_lin_traspaso.cod_uso%type;
 v_estado   al_lin_traspaso.cod_estado%type;
 v_can_old  al_lin_traspaso.can_traspaso%type;
 v_can_new  al_lin_traspaso.can_traspaso%type;
BEGIN
--
 v_traspaso := :new.num_traspaso;
 v_tstock  := :new.tip_stock;
 v_articulo := :new.cod_articulo;
 v_uso   := :new.cod_uso;
 v_estado  := :new.cod_estado;
 v_can_old := :old.can_traspaso;
 v_can_new := :new.can_traspaso;
   al_trata_traspa.p_cambio_cantidad(v_traspaso,
                                     v_tstock,
                                     v_articulo,
                                     v_uso,
                                     v_estado,
                                     v_can_old,
                                     v_can_new);
END;
/
SHOW ERRORS
