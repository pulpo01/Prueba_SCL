CREATE OR REPLACE PACKAGE BODY ve_portabilidad_impuesto_pg AS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_rec_oficina_central_fn(
    sv_cod_oficina        OUT NOCOPY      ge_oficinas.cod_oficina%TYPE,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
      LV_des_error    ge_errores_pg.desevent;
      LV_sql          ge_errores_pg.vquery;
      errro_ejecucion EXCEPTION;
   BEGIN
      SN_CodRetorno := 0;
      SV_MenRetorno := NULL;
      SN_NumEvento  := 0;

    LV_sql := 'SELECT cod_oficcentral'
               || ' FROM ge_datosgener';

      SELECT cod_oficcentral
      INTO sv_cod_oficina
        FROM ge_datosgener;

        RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         SN_CodRetorno := '200037';
         SV_MenRetorno := 'error al recuperar oficina central';
         LV_des_error  := 'OTHERS: er_integracion_impuesto_pg.er_rec_oficina_central_fn;- ' || SQLERRM;
         SN_NumEvento  := Ge_Errores_Pg.Grabarpl( SN_NumEvento, CV_MODULO_GA,SV_MenRetorno, '1.0', USER, 'er_integracion_impuesto_pg.er_rec_oficina_central_fn',LV_Sql, SQLCODE, LV_des_error);
         RETURN FALSE;
   END ve_rec_oficina_central_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_rec_oficina_vendedor_fn(
      en_cod_vendedor       IN              ve_vendedores.cod_vendedor%TYPE,
    sv_cod_oficina        OUT NOCOPY      ge_oficinas.cod_oficina%TYPE,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
      LV_des_error    ge_errores_pg.desevent;
      LV_sql          ge_errores_pg.vquery;
      errro_ejecucion EXCEPTION;
    error_datos     EXCEPTION   ;
   BEGIN
      SN_CodRetorno := 0;
      SV_MenRetorno := NULL;
      SN_NumEvento  := 0;

    IF en_cod_vendedor IS NOT NULL THEN

       LV_sql := 'SELECT a.cod_oficina'
                || ' FROM ve_vendedores a'
                || ' WHERE a.cod_vendedor = '||en_cod_vendedor;

         SELECT a.cod_oficina
       INTO sv_cod_oficina
           FROM ve_vendedores a
          WHERE a.cod_vendedor = en_cod_vendedor;

      ELSE
       RAISE error_datos;
    END IF;



      RETURN TRUE;

      EXCEPTION
         WHEN error_datos THEN
            SN_CodRetorno := '200038';
            SV_MenRetorno := 'error al recuperar la oficina del vendedor';
            LV_des_error  := 'error_datos: er_integracion_impuesto_pg.er_rec_oficina_vendedor_fn;- ' || SQLERRM;
            SN_NumEvento  := Ge_Errores_Pg.Grabarpl( SN_NumEvento, CV_MODULO_GA,SV_MenRetorno, '1.0', USER, 'er_integracion_impuesto_pg.er_rec_oficina_vendedor_fn',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
         WHEN NO_DATA_FOUND THEN
            SN_CodRetorno := '200039';
            SV_MenRetorno := 'error al recuperar la oficina del vendedor';
            LV_des_error  := 'NO_DATA_FOUND: er_integracion_impuesto_pg.er_rec_oficina_vendedor_fn;- ' || SQLERRM;
            SN_NumEvento  := Ge_Errores_Pg.Grabarpl( SN_NumEvento, CV_MODULO_GA,SV_MenRetorno, '1.0', USER, 'er_integracion_impuesto_pg.er_rec_oficina_vendedor_fn',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
         WHEN OTHERS THEN
            SN_CodRetorno := '200040';
            SV_MenRetorno := 'error al recuperar la oficina del vendedor';
            LV_des_error  := 'OTHERS: er_integracion_impuesto_pg.er_rec_oficina_vendedor_fn;- ' || SQLERRM;
            SN_NumEvento  := Ge_Errores_Pg.Grabarpl( SN_NumEvento, CV_MODULO_GA,SV_MenRetorno, '1.0', USER, 'er_integracion_impuesto_pg.er_rec_oficina_vendedor_fn',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END ve_rec_oficina_vendedor_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ve_rec_grupo_serv_fn(
      sn_cod_grpservi       OUT NOCOPY fa_grpserconc.cod_grpservi%TYPE,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS

      LV_des_error    ge_errores_pg.desevent;
      LV_sql          ge_errores_pg.vquery;
      errro_ejecucion EXCEPTION;
      VP_PROC  VARCHAR2(50);
      VP_TABLA VARCHAR2(50);
      VP_ACT   VARCHAR2(50);
      Error_apli VARCHAR2(50);
   BEGIN
      SN_CodRetorno := 0;
      SV_MenRetorno := NULL;
      SN_NumEvento  := 0;

      LV_sql := 'SELECT COD_GRPSERVI'
             || ' FROM FA_GRPSERCONC'
             || ' WHERE COD_CONCEPTO  IN (SELECT cod_abonocel FROM fa_datosgener)'
             || ' AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA';


      SELECT COD_GRPSERVI
        INTO sn_cod_grpservi
        FROM FA_GRPSERCONC
       WHERE COD_CONCEPTO  IN (SELECT cod_abonocel
                               FROM fa_datosgener)
         AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

      RETURN TRUE;

      EXCEPTION
         WHEN OTHERS THEN
            SN_CodRetorno := '200041';
            SV_MenRetorno := 'error al procesar impuestos ';
            LV_des_error  := 'VP_PROC ['||VP_PROC||'] - VP_TABLA ['||VP_TABLA||'] - VP_ACT['||VP_ACT||'] -- OTHERS: er_integracion_impuesto_pg.ER_ObtenerNumeroProceso_FN;- ' || SQLERRM;
            SN_NumEvento  := Ge_Errores_Pg.Grabarpl( SN_NumEvento, CV_MODULO_GA,SV_MenRetorno, '1.0', USER, 'er_integracion_impuesto_pg.er_ObtenerNumeroProceso_fn',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END ve_rec_grupo_serv_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_rec_zona_impo_FN(
      en_cod_vendedor       IN              ve_vendedores.cod_vendedor%TYPE,
      sn_cod_zonaimpo       OUT NOCOPY      ge_zonaciudad.cod_zonaimpo%TYPE,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS

      LV_des_error    ge_errores_pg.desevent;
      LV_sql          ge_errores_pg.vquery;
      error_ejecucion EXCEPTION;
      VP_PROC  VARCHAR2(50);
      VP_TABLA VARCHAR2(50);
      VP_ACT   VARCHAR2(50);
      Error_apli VARCHAR2(50);
    v_cod_oficina_v ve_vendedores.cod_oficina%TYPE;
   BEGIN
      SN_CodRetorno := 0;
      SV_MenRetorno := NULL;
      SN_NumEvento  := 0;

      IF NOT (ve_rec_oficina_vendedor_fn(en_cod_vendedor,v_cod_oficina_v,sn_codretorno,sv_menretorno,sn_numevento)) THEN
         IF NOT (ve_rec_oficina_central_fn(v_cod_oficina_v,sn_codretorno,sv_menretorno,sn_numevento)) THEN
        RAISE error_ejecucion;
     END IF;
      END IF;

      LV_sql := ' SELECT cod_zonaimpo FROM ge_zonaciudad a, ge_direcciones b, ge_oficinas c'
             || ' WHERE c.cod_oficina = '||v_cod_oficina_v
             || ' AND c.cod_direccion = b.cod_direccion'
             || ' AND a.cod_region = b.cod_region'
             || ' AND a.cod_provincia = b.cod_provincia'
             || ' AND a.cod_ciudad = b.cod_ciudad'
             || ' AND SYSDATE BETWEEN a.fec_desde AND a.fec_hasta';


      SELECT cod_zonaimpo
        INTO sn_cod_zonaimpo
        FROM ge_zonaciudad a, ge_direcciones b, ge_oficinas c
       WHERE c.cod_oficina = v_cod_oficina_v
         AND c.cod_direccion = b.cod_direccion
         AND a.cod_region = b.cod_region
         AND a.cod_provincia = b.cod_provincia
         AND a.cod_ciudad = b.cod_ciudad
         AND SYSDATE BETWEEN a.fec_desde AND a.fec_hasta;

      RETURN TRUE;

      EXCEPTION
         WHEN error_ejecucion THEN
            SN_CodRetorno := '200042';
            SV_MenRetorno := 'error al procesar impuestos ';

            LV_des_error  := 'error_ejecucion: er_integracion_impuesto_pg.er_rec_zona_impo_fn;- ' || SQLERRM;
            SN_NumEvento  := Ge_Errores_Pg.Grabarpl( SN_NumEvento, CV_MODULO_GA,SV_MenRetorno, '1.0', USER, 'er_integracion_impuesto_pg.er_rec_zona_impo_fn',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;

         WHEN OTHERS THEN
            SN_CodRetorno := '200042';
            SV_MenRetorno := 'error al procesar impuestos ';
            LV_des_error  := 'OTHERS: er_integracion_impuesto_pg.er_rec_zona_impo_fn;- ' || SQLERRM;
            SN_NumEvento  := Ge_Errores_Pg.Grabarpl( SN_NumEvento, CV_MODULO_GA,SV_MenRetorno, '1.0', USER, 'er_integracion_impuesto_pg.er_rec_zona_impo_fn',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END ve_rec_zona_impo_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ve_ObtenerCategImpositiva_FN(
      ev_tipident           IN             ge_clientes.COD_TIPIDENT%TYPE,
      ev_numident           IN             ge_clientes.NUM_IDENT%TYPE,
      en_codcliente         IN OUT NOCOPY  ge_clientes.COD_CLIENTE%TYPE,
      sn_codcatimpos        OUT NOCOPY     NUMBER,
      sn_codretorno         OUT NOCOPY     ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY     ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY     ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
      LV_des_error ge_errores_pg.desevent;
      LV_sql       ge_errores_pg.vquery;
   BEGIN
      SN_CodRetorno := 0;
      SV_MenRetorno := NULL;
      SN_NumEvento  := 0;

      SN_CodCatimpos := 0;

      IF (TRIM(EN_CodCliente) = '') OR (EN_CodCliente IS NULL) OR (EN_CodCliente = 0) THEN

         LV_sql := 'SELECT val_parametro FROM ged_parametros'
                || ' WHERE nom_parametro = ''' || CV_PARAMCATEGIMPOS || '''';

         SELECT val_parametro
           INTO sn_codcatimpos
           FROM ged_parametros
          WHERE nom_parametro = cv_paramcategimpos;

         EN_CodCliente := 1;

      ELSE
         LV_sql := 'SELECT b.cod_catimpos,a.cod_cliente'
                || ' FROM  ge_clientes a,ge_catimpclientes b'
                || ' WHERE a.cod_cliente = b.cod_cliente'
                || ' AND a.cod_tipident = ' || EV_TipIdent
                || ' AND a.num_ident = ' || EV_NumIdent
                || ' AND SYSDATE BETWEEN b.fec_desde AND b.fec_hasta'
                || ' AND ROWNUM <= 1';

         SELECT b.cod_catimpos, a.cod_cliente
           INTO sn_codcatimpos, en_codcliente
           FROM ge_clientes a, ge_catimpclientes b
          WHERE a.cod_cliente = b.cod_cliente
            AND a.cod_cliente = en_codcliente
            AND SYSDATE BETWEEN b.fec_desde AND b.fec_hasta
      AND ROWNUM <= 1;

      END IF;

      RETURN TRUE;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            SN_CodRetorno := '200043';
            LV_des_error  := 'OTHERS: er_integracion_impuesto_pg.ER_ObtenerCategImpositiva_FN;- ' || SQLERRM;
            SV_MenRetorno := 'No existe categoria impositiva';
            SN_NumEvento  := Ge_Errores_Pg.Grabarpl( SN_NumEvento, CV_MODULO_GA,SV_MenRetorno, '1.0', USER, 'er_integracion_impuesto_pg.ObtenerCategImpositiva_fn',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
         WHEN OTHERS THEN
            SN_CodRetorno := '200044';
            LV_des_error  := 'OTHERS: er_integracion_impuesto_pg.ER_ObtenerCategImpositiva_FN;- ' || SQLERRM;
            SV_MenRetorno := 'No pudo obtener categoria impositiva';
            SN_NumEvento  := Ge_Errores_Pg.Grabarpl( SN_NumEvento, CV_MODULO_GA,SV_MenRetorno, '1.0', USER, 'er_integracion_impuesto_pg.ObtenerCategImpositiva_fn',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END ve_ObtenerCategImpositiva_FN;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ve_ObtenerImpuestoPresuTemp_FN(
      sn_codcatimpos        IN             ge_impuestos.COD_CATIMPOS%TYPE,
      sn_cod_grpservi       IN             ge_impuestos.COD_GRPSERVI%TYPE,                                                                                                                                            /* global */
      sn_cod_zonaimpo       IN             ge_impuestos.COD_ZONAIMPO%TYPE,
      sn_PrcImpuesto        OUT NOCOPY     NUMBER,
      sn_codretorno         OUT NOCOPY     ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY     ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY     ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
      LV_des_error ge_errores_pg.desevent;
      LV_sql       ge_errores_pg.vquery;
   BEGIN
      SN_CodRetorno := 0;
      SV_MenRetorno := NULL;
      SN_NumEvento  := 0;

      SN_PrcImpuesto := 0;

      LV_sql := 'SELECT sum(i.prc_impuesto)'
             || ' FROM ge_impuestos i, ge_tipimpues t'
             || ' WHERE i.cod_catimpos = '||sn_codcatimpos
             || ' AND i.cod_grpservi = '||sn_cod_grpservi                                                                                                                                              /* global */
             || ' AND SYSDATE BETWEEN fec_desde AND fec_hasta'
             || ' AND i.cod_zonaimpo = '||sn_cod_zonaimpo
             || ' AND i.cod_zonaabon = '||sn_cod_zonaimpo;


      SELECT (SUM (prc_impuesto)/100)+1
        INTO SN_PrcImpuesto
        FROM (SELECT DISTINCT i.cod_concgene, i.prc_impuesto
                FROM ge_impuestos i, ge_tipimpues t
               WHERE i.cod_catimpos = sn_codcatimpos
                 AND i.cod_grpservi = sn_cod_grpservi                                                                                                                                    /* global */
                 AND SYSDATE BETWEEN fec_desde AND fec_hasta
                 AND i.cod_zonaimpo = decode(I.COD_ZONAIMPO,0,0,sn_cod_zonaimpo));

      RETURN TRUE;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            SN_CodRetorno := '200045';
            SV_MenRetorno := 'No existe impuesto de presupuesto temporal';
            LV_des_error  := 'OTHERS: er_integracion_impuesto_pg.ER_ObtenerImpuestoPresuTemp_FN;- ' || SQLERRM;
            SN_NumEvento  := Ge_Errores_Pg.Grabarpl( SN_NumEvento, CV_MODULO_GA,SV_MenRetorno, '1.0', USER, 'er_integracion_impuesto_pg.er_ObtenerImpuestoPresuTemp_fn',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
         WHEN OTHERS THEN
            SN_CodRetorno := '200046';
            SV_MenRetorno := 'No pudo obtener impuesto de presupuesto temporal';
            LV_des_error  := 'OTHERS: er_integracion_impuesto_pg.ER_ObtenerImpuestoPresuTemp_FN;- ' || SQLERRM;
            SN_NumEvento  := Ge_Errores_Pg.Grabarpl( SN_NumEvento, CV_MODULO_GA,SV_MenRetorno, '1.0', USER, 'er_integracion_impuesto_pg.er_ObtenerImpuestoPresuTemp_fn',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END ve_ObtenerImpuestoPresuTemp_FN;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_obtenerimpuesto_clie_pr(
    en_cod_vendedor       IN  ve_vendedores.cod_vendedor%TYPE,
    sn_valor_imp          OUT NOCOPY      NUMBER,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      error_ejecucion     EXCEPTION;

      LV_des_error ge_errores_pg.desevent;
      LV_sql       ge_errores_pg.vquery;


      n_cod_grpservi  fa_grpserconc.cod_grpservi%TYPE;
      n_cod_zonaimpo  ge_zonaciudad.cod_zonaimpo%TYPE;
      n_cod_cliente   ge_clientes.COD_CLIENTE%TYPE := 0;
      n_codcatimpos   NUMBER;
      n_impuesto      NUMBER;
      v_tipident      VARCHAR(1) := '';
      v_numident      VARCHAR(1) := '';
   BEGIN
      SN_CodRetorno := 0;
      SV_MenRetorno := NULL;
      SN_NumEvento  := 0;
      n_impuesto    := 0;

      IF NOT(ve_ObtenerCategImpositiva_FN(v_tipident,v_numident,n_cod_cliente,n_codcatimpos,SN_CodRetorno,SV_MenRetorno,SN_NumEvento)) THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT(ve_rec_zona_impo_FN(en_cod_vendedor,n_cod_zonaimpo,SN_CodRetorno,SV_MenRetorno,SN_NumEvento)) THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (ve_rec_grupo_serv_fn(n_cod_grpservi,SN_CodRetorno,SV_MenRetorno,SN_NumEvento)) THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT(ve_ObtenerImpuestoPresuTemp_FN(n_codcatimpos,n_cod_grpservi,n_cod_zonaimpo,n_impuesto,SN_CodRetorno,SV_MenRetorno,SN_NumEvento)) THEN
         RAISE error_ejecucion;
      END IF;

      sn_valor_imp := n_impuesto;

      EXCEPTION
         WHEN error_ejecucion THEN
            SN_CodRetorno := '200047';
            SV_MenRetorno := 'Error al obtener impuestos';
            LV_des_error  := 'OTHERS: er_integracion_impuesto_pg.er_obtenerimpuesto_clie_fn('||en_cod_vendedor||');- ' || SQLERRM;
            SN_NumEvento  := Ge_Errores_Pg.Grabarpl( SN_NumEvento, CV_MODULO_GA,SV_MenRetorno, '1.0', USER, 'er_integracion_impuesto_pg.er_obtenerimpuesto_clie_fn',LV_Sql, SQLCODE, LV_des_error);
         WHEN OTHERS THEN
            SN_CodRetorno := '200047';
            LV_des_error  := 'OTHERS: er_integracion_impuesto_pg.er_obtenerimpuesto_clie_fn('||en_cod_vendedor||');- ' || SQLERRM;
            SV_MenRetorno := 'Error al obtener impuestos';
            SN_NumEvento  := Ge_Errores_Pg.Grabarpl( SN_NumEvento, CV_MODULO_GA,SV_MenRetorno, '1.0', USER, 'er_integracion_impuesto_pg.er_obtenerimpuesto_clie_fn',LV_Sql, SQLCODE, LV_des_error);

   END ve_obtenerimpuesto_clie_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_obtenerimpuesto_clie_fn(
    en_cod_vendedor IN  ve_vendedores.cod_vendedor%TYPE
   ) RETURN NUMBER
   IS
      error_ejecucion     EXCEPTION;

      LV_des_error ge_errores_pg.desevent;
      LV_sql       ge_errores_pg.vquery;

      SN_CodRetorno  ge_errores_pg.coderror;
      SV_MenRetorno  ge_errores_pg.msgerror;
      SN_NumEvento   ge_errores_pg.evento;

      n_cod_grpservi  fa_grpserconc.cod_grpservi%TYPE;
      n_cod_zonaimpo  ge_zonaciudad.cod_zonaimpo%TYPE;
      n_cod_cliente   ge_clientes.COD_CLIENTE%TYPE := 0;
      n_codcatimpos   NUMBER;
      n_impuesto      NUMBER;
      v_tipident      VARCHAR(1) := '';
      v_numident      VARCHAR(1) := '';
   BEGIN
      SN_CodRetorno := 0;
      SV_MenRetorno := NULL;
      SN_NumEvento  := 0;
      n_impuesto    := 0;

      IF NOT(ve_ObtenerCategImpositiva_FN(v_tipident,v_numident,n_cod_cliente,n_codcatimpos,SN_CodRetorno,SV_MenRetorno,SN_NumEvento)) THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT(ve_rec_zona_impo_FN(en_cod_vendedor,n_cod_zonaimpo,SN_CodRetorno,SV_MenRetorno,SN_NumEvento)) THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (ve_rec_grupo_serv_fn(n_cod_grpservi,SN_CodRetorno,SV_MenRetorno,SN_NumEvento)) THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT(ve_ObtenerImpuestoPresuTemp_FN(n_codcatimpos,n_cod_grpservi,n_cod_zonaimpo,n_impuesto,SN_CodRetorno,SV_MenRetorno,SN_NumEvento)) THEN
         RAISE error_ejecucion;
      END IF;

      RETURN n_impuesto;

      EXCEPTION
         WHEN error_ejecucion THEN
            SN_CodRetorno := '200047';
            SV_MenRetorno := 'Error al obtener impuestos';

            LV_des_error  := 'OTHERS: er_integracion_impuesto_pg.er_obtenerimpuesto_clie_fn('||en_cod_vendedor||');- ' || SQLERRM;
            SN_NumEvento  := Ge_Errores_Pg.Grabarpl( SN_NumEvento, CV_MODULO_GA,SV_MenRetorno, '1.0', USER, 'er_integracion_impuesto_pg.er_obtenerimpuesto_clie_fn',LV_Sql, SQLCODE, LV_des_error);
            RAISE_APPLICATION_ERROR(-20001,'Ver EVENTO ['||SN_NumEvento||']');
         WHEN OTHERS THEN
            SN_CodRetorno := '200047';
            LV_des_error  := 'OTHERS: er_integracion_impuesto_pg.er_obtenerimpuesto_clie_fn('||en_cod_vendedor||');- ' || SQLERRM;
            SV_MenRetorno := 'Error al obtener impuestos';
            SN_NumEvento  := Ge_Errores_Pg.Grabarpl( SN_NumEvento, CV_MODULO_GA,SV_MenRetorno, '1.0', USER, 'er_integracion_impuesto_pg.er_obtenerimpuesto_clie_fn',LV_Sql, SQLCODE, LV_des_error);
            RAISE_APPLICATION_ERROR(-20001,'Ver EVENTO ['||SN_NumEvento||']');

   END ve_obtenerimpuesto_clie_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END ve_portabilidad_impuesto_pg;
/

SHOW ERRORS