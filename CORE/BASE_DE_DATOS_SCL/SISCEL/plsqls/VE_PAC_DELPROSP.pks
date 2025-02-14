CREATE OR REPLACE PACKAGE        VE_PAC_DELPROSP IS
  --
  -- Retrofitted
  PROCEDURE p_principal(
  V_CODPROSPECTO IN NUMBER ,
  V_MODULO IN GE_MODULOS.COD_MODULO%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_delete_prospecto(
  V_CODPROSPECTO IN NUMBER )
;
  --
  -- Retrofitted
  PROCEDURE p_delete_Proasign(
  V_CODPROSPECTO IN NUMBER )
;
  --
  -- Retrofitted
  PROCEDURE p_delete_Proentrev(
  V_CODPROSPECTO IN NUMBER )
;
  --
  -- Retrofitted
  PROCEDURE p_leer_Prodireccion(
  V_CODPROSPECTO IN NUMBER )
;
  --
  -- Retrofitted
  PROCEDURE p_delete_Prodireccion(
  V_CODPROSPECTO IN NUMBER )
;
  --
  -- Retrofitted
  PROCEDURE p_delete_Gedirecciones(
  v_cod_Direccion IN ge_direcciones.cod_direccion%TYPE )
;
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
END VE_PAC_DELPROSP;
/
SHOW ERRORS
