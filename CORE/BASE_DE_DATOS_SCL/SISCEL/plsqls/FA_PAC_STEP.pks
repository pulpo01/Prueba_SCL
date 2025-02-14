CREATE OR REPLACE PACKAGE        fa_pac_step IS
  --
  -- Retrofitted
  PROCEDURE p_main(
  v_proceso IN Fa_Procesos.Num_Proceso%TYPE ,
  v_tipdocum IN Ge_TipDocumen.Cod_TipDocum%TYPE ,
  v_cliente IN Ge_Clientes.Cod_Cliente%TYPE ,
  v_step IN varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_getgedatosgener(
  v_ge_datosgener OUT Ge_DatosGener%ROWTYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_step_contado(
  v_proceso IN OUT Fa_Procesos.Num_Proceso%TYPE ,
  v_step IN varchar2 ,
  v_sqlcode IN OUT number ,
  v_sqlerrm IN OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_step_notas(
  v_proceso IN OUT Fa_Procesos.Num_Proceso%TYPE ,
  v_step IN varchar2 ,
  v_sqlcode IN OUT number ,
  v_sqlerrm IN OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_step_baja(
  v_proceso OUT Fa_Procesos.Num_Proceso%TYPE ,
  v_step IN varchar2 ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_step_liquidacion(
  v_proceso OUT Fa_Procesos.Num_Proceso%TYPE ,
  v_step IN varchar2 ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_step_rentaphone(
  v_proceso OUT Fa_Procesos.Num_Proceso%TYPE ,
  v_step IN varchar2 ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_step_getcargos(
  rec_histcargos IN OUT Fa_HistCargos%ROWTYPE ,
  v_proceso IN Fa_Procesos.Num_Proceso%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_step_inscargos(
  rec_histcargos IN Fa_HistCargos%ROWTYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_step_ciclo(
  v_proceso IN OUT Fa_Procesos.Num_Proceso%TYPE ,
  v_cliente IN Ge_Clientes.Cod_Cliente%TYPE ,
  v_step IN varchar2 ,
  v_rec_ge_datosgener IN Ge_DatosGener%ROWTYPE ,
  v_sqlcode IN OUT number ,
  v_sqlerrm IN OUT varchar2 )
;
  --
  -- Retrofitted
  PROCEDURE p_step_update(
  v_cliente IN OUT Fa_CicloCli.Cod_Cliente%TYPE ,
  v_num_abonado IN OUT Fa_CicloCli.Num_Abonado%TYPE ,
  v_cod_producto IN OUT Fa_CicloCli.Cod_Producto%TYPE ,
  v_ind_cuotas IN OUT Ga_InfacCel.Ind_Cuotas%TYPE ,
  v_ind_arriendo IN OUT Ga_InfacCel.Ind_Cuotas%TYPE ,
  v_cod_ciclfact IN OUT Fa_CiclFact.Cod_CiclFact%TYPE )
;
END fa_pac_step;
/
SHOW ERRORS
