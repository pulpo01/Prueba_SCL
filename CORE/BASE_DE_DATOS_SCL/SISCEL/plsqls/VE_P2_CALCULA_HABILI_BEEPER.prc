CREATE OR REPLACE PROCEDURE        VE_P2_CALCULA_HABILI_BEEPER(
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
  vp_procedure VARCHAR2(30):='VE_P2_calcula_habili_celular';
  vp_tabla VARCHAR2(30):='GA_ABOBEEP';
  vp_accion VARCHAR2(1):='S';
  vp_sqlcode VARCHAR2(10);
  vp_sqlerrm VARCHAR2(70);
  vp_AC VARCHAR2(2) := 'AC';
  vp_75 VARCHAR2(2) := '75';
  vp_num_habilitaciones NUMBER := 0;
BEGIN
IF vp_ind_nivel > 0 THEN
   SELECT COUNT(*)
    INTO   vp_num_habilitaciones
    FROM GA_ABOBEEP GA_ABOBEEP,
         VE_VENDEDORES  VE_VENDEDORES,
         GA_VENTAS GA_VENTAS
    WHERE VE_VENDEDORES.COD_VENDEDOR = GA_VENTAS.COD_VENDEDOR  AND
          GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
          GA_VENTAS.FEC_VENTA < vp_fecha_final AND
          GA_VENTAS.NUM_VENTA = GA_ABOBEEP.NUM_VENTA AND
          GA_VENTAS.IND_ESTVENTA =vp_AC AND
          VE_VENDEDORES.COD_VENDE_RAIZ = vp_cod_vendedor;
ELSE
   SELECT COUNT(*)
   INTO  vp_num_habilitaciones
   FROM GA_ABOBEEP GA_ABOBEEP,
        GA_VENTAS GA_VENTAS
   WHERE GA_VENTAS.COD_VENDEDOR = vp_cod_vendedor AND
         GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
         GA_VENTAS.FEC_VENTA < vp_fecha_final AND
         GA_VENTAS.IND_ESTVENTA =vp_AC AND
         GA_VENTAS.NUM_VENTA = GA_ABOBEEP.NUM_VENTA;
END IF;
vp_num_habi_beep := vp_num_habilitaciones;
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
VE_P2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END VE_P2_calcula_habili_beeper;
/
SHOW ERRORS
