CREATE OR REPLACE PACKAGE BODY ve_parametros_comer_quiosco_pg AS
   PROCEDURE ve_planservicio_pr (
      ev_plantarif       IN              ta_plantarif.cod_plantarif%TYPE,
      ev_codtecnologia   IN              al_tecnologia.cod_tecnologia%TYPE,
      sc_cursordatos     OUT NOCOPY      refcursor,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento)
                                                              /*--
                                                              <Documentación TipoDoc = "Procedimiento">
                                                                 Elemento Nombre = "VE_planservicio_PR"
                                                                 Lenguaje="PL/SQL"
                                                                 Fecha="21-03-2007"
                                                                 Versión="1.0.0"
                                                                 Diseñador="Roberto Pérez Varas"
                                                                 Programador="Roberto Pérez Varas"
                                                                 Ambiente="BD"
                                                              <Retorno>Planes de servicio</Retorno>
                                                              <Descripción>
                                                                 Retorna planes de servicio
                                                              </Descripción>
                                                              <Parametros>
                                                              <Entrada>
                                                                 <param nom="EV_plantarif" Tipo="VARCHAR2">plan tarifario</param>
                                                                 <param nom="EV_codtecnologia" Tipo="VARCHAR2">codigo tecnologia</param>
                                                              </Entrada>
                                                              <Salida>
                                                                   <param nom="SC_cursordatos "  Tipo="CURSOR">Cursor con planes de servicio</param>
                                                                   <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                   <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                   <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                              </Salida>
                                                              </Parametros>
                                                              </Elemento>
                                                              </Documentación>
                                                              */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql :=
         'SELECT planservicio.cod_planserv, planservicio.des_planserv' || ' FROM   ga_planserv planservicio' || ' WHERE  SYSDATE BETWEEN planservicio.fec_desde AND NVL(planservicio.fec_hasta, SYSDATE)' || ' AND planservicio.cod_producto = '
         || cv_cod_producto || ' AND planservicio.cod_planserv IN (SELECT relacion.cod_planserv' || ' FROM  ga_plantecplserv relacion ' || ' WHERE relacion.cod_tecnologia = ' || ev_codtecnologia || ' AND relacion.cod_plantarif = ' || ev_plantarif || ')';

      SELECT COUNT (1)
        INTO ln_count
        FROM ga_planserv planservicio
       WHERE SYSDATE BETWEEN planservicio.fec_desde AND NVL (planservicio.fec_hasta, SYSDATE)
         AND planservicio.cod_producto = cv_cod_producto
         AND planservicio.cod_planserv IN (SELECT relacion.cod_planserv
                                             FROM ga_plantecplserv relacion
                                            WHERE relacion.cod_tecnologia = ev_codtecnologia
                                              AND relacion.cod_plantarif = ev_plantarif)
         AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT planservicio.cod_planserv, planservicio.des_planserv
           FROM ga_planserv planservicio
          WHERE SYSDATE BETWEEN planservicio.fec_desde AND NVL (planservicio.fec_hasta, SYSDATE)
            AND planservicio.cod_producto = cv_cod_producto
            AND planservicio.cod_planserv IN (SELECT relacion.cod_planserv
                                                FROM ga_plantecplserv relacion
                                               WHERE relacion.cod_tecnologia = ev_codtecnologia
                                                 AND relacion.cod_plantarif = ev_plantarif);

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno  := 10779;
         sv_mens_retorno := 'Error al intentar recuperar datos Plan de Servicios';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_planservicio_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_planservicio_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10900;
         sv_mens_retorno := 'Error al intentar obtener plan de servicios';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_planservicio_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_planservicio_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10900;
         sv_mens_retorno := 'Error al intentar obtener plan de servicios';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_planservicio_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_planservicio_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_planservicio_pr;

   PROCEDURE ve_campanavigente_pr (
      sc_cursordatos    OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento)
                                                          /*--
                                                          <Documentación TipoDoc = "Procedimiento">
                                                             Elemento Nombre = "VE_campanavigente_PR"
                                                             Lenguaje="PL/SQL"
                                                             Fecha="21-03-2007"
                                                             Versión="1.0.0"
                                                             Diseñador="Roberto Pérez Varas"
                                                             Programador="Roberto Pérez Varas"
                                                             Ambiente="BD"
                                                          <Retorno></Retorno>
                                                          <Descripción>
                                                             Campaña Vigente
                                                          </Descripción>
                                                          <Parametros>
                                                          <Entrada>  NA  </Entrada>
                                                          <Salida>
                                                               <param nom="SC_cursordatos "  Tipo="CURSOR">Cursor con campaña vigente</param>
                                                               <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                               <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                               <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                          </Salida>
                                                          </Parametros>
                                                          </Elemento>
                                                          </Documentación>
                                                          */
   IS
      lv_uso                    al_usos.cod_uso%TYPE;
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT parametros.val_parametro' || ' FROM   ged_parametros parametros' || ' WHERE  parametros.nom_parametro = ' || '''USO_LINEA''' || ' AND    parametros.cod_modulo = ' || '''GA''' || ' AND    parametros.cod_producto = 1';

      SELECT parametros.val_parametro
        INTO lv_uso
        FROM ged_parametros parametros
       WHERE parametros.nom_parametro = 'USO_LINEA'
         AND parametros.cod_modulo = 'GA'
         AND parametros.cod_producto = 1;

      lv_sql :=
         'SELECT campanasvigentes.cod_campana,campanasvigentes.des_campana,' || ' DECODE(campanasvigentes.cod_tiplan,LV_uso,S,N)' || ' FROM bp_campanas_td campanasvigentes' || ' WHERE campanasvigentes.tip_entidad = A'
         || ' AND TO_DATE(TO_CHAR(campanasvigentes.fec_termino,YYYYMMDD),YYYYMMDD) >= TO_DATE(TO_CHAR(SYSDATE,YYYYMMDD),YYYYMMDD)' || ' AND campanasvigentes.cod_tiplan <> 1 ' || ' ORDER BY campanasvigentes.ind_default DESC';

      SELECT COUNT (1)
        INTO ln_count
        FROM bp_campanas_td campanasvigentes
       WHERE campanasvigentes.tip_entidad = 'A'
         AND TO_DATE (TO_CHAR (campanasvigentes.fec_termino, 'YYYYMMDD'), 'YYYYMMDD') >= TO_DATE (TO_CHAR (SYSDATE, 'YYYYMMDD'), 'YYYYMMDD')
         AND campanasvigentes.cod_tiplan <> '1'
         AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT   campanasvigentes.cod_campana, campanasvigentes.des_campana, DECODE (campanasvigentes.cod_tiplan, lv_uso, 'S', 'N')
             FROM bp_campanas_td campanasvigentes
            WHERE campanasvigentes.tip_entidad = 'A'
              AND TO_DATE (TO_CHAR (campanasvigentes.fec_termino, 'YYYYMMDD'), 'YYYYMMDD') >= TO_DATE (TO_CHAR (SYSDATE, 'YYYYMMDD'), 'YYYYMMDD')
              AND campanasvigentes.cod_tiplan <> '1'
         ORDER BY campanasvigentes.ind_default DESC;

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno  := 10780;
         sv_mens_retorno :='Error no existen datos para el tipo de campaña';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_campanavigente_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_campanavigente_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN NO_DATA_FOUND THEN
          sn_cod_retorno  := 10781;
          sv_mens_retorno :='Error al Intentar Recuperar Datos de la campaña Vigente';
          lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_campanavigente_PR();- ' || SQLERRM;
         sn_num_evento    := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_campanavigente_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
        sn_cod_retorno  := 10781;
        sv_mens_retorno :='Error al Intentar Recuperar Datos de la campaña Vigente';
        lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_campanavigente_PR();- ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_campanavigente_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_campanavigente_pr;

   PROCEDURE ve_planindemnizacion_pr (
      sc_cursordatos    OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_planindemnizacion_PR"
         Lenguaje="PL/SQL"
         Fecha="21-03-2007"
         Versión="1.0.0"
         Diseñador="Roberto Pérez Varas"
         Programador="Roberto Pérez Varas"
         Ambiente="BD"
      <Retorno></Retorno>
      <Descripción>
         Plabes de Indemnizacion vigentes
      </Descripción>
      <Parametros>
      <Entrada>  NA  </Entrada>
      <Salida>
           <param nom="SC_cursordatos "  Tipo="CURSOR">Cursor con planes de indemnizacion vigentes</param>
           <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
           <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
           <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentación>
      */
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT planind.cod_plan_indemnizacion, planind.des_plan_indemnizacion' || ' FROM pv_plan_indemnizacion_td  planind' || ' WHERE SYSDATE BETWEEN planind.fec_desde AND NVL(planind.fec_hasta, SYSDATE)';

      SELECT COUNT (1)
        INTO ln_count
        FROM pv_plan_indemnizacion_td planind
       WHERE SYSDATE BETWEEN planind.fec_desde AND NVL (planind.fec_hasta, SYSDATE)
         AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT planind.cod_plan_indemnizacion, planind.des_plan_indemnizacion
           FROM pv_plan_indemnizacion_td planind
          WHERE SYSDATE BETWEEN planind.fec_desde AND NVL (planind.fec_hasta, SYSDATE);

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno  := 10782;
         sv_mens_retorno :='Error no se encontraron datos planes de indemnizacion';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_planindemnizacion_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_planindemnizacion_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10901;
         sv_mens_retorno := 'Error al intentar obtener planes de indemnizacion';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_planindemnizacion_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_planindemnizacion_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10901;
         sv_mens_retorno := 'Error al intentar obtener planes de indemnizacion';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_planindemnizacion_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_planindemnizacion_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_planindemnizacion_pr;

   PROCEDURE ve_creditomorosidad_pr (
      en_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentación TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_creditomorosidad_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="21-03-2007"
                                                                Versión="1.0.0"
                                                                Diseñador="Roberto Pérez Varas"
                                                                Programador="Roberto Pérez Varas"
                                                                Ambiente="BD"
                                                             <Retorno>Morosidad de credito de un cliente </Retorno>
                                                             <Descripción>
                                                                Morosidad de credito de un cliente
                                                             </Descripción>
                                                             <Parametros>
                                                             <Entrada>
                                                                  <param nom="EN_codcliente"  Tipo="NUMBER">codigo de cliente</param>
                                                             </Entrada>
                                                             <Salida>
                                                                  <param nom="SC_cursordatos"  Tipo="CURSOR">Cursor con causales de descuentos vigentes</param>
                                                                  <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                  <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                  <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql :=
         'SELECT credmor.cod_credmor, credmor.des_credmor, credmor.imp_morosidad' || ' FROM co_limcreditos credmor' || ' WHERE credmor.cod_producto = 1' || ' AND credmor.cod_calclien IN (SELECT cli.cod_calclien' || ' SELECT cli.cod_calclien'
         || ' WHERE cli.cod_cliente = ' || en_codcliente || ')';

      SELECT COUNT (1)
        INTO ln_count
        FROM co_limcreditos credmor
       WHERE credmor.cod_producto = 1
         AND credmor.cod_calclien IN (SELECT cli.cod_calclien
                                        FROM ge_clientes cli
                                       WHERE cli.cod_cliente = en_codcliente)
         AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT credmor.cod_credmor, credmor.des_credmor, credmor.imp_morosidad
           FROM co_limcreditos credmor
          WHERE credmor.cod_producto = 1
            AND credmor.cod_calclien IN (SELECT cli.cod_calclien
                                           FROM ge_clientes cli
                                          WHERE cli.cod_cliente = en_codcliente);

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno  := 10783;
         sv_mens_retorno := 'Error no se encontraron datos morosidad de credito de un cliente';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_creditomorosidad_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_creditomorosidad_PR()', lv_sql, SQLCODE, lv_des_error);

     WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10902;
         sv_mens_retorno := 'Error al intentar obtener morosidad de credito de un cliente';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_creditomorosidad_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_creditomorosidad_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10902;
         sv_mens_retorno := 'Error al intentar obtener morosidad de credito de un cliente';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_creditomorosidad_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_creditomorosidad_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_creditomorosidad_pr;

   PROCEDURE ve_grupocobroservicio_pr (
      en_codproducto    IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentación TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_grupocobroservicio_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="21-03-2007"
                                                                Versión="1.0.0"
                                                                Diseñador="Roberto Pérez Varas"
                                                                Programador="Roberto Pérez Varas"
                                                                Ambiente="BD"
                                                             <Retorno>Grupo cobro servicio</Retorno>
                                                             <Descripción>
                                                                Grupo cobro servicio
                                                             </Descripción>
                                                             <Parametros>
                                                             <Entrada>
                                                                  <param nom="EN_codcliente"  Tipo="NUMBER">codigo de cliente</param>
                                                             </Entrada>
                                                             <Salida>
                                                                  <param nom="SC_cursordatos"  Tipo="CURSOR">Cursor con causales de descuentos vigentes</param>
                                                                  <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                  <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                  <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT grupo.cod_grupo, grupo.des_grupo' || ' FROM ga_grpserv grupo' || ' WHERE grupo.cod_producto = 1';

      SELECT COUNT (1)
        INTO ln_count
        FROM ga_grpserv grupo
       WHERE cod_producto = en_codproducto
         AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT grupo.cod_grupo, grupo.des_grupo
           FROM ga_grpserv grupo
          WHERE cod_producto = en_codproducto;

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno  := 10784;
         sv_mens_retorno := 'Error no se encontraron datos grupo cobro servicio';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_grupocobroservicio_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_grupocobroservicio_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10903;
         sv_mens_retorno := 'Error al intentar obtener grupo cobro servicio';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_grupocobroservicio_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_grupocobroservicio_PR()', lv_sql, SQLCODE, lv_des_error);

     WHEN OTHERS THEN
         sn_cod_retorno  := 10903;
         sv_mens_retorno := 'Error al intentar obtener grupo cobro servicio';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_grupocobroservicio_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_grupocobroservicio_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_grupocobroservicio_pr;

   PROCEDURE ve_creditoconsumo_pr (
      en_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      en_codproducto    IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentación TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_creditoconsumo_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="21-03-2007"
                                                                Versión="1.0.0"
                                                                Diseñador="Roberto Pérez Varas"
                                                                Programador="Roberto Pérez Varas"
                                                                Ambiente="BD"
                                                             <Retorno>credito consumo de un cliente </Retorno>
                                                             <Descripción>
                                                                Credito Consumo de un cliente
                                                             </Descripción>
                                                             <Parametros>
                                                             <Entrada>
                                                                  <param nom="EN_codcliente"  Tipo="NUMBER">codigo de cliente</param>
                                                                  <param nom="EN_codproducto"  Tipo="NUMBER">codigo de producto</param>
                                                             </Entrada>
                                                             <Salida>
                                                                  <param nom="SC_cursordatos"  Tipo="CURSOR">Cursor con causales de descuentos vigentes</param>
                                                                  <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                  <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                  <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql :=
         'SELECT limcon.cod_credcon, limcon.des_credcon, limcon.imp_consumo' || ' FROM co_limconsumo limcon' || ' WHERE limcon.cod_producto = 1' || ' AND limcon.cod_calclien IN (SELECT cli.cod_calclien' || ' FROM ge_clientes cli'
         || ' WHERE cli.cod_cliente = ' || en_codcliente || ')';

      SELECT COUNT (1)
        INTO ln_count
        FROM co_limconsumo limcon
       WHERE limcon.cod_producto = en_codproducto
         AND limcon.cod_calclien IN (SELECT cli.cod_calclien
                                       FROM ge_clientes cli
                                      WHERE cli.cod_cliente = en_codcliente)
         AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT limcon.cod_credcon, limcon.des_credcon, limcon.imp_consumo
           FROM co_limconsumo limcon
          WHERE limcon.cod_producto = en_codproducto
            AND limcon.cod_calclien IN (SELECT cli.cod_calclien
                                          FROM ge_clientes cli
                                         WHERE cli.cod_cliente = en_codcliente);

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno  := 10785;
         sv_mens_retorno := 'Error no se encontraron datos sobre credito consumo de un cliente';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_creditoconsumo_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_creditoconsumo_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10904;
         sv_mens_retorno :='Error al intentar obtener credito consumo de un cliente';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_creditoconsumo_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_creditoconsumo_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10904;
         sv_mens_retorno :='Error al intentar obtener credito consumo de un cliente';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_creditoconsumo_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_creditoconsumo_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_creditoconsumo_pr;

   PROCEDURE ve_grupoafinidad_pr (
      en_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentación TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_grupoafinidad_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="21-03-2007"
                                                                Versión="1.0.0"
                                                                Diseñador="Roberto Pérez Varas"
                                                                Programador="Roberto Pérez Varas"
                                                                Ambiente="BD"
                                                             <Retorno>Grupos de Afinidad por cliente </Retorno>
                                                             <Descripción>
                                                                Grupos de Afinidad
                                                             </Descripción>
                                                             <Parametros>
                                                             <Entrada>
                                                                  <param nom="EN_codcliente"  Tipo="NUMBER">codigo de cliente</param>
                                                             </Entrada>
                                                             <Salida>
                                                                  <param nom="SC_cursordatos"  Tipo="CURSOR">Cursor con grupos de afinidad</param>
                                                                  <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                  <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                  <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_count                  VARCHAR2 (1);
      lv_origen                 ga_afinidades.ori_afinidad%TYPE;
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      BEGIN
         sn_cod_retorno := 0;
         sv_mens_retorno := NULL;
         sn_num_evento := 0;
         lv_origen := 'I';
         lv_sql := 'SELECT ' || '''1''' || ' FROM ga_empresa emp' || ' WHERE emp.cod_cliente = ' || en_codcliente;

         SELECT '1'
           INTO lv_count
           FROM ga_empresa emp
          WHERE emp.cod_cliente = en_codcliente;

         IF lv_count = '1' THEN
            lv_origen := 'E';
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            NULL;
         WHEN OTHERS THEN
            sn_cod_retorno  := 10905;
            sv_mens_retorno := 'Error a intentar verificar existencia de empresa';
            lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_grupoafinidad_PR();- ' || SQLERRM;
            sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_grupoafinidad_PR()', lv_sql, SQLCODE, lv_des_error);
      END;

      BEGIN
         lv_sql := 'SELECT afi.cod_afinidad, afi.des_afinidad' || ' FROM ga_afinidades afi' || ' WHERE afi.ori_afinidad = ' || lv_origen;

         SELECT COUNT (1)
           INTO ln_count
           FROM ga_afinidades afi
          WHERE afi.ori_afinidad = lv_origen
            AND ROWNUM <= 1;

         OPEN sc_cursordatos FOR
            SELECT afi.cod_afinidad, afi.des_afinidad
              FROM ga_afinidades afi
             WHERE afi.ori_afinidad = lv_origen;

         IF ln_count = 0 THEN
            RAISE le_no_data_found_cursor;
         END IF;
      EXCEPTION
         WHEN le_no_data_found_cursor THEN
            sn_cod_retorno  := 10786;
            sv_mens_retorno := 'Error no se encontró cantidad de datos de afinidad';
            lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_grupoafinidad_PR();- ' || SQLERRM;
            sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_grupoafinidad_PR()', lv_sql, SQLCODE, lv_des_error);

        WHEN NO_DATA_FOUND THEN
            sn_cod_retorno  := 10906;
            sv_mens_retorno := 'Error al intentar recuperar cantidad de datos de afinidad';
            lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_grupoafinidad_PR();- ' || SQLERRM;
            sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_grupoafinidad_PR()', lv_sql, SQLCODE, lv_des_error);

         WHEN OTHERS THEN
            sn_cod_retorno  := 10906;
            sv_mens_retorno := 'Error al intentar recuperar cantidad de datos de afinidad';
            lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_grupoafinidad_PR();- ' || SQLERRM;
            sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_grupoafinidad_PR()', lv_sql, SQLCODE, lv_des_error);
      END;
   END ve_grupoafinidad_pr;

   PROCEDURE ve_modalidadpago_pr (
      ev_codtipcontrato   IN              ga_tipcontrato.cod_tipcontrato%TYPE,
      en_nromeses         IN              ga_percontrato.num_meses%TYPE,
      en_codvendedor      IN              ve_vendedores.cod_vendedor%TYPE,
      ev_nomusuario       IN              ge_seg_usuario.nom_usuario%TYPE,
      en_codproducto      IN              NUMBER,
      ev_codoperacion     IN              gad_modpago_catplan.cod_operacion%TYPE,
      ev_cod_programa     IN              ge_programas.cod_programa%TYPE,
      sc_cursordatos      OUT NOCOPY      refcursor,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento)
                                                               /*--
                                                               <Documentación TipoDoc = "Procedimiento">
                                                                  Elemento Nombre = "VE_modalidadpago_PR"
                                                                  Lenguaje="PL/SQL"
                                                                  Fecha="21-03-2007"
                                                                  Versión="1.0.0"
                                                                  Diseñador="Roberto Pérez Varas"
                                                                  Programador="Roberto Pérez Varas"
                                                                  Ambiente="BD"
                                                               <Retorno>Modalidad de Pago </Retorno>
                                                               <Descripción>
                                                                  Modalidad de Pago
                                                               </Descripción>
                                                               <Parametros>
                                                               <Entrada>
                                                                    <param nom="EV_codtipcontrato"  Tipo="VARCHAR2">codigo de tipo de contrato</param>
                                                                    <param nom="EN_nromeses"  Tipo="NUMBER">numero de meses</param>
                                                                    <param nom="EN_codvendedor"  Tipo="NUMBER">codigo de vendedor</param>
                                                                    <param nom="EV_nomusuario"  Tipo="VARCHAR2">nombre de usuario</param>
                                                                    <param nom="EN_codproducto"  Tipo="NUMBER">codigo del producto</param>
                                                                    <param nom="EV_codoperacion"  Tipo="VARCHAR2">codigo de operacion</param>
                                                                  <param nom="EV_cod_programa" Tipo="STRING">Código del Programa</param>
                                                               </Entrada>
                                                               <Salida>
                                                                    <param nom="SC_cursordatos"  Tipo="CURSOR">Cursor con modalidad de pago</param>
                                                                    <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                    <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                    <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                               </Salida>
                                                               </Parametros>
                                                               </Elemento>
                                                               </Documentación>
                                                               */
   IS
      lv_uso                    al_usos.cod_uso%TYPE;
      lv_usodos                 al_usos.cod_uso%TYPE;
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      lv_sqlejecutar            ge_errores_pg.vquery;
      lv_sqlejecutarc           ge_errores_pg.vquery;
      lv_sqltipcomis            VARCHAR2 (1024);
      ln_cod_proceso            gad_procesos_perfiles.cod_proceso%TYPE;
      lv_res_validacion         BOOLEAN;
      ln_cod_retorno            ge_errores_pg.coderror;
      lv_mens_retorno           ge_errores_pg.msgerror;
      ln_num_evento             ge_errores_pg.evento;
      ln_count                  NUMBER (1);
      lv_count                  ge_errores_pg.vquery;
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT procesoperfil.cod_proceso' || ' FROM gad_procesos_perfiles procesoperfil' || ' WHERE nom_perfil_proceso = ' || cv_codmodventa;

      SELECT procesoperfil.cod_proceso
        INTO ln_cod_proceso
        FROM gad_procesos_perfiles procesoperfil
       WHERE nom_perfil_proceso = cv_codmodventa;

      lv_sql := 'SELECT parametros.val_parametro' || ' FROM ged_parametros parametros' || ' WHERE parametros.nom_parametro = ' || cv_parcausavta || ' AND parametros.cod_modulo = ' || cv_codmodulo || ' AND parametros.cod_producto = ' || en_codproducto;

      SELECT parametros.val_parametro
        INTO lv_uso
        FROM ged_parametros parametros
       WHERE parametros.nom_parametro = cv_parcausavta
         AND parametros.cod_modulo = cv_codmodulo
         AND parametros.cod_producto = en_codproducto;

      lv_sql := 'SELECT parametros.val_parametro' || ' FROM ged_parametros parametros' || ' WHERE parametros.nom_parametro = ' || cv_parametrov || ' AND parametros.cod_modulo = ' || cv_codmodulo || ' AND parametros.cod_producto = ' || en_codproducto;

      SELECT parametros.val_parametro
        INTO lv_usodos
        FROM ged_parametros parametros
       WHERE parametros.nom_parametro = cv_parametrov
         AND parametros.cod_modulo = cv_codmodulo
         AND parametros.cod_producto = en_codproducto;

      lv_sql := 've_parametros_comer_quiosco_pg.VE_validausuariovendedor_FN(' || en_codvendedor || ', ' || ln_cod_retorno || ', ' || lv_mens_retorno || ', ' || ln_num_evento || ')';
      lv_res_validacion := ve_parametros_comer_quiosco_pg.ve_validausuariovendedor_fn (en_codvendedor, ln_cod_retorno, lv_mens_retorno, ln_num_evento);

      IF lv_res_validacion = TRUE THEN
         lv_sql := 've_parametros_comer_quiosco_pg.VE_validapermisovendedor_FN(' || en_codvendedor || ', ' || ln_cod_proceso || ', ' || ln_cod_retorno || ', ' || lv_mens_retorno || ', ' || ln_num_evento || ')';
         lv_res_validacion := ve_parametros_comer_quiosco_pg.ve_validapermisovendedor_fn (en_codvendedor, ln_cod_proceso, ln_cod_retorno, lv_mens_retorno, ln_num_evento);
      ELSE
         lv_sql := 've_parametros_comer_quiosco_pg.VE_validapermisousuario_FN(' || ev_nomusuario || ', ' || ln_cod_proceso || ', ' || ln_cod_retorno || ', ' || lv_mens_retorno || ', ' || ln_num_evento || ')';
         lv_res_validacion := ve_parametros_comer_quiosco_pg.ve_validapermisousuario_fn (ev_nomusuario, ln_cod_proceso, ln_cod_retorno, lv_mens_retorno, ln_num_evento);
      END IF;

      lv_sqlejecutar :=
         'SELECT UNIQUE mod_venta.cod_modventa, mod_venta.des_modventa' || ' FROM GE_MODVENTA mod_venta, GA_MODVENT_APLIC mod_ven_aplicacion,' || ' GAD_MODPAGO_CATPLAN mod_pago' || ' WHERE mod_venta.cod_modventa= mod_ven_aplicacion.COD_MODVENTA'
         || ' AND mod_ven_aplicacion.cod_producto= ' || en_codproducto || ' AND mod_ven_aplicacion.cod_aplic LIKE ''' || '%' || ev_cod_programa || '%' || '''' || ' AND mod_pago.cod_tipcontrato = ''' || ev_codtipcontrato || ''''
         || ' AND mod_pago.num_meses =' || en_nromeses || ' AND mod_pago.cod_operacion =''' || ev_codoperacion || '''' || ' AND mod_venta.cod_modventa = mod_pago.cod_modpago' || ' AND mod_ven_aplicacion.cod_canal = mod_pago.cod_canal_vta'
         || ' AND mod_pago.ind_causa =''' || lv_usodos || '''' || ' AND mod_ven_aplicacion.cod_canal IN (' || ' SELECT tipo_comisionista.ind_vta_externa' || ' FROM ve_tipcomis tipo_comisionista ' || ' WHERE tipo_comisionista.cod_tipcomis IN ('
         || ' SELECT vendedores.cod_tipcomis' || ' FROM ve_vendedores vendedores' || ' WHERE vendedores.cod_vendedor = ' || en_codvendedor || ' AND SYSDATE BETWEEN vendedores.fec_contrato AND NVL(vendedores.fec_fincontrato,SYSDATE)' || ' UNION'
         || ' SELECT vendedores.cod_tipcomis' || ' FROM ve_vendedores vendedores, ve_vendealer dealer' || ' WHERE vendedores.cod_vendedor = ' || en_codvendedor || ' AND dealer.cod_vendedor = vendedores.cod_vendedor'
         || ' AND SYSDATE BETWEEN vendedores.fec_contrato AND NVL(vendedores.fec_fincontrato,SYSDATE)' || ' AND SYSDATE BETWEEN dealer.fec_contrato AND NVL(dealer.fec_fincontrato,SYSDATE)))';

      IF lv_res_validacion = TRUE THEN
         lv_sqlejecutar := lv_sqlejecutar || ' AND mod_venta.ind_cuotas != -1';

         IF     lv_usodos <> 0
            AND lv_uso <> NULL
            AND lv_uso <> '' THEN
            lv_sqlejecutar := lv_sqlejecutar || ' AND mod_pago.cod_causa = ' || lv_uso;
         END IF;
      ELSE
         IF     lv_usodos <> 0
            AND lv_uso <> NULL
            AND lv_uso <> '' THEN
            lv_sqlejecutar := lv_sqlejecutar || ' AND mod_pago.cod_causa = ' || lv_uso;
         END IF;
      END IF;

      lv_sql := lv_sqlejecutar;

      OPEN sc_cursordatos FOR lv_sql;

      lv_count := 'SELECT COUNT(1) FROM (' || lv_sqlejecutar || ' AND ROWNUM <= 1)';

      EXECUTE IMMEDIATE lv_count
                   INTO ln_count;

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10907;
         sv_mens_retorno := 'Error al intentar obtener modalidad de pago';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_modalidadpago_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_modalidadpago_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10907;
         sv_mens_retorno := 'Error al intentar obtener modalidad de pago';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_modalidadpago_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_modalidadpago_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_modalidadpago_pr;

   PROCEDURE ve_tipocontrato_pr (
      ev_nomusuario     IN              ge_seg_usuario.nom_usuario%TYPE,
      en_codproducto    IN              NUMBER,
      ev_indcontcel     IN              VARCHAR2,
      ev_indcontseg     IN              VARCHAR2,
      ev_cod_programa   IN              ge_programas.cod_programa%TYPE,
      en_num_version    IN              ge_programas.num_version%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentación TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_tipocontrato_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="21-03-2007"
                                                                Versión="1.0.0"
                                                                Diseñador="Roberto Pérez Varas"
                                                                Programador="Roberto Pérez Varas"
                                                                Ambiente="BD"
                                                             <Retorno>Tipo de contrato</Retorno>
                                                             <Descripción>
                                                                Tipo de contrato
                                                             </Descripción>
                                                             <Parametros>
                                                             <Entrada>
                                                                  <param nom="EV_nomusuario"   Tipo="VARCHAR2">Nombre de usuario</param>
                                                                  <param nom="EN_codproducto"  Tipo="NUMBER">codigo de producto</param>
                                                                  <param nom="EV_indcontcel"   Tipo="VARCHAR2">indice contcel</param>
                                                                  <param nom="EV_indcontseg"   Tipo="VARCHAR2">indice contseg</param>
                                                                <param nom="EV_cod_programa" Tipo="STRING">Código del Programa</param>
                                                                <param nom="EN_num_version"  Tipo="NUMBER">Versión del programa</param>
                                                             </Entrada>
                                                             <Salida>
                                                                  <param nom="SC_cursordatos"  Tipo="CURSOR">Cursor con tipo de contrato</param>
                                                                  <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                  <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                  <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      ln_codproceso             ge_seg_perfiles.cod_proceso%TYPE;
      ln_cod_retorno            ge_errores_pg.coderror;
      lv_mens_retorno           ge_errores_pg.msgerror;
      ln_num_evento             ge_errores_pg.evento;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      ln_cod_retorno := 0;
      ve_permisousuario_pr (ev_nomusuario, cv_codcomodato, ev_cod_programa, en_num_version, ln_codproceso, ln_cod_retorno, lv_mens_retorno, ln_num_evento);

      IF ln_cod_retorno = 0 THEN
         lv_sql :=
            'SELECT tipo_contrato.cod_tipcontrato, tipo_contrato.des_tipcontrato' || ' FROM ga_tipcontrato tipo_contrato' || ' WHERE SYSDATE BETWEEN tipo_contrato.fec_desde AND NVL(tipo_contrato.fec_hasta, SYSDATE)'
            || ' AND tipo_contrato.cod_producto = ' || en_codproducto || ' AND tipo_contrato.ind_contcel = ' || ev_indcontcel || ' AND tipo_contrato.ind_contseg = ' || ev_indcontseg;

         SELECT COUNT (1)
           INTO ln_count
           FROM ga_tipcontrato tipo_contrato
          WHERE SYSDATE BETWEEN tipo_contrato.fec_desde AND NVL (tipo_contrato.fec_hasta, SYSDATE)
            AND tipo_contrato.cod_producto = en_codproducto
            AND tipo_contrato.ind_contcel = ev_indcontcel
            AND tipo_contrato.ind_contseg = ev_indcontseg
            AND ROWNUM <= 1;

         OPEN sc_cursordatos FOR
            SELECT tipo_contrato.cod_tipcontrato, tipo_contrato.des_tipcontrato
              FROM ga_tipcontrato tipo_contrato
             WHERE SYSDATE BETWEEN tipo_contrato.fec_desde AND NVL (tipo_contrato.fec_hasta, SYSDATE)
               AND tipo_contrato.cod_producto = en_codproducto
               AND tipo_contrato.ind_contcel = ev_indcontcel
               AND tipo_contrato.ind_contseg = ev_indcontseg;
      ELSE
         lv_sql :=
            'SELECT tipo_contrato.cod_tipcontrato, tipo_contrato.des_tipcontrato' || ' FROM ga_tipcontrato tipo_contrato' || ' WHERE SYSDATE BETWEEN tipo_contrato.fec_desde AND NVL(tipo_contrato.fec_hasta, SYSDATE)'
            || ' AND tipo_contrato.cod_producto = ' || en_codproducto || ' AND tipo_contrato.ind_contcel = ' || ev_indcontcel || ' AND tipo_contrato.ind_contseg = ' || ev_indcontseg || ' AND NVL(tipo_contrato.ind_comodato,0) != 1';

         SELECT COUNT (1)
           INTO ln_count
           FROM ga_tipcontrato tipo_contrato
          WHERE SYSDATE BETWEEN tipo_contrato.fec_desde AND NVL (tipo_contrato.fec_hasta, SYSDATE)
            AND tipo_contrato.cod_producto = en_codproducto
            AND tipo_contrato.ind_contcel = ev_indcontcel
            AND tipo_contrato.ind_contseg = ev_indcontseg
            AND NVL (tipo_contrato.ind_comodato, 0) != 1
            AND ROWNUM <= 1;

         OPEN sc_cursordatos FOR
            SELECT tipo_contrato.cod_tipcontrato, tipo_contrato.des_tipcontrato
              FROM ga_tipcontrato tipo_contrato
             WHERE SYSDATE BETWEEN tipo_contrato.fec_desde AND NVL (tipo_contrato.fec_hasta, SYSDATE)
               AND tipo_contrato.cod_producto = en_codproducto
               AND tipo_contrato.ind_contcel = ev_indcontcel
               AND tipo_contrato.ind_contseg = ev_indcontseg
               AND NVL (tipo_contrato.ind_comodato, 0) != 1;
      END IF;

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno  := 10787;
         sv_mens_retorno := 'Error no se encontraron datos para Tipo de Contrato';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_tipocontrato_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_tipocontrato_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10908;
         sv_mens_retorno := 'Error al intentar obtener tipo de contrato';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_tipocontrato_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_tipocontrato_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10908;
         sv_mens_retorno := 'Error al intentar obtener tipo de contrato';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_tipocontrato_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_tipocontrato_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_tipocontrato_pr;

   PROCEDURE ve_permisousuario_pr (
      ev_nom_usuario    IN              ge_seg_usuario.nom_usuario%TYPE,
      ev_nom_proceso    IN              gad_procesos_perfiles.cod_proceso%TYPE,
      ev_cod_programa   IN              ge_programas.cod_programa%TYPE,
      en_num_version    IN              ge_programas.num_version%TYPE,
      sn_codproceso     OUT NOCOPY      ge_seg_perfiles.cod_proceso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentación TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_permisousuario_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="21-03-2007"
                                                                Versión="1.0.0"
                                                                Diseñador="Roberto Pérez Varas"
                                                                Programador="Roberto Pérez Varas"
                                                                Ambiente="BD"
                                                             <Retorno>Permiso Usuario</Retorno>
                                                             <Descripción>
                                                                Permiso Usuario
                                                             </Descripción>
                                                             <Parametros>
                                                             <Entrada>
                                                                  <param nom="EV_nom_usuario"  Tipo="STRING">Nombre de usuario</param>
                                                                  <param nom="EV_nom_proceso"  Tipo="STRING">Nombre Proceso</param>
                                                                <param nom="EV_cod_programa" Tipo="STRING">Código del Programa</param>
                                                                <param nom="EN_num_version"  Tipo="NUMBER">Versión del programa</param>
                                                             </Entrada>
                                                             <Salida>
                                                                  <param nom="SC_cursordatos"  Tipo="CURSOR">Cursor con permiso usuario</param>
                                                                  <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                  <param nom="SV_mens_retorno" Tipo="STRING">Mensaje error de negocio Retornado</param>
                                                                  <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentación>
                                                             */
   IS
      ln_codproceso   gad_procesos_perfiles.cod_proceso%TYPE;
      lv_des_error    ge_errores_pg.desevent;
      lv_sql          ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT perfiles.cod_proceso' || ' FROM gad_procesos_perfiles perfiles' || ' WHERE perfiles.nom_perfil_proceso = ' || ev_nom_proceso;

      SELECT perfiles.cod_proceso
        INTO ln_codproceso
        FROM gad_procesos_perfiles perfiles
       WHERE perfiles.nom_perfil_proceso = ev_nom_proceso;

      lv_sql :=
         'SELECT perfiles.cod_proceso' || ' FROM   ge_seg_perfiles perfiles, ge_seg_grpusuario grupo_usuario' || ' WHERE  perfiles.cod_grupo = grupo_usuario.cod_grupo' || ' AND    grupo_usuario.nom_usuario = ''' || ev_nom_usuario || ''''
         || ' AND    perfiles.cod_programa = ''' || ev_cod_programa || '''' || ' AND    perfiles.num_version = ' || en_num_version || ' AND    perfiles.cod_proceso = ' || ln_codproceso || ' AND    ROWNUM = 1';

      SELECT perfiles.cod_proceso
        INTO sn_codproceso
        FROM ge_seg_perfiles perfiles, ge_seg_grpusuario grupo_usuario
       WHERE perfiles.cod_grupo = grupo_usuario.cod_grupo
         AND grupo_usuario.nom_usuario = ev_nom_usuario
         AND perfiles.cod_programa = ev_cod_programa
         AND perfiles.num_version = en_num_version
         AND perfiles.cod_proceso = ln_codproceso
         AND ROWNUM = 1;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10788;
         sv_mens_retorno := 'Error al Consultar Permiso de Usuario';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_permisousuario_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_permisousuario_PR()', lv_sql, SQLCODE, lv_des_error);

     WHEN OTHERS THEN
         sn_cod_retorno  := 10909;
         sv_mens_retorno := 'Error al intentar obtener Permiso Usuario';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_permisousuario_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_permisousuario_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_permisousuario_pr;

   PROCEDURE ve_nromesescontrato_pr (
      ev_codtipcontrato   IN              ga_tipcontrato.cod_tipcontrato%TYPE,
      en_codproducto      IN              NUMBER,
      sc_cursordatos      OUT NOCOPY      refcursor,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento)
                                                               /*--
                                                               <Documentación TipoDoc = "Procedimiento">
                                                                  Elemento Nombre = "VE_nromesescontrato_PR"
                                                                  Lenguaje="PL/SQL"
                                                                  Fecha="21-03-2007"
                                                                  Versión="1.0.0"
                                                                  Diseñador="Roberto Pérez Varas"
                                                                  Programador="Roberto Pérez Varas"
                                                                  Ambiente="BD"
                                                               <Retorno>Numero Meses Contrato/Retorno>
                                                               <Descripción>
                                                                  Numero Meses Contrato
                                                               </Descripción>
                                                               <Parametros>
                                                               <Entrada>
                                                                    <param nom="EV_codtipcontrato"  Tipo="VARCHAR2">Codigo tipo contrato</param>
                                                                    <param nom="EN_codproducto"  Tipo="NUMBER">codigo de producto</param>
                                                               </Entrada>
                                                               <Salida>
                                                                    <param nom="SC_cursordatos"  Tipo="CURSOR">Numero Meses Contrato</param>
                                                                    <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                    <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                    <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                               </Salida>
                                                               </Parametros>
                                                               </Elemento>
                                                               </Documentación>
                                                               */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT duracion.cod_tipcontrato, duracion.num_meses' || ' FROM  ga_percontrato duracion' || ' WHERE duracion.cod_producto = ' || en_codproducto || ' AND duracion.cod_tipcontrato = ' || ev_codtipcontrato;

      SELECT COUNT (1)
        INTO ln_count
        FROM ga_percontrato duracion
       WHERE duracion.cod_producto = en_codproducto
         AND duracion.cod_tipcontrato = ev_codtipcontrato
         AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT duracion.cod_tipcontrato, duracion.num_meses
           FROM ga_percontrato duracion
          WHERE duracion.cod_producto = en_codproducto
            AND duracion.cod_tipcontrato = ev_codtipcontrato;

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno  := 10789;
         sv_mens_retorno := 'Error no se encontraron datos  para el Numero de Mes de Contrato';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_nromesescontrato_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_nromesescontrato_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10910;
         sv_mens_retorno := 'Error al intentar obtener el numero de meses de contrato';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_nromesescontrato_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_nromesescontrato_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10910;
         sv_mens_retorno := 'Error al intentar obtener el numero de meses de contrato';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_nromesescontrato_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_nromesescontrato_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_nromesescontrato_pr;

   PROCEDURE ve_nrocuotas_pr (
      en_codmodventa    IN              ge_modventa.cod_modventa%TYPE,
      en_codvendedor    IN              ve_vendedores.cod_vendedor%TYPE,
      ev_nomusuario     IN              ge_seg_usuario.nom_usuario%TYPE,
      en_codproducto    IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentación TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_nrocuotas_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="21-03-2007"
                                                                Versión="1.0.0"
                                                                Diseñador="Roberto Pérez Varas"
                                                                Programador="Roberto Pérez Varas"
                                                                Ambiente="BD"
                                                             <Retorno>Numero cuotas</Retorno>
                                                             <Descripción>
                                                                Numero cuotas
                                                             </Descripción>
                                                             <Parametros>
                                                             <Entrada>
                                                                  <param nom="EN_codmodventa"  Tipo="NUMBER">Codigo tipo contrato</param>
                                                                  <param nom="EN_codvendedor"  Tipo="NUMBER">codigo de vendedor</param>
                                                                  <param nom="EV_nomusuario"  Tipo="NUMBER">nombre de usuario</param>
                                                                  <param nom="EN_codproducto"  Tipo="NUMBER">codigo de producto</param>
                                                             </Entrada>
                                                             <Salida>
                                                                  <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con Numero cuotas</param>
                                                                  <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                  <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                  <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      lv_parametro1             ged_parametros.val_parametro%TYPE;
      lv_parametro2             ged_parametros.val_parametro%TYPE;
      lv_usotres                ged_parametros.val_parametro%TYPE;
      ln_cod_retorno            ge_errores_pg.coderror;
      lv_mens_retorno           ge_errores_pg.msgerror;
      ln_num_evento             ge_errores_pg.evento;
      ln_filas                  NUMBER;
      ln_cod_proceso            gad_procesos_perfiles.cod_proceso%TYPE;
      lv_res_validacion         BOOLEAN;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT parametros.val_parametro' || ' FROM ged_parametros parametros' || ' WHERE parametros.nom_parametro = ' || cv_codconcons || ' AND parametros.cod_modulo = ' || cv_codmodulo || ' AND parametros.cod_producto = ' || en_codproducto;

      SELECT parametros.val_parametro
        INTO lv_parametro1
        FROM ged_parametros parametros
       WHERE parametros.nom_parametro = cv_codconcons
         AND parametros.cod_modulo = cv_codmodulo
         AND parametros.cod_producto = en_codproducto;

      lv_sql := 'SELECT parametros.val_parametro' || ' FROM ged_parametros parametros' || ' WHERE parametros.nom_parametro = ' || cv_codmodpricta || ' AND parametros.cod_modulo = ' || cv_codmodulo || ' AND parametros.cod_producto = ' || en_codproducto;

      SELECT parametros.val_parametro
        INTO lv_parametro2
        FROM ged_parametros parametros
       WHERE parametros.nom_parametro = cv_codmodpricta
         AND parametros.cod_modulo = cv_codmodulo
         AND parametros.cod_producto = en_codproducto;

      lv_sql := 'SELECT procesoperfil.cod_proceso' || ' FROM gad_procesos_perfiles procesoperfil' || ' WHERE nom_perfil_proceso = ' || cv_codcargocuenta;

      SELECT procesoperfil.cod_proceso
        INTO ln_cod_proceso
        FROM gad_procesos_perfiles procesoperfil
       WHERE nom_perfil_proceso = cv_codcargocuenta;

      lv_sql := 've_parametros_comer_quiosco_pg.VE_validausuariovendedor_FN(' || en_codvendedor || ', ' || ln_cod_retorno || ', ' || lv_mens_retorno || ', ' || ln_num_evento || ')';
      lv_res_validacion := ve_parametros_comer_quiosco_pg.ve_validausuariovendedor_fn (en_codvendedor, ln_cod_retorno, lv_mens_retorno, ln_num_evento);

      IF lv_res_validacion = TRUE THEN
         lv_sql := 've_parametros_comer_quiosco_pg.VE_validapermisovendedor_FN(' || en_codvendedor || ', ' || ln_cod_proceso || ', ' || ln_cod_retorno || ', ' || lv_mens_retorno || ', ' || ln_num_evento || ')';
         lv_res_validacion := ve_parametros_comer_quiosco_pg.ve_validapermisovendedor_fn (en_codvendedor, ln_cod_proceso, ln_cod_retorno, lv_mens_retorno, ln_num_evento);
      ELSE
         lv_sql := 've_parametros_comer_quiosco_pg.VE_validapermisousuario_FN(' || ev_nomusuario || ', ' || ln_cod_proceso || ', ' || ln_cod_retorno || ', ' || lv_mens_retorno || ', ' || ln_num_evento || ')';
         lv_res_validacion := ve_parametros_comer_quiosco_pg.ve_validapermisousuario_fn (ev_nomusuario, ln_cod_proceso, ln_cod_retorno, lv_mens_retorno, ln_num_evento);
      END IF;

      IF     en_codmodventa <> lv_parametro2
         AND lv_res_validacion = FALSE THEN
         lv_sql := 'SELECT cuotas.cod_cuota, cuotas.des_cuota' || ' FROM ge_tipcuotas cuotas' || ' WHERE cuotas.cod_cuota != ' || lv_parametro1;

         SELECT COUNT (1)
           INTO ln_count
           FROM ge_tipcuotas cuotas
          WHERE cuotas.cod_cuota != lv_parametro1
            AND ROWNUM <= 1;

         OPEN sc_cursordatos FOR
            SELECT cuotas.cod_cuota, cuotas.des_cuota
              FROM ge_tipcuotas cuotas
             WHERE cuotas.cod_cuota != lv_parametro1;
      ELSIF     en_codmodventa = lv_parametro2
            AND lv_res_validacion = TRUE THEN
         lv_sql := 'SELECT cuotas.cod_cuota, cuotas.des_cuota' || ' FROM ge_tipcuotas cuotas' || ' WHERE cuotas.cod_cuota = ' || lv_parametro1;

         SELECT COUNT (1)
           INTO ln_count
           FROM ge_tipcuotas cuotas
          WHERE cuotas.cod_cuota = lv_parametro1
            AND ROWNUM <= 1;

         OPEN sc_cursordatos FOR
            SELECT cuotas.cod_cuota, cuotas.des_cuota
              FROM ge_tipcuotas cuotas
             WHERE cuotas.cod_cuota = lv_parametro1;
      ELSE
         lv_sql := 'SELECT cuotas.cod_cuota, cuotas.des_cuota' || ' FROM ge_tipcuotas cuotas';

         SELECT COUNT (1)
           INTO ln_count
           FROM ge_tipcuotas cuotas
          WHERE ROWNUM <= 1;

         OPEN sc_cursordatos FOR
            SELECT cuotas.cod_cuota, cuotas.des_cuota
              FROM ge_tipcuotas cuotas;
      END IF;

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno  := 10790;
         sv_mens_retorno := 'Error no se encontraron número de cuotas';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_nrocuotas_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_nrocuotas_PR()', lv_sql, SQLCODE, lv_des_error);

     WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10911;
         sv_mens_retorno := 'Error al intentar obtener el numero de cuotas';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_nrocuotas_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_nrocuotas_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10911;
         sv_mens_retorno := 'Error al intentar obtener el numero de cuotas';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_nrocuotas_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_nrocuotas_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_nrocuotas_pr;

   PROCEDURE ve_tipodocumento_pr (
      en_cod_cliente     IN              ge_clientes.cod_cliente%TYPE,
      ev_ind_agente      IN              ge_clientes.ind_agente%TYPE,
      ev_ind_situacion   IN              ge_clientes.ind_situacion%TYPE,
      en_cod_producto    IN              NUMBER,
      ev_cod_amiciclo    IN              ged_parametros.nom_parametro%TYPE,
      ev_cod_modulo      IN              VARCHAR2,
      sc_cursordatos     OUT NOCOPY      refcursor,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento)
                                                              /*--
                                                              <Documentación TipoDoc = "Procedimiento">
                                                                 Elemento Nombre = "VE_tipodocumento_PR"
                                                                 Lenguaje="PL/SQL"
                                                                 Fecha="21-03-2007"
                                                                 Versión="1.0.0"
                                                                 Diseñador="Roberto Pérez Varas"
                                                                 Programador="Roberto Pérez Varas"
                                                                 Ambiente="BD"
                                                              <Retorno>Tipo de Documento</Retorno>
                                                              <Descripción>
                                                                 Tipo de Documento
                                                              </Descripción>
                                                              <Parametros>
                                                              <Entrada>
                                                                   <param nom="EN_cod_cliente"  Tipo="NUMBER">Codigo cliente</param>
                                                                   <param nom="EV_ind_agente"  Tipo="VARCHAR2">indicador agente</param>
                                                                   <param nom="EV_ind_situacion"  Tipo="VARCHAR2">indicador situacion</param>
                                                                   <param nom="EN_cod_producto"  Tipo="NUMBER">codigo de producto</param>
                                                                   <param nom="EV_cod_amiciclo"  Tipo="VARCHAR2">codigo amiciclo</param>
                                                                   <param nom="EV_cod_modulo  Tipo="VARCHAR2">codigo modulo</param>
                                                              </Entrada>
                                                              <Salida>
                                                                   <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con Tipo de Documento</param>
                                                                   <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                   <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                   <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                              </Salida>
                                                              </Parametros>
                                                              </Elemento>
                                                              </Documentación>
                                                              */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      lv_uso                    al_usos.cod_uso%TYPE;
      lv_cal_tributaria         ga_catributclie.cod_catribut%TYPE;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT parametros.val_parametro' || ' FROM ged_parametros parametros' || ' WHERE parametros.nom_parametro = ' || ev_cod_amiciclo || ' AND parametros.cod_modulo = ' || ev_cod_modulo || ' AND parametros.cod_producto = ' || en_cod_producto;

      SELECT parametros.val_parametro
        INTO lv_uso
        FROM ged_parametros parametros
       WHERE parametros.nom_parametro = ev_cod_amiciclo
         AND parametros.cod_modulo = ev_cod_modulo
         AND parametros.cod_producto = en_cod_producto;

      lv_sql :=
         'SELECT calidadtributaria.cod_catribut' || ' FROM   ge_clientes cliente, ga_catributclie calidadtributaria' || ' WHERE  cliente.cod_cliente = ' || en_cod_cliente || ' AND    cliente.ind_agente = ' || ev_ind_agente
         || ' AND    cliente.ind_situacion <> ' || ev_ind_situacion || ' AND    cliente.cod_ciclo <> ' || lv_uso || ' AND    cliente.cod_cliente = calidadtributaria.cod_cliente'
         || ' AND    SYSDATE BETWEEN calidadtributaria.fec_desde AND NVL(calidadtributaria.fec_hasta,SYSDATE)';

      SELECT calidadtributaria.cod_catribut
        INTO lv_cal_tributaria
        FROM ge_clientes cliente, ga_catributclie calidadtributaria
       WHERE cliente.cod_cliente = en_cod_cliente
         AND cliente.ind_agente = ev_ind_agente
         AND cliente.ind_situacion <> ev_ind_situacion
         AND cliente.cod_ciclo <> lv_uso
         AND cliente.cod_cliente = calidadtributaria.cod_cliente
         AND SYSDATE BETWEEN calidadtributaria.fec_desde AND NVL (calidadtributaria.fec_hasta, SYSDATE);

      lv_sql :=
         'SELECT tipodoc.cod_tipdocum, tipodoc.des_tipdocum, caltribdoc.cod_catribut,tipodoc.tip_foliacion' || ' FROM   ge_catribdocum caltribdoc, ge_tipdocumen tipodoc' || ' WHERE  caltribdoc.cod_catribut = lv_cal_tributaria'
         || ' AND    SYSDATE BETWEEN caltribdoc.fec_desde AND caltribdoc.fec_hasta' || ' AND    caltribdoc.cod_tipdocum = tipodoc.cod_tipdocum';

      SELECT COUNT (1)
        INTO ln_count
        FROM ge_catribdocum caltribdoc, ge_tipdocumen tipodoc
       WHERE caltribdoc.cod_catribut = lv_cal_tributaria
         AND SYSDATE BETWEEN caltribdoc.fec_desde AND caltribdoc.fec_hasta
         AND caltribdoc.cod_tipdocum = tipodoc.cod_tipdocum
         AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT tipodoc.cod_tipdocum, tipodoc.des_tipdocum, caltribdoc.cod_catribut, tipodoc.tip_foliacion
           FROM ge_catribdocum caltribdoc, ge_tipdocumen tipodoc
          WHERE caltribdoc.cod_catribut = lv_cal_tributaria
            AND SYSDATE BETWEEN caltribdoc.fec_desde AND caltribdoc.fec_hasta
            AND caltribdoc.cod_tipdocum = tipodoc.cod_tipdocum;

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno  := 10791;
         sv_mens_retorno := 'Error no se encontraron datos para obtener el tipo de documento';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_tipodocumento_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_tipodocumento_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10912;
         sv_mens_retorno := 'Error al intentar obtener el tipo de documento';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_tipodocumento_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_tipodocumento_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10912;
         sv_mens_retorno := 'Error al intentar obtener el tipo de documento';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_tipodocumento_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_tipodocumento_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_tipodocumento_pr;

   PROCEDURE ve_contratocliente_pr (
      en_codcliente       IN              ge_clientes.cod_cliente%TYPE,
      ev_codtipcontrato   IN              ga_tipcontrato.cod_tipcontrato%TYPE,
      sc_cursordatos      OUT NOCOPY      refcursor,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento)
                                                               /*--
                                                               <Documentación TipoDoc = "Procedimiento">
                                                                  Elemento Nombre = "VE_contratocliente_PR"
                                                                  Lenguaje="PL/SQL"
                                                                  Fecha="21-03-2007"
                                                                  Versión="1.0.0"
                                                                  Diseñador="Roberto Pérez Varas"
                                                                  Programador="Roberto Pérez Varas"
                                                                  Ambiente="BD"
                                                               <Retorno>Contrato Cliente</Retorno>
                                                               <Descripción>
                                                                  Contrato Cliente
                                                               </Descripción>
                                                               <Parametros>
                                                               <Entrada>
                                                                    <param nom="EN_codcliente" Tipo="NUMBER">codigo cliente</param>
                                                                    <param nom="EV_codtipcontrato" Tipo="VARCHAR2">codigo tipo contrato</param>
                                                               </Entrada>
                                                               <Salida>
                                                                    <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con contrato cliente</param>
                                                                    <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                    <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                    <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                               </Salida>
                                                               </Parametros>
                                                               </Elemento>
                                                               </Documentación>
                                                               */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT DISTINCT contrato.cod_tipcontrato, contrato.num_contrato' || ' FROM ga_contcta contrato' || ' WHERE contrato.cod_cuenta IN' || ' (SELECT cliente.cod_cuenta' || ' FROM ge_clientes' || ' WHERE cod_cliente = ' || en_codcliente || ')';

      SELECT COUNT (1)
        INTO ln_count
        FROM ga_contcta contrato
       WHERE contrato.cod_cuenta IN (SELECT cliente.cod_cuenta
                                       FROM ge_clientes cliente
                                      WHERE cliente.cod_cliente = en_codcliente)
         AND contrato.cod_tipcontrato = ev_codtipcontrato
         AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT DISTINCT contrato.cod_tipcontrato, contrato.num_contrato
                    FROM ga_contcta contrato
                   WHERE contrato.cod_cuenta IN (SELECT cliente.cod_cuenta
                                                   FROM ge_clientes cliente
                                                  WHERE cliente.cod_cliente = en_codcliente)
                     AND contrato.cod_tipcontrato = ev_codtipcontrato;

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno  := 10792;
         sv_mens_retorno := 'Error no se encontraron datos para el Contrato del Cliente';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_contratocliente_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_contratocliente_PR()', lv_sql, SQLCODE, lv_des_error);

     WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10913;
         sv_mens_retorno := 'Error al intentar obtener contrato de cliente';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_contratocliente_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_contratocliente_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10913;
         sv_mens_retorno := 'Error al intentar obtener contrato de cliente';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_contratocliente_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_contratocliente_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_contratocliente_pr;

   PROCEDURE ve_obtienedatoscelda_pr (
      ev_codcelda       IN              ge_celdas.cod_celda%TYPE,
      sv_codsubalm      OUT NOCOPY      ge_celdas.cod_subalm%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentación TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_obtienedatoscelda_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="21-03-2007"
                                                                Versión="1.0.0"
                                                                Diseñador="Roberto Pérez Varas"
                                                                Programador="Roberto Pérez Varas"
                                                                Ambiente="BD"
                                                             <Retorno>Obtiene Datos Celda</Retorno>
                                                             <Descripción>
                                                                Obtiene Datos Celda
                                                             </Descripción>
                                                             <Parametros>
                                                             <Entrada>
                                                                  <param nom="EN_codcelda" Tipo="NUMBER">codigo celda</param>
                                                             </Entrada>
                                                             <Salida>
                                                                  <param nom="SN_codsubalm"  Tipo="NUMBER">codigo subalimentador</param>
                                                                  <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                  <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                  <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT celda.cod_subalm' || ' FROM ge_celdas celda' || ' WHERE celda.cod_celda = ' || ev_codcelda || ' AND ROWNUM < 2';

      SELECT celda.cod_subalm
        INTO sv_codsubalm
        FROM ge_celdas celda
       WHERE celda.cod_celda = ev_codcelda
         AND ROWNUM < 2;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10914;
         sv_mens_retorno := 'Error al intentar obtener datos celda';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_obtienedatoscelda_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_obtienedatoscelda_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10914;
         sv_mens_retorno := 'Error al intentar obtener datos celda';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_obtienedatoscelda_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_obtienedatoscelda_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_obtienedatoscelda_pr;

   PROCEDURE ve_listadoceldas_pr (
      ev_codregion      IN              ge_regiones.cod_region%TYPE,
      ev_codprovincia   IN              ge_provincias.cod_provincia%TYPE,
      ev_codciudad      IN              ge_ciudades.cod_provincia%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentación TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_listadoceldas_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="21-03-2007"
                                                                Versión="1.0.0"
                                                                Diseñador="Roberto Pérez Varas"
                                                                Programador="Roberto Pérez Varas"
                                                                Ambiente="BD"
                                                             <Retorno>Listado de celdas</Retorno>
                                                             <Descripción>
                                                                Listado de celdas
                                                             </Descripción>
                                                             <Parametros>
                                                             <Entrada>
                                                                  <param nom="EV_codregion" Tipo="VARCHAR2">codigo region</param>
                                                                  <param nom="EV_codprovincia" Tipo="VARCHAR2">codigo provincia</param>
                                                                  <param nom="EV_codciudad" Tipo="VARCHAR2">codigo ciudad</param>
                                                             </Entrada>
                                                             <Salida>
                                                                  <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con celdas</param>
                                                                  <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                  <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                  <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql :=
         'SELECT celda.cod_celda, celda.des_celda, celda.cod_subalm, celda.cod_subalm2' || ' FROM ge_celdas celda, ge_ciudades ciudades, ge_ciuceldas_td relciudadcelda' || ' WHERE ciudades.cod_region = relciudadcelda.cod_region'
         || ' AND ciudades.cod_provincia = relciudadcelda.cod_provincia' || ' AND ciudades.cod_ciudad = relciudadcelda.cod_ciudad' || ' AND ciudades.cod_region = ' || ev_codregion || ' AND ciudades.cod_provincia = ' || ev_codprovincia
         || ' AND ciudades.cod_ciudad = ' || ev_codciudad || ' ORDER BY celda.des_celda';

      SELECT COUNT (1)
        INTO ln_count
        FROM ge_celdas celda, ge_ciudades ciudades, ge_ciuceldas_td relciudadcelda
       WHERE ciudades.cod_region = relciudadcelda.cod_region
         AND ciudades.cod_provincia = relciudadcelda.cod_provincia
         AND ciudades.cod_ciudad = relciudadcelda.cod_ciudad
         AND ciudades.cod_region = ev_codregion
         AND ciudades.cod_provincia = ev_codprovincia
         AND ciudades.cod_ciudad = ev_codciudad
         AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT   celda.cod_celda, celda.des_celda, celda.cod_subalm, celda.cod_subalm2
             FROM ge_celdas celda, ge_ciudades ciudades, ge_ciuceldas_td relciudadcelda
            WHERE ciudades.cod_region = relciudadcelda.cod_region
              AND ciudades.cod_provincia = relciudadcelda.cod_provincia
              AND ciudades.cod_ciudad = relciudadcelda.cod_ciudad
              AND ciudades.cod_region = ev_codregion
              AND ciudades.cod_provincia = ev_codprovincia
              AND ciudades.cod_ciudad = ev_codciudad
         ORDER BY celda.des_celda;

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno  := 10793;
         sv_mens_retorno :='Error no se encontraron datos de Celdas';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_listadoceldas_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_listadoceldas_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10915;
         sv_mens_retorno := 'Error al intentar obtener listado de celdas';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_listadoceldas_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_listadoceldas_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10915;
         sv_mens_retorno := 'Error al intentar obtener listado de celdas';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_listadoceldas_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_listadoceldas_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_listadoceldas_pr;

   PROCEDURE ve_listadocentrales_pr (
      ev_codsubalm      IN              ta_subcentral.cod_subalm%TYPE,
      en_codproducto    IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentación TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_listadocentrales_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="21-03-2007"
                                                                Versión="1.0.0"
                                                                Diseñador="Roberto Pérez Varas"
                                                                Programador="Roberto Pérez Varas"
                                                                Ambiente="BD"
                                                             <Retorno>Listado de centrales</Retorno>
                                                             <Descripción>
                                                                Listado de centrales
                                                             </Descripción>
                                                             <Parametros>
                                                             <Entrada>
                                                                  <param nom="EV_codregion" Tipo="VARCHAR2">codigo subalmimentador</param>
                                                                  <param nom="EN_codprovincia" Tipo="NUMBER">codigo producto</param>
                                                             </Entrada>
                                                             <Salida>
                                                                  <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con centrales</param>
                                                                  <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                  <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                  <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql :=
         'SELECT central.cod_central, central.nom_central' || ' FROM icg_central central, ta_subcentral subcentral' || ' WHERE subcentral.cod_subalm = ' || ev_codsubalm || ' AND central.cod_producto = ' || en_codproducto
         || ' AND central.cod_central = subcentral.cod_central' || ' ORDER BY central.nom_central';

      SELECT COUNT (1)
        INTO ln_count
        FROM icg_central central, ta_subcentral subcentral
       WHERE subcentral.cod_subalm = ev_codsubalm
         AND central.cod_producto = en_codproducto
         AND central.cod_central = subcentral.cod_central
         AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT   central.cod_central, central.nom_central
             FROM icg_central central, ta_subcentral subcentral
            WHERE subcentral.cod_subalm = ev_codsubalm
              AND central.cod_producto = en_codproducto
              AND central.cod_central = subcentral.cod_central
         ORDER BY central.nom_central;

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno  := 10794;
         sv_mens_retorno := 'Error no se encontraron datos de Centrales';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_listadocentrales_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_listadocentrales_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10916;
         sv_mens_retorno := 'Error al intentar obtener listado de centrales';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_listadocentrales_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_listadocentrales_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10916;
         sv_mens_retorno := 'Error al intentar obtenet listado de centrales';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_listadocentrales_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_listadocentrales_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_listadocentrales_pr;

   PROCEDURE ve_plan_comercial_cliente_pr (
      en_cod_cliente    IN              ga_cliente_pcom.cod_cliente%TYPE,
      sn_cod_plancom    OUT NOCOPY      ga_cliente_pcom.cod_plancom%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
        <Documentación TipoDoc = "Procedimiento">
           Elemento Nombre = "VE_plan_comercial_cliente_PR
           Lenguaje="PL/SQL"
           Fecha="23-04-2007"
           Versión="1.0.0"
           Diseñador="Héctor Hermosilla"
           Programador="Héctor Hermosilla"
           Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripción>
            Obtiene plan comercial asociado al cliente
        </Descripción>
        <Parametros>
        <Entrada>
              <param nom="EN_cod_cliente"    Tipo="NUMBER"> codigo cliente </param>
        </Entrada>
        <Salida>
                  <param nom="SN_cod_plancom" Tipo="NUMBER"> codigo plan comercial</param>
              <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
              <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
              <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

        </Salida>
        </Parametros>
        </Elemento>
        </Documentación>
        --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT plancomcliente.cod_plancom' || ' FROM ga_cliente_pcom plancomcliente' || ' WHERE plancomcliente.cod_cliente =' || en_cod_cliente || ' AND SYSDATE BETWEEN fec_desde AND NVL(fec_hasta, SYSDATE)';

      SELECT plancomcliente.cod_plancom
        INTO sn_cod_plancom
        FROM ga_cliente_pcom plancomcliente
       WHERE plancomcliente.cod_cliente = en_cod_cliente
         AND SYSDATE BETWEEN fec_desde AND NVL (fec_hasta, SYSDATE);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10917;
         sv_mens_retorno := 'Error al intentar obtener el plan comercial asociado al cliente';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_plan_comercial_cliente_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_plan_comercial_cliente_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10917;
         sv_mens_retorno := 'Error al intentar obtener el plan comercial asociado al cliente';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_plan_comercial_cliente_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_plan_comercial_cliente_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_plan_comercial_cliente_pr;

   FUNCTION ve_validausuariovendedor_fn (
      en_codvendedor    IN              ve_vendedores.cod_vendedor%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN
                    /*--
                    <Documentación TipoDoc = "Function">
                       Elemento Nombre = "VE_validausuariovendedor_FN"
                       Lenguaje="PL/SQL"
                       Fecha="21-03-2007"
                       Versión="1.0.0"
                       Diseñador="Roberto Pérez Varas"
                       Programador="Roberto Pérez Varas"
                       Ambiente="BD"
                    <Retorno>Valida Usuario Vendedor</Retorno>
                    <Descripción>
                       Valida Usuario Vendedor
                    </Descripción>
                    <Parametros>
                    <Entrada>
                         <param nom="EN_codvendedor" Tipo="NUMBER">codigo vendedor</param>
                    </Entrada>
                    <Salida>
                         <param nom="SALIDA"  Tipo="BOOLEAN">Validacion Usuario Vendedor</param>
                         <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                         <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                         <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                    </Salida>
                    </Parametros>
                    </Elemento>
                    </Documentación>
                    */
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
      lv_count       VARCHAR2 (1);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT ' || '''1''' || ' FROM ge_seg_usuario usuarios' || ' WHERE usuarios.cod_vendedor = ' || en_codvendedor || ' AND ROWNUM = 1';

      SELECT '1'
        INTO lv_count
        FROM ge_seg_usuario usuarios
       WHERE usuarios.cod_vendedor = en_codvendedor
         AND ROWNUM = 1;

      IF lv_count = '1' THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10795;
         sv_mens_retorno := 'Error al validar Usuario Vendedor';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_validausuariovendedor_FN();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_validausuariovendedor_FN()', lv_sql, SQLCODE, lv_des_error);
         RETURN FALSE;

      WHEN OTHERS THEN
         sn_cod_retorno  := 10795;
         sv_mens_retorno := 'Error al validar Usuario Vendedor';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_validausuariovendedor_FN();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_validausuariovendedor_FN()', lv_sql, SQLCODE, lv_des_error);
         RETURN FALSE;
   END ve_validausuariovendedor_fn;

   FUNCTION ve_validapermisousuario_fn (
      ev_nomusuario     IN              ge_seg_usuario.nom_usuario%TYPE,
      ev_cod_proceso    IN              gad_procesos_perfiles.cod_proceso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN
                    /*--
                    <Documentación TipoDoc = "Function">
                       Elemento Nombre = "VE_validapermisousuario_FN"
                       Lenguaje="PL/SQL"
                       Fecha="21-03-2007"
                       Versión="1.0.0"
                       Diseñador="Roberto Pérez Varas"
                       Programador="Roberto Pérez Varas"
                       Ambiente="BD"
                    <Retorno>Valida Permiso Usuario</Retorno>
                    <Descripción>
                       Valida Permiso Usuario
                    </Descripción>
                    <Parametros>
                    <Entrada>
                         <param nom="EV_nomusuario" Tipo="VARCHAR2">Nombre Usuario</param>
                         <param nom="EV_cod_proceso" Tipo="VARCHAR2">codigo proceso</param>
                    </Entrada>
                    <Salida>
                         <param nom="SALIDA"  Tipo="BOOLEAN">Validacion Permiso Usuario</param>
                         <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                         <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                         <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                    </Salida>
                    </Parametros>
                    </Elemento>
                    </Documentación>
                    */
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
      lv_count       VARCHAR2 (1);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql :=
         'SELECT ' || '''1''' || ' FROM ge_seg_perfiles perfiles, ge_seg_grpusuario grupo_usuario' || ' WHERE perfiles.cod_grupo = grupo_usuario.cod_grupo' || ' AND grupo_usuario.nom_usuario = ' || ev_nomusuario || ' AND perfiles.cod_proceso = '
         || ev_cod_proceso || ' AND ROWNUM = 1';

      SELECT '1'
        INTO lv_count
        FROM ge_seg_perfiles perfiles, ge_seg_grpusuario grupo_usuario
       WHERE perfiles.cod_grupo = grupo_usuario.cod_grupo
         AND grupo_usuario.nom_usuario = ev_nomusuario
         AND perfiles.cod_proceso = ev_cod_proceso
         AND ROWNUM = 1;

      IF lv_count = '1' THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10297;
         sv_mens_retorno :='Problemas al consultar permisos de usuario';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_validapermisousuario_FN();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_validapermisousuario_FN()', lv_sql, SQLCODE, lv_des_error);
         RETURN FALSE;

      WHEN OTHERS THEN
         sn_cod_retorno  := 10297;
         sv_mens_retorno :='Problemas al consultar permisos de usuario';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_validapermisousuario_FN();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_validapermisousuario_FN()', lv_sql, SQLCODE, lv_des_error);
         RETURN FALSE;
   END ve_validapermisousuario_fn;

   FUNCTION ve_validapermisovendedor_fn (
      en_codvendedor    IN              ve_vendedores.cod_vendedor%TYPE,
      ev_cod_proceso    IN              gad_procesos_perfiles.cod_proceso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN
                    /*--
                    <Documentación TipoDoc = "Function">
                       Elemento Nombre = "VE_validapermisovendedor_FN"
                       Lenguaje="PL/SQL"
                       Fecha="21-03-2007"
                       Versión="1.0.0"
                       Diseñador="Roberto Pérez Varas"
                       Programador="Roberto Pérez Varas"
                       Ambiente="BD"
                    <Retorno>Valida Permiso Vendedor</Retorno>
                    <Descripción>
                       Valida Permiso Vendedor
                    </Descripción>
                    <Parametros>
                    <Entrada>
                         <param nom="EN_codvendedor" Tipo="VARCHAR2">codigo vendedor</param>
                         <param nom="EV_cod_proceso" Tipo="VARCHAR2">codigo proceso</param>
                    </Entrada>
                    <Salida>
                         <param nom="SALIDA"  Tipo="BOOLEAN">Validacion Permiso Vendedor</param>
                         <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                         <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                         <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                    </Salida>
                    </Parametros>
                    </Elemento>
                    </Documentación>
                    */
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
      lv_count       VARCHAR2 (1);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql :=
         'SELECT ' || '''1''' || ' FROM ge_seg_perfiles perfiles, ge_seg_grpusuario grupo_usuario,' || ' ge_seg_usuario usuario' || ' WHERE perfiles.cod_grupo = grupo_usuario.cod_grupo' || ' AND grupo_usuario.nom_usuario =usuario.nom_usuario'
         || ' AND usuario.cod_vendedor = ' || en_codvendedor || ' AND perfiles.cod_proceso = ' || ev_cod_proceso || ' AND ROWNUM = 1';

      SELECT '1'
        INTO lv_count
        FROM ge_seg_perfiles perfiles, ge_seg_grpusuario grupo_usuario, ge_seg_usuario usuario
       WHERE perfiles.cod_grupo = grupo_usuario.cod_grupo
         AND grupo_usuario.nom_usuario = usuario.nom_usuario
         AND usuario.cod_vendedor = en_codvendedor
         AND perfiles.cod_proceso = ev_cod_proceso
         AND ROWNUM = 1;

      IF lv_count = '1' THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10796;
         sv_mens_retorno := 'Error al validar Permiso Vendedor';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_validapermisovendedor_FN();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_validapermisovendedor_FN()', lv_sql, SQLCODE, lv_des_error);
         RETURN FALSE;

      WHEN OTHERS THEN
         sn_cod_retorno  := 10796;
         sv_mens_retorno := 'Error al validar Permiso Vendedor';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_validapermisovendedor_FN();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_validapermisovendedor_FN()', lv_sql, SQLCODE, lv_des_error);
         RETURN FALSE;
   END ve_validapermisovendedor_fn;

   PROCEDURE ve_consulta_datos_usuario_pr (
      ev_nom_usuario      IN              VARCHAR2,
      sv_codigo_oficina   OUT NOCOPY      ge_seg_usuario.cod_oficina%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*

       <Documentación TipoDoc = "Procedimiento">
          Elemento Nombre = "VE_consulta_datos_usuario_PR"
          Lenguaje="PL/SQL"
          Fecha="02-05-2007"
          Versión="1.0.0"
          Diseñador="Héctor Hermosilla"
          Programador="Héctor Hermosilla"
          Ambiente="BD"
       <Retorno> NA </Retorno>
       <Descripción>
          Consulta los datos del usuario.
       </Descripción>
       <Parametros>
       <Entrada>
             <param nom="EV_nom_usuario" Tipo="VARCHAR2"> nombre del usuario </param>

       </Entrada>
       <Salida>
             <param nom="SV_codigo_oficina" Tipo="VARCHAR2> código oficina del usuario</param>
             <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
             <param nom="SV_mens_retorno"   Tipo="VARCHAR2"> glosa mensaje error </param>
             <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>

       </Salida>
       </Parametros>
       </Elemento>
       </Documentación>
       */
      lv_resultado   VARCHAR2 (1);
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
      ln_count       NUMBER (1);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT usuario.cod_oficina' || ' FROM ge_seg_usuario usuario' || ' WHERE usuario.nom_usuario = UPPER(' || ev_nom_usuario || ')';

      SELECT usuario.cod_oficina
        INTO sv_codigo_oficina
        FROM ge_seg_usuario usuario
       WHERE usuario.nom_usuario = UPPER (ev_nom_usuario);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10797;
         sv_mens_retorno :='Error al Consultar datos de usuario';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_consulta_datos_usuario_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_consulta_datos_usuario_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10797;
         sv_mens_retorno :='Error al Consultar datos de usuario';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_consulta_datos_usuario_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_consulta_datos_usuario_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_datos_usuario_pr;

   PROCEDURE ve_con_oficina_pr (
      ev_cod_oficina     IN              VARCHAR2,
      sv_des_oficina     OUT NOCOPY      VARCHAR2,
      sv_cod_direccion   OUT NOCOPY      VARCHAR2,
      sv_des_region      OUT NOCOPY      VARCHAR2,
      sv_des_provincia   OUT NOCOPY      VARCHAR2,
      sv_des_ciudad      OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*

       <Documentación TipoDoc = "Procedimiento">
          Elemento Nombre = "VE_con_oficina_PR"
          Lenguaje="PL/SQL"
          Fecha="02-10-2007"
          Versión="1.0.0"
          Diseñador="Héctor Hermosilla"
          Programador="Héctor Hermosilla"
          Ambiente="BD"
       <Retorno> NA </Retorno>
       <Descripción>
          Consulta los datos de la oficina
       </Descripción>
       <Parametros>
       <Entrada>
             <param nom="EV_cod_oficina" Tipo="VARCHAR2"> codigo de la oficina </param>

       </Entrada>
       <Salida>
             <param nom="SV_des_oficina"    Tipo="VARCHAR2"> descripcion de la oficina</param>
             <param nom="SV_cod_direccion"  Tipo="VARCHAR2"> codigo de la direccion</param>
             <param nom="SV_des_region"     Tipo="VARCHAR2"> region de la oficina</param>
             <param nom="SV_des_provincia"  Tipo="VARCHAR2"> provincia de la oficina</param>
             <param nom="SV_des_ciudad"     Tipo="VARCHAR2"> ciudad de la oficina</param>
             <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
             <param nom="SV_mens_retorno"   Tipo="VARCHAR2"> glosa mensaje error </param>
             <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>

       </Salida>
       </Parametros>
       </Elemento>
       </Documentación>
       */
      lv_resultado   VARCHAR2 (1);
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
      ln_count       NUMBER (1);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql :=
         'SELECT ofi.des_oficina, ofi.cod_direccion,' || ' reg.des_region, prov.des_provincia,' || ' ciu.des_ciudad' || ' FROM   ge_oficinas ofi, ge_direcciones dir,' || ' ge_regiones reg, ge_provincias prov,' || ' ge_ciudades ciu'
         || ' WHERE  oficina.cod_oficina =''' || ev_cod_oficina || '''' || ' AND    oficina.cod_direccion = dir.cod_direccion' || ' AND    reg.cod_region = dir.cod_region' || ' AND    prov.cod_provincia = dir.cod_provincia'
         || ' AND    prov.cod_region = dir.cod_region' || ' AND    ciu.cod_region = dir.cod_region' || ' AND    ciu.cod_provincia = dir.cod_provincia' || ' AND    ciu.cod_ciudad = dir.cod_ciudad';

      SELECT ofi.des_oficina, ofi.cod_direccion, reg.des_region, prov.des_provincia, ciu.des_ciudad
        INTO sv_des_oficina, sv_cod_direccion, sv_des_region, sv_des_provincia, sv_des_ciudad
        FROM ge_oficinas ofi, ge_direcciones dir, ge_regiones reg, ge_provincias prov, ge_ciudades ciu
       WHERE ofi.cod_oficina = ev_cod_oficina
         AND ofi.cod_direccion = dir.cod_direccion
         AND reg.cod_region = dir.cod_region
         AND prov.cod_provincia = dir.cod_provincia
         AND prov.cod_region = dir.cod_region
         AND ciu.cod_region = dir.cod_region
         AND ciu.cod_provincia = dir.cod_provincia
         AND ciu.cod_ciudad = dir.cod_ciudad;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10798;
         sv_mens_retorno := 'Error al consultar datos de la oficina';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_con_oficina_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_con_oficina_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10798;
         sv_mens_retorno := 'Error al consultar datos de la oficina';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_con_oficina_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_con_oficina_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_con_oficina_pr;

   PROCEDURE ve_con_oficina_pr (
      ev_cod_oficina     IN              VARCHAR2,
      sv_des_oficina     OUT NOCOPY      VARCHAR2,
      sv_cod_direccion   OUT NOCOPY      VARCHAR2,
      sv_des_region      OUT NOCOPY      VARCHAR2,
      sv_des_provincia   OUT NOCOPY      VARCHAR2,
      sv_des_ciudad      OUT NOCOPY      VARCHAR2,
      sv_cod_region      OUT NOCOPY      VARCHAR2,
      sv_cod_provincia   OUT NOCOPY      VARCHAR2,
      sv_cod_ciudad      OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*

       <Documentación TipoDoc = "Procedimiento">
          Elemento Nombre = "VE_con_oficina_PR"
          Lenguaje="PL/SQL"
          Fecha="02-10-2007"
          Versión="1.0.0"
          Diseñador="Héctor Hermosilla"
          Programador="Héctor Hermosilla"
          Ambiente="BD"
       <Retorno> NA </Retorno>
       <Descripción>
          Consulta los datos de la oficina
       </Descripción>
       <Parametros>
       <Entrada>
             <param nom="EV_cod_oficina" Tipo="VARCHAR2"> codigo de la oficina </param>

       </Entrada>
       <Salida>
             <param nom="SV_des_oficina"    Tipo="VARCHAR2"> descripcion de la oficina</param>
             <param nom="SV_cod_direccion"  Tipo="VARCHAR2"> codigo de la direccion</param>
             <param nom="SV_des_region"     Tipo="VARCHAR2"> region de la oficina</param>
             <param nom="SV_des_provincia"  Tipo="VARCHAR2"> provincia de la oficina</param>
             <param nom="SV_des_ciudad"     Tipo="VARCHAR2"> ciudad de la oficina</param>
             <param nom="SV_cod_region"     Tipo="VARCHAR2"> codigo region de la oficina</param>
             <param nom="SV_cod_provincia"  Tipo="VARCHAR2"> codigo provincia de la oficina</param>
             <param nom="SV_cod_ciudad"     Tipo="VARCHAR2"> codigo ciudad de la oficina</param>
             <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
             <param nom="SV_mens_retorno"   Tipo="VARCHAR2"> glosa mensaje error </param>
             <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>

       </Salida>
       </Parametros>
       </Elemento>
       </Documentación>
       */
      lv_resultado   VARCHAR2 (1);
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
      ln_count       NUMBER (1);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql :=
         'SELECT ofi.des_oficina, ofi.cod_direccion,' || ' reg.des_region, prov.des_provincia,' || ' ciu.des_ciudad, ciu.cod_region,' || ' ciu.cod_provincia, ciu.cod_ciudad' || ' ciu.des_ciudad' || ' FROM   ge_oficinas ofi, ge_direcciones dir,'
         || ' ge_regiones reg, ge_provincias prov,' || ' ge_ciudades ciu' || ' WHERE  oficina.cod_oficina =''' || ev_cod_oficina || '''' || ' AND    oficina.cod_direccion = dir.cod_direccion' || ' AND    reg.cod_region = dir.cod_region'
         || ' AND    prov.cod_provincia = dir.cod_provincia' || ' AND    prov.cod_region = dir.cod_region' || ' AND    ciu.cod_region = dir.cod_region' || ' AND    ciu.cod_provincia = dir.cod_provincia' || ' AND    ciu.cod_ciudad = dir.cod_ciudad';

      SELECT ofi.des_oficina, ofi.cod_direccion, reg.des_region, prov.des_provincia, ciu.des_ciudad, ciu.cod_region, ciu.cod_provincia, ciu.cod_ciudad
        INTO sv_des_oficina, sv_cod_direccion, sv_des_region, sv_des_provincia, sv_des_ciudad, sv_cod_region, sv_cod_provincia, sv_cod_ciudad
        FROM ge_oficinas ofi, ge_direcciones dir, ge_regiones reg, ge_provincias prov, ge_ciudades ciu
       WHERE ofi.cod_oficina = ev_cod_oficina
         AND ofi.cod_direccion = dir.cod_direccion
         AND reg.cod_region = dir.cod_region
         AND prov.cod_provincia = dir.cod_provincia
         AND prov.cod_region = dir.cod_region
         AND ciu.cod_region = dir.cod_region
         AND ciu.cod_provincia = dir.cod_provincia
         AND ciu.cod_ciudad = dir.cod_ciudad;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10798;
         sv_mens_retorno := 'Error al consultar datos de la oficina';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_con_oficina_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_con_oficina_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10798;
         sv_mens_retorno := 'Error al consultar datos de la oficina';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_con_oficina_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_con_oficina_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_con_oficina_pr;

   PROCEDURE ve_celdaciudad_pr (
      ev_cod_region      IN              ge_regiones.cod_region%TYPE,
      ev_cod_provincia   IN              ge_provincias.cod_provincia%TYPE,
      ev_cod_ciudad      IN              ge_ciudades.cod_provincia%TYPE,
      sv_cod_celda       OUT NOCOPY      ge_ciudades.cod_celda%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*

       <Documentación TipoDoc = "Procedimiento">
          Elemento Nombre = "VE_celdaCiudad_PR"
          Lenguaje="PL/SQL"
          Fecha="16-10-2007"
          Versión="1.0.0"
          Diseñador="Héctor Hermosilla"
          Programador="Héctor Hermosilla"
          Ambiente="BD"
       <Retorno> NA </Retorno>
       <Descripción>
                    OBTIENE LA CELDA ASOCIADA A LA CIUDAD INFORMADA
       </Descripción>
       <Parametros>
       <Entrada>
             <param nom="EV_cod_region"    Tipo="VARCHAR2"> codigo region de la ciudad </param>
             <param nom="EV_cod_provincia" Tipo="VARCHAR2"> codigo provincia de la ciudad </param>
             <param nom="EV_cod_ciudad"    Tipo="VARCHAR2"> codigo de la ciudad </param>

       </Entrada>
       <Salida>
             <param nom="SV_cod_celda"     Tipo="VARCHAR2"> codigo celda de la ciudad</param>
             <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
             <param nom="SV_mens_retorno"   Tipo="VARCHAR2"> glosa mensaje error </param>
             <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>

       </Salida>
       </Parametros>
       </Elemento>
       </Documentación>
       */
      lv_resultado   VARCHAR2 (1);
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
      ln_count       NUMBER (1);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql :=
         'SELECT a.cod_celda' || ' FROM ge_celdas a, ge_ciudades b' || ' WHERE a.cod_celda = b.cod_celda' || ' AND b.cod_region =''' || ev_cod_region || '''' || ' AND b.cod_provincia =''' || ev_cod_provincia || '''' || ' AND b.cod_ciudad = '''
         || ev_cod_ciudad || '''';

      SELECT a.cod_celda
        INTO sv_cod_celda
        FROM ge_celdas a, ge_ciudades b
       WHERE a.cod_celda = b.cod_celda
         AND b.cod_region = ev_cod_region
         AND b.cod_provincia = ev_cod_provincia
         AND b.cod_ciudad = ev_cod_ciudad;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10799;
         sv_mens_retorno := 'Error al Obtener Celda Asociada a la ciudad';
         lv_des_error    := 'NO_DATA_FOUND:ve_parametros_comer_quiosco_pg.VE_celdaCiudad_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_celdaCiudad_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10799;
         sv_mens_retorno := 'Error al Obtener Celda Asociada a la ciudad';
         lv_des_error    := 'OTHERS:ve_parametros_comer_quiosco_pg.VE_celdaCiudad_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 've_parametros_comer_quiosco_pg.VE_celdaCiudad_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_celdaciudad_pr;
END ve_parametros_comer_quiosco_pg;
/

SHOW ERRORS