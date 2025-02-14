CREATE OR REPLACE PACKAGE        VE_PAC_UPDPROSP_BA IS
  --
  -- Retrofitted
  PROCEDURE p_prospecto
;
  --
  -- Retrofitted
  PROCEDURE p_insert_prostatus(
  v_cod_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
;
/*-- Proceso que recupera todos los prospectos.*/
 /*-- Proceso que recupera el codigo de oficina con la misma comuna que la
recuperada*/
END VE_PAC_UPDPROSP_BA;
/
SHOW ERRORS
