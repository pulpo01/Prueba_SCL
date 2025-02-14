CREATE OR REPLACE FUNCTION AL_OBTIENE_PMP_ARTICULO_FN(
   v_cod_articulo  IN al_articulos.cod_articulo%TYPE
) RETURN NUMBER IS

   v_cod_moneda        ge_monedas.cod_moneda%TYPE;
   v_cod_moneda_local  ge_monedas.cod_moneda%TYPE;
   v_precio_aux        NUMBER;
   v_precio            NUMBER;
   v_fecha             al_cabecera_ordenes2.fec_creacion%TYPE;
   v_fecha_h           al_cabecera_ordenes2.fec_creacion%TYPE;
   v_precio_h          NUMBER;
   v_cod_moneda_h      ge_monedas.cod_moneda%TYPE;

BEGIN

   al_pac_validaciones.p_obtiene_moneda(v_cod_moneda_local);
	   -- INICIO XO-200509020564  05-09-2005
	   v_cod_moneda := v_cod_moneda_local;
	   -- FIN XO-200509020564  05-09-2005
-- Obtiene precio del ultimo registro del PMP diario

BEGIN
   SELECT PREC_PMP
   INTO   v_precio
   FROM   al_pmp_articulo
   WHERE  cod_articulo = v_cod_articulo
   AND fec_ult_mod = (SELECT MAX(fec_ult_mod)
                      FROM al_pmp_articulo
                      WHERE  cod_articulo = v_cod_articulo);

-- Si el PMP diario es nulo se busca la Orden de Ingreso con fecha mayor de entrada

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      BEGIN
         SELECT NVL(SUM(NVL(PRC_UNIDAD,0) + NVL(PRC_FF,0) + NVL(PRC_ADIC,0)),0), a.cod_moneda, a.fec_creacion
         INTO   v_precio, v_cod_moneda , v_fecha
         FROM   al_cabecera_ordenes2 a,
                al_lineas_ordenes2 b
         WHERE  a.num_orden = (SELECT MAX(c.num_orden)
                               FROM al_cabecera_ordenes2 c,
                                    al_lineas_ordenes2 d
                               WHERE c.num_orden = d.num_orden
                               AND   d.cod_articulo = v_cod_articulo
                               AND   c.cod_estado <> 'NU')
         AND   a.num_orden = b.num_orden
         GROUP BY a.cod_moneda,a.fec_creacion;

      EXCEPTION
         WHEN OTHERS THEN
		      v_precio := -1;
      END;

      BEGIN
            SELECT NVL(SUM(NVL(PRC_UNIDAD,0)+NVL(PRC_FF,0)+NVL(PRC_ADIC,0)),0), a.cod_moneda, a.fec_creacion
            INTO v_precio_h, v_cod_moneda_h, v_fecha_h
            FROM al_hcabecera_ordenes2 a,
                 al_hlineas_ordenes2 b
            WHERE a.num_orden = (SELECT MAX(c.num_orden)
                                 FROM al_hcabecera_ordenes2 c,
                                      al_hlineas_ordenes2 d
                                 WHERE c.num_orden = d.num_orden
                                 AND d.cod_articulo = v_cod_articulo)
            AND a.num_orden = b.num_orden
            GROUP BY a.cod_moneda,a.fec_creacion;

         EXCEPTION
            WHEN OTHERS THEN
               v_precio_h := -1;
      END;

	  IF v_fecha_h IS NOT NULL AND v_fecha IS NOT NULL THEN
	     IF v_fecha_h > v_fecha THEN
	        v_precio     := v_precio_h;
			v_cod_moneda := v_cod_moneda_h;
			v_fecha      := v_fecha_h;
	     END IF;
	  END IF;

	  IF v_precio = -1 and v_precio_h > 0 THEN
	     v_precio     := v_precio_h;
		 v_cod_moneda := v_cod_moneda_h;
		 v_fecha      := v_fecha_h;
	  END IF;


END;

IF v_precio IS NULL THEN
   v_precio:=-1;
ELSE
   IF v_precio > 0 THEN
      IF v_cod_moneda_local <> v_cod_moneda THEN
         al_pac_validaciones.p_convertir_precio(v_cod_moneda, v_cod_moneda_local ,v_precio, v_precio_aux, v_fecha);
         v_precio := v_precio_aux;
      END IF;
   END IF;
END IF;
RETURN v_precio;

END;
/
SHOW ERRORS
