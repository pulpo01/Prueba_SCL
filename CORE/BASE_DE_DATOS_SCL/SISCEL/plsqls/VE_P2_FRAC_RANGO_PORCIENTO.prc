CREATE OR REPLACE PROCEDURE        VE_P2_FRAC_RANGO_PORCIENTO
(
 vp_cod_cuadrante IN VE_RESLIQUIDAC.COD_CUADRANTE%TYPE,
 vp_cantidad IN NUMBER,
 vp_meta IN NUMBER,
 vp_resultado IN OUT NUMBER
)
IS
vp_resto NUMBER;
vp_max NUMBER;
BEGIN
vp_resultado:=0;
SELECT SUM(round(IMP_HASTA*vp_meta/100-IMP_DESDE*vp_meta/100)*IMP_RANGO)
INTO vp_resultado
FROM VE_CUADCOMIS
WHERE IMP_HASTA*vp_meta/100 < vp_cantidad AND
     COD_CUADRANTE=vp_cod_cuadrante;
vp_resultado:=nvl(vp_resultado,0);
SELECT IMP_RANGO,IMP_DESDE*vp_meta/100
INTO vp_max,vp_resto
FROM VE_CUADCOMIS
WHERE vp_cantidad >=IMP_DESDE*vp_meta/100 AND
      vp_cantidad <IMP_HASTA*vp_meta/100 AND
      COD_CUADRANTE=vp_cod_cuadrante;
vp_resultado:=vp_resultado+(vp_cantidad-vp_resto)*vp_max;
END ve_p2_frac_rango_porciento;
/
SHOW ERRORS
