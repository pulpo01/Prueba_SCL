CREATE OR REPLACE PROCEDURE        VE_P2_COMIS_PREMIOS
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
 vp_num_habi_beep IN OUT NUMBER,
 vp_num_habi_celu_meta IN OUT NUMBER
)
IS
  vp_mensaje VARCHAR2(120):=' ';
  vp_procedure VARCHAR2(30):='VE_P2_comis_premios';
  vp_tabla VARCHAR2(30):='VE_CUADRANTESLIQ';
  vp_accion VARCHAR2(1):='S';
  vp_sqlcode VARCHAR2(10);
  vp_sqlerrm VARCHAR2(70);
vp_var NUMBER;
vp_num_total_ventas NUMBER:=0;
vp_num_bajas NUMBER;
vp_importe_total NUMBER:=0;
vp_importe_por_venta NUMBER;
vp_cod_cuadrante ve_cuadrantesliq.cod_cuadrante%TYPE;
vp_cod_moneda GE_MONEDAS.COD_MONEDA%TYPE;
vp_meta VE_METAVEND.NUM_META%TYPE;
vp_cat_sucursal VE_SUCURCATEG.COD_CATEGORIA%TYPE;
vp_variable NUMBER;
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
vp_tabla:='VE_METAVEND';
vp_mensaje:='Busqueda de meta para vendedor '||to_char(vp_cod_vendedor)||' y producto '||to_char(vp_producto);
SELECT VE_METAVEND.NUM_META
 INTO vp_meta
 FROM VE_METAVEND VE_METAVEND
 WHERE VE_METAVEND.COD_TIPCOMIS= vp_tip_vendedor AND
       VE_METAVEND.COD_PRODUCTO =  vp_producto AND
       VE_METAVEND.FEC_VALOR < vp_fecha_final AND
       nvl(VE_METAVEND.FEC_FINVALOR,to_date('99991231','YYYYMMDD')) >= vp_fecha_final AND
       VE_METAVEND.COD_VENDEDOR =  vp_cod_vendedor;
IF vp_producto = 1 THEN
   IF vp_num_habi_celu=-1 THEN
      VE_P2_calcula_habili_celular(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_cod_tip_cuad,vp_cat_vendedor,vp_tip_vendedor,vp_ind_nivel,vp_fecha_inicial,vp_fecha_final,vp_num_habi_celu,vp_num_habi_beep,vp_num_habi_celu_meta);
   END IF;
   vp_num_total_ventas:=vp_num_habi_celu_meta;
   IF vp_cat_vendedor != 1 THEN
      IF vp_num_habi_beep=-1  THEN
         VE_P2_calcula_habili_beeper(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_cod_tip_cuad,vp_cat_vendedor,vp_tip_vendedor,vp_ind_nivel,vp_fecha_inicial,vp_fecha_final,vp_num_habi_celu,vp_num_habi_beep);
      END IF;
      vp_num_total_ventas:=vp_num_total_ventas+TRUNC(vp_num_habi_beep/2.0);
   END IF;
END IF;
IF vp_producto = 2 THEN
   IF vp_num_habi_beep=-1  THEN
      VE_P2_calcula_habili_beeper(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_cod_tip_cuad,vp_cat_vendedor,vp_tip_vendedor,vp_ind_nivel,vp_fecha_inicial,vp_fecha_final,vp_num_habi_celu,vp_num_habi_beep);
   END IF;
   vp_num_total_ventas:=vp_num_habi_beep;
END IF;
vp_importe_total:=0;
vp_mensaje:='Busqueda de rango para '||to_char(vp_num_total_ventas)||' Vendedor '||to_char(vp_cod_vendedor)||' Cuadrante '||to_char(vp_cod_cuadrante);
IF vp_num_total_ventas > 0 THEN
   IF vp_cod_tip_cuad = '2202' THEN  -- u u $
      vp_tabla:='VE_CUADCOMIS';
      vp_mensaje:='Busqueda de rango para '||to_char(vp_num_total_ventas)||' Vendedor '||to_char(vp_cod_vendedor)||' Cuadrante '||to_char(vp_cod_cuadrante);
      SELECT IMP_RANGO
       INTO  vp_importe_por_venta
       FROM VE_CUADCOMIS
       WHERE COD_CUADRANTE = vp_cod_cuadrante AND
             vp_num_total_ventas BETWEEN IMP_DESDE AND IMP_HASTA;
      IF vp_num_total_ventas >= vp_meta THEN
         IF vp_cat_vendedor = 1 THEN --- MASTER DEALER
            vp_importe_total:= vp_importe_por_venta*vp_num_total_ventas;
         ELSE
            vp_importe_total:= vp_importe_por_venta*vp_meta;
         END IF;
      ELSE
         vp_importe_total:=0;
      END IF;
   ELSE  ---   % % $
      vp_importe_total:=0;
      vp_variable:=TRUNC(vp_num_total_ventas*100.0/vp_meta,2);
      IF vp_variable >= 1 THEN
         IF vp_tip_vendedor IN ('3', '22') THEN --- REP VENTA STARTEL Y EX-VTRCATEGORIAS DE SUCURSAL
            vp_tabla:='VE_SUCURCATEG-VE_CUADCOMIS';
            vp_mensaje:='Busqueda de rango % para '||to_char(vp_variable)||' Vendedor '||to_char(vp_cod_vendedor)||' Cuadrante '||to_char(vp_cod_cuadrante);
            SELECT IMP_RANGO
             INTO vp_importe_por_venta
             FROM VE_CUADCOMIS VE_CUADCOMIS
             WHERE vp_meta BETWEEN VE_CUADCOMIS.NUM_DESDE AND VE_CUADCOMIS.NUM_HASTA AND
                   vp_variable BETWEEN VE_CUADCOMIS.IMP_DESDE AND VE_CUADCOMIS.IMP_HASTA AND
                   VE_CUADCOMIS.COD_CUADRANTE = vp_cod_cuadrante;
            vp_importe_total:= vp_importe_por_venta;
         ELSE
            vp_tabla:='VE_CUADCOMIS';
            vp_mensaje:='Busqueda de rango % para '||to_char(vp_variable)||' Vendedor '||to_char(vp_cod_vendedor)||' Cuadrante '||to_char(vp_cod_cuadrante);
            SELECT IMP_RANGO
             INTO  vp_importe_por_venta
             FROM VE_CUADCOMIS
             WHERE COD_CUADRANTE = vp_cod_cuadrante AND
                   vp_variable  BETWEEN IMP_DESDE AND IMP_HASTA;
            IF vp_cat_vendedor = 1 THEN --- DEALER
               vp_importe_total:= vp_importe_por_venta*vp_num_total_ventas;
            ELSE
               IF vp_tip_vendedor = 1 THEN --- Jefe de ventas
                  vp_importe_total:= vp_importe_por_venta;
               ELSE
                  vp_importe_total:= vp_importe_por_venta*vp_meta;
               END IF;
            END IF;
         END IF;
      END IF;
   END IF;  -- tipo de cuadrante
ELSE
   vp_importe_total:=0;
END IF;
VE_P2_cambia_moneda(vp_cod_moneda, vp_num_liquidacion, vp_fecha_inicial,vp_importe_total);
VE_P2_inserta_resultado(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_tip_vendedor,
vp_fecha_inicial,vp_fecha_final,vp_importe_total,vp_cod_cuadrante,vp_meta,vp_num_total_ventas,0);
EXCEPTION
WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
VE_P2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END VE_P2_comis_premios;
/
SHOW ERRORS
