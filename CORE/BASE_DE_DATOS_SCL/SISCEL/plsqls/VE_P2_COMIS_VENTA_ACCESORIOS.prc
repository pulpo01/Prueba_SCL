CREATE OR REPLACE PROCEDURE        VE_P2_COMIS_VENTA_ACCESORIOS
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
 vp_fecha_final IN DATE,
 vp_num_habi_celu IN OUT NUMBER,
 vp_num_habi_beep IN OUT NUMBER
)
IS
  vp_mensaje VARCHAR2(120):=' ';
  vp_procedure VARCHAR2(30):='VE_P2_comis_venta_accesorios';
  vp_tabla VARCHAR2(30):='VE_CUADRANTESLIQ';
  vp_accion VARCHAR2(1):='S';
  vp_sqlcode VARCHAR2(10);
  vp_sqlerrm VARCHAR2(70);
vp_num_bajas NUMBER;
vp_importe_total NUMBER;
vp_num_total_ventas  NUMBER;
vp_importe_total_aux1 NUMBER;
vp_importe_total_aux2 NUMBER;
vp_num_total_ventas_aux1  NUMBER;
vp_num_total_ventas_aux2  NUMBER;
vp_importe_por_venta NUMBER;
vp_porcentaje NUMBER;
vp_cod_cuadrante ve_cuadrantesliq.cod_cuadrante%TYPE;
vp_cod_moneda GE_MONEDAS.COD_MONEDA%TYPE;
vp_meta VE_METAVEND.NUM_META%TYPE;
vp_IND_ESTVENTA VARCHAR2(2):='AC';
vp_IND_VENTA VARCHAR2(1):='V';
VP_IND_EQUIACC VARCHAR2(1):='A';
BEGIN
SELECT COD_CUADRANTE, COD_MONEDA
 INTO vp_cod_cuadrante,vp_cod_moneda
 FROM VE_CUADRANTESLIQ
 WHERE COD_CTOLIQ = vp_ctoliq AND
  COD_TIPCOMIS = vp_tip_vendedor AND
  FEC_EFECTIVIDAD < vp_fecha_inicial AND
  NVL(FEC_FINEFECTIVIDAD,SYSDATE) > vp_fecha_final AND
  ROWNUM =1
 ORDER BY COD_CUADRANTE DESC;
IF vp_ind_nivel > 0 THEN
 SELECT SUM(FA_HISTCARGOS.IMP_CARGO*FA_HISTCARGOS.NUM_UNIDADES),SUM(FA_HISTCARGOS.NUM_UNIDADES)
 INTO vp_importe_total_aux1, vp_num_total_ventas_aux1
 FROM VE_ACC_NOSUBSID VE_ACC_NOSUBSID,
  GA_VENTAS  GA_VENTAS,
  FA_HISTCARGOS  FA_HISTCARGOS,
  AL_ARTICULOS  AL_ARTICULOS,
  VE_VENDEDORES VE_VENDEDORES
 WHERE GA_VENTAS.COD_VENDEDOR = VE_VENDEDORES.COD_VENDEDOR  AND
  GA_VENTAS.NUM_VENTA = FA_HISTCARGOS.NUM_VENTA AND
  GA_VENTAS.IND_ESTVENTA =vp_IND_ESTVENTA AND
  GA_VENTAS.IND_VENTA =vp_IND_VENTA AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final AND
  FA_HISTCARGOS.COD_CONCEPTO = AL_ARTICULOS.COD_CONCEPTOART AND
  VE_ACC_NOSUBSID.COD_ARTICULO IS NULL AND                                  /* los accesorios NO */
  AL_ARTICULOS.COD_ARTICULO = VE_ACC_NOSUBSID.COD_ARTICULO(+) AND /* deben existir en  */
  AL_ARTICULOS.COD_PRODUCTO = VE_ACC_NOSUBSID.COD_PRODUCTO(+) AND /* VE_ACC_NOSUBSID   */
  AL_ARTICULOS.IND_EQUIACC=VP_IND_EQUIACC AND
  AL_ARTICULOS.COD_PRODUCTO=vp_producto AND
  VE_VENDEDORES.COD_VENDE_RAIZ=vp_cod_vendedor;
 SELECT SUM(GE_CARGOS.IMP_CARGO*GE_CARGOS.NUM_UNIDADES),SUM(GE_CARGOS.NUM_UNIDADES)
 INTO vp_importe_total_aux2, vp_num_total_ventas_aux2
 FROM VE_ACC_NOSUBSID VE_ACC_NOSUBSID,
  GA_VENTAS  GA_VENTAS,
  GE_CARGOS  GE_CARGOS,
  AL_ARTICULOS  AL_ARTICULOS,
  VE_VENDEDORES VE_VENDEDORES
 WHERE GA_VENTAS.COD_VENDEDOR = VE_VENDEDORES.COD_VENDEDOR  AND
  GA_VENTAS.NUM_VENTA = GE_CARGOS.NUM_VENTA AND
  GA_VENTAS.IND_ESTVENTA =vp_IND_ESTVENTA AND
  GA_VENTAS.IND_VENTA =vp_IND_VENTA AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final AND
  GE_CARGOS.COD_CONCEPTO = AL_ARTICULOS.COD_CONCEPTOART AND
  VE_ACC_NOSUBSID.COD_ARTICULO IS NULL AND                                          /* los accesorios NO */
  AL_ARTICULOS.COD_ARTICULO = VE_ACC_NOSUBSID.COD_ARTICULO(+) AND /* deben existir en  */
  AL_ARTICULOS.COD_PRODUCTO = VE_ACC_NOSUBSID.COD_PRODUCTO(+) AND /* VE_ACC_NOSUBSID   */
  AL_ARTICULOS.IND_EQUIACC=VP_IND_EQUIACC AND
  AL_ARTICULOS.COD_PRODUCTO=vp_producto AND
  VE_VENDEDORES.COD_VENDE_RAIZ=vp_cod_vendedor;
  vp_importe_total:=NVL(vp_importe_total_aux1,0)+NVL(vp_importe_total_aux2,0);
  vp_num_total_ventas:=NVL(vp_num_total_ventas_aux1,0)+NVL(vp_num_total_ventas_aux2,0);
ELSE
 SELECT SUM(FA_HISTCARGOS.IMP_CARGO*FA_HISTCARGOS.NUM_UNIDADES),SUM(FA_HISTCARGOS.NUM_UNIDADES)
 INTO vp_importe_total_aux1, vp_num_total_ventas_aux1
 FROM VE_ACC_NOSUBSID VE_ACC_NOSUBSID,
  GA_VENTAS  GA_VENTAS,
  FA_HISTCARGOS FA_HISTCARGOS,
  AL_ARTICULOS  AL_ARTICULOS
 WHERE GA_VENTAS.COD_VENDEDOR = vp_cod_vendedor  AND
  GA_VENTAS.NUM_VENTA = FA_HISTCARGOS.NUM_VENTA AND
  GA_VENTAS.IND_ESTVENTA =vp_IND_ESTVENTA AND
  GA_VENTAS.IND_VENTA =vp_IND_VENTA AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final AND
  FA_HISTCARGOS.COD_CONCEPTO = AL_ARTICULOS.COD_CONCEPTOART AND
  VE_ACC_NOSUBSID.COD_ARTICULO IS NULL AND                                              /* los accesorios NO */
  AL_ARTICULOS.COD_ARTICULO = VE_ACC_NOSUBSID.COD_ARTICULO(+) AND /* deben existir en  */
  AL_ARTICULOS.COD_PRODUCTO = VE_ACC_NOSUBSID.COD_PRODUCTO(+) AND /* VE_ACC_NOSUBSID   */
  AL_ARTICULOS.COD_PRODUCTO=vp_producto AND
  AL_ARTICULOS.IND_EQUIACC=VP_IND_EQUIACC;
 SELECT SUM(GE_CARGOS.IMP_CARGO*GE_CARGOS.NUM_UNIDADES),SUM(GE_CARGOS.NUM_UNIDADES)
 INTO vp_importe_total_aux2, vp_num_total_ventas_aux2
 FROM VE_ACC_NOSUBSID VE_ACC_NOSUBSID,
  GA_VENTAS  GA_VENTAS,
  GE_CARGOS  GE_CARGOS,
  AL_ARTICULOS  AL_ARTICULOS
 WHERE GA_VENTAS.COD_VENDEDOR = vp_cod_vendedor  AND
  GA_VENTAS.NUM_VENTA = GE_CARGOS.NUM_VENTA AND
  GA_VENTAS.IND_ESTVENTA =vp_IND_ESTVENTA AND
  GA_VENTAS.IND_VENTA =vp_IND_VENTA AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final AND
  GE_CARGOS.COD_CONCEPTO = AL_ARTICULOS.COD_CONCEPTOART AND
  VE_ACC_NOSUBSID.COD_ARTICULO IS NULL AND                                          /* los accesorios NO */
  AL_ARTICULOS.COD_ARTICULO = VE_ACC_NOSUBSID.COD_ARTICULO(+) AND /* deben existir en  */
  AL_ARTICULOS.COD_PRODUCTO = VE_ACC_NOSUBSID.COD_PRODUCTO(+) AND /* VE_ACC_NOSUBSID   */
  AL_ARTICULOS.COD_PRODUCTO=vp_producto AND
  AL_ARTICULOS.IND_EQUIACC=VP_IND_EQUIACC;
  vp_importe_total:=NVL(vp_importe_total_aux1,0)+NVL(vp_importe_total_aux2,0);
  vp_num_total_ventas:=NVL(vp_num_total_ventas_aux1,0)+NVL(vp_num_total_ventas_aux2,0);
END IF;
vp_importe_total:=NVL(vp_importe_total,0);
vp_num_total_ventas:=NVL(vp_num_total_ventas,0);
vp_tabla:='VE_CUADCOMIS';
IF vp_importe_total > 0 AND vp_num_total_ventas > 0 THEN
  IF vp_cod_tip_cuad = '2212' THEN  -- u u %
   vp_tabla:='VE_CUADCOMIS';
   vp_mensaje:='Busqueda de rango para '||to_char(vp_num_total_ventas)||' Vendedor '||to_char(vp_cod_vendedor)||' Cuadrante '||to_char(vp_cod_cuadrante);
        SELECT IMP_RANGO
         INTO vp_porcentaje
         FROM VE_CUADCOMIS
         WHERE COD_CUADRANTE = vp_cod_cuadrante AND
          vp_num_total_ventas BETWEEN IMP_DESDE AND IMP_HASTA;
          vp_importe_total:=vp_importe_total*vp_porcentaje/100;
  ELSE
    vp_importe_total:=0;
  END IF;
ELSE
vp_importe_total:=0;
END IF;
VE_P2_cambia_moneda(vp_cod_moneda, vp_num_liquidacion, vp_fecha_inicial,vp_importe_total);
VE_P2_inserta_resultado(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_tip_vendedor,vp_fecha_inicial,vp_fecha_final,
vp_importe_total,vp_cod_cuadrante, vp_meta,vp_num_total_ventas,0);
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
VE_P2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END VE_P2_comis_venta_accesorios;
/
SHOW ERRORS
