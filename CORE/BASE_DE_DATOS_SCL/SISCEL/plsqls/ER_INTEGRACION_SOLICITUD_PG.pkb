CREATE OR REPLACE PACKAGE BODY er_integracion_solicitud_pg IS


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION er_obtiene_codigoEstFinal_fn (
      en_cod_respuesta_buro  IN             ert_datos_detalle_to.cod_respuesta_reg99%TYPE,
      en_cod_estado_final    OUT NOCOPY     ert_solicitud.cod_estadofinal%TYPE,
      sn_codretorno          OUT NOCOPY     ge_errores_pg.coderror,
      sv_menretorno          OUT NOCOPY     ge_errores_pg.msgerror,
      sn_numevento           OUT NOCOPY     ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
      lv_des_error           ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      d_fecha_actualizacion  ert_datos_consulta_to.fecha_actualizacion%TYPE;
          trama_no_vigente       EXCEPTION;
      LV_COD_CODIGO          ERD_PARAMETROS.COD_CODIGO%TYPE;
      LV_COD_SUBCODIGO       ERD_PARAMETROS.COD_SUBCODIGO%TYPE;
   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;
       LV_COD_CODIGO:='101';
       LV_COD_SUBCODIGO:='1';

          LV_sql:= 'SELECT cod_parametro'
            || ' FROM erd_parametros'
            || ' WHERE cod_codigo = '|| LV_COD_CODIGO
                || ' AND cod_subcodigo = '|| LV_COD_SUBCODIGO
                    || ' AND VAL_PARAMETRO2 = '|| EN_COD_RESPUESTA_BURO;

      SELECT cod_parametro
        INTO en_cod_estado_final
        FROM erd_parametros
       WHERE cod_codigo = lv_cod_codigo
         AND cod_subcodigo = lv_cod_subcodigo
         AND val_parametro2 = en_cod_respuesta_buro;

           RETURN TRUE;

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        EN_COD_ESTADO_FINAL := NULL;
            RETURN TRUE;

     WHEN OTHERS THEN
        sn_codretorno  := '494';
        sv_menretorno  := 'Error: al obtener codigo de estado final';
        lv_des_error   := 'er_integracion_solicitud_pg.er_valida_reg99_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_obtiene_codigoestfinal_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_obtiene_erd_parametros_fn (
      eo_erd_parametros IN OUT NOCOPY  ERD_PARAMETROS_OT,
      sn_codretorno     OUT NOCOPY     ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY     ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY     ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
      lv_des_error           ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      d_fecha_actualizacion  ert_datos_consulta_to.fecha_actualizacion%TYPE;
          trama_no_vigente       EXCEPTION;
   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

          LV_sql:= 'SELECT cod_codigo, cod_subcodigo, des_codigo, cod_parametro, ind_tipo_parametro,des_parametro1, des_parametro2, val_operador1, val_operador2, val_parametro1,val_parametro2, nom_usuario_modi, fec_modi_h'
            || ' FROM erd_parametros'
            || ' WHERE cod_codigo = '||eo_erd_parametros.cod_codigo
                || ' AND cod_subcodigo = '||eo_erd_parametros.cod_subcodigo
                    || ' AND cod_parametro = '||eo_erd_parametros.cod_parametro;

      SELECT cod_codigo, cod_subcodigo, des_codigo, cod_parametro, ind_tipo_parametro,
             des_parametro1, des_parametro2, val_operador1, val_operador2, val_parametro1,
             val_parametro2, nom_usuario_modi, fec_modi_h
        INTO eo_erd_parametros.cod_codigo, eo_erd_parametros.cod_subcodigo, eo_erd_parametros.des_codigo, eo_erd_parametros.cod_parametro, eo_erd_parametros.ind_tipo_parametro,
             eo_erd_parametros.des_parametro1, eo_erd_parametros.des_parametro2, eo_erd_parametros.val_operador1, eo_erd_parametros.val_operador2, eo_erd_parametros.val_parametro1,
             eo_erd_parametros.val_parametro2, eo_erd_parametros.nom_usuario_modi, eo_erd_parametros.fec_modi_h
        FROM erd_parametros
       WHERE cod_codigo = eo_erd_parametros.cod_codigo
             AND cod_subcodigo = eo_erd_parametros.cod_subcodigo
                 AND cod_parametro = eo_erd_parametros.cod_parametro;

           RETURN TRUE;

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        sn_codretorno  := '495';
        sv_menretorno  := 'Error: el parametro no existe';
        lv_des_error   := 'er_integracion_solicitud_pg.er_obtiene_erd_parametros_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
                RETURN FALSE;

     WHEN OTHERS THEN
        sn_codretorno  := '496';
        sv_menretorno  := 'Error: no determinado al recueprar parametro';
        lv_des_error   := 'er_integracion_solicitud_pg.er_obtiene_erd_parametros_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
                RETURN FALSE;
   END er_obtiene_erd_parametros_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_obtiene_valor_parametro_fn (
      ev_nomparametro   IN         ged_parametros.nom_parametro%TYPE,
      ev_codmodulo      IN         ged_parametros.cod_modulo%TYPE,
      ev_codproducto    IN         ged_parametros.cod_producto%TYPE,
      sv_valparametro   OUT NOCOPY ged_parametros.val_parametro%TYPE,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
      lv_des_error           ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      d_fecha_actualizacion  ert_datos_consulta_to.fecha_actualizacion%TYPE;
          trama_no_vigente       EXCEPTION;
   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

       LV_Sql := 'SELECT a.val_parametro '
              || 'FROM ged_parametros a '
              || 'WHERE a.nom_parametro = ' || EV_nomparametro
              || ' AND a.cod_modulo = ' || EV_codmodulo
              || ' AND a.cod_producto = ' || EV_codproducto;

       SELECT a.val_parametro
         INTO SV_valparametro
         FROM ged_parametros a
        WHERE a.nom_parametro  = EV_nomparametro
          AND a.cod_modulo     = EV_codmodulo
          AND a.cod_producto   = EV_codproducto;

           RETURN TRUE;

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        sn_codretorno  := '497';
        sv_menretorno  := 'Error: el parametro no existe';
        lv_des_error   := 'er_integracion_solicitud_pg.er_obtiene_valor_parametro_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;

     WHEN OTHERS THEN
        sn_codretorno  := '498';
        sv_menretorno  := 'Error: no determinado al recueprar parametro';
        lv_des_error   := 'er_integracion_solicitud_pg.er_obtiene_valor_parametro_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_obtiene_valor_parametro_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE er_actualiza_preevaluacion_pr (
      ev_num_solicitud   IN              ert_solicitud.num_solicitud%TYPE,
      ev_cod_plantarif   IN              ert_solicitud_planes.cod_plantarif%TYPE,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento
   )
   IS
       lv_des_error    ge_errores_pg.desevent;
       lv_sql          ge_errores_pg.vquery;

       ln_estado_preevaluacion    ert_solicitud.cod_estado%TYPE;
           lv_tipident_cliente        ert_solicitud.cod_tipident%TYPE;
       lv_numident_cliente        ert_solicitud.num_ident_cliente%TYPE;
       lv_count                   NUMBER(3);
       error_ejecucion            EXCEPTION;
       error_evaluacion_vigente   EXCEPTION;

          o_erd_parametros                       erd_parametros_ot := NEW erd_parametros_ot();

   BEGIN
       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;


       /**1.- Obtener Parametro con estado valido para la Preevaluacion*/
       o_erd_parametros.cod_codigo := 100;
           o_erd_parametros.cod_subcodigo := 6;
       o_erd_parametros.cod_parametro := 10;
       IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_codretorno,sv_menretorno,sn_numevento)) THEN
          RAISE error_ejecucion;
           END IF;

       /**2.- Obtengo Datos de la Preevaluacion Vigente */

       lv_sql := 'SELECT cod_tipident, num_ident_cliente FROM ert_solicitud'
              || ' WHERE num_solicitud = '||ev_num_solicitud
              || ' AND cod_estado = '||ln_estado_preevaluacion;

       SELECT cod_tipident, num_ident_cliente
         INTO lv_tipident_cliente, lv_numident_cliente
         FROM ert_solicitud
        WHERE num_solicitud = ev_num_solicitud
          AND cod_estado = ln_estado_preevaluacion;

       /**3.- Verifico si el Numero y Tipo de identificacion tienen otras solicitudes de evaluacion
       de riesgo*/

       lv_sql := 'SELECT COUNT (1) FROM ert_solicitud'
              || ' WHERE num_ident_cliente = '||lv_numident_cliente
              || ' AND cod_tipident = '||lv_tipident_cliente
              || ' AND cod_estado IN (1, 2)';

       LV_COUNT:=0;

       SELECT COUNT (1)
         INTO lv_count
         FROM ert_solicitud
        WHERE num_ident_cliente = lv_numident_cliente
          AND cod_tipident = lv_tipident_cliente
          AND cod_estado IN (1, 2);

       IF lv_count > 0 THEN
          RAISE error_evaluacion_vigente;
       ELSE
          /**4.- Si no hay solicitudes de Evaluacion de Riesgo activas entonces se inicia el proceso
          para dejar activa la preevaluacion*/

          /**4.1 Se borra de la tabla ERT_SOLICITUD_PLANES todos los planes a excepcion del elegido*/

       lv_sql := 'DELETE ert_solicitud_planes'
              || ' WHERE num_solicitud = '||ev_num_solicitud
              || ' AND cod_plantarif <> '||ev_cod_plantarif;

          DELETE ert_solicitud_planes
           WHERE num_solicitud = ev_num_solicitud
             AND cod_plantarif <> ev_cod_plantarif;

          /**4.2 Se actualiza el estado de la preevaluacion*/

       lv_sql := 'UPDATE ert_solicitud SET cod_estado = 1'
              || ' WHERE num_solicitud = '||ev_num_solicitud
                      || ' AND cod_estado = '||ln_estado_preevaluacion;

          UPDATE ert_solicitud
             SET cod_estado = 1
           WHERE num_solicitud = ev_num_solicitud
                     AND cod_estado = ln_estado_preevaluacion;

       END IF;

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        sn_codretorno  := '499';
        sv_menretorno  := 'Error: al actualizar solicitud de evaluacion';
        lv_des_error   := 'er_integracion_solicitud_pg.er_valida_reg99_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
    WHEN error_evaluacion_vigente THEN
        sn_codretorno  := '500';
        sv_menretorno  := 'Error: existe evalacuacion';
        lv_des_error   := 'er_integracion_solicitud_pg.er_valida_reg99_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
     WHEN error_ejecucion THEN
        lv_des_error   := 'er_integracion_solicitud_pg.er_valida_reg99_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
     WHEN OTHERS THEN
        sn_codretorno  := '501';
        sv_menretorno  := 'Error: no determinado al actualizar evaluacion';
        lv_des_error   := 'er_integracion_solicitud_pg.er_valida_reg99_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
   END er_actualiza_preevaluacion_pr;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_ins_solicitudplanes_fn (
      en_num_solicitud   IN              ert_solicitud.num_solicitud%TYPE,
      ev_cod_plantarif   IN              ert_solicitud_planes.cod_plantarif%TYPE,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;

   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

       LV_sql := 'INSERT INTO ert_solicitud_planes (num_solicitud, cod_plantarif, val_cant_terminales, val_cant_vendidos, ind_venta)'
              || ' VALUES ('||en_num_solicitud||', '||ev_cod_plantarif||', 1, 0, 0)';

       INSERT INTO ert_solicitud_planes
                   (num_solicitud, cod_plantarif, val_cant_terminales, val_cant_vendidos, ind_venta)
            VALUES (en_num_solicitud, ev_cod_plantarif, 1, 0, 0);

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        sn_codretorno  := '502';
        sv_menretorno  := 'Error: no determinado al registra planes';
        lv_des_error   := 'er_integracion_solicitud_pg.er_valida_reg99_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
                RETURN FALSE;
   END er_ins_solicitudplanes_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_ins_solicitudcampos_pr (
      en_num_solicitud    IN              ert_solicitud_campos.num_solicitud%TYPE,
      ev_ind_personeria   IN              ert_solicitud_campos.ind_personeria%TYPE,
      ev_nombre_cliente   IN              ert_solicitud_campos.nombre_cliente%TYPE,
      ev_apellido1        IN              ert_solicitud_campos.primer_apellido%TYPE,
      ev_apellido2        IN              ert_solicitud_campos.segundo_apellido%TYPE,
      en_mtos_impagos     IN              ert_solicitud_campos.mto_impagos%TYPE,
      ev_des_nombre       IN              ert_solicitud_campos.des_nombre%TYPE,
      ev_des_comuna       IN              ert_solicitud_campos.des_comuna%TYPE,
      ev_des_ciudad       IN              ert_solicitud_campos.des_ciudad%TYPE,
      ev_cod_tipident     IN              ert_solicitud_campos.cod_tipident%TYPE,
      ev_num_ident        IN              ert_solicitud_campos.num_ident%TYPE,
      sn_codretorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento        OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS

       lv_des_error           ge_errores_pg.desevent;
       lv_sql                 ge_errores_pg.vquery;

   BEGIN
       SN_codRetorno := 0;
       SV_menRetorno := NULL;
       SN_numEvento  := 0;

       lv_sql := 'INSERT INTO ert_solicitud_campos (num_solicitud, ind_personeria, nombre_cliente, primer_apellido, segundo_apellido, mto_impagos, des_nombre, des_comuna, des_ciudad, cod_tipident, num_ident)'
              || 'VALUES ('||en_num_solicitud||', '||ev_ind_personeria||', '||ev_nombre_cliente||', '||ev_apellido1||', '||ev_apellido2||', '||en_mtos_impagos||', '||ev_des_nombre||', '||ev_des_comuna||', '||ev_des_ciudad||', '||ev_cod_tipident||', '||ev_num_ident||')';

       INSERT INTO ert_solicitud_campos
                   (num_solicitud, ind_personeria, nombre_cliente, primer_apellido, segundo_apellido, mto_impagos, des_nombre, des_comuna, des_ciudad, cod_tipident, num_ident)
            VALUES (en_num_solicitud, ev_ind_personeria, ev_nombre_cliente, ev_apellido1, ev_apellido2, en_mtos_impagos, ev_des_nombre, ev_des_comuna, ev_des_ciudad, ev_cod_tipident, ev_num_ident);

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        sn_codretorno  := '503';
        sv_menretorno  := 'Error: no determinado al registrar solicitud campos';
        lv_des_error   := 'er_integracion_solicitud_pg.er_valida_reg99_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END ER_INS_SolicitudCampos_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_ins_solicituddetcampo_pr (
      en_num_solicitud           IN              ert_solicitud_detcampo.num_solicitud%TYPE,
      ev_ind_tipo_documento      IN              ert_solicitud_detcampo.ind_tipo_documento%TYPE,
      ev_cod_moneda              IN              ged_parametros.val_parametro%TYPE,
      en_mto_deuda               IN              ert_solicitud_detcampo.mto_deuda%TYPE,
      ev_fec_vencimiento         IN              VARCHAR2,
      ev_des_librador            IN              ert_solicitud_detcampo.des_librador%TYPE,
      ev_des_causa_publicacion   IN              ert_solicitud_detcampo.des_causa_publicacion%TYPE,
      sn_codretorno              OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno              OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento               OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN

   IS
       lv_des_error           ge_errores_pg.desevent;
       lv_sql                 ge_errores_pg.vquery;
   BEGIN
       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

       lv_sql := 'INSERT INTO ert_solicitud_detcampo (num_solicitud, ind_tipo_documento, cod_moneda, mto_deuda, fec_vencimiento, des_librador, des_causa_publicacion)'
              || ' VALUES ('||en_num_solicitud||', '||ev_ind_tipo_documento||', '||ev_cod_moneda||', '||en_mto_deuda||', '||ev_fec_vencimiento||', '||ev_des_librador||', '||ev_des_causa_publicacion||')';

       INSERT INTO ert_solicitud_detcampo
                   (num_solicitud, ind_tipo_documento, cod_moneda, mto_deuda, fec_vencimiento, des_librador, des_causa_publicacion)
            VALUES (en_num_solicitud, ev_ind_tipo_documento, ev_cod_moneda, en_mto_deuda, TO_DATE(ev_fec_vencimiento,'YYYYMMDD'), ev_des_librador, ev_des_causa_publicacion);

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        sn_codretorno  := '504';
        sv_menretorno  := 'Error: no determinado al registrar detalle de campos de solicitud';
        lv_des_error   := 'er_integracion_solicitud_pgg.er_valida_reg99_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END ER_INS_SolicitudDetCampo_PR;
-------------------------------------------------------------------------------------------------------------
   FUNCTION er_ins_solicitud_fn (
      en_num_solicitud            IN              ert_solicitud.num_solicitud%TYPE,
      ev_ind_tipo_cliente         IN              ert_solicitud.ind_tipo_cliente%TYPE,
      ev_cod_esquema              IN              ert_solicitud.cod_esquema%TYPE,
      ev_ind_personeria           IN              ert_solicitud.ind_personeria%TYPE,
      ev_cod_usuario_evaluacion   IN              ert_solicitud.cod_usuario_evaluacion%TYPE,
      ev_cod_vendedor             IN              ert_solicitud.cod_vendedor%TYPE,
      ev_cod_tipident             IN              ert_solicitud.cod_tipident%TYPE,
      ev_num_ident_cliente        IN              ert_solicitud.num_ident_cliente%TYPE,
      ev_cod_puntaje              IN              ert_solicitud.cod_puntaje%TYPE,
      ev_cod_calificacion         IN              ert_solicitud.cod_calificacion%TYPE,
      ev_cod_tipcomis             IN              ert_solicitud.cod_tipcomis%TYPE,
      ev_ind_tipo_solicitud       IN              ert_solicitud.ind_tipo_solicitud%TYPE,
      ev_cod_estado               IN              ert_solicitud.cod_estado%TYPE,
      ev_cod_vendealer            IN              ert_solicitud.cod_vendedor_dealer%TYPE,
      ev_cod_oficina              IN              ert_solicitud.cod_oficina%TYPE,
      ev_cod_estado_final         IN              ert_solicitud.cod_estadofinal%TYPE,
      ev_cod_vendedor_agente      IN              ert_solicitud.cod_vendedor_agente%TYPE,
      ev_nom_usuario_evaluacion   IN              ert_solicitud.nom_usuario_evaluacion%TYPE,
      ev_ind_evento               IN              ert_solicitud.ind_evento%TYPE,
      ev_cod_acreditacion         IN              ert_solicitud.cod_acreditacion%TYPE,
      en_monto_garantia           IN              ert_solicitud.mto_garantia%TYPE,
      en_monto_renta              IN              ert_solicitud.mto_renta%TYPE,
      sn_codretorno               OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno               OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento                OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN

   IS
       lv_des_error           ge_errores_pg.desevent;
       lv_sql                 ge_errores_pg.vquery;
   BEGIN
       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

       lv_sql := 'INSERT INTO ert_solicitud (num_solicitud, ind_excepcion_renta, ind_excepcion_morosidad, ind_tipo_cliente, cod_esquema, ind_personeria, cod_usuario_evaluacion, cod_vendedor, cod_tipident, num_ident_cliente, cod_puntaje, cod_calificacion, cod_tipcomis, ind_tipo_solicitud, cod_estado, cod_vendedor_dealer, cod_oficina, cod_estadofinal, cod_vendedor_agente, nom_usuario_evaluacion, ind_evento, cod_acreditacion, mto_garantia, mto_renta, fec_ingreso_h, ind_origen)'
               || ' VALUES ('||en_num_solicitud||', ''N'', ''N'', '||ev_ind_tipo_cliente||', '||ev_cod_esquema||', '||ev_ind_personeria||', '||ev_cod_usuario_evaluacion||', '||ev_cod_vendedor||', '||ev_cod_tipident||', '||ev_num_ident_cliente||', '||ev_cod_puntaje||', '||ev_cod_calificacion||', '||ev_cod_tipcomis||', '||ev_ind_tipo_solicitud||', '||ev_cod_estado||', '||ev_cod_vendealer||', '||ev_cod_oficina||', '||ev_cod_estado_final||', '||ev_cod_vendedor_agente||', '||ev_nom_usuario_evaluacion||', '||ev_ind_evento||', '||ev_cod_acreditacion||', '||en_monto_garantia||', '||en_monto_renta||', '||SYSDATE||', '||'''PA'''||')';

       INSERT INTO ert_solicitud
                   (num_solicitud, ind_excepcion_renta, ind_excepcion_morosidad, ind_tipo_cliente, cod_esquema, ind_personeria, cod_usuario_evaluacion, cod_vendedor, cod_tipident, num_ident_cliente,
                    cod_puntaje, cod_calificacion, cod_tipcomis, ind_tipo_solicitud, cod_estado, cod_vendedor_dealer, cod_oficina, cod_estadofinal, cod_vendedor_agente,
                    nom_usuario_evaluacion, ind_evento, cod_acreditacion, mto_garantia, mto_renta, fec_ingreso_h, ind_origen)
            VALUES (en_num_solicitud, 'N', 'N', ev_ind_tipo_cliente, ev_cod_esquema, ev_ind_personeria, ev_cod_usuario_evaluacion, ev_cod_vendedor, ev_cod_tipident, ev_num_ident_cliente,
                    ev_cod_puntaje, ev_cod_calificacion, ev_cod_tipcomis, ev_ind_tipo_solicitud, ev_cod_estado, ev_cod_vendealer, ev_cod_oficina, ev_cod_estado_final, ev_cod_vendedor_agente,
                    ev_nom_usuario_evaluacion, ev_ind_evento, ev_cod_acreditacion, en_monto_garantia, en_monto_renta, sysdate, 'PA');

      RETURN TRUE;

   EXCEPTION

     WHEN OTHERS THEN
        sn_codretorno  := '505';
        sv_menretorno  := 'Error: no determinado al registrar solicitud';
        lv_des_error   := 'er_integracion_solicitud_pg.er_valida_reg99_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
        RETURN FALSE;
   END er_ins_solicitud_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_procesa_detcampos_fn (
      en_num_solicitud   IN              ert_solicitud.num_solicitud%TYPE,
      so_objeto          IN OUT          er_datosburo_ot,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN

   IS
      lv_des_error             ge_errores_pg.desevent;
      lv_sql                   ge_errores_pg.vquery;

      lv_ind_tipo_documento    ERT_SOLICITUD_DETCAMPO.IND_TIPO_DOCUMENTO%TYPE;
      lv_cod_moneda            GED_PARAMETROS.VAL_PARAMETRO%TYPE;
      ln_mto_deuda             ERT_SOLICITUD_DETCAMPO.MTO_DEUDA%TYPE;
      lv_fec_vencimiento       varchar2(20);
      lv_des_librador          ERT_SOLICITUD_DETCAMPO.DES_LIBRADOR%TYPE;
      lv_des_causa_publicacion ERT_SOLICITUD_DETCAMPO.DES_CAUSA_PUBLICACION%TYPE;
      sv_valparametro          GED_PARAMETROS.VAL_PARAMETRO%TYPE;
      error_moneda             EXCEPTION;
      error_ejecucion          EXCEPTION;
   BEGIN
       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

       --SE procesa el Registro 03 y 08 Recordar el registro 03 corresponde a la deuda del cliente y el regitro 08 corresponde al detalle de esta

           IF NOT (er_obtiene_valor_parametro_fn ('MONEDA_LOCAL',cv_modulo_ga,cn_producto,sv_valparametro,sn_codretorno,sv_menretorno,sn_numevento)) THEN
              RAISE error_moneda;
       END IF;

       lv_cod_moneda := SUBSTR(sv_valparametro,length(sv_valparametro)-1, 2);


       so_objeto.deuda_total:=0;

       FOR i IN 1..so_objeto.registro03.count LOOP
          lv_fec_vencimiento:=so_objeto.registro03(i).fecha_actualizacion || '01';
          lv_ind_tipo_documento:=so_objeto.registro03(i).cod_estado;

           --Si no se encontro parametro Error

          IF (so_objeto.registro08(i).indicador_valores = '*') THEN
             ln_mto_deuda:=so_objeto.registro08(i).saldo_mora * 1000;
             so_objeto.deuda_total:= so_objeto.deuda_total + ln_mto_deuda;

             IF (ln_mto_deuda > 0) THEN
                lv_des_causa_publicacion := 'DEUDA VIGENTE';
             ELSE
                lv_des_causa_publicacion := 'AL DIA VIGENTE';
             END IF;
          ELSE
             ln_mto_deuda:=0;
             lv_des_causa_publicacion:='';
          END IF;

          lv_des_librador := so_objeto.registro03(i).nom_suscriptor;
                  IF NOT (er_ins_solicituddetcampo_pr (en_num_solicitud,lv_ind_tipo_documento,lv_cod_moneda,ln_mto_deuda,lv_fec_vencimiento,lv_des_librador,lv_des_causa_publicacion,sn_codretorno,sv_menretorno,sn_numevento)) THEN
                     RAISE error_ejecucion;
                  END IF;
       END LOOP;

           RETURN TRUE;

   EXCEPTION
     WHEN ERROR_MONEDA THEN
        SN_codRetorno := 506;
        LV_des_error  := 'er_integracion_solicitud_pg.er_procesa_detcampos_fn();- ' || SQLERRM;
        SV_menRetorno := 'Error al recuperar codigo de moneda';
        SN_numEvento  := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'er_integracion_solicitud_pg.er_procesa_detcampos_fn',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
     WHEN OTHERS THEN
        SN_codRetorno := 507;
        LV_des_error   := 'er_integracion_solicitud_pg.er_procesa_detcampos_fn();- ' || SQLERRM;
        sv_menretorno  := 'Error: no determinado al procesar detalle de campos';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'er_integracion_solicitud_pg.er_procesa_detcampos_fn',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_procesa_detcampos_fn ;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_procesa_solicitudcampos_fn (
      en_num_solicitud    IN              ert_solicitud.num_solicitud%TYPE,
      so_objeto           IN OUT          er_datosburo_ot,
      ev_ind_personeria   IN              VARCHAR2,
      ev_cod_tipident     IN              ert_solicitud_campos.cod_tipident%TYPE,
      ev_num_ident        IN              ert_solicitud_campos.num_ident%TYPE,
      sn_codretorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento        OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
      lv_des_error             ge_errores_pg.desevent;
      lv_sql                   ge_errores_pg.vquery;

      lv_nombre_cliente        ert_solicitud_campos.nombre_cliente%TYPE;
      lv_apellido1             ert_solicitud_campos.primer_apellido%TYPE;
      Lv_Apellido2             Ert_Solicitud_Campos.Segundo_Apellido%TYPE;
      ln_mtos_impagos          ert_solicitud_campos.mto_impagos%TYPE;
      lv_des_nombre            ert_solicitud_campos.des_nombre%TYPE;
      lv_des_comuna            ert_solicitud_campos.des_comuna%TYPE;
      lv_des_ciudad            ert_solicitud_campos.des_ciudad%TYPE;

          o_erd_parametros         erd_parametros_ot := NEW erd_parametros_ot();
      error_ejecucion          EXCEPTION;
   BEGIN
       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

       o_erd_parametros.cod_codigo := 100;
           o_erd_parametros.cod_subcodigo := 22;

       IF ev_ind_personeria ='PN' THEN
          o_erd_parametros.cod_parametro := '2';
          IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_codretorno,sv_menretorno,sn_numevento)) THEN
                 RAISE error_ejecucion;
                  END IF;
       ELSIF ev_ind_personeria ='PJ' THEN
          o_erd_parametros.cod_parametro := '1';
          IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_codretorno,sv_menretorno,sn_numevento)) THEN
                 RAISE error_ejecucion;
                  END IF;
       END IF;

       IF so_objeto.registro00ext.tipo_registro IS NOT NULL THEN --ES TIPO IDENTIFICACION 2 O 4
          lv_nombre_cliente := replace(so_objeto.registro00ext.nombre,'/','Ñ');
          lv_apellido1      := '';
          lv_apellido2      := '';
          ln_mtos_impagos   := so_objeto.deuda_total;
          lv_des_nombre     := replace(so_objeto.registro00ext.nombre,'/','Ñ');
          lv_des_comuna     := '';
          lv_des_ciudad     := '';
       ELSE
          lv_nombre_cliente := replace(so_objeto.registro00ciu.nombre,'/','Ñ');
          lv_apellido1      := replace(so_objeto.registro00ciu.primer_apellido,'/','Ñ');
          lv_apellido2      := replace(so_objeto.registro00ciu.segundo_apellido,'/','Ñ');
          ln_mtos_impagos   := so_objeto.deuda_total;
          lv_des_nombre     := replace(so_objeto.registro00ciu.nombre_completo,'/','Ñ');
          lv_des_comuna     := so_objeto.registro00ciu.departamento;
          lv_des_ciudad     := so_objeto.registro00ciu.ciudad;
       END IF;

       IF NOT (er_ins_solicitudcampos_pr(en_num_solicitud,o_erd_parametros.val_parametro1,lv_nombre_cliente,lv_apellido1,lv_apellido2,ln_mtos_impagos,lv_des_nombre,lv_des_comuna,lv_des_ciudad,ev_cod_tipident,ev_num_ident,sn_codretorno,sv_menretorno,sn_numevento)) THEN
                 RAISE error_ejecucion;
           END IF;

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        sn_codretorno  := '508';
        sv_menretorno  := 'Error: no determinado al procesar campos de solicitud';
        lv_des_error   := 'er_integracion_solicitud_pg.er_procesa_solicitudcampos_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_procesa_solicitudcampos_fn', lv_sql, SQLCODE, lv_des_error);
        RETURN FALSE;

   END er_procesa_solicitudcampos_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_procesa_solicitud_fn (
      en_num_solicitud            IN              ert_solicitud.num_solicitud%TYPE,
      so_objeto                   IN OUT          er_datosburo_ot,
      ev_ind_personeria           IN              VARCHAR2,
      ev_cod_tipident             IN              ert_solicitud.cod_tipident%TYPE,
      ev_num_ident                IN              ert_solicitud.num_ident_cliente%TYPE,
      ev_ind_tipo_cliente         IN              VARCHAR2,
      en_cod_esquema              IN              ert_solicitud.cod_esquema%TYPE,
      ev_cod_usuario_evaluacion   IN              ert_solicitud.cod_usuario_evaluacion%TYPE,
      en_cod_vendedor             IN              ert_solicitud.cod_vendedor%TYPE,
      en_cod_vendealer            IN              ve_vendealer.cod_vendealer%TYPE,
      ev_usuario_evaluacion       IN              ert_solicitud.nom_usuario_evaluacion%TYPE,
      en_monto_renta              IN OUT          ert_solicitud.mto_renta%TYPE,
      en_cod_acreditacion         IN              ert_solicitud.cod_acreditacion%TYPE,
      en_monto_garantia           IN              ert_solicitud.mto_garantia%TYPE,
      en_cod_respuesta_buro       IN              ert_datos_detalle_to.cod_respuesta_reg99%TYPE,
      sn_codretorno               OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno               OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento                OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN

   IS

      lv_des_error                           ge_errores_pg.desevent;
      lv_sql                                 ge_errores_pg.vquery;
      lv_count                               number(6);
      ln_num_solicitud                       ert_solicitud.num_solicitud%TYPE;
      lv_ind_tipo_documento                  ert_solicitud_detcampo.ind_tipo_documento%TYPE;
      ln_mto_deuda                           ert_solicitud_detcampo.mto_deuda%TYPE;
      sv_valparametro                        ged_parametros.val_parametro%TYPE;
      lv_nomparametro                        ged_parametros.nom_parametro%TYPE;
      lv_subcodigo                           erd_parametros.cod_subcodigo%TYPE;
      lv_parametro_natural                   erd_parametros.val_parametro1%TYPE;
      lv_parametro_juridica                  erd_parametros.val_parametro1%TYPE;
      lv_codcodigo                           erd_parametros.cod_codigo%TYPE;
      lv_ind_personeria                      ert_solicitud.ind_personeria%TYPE;
      lv_cod_puntaje                         ert_solicitud.cod_puntaje%type;
      lv_cod_calificacion                    ert_solicitud.cod_calificacion%TYPE;
      lv_cod_tipcomis                        ert_solicitud.cod_tipcomis%TYPE;
      lv_ind_tipo_solicitud                  ert_solicitud.ind_tipo_solicitud%TYPE;
      lv_cod_estado                          ert_solicitud.cod_estado%TYPE;
      lv_cod_oficina                         ert_solicitud.cod_oficina%TYPE;
      lv_cod_estado_final                    ert_solicitud.cod_estadofinal%TYPE;
      lv_cod_vendedor_agente                 ert_solicitud.cod_vendedor_agente%TYPE;
      lv_ind_evento                          ert_solicitud.ind_evento%TYPE;
      ln_ind_tipo_cliente                    ert_solicitud.ind_tipo_cliente%TYPE;
      error_ejecucion                        EXCEPTION;
          o_erd_parametros                       erd_parametros_ot := NEW erd_parametros_ot();
   BEGIN

      SN_codRetorno := 0;
      SV_menRetorno  := NULL;
      SN_numEvento := 0;

      o_erd_parametros.cod_codigo := 100;
      o_erd_parametros.cod_subcodigo := 22;

      --Obtemer el IND_PERSONERIA
      IF (ev_ind_personeria ='PN') THEN
         o_erd_parametros.cod_parametro := '2';
         IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_codretorno,sv_menretorno,sn_numevento)) THEN
            RAISE error_ejecucion;
         END IF;
      ELSIF (ev_ind_personeria ='PJ') THEN
         o_erd_parametros.cod_parametro := '1';
         IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_codretorno,sv_menretorno,sn_numevento)) THEN
            RAISE error_ejecucion;
         END IF;
      END IF;

      lv_ind_personeria:=o_erd_parametros.val_parametro1;

      --Datos a Obtener

      --1) IND_TIPO_CLIENTE

      o_erd_parametros.cod_codigo := 100;
      o_erd_parametros.cod_subcodigo := 21;

      IF ev_ind_tipo_cliente='NU' THEN
         o_erd_parametros.cod_parametro := '2';
         IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_codretorno,sv_menretorno,sn_numevento)) THEN
            RAISE error_ejecucion;
         END IF;
      ELSIF EV_IND_TIPO_CLIENTE='AA' THEN
         o_erd_parametros.cod_parametro := '1';
         IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_codretorno,sv_menretorno,sn_numevento)) THEN
            RAISE error_ejecucion;
         END IF;
      ELSIF EV_IND_TIPO_CLIENTE='AP' THEN
         o_erd_parametros.cod_parametro := '3';
         IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_codretorno,sv_menretorno,sn_numevento)) THEN
            RAISE error_ejecucion;
         END IF;
      ELSE
         o_erd_parametros.cod_parametro := '4';
         IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_codretorno,sv_menretorno,sn_numevento)) THEN
            RAISE error_ejecucion;
         END IF;
      END IF;
      ln_ind_tipo_cliente:=o_erd_parametros.val_parametro1;

      --2) COD_TIPCOMIS
      lv_sql:='SELECT cod_oficina,cod_tipcomis FROM ve_vendedores WHERE cod_vendedor=' || EN_COD_VENDEDOR;

      SELECT cod_oficina, cod_tipcomis, cod_vende_raiz
        INTO lv_cod_oficina, lv_cod_tipcomis, lv_cod_vendedor_agente
        FROM ve_vendedores
       WHERE cod_vendedor = en_cod_vendedor;

      --3) IND_TIPO_SOLICITUD
      o_erd_parametros.cod_codigo := 100;
      o_erd_parametros.cod_subcodigo := 20;
      o_erd_parametros.cod_parametro := '2';
      IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_codretorno,sv_menretorno,sn_numevento)) THEN
         RAISE error_ejecucion;
      END IF;
      lv_ind_tipo_solicitud := o_erd_parametros.val_parametro1;

      --4) COD_ESTADO
      o_erd_parametros.cod_codigo := 100;
      o_erd_parametros.cod_subcodigo := 6;
      o_erd_parametros.cod_parametro := '10';
      IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_codretorno,sv_menretorno,sn_numevento)) THEN
         RAISE error_ejecucion;
      END IF;
      lv_cod_estado:=o_erd_parametros.val_parametro1;

      --6) COD_ESTADO_FINAL
      IF NOT (er_obtiene_codigoEstFinal_fn (EN_COD_RESPUESTA_BURO,LV_COD_ESTADO_FINAL,sn_codretorno,sv_menretorno,sn_numevento)) THEN
         RAISE error_ejecucion;
      END IF;

      --8) IND_EVENTO
      o_erd_parametros.cod_codigo := 100;
      o_erd_parametros.cod_subcodigo := 11;
      o_erd_parametros.cod_parametro := '1';
      IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_codretorno,sv_menretorno,sn_numevento)) THEN
         RAISE error_ejecucion;
      END IF;
      lv_ind_evento:=o_erd_parametros.val_parametro1;

      lv_cod_puntaje:=so_objeto.registro20.calificacion;
      lv_cod_calificacion:=so_objeto.registro20.clasificacion;

      IF NOT (er_ins_solicitud_fn (en_num_solicitud,ln_ind_tipo_cliente,en_cod_esquema,lv_ind_personeria,ev_cod_usuario_evaluacion,en_cod_vendedor,ev_cod_tipident,ev_num_ident,lv_cod_puntaje,lv_cod_calificacion,lv_cod_tipcomis,lv_ind_tipo_solicitud,lv_cod_estado,en_cod_vendealer,lv_cod_oficina,lv_cod_estado_final,lv_cod_vendedor_agente,ev_usuario_evaluacion,lv_ind_evento,en_cod_acreditacion,en_monto_garantia,en_monto_renta,sn_codretorno,sv_menretorno,sn_numevento)) THEN
         RAISE error_ejecucion;
      END IF;

      RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        sn_codretorno  := '509';
        sv_menretorno  := 'Error: no determinado al procesar solicitud';
        lv_des_error   := 'er_integracion_solicitud_pg.er_procesa_solicitud_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_procesa_solicitud_fn', lv_sql, SQLCODE, lv_des_error);
        RETURN FALSE;
   END er_procesa_solicitud_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_procesa_solicitud_planes_fn (
      en_num_solicitud            IN              ert_solicitud.num_solicitud%TYPE,
          ec_planes                   IN              refcursor,
      sn_codretorno               OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno               OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento                OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN

   IS
       lv_des_error           ge_errores_pg.desevent;
       lv_sql                 ge_errores_pg.vquery;
           ev_cod_plantarif       VARCHAR2(10);
           ev_des_plantarif       VARCHAR2(30);
           error_ejecucion        EXCEPTION;
   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno := NULL;
       SN_numEvento  := 0;

       LOOP

          FETCH ec_planes INTO ev_cod_plantarif,ev_des_plantarif;
          EXIT WHEN ec_planes%NOTFOUND;

          IF NOT (er_ins_solicitudplanes_fn (en_num_solicitud,ev_cod_plantarif,sn_codretorno,sv_menretorno,sn_numevento)) THEN
                 RAISE error_ejecucion;
              END IF;

       END LOOP;

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        sn_codretorno  := '510';
        sv_menretorno  := 'Error: no determinado al procesar solicitud planes';
        lv_des_error   := 'er_integracion_solicitud_pg.er_procesa_solicitud_planes_fn(); - ' || SQLERRM;
        sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, 'GA', sn_codretorno || ' -- ' || sv_menretorno, '1.0', USER, 'er_integracion_solicitud_pg.er_procesa_solicitud_planes_fn', lv_sql, SQLCODE, lv_des_error);
                RETURN FALSE;
   END er_procesa_solicitud_planes_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END er_integracion_solicitud_pg;
/
SHOW ERRORS
