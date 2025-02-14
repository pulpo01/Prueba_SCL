CREATE OR REPLACE PROCEDURE        SP_P_GENGUIAS(
  v_peticion_x IN char ,
  v_detalle_x IN char )
IS
  v_peticion al_interguias.num_peticion%type;
  v_detalle  al_cab_guias.ind_detalle%type;
BEGIN
--
   v_peticion := to_number(v_peticion_x);
   v_detalle  := to_number(v_detalle_x);
   sp_pac_guias_stp.sp_p_genera_guias(v_peticion, v_detalle);
--
END SP_P_GENGUIAS;
/
SHOW ERRORS
