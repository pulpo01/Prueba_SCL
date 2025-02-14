CREATE OR REPLACE PROCEDURE        VE_P2_FRAC_RANGO_CANTIDAD
(
 vp_cod_cuadrante IN VE_RESLIQUIDAC.COD_CUADRANTE%TYPE,
 vp_cantidad IN NUMBER,
 vp_resultado IN OUT NUMBER
)
IS
vp_resto NUMBER;
vp_max NUMBER;
BEGIN
vp_resultado:=0;
SELECT SUM((IMP_HASTA-IMP_DESDE)*IMP_RANGO)
INTO vp_resultado
FROM VE_CUADCOMIS
WHERE IMP_HASTA < vp_cantidad AND
     COD_CUADRANTE=vp_cod_cuadrante;
SELECT IMP_RANGO,IMP_DESDE
INTO vp_max,vp_resto
FROM VE_CUADCOMIS
WHERE vp_cantidad >IMP_DESDE AND
      vp_cantidad <IMP_HASTA AND
      COD_CUADRANTE=vp_cod_cuadrante;
vp_resultado:=vp_resultado+(vp_cantidad-vp_resto)*vp_max;
END ve_p2_frac_rango_cantidad;
/
SHOW ERRORS
