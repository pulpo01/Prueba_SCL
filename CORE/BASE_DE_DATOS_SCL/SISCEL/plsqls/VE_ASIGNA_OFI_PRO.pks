CREATE OR REPLACE PACKAGE        VE_ASIGNA_OFI_PRO IS
  --
  -- Retrofitted
  PROCEDURE p_prospecto
;
  --
  -- Retrofitted
  PROCEDURE p_oficina(
  v_codComuna IN ge_direcciones.cod_comuna%TYPE ,
  v_cod_region IN ge_direcciones.cod_region%TYPE ,
  v_cod_provincia IN ge_direcciones.cod_provincia%TYPE ,
  v_cod_Oficina OUT ge_oficinas.cod_oficina%TYPE ,
  v_encofi IN OUT number )
;
  --
  -- Retrofitted
  PROCEDURE p_Update_Prospectos(
  v_cod_Prospecto IN ve_prospectos.cod_prospecto%TYPE ,
  v_cod_oficina IN ge_oficinas.cod_oficina%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_insert_Prospectos(
  v_cod_prospecto IN ve_prospectos.cod_prospecto%TYPE )
;
/*        -- Proceso que recupera todos los prospectos sin asignar*/
/* -- Proceso que recupera el codigo de oficina con la misma comuna que la
recuperada*/
END VE_ASIGNA_OFI_PRO;
/
SHOW ERRORS
