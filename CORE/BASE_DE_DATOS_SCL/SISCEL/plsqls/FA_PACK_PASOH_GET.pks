CREATE OR REPLACE PACKAGE        fa_pack_pasoh_get IS
  --
  -- Retrofitted
  PROCEDURE p_insdociclo(
  v_num_proceso IN Fa_HistDocu.Num_Proceso%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_inscliciclo(
  v_ind_ordentotal IN Fa_HistDocu.Ind_OrdenTotal%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_insabociclo(
  v_ind_ordentotal IN Fa_HistDocu.Ind_OrdenTotal%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_getgedatosgener(
  v_ge_datosgener OUT Ge_DatosGener%ROWTYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_getfadatosgener(
  v_fa_datosgener OUT Fa_DatosGener%ROWTYPE )
;
END fa_pack_pasoh_get;
/
SHOW ERRORS
