CREATE OR REPLACE PROCEDURE        VE_P2_COMIS_PLAN_TARIFARIO(
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
  vp_mensaje VARCHAR2(120) := ' ';
  vp_procedure VARCHAR2(30):='VE_P2_comis_plan_tarifario';
  vp_tabla VARCHAR2(30) :='VE_CUADRANTESLIQ';
  vp_accion VARCHAR2(1) := 'S';
  vp_sqlcode VARCHAR2(10);
  vp_sqlerrm VARCHAR2(70);
vp_num_total_ventas  NUMBER;
vp_importe_total NUMBER;
vp_cod_cuadrante ve_cuadrantesliq.cod_cuadrante%TYPE;
vp_cod_moneda GE_MONEDAS.COD_MONEDA%TYPE;
vp_rownum number(1) := 1;
vp_AAA varchar2(3) := 'AAA';
vp_ABP varchar2(3) := 'ABP';
vp_ACP varchar2(3) := 'ACP';
vp_CNP varchar2(3) := 'CNP';
vp_CSP varchar2(3) := 'CSP';
vp_RTP varchar2(3) := 'RTP';
vp_CO  varchar2(2) := 'CO';
vp_PR  varchar2(2) := 'PR';
vp_AC  varchar2(2) := 'AC';
-- Se tomaran ventas de hace 4 meses para asegurar 3 MESES DE FACTURACION
vp_fecha_inicial2 date := ADD_MONTHS(vp_fecha_inicial,-4);
vp_fecha_final2 date := ADD_MONTHS(vp_fecha_final,-4);
BEGIN
SELECT COD_CUADRANTE, COD_MONEDA
 INTO vp_cod_cuadrante,vp_cod_moneda
 FROM VE_CUADRANTESLIQ
 WHERE COD_CTOLIQ = vp_ctoliq AND
  COD_TIPCOMIS = vp_tip_vendedor AND
  FEC_EFECTIVIDAD < vp_fecha_inicial AND
  NVL(FEC_FINEFECTIVIDAD,SYSDATE) > vp_fecha_final AND
  ROWNUM =vp_rownum
 ORDER BY COD_CUADRANTE DESC;
IF vp_ind_nivel > 0 THEN
 SELECT SUM(VE_CUADCATEG.IMP_CATEGORIA),count(*)
 INTO vp_importe_total,vp_num_total_ventas
 FROM VE_VENDEDORES VE_VENDEDORES,
  GA_ABOCEL GA_ABOCEL,
  GA_VENTAS GA_VENTAS,
--  GE_CLIENTES GE_CLIENTES,
  VE_CATPLANTARIF VE_CATPLANTARIF,
  VE_CUADCATEG VE_CUADCATEG
 WHERE GA_VENTAS.COD_VENDEDOR = VE_VENDEDORES.COD_VENDEDOR AND
  GA_ABOCEL.COD_SITUACION IN (vp_AAA, vp_ABP, vp_ACP, vp_CNP, vp_CSP, vp_RTP) AND
  GA_ABOCEL.COD_ESTADO IN (vp_CO, vp_PR) AND
  GA_ABOCEL.COD_PLANTARIF <> 'AMI' AND
  NOT EXISTS (SELECT ROWID
               FROM GA_TRASPABO GA_TRASPABO
               WHERE GA_TRASPABO.NUM_ABONADO = GA_ABOCEL.NUM_ABONADO) AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial2 AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final2 AND
  GA_VENTAS.NUM_VENTA = GA_ABOCEL.NUM_VENTA AND
  GA_VENTAS.IND_ESTVENTA = vp_AC AND
  GA_ABOCEL.COD_PLANTARIF = VE_CATPLANTARIF.COD_PLANTARIF AND
--  GE_CLIENTES.NUM_CELULAR = GA_ABOCEL.NUM_CELULAR AND
--  GE_CLIENTES.COD_CLIENTE  = GA_ABOCEL.COD_CLIENTE AND
  VE_CATPLANTARIF.COD_CATEGORIA = VE_CUADCATEG.COD_CATEGORIA AND
  VE_CUADCATEG.COD_CUADRANTE = vp_cod_cuadrante AND
  VE_CUADCATEG.IND_ARTICPLAN = vp_rownum AND
  VE_VENDEDORES.COD_VENDE_RAIZ = vp_cod_vendedor;
ELSE
 SELECT SUM(VE_CUADCATEG.IMP_CATEGORIA),count(*)
 INTO  vp_importe_total ,vp_num_total_ventas
 FROM GA_ABOCEL GA_ABOCEL,
--  GE_CLIENTES GE_CLIENTES,
  GA_VENTAS GA_VENTAS,
  VE_CATPLANTARIF VE_CATPLANTARIF,
  VE_CUADCATEG VE_CUADCATEG
 WHERE GA_ABOCEL.COD_VENDEDOR = vp_cod_vendedor AND
  GA_ABOCEL.COD_SITUACION IN (vp_AAA, vp_ABP, vp_ACP, vp_CNP, vp_CSP, vp_RTP) AND
  GA_ABOCEL.COD_ESTADO IN (vp_CO, vp_PR) AND
  GA_ABOCEL.COD_PLANTARIF <> 'AMI' AND
  NOT EXISTS (SELECT ROWID
               FROM GA_TRASPABO GA_TRASPABO
               WHERE GA_TRASPABO.NUM_ABONADO = GA_ABOCEL.NUM_ABONADO) AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial2 AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final2 AND
  GA_VENTAS.NUM_VENTA = GA_ABOCEL.NUM_VENTA AND
  GA_VENTAS.IND_ESTVENTA = vp_AC AND
--  GE_CLIENTES.NUM_CELULAR = GA_ABOCEL.NUM_CELULAR AND
--  GE_CLIENTES.COD_CLIENTE  = GA_ABOCEL.COD_CLIENTE AND
  VE_CATPLANTARIF.COD_CATEGORIA = VE_CUADCATEG.COD_CATEGORIA AND
  VE_CUADCATEG.COD_CUADRANTE = vp_cod_cuadrante AND
  VE_CUADCATEG.IND_ARTICPLAN = vp_rownum;
END IF;
vp_importe_total:=NVL(vp_importe_total,0);
VE_P2_cambia_moneda(vp_cod_moneda,vp_num_liquidacion,vp_fecha_inicial,vp_importe_total);
VE_P2_inserta_resultado(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_tip_vendedor,vp_fecha_inicial,vp_fecha_final,
  vp_importe_total,vp_cod_cuadrante, 0,vp_num_total_ventas,0);
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
VE_P2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END VE_P2_comis_plan_tarifario;
/
SHOW ERRORS
