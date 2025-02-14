CREATE OR REPLACE PROCEDURE        P_AL_PASOHIS_BOLETA(
  v_boleta_x IN char )
IS
  v_boleta al_cab_boleta.num_boleta%type;
BEGIN
  v_boleta := to_number(v_boleta_x);
  al_pac_boleta.al_p_pasohis(v_boleta);
END P_AL_PASOHIS_BOLETA;
/
SHOW ERRORS
