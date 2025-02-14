CREATE OR REPLACE PROCEDURE        VE_P2_COMIS_ARRIENDO
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
  vp_procedure VARCHAR2(30):='ve_p2_comis_arriendo';
  vp_tabla VARCHAR2(30):='VE_CUADRANTESLIQ';
  vp_accion VARCHAR2(1):='S';
  vp_sqlcode VARCHAR2(10);
  vp_sqlerrm VARCHAR2(70);
vp_num_total_ventas  NUMBER;
vp_importe_total NUMBER;
vp_num_total_ventas_aux1  NUMBER;
vp_importe_total_aux1 NUMBER;
vp_num_total_ventas_aux2  NUMBER;
vp_importe_total_aux2 NUMBER;
vp_porcentaje NUMBER;
vp_cod_cuadrante ve_cuadrantesliq.cod_cuadrante%TYPE;
vp_cod_moneda GE_MONEDAS.COD_MONEDA%TYPE;
vp_rownum  number(1) := 1;
vp_ac     varchar2(2) := 'AC';
vp_r  varchar2(1) := 'R';
BEGIN
SELECT COD_CUADRANTE, COD_MONEDA
 INTO vp_cod_cuadrante,vp_cod_moneda
 FROM VE_CUADRANTESLIQ
 WHERE COD_CTOLIQ = vp_ctoliq AND
  COD_TIPCOMIS = vp_tip_vendedor AND
  FEC_EFECTIVIDAD < vp_fecha_inicial AND
  NVL(FEC_FINEFECTIVIDAD,SYSDATE) > vp_fecha_final AND
  ROWNUM = vp_rownum
 ORDER BY COD_CUADRANTE DESC;
IF vp_ind_nivel > 0 THEN
 SELECT SUM(GE_CARGOS.IMP_CARGO),count(*)
 INTO vp_importe_total_aux1,vp_num_total_ventas_aux1
 FROM GA_VENTAS  GA_VENTAS,
  GE_CARGOS  GE_CARGOS,
  VE_VENDEDORES VE_VENDEDORES
 WHERE GA_VENTAS.COD_VENDEDOR = VE_VENDEDORES.COD_VENDEDOR  AND
  GA_VENTAS.NUM_VENTA = GE_CARGOS.NUM_VENTA AND
  GA_VENTAS.IND_ESTVENTA =vp_ac AND
  GA_VENTAS.IND_VENTA =vp_r AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final AND
  VE_VENDEDORES.COD_VENDE_RAIZ=vp_cod_vendedor;
 SELECT SUM(FA_HISTCARGOS.IMP_CARGO),count(*)
 INTO vp_importe_total_aux2,vp_num_total_ventas_aux2
 FROM GA_VENTAS  GA_VENTAS,
  FA_HISTCARGOS  FA_HISTCARGOS,
  VE_VENDEDORES VE_VENDEDORES
 WHERE GA_VENTAS.COD_VENDEDOR = VE_VENDEDORES.COD_VENDEDOR  AND
  GA_VENTAS.NUM_VENTA = FA_HISTCARGOS.NUM_VENTA AND
  GA_VENTAS.IND_ESTVENTA =vp_ac AND
  GA_VENTAS.IND_VENTA =vp_r AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final AND
  VE_VENDEDORES.COD_VENDE_RAIZ=vp_cod_vendedor;
vp_importe_total:=nvl(vp_importe_total_aux1,0)+nvl(vp_importe_total_aux2,0);
vp_num_total_ventas:=nvl(vp_num_total_ventas_aux1,0)+nvl(vp_num_total_ventas_aux2,0);
ELSE
 SELECT SUM(GE_CARGOS.IMP_CARGO),count(*)
 INTO vp_importe_total_aux1,vp_num_total_ventas_aux1
 FROM GA_VENTAS  GA_VENTAS,
  GE_CARGOS  GE_CARGOS
 WHERE GA_VENTAS.COD_VENDEDOR = vp_cod_vendedor  AND
  GA_VENTAS.NUM_VENTA = GE_CARGOS.NUM_VENTA AND
  GA_VENTAS.IND_ESTVENTA =vp_ac AND
  GA_VENTAS.IND_VENTA =vp_r AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final;
 SELECT SUM(FA_HISTCARGOS.IMP_CARGO),count(*)
 INTO vp_importe_total_aux2,vp_num_total_ventas_aux2
 FROM GA_VENTAS  GA_VENTAS,
  FA_HISTCARGOS  FA_HISTCARGOS
 WHERE GA_VENTAS.COD_VENDEDOR = vp_cod_vendedor  AND
  GA_VENTAS.NUM_VENTA = FA_HISTCARGOS.NUM_VENTA AND
  GA_VENTAS.IND_ESTVENTA =vp_ac AND
  GA_VENTAS.IND_VENTA =vp_r AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final;
vp_importe_total:=nvl(vp_importe_total_aux1,0)+nvl(vp_importe_total_aux2,0);
vp_num_total_ventas:=nvl(vp_num_total_ventas_aux1,0)+nvl(vp_num_total_ventas_aux2,0);
END IF;
vp_importe_total:=NVL(vp_importe_total,0);
vp_tabla:='VE_CUADCOMIS';
IF vp_importe_total > 0 THEN
vp_tabla:='VE_CUADCOMIS';
vp_mensaje:='Busqueda de rango para '||to_char(vp_importe_total)||' Vendedor '||to_char(vp_cod_vendedor)||' Cuadrante '||to_char(vp_cod_cuadrante);
SELECT IMP_RANGO
 INTO vp_porcentaje
 FROM VE_CUADCOMIS
 WHERE COD_CUADRANTE = vp_cod_cuadrante AND
 vp_importe_total BETWEEN IMP_DESDE AND IMP_HASTA;
ELSE
vp_porcentaje:=0;
END IF;
vp_importe_total:=vp_importe_total*100.0/vp_porcentaje;
ve_p2_cambia_moneda(vp_cod_moneda, vp_num_liquidacion, vp_fecha_inicial,vp_importe_total);
ve_p2_inserta_resultado(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_tip_vendedor,vp_fecha_inicial,vp_fecha_final,
vp_importe_total,vp_cod_cuadrante,0,vp_num_total_ventas,0);
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
ve_p2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END ve_p2_comis_arriendo;
/
SHOW ERRORS
