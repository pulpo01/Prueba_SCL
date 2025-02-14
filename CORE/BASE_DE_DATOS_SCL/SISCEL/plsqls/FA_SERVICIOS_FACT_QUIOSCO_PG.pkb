CREATE OR REPLACE PACKAGE BODY fa_servicios_fact_quiosco_pg IS
   PROCEDURE fa_con_presupuesto_pr (
      en_num_proceso    IN              fa_presupuesto.num_proceso%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      no_data_found_cursor   EXCEPTION;
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
   /*--
   <Documentacion TipoDoc = "Procedimiento">
      Elemento Nombre = "FA_con_presupuesto_PR"
      Lenguaje="PL/SQL"
      Fecha="05/06/2007"
      Version="1.0.0"
      Dise?ador="Hector Hermosilla"
      Programador="Hector Hermosilla
      Ambiente="BD"
   <Retorno>NA</Retorno>
   <Descripcion>
      Obtiene el detalle del presupuesto
   </Descripcion>
   <Parametros>
   <Entrada>
      <param nom="EN_num_proceso"    Tipo="NUMBER> número proceso de ejecución</param>
   </Entrada>
   <Salida>
       <param nom="SC_cursordatos"    Tipo="CURSOR"> detalle presupuesto </param>
      <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
      <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
      <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
   </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
   --*/
   BEGIN
      sn_num_evento   := 0;
      sn_cod_retorno  := 0;
      sv_mens_retorno := '';

      lv_ssql :=
         'SELECT A.COD_CONCEPTO,' || ' F_CARGO_PRESUPUESTO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_BASE,' || ' F_IMPUESTOS_CARGO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_IMPUESTO,'
         || ' F_DCTO_IMPUESTOS(A.NUM_PROCESO,A.COLUMNA, A.COD_CONCEPTO) IMP_DTO,'
         || ' F_CARGO_PRESUPUESTO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) + F_DCTO_IMPUESTOS(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) + F_IMPUESTOS_CARGO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_TOTAL' || ' FROM' || ' FA_PRESUPUESTO A,'
         || ' FA_CONCEPTOS X' || ' WHERE' || ' A.COD_TIPCONCE = 3 AND' || ' A.IND_FACTUR = 1 AND' || ' X.COD_CONCEPTO = A.COD_CONCEPTO AND' || ' A.IND_CUOTA = 0 AND' || ' X.COD_TIPCONCE = A.COD_TIPCONCE AND' || ' A.NUM_PROCESO =' || en_num_proceso
         || ' UNION ALL' || ' SELECT a.COD_CONCEPTO,' || ' a.MTO_GARANTIA IMP_BASE,0 IMP_IMPUESTO,0 IMP_DTO,a.MTO_GARANTIA IMP_TOTAL' || ' FROM   GA_PRESUPUESTO_RECAUDACION a, GE_TIPDOCUMEN b, GED_PARAMETROS c'
         || ' WHERE a.COD_CONCEPTO = b.COD_TIPDOCUM AND' || ' c.NOM_PARAMETRO = ''' || 'COD_GARANTIA' || ''' AND' || ' a.COD_CONCEPTO = TO_NUMBER(c.VAL_PARAMETRO) AND' || ' c.COD_MODULO = ''' || 'RE' || '''  AND' || ' a.NUM_PROCESO = ' || en_num_proceso;

      OPEN sc_cursordatos FOR
         SELECT a.cod_concepto, f_cargo_presupuesto (a.num_proceso, a.columna, a.cod_concepto) imp_base, f_impuestos_cargo (a.num_proceso, a.columna, a.cod_concepto) imp_impuesto, f_dcto_impuestos (a.num_proceso, a.columna, a.cod_concepto) imp_dto,
                f_cargo_presupuesto (a.num_proceso, a.columna, a.cod_concepto) + f_dcto_impuestos (a.num_proceso, a.columna, a.cod_concepto) + f_impuestos_cargo (a.num_proceso, a.columna, a.cod_concepto) imp_total
           FROM fa_presupuesto a, fa_conceptos x
          WHERE a.cod_tipconce = 3 AND a.ind_factur = 1 AND x.cod_concepto = a.cod_concepto AND a.ind_cuota = 0 AND x.cod_tipconce = a.cod_tipconce AND a.num_proceso = en_num_proceso
          UNION ALL
         SELECT a.cod_concepto, a.mto_garantia imp_base, 0 imp_impuesto, 0 imp_dto, a.mto_garantia imp_total
           FROM ga_presupuesto_recaudacion a, ge_tipdocumen b, ged_parametros c
          WHERE a.cod_concepto = b.cod_tipdocum AND c.nom_parametro = 'COD_GARANTIA' AND a.cod_concepto = TO_NUMBER (c.val_parametro) AND c.cod_modulo = 'RE' AND a.num_proceso = en_num_proceso;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno := 10030;
         sv_mens_retorno := 'Problemas al consultar Presupuesto';

         lv_des_error    := SUBSTR ('no_data_found_cursor:FA_con_presupuesto_PR.VE_obtiene_abonados_venta_PR(' || en_num_proceso || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_fa, sv_mens_retorno, '1.0', USER, 'FA_con_presupuesto_PR.FA_con_presupuesto_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno := 10030;
         sv_mens_retorno := 'Problemas al consultar Presupuesto';

         lv_des_error := SUBSTR ('OTHERS:FA_con_presupuesto_PR.FA_con_presupuesto_PR(' || en_num_proceso || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_fa, sv_mens_retorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_con_presupuesto_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END fa_con_presupuesto_pr;

   PROCEDURE fa_det_concepto_presup_pr (
      en_num_proceso         IN              fa_presupuesto.num_proceso%TYPE,
      en_cod_concepto        IN              fa_presupuesto.cod_concepto%TYPE,
      sc_cursordatos         OUT NOCOPY      refcursor,
      sn_cod_retorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno        OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento          OUT NOCOPY      ge_errores_pg.evento) IS
      no_data_found_cursor   EXCEPTION;
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
   /*--
   <Documentacion TipoDoc = "Procedimiento">
      Elemento Nombre = "FA_det_cargo_presup_PR"
      Lenguaje="PL/SQL"
      Fecha="05/06/2007"
      Version="1.0.0"
      Dise?ador="Hector Hermosilla"
      Programador="Hector Hermosilla
      Ambiente="BD"
   <Retorno>NA</Retorno>
   <Descripcion>
      Obtiene presupuesto especifico asociado a un concepto facturable
   </Descripcion>
   <Parametros>
   <Entrada>
      <param nom="EN_num_proceso"    Tipo="NUMBER> número proceso de ejecución</param>

   </Entrada>
   <Salida>
      <param nom="SC_cursordatos"    Tipo="CURSOR"> detalle presupuesto </param>
      <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
      <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
      <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
   </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
   --*/
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';

      lv_ssql :=
         'SELECT' || ' F_CARGO_PRESUPUESTO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_BASE,' || ' F_IMPUESTOS_CARGO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_IMPUESTO,' || ' F_DCTO_IMPUESTOS(A.NUM_PROCESO,A.COLUMNA, A.COD_CONCEPTO) IMP_DTO,'
         || ' F_CARGO_PRESUPUESTO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) + F_DCTO_IMPUESTOS(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) + F_IMPUESTOS_CARGO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_TOTAL' || ' FROM' || ' FA_PRESUPUESTO A,'
         || ' FA_CONCEPTOS X' || ' WHERE' || ' A.COD_TIPCONCE = 3 AND' || ' A.IND_FACTUR = 1 AND' || ' X.COD_CONCEPTO = A.COD_CONCEPTO AND' || ' A.IND_CUOTA = 0 AND' || ' X.COD_TIPCONCE = A.COD_TIPCONCE AND' || ' A.NUM_PROCESO =' || en_num_proceso
         || ' A.COD_CONCEPTO =' || en_cod_concepto || ' UNION ALL' || ' SELECT' || ' a.MTO_GARANTIA IMP_BASE,0 IMP_IMPUESTO,0 IMP_DTO,a.MTO_GARANTIA IMP_TOTAL' || ' FROM   GA_PRESUPUESTO_RECAUDACION a, GE_TIPDOCUMEN b, GED_PARAMETROS c'
         || ' WHERE a.COD_CONCEPTO = b.COD_TIPDOCUM AND' || ' c.NOM_PARAMETRO = ''' || 'COD_GARANTIA' || ''' AND' || ' a.COD_CONCEPTO = TO_NUMBER(c.VAL_PARAMETRO) AND' || ' c.COD_MODULO = ''' || 'RE' || '''  AND' || ' a.NUM_PROCESO = ' || en_num_proceso
         || ' a.COD_CONCEPTO = ' || en_cod_concepto;

      OPEN sc_cursordatos FOR
         SELECT f_cargo_presupuesto (a.num_proceso, a.columna, a.cod_concepto) imp_base, f_impuestos_cargo (a.num_proceso, a.columna, a.cod_concepto) imp_impuesto, f_dcto_impuestos (a.num_proceso, a.columna, a.cod_concepto) imp_dto,
                f_cargo_presupuesto (a.num_proceso, a.columna, a.cod_concepto) + f_dcto_impuestos (a.num_proceso, a.columna, a.cod_concepto) + f_impuestos_cargo (a.num_proceso, a.columna, a.cod_concepto) imp_total
           FROM fa_presupuesto a, fa_conceptos x
          WHERE a.cod_tipconce = 3 AND a.ind_factur = 1 AND x.cod_concepto = a.cod_concepto AND a.ind_cuota = 0 AND x.cod_tipconce = a.cod_tipconce AND a.num_proceso = en_num_proceso AND a.cod_concepto = en_cod_concepto
          UNION ALL
         SELECT a.mto_garantia imp_base, 0 imp_impuesto, 0 imp_dto, a.mto_garantia imp_total
           FROM ga_presupuesto_recaudacion a, ge_tipdocumen b, ged_parametros c
          WHERE a.cod_concepto = b.cod_tipdocum AND c.nom_parametro = 'COD_GARANTIA' AND a.cod_concepto = TO_NUMBER (c.val_parametro) AND c.cod_modulo = 'RE' AND a.num_proceso = en_num_proceso AND a.cod_concepto = en_cod_concepto;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno := 10030;
         sv_mens_retorno := 'Problemas al consultar Presupuesto';


         lv_des_error    := SUBSTR ('no_data_found_cursor:FA_con_presupuesto_PR.VE_obtiene_abonados_venta_PR(' || en_num_proceso || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_fa, sv_mens_retorno, '1.0', USER, 'FA_con_presupuesto_PR.FA_con_presupuesto_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno := 10503;
         sv_mens_retorno := 'Error al obtiene presupuesto especifico asociado a un concepto facturable';

         lv_des_error := SUBSTR ('OTHERS:FA_con_presupuesto_PR.FA_con_presupuesto_PR(' || en_num_proceso || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_fa, sv_mens_retorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_con_presupuesto_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END fa_det_concepto_presup_pr;

   PROCEDURE fa_getcodigodespacho_pr (
      sv_coddespacho   OUT NOCOPY   fa_codespacho.cod_despacho%TYPE,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "FA_getCodigoDespacho_PR"
         Lenguaje="PL/SQL"
         Fecha="23-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Retorna codigo despacho
      </Retorno>
        <Descripción>
              Retorna codigo despacho
        </Descripción>
        <Parámetros>
            <Entrada>
              <param nom="SN_codDespacho" Tipo="STRING"> codigo despacho </param>
            </Entrada>
            <Salida>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
            </Salida>
        </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;

      lv_sql := 'SELECT a.cod_despacho '
             || 'FROM fa_codespacho a '
             || 'WHERE a.ind_ventas = ''1'
             || 'AND ROWNUM < 2';

      SELECT a.cod_despacho
        INTO sv_coddespacho
        FROM fa_codespacho a
       WHERE a.ind_ventas = '1'
         AND ROWNUM < 2;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_codretorno := 10031;
         sv_menretorno :='Problemas al consultar el código despacho';

         lv_deserror := 'NO_DATA_FOUND:fa_servicios_fact_quiosco_pg.FA_getCodigoDespacho_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_getCodigoDespacho_PR', lv_sql, SQLCODE, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 156;
         sv_menretorno :='No es posible ejecutar este servicio.';


         lv_deserror := 'OTHERS:fa_servicios_fact_quiosco_pg.FA_getCodigoDespacho_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_getCodigoDespacho_PR', lv_sql, SQLCODE, lv_deserror);
   END fa_getcodigodespacho_pr;

   PROCEDURE fa_getciclofacturacion_pr (
      ev_cod_ciclo          OUT NOCOPY   VARCHAR2,
      ev_ano                OUT NOCOPY   VARCHAR2,
      ev_cod_ciclfact       OUT NOCOPY   VARCHAR2,
      ev_fec_vencimie       OUT NOCOPY   VARCHAR2,
      ev_fec_emision        OUT NOCOPY   VARCHAR2,
      ev_fec_caducida       OUT NOCOPY   VARCHAR2,
      ev_fec_proxvenc       OUT NOCOPY   VARCHAR2,
      ev_fec_desdellam      OUT NOCOPY   VARCHAR2,
      ev_fec_hastallam      OUT NOCOPY   VARCHAR2,
      ev_dia_periodo        OUT NOCOPY   VARCHAR2,
      ev_fec_desdecfijos    OUT NOCOPY   VARCHAR2,
      ev_fec_hastacfijos    OUT NOCOPY   VARCHAR2,
      ev_fec_desdeocargos   OUT NOCOPY   VARCHAR2,
      ev_fec_hastaocargos   OUT NOCOPY   VARCHAR2,
      ev_fec_desderoa       OUT NOCOPY   VARCHAR2,
      ev_fec_hastaroa       OUT NOCOPY   VARCHAR2,
      ev_ind_facturacion    OUT NOCOPY   VARCHAR2,
      ev_dir_logs           OUT NOCOPY   VARCHAR2,
      ev_dir_spool          OUT NOCOPY   VARCHAR2,
      ev_des_leyen1         OUT NOCOPY   VARCHAR2,
      ev_des_leyen2         OUT NOCOPY   VARCHAR2,
      ev_des_leyen3         OUT NOCOPY   VARCHAR2,
      ev_des_leyen4         OUT NOCOPY   VARCHAR2,
      ev_des_leyen5         OUT NOCOPY   VARCHAR2,
      ev_ind_tasador        OUT NOCOPY   VARCHAR2,
      sn_codretorno         OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "FA_getCicloFacturacion_PR"
         Lenguaje="PL/SQL"
         Fecha="14-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Retorna ciclo facturacion mas proximo
      </Retorno>
      <Descripción>
              Retorna ciclo facturacion mas proximo
      </Descripción>
      <Parámetros>
            <Entrada>
             <param nom="EV_cod_ciclo"        Tipo="STRING"> </param>
            <param nom="EV_ano"              Tipo="STRING"> </param>
            <param nom="EV_cod_ciclfact"     Tipo="STRING"> </param>
            <param nom="EV_fec_vencimie"     Tipo="STRING"> </param>
            <param nom="EV_fec_emision"      Tipo="STRING"> </param>
            <param nom="EV_fec_caducida"     Tipo="STRING"> </param>
            <param nom="EV_fec_proxvenc"     Tipo="STRING"> </param>
            <param nom="EV_fec_desdellam"    Tipo="STRING"> </param>
            <param nom="EV_fec_hastallam"    Tipo="STRING"> </param>
            <param nom="EV_dia_periodo"      Tipo="STRING"> </param>
            <param nom="EV_fec_desdecfijos"  Tipo="STRING"> </param>
            <param nom="EV_fec_hastacfijos"  Tipo="STRING"> </param>
            <param nom="EV_fec_desdeocargos" Tipo="STRING"> </param>
            <param nom="EV_fec_hastaocargos" Tipo="STRING"> </param>
            <param nom="EV_fec_desderoa"     Tipo="STRING"> </param>
            <param nom="EV_fec_hastaroa"     Tipo="STRING"> </param>
            <param nom="EV_ind_facturacion"  Tipo="STRING"> </param>
            <param nom="EV_dir_logs"         Tipo="STRING"> </param>
            <param nom="EV_dir_spool"        Tipo="STRING"> </param>
            <param nom="EV_des_leyen1"        Tipo="STRING"> </param>
            <param nom="EV_des_leyen2"        Tipo="STRING"> </param>
            <param nom="EV_des_leyen3"        Tipo="STRING"> </param>
            <param nom="EV_des_leyen4"        Tipo="STRING"> </param>
            <param nom="EV_des_leyen5"        Tipo="STRING"> </param>
            <param nom="EV_ind_tasador"       Tipo="STRING"> </param>
          </Entrada>
          <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;

      lv_sql := 'SELECT cod_ciclo, ano, cod_ciclfact, fec_vencimie, fec_emision,fec_caducida, fec_proxvenc,';
      lv_sql := lv_sql || ' fec_desdellam, fec_hastallam, dia_periodo, fec_desdecfijos, fec_hastacfijos,';
      lv_sql := lv_sql || ' fec_desdeocargos, fec_hastaocargos, fec_desderoa, fec_hastaroa, ind_facturacion,';
      lv_sql := lv_sql || ' dir_logs, dir_spool,des_leyen1, des_leyen2, des_leyen3,des_leyen4,des_leyen5, ind_tasador';
      lv_sql := lv_sql || ' FROM fa_ciclfact a';
      lv_sql := lv_sql || ' WHERE a.fec_desdellam = (SELECT min(b.fec_desdellam)';
      lv_sql := lv_sql || '                          FROM fa_ciclfact b ';
      lv_sql := lv_sql || '                          WHERE COD_CICLO in (SELECT VAL_PARAMETRO';
      lv_sql := lv_sql || '						 FROM GED_PARAMETROS WHERE COD_PRODUCTO = 1';
      lv_sql := lv_sql || '						 AND COD_MODULO = GA';
      lv_sql := lv_sql || '                                              AND NOM_PARAMETRO = CICLFA_DEFECTO_COMBO)';
      lv_sql := lv_sql || '			     AND b.fec_desdellam >= sysdate';
      lv_sql := lv_sql || '                          b.cod_ciclo NOT IN (SELECT ged.cod_valor';
      lv_sql := lv_sql || ' 						                            FROM ged_codigos ged';
      lv_sql := lv_sql || '                          							WHERE ged.cod_modulo ='''  || cv_modulo_ga     || '''';
      lv_sql := lv_sql || '                           						    AND ged.nom_tabla    ='''  || cv_tab_faciclos  || '''';
      lv_sql := lv_sql || '                                                     AND ged.nom_columna  = ''' || cv_col_faciclos  || '''';

      SELECT cod_ciclo, ano, cod_ciclfact, fec_vencimie, fec_emision, fec_caducida, fec_proxvenc, fec_desdellam, fec_hastallam, dia_periodo, fec_desdecfijos, fec_hastacfijos, fec_desdeocargos, fec_hastaocargos,
             fec_desderoa, fec_hastaroa, ind_facturacion, dir_logs, dir_spool, des_leyen1, des_leyen2, des_leyen3, des_leyen4, des_leyen5, ind_tasador
        INTO ev_cod_ciclo, ev_ano, ev_cod_ciclfact, ev_fec_vencimie, ev_fec_emision, ev_fec_caducida, ev_fec_proxvenc, ev_fec_desdellam, ev_fec_hastallam, ev_dia_periodo, ev_fec_desdecfijos, ev_fec_hastacfijos, ev_fec_desdeocargos, ev_fec_hastaocargos,
             ev_fec_desderoa, ev_fec_hastaroa, ev_ind_facturacion, ev_dir_logs, ev_dir_spool, ev_des_leyen1, ev_des_leyen2, ev_des_leyen3, ev_des_leyen4, ev_des_leyen5, ev_ind_tasador
        FROM fa_ciclfact a
       WHERE a.fec_desdellam =
            (SELECT MIN (b.fec_desdellam)
                  FROM fa_ciclfact b
                 WHERE  cod_ciclo IN (SELECT val_parametro
                                        FROM ged_parametros
                                       WHERE cod_producto = 1 AND cod_modulo = 'GA'
                                         AND nom_parametro = 'CICLFA_DEFECTO_COMBO') AND b.fec_desdellam >= SYSDATE
                                         AND b.cod_ciclo NOT IN (SELECT ged.cod_valor
                                                                   FROM ged_codigos ged
                                                                  WHERE ged.cod_modulo  = cv_modulo_ga
                                                                    AND ged.nom_tabla   = cv_tab_faciclos
                                                                    AND ged.nom_columna = cv_col_faciclos));
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_codretorno := 10032;
         sv_menretorno := 'Problemas al recuperar datos de la Factura';


         lv_deserror := 'NO_DATA_FOUND:fa_servicios_fact_quiosco_pg.FA_getCicloFacturacion_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_getCicloFacturacion_PR', lv_sql, SQLCODE, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10504;
         sv_menretorno := 'Error al retornar ciclo facturacion mas proximo';

         lv_deserror := 'OTHERS:fa_servicios_fact_quiosco_pg.FA_getCicloFacturacion_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_getCicloFacturacion_PR', lv_sql, SQLCODE, lv_deserror);
   END fa_getciclofacturacion_pr;

   PROCEDURE fa_getlistciclospostpago_pr (
      en_cicloprepago   IN              fa_ciclos.cod_ciclo%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "FA_getListCiclosPostPago_PR"
         Lenguaje="PL/SQL"
         Fecha="22-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna lista de ciclos, excepto ciclo prepago
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_CicloPrepago" Tipo="NUMBER"> codigo ciclo prepago </param>
          </Entrada>
            <Salida>
            <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor ciclos </param>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
            <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
            <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

      lv_sql :='SELECT a.cod_ciclo,a.des_ciclo '
            || ' FROM fa_ciclos a '
            || ' WHERE a.cod_ciclo <> ' || en_cicloprepago
            || ' AND a.cod_ciclo NOT IN (' || 'SELECT b.cod_valor ' || 'FROM ged_codigos b  '
            || ' WHERE b.cod_modulo = ' || cv_modulo_ga
            || ' AND b.nom_tabla    = ' || cv_tab_faciclos
            || ' AND b.nom_columna  = ' || cv_col_faciclos || ')';

      SELECT COUNT (1)
        INTO ln_contador
        FROM fa_ciclos a
       WHERE a.cod_ciclo <> en_cicloprepago
         AND a.cod_ciclo NOT IN (SELECT b.cod_valor FROM ged_codigos b
                                  WHERE b.cod_modulo = cv_modulo_ga
                                    AND b.nom_tabla = cv_tab_faciclos
                                    AND b.nom_columna = cv_col_faciclos);

      OPEN sc_cursordatos FOR
         SELECT a.cod_ciclo, a.des_ciclo
           FROM fa_ciclos a
          WHERE a.cod_ciclo <> en_cicloprepago AND a.cod_ciclo NOT IN (SELECT b.cod_valor
                                                                         FROM ged_codigos b
                                                                        WHERE b.cod_modulo = cv_modulo_ga
                                                                          AND b.nom_tabla = cv_tab_faciclos
                                                                          AND b.nom_columna = cv_col_faciclos);

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10033;
         sv_menretorno :='Problemas al recuperar datos de la tabla a_ciclos';


         lv_deserror := SUBSTR ('NO_DATA_FOUND_CURSOR:fa_servicios_fact_quiosco_pg.FA_getListCiclosPostPago_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_getListCiclosPostPago_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10505;
         sv_menretorno :='Error al retornar lista de ciclos';

         lv_deserror := 'OTHERS:fa_servicios_fact_quiosco_pg.FA_getListCiclosPostPago_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_getListCiclosPostPago_PR', lv_sql, SQLCODE, lv_deserror);
   END fa_getlistciclospostpago_pr;

   PROCEDURE fa_getdiasprorrateo_pr (
      ev_codciclo        IN              VARCHAR2,
      ev_formatofecha    IN              VARCHAR2,
      sv_diasprorrateo   OUT NOCOPY      VARCHAR2,
      sv_cantdias        OUT NOCOPY      VARCHAR2,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "FA_getDiasProrrateo_PR"
         Lenguaje="PL/SQL"
         Fecha="11-09-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Retorna numero de dias prorrateo para el abonado
      </Retorno>
      <Descripción>
              Retorna numero de dias prorrateo para el abonado
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EV_codCiclo"     Tipo="STRING"> codigo ciclo </param>
            <param nom="EV_formatoFecha" Tipo="STRING"> formato fecha </param>
          </Entrada>
            <Salida>
              <param nom="SV_diasProrrateo" Tipo="STRING"> numero dias prorrateo </param>
              <param nom="SV_cantDias"      Tipo="STRING"> cantidad de dias</param>
              <param nom="SN_codRetorno"    Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"    Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"     Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;

   BEGIN
      sn_codretorno    := 0;
      sv_menretorno    := NULL;
      sn_numevento     := 0;
      sv_diasprorrateo := NULL;
      sv_cantdias      := NULL;

      lv_sql := ' SELECT a.dia_periodo,'
             || ' (TO_DATE(TO_CHAR(a.fec_hastallam,'''|| ev_formatofecha || '''),'''|| ev_formatofecha || ''') - TO_DATE(TO_CHAR(SYSDATE,''' || ev_formatofecha || '''),'''|| ev_formatofecha || ''')) + 1' || ' FROM fa_ciclfact a' || ' WHERE a.cod_ciclo =' || ev_codciclo
             || ' AND SYSDATE BETWEEN a.fec_desdellam AND a.fec_hastallam';

      SELECT a.dia_periodo, (TO_DATE (TO_CHAR (a.fec_hastallam, ev_formatofecha),ev_formatofecha) - TO_DATE (TO_CHAR (SYSDATE, ev_formatofecha),ev_formatofecha)) + 1
        INTO sv_diasprorrateo, sv_cantdias
        FROM fa_ciclfact a
       WHERE a.cod_ciclo = ev_codciclo AND SYSDATE BETWEEN a.fec_desdellam AND a.fec_hastallam;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_codretorno := 10035;
          sv_menretorno :='Problemas al recuperar datos de la llamada';

         lv_deserror := 'NO_DATA_FOUND:fa_servicios_fact_quiosco_pg.FA_getDiasProrrateo_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_getDiasProrrateo_PR', lv_sql, SQLCODE, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10506;
         sv_menretorno :='Error al retornar numero de dias prorrateo para el abonado';


         lv_deserror := 'OTHERS:fa_servicios_fact_quiosco_pg.FA_getDiasProrrateo_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_getDiasProrrateo_PR', lv_sql, SQLCODE, lv_deserror);
   END fa_getdiasprorrateo_pr;

   PROCEDURE fa_getimpuesto_pr (
      ev_codcliente   IN              VARCHAR2,
      ev_codoficina   IN              VARCHAR2,
      en_importe      IN              NUMBER,
      sn_imptotal     OUT NOCOPY      NUMBER,
      sn_codretorno   OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "FA_getImpuesto_PR"
         Lenguaje="PL/SQL"
         Fecha="28-08-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Importe cargo basifo afecto impuesto
      </Retorno>
      <Descripción>
              Obtiene Impuesto
      </Descripción>
      <Parámetros>
            <Entrada>
              <param nom="EV_codCliente"   Tipo="STRING"> codigo del cliente </param>
              <param nom="EV_codOficina"   Tipo="STRING"> codigo oficina </param>
              <param nom="EN_importe"      Tipo="NUMBER"> importe </param>
            </Entrada>
            <Salida>
              <param nom="SN_impuesto"     Tipo="NUMBER"> impuesto </param>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror      ge_errores_pg.desevent;
      lv_sql           ge_errores_pg.vquery;
      ln_codabonocel   NUMBER;
      ln_codcatimpos   NUMBER;
      ln_codtipconce   NUMBER;
      ln_numproceso    NUMBER;
      ln_impuesto      NUMBER;
      ln_descuento     NUMBER;
      ln_contador      NUMBER;
      lv_proc          VARCHAR2 (50);
      lv_tabla         VARCHAR2 (50);
      lv_act           VARCHAR2 (50);
      lv_sqlcode       VARCHAR2 (50);
      lv_sqlerrm       VARCHAR2 (50);
      lv_error         VARCHAR2 (50);

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      sn_imptotal   := 0;
      ln_impuesto   := 0;
      ln_descuento  := 0;

      -- Numero de Proceso
      lv_sql := 'SELECT fas_presuptemp.NEXTVAL' || ' FROM DUAL';

      SELECT fas_presuptemp.NEXTVAL
        INTO ln_numproceso
        FROM DUAL;

      -- Categoria impositiva del cliente
      lv_sql := 'SELECT cod_catimpos'
             || ' FROM ge_catimpclientes'
             || ' WHERE cod_cliente = ' || ev_codcliente
             || ' AND SYSDATE BETWEEN fec_desde AND fec_hasta';

      SELECT cod_catimpos
        INTO ln_codcatimpos
        FROM ge_catimpclientes
       WHERE cod_cliente = ev_codcliente
         AND SYSDATE BETWEEN fec_desde AND fec_hasta;

      -- Codigo de concepto para el cargo basico
      lv_sql := 'SELECT a.cod_abonocel' || ' FROM fa_datosgener a';

      SELECT a.cod_abonocel
        INTO ln_codabonocel
        FROM fa_datosgener a;

      -- Tipo de concepto
      lv_sql := 'SELECT a.cod_tipconce' || ' FROM fa_conceptos a' || ' WHERE a.cod_concepto = ' || ln_codabonocel;

      SELECT a.cod_tipconce
        INTO ln_codtipconce
        FROM fa_conceptos a
       WHERE a.cod_concepto = ln_codabonocel;

      lv_sql := 'INSERT INTO fat_presuptemp'
             || '(num_proceso,' || ' cod_concepto,' || ' columna,' || ' cod_cliente,' || ' fec_efectividad,' || ' imp_concepto,' || ' imp_facturable,' || ' cod_tipconce)' || ' VALUES (' || ln_numproceso || ',' || ln_codabonocel
             || ',1,' || ev_codcliente || ',' || SYSDATE || ',' || en_importe || ',' || en_importe || ',' || ln_codtipconce || ')';

      INSERT INTO fat_presuptemp
                  (num_proceso, cod_concepto, columna, cod_cliente, fec_efectividad, imp_concepto, imp_facturable, cod_tipconce)
      VALUES      (ln_numproceso, ln_codabonocel, 1, ev_codcliente, SYSDATE, en_importe, en_importe, ln_codtipconce);

      lv_sql := 'fa_proc_imptos(' || ln_numproceso || ',' || ln_codcatimpos || ',' || ev_codoficina || ',' || lv_proc || ',' || lv_tabla || ',' || lv_act || ',' || lv_sqlcode || ',' || lv_sqlerrm || ',' || lv_error || ')';
      fa_proc_imptos (ln_numproceso, ln_codcatimpos, ev_codoficina, lv_proc, lv_tabla, lv_act, lv_sqlcode, lv_sqlerrm, lv_error);

      ln_contador := 0;

      lv_sql :=' SELECT COUNT (1)'
           || ' INTO ln_contador'
           || ' FROM fat_presuptemp a'
           || ' WHERE a.num_proceso ='|| ln_numproceso
           || ' AND a.cod_tipconce = 1';

      SELECT COUNT (1)
        INTO ln_contador
        FROM fat_presuptemp a
       WHERE a.num_proceso = ln_numproceso
         AND a.cod_tipconce = 1;

      lv_sql := 'SELECT SUM(a.imp_facturable)'
             || ' FROM fat_presuptemp a'
             || ' WHERE a.num_proceso = ' || ln_numproceso
             || ' AND a.cod_tipconce  = 1'
             || ' GROUP BY a.cod_concerel';

      IF (ln_contador > 0) THEN

           SELECT SUM (a.imp_facturable)
             INTO ln_impuesto
             FROM fat_presuptemp a
            WHERE a.num_proceso  = ln_numproceso
              AND a.cod_tipconce = 1
         GROUP BY a.cod_concerel;

      END IF;

      ln_contador := 0;

      lv_sql := 'SELECT COUNT (1)'
             || 'FROM fat_presuptemp a'
             || 'WHERE a.num_proceso = '|| ln_numproceso
             || 'AND a.cod_tipconce = 2 '
             || 'AND a.cod_concerel IN (SELECT b.cod_concepto FROM fat_presuptemp b'
                                     || 'WHERE b.num_proceso =' || ln_numproceso
                                     || 'AND b.cod_tipconce = 1)';

      SELECT COUNT (1)
        INTO ln_contador
        FROM fat_presuptemp a
       WHERE a.num_proceso = ln_numproceso
         AND a.cod_tipconce = 2
         AND a.cod_concerel IN (SELECT b.cod_concepto  FROM fat_presuptemp b
                                                      WHERE b.num_proceso  = ln_numproceso
                                                        AND b.cod_tipconce = 1);
      lv_sql := 'SELECT SUM(a.imp_facturable)'
             || ' FROM  fat_presuptemp a'
             || ' WHERE a.num_proceso = ' || ln_numproceso
             || ' AND   a.cod_tipconce = 2'
             || ' AND   a.cod_concerel IN' || ' (SELECT b.cod_concepto FROM fat_presuptemp b'
                                           || ' WHERE b.num_proceso  = '|| ln_numproceso
                                           || ' AND   b.cod_tipconce = 1)' || ' GROUP BY a.cod_concerel';

      IF (ln_contador > 0) THEN

           SELECT SUM (a.imp_facturable)
             INTO ln_descuento
             FROM fat_presuptemp a
            WHERE a.num_proceso = ln_numproceso
             AND  a.cod_tipconce = 2
             AND  a.cod_concerel IN (SELECT b.cod_concepto  FROM fat_presuptemp b
                                                          WHERE b.num_proceso  = ln_numproceso
                                                            AND b.cod_tipconce = 1) GROUP BY a.cod_concerel;
      END IF;
      sn_imptotal := en_importe + ln_impuesto + ln_descuento;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_codretorno := 1;
         sv_menretorno :='No se pudo recuperar datos.';

         lv_deserror := 'NO_DATA_FOUND:fa_servicios_fact_quiosco_pg.FA_getImpuesto_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_getImpuesto_PR', lv_sql, SQLCODE, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 156;
         sv_menretorno := 'No es posible ejecutar este servicio.';

         lv_deserror := 'OTHERS:fa_servicios_fact_quiosco_pg.FA_getImpuesto_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_getImpuesto_PR', lv_sql, SQLCODE, lv_deserror);
   END fa_getimpuesto_pr;

  PROCEDURE fa_inserta_mensaje_pr (
      en_corrmensaje     IN              fa_mensajes.corr_mensaje%TYPE,
      ev_numlinea        IN              fa_mensajes.num_linea%TYPE,
      ev_descmensaje     IN              fa_mensajes.desc_mensaje%TYPE,
      ev_descmenslin     IN              fa_mensajes.desc_menslin%TYPE,
      ev_codidioma       IN              fa_mensajes.cod_idioma%TYPE,
      en_cantlineasmen   IN              fa_mensajes.cant_lineasmen%TYPE,
      en_cantcaractlin   IN              fa_mensajes.cant_caractlin%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "FA_inserta_mensaje_PR"
         Lenguaje="PL/SQL"
         Fecha="28-07-2008"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Inserta mensajes
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_corrMensaje"    Tipo="NUMBER> correlativo mensaje </param>
         <param nom="SV_numLinea"       Tipo="STRING"> numero de lineas </param>
         <param nom="SV_descMensaje"    Tipo="STRING"> descripcion mensaje </param>
         <param nom="SV_descMenslin"    Tipo="STRING"> descripcion mensaje linea </param>
         <param nom="SV_codIdioma"      Tipo="STRING"> codigo idioma </param>
         <param nom="EN_cantLineasmen"  Tipo="NUMBER> cantidad lineas mensaje </param>
         <param nom="EN_cantCaractlin"  Tipo="NUMBER> cantidad caracteres linea </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;

   BEGIN
      sn_num_evento   := 0;
      sn_cod_retorno  := 0;
      sv_mens_retorno := '';

      lv_ssql :='INSERT INTO fa_mensajes (' || ' corr_mensaje,' || ' num_linea,' || ' desc_mensaje,' || ' desc_menslin,' || ' cod_idioma,' || ' cant_lineasmen,' || ' cant_caractlin)' || 'VALUES (' || en_corrmensaje || ',' || ev_numlinea || ',' || ev_descmensaje
              || ',' || ev_descmenslin || ',' || ev_codidioma || ',' || en_cantlineasmen || ',' || en_cantcaractlin || ')';

      INSERT INTO fa_mensajes
                  (corr_mensaje, num_linea, desc_mensaje, desc_menslin, cod_idioma, cant_lineasmen, cant_caractlin)
      VALUES      (en_corrmensaje, ev_numlinea, ev_descmensaje, ev_descmenslin, ev_codidioma, en_cantlineasmen, en_cantcaractlin);

  EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno   := 10037;
         sv_mens_retorno :='Problemas al ingresar datos en la tabla fa_mensajes';


         lv_des_error    := SUBSTR ('OTHERS:fa_servicios_fact_quiosco_pg.FA_inserta_mensaje_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_fa, sv_mens_retorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_inserta_mensaje_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END fa_inserta_mensaje_pr;

   PROCEDURE fa_inserta_mensaje_proc_pr (
      en_numproceso      IN              fa_mensproceso.num_proceso%TYPE,
      en_codformulario   IN              fa_mensproceso.cod_formulario%TYPE,
      en_codbloque       IN              fa_mensproceso.cod_bloque%TYPE,
      en_corrmensaje     IN              fa_mensproceso.corr_mensaje%TYPE,
      en_numlineas       IN              fa_mensproceso.num_lineas%TYPE,
      ev_codorigen       IN              fa_mensproceso.cod_origen%TYPE,
      ev_descmensaje     IN              fa_mensproceso.desc_mensaje%TYPE,
      ev_indfacturado    IN              fa_mensproceso.ind_facturado%TYPE,
      ev_nomusuario      IN              fa_mensproceso.nom_usuario%TYPE,
      ev_fecingreso      IN              fa_mensproceso.fec_ingreso%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "FA_inserta_mensaje_proc_PR"
         Lenguaje="PL/SQL"
         Fecha="28-07-2008"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Inserta mensajes
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_numProceso"    Tipo="NUMBER> numero de proceso </param>
         <param nom="EN_codFormulario" Tipo="NUMBER> codigo formulario </param>
         <param nom="EN_codBloque"     Tipo="NUMBER> codigo bloque </param>
         <param nom="EN_corrMensaje"   Tipo="NUMBER> correlativo mensaje </param>
         <param nom="EN_numLineas"     Tipo="NUMBER> numero de lineas </param>
         <param nom="EV_codOrigen"     Tipo="STRING"> codigo origen </param>
         <param nom="EV_descMensaje"   Tipo="STRING"> descripcion mensaje </param>
         <param nom="EV_indFacturado"  Tipo="STRING"> indicador facturado </param>
         <param nom="EV_nomUsuario"    Tipo="STRING"> nombre usuario </param>
         <param nom="EV_fecIngreso"    Tipo="STRING"> fecha ingreso </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;

   BEGIN
      sn_num_evento   := 0;
      sn_cod_retorno  := 0;
      sv_mens_retorno := '';

      lv_ssql :=
         'INSERT INTO fa_mensproceso (' || ' num_proceso,' || ' cod_formulario,' || ' cod_bloque,' || ' corr_mensaje,' || ' num_lineas,' || ' cod_origen,' || ' desc_mensaje,' || ' ind_facturado,' || ' nom_usuario,' || ' fec_ingreso)' || ' VALUES ('
         || en_numproceso || ',' || en_codformulario || ',' || en_codbloque || ',' || en_corrmensaje || ',' || en_numlineas || ',' || ev_codorigen || ',' || ev_descmensaje || ',' || ev_indfacturado || ',' || ev_nomusuario || ',' || ev_fecingreso || ')';

      INSERT INTO fa_mensproceso
                  (num_proceso, cod_formulario, cod_bloque, corr_mensaje, num_lineas, cod_origen, desc_mensaje, ind_facturado, nom_usuario, fec_ingreso)
      VALUES      (en_numproceso, en_codformulario, en_codbloque, en_corrmensaje, en_numlineas, ev_codorigen, ev_descmensaje, ev_indfacturado, ev_nomusuario, ev_fecingreso);

   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 10038;
         sv_mens_retorno := 'Problemas al ingresar datos en la tabla fa_mensproceso';

         lv_des_error    := SUBSTR ('OTHERS:fa_servicios_fact_quiosco_pg.FA_inserta_mensaje_proc_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_fa, sv_mens_retorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_inserta_mensaje_proc_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END fa_inserta_mensaje_proc_pr;

   PROCEDURE fa_recibe_mensaje_pr (
      en_numproceso      IN              fa_mensproceso.num_proceso%TYPE,
      ev_descormensaje   IN              fa_mensproceso.desc_mensaje%TYPE,
      ev_mensaje         IN              ci_orserv.comentario%TYPE,
      ev_nomusuario      IN              fa_mensproceso.nom_usuario%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "FA_recibe_mensaje_PR"
         Lenguaje="PL/SQL"
         Fecha="28-07-2008"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Inserta mensajes
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_numProceso"    Tipo="NUMBER"> numero de proceso </param>
         <param nom="EV_desCorMensaje" Tipo="STRING"> descripcion corta mensaje</param>
         <param nom="EV_Mensaje"       Tipo="STRING"> mensaje </param>
         <param nom="EV_nomUsuario"    Tipo="STRING"> usuario </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      error_proceso    EXCEPTION;
      lv_des_error     ge_errores_pg.desevent;
      lv_ssql          ge_errores_pg.vquery;
      lv_corrmensaje   VARCHAR2 (6);
      ln_corrmensaje   fa_mensproceso.corr_mensaje%TYPE;
      lv_string1       VARCHAR2 (3000);
      lv_string2       VARCHAR2 (100);
      lv_string3       VARCHAR2 (100);
      ln_indice1       NUMBER;
      ln_indice2       NUMBER;
      ln_indice3       NUMBER;
      ln_contlineas    NUMBER;
      lv_mensaje       ci_orserv.comentario%TYPE;

   BEGIN
      sn_num_evento   := 0;
      sn_cod_retorno  := 0;
      sv_mens_retorno := '';

      SELECT SUBSTR (REPLACE (ev_mensaje, CHR (13), ''), 1, 500)
        INTO lv_mensaje
        FROM DUAL;

      SELECT SUBSTR (REPLACE (lv_mensaje, CHR (10), ''), 1, 500)
        INTO lv_mensaje
        FROM DUAL;

      SELECT SUBSTR (REPLACE (lv_mensaje, CHR (127), ' '), 1, 500)
        INTO lv_mensaje
        FROM DUAL;

      -- OBTENEMOS CORRELATIVO DEL MENSAJE
      ve_intermediario_quiosco_pg.ve_obtiene_secuencia_pr ('FA_SEQ_MENSAJES', lv_corrmensaje, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF (sn_cod_retorno <> 0) THEN
         -- ERROR AL INSERTAR MENSAJE, SE ABORTA EL PROCESO
         RAISE error_proceso;
      END IF;

      ln_corrmensaje := TO_NUMBER (lv_corrmensaje);
      lv_string1     := lv_mensaje;
      ln_contlineas  := 0;

      LOOP
         IF (LENGTH (lv_string1) > cn_largomaxmenslinea) THEN
            ln_indice1 := 1;
            ln_indice2 := cn_largomaxmenslinea;
            lv_string2 := SUBSTR (lv_string1, ln_indice1, cn_largomaxmenslinea);

            LOOP
               IF (ln_indice2 < ln_indice1) THEN
                  EXIT;
               ELSE
                  IF (SUBSTR (lv_string2, ln_indice2, 1) = ' ') THEN
                     EXIT;
                  END IF;

                  ln_indice2 := ln_indice2 - 1;
               END IF;
            END LOOP;

            IF (ln_indice2 = 0) AND (LENGTH (lv_string2) > 1) THEN

               ln_indice3 := cn_largomaxmenslinea;
            ELSE
               ln_indice3 := ln_indice2;
            END IF;

            lv_string3 := SUBSTR (lv_string2, 1, ln_indice3);

            IF (LENGTH (lv_string3) > 1) THEN

               ln_contlineas := ln_contlineas + 1;
               fa_inserta_mensaje_pr (ln_corrmensaje, ln_contlineas, ev_descormensaje, lv_string3, 1, 0,                                                                                                              -- al final debe actualizarse para todos
                                      cn_largomaxmenslinea, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

               IF (sn_cod_retorno <> 0) THEN
                  RAISE error_proceso;
               END IF;

               ln_indice2 := ln_indice3;
            END IF;

            lv_string1 := SUBSTR (lv_string1, ln_indice2 + 1, LENGTH (lv_string1));
         ELSE
            lv_string3 := lv_string1;

            IF (LENGTH (lv_string3) > 1) THEN
               ln_contlineas := ln_contlineas + 1;
               fa_inserta_mensaje_pr (ln_corrmensaje, ln_contlineas, ev_descormensaje, lv_string3, 1, 0,                                                                                                                         -- al final debe actualizarse
                                      cn_largomaxmenslinea, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

               IF (sn_cod_retorno <> 0) THEN
                  RAISE error_proceso;
               END IF;
            END IF;

            EXIT;
         END IF;
      END LOOP;
      -- INSERTAR MENSAJE PROCESO
      fa_inserta_mensaje_proc_pr (en_numproceso, 1, 3, ln_corrmensaje, ln_contlineas, 'FA', ev_descormensaje, 'I', ev_nomusuario, SYSDATE, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF (sn_cod_retorno <> 0) THEN
         -- ERROR AL INSERTAR MENSAJE PROCESO, SE ABORTA EL PROCESO
         RAISE error_proceso;
      END IF;

      -- ACTUALIZAR NUMERO DE LINEAS DE MENSAJES
      lv_ssql:= ' UPDATE fa_mensajes m'
             || ' SET m.cant_lineasmen =' || ln_contlineas
             || ' WHERE m.corr_mensaje = '|| ln_corrmensaje;

      UPDATE fa_mensajes m
         SET m.cant_lineasmen = ln_contlineas
       WHERE m.corr_mensaje   = ln_corrmensaje;

   EXCEPTION
      WHEN error_proceso THEN
         sn_cod_retorno := 10039;
         sv_mens_retorno :='Error al ingresar mensaje';

         lv_des_error := SUBSTR ('error_proceso:fa_servicios_fact_quiosco_pg.FA_recibe_mensaje_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_fa, sv_mens_retorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_recibe_mensaje_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno := 10000;
         sv_mens_retorno := 'No es posible insertar mensaje';


         lv_des_error := SUBSTR ('OTHERS:fa_servicios_fact_quiosco_pg.FA_recibe_mensaje_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_fa, sv_mens_retorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_recibe_mensaje_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END fa_recibe_mensaje_pr;

   PROCEDURE fa_recibe_mensaje_fs_pr (
      en_numtransaccion   IN   ga_transacabo.num_transaccion%TYPE,
      en_numproceso       IN   fa_mensproceso.num_proceso%TYPE,
      ev_descormensaje    IN   fa_mensproceso.desc_mensaje%TYPE,
      ev_mensaje          IN   ci_orserv.comentario%TYPE,
      ev_nomusuario       IN   fa_mensproceso.nom_usuario%TYPE) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "FA_recibe_mensaje_FS_PR"
         Lenguaje="PL/SQL"
         Fecha="28-07-2008"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
          Por medio de la tabla GA_TRANSACABO el VB obtendra el resultado de ejecucion.
         Cada dato agregado en el campo DES_CADENA, debe ir separado por / para el VB.
      </Retorno>
      <Descripcion>
         Mascara para ser invocada desde los VB.
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_numTransaccion" Tipo="NUMBER"> numero de transaccion </param>
         <param nom="EN_numProceso"     Tipo="NUMBER"> numero de proceso </param>
         <param nom="EV_desCorMensaje"  Tipo="STRING"> descripcion corta mensaje</param>
         <param nom="EV_Mensaje"        Tipo="STRING"> mensaje </param>
         <param nom="EV_nomUsuario"     Tipo="STRING"> usuario </param>
      </Entrada>
      <Salida> N/A </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      error_proceso     EXCEPTION;
      lv_des_error      ge_errores_pg.desevent;
      lv_sql            ge_errores_pg.vquery;
      ln_cod_retorno    ge_errores_pg.coderror;
      lv_mens_retorno   ge_errores_pg.msgerror;
      ln_num_evento     ge_errores_pg.evento;

   BEGIN
      ln_cod_retorno  := 0;
      lv_mens_retorno := NULL;
      ln_num_evento   := 0;

      fa_recibe_mensaje_pr (en_numproceso, ev_descormensaje, ev_mensaje, ev_nomusuario, ln_cod_retorno, lv_mens_retorno, ln_num_evento);

      IF (ln_cod_retorno <> 0) THEN
         ln_cod_retorno  := 0;
         lv_mens_retorno := '/ERROR' || '/' || TO_CHAR (ln_num_evento);
         RAISE error_proceso;
      END IF;

      lv_mens_retorno := '/OK';
      RAISE error_proceso;

   EXCEPTION
      WHEN error_proceso THEN
         INSERT INTO ga_transacabo
                     (num_transaccion, cod_retorno, des_cadena)
         VALUES      (en_numtransaccion, ln_cod_retorno, lv_mens_retorno);

     WHEN OTHERS THEN
         RAISE error_proceso;
   END fa_recibe_mensaje_fs_pr;

   PROCEDURE fa_obtiene_numproceso_pr (
      en_numventa       IN              fa_interfact.num_venta%TYPE,
      sn_numproceso     OUT NOCOPY      fa_interfact.num_proceso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "FA_obtiene_NumProceso_PR
         Lenguaje="PL/SQL"
         Fecha="04-08-2008"
         Version="1.0.0"
         Disenador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Obtiene numero de proceso para la venta
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_numVenta"     Tipo="NUMBER"> numero de venta</param>
      </Entrada>
      <Salida>
         <param nom="SV_numProceso"   Tipo="STRING"> numero proceso </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error</param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;

   BEGIN
      sn_num_evento   := 0;
      sn_cod_retorno  := 0;
      sv_mens_retorno := '';
      sn_numproceso   := 0;

      lv_ssql := 'SELECT a.num_proceso' || ' FROM fa_interfact a' || ' WHERE a.num_venta = ' || en_numventa;

      SELECT a.num_proceso
        INTO sn_numproceso
        FROM fa_interfact a
       WHERE a.num_venta = en_numventa;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10040;
     -- sv_mens_retorno :='Problemas al consultar datos facturación';
         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := SUBSTR ('NO_DATA_FOUND:fa_servicios_fact_quiosco_pg.FA_obtiene_NumProceso_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_fa, sv_mens_retorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_obtiene_NumProceso_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := SUBSTR ('OTHERS:fa_servicios_fact_quiosco_pg.FA_obtiene_NumProceso_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_fa, sv_mens_retorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_obtiene_NumProceso_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END fa_obtiene_numproceso_pr;

  PROCEDURE fa_recibe_mencargos_fs_pr (
      en_numtransaccion   IN   ga_transacabo.num_transaccion%TYPE,
      en_num_os           IN   ci_orserv.num_os%TYPE,
      ev_cod_os           IN   ci_orserv.cod_os%TYPE,
      ev_comentario       IN   ci_orserv.comentario%TYPE) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "FA_recibe_mencargos_FS_PR"
         Lenguaje="PL/SQL"
         Fecha="28-07-2008"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
          Por medio de la tabla GA_TRANSACABO el VB obtendra el resultado de ejecucion.
         Cada dato agregado en el campo DES_CADENA, debe ir separado por / para el VB.
      </Retorno>
      <Descripcion>
         Mascara para ser invocada desde los VB.
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_numTransaccion" Tipo="NUMBER"> numero de transaccion </param>
         <param nom="EN_num_os"     Tipo="NUMBER"> numero de secuencia </param>
         <param nom="EV_COD_OS"     Tipo="STRING"> codigo OOSS</param>
         <param nom="EV_comentario" Tipo="STRING"> mensaje </param>
      </Entrada>
      <Salida> N/A </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      error_proceso     EXCEPTION;
      lv_des_error      ge_errores_pg.desevent;
      lv_sql            ge_errores_pg.vquery;
      ln_cod_retorno    ge_errores_pg.coderror;
      lv_mens_retorno   ge_errores_pg.msgerror;
      ln_num_evento     ge_errores_pg.evento;

   BEGIN
      ln_cod_retorno  := 0;
      lv_mens_retorno := NULL;
      ln_num_evento   := 0;

      fa_inserta_mencargos_pr (en_numtransaccion, en_num_os, ev_cod_os, ev_comentario, ln_cod_retorno, lv_mens_retorno, ln_num_evento);

      IF (ln_cod_retorno <> 0) THEN
         ln_cod_retorno := 0;
         lv_mens_retorno := '/ERROR' || '/' || TO_CHAR (ln_num_evento);
         RAISE error_proceso;
      END IF;

      lv_mens_retorno := '/OK';
      RAISE error_proceso;

   EXCEPTION
      WHEN error_proceso THEN
         INSERT INTO ga_transacabo
                     (num_transaccion, cod_retorno, des_cadena)
         VALUES      (en_numtransaccion, ln_cod_retorno, lv_mens_retorno);

      WHEN OTHERS THEN
         RAISE error_proceso;
   END fa_recibe_mencargos_fs_pr;

   PROCEDURE fa_inserta_mencargos_pr (
      en_numtransaccion   IN              ga_transacabo.num_transaccion%TYPE,
      en_num_os           IN              ci_orserv.num_os%TYPE,
      ev_cod_os           IN              ci_orserv.cod_os%TYPE,
      ev_comentario       IN              ci_orserv.comentario%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "FA_inserta_mencargos_PR"
         Lenguaje="PL/SQL"
         Fecha="28-07-2008"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Inserta mensajes
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_numTransaccion" Tipo="NUMBER> correlativo mensaje </param>
         <param nom="EN_num_os"        Tipo="STRING"> numero de lineas </param>
         <param nom="EV_COD_OS"        Tipo="STRING"> descripcion mensaje </param>
         <param nom="EV_comentario"    Tipo="STRING"> descripcion mensaje linea </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      PRAGMA AUTONOMOUS_TRANSACTION;
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;

   BEGIN
      sn_num_evento   := 0;
      sn_cod_retorno  := 0;
      sv_mens_retorno := '';

      lv_ssql :='INSERT INTO ci_orserv (' || ' NUM_OS,' || ' COD_OS,' || ' PRODUCTO,' || ' TIP_INTER,'
              || ' COD_INTER,' || ' FECHA,' || ' COMENTARIO)' || 'VALUES (' || en_num_os || ','
              || ev_cod_os || ',' || '1' || ',' || '0' || ',' || '0' || ',' || 'sysdate'
              || ',' || ev_comentario || ')';

      INSERT INTO ci_orserv
                  (num_os, cod_os, producto, tip_inter, cod_inter, fecha, comentario)
      VALUES      (en_num_os, ev_cod_os, 1, 0, 0, sysdate, ev_comentario);
      COMMIT;

   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10041;
      --sv_mens_retorno := 'Problemas al ingresar mensajes en la tabla ci_orserv';
         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error    := SUBSTR ('OTHERS:fa_servicios_fact_quiosco_pg.FA_inserta_mencargos_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_fa, sv_mens_retorno, '1.0', USER, 'fa_servicios_fact_quiosco_pg.FA_inserta_mencargos_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END fa_inserta_mencargos_pr;
END fa_servicios_fact_quiosco_pg;
/

SHOW ERRORS
