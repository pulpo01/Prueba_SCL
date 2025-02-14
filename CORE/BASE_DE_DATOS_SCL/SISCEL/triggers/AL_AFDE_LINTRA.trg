CREATE OR REPLACE TRIGGER SISCEL.al_afde_lintra
AFTER DELETE
ON SISCEL.AL_LIN_TRASPASO
FOR EACH ROW

DECLARE
 v_traspaso al_lin_traspaso.num_traspaso%type;
 v_tstock   al_lin_traspaso.tip_stock%type;
 v_articulo al_lin_traspaso.cod_articulo%type;
 v_uso      al_lin_traspaso.cod_uso%type;
 v_estado   al_lin_traspaso.cod_estado%type;
   v_cantidad al_lin_traspaso.can_traspaso%type;
BEGIN
--
   v_traspaso := :old.num_traspaso;
 v_tstock  := :old.tip_stock;
 v_articulo := :old.cod_articulo;
 v_uso   := :old.cod_uso;
 v_estado  := :old.cod_estado;
 v_cantidad := :old.can_traspaso;
   al_trata_traspa.p_borrado_lintra(v_traspaso,
                                    v_tstock,
                                    v_articulo,
                                    v_uso,
                                    v_estado,
                                    v_cantidad);
END;
/
SHOW ERRORS
