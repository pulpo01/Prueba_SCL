CREATE OR REPLACE PACKAGE        fa_pac_arreglo IS
  --
  -- Retrofitted
  PROCEDURE p_main_arreglo(
  v_seq_cuotas IN Fa_CabCuotas.Seq_Cuotas%TYPE ,
  v_regenera IN number )
;
  --
  -- Retrofitted
  PROCEDURE p_genera(
  v_seq_cuotas IN OUT Fa_Cuotas.Seq_Cuotas%TYPE ,
  v_reg_fa_cuotas IN OUT Fa_Cuotas%ROWTYPE ,
  v_regenera IN number ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_upd_cuota(
  v_fec_emision IN Fa_Cuotas.Fec_Emision%TYPE ,
  v_seq_cuotas IN Fa_Cuotas.Seq_Cuotas%TYPE ,
  v_ord_cuota IN Fa_Cuotas.Ord_Cuota%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
END fa_pac_arreglo;
/
SHOW ERRORS
