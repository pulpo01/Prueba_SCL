CREATE OR REPLACE PROCEDURE          "VE_P2_COMIS_HABILITA_VOLUMEN" (
 vp_cod_vendedor IN VE_VENDEDORES.COD_VENDEDOR%TYPE,
 vp_num_liquidacion VE_CABLIQUIDAC.NUM_LIQUIDACION%TYPE,
 vp_producto IN GE_PRODUCTOS.COD_PRODUCTO%TYPE,
 vp_ctoliq  IN VE_CTOLIQ.COD_CTOLIQ%TYPE,
 vp_cod_tip_cuad IN VE_CTOLIQ.COD_TIPOCUAD%TYPE,
 vp_cat_vendedor IN VE_CATCOMIS.COD_CATCOMIS%TYPE,
 vp_tip_vendedor IN VE_TIPCOMIS.COD_TIPCOMIS%TYPE,
 vp_ind_nivel  IN  VE_CATCOMIS.IND_NIVEL%TYPE,
 vp_fecha_inicial IN DATE,
 vp_fecha_final   IN DATE,
 vp_num_habi_celu IN OUT NUMBER,
 vp_num_habi_beep IN OUT NUMBER,
 vp_num_habi_celu_meta IN OUT NUMBER
)
IS
  vp_mensaje VARCHAR2(120):=' ';
  vp_procedure VARCHAR2(30):='VE_P2_comis_habilita_volumen';
  vp_tabla VARCHAR2(30):='VE_CUADRANTESLIQ';
  vp_accion VARCHAR2(1):='S';
  vp_sqlcode VARCHAR2(10);
  vp_sqlerrm VARCHAR2(70);
vp_num_total_ventas  NUMBER;
vp_importe_por_venta NUMBER;
vp_importe_total NUMBER;
vp_importe_base VE_CUADRANTESLIQ.IMP_BASE%TYPE;
vp_cod_cuadrante ve_cuadrantesliq.cod_cuadrante%TYPE;
vp_cod_moneda GE_MONEDAS.COD_MONEDA%TYPE;
vp_meta VE_METAVEND.NUM_META%TYPE;
vp_rownum  number(1) := 1;
BEGIN
SELECT COD_CUADRANTE, COD_MONEDA,IMP_BASE
INTO vp_cod_cuadrante,vp_cod_moneda,vp_importe_base
FROM VE_CUADRANTESLIQ
WHERE COD_CTOLIQ = vp_ctoliq AND
 COD_TIPCOMIS = vp_tip_vendedor AND
 FEC_EFECTIVIDAD < vp_fecha_inicial AND
 NVL(FEC_FINEFECTIVIDAD,SYSDATE) > vp_fecha_final AND
 ROWNUM =vp_rownum
ORDER BY COD_CUADRANTE DESC;
IF vp_producto=1 THEN
 IF vp_num_habi_celu=-1  THEN
  VE_P2_calcula_habili_celular(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_cod_tip_cuad,vp_cat_vendedor,vp_tip_vendedor,vp_ind_nivel,vp_fecha_inicial,vp_fecha_final,vp_num_habi_celu,vp_num_habi_beep,vp_num_habi_celu_meta);
 END IF;
 vp_num_total_ventas:=vp_num_habi_celu;
END IF;
IF vp_producto=2 THEN
 IF vp_num_habi_beep=-1 THEN
  VE_P2_calcula_habili_beeper(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_cod_tip_cuad,vp_cat_vendedor,vp_tip_vendedor,vp_ind_nivel,vp_fecha_inicial,vp_fecha_final,vp_num_habi_celu,vp_num_habi_beep);
 END IF;
  vp_num_total_ventas:=vp_num_habi_beep;
END IF;
vp_num_total_ventas:=NVL(vp_num_total_ventas,0);
vp_importe_por_venta:=0;
vp_importe_total:=0;
IF vp_num_total_ventas >0 THEN
  vp_importe_total:=vp_num_total_ventas*vp_importe_base;
  vp_tabla:='VE_CUADCOMIS';
  vp_mensaje:='Busqueda de rango para '||to_char(vp_num_total_ventas)||' Vendedor '||to_char(vp_cod_vendedor)||' Cuadrante '||to_char(vp_cod_cuadrante);
  SELECT IMP_RANGO
     INTO  vp_importe_por_venta
   FROM VE_CUADCOMIS
   WHERE COD_CUADRANTE = vp_cod_cuadrante AND
   vp_num_total_ventas BETWEEN IMP_DESDE AND IMP_HASTA;
   vp_importe_total:=vp_importe_total+vp_importe_por_venta;
END IF;
VE_P2_cambia_moneda(vp_cod_moneda, vp_num_liquidacion, vp_fecha_inicial,vp_importe_por_venta);
VE_P2_inserta_resultado(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_tip_vendedor,vp_fecha_inicial,vp_fecha_final,
vp_importe_total,vp_cod_cuadrante, 0,vp_num_total_ventas,0);
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
VE_P2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END VE_P2_comis_habilita_volumen;
/
SHOW ERRORS
