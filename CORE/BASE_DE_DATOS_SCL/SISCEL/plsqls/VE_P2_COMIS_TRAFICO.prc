CREATE OR REPLACE PROCEDURE        VE_P2_COMIS_TRAFICO
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
  vp_procedure VARCHAR2(30):='ve_p2_comis_trafico';
  vp_tabla VARCHAR2(30):='VE_CUADRANTESLIQ';
  vp_accion VARCHAR2(1):='S';
  vp_sqlcode VARCHAR2(10);
  vp_sqlerrm VARCHAR2(70);
vp_importe_total NUMBER;
vp_cod_cuadrante NUMBER;
vp_cod_moneda GE_MONEDAS.COD_MONEDA%TYPE;
vp_porcentaje NUMBER;
vp_num_meses NUMBER;
vp_cod_vendedor_aux VE_VENDEDORES.COD_VENDEDOR%TYPE;
vp_cod_cliente_aux GA_ABOCEL.COD_CLIENTE%TYPE;
vp_num_abonado_aux GA_ABOCEL.NUM_ABONADO%TYPE;
vp_ind_ordentotal_aux FA_HISTDOCU.IND_ORDENTOTAL%TYPE;
vp_importe_consumo_aux NUMBER;
vp_importe_cargo_basico_aux NUMBER;
vp_num_total_clientes NUMBER:=0;
vp_AAA VARCHAR2(3):='AAA';
vp_STP VARCHAR2(3):='STP';
vp_RTP VARCHAR2(3):='RTP';
vp_CNP VARCHAR2(3):='CNP';
vp_CSP VARCHAR2(3):='CSP';
vp_ABP VARCHAR2(3):='ABP';
vp_SAA VARCHAR2(3):='SAA';
vp_CO VARCHAR2(2):='CO';
vp_PR VARCHAR2(2):='PR';
vp_AC VARCHAR2(2):='AC';
vp_1 NUMBER:=1;
vp_25 NUMBER:=25;
CURSOR c_vtoliq IS
 SELECT  VE_VENDEDORES.COD_VENDEDOR
 FROM  VE_VENDEDORES
 WHERE  VE_VENDEDORES.COD_VENDE_RAIZ=vp_cod_vendedor;
CURSOR c_atoliq IS
 SELECT  GA_ABOCEL.NUM_ABONADO,GA_ABOCEL.COD_CLIENTE
 FROM  GA_ABOCEL,GA_VENTAS
 WHERE  GA_VENTAS.COD_VENDEDOR=vp_cod_vendedor_aux AND
  GA_VENTAS.NUM_VENTA = GA_ABOCEL.NUM_VENTA AND
  GA_VENTAS.IND_ESTVENTA =vp_AC AND
  ADD_MONTHS(GA_VENTAS.FEC_ACEPREC,vp_num_meses) >= vp_fecha_inicial AND
  GA_ABOCEL.COD_SITUACION IN (vp_AAA,vp_STP,vp_RTP,vp_CNP,vp_CSP,vp_ABP,vp_SAA) AND
  GA_ABOCEL.COD_ESTADO IN (vp_CO,vp_PR);
CURSOR c_ftoliq IS
 SELECT  FA_HISTDOCU.IND_ORDENTOTAL
 FROM  FA_HISTDOCU
 WHERE  FA_HISTDOCU.COD_CLIENTE = vp_cod_cliente_aux  AND
  ADD_MONTHS(FA_HISTDOCU.FEC_EMISION,vp_1) >= vp_fecha_inicial AND
  ADD_MONTHS(FA_HISTDOCU.FEC_EMISION,vp_1) < vp_fecha_final;
BEGIN
SELECT COD_CUADRANTE, COD_MONEDA,NUM_LIMITE,IMP_BASE
 INTO vp_cod_cuadrante,vp_cod_moneda,vp_num_meses,vp_porcentaje
 FROM VE_CUADRANTESLIQ
 WHERE COD_CTOLIQ = vp_ctoliq AND
  COD_TIPCOMIS = vp_tip_vendedor AND
  FEC_EFECTIVIDAD < vp_fecha_inicial AND
  NVL(FEC_FINEFECTIVIDAD,SYSDATE) > vp_fecha_final AND
  ROWNUM =vp_1
 ORDER BY COD_CUADRANTE DESC;
vp_importe_total:=0;
IF vp_ind_nivel > 0 THEN
OPEN c_vtoliq;
 LOOP
 FETCH c_vtoliq INTO  vp_cod_vendedor_aux;
 EXIT WHEN c_vtoliq%NOTFOUND;
 OPEN c_atoliq;
  LOOP
  FETCH c_atoliq INTO  vp_num_abonado_aux,vp_cod_cliente_aux;
  EXIT WHEN c_atoliq%NOTFOUND;
  OPEN c_ftoliq;
   LOOP
   FETCH c_ftoliq INTO  vp_ind_ordentotal_aux;
   EXIT WHEN c_ftoliq%NOTFOUND;
   SELECT SUM(FA_HISTCONCCELU.IMP_FACTURABLE)
    INTO vp_importe_cargo_basico_aux
    FROM FA_HISTCONCCELU, VE_FACCTO
    WHERE FA_HISTCONCCELU.IND_ORDENTOTAL= vp_ind_ordentotal_aux AND
     FA_HISTCONCCELU.NUM_ABONADO= vp_num_abonado_aux AND
     FA_HISTCONCCELU.COD_CONCEPTO = VE_FACCTO.COD_CONCEPTO;
     vp_importe_cargo_basico_aux:=NVL(vp_importe_cargo_basico_aux,0);
   vp_importe_total:=vp_importe_total+vp_importe_cargo_basico_aux;
   vp_num_total_clientes:=vp_num_total_clientes+1;
  END LOOP;
  CLOSE c_ftoliq;
 END LOOP;
 CLOSE c_atoliq;
END LOOP;
CLOSE c_vtoliq;
END IF;
ve_p2_inserta_resultado(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_tip_vendedor,vp_fecha_inicial,vp_fecha_final,
NVL(vp_importe_total,0)*vp_porcentaje/100.0,vp_cod_cuadrante,0,vp_num_total_clientes,vp_num_meses);
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
ve_p2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END ve_p2_comis_trafico;
/
SHOW ERRORS
