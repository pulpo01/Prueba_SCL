CREATE OR REPLACE PACKAGE        fa_pac_pagare IS
  --
  -- Retrofitted
  PROCEDURE p_main_cuota(
  v_cod_concepto IN Fa_Conceptos.Cod_Concepto%TYPE ,
  v_cod_producto IN Ge_Productos.Cod_Producto%TYPE ,
  v_cod_moneda IN Ge_Monedas.Cod_Moneda%TYPE ,
  v_cod_cliente IN Ge_Clientes.Cod_Cliente%TYPE ,
  v_num_pagare IN Co_Pagare.Num_Pagare%TYPE ,
  v_num_cuotas IN Co_Pagare.num_Cuotas%TYPE ,
  v_prc_interes IN Co_Pagare.Factor_Ind%TYPE ,
  v_fecha IN varchar2 ,
  v_num_dias IN Co_Pagare.num_Dias%TYPE ,
  v_imp_concepto IN number )
;
  --
  -- Retrofitted
  PROCEDURE p_gencuota(
  v_seq_cuota IN Fa_Cuotas.Seq_Cuotas%TYPE ,
  v_imp_cuota IN Fa_Cuotas.Imp_Cuota%TYPE ,
  v_reg_fa_cuotas IN OUT Fa_Cuotas%ROWTYPE ,
  v_reg_fa_cabcuotas IN OUT Fa_CabCuotas%ROWTYPE ,
  v_cod_concepto IN Fa_Conceptos.Cod_Concepto%TYPE ,
  v_cod_producto IN Ge_Productos.Cod_Producto%TYPE ,
  v_cod_moneda IN Ge_Monedas.Cod_Moneda%TYPE ,
  v_cod_cliente IN Ge_Clientes.Cod_Cliente%TYPE ,
  v_num_cuotas IN Fa_CabCuotas.Num_Cuotas%TYPE ,
  v_num_dias IN Co_Pagare.Num_Dias%TYPE ,
  v_num_pagare IN Co_Pagare.Num_Pagare%TYPE ,
  v_fec_valor IN Co_Pagare.Fec_Valor%TYPE ,
  v_diferencia IN number ,
  v_imp_total IN OUT Fa_CabCuotas.Imp_Total%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_calcula(
  v_imp_concepto IN number ,
  v_imp_cuota OUT Fa_Cuotas.Imp_Cuota%TYPE ,
  v_num_cuotas IN Fa_CabCuotas.Num_Cuotas%TYPE ,
  v_prc_interes IN Co_Pagare.Factor_Ind%TYPE ,
  v_diferencia OUT number ,
  v_imp_total IN OUT Fa_CabCuotas.Imp_Total%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_ins_cuota(
  v_reg_fa_cuotas IN Fa_Cuotas%ROWTYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_ins_cabcuota(
  v_reg_fa_cabcuotas IN Fa_CabCuotas%ROWTYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_seqcuota(
  vseq_cuotas OUT Fa_Cuotas.Seq_Cuotas%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
END fa_pac_pagare;
/
SHOW ERRORS
