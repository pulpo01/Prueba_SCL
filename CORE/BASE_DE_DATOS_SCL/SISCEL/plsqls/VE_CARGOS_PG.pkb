CREATE OR REPLACE PACKAGE BODY ve_cargos_pg AS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_obtiene_venta_kit_pr (
                                        en_numventa       IN              NUMBER,
                                        sc_cursordatos    OUT NOCOPY      refcursor,
                                        sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
                                        sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
                                        sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS

no_data_found_cursor   EXCEPTION;
lv_des_error           ge_errores_pg.desevent;
lv_sql                ge_errores_pg.vquery;
ln_contador            NUMBER;

BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';

      ln_contador := 0;

      SELECT COUNT (1)
      INTO ln_contador
      FROM ga_aboamist a
      WHERE a.num_venta = en_numventa;

      lv_sql := 'SELECT distinct d.cod_articulo,d.tip_stock,b.cod_plantarif,b.cod_cargobasico,b.cod_planserv,b.cod_cliente,'
              ||'b.cod_vendedor,b.cod_tipcontrato,b.cod_causa_venta,b.cod_modventa,b.tip_plantarif,b.num_contrato,b.cod_uso,'
              ||'b.num_min,b.cod_central,b.cod_cuenta,b.cod_ciclo,b.cod_vendealer,b.cod_tecnologia,b.cod_celda,d.num_kit'
              ||'FROM   ga_aboamist b, ga_equipaboser c, al_componente_kit d, al_articulos e '
              ||'WHERE  b.num_venta = '||en_numventa||' '
              ||'AND    b.num_abonado = c.num_abonado '
              ||'AND    b.num_serie = d.num_serie '
              ||'AND    e.cod_articulo = d.cod_kit '
              ||'AND    e.tip_articulo = '||cn_kit||'';


      OPEN sc_cursordatos FOR
         SELECT DISTINCT d.cod_articulo,d.tip_stock,b.cod_plantarif,b.cod_cargobasico,b.cod_planserv,b.cod_cliente,
         b.cod_vendedor,b.cod_tipcontrato,b.cod_causa_venta,b.cod_modventa,b.tip_plantarif,b.num_contrato,b.cod_uso,
         b.num_min,b.cod_central,b.cod_cuenta,b.cod_ciclo,b.cod_vendealer,b.cod_tecnologia,b.cod_celda,d.num_kit,b.cod_tipcontrato
         FROM   ga_aboamist b, ga_equipaboser c, al_componente_kit d, al_articulos e, al_series f
         WHERE  b.num_venta = en_numventa
         AND    b.num_abonado = c.num_abonado
         AND    b.num_serie = d.num_serie
         AND    e.cod_articulo = d.cod_kit
         AND    e.tip_articulo = cn_kit
     AND    f.num_serie = d.num_kit
     AND    f.cod_estado = 7;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 30015;
         sv_mens_retorno := 'Error al obtener abonados venta';
         lv_des_error    := 've_cargos_pg.ve_obtiene_abonados_venta_pr() - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, '1.0', USER, 've_cargos_pg.ve_obtiene_abonados_venta_pr', lv_sql, sn_cod_retorno, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 30016;
         sv_mens_retorno := 'Problemas al Obtener datos de Abonados Venta';
         lv_des_error    := 've_cargos_pg.ve_obtiene_abonados_venta_pr() - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, '1.0', USER, 've_cargos_pg.ve_obtiene_abonados_venta_pr', lv_sql, sn_cod_retorno, lv_des_error);
END ve_obtiene_venta_kit_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_consulta_kit_pr (
                                ev_serie          IN              al_series.num_serie%TYPE,
                                sv_tipostock      OUT NOCOPY      al_series.tip_stock%TYPE,
                                sn_codarticulo    OUT NOCOPY      al_series.cod_articulo%TYPE,
                                sn_indvalorar     OUT NOCOPY      al_tipos_stock.ind_valorar%TYPE,
                                sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
                                sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
                                sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS

lv_sql         ge_errores_pg.vquery;
lv_des_error   ge_errores_pg.desevent;

 BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :='SELECT DISTINCT s.tip_stock, s.cod_kit,t.ind_valorar '
             ||'FROM   al_componente_kit s, al_articulos a, al_tipos_stock t '
             ||'WHERE  s.num_kit = '||ev_serie||' '
             ||'AND    s.cod_articulo = a.cod_articulo '
             ||'AND    s.tip_stock = t.tip_stock';

     SELECT DISTINCT s.tip_stock, s.cod_kit,t.ind_valorar
     INTO   sv_tipostock,sn_codarticulo,sn_indvalorar
     FROM   al_componente_kit s, al_articulos a, al_tipos_stock t
     WHERE  s.num_kit = ev_serie
     AND    s.cod_articulo = a.cod_articulo
     AND    s.tip_stock = t.tip_stock;

 EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 30017;
         sv_mens_retorno := 'Error al consultar datos del Kit. No se retornaron registros';
         lv_des_error    := 'NO_DATA_FOUND:ve_cargos_pg.VE_consulta_kit_PR(' || ev_serie || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, '1.0', USER, 've_cargos_pg.VE_consulta_kit_PR(' || ev_serie || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno  := 30018;
         sv_mens_retorno := 'error al consultar datos del Kit';
         lv_des_error    := 'OTHERS:ve_cargos_pg.VE_consulta_kit_PR(' || ev_serie || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, '1.0', USER, 've_cargos_pg.VE_consulta_kit_PR(' || ev_serie || ')', lv_sql, SQLCODE, lv_des_error);
 END ve_consulta_kit_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_preccargokit_prelis_pr (
                                      en_codarticulo    IN              al_precios_venta.cod_articulo%TYPE,
                                      en_tipstock       IN              al_precios_venta.tip_stock%TYPE,
                                      en_codusoventa    IN              al_precios_venta.cod_uso%TYPE,
                                      en_codestado      IN              al_precios_venta.cod_estado%TYPE,
                                      sc_cursordatos    OUT NOCOPY      refcursor,
                                      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
                                      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
                                      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
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
      INTO   ln_contador
      FROM   al_precios_venta t, al_articulos a, ge_monedas m
      WHERE  t.tip_stock = en_tipstock
      AND    t.cod_articulo = en_codarticulo
      AND    UPPER(t.cod_categoria) = UPPER(cv_categoria)
      AND    t.cod_uso = en_codusoventa
      AND    t.cod_estado = en_codestado
      AND    SYSDATE BETWEEN t.fec_desde AND NVL (t.fec_hasta, SYSDATE)
      AND    a.cod_articulo = t.cod_articulo
      AND    m.cod_moneda = t.cod_moneda
      AND    t.ind_recambio = cn_ind_recambio
      AND    t.num_meses=0 --INICIO CSR-11002
      AND    t.cod_promedio=0
      AND    t.cod_antiguedad=0
      AND    t.cod_modventa=1
      AND    t.ind_renova=0
      AND    t.ind_priseg_lin=0
      AND    t.cod_calificacion = cv_cod_calificacion --FIN CSR-11002
      AND    ROWNUM <= 1;

      lv_sql := 'SELECT a.cod_conceptoart, a.des_articulo, t.prc_venta, t.cod_moneda, m.des_moneda, NVL (t.val_minimo, 0),'
              ||'NVL (t.val_maximo, 0), "A","1","1","0",a.mes_garantia,"0","0","0","0" '
              ||'FROM  al_precios_venta t, al_articulos a, ge_monedas m '
              ||'WHERE t.tip_stock = '||en_tipstock||' '
              ||'AND   t.cod_articulo = '||en_codarticulo||' '
              ||'AND   UPPER(t.cod_categoria) = UPPER('||cv_categoria||') '
              ||'AND   t.cod_uso = '||en_codusoventa||' '
              ||'AND   t.cod_estado = '||en_codestado||' '
              ||'AND   SYSDATE BETWEEN t.fec_desde AND NVL (t.fec_hasta, SYSDATE) '
              ||'AND   a.cod_articulo = t.cod_articulo '
              ||'AND   m.cod_moneda = t.cod_moneda '
              ||'AND   t.ind_recambio = '||cn_ind_recambio||''
              ||'AND    t.num_meses=0 '
              ||'AND    t.cod_promedio=0 '
              ||'AND    t.cod_antiguedad=0 '
              ||'AND    t.cod_modventa=1 '
              ||'AND    t.ind_renova=0 '
              ||'AND    t.ind_priseg_lin=0 '
              ||'AND    t.cod_calificacion = ' || cv_cod_calificacion;

      OPEN sc_cursordatos FOR
         SELECT a.cod_conceptoart, a.des_articulo, t.prc_venta, t.cod_moneda, m.des_moneda, NVL (t.val_minimo, 0), NVL (t.val_maximo, 0), 'A','1',
                '1','0',a.mes_garantia,'0','0','0','0'
         FROM  al_precios_venta t, al_articulos a, ge_monedas m
         WHERE t.tip_stock = en_tipstock
         AND   t.cod_articulo = en_codarticulo
         AND   UPPER(t.cod_categoria) = UPPER(cv_categoria)
         AND   t.cod_uso = en_codusoventa
         AND   t.cod_estado = en_codestado
         AND   SYSDATE BETWEEN t.fec_desde AND NVL (t.fec_hasta, SYSDATE)
         AND   a.cod_articulo = t.cod_articulo
         AND   m.cod_moneda = t.cod_moneda
         AND   t.ind_recambio = cn_ind_recambio
         AND   t.num_meses=0 --INICIO CSR-11002
         AND   t.cod_promedio=0
         AND   t.cod_antiguedad=0
         AND   t.cod_modventa=1
         AND   t.ind_renova=0
         AND   t.ind_priseg_lin=0
         AND   t.cod_calificacion = cv_cod_calificacion; --FIN CSR-11002

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 30019;
         sv_mens_retorno := 'Error al consultar el Precio de Cargo del Kit. No se retornaron registros';
         lv_des_error    :='no_data_found_cursor:ve_cargos_pg.ve_preccargokit_prelis_pr(' || en_codarticulo || ',' || en_tipstock || ',' || en_codusoventa || ',' || en_codestado || ',' || cn_ind_recambio || ',' || cv_categoria || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, '1.0', USER, 've_cargos_pg.ve_preccargokit_prelis_pr(' || en_codarticulo || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 30020;
         sv_mens_retorno := 'error al consultar precio cargo del Kit(precio lista)';
         lv_des_error    := 'OTHERS:ve_cargos_pg.ve_preccargokit_prelis_pr(' || en_codarticulo || ',' || en_tipstock || ',' || en_codusoventa || ',' || en_codestado || ',' || cn_ind_recambio || ',' || cv_categoria || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, '1.0', USER, 've_cargos_pg.ve_preccargokit_prelis_pr(' || en_codarticulo || ')', lv_sql, SQLCODE, lv_des_error);
END ve_preccargokit_prelis_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_precarkit_noprelis_pr (
                                      en_codarticulo     IN              al_precios_venta.cod_articulo%TYPE,
                                      en_tipstock        IN              al_precios_venta.tip_stock%TYPE,
                                      en_codusoventa     IN              al_precios_venta.cod_uso%TYPE,
                                      en_codestado       IN              al_precios_venta.cod_estado%TYPE,
                                      en_modventa        IN              al_precios_venta.cod_modventa%TYPE,
                                      ev_tipocontrato    IN              ga_percontrato.cod_tipcontrato%TYPE,
                                      ev_plantarif       IN              ve_catplantarif.cod_plantarif%TYPE,
                                      en_codusoprepago   IN              al_precios_venta.cod_uso%TYPE,
                                      ev_indequipo       IN              al_articulos.ind_equiacc%TYPE,
                                      sc_cursordatos     OUT NOCOPY      refcursor,
                                      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
                                      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
                                      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS

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
      FROM al_precios_venta a, al_articulos b, ge_monedas c, (SELECT w.cod_categoria categoria
                                                              FROM   ve_catplantarif v, ve_categorias w
                                                              WHERE  v.cod_plantarif = ev_plantarif
                                                              AND    v.cod_categoria = w.cod_categoria) z, (SELECT p.num_meses meses
                                                                                                            FROM   ga_percontrato p
                                                                                                            WHERE  p.cod_producto > 0
                                                                                                            AND    p.cod_tipcontrato = ev_tipocontrato) xy
      WHERE a.tip_stock = en_tipstock
      AND   a.cod_articulo = en_codarticulo
      AND   a.cod_uso = en_codusoventa
      AND   a.cod_estado = en_codestado
      AND   a.cod_modventa = en_modventa
      AND   SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE)
      AND   b.cod_articulo = a.cod_articulo
      AND   c.cod_moneda = a.cod_moneda
      --AND   a.ind_recambio = en_indrecambio
      AND   a.num_meses = xy.meses
      AND   a.cod_categoria = z.categoria
      AND   b.ind_equiacc = ev_indequipo
      AND   a.num_meses=0 --CSR-11002
      AND   a.cod_promedio=0
      AND   a.cod_antiguedad=0
      AND   a.ind_renova=0
      AND   a.ind_priseg_lin=0
      AND   a.cod_calificacion= cv_cod_calificacion --CSR-11002
      AND   ROWNUM <= 1;

      lv_sql := 'SELECT b.cod_conceptoart, b.des_articulo, a.prc_venta, a.cod_moneda, c.des_moneda, NVL (a.val_minimo, 0),'
              ||'NVL (a.val_maximo, 0), "A","1","1","0",b.mes_garantia,"0","0","0","0" '
              ||'FROM al_precios_venta a, al_articulos b, ge_monedas c, (SELECT w.cod_categoria categoria '
                                                                      ||'FROM   ve_catplantarif v, ve_categorias WHERE '
                                                                      ||'WHERE  v.cod_plantarif = '||ev_plantarif||' '
                                                                      ||'AND    v.cod_categoria = w.cod_categoria) z,(SELECT p.num_meses meses '
                                                                                                                   ||'FROM   ga_percontrato p '
                                                                                                                   ||'WHERE  p.cod_producto > 0 '
                                                                                                                   ||'AND    p.cod_tipcontrato = '||ev_tipocontrato||') xy '
              ||'WHERE a.tip_stock = '||en_tipstock||' '
              ||'AND   a.cod_articulo = '||en_codarticulo||' '
              ||'AND   a.cod_uso = '||en_codusoventa||' '
              ||'AND   a.cod_estado = '||en_codestado||' '
              ||'AND   a.cod_modventa = '||en_modventa||' '
              ||'AND   SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE) '
              ||'AND   b.cod_articulo = a.cod_articulo '
              ||'AND   c.cod_moneda = a.cod_moneda '
              ||'AND   a.num_meses = xy.meses '
              ||'AND   a.cod_categoria = z.categoria '
              ||'AND   b.ind_equiacc = '||ev_indequipo||''
              ||'AND   a.num_meses=0 '
              ||'AND   a.cod_promedio=0 '
              ||'AND   a.cod_antiguedad=0 '
              ||'AND   a.ind_renova=0 '
              ||'AND   a.ind_priseg_lin=0 '
              ||'AND   a.cod_calificacion= '||cv_cod_calificacion;

      OPEN sc_cursordatos FOR
         SELECT b.cod_conceptoart, b.des_articulo, a.prc_venta, a.cod_moneda, c.des_moneda, NVL (a.val_minimo, 0), NVL (a.val_maximo, 0), 'A',
                '1','1','0',b.mes_garantia,'0','0','0','0'
         FROM al_precios_venta a, al_articulos b, ge_monedas c, (SELECT w.cod_categoria categoria
                                                                 FROM   ve_catplantarif v, ve_categorias w
                                                                 WHERE  v.cod_plantarif = ev_plantarif
                                                                 AND    v.cod_categoria = w.cod_categoria) z,(SELECT p.num_meses meses
                                                                                                              FROM   ga_percontrato p
                                                                                                              WHERE  p.cod_producto > 0
                                                                                                              AND    p.cod_tipcontrato = ev_tipocontrato) xy
          WHERE a.tip_stock = en_tipstock
          AND   a.cod_articulo = en_codarticulo
          AND   a.cod_uso = en_codusoventa
          AND   a.cod_estado = en_codestado
          AND   a.cod_modventa = en_modventa
          AND   SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE)
          AND   b.cod_articulo = a.cod_articulo
          AND   c.cod_moneda = a.cod_moneda
          --AND   a.ind_recambio = en_indrecambio
          AND   a.num_meses = xy.meses
          AND   a.cod_categoria = z.categoria
          AND   b.ind_equiacc = ev_indequipo
          AND   a.num_meses=0 --CSR-11002
          AND   a.cod_promedio=0
          AND   a.cod_antiguedad=0
          AND   a.ind_renova=0
          AND   a.ind_priseg_lin=0
          AND   a.cod_calificacion= cv_cod_calificacion; --CSR-11002

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 30021;
         sv_mens_retorno := 'Error al Obtener Precio Cargo del Kit No Precio de Lista. No se retornaron registros';
         lv_des_error    :='no_data_found_cursor:ve_cargos_pg.ve_precarkit_noprelis_pr(' || en_codarticulo || ',' || en_tipstock || ',' || en_codusoventa || ',' || en_codestado || ',' || en_modventa || ',' || ev_tipocontrato || ',' || ev_plantarif || ','
            /*|| en_indrecambio || ',' || ev_codcategoria || ',' */|| en_codusoprepago || ',' || ev_indequipo || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, '1.0', USER, 've_cargos_pg.ve_precarkit_noprelis_pr(' || en_codarticulo || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 30022;
         sv_mens_retorno := 'Error al consultar precio cargo del Kit(No Precio de Lista)';
         lv_des_error    := 'OTHERS:ve_cargos_pg.ve_precarkit_noprelis_pr(' || en_codarticulo || ',' || en_tipstock || ',' || en_codusoventa || ',' || en_codestado || ',' || en_modventa || ',' || ev_tipocontrato || ',' || ev_plantarif || ','
            /*|| en_indrecambio || ',' || ev_codcategoria || ',' */|| en_codusoprepago || ',' || ev_indequipo || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, '1.0', USER, 've_cargos_pg.ve_precarkit_noprelis_pr(' || en_codarticulo || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_precarkit_noprelis_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_obtiene_abo_ven_nokit_pr (
      en_numventa       IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_abonados_venta_PR"
         Lenguaje="PL/SQL"
         Fecha="26-03-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Recupera abonados para el numero de venta ingresado
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_numventa"     Tipo="NUMBER> numero de venta </param>
      </Entrada>
      <Salida>
         <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con abonados seleccionados </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      no_data_found_cursor   EXCEPTION;
    error_venta            EXCEPTION;
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
      ln_contador            NUMBER;
    postpago               NUMBER;
    prepago                NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'SELECT a.num_abonado' || ',a.cod_plantarif' || ',a.cod_cargobasico' || ',a.cod_planserv' || ',a.num_serie' || ',a.num_imei' || ',a.cod_cliente' || ',a.cod_vendedor' || ',a.cod_tipcontrato' || ',a.cod_causa_venta' || ',a.cod_modventa'
         || ',a.tip_plantarif' || ',a.num_contrato' || ',a.cod_uso' || ',a.cod_cuenta' || ' FROM  ga_abocel a' || '  WHERE a.num_venta =' || en_numventa;
      ln_contador := 0;


    SELECT COUNT (1) AS cant
      INTO postpago
        FROM ga_abocel a
       WHERE a.num_venta = en_numventa;

      SELECT COUNT (1) AS cant
      INTO prepago
        FROM ga_aboamist b
       WHERE b.num_venta = en_numventa;


    IF (prepago > 0 AND postpago > 0) THEN
       RAISE error_venta;
    END IF;

      IF (postpago > 0) THEN
         OPEN sc_cursordatos FOR
            SELECT a.num_abonado, a.cod_plantarif, a.cod_cargobasico, a.cod_planserv, a.num_serie,
                   a.num_imei, a.cod_cliente, a.cod_vendedor, a.cod_tipcontrato, a.cod_causa_venta,
                   a.cod_modventa, a.tip_plantarif, a.num_contrato, a.cod_uso, a.num_min, a.cod_central,
                   a.num_celular, a.cod_cuenta, a.cod_ciclo, a.cod_vendealer, a.cod_tecnologia, a.cod_celda,
                   a.tip_terminal, a.num_seriehex, a.ind_procequi
              FROM ga_abocel a
             WHERE a.num_venta = en_numventa
       AND   a.num_serie NOT IN (SELECT num_serie
                                   FROM al_componente_kit
                    WHERE num_kit > 0
                      AND cod_kit > 0
                      AND cod_articulo > 0
                      AND num_serie > 0);

      ELSIF(prepago > 0) THEN

         OPEN sc_cursordatos FOR
            SELECT b.num_abonado, b.cod_plantarif, b.cod_cargobasico, b.cod_planserv, b.num_serie,
                   b.num_imei, b.cod_cliente, b.cod_vendedor, b.cod_tipcontrato, b.cod_causa_venta,
                   b.cod_modventa, b.tip_plantarif, b.num_contrato, b.cod_uso, b.num_min, b.cod_central,
                   b.num_celular, b.cod_cuenta, b.cod_ciclo, b.cod_vendealer, b.cod_tecnologia, b.cod_celda,
                   b.tip_terminal, b.num_seriehex, b.ind_procequi
             FROM ga_aboamist b
             WHERE b.num_venta = en_numventa
       AND   b.num_serie NOT IN (SELECT num_serie
                                   FROM al_componente_kit
                    WHERE num_kit > 0
                      AND cod_kit > 0
                      AND cod_articulo > 0
                      AND num_serie > 0);

    ELSE
        lv_ssql := 'prepago ='||prepago ||' AND postpago ='||postpago;
        RAISE error_venta;
    END IF;

   EXCEPTION
      WHEN error_venta THEN
         sn_cod_retorno  := 100761;
         sv_mens_retorno :='Error la venta tiene abonados prepago y postpago';
         lv_des_error    := SUBSTR ('error_venta:Ve_Servicios_Venta_Pg.VE_obtiene_abonados_venta_PR(' || en_numventa || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'Ve_Servicios_Venta_Pg.VE_obtiene_abonados_venta_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 10761;
         sv_mens_retorno :='Error al obtener abonados venta';
         lv_des_error    := SUBSTR ('no_data_found_cursor:Ve_Servicios_Venta_Pg.VE_obtiene_abonados_venta_PR(' || en_numventa || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'Ve_Servicios_Venta_Pg.VE_obtiene_abonados_venta_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10762;
         sv_mens_retorno := 'Problemas al Obtener datos de Abonados Venta';
         lv_des_error    := SUBSTR ('OTHERS:Ve_Servicios_Venta_Pg.VE_obtiene_abonados_venta_PR(' || en_numventa || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'Ve_Servicios_Venta_Pg.VE_obtiene_abonados_venta_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_abo_ven_nokit_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_obtiene_info_cargos_pr (
      en_numventa       IN              NUMBER,
      en_num_proceso    IN              NUMBER,
      sn_total_cargos   OUT NOCOPY      NUMBER,
      sn_total_itmb     OUT NOCOPY      NUMBER,
      sn_total_ics      OUT NOCOPY      NUMBER,
      sn_total_apagar   OUT NOCOPY      NUMBER,
      sn_num_folio      OUT NOCOPY      NUMBER,
      sv_pref_plaza     OUT NOCOPY      VARCHAR2,
      sc_cargosseries   OUT NOCOPY      refcursor,
      sn_imp_cruzroja   OUT NOCOPY      NUMBER,
      sn_imp_911        OUT NOCOPY      NUMBER,
      sn_imp_venta      OUT NOCOPY      NUMBER,
      sn_descuento      OUT NOCOPY      NUMBER,
      sv_serie          OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      no_data_found_cursor   EXCEPTION;
    error_venta            EXCEPTION;
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
      ln_contador            NUMBER;
    postpago               NUMBER;
    prepago                NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';

    lv_ssql := 'SELECT SUM (DECODE (conc.cod_tipconce, 3, imp_facturable, 0)) + SUM (DECODE (conc.cod_tipconce, 2, imp_facturable, 0)) total_cargos, SUM (DECODE (conc.cod_tipconce, 1, imp_facturable, 0)) total_impuestos, SUM (DECODE (conc.cod_tipconce, 3, imp_facturable, 0)) + SUM (DECODE (conc.cod_tipconce, 2, imp_facturable, 0)) + SUM (DECODE (conc.cod_tipconce, 1, imp_facturable, 0)) total_apagar'
              || 'FROM fa_presupuesto pre, fa_conceptos conc WHERE pre.cod_concepto = conc.cod_concepto AND cod_cliente > 0 AND pre.cod_concepto > 0 AND columna > 0 AND pre.num_proceso = '||en_num_proceso;


      SELECT SUM (DECODE (conc.cod_tipconce, 3, imp_facturable, 0)) + SUM (DECODE (conc.cod_tipconce, 2, imp_facturable, 0)) cargos,
       SUM(DECODE (conc.cod_tipconce, 1, decode(conc.cod_grpconcepto,5,imp_facturable, 0), 0)) ITBM,
       SUM(DECODE (conc.cod_tipconce, 1, decode(conc.cod_grpconcepto,6,imp_facturable, 0), 0)) ISC,
       SUM (DECODE (conc.cod_tipconce, 3, imp_facturable, 0)) + SUM (DECODE (conc.cod_tipconce, 2, imp_facturable, 0)) + SUM(DECODE (conc.cod_tipconce, 1, imp_facturable, 0)) TotalPagar
      INTO sn_total_cargos,
         sn_total_ITMB,
         sn_total_ICS,
       sn_total_apagar
        FROM fa_presupuesto pre, fa_conceptos conc
       WHERE pre.cod_concepto = conc.cod_concepto
         AND pre.num_proceso = en_num_proceso
         AND cod_cliente > 0
         AND pre.cod_concepto > 0
         AND columna > 0;


      lv_ssql := 'SELECT b.des_concepto, a.num_unidades, a.num_serie, a.imp_cargo FROM ge_cargos a, fa_conceptos b WHERE a.cod_concepto = b.cod_concepto AND a.num_venta = '||en_numventa;

      OPEN sc_cargosSeries FOR
      SELECT b.des_concepto, a.num_unidades, a.num_serie, a.imp_cargo, a.val_dto
        FROM ge_cargos a, fa_conceptos b
       WHERE a.cod_concepto = b.cod_concepto
         AND a.num_venta = en_numventa;

    lv_ssql := 'SELECT num_folio, pref_plaza FROM fa_factdocu_nociclo WHERE num_proceso = '||en_num_proceso;

      SELECT num_folio, pref_plaza, serie||num_folio
        INTO sn_num_folio, sv_pref_plaza, sv_serie
        FROM fa_factdocu_nociclo
       WHERE num_proceso = en_num_proceso;
       
       
       --CSR-11002 HOM
       
       --Recupero impuestos
       
       --Cruz roja HOM
       select nvl(sum(a.imp_concepto),0) into sn_imp_cruzroja
       from fa_presupuesto a where num_proceso=en_num_proceso
       and a.imp_concepto>0 
       and a.cod_concepto=GE_FN_DEVVALPARAM('GA',1,'CONCEP_IMP_CRUZROJA'); --Cambiar el 7 por el del parametro de cruz roja
       
       --911 HOM
       select nvl(sum(a.imp_concepto),0) into sn_imp_911
       from fa_presupuesto a where num_proceso=en_num_proceso
       and a.imp_concepto>0 
       and a.cod_concepto=GE_FN_DEVVALPARAM('GA',1,'CONCEP_IMP_911'); --Cambiar el 4 por el del parametro de 911
            
       
       --Impto. Venta HOM
       select nvl(sum(a.imp_concepto),0) into sn_imp_venta
       from fa_presupuesto a where num_proceso=en_num_proceso
       and a.imp_concepto>0
       and a.cod_concepto=GE_FN_DEVVALPARAM('GA',1,'CONCEP_IMP_VENTA'); --Cambiar el 5 por el del parametro de impto venta
       
       
       -- Recupero Descuentos HOM
        select nvl(sum(imp_concepto),0) into sn_descuento from fa_presupuesto where num_proceso=en_num_proceso 
        and imp_concepto<0;
       

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 10761;
         sv_mens_retorno :='Error al obtener abonados venta';
         lv_des_error    := SUBSTR ('no_data_found_cursor:Ve_Servicios_Venta_Pg.VE_obtiene_abonados_venta_PR(' || en_numventa || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'Ve_Servicios_Venta_Pg.VE_obtiene_abonados_venta_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 111768;
         sv_mens_retorno :='Error la venta tiene abonados prepago y postpago';
         lv_des_error    := SUBSTR ('error_venta:Ve_Servicios_Venta_Pg.VE_obtiene_abonados_venta_PR(' || en_numventa || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'Ve_Servicios_Venta_Pg.VE_obtiene_abonados_venta_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10762;
         sv_mens_retorno := 'Problemas al Obtener datos de Abonados Venta';
         lv_des_error    := SUBSTR ('OTHERS:Ve_Servicios_Venta_Pg.VE_obtiene_abonados_venta_PR(' || en_numventa || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'Ve_Servicios_Venta_Pg.VE_obtiene_abonados_venta_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_info_cargos_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_ins_quios_vent_pr (
      en_num_venta      IN              NUMBER,
      en_cod_cliente    IN              NUMBER,
      ev_nomusuarioad   IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) IS
      lv_des_error           ge_errores_pg.desevent;
      lv_sql                ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';

      INSERT INTO ve_ventas_quiosco_to
                  (num_venta, cod_cliente, nom_usuario_ad, fecha)
           VALUES (en_num_venta, en_cod_cliente, ev_nomusuarioad, SYSDATE);

   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 30016;
         sv_mens_retorno := 'Problemas al Obtener datos de Abonados Venta';
         lv_des_error    := 've_cargos_pg.ve_obtiene_abonados_venta_pr() - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, '1.0', USER, 've_cargos_pg.ve_obtiene_abonados_venta_pr', lv_sql, sn_cod_retorno, lv_des_error);
   END ve_ins_quios_vent_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE CE_APLICA_PAGO_PR (
    pRevempresa       IN  VARCHAR2
   ,pRevCaja          IN  VARCHAR2
   ,pRevCodSer        IN  VARCHAR2
   ,pRevFechaEfectiva IN  VARCHAR2
   ,pRevNum_Oper      IN  VARCHAR2
   ,pRevOperador      IN  VARCHAR2
   ,pRevTipo          IN  VARCHAR2
   ,pRevSubTipo       IN  VARCHAR2
   ,pRevCod_Servicio  IN  VARCHAR2
   ,pRevCi_Fecontab   IN  VARCHAR2
   ,pRevCliente       IN  VARCHAR2
   ,pRevCelular       IN  VARCHAR2
   ,pRevMonto         IN  VARCHAR2
   ,pRevFolio         IN  VARCHAR2
   ,pRevRut           IN  VARCHAR2
   ,pRevModPago       IN  VARCHAR2
   ,pRevNumDocum      IN  VARCHAR2
   ,pRevBcoDocum      IN  VARCHAR2
   ,pRevCtaCte        IN  VARCHAR2
   ,pRevCodAuto       IN  VARCHAR2
   ,pNumTarjeta       IN  VARCHAR2
   ,pResul            OUT VARCHAR2
   ,pDescripcion      OUT VARCHAR2
   ,pCodOperacion    IN  VARCHAR2 default '1'
   ,pNumventa      IN  NUMBER   default null
   ,pNumFolio      IN  NUMBER   default null
   ,pCodPlanSrv    IN  VARCHAR2 default null
)

IS
    vcErrFrom         VARCHAR2(200);
    vcErrCode         VARCHAR2(200);
    vcErrMens         VARCHAR2(32767);
    tmpDescri         VARCHAR2(32767);
    vExceptio         EXCEPTION;
    LV_nomtabla       GED_CODIGOS.NOM_TABLA%TYPE := 'CO_INTERFAZ_PAGOS'; --MA-70067
    LV_nomcolumna     GED_CODIGOS.NOM_COLUMNA%TYPE := 'TIP_VALOR'; --MA-70067
    LN_contador NUMBER := 0; --MA-70067 Si valor es 0 se valida el banco, en caso contrario no se valida.

BEGIN

    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevEmpresa_FN       ( pRevempresa,       vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;
    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevCaja_FN          ( pRevCaja,          vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;
    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevOperador_FN      ( pRevOperador,      vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;
    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevCliente_FN       ( pRevCliente,       vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;

    --MA-70067 Valida si el tipo de  valor está entre los que no requieren el código del Banco
    SELECT COUNT(1)
    INTO LN_contador
    FROM ged_codigos a
    WHERE a.nom_tabla = 'CO_INTERFAZ_PAGOS'
    AND a.nom_columna = 'TIP_VALOR'
    AND a.cod_valor =  pRevModPago;

    --if trim(pRevModPago) != '1' then
    IF LN_contador = 0 THEN
    --Fin MA-70067
    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevBcoDocum_FN      ( pRevBcoDocum,      vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;
  end if;
    IF NOT CE_VALIDA_PAGO_PG.CE_IsRevFechaEfectiva_FN ( pRevFechaEfectiva, vcErrFrom, vcErrCode, vcErrMens ) THEN RAISE vExceptio; END IF;

    vcErrFrom := 'CE_APLICA_PAGO_PR';
    pResul:='0';
    pDescripcion:='Ejecución Exitosa';


    INSERT INTO CO_INTERFAZ_PAGOS (
        EMP_RECAUDADORA
       ,COD_CAJA_RECAUDA
       ,SER_SOLICITADO
       ,FEC_EFECTIVIDAD
       ,NUM_TRANSACCION
       ,NOM_USUARORA
       ,TIP_TRANSACCION
       ,SUB_TIP_TRANSAC
       ,COD_SERVICIO
       ,NUM_EJERCICIO
       ,COD_CLIENTE
       ,NUM_CELULAR
       ,IMP_PAGO
       ,NUM_FOLIOCTC
       ,NUM_IDENT
       ,TIP_VALOR
       ,NUM_DOCUMENTO
       ,COD_BANCO
       ,CTA_CORRIENTE
       ,COD_AUTORIZA
       ,NUM_TARJETA
       ,COD_OPERACION  /* Requerimiento de Soporte - #34406 capc 28-09-2006 */
       ,NUM_VENTA     /* Requerimiento de Soporte - #34406 capc 28-09-2006 */
       ,NUM_FOLIO     /* Requerimiento de Soporte - #34846 capc 03-11-2006 */
       ,COD_PLANSRV      /* MA 41252 - Soporte Rspool off
 CPalma 26/06/2007          */
    )
    VALUES (
        pRevempresa
       ,pRevCaja
       ,pRevCodSer
       ,TO_DATE(pRevFechaEfectiva,'YYYYMMDD HH24MISS')
       ,pRevNum_Oper
       ,pRevOperador
       ,pRevTipo
       ,pRevSubTipo
       ,pRevCod_Servicio
       ,pRevCi_Fecontab
       ,pRevCliente
       ,pRevCelular
       ,pRevMonto
       ,pRevFolio
       ,pRevRut
       ,pRevModPago
       ,pRevNumDocum
       ,pRevBcoDocum
       ,pRevCtaCte
       ,pRevCodAuto
       ,pNumTarjeta
       ,pCodOperacion  /* Requerimiento de Soporte - #34406 capc 28-09-2006 */
       ,pNumventa    /* Requerimiento de Soporte - #34406 capc 28-09-2006 */
       ,pNumFolio    /* Requerimiento de Soporte - #34846 capc 03-11-2006 */
       ,pCodPlanSrv      /* MA 41252 - Soporte R
 CPalma 26/06/2007          */
    );

EXCEPTION
    WHEN vExceptio THEN
        pResul:= vcErrCode;
        tmpDescri:= 'ERROR EN TRANSACCIÓN: [' || pRevNum_Oper || '], DESCRIPCIÓN: ' || vcErrMens;
        pDescripcion:= SUBSTR(tmpDescri, 1, 255);
        RETURN;

    WHEN OTHERS THEN
        pResul:= TO_CHAR(SQLCODE);
     tmpDescri:= 'ERROR EN TRANSACCIÓN: [' || pRevNum_Oper || '], DESCRIPCIÓN: ' || SUBSTR(SQLERRM, 1, 190);
        pDescripcion:= SUBSTR(tmpDescri, 1, 255);
        RETURN;

END CE_APLICA_PAGO_PR;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END ve_cargos_pg;
/
SHOW ERRORS