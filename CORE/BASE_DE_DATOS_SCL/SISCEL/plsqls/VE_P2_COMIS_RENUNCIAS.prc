CREATE OR REPLACE PROCEDURE        VE_P2_COMIS_RENUNCIAS
(
 vp_cod_vendedor IN VE_VENDEDORES.COD_VENDEDOR%TYPE,
 vp_num_liquidacion VE_CABLIQUIDAC.NUM_LIQUIDACION%TYPE,
 vp_producto IN GE_PRODUCTOS.COD_PRODUCTO%TYPE,
 vp_ctoliq  IN VE_CTOLIQ.COD_CTOLIQ%TYPE,
 vp_cod_tip_cuad IN VE_CTOLIQ.COD_TIPOCUAD%TYPE,
 vp_cat_vendedor IN VE_CATCOMIS.COD_CATCOMIS%TYPE,
 vp_tip_vendedor IN VE_TIPCOMIS.COD_TIPCOMIS%TYPE,
 vp_ind_nivel  IN VE_CATCOMIS.IND_NIVEL%TYPE,
 vp_fecha_inicial IN DATE,
 vp_fecha_final   IN DATE,
 vp_num_habi_celu IN OUT NUMBER,
 vp_num_habi_beep IN OUT NUMBER
)
IS
  vp_mensaje VARCHAR2(120):=' ';
  vp_procedure VARCHAR2(30):='ve_p2_comis_renuncias';
  vp_tabla VARCHAR2(30);
  vp_accion VARCHAR2(1):='S';
  vp_sqlcode VARCHAR2(10);
  vp_sqlerrm VARCHAR2(70);
vp_num_total_ventas  NUMBER;
vp_importe_por_venta NUMBER;
vp_cod_cuadrante ve_cuadrantesliq.cod_cuadrante%TYPE;
vp_cod_moneda GE_MONEDAS.COD_MONEDA%TYPE;
BEGIN
--IF vp_ind_nivel > 0 THEN
-- NULL;
--ELSE
-- NULL;
--END IF;
ve_p2_inserta_resultado(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_tip_vendedor,vp_fecha_inicial,vp_fecha_final,
0,0,0,0,0);
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
ve_p2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END ve_p2_comis_renuncias;
/
SHOW ERRORS
