CREATE OR REPLACE PACKAGE BODY SISCEL.ve_cargos_accesorios_pg AS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_rec_impuesto_art_fn (en_cod_articulo   IN al_articulos.cod_articulo%TYPE,
                                 sn_imp_isc        OUT NOCOPY NUMBER,
                                  sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    sn_num_evento     OUT NOCOPY ge_errores_pg.evento)RETURN BOOLEAN
IS

   lv_des_error    VARCHAR2(300);
   lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     lv_sql := 'SELECT sum(decode(cod_tipimpues,1,prc_impuesto,0))/100 as ITBM, sum(decode(cod_tipimpues,2,prc_impuesto,0))/100 as ISC FROM al_articulos a, fa_grpserconc b, ge_impuestos c'
            || ' WHERE b.cod_concepto = a.cod_conceptoart AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta AND sysdate between b.fec_desde and b.fec_hasta AND c.cod_grpservi = b.cod_grpservi'
            || ' AND c.cod_catimpos = 1'
            || ' AND a.cod_articulo = '||en_cod_articulo;

     SELECT sum(decode(cod_tipimpues,2,prc_impuesto,0))/100 as ISC
      INTO sn_imp_isc
      FROM al_articulos a, fa_grpserconc b, ge_impuestos c
     WHERE b.cod_concepto = a.cod_conceptoart
       AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta
       AND sysdate between b.fec_desde and b.fec_hasta
       AND c.cod_grpservi = b.cod_grpservi
       AND c.cod_catimpos = 1
       AND a.cod_articulo = en_cod_articulo;

     RETURN TRUE;


EXCEPTION
    WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 30002;
         sv_mens_retorno := 'No se encontraron impuestos para el articulo';
         lv_des_error      := 've_tipificacion_pg.ve_tipificacion_pg() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, '1.0', USER, 've_tipificacion_pg.ve_tipificacion_pg()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;

    WHEN OTHERS THEN
         sn_cod_retorno  := 30003;
         sv_mens_retorno := 'Error al intentar recuperar impuestos';
         lv_des_error      := 've_tipificacion_pg.ve_tipificacion_pg() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, '1.0', USER, 've_tipificacion_pg.ve_tipificacion_pg()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;
END ve_rec_impuesto_art_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_rec_des_isc_fn (
      en_cod_articulo   IN  ga_tipificacion_td.cod_articulo%TYPE,
      en_tip_stock        IN  al_series.tip_stock%TYPE,
      en_cod_uso        IN  al_series.cod_uso%TYPE,
      sn_des_art        OUT NOCOPY NUMBER,
      sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY ge_errores_pg.evento
   )RETURN BOOLEAN
   IS

      lv_des_error    VARCHAR2(300);
      lv_sql          VARCHAR2(1000);
      sn_imp_isc      NUMBER;
      n_prc_venta     NUMBER;
      error_ejecucion EXCEPTION;
      ln_count        NUMBER;

   BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     sn_des_art := 0;


     lv_sql:= 'SELECT prc_venta '
             ||'FROM   al_precios_venta '
             ||'WHERE  cod_articulo = '||en_cod_articulo||' '
            ||'AND       tip_stock = '||en_tip_stock||' '
             ||'AND       cod_uso = '||en_cod_uso||' '
             ||'AND    ind_recambio = 9'
            ||'AND    cod_categoria = ''ZZZ'''
             ||'AND    SYSDATE BETWEEN fec_desde AND fec_hasta';

     SELECT prc_venta
     INTO    n_prc_venta
     FROM   al_precios_venta
     WHERE  cod_articulo = en_cod_articulo
     AND     tip_stock = en_tip_stock
     AND     cod_uso = en_cod_uso
     AND    ind_recambio = 9
     AND    cod_categoria = 'ZZZ'
     AND    SYSDATE BETWEEN fec_desde AND fec_hasta;


    IF NOT (ve_rec_impuesto_art_fn (en_cod_articulo,sn_imp_isc,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
        RAISE error_ejecucion;
     END IF;

--    if sn_imp_isc > 0 then
 --       sn_des_art  := round(n_prc_venta  ,4);
 --   else
        sn_des_art := 0;
 --   end if;


     RETURN TRUE;

   EXCEPTION
        WHEN error_ejecucion THEN
             RETURN FALSE;
        WHEN OTHERS THEN
          sn_cod_retorno  := 30007;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_rec_prc_venta_fn() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, '1.0', USER, 've_tipificacion_pg.ve_rec_prc_venta_fn()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;

   END ve_rec_des_isc_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_preccargoAcce_prelis_pr (
      en_codarticulo    IN              al_precios_venta.cod_articulo%TYPE,
      en_tipstock       IN              al_precios_venta.tip_stock%TYPE,
      en_codusoventa    IN              al_precios_venta.cod_uso%TYPE,
      en_codestado      IN              al_precios_venta.cod_estado%TYPE,
      ev_codcategoria   IN              al_precios_venta.cod_categoria%TYPE,
      ev_ind_recambio   IN              al_precios_venta.ind_recambio%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS

      no_data_found_cursor   EXCEPTION;
      lv_des_error           ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';

      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM al_precios_venta a, al_articulos b, ge_monedas c
       WHERE a.cod_articulo = en_codarticulo
         AND a.tip_stock = en_tipstock
         AND a.cod_uso = en_codusoventa
         AND a.cod_estado = en_codestado
         AND A.NUM_MESES=0  -- INI CSR-11002
         AND A.COD_PROMEDIO=0
         AND A.COD_ANTIGUEDAD=0
         AND A.COD_MODVENTA=1
         AND A.IND_RENOVA=0
         AND A.IND_PRISEG_LIN=0
         AND A.COD_CALIFICACION=cv_cod_calificacion -- FIN CSR-11002
         AND SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE)
         AND b.cod_articulo = a.cod_articulo
         AND c.cod_moneda = a.cod_moneda
         AND a.ind_recambio = ev_ind_recambio
         AND a.cod_categoria = ev_codcategoria
         AND a.FEC_DESDE = (SELECT max(a.fec_desde)
                              FROM al_precios_venta a, al_articulos b, ge_monedas c
                             WHERE a.cod_articulo = en_codarticulo
                               AND a.tip_stock = en_tipstock
                               AND a.cod_uso = en_codusoventa
                               AND a.cod_estado = en_codestado
                               AND A.NUM_MESES=0 -- INI CSR-11002
                               AND A.COD_PROMEDIO=0
                               AND A.COD_ANTIGUEDAD=0
                               AND A.COD_MODVENTA=1
                               AND A.IND_RENOVA=0
                               AND A.IND_PRISEG_LIN=0
                               AND A.COD_CALIFICACION=cv_cod_calificacion -- FIN CSR-11002
                               AND SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE)
                               AND b.cod_articulo = a.cod_articulo
                               AND c.cod_moneda = a.cod_moneda
                               AND a.ind_recambio = ev_ind_recambio
                               AND a.cod_categoria = ev_codcategoria);

      lv_sql := 'SELECT a.cod_conceptoart, a.des_articulo, t.prc_venta, t.cod_moneda, m.des_moneda, NVL (t.val_minimo, 0), NVL (t.val_maximo, 0), ''A'',''1'',''1'',''0'',a.mes_garantia,''0'',''0'',''0'',''0'''
             || ' FROM al_precios_venta a, al_articulos b, ge_monedas c'
             || ' WHERE a.cod_articulo = en_codarticulo'
             || ' AND a.tip_stock = '||en_tipstock
             || ' AND a.cod_uso = '||en_codusoventa
             || ' AND a.cod_estado = '||en_codestado
             || ' AND A.NUM_MESES=0 '
             || ' AND A.COD_PROMEDIO=0 '
             || ' AND A.COD_ANTIGUEDAD=0 '
             || ' AND A.COD_MODVENTA=1 '
             || ' AND A.IND_RENOVA=0 '
             || ' AND A.IND_PRISEG_LIN=0 '
             || ' AND A.COD_CALIFICACION= ' || cv_cod_calificacion
             || ' AND SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE)'
             || ' AND b.cod_articulo = a.cod_articulo'
             || ' AND c.cod_moneda = a.cod_moneda'
             || ' AND a.ind_recambio = '||ev_ind_recambio
             || ' AND a.cod_categoria = '||ev_codcategoria
             || ' AND a.FEC_DESDE = (SELECT max(a.fec_desde)'
                              || ' FROM al_precios_venta a, al_articulos b, ge_monedas c'
                              || ' WHERE a.cod_articulo = '||en_codarticulo
                              || ' AND a.tip_stock = '||en_tipstock
                              || ' AND a.cod_uso = '||en_codusoventa
                              || ' AND a.cod_estado = '||en_codestado
                              || ' AND A.NUM_MESES=0 '
                              || ' AND A.COD_PROMEDIO=0 '
                              || ' AND A.COD_ANTIGUEDAD=0 '
                              || ' AND A.COD_MODVENTA=1 '
                              || ' AND A.IND_RENOVA=0 '
                              || ' AND A.IND_PRISEG_LIN=0 '
                              || ' AND A.COD_CALIFICACION= ' || cv_cod_calificacion
                              || ' AND SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE)'
                              || ' AND b.cod_articulo = a.cod_articulo'
                              || ' AND c.cod_moneda = a.cod_moneda'
                              || ' AND a.ind_recambio = '||ev_ind_recambio
                              || ' AND a.cod_categoria = ev_codcategoria)';


        OPEN sc_cursordatos FOR
      SELECT b.cod_conceptoart, b.des_articulo, a.prc_venta, c.cod_moneda, c.des_moneda, 'A','1',
                '1','0','0','0','0','0','0'
        FROM al_precios_venta a, al_articulos b, ge_monedas c
       WHERE a.cod_articulo = en_codarticulo
         AND a.tip_stock = en_tipstock
         AND a.cod_uso = en_codusoventa
         AND a.cod_estado = en_codestado
         AND A.NUM_MESES=0 -- INI CSR-11002
         AND A.COD_PROMEDIO=0
         AND A.COD_ANTIGUEDAD=0
         AND A.COD_MODVENTA=1
         AND A.IND_RENOVA=0
         AND A.IND_PRISEG_LIN=0
         AND A.COD_CALIFICACION=cv_cod_calificacion -- FIN CSR-11002
         AND SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE)
         AND b.cod_articulo = a.cod_articulo
         AND c.cod_moneda = a.cod_moneda
         AND a.ind_recambio = ev_ind_recambio
         AND a.cod_categoria = ev_codcategoria
         AND a.FEC_DESDE = (SELECT max(a.fec_desde)
                              FROM al_precios_venta a, al_articulos b, ge_monedas c
                             WHERE a.cod_articulo = en_codarticulo
                               AND a.tip_stock = en_tipstock
                               AND a.cod_uso = en_codusoventa
                               AND a.cod_estado = en_codestado
                               AND A.NUM_MESES=0 -- INI CSR-11002
                               AND A.COD_PROMEDIO=0
                               AND A.COD_ANTIGUEDAD=0
                               AND A.COD_MODVENTA=1
                               AND A.IND_RENOVA=0
                               AND A.IND_PRISEG_LIN=0
                               AND A.COD_CALIFICACION=cv_cod_calificacion -- FIN CSR-11002
                               AND SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE)
                               AND b.cod_articulo = a.cod_articulo
                               AND c.cod_moneda = a.cod_moneda
                               AND a.ind_recambio = ev_ind_recambio
                               AND a.cod_categoria = ev_codcategoria);

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;


   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 30019;
         sv_mens_retorno := 'Error al consultar el Precio de Cargo del Accesorios. No se retornaron registros';
         lv_des_error    :='no_data_found_cursor:ve_cargos_pg.ve_preccargokit_prelis_pr(' || en_codarticulo || ',' || en_tipstock || ',' || en_codusoventa || ',' || en_codestado || ',' || ev_ind_recambio|| ',' || ev_codcategoria || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, '1.0', USER, 've_cargos_pg.ve_preccargokit_prelis_pr(' || en_codarticulo || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 30020;
         sv_mens_retorno := 'error al consultar precio cargo del Accesorios (precio lista)';
         lv_des_error    := 'OTHERS:ve_cargos_pg.ve_preccargokit_prelis_pr(' || en_codarticulo || ',' || en_tipstock || ',' || en_codusoventa || ',' || en_codestado || ',' || ev_ind_recambio|| ',' || ev_codcategoria || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, '1.0', USER, 've_cargos_pg.ve_preccargokit_prelis_pr(' || en_codarticulo || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_preccargoAcce_prelis_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_descuentoAcce_isc_pr (
      en_codarticulo    IN              al_precios_venta.cod_articulo%TYPE,
      en_tip_stock        IN              al_series.tip_stock%TYPE,
      en_cod_uso        IN              al_series.cod_uso%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_des_error           ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      n_prc_isc              NUMBER;
      error_ejecucion        EXCEPTION;
      n_des_art              NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';

      IF NOT (ve_rec_des_isc_fn (en_codarticulo,en_tip_stock,en_cod_uso,n_des_art,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      OPEN sc_cursordatos FOR
      SELECT a.cod_conceptodto, b.des_concepto, n_des_art
        FROM al_articulos a, fa_conceptos b
       WHERE cod_articulo = en_codarticulo
         AND b.cod_concepto = a.cod_conceptodto;

   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 30020;
         sv_mens_retorno := 'error al consultar precio cargo del Accesorios (precio lista)';
         lv_des_error    := '';
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, '1.0', USER, 've_cargos_pg.ve_preccargokit_prelis_pr(' || en_codarticulo || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_descuentoAcce_isc_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ve_cargos_accesorios_pg; 
/

