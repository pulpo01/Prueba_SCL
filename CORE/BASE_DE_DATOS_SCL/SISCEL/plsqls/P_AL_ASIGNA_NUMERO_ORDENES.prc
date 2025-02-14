CREATE OR REPLACE PROCEDURE        P_AL_ASIGNA_NUMERO_ORDENES(
  v_numeracion_x IN char ,
  v_linea_x IN char ,
  v_subalm IN char ,
  v_central_x IN char ,
  v_uso_x IN char ,
  v_can_x IN char ,
  v_cat_x IN char )
IS
  v_numeracion al_ser_numeracion.num_numeracion%type;
  v_linea      al_ser_numeracion.lin_numeracion%type;
  v_central    icg_central.cod_central%type;
  v_uso        al_usos.cod_uso%type;
  v_can        al_lin_numeracion.can_numera%type;
  v_error      number(1) := 0;
  v_nro_reutil number := 0;
  v_cat        ga_catnumer.cod_cat%type;
BEGIN
  v_numeracion  := to_number(v_numeracion_x);
  v_linea   := to_number(v_linea_x);
  v_central := to_number(v_central_x);
  v_uso     := to_number(v_uso_x);
  v_can     := to_number(v_can_x);
  v_cat     := to_number(v_cat_x);
  al_pac_numeracion.p_hay_numeros_al (v_subalm,
                                   v_central,
                                   v_uso,
                                   v_can,
                                   v_nro_reutil,
                                   v_cat,
                                   v_error);
  if v_error = 0 then
		al_pac_numeracion.p_asigna_numero_ordenes (v_numeracion,
                                            v_linea,
                                            v_subalm,
                                            v_central,
                                            v_uso,
                                            v_nro_reutil,
                                            v_cat,
                                            v_error);
     if v_error = 1 then
        raise_application_error (-20123,'');
--
-- Error controlado desde VB dando como mensaje:
-- " ERROR EN ASIGNACION DE NUMERACION A LAS SERIES DE CELULAR "
--
     end if;
  else
     raise_application_error (-20120,'');
--
-- Error controlado desde VB dando como mensaje:
-- " NO HAY NUMERACION DISPONIBLE SUFICIENTE "
--
  end if;
END P_AL_ASIGNA_NUMERO_ORDENES;
/
SHOW ERRORS
