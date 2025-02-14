CREATE OR REPLACE PACKAGE        VE_BUSCAR_PROSPECTOS IS
  --
  -- Retrofitted
  PROCEDURE p_Buscar_Prospectos(
  v_Cod_Ident IN ve_prospectos.cod_tipident%TYPE ,
  v_Num_Ident IN ve_prospectos.num_ident%TYPE ,
  v_IdUsr IN ve_prospectos.nom_usuario%TYPE ,
  v_result OUT number ,
  v_err OUT char )
;
  --
  -- Retrofitted
  PROCEDURE p_delete_Proasign(
  v_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_delete_ProEntrev(
  v_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_delete_Prospectos(
  v_Prospecto IN ve_prospectos.cod_prospecto%TYPE )
;
END VE_BUSCAR_PROSPECTOS;
/
SHOW ERRORS
