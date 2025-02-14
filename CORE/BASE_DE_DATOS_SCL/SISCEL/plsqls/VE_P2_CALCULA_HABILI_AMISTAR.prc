CREATE OR REPLACE PROCEDURE        VE_P2_CALCULA_HABILI_AMISTAR(
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
 vp_num_habi_amistar OUT NUMBER
)
IS
  vp_mensaje VARCHAR2(120):=' ';
  vp_procedure VARCHAR2(30):='VE_P2_calcula_habili_amistar';
  vp_tabla VARCHAR2(30):='GA_ABOCEL';
  vp_accion VARCHAR2(1):='S';
  vp_AC     VARCHAR2(2) := 'AC';
  VP_E      CHAR(1)     :='E';
  vp_AMI    VARCHAR2(3) := 'AMI';
  vp_39		VARCHAR2(2) := '39';
  vp_sqlcode VARCHAR2(10);
  vp_sqlerrm VARCHAR2(70);
BEGIN
IF vp_ind_nivel > 0 THEN
 SELECT COUNT(*)
 INTO  vp_num_habi_amistar
 FROM GA_ABOCEL GA_ABOCEL,
  VE_VENDEDORES  VE_VENDEDORES,
  GA_VENTAS GA_VENTAS
 WHERE NOT EXISTS (SELECT ROWID
                    FROM GA_TRASPABO TRASP
                    WHERE TRASP.NUM_ABONADO = GA_ABOCEL.NUM_ABONADO) AND
  VE_VENDEDORES.COD_VENDEDOR = GA_VENTAS.COD_VENDEDOR  AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final AND
  GA_VENTAS.NUM_VENTA = GA_ABOCEL.NUM_VENTA AND
--  GA_VENTAS.IND_ESTVENTA =vp_AC AND     SE SACA ESTA CONDICION, siempre vtas.AMI estan aceptadas
  GA_ABOCEL.IND_PROCEQUI = VP_E AND          -- PROCEDENCIA EXTERNA
  VE_VENDEDORES.COD_VENDE_RAIZ = vp_cod_vendedor AND
  GA_ABOCEL.COD_PLANTARIF = vp_AMI;
ELSE
 SELECT COUNT(*)
 INTO  vp_num_habi_amistar
 FROM GA_ABOCEL GA_ABOCEL,
      GA_VENTAS GA_VENTAS
 WHERE NOT EXISTS (SELECT ROWID
                    FROM GA_TRASPABO TRASP
                    WHERE TRASP.NUM_ABONADO = GA_ABOCEL.NUM_ABONADO) AND
  GA_ABOCEL.COD_VENDEDOR = vp_cod_vendedor AND
  GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
  GA_VENTAS.FEC_VENTA < vp_fecha_final AND
--  GA_VENTAS.IND_ESTVENTA =vp_AC AND     SE SACA ESTA CONDICION, siempre vtas.AMI estan aceptadas
  GA_ABOCEL.IND_PROCEQUI = VP_E AND          -- PROCEDENCIA EXTERNA
  GA_VENTAS.NUM_VENTA = GA_ABOCEL.NUM_VENTA AND
  GA_ABOCEL.COD_PLANTARIF = vp_AMI;
END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
VE_P2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END VE_P2_calcula_habili_amistar;
/
SHOW ERRORS
