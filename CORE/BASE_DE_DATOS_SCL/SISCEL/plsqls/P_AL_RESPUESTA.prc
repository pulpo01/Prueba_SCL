CREATE OR REPLACE PROCEDURE        P_AL_RESPUESTA(
  v_movim IN icc_movimiento%rowtype )
IS
   v_tipo char(1);
BEGIN
   al_pac_validaciones.p_actuacion (v_movim.cod_actuacion,
                                    v_tipo);
   if v_tipo = 'A' then
      update al_fic_series
             set cod_estacen = 'PR'
             where num_telefono = v_movim.num_celular
               and num_serhex   = v_movim.num_serie;
   end if;
EXCEPTION
   when OTHERS then
        raise_application_error (-20177,'');
END P_AL_RESPUESTA;
/
SHOW ERRORS
