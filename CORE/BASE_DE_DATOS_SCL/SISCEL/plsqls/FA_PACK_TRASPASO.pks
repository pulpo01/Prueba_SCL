CREATE OR REPLACE PACKAGE        fa_pack_traspaso IS
  --
  -- Retrofitted
  PROCEDURE p_main(
  v_cod_cliente IN Ge_Cargos.Cod_Cliente%TYPE ,
  v_num_abonado IN Ge_Cargos.Num_Abonado%TYPE ,
  v_num_transaccion IN number ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_aplicadto(
  v_reg_ge_cargos IN OUT Ge_Cargos%ROWTYPE ,
  v_imp_descuento OUT number ,
  v_cod_monefact IN Fa_DatosGener.Cod_MoneFact%TYPE ,
  v_flag_dto OUT number ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_getfadatosgener(
  v_fa_datosgener OUT Fa_DatosGener%ROWTYPE )
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
  --
  -- Retrofitted
  PROCEDURE p_aplicaiva(
  v_cod_cliente IN Ge_Cargos.Cod_Cliente%TYPE ,
  v_cod_moneda IN Ge_Cargos.Cod_Moneda%TYPE ,
  v_cod_concepto IN Ge_Cargos.Cod_Concepto%TYPE ,
  v_num_unidades IN Ge_Cargos.Num_Unidades%TYPE ,
  v_imp_cargo IN Ge_Cargos.Imp_Cargo%TYPE ,
  v_fec_alta IN Ge_Cargos.Fec_Alta%TYPE ,
  v_cod_iva IN Fa_DatosGener.Cod_Iva%TYPE ,
  v_cod_monefact IN Fa_DatosGener.Cod_MoneFact%TYPE ,
  v_imp_iva OUT number ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_getcatimpos(
  v_cod_cliente IN Ge_Cargos.Cod_Cliente%TYPE ,
  v_fec_alta IN Ge_Cargos.Fec_Alta%TYPE ,
  v_catimpos OUT Ge_CatImpClientes.Cod_CatImpos%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_getdireccli(
  v_cod_cliente IN Ga_DirecCli.Cod_Cliente%TYPE ,
  v_cod_region OUT Ge_Direcciones.Cod_Region%TYPE ,
  v_cod_provincia OUT Ge_Direcciones.Cod_Provincia%TYPE ,
  v_cod_ciudad OUT Ge_Direcciones.Cod_Ciudad%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_getzonaimpo(
  v_cod_region IN Ge_Direcciones.Cod_Region%TYPE ,
  v_cod_provincia IN Ge_Direcciones.Cod_Provincia%TYPE ,
  v_cod_ciudad IN Ge_Direcciones.Cod_Ciudad%TYPE ,
  v_fec_alta IN Ge_Cargos.Fec_Alta%TYPE ,
  v_cod_zonaimpo OUT Ge_ZonaCiudad.Cod_ZonaImpo%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_getgrpservi(
  v_cod_concepto IN Fa_GrpSerConc.Cod_Concepto%TYPE ,
  v_fec_alta IN date ,
  v_cod_grpservi OUT Fa_GrpSerConc.Cod_GrpServi%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_getimpuesto(
  v_cod_catimpos IN Ge_Impuestos.Cod_Catimpos%TYPE ,
  v_cod_zonaimpo IN Ge_Impuestos.Cod_ZonaImpo%TYPE ,
  v_cod_tipimpues IN Ge_Impuestos.Cod_TipImpues%TYPE ,
  v_cod_grpservi IN Ge_Impuestos.Cod_GrpServi%TYPE ,
  v_fec_alta IN date ,
  v_cod_concgene OUT Ge_Impuestos.Cod_ConcGene%TYPE ,
  v_prc_impuesto OUT Ge_Impuestos.Prc_Impuesto%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_ins_transacabo(
  v_num_transaccion IN number ,
  v_imp_traspaso IN number ,
  v_cod_moneda IN varchar2 ,
  v_sqlcode IN OUT number ,
  v_sqlerrm IN OUT varchar2 )
;
END fa_pack_traspaso;
/
SHOW ERRORS
