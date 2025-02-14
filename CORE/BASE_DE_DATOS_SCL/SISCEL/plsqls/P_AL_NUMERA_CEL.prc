CREATE OR REPLACE PROCEDURE P_AL_NUMERA_CEL(
  v_orden_x IN char ,
  v_tipo_x IN char ,
  v_linea_x IN char ,
  v_subalm IN char ,
  v_central_x IN char ,
  v_uso_x IN char ,
  v_can_x IN char ,
  v_cat_x IN char )
IS
  v_central    icg_central.cod_central%type;
  v_uso        al_usos.cod_uso%type;
  v_can        al_lineas_ordenes1.can_orden%type;
  v_orden      al_lineas_ordenes1.num_orden%type;
  v_linea      al_lineas_ordenes1.num_linea%type;
  v_error      number(1) := 0;
  v_nro_reutil number := 0;
  v_nro_uso    number := 0;
  v_articulo   al_articulos.cod_articulo%type;
  v_terminal   al_tipos_terminales.tip_terminal%type;
  v_cat        ga_catnumer.cod_cat%type;
  v_tipo       al_cabecera_ordenes.tip_orden%type;
BEGIN
  v_central := to_number(v_central_x);
  v_uso     := to_number(v_uso_x);
  v_can     := to_number(v_can_x);
  v_orden   := to_number(v_orden_x);
  v_linea   := to_number(v_linea_x);
  v_cat     := to_number(v_cat_x);
  v_tipo    := to_number(v_tipo_x);
  al_pac_numeracion.p_hay_numeros_al (v_subalm,
                                   v_central,
                                   v_uso,
                                   v_can,
                                   v_nro_reutil,
                                   v_cat,
                                   v_error);
  if v_error = 0 then
     al_pac_numeracion.p_select_articulo (v_orden,
                                          v_tipo,
                                          v_linea,
                                          v_articulo);
--
     al_pac_numeracion.p_select_terminal (v_articulo,
                                          v_terminal);
--
     al_pac_numeracion.p_asigna_numeracion (v_orden,
                                            v_tipo,
                                            v_linea,
                                            v_subalm,
                                            v_central,
                                            v_uso,
                                            v_nro_reutil,
                                            v_terminal,
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
END P_AL_NUMERA_CEL;
/
SHOW ERRORS
