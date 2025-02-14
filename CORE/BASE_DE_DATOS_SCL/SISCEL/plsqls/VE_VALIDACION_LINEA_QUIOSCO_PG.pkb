CREATE OR REPLACE PACKAGE BODY ve_validacion_linea_quiosco_pg IS

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ve_convertir_fn (
      eb_valor   IN   BOOLEAN)
      RETURN PLS_INTEGER IS
   BEGIN
      IF eb_valor = TRUE THEN
         RETURN ci_true;
      ELSE
         RETURN ci_false;
      END IF;
   END ve_convertir_fn;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ve_validadiasmaxanulabaja_fn (
      ev_cod_plantarif   IN   ga_abocel.cod_plantarif%TYPE,
      ev_num_abonado     IN   ga_abocel.num_abonado%TYPE)
      RETURN BOOLEAN IS
      lv_fecha_actual   DATE;
      lv_num_plazodev   pv_plazodev_baja_to.num_plazodev%TYPE;
      lv_aux            ga_abocel.num_abonado%TYPE;
   BEGIN
      lv_fecha_actual := TRUNC (SYSDATE);
      /*SELECT NUM_PLAZODEV
      INTO LV_num_plazodev
      FROM PV_PLAZODEV_BAJA_TO
      WHERE COD_TIPLAN IN (SELECT COD_TIPLAN
                                    FROM TA_PLANTARIF
                                    WHERE COD_PLANTARIF = EV_cod_plantarif);*/
      lv_num_plazodev := NULL;

      SELECT val_parametro
        INTO lv_num_plazodev
        FROM ged_parametros
       WHERE nom_parametro = 'MAX_D_REUTIL';

      IF lv_num_plazodev IS NOT NULL THEN
         SELECT a.num_abonado
           INTO lv_aux
           FROM ga_abocel a
          WHERE a.num_abonado = ev_num_abonado AND a.fec_baja + lv_num_plazodev >= lv_fecha_actual
         UNION
         SELECT b.num_abonado
           FROM ga_aboamist b
          WHERE b.num_abonado = ev_num_abonado AND b.fec_baja + lv_num_plazodev >= lv_fecha_actual;

         IF lv_aux IS NULL THEN
            RETURN FALSE;
         ELSE
            RETURN TRUE;
         END IF;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RETURN FALSE;
   END ve_validadiasmaxanulabaja_fn;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existeserieabonado_pr (
      ev_seriesimcard   IN              ga_abocel.num_serie%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lv_esta            VARCHAR2 (1);
      ln_num_abonado     ga_abocel.num_abonado%TYPE;
      ln_num_venta       ga_abocel.num_venta%TYPE;
      lv_ind_ofiter      ga_ventas.ind_ofiter%TYPE;
      ln_cod_plantarif   ga_abocel.cod_plantarif%TYPE;
      lb_enrango         BOOLEAN;
      lv_sql             ge_errores_pg.vquery;
      lv_des_error       ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'SELECT 1 ' || 'FROM ga_abocel a ' || 'WHERE a.num_serie=' || ev_seriesimcard || 'AND a.cod_situacion not in (''BAA'', ''BAP'')' || 'UNION SELECT 1 ' || 'FROM ga_aboamist b ' || 'WHERE b.num_serie=' || ev_seriesimcard
         || 'AND b.cod_situacion not in (''BAA'', ''BAP'')';

                                                                                                                         --Incidencia 95563 [ACP Soporte Ventas 25-06-2009]

      sb_resultado := TRUE;

    BEGIN

       SELECT a.num_venta, a.num_abonado, a.cod_plantarif
       INTO LN_num_venta, LN_num_abonado, LN_cod_plantarif
       FROM ga_abocel a
       WHERE  a.num_serie=EV_seriesimcard
       AND a.cod_situacion NOT IN ('BAA', 'BAP')
       UNION
       SELECT b.num_venta, b.num_abonado, b.cod_plantarif
       FROM ga_aboamist b
       WHERE  b.num_serie=EV_seriesimcard
       AND b.cod_situacion NOT IN ('BAA', 'BAP');

       SB_resultado := FALSE;

       EXCEPTION
        WHEN NO_DATA_FOUND THEN
            SB_resultado := FALSE;

    END;


    IF LN_num_venta is not null THEN

        SELECT c.ind_ofiter
        INTO LV_ind_ofiter
        FROM ga_ventas c
        WHERE c.NUM_VENTA=LN_num_venta;

        IF LV_ind_ofiter = 'M' THEN
             SB_resultado := FALSE;
        ELSE
                LB_EnRango := VE_ValidaDiasMaxAnulaBaja_FN (LN_cod_plantarif,LN_num_abonado);
             IF LB_EnRango = TRUE THEN
               SB_resultado := TRUE;
             ELSE
                SB_resultado := FALSE;
             END IF;
        END IF;
    END IF;


   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sb_resultado    := FALSE;
         sn_cod_retorno  := 11198;
         sv_mens_retorno := 'Error al Consultar si existe Serie del Abonado';

      WHEN OTHERS THEN
         sn_cod_retorno  := 11198;
         sv_mens_retorno := 'Error al Consultar si existe Serie del Abonado';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_existeserieabonado_FN(' || ev_seriesimcard || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_existeserieabonado_FN(' || ev_seriesimcard || ')', lv_sql, SQLCODE, lv_des_error);
         sb_resultado    := FALSE;
   END ve_existeserieabonado_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existeserieabonado_pr (
      ev_seriesimcard   IN              ga_abocel.num_serie%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lb_aux   BOOLEAN;
   BEGIN
      ve_existeserieabonado_pr (ev_seriesimcard, lb_aux, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      sn_resultado := ve_convertir_fn (lb_aux);
   END ve_existeserieabonado_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_serieterminalenabonado_pr (
      ev_serieterminal   IN              ga_abocel.num_serie%TYPE,
      sb_resultado       OUT NOCOPY      BOOLEAN,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      lv_esta            VARCHAR2 (1);
      lv_sql             ge_errores_pg.vquery;
      lv_des_error       ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'SELECT 1 ' || 'FROM ga_abocel a ' || 'WHERE a.num_serie=' || ev_serieterminal || '  AND a.cod_situacion =' || cv_baja_abonado || 'UNION SELECT 1 ' || 'FROM ga_aboamist b ' || 'WHERE b.num_serie=' || ev_serieterminal || '  AND b.cod_situacion ='
         || cv_baja_abonado;

      SELECT '1'
        INTO lv_esta
        FROM ga_abocel a
       WHERE a.num_serie = ev_serieterminal AND a.cod_situacion = cv_baja_abonado
      UNION
      SELECT '1'
        FROM ga_aboamist b
       WHERE b.num_serie = ev_serieterminal AND b.cod_situacion = cv_baja_abonado;

      sb_resultado := TRUE;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sb_resultado    := FALSE;
         sn_cod_retorno  := 11222;
         sv_mens_retorno := 'Error no se obtuvieron datos para la Serie Terminal';

      WHEN OTHERS THEN
         sn_cod_retorno  := 11199;
         sv_mens_retorno := 'Error al Consultar Serie Terminal en Abonado';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_serieterminalenabonado_PR(' || ev_serieterminal || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_serieterminalenabonado_PR(' || ev_serieterminal || ')', lv_sql, SQLCODE, lv_des_error);
         sb_resultado    := FALSE;
   END ve_serieterminalenabonado_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_serieterminalenabonado_pr (
      ev_serieterminal   IN              ga_abocel.num_serie%TYPE,
      sn_resultado       OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      lb_aux   BOOLEAN;
   BEGIN
      ve_serieterminalenabonado_pr (ev_serieterminal, lb_aux, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      sn_resultado := ve_convertir_fn (lb_aux);
   END ve_serieterminalenabonado_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existeseriebodega_pr (
      ev_serie          IN              al_series.num_serie%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      lv_resultado   VARCHAR2 (1);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sb_resultado := FALSE;
      lv_resultado := '0';
      lv_sql := 'SELECT 1' || ' FROM   al_series series, al_articulos articulos' || ' WHERE series.num_serie=' || ev_serie || ' AND series.cod_articulo = articulos.cod_articulo';

      SELECT '1'
        INTO lv_resultado
        FROM al_series series, al_articulos articulos
       WHERE series.num_serie = ev_serie AND series.cod_articulo = articulos.cod_articulo;

      sb_resultado := TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sb_resultado    := FALSE;
         sn_cod_retorno  := 11223;
         sv_mens_retorno := 'Error al consultar por número de Serie';

      WHEN OTHERS THEN
         sb_resultado    := FALSE;
         sn_cod_retorno  := 11200;
         sv_mens_retorno := 'Error al consultar si existe Serie de Bodega';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_existeseriebodega_PR(' || ev_serie || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_existeseriebodega_PR(' || ev_serie || ')', lv_sql, SQLCODE, lv_des_error);
         sb_resultado    := FALSE;

   END ve_existeseriebodega_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existeseriebodega_pr (
      ev_serie          IN              al_series.num_serie%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lb_aux   BOOLEAN;
   BEGIN
      ve_existeseriebodega_pr (ev_serie, lb_aux, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      sn_resultado := ve_convertir_fn (lb_aux);

   END ve_existeseriebodega_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_vendedorbodega_pr (
      ev_codvendedor    IN              ve_vendedores.cod_vendedor%TYPE,
      ev_codbodega      IN              al_series.cod_bodega%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      lv_esta        VARCHAR2 (1);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT 1 FROM ve_vendalmac ' || 'WHERE cod_vendedor=' || ev_codvendedor || ' AND cod_bodega=' || ev_codbodega || ' AND SYSDATE BETWEEN fec_asignacion AND nvl(fec_desasignac, SYSDATE)';

      SELECT '1'
        INTO lv_esta
        FROM ve_vendalmac
       WHERE cod_vendedor = ev_codvendedor AND cod_bodega = ev_codbodega AND SYSDATE BETWEEN fec_asignacion AND NVL (fec_desasignac, SYSDATE);

      sb_resultado := TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sb_resultado    := FALSE;
         sn_cod_retorno  := 0;
         sv_mens_retorno := 'Error al Consultar vendedor Bodega';

      WHEN OTHERS THEN
         sn_cod_retorno  := 11201;
         sv_mens_retorno := 'Error al Consultar vendedor Bodega';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_vendedorbodega_FN(' || ev_codvendedor || ',' || ev_codbodega || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_vendedorbodega_FN(' || ev_codvendedor || ',' || ev_codbodega || ')', lv_sql, SQLCODE, lv_des_error);
         sb_resultado    := FALSE;

   END ve_vendedorbodega_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_vendedorbodega_pr (
      ev_codvendedor    IN              ve_vendedores.cod_vendedor%TYPE,
      ev_codbodega      IN              al_series.cod_bodega%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lb_aux   BOOLEAN;
   BEGIN
      ve_vendedorbodega_pr (ev_codvendedor, ev_codbodega, lb_aux, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      sn_resultado := ve_convertir_fn (lb_aux);
   END ve_vendedorbodega_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_terminallistanegra_pr (
      ev_serieterminal   IN              ga_abocel.num_serie%TYPE,
      sb_resultado       OUT NOCOPY      BOOLEAN,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      lv_esta        VARCHAR2 (1);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT 1 FROM ga_lncelu a ' || 'WHERE     a.num_serie=' || ev_serieterminal;

      SELECT '1'
        INTO lv_esta
        FROM ga_lncelu a
       WHERE a.num_serie = ev_serieterminal;

      sb_resultado := TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sb_resultado    := FALSE;
         sn_cod_retorno  := 0;
         sv_mens_retorno := 'Error al consultar Terminal Lista Negra';

      WHEN OTHERS THEN
         sn_cod_retorno  := 11202;
         sv_mens_retorno := 'Error al consultar Terminal Lista Negra';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_terminallistanegra_FN(' || ev_serieterminal || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_terminallistanegra_FN(' || ev_serieterminal || ')', lv_sql, SQLCODE, lv_des_error);
         sb_resultado    := FALSE;

   END ve_terminallistanegra_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_terminallistanegra_pr (
      ev_serieterminal   IN              ga_abocel.num_serie%TYPE,
      sn_resultado       OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      lb_aux   BOOLEAN;
   BEGIN
      ve_terminallistanegra_pr (ev_serieterminal, lb_aux, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      sn_resultado := ve_convertir_fn (lb_aux);
   END ve_terminallistanegra_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existe_plan_tarifario_pr (
      ev_plantarif      IN              ta_plantarif.cod_plantarif%TYPE,
      en_codproducto    IN              ga_modvent_aplic.cod_producto%TYPE,
      ev_tecnologia     IN              al_tecnologia.cod_tecnologia%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      lv_resultado   VARCHAR2 (1);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'SELECT decode(max(cargosbasicos.FEC_DESDE),NULL,0,1)' || ' FROM ta_plantarif plantarifario, ta_cargosbasico cargosbasicos' || ' WHERE plantarifario.cod_plantarif= ' || ev_plantarif || ' AND SYSDATE BETWEEN plantarifario.fec_desde '
         || ' AND NVL(plantarifario.fec_hasta, SYSDATE)' || ' AND plantarifario.cod_cargobasico= cargosbasicos.cod_cargobasico ' || ' AND plantarifario.cod_producto =' || en_codproducto || ' AND SYSDATE BETWEEN cargosbasicos.fec_desde '
         || ' AND NVL(cargosbasicos.fec_hasta, SYSDATE)' || ' AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif' || ' AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto'
         || ' AND relserviciotecnoplantarif.cod_tecnologia =' || ev_tecnologia;

      SELECT DECODE (MAX (cargosbasicos.fec_desde), NULL, '0', '1')
        INTO lv_resultado
        FROM ta_plantarif plantarifario, ta_cargosbasico cargosbasicos, ga_plantecplserv relserviciotecnoplantarif
       WHERE plantarifario.cod_plantarif = ev_plantarif AND SYSDATE BETWEEN plantarifario.fec_desde AND NVL (plantarifario.fec_hasta, SYSDATE) AND plantarifario.cod_cargobasico = cargosbasicos.cod_cargobasico
             AND plantarifario.cod_producto = en_codproducto AND SYSDATE BETWEEN cargosbasicos.fec_desde AND NVL (cargosbasicos.fec_hasta, SYSDATE) AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif
             AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto AND relserviciotecnoplantarif.cod_tecnologia = ev_tecnologia;

      IF (lv_resultado = '1') THEN
         sb_resultado := TRUE;
      ELSE
         sb_resultado := FALSE;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sb_resultado    := FALSE;
         sn_cod_retorno  := 0;
         sv_mens_retorno := 'No se encontraron datos para el Plan Tarifario';

      WHEN OTHERS THEN
         sn_cod_retorno  := 11203;
         sv_mens_retorno := 'Error al Consultar si existe Plan Tarifario';
         lv_des_error    := 'OTHERS:VE_validaarchivo_PR.VE_existe_plan_tarifario_FN(' || ev_plantarif || ',' || en_codproducto || ',' || ev_tecnologia || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_existe_plan_tarifario_PR(' || ev_plantarif || ')', lv_sql, SQLCODE, lv_des_error);
         sb_resultado    := FALSE;
   END ve_existe_plan_tarifario_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existe_plan_tarifario_pr (
      ev_plantarif      IN              ta_plantarif.cod_plantarif%TYPE,
      en_codproducto    IN              ga_modvent_aplic.cod_producto%TYPE,
      ev_tecnologia     IN              al_tecnologia.cod_tecnologia%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lb_aux   BOOLEAN;
   BEGIN
      ve_existe_plan_tarifario_pr (ev_plantarif, en_codproducto, ev_tecnologia, lb_aux, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      sn_resultado := ve_convertir_fn (lb_aux);
   END ve_existe_plan_tarifario_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ve_existe_vendedor_fn (
      ev_cod_vendedor   IN              ve_vendedores.cod_vendedor%TYPE,
      ev_ind_interno    OUT NOCOPY      ve_vendedores.ind_interno%TYPE,
      sv_cod_cliente    OUT NOCOPY      ve_vendedores.cod_cliente%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT a.ind_interno, a.cod_cliente ' || 'FROM    ve_vendedores a' || 'WHERE  a.cod_vendedor=' || ev_cod_vendedor || 'AND SYSDATE BETWEEN a.fec_contrato ' || 'AND NVL(a.fec_fincontrato, SYSDATE)';

      SELECT a.ind_interno, a.cod_cliente
        INTO ev_ind_interno, sv_cod_cliente
        FROM ve_vendedores a
       WHERE a.cod_vendedor = ev_cod_vendedor AND SYSDATE BETWEEN a.fec_contrato AND NVL (a.fec_fincontrato, SYSDATE);

      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RETURN FALSE;
         sn_cod_retorno  := 0;
         sv_mens_retorno := 'No se encontraron datos asociados código de Vendedor';

      WHEN OTHERS THEN
         sn_cod_retorno  := 11204;
         sv_mens_retorno := 'Error al Consultar si Existe Vendedor';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_existe_vendedor_FN(' || ev_cod_vendedor || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_existe_vendedor_FN(' || ev_cod_vendedor || ')', lv_sql, SQLCODE, lv_des_error);
         RETURN FALSE;
   END ve_existe_vendedor_fn;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existe_evaluacion_riesgo_pr (
      ev_numident         IN              ge_clientes.num_ident%TYPE,
      ev_tipident         IN              ge_clientes.cod_tipident%TYPE,
      en_tipo_solicitud   IN              ert_solicitud.ind_tipo_solicitud%TYPE,
      en_ind_evento       IN              ert_solicitud.ind_evento%TYPE,
      ev_cod_estado       IN              VARCHAR2,
      ev_tipocliente      IN              VARCHAR2,
      sb_resultado        OUT NOCOPY      BOOLEAN,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      lv_parametros     array_parametros_;
      lv_sql            ge_errores_pg.vquery;
      lv_des_error      ge_errores_pg.desevent;
      lv_esta           VARCHAR2 (1);
      lv_valparametro   ged_parametros.val_parametro%TYPE;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';

      IF ev_tipocliente = 'I' THEN
         ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr ('VIGENCIA_DAT_EXTERNA', cv_codmodulo, cv_codproducto, lv_valparametro, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
         lv_sql :=
            'SELECT 1' || ' FROM ert_solicitud a, ert_datos_consulta_to datos_evaluacion' || ' WHERE     a.num_ident_cliente = :EV_numident ' || ' AND a.cod_tipident = :EV_tipident ' || ' AND a.ind_tipo_solicitud = :EV_tipo_solicitud'
            || ' AND a.ind_evento = :EV_ind_evento' || ' AND a.cod_estado IN(:par1,:par2)' || ' AND a.num_ident_cliente =  datos_evaluacion.num_ident' || ' AND a.ind_tipo_solicitud =  datos_evaluacion.ind_tipo_solicitud'
            || ' AND SYSDATE <  datos_evaluacion.fecha_actualizacion + :LV_valparametro';
         lv_parametros (1) := SUBSTR (ev_cod_estado, 2, 1);
         lv_parametros (2) := SUBSTR (ev_cod_estado, 6, 1);

         EXECUTE IMMEDIATE lv_sql
                      INTO lv_esta
                     USING IN ev_numident, ev_tipident, en_tipo_solicitud, en_ind_evento, lv_parametros (1), lv_parametros (2), lv_valparametro;
      ELSE
         lv_sql :=
            'SELECT 1' || ' FROM ert_solicitud a' || ' WHERE     a.num_ident_cliente = :EV_numident ' || ' AND a.cod_tipident = :EV_tipident ' || ' AND a.ind_tipo_solicitud = :EV_tipo_solicitud' || ' AND a.ind_evento = :EV_ind_evento'
            || ' AND a.cod_estado IN(:par1,:par2)';
         lv_parametros (1) := SUBSTR (ev_cod_estado, 2, 1);
         lv_parametros (2) := SUBSTR (ev_cod_estado, 6, 1);

         EXECUTE IMMEDIATE lv_sql
                      INTO lv_esta
                     USING IN ev_numident, ev_tipident, en_tipo_solicitud, en_ind_evento, lv_parametros (1), lv_parametros (2);
      END IF;

      sb_resultado := TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sb_resultado    := FALSE;
         sn_cod_retorno  := 11205;
         sv_mens_retorno := 'Error al consultar si existe Evaluación de Riesgo';

     WHEN OTHERS THEN
         sn_cod_retorno  := 11205;
         sv_mens_retorno := 'Error al consultar si existe Evaluación de Riesgo';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_existe_evaluacion_riesgo_PR(' || ev_numident || ',' || ev_tipident || ',' || en_tipo_solicitud || ',' || en_ind_evento || ',' || ev_cod_estado || ',' || ev_tipocliente || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_existe_evaluacion_riesgo_PR(' || ev_numident || ',' || en_tipo_solicitud || ',' || ev_cod_estado || ')', lv_sql, SQLCODE,lv_des_error);
         sb_resultado    := FALSE;
         sv_mens_retorno := lv_sql;
   END ve_existe_evaluacion_riesgo_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existe_evaluacion_riesgo_pr (
      ev_numident         IN              ge_clientes.num_ident%TYPE,
      ev_tipident         IN              ge_clientes.cod_tipident%TYPE,
      en_tipo_solicitud   IN              ert_solicitud.ind_tipo_solicitud%TYPE,
      en_ind_evento       IN              ert_solicitud.ind_evento%TYPE,
      ev_cod_estado       IN              VARCHAR2,
      ev_tipocliente      IN              VARCHAR2,
      sn_resultado        OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      lb_aux   BOOLEAN;
   BEGIN
      ve_existe_evaluacion_riesgo_pr (ev_numident, ev_tipident, en_tipo_solicitud, en_ind_evento, ev_cod_estado, ev_tipocliente, lb_aux, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      sn_resultado := ve_convertir_fn (lb_aux);
   END ve_existe_evaluacion_riesgo_pr;


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existe_eriesgo_ptarif_pr (
      ev_numident         IN              ge_clientes.num_ident%TYPE,
      ev_tipident         IN              ge_clientes.cod_tipident%TYPE,
      en_tipo_solicitud   IN              ert_solicitud.ind_tipo_solicitud%TYPE,
      en_ind_evento       IN              ert_solicitud.ind_evento%TYPE,
      ev_cod_estado       IN              VARCHAR2,
      ev_plantarif        IN              ert_solicitud_planes.cod_plantarif%TYPE,
      sb_resultado        OUT NOCOPY      BOOLEAN,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      lv_parametros   array_parametros_;
      lv_sql          ge_errores_pg.vquery;
      lv_des_error    ge_errores_pg.desevent;
      lv_estado       VARCHAR2 (1);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'SELECT  1' || ' FROM      ert_solicitud_planes b,ert_solicitud a' || ' WHERE     a.num_ident_cliente = :EV_numident' || ' AND a.cod_tipident = :EV_tipident' || ' AND a.num_solicitud = b.num_solicitud'
         || ' AND a.ind_tipo_solicitud = :EN_tipo_solicitud' || ' AND a.ind_evento =:EN_ind_evento' || ' AND a.cod_estado IN(:par1,:par2)' || ' AND b.cod_plantarif = :EV_plantarif';
      lv_parametros (1) := SUBSTR (ev_cod_estado, 2, 1);
      lv_parametros (2) := SUBSTR (ev_cod_estado, 6, 1);

      EXECUTE IMMEDIATE lv_sql
                   INTO lv_estado
                  USING IN ev_numident, ev_tipident, en_tipo_solicitud, en_ind_evento, lv_parametros (1), lv_parametros (2), ev_plantarif;

      sb_resultado := TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sb_resultado    := FALSE;
         sn_cod_retorno  := 0 ;
         sv_mens_retorno := 'Error al consultar si Existe Riesgo Plan Tarifario';

      WHEN OTHERS THEN
         sn_cod_retorno  := 11206 ;
         sv_mens_retorno := 'Error al consultar si Existe Riesgo Plan Tarifario';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_existe_eriesgo_ptarif_PR(' || ev_numident || ',' || ev_tipident || ',' || en_tipo_solicitud || ',' || en_ind_evento || ',' || ev_cod_estado || ',' || ev_plantarif || ')- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_existe_eriesgo_ptarif_PR(' || ev_numident || ',' || en_tipo_solicitud || ',' || ev_cod_estado || ')', lv_sql, SQLCODE, lv_des_error);
         sb_resultado    := FALSE;
   END ve_existe_eriesgo_ptarif_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existe_eriesgo_ptarif_pr (
      ev_numident         IN              ge_clientes.num_ident%TYPE,
      ev_tipident         IN              ge_clientes.cod_tipident%TYPE,
      en_tipo_solicitud   IN              ert_solicitud.ind_tipo_solicitud%TYPE,
      en_ind_evento       IN              ert_solicitud.ind_evento%TYPE,
      ev_cod_estado       IN              VARCHAR2,
      ev_plantarif        IN              ert_solicitud_planes.cod_plantarif%TYPE,
      sn_resultado        OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      lb_aux   BOOLEAN;
   BEGIN
      ve_existe_eriesgo_ptarif_pr (ev_numident, ev_tipident, en_tipo_solicitud, en_ind_evento, ev_cod_estado, ev_plantarif, lb_aux, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      sn_resultado := ve_convertir_fn (lb_aux);
   END ve_existe_eriesgo_ptarif_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_agente_comercial_pr (
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      lv_existe      VARCHAR2 (1);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT 1 FROM    npt_usuario_cliente a ' || 'WHERE  a.cod_cliente=' || ev_codcliente;

      SELECT '1'
        INTO lv_existe
        FROM npt_usuario_cliente a
       WHERE a.cod_cliente = ev_codcliente;

      sb_resultado := TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sb_resultado    := FALSE;
         sn_cod_retorno  := 0;
         sv_mens_retorno := 'No se encontraron Agente Comercial asociado al codigo de cliente';

      WHEN OTHERS THEN
         sn_cod_retorno  := 11207;
         sv_mens_retorno := 'Error al consultar Agente Comercial';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_agente_comercial_FN(' || ev_codcliente || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_agente_comercial_FN(' || ev_codcliente || ')', lv_sql, SQLCODE, lv_des_error);
         sb_resultado    := FALSE;
   END ve_agente_comercial_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_agente_comercial_pr (
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lb_aux   BOOLEAN;
   BEGIN
      ve_agente_comercial_pr (ev_codcliente, lb_aux, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      sn_resultado := ve_convertir_fn (lb_aux);
   END ve_agente_comercial_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existe_cliente_pr (
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql                            ge_errores_pg.vquery;
      lv_des_error                      ge_errores_pg.desevent;
      lv_esta                           VARCHAR2 (1);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'SELECT ''' || '1' || '''' || 'FROM     ge_clientes cliente,' || 'ge_direcciones direccion, ga_direccli direccioncliente,' || 'ge_ciudades ciudad' || 'WHERE    cliente.cod_cliente = ' || ev_codcliente
         || 'AND direccioncliente.cod_cliente = cliente.cod_cliente' || 'AND direccioncliente.cod_tipdireccion = ' || cv_tipodireccion || 'AND direccion.cod_direccion = direccioncliente.cod_direccion' || 'AND ciudad.cod_ciudad = direccion.cod_ciudad'
         || 'AND ciudad.cod_provincia = direccion.cod_provincia' || 'AND ciudad.cod_region = direccion.cod_region' || 'AND cliente.fec_baja IS NULL';

      SELECT '1'
        INTO lv_esta
        FROM ge_clientes cliente, ge_direcciones direccion, ga_direccli direccioncliente, ge_ciudades ciudad
       WHERE cliente.cod_cliente = ev_codcliente AND direccioncliente.cod_cliente = cliente.cod_cliente AND direccioncliente.cod_tipdireccion = cv_tipodireccion AND direccion.cod_direccion = direccioncliente.cod_direccion
             AND ciudad.cod_ciudad = direccion.cod_ciudad AND ciudad.cod_provincia = direccion.cod_provincia AND ciudad.cod_region = direccion.cod_region AND cliente.fec_baja IS NULL;

      sb_resultado := TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sb_resultado    := FALSE;
         sn_cod_retorno  := 0;
         sv_mens_retorno := 'No se encontraron datos asociados al Cliente';

      WHEN OTHERS THEN
         sn_cod_retorno  := 11208;
         sv_mens_retorno := 'Error al consultar si existe Cliente';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_existe_cliente_PR(' || ev_codcliente || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_existe_cliente_PR(' || ev_codcliente || ')', lv_sql, SQLCODE, lv_des_error);
         sb_resultado    := FALSE;
   END ve_existe_cliente_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existe_cliente_pr (
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lb_aux   BOOLEAN;
   BEGIN
      ve_existe_cliente_pr (ev_codcliente, lb_aux, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      sn_resultado := ve_convertir_fn (lb_aux);
   END ve_existe_cliente_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existe_cliente_empresa_pr (
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      lv_esta        VARCHAR2 (1);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'SELECT ''' || '1' || '''' || 'FROM     ge_clientes a, ga_empresa b,' || 'ge_direcciones c, ga_direccli d,' || 'ge_ciudades e' || 'WHERE    cliente.cod_cliente = ' || ev_codcliente || 'AND cliente.cod_cliente = empresa.cod_cliente(+)'
         || 'AND direccioncliente.cod_cliente = cliente.cod_cliente' || 'AND direccioncliente.cod_tipdireccion = ' || cv_tipodireccion || 'AND direccion.cod_direccion = direccioncliente.cod_direccion' || 'AND ciudad.cod_ciudad = direccion.cod_ciudad'
         || 'AND ciudad.cod_provincia = direccion.cod_provincia' || 'AND ciudad.cod_region = direccion.cod_region';

      SELECT '1'
        INTO lv_esta
        FROM ge_clientes cliente, ga_empresa empresa, ge_direcciones direccion, ga_direccli direccioncliente, ge_ciudades ciudad
       WHERE cliente.cod_cliente = ev_codcliente AND cliente.cod_cliente = empresa.cod_cliente(+) AND direccioncliente.cod_cliente = cliente.cod_cliente AND direccioncliente.cod_tipdireccion = cv_tipodireccion
             AND direccion.cod_direccion = direccioncliente.cod_direccion AND ciudad.cod_ciudad = direccion.cod_ciudad AND ciudad.cod_provincia = direccion.cod_provincia AND ciudad.cod_region = direccion.cod_region;

      sb_resultado := TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sb_resultado    := FALSE;
         sn_cod_retorno  := 0;
         sv_mens_retorno := 'Error al consultar si existe Cliente Empresa';

      WHEN OTHERS THEN
         sn_cod_retorno  := 11209;
         sv_mens_retorno := 'Error al consultar si existe Cliente Empresa';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_existe_cliente_empresa_PR(' || ev_codcliente || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_existe_cliente_empresa_PR(' || ev_codcliente || ')', lv_sql, SQLCODE, lv_des_error);
         sb_resultado    := FALSE;
   END ve_existe_cliente_empresa_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existe_cliente_empresa_pr (
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lb_aux   BOOLEAN;
   BEGIN
      ve_existe_cliente_empresa_pr (ev_codcliente, lb_aux, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      sn_resultado := ve_convertir_fn (lb_aux);
   END ve_existe_cliente_empresa_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existe_contrato_pr (
      ev_numcontrato    IN              ga_contcta.num_contrato%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      lv_esta        VARCHAR2 (1);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT 1 FROM ga_contcta ga ' || 'WHERE ga.num_contrato = ' || ev_numcontrato;

      SELECT '1'
        INTO lv_esta
        FROM ga_contcta ga
       WHERE ga.num_contrato = ev_numcontrato;

      sb_resultado := TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sb_resultado    := FALSE;
         sn_cod_retorno  := 0;
         sv_mens_retorno := 'Error al consultar si existe Contrato';

      WHEN OTHERS THEN
         sn_cod_retorno  := 11210;
         sv_mens_retorno := 'Error al consultar si existe Contrato';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_existe_contrato_PR(' || ev_numcontrato || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_existe_contrato_PR(' || ev_numcontrato || ')', lv_sql, SQLCODE, lv_des_error);
         sb_resultado    := FALSE;
   END ve_existe_contrato_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existe_contrato_pr (
      ev_numcontrato    IN              ga_contcta.num_contrato%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lb_aux   BOOLEAN;
   BEGIN
      ve_existe_contrato_pr (ev_numcontrato, lb_aux, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      sn_resultado := ve_convertir_fn (lb_aux);
   END ve_existe_contrato_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_vendedor_numero_pr (
      ev_numcelular     IN              ga_abocel.num_celular%TYPE,
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sv_codvendedor    OUT NOCOPY      ve_vendedores.cod_vendedor%TYPE,
      sv_coduso         OUT NOCOPY      al_usos.cod_uso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT a.cod_vendedor, a.cod_uso ' || 'FROM    ga_reserva a ' || 'WHERE    a.num_celular=' || ev_numcelular || 'AND a.cod_cliente=' || ev_codcliente;

      SELECT a.cod_vendedor, a.cod_uso
        INTO sv_codvendedor, sv_coduso
        FROM ga_reserva a
       WHERE a.num_celular = ev_numcelular AND a.cod_cliente = ev_codcliente;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11212;
         sv_mens_retorno := 'Error al consultar Código de Vendedor';

      WHEN OTHERS THEN
         sn_cod_retorno  := 11211;
         sv_mens_retorno := 'Error al consultar Numero de Vendedor';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_vendedor_numero_PR(' || ev_numcelular || ',' || ev_codcliente || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_vendedor_numero_PR(' || ev_numcelular || ',' || ev_codcliente || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_vendedor_numero_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_actualiza_eriesgo_pr (
      ev_numsolicitud   IN              ert_solicitud.num_solicitud%TYPE,
      ev_cod_estado     IN              ert_solicitud.cod_estado%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'UPDATE ert_solicitud set cod_estado=' || ev_cod_estado || 'WHERE  num_solicitud=' || ev_numsolicitud;

      UPDATE ert_solicitud
         SET cod_estado = ev_cod_estado
       WHERE num_solicitud = ev_numsolicitud;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 11213;
         sv_mens_retorno := 'Error al actualizar Riesgo';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_actualiza_eriesgo_PR(' || ev_numsolicitud || ',' || ev_cod_estado || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_actualiza_eriesgo_PR(' || ev_numsolicitud || ',' || ev_cod_estado || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_actualiza_eriesgo_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_tipostock_valido_pr (
      ev_tipstock       IN              al_series.tip_stock%TYPE,
      ev_modventa       IN              ga_modvent_aplic.cod_modventa%TYPE,
      ev_codproducto    IN              ga_modvent_aplic.cod_producto%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      lv_resultado   VARCHAR2 (1);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'SELECT UNIQUE 1 ' || 'FROM ga_modvent_aplic c ' || 'WHERE  c.cod_producto = ' || ev_codproducto || ' AND c.cod_modventa = ' || ev_modventa || ' AND c.cod_modventa IN (SELECT cod_modventa_nue ' || 'FROM   ga_modvent_aplic d '
         || 'WHERE  c.cod_modventa=d.cod_modventa) ' || 'AND c.tip_stock IN (' || ev_tipstock || ')';

      SELECT UNIQUE '1'
               INTO lv_resultado
               FROM ga_modvent_aplic c
              WHERE c.cod_producto = ev_codproducto AND c.cod_modventa = ev_modventa AND c.cod_modventa IN (SELECT cod_modventa_nue
                                                                                                              FROM ga_modvent_aplic d
                                                                                                             WHERE c.cod_modventa = d.cod_modventa) AND c.tip_stock IN (ev_tipstock);

      sb_resultado := TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 0;
         sv_mens_retorno :='Error al consultar Tipo de Stock';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_tipostock_valido_PR(' || ev_tipstock || ',' || ev_modventa || ',' || ev_codproducto || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_tipostock_valido_PR(' || ev_tipstock || ',' || ev_modventa || ',' || ev_codproducto || ')', lv_sql, SQLCODE, lv_des_error);
         sb_resultado    := FALSE;

      WHEN OTHERS THEN
         sn_cod_retorno  := 11214;
         sv_mens_retorno := 'Error al consultar Tipo Stock es valido';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_tipostock_valido_PR(' || ev_tipstock || ',' || ev_modventa || ',' || ev_codproducto || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_tipostock_valido_PR(' || ev_tipstock || ',' || ev_modventa || ',' || ev_codproducto || ')', lv_sql, SQLCODE, lv_des_error);
         sb_resultado    := FALSE;
   END ve_tipostock_valido_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_tipostock_valido_pr (
      ev_tipstock       IN              al_series.tip_stock%TYPE,
      ev_modventa       IN              ga_modvent_aplic.cod_modventa%TYPE,
      ev_codproducto    IN              ga_modvent_aplic.cod_producto%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lb_aux   BOOLEAN;
   BEGIN
      ve_tipostock_valido_pr (ev_tipstock, ev_modventa, ev_codproducto, lb_aux, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      sn_resultado := ve_convertir_fn (lb_aux);
   END ve_tipostock_valido_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_obtiene_valor_parametro_pr (
      ev_nomparametro   IN              ged_parametros.nom_parametro%TYPE,
      ev_codmodulo      IN              ged_parametros.cod_modulo%TYPE,
      ev_codproducto    IN              ged_parametros.cod_producto%TYPE,
      sv_valparametro   OUT NOCOPY      ged_parametros.val_parametro%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT a.val_parametro ' || 'FROM    ged_parametros a ' || 'WHERE     a.nom_parametro=' || ev_nomparametro || ' AND a.cod_modulo=' || ev_codmodulo || ' AND a.cod_producto=' || ev_codproducto;

      SELECT a.val_parametro
        INTO sv_valparametro
        FROM ged_parametros a
       WHERE a.nom_parametro = ev_nomparametro AND a.cod_modulo = ev_codmodulo AND a.cod_producto = ev_codproducto;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10261;
         sv_mens_retorno :='Problemas al obtener valor del parametro';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_obtiene_valor_parametro_PR(' || ev_nomparametro || ',' || ev_codmodulo || ',' || ev_codproducto || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_obtiene_valor_parametro_PR(' || ev_nomparametro || ',' || ev_codmodulo || ',' || ev_codproducto || ')', lv_sql, SQLCODE,                                    lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10261;
         sv_mens_retorno :='Problemas al obtener valor del parametro';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_obtiene_valor_parametro_PR(' || ev_nomparametro || ',' || ev_codmodulo || ',' || ev_codproducto || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_obtiene_valor_parametro_PR(' || ev_nomparametro || ',' || ev_codmodulo || ',' || ev_codproducto || ')', lv_sql, SQLCODE,                                    lv_des_error);
   END ve_obtiene_valor_parametro_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existe_cuenta_pr (
      ev_codcuenta      IN              ga_cuentas.cod_cuenta%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sv_descuenta      OUT NOCOPY      ga_cuentas.des_cuenta%TYPE,
      sv_codcategoria   OUT NOCOPY      ga_cuentas.cod_categoria%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedure">
      <Elemento Nombre = "VE_existe_cuenta_PR"
                Lenguaje="PL/SQL"
              Fecha="05-03-2007"
              Version="1.0.0"
              Dise?ador="wjrc"
              Programador="wjrc"
              Ambiente="BD">
      <Retorno> PLS_INTEGER </Retorno>
      <Descripcion> obtiene datos de la cuenta </Descripcion>
      <Parametros>
      <Entrada>
              <param nom="EV_codcuenta" Tipo="NUMBER"> codigo de la cuenta </param>
      </Entrada>
      <Salida>
            <param nom="SB_resultado" Tipo="BOOLEAN"> resultado de la busqueda </param>
            <param nom="SV_descuenta" Tipo="STRING"> descripcion de la cuenta </param>
            <param nom="SV_codcategoria" Tipo="NUMBER"> codigo de la categoria </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT a.des_cuenta, a.cod_categoria ' || 'FROM    ga_cuentas a ' || 'WHERE  a.cod_cuenta = ' || ev_codcuenta;

      SELECT a.des_cuenta, a.cod_categoria
        INTO sv_descuenta, sv_codcategoria
        FROM ga_cuentas a
       WHERE a.cod_cuenta = ev_codcuenta;

      sb_resultado := TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sb_resultado    := FALSE;
         sn_cod_retorno  := 0;
         sv_mens_retorno := 'Error al consultar si existe Cuenta';

      WHEN OTHERS THEN
         sn_cod_retorno  := 11216;
         sv_mens_retorno := 'Error al consultar si existe Cuenta';
         lv_des_error    := 'OTHERS:ve_validacion_linea_quiosco_pg.VE_existe_cuenta_PR(' || ev_codcuenta || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_existe_cuenta_PR(' || ev_codcuenta || ')', lv_sql, SQLCODE, lv_des_error);
         sb_resultado    := FALSE;
   END ve_existe_cuenta_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existe_cuenta_pr (
      ev_codcuenta      IN              ga_cuentas.cod_cuenta%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sv_descuenta      OUT NOCOPY      ga_cuentas.des_cuenta%TYPE,
      sv_codcategoria   OUT NOCOPY      ga_cuentas.cod_categoria%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedure">
      <Elemento Nombre = "VE_existe_cuenta_PR"
                Lenguaje="PL/SQL"
              Fecha="05-03-2007"
              Version="1.0.0"
              Dise?ador="wjrc"
              Programador="wjrc"
              Ambiente="BD">
      <Retorno> PLS_INTEGER </Retorno>
      <Descripcion> convierte la salida boolean en entero </Descripcion>
      <Parametros>
      <Entrada>
              <param nom="EV_codcuenta" Tipo="NUMBER"> codigo de la cuenta </param>
      </Entrada>
      <Salida>
            <param nom="SN_resultado" Tipo="PLS_INTEGER"> resultado de la conversion </param>
            <param nom="SV_descuenta" Tipo="STRING"> descripcion de la cuenta </param>
            <param nom="SV_codcategoria" Tipo="NUMBER"> codigo de la categoria </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lb_aux   BOOLEAN;
   BEGIN
      ve_existe_cuenta_pr (ev_codcuenta, lb_aux, sv_descuenta, sv_codcategoria, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      sn_resultado := ve_convertir_fn (lb_aux);
   END ve_existe_cuenta_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_verifica_rechazo_serie_pr (
      ev_num_serie_equipo   IN              ga_det_preliq.num_serie_orig%TYPE,
      sn_resultado          OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_verifica_rechazo_serie_PR"
         Lenguaje="PL/SQL"
         Fecha="01-05-2007"
         Version="1.0.0"
         Dise?ador=" Mario Tigua"
         Programador=" Mario Tigua"
         Ambiente="BD"
      <Retorno> NA </Retorno>
      <Descripcion>
          Restorna 1 si la serie del equipo se encuentra en estado rechazada y sin una nota de credito,0 de lo contrario
      </Descripcion>
      <Parametros>
      <Entrada>
            <param nom="EV_num_serie_equipo" Tipo="VARCHAR"> Numero de serie del equipo </param>
      </Entrada>
      <Salida>
                <param nom="SN_resultado Tipo="NUMBER"> Resultado de la validacion </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT 1 ' || 'FROM    ga_preliquidacion a, ga_det_preliq b' || ' WHERE  a.num_venta = b.num_venta' || '  AND b.num_serie_orig = ' || ev_num_serie_equipo || '  AND a.ind_estventa = ' || cv_venta_rechazada || '  AND a.nota_credito IS NULL';

      SELECT 1
        INTO sn_resultado
        FROM ga_preliquidacion a, ga_det_preliq b
       WHERE a.num_venta = b.num_venta AND b.num_serie_orig = ev_num_serie_equipo AND a.ind_estventa = cv_venta_rechazada AND a.nota_credito IS NULL;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_resultado    := 0;
         sn_cod_retorno  := 11217;
         sv_mens_retorno := 'Error al consultar Rechazo de Serie del Equipo';
         sv_mens_retorno := 'NO_DATA_FOUND:VE_servicios_venta_quiosco_PG.VE_verifica_rechazo_serie_PR;- ' || SQLERRM;

      WHEN OTHERS THEN
         sn_resultado    := 0;
         sn_cod_retorno  := 11217;
         sv_mens_retorno := 'Error al consultar Rechazo de Serie del Equipo';
         lv_des_error    := 'OTHERS:VE_validacion_linea_quiosco_PG.VE_verifica_rechazo_serie_PR(' || ev_num_serie_equipo || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_validacion_linea_quiosco_PG.VE_verifica_rechazo_serie_PR (' || ev_num_serie_equipo || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_verifica_rechazo_serie_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_numeroreservadook_pr (
      en_numcelular     IN              ga_reserva.num_celular%TYPE,
      en_codcliente     IN              ga_reserva.cod_cliente%TYPE,
      en_codvendedor    IN              ga_reserva.cod_vendedor%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedure">
      <Elemento Nombre = "VE_numeroreservadoOK_PR"
                Lenguaje="PL/SQL"
              Fecha="03-05-2007"
              Version="1.0.0"
              Dise?ador="wjrc"
              Programador="wjrc"
              Ambiente="BD">
      <Retorno> PLS_INTEGER </Retorno>
      <Descripcion>
                 Verifica si el numero de celular esta reservado para el cliente y/o vendedor
      </Descripcion>
      <Parametros>
      <Entrada>
              <param nom="EN_numcelular"  Tipo="NUMBER"> numero de celular</param>
              <param nom="EN_codcliente"  Tipo="NUMBER"> codigo cliente</param>
              <param nom="EN_codvendedor" Tipo="NUMBER"> codigo vendedor</param>
      </Entrada>
      <Salida>
            <param nom="SN_resultado"    Tipo="BOOLEAN"> resultado boolean</param>
            <param nom="SN_cod_retorno   Tipo="NUMBER"> codigo error</param>
            <param nom="SV_mens_retorno" Tipo="STRING"> descripcion error</param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      ln_esta        NUMBER;
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sb_resultado := FALSE;
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'SELECT 1' || ' FROM   GA_RESERVA r' || ' WHERE  r.num_celular = ' || en_numcelular || ' AND ((r.cod_cliente = ' || en_codcliente || ' AND r.cod_vendedor =' || en_codvendedor || ')' || ' OR (r.cod_cliente IS NULL AND r.cod_vendedor = '
         || en_codvendedor || '))';

      SELECT 1
        INTO ln_esta
        FROM ga_reserva r
       WHERE r.num_celular = en_numcelular
         AND ((r.cod_cliente = en_codcliente AND r.cod_vendedor = en_codvendedor) OR (r.cod_cliente IS NULL AND r.cod_vendedor = en_codvendedor));

      sb_resultado := TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11218;
         sv_mens_retorno :='Error no se obtuvo resultados para número de celular';
         lv_des_error    := SUBSTR ('NO_DATA_FOUND:ve_validacion_linea_quiosco_pg.VE_numeroreservadoOK_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_numeroreservadoOK_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11219;
         sv_mens_retorno :='Error al consultar si número de celular se encuentra Reservado Cliente y/o Vendedor';
         lv_des_error    := SUBSTR ('OTHERS:ve_validacion_linea_quiosco_pg.VE_numeroreservadoOK_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_numeroreservadoOK_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_numeroreservadook_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_numeroreservadook_pr (
      en_numcelular     IN              ga_reserva.num_celular%TYPE,
      en_codcliente     IN              ga_reserva.cod_cliente%TYPE,
      en_codvendedor    IN              ga_reserva.cod_vendedor%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedure">
      <Elemento Nombre = "VE_numeroreservadoOK_PR"
                Lenguaje="PL/SQL"
              Fecha="03-05-2007"
              Version="1.0.0"
              Dise?ador="wjrc"
              Programador="wjrc"
              Ambiente="BD">
      <Retorno> PLS_INTEGER </Retorno>
      <Descripcion> convierte la salida boolean en entero </Descripcion>
      <Parametros>
      <Entrada>
              <param nom="EN_numcelular"  Tipo="NUMBER"> numero de celular</param>
              <param nom="EN_codcliente"  Tipo="NUMBER"> codigo cliente</param>
              <param nom="EN_codvendedor" Tipo="NUMBER"> codigo vendedor</param>
      </Entrada>
      <Salida>
            <param nom="SN_resultado"    Tipo="PLS_INTEGER"> resultado de la conversion</param>
            <param nom="SN_cod_retorno   Tipo="NUMBER"> codigo error</param>
            <param nom="SV_mens_retorno" Tipo="STRING"> descripcion error</param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lb_aux   BOOLEAN;
   BEGIN
      ve_numeroreservadook_pr (en_numcelular, en_codcliente, en_codvendedor, lb_aux, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      sn_resultado := ve_convertir_fn (lb_aux);
   END ve_numeroreservadook_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_existeusuario_pr (
      ev_nomusuario     IN              ga_usuarios.nom_usuario%TYPE,
      ev_apeusuario     IN              ga_usuarios.nom_apellido1%TYPE,
      sn_codusuario     OUT NOCOPY      ga_usuarios.cod_usuario%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedure">
      <Elemento Nombre = "VE_existeUsuario_PR"
                Lenguaje="PL/SQL"
              Fecha="28-07-2008"
              Version="1.0.0"
              Diseñador="wjrc"
              Programador="wjrc"
              Ambiente="BD">
      <Retorno> PLS_INTEGER </Retorno>
      <Descripcion>
                 Verifica si el usuario existe en tabla GA_USUARIOS
                 Si existe codUsuario ee mayor que cero
      </Descripcion>
      <Parametros>
      <Entrada>
              <param nom="EV_nomUsuario"  Tipo="STRING"> nombre usuario</param>
              <param nom="EV_apeUsuario"  Tipo="STRING"> apellido usuario</param>
      </Entrada>
      <Salida>
            <param nom="SN_codUsuario    Tipo="NUMBER"> codigo de usuario</param>
            <param nom="SN_cod_retorno   Tipo="NUMBER"> codigo error</param>
            <param nom="SV_mens_retorno" Tipo="STRING"> descripcion error</param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN

      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_codusuario := 0;

      lv_ssql := 'SELECT u.cod_usuario'
              || ' FROM  ga_usuarios u'
              || ' WHERE UPPER(u.nom_usuario) = UPPER('|| ev_nomusuario ||')'
              || ' AND UPPER(u.nom_apellido1) = UPPER('|| ev_apeusuario ||')';

      SELECT u.cod_usuario
        INTO sn_codusuario
        FROM ga_usuarios u
       WHERE UPPER (u.nom_usuario) = UPPER (ev_nomusuario)
         AND UPPER (u.nom_apellido1) = UPPER (ev_apeusuario);

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_codusuario   := 0;
         sn_cod_retorno  := 11221;
         sv_mens_retorno := 'Error al consultar por Usuario no válido';

     WHEN OTHERS THEN
         sn_codusuario   := 0;
         sn_cod_retorno  := 11220;
         sv_mens_retorno :='Error al consultar si existe Usuario';
         lv_des_error    := SUBSTR ('OTHERS:ve_validacion_linea_quiosco_pg.VE_existeUsuario_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_existeUsuario_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_existeusuario_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_rec_central_pr (
      ev_cod_central     IN              icg_central.cod_central%TYPE,
      ev_cod_celda       IN              ge_celdas.cod_celda%TYPE,
      sv_cod_central     OUT NOCOPY      VARCHAR2,
      sv_cod_producto    OUT NOCOPY      VARCHAR2,
      sv_nom_central     OUT NOCOPY      VARCHAR2,
      sv_cod_nemotec     OUT NOCOPY      VARCHAR2,
      sv_cod_alm         OUT NOCOPY      VARCHAR2,
      sv_num_maxintentos OUT NOCOPY      VARCHAR2,
      sv_cod_sistema     OUT NOCOPY      VARCHAR2,
      sv_cod_cobertura   OUT NOCOPY      VARCHAR2,
      sv_tie_respuesta   OUT NOCOPY      VARCHAR2,
      sv_nodocom         OUT NOCOPY      VARCHAR2,
      sv_cod_tecnologia  OUT NOCOPY      VARCHAR2,
      sv_cod_hlr           OUT NOCOPY      VARCHAR2,
      sv_cod_grupo_tec   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedure">
      <Elemento Nombre = "VE_existeUsuario_PR"
                Lenguaje="PL/SQL"
              Fecha="28-07-2008"
              Version="1.0.0"
              Diseñador="wjrc"
              Programador="wjrc"
              Ambiente="BD">
      <Retorno> PLS_INTEGER </Retorno>
      <Descripcion>
                 Verifica si el usuario existe en tabla GA_USUARIOS
                 Si existe codUsuario ee mayor que cero
      </Descripcion>
      <Parametros>
      <Entrada>
              <param nom="EV_nomUsuario"  Tipo="STRING"> nombre usuario</param>
              <param nom="EV_apeUsuario"  Tipo="STRING"> apellido usuario</param>
      </Entrada>
      <Salida>
            <param nom="SN_codUsuario    Tipo="NUMBER"> codigo de usuario</param>
            <param nom="SN_cod_retorno   Tipo="NUMBER"> codigo error</param>
            <param nom="SV_mens_retorno" Tipo="STRING"> descripcion error</param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN

      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';

      lv_ssql := 'SELECT a.cod_central, a.cod_producto, a.nom_central, a.cod_nemotec, a.cod_alm, a.num_maxintentos, a.cod_sistema, a.cod_cobertura, a.tie_respuesta, a.nodocom, a.cod_tecnologia, a.cod_hlr'
              || ' FROM icg_central a, ta_subcentral b, ge_subalms c, ge_celdas d'
              || ' WHERE a.cod_central = b.cod_central'
              || ' AND c.cod_alm     = a.cod_alm'
              || ' AND d.cod_subalm  = c.cod_subalm'
              || ' AND a.cod_central = '||ev_cod_central
              || ' AND d.cod_subalm  = '||ev_cod_celda;

       SELECT a.cod_central, a.cod_producto, a.nom_central, a.cod_nemotec, a.cod_alm, a.num_maxintentos, a.cod_sistema, a.cod_cobertura, a.tie_respuesta, a.nodocom, a.cod_tecnologia, a.cod_hlr, e.cod_grupo
         INTO sv_cod_central, sv_cod_producto, sv_nom_central, sv_cod_nemotec, sv_cod_alm, sv_num_maxintentos, sv_cod_sistema, sv_cod_cobertura, sv_tie_respuesta, sv_nodocom, sv_cod_tecnologia, sv_cod_hlr, sv_cod_grupo_tec
         FROM icg_central a, ta_subcentral b, ge_subalms c, ge_celdas d, al_tecnologia e
        WHERE a.cod_central = b.cod_central
          AND c.COD_ALM = a.COD_ALM
          AND d.cod_subalm = c.cod_subalm
          AND a.cod_central = ev_cod_central
          AND d.cod_celda = ev_cod_celda
          AND e.cod_tecnologia = a.cod_tecnologia;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 19000;
         sv_mens_retorno :='Error no existen datos para Central y SubAlm informados';
         lv_des_error    := SUBSTR ('OTHERS:ve_validacion_linea_quiosco_pg.VE_existeUsuario_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_existeUsuario_PR', lv_ssql, sn_cod_retorno, lv_des_error);

     WHEN OTHERS THEN
         sn_cod_retorno  := 19001;
         sv_mens_retorno :='Error al recuperar datos Central Subalm';
         lv_des_error    := SUBSTR ('OTHERS:ve_validacion_linea_quiosco_pg.VE_existeUsuario_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_validacion_linea_quiosco_pg.VE_existeUsuario_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_rec_central_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END ve_validacion_linea_quiosco_pg;
/
SHOW ERRORS