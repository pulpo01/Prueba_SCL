CREATE OR REPLACE PROCEDURE          "VE_P2_COMIS_VENTA_AMISTAR" (
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
  vp_procedure VARCHAR2(30):='VE_P2_venta_amistar';
  vp_tabla VARCHAR2(30):='VE_CUADRANTESLIQ';
  vp_accion VARCHAR2(1):='S';
  vp_sqlcode VARCHAR2(10);
  vp_sqlerrm VARCHAR2(70);
vp_num_total_ventas  NUMBER:=0;
vp_num_total_ventas_aux  NUMBER:=0;
vp_importe_por_venta NUMBER:=0;
vp_importe_total NUMBER:=0;
vp_importe_base VE_CUADRANTESLIQ.IMP_BASE%TYPE;
vp_cod_cuadrante ve_cuadrantesliq.cod_cuadrante%TYPE;
vp_cod_moneda GE_MONEDAS.COD_MONEDA%TYPE;
vp_meta VE_METAVEND.NUM_META%TYPE;
vp_ce VARCHAR2(2):='CE';
VP_IND_EQUIACC VARCHAR2(1):='E';
VP_IND_ESTVENTA VARCHAR2(2):='AC';
VP_COD_PLANTARIF VARCHAR2(3):= 'AMI';
BEGIN
SELECT COD_CUADRANTE, COD_MONEDA,IMP_BASE
INTO vp_cod_cuadrante,vp_cod_moneda,vp_importe_base
FROM VE_CUADRANTESLIQ
WHERE COD_CTOLIQ = vp_ctoliq AND
 COD_TIPCOMIS = vp_tip_vendedor AND
 FEC_EFECTIVIDAD < vp_fecha_inicial AND
 NVL(FEC_FINEFECTIVIDAD,SYSDATE) > vp_fecha_final AND
 ROWNUM =1
ORDER BY COD_CUADRANTE DESC;
IF vp_ind_nivel > 0 THEN
 SELECT COUNT(*)
 INTO vp_num_total_ventas_aux
 FROM GA_ABOCEL GA_ABOCEL,
  VE_VENDEDORES  VE_VENDEDORES,
  GA_VENTAS GA_VENTAS
 WHERE NOT EXISTS (SELECT ROWID
                    FROM GA_TRASPABO TRASP
                    WHERE TRASP.NUM_ABONADO = GA_ABOCEL.NUM_ABONADO) AND
  VE_VENDEDORES.COD_VENDEDOR = GA_VENTAS.COD_VENDEDOR  AND
  GA_ABOCEL.NUM_VENTA = GA_VENTAS.NUM_VENTA AND
  ga_ventas.fec_venta >= vp_fecha_inicial AND
  ga_ventas.fec_venta < vp_fecha_final AND
--  GA_VENTAS.IND_ESTVENTA =VP_IND_ESTVENTA AND     SE SACA ESTA CONDICION, siempre vtas.AMI estan aceptadas
  GA_ABOCEL.COD_PLANTARIF = VP_COD_PLANTARIF AND
  VE_VENDEDORES.COD_VENDE_RAIZ= vp_cod_vendedor ;
  vp_num_total_ventas:=vp_num_total_ventas+nvl(vp_num_total_ventas_aux,0);
 SELECT COUNT(*)
 INTO vp_num_total_ventas_aux
 FROM AL_CAB_BOLETA AL_CAB_BOLETA,
    AL_LIN_BOLETA AL_LIN_BOLETA,
    AL_SER_BOLETA AL_SER_BOLETA,
    AL_ARTICULOS AL_ARTICULOS,
    VE_VENDEDORES  VE_VENDEDORES
 WHERE AL_CAB_BOLETA.NUM_BOLETA = AL_LIN_BOLETA.NUM_BOLETA AND
    AL_LIN_BOLETA.NUM_BOLETA = AL_SER_BOLETA.NUM_BOLETA AND
    AL_LIN_BOLETA.NUM_LINEA = AL_SER_BOLETA.NUM_LINEA AND
    AL_LIN_BOLETA.COD_ARTICULO = AL_ARTICULOS.COD_ARTICULO AND
    AL_CAB_BOLETA.FEC_BOLETA >= vp_fecha_inicial AND
    AL_CAB_BOLETA.FEC_BOLETA < vp_fecha_final AND
    AL_CAB_BOLETA.COD_ESTADO=vp_ce AND
    AL_ARTICULOS.IND_EQUIACC=VP_IND_EQUIACC AND
    AL_ARTICULOS.COD_PRODUCTO=vp_producto AND
    AL_CAB_BOLETA.COD_VENDEDOR = VE_VENDEDORES.COD_VENDEDOR AND
    VE_VENDEDORES.COD_VENDE_RAIZ= vp_cod_vendedor;
    vp_num_total_ventas:=vp_num_total_ventas+nvl(vp_num_total_ventas_aux,0);
 SELECT COUNT(*)
 INTO vp_num_total_ventas_aux
 FROM AL_HCAB_BOLETA AL_HCAB_BOLETA,
    AL_HLIN_BOLETA AL_HLIN_BOLETA,
    AL_HSER_BOLETA AL_HSER_BOLETA,
    AL_ARTICULOS AL_ARTICULOS,
    VE_VENDEDORES  VE_VENDEDORES
 WHERE AL_HCAB_BOLETA.NUM_BOLETA = AL_HLIN_BOLETA.NUM_BOLETA AND
    AL_HCAB_BOLETA.FEC_HISTORICO = AL_HLIN_BOLETA.FEC_HISTORICO AND
    AL_HLIN_BOLETA.NUM_BOLETA = AL_HSER_BOLETA.NUM_BOLETA AND
    AL_HLIN_BOLETA.NUM_LINEA = AL_HSER_BOLETA.NUM_LINEA AND
    AL_HLIN_BOLETA.FEC_HISTORICO = AL_HSER_BOLETA.FEC_HISTORICO AND
    AL_HLIN_BOLETA.COD_ARTICULO = AL_ARTICULOS.COD_ARTICULO AND
    AL_HCAB_BOLETA.FEC_HISTORICO >= vp_fecha_inicial AND
    AL_HCAB_BOLETA.FEC_HISTORICO < vp_fecha_final AND
    AL_HCAB_BOLETA.COD_ESTADO=vp_ce AND
    AL_ARTICULOS.IND_EQUIACC=VP_IND_EQUIACC AND
    AL_ARTICULOS.COD_PRODUCTO=vp_producto AND
    AL_HCAB_BOLETA.COD_VENDEDOR = VE_VENDEDORES.COD_VENDEDOR AND
    VE_VENDEDORES.COD_VENDE_RAIZ= vp_cod_vendedor;
    vp_num_total_ventas:=vp_num_total_ventas+nvl(vp_num_total_ventas_aux,0);
ELSE
 SELECT COUNT(*)
 INTO vp_num_total_ventas_aux
 FROM GA_ABOCEL GA_ABOCEL,GA_VENTAS GA_VENTAS
 WHERE GA_VENTAS.COD_VENDEDOR = vp_cod_vendedor AND
  ga_ventas.fec_venta >= vp_fecha_inicial AND
  ga_ventas.fec_venta < vp_fecha_final AND
  GA_VENTAS.NUM_VENTA = GA_ABOCEL.NUM_VENTA AND
--  GA_VENTAS.IND_ESTVENTA =VP_IND_ESTVENTA  AND     SE SACA ESTA CONDICION, siempre vtas.AMI estan aceptadas
  GA_ABOCEL.COD_PLANTARIF = VP_COD_PLANTARIF;
  vp_num_total_ventas:=vp_num_total_ventas+nvl(vp_num_total_ventas_aux,0);
 SELECT COUNT(*)
 INTO vp_num_total_ventas_aux
 FROM AL_CAB_BOLETA AL_CAB_BOLETA,
    AL_LIN_BOLETA AL_LIN_BOLETA,
    AL_SER_BOLETA AL_SER_BOLETA,
    AL_ARTICULOS AL_ARTICULOS
 WHERE AL_CAB_BOLETA.NUM_BOLETA = AL_LIN_BOLETA.NUM_BOLETA AND
    AL_LIN_BOLETA.NUM_BOLETA = AL_SER_BOLETA.NUM_BOLETA AND
    AL_LIN_BOLETA.NUM_LINEA = AL_SER_BOLETA.NUM_LINEA AND
    AL_LIN_BOLETA.COD_ARTICULO = AL_ARTICULOS.COD_ARTICULO AND
    AL_CAB_BOLETA.FEC_BOLETA >= vp_fecha_inicial AND
    AL_CAB_BOLETA.FEC_BOLETA < vp_fecha_final AND
    AL_CAB_BOLETA.COD_ESTADO=vp_ce AND
    AL_ARTICULOS.IND_EQUIACC=VP_IND_EQUIACC AND
    AL_ARTICULOS.COD_PRODUCTO=vp_producto AND
    AL_CAB_BOLETA.COD_VENDEDOR = vp_cod_vendedor;
    vp_num_total_ventas:=vp_num_total_ventas+nvl(vp_num_total_ventas_aux,0);
 SELECT COUNT(*)
 INTO vp_num_total_ventas_aux
 FROM AL_HCAB_BOLETA AL_HCAB_BOLETA,
    AL_HLIN_BOLETA AL_HLIN_BOLETA,
    AL_HSER_BOLETA AL_HSER_BOLETA,
    AL_ARTICULOS AL_ARTICULOS
 WHERE AL_HCAB_BOLETA.NUM_BOLETA = AL_HLIN_BOLETA.NUM_BOLETA AND
    AL_HCAB_BOLETA.FEC_HISTORICO = AL_HLIN_BOLETA.FEC_HISTORICO AND
    AL_HLIN_BOLETA.NUM_BOLETA = AL_HSER_BOLETA.NUM_BOLETA AND
    AL_HLIN_BOLETA.NUM_LINEA = AL_HSER_BOLETA.NUM_LINEA AND
    AL_HLIN_BOLETA.FEC_HISTORICO = AL_HSER_BOLETA.FEC_HISTORICO AND
    AL_HLIN_BOLETA.COD_ARTICULO = AL_ARTICULOS.COD_ARTICULO AND
    AL_HCAB_BOLETA.FEC_HISTORICO >= vp_fecha_inicial AND
    AL_HCAB_BOLETA.FEC_HISTORICO < vp_fecha_final AND
    AL_HCAB_BOLETA.COD_ESTADO=vp_ce AND
    AL_ARTICULOS.IND_EQUIACC=VP_IND_EQUIACC AND
    AL_ARTICULOS.COD_PRODUCTO=vp_producto AND
    AL_HCAB_BOLETA.COD_VENDEDOR = vp_cod_vendedor;
    vp_num_total_ventas:=vp_num_total_ventas+nvl(vp_num_total_ventas_aux,0);
END IF;
vp_num_total_ventas:=NVL(vp_num_total_ventas,0);
vp_importe_por_venta:=0;
vp_importe_total:=0;
IF vp_num_total_ventas >0 THEN
   vp_tabla:='VE_CUADCOMIS';
   vp_mensaje:='Busqueda de rango para '||to_char(vp_num_total_ventas)||' Vendedor '||to_char(vp_cod_vendedor)||' Cuadrante '||to_char(vp_cod_cuadrante);
   SELECT IMP_RANGO
     INTO  vp_importe_por_venta
   FROM VE_CUADCOMIS
   WHERE COD_CUADRANTE = vp_cod_cuadrante AND
   vp_num_total_ventas BETWEEN IMP_DESDE AND IMP_HASTA;
   IF vp_producto = 1 THEN
   vp_importe_total:=vp_num_total_ventas*vp_importe_por_venta;
   ELSE
   vp_importe_total:=vp_importe_por_venta;
   END IF;
END IF;
vp_importe_total:=NVL(vp_importe_total,0);
VE_P2_cambia_moneda(vp_cod_moneda, vp_num_liquidacion, vp_fecha_inicial,vp_importe_total);
VE_P2_inserta_resultado(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_tip_vendedor,vp_fecha_inicial,vp_fecha_final,
vp_importe_total,vp_cod_cuadrante, 0,vp_num_total_ventas,0);
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
VE_P2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END VE_P2_comis_venta_amistar;
/
SHOW ERRORS
