CREATE OR REPLACE PACKAGE        fa_pac_cuota IS
  --
  -- Retrofitted
  PROCEDURE p_main_cuota(
  v_num_cargo IN Ge_Cargos.Num_Cargo%TYPE ,
  v_cod_cuota IN Ge_TipCuotas.Cod_Cuota%TYPE ,
  v_prc_impuesto IN Fa_Presupuesto.Prc_Impuesto%TYPE ,
  v_cod_concepto IN Fa_Conceptos.Cod_Concepto%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_main_cuota2(
  v_num_ventas IN Ge_Cargos.Num_Venta%TYPE ,
  v_cod_cuota IN Ge_TipCuotas.Cod_Cuota%TYPE ,
  v_prc_impuesto IN Fa_Presupuesto.Prc_Impuesto%TYPE ,
  v_cod_concepto IN Fa_Conceptos.Cod_Concepto%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_getconcepto(
  v_reg_ge_cargos IN OUT Ge_Cargos%ROWTYPE ,
  v_reg_ge_tipcuotas IN OUT Ge_TipCuotas%ROWTYPE ,
  v_seq_cuota IN OUT Fa_Cuotas.Seq_Cuotas%TYPE ,
  v_prc_impuesto IN OUT Fa_Presupuesto.Prc_Impuesto%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_getconcepto2(
  v_reg_ge_cargos IN OUT Ge_Cargos%ROWTYPE ,
  v_reg_ge_tipcuotas IN OUT Ge_TipCuotas%ROWTYPE ,
  v_seq_cuota IN OUT Fa_Cuotas.Seq_Cuotas%TYPE ,
  v_prc_impuesto IN OUT Fa_Presupuesto.Prc_Impuesto%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_gencuota(
  v_reg_ge_cargos IN Ge_Cargos%ROWTYPE ,
  v_reg_ge_tipcuotas IN Ge_TipCuotas%ROWTYPE ,
  v_seq_cuota IN Fa_Cuotas.Seq_Cuotas%TYPE ,
  v_imp_cuota IN Fa_Cuotas.Imp_Cuota%TYPE ,
  v_diferencia IN number ,
  v_imp_total IN OUT Fa_CabCuotas.Imp_Total%TYPE ,
  v_reg_fa_cuotas IN OUT Fa_Cuotas%ROWTYPE ,
  v_modventa IN Ge_ModVenta.Cod_ModVenta%TYPE ,
  v_leasing IN Ga_DatosGener.Cod_Leasing%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_calcula(
  v_imp_cuota OUT Fa_Cuotas.Imp_cuota%TYPE ,
  v_reg_ge_tipcuotas IN OUT Ge_tipCuotas%ROWTYPE ,
  v_reg_ge_cargos IN OUT Ge_Cargos%ROWTYPE ,
  v_prc_impuesto IN Fa_Presupuesto.Prc_Impuesto%TYPE ,
  v_diferencia OUT number ,
  v_imp_total IN OUT Fa_CabCuotas.Imp_Total%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_ins_cuota(
  v_reg_fa_cuotas IN OUT Fa_Cuotas%ROWTYPE ,
  v_sqlcode IN OUT number ,
  v_sqlerrm IN OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_getcuota(
  v_reg_ge_tipcuotas IN OUT Ge_TipCuotas%ROWTYPE ,
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
  --
  -- Retrofitted
  PROCEDURE p_gencabcuotas(
  v_reg_fa_cabcuotas IN Fa_CabCuotas%ROWTYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_getmodventa(
  v_num_venta IN Ga_Ventas.Num_Venta%TYPE ,
  v_modventa OUT Ge_ModVenta.Cod_ModVenta%TYPE ,
  v_leasing OUT Ga_DatosGener.Cod_Leasing%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_getcambio(
  v_fec_valor IN Fa_HistConcCelu.fec_valor%TYPE ,
  v_cod_monedaorig IN Fa_HistConcCelu.Cod_Moneda%TYPE ,
  v_cod_monedadest IN Fa_DatosGener.Cod_MoneFact%TYPE ,
  v_imp_concepto IN Fa_HistConcCelu.Imp_Concepto%TYPE ,
  v_num_unidades IN Fa_HistConcCelu.Num_Unidades%TYPE ,
  v_imp_facturable OUT Fa_HistConcCelu.Imp_Facturable%TYPE )
;
END fa_pac_cuota;
/
SHOW ERRORS
