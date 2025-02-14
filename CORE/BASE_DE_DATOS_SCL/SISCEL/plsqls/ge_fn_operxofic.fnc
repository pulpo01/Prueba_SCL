CREATE OR REPLACE FUNCTION ge_fn_operxofic (v_cod_oficina IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_cod_operadora   ge_alms.cod_operadora_scl%TYPE;
--  Funcion que retorna el codigo de la operadora
--  al que esta asociada una oficina.
---------------------------------------------------------------
BEGIN
   SELECT f.cod_operadora_scl
     INTO v_cod_operadora
     FROM ge_oficinas a,
          ge_direcciones b,
          ge_ciuceldas_td c,
          ge_celdas d,
          ge_subalms e,
          ge_alms f
    WHERE a.cod_direccion = b.cod_direccion
      AND b.cod_ciudad = c.cod_ciudad
      AND c.cod_celda = d.cod_celda
      AND d.cod_subalm = e.cod_subalm
      AND e.cod_alm = f.cod_alm
      AND cod_oficina = v_cod_oficina
      AND ROWNUM = 1;
   RETURN v_cod_operadora;
END;
/
SHOW ERRORS
