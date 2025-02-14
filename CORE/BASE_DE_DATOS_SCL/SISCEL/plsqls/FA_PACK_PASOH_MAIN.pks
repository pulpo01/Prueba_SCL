CREATE OR REPLACE PACKAGE        fa_pack_pasoh_main IS
  --
  -- Retrofitted
  PROCEDURE p_main(
  v_proceso IN Fa_HistDocu.Num_Proceso%TYPE ,
  v_tipdocum IN Ge_TipDocumen.Cod_Tipdocum%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_pasohist_ciclo(
  v_proceso IN Fa_HistDocu.Num_Proceso%TYPE )
;
END fa_pack_pasoh_main;
/
SHOW ERRORS
