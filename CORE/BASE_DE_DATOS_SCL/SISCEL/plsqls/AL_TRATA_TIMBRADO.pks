CREATE OR REPLACE PACKAGE AL_TRATA_TIMBRADO IS
  --
  PROCEDURE p_proceso_timbre(
  v_timbra IN al_cab_timbrado%rowtype )
;
  --
  PROCEDURE p_select_movim(
  v_movto IN OUT al_movimientos.num_movimiento%type )
;
  --
  PROCEDURE p_select_estados(
  v_tempor IN OUT al_datos_generales.cod_estado_tem%type ,
  v_timbre IN OUT al_datos_generales.cod_estado_tim%type )
;
--
END AL_TRATA_TIMBRADO;
/
SHOW ERRORS
