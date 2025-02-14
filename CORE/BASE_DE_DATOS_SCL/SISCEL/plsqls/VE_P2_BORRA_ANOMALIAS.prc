CREATE OR REPLACE PROCEDURE        VE_P2_BORRA_ANOMALIAS
(
 vp_cod_vendedor IN VE_VENDEDORES.COD_VENDEDOR%TYPE,
 vp_fecha_inicial IN DATE ,
 vp_fecha_final IN DATE
  )
IS
BEGIN
DELETE VE_ANOMLIQ
WHERE NUM_LIQUIDACION IN (SELECT DISTINCT VE_CABLIQUIDAC.NUM_LIQUIDACION
                            FROM VE_CABLIQUIDAC
                            WHERE VE_CABLIQUIDAC.FEC_INILIQ = vp_fecha_inicial AND
                            VE_CABLIQUIDAC.FEC_FINLIQ = vp_fecha_final AND
                            VE_CABLIQUIDAC.COD_VENDEDOR= vp_cod_vendedor);
DELETE VE_RESLIQUIDAC
WHERE NUM_LIQUIDACION IN (SELECT DISTINCT VE_CABLIQUIDAC.NUM_LIQUIDACION
                            FROM VE_CABLIQUIDAC
                            WHERE VE_CABLIQUIDAC.FEC_INILIQ = vp_fecha_inicial AND
                            VE_CABLIQUIDAC.FEC_FINLIQ = vp_fecha_final AND
                            VE_CABLIQUIDAC.COD_VENDEDOR= vp_cod_vendedor);
DELETE VE_CABLIQUIDAC
  WHERE VE_CABLIQUIDAC.FEC_INILIQ = vp_fecha_inicial AND
        VE_CABLIQUIDAC.FEC_FINLIQ = vp_fecha_final AND
        VE_CABLIQUIDAC.COD_VENDEDOR= vp_cod_vendedor;
EXCEPTION WHEN NO_DATA_FOUND THEN
NULL;
END ve_p2_borra_anomalias;
/
SHOW ERRORS
