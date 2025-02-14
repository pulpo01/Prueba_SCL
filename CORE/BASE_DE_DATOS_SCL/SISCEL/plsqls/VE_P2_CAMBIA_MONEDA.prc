CREATE OR REPLACE PROCEDURE        VE_P2_CAMBIA_MONEDA
(
 vp_cod_moneda IN OUT GE_MONEDAS.COD_MONEDA%TYPE,
 vp_num_liquidacion VE_CABLIQUIDAC.NUM_LIQUIDACION%TYPE,
 vp_fecha IN DATE,
 vp_importe IN OUT NUMBER
 )
IS
  vp_mensaje VARCHAR2(120):=' ';
  vp_procedure VARCHAR2(30):='ve_p2_cambia_moneda';
  vp_tabla VARCHAR2(30):='GE_CONVERSION';
  vp_trunc  date;
  vp_accion VARCHAR2(1):='S';
  vp_sqlcode VARCHAR2(10);
  vp_sqlerrm VARCHAR2(70);
vp_factor NUMBER;
BEGIN
vp_cod_moneda:=NVL(vp_cod_moneda,'001');
vp_trunc := TRUNC(vp_fecha)+.1;
SELECT CAMBIO
INTO vp_factor
FROM GE_CONVERSION
WHERE COD_MONEDA=vp_cod_moneda AND
 vp_trunc BETWEEN FEC_DESDE AND FEC_HASTA;
 vp_importe:= vp_importe*vp_factor;
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
ve_p2_insanomliq( vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END ve_p2_cambia_moneda;
/
SHOW ERRORS
