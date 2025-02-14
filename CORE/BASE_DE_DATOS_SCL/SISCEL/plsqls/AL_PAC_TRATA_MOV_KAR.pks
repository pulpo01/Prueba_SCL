CREATE OR REPLACE PACKAGE        Al_Pac_Trata_Mov_Kar
 IS
  --
  -- Retrofitted
  PROCEDURE trata_datos(
  v_mov_kar IN OUT AL_PDTE_KARDEX%ROWTYPE ,
  v_imp_cargo IN OUT ge_cargos.imp_cargo%TYPE,
  v_err IN OUT NUMBER )
;
END Al_Pac_Trata_Mov_Kar;
/
SHOW ERRORS
