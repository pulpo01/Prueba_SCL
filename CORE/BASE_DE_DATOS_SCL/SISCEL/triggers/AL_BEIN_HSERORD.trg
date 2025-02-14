CREATE OR REPLACE TRIGGER al_bein_hserord
BEFORE INSERT
ON AL_HSERIES_ORDENES
FOR EACH ROW

DECLARE
   v_hserord al_hseries_ordenes%rowtype;
begin
   v_hserord.num_orden     := :new.num_orden;
   v_hserord.tip_orden     := :new.tip_orden;
   v_hserord.fec_historico := :new.fec_historico;
   v_hserord.num_linea     := :new.num_linea;
   v_hserord.num_serie     := :new.num_serie;
   v_hserord.cod_accion    := :new.cod_accion;
   v_hserord.num_seriemec  := :new.num_seriemec;
   v_hserord.cod_producto  := :new.cod_producto;
   v_hserord.cod_central   := :new.cod_central;
   v_hserord.cap_code      := :new.cap_code;
   v_hserord.num_telefono  := :new.num_telefono;
   v_hserord.cod_subalm    := :new.cod_subalm;
   v_hserord.cod_cat       := :new.cod_cat;
   v_hserord.ind_telefono  := :new.ind_telefono;
   v_hserord.plan          := :new.plan;
   v_hserord.carga         := :new.carga;
   v_hserord.cod_hlr         := :new.cod_hlr;
   if :new.cod_accion = 1 then
      al_trata_horden.p_insert_hserord(v_hserord);
   else
  al_trata_horden.p_delete_hserord(v_hserord);
   end if;
   :new.tip_orden := 9;
end;
/
SHOW ERRORS
