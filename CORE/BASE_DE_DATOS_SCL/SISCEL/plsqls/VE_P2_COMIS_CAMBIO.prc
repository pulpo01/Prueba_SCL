CREATE OR REPLACE PROCEDURE        VE_P2_COMIS_CAMBIO
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
  vp_procedure VARCHAR2(30):='ve_p2_comis_cambio';
  vp_tabla VARCHAR2(30):='VE_CUADRANTESLIQ';
  vp_accion VARCHAR2(1):='S';
  vp_sqlcode VARCHAR2(10);
  vp_sqlerrm VARCHAR2(70);
vp_num_total_ventas  NUMBER:=0;
vp_num_total_ventas_aux1  NUMBER;
vp_num_total_ventas_aux2  NUMBER;
vp_num_bajas NUMBER;
vp_importe_total NUMBER;
vp_importe_por_venta NUMBER;
vp_cod_cuadrante ve_cuadrantesliq.cod_cuadrante%TYPE;
vp_cod_moneda GE_MONEDAS.COD_MONEDA%TYPE;
vp_meta VE_METAVEND.NUM_META%TYPE;
vp_cat_sucursal VE_SUCURCATEG.COD_CATEGORIA%TYPE;
vp_rownum  number(1) := 1;
vp_ac   varchar2(2) := 'AC';
vp_e varchar2(1) := 'E';
vp_0 number(1) := 0;
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
vp_tabla:='VENDE-VENTAS-CARG-ART';
 SELECT SUM(gE_CARGOS.NUM_UNIDADES)
 INTO vp_num_total_ventas_aux1
 FROM VE_VENDEDORES  VE_VENDEDORES,
  GA_VENTAS  GA_VENTAS,
  gE_CARGOS  gE_CARGOS,
  AL_ARTICULOS  AL_ARTICULOS
 WHERE VE_VENDEDORES.COD_VENDEDOR = GA_VENTAS.COD_VENDEDOR  AND
  GA_VENTAS.NUM_VENTA = gE_CARGOS.NUM_VENTA AND
  GA_VENTAS.IND_ESTVENTA =vp_ac AND
  GA_VENTAS.IND_VENTA =vp_e AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final AND
  gE_CARGOS.COD_CONCEPTO = AL_ARTICULOS.COD_CONCEPTOART AND
  gE_CARGOS.IMP_CARGO > vp_0 AND
  AL_ARTICULOS.IND_EQUIACC=vp_e AND
  AL_ARTICULOS.COD_PRODUCTO=vp_producto AND
  VE_VENDEDORES.COD_VENDE_RAIZ= vp_cod_vendedor ;
 SELECT SUM(FA_HISTCARGOS.NUM_UNIDADES)
 INTO vp_num_total_ventas_aux2
 FROM VE_VENDEDORES  VE_VENDEDORES,
  GA_VENTAS  GA_VENTAS,
  FA_HISTCARGOS  FA_HISTCARGOS,
  AL_ARTICULOS  AL_ARTICULOS
 WHERE VE_VENDEDORES.COD_VENDEDOR = GA_VENTAS.COD_VENDEDOR  AND
  GA_VENTAS.NUM_VENTA = FA_HISTCARGOS.NUM_VENTA AND
  GA_VENTAS.IND_ESTVENTA =vp_ac AND
  GA_VENTAS.IND_VENTA =vp_e AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final AND
  FA_HISTCARGOS.COD_CONCEPTO = AL_ARTICULOS.COD_CONCEPTOART AND
  FA_HISTCARGOS.IMP_CARGO > vp_0 AND
  AL_ARTICULOS.IND_EQUIACC=vp_e AND
  AL_ARTICULOS.COD_PRODUCTO=vp_producto AND
  VE_VENDEDORES.COD_VENDE_RAIZ= vp_cod_vendedor ;
vp_num_total_ventas:=nvl(vp_num_total_ventas_aux1,0)+nvl(vp_num_total_ventas_aux2,0);
ELSE
vp_tabla:='VENTAS-CARG-ART';
 SELECT SUM(ge_cargos.NUM_UNIDADES)
 INTO vp_num_total_ventas_aux1
 FROM GA_VENTAS  GA_VENTAS,
  ge_cargos  ge_cargos,
  AL_ARTICULOS  AL_ARTICULOS
 WHERE GA_VENTAS.COD_VENDEDOR = vp_cod_vendedor  AND
  GA_VENTAS.NUM_VENTA = ge_cargos.NUM_VENTA AND
  GA_VENTAS.IND_ESTVENTA =vp_ac AND
  GA_VENTAS.IND_VENTA =vp_e AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final AND
  ge_cargos.COD_CONCEPTO = AL_ARTICULOS.COD_CONCEPTOART AND
  ge_cargos.IMP_CARGO > vp_0 AND
  AL_ARTICULOS.IND_EQUIACC=vp_e AND
  AL_ARTICULOS.COD_PRODUCTO=vp_producto;
 SELECT SUM(fa_histcargos.NUM_UNIDADES)
 INTO vp_num_total_ventas_aux2
 FROM GA_VENTAS  GA_VENTAS,
  fa_histcargos  fa_histcargos,
  AL_ARTICULOS  AL_ARTICULOS
 WHERE GA_VENTAS.COD_VENDEDOR = vp_cod_vendedor  AND
  GA_VENTAS.NUM_VENTA = fa_histcargos.NUM_VENTA AND
  GA_VENTAS.IND_ESTVENTA =vp_ac AND
  GA_VENTAS.IND_VENTA =vp_e AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final AND
  fa_histcargos.COD_CONCEPTO = AL_ARTICULOS.COD_CONCEPTOART AND
  fa_histcargos.IMP_CARGO > vp_0 AND
  AL_ARTICULOS.IND_EQUIACC=vp_e AND
  AL_ARTICULOS.COD_PRODUCTO=vp_producto;
vp_num_total_ventas:=nvl(vp_num_total_ventas_aux1,0)+nvl(vp_num_total_ventas_aux2,0);
END IF;
vp_num_total_ventas:=NVL(vp_num_total_ventas,0);
vp_importe_total:=0;
IF vp_num_total_ventas > 0 THEN
   vp_tabla:='VE_CUADCOMIS';
   vp_mensaje:='Busqueda de rango para '||to_char(vp_num_total_ventas)||' Vendedor '||to_char(vp_cod_vendedor)||' Cuadrante '||to_char(vp_cod_cuadrante);
   SELECT IMP_RANGO
    INTO  vp_importe_por_venta
    FROM VE_CUADCOMIS
    WHERE COD_CUADRANTE = vp_cod_cuadrante AND
    vp_num_total_ventas BETWEEN IMP_DESDE AND IMP_HASTA;
       vp_importe_total:= vp_importe_por_venta*vp_num_total_ventas;
END IF;
ve_p2_cambia_moneda(vp_cod_moneda, vp_num_liquidacion, vp_fecha_inicial,vp_importe_total);
ve_p2_inserta_resultado(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_tip_vendedor,vp_fecha_inicial,vp_fecha_final,
vp_importe_total,vp_cod_cuadrante,vp_meta,vp_num_total_ventas,0);
EXCEPTION
WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
ve_p2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END ve_p2_comis_cambio;
/
SHOW ERRORS
