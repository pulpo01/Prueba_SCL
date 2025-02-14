CREATE OR REPLACE PACKAGE        VE_DEL_PROS_AUT IS
  --
  -- Retrofitted
  PROCEDURE p_prospecto
;
  --
  -- Retrofitted
  PROCEDURE p_insert_prostatus(
  v_cod_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_delete_prospecto(
  v_cod_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_delete_Proasign(
  v_cod_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_delete_Proentrev(
  v_cod_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_leer_Prodireccion(
  v_cod_prospecto IN ve_prospectos.cod_prospecto%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_delete_Prodireccion(
  v_cod_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_delete_Gedirecciones(
  v_cod_Direccion IN ge_direcciones.cod_direccion%TYPE )
;
END VE_DEL_PROS_AUT;
/
SHOW ERRORS
