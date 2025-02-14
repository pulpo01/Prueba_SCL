CREATE OR REPLACE PROCEDURE        P_AL_GENGUIAS(
  v_call IN char ,
  v_detalle_x IN char ,
  v_peticion_x IN char )
IS
  v_peticion al_interguias.num_peticion%type;
  v_detalle  al_cab_guias.ind_detalle%type;
BEGIN
--
   v_peticion := to_number(v_peticion_x);
   v_detalle  := to_number(v_detalle_x);
   if v_call = 'V' then
      al_pac_guias_abo.p_genera_guias(v_peticion,
                                      v_detalle);
   elsif v_call = 'A' then
      al_pac_guias_alma.p_genera_guias(v_peticion,
                                       v_detalle);
   end if;
--
END P_AL_GENGUIAS;
/
SHOW ERRORS
