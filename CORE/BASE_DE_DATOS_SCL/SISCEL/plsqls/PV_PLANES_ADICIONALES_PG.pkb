	CREATE OR REPLACE PACKAGE BODY SISCEL.PV_PLANES_ADICIONALES_PG AS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_VALIDA_PARAMETROS_FN ( EN_CLIENTE_ORIGEN IN ge_clientes.cod_cliente%TYPE,
 EV_PLAN_ORIGEN IN ta_plantarif.cod_plantarif%TYPE,
 EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
 EV_PLAN_DESTINO IN ta_plantarif.cod_plantarif%TYPE,
 ED_FECHA_ALTA IN DATE,
 EN_NUM_PROCESO IN pr_productos_contratados_to.num_proceso%TYPE,
 EV_COD_CANAL IN pr_productos_contratados_to.cod_canal%TYPE,
 SN_COD_RETORNO OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
 SV_MENS_RETORNO OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
 SN_NUM_EVENTO OUT NOCOPY ge_errores_pg.evento
 ) RETURN BOOLEAN IS
/*
 <Documentación
 TipoDoc = "Procedure">>
 <Elemento
 Nombre = "PV_VALIDA_PARAMETROS_FN"
 Lenguaje="PL/SQL"
 Fecha="20-11-2008"
 Versión="La del package"
 Diseñador="Andrés Osorio"
 Programador="Andrés Osorio"
 Ambiente Desarrollo="BD">
 <Retorno>BOOLEAN</Retorno>>
 <Descripción>Valida los Parametros de entrada</Descripción>>
 <Parámetros>
 <Entrada>
 <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
 <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
 <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
 <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
 <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
 <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
 <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
 </Entrada>
 <Salida>
 <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
 <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
 <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
 </Salida>
 </Parámetros>
 </Elemento>
 </Documentación>
*/
LV_des_error ge_errores_pg.DesEvent;
LV_sSql ge_errores_pg.vQuery;
ERROR_CLIENTE EXCEPTION;
ERROR_PLAN EXCEPTION;
ERROR_FECHA EXCEPTION;
ERROR_PROCESO EXCEPTION;
ERROR_CANAL EXCEPTION;

BEGIN

 SN_COD_RETORNO := 0;
 SV_MENS_RETORNO := NULL;
 SN_NUM_EVENTO := 0;

 IF (EN_CLIENTE_ORIGEN IS NULL) OR (EN_CLIENTE_ORIGEN = 0) THEN
 RAISE ERROR_CLIENTE;
 END IF;

 IF (EV_PLAN_ORIGEN IS NULL) OR (EV_PLAN_ORIGEN = '') THEN
 RAISE ERROR_PLAN;
 END IF;

 IF (EN_CLIENTE_DESTINO IS NULL) OR (EN_CLIENTE_DESTINO = 0) THEN
 RAISE ERROR_CLIENTE;
 END IF;

 IF (EV_PLAN_DESTINO IS NULL) OR (EV_PLAN_DESTINO = '') THEN
 RAISE ERROR_PLAN;
 END IF;

 IF (ED_FECHA_ALTA IS NULL) THEN
 RAISE ERROR_FECHA;
 END IF;

 IF (EN_NUM_PROCESO IS NULL) OR (EN_NUM_PROCESO = 0) THEN
 RAISE ERROR_PROCESO;
 END IF;

 IF (EV_COD_CANAL IS NULL) OR (EV_COD_CANAL = '') THEN
 RAISE ERROR_CANAL;
 END IF;

 RETURN TRUE;

EXCEPTION
 WHEN ERROR_CLIENTE THEN
 SN_cod_retorno := 877;
 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
 SV_mens_retorno := cv_error_no_clasif;
 END IF;
 LV_des_error := 'PV_PLANES_ADICIONALES_PG('||EN_CLIENTE_ORIGEN||','||EN_CLIENTE_DESTINO||'); - ' || SQLERRM;
 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'PV_PLANES_ADICIONALES_PG.PV_VALIDA_PARAMETROS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
 RETURN FALSE;

 WHEN ERROR_PLAN THEN
 SN_cod_retorno := 232;
 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
 SV_mens_retorno := cv_error_no_clasif;
 END IF;
 LV_des_error := 'PV_PLANES_ADICIONALES_PG('||EV_PLAN_ORIGEN||','||EV_PLAN_DESTINO||'); - ' || SQLERRM;
 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'PV_PLANES_ADICIONALES_PG.PV_VALIDA_PARAMETROS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
 RETURN FALSE;

 WHEN ERROR_FECHA THEN
 SN_cod_retorno := 200302;
 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
 SV_mens_retorno := cv_error_no_clasif;
 END IF;
 LV_des_error := 'SISCEL.PV_PLANES_ADICIONALES_PG('||ED_FECHA_ALTA||'); - ' || SQLERRM;
 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'PV_PLANES_ADICIONALES_PG.PV_VALIDA_PARAMETROS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
 RETURN FALSE;

 WHEN ERROR_PROCESO THEN
 SN_cod_retorno := 1642;
 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
 SV_mens_retorno := cv_error_no_clasif;
 END IF;
 LV_des_error := 'PV_PLANES_ADICIONALES_PG('||EN_NUM_PROCESO||'); - ' || SQLERRM;
 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'PV_PLANES_ADICIONALES_PG.PV_VALIDA_PARAMETROS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
 RETURN FALSE;

 WHEN ERROR_CANAL THEN
 SN_cod_retorno := 98;
 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
 SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||EV_COD_CANAL||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'PV_PLANES_ADICIONALES_PG.PV_VALIDA_PARAMETROS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN FALSE;
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_VALIDA_PARAMETROS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END PV_VALIDA_PARAMETROS_FN ;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION pv_agrega_fn(en_cliente_destino IN GE_CLIENTES.cod_cliente%TYPE,
                        en_abonado_destino IN GA_ABOCEL.NUM_ABONADO%TYPE,
                        en_prod_ofertado   IN pr_productos_contratados_to.cod_prod_ofertado%TYPE,
                        ed_fecha_alta      IN DATE,
                        ed_fecha_baja      IN DATE,
                        en_num_mov_ant     IN ICC_MOVIMIENTO.num_movant%TYPE,
                        en_num_veces       IN pf_paquete_ofertado_to.num_veces_hijo%TYPE,
                        en_num_proceso     IN pr_productos_contratados_to.num_proceso%TYPE,
                        ev_cod_canal       IN pr_productos_contratados_to.cod_canal%TYPE,
                        ev_ind_contrata    IN pr_productos_contratados_to.ind_condicion_contratacion%TYPE,
                        --Inicio Inc. 170939 - FDL - 09/08/2011
                        en_cod_padre       IN pr_productos_contratados_to.cod_prod_contra_padre%TYPE,
                        ev_ind_hijo        IN VARCHAR2,
                        --Fin Inc. 170939 - FDL - 09/08/2011
                        sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                        sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                        sn_num_evento      OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN IS
    /*
     <Documentación
       TipoDoc = "Procedure">>
        <Elemento
           Nombre = "PV_AGREGA_FN"
               Lenguaje="PL/SQL"
           Fecha="20-11-2008"
           Versión="La del package"
           Diseñador="Andrés Osorio"
           Programador="Andrés Osorio"
           Ambiente Desarrollo="BD">
           <Retorno>BOOLEAN</Retorno>>
           <Descripción>Realiza la inscripción de un producto en todas las plataformas</Descripción>>
           <Parámetros>
              <Entrada>
                    <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                    <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                    <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                    <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                    <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                    <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                    <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
              </Entrada>
              <Salida>
                 <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
                 <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
                 <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
              </Salida>
           </Parámetros>
        </Elemento>
     </Documentación>
    */
    lv_des_error ge_errores_pg.desevent;
    lv_ssql      ge_errores_pg.vquery;
    error_subfuncion EXCEPTION;
    ln_count                 NUMBER;
    ln_cod_prod_contratado   pr_productos_contratados_to.cod_prod_contratado%TYPE;
    ln_cod_espec_prod        se_detalles_especificacion_to.cod_espec_prod%TYPE;
    ln_cod_perfil_lista      se_detalles_especificacion_to.cod_perfil_lista%TYPE;
    ln_cod_prov_serv         se_detalles_especificacion_to.cod_prov_serv%TYPE;
    lv_cod_servicio_base     se_detalles_especificacion_to.cod_servicio_base%TYPE;
    lv_ind_tipo_servicio     se_detalles_especificacion_to.ind_tipo_servicio%TYPE;
    lv_tipo_comportamiento   ps_especificaciones_prod_td.tipo_comportamiento%TYPE;
    lv_tipo_plataforma       ps_especificaciones_prod_td.tipo_plataforma%TYPE;
    lv_tipo_unidad_bonificar se_planes_altamira_td.tipo_unidad_bonificar%TYPE;
    ln_can_bonificar         se_planes_altamira_td.can_bonificar%TYPE;
    c_pro_defecto            refcursor;
    c_cargos                 refcursor;
    lo_cargos_rec            fa_cargos_rec_qt;
    lo_abonado               ga_abonado_qt;
    lo_producto              pr_productos_conts_to_qt;
    lo_lista_numeros         sv_prod_contr_lst_qt;
    lo_lista_centrales       ic_provision_qt;
    lo_cliente               pv_cliente_qt;
    lo_cargos                fa_cargos_qt;
    ln_monto_importe         pf_cargos_productos_td.monto_importe%TYPE;
    lv_cod_moneda            pf_cargos_productos_td.cod_moneda%TYPE;
    ln_cod_cargo             pf_cargos_productos_td.cod_cargo%TYPE;
    ln_cod_concepto          pf_catalogo_ofertado_td.cod_concepto%TYPE;
    lv_tip_cargo             pf_conceptos_prod_td.tipo_cargo%TYPE;
    ln_ind_prorrateable      NUMBER;
    lv_ind_nivel_aplica      pf_productos_ofertados_td.ind_nivel_aplica%TYPE;
    lv_usuario               GA_ABOCEL.nom_usuarora%TYPE;
    ld_fecdesdecargos        FA_CICLFACT.fec_desdeocargos%TYPE;
    ld_fechastacargos        FA_CICLFACT.fec_hastaocargos%TYPE;

    --Inicio Inc. 170939 - FDL - 09/08/2011
    ln_cod_padre pr_productos_contratados_to.cod_prod_contra_padre%TYPE;
    ln_max_contra pf_productos_ofertados_td.max_contrataciones%TYPE;
    ln_can_contra NUMBER;
    ln_num_veces  NUMBER;
    ld_fec_desdeocargos      DATE;
    ln_esprepago  NUMBER;

    LV_DESESTADO       VARCHAR2(2000);
    LV_INFO_REG        VARCHAR2(2000);
    LV_NomProc VARCHAR2(2000) := 'PV_PLANES_ADICIOALES_PG.PV_QUITA_FN';
    LV_Tabla   VARCHAR2(30);
    LV_Act     VARCHAR2(1);
    LNEstado   NUMBER;
    LVCode     VARCHAR2(2000);
    LVErrm     VARCHAR2(2000);
    --Fin Inc. 170939 - FDL - 09/08/2011



  BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;

    --Se obtiene el usuario de la OOSS
    BEGIN
      SELECT usuario
        INTO lv_usuario
        FROM PV_IORSERV
       WHERE num_os = en_num_proceso
      UNION
      SELECT usuario
      FROM CI_ORSERV
      WHERE num_os = en_num_proceso;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        lv_usuario := USER;
    END;

    lo_lista_centrales := ic_provision_qt();
    --Se prepara estructura para obtener datos del abonado
    lo_abonado := ga_abonado_qt(en_abonado_destino,
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '');
    --Se prepara estructura para obtener datos del abonado
    lo_cliente := pv_cliente_qt(en_cliente_destino,
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '');

    IF (en_abonado_destino != 0 AND en_abonado_destino IS NOT NULL) THEN
      lv_ind_nivel_aplica := 'A';
      --Se Obtienen los datos del abonado
      Pv_Datos_Abonado_Pg.pv_obtiene_datos_abonado_pr(lo_abonado,
                                                      sn_cod_retorno,
                                                      sv_mens_retorno,
                                                      sn_num_evento);

      IF (sn_cod_retorno != 0) THEN
        RAISE error_subfuncion;
      END IF;
    ELSE
      lv_ind_nivel_aplica := 'C';
      Pv_Datos_Clientes_Pg.pv_obtiene_datos_cliente_pr(lo_cliente,
                                                       sn_cod_retorno,
                                                       sv_mens_retorno,
                                                       sn_num_evento);
      lo_abonado.cod_ciclo      := lo_cliente.cod_ciclo;
      lo_abonado.cod_cliente    := lo_cliente.cod_cliente;
      lo_abonado.tip_terminal   := lo_cliente.tip_terminal;
      lo_abonado.cod_tecnologia := lo_cliente.cod_tecnologia;
    END IF;

    --Inicion Inc. 170939 - 07/08/2011 - FDL
    lv_ssql := 'SELECT NVL(max_contrataciones,0) FROM pf_productos_ofertados_td WHERE cod_prod_ofertado = ' || en_prod_ofertado;

    SELECT NVL(max_contrataciones, 0)
      INTO ln_max_contra
      FROM pf_productos_ofertados_td
     WHERE cod_prod_ofertado = en_prod_ofertado;


    dbms_output.put_line('ln_max_contra:'||ln_max_contra);

    IF (ln_max_contra > 0) THEN
      lv_ssql := 'SELECT COUNT(0)';
      lv_ssql := lv_ssql || ' FROM pr_productos_contratados_to';
      lv_ssql := lv_ssql || ' WHERE cod_prod_ofertado = ' ||en_prod_ofertado;
      lv_ssql := lv_ssql || ' AND    cod_cliente_contratante = ' || en_cliente_destino;
      lv_ssql := lv_ssql || ' AND    num_abonado_contratante = ' || en_abonado_destino;

      SELECT COUNT(0)
        INTO ln_can_contra
        FROM pr_productos_contratados_to
       WHERE cod_prod_ofertado = en_prod_ofertado
         AND cod_cliente_contratante = en_cliente_destino
         AND num_abonado_contratante = en_abonado_destino;

    END IF;

    dbms_output.put_line('ln_can_contra:'||ln_can_contra);

    IF (ln_can_contra < ln_max_contra) OR (ln_max_contra = 0) THEN
      --Fin Inc. 170939 - 07/08/2011 - FDL
      --Se buscan los datos necesarios para contratar productos
      lv_ssql := 'SELECT servicio.cod_espec_prod, servicio.cod_perfil_lista, servicio.cod_prov_serv, servicio.cod_servicio_base,';
      lv_ssql := lv_ssql || ' servicio.ind_tipo_servicio, espec.tipo_comportamiento, espec.tipo_plataforma';
      lv_ssql := lv_ssql || ' FROM   pf_productos_ofertados_td ofertado, ps_especificaciones_prod_td espec, se_detalles_especificacion_to servicio';
      lv_ssql := lv_ssql || ' WHERE  ofertado.cod_espec_prod = espec.cod_espec_prod';
      lv_ssql := lv_ssql || ' AND       ofertado.cod_espec_prod = servicio.cod_espec_prod';
      lv_ssql := lv_ssql || ' AND       ofertado.cod_prod_ofertado = ' || en_prod_ofertado;
      lv_ssql := lv_ssql || ' AND       ofertado.ind_nivel_aplica = ' || lv_ind_nivel_aplica;

      SELECT servicio.cod_espec_prod,
             NVL(servicio.cod_perfil_lista, 0),
             servicio.cod_prov_serv,
             servicio.cod_servicio_base,
             servicio.ind_tipo_servicio,
             espec.tipo_comportamiento,
             espec.tipo_plataforma
        INTO ln_cod_espec_prod,
             ln_cod_perfil_lista,
             ln_cod_prov_serv,
             lv_cod_servicio_base,
             lv_ind_tipo_servicio,
             lv_tipo_comportamiento,
             lv_tipo_plataforma
        FROM pf_productos_ofertados_td     ofertado,
             ps_especificaciones_prod_td   espec,
             se_detalles_especificacion_to servicio
       WHERE ofertado.cod_espec_prod = espec.cod_espec_prod
         AND ofertado.cod_espec_prod = servicio.cod_espec_prod
         AND ofertado.cod_prod_ofertado = en_prod_ofertado
         AND ofertado.ind_nivel_aplica = lv_ind_nivel_aplica;

      --dbms_output.put_line('lv_ind_tipo_servicio:'||lv_ind_tipo_servicio);

      IF (lv_ind_tipo_servicio = 'AA') THEN
        lv_ssql := 'SELECT altamira.tipo_unidad_bonificar, altamira.can_bonificar';
        lv_ssql := lv_ssql || ' FROM   se_planes_altamira_td altamira';
        lv_ssql := lv_ssql || ' WHERE  altamira.cod_plan_altamira = ' || lv_cod_servicio_base;

        SELECT altamira.tipo_unidad_bonificar, altamira.can_bonificar
          INTO lv_tipo_unidad_bonificar, ln_can_bonificar
          FROM se_planes_altamira_td altamira
         WHERE altamira.cod_plan_altamira = lv_cod_servicio_base;
      END IF;

      --Inicio Inc. 170939/ 11-07-2011 / FDL
      IF (en_num_veces + ln_can_contra > ln_max_contra) THEN
        ln_num_veces := ln_max_contra - ln_can_contra;
      ELSE
        ln_num_veces := en_num_veces;
      END IF;

      --Fin Inc. 170939/ 11-07-2011 / FDL


      --dbms_output.put_line('ln_num_veces:'||ln_num_veces);


      FOR ln_count IN 1.. ln_num_veces
       LOOP
        --Se obtiene el secuencial de producto contratado
        lv_ssql := 'SELECT PF_PRODUCTOS_CONTRATADOS_SQ.NEXTVAL FROM dual';

        SELECT pf_productos_contratados_sq.NEXTVAL
          INTO ln_cod_prod_contratado
          FROM DUAL;

        --Inicio Inc. 170939/ 11-07-2011 / FDL
        /*
        IF (en_cod_padre IS NULL) THEN
          ln_cod_padre := ln_cod_prod_contratado;
        ELSE
          ln_cod_padre := en_cod_padre;
        END IF;
*/
        lv_ssql := '1.- lo_producto := pr_productos_conts_to_qt('||ln_cod_prod_contratado||','
                                                ||en_cliente_destino||','
                                                ||en_abonado_destino||','
                                                ||en_prod_ofertado||','
                                                ||ed_fecha_alta||','
                                                ||ev_cod_canal||','
                                                ||en_num_proceso||','
                                                ||ev_cod_canal||','
                                                ||SYSDATE||','
                                                ||'OK,'
                                                ||ev_ind_contrata||','
                                                ||en_cliente_destino||','
                                                ||en_abonado_destino||','
                                                ||'31-12-3000,'
                                                ||'1,'
                                                ||ln_cod_padre||','
                                                ||ln_cod_perfil_lista||','
                                                ||lv_tipo_comportamiento||','
                                                ||'NULL,'
                                                ||'NULL);';

        --Fin Inc. 170939/ 11-07-2011 / FDL


        --Se prepara el arreglo de producto
        lo_producto := pr_productos_conts_to_qt(ln_cod_prod_contratado,
                                                en_cliente_destino,
                                                en_abonado_destino,
                                                en_prod_ofertado,
                                                ed_fecha_alta,
                                                ev_cod_canal,
                                                en_num_proceso,
                                                ev_cod_canal,
                                                SYSDATE,
                                                'OK',
                                                ev_ind_contrata,
                                                en_cliente_destino,
                                                en_abonado_destino,
                                                TO_DATE('31-12-3000','DD-MM-YYYY'), -- FPP 08-07-2010 --160835|12-01-2011|EFR
                                                1,
                                                ln_cod_padre,
                                                ln_cod_perfil_lista,
                                                lv_tipo_comportamiento,
                                                NULL,
                                                NULL);
        --Se contrata el Producto
        lv_ssql := 'PR_PRODUCTOS_CONTRATADOS_PG.PR_CONTRATA_I_PR(' ||
                        ln_cod_prod_contratado || ', ' ||
                        en_cliente_destino || ', ' ||
                        en_abonado_destino || ', ' ||
                        en_prod_ofertado || ', ' ||
                        ed_fecha_alta || ', ' ||
                        ev_cod_canal || ', ' ||
                        en_num_proceso || ', ' ||
                        ev_cod_canal || ', ' ||
                        SYSDATE || ', ' ||
                        'OK, ' ||
                        ev_ind_contrata ||
                        en_cliente_destino || ', ' ||
                        en_abonado_destino || ', ' ||
                        ed_fecha_baja || ', ' ||
                        '1 ' ||
                        ln_cod_padre || ', ' ||
                        ln_cod_perfil_lista || ', ' ||
                        lv_tipo_comportamiento || ')';

        pr_productos_contratados_pg.pr_contrata_i_pr(lo_producto,
                                                     sn_cod_retorno,
                                                     sv_mens_retorno,
                                                     sn_num_evento);

        IF (sn_cod_retorno != 0) THEN
          RAISE error_subfuncion;
        END IF;


        IF (lv_ind_tipo_servicio = 'TOL') THEN
          --Se informa el producto contratado a TOL
          lv_ssql := 'TOL_PRODUCTO_CONTRATADO_PG.TOL_ALTA_FACHADA_PR(' ||
                     en_abonado_destino || ', ' || to_char(ed_fecha_alta,'dd-mm-yyyy hh24:mi:ss') || ', ' ||
                     '31-12-3000' || ', ' || lv_cod_servicio_base || ', ' ||
                     ln_cod_prod_contratado || ', ' || 1 || ', ' ||
                     en_cliente_destino || ', ' || ev_cod_canal || ', ' ||
                     lo_abonado.cod_ciclo || ')';

            --Inicio Prueba Traza
    LV_DESESTADO := 'EN_CLIENTE_DESTINO['||EN_CLIENTE_DESTINO||'] EN_ABONADO_DESTINO['||EN_ABONADO_DESTINO;
    LV_DESESTADO := LV_DESESTADO || '] EN_PROD_CONTRATADO['||ln_cod_prod_contratado||'] EN_PROD_OFERTADO['||EN_PROD_OFERTADO;
    LV_DESESTADO := LV_DESESTADO || '] ED_FECHA_ALTA['||ED_FECHA_ALTA||'] ED_FECHA_BAJA['||ED_FECHA_BAJA;
    LV_DESESTADO := LV_DESESTADO || '] EN_NUM_MOV_ANT['||EN_NUM_MOV_ANT||'] EN_NUM_PROCESO['||EN_NUM_PROCESO||']';

    LV_INFO_REG := 'Antes de: TOL_PRODUCTO_CONTRATADO_PG.TOL_ALTA_FACHADA_PR@LNK_PRODUC_SCL_TOL('||ln_cod_prod_contratado||','||ed_fecha_baja||')';
    LV_NomProc := 'PV_AGREGA_FN';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    NULL, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    --Fin Prueba Traza

          --TOL_PRODUCTO_CONTRATADO_PG.TOL_ALTA_FACHADA_PR(EN_ABONADO_DESTINO, ED_FECHA_ALTA, ED_FECHA_BAJA, LV_cod_servicio_base,
          tol_producto_contratado_pg.tol_alta_fachada_pr(en_abonado_destino,
                                                                            ed_fecha_alta,
                                                                            to_date('31-12-3000', 'dd-mm-yyyy'), --Inc. 170939 - 07/08/2011 - FDL
                                                                            lv_cod_servicio_base,
                                                                            ln_cod_prod_contratado,
                                                                            1,
                                                                            en_cliente_destino,
                                                                            ev_cod_canal,
                                                                            lo_abonado.cod_ciclo,
                                                                            sn_cod_retorno,
                                                                            sv_mens_retorno,
                                                                            sn_num_evento);

        --Inicio Prueba Traza
    LV_DESESTADO := 'EN_CLIENTE_DESTINO['||EN_CLIENTE_DESTINO||'] EN_ABONADO_DESTINO['||EN_ABONADO_DESTINO;
    LV_DESESTADO := LV_DESESTADO || '] EN_PROD_CONTRATADO['||ln_cod_prod_contratado||'] EN_PROD_OFERTADO['||EN_PROD_OFERTADO;
    LV_DESESTADO := LV_DESESTADO || '] ED_FECHA_ALTA['||ED_FECHA_ALTA||'] ED_FECHA_BAJA['||ED_FECHA_BAJA;
    LV_DESESTADO := LV_DESESTADO || '] EN_NUM_MOV_ANT['||EN_NUM_MOV_ANT||'] EN_NUM_PROCESO['||EN_NUM_PROCESO||']';

    LV_INFO_REG := 'Despues de: TOL_PRODUCTO_CONTRATADO_PG.TOL_ALTA_fACHADA_PR@LNK_PRODUC_SCL_TOL('||ln_cod_prod_contratado||','||ed_fecha_baja||')';
    LV_NomProc := 'PV_AGREGA_FN';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';
    LNEstado := SN_NUM_EVENTO;
    LVCode := SN_COD_RETORNO;
    LVErrm := SV_MENS_RETORNO;

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    NULL, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    --Fin Prueba Traza

          IF (sn_cod_retorno != 0) THEN
            pv_general_ooss_pg.PV_AUDREG_PR(
               'PA', en_abonado_destino, 1, '4', NULL, 'PA',  NULL, 'ERROR INVOCANDO A TOL', LV_SSQL, 'tol_producto_contratado_pg.tol_alta_fachada_pr',
               'TOL', 'I', NULL, sn_cod_retorno, sv_mens_retorno, sn_num_evento, LNEstado, LVCode,  LVErrm
            );
            RAISE error_subfuncion;
          END IF;


          IF (ln_cod_prov_serv IS NOT NULL) THEN
            --Se prepara la estructura para enviar a centrales
            lo_lista_centrales.cod_cliente      := lo_abonado.cod_cliente;
            lo_lista_centrales.cod_prov_serv    := ln_cod_prov_serv;
            lo_lista_centrales.tip_accion       := '1';
            lo_lista_centrales.tip_ser          := lv_ind_tipo_servicio;
            lo_lista_centrales.cod_prod_contrat := ln_cod_prod_contratado;
            lo_lista_centrales.fecha_ejecucion  := ed_fecha_alta;
            lo_lista_centrales.num_celular      := lo_abonado.num_celular;
            lo_lista_centrales.NUM_ABONADO      := lo_abonado.NUM_ABONADO;
            lo_lista_centrales.tip_terminal     := lo_abonado.tip_terminal;
            lo_lista_centrales.cod_central      := lo_abonado.cod_central;
            lo_lista_centrales.num_serie        := lo_abonado.num_serie;
            lo_lista_centrales.cod_tecnologia   := lo_abonado.cod_tecnologia;
            lo_lista_centrales.id_plan          := lv_cod_servicio_base;
            lo_lista_centrales.importe          := '0';
            lo_lista_centrales.cod_moneda       := '0';
            lo_lista_centrales.usuario          := 'SCL';
            lo_lista_centrales.cod_causa        := '00';
            lo_lista_centrales.monto_bonif      := '0';
            lo_lista_centrales.tipo_bono        := '0';
            lo_lista_centrales.cod_periodif     := NULL;
            lo_lista_centrales.fecha_ejec_bono  := ed_fecha_alta;
            lo_lista_centrales.num_movant       := en_num_mov_ant;
            lo_lista_centrales.nom_usuarora     := lv_usuario;
            --Se informa el movimiento a centrales
            lv_ssql := 'Ic_Provision_Pg.ic_inserta_pr(';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_cliente || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_prov_serv || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.tip_accion || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.tip_ser || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_prod_contrat || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.fecha_ejecucion || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.num_celular || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.NUM_ABONADO || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.tip_terminal || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_central || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.num_serie || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_tecnologia || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.id_plan || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.importe || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_moneda || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.usuario || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_causa || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.monto_bonif || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.tipo_bono || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_periodif || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.fecha_ejec_bono || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.num_movant || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.nom_usuarora || ');';
            Ic_Provision_Pg.ic_inserta_pr(lo_lista_centrales,
                                          sn_cod_retorno,
                                          sv_mens_retorno,
                                          sn_num_evento);

            IF (sn_cod_retorno != 0) THEN
              RAISE error_subfuncion;
            END IF;
          END IF;

        ELSIF (lv_ind_tipo_servicio = 'AA') THEN

          --Se prepara la estructura para enviar a centrales
          lo_lista_centrales.cod_cliente      := lo_abonado.cod_cliente;
          lo_lista_centrales.cod_prov_serv    := ln_cod_prov_serv;
          lo_lista_centrales.tip_accion       := '1';
          lo_lista_centrales.tip_ser          := lv_ind_tipo_servicio;
          lo_lista_centrales.cod_prod_contrat := ln_cod_prod_contratado;
          lo_lista_centrales.fecha_ejecucion  := ed_fecha_alta;
          lo_lista_centrales.num_celular      := lo_abonado.num_celular;
          lo_lista_centrales.NUM_ABONADO      := lo_abonado.NUM_ABONADO;
          lo_lista_centrales.tip_terminal     := lo_abonado.tip_terminal;
          lo_lista_centrales.cod_central      := lo_abonado.cod_central;
          lo_lista_centrales.num_serie        := lo_abonado.num_serie;
          lo_lista_centrales.cod_tecnologia   := lo_abonado.cod_tecnologia;
          lo_lista_centrales.id_plan          := lv_cod_servicio_base;
          lo_lista_centrales.importe          := '0';
          lo_lista_centrales.cod_moneda       := '0';
          lo_lista_centrales.usuario          := 'SCL';
          lo_lista_centrales.cod_causa        := '00';
          lo_lista_centrales.monto_bonif      := ln_can_bonificar;
          lo_lista_centrales.tipo_bono        := lv_tipo_unidad_bonificar;
          lo_lista_centrales.cod_periodif     := NULL;
          lo_lista_centrales.fecha_ejec_bono  := ed_fecha_alta;
          lo_lista_centrales.num_movant       := en_num_mov_ant;
          lo_lista_centrales.nom_usuarora     := lv_usuario;
          lv_ssql := 'Ic_Provision_Pg.ic_inserta_pr(';
          lv_ssql := lv_ssql || lo_lista_centrales.cod_cliente || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.cod_prov_serv || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.tip_accion || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.tip_ser || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.cod_prod_contrat || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.fecha_ejecucion || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.num_celular || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.NUM_ABONADO || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.tip_terminal || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.cod_central || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.num_serie || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.cod_tecnologia || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.id_plan || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.importe || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.cod_moneda || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.usuario || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.cod_causa || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.monto_bonif || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.tipo_bono || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.cod_periodif || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.fecha_ejec_bono || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.num_movant || ',';
          lv_ssql := lv_ssql || lo_lista_centrales.nom_usuarora || ');';
          --Se informa el movimiento a centrales
          Ic_Provision_Pg.ic_inserta_pr(lo_lista_centrales,
                                        sn_cod_retorno,
                                        sv_mens_retorno,
                                        sn_num_evento);

          IF (sn_cod_retorno != 0) THEN
            RAISE error_subfuncion;
          END IF;
        END IF;

        --Inicio Inc. 170939 - 07/08/2011 - FDL
        -- Se verifica si el abonado es prepago, para no cobrar los cargos
        select count(1)
        into ln_esprepago
        from ga_aboamist
        where num_abonado = en_abonado_destino;
        --Fin Inc. 170939 - 07/08/2011 - FDL

    -- INI Traza 200250|06-11-2013
    LV_DESESTADO := 'EN_CLIENTE_DESTINO['||EN_CLIENTE_DESTINO||'] EN_ABONADO_DESTINO['||EN_ABONADO_DESTINO;
    LV_DESESTADO := LV_DESESTADO || '] EN_PROD_CONTRATADO['||ln_cod_prod_contratado||'] EN_PROD_OFERTADO['||EN_PROD_OFERTADO;
    LV_DESESTADO := LV_DESESTADO || '] ED_FECHA_ALTA['||ED_FECHA_ALTA||'] ED_FECHA_BAJA['||ED_FECHA_BAJA;
    LV_DESESTADO := LV_DESESTADO || '] EN_NUM_MOV_ANT['||EN_NUM_MOV_ANT||'] EN_NUM_PROCESO['||EN_NUM_PROCESO;
    LV_DESESTADO := LV_DESESTADO || '] EV_IND_CONTRATA['||ev_ind_contrata;
    LV_DESESTADO := LV_DESESTADO || '] EV_IND_HIJO['||ev_ind_hijo||'] LN_ESPREPAGO['||ln_esprepago;

    LV_INFO_REG := 'Antes de IF (ev_ind_contrata = = O OR ev_ind_contrata = B) AND  (ev_ind_hijo = N)) AND (ln_esprepago = 0)';
    LV_NomProc := 'PV_AGREGA_FN';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    200250, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    -- FIN Traza 200250|06-11-2013

        -- CSR_200250|11-11-2013|JHA
        -- se agrega ev_ind_contrata = 'D' para cargos por defecto
        -- IF ((ev_ind_contrata = 'O' OR ev_ind_contrata = 'B') AND
        IF ((ev_ind_contrata = 'O' OR ev_ind_contrata = 'B' OR ev_ind_contrata = 'D') AND
           (ev_ind_hijo = 'N')) AND (ln_esprepago = 0)
            --IF ((ev_ind_contrata = 'O') AND (ev_ind_hijo = 'N'))
         THEN
            lv_ssql := ' SELECT cargos.monto_importe, cargos.cod_moneda, catalogo.cod_concepto,';
            lv_ssql := lv_ssql || ' DECODE(concepto.ind_prorrateable,''S'',1,0), cargos.cod_cargo';
            lv_ssql := lv_ssql || ' FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,';
            lv_ssql := lv_ssql || ' pf_conceptos_prod_td concepto';
            lv_ssql := lv_ssql || ' WHERE  catalogo.cod_concepto = concepto.cod_concepto';
            lv_ssql := lv_ssql || ' AND       catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado';
            lv_ssql := lv_ssql || ' AND       catalogo.cod_cargo = cargos.cod_cargo';
            lv_ssql := lv_ssql || ' AND       catalogo.cod_prod_ofertado = ' ||en_prod_ofertado;
            lv_ssql := lv_ssql || ' AND       catalogo.cod_canal = ' ||ev_cod_canal;
            lv_ssql := lv_ssql || ' AND       catalogo.fec_inicio_vigencia <= ' ||ed_fecha_alta;
            lv_ssql := lv_ssql || ' AND       catalogo.fec_termino_vigencia >= ' ||ed_fecha_baja;

            --                LV_sSql := LV_sSql || ' AND       concepto.tipo_cargo = ''''R''';
            --Se buscan los cargos recurrentes
            OPEN c_cargos FOR
                SELECT cargos.monto_importe,
                    cargos.cod_moneda,
                    catalogo.cod_concepto,
                    DECODE(concepto.ind_prorrateable, 'S', 1, 0),
                    cargos.cod_cargo,
                    concepto.tipo_cargo
                FROM pf_cargos_productos_td  cargos,
                    pf_catalogo_ofertado_td catalogo,
                    pf_conceptos_prod_td    concepto
                WHERE catalogo.cod_concepto = concepto.cod_concepto
                AND catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado
                AND catalogo.cod_cargo = cargos.cod_cargo
                AND catalogo.cod_prod_ofertado = en_prod_ofertado
                AND catalogo.cod_canal = ev_cod_canal
                --ini 194913
                --AND ED_FECHA_ALTA BETWEEN catalogo.fec_inicio_vigencia AND catalogo.fec_termino_vigencia;
                AND SYSDATE BETWEEN catalogo.fec_inicio_vigencia AND catalogo.fec_termino_vigencia;
               --fin 194913

            --AND catalogo.fec_inicio_vigencia <= ed_fecha_alta
            --AND catalogo.fec_termino_vigencia >= ed_fecha_baja;

            --                AND       concepto.tipo_cargo = 'R';

            --Se incializa la estructura de cargos Recurrentes
            lo_cargos_rec := fa_cargos_rec_qt( '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '');
            --Se incializa la estructura de cargos ocasionales
            lo_cargos := fa_cargos_qt('',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '');


          LOOP
            FETCH c_cargos INTO ln_monto_importe, lv_cod_moneda, ln_cod_concepto, ln_ind_prorrateable, ln_cod_cargo, lv_tip_cargo;

            EXIT WHEN c_cargos%NOTFOUND;

    -- INI Traza 200250|06-11-2013
    LV_DESESTADO := 'EN_CLIENTE_DESTINO['||EN_CLIENTE_DESTINO||'] EN_ABONADO_DESTINO['||EN_ABONADO_DESTINO;
    LV_DESESTADO := LV_DESESTADO || '] EN_PROD_CONTRATADO['||ln_cod_prod_contratado||'] EN_PROD_OFERTADO['||EN_PROD_OFERTADO;
    LV_DESESTADO := LV_DESESTADO || '] ED_FECHA_ALTA['||ED_FECHA_ALTA||'] ED_FECHA_BAJA['||ED_FECHA_BAJA;
    LV_DESESTADO := LV_DESESTADO || '] EN_NUM_MOV_ANT['||EN_NUM_MOV_ANT||'] EN_NUM_PROCESO['||EN_NUM_PROCESO;
    LV_DESESTADO := LV_DESESTADO || '] LV_TIP_CARGO['||lv_tip_cargo||']';

    LV_INFO_REG := 'Antes de IF (lv_tip_cargo = R) ';
    LV_NomProc := 'PV_AGREGA_FN';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    200250, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    -- FIN Traza 200250|06-11-2013

            IF (lv_tip_cargo = 'R') THEN
              --Se prepara la estructura para informar cargos recurrentes
              lo_cargos_rec.cod_clienteserv      := en_cliente_destino;
              lo_cargos_rec.num_abonadoserv      := en_abonado_destino;
              lo_cargos_rec.cod_prod_contratado  := ln_cod_prod_contratado;
              lo_cargos_rec.cod_cargo_contratado := ln_cod_cargo;
              lo_cargos_rec.cod_clientepago      := en_cliente_destino;
              lo_cargos_rec.num_abonadopago      := en_abonado_destino;
              --                LO_CARGOS_REC.COD_TIPSERV          := ;--VARCHAR2(2)
              --                LO_CARGOS_REC.COD_SERVICIO         := ;--VARCHAR2(5)
              lo_cargos_rec.cod_planserv  := lo_abonado.cod_planserv;
              lo_cargos_rec.ind_cargopro  := ln_ind_prorrateable;
              lo_cargos_rec.cod_concepto  := ln_cod_concepto;
              lo_cargos_rec.fec_alta      := ed_fecha_alta;
              --lo_cargos_rec.fec_baja      := ed_fecha_baja; -- FPP 08-07-2010
              lo_cargos_rec.fec_baja      := NULL; -- FPP 08-07-2010
              lo_cargos_rec.fec_desdecobr := ed_fecha_alta;
              --lo_cargos_rec.fec_hastacobr := ed_fecha_baja; -- FPP 08-07-2010
              lo_cargos_rec.fec_hastacobr := NULL; -- FPP 08-07-2010
              --                LO_CARGOS_REC.IND_BLOQUEO          := ;--VARCHAR2(5)
              --                LO_CARGOS_REC.EST_BLOQUEO          := ;--VARCHAR2(5)
              lo_cargos_rec.fec_desdebloc := ed_fecha_alta;
              --lo_cargos_rec.fec_hastabloc := ed_fecha_baja; -- FPP 08-07-2010
              lo_cargos_rec.fec_hastabloc := NULL; -- FPP 08-07-2010
              --lo_cargos_rec.fec_hastabloc :=   lo_cargos_rec.fec_desdebloc; -- FPP 16-09-2010 -- FPP 27-09-2010
              --                LO_CARGOS_REC.FEC_ULTFACTURA       := ;--DATE
              --                LO_CARGOS_REC.COD_ULTCICLFACT      := ;--NUMBER(10)
              --                LO_CARGOS_REC.NUM_ULTPROCESO       := ;--NUMBER(10)
              --                LO_CARGOS_REC.FEC_ULTMOD           := ;--DATE
              lo_cargos_rec.nom_usuario := lv_usuario;--VARCHAR2(30)
              lv_ssql := 'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR(' ||
                         en_cliente_destino || ', ' || en_abonado_destino || ', ' ||
                         ln_cod_prod_contratado || ', ' || ln_cod_cargo || ', ' ||
                         lo_abonado.cod_planserv || ', ' ||
                         ln_ind_prorrateable || ', ' || ln_cod_concepto || ')';

    -- INI Traza 200250|06-11-2013
    LV_DESESTADO := lv_ssql;

    LV_INFO_REG := 'Antes de FA_CARGOS_SN_PG.FA_CARGOS_REC_ALTA_PR ';
    LV_NomProc := 'PV_AGREGA_FN';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    200250, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    -- FIN Traza 200250|06-11-2013

              Fa_Cargos_Rec_Sn_Pg.fa_cargos_rec_alta_pr(lo_cargos_rec,
                                                        sn_cod_retorno,
                                                        sv_mens_retorno,
                                                        sn_num_evento);

              IF (sn_cod_retorno != 0) THEN
                RAISE error_subfuncion;
              END IF;
            ELSE

                LV_sSql:= 'SELECT cod_ciclfact';
                LV_sSql:= LV_sSql ||' FROM fa_ciclfact';
                LV_sSql:= LV_sSql ||'    WHERE  cod_ciclo  = '||LO_ABONADO.COD_CICLO;
                LV_sSql:= LV_sSql ||' AND sysdate BETWEEN fec_desdeocargos AND fec_hastaocargos';

                BEGIN
                    --Inicio Inc. 170939 - 07/08/2011 - FDL
                    SELECT fec_desdeocargos
                    INTO ld_fec_desdeocargos
                    FROM FA_CICLFACT
                    WHERE cod_ciclo = lo_abonado.cod_ciclo
                    AND SYSDATE BETWEEN fec_desdeocargos AND fec_hastaocargos;

                    IF trunc(ld_fec_desdeocargos) = trunc(sysdate) THEN
                        -- Corresponde a un cambio de plan a ciclo, por lo que el ciclo de facturacion
                        -- debe ser el anterior para que sea cobrado en el ciclo de facturacion actual
                        -- de lo contrario quedara para ser cobrado a fin del proximo ciclo
                        SELECT cod_ciclfact
                        INTO lo_cargos.cod_ciclfact
                        FROM FA_CICLFACT
                        WHERE cod_ciclo = lo_abonado.cod_ciclo
                        -- ciclo de facturación del contratante (cod_ciclo)
                        AND SYSDATE -2 BETWEEN fec_desdeocargos AND
                        fec_hastaocargos;
                    ELSE
                        SELECT cod_ciclfact
                        INTO lo_cargos.cod_ciclfact
                        FROM FA_CICLFACT
                        WHERE cod_ciclo = lo_abonado.cod_ciclo
                        -- ciclo de facturación del contratante (cod_ciclo)
                        AND SYSDATE BETWEEN fec_desdeocargos AND
                        fec_hastaocargos;

                    END IF;
                    --Fin Inc. 170939 - 07/08/2011 - FDL
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        sn_cod_retorno := 1411;
                        IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
                            sv_mens_retorno := cv_error_no_clasif;
                        END IF;
                        lv_des_error  := 'PV_PLANES_ADICIONALES_PG(' || '); - ' ||SQLERRM;
                        sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento,'PV',sv_mens_retorno,cv_version,USER,' PV_PLANES_ADICIONALES_PG.PV_AGREGA_FN',lv_ssql,sn_cod_retorno,lv_des_error);
                    RETURN FALSE;
              END;

              --LO_CARGOS.SEQ_CARGO              := ;--    NUMBER(9),
              lo_cargos.cod_cliente := en_cliente_destino;--    NUMBER(10),
              lo_cargos.NUM_ABONADO := en_abonado_destino;--    NUMBER(10),
              lo_cargos.cod_prod_contratado := ln_cod_prod_contratado;--    NUMBER(38),
              lo_cargos.cod_producto := 1; --    NUMBER(1),
              lo_cargos.id_cargo     := ln_cod_cargo; --    NUMBER(9),
              lo_cargos.cod_concepto := ln_cod_concepto;--    NUMBER(9),
              --LO_CARGOS.COLUMNA                := ;--    NUMBER(6),
              lo_cargos.fec_alta  := ed_fecha_alta; --    DATE,
              lo_cargos.imp_cargo := ln_monto_importe;--    NUMBER(14,4)
              lo_cargos.cod_moneda := lv_cod_moneda;--    VARCHAR2(3),
              lo_cargos.cod_plancom  := 1; --    NUMBER(6),
              lo_cargos.num_unidades := 1; --    NUMBER(6),
              -- lo_cargos.ind_factur   := 9; --    NUMBER(1), -- FPP 20-06-2010
              lo_cargos.ind_factur   := 1; --    NUMBER(1),    -- FPP 20-06-2010
              --LO_CARGOS.NUM_TRANSACCION        := ;--    NUMBER(9),
              --LO_CARGOS.NUM_VENTA            := 0;--    NUMBER(8),
              --LO_CARGOS.NUM_PAQUETE            := ;--    NUMBER(3),
              lo_cargos.num_terminal := lo_abonado.num_celular;--    VARCHAR2(15)
              --LO_CARGOS.COD_CICLFACT        := ;--    NUMBER(6),
              --LO_CARGOS.NUM_SERIE            := ;--    VARCHAR2(25)
              --LO_CARGOS.NUM_SERIEMEC        := ;--    VARCHAR2(20)
              --LO_CARGOS.CAP_CODE            := ;--    NUMBER(7),
              lo_cargos.mes_garantia := 0; --    NUMBER(2),
              --LO_CARGOS.NUM_PREGUIA            := ;--    VARCHAR2(10)
              --LO_CARGOS.NUM_GUIA            := ;--    VARCHAR2(10)
              --LO_CARGOS.COD_CONCEREL        := ;--    NUMBER(8),
              --LO_CARGOS.COLUMNA_REL            := ;--    NUMBER(4),
              --LO_CARGOS.COD_CONCEPTO_DTO    := ;--    NUMBER(4),
              --LO_CARGOS.VAL_DTO                := ;--    NUMBER(14,4)
              --LO_CARGOS.TIP_DTO                := ;--    NUMBER(1),
              lo_cargos.ind_cuota := 0; --    NUMBER(1),
              --LO_CARGOS.NUM_CUOTAS            := ;--    NUMBER(3),
              --LO_CARGOS.ORD_CUOTA            := ;--    NUMBER(3),
              lo_cargos.ind_supertel := 0; --    NUMBER(1),
              --LO_CARGOS.IND_MANUAL            := ;--    NUMBER(1),
              --LO_CARGOS.PREF_PLAZA            := ;--    VARCHAR2(10)
              lo_cargos.cod_tecnologia := lo_abonado.cod_tecnologia;--    VARCHAR2(7),
              --LO_CARGOS.GLS_DESCRIP            := ;--    VARCHAR2(100
              --LO_CARGOS.NUM_FACTURA            := ;--    NUMBER(10),
              lo_cargos.fec_ultmod  := SYSDATE; --    DATE,
              lo_cargos.nom_usuario := lv_usuario;--    VARCHAR2(30)
              lv_ssql := 'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR(' ||
                         en_cliente_destino || ', ' || en_abonado_destino || ', ' ||
                         ln_cod_prod_contratado || ', ' || ln_cod_cargo || ', ' ||
                         ln_cod_concepto || ', ' || ed_fecha_alta || ', ' ||
                         ln_monto_importe || ', ' || lv_cod_moneda || ', ' ||
                         lo_abonado.num_celular || ', ' ||
                         lo_abonado.cod_tecnologia || ', ' || lv_usuario || ')';

    -- INI Traza 200250|06-11-2013
    LV_DESESTADO := lv_ssql;

    LV_INFO_REG := 'Antes de FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR ';
    LV_NomProc := 'PV_AGREGA_FN';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    200250, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    -- FIN Traza 200250|06-11-2013
                         
              Fa_Cargos_Sn_Pg.fa_cargos_alta_pr(lo_cargos,
                                                sn_cod_retorno,
                                                sv_mens_retorno,
                                                sn_num_evento);

              IF (sn_cod_retorno != 0) THEN
                RAISE error_subfuncion;
              END IF;
            END IF;
          END LOOP;

          CLOSE c_cargos;

        END IF;
      END LOOP; -- FIN LOOP DE CANTIDAD


    ELSE
      --Supera el maximo de contrataciones [88108]
      lv_ssql := 'PV_EXCLUSION_PLANES_SS_PG.PV_LOG_EXCLUSION_PR(' ||
                 en_num_proceso || ', ' || en_cliente_destino || ', ' ||
                 en_abonado_destino || ', ' || en_prod_ofertado ||
                 ',3 , ''MAXCONTRA'')';
--      Pv_Exclusion_Planes_Ss_Pg.pv_log_exclusion_pr(en_num_proceso,
--                                                    en_cliente_destino,
--                                                    en_abonado_destino,
--                                                    en_prod_ofertado,
--                                                    3,
--                                                    'MAXCONTRA',
--                                                    sn_cod_retorno,
--                                                    sv_mens_retorno,
--                                                    sn_num_evento);
    END IF; --88108
    --END IF;                                                          --88108

    RETURN TRUE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN TRUE;
    WHEN error_subfuncion THEN
      IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno, sv_mens_retorno) THEN
        sv_mens_retorno := cv_error_no_clasif;
      END IF;

      lv_des_error  := 'PV_PLANES_ADICIONALES_PG(' || '); - ' || SQLERRM;
      sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento,'PV',sv_mens_retorno,cv_version,USER,' PV_PLANES_ADICIONALES_PG.PV_AGREGA_FN',lv_ssql,sn_cod_retorno,lv_des_error);
      RETURN FALSE;
    WHEN OTHERS THEN
      sn_cod_retorno := 156;

      IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno, sv_mens_retorno) THEN
        sv_mens_retorno := cv_error_no_clasif;
      END IF;

      lv_des_error  := 'PV_PLANES_ADICIONALES_PG(' || '); - ' || SQLERRM;
      sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento,'PV',sv_mens_retorno,cv_version,USER,' PV_PLANES_ADICIONALES_PG.PV_AGREGA_FN',lv_ssql,sn_cod_retorno,lv_des_error);
      RETURN FALSE;
  END pv_agrega_fn;

-- Se replica funcion para incorporar parametro para que indica si se cobra o no cargo ocasional
-- (usado para traspasos y cambios de plan)
FUNCTION pv_agrega_fn(
   en_cliente_destino IN GE_CLIENTES.cod_cliente%TYPE,
   en_abonado_destino IN GA_ABOCEL.NUM_ABONADO%TYPE,
   en_prod_ofertado   IN pr_productos_contratados_to.cod_prod_ofertado%TYPE,
   ed_fecha_alta      IN DATE,
   ed_fecha_baja      IN DATE,
   en_num_mov_ant     IN ICC_MOVIMIENTO.num_movant%TYPE,
   en_num_veces       IN pf_paquete_ofertado_to.num_veces_hijo%TYPE,
   en_num_proceso     IN pr_productos_contratados_to.num_proceso%TYPE,
   ev_cod_canal       IN pr_productos_contratados_to.cod_canal%TYPE,
   ev_ind_contrata    IN pr_productos_contratados_to.ind_condicion_contratacion%TYPE,
   en_cod_padre       IN pr_productos_contratados_to.cod_prod_contra_padre%TYPE,
   ev_ind_hijo        IN VARCHAR2,
   ev_cargo_ocasional IN VARCHAR2,
   sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   sn_num_evento      OUT NOCOPY ge_errores_pg.evento
) RETURN BOOLEAN IS
    /*
     <Documentación
       TipoDoc = "Procedure">>
        <Elemento
           Nombre = "PV_AGREGA_FN"
               Lenguaje="PL/SQL"
           Fecha="20-11-2008"
           Versión="La del package"
           Diseñador="Andrés Osorio"
           Programador="Andrés Osorio"
           Ambiente Desarrollo="BD">
           <Retorno>BOOLEAN</Retorno>>
           <Descripción>Realiza la inscripción de un producto en todas las plataformas</Descripción>>
           <Parámetros>
              <Entrada>
                    <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                    <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                    <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                    <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                    <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                    <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                    <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
              </Entrada>
              <Salida>
                 <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
                 <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
                 <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
              </Salida>
           </Parámetros>
        </Elemento>
     </Documentación>
    */

   lv_des_error               ge_errores_pg.desevent;
   lv_ssql                    ge_errores_pg.vquery;
   error_subfuncion           EXCEPTION;
   ln_count                   NUMBER;
   ln_cod_prod_contratado     pr_productos_contratados_to.cod_prod_contratado%TYPE;
   ln_cod_espec_prod          se_detalles_especificacion_to.cod_espec_prod%TYPE;
   ln_cod_perfil_lista        se_detalles_especificacion_to.cod_perfil_lista%TYPE;
   ln_cod_prov_serv           se_detalles_especificacion_to.cod_prov_serv%TYPE;
   lv_cod_servicio_base       se_detalles_especificacion_to.cod_servicio_base%TYPE;
   lv_ind_tipo_servicio       se_detalles_especificacion_to.ind_tipo_servicio%TYPE;
   lv_tipo_comportamiento     ps_especificaciones_prod_td.tipo_comportamiento%TYPE;
   lv_tipo_plataforma         ps_especificaciones_prod_td.tipo_plataforma%TYPE;
   lv_tipo_unidad_bonificar   se_planes_altamira_td.tipo_unidad_bonificar%TYPE;
   ln_can_bonificar           se_planes_altamira_td.can_bonificar%TYPE;
   c_pro_defecto              refcursor;
   c_cargos                   refcursor;
   lo_cargos_rec              fa_cargos_rec_qt;
   lo_abonado                 ga_abonado_qt;
   lo_producto                pr_productos_conts_to_qt;
   lo_lista_numeros           sv_prod_contr_lst_qt;
   lo_lista_centrales         ic_provision_qt;
   lo_cliente                 pv_cliente_qt;
   lo_cargos                  fa_cargos_qt;
   ln_monto_importe           pf_cargos_productos_td.monto_importe%TYPE;
   lv_cod_moneda              pf_cargos_productos_td.cod_moneda%TYPE;
   ln_cod_cargo               pf_cargos_productos_td.cod_cargo%TYPE;
   ln_cod_concepto            pf_catalogo_ofertado_td.cod_concepto%TYPE;
   lv_tip_cargo               pf_conceptos_prod_td.tipo_cargo%TYPE;
   ln_ind_prorrateable        NUMBER;
   lv_ind_nivel_aplica        pf_productos_ofertados_td.ind_nivel_aplica%TYPE;
   lv_usuario                 GA_ABOCEL.nom_usuarora%TYPE;
   ld_fecdesdecargos          FA_CICLFACT.fec_desdeocargos%TYPE;
   ld_fechastacargos          FA_CICLFACT.fec_hastaocargos%TYPE;
   ln_cod_padre               pr_productos_contratados_to.cod_prod_contra_padre%TYPE;
   ln_max_contra              pf_productos_ofertados_td.max_contrataciones%TYPE;   --88108
   ln_can_contra              NUMBER; --88108
   ln_num_veces               NUMBER; --88108
   ln_can_oblig               NUMBER; -- FPP 21-06-2010
   ld_fec_desdeocargos        DATE; -- FPP 13-07-2010 Defecto 82
   ln_esprepago               NUMBER; -- FPP 28-07-2010 Defecto 110
   lv_cargo_recurrente        BOOLEAN; -- FPP 26-08-2010 Defecto 131
   LV_DESESTADO               VARCHAR2(2000);
   LV_INFO_REG                VARCHAR2(2000);
   LV_NomProc                 VARCHAR2(2000);
   LV_Tabla                   VARCHAR2(30);
   LV_Act                     VARCHAR2(1);
   LNEstado                   NUMBER;
   LVCode                     VARCHAR2(2000);
   LVErrm                     VARCHAR2(2000);
BEGIN
   sn_cod_retorno  := 0;
   sv_mens_retorno := NULL;
   sn_num_evento   := 0;
   lv_cargo_recurrente := FALSE; -- FPP 26-08-2010 Defecto 131



   --Se obtiene el usuario de la OOSS
   BEGIN
      SELECT usuario INTO lv_usuario
      FROM PV_IORSERV
      WHERE num_os = en_num_proceso
      UNION
      SELECT usuario FROM CI_ORSERV WHERE num_os = en_num_proceso;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         lv_usuario := USER;
   END;

   lo_lista_centrales := ic_provision_qt();
   --Se prepara estructura para obtener datos del abonado
   lo_abonado := ga_abonado_qt(en_abonado_destino,'','','','','','','','','','','','','','','','','','','','','','','','','',
                  '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                  '','','','','','','','','','');

   --Se prepara estructura para obtener datos del abonado
   lo_cliente := pv_cliente_qt(en_cliente_destino,'','','','','','','','','','','','','','','','','','','','','','','','','',
                  '','','','','','','','','','','','','','','');

   IF (en_abonado_destino != 0 AND en_abonado_destino IS NOT NULL) THEN
      lv_ind_nivel_aplica := 'A';
      --Se Obtienen los datos del abonado
      Pv_Datos_Abonado_Pg.pv_obtiene_datos_abonado_pr(lo_abonado,sn_cod_retorno,sv_mens_retorno,sn_num_evento);
      IF (sn_cod_retorno != 0) THEN
         RAISE error_subfuncion;
      END IF;
   ELSE
      lv_ind_nivel_aplica := 'C';
      Pv_Datos_Clientes_Pg.pv_obtiene_datos_cliente_pr(lo_cliente,sn_cod_retorno,sv_mens_retorno,sn_num_evento);
      lo_abonado.cod_ciclo      := lo_cliente.cod_ciclo;
      lo_abonado.cod_cliente    := lo_cliente.cod_cliente;
      lo_abonado.tip_terminal   := lo_cliente.tip_terminal;
      lo_abonado.cod_tecnologia := lo_cliente.cod_tecnologia;
   END IF;

   --Inicio Inc. 170939 - 07/08/2011 - FDL
   lv_ssql := 'SELECT NVL(max_contrataciones,0) FROM pf_productos_ofertados_td WHERE cod_prod_ofertado = ' ||en_prod_ofertado;

   SELECT NVL(max_contrataciones, 0)
   INTO ln_max_contra
   FROM pf_productos_ofertados_td
   WHERE cod_prod_ofertado = en_prod_ofertado;

   IF (ln_max_contra > 0) THEN
      lv_ssql := 'SELECT COUNT(0)';
      lv_ssql := lv_ssql || ' FROM pr_productos_contratados_to';
      lv_ssql := lv_ssql || ' WHERE cod_prod_ofertado = ' || en_prod_ofertado;
      lv_ssql := lv_ssql || ' AND    cod_cliente_contratante = ' || en_cliente_destino;
      lv_ssql := lv_ssql || ' AND    num_abonado_contratante = ' || en_abonado_destino;

      SELECT COUNT(0)
      INTO ln_can_contra
      FROM pr_productos_contratados_to
      WHERE cod_prod_ofertado = en_prod_ofertado
      AND cod_cliente_contratante = en_cliente_destino
      AND num_abonado_contratante = en_abonado_destino;
   END IF;

   IF (ln_can_contra < ln_max_contra) OR (ln_max_contra = 0) THEN
      --Fin Inc. 170939 - 07/08/2011 - FDL
      --Se buscan los datos necesarios para contratar productos
      lv_ssql := 'SELECT servicio.cod_espec_prod, servicio.cod_perfil_lista, servicio.cod_prov_serv, servicio.cod_servicio_base,';
      lv_ssql := lv_ssql || ' servicio.ind_tipo_servicio, espec.tipo_comportamiento, espec.tipo_plataforma';
      lv_ssql := lv_ssql || ' FROM   pf_productos_ofertados_td ofertado, ps_especificaciones_prod_td espec, se_detalles_especificacion_to servicio';
      lv_ssql := lv_ssql || ' WHERE  ofertado.cod_espec_prod = espec.cod_espec_prod';
      lv_ssql := lv_ssql || ' AND       ofertado.cod_espec_prod = servicio.cod_espec_prod';
      lv_ssql := lv_ssql || ' AND       ofertado.cod_prod_ofertado = ' || en_prod_ofertado;
      lv_ssql := lv_ssql || ' AND       ofertado.ind_nivel_aplica = ' || lv_ind_nivel_aplica;

      SELECT servicio.cod_espec_prod, NVL(servicio.cod_perfil_lista, 0), servicio.cod_prov_serv, servicio.cod_servicio_base,
      servicio.ind_tipo_servicio, espec.tipo_comportamiento, espec.tipo_plataforma
      INTO ln_cod_espec_prod, ln_cod_perfil_lista, ln_cod_prov_serv, lv_cod_servicio_base,
      lv_ind_tipo_servicio, lv_tipo_comportamiento, lv_tipo_plataforma
      FROM pf_productos_ofertados_td ofertado, ps_especificaciones_prod_td espec, se_detalles_especificacion_to servicio
      WHERE ofertado.cod_espec_prod = espec.cod_espec_prod
      AND ofertado.cod_espec_prod = servicio.cod_espec_prod
      AND ofertado.cod_prod_ofertado = en_prod_ofertado
      AND ofertado.ind_nivel_aplica = lv_ind_nivel_aplica;

      IF (lv_ind_tipo_servicio = 'AA') THEN
         lv_ssql := 'SELECT altamira.tipo_unidad_bonificar, altamira.can_bonificar';
         lv_ssql := lv_ssql || ' FROM   se_planes_altamira_td altamira';
         lv_ssql := lv_ssql || ' WHERE  altamira.cod_plan_altamira = ' || lv_cod_servicio_base;

         SELECT altamira.tipo_unidad_bonificar, altamira.can_bonificar
         INTO lv_tipo_unidad_bonificar, ln_can_bonificar
         FROM se_planes_altamira_td altamira
         WHERE altamira.cod_plan_altamira = lv_cod_servicio_base;
      END IF;

      /*--- 88108 ---*/
      IF (en_num_veces + ln_can_contra > ln_max_contra) THEN
         ln_num_veces := ln_max_contra - ln_can_contra;
      ELSE
         ln_num_veces := en_num_veces;
      END IF;

      /*--- 88108 ---*/
      --  FOR LN_COUNT IN 1..EN_NUM_VECES
      FOR ln_count IN 1 .. ln_num_veces --88108
      LOOP
         --Se obtiene el secuencial de producto contratado
         lv_ssql := 'SELECT PF_PRODUCTOS_CONTRATADOS_SQ.NEXTVAL FROM dual caso 2';

         SELECT pf_productos_contratados_sq.NEXTVAL
         INTO ln_cod_prod_contratado
         FROM DUAL;
/*
         IF (en_cod_padre IS NULL) THEN
            ln_cod_padre := ln_cod_prod_contratado;
         ELSE
            ln_cod_padre := en_cod_padre;
         END IF;*/


lv_ssql := '2.- lo_producto := pr_productos_conts_to_qt('||LN_COD_PROD_CONTRATADO||','
                                                ||EN_CLIENTE_DESTINO||','
                                                ||EN_ABONADO_DESTINO||','
                                                ||EN_PROD_OFERTADO||','
                                                ||ED_FECHA_ALTA||','
                                                ||EV_COD_CANAL||','
                                                ||EN_NUM_PROCESO||','
                                                ||EV_COD_CANAL||','
                                                ||SYSDATE||','
                                                ||'OK,'
                                                ||EV_IND_CONTRATA||','
                                                ||en_cliente_destino||','
                                                ||en_abonado_destino||','
                                                ||'31-12-3000,'
                                                ||'1,'
                                                ||LN_COD_PROD_CONTRATADO||','
                                                ||ln_cod_perfil_lista||','
                                                ||lv_tipo_comportamiento||','
                                                ||'NULL,'
                                                ||'NULL);';





         --Se prepara el arreglo de producto
         lo_producto := pr_productos_conts_to_qt( ln_cod_prod_contratado,
                                                  en_cliente_destino,
                                                  en_abonado_destino,
                                                  en_prod_ofertado,
                                                  ed_fecha_alta,
                                                  ev_cod_canal,
                                                  en_num_proceso,
                                                  ev_cod_canal,
                                                  SYSDATE,
                                                  'OK',
                                                  ev_ind_contrata,
                                                  en_cliente_destino,
                                                  en_abonado_destino,
                                                  ed_fecha_baja,
                                                  1,
                                                  ln_cod_padre,
                                                  ln_cod_perfil_lista,
                                                  lv_tipo_comportamiento,
                                                  NULL,
                                                  NULL);



         --Se contrata el Producto
         lv_ssql := 'PR_PRODUCTOS_CONTRATADOS_PG.PR_CONTRATA_I_PR(';
         lv_ssql := lv_ssql || ln_cod_prod_contratado || ', ' || en_cliente_destino || ', ';
         lv_ssql := lv_ssql || en_abonado_destino || ', ' || en_prod_ofertado || ', ';
         lv_ssql := lv_ssql || to_char(ed_fecha_alta,'DD-MM-YYYY HH24:MI:SS') || ', ' || ev_cod_canal || ', ';
         lv_ssql := lv_ssql || en_num_proceso || ', ' || ev_cod_canal || ', ';
         lv_ssql := lv_ssql || SYSDATE || ', ' || 'OK, ' || ev_ind_contrata || ',';
         lv_ssql := lv_ssql || en_cliente_destino || ', ' || en_abonado_destino || ', ';
         lv_ssql := lv_ssql || ed_fecha_baja || ', ' || '1 ' || ln_cod_padre || ', ';
         lv_ssql := lv_ssql || ln_cod_perfil_lista || ', ' || lv_tipo_comportamiento || ')';

         pr_productos_contratados_pg.pr_contrata_i_pr(lo_producto, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

         /* 10-01-2011 160835|12-01-2011|EFR
         pv_general_ooss_pg.PV_AUDREG_PR(
            'PA', en_abonado_destino, 1, '3', NULL, 'PA',  NULL, 'INSERTANDO PRODUCTO', LV_SSQL, 'pr_productos_contratados_pg.pr_contrata_i_pr',
            'TOL', 'I', NULL, sn_cod_retorno, sv_mens_retorno, sn_num_evento, LNEstado, LVCode,  LVErrm
         );
         */

         IF (sn_cod_retorno != 0) THEN
            RAISE error_subfuncion;
         END IF;
         /* 160835|12-01-2011|EFR
         pv_general_ooss_pg.PV_AUDREG_PR(
            'PA', en_abonado_destino, 1, '3', NULL, 'PA',  NULL, 'DESPUES DE INSERTAR PRODUCTO', TO_CHAR(ed_fecha_alta,'DD-MM-YYYY HH24:MI:SS'), 'pr_productos_contratados_pg.pr_contrata_i_pr',
            'TOL', 'I', NULL, sn_cod_retorno, sv_mens_retorno, sn_num_evento, LNEstado, LVCode,  LVErrm
         );
         */

         IF (lv_ind_tipo_servicio = 'TOL') THEN
            --Se informa el producto contratado a TOL
            lv_ssql := 'TOL_PRODUCTO_CONTRATADO_PG.TOL_ALTA_FACHADA_PR(';
            lv_ssql := lv_ssql || en_abonado_destino || ', ' || to_char(ed_fecha_alta,'dd-mm-yyyy hh24:mi:ss') || ', ';
            lv_ssql := lv_ssql || '31-12-3000' || ', ' || lv_cod_servicio_base || ', ';
            lv_ssql := lv_ssql || ln_cod_prod_contratado || ', ' || 1 || ', ';
            lv_ssql := lv_ssql || en_cliente_destino || ', ' || ev_cod_canal || ', ';
            lv_ssql := lv_ssql || lo_abonado.cod_ciclo || ')';
            tol_producto_contratado_pg.tol_alta_fachada_pr(en_abonado_destino,ed_fecha_alta, --ed_fecha_baja,
               to_date('31-12-3000', 'dd-mm-yyyy'), -- FPP 22-09-2010
               lv_cod_servicio_base, ln_cod_prod_contratado, 1, en_cliente_destino, ev_cod_canal, lo_abonado.cod_ciclo, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

            IF (sn_cod_retorno != 0) THEN
               pv_general_ooss_pg.PV_AUDREG_PR(
                  'PA', en_abonado_destino, 1, '4', NULL, 'PA',  NULL, 'ERROR INVOCANDO A TOL', LV_SSQL, 'tol_producto_contratado_pg.tol_alta_fachada_pr',
                  'TOL', 'I', NULL, sn_cod_retorno, sv_mens_retorno, sn_num_evento, LNEstado, LVCode,  LVErrm
               );
               RAISE error_subfuncion;
            END IF;


            IF (ln_cod_prov_serv IS NOT NULL) THEN
               --Se prepara la estructura para enviar a centrales
               lo_lista_centrales.cod_cliente      := lo_abonado.cod_cliente;
               lo_lista_centrales.cod_prov_serv    := ln_cod_prov_serv;
               lo_lista_centrales.tip_accion       := '1';
               lo_lista_centrales.tip_ser          := lv_ind_tipo_servicio;
               lo_lista_centrales.cod_prod_contrat := ln_cod_prod_contratado;
               lo_lista_centrales.fecha_ejecucion  := ed_fecha_alta;
               lo_lista_centrales.num_celular      := lo_abonado.num_celular;
               lo_lista_centrales.NUM_ABONADO      := lo_abonado.NUM_ABONADO;
               lo_lista_centrales.tip_terminal     := lo_abonado.tip_terminal;
               lo_lista_centrales.cod_central      := lo_abonado.cod_central;
               lo_lista_centrales.num_serie        := lo_abonado.num_serie;
               lo_lista_centrales.cod_tecnologia   := lo_abonado.cod_tecnologia;
               lo_lista_centrales.id_plan          := lv_cod_servicio_base;
               lo_lista_centrales.importe          := '0';
               lo_lista_centrales.cod_moneda       := '0';
               lo_lista_centrales.usuario          := 'SCL';
               lo_lista_centrales.cod_causa        := '00';
               lo_lista_centrales.monto_bonif      := '0';
               lo_lista_centrales.tipo_bono        := '0';
               lo_lista_centrales.cod_periodif     := NULL;
               lo_lista_centrales.fecha_ejec_bono  := ed_fecha_alta;
               lo_lista_centrales.num_movant       := en_num_mov_ant;
               lo_lista_centrales.nom_usuarora     := lv_usuario;
               lv_ssql := 'Ic_Provision_Pg.ic_inserta_pr(';
               lv_ssql := lv_ssql || lo_lista_centrales.cod_cliente || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.cod_prov_serv || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.tip_accion || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.tip_ser || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.cod_prod_contrat || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.fecha_ejecucion || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.num_celular || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.NUM_ABONADO || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.tip_terminal || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.cod_central || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.num_serie || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.cod_tecnologia || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.id_plan || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.importe || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.cod_moneda || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.usuario || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.cod_causa || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.monto_bonif || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.tipo_bono || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.cod_periodif || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.fecha_ejec_bono || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.num_movant || ',';
               lv_ssql := lv_ssql || lo_lista_centrales.nom_usuarora || ');';
               --Se informa el movimiento a centrales
               Ic_Provision_Pg.ic_inserta_pr(lo_lista_centrales,sn_cod_retorno,sv_mens_retorno,sn_num_evento);
               IF (sn_cod_retorno != 0) THEN
                  RAISE error_subfuncion;
               END IF;
            END IF;
         ELSIF (lv_ind_tipo_servicio = 'AA') THEN
            --Se prepara la estructura para enviar a centrales
            lo_lista_centrales.cod_cliente      := lo_abonado.cod_cliente;
            lo_lista_centrales.cod_prov_serv    := ln_cod_prov_serv;
            lo_lista_centrales.tip_accion       := '1';
            lo_lista_centrales.tip_ser          := lv_ind_tipo_servicio;
            lo_lista_centrales.cod_prod_contrat := ln_cod_prod_contratado;
            lo_lista_centrales.fecha_ejecucion  := ed_fecha_alta;
            lo_lista_centrales.num_celular      := lo_abonado.num_celular;
            lo_lista_centrales.NUM_ABONADO      := lo_abonado.NUM_ABONADO;
            lo_lista_centrales.tip_terminal     := lo_abonado.tip_terminal;
            lo_lista_centrales.cod_central      := lo_abonado.cod_central;
            lo_lista_centrales.num_serie        := lo_abonado.num_serie;
            lo_lista_centrales.cod_tecnologia   := lo_abonado.cod_tecnologia;
            lo_lista_centrales.id_plan          := lv_cod_servicio_base;
            lo_lista_centrales.importe          := '0';
            lo_lista_centrales.cod_moneda       := '0';
            lo_lista_centrales.usuario          := 'SCL';
            lo_lista_centrales.cod_causa        := '00';
            lo_lista_centrales.monto_bonif      := ln_can_bonificar;
            lo_lista_centrales.tipo_bono        := lv_tipo_unidad_bonificar;
            lo_lista_centrales.cod_periodif     := NULL;
            lo_lista_centrales.fecha_ejec_bono  := ed_fecha_alta;
            lo_lista_centrales.num_movant       := en_num_mov_ant;
            lo_lista_centrales.nom_usuarora     := lv_usuario;
            lv_ssql := 'Ic_Provision_Pg.ic_inserta_pr(';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_cliente || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_prov_serv || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.tip_accion || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.tip_ser || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_prod_contrat || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.fecha_ejecucion || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.num_celular || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.NUM_ABONADO || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.tip_terminal || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_central || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.num_serie || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_tecnologia || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.id_plan || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.importe || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_moneda || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.usuario || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_causa || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.monto_bonif || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.tipo_bono || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.cod_periodif || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.fecha_ejec_bono || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.num_movant || ',';
            lv_ssql := lv_ssql || lo_lista_centrales.nom_usuarora || ');';
            --Se informa el movimiento a centrales
            Ic_Provision_Pg.ic_inserta_pr(lo_lista_centrales,sn_cod_retorno,sv_mens_retorno,sn_num_evento);

            IF (sn_cod_retorno != 0) THEN
               RAISE error_subfuncion;
            END IF;
         END IF;

         --Inicio Inc. 170939 - 07/08/2011 - FDL
         -- Se verifica si el abonado es prepago, para no cobrar los cargos
         lv_ssql := 'select count(1)';
         lv_ssql := lv_ssql || ' from ga_aboamist ';
         lv_ssql := lv_ssql || ' where num_abonado = '||en_abonado_destino;
         select count(1)
         into ln_esprepago
         from ga_aboamist
         where num_abonado = en_abonado_destino;
         --Fin Inc. 170939 - 07/08/2011 - FDL

    -- INI Traza 200250|06-11-2013
    LV_DESESTADO := 'EN_CLIENTE_DESTINO['||EN_CLIENTE_DESTINO||'] EN_ABONADO_DESTINO['||EN_ABONADO_DESTINO;
    LV_DESESTADO := LV_DESESTADO || '] EN_PROD_CONTRATADO['||ln_cod_prod_contratado||'] EN_PROD_OFERTADO['||EN_PROD_OFERTADO;
    LV_DESESTADO := LV_DESESTADO || '] ED_FECHA_ALTA['||ED_FECHA_ALTA||'] ED_FECHA_BAJA['||ED_FECHA_BAJA;
    LV_DESESTADO := LV_DESESTADO || '] EN_NUM_MOV_ANT['||EN_NUM_MOV_ANT||'] EN_NUM_PROCESO['||EN_NUM_PROCESO;
    LV_DESESTADO := LV_DESESTADO || '] EV_IND_CONTRATA['||ev_ind_contrata;
    LV_DESESTADO := LV_DESESTADO || '] EV_IND_HIJO['||ev_ind_hijo||'] LN_ESPREPAGO['||ln_esprepago;

    LV_INFO_REG := 'Antes de IF ((ev_ind_contrata = O OR ev_ind_contrata = B) AND (ev_ind_hijo = N)) AND (ln_esprepago = 0)';
    LV_NomProc := 'PV_AGREGA_FN_2';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    200250, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    -- FIN Traza 200250|06-11-2013

         IF ((ev_ind_contrata = 'O' OR ev_ind_contrata = 'B') AND (ev_ind_hijo = 'N')) AND (ln_esprepago = 0) THEN
         --IF ((ev_ind_contrata = 'O') AND (ev_ind_hijo = 'N')) THEN
            lv_ssql := ' SELECT cargos.monto_importe, cargos.cod_moneda, catalogo.cod_concepto,';
            lv_ssql := lv_ssql || ' DECODE(concepto.ind_prorrateable,''S'',1,0), cargos.cod_cargo';
            lv_ssql := lv_ssql || ' FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,';
            lv_ssql := lv_ssql || ' pf_conceptos_prod_td concepto';
            lv_ssql := lv_ssql || ' WHERE  catalogo.cod_concepto = concepto.cod_concepto';
            lv_ssql := lv_ssql || ' AND       catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado';
            lv_ssql := lv_ssql || ' AND       catalogo.cod_cargo = cargos.cod_cargo';
            lv_ssql := lv_ssql || ' AND       catalogo.cod_prod_ofertado = ' || en_prod_ofertado;
            lv_ssql := lv_ssql || ' AND       catalogo.cod_canal = ' || ev_cod_canal;
            --lv_ssql := lv_ssql || ' AND       catalogo.fec_inicio_vigencia <= ' || ed_fecha_alta;
            --lv_ssql := lv_ssql || ' AND       catalogo.fec_termino_vigencia >= ' || ed_fecha_baja;
            lv_ssql := lv_ssql || ' AND ' || to_char(ED_FECHA_ALTA,'dd-mm-yyyy hh24:mi:ss');
            lv_ssql := lv_ssql || ' BETWEEN catalogo.fec_inicio_vigencia AND catalogo.fec_termino_vigencia ';
            --                LV_sSql := LV_sSql || ' AND       concepto.tipo_cargo = ''''R''';
            --Se buscan los cargos recurrentes
            OPEN c_cargos FOR
               SELECT cargos.monto_importe, cargos.cod_moneda, catalogo.cod_concepto,
               DECODE(concepto.ind_prorrateable, 'S', 1, 0), cargos.cod_cargo, concepto.tipo_cargo
               FROM pf_cargos_productos_td  cargos, pf_catalogo_ofertado_td catalogo, pf_conceptos_prod_td    concepto
               WHERE catalogo.cod_concepto = concepto.cod_concepto
               AND catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado
               AND catalogo.cod_cargo = cargos.cod_cargo
               AND catalogo.cod_prod_ofertado = en_prod_ofertado
               AND catalogo.cod_canal = ev_cod_canal
               AND ED_FECHA_ALTA BETWEEN catalogo.fec_inicio_vigencia AND catalogo.fec_termino_vigencia
               ORDER BY concepto.tipo_cargo DESC; -- FPP 26-08-2010 Defecto 131 (se ordena para obtener primero los cargos recurrentes)

               --AND catalogo.fec_inicio_vigencia <= ed_fecha_alta
               --AND catalogo.fec_termino_vigencia >= ed_fecha_baja;
               --AND       concepto.tipo_cargo = 'R';

            --Se incializa la estructura de cargos Recurrentes
            lo_cargos_rec := fa_cargos_rec_qt('','','','','','','','','','','','','','','','','','','','','','','','');
            --Se incializa la estructura de cargos ocasionales
            lo_cargos := fa_cargos_qt('','','','','','','','','','','','','','','','','','','','','','','','','','','',
                           '','','','','','','','','','','','','','');


            LOOP
               FETCH c_cargos
               INTO ln_monto_importe, lv_cod_moneda, ln_cod_concepto, ln_ind_prorrateable, ln_cod_cargo, lv_tip_cargo;
               EXIT WHEN c_cargos%NOTFOUND;

    -- INI Traza 200250|06-11-2013
    LV_DESESTADO := 'EN_CLIENTE_DESTINO['||EN_CLIENTE_DESTINO||'] EN_ABONADO_DESTINO['||EN_ABONADO_DESTINO;
    LV_DESESTADO := LV_DESESTADO || '] EN_PROD_CONTRATADO['||ln_cod_prod_contratado||'] EN_PROD_OFERTADO['||EN_PROD_OFERTADO;
    LV_DESESTADO := LV_DESESTADO || '] ED_FECHA_ALTA['||ED_FECHA_ALTA||'] ED_FECHA_BAJA['||ED_FECHA_BAJA;
    LV_DESESTADO := LV_DESESTADO || '] EN_NUM_MOV_ANT['||EN_NUM_MOV_ANT||'] EN_NUM_PROCESO['||EN_NUM_PROCESO;
    LV_DESESTADO := LV_DESESTADO || '] LV_TIP_CARGO['||lv_tip_cargo||']';

    LV_INFO_REG := 'Antes de IF (lv_tip_cargo = R) ';
    LV_NomProc := 'PV_AGREGA_FN_2';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    200250, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    -- FIN Traza 200250|06-11-2013

               IF (lv_tip_cargo = 'R') THEN
                  lv_cargo_recurrente := TRUE; -- FPP 26-08-2010 Defecto 131
                  --Se prepara la estructura para informar cargos recurrentes
                  lo_cargos_rec.cod_clienteserv      := en_cliente_destino;
                  lo_cargos_rec.num_abonadoserv      := en_abonado_destino;
                  lo_cargos_rec.cod_prod_contratado  := ln_cod_prod_contratado;
                  lo_cargos_rec.cod_cargo_contratado := ln_cod_cargo;
                  lo_cargos_rec.cod_clientepago      := en_cliente_destino;
                  lo_cargos_rec.num_abonadopago      := en_abonado_destino;
                  -- LO_CARGOS_REC.COD_TIPSERV          := ;--VARCHAR2(2)
                  -- LO_CARGOS_REC.COD_SERVICIO         := ;--VARCHAR2(5)
                  lo_cargos_rec.cod_planserv  := lo_abonado.cod_planserv;
                  lo_cargos_rec.ind_cargopro  := ln_ind_prorrateable;
                  lo_cargos_rec.cod_concepto  := ln_cod_concepto;
                  lo_cargos_rec.fec_alta      := ed_fecha_alta;
                  -- lo_cargos_rec.fec_baja      := ed_fecha_baja; -- FPP 08-07-2010
                  lo_cargos_rec.fec_baja      := NULL; -- FPP 08-07-2010
                  lo_cargos_rec.fec_desdecobr := ed_fecha_alta;
                  -- lo_cargos_rec.fec_hastacobr := ed_fecha_baja; -- FPP 08-07-2010
                  lo_cargos_rec.fec_hastacobr := NULL; -- FPP 08-07-2010
                  -- LO_CARGOS_REC.IND_BLOQUEO          := ;--VARCHAR2(5)
                  -- LO_CARGOS_REC.EST_BLOQUEO          := ;--VARCHAR2(5)
                  lo_cargos_rec.fec_desdebloc := ed_fecha_alta;
                  -- lo_cargos_rec.fec_hastabloc := ed_fecha_baja; -- FPP 08-07-2010
                  lo_cargos_rec.fec_hastabloc := NULL; -- FPP 08-07-2010 -- FPP 27-09-2010
                  -- lo_cargos_rec.fec_hastabloc := lo_cargos_rec.fec_desdebloc; -- FPP 16-09-2010 -- FPP 27-09-2010
                  -- LO_CARGOS_REC.FEC_ULTFACTURA       := ;--DATE
                  -- LO_CARGOS_REC.COD_ULTCICLFACT      := ;--NUMBER(10)
                  -- LO_CARGOS_REC.NUM_ULTPROCESO       := ;--NUMBER(10)
                  -- LO_CARGOS_REC.FEC_ULTMOD           := ;--DATE
                  lo_cargos_rec.nom_usuario := lv_usuario; --VARCHAR2(30)
                  lv_ssql := 'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR(';
                  lv_ssql := lv_ssql || en_cliente_destino || ', ' || en_abonado_destino || ', ';
                  lv_ssql := lv_ssql || ln_cod_prod_contratado || ', ' || ln_cod_cargo || ', ';
                  lv_ssql := lv_ssql || lo_abonado.cod_planserv || ', ';
                  lv_ssql := lv_ssql || ln_ind_prorrateable || ', ' || ln_cod_concepto || ')';

    -- INI Traza 200250|06-11-2013
    LV_DESESTADO := lv_ssql;

    LV_INFO_REG := 'Antes de FA_CARGOS_SN_PG.FA_CARGOS_REC_ALTA_PR ';
    LV_NomProc := 'PV_AGREGA_FN_2';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    200250, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    -- FIN Traza 200250|06-11-2013

                  Fa_Cargos_Rec_Sn_Pg.fa_cargos_rec_alta_pr(lo_cargos_rec,sn_cod_retorno,sv_mens_retorno,sn_num_evento);

                  IF (sn_cod_retorno != 0) THEN
                     RAISE error_subfuncion;
                  END IF;
               ELSE
                  lv_ssql := 'SELECT cod_ciclfact';
                  lv_ssql := lv_ssql || ' FROM fa_ciclfact';
                  lv_ssql := lv_ssql || '    WHERE  cod_ciclo  = ' || lo_abonado.cod_ciclo;
                  lv_ssql := lv_ssql || ' AND sysdate BETWEEN fec_desdeocargos AND fec_hastaocargos';

                  BEGIN
                     -- INI. FPP 13-07-2010 Defecto 82
                     SELECT fec_desdeocargos
                     INTO ld_fec_desdeocargos
                     FROM FA_CICLFACT
                     WHERE cod_ciclo = lo_abonado.cod_ciclo
                     AND SYSDATE BETWEEN fec_desdeocargos AND fec_hastaocargos;

                     IF trunc(ld_fec_desdeocargos) = trunc(sysdate) THEN
                        -- Corresponde a un cambio de plan a ciclo, por lo que el ciclo de facturacion
                        -- debe ser el anterior para que sea cobrado en el ciclo de facturacion actual
                        -- de lo contrario quedara para ser cobrado a fin del proximo ciclo
                        SELECT cod_ciclfact
                        INTO lo_cargos.cod_ciclfact
                        FROM FA_CICLFACT
                        WHERE cod_ciclo = lo_abonado.cod_ciclo -- ciclo de facturación del contratante (cod_ciclo)
                        AND SYSDATE -2 BETWEEN fec_desdeocargos AND fec_hastaocargos;
                     ELSE
                        SELECT cod_ciclfact
                        INTO lo_cargos.cod_ciclfact
                        FROM FA_CICLFACT
                        WHERE cod_ciclo = lo_abonado.cod_ciclo -- ciclo de facturación del contratante (cod_ciclo)
                        AND SYSDATE BETWEEN fec_desdeocargos AND fec_hastaocargos;
                     END IF;
                     -- FIN FPP 13-07-2010 Defecto 82
                  EXCEPTION
                     WHEN NO_DATA_FOUND THEN
                        sn_cod_retorno := 1411;
                        IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno, sv_mens_retorno) THEN
                           sv_mens_retorno := cv_error_no_clasif;
                        END IF;
                        lv_des_error  := 'PV_PLANES_ADICIONALES_PG(' || '); - ' || SQLERRM;
                        sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento,'PV',sv_mens_retorno,cv_version,USER,
                                          'PV_PLANES_ADICIONALES_PG.PV_AGREGA_FN',lv_ssql,sn_cod_retorno,lv_des_error);
                        RETURN FALSE;
                  END;

                  -- LO_CARGOS.SEQ_CARGO              := ;--    NUMBER(9),
                  lo_cargos.cod_cliente := en_cliente_destino; --    NUMBER(10),
                  lo_cargos.NUM_ABONADO := en_abonado_destino; --    NUMBER(10),
                  lo_cargos.cod_prod_contratado := ln_cod_prod_contratado; --    NUMBER(38),
                  lo_cargos.cod_producto := 1; --    NUMBER(1),
                  lo_cargos.id_cargo     := ln_cod_cargo; --    NUMBER(9),
                  lo_cargos.cod_concepto := ln_cod_concepto; --    NUMBER(9),
                  -- LO_CARGOS.COLUMNA                := ;--    NUMBER(6),
                  lo_cargos.fec_alta  := ed_fecha_alta; --    DATE,
                  lo_cargos.imp_cargo := ln_monto_importe; --    NUMBER(14,4)
                  lo_cargos.cod_moneda := lv_cod_moneda; --    VARCHAR2(3),
                  lo_cargos.cod_plancom  := 1; --    NUMBER(6),
                  lo_cargos.num_unidades := 1; --    NUMBER(6),
                  IF (ev_cargo_ocasional = 'S') THEN
                     lo_cargos.ind_factur   := 1;
                  ELSE
                     lo_cargos.ind_factur   := 9;
                  END IF;

                  -- INI. FPP 21-06-2010
                  -- Se se trata de la contratacion de un plan adicional obligatorio, se verifica
                  -- que el abonado no lo tuviera previamente contratado para no cobrar el cargo ocasional
                  IF (ev_ind_contrata = 'B') THEN
                     select  count(1)
                     into ln_can_oblig
                     from pr_productos_contratados_th
                     where num_abonado_beneficiario = en_abonado_destino
                     and cod_prod_ofertado = en_prod_ofertado
                     and trunc(sysdate) between trunc(fec_inicio_vigencia) and trunc(fec_termino_vigencia);

                     IF (ln_can_oblig > 0) THEN
                        lo_cargos.ind_factur   := 9;
                     END IF;
                  END IF;
                  -- FIN FPP 21-06-2010

                  -- INI. FPP 26-08-2010 Defecto 131
                  -- Si el cargo_ocasional = X, quiere decir que no hay que cobrar cargo ocasional
                  -- para no cobrar 2 veces al cliente en un mismo mes el cargo ocasional y recurrente
                  -- Si el plan adicional no tiene cargo recurrente, se debe cobrar el cargo ocasional
                  IF (ev_cargo_ocasional = 'X') THEN
                     IF (lv_cargo_recurrente = TRUE) THEN
                        lo_cargos.ind_factur   := 9;
                     ELSE
                        lo_cargos.ind_factur   := 1;
                     END IF;
                  END IF;
                  -- FIN FPP 26-08-2010 Defecto 131

                  -- LO_CARGOS.NUM_TRANSACCION        := ;--    NUMBER(9),
                  -- LO_CARGOS.NUM_VENTA            := 0;--    NUMBER(8),
                  -- LO_CARGOS.NUM_PAQUETE            := ;--    NUMBER(3),
                  lo_cargos.num_terminal := lo_abonado.num_celular; --    VARCHAR2(15)
                  -- LO_CARGOS.COD_CICLFACT        := ;--    NUMBER(6),
                  -- LO_CARGOS.NUM_SERIE            := ;--    VARCHAR2(25)
                  -- LO_CARGOS.NUM_SERIEMEC        := ;--    VARCHAR2(20)
                  -- LO_CARGOS.CAP_CODE            := ;--    NUMBER(7),
                  lo_cargos.mes_garantia := 0; --    NUMBER(2),
                  -- LO_CARGOS.NUM_PREGUIA            := ;--    VARCHAR2(10)
                  -- LO_CARGOS.NUM_GUIA            := ;--    VARCHAR2(10)
                  -- LO_CARGOS.COD_CONCEREL        := ;--    NUMBER(8),
                  -- LO_CARGOS.COLUMNA_REL            := ;--    NUMBER(4),
                  -- LO_CARGOS.COD_CONCEPTO_DTO    := ;--    NUMBER(4),
                  -- LO_CARGOS.VAL_DTO                := ;--    NUMBER(14,4)
                  -- LO_CARGOS.TIP_DTO                := ;--    NUMBER(1),
                  lo_cargos.ind_cuota := 0; --    NUMBER(1),
                  -- LO_CARGOS.NUM_CUOTAS            := ;--    NUMBER(3),
                  -- LO_CARGOS.ORD_CUOTA            := ;--    NUMBER(3),
                  lo_cargos.ind_supertel := 0; --    NUMBER(1),
                  -- LO_CARGOS.IND_MANUAL            := ;--    NUMBER(1),
                  -- LO_CARGOS.PREF_PLAZA            := ;--    VARCHAR2(10)
                  lo_cargos.cod_tecnologia := lo_abonado.cod_tecnologia; --    VARCHAR2(7),
                  -- LO_CARGOS.GLS_DESCRIP            := ;--    VARCHAR2(100
                  -- LO_CARGOS.NUM_FACTURA            := ;--    NUMBER(10),
                  lo_cargos.fec_ultmod  := SYSDATE; --    DATE,
                  lo_cargos.nom_usuario := lv_usuario; --    VARCHAR2(30)
                  lv_ssql := 'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR(';
                  lv_ssql := lv_ssql || en_cliente_destino || ', ' || en_abonado_destino || ', ';
                  lv_ssql := lv_ssql || ln_cod_prod_contratado || ', ' || ln_cod_cargo || ', ';
                  lv_ssql := lv_ssql || ln_cod_concepto || ', ' || ed_fecha_alta || ', ';
                  lv_ssql := lv_ssql || ln_monto_importe || ', ' || lv_cod_moneda || ', ';
                  lv_ssql := lv_ssql || lo_abonado.num_celular || ', ';
                  lv_ssql := lv_ssql || lo_abonado.cod_tecnologia || ', ' || lv_usuario || ')';

    -- INI Traza 200250|06-11-2013
    LV_DESESTADO := lv_ssql;

    LV_INFO_REG := 'Antes de FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR ';
    LV_NomProc := 'PV_AGREGA_FN';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    200250, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    -- FIN Traza 200250|06-11-2013

                  Fa_Cargos_Sn_Pg.fa_cargos_alta_pr(lo_cargos,sn_cod_retorno,sv_mens_retorno,sn_num_evento);

                  IF (sn_cod_retorno != 0) THEN
                     RAISE error_subfuncion;
                  END IF;
               END IF;
            END LOOP; -- FIN LOOP DE CURSOR

            close c_cargos; -- RRG 161846 COL 22-01-2011

         END IF;
      END LOOP;
   ELSE
      --Supera el maximo de contrataciones [88108]
      lv_ssql := 'PV_EXCLUSION_PLANES_SS_PG.PV_LOG_EXCLUSION_PR(';
      lv_ssql := lv_ssql || en_num_proceso || ', ' || en_cliente_destino || ', ';
      lv_ssql := lv_ssql || en_abonado_destino || ', ' || en_prod_ofertado;
      lv_ssql := lv_ssql || ',3 , ''MAXCONTRA'')';
      /*Pv_Exclusion_Planes_Ss_Pg.pv_log_exclusion_pr(en_num_proceso, en_cliente_destino, en_abonado_destino,
         en_prod_ofertado, 3, 'MAXCONTRA', sn_cod_retorno, sv_mens_retorno, sn_num_evento);*/

      Pv_Exclusion_Planes_Ss_Pg.pv_log_exclusion_pr(en_num_proceso, en_cliente_destino, en_abonado_destino,
         en_prod_ofertado, 3,en_prod_ofertado, sn_cod_retorno, sv_mens_retorno, sn_num_evento);


         -- Dado que despues de integrar con
         -- prepago existe la posibilidad de que se inserte este log mas de una vez con los mismos datos,
         -- se solicita que se controle el error cuando se cae por PK
         if sn_cod_retorno = 156 then
            sn_cod_retorno := 0;
            sv_mens_retorno := null;
            sn_num_evento :=0;
         end if;

   END IF; --88108
   --END IF;                                                          --88108

   RETURN TRUE;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN TRUE;
   WHEN error_subfuncion THEN
      lv_des_error  := 'PV_PLANES_ADICIONALES_PG(' || '); - ' || sv_mens_retorno;
      IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno, sv_mens_retorno) THEN
         sv_mens_retorno := cv_error_no_clasif;
      END IF;
      -- lv_des_error  := 'PV_PLANES_ADICIONALES_PG(' || '); - ' || SQLERRM;
      sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento, 'PV', sv_mens_retorno, cv_version, USER,
         'PV_PLANES_ADICIONALES_PG.PV_AGREGA_FN', lv_ssql, sn_cod_retorno, lv_des_error);
      RETURN FALSE;
   WHEN OTHERS THEN
      sn_cod_retorno := 156;
      IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno, sv_mens_retorno) THEN
         sv_mens_retorno := cv_error_no_clasif;
      END IF;
      lv_des_error  := 'PV_PLANES_ADICIONALES_PG(' || '); - ' || SQLERRM;
      sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento, 'PV', sv_mens_retorno, cv_version, USER,
         ' PV_PLANES_ADICIONALES_PG.PV_AGREGA_FN', lv_ssql, sn_cod_retorno, lv_des_error);
      RETURN FALSE;
END pv_agrega_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_AGREGA_CON_LISTA_FN( EN_CLIENTE_DESTINO  IN ge_clientes.cod_cliente%TYPE,
                        EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                        EN_PROD_OFERTADO   IN pr_productos_contratados_to.cod_prod_ofertado%TYPE,
                        ED_FECHA_ALTA        IN DATE,
                        ED_FECHA_BAJA       IN DATE,
                        EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                        EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                        EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                        EO_LISTA_NUMEROS   IN SV_LISTA_CONTRA_TO_LST_QT,
                        EV_IND_CONTRATA       IN pr_productos_contratados_to.ind_condicion_contratacion%TYPE,
                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_AGREGA_CON_LISTA_FN"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>BOOLEAN</Retorno>>
       <Descripción>Realiza la contratación de un producto en todas las plataformas e ingresa una lista de números si se provee</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LN_COUNT         NUMBER;
LN_i             NUMBER:=0;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_cod_espec_prod        se_detalles_especificacion_to.cod_espec_prod%TYPE;
LN_cod_perfil_lista      se_detalles_especificacion_to.cod_perfil_lista%TYPE;
LN_cod_prov_serv          se_detalles_especificacion_to.cod_prov_serv%TYPE;
LV_cod_servicio_base     se_detalles_especificacion_to.cod_servicio_base%TYPE;
LV_ind_tipo_servicio     se_detalles_especificacion_to.ind_tipo_servicio%TYPE;
LV_tipo_comportamiento   ps_especificaciones_prod_td.tipo_comportamiento%TYPE;
LV_tipo_plataforma          ps_especificaciones_prod_td.tipo_plataforma%TYPE;
LV_tipo_unidad_bonificar se_planes_altamira_td.tipo_unidad_bonificar%TYPE;
LN_can_bonificar         se_planes_altamira_td.can_bonificar%TYPE;

C_PRO_DEFECTO         refcursor;
C_LISTA_NUMEROS         refcursor;
C_CARGOS             refcursor;
LO_ABONADO               GA_ABONADO_QT;
LO_PRODUCTO              PR_PRODUCTOS_CONTS_TO_QT;
LO_LISTA_NUMEROS     SV_LISTA_CONTRA_TO_LST_QT := SV_LISTA_CONTRA_TO_LST_QT(SV_LISTA_CONTRA_TO_QT('','','','','','','','','',''));
LO_NUMERO              SV_LISTA_CONTRA_TO_QT := SV_LISTA_CONTRA_TO_QT('','','','','','','','','','');
LO_LISTA_CENTRALES     IC_PROVISION_QT;
LO_CARGOS_REC         FA_CARGOS_REC_QT;
LO_CLIENTE              PV_CLIENTE_QT;
LO_CARGOS             FA_CARGOS_QT;

LV_VAL_ELEMENTO         sv_lista_contratada_to.valor_elemento%TYPE;
LD_FEC_INI_VIG         sv_lista_contratada_to.fec_inicio_vigencia%TYPE;
LD_FEC_TER_VIG         sv_lista_contratada_to.fec_termino_vigencia%TYPE;
LV_CATEGORIA_DESTINO sv_lista_contratada_to.cod_categoria_destino%TYPE;

LN_MONTO_IMPORTE     pf_cargos_productos_td.monto_importe%TYPE;
LV_COD_MONEDA          pf_cargos_productos_td.cod_moneda%TYPE;
LN_COD_CARGO          pf_cargos_productos_td.cod_cargo%TYPE;
LN_COD_CONCEPTO      pf_catalogo_ofertado_td.cod_concepto%TYPE;
LV_TIP_CARGO         pf_conceptos_prod_td.tipo_cargo%TYPE;
LN_IND_PRORRATEABLE  NUMBER;
LV_IND_NIVEL_APLICA     pf_productos_ofertados_td.ind_nivel_aplica%TYPE;
LV_USUARIO             ga_abocel.nom_usuarora%TYPE;
LD_FECDESDECARGOS      fa_ciclfact.fec_desdeocargos%TYPE;
LD_FECHASTACARGOS      fa_ciclfact.fec_hastaocargos%TYPE;

LB_HAYNUMEROS         BOOLEAN;

BEGIN
    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LB_HAYNUMEROS := FALSE; --Se asume la inexistencia de números en la lista

    --Se obtiene el usuario de la OOSS
    BEGIN
        SELECT usuario
        INTO   LV_USUARIO
        FROM   pv_iorserv
        WHERE  num_os = EN_NUM_PROCESO
        UNION
        SELECT usuario
        FROM   ci_orserv
        WHERE  num_os = EN_NUM_PROCESO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            LV_USUARIO := USER;
    END;

    LO_LISTA_CENTRALES := IC_PROVISION_QT();

    --Se prepara estructura para obtener datos del abonado
    LO_ABONADO:= GA_ABONADO_QT(EN_ABONADO_DESTINO,'','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                            '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                            '','','','','','','','','','');

    --Se prepara estructura para obtener datos del abonado
    LO_CLIENTE := PV_CLIENTE_QT(EN_CLIENTE_DESTINO,'','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                                                        '','','','','','','','','','','','');
    IF (EN_ABONADO_DESTINO != 0 AND EN_ABONADO_DESTINO IS NOT NULL) THEN

        LV_IND_NIVEL_APLICA := 'A';


        --Se Obtienen los datos del abonado
        PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR(LO_ABONADO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
    ELSE
        LV_IND_NIVEL_APLICA := 'C';

        PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_CLIENTE_PR(LO_CLIENTE, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);

        LO_ABONADO.COD_CICLO := LO_CLIENTE.COD_CICLO;
        LO_ABONADO.COD_CLIENTE := LO_CLIENTE.COD_CLIENTE;
        LO_ABONADO.TIP_TERMINAL := LO_CLIENTE.TIP_TERMINAL;
        LO_ABONADO.COD_TECNOLOGIA := LO_CLIENTE.COD_TECNOLOGIA;

    END IF;

    --Se buscan los datos necesarios para contratar productos
    LV_sSql := 'SELECT servicio.cod_espec_prod, servicio.cod_perfil_lista, servicio.cod_prov_serv, servicio.cod_servicio_base,';
    LV_sSql := LV_sSql || ' servicio.ind_tipo_servicio, espec.tipo_comportamiento, espec.tipo_plataforma';
    LV_sSql := LV_sSql || ' FROM   pf_productos_ofertados_td ofertado, ps_especificaciones_prod_td espec, se_detalles_especificacion_to servicio';
    LV_sSql := LV_sSql || ' WHERE  ofertado.cod_espec_prod = espec.cod_espec_prod';
    LV_sSql := LV_sSql || ' AND       ofertado.cod_espec_prod = servicio.cod_espec_prod';
    LV_sSql := LV_sSql || ' AND       ofertado.cod_prod_ofertado = '||EN_PROD_OFERTADO;
    LV_sSql := LV_sSql || ' AND       ofertado.ind_nivel_aplica = '||LV_IND_NIVEL_APLICA;

    SELECT servicio.cod_espec_prod, NVL(servicio.cod_perfil_lista,0), servicio.cod_prov_serv, servicio.cod_servicio_base,
           servicio.ind_tipo_servicio, espec.tipo_comportamiento, espec.tipo_plataforma
    INTO   LN_cod_espec_prod, LN_cod_perfil_lista, LN_cod_prov_serv, LV_cod_servicio_base,
           LV_ind_tipo_servicio, LV_tipo_comportamiento, LV_tipo_plataforma
    FROM   pf_productos_ofertados_td ofertado, ps_especificaciones_prod_td espec, se_detalles_especificacion_to servicio
    WHERE  ofertado.cod_espec_prod = espec.cod_espec_prod
    AND       ofertado.cod_espec_prod = servicio.cod_espec_prod
    AND       ofertado.cod_prod_ofertado = EN_PROD_OFERTADO
    AND       ofertado.ind_nivel_aplica = LV_IND_NIVEL_APLICA;

    IF (LV_ind_tipo_servicio = 'AA') THEN

        LV_sSql := 'SELECT altamira.tipo_unidad_bonificar, altamira.can_bonificar';
        LV_sSql := LV_sSql || ' FROM   se_planes_altamira_td altamira';
        LV_sSql := LV_sSql || ' WHERE  altamira.cod_plan_altamira = '||LV_cod_servicio_base;

        SELECT altamira.tipo_unidad_bonificar, altamira.can_bonificar
        INTO   LV_tipo_unidad_bonificar, LN_can_bonificar
        FROM   se_planes_altamira_td altamira
        WHERE  altamira.cod_plan_altamira = LV_cod_servicio_base;

    END IF;

    --Se obtiene el secuencial de producto contratado
    LV_sSql := 'SELECT PF_PRODUCTOS_CONTRATADOS_SQ.NEXTVAL FROM dual';

    SELECT PF_PRODUCTOS_CONTRATADOS_SQ.NEXTVAL
    INTO   LN_COD_PROD_CONTRATADO
    FROM   dual;

  lv_ssql := 'lo_producto := pr_productos_conts_to_qt('||LN_COD_PROD_CONTRATADO||','
                                                ||EN_CLIENTE_DESTINO||','
                                                ||EN_ABONADO_DESTINO||','
                                                ||EN_PROD_OFERTADO||','
                                                ||ED_FECHA_ALTA||','
                                                ||EV_COD_CANAL||','
                                                ||EN_NUM_PROCESO||','
                                                ||EV_COD_CANAL||','
                                                ||SYSDATE||','
                                                ||'OK,'
                                                ||EV_IND_CONTRATA||','
                                                ||en_cliente_destino||','
                                                ||en_abonado_destino||','
                                                ||'31-12-3000,'
                                                ||'1,'
                                                ||LN_COD_PROD_CONTRATADO||','
                                                ||ln_cod_perfil_lista||','
                                                ||lv_tipo_comportamiento||','
                                                ||'NULL,'
                                                ||'NULL);';

    --Se prepara el arreglo de producto
    LO_PRODUCTO := PR_PRODUCTOS_CONTS_TO_QT( LN_COD_PROD_CONTRATADO,
                                              EN_CLIENTE_DESTINO,
                                              EN_ABONADO_DESTINO,
                                              EN_PROD_OFERTADO,
                                              ED_FECHA_ALTA,
                                              EV_COD_CANAL,
                                              EN_NUM_PROCESO,
                                              EV_COD_CANAL,
                                              SYSDATE,
                                              'OK',
                                              EV_IND_CONTRATA,
                                              EN_CLIENTE_DESTINO,
                                              EN_ABONADO_DESTINO,
                                              ED_FECHA_BAJA,
                                              1,
                                              LN_COD_PROD_CONTRATADO,
                                              LN_cod_perfil_lista,
                                              LV_tipo_comportamiento,
                                               NULL,
                                                NULL);

    --Se contrata el Producto
    LV_sSql := 'PR_PRODUCTOS_CONTRATADOS_PG.PR_CONTRATA_I_PR('||
                       LN_COD_PROD_CONTRATADO||', '||
                    EN_CLIENTE_DESTINO||', '||
                    EN_ABONADO_DESTINO||', '||
                    EN_PROD_OFERTADO||', '||
                    ED_FECHA_ALTA||', '||
                    EV_COD_CANAL||', '||
                    EN_NUM_PROCESO||', '||
                    EV_COD_CANAL||', '||
                    SYSDATE||', '||
                    'OK, '||
                    EV_IND_CONTRATA||', '||
                    EN_CLIENTE_DESTINO||', '||
                    EN_ABONADO_DESTINO||', '||
                    ED_FECHA_BAJA||', '||
                    '1 '||
                    LN_COD_PROD_CONTRATADO||', '||
                    LN_cod_perfil_lista||', '||
                    LV_tipo_comportamiento||')';

    PR_PRODUCTOS_CONTRATADOS_PG.PR_CONTRATA_I_PR(LO_PRODUCTO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
    IF (SN_COD_RETORNO != 0) THEN
        RAISE ERROR_SUBFUNCION;
    END IF;

    IF (LV_ind_tipo_servicio = 'TOL') THEN
    --Se informa el producto contratado a TOL
        LV_sSql := 'TOL_PRODUCTO_CONTRATADO_PG.TOL_ALTA_FACHADA_PR@LNK_PRODUC_SCL_TOL('||EN_ABONADO_DESTINO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA||', '||
           LV_cod_servicio_base||', '||LN_COD_PROD_CONTRATADO||', '||1||', '||EN_CLIENTE_DESTINO||', '||
           EV_COD_CANAL||', '||LO_ABONADO.COD_CICLO||')';

        --TOL_PRODUCTO_CONTRATADO_PG.TOL_ALTA_FACHADA_PR(EN_ABONADO_DESTINO, ED_FECHA_ALTA, ED_FECHA_BAJA, LV_cod_servicio_base,
        TOL_PRODUCTO_CONTRATADO_PG.TOL_ALTA_FACHADA_PR(EN_ABONADO_DESTINO, ED_FECHA_ALTA, ED_FECHA_BAJA, LV_cod_servicio_base,
                                                        LN_COD_PROD_CONTRATADO, 1, EN_CLIENTE_DESTINO, EV_COD_CANAL, LO_ABONADO.COD_CICLO,
                                                        SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

        IF (LN_cod_prov_serv IS NOT NULL) THEN

        --Se prepara la estructura para enviar a centrales
            LO_LISTA_CENTRALES.COD_CLIENTE := LO_ABONADO.COD_CLIENTE;
            LO_LISTA_CENTRALES.COD_PROV_SERV := LN_cod_prov_serv;
            LO_LISTA_CENTRALES.TIP_ACCION := '1';
            LO_LISTA_CENTRALES.TIP_SER := LV_ind_tipo_servicio;
            LO_LISTA_CENTRALES.COD_PROD_CONTRAT := LN_COD_PROD_CONTRATADO;
            LO_LISTA_CENTRALES.FECHA_EJECUCION := ED_FECHA_ALTA;
            LO_LISTA_CENTRALES.NUM_CELULAR := LO_ABONADO.NUM_CELULAR;
            LO_LISTA_CENTRALES.NUM_ABONADO := LO_ABONADO.NUM_ABONADO;
            LO_LISTA_CENTRALES.TIP_TERMINAL := LO_ABONADO.TIP_TERMINAL;
            LO_LISTA_CENTRALES.COD_CENTRAL := LO_ABONADO.COD_CENTRAL;
            LO_LISTA_CENTRALES.NUM_SERIE := LO_ABONADO.NUM_SERIE;
            LO_LISTA_CENTRALES.COD_TECNOLOGIA := LO_ABONADO.COD_TECNOLOGIA;
            LO_LISTA_CENTRALES.ID_PLAN := LV_cod_servicio_base;
            LO_LISTA_CENTRALES.IMPORTE := '0';
            LO_LISTA_CENTRALES.COD_MONEDA := '0';
            LO_LISTA_CENTRALES.USUARIO := 'SCL';
            LO_LISTA_CENTRALES.COD_CAUSA := '00';
            LO_LISTA_CENTRALES.MONTO_BONIF := '0';
            LO_LISTA_CENTRALES.TIPO_BONO := '0';
            LO_LISTA_CENTRALES.COD_PERIODIF := NULL;
            LO_LISTA_CENTRALES.FECHA_EJEC_BONO := ED_FECHA_ALTA;
            LO_LISTA_CENTRALES.NUM_MOVANT := EN_NUM_MOV_ANT;
            LO_LISTA_CENTRALES.NOM_USUARORA := LV_USUARIO;
        --Se informa el movimiento a centrales
            IC_PROVISION_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        END IF;

    ELSIF (LV_ind_tipo_servicio = 'AA') THEN

        --Se prepara la estructura para enviar a centrales
        LO_LISTA_CENTRALES.COD_CLIENTE := LO_ABONADO.COD_CLIENTE;
        LO_LISTA_CENTRALES.COD_PROV_SERV := LN_cod_prov_serv;
        LO_LISTA_CENTRALES.TIP_ACCION := '1';
        LO_LISTA_CENTRALES.TIP_SER := LV_ind_tipo_servicio;
        LO_LISTA_CENTRALES.COD_PROD_CONTRAT := LN_COD_PROD_CONTRATADO;
        LO_LISTA_CENTRALES.FECHA_EJECUCION := ED_FECHA_ALTA;
        LO_LISTA_CENTRALES.NUM_CELULAR := LO_ABONADO.NUM_CELULAR;
        LO_LISTA_CENTRALES.NUM_ABONADO := LO_ABONADO.NUM_ABONADO;
        LO_LISTA_CENTRALES.TIP_TERMINAL := LO_ABONADO.TIP_TERMINAL;
        LO_LISTA_CENTRALES.COD_CENTRAL := LO_ABONADO.COD_CENTRAL;
        LO_LISTA_CENTRALES.NUM_SERIE := LO_ABONADO.NUM_SERIE;
        LO_LISTA_CENTRALES.COD_TECNOLOGIA := LO_ABONADO.COD_TECNOLOGIA;
        LO_LISTA_CENTRALES.ID_PLAN := LV_cod_servicio_base;
        LO_LISTA_CENTRALES.IMPORTE := '0';
        LO_LISTA_CENTRALES.COD_MONEDA := '0';
        LO_LISTA_CENTRALES.USUARIO := 'SCL';
        LO_LISTA_CENTRALES.COD_CAUSA := '00';
        LO_LISTA_CENTRALES.MONTO_BONIF := LN_can_bonificar;
        LO_LISTA_CENTRALES.TIPO_BONO := LV_tipo_unidad_bonificar;
        LO_LISTA_CENTRALES.COD_PERIODIF := NULL;
        LO_LISTA_CENTRALES.FECHA_EJEC_BONO := ED_FECHA_ALTA;
        LO_LISTA_CENTRALES.NUM_MOVANT := EN_NUM_MOV_ANT;
        LO_LISTA_CENTRALES.NOM_USUARORA := LV_USUARIO;

        --Se informa el movimiento a centrales
        IC_PROVISION_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END IF;

    IF (EO_LISTA_NUMEROS IS NOT NULL) THEN

        OPEN C_LISTA_NUMEROS FOR
        SELECT
            valor_elemento, fec_inicio_vigencia, fec_termino_vigencia, cod_categoria_destino
        FROM
            TABLE(EO_LISTA_NUMEROS);

        LOOP

            FETCH C_LISTA_NUMEROS INTO LV_VAL_ELEMENTO, LD_FEC_INI_VIG, LD_FEC_TER_VIG, LV_CATEGORIA_DESTINO;

            EXIT WHEN C_LISTA_NUMEROS%NOTFOUND OR LV_VAL_ELEMENTO IS NULL;

            LB_HAYNUMEROS := TRUE; --Con que pase una vez, ya hay números

            lv_ssql := 'TOL_PRODUCTO_CONTRATADO_PG.SV_FACADE_ALTA_LISTAS_PR@LNK_PRODUC_SCL_TOL(' ||EN_CLIENTE_DESTINO|| ', ' ||EN_ABONADO_DESTINO|| ', ' ||LN_COD_PROD_CONTRATADO|| ', ';
            lv_ssql := lv_ssql ||LV_TIPO_COMPORTAMIENTO|| ', ' ||LV_VAL_ELEMENTO|| ', ' ||LD_FEC_INI_VIG|| ', ' ||LD_FEC_TER_VIG|| ', ' ||LV_CATEGORIA_DESTINO|| ')';
            --TOL_PRODUCTO_CONTRATADO_PG.SV_FACADE_ALTA_LISTAS_PR(EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_CONTRATADO,
            TOL_PRODUCTO_CONTRATADO_PG.SV_FACADE_ALTA_LISTAS_PR(EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_CONTRATADO,
                                LV_TIPO_COMPORTAMIENTO, LV_VAL_ELEMENTO, LD_FEC_INI_VIG, LD_FEC_TER_VIG, LV_CATEGORIA_DESTINO,
                                SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        END LOOP;

        IF (LB_HAYNUMEROS) THEN --Si existe al menos un número en la lista, se contrata en SCL

            FOR LN_i IN 1..EO_LISTA_NUMEROS.count LOOP

                IF (LN_i>1) THEN
                    LO_LISTA_NUMEROS.extend;
                END IF;

                LO_NUMERO := EO_LISTA_NUMEROS(LN_i);

                LO_NUMERO.COD_PROD_CONTRATADO := LN_COD_PROD_CONTRATADO;

                LO_LISTA_NUMEROS(LO_LISTA_NUMEROS.count) := LO_NUMERO;
            END LOOP;

            LV_sSql := 'SV_LISTA_CONTRATADA_PG.SV_CONTRATA_I_PR([OBJECT])';
            SV_LISTA_CONTRATADA_PG.SV_CONTRATA_I_PR(LO_LISTA_NUMEROS,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        END IF;


    END IF;

    IF (EV_IND_CONTRATA = 'O') THEN
        LV_sSql := ' SELECT cargos.monto_importe, cargos.cod_moneda, catalogo.cod_concepto,';
        LV_sSql := LV_sSql || ' DECODE(concepto.ind_prorrateable,''''S'''',1,0), cargos.cod_cargo';
        LV_sSql := LV_sSql || ' FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,';
        LV_sSql := LV_sSql || ' pf_conceptos_prod_td concepto';
        LV_sSql := LV_sSql || ' WHERE  catalogo.cod_concepto = concepto.cod_concepto';
        LV_sSql := LV_sSql || ' AND       catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado';
        LV_sSql := LV_sSql || ' AND       catalogo.cod_cargo = cargos.cod_cargo';
        LV_sSql := LV_sSql || ' AND       catalogo.cod_prod_ofertado = '||EN_PROD_OFERTADO;
        LV_sSql := LV_sSql || ' AND       catalogo.cod_canal = '||EV_COD_CANAL;
        LV_sSql := LV_sSql || ' AND       catalogo.fec_inicio_vigencia <= '||ED_FECHA_ALTA;
        LV_sSql := LV_sSql || ' AND       catalogo.fec_termino_vigencia >= '||ED_FECHA_BAJA;

        --Se buscan los cargos
        OPEN C_CARGOS FOR
        SELECT cargos.monto_importe, cargos.cod_moneda, catalogo.cod_concepto,
               DECODE(concepto.ind_prorrateable,'S',1,0), cargos.cod_cargo, concepto.tipo_cargo
        FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,
               pf_conceptos_prod_td concepto
        WHERE  catalogo.cod_concepto = concepto.cod_concepto
        AND       catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado
        AND       catalogo.cod_cargo = cargos.cod_cargo
        AND       catalogo.cod_prod_ofertado = EN_PROD_OFERTADO
        AND       catalogo.cod_canal = EV_COD_CANAL
        AND       catalogo.fec_inicio_vigencia <= ED_FECHA_ALTA
        AND       catalogo.fec_termino_vigencia >= ED_FECHA_BAJA;

        --Se incializa la estructura de cargos
        LO_CARGOS_REC := FA_CARGOS_REC_QT('','','','','','','','','','','','','','','','','','','','','','','','');

        --Se incializa la estructura de cargos ocasionales
        LO_CARGOS := FA_CARGOS_QT('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

        LOOP
            FETCH C_CARGOS INTO LN_MONTO_IMPORTE, LV_COD_MONEDA, LN_COD_CONCEPTO, LN_IND_PRORRATEABLE, LN_COD_CARGO, LV_TIP_CARGO;

            EXIT WHEN C_CARGOS%NOTFOUND;

            IF (LV_TIP_CARGO= 'R') THEN
                --Se prepara la estructura para informar cargos recurrentes
                LO_CARGOS_REC.COD_CLIENTESERV      := EN_CLIENTE_DESTINO;
                LO_CARGOS_REC.NUM_ABONADOSERV      := EN_ABONADO_DESTINO;
                LO_CARGOS_REC.COD_PROD_CONTRATADO  := LN_COD_PROD_CONTRATADO;
                LO_CARGOS_REC.COD_CARGO_CONTRATADO := LN_COD_CARGO;
                LO_CARGOS_REC.COD_CLIENTEPAGO      := EN_CLIENTE_DESTINO;
                LO_CARGOS_REC.NUM_ABONADOPAGO      := EN_ABONADO_DESTINO;
--                LO_CARGOS_REC.COD_TIPSERV          := ;--VARCHAR2(2)
--                LO_CARGOS_REC.COD_SERVICIO         := ;--VARCHAR2(5)
                LO_CARGOS_REC.COD_PLANSERV         := LO_ABONADO.COD_PLANSERV;
                LO_CARGOS_REC.IND_CARGOPRO         := LN_IND_PRORRATEABLE;
                LO_CARGOS_REC.COD_CONCEPTO         := LN_COD_CONCEPTO;
                LO_CARGOS_REC.FEC_ALTA             := ED_FECHA_ALTA;
                LO_CARGOS_REC.FEC_BAJA             := ED_FECHA_BAJA;
                LO_CARGOS_REC.FEC_DESDECOBR        := ED_FECHA_ALTA;
                LO_CARGOS_REC.FEC_HASTACOBR        := ED_FECHA_BAJA;
--                LO_CARGOS_REC.IND_BLOQUEO          := ;--VARCHAR2(5)
--                LO_CARGOS_REC.EST_BLOQUEO          := ;--VARCHAR2(5)
                LO_CARGOS_REC.FEC_DESDEBLOC        := ED_FECHA_ALTA;
                LO_CARGOS_REC.FEC_HASTABLOC        := ED_FECHA_BAJA;
--                LO_CARGOS_REC.FEC_ULTFACTURA       := ;--DATE
--                LO_CARGOS_REC.COD_ULTCICLFACT      := ;--NUMBER(10)
--                LO_CARGOS_REC.NUM_ULTPROCESO       := ;--NUMBER(10)
--                LO_CARGOS_REC.FEC_ULTMOD           := ;--DATE
                LO_CARGOS_REC.NOM_USUARIO          := LV_USUARIO;--VARCHAR2(30)

                LV_sSql:= 'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_CONTRATADO||', '
                                    ||LN_COD_CARGO||', '||LO_ABONADO.COD_PLANSERV||', '||LN_IND_PRORRATEABLE||', '||LN_COD_CONCEPTO||')';
                FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR (LO_CARGOS_REC, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
                IF (SN_COD_RETORNO != 0) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;

            ELSE
                LV_sSql:= 'SELECT cod_ciclfact';
                LV_sSql:= LV_sSql ||' FROM fa_ciclfact';
                LV_sSql:= LV_sSql ||'    WHERE  cod_ciclo  = '||LO_ABONADO.COD_CICLO;
                LV_sSql:= LV_sSql ||' AND sysdate BETWEEN fec_desdeocargos AND fec_hastaocargos';

                BEGIN
                    SELECT cod_ciclfact
                    INTO   LO_CARGOS.COD_CICLFACT
                    FROM   fa_ciclfact
                    WHERE  cod_ciclo  = LO_ABONADO.COD_CICLO -- ciclo de facturación del contratante (cod_ciclo)
                    AND sysdate BETWEEN fec_desdeocargos AND fec_hastaocargos;
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                          SN_Cod_retorno:=1411;
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
                             SV_mens_retorno := cv_error_no_clasif;
                          END IF;
                          LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
                          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_AGREGA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                          RETURN FALSE;
                END;

                --LO_CARGOS.SEQ_CARGO              := ;--    NUMBER(9),
                LO_CARGOS.COD_CLIENTE            := EN_CLIENTE_DESTINO;--    NUMBER(10),
                LO_CARGOS.NUM_ABONADO            := EN_ABONADO_DESTINO;--    NUMBER(10),
                LO_CARGOS.COD_PROD_CONTRATADO    := LN_COD_PROD_CONTRATADO;--    NUMBER(38),
                LO_CARGOS.COD_PRODUCTO            := 1;--    NUMBER(1),
                LO_CARGOS.ID_CARGO                := LN_COD_CARGO;--    NUMBER(9),
                LO_CARGOS.COD_CONCEPTO            := LN_COD_CONCEPTO;--    NUMBER(9),
                --LO_CARGOS.COLUMNA                := ;--    NUMBER(6),
                LO_CARGOS.FEC_ALTA                := ED_FECHA_ALTA;--    DATE,
                LO_CARGOS.IMP_CARGO                := LN_MONTO_IMPORTE;--    NUMBER(14,4)
                LO_CARGOS.COD_MONEDA            := LV_COD_MONEDA;--    VARCHAR2(3),
                LO_CARGOS.COD_PLANCOM            := 1;--    NUMBER(6),
                LO_CARGOS.NUM_UNIDADES            := 1;--    NUMBER(6),
                LO_CARGOS.IND_FACTUR            := 9;--    NUMBER(1),
                --LO_CARGOS.NUM_TRANSACCION        := ;--    NUMBER(9),
                --LO_CARGOS.NUM_VENTA            := 0;--    NUMBER(8),
                --LO_CARGOS.NUM_PAQUETE            := ;--    NUMBER(3),
                LO_CARGOS.NUM_TERMINAL            := LO_ABONADO.NUM_CELULAR;--    VARCHAR2(15)
                --LO_CARGOS.COD_CICLFACT        := ;--    NUMBER(6),
                --LO_CARGOS.NUM_SERIE            := ;--    VARCHAR2(25)
                --LO_CARGOS.NUM_SERIEMEC        := ;--    VARCHAR2(20)
                --LO_CARGOS.CAP_CODE            := ;--    NUMBER(7),
                LO_CARGOS.MES_GARANTIA            := 0;--    NUMBER(2),
                --LO_CARGOS.NUM_PREGUIA            := ;--    VARCHAR2(10)
                --LO_CARGOS.NUM_GUIA            := ;--    VARCHAR2(10)
                --LO_CARGOS.COD_CONCEREL        := ;--    NUMBER(8),
                --LO_CARGOS.COLUMNA_REL            := ;--    NUMBER(4),
                --LO_CARGOS.COD_CONCEPTO_DTO    := ;--    NUMBER(4),
                --LO_CARGOS.VAL_DTO                := ;--    NUMBER(14,4)
                --LO_CARGOS.TIP_DTO                := ;--    NUMBER(1),
                LO_CARGOS.IND_CUOTA                := 0;--    NUMBER(1),
                --LO_CARGOS.NUM_CUOTAS            := ;--    NUMBER(3),
                --LO_CARGOS.ORD_CUOTA            := ;--    NUMBER(3),
                LO_CARGOS.IND_SUPERTEL            := 0;--    NUMBER(1),
                --LO_CARGOS.IND_MANUAL            := ;--    NUMBER(1),
                --LO_CARGOS.PREF_PLAZA            := ;--    VARCHAR2(10)
                LO_CARGOS.COD_TECNOLOGIA        := LO_ABONADO.COD_TECNOLOGIA;--    VARCHAR2(7),
                --LO_CARGOS.GLS_DESCRIP            := ;--    VARCHAR2(100
                --LO_CARGOS.NUM_FACTURA            := ;--    NUMBER(10),
                LO_CARGOS.FEC_ULTMOD            := SYSDATE;--    DATE,
                LO_CARGOS.NOM_USUARIO            := LV_USUARIO;--    VARCHAR2(30)

                LV_sSql:= 'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_CONTRATADO
                ||', '||LN_COD_CARGO||', '||LN_COD_CONCEPTO||', '||ED_FECHA_ALTA||', '||LN_MONTO_IMPORTE||', '||LV_COD_MONEDA||', '||
                LO_ABONADO.NUM_CELULAR||', '||LO_ABONADO.COD_TECNOLOGIA||', '||LV_USUARIO||')';

                FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR(LO_CARGOS, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
                IF (SN_COD_RETORNO != 0) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;

            END IF;

        END LOOP;
    END IF;

    RETURN TRUE;

EXCEPTION
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_AGREGA_CON_LISTA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN FALSE;
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_AGREGA_CON_LISTA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN FALSE;
END PV_AGREGA_CON_LISTA_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_QUITA_FN( EN_CLIENTE_DESTINO  IN ge_clientes.cod_cliente%TYPE,
                    EN_ABONADO_DESTINO     IN ga_abocel.num_abonado%TYPE,
                    EN_PROD_CONTRATADO  IN pr_productos_contratados_to.cod_prod_contratado%TYPE,
                    EN_PROD_OFERTADO     IN pr_productos_contratados_to.cod_prod_ofertado%TYPE,
                    ED_FECHA_ALTA        IN DATE,
                    ED_FECHA_BAJA         IN DATE,
                    EN_NUM_MOV_ANT         IN icc_movimiento.num_movant%TYPE,
                    EN_NUM_PROCESO         IN pr_productos_contratados_to.num_proceso%TYPE,
                    EV_COD_CANAL         IN pr_productos_contratados_to.cod_canal%TYPE,
                    EV_IND_CONTRATA        IN pr_productos_contratados_to.ind_condicion_contratacion%TYPE,
                    SN_COD_RETORNO      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                    SV_MENS_RETORNO     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                    SN_NUM_EVENTO       OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_QUITA_FN"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>BOOLEAN</Retorno>>
       <Descripción>Elimina un producto pasando a historico el registro, informa a todas las plataformas de la baja</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LN_COD_PROV_SERV         se_detalles_especificacion_to.cod_prov_serv%TYPE;
LV_IND_TIPO_SERVICIO     se_detalles_especificacion_to.ind_tipo_servicio%TYPE;
LV_COD_PERFIL_LISTA      se_detalles_especificacion_to.cod_perfil_lista%TYPE;
LN_NUMVECES_ORIGEN         pf_paquete_ofertado_to.num_veces_hijo%TYPE;
LN_NUMVECES_DESTINO         pf_paquete_ofertado_to.num_veces_hijo%TYPE;

C_PRO_CONTRATADOS         refcursor;
C_CARGOS                 refcursor;
LO_LISTA_PRODUCTOS         PR_PRODUCTO_DES_LST_QT;
LO_LISTA_NUMEROS         SV_PROD_CONTR_LST_QT;
--LO_LISTA_TOL             TOL_BAJA_PRODUCTO_DET_QT; --Se enmascarara package
LO_LISTA_CENTRALES         IC_PROVISION_QT;
LO_CARGOS_REC         FA_CARGOS_REC_QT;

LN_MONTO_IMPORTE     pf_cargos_productos_td.monto_importe%TYPE;
LV_COD_MONEDA          pf_cargos_productos_td.cod_moneda%TYPE;
LN_COD_CARGO          pf_cargos_productos_td.cod_cargo%TYPE;
LN_COD_CONCEPTO      pf_catalogo_ofertado_td.cod_concepto%TYPE;
LV_USUARIO             ga_abocel.nom_usuarora%TYPE;

ld_fec_baja_tmp         DATE; -- FPP 14-07-2010

--Inicio Datos para traza
LV_DESESTADO VARCHAR2(2000);
LV_INFO_REG VARCHAR2(2000);
LV_NomProc VARCHAR2(2000) := 'PV_PLANES_ADICIOALES_PG.PV_QUITA_FN';
LV_Tabla VARCHAR2(30);
LV_Act VARCHAR2(1);
LNEstado NUMBER;
LVCode VARCHAR2(2000);
LVErrm VARCHAR2(2000);
--Inicio Datos para traza


BEGIN
    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    --Se obtiene el usuario de la OOSS

    --Inicio Prueba Traza
    LV_DESESTADO := 'EN_CLIENTE_DESTINO['||EN_CLIENTE_DESTINO||'] EN_ABONADO_DESTINO['||EN_ABONADO_DESTINO;
    LV_DESESTADO := LV_DESESTADO || '] EN_PROD_CONTRATADO['||EN_PROD_CONTRATADO||'] EN_PROD_OFERTADO['||EN_PROD_OFERTADO;
    LV_DESESTADO := LV_DESESTADO || '] ED_FECHA_ALTA['||ED_FECHA_ALTA||'] ED_FECHA_BAJA['||ED_FECHA_BAJA;
    LV_DESESTADO := LV_DESESTADO || '] EN_NUM_MOV_ANT['||EN_NUM_MOV_ANT||'] EN_NUM_PROCESO['||EN_NUM_PROCESO||']';

    LV_INFO_REG := 'Antes de: SELECT usuario INTO   LV_USUARIO FROM   pv_iorserv WHERE  num_os = '||EN_NUM_PROCESO||' UNION SELECT usuario FROM   ci_orserv WHERE  num_os = '||EN_NUM_PROCESO||'; ';
    LV_NomProc := 'PV_QUITA_FN';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    NULL, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    --Fin Prueba Traza

    BEGIN
        SELECT usuario
        INTO   LV_USUARIO
        FROM   pv_iorserv
        WHERE  num_os = EN_NUM_PROCESO
        UNION
        SELECT usuario
        FROM   ci_orserv
        WHERE  num_os = EN_NUM_PROCESO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            LV_USUARIO := USER;
    END;

    --Inicio Prueba Traza
    LV_DESESTADO := 'EN_CLIENTE_DESTINO['||EN_CLIENTE_DESTINO||'] EN_ABONADO_DESTINO['||EN_ABONADO_DESTINO;
    LV_DESESTADO := LV_DESESTADO || '] EN_PROD_CONTRATADO['||EN_PROD_CONTRATADO||'] EN_PROD_OFERTADO['||EN_PROD_OFERTADO;
    LV_DESESTADO := LV_DESESTADO || '] ED_FECHA_ALTA['||ED_FECHA_ALTA||'] ED_FECHA_BAJA['||ED_FECHA_BAJA;
    LV_DESESTADO := LV_DESESTADO || '] EN_NUM_MOV_ANT['||EN_NUM_MOV_ANT||'] EN_NUM_PROCESO['||EN_NUM_PROCESO||']';

    LV_INFO_REG := 'Despues de: SELECT usuario INTO   LV_USUARIO FROM   pv_iorserv WHERE  num_os = '||EN_NUM_PROCESO||' UNION SELECT usuario FROM   ci_orserv WHERE  num_os = '||EN_NUM_PROCESO||'; ';
    LV_NomProc := 'PV_QUITA_FN';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    NULL, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    --Fin Prueba Traza

    -- INI. FPP 14-07-2010
    IF (ed_fecha_baja IS NULL) THEN
       ld_fec_baja_tmp := ed_fecha_alta;
    ELSE
       IF trunc(ed_fecha_baja) = to_date('31-12-3000', 'dd-mm-yyyy') THEN
          ld_fec_baja_tmp := ed_fecha_alta;
       ELSE
          ld_fec_baja_tmp := ed_fecha_baja;
       END IF;
    END IF;
    -- FIN FPP 14-07-2010

    LO_LISTA_CENTRALES := IC_PROVISION_QT();

    --Inicio Prueba Traza
    LV_DESESTADO := 'EN_CLIENTE_DESTINO['||EN_CLIENTE_DESTINO||'] EN_ABONADO_DESTINO['||EN_ABONADO_DESTINO;
    LV_DESESTADO := LV_DESESTADO || '] EN_PROD_CONTRATADO['||EN_PROD_CONTRATADO||'] EN_PROD_OFERTADO['||EN_PROD_OFERTADO;
    LV_DESESTADO := LV_DESESTADO || '] ED_FECHA_ALTA['||ED_FECHA_ALTA||'] ED_FECHA_BAJA['||ED_FECHA_BAJA;
    LV_DESESTADO := LV_DESESTADO || '] EN_NUM_MOV_ANT['||EN_NUM_MOV_ANT||'] EN_NUM_PROCESO['||EN_NUM_PROCESO||']';

    LV_INFO_REG := 'Antes de: SELECT servicio.ind_tipo_servicio,
                    NVL(servicio.cod_perfil_lista,0),
                    NVL(servicio.cod_prov_serv,0)
                    INTO   LV_IND_TIPO_SERVICIO, LV_COD_PERFIL_LISTA, LN_COD_PROV_SERV
                    FROM   se_detalles_especificacion_to servicio, pf_productos_ofertados_td ofertado
                    WHERE  servicio.cod_espec_prod = ofertado.cod_espec_prod
                    AND       ofertado.cod_prod_ofertado = '||EN_PROD_OFERTADO||';';
    LV_NomProc := 'PV_QUITA_FN';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    NULL, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    --Fin Prueba Traza
    LV_sSql := 'SELECT servicio.ind_tipo_servicio, servicio.cod_perfil_lista, servicio.cod_prov_serv';
    LV_sSql := LV_sSql || ' FROM se_detalles_especificacion_to servicio, pf_productos_ofertados_td ofertado';
    LV_sSql := LV_sSql || ' WHERE servicio.cod_espec_prod = ofertado.cod_espec_prod';
    LV_sSql := LV_sSql || ' AND      ofertado.cod_prod_ofertado = '|| EN_PROD_OFERTADO;

    SELECT servicio.ind_tipo_servicio,
           NVL(servicio.cod_perfil_lista,0),
           NVL(servicio.cod_prov_serv,0)
    INTO   LV_IND_TIPO_SERVICIO, LV_COD_PERFIL_LISTA, LN_COD_PROV_SERV
    FROM   se_detalles_especificacion_to servicio, pf_productos_ofertados_td ofertado
    WHERE  servicio.cod_espec_prod = ofertado.cod_espec_prod
    AND       ofertado.cod_prod_ofertado = EN_PROD_OFERTADO;

    --Inicio Prueba Traza
    LV_DESESTADO := 'EN_CLIENTE_DESTINO['||EN_CLIENTE_DESTINO||'] EN_ABONADO_DESTINO['||EN_ABONADO_DESTINO;
    LV_DESESTADO := LV_DESESTADO || '] EN_PROD_CONTRATADO['||EN_PROD_CONTRATADO||'] EN_PROD_OFERTADO['||EN_PROD_OFERTADO;
    LV_DESESTADO := LV_DESESTADO || '] ED_FECHA_ALTA['||ED_FECHA_ALTA||'] ED_FECHA_BAJA['||ED_FECHA_BAJA;
    LV_DESESTADO := LV_DESESTADO || '] EN_NUM_MOV_ANT['||EN_NUM_MOV_ANT||'] EN_NUM_PROCESO['||EN_NUM_PROCESO||']';

    LV_INFO_REG := 'Despues de: SELECT servicio.ind_tipo_servicio,
                    NVL(servicio.cod_perfil_lista,0),
                    NVL(servicio.cod_prov_serv,0)
                    INTO   LV_IND_TIPO_SERVICIO, LV_COD_PERFIL_LISTA, LN_COD_PROV_SERV
                    FROM   se_detalles_especificacion_to servicio, pf_productos_ofertados_td ofertado
                    WHERE  servicio.cod_espec_prod = ofertado.cod_espec_prod
                    AND       ofertado.cod_prod_ofertado = '||EN_PROD_OFERTADO||';';
    LV_NomProc := 'PV_QUITA_FN';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    NULL, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    --Fin Prueba Traza

    IF (LV_IND_TIPO_SERVICIO = 'TOL') THEN

    --Inicio Prueba Traza
    LV_DESESTADO := 'EN_CLIENTE_DESTINO['||EN_CLIENTE_DESTINO||'] EN_ABONADO_DESTINO['||EN_ABONADO_DESTINO;
    LV_DESESTADO := LV_DESESTADO || '] EN_PROD_CONTRATADO['||EN_PROD_CONTRATADO||'] EN_PROD_OFERTADO['||EN_PROD_OFERTADO;
    LV_DESESTADO := LV_DESESTADO || '] ED_FECHA_ALTA['||ED_FECHA_ALTA||'] ED_FECHA_BAJA['||ED_FECHA_BAJA;
    LV_DESESTADO := LV_DESESTADO || '] EN_NUM_MOV_ANT['||EN_NUM_MOV_ANT||'] EN_NUM_PROCESO['||EN_NUM_PROCESO||']';

    LV_INFO_REG := 'Antes de: TOL_PRODUCTO_CONTRATADO_PG.TOL_BAJA_FACHADA_PR@LNK_PRODUC_SCL_TOL('||EN_PROD_CONTRATADO||','||ld_fec_baja_tmp||')';
    LV_NomProc := 'PV_QUITA_FN';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    NULL, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    --Fin Prueba Traza

        --Se descontrata el producto en TOL
        LV_sSql := 'TOL_PRODUCTO_CONTRATADO_PG.TOL_BAJA_PRODUCTO_PR@LNK_PRODUC_SCL_TOL('||EN_PROD_CONTRATADO||','||ld_fec_baja_tmp||')';
        --TOL_PRODUCTO_CONTRATADO_PG.TOL_BAJA_FACHADA_PR(EN_PROD_CONTRATADO, ED_FECHA_ALTA,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        TOL_PRODUCTO_CONTRATADO_PG.TOL_BAJA_FACHADA_PR( EN_PROD_CONTRATADO,
                                                                           --ED_FECHA_ALTA,
                                                                           ld_fec_baja_tmp,  -- FPP 03-08-2010
                                                                           SN_COD_RETORNO,
                                                                           SV_MENS_RETORNO,
                                                                           SN_NUM_EVENTO);

        --Inicio Prueba Traza
    LV_DESESTADO := 'EN_CLIENTE_DESTINO['||EN_CLIENTE_DESTINO||'] EN_ABONADO_DESTINO['||EN_ABONADO_DESTINO;
    LV_DESESTADO := LV_DESESTADO || '] EN_PROD_CONTRATADO['||EN_PROD_CONTRATADO||'] EN_PROD_OFERTADO['||EN_PROD_OFERTADO;
    LV_DESESTADO := LV_DESESTADO || '] ED_FECHA_ALTA['||ED_FECHA_ALTA||'] ED_FECHA_BAJA['||ED_FECHA_BAJA;
    LV_DESESTADO := LV_DESESTADO || '] EN_NUM_MOV_ANT['||EN_NUM_MOV_ANT||'] EN_NUM_PROCESO['||EN_NUM_PROCESO||']';

    LV_INFO_REG := 'Despues de: TOL_PRODUCTO_CONTRATADO_PG.TOL_BAJA_FACHADA_PR@LNK_PRODUC_SCL_TOL'||EN_PROD_CONTRATADO||','||ld_fec_baja_tmp||')';
    LV_NomProc := 'PV_QUITA_FN';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';
    LNEstado := SN_NUM_EVENTO;
    LVCode := SN_COD_RETORNO;
    LVErrm := SV_MENS_RETORNO;

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    NULL, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    --Fin Prueba Traza

        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;


        IF (LN_COD_PROV_SERV != 0) THEN    -- Si el producto es de tipo tol, y tiene impacto en centrales se envia comando
            --Se crea arreglo para invocar a centrales
            LO_LISTA_CENTRALES.TIP_ACCION :=   '2';
            LO_LISTA_CENTRALES.COD_PROD_CONTRAT := EN_PROD_CONTRATADO;
            LO_LISTA_CENTRALES.FECHA_EJECUCION := ED_FECHA_ALTA;
            LO_LISTA_CENTRALES.USUARIO :=  'SCL';
            LO_LISTA_CENTRALES.NUM_MOVANT :=  EN_NUM_MOV_ANT;
            LO_LISTA_CENTRALES.COD_CLIENTE := EN_CLIENTE_DESTINO;
            LO_LISTA_CENTRALES.NUM_ABONADO := EN_ABONADO_DESTINO;
            LO_LISTA_CENTRALES.NOM_USUARORA := LV_USUARIO;

            --Se envia movimiento a centrales
            LV_sSql := 'IC_PROVISION_PG.IC_INSERTA_PR('||LO_LISTA_CENTRALES.TIP_ACCION||','
                                                        ||LO_LISTA_CENTRALES.COD_PROD_CONTRAT||','
                                                        ||LO_LISTA_CENTRALES.FECHA_EJECUCION||','
                                                        ||LO_LISTA_CENTRALES.USUARIO||','
                                                        ||LO_LISTA_CENTRALES.NUM_MOVANT||')';

            IC_PROVISION_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        END IF;
    ELSIF (LV_IND_TIPO_SERVICIO = 'AA') THEN

        --Se crea arreglo para invocar a centrales
        LO_LISTA_CENTRALES.TIP_ACCION :=   '2';
        LO_LISTA_CENTRALES.COD_PROD_CONTRAT := EN_PROD_CONTRATADO;
        LO_LISTA_CENTRALES.FECHA_EJECUCION := ED_FECHA_ALTA;
        LO_LISTA_CENTRALES.USUARIO :=  'SCL';
        LO_LISTA_CENTRALES.NUM_MOVANT :=  EN_NUM_MOV_ANT;
        LO_LISTA_CENTRALES.COD_CLIENTE := EN_CLIENTE_DESTINO;
        LO_LISTA_CENTRALES.NUM_ABONADO := EN_ABONADO_DESTINO;
        LO_LISTA_CENTRALES.NOM_USUARORA := LV_USUARIO;

        --Se envia movimiento a centrales
        LV_sSql := 'IC_PROVISION_PG.IC_INSERTA_PR('||LO_LISTA_CENTRALES.TIP_ACCION||','
                                                    ||LO_LISTA_CENTRALES.COD_PROD_CONTRAT||','
                                                    ||LO_LISTA_CENTRALES.FECHA_EJECUCION||','
                                                    ||LO_LISTA_CENTRALES.USUARIO||','
                                                    ||LO_LISTA_CENTRALES.NUM_MOVANT||')';

        IC_PROVISION_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
    END IF;

    -- INI Traza 200250|06-11-2013
    LV_DESESTADO := 'EV_IND_CONTRATA['||EV_IND_CONTRATA||']';

    LV_INFO_REG := 'Antes de IF (EV_IND_CONTRATA = O OR EV_IND_CONTRATA = D)';
    LV_NomProc := 'PV_QUITA_FN';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    200250, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    -- FIN Traza 200250|06-11-2013

    -- CSR_200250|11-11-2013|JHA
    -- Agrega EV_IND_CONTRATA = 'D' para eliminar cargos recurrentes por defecto
    -- IF (EV_IND_CONTRATA = 'O') THEN
    IF (EV_IND_CONTRATA = 'O' OR EV_IND_CONTRATA = 'D') THEN
        LV_sSql := ' SELECT cargos.monto_importe, cargos.cod_moneda, catalogo.cod_concepto, cargos.cod_cargo';
        LV_sSql := LV_sSql || ' FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,';
        LV_sSql := LV_sSql || ' pf_conceptos_prod_td concepto';
        LV_sSql := LV_sSql || ' WHERE  catalogo.cod_concepto = concepto.cod_concepto';
        LV_sSql := LV_sSql || ' AND       catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado';
        LV_sSql := LV_sSql || ' AND       catalogo.cod_cargo = cargos.cod_cargo';
        LV_sSql := LV_sSql || ' AND       catalogo.cod_prod_ofertado = '||EN_PROD_OFERTADO;
--        LV_sSql := LV_sSql || ' AND       catalogo.cod_canal = '||EV_COD_CANAL;
        LV_sSql := LV_sSql || ' AND       concepto.tipo_cargo = ''R''';
        --Se buscan los cargos recurrentes
        OPEN C_CARGOS FOR
        SELECT cargos.monto_importe, cargos.cod_moneda, catalogo.cod_concepto, cargos.cod_cargo
        FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,
               pf_conceptos_prod_td concepto
        WHERE  catalogo.cod_concepto = concepto.cod_concepto
        AND       catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado
        AND       catalogo.cod_cargo = cargos.cod_cargo
        AND       catalogo.cod_prod_ofertado = EN_PROD_OFERTADO
--        AND       catalogo.cod_canal = EV_COD_CANAL
        AND       concepto.tipo_cargo = 'R';

        --Se incializa la estructura de cargos
        LO_CARGOS_REC := FA_CARGOS_REC_QT('','','','','','','','','','','','','','','','','','','','','','','','');

        LOOP
            FETCH C_CARGOS INTO LN_MONTO_IMPORTE, LV_COD_MONEDA, LN_COD_CONCEPTO, LN_COD_CARGO;

            EXIT WHEN C_CARGOS%NOTFOUND;

            --Se prepara la estructura para informar cargos recurrentes
            LO_CARGOS_REC.COD_CLIENTESERV      := EN_CLIENTE_DESTINO;
            LO_CARGOS_REC.NUM_ABONADOSERV      := EN_ABONADO_DESTINO;
            LO_CARGOS_REC.COD_PROD_CONTRATADO  := EN_PROD_CONTRATADO;
            LO_CARGOS_REC.COD_CARGO_CONTRATADO := LN_COD_CARGO;
            LO_CARGOS_REC.COD_CONCEPTO         := LN_COD_CONCEPTO;
            LO_CARGOS_REC.FEC_ALTA             := ED_FECHA_ALTA;
            LO_CARGOS_REC.FEC_BAJA             := ED_FECHA_ALTA;--Fecha de baja del cargo
            LO_CARGOS_REC.NOM_USUARIO          := LV_USUARIO;

    -- INI Traza 200250|06-11-2013
    LV_DESESTADO := 'EN_CLIENTE_DESTINO['||EN_CLIENTE_DESTINO||'] EN_ABONADO_DESTINO['||EN_ABONADO_DESTINO;
    LV_DESESTADO := LV_DESESTADO || '] EN_PROD_CONTRATADO['||EN_PROD_CONTRATADO;
    LV_DESESTADO := LV_DESESTADO || '] LN_COD_CARGO['||LN_COD_CARGO||'] LN_COD_CONCEPTO['||LN_COD_CONCEPTO;
    LV_DESESTADO := LV_DESESTADO || '] ED_FECHA_ALTA['||ED_FECHA_ALTA||'] ED_FECHA_BAJA['||ED_FECHA_BAJA;
    LV_DESESTADO := LV_DESESTADO || '] LV_USUARIO['||LV_USUARIO||']';

    LV_INFO_REG := 'Antes de IF (EV_IND_CONTRATA = O OR EV_IND_CONTRATA = D)';
    LV_NomProc := 'PV_QUITA_FN';
    LV_Tabla := 'ge_aud_regulariza_td';
    LV_Act := 'S';

    pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                    en_abonado_destino, --> num_inter
                                    1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3', --> tipo de ejecuccion 3=OK // 4 NOOK
                                    200250, --> Numero incidencia (uno nunca sabe)
                                    'PA', --> cod_tipmodi
                                    NULL, --> cod_os
                                    LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc, --> Nombre procedimiento
                                    LV_Tabla, --> Tabla en la que vas( del ruteo)
                                    LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL, --> Da lo mismo
                                    SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0, --> Da lo mismo
                                    LNEstado, --> Retorno
                                    LVCode, --> Retorno
                                    LVErrm); --> Retorno
    -- FIN Traza 200250|06-11-2013

            LV_sSql:= 'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_PR('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||EN_PROD_CONTRATADO||', '
                                ||LN_COD_CARGO||', '||LN_COD_CONCEPTO||')';
            FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_PR (LO_CARGOS_REC, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        END LOOP;
    END IF;

    IF (LV_COD_PERFIL_LISTA != 0) THEN
        --Se crea arreglo para descontratar la lista de números
        LO_LISTA_NUMEROS:=SV_PROD_CONTR_LST_QT(SV_PROD_CONTRA_QT(EN_PROD_CONTRATADO,EN_NUM_PROCESO,EV_COD_CANAL,'','',''));

        --Se descontrata la lista de numeros asociado al producto
        LV_sSql := 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_U_PR('||EN_PROD_CONTRATADO||','||EN_NUM_PROCESO||','||EV_COD_CANAL||')';
        SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_U_PR(LO_LISTA_NUMEROS, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
    END IF;

    --Se crea arreglo para descontratar el producto
    LO_LISTA_PRODUCTOS:=PR_PRODUCTO_DES_LST_QT(PR_PRODUCTO_DESCONTRATA_QT(EV_COD_CANAL,EN_NUM_PROCESO,ED_FECHA_ALTA,'','','','',ED_FECHA_ALTA,'','','','','','','','','','','','',EN_PROD_CONTRATADO,NULL, NULL, NULL) );

    --Se descontrata el producto
    LV_sSql := 'PR_PRODUCTOS_CONTRATADOS_PG.PR_PRODUCTO_U_PR('||EV_COD_CANAL||','||EN_NUM_PROCESO||','||ED_FECHA_ALTA||','||EN_PROD_CONTRATADO||')';
    PR_PRODUCTOS_CONTRATADOS_PG.PR_PRODUCTO_U_PR(LO_LISTA_PRODUCTOS, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
    IF (SN_COD_RETORNO != 0) THEN
        RAISE ERROR_SUBFUNCION;
    END IF;


    RETURN TRUE;

EXCEPTION
   WHEN ERROR_SUBFUNCION THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        --Inicio Prueba Traza
        LV_DESESTADO := 'EN_CLIENTE_DESTINO['||EN_CLIENTE_DESTINO||'] EN_ABONADO_DESTINO['||EN_ABONADO_DESTINO;
        LV_DESESTADO := LV_DESESTADO || '] EN_PROD_CONTRATADO['||EN_PROD_CONTRATADO||'] EN_PROD_OFERTADO['||EN_PROD_OFERTADO;
        LV_DESESTADO := LV_DESESTADO || '] ED_FECHA_ALTA['||ED_FECHA_ALTA||'] ED_FECHA_BAJA['||ED_FECHA_BAJA;
        LV_DESESTADO := LV_DESESTADO || '] EN_NUM_MOV_ANT['||EN_NUM_MOV_ANT||'] EN_NUM_PROCESO['||EN_NUM_PROCESO||']';

        LV_INFO_REG := 'Entra a ERROR_SUBFUNCION, SN_COD_RETORNO['||SN_COD_RETORNO||'] SV_MENS_RETORNO['||SV_MENS_RETORNO||'] SN_NUM_EVENTO['||SN_NUM_EVENTO||']';
        LV_NomProc := 'PV_QUITA_FN';
        LV_Tabla := 'ge_aud_regulariza_td';
        LV_Act := 'S';
        LNEstado := SN_NUM_EVENTO;
        LVCode := SN_COD_RETORNO;
        LVErrm := SV_MENS_RETORNO;

        pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                        en_abonado_destino, --> num_inter
                                        1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                        '4', --> tipo de ejecuccion 3=OK // 4 NOOK
                                        NULL, --> Numero incidencia (uno nunca sabe)
                                        'PA', --> cod_tipmodi
                                        NULL, --> cod_os
                                        LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                        LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                        LV_NomProc, --> Nombre procedimiento
                                        LV_Tabla, --> Tabla en la que vas( del ruteo)
                                        LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                        NULL, --> Da lo mismo
                                        SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                        SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                        0, --> Da lo mismo
                                        LNEstado, --> Retorno
                                        LVCode, --> Retorno
                                        LVErrm); --> Retorno
        --Fin Prueba Traza


      RETURN FALSE;
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      --Inicio Prueba Traza
        LV_DESESTADO := 'EN_CLIENTE_DESTINO['||EN_CLIENTE_DESTINO||'] EN_ABONADO_DESTINO['||EN_ABONADO_DESTINO;
        LV_DESESTADO := LV_DESESTADO || '] EN_PROD_CONTRATADO['||EN_PROD_CONTRATADO||'] EN_PROD_OFERTADO['||EN_PROD_OFERTADO;
        LV_DESESTADO := LV_DESESTADO || '] ED_FECHA_ALTA['||ED_FECHA_ALTA||'] ED_FECHA_BAJA['||ED_FECHA_BAJA;
        LV_DESESTADO := LV_DESESTADO || '] EN_NUM_MOV_ANT['||EN_NUM_MOV_ANT||'] EN_NUM_PROCESO['||EN_NUM_PROCESO||']';

        LV_INFO_REG := 'Entra a OTHERS, SN_COD_RETORNO['||SN_COD_RETORNO||'] SV_MENS_RETORNO['||SV_MENS_RETORNO||'] SN_NUM_EVENTO['||SN_NUM_EVENTO||']'; --198305
        LV_NomProc := 'PV_QUITA_FN';
        LV_Tabla := 'ge_aud_regulariza_td';
        LV_Act := 'S';
        LNEstado := SN_NUM_EVENTO;
        LVCode := SN_COD_RETORNO;
        LVErrm := SV_MENS_RETORNO;

        pv_general_ooss_pg.PV_AUDREG_PR('PA', --> cod_modulo
                                        en_abonado_destino, --> num_inter
                                        1, --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                        '4', --> tipo de ejecuccion 3=OK // 4 NOOK
                                        NULL, --> Numero incidencia (uno nunca sabe)
                                        'PA', --> cod_tipmodi
                                        NULL, --> cod_os
                                        LV_DESESTADO, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                        LV_INFO_REG, --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                        LV_NomProc, --> Nombre procedimiento
                                        LV_Tabla, --> Tabla en la que vas( del ruteo)
                                        LV_Act, --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                        NULL, --> Da lo mismo
                                        SQLCODE, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                        SQLERRM, --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                        0, --> Da lo mismo
                                        LNEstado, --> Retorno
                                        LVCode, --> Retorno
                                        LVErrm); --> Retorno
        --Fin Prueba Traza
      RETURN FALSE;
END PV_QUITA_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_QUITA_PLANES_DEFECTO_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_ORIGEN     IN ta_plantarif.cod_plantarif%TYPE,
                                        EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                        ED_FECHA_ALTA        IN DATE,
                                        ED_FECHA_BAJA        IN DATE,
                                        EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                        EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                        EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_QUITA_PLANES_DEFECTO_PR
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Elimina los planes por defecto del plan origen que no esten por defecto al plan destino</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;

C_PRO_CONTRATADOS         refcursor;
lv_aplica_plan_adic    GED_PARAMETROS.val_parametro%TYPE; -- FPP 06-07-2010
BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    lv_aplica_plan_adic := Ge_Fn_Devvalparam('GE', 1, 'APLICA_PLAN_ADIC_OO');  -- FPP 06-07-2010

    IF (lv_aplica_plan_adic = 'TRUE') THEN -- FPP 06-07-2010
    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));

    --Inicio Inc. 170939 - FDL - 14/08/2011
    lv_ssql := 'SELECT planAdicional.COD_PROD_OFERTADO ,productosContratados.COD_PROD_CONTRATADO ';
    lv_ssql := lv_ssql || 'FROM ta_plantarif planTarifario, ';
    lv_ssql := lv_ssql || 'ps_plantarif_planadic_td planAdicional, ';
    lv_ssql := lv_ssql || 'pr_productos_contratados_to productosContratados ';
    lv_ssql := lv_ssql || 'WHERE planAdicional.COD_PLANTARIF = planTarifario.COD_PLANTARIF ';
    lv_ssql := lv_ssql || 'AND planAdicional.TIPO_RELACION_PA = 2 ';
    lv_ssql := lv_ssql || 'AND productosContratados.cod_cliente_beneficiario = productosContratados.cod_cliente_contratante ';
    lv_ssql := lv_ssql || 'AND productosContratados.num_abonado_beneficiario = productosContratados.num_abonado_contratante ';
    lv_ssql := lv_ssql || 'AND productosContratados.ind_condicion_contratacion = D ';
    lv_ssql := lv_ssql || 'AND planTarifario.COD_PLANTARIF = '||EV_PLAN_ORIGEN;
    lv_ssql := lv_ssql || ' AND productosContratados.COD_CLIENTE_CONTRATANTE = '||EN_CLIENTE_ORIGEN;
    lv_ssql := lv_ssql || ' AND productosContratados.NUM_ABONADO_CONTRATANTE = '||EN_ABONADO_ORIGEN;
    lv_ssql := lv_ssql || 'AND planTarifario.COD_PLANTARIF NOT IN ';
    lv_ssql := lv_ssql || '(SELECT planTarifario.COD_PLANTARIF ';
    lv_ssql := lv_ssql || 'FROM ta_plantarif planTarifario, ps_plantarif_planadic_td planAdicional ';
    lv_ssql := lv_ssql || 'WHERE planTarifario.COD_PLANTARIF = planAdicional.COD_PLANTARIF ';
    lv_ssql := lv_ssql || 'AND planTarifario.COD_PLANTARIF = '||EV_PLAN_DESTINO||')';
    /*
    LV_sSql := 'SELECT paqueteOrigen.cod_prod_hijo, paqueteOrigen.num_veces_hijo, producto.cod_prod_contratado';
    LV_sSql := LV_sSql || ' FROM ta_plantarif planOrigen, ';
    LV_sSql := LV_sSql || ' pf_paquete_ofertado_to paqueteOrigen,';
    LV_sSql := LV_sSql || ' pr_productos_contratados_to producto  ';
    LV_sSql := LV_sSql || ' WHERE paqueteOrigen.cod_prod_padre = planOrigen.cod_prod_padre';
    LV_sSql := LV_sSql || ' AND paqueteOrigen.cod_prod_hijo = producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' AND producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario = producto.num_abonado_contratante';
    LV_sSql := LV_sSql || ' AND producto.ind_condicion_contratacion = ''D''';
    LV_sSql := LV_sSql || ' AND planOrigen.cod_plantarif = '||EV_PLAN_ORIGEN;
    LV_sSql := LV_sSql || ' AND producto.COD_CLIENTE_CONTRATANTE = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND producto.NUM_ABONADO_CONTRATANTE = '||EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND paqueteOrigen.cod_prod_hijo NOT IN ';
    LV_sSql := LV_sSql || ' (SELECT paqueteDestino.COD_PROD_HIJO';
    LV_sSql := LV_sSql || ' FROM ta_plantarif planDestino, pf_paquete_ofertado_to paqueteDestino';
    LV_sSql := LV_sSql || ' WHERE paqueteDestino.cod_prod_padre = planDestino.cod_prod_padre';
    LV_sSql := LV_sSql || ' AND planDestino.cod_plantarif = '||EV_PLAN_DESTINO;
    LV_sSql := LV_sSql || ' )';
    */

    -- Se obtienen los planes contratados por defecto que no esten en el plan destino
    /*OPEN C_PRO_CONTRATADOS FOR
    SELECT paqueteOrigen.cod_prod_hijo, producto.cod_prod_contratado
    FROM   ta_plantarif planOrigen,
           pf_paquete_ofertado_to paqueteOrigen,
           pr_productos_contratados_to producto
    WHERE  paqueteOrigen.cod_prod_padre = planOrigen.cod_prod_padre
    AND       paqueteOrigen.cod_prod_hijo = producto.cod_prod_ofertado
    AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante
    AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante
    AND       producto.ind_condicion_contratacion = 'D'
    AND       planOrigen.cod_plantarif = EV_PLAN_ORIGEN
    AND       producto.COD_CLIENTE_CONTRATANTE = EN_CLIENTE_ORIGEN
    AND       producto.NUM_ABONADO_CONTRATANTE = EN_ABONADO_ORIGEN
    AND    paqueteOrigen.cod_prod_hijo NOT IN
        (SELECT paqueteDestino.COD_PROD_HIJO
         FROM   ta_plantarif planDestino, pf_paquete_ofertado_to paqueteDestino
         WHERE  paqueteDestino.cod_prod_padre = planDestino.cod_prod_padre
         AND     planDestino.cod_plantarif = EV_PLAN_DESTINO
        );
    */

  
    
    
    OPEN C_PRO_CONTRATADOS FOR
        SELECT planAdicional.COD_PROD_OFERTADO ,productosContratados.COD_PROD_CONTRATADO
        FROM ta_plantarif planTarifario,
        ps_plantarif_planadic_td planAdicional,
        pr_productos_contratados_to productosContratados
        WHERE planAdicional.COD_PLANTARIF = planTarifario.COD_PLANTARIF
        AND planAdicional.TIPO_RELACION_PA = 2
        AND planAdicional.COD_PROD_OFERTADO=productosContratados.COD_PROD_OFERTADO
        AND productosContratados.cod_cliente_beneficiario = productosContratados.cod_cliente_contratante
        AND productosContratados.num_abonado_beneficiario = productosContratados.num_abonado_contratante
        AND productosContratados.ind_condicion_contratacion = 'D'
        AND planTarifario.COD_PLANTARIF = EV_PLAN_ORIGEN
        AND productosContratados.COD_CLIENTE_CONTRATANTE =EN_CLIENTE_ORIGEN
        AND productosContratados.NUM_ABONADO_CONTRATANTE = EN_ABONADO_ORIGEN
        AND planTarifario.COD_PLANTARIF NOT IN
        (SELECT planTarifario.COD_PLANTARIF
        FROM ta_plantarif planTarifario, ps_plantarif_planadic_td planAdicional
        WHERE planTarifario.COD_PLANTARIF = planAdicional.COD_PLANTARIF
        AND planTarifario.COD_PLANTARIF = EV_PLAN_DESTINO
        );


    --Fin Inc. 170939 - FDL - 14/08/2011

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO  LN_COD_PROD_OFERTADO, LN_COD_PROD_CONTRATADO;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                       EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'D',SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;
CLOSE c_pro_contratados; -- RRG COL 22-01-2011 161846
    END IF; -- FPP 06-07-2010
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_QUITA_PLANES_DEFECTO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_AGREGA_PLANES_DEFECTO_PR (EV_PLAN_ORIGEN        IN ta_plantarif.cod_plantarif%TYPE,
                                        EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                        ED_FECHA_ALTA        IN DATE,
                                        ED_FECHA_BAJA        IN DATE,
                                        EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                        EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                        EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_AGREGA_PLANES_DEFECTO_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Contrata los productos por defecto del plan destino, que no sean por defecto al plan origen</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

LN_COD_PROD_OFERTADO     pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LN_NUM_VECES             pf_paquete_ofertado_to.num_veces_hijo%TYPE;

C_PRO_DEFECTO         refcursor;
C_PRO_DEFECTO_CLIENTE   REFCURSOR; --193616
lv_aplica_plan_adic    GED_PARAMETROS.val_parametro%TYPE;
BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    lv_aplica_plan_adic := Ge_Fn_Devvalparam('GE', 1, 'APLICA_PLAN_ADIC_OO');

    IF (lv_aplica_plan_adic = 'TRUE') THEN -- Los planes por defecto son validos solo en modalidad antigua

        --Inicio Inc. 170939 - FDL - 14/08/2011
        lv_ssql := 'SELECT planAdicional.COD_PROD_OFERTADO, 1 num_veces_hijo ';
        lv_ssql := lv_ssql || 'FROM ta_plantarif planTarifario, ps_plantarif_planadic_td planAdicional ';
        lv_ssql := lv_ssql || 'WHERE planTarifario.COD_PLANTARIF = planAdicional.COD_PLANTARIF ';
        lv_ssql := lv_ssql || 'AND planAdicional.COD_PLANTARIF = '||EV_PLAN_DESTINO;
        lv_ssql := lv_ssql || ' AND planAdicional.TIPO_RELACION_PA = 2 ';
        lv_ssql := lv_ssql || 'AND planAdicional.COD_PLANTARIF NOT IN ';
        lv_ssql := lv_ssql || '(SELECT planAdicional ';
        lv_ssql := lv_ssql || 'FROM ta_plantarif planTarifario, ps_plantarif_planadic_td planAdicional ';
        lv_ssql := lv_ssql || 'WHERE planTarifario.COD_PLANTARIF = planAdicional.COD_PLANTARIF ';
        lv_ssql := lv_ssql || 'AND planAdicional.COD_PLANTARIF = ' ||EV_PLAN_ORIGEN||')';

        /*
        LV_sSql := 'SELECT paqueteDestino.cod_prod_hijo, paqueteDestino.num_veces_hijo';
        LV_sSql := LV_sSql || ' FROM ta_plantarif planDestino, pf_paquete_ofertado_to paqueteDestino';
        LV_sSql := LV_sSql || ' WHERE paqueteDestino.cod_prod_padre = planDestino.cod_prod_padre';
        LV_sSql := LV_sSql || ' AND planDestino.cod_plantarif = '||EV_PLAN_DESTINO;
        LV_sSql := LV_sSql || ' AND paqueteDestino.COD_PROD_HIJO NOT IN';
        LV_sSql := LV_sSql || ' (SELECT paqueteOrigen.cod_prod_hijo';
        LV_sSql := LV_sSql || ' FROM ta_plantarif planOrigen, pf_paquete_ofertado_to paqueteOrigen';
        LV_sSql := LV_sSql || ' WHERE paqueteOrigen.cod_prod_padre = planOrigen.cod_prod_padre';
        LV_sSql := LV_sSql || ' AND planOrigen.cod_plantarif = '||EV_PLAN_ORIGEN||')';
        */

        --Se obtienen los planes adicionales por defecto del destino, que no esten en el origen
        /*
        OPEN C_PRO_DEFECTO FOR
            SELECT paqueteDestino.cod_prod_hijo, paqueteDestino.num_veces_hijo
            FROM   ta_plantarif planDestino, pf_paquete_ofertado_to paqueteDestino
            WHERE  paqueteDestino.cod_prod_padre = planDestino.cod_prod_padre
            AND    planDestino.cod_plantarif = EV_PLAN_DESTINO
            AND    paqueteDestino.COD_PROD_HIJO NOT IN
           (SELECT paqueteorigen.cod_prod_hijo
            FROM   ta_plantarif planOrigen, pf_paquete_ofertado_to paqueteOrigen
            WHERE  paqueteOrigen.cod_prod_padre = planOrigen.cod_prod_padre
            AND    planOrigen.cod_plantarif = EV_PLAN_ORIGEN
           );
        */
        
        
        -- inicio 199030 
        /* OPEN C_PRO_DEFECTO FOR
            SELECT planAdicional.COD_PROD_OFERTADO, 1 num_veces_hijo
            FROM ta_plantarif planTarifario, ps_plantarif_planadic_td planAdicional
            WHERE planTarifario.COD_PLANTARIF = planAdicional.COD_PLANTARIF
            AND planAdicional.COD_PLANTARIF = EV_PLAN_DESTINO
            AND planAdicional.TIPO_RELACION_PA = 2
            AND planAdicional.COD_PLANTARIF NOT IN
            (SELECT planAdicional.COD_PLANTARIF
            FROM ta_plantarif planTarifario, ps_plantarif_planadic_td planAdicional
            WHERE planTarifario.COD_PLANTARIF = planAdicional.COD_PLANTARIF
            AND planAdicional.COD_PLANTARIF = EV_PLAN_ORIGEN);*/
        
        IF  EV_PLAN_ORIGEN <> EV_PLAN_DESTINO     THEN 

        OPEN C_PRO_DEFECTO FOR
            SELECT planAdicional.COD_PROD_OFERTADO, 1 num_veces_hijo
            FROM ta_plantarif planTarifario, ps_plantarif_planadic_td planAdicional
            WHERE planTarifario.COD_PLANTARIF = planAdicional.COD_PLANTARIF
            AND planAdicional.COD_PLANTARIF = EV_PLAN_DESTINO
            AND planAdicional.TIPO_RELACION_PA = 2
            AND planAdicional.COD_PLANTARIF NOT IN
            (SELECT planAdicional.COD_PLANTARIF
            FROM ta_plantarif planTarifario, ps_plantarif_planadic_td planAdicional
            WHERE planTarifario.COD_PLANTARIF = planAdicional.COD_PLANTARIF
            AND planAdicional.COD_PLANTARIF = EV_PLAN_ORIGEN);

         ELSE 
         
         OPEN C_PRO_DEFECTO FOR
            SELECT planAdicional.COD_PROD_OFERTADO, 1 num_veces_hijo
            FROM ta_plantarif planTarifario, ps_plantarif_planadic_td planAdicional
            WHERE planTarifario.COD_PLANTARIF = planAdicional.COD_PLANTARIF
            AND planAdicional.COD_PLANTARIF = EV_PLAN_DESTINO
            AND planAdicional.TIPO_RELACION_PA = 2;
            
         
         END IF ;
         --fin 199030
         
         
        --Fin Inc. 170939 - FDL - 14/08/2011
        LOOP

            FETCH C_PRO_DEFECTO INTO LN_COD_PROD_OFERTADO,LN_NUM_VECES;

            EXIT WHEN C_PRO_DEFECTO%NOTFOUND;

            LV_sSql := 'PV_AGREGA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                                      ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''D'''')';
            IF (NOT PV_AGREGA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                        LN_NUM_VECES, EN_NUM_PROCESO, EV_COD_CANAL, 'D',NULL,'N',SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        END LOOP;

        --INI 193616
        OPEN C_PRO_DEFECTO_CLIENTE FOR
            SELECT planAdicional.COD_PROD_OFERTADO, 1 num_veces_hijo
            FROM ta_plantarif planTarifario, ps_plantarif_planadic_td planAdicional, pf_productos_ofertados_td ofertado
            WHERE planTarifario.COD_PLANTARIF = planAdicional.COD_PLANTARIF
            AND planAdicional.COD_PROD_OFERTADO = ofertado.COD_PROD_OFERTADO
            AND ofertado.ind_nivel_aplica = 'C'
            AND planAdicional.COD_PLANTARIF = EV_PLAN_DESTINO
            AND planAdicional.TIPO_RELACION_PA = 2
            AND planAdicional.COD_PLANTARIF NOT IN
            (SELECT planAdicional.COD_PLANTARIF
            FROM ta_plantarif planTarifario, ps_plantarif_planadic_td planAdicional
            WHERE planTarifario.COD_PLANTARIF = planAdicional.COD_PLANTARIF
            AND planAdicional.COD_PLANTARIF = EV_PLAN_ORIGEN);

        LOOP

            FETCH C_PRO_DEFECTO_CLIENTE INTO LN_COD_PROD_OFERTADO,LN_NUM_VECES;
            EXIT WHEN C_PRO_DEFECTO_CLIENTE%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('LN_COD_PROD_OFERTADO:'||LN_COD_PROD_OFERTADO||', LN_NUM_VECES: '||LN_NUM_VECES );

            LV_sSql := 'PV_AGREGA_FN2('||EN_CLIENTE_DESTINO||', 0, '||LN_COD_PROD_OFERTADO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                                      ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''D'''')';
            IF (NOT PV_AGREGA_FN( EN_CLIENTE_DESTINO, 0, LN_COD_PROD_OFERTADO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                        --LN_NUM_VECES, EN_NUM_PROCESO, EV_COD_CANAL, 'D',NULL,'N',SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN  193616
                        LN_NUM_VECES, EN_NUM_PROCESO, EV_COD_CANAL, 'B',NULL,'N',SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        END LOOP;

        --FIN 193616
    END IF;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_AGREGA_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_AGREGA_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_AGREGA_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_AGREGA_PLANES_DEFECTO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_QUITA_OPCIONALES_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                    EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                    ED_FECHA_ALTA        IN DATE,
                                    ED_FECHA_BAJA        IN DATE,
                                    EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                    EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                    EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                    SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_QUITA_OPCIONALES_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Elimina todos los productos contratados opcionalmente por el abonado</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
C_PRO_CONTRATADOS         refcursor;

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));
    --Se obtienen los planes contratados por el abonado, excepto aquellos de los que es solo contratante
    --o solo beneficiario pues se analizan en forma posterior

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
    LV_sSql := LV_sSql || ' WHERE  producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante';
    LV_sSql := LV_sSql || ' AND       producto.ind_condicion_contratacion = ''''O''';

    OPEN C_PRO_CONTRATADOS FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
    FROM   pr_productos_contratados_to producto
    WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
    AND       producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
    AND       producto.cod_cliente_beneficiario = producto.cod_cliente_contratante
    AND       producto.num_abonado_beneficiario = producto.num_abonado_contratante
    AND       producto.ind_condicion_contratacion = 'O';

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO   LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                   EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'O', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_OPCIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_OPCIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_OPCIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_QUITA_OPCIONALES_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_MANTIENE_PLANES_DEFECTO_PR (EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_ORIGEN        IN ta_plantarif.cod_plantarif%TYPE,
                                        EN_NUM_OS_ANULAR   IN ci_orserv.num_os%TYPE,
                                        EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                        ED_FECHA_ALTA        IN DATE,
                                        ED_FECHA_BAJA        IN DATE,
                                        EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                        EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                        EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_MANTIENE_PLANES_DEFECTO_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Da de baja y de alta los productos contratados que esten por defecto en el origen y destino</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LN_COUNT         NUMBER;
LN_NUMEROS         NUMBER :=1;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO     pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LN_NUM_VECES_ORIGEN         pf_paquete_ofertado_to.num_veces_hijo%TYPE;
LN_NUM_VECES_DESTINO     pf_paquete_ofertado_to.num_veces_hijo%TYPE;
LN_NUM_VECES             pf_paquete_ofertado_to.num_veces_hijo%TYPE;
LO_LISTA_NUMEROS SV_LISTA_CONTRA_TO_LST_QT;
LO_NUMERO          SV_LISTA_CONTRA_TO_QT;

C_PRO_DEFECTO         refcursor;
C_PRO_CONTRATADO     refcursor;
C_LISTA_NUMEROS         refcursor;
BEGIN

    LO_NUMERO := SV_LISTA_CONTRA_TO_QT('','','','','','','','','','');
    LO_LISTA_NUMEROS := SV_LISTA_CONTRA_TO_LST_QT(LO_NUMERO);

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));

    LV_sSql := 'SELECT paquete.cod_prod_hijo, paquete.num_veces_hijo';
    LV_sSql := LV_sSql || ' FROM   pf_paquete_ofertado_to paquete, ta_plantarif plan';
    LV_sSql := LV_sSql || ' WHERE  paquete.cod_prod_padre = plan.cod_prod_padre';
    LV_sSql := LV_sSql || ' AND       plan.cod_plantarif = '||EV_PLAN_DESTINO;

    --Se obtienen los planes por defecto del destino
    OPEN C_PRO_DEFECTO FOR
    SELECT paquete.cod_prod_hijo, paquete.num_veces_hijo
    FROM   pf_paquete_ofertado_to paquete, ta_plantarif plan
    WHERE  paquete.cod_prod_padre = plan.cod_prod_padre
    AND       plan.cod_plantarif = EV_PLAN_DESTINO;

    LOOP

        <<SIGUIENTE>>
        FETCH C_PRO_DEFECTO INTO LN_COD_PROD_OFERTADO, LN_NUM_VECES_DESTINO;

        EXIT WHEN C_PRO_DEFECTO%NOTFOUND;

        --Se obtiene el numero de veces que el plan destino está en el origen
        LV_sSql := 'SELECT paquete.num_veces_hijo';
        LV_sSql := LV_sSql || ' FROM pf_paquete_ofertado_to paquete, ta_plantarif plan';
        LV_sSql := LV_sSql || ' WHERE paquete.cod_prod_padre = plan.cod_prod_padre';
        LV_sSql := LV_sSql || ' AND    plan.cod_plantarif = '||EV_PLAN_ORIGEN;
        LV_sSql := LV_sSql || ' AND    paquete.cod_prod_hijo = '||LN_COD_PROD_OFERTADO;

        BEGIN
            SELECT paquete.num_veces_hijo
            INTO   LN_NUM_VECES_ORIGEN
            FROM   pf_paquete_ofertado_to paquete, ta_plantarif plan
            WHERE  paquete.cod_prod_padre = plan.cod_prod_padre
            AND       plan.cod_plantarif = EV_PLAN_ORIGEN
            AND       paquete.cod_prod_hijo = LN_COD_PROD_OFERTADO;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                GOTO SIGUIENTE;--CONTINUE;
        END;

         LV_sSql := 'SELECT producto.cod_prod_contratado';
        LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
        LV_sSql := LV_sSql || ' WHERE  producto.ind_condicion_contratacion = ''''D''''';
        LV_sSql := LV_sSql || ' AND       producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
        LV_sSql := LV_sSql || ' AND       producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;
        LV_sSql := LV_sSql || ' AND       producto.cod_cliente_contratante = producto.cod_cliente_beneficiario';
        LV_sSql := LV_sSql || ' AND       producto.num_abonado_contratante = producto.num_abonado_beneficiario';
        LV_sSql := LV_sSql || ' AND       producto.cod_prod_ofertado = '||LN_COD_PROD_OFERTADO;
        -- Se obtienen los productos contratados
        OPEN C_PRO_CONTRATADO FOR
        SELECT producto.cod_prod_contratado
        FROM   pr_productos_contratados_to producto
        WHERE  producto.ind_condicion_contratacion = 'D'
        AND       producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
        AND       producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
        AND       producto.cod_cliente_contratante = producto.cod_cliente_beneficiario
        AND       producto.num_abonado_contratante = producto.num_abonado_beneficiario
        AND       producto.cod_prod_ofertado = LN_COD_PROD_OFERTADO
        AND       sysdate BETWEEN producto.fec_inicio_vigencia AND NVL(producto.fec_termino_vigencia,TO_DATE('31-12-3000','DD-MM-YYYY'));

        IF (LN_NUM_VECES_ORIGEN = LN_NUM_VECES_DESTINO) THEN

            FOR LN_COUNT IN 1..LN_NUM_VECES_ORIGEN
            LOOP
                FETCH C_PRO_CONTRATADO INTO LN_COD_PROD_CONTRATADO;

                EXIT WHEN C_PRO_CONTRATADO%NOTFOUND;

                LV_sSql := 'SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,';
                LV_sSql := LV_sSql ||  EN_NUM_PROCESO||', '||EV_COD_CANAL||', '||SYSDATE;
                LV_sSql := LV_sSql || 'FROM   sv_lista_contratada_to lista';
                LV_sSql := LV_sSql || 'WHERE  lista.cod_prod_contratado = '||LN_COD_PROD_CONTRATADO;
                --Se obtiene la lista
                OPEN C_LISTA_NUMEROS FOR
                SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,
                       EN_NUM_PROCESO, EV_COD_CANAL, SYSDATE
                FROM   sv_lista_contratada_to lista
                WHERE  lista.cod_prod_contratado = LN_COD_PROD_CONTRATADO;

                LOOP

                    FETCH C_LISTA_NUMEROS INTO LO_NUMERO.valor_elemento, LO_NUMERO.fec_inicio_vigencia, LO_NUMERO.fec_termino_vigencia,
                                LO_NUMERO.cod_categoria_destino, LO_NUMERO.num_proceso, LO_NUMERO.origen_proceso, LO_NUMERO.fec_proceso;

                    EXIT WHEN C_LISTA_NUMEROS%NOTFOUND;

                    IF (LN_NUMEROS>1) THEN
                        --Se expande la lista
                        LO_LISTA_NUMEROS.extend;
                    END IF;
                    --Se agrega el registro
                    LO_LISTA_NUMEROS (LO_LISTA_NUMEROS.count) := LO_NUMERO;

                    LN_NUMEROS := LN_NUMEROS + 1;

                END LOOP;

                --Se da de baja el producto
                LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                    ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
                IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                                        EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'D', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;
                --Se da de alta los productos para el abonado destino con la lista de numeros anterior
                LV_sSql := 'PV_AGREGA_CON_LISTA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                                    ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES_DESTINO||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''D'''')';
                IF (NOT PV_AGREGA_CON_LISTA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                                        EN_NUM_PROCESO, EV_COD_CANAL, LO_LISTA_NUMEROS, 'D', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;

            END LOOP;

        END IF;

        IF (LN_NUM_VECES_ORIGEN > LN_NUM_VECES_DESTINO) THEN

            FOR LN_COUNT IN 1..LN_NUM_VECES_DESTINO
            LOOP
                FETCH C_PRO_CONTRATADO INTO LN_COD_PROD_CONTRATADO;

                EXIT WHEN C_PRO_CONTRATADO%NOTFOUND;

                LV_sSql := 'SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,';
                LV_sSql := LV_sSql ||  EN_NUM_PROCESO||', '||EV_COD_CANAL||', '||SYSDATE;
                LV_sSql := LV_sSql || 'FROM   sv_lista_contratada_to lista';
                LV_sSql := LV_sSql || 'WHERE  lista.cod_prod_contratado = '||LN_COD_PROD_CONTRATADO;
                --Se obtiene la lista
                OPEN C_LISTA_NUMEROS FOR
                SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,
                       EN_NUM_PROCESO, EV_COD_CANAL, SYSDATE
                FROM   sv_lista_contratada_to lista
                WHERE  lista.cod_prod_contratado = LN_COD_PROD_CONTRATADO;

                LOOP

                    FETCH C_LISTA_NUMEROS INTO LO_NUMERO.valor_elemento, LO_NUMERO.fec_inicio_vigencia, LO_NUMERO.fec_termino_vigencia,
                                LO_NUMERO.cod_categoria_destino, LO_NUMERO.num_proceso, LO_NUMERO.origen_proceso, LO_NUMERO.fec_proceso;

                    EXIT WHEN C_LISTA_NUMEROS%NOTFOUND;

                    IF (LN_NUMEROS>1) THEN
                        --Se expande la lista
                        LO_LISTA_NUMEROS.extend;
                    END IF;
                    --Se agrega el registro
                    LO_LISTA_NUMEROS (LO_LISTA_NUMEROS.count) := LO_NUMERO;

                    LN_NUMEROS := LN_NUMEROS + 1;
                END LOOP;

                --Se da de baja el producto
                LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                    ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
                IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                                        EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'D', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;
                --Se da de alta los productos para el abonado destino con la lista de numeros anterior
                LV_sSql := 'PV_AGREGA_CON_LISTA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                                    ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES_DESTINO||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''D'''')';
                IF (NOT PV_AGREGA_CON_LISTA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                                        EN_NUM_PROCESO, EV_COD_CANAL, LO_LISTA_NUMEROS, 'D', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;

            END LOOP;

            LN_NUM_VECES := LN_NUM_VECES_ORIGEN - LN_NUM_VECES_DESTINO;

            FOR LN_COUNT IN 1..LN_NUM_VECES
            LOOP

                LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                    ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
                IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                                        EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'D', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;
            END LOOP;

        END IF;

        IF (LN_NUM_VECES_ORIGEN < LN_NUM_VECES_DESTINO) THEN

            FOR LN_COUNT IN 1..LN_NUM_VECES_ORIGEN
            LOOP
                FETCH C_PRO_CONTRATADO INTO LN_COD_PROD_CONTRATADO;

                EXIT WHEN C_PRO_CONTRATADO%NOTFOUND;

                LV_sSql := 'SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,';
                LV_sSql := LV_sSql ||  EN_NUM_PROCESO||', '||EV_COD_CANAL||', '||SYSDATE;
                LV_sSql := LV_sSql || 'FROM   sv_lista_contratada_to lista';
                LV_sSql := LV_sSql || 'WHERE  lista.cod_prod_contratado = '||LN_COD_PROD_CONTRATADO;
                --Se obtiene la lista
                OPEN C_LISTA_NUMEROS FOR
                SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,
                       EN_NUM_PROCESO, EV_COD_CANAL, SYSDATE
                FROM   sv_lista_contratada_to lista
                WHERE  lista.cod_prod_contratado = LN_COD_PROD_CONTRATADO;

                LOOP

                    FETCH C_LISTA_NUMEROS INTO LO_NUMERO.valor_elemento, LO_NUMERO.fec_inicio_vigencia, LO_NUMERO.fec_termino_vigencia,
                                LO_NUMERO.cod_categoria_destino, LO_NUMERO.num_proceso, LO_NUMERO.origen_proceso, LO_NUMERO.fec_proceso;

                    EXIT WHEN C_LISTA_NUMEROS%NOTFOUND;

                    IF (LN_NUMEROS>1) THEN
                        --Se expande la lista
                        LO_LISTA_NUMEROS.extend;
                    END IF;
                    --Se agrega el registro
                    LO_LISTA_NUMEROS (LO_LISTA_NUMEROS.count) := LO_NUMERO;

                    LN_NUMEROS := LN_NUMEROS + 1;

                END LOOP;

                --Se da de baja el producto
                LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                    ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
                IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                                        EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'D', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;
                --Se da de alta los productos para el abonado destino con la lista de numeros anterior
                LV_sSql := 'PV_AGREGA_CON_LISTA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                                    ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES_DESTINO||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''D'''')';
                IF (NOT PV_AGREGA_CON_LISTA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                                        EN_NUM_PROCESO, EV_COD_CANAL, LO_LISTA_NUMEROS, 'D', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;

            END LOOP;

            LN_NUM_VECES := LN_NUM_VECES_DESTINO - LN_NUM_VECES_ORIGEN;

            LV_sSql := 'PV_AGREGA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                        ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''D'''')';
            IF (NOT PV_AGREGA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                            LN_NUM_VECES, EN_NUM_PROCESO, EV_COD_CANAL, 'D',NULL,'N',SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_MANTIENE_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_MANTIENE_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_MANTIENE_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_MANTIENE_PLANES_DEFECTO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_MANTIENE_OPCIONALES_PR (EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_ORIGEN        IN ta_plantarif.cod_plantarif%TYPE,
                                        EN_NUM_OS_ANULAR   IN ci_orserv.num_os%TYPE,
                                        EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                        ED_FECHA_ALTA        IN DATE,
                                        ED_FECHA_BAJA        IN DATE,
                                        EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                        EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                        EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_MANTIENE_OPCIONALES_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Da de baja y alta los productos contratados opcionalmente por un abonado</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LN_COUNT         NUMBER :=1;
LN_NUMEROS         NUMBER :=1;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO     pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LN_NUM_VECES_ORIGEN         pf_paquete_ofertado_to.num_veces_hijo%TYPE;
LN_NUM_VECES_DESTINO     pf_paquete_ofertado_to.num_veces_hijo%TYPE;

C_PRO_DEFECTO         refcursor;
C_LISTA_NUMEROS         refcursor;

LO_LISTA_NUMEROS SV_LISTA_CONTRA_TO_LST_QT;
LO_NUMERO          SV_LISTA_CONTRA_TO_QT;


BEGIN

    LO_NUMERO := SV_LISTA_CONTRA_TO_QT('','','','','','','','','','');
    LO_LISTA_NUMEROS := SV_LISTA_CONTRA_TO_LST_QT(SV_LISTA_CONTRA_TO_QT('','','','','','','','','',''));


    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
    LV_sSql := LV_sSql || ' WHERE  producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND       producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND       producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND       producto.num_abonado_beneficiario = producto.num_abonado_contratante';
    LV_sSql := LV_sSql || ' AND       producto.ind_condicion_contratacion = ''''O''';

    --Se obtienen los planes adicionales opcionales
    OPEN C_PRO_DEFECTO FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
    FROM   pr_productos_contratados_to producto
    WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
    AND       producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
    AND       producto.cod_cliente_beneficiario = producto.cod_cliente_contratante
    AND       producto.num_abonado_beneficiario = producto.num_abonado_contratante
    AND       producto.ind_condicion_contratacion = 'O'
    AND       sysdate BETWEEN producto.fec_inicio_vigencia AND NVL(producto.fec_termino_vigencia,TO_DATE('31-12-3000','DD-MM-YYYY'));

    LOOP
        FETCH C_PRO_DEFECTO INTO LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO;

        EXIT WHEN C_PRO_DEFECTO%NOTFOUND;

        --Se obtiene la lista de numeros
        OPEN C_LISTA_NUMEROS FOR
        SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,
               EN_NUM_PROCESO, EV_COD_CANAL, SYSDATE
        FROM   sv_lista_contratada_to lista
        WHERE  lista.cod_prod_contratado = LN_COD_PROD_CONTRATADO;

        LOOP

            FETCH C_LISTA_NUMEROS INTO LO_NUMERO.valor_elemento, LO_NUMERO.fec_inicio_vigencia, LO_NUMERO.fec_termino_vigencia,
                                           LO_NUMERO.cod_categoria_destino, LO_NUMERO.num_proceso, LO_NUMERO.origen_proceso, LO_NUMERO.fec_proceso;

            EXIT WHEN C_LISTA_NUMEROS%NOTFOUND;

            IF (LN_NUMEROS>1) THEN
                --Se expande la lista
                LO_LISTA_NUMEROS.extend;
            END IF;
            --Se agrega el registro
            LO_LISTA_NUMEROS (LO_LISTA_NUMEROS.count) := LO_NUMERO;

            LN_NUMEROS := LN_NUMEROS + 1;

        END LOOP;
        --Se da de baja el producto
        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                        ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                                EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'O', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
        --Se da de alta los productos para el abonado destino con la lista de numeros anterior
        LV_sSql := 'PV_AGREGA_CON_LISTA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                            ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES_DESTINO||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''O'''')';
        IF (NOT PV_AGREGA_CON_LISTA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                                        EN_NUM_PROCESO, EV_COD_CANAL, LO_LISTA_NUMEROS, 'O', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_MANTIENE_OPCIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_MANTIENE_OPCIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_MANTIENE_OPCIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_MANTIENE_OPCIONALES_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_QUITA_PLANES_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                ED_FECHA_ALTA        IN DATE,
                                ED_FECHA_BAJA        IN DATE,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_QUITA_PLANES_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Descontrata todos los productos contratados</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LV_IND_CONTRATACION        pr_productos_contratados_to.ind_condicion_contratacion%TYPE;
C_PRO_CONTRATADOS         refcursor;

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));
    --Se obtienen los planes contratados por el abonado, excepto aquellos de los que es solo contratante
    --o solo beneficiario pues se analizan en forma posterior

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
    LV_sSql := LV_sSql || ' WHERE  producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante';


    OPEN C_PRO_CONTRATADOS FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado, producto.ind_condicion_contratacion
    FROM   pr_productos_contratados_to producto
    WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
    AND    producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
    AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante
    AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante;

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO   LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LV_IND_CONTRATACION;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
           EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, LV_IND_CONTRATACION, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_QUITA_PLANES_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_PLANES_DEFECTO_PR (EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EV_FECHA_BAJA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_PLANES_DEFECTO_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Contrata todos los productos por defecto al plan destino</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

LN_COD_PROD_OFERTADO     pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LN_NUM_VECES             pf_paquete_ofertado_to.num_veces_hijo%TYPE;

C_PRO_DEFECTO         refcursor;

LD_FECHA_ALTA        DATE;
LD_FECHA_BAJA        DATE;

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LD_FECHA_ALTA     := TO_DATE(EV_FECHA_ALTA,'DD-MM-YYYY HH24:MI:SS');

    IF (EV_FECHA_BAJA IS NULL) THEN
        LD_FECHA_BAJA:= TO_DATE('31-12-3000','DD-MM-YYYY');
    ELSE
        LD_FECHA_BAJA     := TO_DATE(EV_FECHA_BAJA,'DD-MM-YYYY HH24:MI:SS');
        --Se quita la hora de la fecha de termino para los productos de duracion infinita.
        IF (TO_CHAR(LD_FECHA_BAJA,'DD-MM-YYYY') = '31-12-3000') THEN
           LD_FECHA_BAJA := TO_DATE('31-12-3000','DD-MM-YYYY');
        END IF;
    END IF;
  /* inicio INC197463 JLGR se modifica forma de obtener planes adicionales por defecto
    LV_sSql := 'SELECT paquete.cod_prod_hijo, paquete.num_veces_hijo';
    LV_sSql := LV_sSql || ' FROM   ta_plantarif plan, pf_paquete_ofertado_to paquete';
    LV_sSql := LV_sSql || ' WHERE  plan.cod_prod_padre = paquete.cod_prod_padre ';
    LV_sSql := LV_sSql || ' AND    plan.cod_plantarif = '||EV_PLAN_DESTINO;
    --Se obtienen los planes adicionales por defecto
    OPEN C_PRO_DEFECTO FOR
    SELECT paquete.cod_prod_hijo, paquete.num_veces_hijo
    FROM   ta_plantarif plan,
           pf_paquete_ofertado_to paquete
    WHERE  plan.cod_prod_padre = paquete.cod_prod_padre
    AND    plan.cod_plantarif = EV_PLAN_DESTINO;
  */
    LV_sSql := 'SELECT planAdicional.COD_PROD_OFERTADO, 1 num_veces_hijo';
    LV_sSql := LV_sSql || ' FROM ta_plantarif planTarifario, ps_plantarif_planadic_td planAdicional';
    LV_sSql := LV_sSql || '  WHERE planTarifario.COD_PLANTARIF = planAdicional.COD_PLANTARIF ';
    LV_sSql := LV_sSql || ' AND planAdicional.COD_PLANTARIF = '||EV_PLAN_DESTINO;
    LV_sSql := LV_sSql || ' AND planAdicional.TIPO_RELACION_PA = 2 ';

    --Se obtienen los planes adicionales por defecto
    OPEN C_PRO_DEFECTO FOR
    SELECT planAdicional.COD_PROD_OFERTADO, 1 num_veces_hijo
    FROM ta_plantarif planTarifario, ps_plantarif_planadic_td planAdicional
    WHERE planTarifario.COD_PLANTARIF = planAdicional.COD_PLANTARIF
    AND planAdicional.COD_PLANTARIF = EV_PLAN_DESTINO
    AND planAdicional.TIPO_RELACION_PA = 2;

  --fin INC197563

   LOOP

        FETCH C_PRO_DEFECTO INTO LN_COD_PROD_OFERTADO,LN_NUM_VECES;

        EXIT WHEN C_PRO_DEFECTO%NOTFOUND;

        LV_sSql := 'PV_AGREGA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||LD_FECHA_ALTA||', '||LD_FECHA_BAJA
                            ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''D'''')';
        IF (NOT PV_AGREGA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, LD_FECHA_ALTA, LD_FECHA_BAJA, EN_NUM_MOV_ANT,
                    LN_NUM_VECES, EN_NUM_PROCESO, EV_COD_CANAL,'D',NULL,'N', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;


EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_PLANES_DEFECTO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_QUITA_PLANES_CONTRA_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                ED_FECHA_ALTA        IN DATE,
                                ED_FECHA_BAJA        IN DATE,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_QUITA_PLANES_CONTRA_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Elimina todos los productos para los cuales el abonado es solo contratante</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LV_IND_CONTRATACION        pr_productos_contratados_to.ind_condicion_contratacion%TYPE;
C_PRO_CONTRATADOS         refcursor;

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));
    --Se obtienen los planes contratados por el abonado, para aquellos de los que es solo contratante

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
    LV_sSql := LV_sSql || ' WHERE  producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante';


    OPEN C_PRO_CONTRATADOS FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado, producto.ind_condicion_contratacion
    FROM   pr_productos_contratados_to producto
    WHERE  producto.cod_cliente_contratante = EN_CLIENTE_ORIGEN
    AND    producto.num_abonado_contratante = EN_ABONADO_ORIGEN
    AND    producto.cod_cliente_beneficiario != producto.cod_cliente_contratante
    AND    producto.num_abonado_beneficiario != producto.num_abonado_contratante;

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO   LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LV_IND_CONTRATACION;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
           EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, LV_IND_CONTRATACION, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_CONTRA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_CONTRA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_CONTRA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_QUITA_PLANES_CONTRA_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_QUITA_PLANES_BENEF_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                ED_FECHA_ALTA        IN DATE,
                                ED_FECHA_BAJA        IN DATE,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_QUITA_PLANES_BENEF_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Elimina todos los productos para los cuales el abonado es solo beneficiario</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LV_IND_CONTRATACION        pr_productos_contratados_to.ind_condicion_contratacion%TYPE;
C_PRO_CONTRATADOS         refcursor;

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));
    --Se obtienen los planes contratados por el abonado, para aquellos de los que es solo beneficiario

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
    LV_sSql := LV_sSql || ' WHERE  producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante';


    OPEN C_PRO_CONTRATADOS FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado, producto.ind_condicion_contratacion
    FROM   pr_productos_contratados_to producto
    WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
    AND    producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
    AND    producto.cod_cliente_beneficiario != producto.cod_cliente_contratante
    AND    producto.num_abonado_beneficiario != producto.num_abonado_contratante;

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO   LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LV_IND_CONTRATACION;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
           EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, LV_IND_CONTRATACION, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_BENEF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_BENEF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_BENEF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_QUITA_PLANES_BENEF_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_MANTIENE_PLANES_BENEF_PR (EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_ORIGEN        IN ta_plantarif.cod_plantarif%TYPE,
                                        EN_NUM_OS_ANULAR   IN ci_orserv.num_os%TYPE,
                                        EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                        ED_FECHA_ALTA        IN DATE,
                                        ED_FECHA_BAJA        IN DATE,
                                        EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                        EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                        EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_MANTIENE_PLANES_BENEF_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Da de baja y alta los productos para los cuales el abonado es solo beneficiario</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LN_COUNT         NUMBER;
LN_NUMEROS         NUMBER :=1;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO     pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LN_NUM_VECES_ORIGEN         pf_paquete_ofertado_to.num_veces_hijo%TYPE;
LN_NUM_VECES_DESTINO     pf_paquete_ofertado_to.num_veces_hijo%TYPE;

C_PRO_DEFECTO         refcursor;
C_LISTA_NUMEROS         refcursor;

LO_LISTA_NUMEROS SV_LISTA_CONTRA_TO_LST_QT;
LO_NUMERO          SV_LISTA_CONTRA_TO_QT;


BEGIN

    LO_NUMERO := SV_LISTA_CONTRA_TO_QT('','','','','','','','','','');
    LO_LISTA_NUMEROS := SV_LISTA_CONTRA_TO_LST_QT(LO_NUMERO);

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
    LV_sSql := LV_sSql || ' WHERE  producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND       producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND       producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND       producto.num_abonado_beneficiario = producto.num_abonado_contratante';
    LV_sSql := LV_sSql || ' AND       producto.ind_condicion_contratacion = ''O''';

    --Se obtienen los planes adicionales opcionales de los que solo se es beneficiario
    OPEN C_PRO_DEFECTO FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
    FROM   pr_productos_contratados_to producto
    WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
    AND       producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
    AND       producto.cod_cliente_beneficiario != producto.cod_cliente_contratante
    AND       producto.num_abonado_beneficiario != producto.num_abonado_contratante
    AND       producto.ind_condicion_contratacion = 'O'
    AND       sysdate BETWEEN producto.fec_inicio_vigencia AND NVL(producto.fec_termino_vigencia,TO_DATE('31-12-3000','DD-MM-YYYY'));

    LOOP
        FETCH C_PRO_DEFECTO INTO LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO;

        EXIT WHEN C_PRO_DEFECTO%NOTFOUND;

        --Se obtiene la lista de numeros
        OPEN C_LISTA_NUMEROS FOR
        SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,
               EN_NUM_PROCESO, EV_COD_CANAL, SYSDATE
        FROM   sv_lista_contratada_to lista
        WHERE  lista.cod_prod_contratado = LN_COD_PROD_CONTRATADO;

        LOOP

            FETCH C_LISTA_NUMEROS INTO LO_NUMERO.valor_elemento, LO_NUMERO.fec_inicio_vigencia, LO_NUMERO.fec_termino_vigencia,
                                           LO_NUMERO.cod_categoria_destino, LO_NUMERO.num_proceso, LO_NUMERO.origen_proceso, LO_NUMERO.fec_proceso;

            EXIT WHEN C_LISTA_NUMEROS%NOTFOUND;

            IF (LN_NUMEROS>1) THEN
                --Se expande la lista
                LO_LISTA_NUMEROS.extend;
            END IF;
            --Se agrega el registro
            LO_LISTA_NUMEROS (LO_LISTA_NUMEROS.count) := LO_NUMERO;

            LN_NUMEROS := LN_NUMEROS + 1;

        END LOOP;
        --Se da de baja el producto
        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                        ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                   EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'O', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
        --Se da de alta los productos para el abonado destino con la lista de numeros anterior
        LV_sSql := 'PV_AGREGA_CON_LISTA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                            ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES_DESTINO||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''O'''')';
        IF (NOT PV_AGREGA_CON_LISTA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                                        EN_NUM_PROCESO, EV_COD_CANAL, LO_LISTA_NUMEROS, 'O', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_MANTIENE_PLANES_BENEF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_MANTIENE_PLANES_BENEF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_MANTIENE_PLANES_BENEF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_MANTIENE_PLANES_BENEF_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE pv_exclusion_opcionales_pr(en_cliente_origen  IN GE_CLIENTES.cod_cliente%TYPE,
                                       en_abonado_origen  IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                       en_cliente_destino IN GE_CLIENTES.cod_cliente%TYPE,
                                       ev_plan_destino    IN TA_PLANTARIF.cod_plantarif%TYPE,
                                       ed_fecha_alta      IN DATE,
                                       ed_fecha_baja      IN DATE,
                                       en_num_mov_ant     IN ICC_MOVIMIENTO.num_movant%TYPE,
                                       en_num_proceso     IN pr_productos_contratados_to.num_proceso%TYPE,
                                       ev_cod_canal       IN pr_productos_contratados_to.cod_canal%TYPE,
                                       sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                       sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                       sn_num_evento      OUT NOCOPY ge_errores_pg.evento) IS
    /*
     <Documentación
       TipoDoc = "Procedure">>
        <Elemento
           Nombre = "PV_EXCLUSION_OPCIONALES_PR"
               Lenguaje="PL/SQL"
           Fecha="20-11-2008"
           Versión="La del package"
           Diseñador="Andrés Osorio"
           Programador="Andrés Osorio"
           Ambiente Desarrollo="BD">
           <Retorno>N/A</Retorno>>
           <Descripción>Quita planes opcionales que tengan exclusion con planes del cliente destino</Descripción>>
           <Parámetros>
              <Entrada>
                    <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                    <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                    <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                    <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
              </Entrada>
              <Salida>
                 <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
                 <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
                 <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
              </Salida>
           </Parámetros>
        </Elemento>
     </Documentación>
    */
    lv_des_error ge_errores_pg.desevent;
    lv_ssql      ge_errores_pg.vquery;
    error_subfuncion EXCEPTION;
    ln_cod_prod_contratado pr_productos_contratados_to.cod_prod_contratado%TYPE;
    ln_cod_prod_ofertado   pr_productos_contratados_to.cod_prod_ofertado%TYPE;
    ln_cod_hijo_contratado pr_productos_contratados_to.cod_prod_contratado%TYPE;
    ln_cod_hijo_ofertado   pr_productos_contratados_to.cod_prod_ofertado%TYPE;
    ln_cod_paquete         pr_productos_contratados_to.cod_prod_contra_padre%TYPE;
    c_pro_defecto          refcursor;
    c_pro_hijos            refcursor;
    ld_fec_alta            DATE;
    lv_id_espec_prod       VARCHAR2(10);
    lv_tipo_excluye        NUMBER(2);
    lv_id_prod_oferta      VARCHAR2(10);
  BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;
    ld_fec_alta     := ed_fecha_alta - (1 / (24 * 60 * 60));
    lv_ssql         := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    lv_ssql         := lv_ssql ||
                       ' FROM   pr_productos_contratados_to producto';
    lv_ssql         := lv_ssql ||
                       ' WHERE  producto.cod_cliente_beneficiario = ' ||
                       en_cliente_origen;
    lv_ssql         := lv_ssql ||
                       ' AND       producto.num_abonado_beneficiario = ' ||
                       en_abonado_origen;
    lv_ssql         := lv_ssql ||
                       ' AND       producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    lv_ssql         := lv_ssql ||
                       ' AND       producto.num_abonado_beneficiario = producto.num_abonado_contratante';
    lv_ssql         := lv_ssql ||
                       ' AND       producto.ind_condicion_contratacion = ''O''';

    --Se obtienen los planes adicionales opcionales no paquetes
    OPEN c_pro_defecto FOR
      SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
        FROM pr_productos_contratados_to producto
       WHERE producto.cod_cliente_beneficiario = en_cliente_origen
         AND producto.num_abonado_beneficiario = en_abonado_origen
         AND producto.cod_cliente_beneficiario =
             producto.cod_cliente_contratante
         AND producto.num_abonado_beneficiario =
             producto.num_abonado_contratante
         AND producto.ind_condicion_contratacion = 'O'
         AND SYSDATE BETWEEN producto.fec_inicio_vigencia AND
             NVL(producto.fec_termino_vigencia,
                 TO_DATE('31-12-3000', 'DD-MM-YYYY'))
         AND producto.cod_prod_contra_padre = producto.cod_prod_contratado;
    --Incidencia 88002

    LOOP
      FETCH c_pro_defecto
        INTO ln_cod_prod_contratado, ln_cod_prod_ofertado;

      EXIT WHEN c_pro_defecto%NOTFOUND;

      IF (en_abonado_origen = 0) THEN
        lv_ssql := 'PV_EXCLUSION_PLANES_SS_PG.PV_VAL_PAD_EXCLUYENTES_PR(' ||
                   ln_cod_prod_ofertado || ', ''C'', ' || ev_plan_destino || ', ' ||
                   en_cliente_destino || ')';
        Pv_Exclusion_Planes_Ss_Pg.pv_val_pad_excluyentes_pr(ln_cod_prod_ofertado,
                                                            'C',
                                                            ev_plan_destino,
                                                            en_cliente_destino,
                                                            lv_id_espec_prod,
                                                            lv_tipo_excluye,
                                                            lv_id_prod_oferta,
                                                            sn_cod_retorno,
                                                            sv_mens_retorno,
                                                            sn_num_evento);
      ELSE
        lv_ssql := 'PV_EXCLUSION_PLANES_SS_PG.PV_VAL_PAD_EXCLUYENTES_PR (' ||
                   ln_cod_prod_ofertado || ', ''A'', ' || ev_plan_destino || ', ' ||
                   en_cliente_destino || ')';
        Pv_Exclusion_Planes_Ss_Pg.pv_val_pad_excluyentes_pr(ln_cod_prod_ofertado,
                                                            'A',
                                                            ev_plan_destino,
                                                            en_cliente_destino,
                                                            lv_id_espec_prod,
                                                            lv_tipo_excluye,
                                                            lv_id_prod_oferta,
                                                            sn_cod_retorno,
                                                            sv_mens_retorno,
                                                            sn_num_evento);
      END IF;

      IF (sn_cod_retorno = 1) THEN
        lv_ssql := 'PV_EXCLUSION_PLANES_SS_PG.PV_LOG_EXCLUSION_PR(' ||
                   en_num_proceso || ', ' || en_cliente_origen || ', ' ||
                   en_abonado_origen || ', ' || lv_id_espec_prod || ', ' ||
                   lv_tipo_excluye || ', ' || lv_id_prod_oferta || ')';
        Pv_Exclusion_Planes_Ss_Pg.pv_log_exclusion_pr(en_num_proceso,
                                                      en_cliente_origen,
                                                      en_abonado_origen,
                                                      lv_id_espec_prod,
                                                      lv_tipo_excluye,
                                                      lv_id_prod_oferta,
                                                      sn_cod_retorno,
                                                      sv_mens_retorno,
                                                      sn_num_evento);
        --Se da de baja el producto
        lv_ssql := 'PV_QUITA_FN(' || ln_cod_prod_contratado || ', ' ||
                   ln_cod_prod_ofertado || ', ' || ld_fec_alta || ', ' ||
                   en_num_mov_ant || ', ' || en_num_proceso || ', ' ||
                   ev_cod_canal || ')';

        IF (NOT pv_quita_fn(en_cliente_origen,
                            en_abonado_origen,
                            ln_cod_prod_contratado,
                            ln_cod_prod_ofertado,
                            ld_fec_alta,
                            ed_fecha_baja,
                            en_num_mov_ant,
                            en_num_proceso,
                            ev_cod_canal,
                            'O',
                            sn_cod_retorno,
                            sv_mens_retorno,
                            sn_num_evento)) THEN
          RAISE error_subfuncion;
        END IF;
      ELSIF (sn_cod_retorno != 0) THEN
        RAISE error_subfuncion;
      END IF;
    END LOOP;
    CLOSE c_pro_defecto; -- RRG COL 161846 22.01.2011

    lv_ssql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    lv_ssql := lv_ssql || ' FROM   pr_productos_contratados_to producto';
    lv_ssql := lv_ssql || ' WHERE  producto.cod_cliente_beneficiario = ' ||
               en_cliente_origen;
    lv_ssql := lv_ssql || ' AND       producto.num_abonado_beneficiario = ' ||
               en_abonado_origen;
    lv_ssql := lv_ssql ||
               ' AND       producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    lv_ssql := lv_ssql ||
               ' AND       producto.num_abonado_beneficiario = producto.num_abonado_contratante';
    lv_ssql := lv_ssql ||
               ' AND       producto.ind_condicion_contratacion = ''O''';
    lv_ssql := lv_ssql || ' AND       producto.cod_prod_contra_padre = 0';

    --Se obtienen los planes adicionales opcionales paquetes
    OPEN c_pro_defecto FOR
      SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
        FROM pr_productos_contratados_to producto
       WHERE producto.cod_cliente_beneficiario = en_cliente_origen
         AND producto.num_abonado_beneficiario = en_abonado_origen
         AND producto.cod_cliente_beneficiario =
             producto.cod_cliente_contratante
         AND producto.num_abonado_beneficiario =
             producto.num_abonado_contratante
         AND producto.ind_condicion_contratacion = 'O'
         AND SYSDATE BETWEEN producto.fec_inicio_vigencia AND
             producto.fec_termino_vigencia
         AND producto.cod_prod_contra_padre = 0;

    LOOP
      FETCH c_pro_defecto
        INTO ln_cod_prod_contratado, ln_cod_prod_ofertado;

      EXIT WHEN c_pro_defecto%NOTFOUND;

      IF (en_abonado_origen = 0) THEN
        lv_ssql := 'PV_EXCLUSION_PLANES_SS_PG.PV_VAL_PAD_EXCLUYENTES_PR(' ||
                   ln_cod_prod_ofertado || ', ''C'', ' || ev_plan_destino || ', ' ||
                   en_cliente_destino || ')';
        Pv_Exclusion_Planes_Ss_Pg.pv_val_pad_excluyentes_pr(ln_cod_prod_ofertado,
                                                            'C',
                                                            ev_plan_destino,
                                                            en_cliente_destino,
                                                            lv_id_espec_prod,
                                                            lv_tipo_excluye,
                                                            lv_id_prod_oferta,
                                                            sn_cod_retorno,
                                                            sv_mens_retorno,
                                                            sn_num_evento);
      ELSE
        lv_ssql := 'PV_EXCLUSION_PLANES_SS_PG.PV_VAL_PAD_EXCLUYENTES_PR (' ||
                   ln_cod_prod_ofertado || ', ''A'', ' || ev_plan_destino || ', ' ||
                   en_cliente_destino || ')';
        Pv_Exclusion_Planes_Ss_Pg.pv_val_pad_excluyentes_pr(ln_cod_prod_ofertado,
                                                            'A',
                                                            ev_plan_destino,
                                                            en_cliente_destino,
                                                            lv_id_espec_prod,
                                                            lv_tipo_excluye,
                                                            lv_id_prod_oferta,
                                                            sn_cod_retorno,
                                                            sv_mens_retorno,
                                                            sn_num_evento);
      END IF;

      IF (sn_cod_retorno = 1) THEN
        --Se da de baja el producto
        lv_ssql := 'PV_EXCLUSION_PLANES_SS_PG.PV_LOG_EXCLUSION_PR(' ||
                   en_num_proceso || ', ' || en_cliente_origen || ', ' ||
                   en_abonado_origen || ', ' || lv_id_espec_prod || ', ' ||
                   lv_tipo_excluye || ', ' || lv_id_prod_oferta || ')';
        Pv_Exclusion_Planes_Ss_Pg.pv_log_exclusion_pr(en_num_proceso,
                                                      en_cliente_origen,
                                                      en_abonado_origen,
                                                      lv_id_espec_prod,
                                                      lv_tipo_excluye,
                                                      lv_id_prod_oferta,
                                                      sn_cod_retorno,
                                                      sv_mens_retorno,
                                                      sn_num_evento);
        lv_ssql := 'PV_QUITA_FN(' || ln_cod_prod_contratado || ', ' ||
                   ln_cod_prod_ofertado || ', ' || ld_fec_alta || ', ' ||
                   en_num_mov_ant || ', ' || en_num_proceso || ', ' ||
                   ev_cod_canal || ')';

        IF (NOT pv_quita_fn(en_cliente_origen,
                            en_abonado_origen,
                            ln_cod_prod_contratado,
                            ln_cod_prod_ofertado,
                            ld_fec_alta,
                            ed_fecha_baja,
                            en_num_mov_ant,
                            en_num_proceso,
                            ev_cod_canal,
                            'O',
                            sn_cod_retorno,
                            sv_mens_retorno,
                            sn_num_evento)) THEN
          RAISE error_subfuncion;
        END IF;

        lv_ssql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
        lv_ssql := lv_ssql ||
                   ' FROM   pr_productos_contratados_to producto';
        lv_ssql := lv_ssql ||
                   ' WHERE  producto.cod_cliente_beneficiario = ' ||
                   en_cliente_origen;
        lv_ssql := lv_ssql ||
                   ' AND       producto.num_abonado_beneficiario = ' ||
                   en_abonado_origen;
        lv_ssql := lv_ssql ||
                   ' AND       producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
        lv_ssql := lv_ssql ||
                   ' AND       producto.num_abonado_beneficiario = producto.num_abonado_contratante';
        lv_ssql := lv_ssql ||
                   ' AND       producto.ind_condicion_contratacion = ''O''';
        lv_ssql := lv_ssql ||
                   ' AND       producto.cod_prod_contra_padre = ' ||
                   ln_cod_prod_contratado;

        --Se obtienen los planes adicionales opcionales del paquetes
        OPEN c_pro_hijos FOR
          SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
            FROM pr_productos_contratados_to producto
           WHERE producto.cod_cliente_beneficiario = en_cliente_origen
             AND producto.num_abonado_beneficiario = en_abonado_origen
             AND producto.cod_cliente_beneficiario =
                 producto.cod_cliente_contratante
             AND producto.num_abonado_beneficiario =
                 producto.num_abonado_contratante
             AND producto.ind_condicion_contratacion = 'O'
             AND SYSDATE BETWEEN producto.fec_inicio_vigencia AND
                 producto.fec_termino_vigencia
             AND producto.cod_prod_contra_padre = ln_cod_prod_contratado;

        LOOP
          FETCH c_pro_hijos
            INTO ln_cod_hijo_contratado, ln_cod_hijo_ofertado;

          EXIT WHEN c_pro_hijos%NOTFOUND;
          --Se da de baja el producto
          lv_ssql := 'PV_QUITA_FN(' || ln_cod_hijo_contratado || ', ' ||
                     ln_cod_hijo_ofertado || ', ' || ld_fec_alta || ', ' ||
                     en_num_mov_ant || ', ' || en_num_proceso || ', ' ||
                     ev_cod_canal || ')';

          IF (NOT pv_quita_fn(en_cliente_origen,
                              en_abonado_origen,
                              ln_cod_hijo_contratado,
                              ln_cod_hijo_ofertado,
                              ld_fec_alta,
                              ed_fecha_baja,
                              en_num_mov_ant,
                              en_num_proceso,
                              ev_cod_canal,
                              'O',
                              sn_cod_retorno,
                              sv_mens_retorno,
                              sn_num_evento)) THEN
            RAISE error_subfuncion;
          END IF;
        END LOOP;
        CLOSE c_pro_hijos; -- RRG COL 161846 22.01.2011
      ELSIF (sn_cod_retorno != 0) THEN
        RAISE error_subfuncion;
      END IF;
    END LOOP;
    CLOSE c_pro_defecto; -- RRG COL 161846 22.01.2011
  EXCEPTION
    WHEN OTHERS THEN
      sn_cod_retorno := 156;

      IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno, sv_mens_retorno) THEN
        sv_mens_retorno := cv_error_no_clasif;
      END IF;

      lv_des_error  := 'PV_PLANES_ADICIONALES_PG(' || '); - ' || SQLERRM;
      sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento,
                                              'PV',
                                              sv_mens_retorno,
                                              cv_version,
                                              USER,
                                              ' PV_PLANES_ADICIONALES_PG.PV_EXCLUSION_OPCIONALES_PR',
                                              lv_ssql,
                                              sn_cod_retorno,
                                              lv_des_error);
END pv_exclusion_opcionales_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_PLANES_ADICIONALES_PR (EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                    EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                    EV_PLAN_ORIGEN        IN ta_plantarif.cod_plantarif%TYPE,
                                    EN_NUM_OS_ANULAR   IN ci_orserv.num_os%TYPE,
                                    EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                    EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                    EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                    ED_FECHA_ALTA        IN DATE,
                                    ED_FECHA_BAJA        IN DATE,
                                    EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                    EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                    EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                    SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_PLANES_ADICIONALES_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Reliza la mantencion de productos para integrar con los cambios de plan</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

LV_TIPOPLAN_ORIGEN  ta_plantarif.cod_tiplan%TYPE;
LV_IMPORTE_ORIGEN   ta_cargosbasico.imp_cargobasico%TYPE;
LV_TIPOPLAN_DESTINO ta_plantarif.cod_tiplan%TYPE;
LV_IMPORTE_DESTINO  ta_cargosbasico.imp_cargobasico%TYPE;
LV_FECHAINI VARCHAR2(20);
LV_FECHATER VARCHAR2(20);
lv_aplica_plan_adic GED_PARAMETROS.val_parametro%TYPE;

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LV_sSql := 'SELECT plan.cod_tiplan, cargo.imp_cargobasico';
    LV_sSql := LV_sSql || ' FROM   TA_PLANTARIF plan, ta_cargosbasico cargo';
    LV_sSql := LV_sSql || ' WHERE  plan.cod_cargobasico = cargo.cod_cargobasico';
    LV_sSql := LV_sSql || ' AND       cargo.cod_producto = 1';
    LV_sSql := LV_sSql || ' AND       SYSDATE BETWEEN cargo.fec_desde AND cargo.fec_hasta';
    LV_sSql := LV_sSql || ' AND       plan.cod_plantarif = '||EV_PLAN_ORIGEN;


    SELECT plan.cod_tiplan, cargo.imp_cargobasico
    INTO   LV_TIPOPLAN_ORIGEN, LV_IMPORTE_ORIGEN
    FROM   TA_PLANTARIF plan, ta_cargosbasico cargo
    WHERE  plan.cod_cargobasico = cargo.cod_cargobasico
    AND       cargo.cod_producto = 1
    AND       SYSDATE BETWEEN cargo.fec_desde AND cargo.fec_hasta
    AND       plan.cod_plantarif = EV_PLAN_ORIGEN;

    LV_sSql := 'SELECT plan.cod_tiplan, cargo.imp_cargobasico';
    LV_sSql := LV_sSql || ' FROM   TA_PLANTARIF plan, ta_cargosbasico cargo';
    LV_sSql := LV_sSql || ' WHERE  plan.cod_cargobasico = cargo.cod_cargobasico';
    LV_sSql := LV_sSql || ' AND       cargo.cod_producto = 1';
    LV_sSql := LV_sSql || ' AND       SYSDATE BETWEEN cargo.fec_desde AND cargo.fec_hasta';
    LV_sSql := LV_sSql || ' AND       plan.cod_plantarif = '||EV_PLAN_DESTINO;

    SELECT plan.cod_tiplan, cargo.imp_cargobasico
    INTO   LV_TIPOPLAN_DESTINO, LV_IMPORTE_DESTINO
    FROM   TA_PLANTARIF plan, ta_cargosbasico cargo
    WHERE  plan.cod_cargobasico = cargo.cod_cargobasico
    AND       cargo.cod_producto = 1
    AND       SYSDATE BETWEEN cargo.fec_desde AND cargo.fec_hasta
    AND       plan.cod_plantarif = EV_PLAN_DESTINO;

    --Inicio Inc. 170939/ 11-07-2011 / FDL
    lv_aplica_plan_adic := Ge_Fn_Devvalparam('GE', 1, 'APLICA_PLAN_ADIC_OO');
    --Fin Inc. 170939/ 11-07-2011 / FDL

    IF (LV_TIPOPLAN_ORIGEN = LV_TIPOPLAN_DESTINO) THEN
    --REGLA 1

        --Inicio Inc. 170939/ 11-07-2011 / FDL
        IF(lv_aplica_plan_adic = 'FALSE') THEN

            lv_ssql := 'PV_QUITA_PLANES_DEFECTO_PR ('||EN_CLIENTE_ORIGEN|| ', ';
            lv_ssql := lv_ssql || EN_ABONADO_ORIGEN || ', ' || EV_PLAN_ORIGEN || ', ';
            lv_ssql := lv_ssql || EV_PLAN_DESTINO || ', ' || ED_FECHA_ALTA || ', ';
            lv_ssql := lv_ssql || EN_NUM_MOV_ANT || ', ' || EN_NUM_PROCESO || ', ';
            lv_ssql := lv_ssql || EV_COD_CANAL || ')';

            PV_QUITA_PLANES_DEFECTO_PR (  EN_CLIENTE_ORIGEN,
                                          EN_ABONADO_ORIGEN,
                                          EV_PLAN_ORIGEN,
                                          EV_PLAN_DESTINO,
                                          ED_FECHA_ALTA,
                                          ED_FECHA_BAJA,
                                          EN_NUM_MOV_ANT,
                                          EN_NUM_PROCESO,
                                          EV_COD_CANAL,
                                          SN_COD_RETORNO,
                                          SV_MENS_RETORNO,
                                          SN_NUM_EVENTO);

            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

            lv_ssql := 'PV_AGREGA_PLANES_DEFECTO_PR ('||EV_PLAN_ORIGEN||', ';
            lv_ssql := lv_ssql || EN_CLIENTE_DESTINO || ', ' || EN_ABONADO_DESTINO || ', ';
            lv_ssql := lv_ssql || EV_PLAN_DESTINO || ', ' || ED_FECHA_ALTA || ', ';
            lv_ssql := lv_ssql || ED_FECHA_BAJA || ', ' || EN_NUM_MOV_ANT || ', ';
            lv_ssql := lv_ssql || EN_NUM_PROCESO || ', ' || EV_COD_CANAL || ')';

            PV_AGREGA_PLANES_DEFECTO_PR (EV_PLAN_ORIGEN,
                                         EN_CLIENTE_DESTINO,
                                         EN_ABONADO_DESTINO,
                                         EV_PLAN_DESTINO,
                                         ED_FECHA_ALTA,
                                         ED_FECHA_BAJA,
                                         EN_NUM_MOV_ANT,
                                         EN_NUM_PROCESO,
                                         EV_COD_CANAL,
                                         SN_COD_RETORNO,
                                         SV_MENS_RETORNO,
                                         SN_NUM_EVENTO);

            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        END IF;
        --Fin Inc. 170939/ 11-07-2011 / FDL

        IF (EN_CLIENTE_ORIGEN != EN_CLIENTE_DESTINO) THEN

            --Se provisiona la baja de servicios de cliente para el abonado
            lv_ssql := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||EN_CLIENTE_ORIGEN||', ';
            lv_ssql := lv_ssql || EN_ABONADO_ORIGEN || ', ' || ED_FECHA_ALTA || ', ';
            lv_ssql := lv_ssql || EN_NUM_MOV_ANT || ')';

            PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR( EN_CLIENTE_ORIGEN,
                                                               EN_ABONADO_ORIGEN,
                                                               ED_FECHA_ALTA,
                                                               EN_NUM_MOV_ANT,
                                                               EN_NUM_PROCESO,
                                                               SN_COD_RETORNO,
                                                               SV_MENS_RETORNO,
                                                               SN_NUM_EVENTO);

            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;


            --Inicio Inc. 170939/ 11-07-2011 / FDL
            IF(lv_aplica_plan_adic = 'FALSE') THEN

                --Si existe cambio de cliente, se MANTIENEN los productos contratados por defecto
                lv_ssql := 'PV_MANTIENE_PLANES_DEFECTO_PR(' || EN_CLIENTE_ORIGEN || ', ';
                lv_ssql := lv_ssql || EN_ABONADO_ORIGEN || ', ' || EV_PLAN_ORIGEN || ', ';
                lv_ssql := lv_ssql || EN_NUM_OS_ANULAR || ', ' || EN_CLIENTE_DESTINO || ', ';
                lv_ssql := lv_ssql || EN_ABONADO_DESTINO || ', ' || EV_PLAN_DESTINO || ', ';
                lv_ssql := lv_ssql || ED_FECHA_ALTA || ', ' || ED_FECHA_BAJA || ', ';
                lv_ssql := lv_ssql || EN_NUM_MOV_ANT || ', ' || EN_NUM_PROCESO || ', ';
                lv_ssql := lv_ssql || EV_COD_CANAL || ')';


                PV_MANTIENE_PLANES_DEFECTO_PR ( EN_CLIENTE_ORIGEN,
                                                EN_ABONADO_ORIGEN,
                                                EV_PLAN_ORIGEN,
                                                EN_NUM_OS_ANULAR,
                                                EN_CLIENTE_DESTINO,
                                                EN_ABONADO_DESTINO,
                                                EV_PLAN_DESTINO,
                                                ED_FECHA_ALTA,
                                                ED_FECHA_BAJA,
                                                EN_NUM_MOV_ANT,
                                                EN_NUM_PROCESO,
                                                EV_COD_CANAL,
                                                SN_COD_RETORNO,
                                                SV_MENS_RETORNO,
                                                SN_NUM_EVENTO);
                IF (SN_COD_RETORNO != 0) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;
            END IF;
            --Fin Inc. 170939/ 11-07-2011 / FDL

        END IF;

        --Se comparan los importes para determinar la categoria de los planes origen y destino
        IF (LV_IMPORTE_ORIGEN > LV_IMPORTE_DESTINO) THEN

            lv_ssql := 'PV_QUITA_OPCIONALES_PR(' || EN_CLIENTE_ORIGEN || ', ';
            lv_ssql := lv_ssql || EN_ABONADO_ORIGEN || ', ' || ED_FECHA_ALTA || ', ';
            lv_ssql := lv_ssql || EN_NUM_MOV_ANT || ', ' || EN_NUM_PROCESO || ', ';
            lv_ssql := lv_ssql || EV_COD_CANAL || ')';

            PV_QUITA_OPCIONALES_PR( EN_CLIENTE_ORIGEN,
                                    EN_ABONADO_ORIGEN,
                                    ED_FECHA_ALTA,
                                    ED_FECHA_BAJA,
                                    EN_NUM_MOV_ANT,
                                    EN_NUM_PROCESO,
                                    EV_COD_CANAL,
                                    SN_COD_RETORNO,
                                    SV_MENS_RETORNO,
                                    SN_NUM_EVENTO);

            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        ELSE
            IF (EN_CLIENTE_ORIGEN != EN_CLIENTE_DESTINO) THEN
                --Si existe cambio de cliente, se MANTIENEN los productos contratados opcionales
                lv_ssql := 'PV_MANTIENE_OPCIONALES_PR(' || EN_CLIENTE_ORIGEN || ', ';
                lv_ssql := lv_ssql || EN_ABONADO_ORIGEN || ', ' || EV_PLAN_ORIGEN || ', ';
                lv_ssql := lv_ssql || EN_NUM_OS_ANULAR || ', ' || EN_CLIENTE_DESTINO || ', ';
                lv_ssql := lv_ssql || EN_ABONADO_DESTINO || ', ' || EV_PLAN_DESTINO || ', ';
                lv_ssql := lv_ssql || ED_FECHA_ALTA || ', ' || ED_FECHA_BAJA || ', ';
                lv_ssql := lv_ssql || EN_NUM_MOV_ANT || ', ' || EN_NUM_PROCESO || ', ';
                lv_ssql := lv_ssql || EV_COD_CANAL || ')';

                PV_MANTIENE_OPCIONALES_PR ( EN_CLIENTE_ORIGEN,
                                            EN_ABONADO_ORIGEN,
                                            EV_PLAN_ORIGEN,
                                            EN_NUM_OS_ANULAR,
                                            EN_CLIENTE_DESTINO,
                                            EN_ABONADO_DESTINO,
                                            EV_PLAN_DESTINO,
                                            ED_FECHA_ALTA,
                                            ED_FECHA_BAJA,
                                            EN_NUM_MOV_ANT,
                                            EN_NUM_PROCESO,
                                            EV_COD_CANAL,
                                            SN_COD_RETORNO,
                                            SV_MENS_RETORNO,
                                            SN_NUM_EVENTO);
                IF (SN_COD_RETORNO != 0) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;

            END IF;
        END IF;

        /* Se comenta por incidencia 170939
        LV_sSql := 'PV_QUITA_PLANES_DEFECTO_PR ('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_PLAN_ORIGEN||', '||EV_PLAN_DESTINO
                                                ||', '||ED_FECHA_ALTA||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        PV_QUITA_PLANES_DEFECTO_PR (  EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, EV_PLAN_ORIGEN, EV_PLAN_DESTINO, ED_FECHA_ALTA, ED_FECHA_BAJA,
                                    EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

        LV_sSql := 'PV_AGREGA_PLANES_DEFECTO_PR ('||EV_PLAN_ORIGEN||', '||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||EV_PLAN_DESTINO
                            ||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        PV_AGREGA_PLANES_DEFECTO_PR (EV_PLAN_ORIGEN, EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, EV_PLAN_DESTINO,
                                    ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                    EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;


        IF (EN_CLIENTE_ORIGEN != EN_CLIENTE_DESTINO) THEN

            --Se provisiona la baja de servicios de cliente para el abonado
            LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA
                                    ||', '||EN_NUM_MOV_ANT||')';
            PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, ED_FECHA_ALTA, EN_NUM_MOV_ANT, EN_NUM_PROCESO, SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        --Si existe cambio de cliente, se MANTIENEN los productos contratados por defecto
            LV_sSql := 'PV_MANTIENE_PLANES_DEFECTO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_PLAN_ORIGEN||', '||EN_NUM_OS_ANULAR
                    ||', '||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||EV_PLAN_DESTINO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                    ||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
            PV_MANTIENE_PLANES_DEFECTO_PR (EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, EV_PLAN_ORIGEN, EN_NUM_OS_ANULAR, EN_CLIENTE_DESTINO,
                                    EN_ABONADO_DESTINO, EV_PLAN_DESTINO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                    EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        END IF;

        --Se comparan los importes para determinar la categoria de los planes origen y destino
        IF (LV_IMPORTE_ORIGEN > LV_IMPORTE_DESTINO) THEN

            LV_sSql := 'PV_QUITA_OPCIONALES_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA||', '||EN_NUM_MOV_ANT
                                            ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
            PV_QUITA_OPCIONALES_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                    EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        ELSE
            IF (EN_CLIENTE_ORIGEN != EN_CLIENTE_DESTINO) THEN
            --Si existe cambio de cliente, se MANTIENEN los productos contratados opcionales
                LV_sSql := 'PV_MANTIENE_OPCIONALES_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_PLAN_ORIGEN||', '||EN_NUM_OS_ANULAR
                            ||', '||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||EV_PLAN_DESTINO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                            ||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
                PV_MANTIENE_OPCIONALES_PR (EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, EV_PLAN_ORIGEN, EN_NUM_OS_ANULAR, EN_CLIENTE_DESTINO,
                                        EN_ABONADO_DESTINO, EV_PLAN_DESTINO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                        EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
                IF (SN_COD_RETORNO != 0) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;
            END IF;
        END IF;
        */

    ELSE
    --REGLA 2


        IF (EN_CLIENTE_ORIGEN != EN_CLIENTE_DESTINO) THEN

            --Se provisiona la baja de servicios de cliente para el abonado
            LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA
                                    ||', '||EN_NUM_MOV_ANT||')';
            PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, ED_FECHA_ALTA, EN_NUM_MOV_ANT,  EN_NUM_PROCESO, SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        END IF;

        LV_sSql := 'PV_QUITA_PLANES_PR ('||EN_CLIENTE_ORIGEN
                                               ||', '||EN_ABONADO_ORIGEN
                                         ||', '||ED_FECHA_ALTA
                                         ||', '||EN_NUM_MOV_ANT
                                         ||', '||EN_NUM_PROCESO
                                           ||', '||EV_COD_CANAL||')';
        --Descontratar TODOS los Planes
        PV_QUITA_PLANES_PR (  EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                 EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;


        --Inicio Inc. 170939/ 11-07-2011 / FDL
        IF(lv_aplica_plan_adic = 'FALSE') THEN

            lv_ssql := 'PV_PLANES_DEFECTO_PR ('|| EN_CLIENTE_DESTINO ||', ';
            lv_ssql := lv_ssql || EN_ABONADO_DESTINO ||', '|| EV_PLAN_DESTINO ||', ';
            lv_ssql := lv_ssql || ED_FECHA_ALTA ||', '|| ED_FECHA_BAJA ||', ';
            lv_ssql := lv_ssql || EN_NUM_MOV_ANT ||', '|| EN_NUM_PROCESO ||', ';
            lv_ssql := lv_ssql || EV_COD_CANAL ||')';

            --Contratar Planes x Defecto Plan Destino
            LV_FECHAINI := TO_CHAR(ED_FECHA_ALTA,'DD-MM-YYYY HH24:MI:SS');
            LV_FECHATER := TO_CHAR(ED_FECHA_BAJA,'DD-MM-YYYY HH24:MI:SS');

            PV_PLANES_DEFECTO_PR ( EN_CLIENTE_DESTINO,
                                   EN_ABONADO_DESTINO,
                                   EV_PLAN_DESTINO,
                                   LV_FECHAINI,
                                   LV_FECHATER,
                                   EN_NUM_MOV_ANT,
                                   EN_NUM_PROCESO,
                                   EV_COD_CANAL,
                                   SN_COD_RETORNO,
                                   SV_MENS_RETORNO,
                                   SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        END IF;
        --Fin Inc. 170939/ 11-07-2011 / FDL

        /*
        LV_sSql := 'PV_PLANES_DEFECTO_PR ('||
                                        EN_CLIENTE_DESTINO||', '||
                                        EN_ABONADO_DESTINO||', '||
                                        EV_PLAN_DESTINO||', '||
                                        ED_FECHA_ALTA||', '||
                                        ED_FECHA_BAJA||', '||
                                        EN_NUM_MOV_ANT||', '||
                                        EN_NUM_PROCESO||', '||
                                        EV_COD_CANAL||')';
        --Contratar Planes x Defecto Plan Destino
        LV_FECHAINI := TO_CHAR(ED_FECHA_ALTA,'DD-MM-YYYY HH24:MI:SS');
        LV_FECHATER := TO_CHAR(ED_FECHA_BAJA,'DD-MM-YYYY HH24:MI:SS');
        PV_PLANES_DEFECTO_PR (EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, EV_PLAN_DESTINO, LV_FECHAINI, LV_FECHATER, EN_NUM_MOV_ANT,
                                EN_NUM_PROCESO, EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
        */

    END IF;

    IF (LV_TIPOPLAN_ORIGEN != LV_TIPOPLAN_DESTINO) OR (EN_CLIENTE_ORIGEN != EN_CLIENTE_DESTINO) OR (LV_IMPORTE_ORIGEN > LV_IMPORTE_DESTINO) THEN
    --REGLA 3
        LV_sSql := 'PV_QUITA_PLANES_CONTRA_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA||', '||EN_NUM_MOV_ANT
                                        ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        PV_QUITA_PLANES_CONTRA_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                    EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
    END IF;

    IF (LV_TIPOPLAN_ORIGEN != LV_TIPOPLAN_DESTINO) THEN
    --REGLA 4
        LV_sSql := 'PV_QUITA_PLANES_BENEF_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA||', '||EN_NUM_MOV_ANT
                                        ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        PV_QUITA_PLANES_BENEF_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                    EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
    ELSE
        IF (EN_CLIENTE_ORIGEN != EN_CLIENTE_DESTINO) THEN
        --REGLA 5
            LV_sSql := 'PV_MANTIENE_PLANES_BENEF_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_PLAN_ORIGEN||', '||EN_NUM_OS_ANULAR
                            ||', '||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||EV_PLAN_DESTINO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                            ||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
            PV_MANTIENE_PLANES_BENEF_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, EV_PLAN_ORIGEN, EN_NUM_OS_ANULAR, EN_CLIENTE_DESTINO,
                                        EN_ABONADO_DESTINO, EV_PLAN_DESTINO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                                        EN_NUM_PROCESO, EV_COD_CANAL,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        END IF;
    END IF;



EXCEPTION
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_PLANES_ADICIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=282;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_PLANES_ADICIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_PLANES_ADICIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_PLANES_ADICIONALES_PR ;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CADUCA_BENEFICIARIOS_PR( EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                        ED_FECHA_ALTA        IN DATE,
                                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_BENEFICIARIOS_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Elimina la lista de beneficiarios del abonado</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;

BEGIN
    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LV_sSql := 'UPDATE cu_benef_prod_to';
    LV_sSql := LV_sSql || ' SET    fec_termino_vigencia    = '|| ED_FECHA_ALTA;
    LV_sSql := LV_sSql || ' WHERE  cod_cliente_contratante = '|| EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND    num_abonado_contratante = '|| EN_ABONADO_ORIGEN;

    UPDATE cu_benef_prod_to
    SET    fec_termino_vigencia    = ED_FECHA_ALTA
    WHERE  cod_cliente_contratante = EN_CLIENTE_ORIGEN
    AND    num_abonado_contratante = EN_ABONADO_ORIGEN;

EXCEPTION
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_CADUCA_BENEFICIARIOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_CADUCA_BENEFICIARIOS_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CADUCA_BENEF_LISTA_PR(EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                        ED_FECHA_ALTA        IN DATE,
                                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                                        ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_CADUCA_BENEF_LISTA_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Elimina al abonado de cualquier lista de beneficiarios en la que este</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/

LV_des_error       ge_errores_pg.DesEvent;
LV_sSql               ge_errores_pg.vQuery;

BEGIN
    SN_cod_retorno     := 0;
    SV_mens_retorno := ' ';
    SN_num_evento     := 0;

    LV_sSql := ' UPDATE CU_BENEF_PROD_TO';
    LV_sSql := LV_sSql || ' SET       FEC_TERMINO_VIGENCIA = '||ED_FECHA_ALTA;
    LV_sSql := LV_sSql || ' WHERE NUM_ABONADO_BENEFICIARIO = ' || EN_ABONADO_ORIGEN;

    UPDATE CU_BENEF_PROD_TO
    SET       FEC_TERMINO_VIGENCIA = ED_FECHA_ALTA
    WHERE  NUM_ABONADO_BENEFICIARIO = EN_ABONADO_ORIGEN;

EXCEPTION
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_BENEFICIARIOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CADUCA_BENEF_LISTA_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_BENEFICIARIOS_PR( EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                EV_PLAN_ORIGEN        IN ta_plantarif.cod_plantarif%TYPE,
                                EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                ED_FECHA_ALTA        IN DATE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_BENEFICIARIOS_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Realiza la mantencion de las listas de beneficiarios</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;

LV_TIPOPLAN_ORIGEN  ta_plantarif.cod_tiplan%TYPE;
LV_TIPOPLAN_DESTINO  ta_plantarif.cod_tiplan%TYPE;

ERROR_SUBFUNCION EXCEPTION;

BEGIN
    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LV_sSql := 'SELECT plan.cod_tiplan FROM TA_PLANTARIF plan WHERE  plan.cod_plantarif = '||EV_PLAN_ORIGEN;

    SELECT plan.cod_tiplan INTO LV_TIPOPLAN_ORIGEN FROM TA_PLANTARIF plan WHERE plan.cod_plantarif = EV_PLAN_ORIGEN;

    LV_sSql := 'SELECT plan.cod_tiplan FROM TA_PLANTARIF plan WHERE  plan.cod_plantarif = '||EV_PLAN_DESTINO;

    SELECT plan.cod_tiplan INTO LV_TIPOPLAN_DESTINO FROM TA_PLANTARIF plan WHERE plan.cod_plantarif = EV_PLAN_DESTINO;

    IF (LV_TIPOPLAN_ORIGEN = 2 OR LV_TIPOPLAN_ORIGEN = 3) AND (LV_TIPOPLAN_DESTINO = 1) THEN
        --Se eliminan los beneficiarios del abonado origen
        LV_sSql := 'PV_CADUCA_BENEFICIARIOS_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA||')';
        PV_CADUCA_BENEFICIARIOS_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, ED_FECHA_ALTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

        --Se eliminan al abonado origen de todas las listas de beneficiarios
        LV_sSql := 'PV_CADUCA_BENEF_LISTA_PR('||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA||')';
        PV_CADUCA_BENEF_LISTA_PR(EN_ABONADO_ORIGEN, ED_FECHA_ALTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
    ELSE
        IF (LV_TIPOPLAN_ORIGEN = 1) AND (LV_TIPOPLAN_DESTINO = 2 OR LV_TIPOPLAN_DESTINO = 3)   THEN
                --Se eliminan al abonado origen de todas las listas de beneficiarios
            LV_sSql := 'PV_CADUCA_BENEF_LISTA_PR('||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA||')';
            PV_CADUCA_BENEF_LISTA_PR(EN_ABONADO_ORIGEN, ED_FECHA_ALTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        END IF;
    END IF;

EXCEPTION
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_AGREGA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_BENEFICIARIOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_BENEFICIARIOS_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_ELIMINA_VETADO_PR( EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                ED_FECHA_ALTA        IN DATE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_ELIMINA_VETADO_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Elimina al abonado de la lista de vetados del cliente</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;

BEGIN
    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LV_sSql := 'UPDATE cu_vetados_prod_to';
    LV_sSql := LV_sSql || ' SET    fec_termino_vigencia    = '|| ED_FECHA_ALTA;
    LV_sSql := LV_sSql || ' WHERE  cod_cliente_contratante = '|| EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND    num_abonado_contratante = '|| EN_ABONADO_ORIGEN;

    UPDATE cu_vetados_prod_to
    SET    fec_termino_vigencia = ED_FECHA_ALTA
    WHERE  cod_cliente = EN_CLIENTE_ORIGEN
    AND    num_abonado = EN_ABONADO_ORIGEN;


EXCEPTION
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_ELIMINA_VETADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_ELIMINA_VETADO_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_INTEGRACION_PR (   EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                EV_PLAN_ORIGEN        IN ta_plantarif.cod_plantarif%TYPE,
                                EN_NUM_OS_ANULAR   IN ci_orserv.num_os%TYPE,
                                EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EV_FECHA_BAJA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_INTEGRACION_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Realiza la integración entre los cambio de plan y los productos contratados</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
LD_FEC_BAJA     DATE;

C_abonados      refcursor;
LN_ABONADO     ga_abocel.num_abonado%TYPE;

--Inicio Inc. 170939/ 11-07-2011/ FDL
lv_aplica_plan_adic    GED_PARAMETROS.val_parametro%TYPE;
ln_tip_estado NUMBER;
--Fin Inc. 170939/ 11-07-2011/ FDL

ERROR_PARAMETROS  EXCEPTION;
ERROR_INTEGRACION EXCEPTION;

LD_FECHA_ALTA        DATE;
LD_FECHA_BAJA        DATE;

LNEstado   NUMBER;
LVCode     VARCHAR2(2000);
LVErrm     VARCHAR2(2000);

BEGIN
    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LD_FECHA_ALTA     := TO_DATE(EV_FECHA_ALTA,'DD-MM-YYYY HH24:MI:SS');
    --LD_FECHA_ALTA     := TO_DATE(TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),'DD-MM-YYYY HH24:MI:SS');

    --Inicio Inc. 170939/ 11-07-2011/ FDL
    ln_tip_estado   := 3;

    lv_ssql := 'PV_VALIDA_PARAMETROS_FN(' || EN_CLIENTE_ORIGEN || ', ';
    lv_ssql := LV_sSql || EV_PLAN_ORIGEN || ', ' || EN_CLIENTE_DESTINO || ', ';
    lv_ssql := LV_sSql || EV_PLAN_DESTINO || ', ' || LD_FECHA_ALTA || ', ';
    lv_ssql := LV_sSql || EN_NUM_PROCESO || ', ' || EV_COD_CANAL || ', ';
    lv_ssql := LV_sSql || SN_COD_RETORNO || ', ' || SV_MENS_RETORNO || ', ';
    lv_ssql := LV_sSql || SN_NUM_EVENTO || ')';

    --Fin Inc. 170939/ 11-07-2011/ FDL
    
    --trazador 199030 
     PV_GENERAL_OOSS_PG.PV_AUDREG_PR('PV',
                                      EN_ABONADO_ORIGEN,
                                      1,
                                      3,
                                      '199030',
                                      'TL',
                                      '',
                                      'INICIO Ejecucion PV_VALIDA_PARAMETROS_FN', 
                                      EN_CLIENTE_ORIGEN|| ','|| EV_PLAN_ORIGEN || ', ' || EN_CLIENTE_DESTINO ||',' || EV_PLAN_DESTINO || ', ' || LD_FECHA_ALTA ||','|| EN_NUM_PROCESO || ', ' || EV_COD_CANAL ||','|| SN_COD_RETORNO || ', ' || SV_MENS_RETORNO ||','|| SN_NUM_EVENTO  ,
                                      '',
                                      '',
                                      '',
                                      0,
                                      '',
                                      SQLCODE,
                                      '',
                                      LNEstado , 
                                      LVCode ,
                                      LVErrm );
    --trazador 199030
    IF NOT (PV_VALIDA_PARAMETROS_FN(EN_CLIENTE_ORIGEN, EV_PLAN_ORIGEN, EN_CLIENTE_DESTINO,
                                    EV_PLAN_DESTINO, LD_FECHA_ALTA, EN_NUM_PROCESO, EV_COD_CANAL,
                                    SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO) )
    THEN
        RAISE ERROR_PARAMETROS;
    END IF;
    
    IF (LD_FECHA_BAJA IS NULL) THEN
        LD_FEC_BAJA:= TO_DATE('31-12-3000','DD-MM-YYYY');
    ELSE
        LD_FECHA_BAJA     := TO_DATE(EV_FECHA_BAJA,'DD-MM-YYYY HH24:MI:SS');
        --Se quita la hora de la fecha de termino para los productos de duracion infinita.
        IF (TO_CHAR(LD_FECHA_BAJA,'DD-MM-YYYY') = '31-12-3000') THEN
           LD_FEC_BAJA := TO_DATE('31-12-3000','DD-MM-YYYY');
        ELSE
            LD_FEC_BAJA:=LD_FECHA_BAJA;
        END IF;

    END IF;

    IF (EN_NUM_OS_ANULAR != 0) AND (EN_NUM_OS_ANULAR IS NOT NULL) THEN
        SN_Cod_retorno     := 0; -- INVOCAR LA REVERSA
        --PV_REVERSA_PLANES_PR();
    END IF;

    --Inicio Inc. 170939/ 11-07-2011/ FDL
    lv_aplica_plan_adic := Ge_Fn_Devvalparam('GE', 1, 'APLICA_PLAN_ADIC_OO');

    IF(ln_tip_estado = 3) THEN

        IF(lv_aplica_plan_adic = 'TRUE') THEN

            lv_ssql := 'PV_PLANES_ADICIONALES_OO_PR ( '||EN_CLIENTE_ORIGEN||', ';
            lv_ssql := lv_ssql || EN_ABONADO_ORIGEN || ', ' || EV_PLAN_ORIGEN || ', ';
            lv_ssql := lv_ssql || EN_NUM_OS_ANULAR || ', ' || EN_CLIENTE_DESTINO || ', ';
            lv_ssql := lv_ssql || EN_ABONADO_DESTINO || ', ' || EV_PLAN_DESTINO || ', ';
            lv_ssql := lv_ssql || LD_FECHA_ALTA || ', ' || LD_FEC_BAJA || ', ';
            lv_ssql := lv_ssql || EN_NUM_MOV_ANT || ', ' || EN_NUM_PROCESO || ', ';
            lv_ssql := lv_ssql || EV_COD_CANAL || ')';
    
    
    --trazador 199030 
     PV_GENERAL_OOSS_PG.PV_AUDREG_PR('PV',EN_ABONADO_ORIGEN,1,3,'199030','TL','','INICIO Ejecucion PV_PLANES_ADICIONALES_OO_PR', EN_CLIENTE_ORIGEN || ','|| EV_PLAN_ORIGEN || ', ' || EN_CLIENTE_DESTINO ||',' 
    || EV_PLAN_DESTINO || ', ' || LD_FECHA_ALTA ||','|| EN_NUM_PROCESO || ', ' || EV_COD_CANAL ||','|| SN_COD_RETORNO || ', ' || SV_MENS_RETORNO ||',
    '|| SN_NUM_EVENTO  ,'','','',0,'',SQLCODE,'',LNEstado ,LVCode ,LVErrm );
    --trazador 199030
    
    
            
            PV_PLANES_ADICIONALES_OO_PR ( EN_CLIENTE_ORIGEN,
                                          EN_ABONADO_ORIGEN,
                                          EV_PLAN_ORIGEN,
                                          EN_NUM_OS_ANULAR,
                                          EN_CLIENTE_DESTINO,
                                          EN_ABONADO_DESTINO,
                                          EV_PLAN_DESTINO,
                                          LD_FECHA_ALTA,
                                          LD_FEC_BAJA,
                                          EN_NUM_MOV_ANT,
                                          EN_NUM_PROCESO,
                                          EV_COD_CANAL,
                                          SN_COD_RETORNO,
                                          SV_MENS_RETORNO,
                                          SN_NUM_EVENTO);
            ln_tip_estado := 4;

            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_INTEGRACION;
            END IF;

        END IF;

    END IF;

    IF (ln_tip_estado = 3) THEN

        IF (EN_ABONADO_ORIGEN != 0) AND (EN_ABONADO_ORIGEN IS NOT NULL) THEN

            lv_ssql := 'PV_PLANES_ADICIONALES_PR ( '||EN_CLIENTE_ORIGEN||', ';
            lv_ssql := lv_ssql || EN_ABONADO_ORIGEN || ', ' || EV_PLAN_ORIGEN || ', ';
            lv_ssql := lv_ssql || EN_NUM_OS_ANULAR || ', ' || EN_CLIENTE_DESTINO || ', ';
            lv_ssql := lv_ssql || EN_ABONADO_DESTINO || ', ' || EV_PLAN_DESTINO || ', ';
            lv_ssql := lv_ssql || LD_FECHA_ALTA || ', ' || LD_FEC_BAJA || ', ';
            lv_ssql := lv_ssql || EN_NUM_MOV_ANT || ', ' || EN_NUM_PROCESO || ', ';
            lv_ssql := lv_ssql || EV_COD_CANAL || ')';


            PV_PLANES_ADICIONALES_PR (  EN_CLIENTE_ORIGEN,
                                        EN_ABONADO_ORIGEN,
                                        EV_PLAN_ORIGEN,
                                        EN_NUM_OS_ANULAR,
                                        EN_CLIENTE_DESTINO,
                                        EN_ABONADO_DESTINO,
                                        EV_PLAN_DESTINO,
                                        LD_FECHA_ALTA,
                                        LD_FEC_BAJA,
                                        EN_NUM_MOV_ANT,
                                        EN_NUM_PROCESO,
                                        EV_COD_CANAL,
                                        SN_COD_RETORNO,
                                        SV_MENS_RETORNO,
                                        SN_NUM_EVENTO);

            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_INTEGRACION;
            END IF;


        ELSE

            lv_ssql := 'PV_PLANES_ADICIONALES_PR ( '||EN_CLIENTE_ORIGEN||', ';
            lv_ssql := lv_ssql || '0, ' || EV_PLAN_ORIGEN || ', ';
            lv_ssql := lv_ssql || EN_NUM_OS_ANULAR || ', ' || EN_CLIENTE_DESTINO || ', ';
            lv_ssql := lv_ssql || ' 0, ' || EV_PLAN_DESTINO || ', ';
            lv_ssql := lv_ssql || LD_FECHA_ALTA || ', ' || LD_FEC_BAJA || ', ';
            lv_ssql := lv_ssql || EN_NUM_MOV_ANT || ', ' || EN_NUM_PROCESO || ', ';
            lv_ssql := lv_ssql || EV_COD_CANAL || ')';

            PV_PLANES_ADICIONALES_PR ( EN_CLIENTE_ORIGEN,
                                       0,
                                       EV_PLAN_ORIGEN,
                                       EN_NUM_OS_ANULAR,
                                       EN_CLIENTE_DESTINO,
                                       0,
                                       EV_PLAN_DESTINO,
                                       LD_FECHA_ALTA,
                                       LD_FEC_BAJA,
                                       EN_NUM_MOV_ANT,
                                       EN_NUM_PROCESO,
                                       EV_COD_CANAL,
                                       SN_COD_RETORNO,
                                       SV_MENS_RETORNO,
                                       SN_NUM_EVENTO);

            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_INTEGRACION;
            END IF;

            OPEN C_abonados FOR
                SELECT abo.num_abonado
                FROM   ga_abocel abo
                WHERE  abo.cod_cliente = EN_CLIENTE_ORIGEN
                AND    abo.cod_situacion NOT IN ('BAA','BAP')
                UNION
                SELECT pre.num_abonado
                FROM   ga_aboamist pre
                WHERE  pre.cod_cliente = EN_CLIENTE_ORIGEN
                AND    pre.cod_situacion NOT IN ('BAA','BAP');

            LOOP

                FETCH C_abonados INTO LN_ABONADO;

                EXIT WHEN C_abonados%NOTFOUND;

                lv_ssql := 'PV_PLANES_ADICIONALES_PR ( '|| EN_CLIENTE_ORIGEN ||', ';
                lv_ssql := lv_ssql || LN_ABONADO ||', ' || EV_PLAN_ORIGEN || ', ';
                lv_ssql := lv_ssql || EN_NUM_OS_ANULAR ||', ' || EN_CLIENTE_DESTINO || ', ';
                lv_ssql := lv_ssql || LN_ABONADO ||', ' || EV_PLAN_DESTINO || ', ';
                lv_ssql := lv_ssql || LD_FECHA_ALTA ||', ' || LD_FEC_BAJA || ', ';
                lv_ssql := lv_ssql || EN_NUM_MOV_ANT ||', ' || EN_NUM_PROCESO || ', ';
                lv_ssql := lv_ssql || EV_COD_CANAL ||')';

                PV_PLANES_ADICIONALES_PR ( EN_CLIENTE_ORIGEN,
                                           LN_ABONADO,
                                           EV_PLAN_ORIGEN,
                                           EN_NUM_OS_ANULAR,
                                           EN_CLIENTE_DESTINO,
                                           LN_ABONADO,
                                           EV_PLAN_DESTINO,
                                           LD_FECHA_ALTA,
                                           LD_FEC_BAJA,
                                           EN_NUM_MOV_ANT,
                                           EN_NUM_PROCESO,
                                           EV_COD_CANAL,
                                           SN_COD_RETORNO,
                                           SV_MENS_RETORNO,
                                           SN_NUM_EVENTO);

                IF (SN_COD_RETORNO != 0) THEN
                    RAISE ERROR_INTEGRACION;
                END IF;

            END LOOP;

        END IF;
    END IF;
    --Fin Inc. 170939/ 11-07-2011/ FDL

    /*
    IF (EN_ABONADO_ORIGEN != 0) AND (EN_ABONADO_ORIGEN IS NOT NULL) THEN

        LV_sSql := 'PV_PLANES_ADICIONALES_PR ( '||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_PLAN_ORIGEN||', '||EN_NUM_OS_ANULAR
                           ||', '||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||EV_PLAN_DESTINO||', '||LD_FECHA_ALTA||', '||LD_FEC_BAJA
                        ||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        PV_PLANES_ADICIONALES_PR ( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, EV_PLAN_ORIGEN, EN_NUM_OS_ANULAR, EN_CLIENTE_DESTINO,
                                    EN_ABONADO_DESTINO, EV_PLAN_DESTINO, LD_FECHA_ALTA, LD_FEC_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                    EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_INTEGRACION;
        END IF;


    ELSE

        LV_sSql := 'PV_PLANES_ADICIONALES_PR ( '||EN_CLIENTE_ORIGEN||', 0, '||EV_PLAN_ORIGEN||', '||EN_NUM_OS_ANULAR
                           ||', '||EN_CLIENTE_DESTINO||', 0, '||EV_PLAN_DESTINO||', '||LD_FECHA_ALTA||', '||LD_FEC_BAJA
                        ||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        PV_PLANES_ADICIONALES_PR ( EN_CLIENTE_ORIGEN, 0, EV_PLAN_ORIGEN, EN_NUM_OS_ANULAR, EN_CLIENTE_DESTINO,
                                    0, EV_PLAN_DESTINO, LD_FECHA_ALTA, LD_FEC_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                    EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_INTEGRACION;
        END IF;

        OPEN C_abonados FOR
        SELECT abo.num_abonado
        FROM   ga_abocel abo
        WHERE  abo.cod_cliente = EN_CLIENTE_ORIGEN
        AND    abo.cod_situacion NOT IN ('BAA','BAP')
        UNION
        SELECT pre.num_abonado
        FROM   ga_aboamist pre
        WHERE  pre.cod_cliente = EN_CLIENTE_ORIGEN
        AND    pre.cod_situacion NOT IN ('BAA','BAP');

        LOOP

            FETCH C_abonados INTO LN_ABONADO;

            EXIT WHEN C_abonados%NOTFOUND;

            LV_sSql := 'PV_PLANES_ADICIONALES_PR ( '||EN_CLIENTE_ORIGEN||', '||LN_ABONADO||', '||EV_PLAN_ORIGEN||', '||EN_NUM_OS_ANULAR
                               ||', '||EN_CLIENTE_DESTINO||', '||LN_ABONADO||', '||EV_PLAN_DESTINO||', '||LD_FECHA_ALTA||', '||LD_FEC_BAJA
                            ||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
            PV_PLANES_ADICIONALES_PR ( EN_CLIENTE_ORIGEN, LN_ABONADO, EV_PLAN_ORIGEN, EN_NUM_OS_ANULAR, EN_CLIENTE_DESTINO,
                                        LN_ABONADO, EV_PLAN_DESTINO, LD_FECHA_ALTA, LD_FEC_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                        EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_INTEGRACION;
            END IF;

        END LOOP;

    END IF;
    */

    --Se gestiona la permanencia de lista de beneficiarios
    LV_sSql := 'PV_BENEFICIARIOS_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_PLAN_ORIGEN||', '||EV_PLAN_DESTINO||', '||LD_FECHA_ALTA||')';
    PV_BENEFICIARIOS_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, EV_PLAN_ORIGEN, EV_PLAN_DESTINO, LD_FECHA_ALTA,
                        SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
    IF (SN_COD_RETORNO != 0) THEN
        RAISE ERROR_INTEGRACION;
    END IF;

    --Se gestiona la permanencia de la lista de vetados
    IF (EN_CLIENTE_ORIGEN != EN_CLIENTE_DESTINO) THEN
        LV_sSql := 'PV_ELIMINA_VETADO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||LD_FECHA_ALTA||')';
        PV_ELIMINA_VETADO_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LD_FECHA_ALTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_INTEGRACION;
        END IF;
    END IF;

EXCEPTION
   WHEN ERROR_PARAMETROS THEN
      SN_cod_retorno := 98;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG(ERROR EN PARAMETROS DE ENTRADA); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'PV_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_INTEGRACION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG(ERROR EN INTEGRACION); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'PV_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_INTEGRACION_PR ;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Inicio Inc. 170939 / 25-07-2011 / FDL

  PROCEDURE pv_planes_adicionales_oo_pr(en_cliente_origen  IN GE_CLIENTES.cod_cliente%TYPE,
                                        en_abonado_origen  IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                        ev_plan_origen     IN TA_PLANTARIF.cod_plantarif%TYPE,
                                        en_num_os_anular   IN CI_ORSERV.num_os%TYPE,
                                        en_cliente_destino IN GE_CLIENTES.cod_cliente%TYPE,
                                        en_abonado_destino IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                        ev_plan_destino    IN TA_PLANTARIF.cod_plantarif%TYPE,
                                        ed_fecha_alta      IN DATE,
                                        ed_fecha_baja      IN DATE,
                                        en_num_mov_ant     IN ICC_MOVIMIENTO.num_movant%TYPE,
                                        en_num_proceso     IN pr_productos_contratados_to.num_proceso%TYPE,
                                        ev_cod_canal       IN pr_productos_contratados_to.cod_canal%TYPE,
                                        sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        sn_num_evento      OUT NOCOPY ge_errores_pg.evento) IS
    lv_des_error ge_errores_pg.desevent;
    lv_ssql      ge_errores_pg.vquery;
    error_subfuncion EXCEPTION;
    lv_tipoplan_origen  TA_PLANTARIF.cod_tiplan%TYPE;
    lv_importe_origen   TA_CARGOSBASICO.imp_cargobasico%TYPE;
    lv_tipoplan_destino TA_PLANTARIF.cod_tiplan%TYPE;
    lv_importe_destino  TA_CARGOSBASICO.imp_cargobasico%TYPE;
    lv_fechaini         VARCHAR2(20);
    lv_fechater         VARCHAR2(20);


---------------------------------
-- Variables de tabla general
LV_DESESTADO       VARCHAR2(2000);
LV_INFO_REG        VARCHAR2(2000);
LV_NomProc VARCHAR2(2000) := 'PV_DEL_REGULAINTERFACT_PR';
LV_Tabla   VARCHAR2(30);
LV_Act     VARCHAR2(1);
LNEstado   NUMBER;
LVCode     VARCHAR2(2000);
LVErrm     VARCHAR2(2000);
---------------------------------


  BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;
    lv_ssql         := 'SELECT plan.cod_tiplan, cargo.imp_cargobasico';
    lv_ssql         := lv_ssql ||
                       ' FROM   TA_PLANTARIF plan, ta_cargosbasico cargo';
    lv_ssql         := lv_ssql ||
                       ' WHERE  plan.cod_cargobasico = cargo.cod_cargobasico';
    lv_ssql         := lv_ssql || ' AND       cargo.cod_producto = 1';
    lv_ssql         := lv_ssql ||
                       ' AND       SYSDATE BETWEEN cargo.fec_desde AND cargo.fec_hasta';
    lv_ssql         := lv_ssql || ' AND       plan.cod_plantarif = ' ||
                       ev_plan_origen;
       -- INI FPP P_COL_09027 22-07-2010
    /*SELECT PLAN.cod_tiplan, cargo.imp_cargobasico
      INTO lv_tipoplan_origen, lv_importe_origen
      FROM TA_PLANTARIF PLAN, TA_CARGOSBASICO cargo
     WHERE PLAN.cod_cargobasico = cargo.cod_cargobasico
       AND cargo.cod_producto = 1
       AND SYSDATE BETWEEN cargo.fec_desde AND cargo.fec_hasta
       AND PLAN.cod_plantarif = ev_plan_origen;
     */

     SELECT PLAN.cod_tiplan
      INTO lv_tipoplan_origen
      FROM TA_PLANTARIF PLAN
     WHERE PLAN.cod_plantarif = ev_plan_origen
     and cod_producto = 1;
     -- FIN FPP P_COL_09027 22-07-2010

      LV_DESESTADO := lv_ssql;
      LV_INFO_REG  := lv_tipoplan_origen||'|'|| lv_importe_origen;
      /* 160835
      pv_general_ooss_pg.PV_AUDREG_PR('PV',   --> cod_modulo
                                    en_abonado_origen,   --> num_inter
                                    1,               --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3',              --> tipo de ejecuccion 3=OK  // 4 NOOK
                                    NULL,             --> Numero incidencia (uno nunca sabe)
                                    'PA',             --> cod_tipmodi
                                    NULL,             --> cod_os
                                    LV_DESESTADO,  --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG,   --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc,       --> Nombre procedimiento
                                    LV_Tabla,      --> Tabla en la que vas( del ruteo)
                                    LV_Act,        --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL,         --> Da lo mismo
                                    SQLCODE,      --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM,      --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0,            --> Da lo mismo
                                    LNEstado,     --> Retorno
                                    LVCode,                --> Retorno
                                    LVErrm);      --> Retorno
      */

    lv_ssql := 'SELECT plan.cod_tiplan, cargo.imp_cargobasico';
    lv_ssql := lv_ssql ||
               ' FROM   TA_PLANTARIF plan, ta_cargosbasico cargo';
    lv_ssql := lv_ssql ||
               ' WHERE  plan.cod_cargobasico = cargo.cod_cargobasico';
    lv_ssql := lv_ssql || ' AND       cargo.cod_producto = 1';
    lv_ssql := lv_ssql ||
               ' AND       SYSDATE BETWEEN cargo.fec_desde AND cargo.fec_hasta';
    lv_ssql := lv_ssql || ' AND       plan.cod_plantarif = ' ||
               ev_plan_destino;

  -- INI FPP P_COL_09027 22-07-2010

    /*SELECT PLAN.cod_tiplan, cargo.imp_cargobasico
      INTO lv_tipoplan_destino, lv_importe_destino
      FROM TA_PLANTARIF PLAN, TA_CARGOSBASICO cargo
     WHERE PLAN.cod_cargobasico = cargo.cod_cargobasico
       AND cargo.cod_producto = 1
       AND SYSDATE BETWEEN cargo.fec_desde AND cargo.fec_hasta
       AND PLAN.cod_plantarif = ev_plan_destino;*/
    SELECT PLAN.cod_tiplan
      INTO lv_tipoplan_destino
      FROM TA_PLANTARIF PLAN
     WHERE PLAN.cod_plantarif = ev_plan_destino
     and cod_producto = 1;
  -- FIN FPP P_COL_09027 22-07-2010

    LV_DESESTADO := lv_ssql;
      LV_INFO_REG  := lv_tipoplan_destino;

      /* 160835|12-01-2011|EFR
      pv_general_ooss_pg.PV_AUDREG_PR('PV',   --> cod_modulo
                                    en_abonado_origen,   --> num_inter
                                    1,               --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                                    '3',              --> tipo de ejecuccion 3=OK  // 4 NOOK
                                    NULL,             --> Numero incidencia (uno nunca sabe)
                                    'PA',             --> cod_tipmodi
                                    NULL,             --> cod_os
                                    LV_DESESTADO,  --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_INFO_REG,   --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                                    LV_NomProc,       --> Nombre procedimiento
                                    LV_Tabla,      --> Tabla en la que vas( del ruteo)
                                    LV_Act,        --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                                    NULL,         --> Da lo mismo
                                    SQLCODE,      --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    SQLERRM,      --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                                    0,            --> Da lo mismo
                                    LNEstado,     --> Retorno
                                    LVCode,                --> Retorno
                                    LVErrm);      --> Retorno
      */
    --------------------------------------------------------------------------------
    -- INI PCOL-09044 -- COMPORTAMIENTO DE PLANES ADICIONALES POR DEFECTO
    --------------------------------------------------------------------------------
    lv_ssql := 'PV_QUITA_PLANES_DEFECTO_PR (' || en_cliente_origen || ', ' ||
               en_abonado_origen || ', ' || ev_plan_origen || ', ' ||
               ev_plan_destino || ', ' || ed_fecha_alta || ', ' ||
               ed_fecha_baja || ', ' || en_num_mov_ant || ', ' ||
               en_num_proceso || ', ' || ev_cod_canal || ')';
               
    --trazador 199030 
    PV_GENERAL_OOSS_PG.PV_AUDREG_PR('PV',EN_ABONADO_ORIGEN,1,3,'199030','TL','','INICIO Ejecucion PV_QUITA_PLANES_DEFECTO_PR ',
     en_cliente_origen || ', ' || en_abonado_origen || ', ' || ev_plan_origen || ', ' ||
       ev_plan_destino || ', ' || ed_fecha_alta || ', ' ||
       ed_fecha_baja || ', ' || en_num_mov_ant || ', ' ||
       en_num_proceso || ', ' || ev_cod_canal ,'','','',0,'',SQLCODE,'',LNEstado , LVCode,LVErrm);
    --trazador 199030 
    

    pv_quita_planes_defecto_pr(en_cliente_origen,
                               en_abonado_origen,
                               ev_plan_origen,
                               ev_plan_destino,
                               ed_fecha_alta,
                               ed_fecha_baja,
                               en_num_mov_ant,
                               en_num_proceso,
                               ev_cod_canal,
                               sn_cod_retorno,
                               sv_mens_retorno,
                               sn_num_evento);

    IF (sn_cod_retorno != 0) THEN
      RAISE error_subfuncion;
    END IF;

    lv_ssql := 'PV_AGREGA_PLANES_DEFECTO_PR (' || ev_plan_origen || ', ' ||
               en_cliente_destino || ', ' || en_abonado_destino || ', ' ||
               ev_plan_destino || ', ' || ed_fecha_alta || ', ' ||
               ed_fecha_baja || ', ' || en_num_mov_ant || ', ' ||
               en_num_proceso || ', ' || ev_cod_canal || ')';

    
    --trazador 199030 
    PV_GENERAL_OOSS_PG.PV_AUDREG_PR('PV',EN_ABONADO_ORIGEN,1,3,'199030','TL','','INICIO Ejecucion PV_AGREGA_PLANES_DEFECTO_PR',
     ev_plan_origen || ', ' || en_cliente_destino || ', ' || en_abonado_destino || ', ' ||
       ev_plan_destino || ', ' || ed_fecha_alta || ', ' ||
       ed_fecha_baja || ', ' || en_num_mov_ant || ', ' ||
       en_num_proceso || ', ' || ev_cod_canal  ,'','','',0,'',SQLCODE,'',LNEstado , LVCode,LVErrm);
    --trazador 199030 


    pv_agrega_planes_defecto_pr(ev_plan_origen,
                                en_cliente_destino,
                                en_abonado_destino,
                                ev_plan_destino,
                                ed_fecha_alta,
                                -- ed_fecha_baja, -- FPP 08-07-2010
                                NULL, -- FPP 08-07-2010
                                en_num_mov_ant,
                                en_num_proceso,
                                ev_cod_canal,
                                sn_cod_retorno,
                                sv_mens_retorno,
                                sn_num_evento);

    IF (sn_cod_retorno != 0) THEN
      RAISE error_subfuncion;
    END IF;

    --------------------------------------------------------------------------------
    -- FIN PCOL-09044 -- COMPORTAMIENTO DE PLANES ADICIONALES POR DEFECTO
    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
    -- INI PCOL-09044 -- COMPORTAMIENTO DE PLANES ADICIONALES OPCIONAL OBLIGATORIOS
    --------------------------------------------------------------------------------
      -- PCOL-09044 -- QUITA PLANES ADICIONALES OPCIONALES OBLIGATORIOS

    lv_ssql := 'PV_QUITA_PLANES_OPCIONALES_PR (' || en_cliente_origen || ', ';
    lv_ssql := lv_ssql || en_abonado_origen || ', ' || ev_plan_origen || ', ';
    lv_ssql := lv_ssql || ev_plan_destino || ', ' || ed_fecha_alta || ', ';
    lv_ssql := lv_ssql || ed_fecha_baja || ', ' || en_num_mov_ant || ', ';
    lv_ssql := lv_ssql || en_num_proceso || ', ' || ev_cod_canal || ', 3)';

    pv_quita_planes_opcionales_pr(  en_cliente_origen,
                                    en_abonado_origen,
                                    en_cliente_destino, -- FPP 22-07-2010 Defecto 100
                                    ev_plan_origen,
                                    ev_plan_destino,
                                    ed_fecha_alta,
                                    ed_fecha_baja,
                                    en_num_mov_ant,
                                    en_num_proceso,
                                    ev_cod_canal,
                                    3,
                                    sn_cod_retorno,
                                    sv_mens_retorno,
                                    sn_num_evento);

    IF (sn_cod_retorno != 0) THEN
      RAISE error_subfuncion;
    END IF;



    -- INI PCOL-09044 -- QUITA PLANES ADICIONALES OPCIONAL
    /* Se comenta la llamada a quitar planes adicionales opcionales, pues esto se realizará
       al momento de llamar a la funcion de mantener planes adicionales.
       Puesto que un PA opcional en plan origen, puede estar definido como obligatorio en el plan destino.
       En esto caso, no daría de baja el PA. Siendo que hay que darlo de baja y posteriormente de alta como obligatorio

    BEGIN
      pv_quita_planes_opcionales_pr(en_cliente_origen,
                                    en_abonado_origen,
                                    ev_plan_origen,
                                    ev_plan_destino,
                                    ed_fecha_alta,
                                    ed_fecha_baja,
                                    en_num_mov_ant,
                                    en_num_proceso,
                                    ev_cod_canal,
                                    1,
                                    sn_cod_retorno,
                                    sv_mens_retorno,
                                    sn_num_evento);
    EXCEPTION
      WHEN OTHERS THEN
        IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno, sv_mens_retorno) THEN
          sv_mens_retorno := cv_error_no_clasif;
        END IF;

        lv_des_error  := 'pv_quita_planes_opcionales_pr(' || '); - ' ||
                         SQLERRM;
        sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento,
                                                'PV',
                                                sv_mens_retorno,
                                                cv_version,
                                                USER,
                                                ' PV_PLANES_ADICIONALES_PG.pv_quita_planes_opcionales_pr',
                                                lv_ssql,
                                                sn_cod_retorno,
                                                lv_des_error);
        RAISE error_subfuncion; -- con esto se termina el proceso.
    END; */

    --------------------------------------------------------------------------------
    -- PCOL-09044 -- AGREGA PLANES ADICIONALES OPCIONALES OBLIGATORIOS
    --------------------------------------------------------------------------------
--ini 171357|14-06-2011|efr
--    lv_ssql := 'PV_AGREGA_PLANES_OPCIONALES_PR (' || ev_plan_origen || ', ' ||
--               en_cliente_destino || ', ' || en_abonado_destino || ', ' ||
--              ev_plan_destino || ', ' || ed_fecha_alta || ', ' ||
--               ed_fecha_baja || ', ' || en_num_mov_ant || ', ' ||
--               en_num_proceso || ', ' || ev_cod_canal || ', 2)';

--    pv_agrega_planes_opcionales_pr(ev_plan_origen,
--                                     en_cliente_destino,
--                                     en_abonado_destino,
--                                     ev_plan_destino,
--                                     ed_fecha_alta,
--                                     --ed_fecha_baja, -- FPP 08-07-2010
--                                     NULL, -- FPP 08-07-2010
--                                     en_num_mov_ant,
--                                     en_num_proceso,
--                                     ev_cod_canal,
--                                     2,
--                                     sn_cod_retorno,
--                                     sv_mens_retorno,
--                                     sn_num_evento);

--    IF (sn_cod_retorno != 0) THEN
--      RAISE error_subfuncion;
--    END IF;

--fin 171357|14-06-2011|efr

    IF (en_cliente_origen != en_cliente_destino) OR
       (lv_tipoplan_origen != lv_tipoplan_destino) THEN

      --Se provisiona la baja de servicios de cliente para el abonado
      lv_ssql := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(' ||
                 en_cliente_origen || ', ' || en_abonado_origen || ', ' ||
                 ed_fecha_alta || ', ' || en_num_mov_ant || ')';

      Pv_Planes_Adicionales_Pg.pv_provision_baja_abo_pr(en_cliente_origen,
                                                        en_abonado_origen,
                                                        ed_fecha_alta,
                                                        en_num_mov_ant,
                                                        en_num_proceso,
                                                        sn_cod_retorno,
                                                        sv_mens_retorno,
                                                        sn_num_evento);

      IF (sn_cod_retorno != 0) THEN
        RAISE error_subfuncion;
      END IF;
    END IF;

    -- Se invoca a la funcion de mantener de planes opcionales para CPU y Traspaso
    -- puesto que un PA opcional en plan origen, puede estar definido como obligatorio en el plan destino.
    -- En esto caso, no daría de baja el PA. Siendo que hay que darlo de baja y posteriormente de alta como obligatorio
    -- Adicionalmente a esto, se comentó la llamada a la baja de planes adicionales opcionales. Solo se dejó
    -- la baja de planes adicionales obligatorios. La validacion si el plan adicional es opcional al plan
    -- tarifario destino se incluye en el PL pv_mantiene_opcionales_pr

    lv_ssql := 'PV_MANTIENE_OPCIONALES_PR(' || en_cliente_origen || ', ' ||
                 en_abonado_origen || ', ' || ev_plan_origen || ', ' ||
                 en_num_os_anular || ', ' || en_cliente_destino || ', ' ||
                 en_abonado_destino || ', ' || ev_plan_destino || ', ' ||
                 ed_fecha_alta || ', ' || ed_fecha_baja || ', ' ||
                 en_num_mov_ant || ', ' || en_num_proceso || ', ' ||
                 ev_cod_canal || ')';
    pv_mantiene_opcionales_pr(en_cliente_origen,
                              en_abonado_origen,
                              ev_plan_origen,
                              en_num_os_anular,
                              en_cliente_destino,
                              en_abonado_destino,
                              ev_plan_destino,
                              ed_fecha_alta,
                              ed_fecha_baja,
                              en_num_mov_ant,
                              en_num_proceso,
                              ev_cod_canal,
                              sn_cod_retorno,
                              sv_mens_retorno,
                              sn_num_evento);

    IF (sn_cod_retorno != 0) THEN
      RAISE error_subfuncion;
    END IF;

--ini 171357|14-06-2011|efr
    --------------------------------------------------------------------------------
    -- PCOL-09044 -- AGREGA PLANES ADICIONALES OPCIONALES OBLIGATORIOS
    --------------------------------------------------------------------------------

    lv_ssql := 'PV_AGREGA_PLANES_OPCIONALES_PR (' || ev_plan_origen || ', ';
    lv_ssql := lv_ssql || en_cliente_destino || ', ' || en_abonado_destino || ', ';
    lv_ssql := lv_ssql || ev_plan_destino || ', ' || ed_fecha_alta || ', ';
    lv_ssql := lv_ssql || ed_fecha_baja || ', ' || en_num_mov_ant || ', ';
    lv_ssql := lv_ssql ||en_num_proceso || ', ' || ev_cod_canal || ', 3)';

    pv_agrega_planes_opcionales_pr(  ev_plan_origen,
                                     en_cliente_destino,
                                     en_abonado_destino,
                                     ev_plan_destino,
                                     ed_fecha_alta,
                                     --ed_fecha_baja, -- FPP 08-07-2010
                                     NULL, -- FPP 08-07-2010
                                     en_num_mov_ant,
                                     en_num_proceso,
                                     ev_cod_canal,
                                     3,
                                     sn_cod_retorno,
                                     sv_mens_retorno,
                                     sn_num_evento);

    IF (sn_cod_retorno != 0) THEN
      RAISE error_subfuncion;
    END IF;

--fin 171357|14-06-2011|efr

    --------------------------------------------------------------------------------
    -- FIN PCOL-09044 -- COMPORTAMIENTO DE PLANES ADICIONALES OPCIONAL OBLIGATORIOS
    --------------------------------------------------------------------------------
    IF (en_cliente_origen != en_cliente_destino) THEN

      --Si existe cambio de cliente, se MANTIENEN los productos contratados por defecto

      lv_ssql := 'PV_MANTIENE_PLANES_DEFECTO_PR(' || en_cliente_origen || ', ' ||
                 en_abonado_origen || ', ' || ev_plan_origen || ', ' ||
                 en_num_os_anular || ', ' || en_cliente_destino || ', ' ||
                 en_abonado_destino || ', ' || ev_plan_destino || ', ' ||
                 ed_fecha_alta || ', ' || ed_fecha_baja || ', ' ||
                 en_num_mov_ant || ', ' || en_num_proceso || ', ' ||
                 ev_cod_canal || ')';
      pv_mantiene_planes_defecto_pr(en_cliente_origen,
                                    en_abonado_origen,
                                    ev_plan_origen,
                                    en_num_os_anular,
                                    en_cliente_destino,
                                    en_abonado_destino,
                                    ev_plan_destino,
                                    ed_fecha_alta,
                                    ed_fecha_baja,
                                    en_num_mov_ant,
                                    en_num_proceso,
                                    ev_cod_canal,
                                    sn_cod_retorno,
                                    sv_mens_retorno,
                                    sn_num_evento);

      IF (sn_cod_retorno != 0) THEN
        RAISE error_subfuncion;
      END IF;


      lv_ssql := 'PV_MANTIENE_PLANES_BENEF_PR(' || en_cliente_origen || ', ' ||
                 en_abonado_origen || ', ' || ev_plan_origen || ', ' ||
                 en_num_os_anular || ', ' || en_cliente_destino || ', ' ||
                 en_abonado_destino || ', ' || ev_plan_destino || ', ' ||
                 ed_fecha_alta || ', ' || ed_fecha_baja || ', ' ||
                 en_num_mov_ant || ', ' || en_num_proceso || ', ' ||
                 ev_cod_canal || ')';
      pv_mantiene_planes_benef_pr(en_cliente_origen,
                                  en_abonado_origen,
                                  ev_plan_origen,
                                  en_num_os_anular,
                                  en_cliente_destino,
                                  en_abonado_destino,
                                  ev_plan_destino,
                                  ed_fecha_alta,
                                  ed_fecha_baja,
                                  en_num_mov_ant,
                                  en_num_proceso,
                                  ev_cod_canal,
                                  sn_cod_retorno,
                                  sv_mens_retorno,
                                  sn_num_evento);
    ELSE
      --Si no existe cambio de cliente, se verifica exclusion
      lv_ssql := 'PV_EXCLUSION_OPCIONALES_PR(' || en_cliente_origen || ', ' ||
                 en_abonado_origen || ', ' || en_cliente_destino || ', ' ||
                 ev_plan_destino || ', ' || ed_fecha_alta || ', ' ||
                 ed_fecha_baja || ', ' || en_num_mov_ant || ', ' ||
                 en_num_proceso || ', ' || ev_cod_canal || ')';
--      pv_exclusion_opcionales_pr(en_cliente_origen,
--                                 en_abonado_origen,
--                                 en_cliente_destino,
--                                 ev_plan_destino,
--                                 ed_fecha_alta,
--                                 ed_fecha_baja,
--                                 en_num_mov_ant,
--                                 en_num_proceso,
--                                 ev_cod_canal,
--                                 sn_cod_retorno,
--                                 sv_mens_retorno,
--                                 sn_num_evento);
--
--      IF (sn_cod_retorno != 0) THEN
--        RAISE error_subfuncion;
--      END IF;
 END IF;

  EXCEPTION
    WHEN error_subfuncion THEN
      IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno, sv_mens_retorno) THEN
        sv_mens_retorno := cv_error_no_clasif;
      END IF;

      lv_des_error  := 'PV_PLANES_ADICIONALES_PG(' || '); - ' || SQLERRM;
      sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento,
                                              'PV',
                                              sv_mens_retorno,
                                              cv_version,
                                              USER,
                                              ' PV_PLANES_ADICIONALES_PG.PV_PLANES_ADICIONALES_OO_PR',
                                              lv_ssql,
                                              sn_cod_retorno,
                                              lv_des_error);
    WHEN NO_DATA_FOUND THEN
      sn_cod_retorno := 282;

      IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno, sv_mens_retorno) THEN
        sv_mens_retorno := cv_error_no_clasif;
      END IF;

      lv_des_error  := 'PV_PLANES_ADICIONALES_PG(' || '); - ' || SQLERRM;
      sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento,
                                              'PV',
                                              sv_mens_retorno,
                                              cv_version,
                                              USER,
                                              ' PV_PLANES_ADICIONALES_PG.PV_PLANES_ADICIONALES_OO_PR',
                                              lv_ssql,
                                              sn_cod_retorno,
                                              lv_des_error);
    WHEN OTHERS THEN
      sn_cod_retorno := 156;

      IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno, sv_mens_retorno) THEN
        sv_mens_retorno := cv_error_no_clasif;
      END IF;

      lv_des_error  := 'PV_PLANES_ADICIONALES_PG(' || '); - ' || SQLERRM;
      sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento,
                                              'PV',
                                              sv_mens_retorno,
                                              cv_version,
                                              USER,
                                              ' PV_PLANES_ADICIONALES_PG.PV_PLANES_ADICIONALES_OO_PR',
                                              lv_ssql,
                                              sn_cod_retorno,
                                              lv_des_error);
  END pv_planes_adicionales_oo_pr;

--Fin Inc. 170939 / 25-07-2011 / FDL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Inicio Inc. 170939 / 25-07-2011 / FDL
  PROCEDURE pv_quita_planes_opcionales_pr(en_cliente_origen IN GE_CLIENTES.cod_cliente%TYPE,
                                          en_abonado_origen IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                          en_cliente_destino IN GE_CLIENTES.cod_cliente%TYPE, -- FPP 22-07-2010 Defecto 100
                                          ev_plan_origen    IN TA_PLANTARIF.cod_plantarif%TYPE,
                                          ev_plan_destino   IN TA_PLANTARIF.cod_plantarif%TYPE,
                                          ed_fecha_alta     IN DATE,
                                          ed_fecha_baja     IN DATE,
                                          en_num_mov_ant    IN ICC_MOVIMIENTO.num_movant%TYPE,
                                          en_num_proceso    IN pr_productos_contratados_to.num_proceso%TYPE,
                                          ev_cod_canal      IN pr_productos_contratados_to.cod_canal%TYPE,
                                          ev_tipo_relacion  IN NUMBER,
                                          sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                          sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                          sn_num_evento     OUT NOCOPY ge_errores_pg.evento) IS
    /*
     <Documentación
       TipoDoc = "Procedure">>
        <Elemento
           Nombre = "pv_quita_planes_opcionales_pr"
               Lenguaje="PL/SQL"
           Fecha="22-01-2010"
           Versión="La del package"
           Diseñador="Patricio Madrid"
           Programador="Patricio Madrid"
           Ambiente Desarrollo="BD">
           <Retorno>N/A</Retorno>>
           <Descripción>Quita planes adicionales opcionales</Descripción>
           <Parámetros>
              <Entrada>
                    <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                    <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                    <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                    <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                    <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                    <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                    <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                    <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                    <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                    <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                    <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                    <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
              </Entrada>
              <Salida>
                 <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
                 <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
                 <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
              </Salida>
           </Parámetros>
        </Elemento>
     </Documentación>
    */
    --------------------------------------------------------------------------------
    -- DECLARACION DE VARIABLES
    --------------------------------------------------------------------------------
    c_qt_planes_opcionales refcursor;
    ln_cod_prod_contratado pr_productos_contratados_to.cod_prod_contratado%TYPE;
    ln_cod_prod_ofertado   pr_productos_contratados_to.cod_prod_ofertado%TYPE;
    error_subfuncion EXCEPTION;
    lv_des_error ge_errores_pg.desevent;
    lv_ssql      ge_errores_pg.vquery;
    lv_tipo_contratacion VARCHAR2(1);
  BEGIN
    --------------------------------------------------------------------------------
    -- INICIALIZACION DE VARIABLES
    --------------------------------------------------------------------------------
    sn_cod_retorno  := 0;
    sv_mens_retorno := 'EL PROCESO QUITA PLANES ADICIONALES SE EJECUTO CORRECTAMENTE';
    sn_num_evento   := 0;

    select decode(ev_tipo_relacion, 1, 'O', 2, 'B') into lv_tipo_contratacion from dual;

    --Inicio Inc. 170939 - 25/07/2011 - FDL

    IF (ev_plan_origen = ev_plan_destino) OR (en_cliente_origen <> en_cliente_destino) THEN

        OPEN c_qt_planes_opcionales FOR
            SELECT cnt.cod_prod_ofertado, cnt.cod_prod_contratado
            FROM PS_PLANTARIF_PLANADIC_TD pla_org, PR_PRODUCTOS_CONTRATADOS_TO cnt
            WHERE pla_org.cod_prod_ofertado = cnt.cod_prod_ofertado
            --AND pla_org.cod_producto = 1 --160835|13-01-2011|EFR
            AND cnt.cod_cliente_beneficiario = en_cliente_origen --PRT_cod_cliente
            AND cnt.num_abonado_beneficiario = en_abonado_origen --PRT_num_abonado
            AND pla_org.cod_plantarif = ev_plan_origen -- PRT_plan_origen
            AND pla_org.tipo_relacion_pa = ev_tipo_relacion
            AND cnt.fec_inicio_vigencia BETWEEN pla_org.fec_inicio_vigencia AND pla_org.fec_termino_vigencia -- INC. COL|168609|25-04-2011|SAQL
            AND SYSDATE BETWEEN cnt.fec_inicio_vigencia AND cnt.fec_termino_vigencia;

    ELSE

        OPEN c_qt_planes_opcionales FOR
            SELECT cnt.cod_prod_ofertado, cnt.cod_prod_contratado
            FROM PS_PLANTARIF_PLANADIC_TD pla_org,
            pr_productos_contratados_to cnt
            WHERE pla_org.cod_prod_ofertado = cnt.cod_prod_ofertado
            --AND pla_org.cod_producto = 1
            AND cnt.cod_cliente_beneficiario = en_cliente_origen
            AND cnt.num_abonado_beneficiario = en_abonado_origen
            AND pla_org.cod_plantarif = ev_plan_origen
            AND pla_org.tipo_relacion_pa = ev_tipo_relacion
            AND SYSDATE BETWEEN cnt.fec_inicio_vigencia AND cnt.fec_termino_vigencia
            AND NOT EXISTS(
                -- productos contratados por cliente en destino
                SELECT 1
                FROM PS_PLANTARIF_PLANADIC_TD pla_des
                WHERE pla_des.cod_plantarif = ev_plan_destino
                --AND pla_des.cod_producto = 1
                AND pla_des.tipo_relacion_pa = ev_tipo_relacion
                AND sysdate between pla_des.fec_inicio_vigencia and pla_des.fec_termino_vigencia
                AND pla_des.cod_prod_ofertado = pla_org.cod_prod_ofertado
            );

    END IF;

    --Fin Inc. 170939 - 25/07/2011 - FDL

    /*
    --------------------------------------------------------------------------------
    -- SE HABRE EL CURSOR
    --------------------------------------------------------------------------------
    -- Paso 2
    -- IF (ev_plan_origen = ev_plan_destino) THEN -- FPP 22-07-2010 Defecto 100
        IF (ev_plan_origen = ev_plan_destino) OR (en_cliente_origen <> en_cliente_destino) THEN -- FPP 22-07-2010 Defecto 100
       -- Se trata de un traspaso o de un reordenamiento, por lo que es necesario dar de baja todos los PA's (segun tipo de contratacion)
       -- para que posteriormente sean dados de alta con el nuevo cliente
         OPEN c_qt_planes_opcionales FOR
            SELECT cnt.cod_prod_ofertado, cnt.cod_prod_contratado
            FROM PS_PLANTARIF_PLANADIC_TD pla_org, pr_productos_contratados_to cnt
            WHERE pla_org.cod_plan_adicional = cnt.cod_prod_ofertado
            AND pla_org.cod_producto = 1 --160835|13-01-2011|EFR
            AND cnt.cod_cliente_beneficiario = en_cliente_origen --PRT_cod_cliente
            AND cnt.num_abonado_beneficiario = en_abonado_origen --PRT_num_abonado
            AND pla_org.cod_plantarif = ev_plan_origen -- PRT_plan_origen
            AND pla_org.tipo_plan_adicional = ev_tipo_relacion
            AND CNT.FEC_INICIO_VIGENCIA BETWEEN PLA_ORG.FECHA_INICIO AND PLA_ORG.FECHA_FIN -- INC. COL|168609|25-04-2011|SAQL
            AND SYSDATE BETWEEN cnt.fec_inicio_vigencia AND cnt.fec_termino_vigencia;
    ELSE
            -- Se trata de un cambio de plan, por lo que solo se dan de baja los PA's
            -- que no esten definidos en el plan destino
         OPEN c_qt_planes_opcionales FOR
            SELECT cnt.cod_prod_ofertado, cnt.cod_prod_contratado
            FROM PS_PLANTARIF_PLANADIC_TD pla_org,
            pr_productos_contratados_to cnt
            WHERE pla_org.cod_plan_adicional = cnt.cod_prod_ofertado
            AND pla_org.cod_producto = 1 --160835|13-01-2011|EFR
            AND cnt.cod_cliente_beneficiario = en_cliente_origen --PRT_cod_cliente
            AND cnt.num_abonado_beneficiario = en_abonado_origen --PRT_num_abonado
            AND pla_org.cod_plantarif = ev_plan_origen -- PRT_plan_origen
            AND pla_org.tipo_plan_adicional = ev_tipo_relacion
            AND SYSDATE BETWEEN cnt.fec_inicio_vigencia AND cnt.fec_termino_vigencia
            -- Planes Vigentes
            --AND cnt.cod_prod_contratado NOT IN -- FPP 08-07-2010
            AND NOT EXISTS -- FPP 08-07-2010
            (
               -- productos contratados por cliente en destino
               SELECT 1
               FROM PS_PLANTARIF_PLANADIC_TD pla_des
               WHERE pla_des.cod_plantarif = ev_plan_destino
                    AND pla_des.cod_producto = 1 --160835|13-01-2011|EFR -- PRT_plan_origen
               AND pla_des.tipo_plan_adicional = ev_tipo_relacion -- PRT_tip_relacion
               AND sysdate between pla_des.fecha_inicio and pla_des.fecha_fin -- FPP 20-06-2010
               AND pla_des.cod_plan_adicional = pla_org.cod_plan_adicional
            );
    END IF;

    */

    LOOP
      FETCH c_qt_planes_opcionales
        INTO ln_cod_prod_ofertado, ln_cod_prod_contratado;

      EXIT WHEN c_qt_planes_opcionales%NOTFOUND;

      -- Paso 3
      IF (NOT pv_quita_fn(en_cliente_origen,
                          en_abonado_origen,
                          ln_cod_prod_contratado,
                          ln_cod_prod_ofertado,
                          ed_fecha_alta,
                          ed_fecha_baja,
                          en_num_mov_ant,
                          en_num_proceso,
                          ev_cod_canal,
                          --'D', -- FPP 21-06-2010
                          lv_tipo_contratacion, -- FPP 21-06-2010
                          sn_cod_retorno,
                          sv_mens_retorno,
                          sn_num_evento)) THEN
        RAISE error_subfuncion;
      END IF;
    END LOOP;
    CLOSE c_qt_planes_opcionales; -- RRG COL 161846 22.01.2011
  EXCEPTION
    WHEN error_subfuncion THEN
      sn_cod_retorno := 156;

      IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno, sv_mens_retorno) THEN
        sv_mens_retorno := cv_error_no_clasif;
      END IF;

      lv_des_error  := 'PV_PLANES_ADICIONALES_PG(' || '); - ' || SQLERRM;
      sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento,
                                              'PV',
                                              sv_mens_retorno,
                                              cv_version,
                                              USER,
                                              ' PV_PLANES_ADICIONALES_PG.pv_agrega_planes_opcionales_pr',
                                              lv_ssql,
                                              sn_cod_retorno,
                                              lv_des_error);
  END pv_quita_planes_opcionales_pr;
--Fin Inc. 170939 / 25-07-2011 / FDL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Inicio Inc. 170939 / 25-07-2011 / FDL
  PROCEDURE pv_agrega_planes_opcionales_pr(ev_plan_origen     IN TA_PLANTARIF.cod_plantarif%TYPE,
                                           en_cliente_destino IN GE_CLIENTES.cod_cliente%TYPE,
                                           en_abonado_destino IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                           ev_plan_destino    IN TA_PLANTARIF.cod_plantarif%TYPE,
                                           ed_fecha_alta      IN DATE,
                                           ed_fecha_baja      IN DATE,
                                           en_num_mov_ant     IN ICC_MOVIMIENTO.num_movant%TYPE,
                                           en_num_proceso     IN pr_productos_contratados_to.num_proceso%TYPE,
                                           ev_cod_canal       IN pr_productos_contratados_to.cod_canal%TYPE,
                                           ev_tipo_relacion   IN NUMBER,
                                           sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                           sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                           sn_num_evento      OUT NOCOPY ge_errores_pg.evento) IS
    /*
     <Documentación
       TipoDoc = "Procedure">>
        <Elemento
           Nombre = "pv_agrega_planes_opcionales_pr"
               Lenguaje="PL/SQL"
           Fecha="22-01-2010"
           Versión="La del package"
           Diseñador="Patricio Madrid"
           Programador="Patricio Madrid"
           Ambiente Desarrollo="BD">
           <Retorno>N/A</Retorno>>
           <Descripción>Agrega planes adicionales opcionales</Descripción>
           <Parámetros>
              <Entrada>
                    <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                    <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                    <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                    <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                    <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                    <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                    <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                    <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                    <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                    <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                    <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                    <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
              </Entrada>
              <Salida>
                 <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
                 <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
                 <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
              </Salida>
           </Parámetros>
        </Elemento>
     </Documentación>
    */
    --------------------------------------------------------------------------------
    -- DECLARACION DE VARIABLES
    --------------------------------------------------------------------------------
    c_agr_planes_opcionales refcursor;
    ln_cod_prod_contratado  pr_productos_contratados_to.cod_prod_contratado%TYPE;
    ln_cod_prod_ofertado    pr_productos_contratados_to.cod_prod_ofertado%TYPE;
    ln_num_veces            pf_paquete_ofertado_to.num_veces_hijo%TYPE;
    error_subfuncion EXCEPTION;
    lv_des_error ge_errores_pg.desevent;
    lv_ssql      ge_errores_pg.vquery;

    lv_ind_contratacion VARCHAR2(1);
    lv_cargo_ocasional      varchar2(1); -- FPP 20-06-2010
    lv_cargo_ocasional_tmp  varchar2(2); -- FPP 09-07-2010 Defecto 77
    ln_count_contratado     number(6); -- FPP 09-07-2010 Defecto 77
    ln_count_ooss           number(6); -- FPP 26-08-2010 Defecto 131

---------------------------------
-- Variables de tabla general
LV_DESESTADO       VARCHAR2(2000);
LV_INFO_REG        VARCHAR2(2000);
LV_NomProc VARCHAR2(2000) := 'PV_PLANES_ADICIONALES_PG.PV_AGREGA_PLANES_OPCIONALES_PR';
LV_Tabla   VARCHAR2(30);
LV_Act     VARCHAR2(1);
LNEstado   NUMBER;
LVCode     VARCHAR2(2000);
LVErrm     VARCHAR2(2000);
---------------------------------

  BEGIN
    --------------------------------------------------------------------------------
    -- INICIALIZACION DE VARIABLES
    --------------------------------------------------------------------------------
    sn_cod_retorno  := 0;
    sv_mens_retorno := 'EL PROCESO AGREGA PLANES ADICIONALES SE EJECUTO CORRECTAMENTE';
    sn_num_evento   := 0;

    lv_cargo_ocasional_tmp := 'S'; -- FPP 26-08-2010 Defecto 131

    SELECT DECODE(ev_tipo_relacion,1,'O',2,'B') INTO lv_ind_contratacion FROM dual ;

    -- INI. FPP 06-09-2010 Defecto 106
    -- Se verifica si es un reordenamiento
    select count(1)
    into ln_count_ooss
    from ci_orserv
    where num_os = en_num_proceso
    and cod_os in ('10507', '10508','10504', '10505', '10541');
    -- FIN FPP 06-09-2010 Defecto 106

    -- INI FPP P_COL_09044 09-09-2010  Defecto 139
    /*
        Si no existen OOSS de reordenamiento, se valida si la ejecución del procedimiento
        corersponde a la ejecución del trigger de contratación automatica de PA,
        por lo que los cargos ocacionales deben ser cobrados
    */
    IF (ln_count_ooss =0 ) THEN
        SELECT COUNT(1)
        into ln_count_ooss
        FROM pr_procesos_prod_td a
        WHERE num_proceso = en_num_proceso
        AND origen_proceso in ( 'PD','VT')
        AND not exists (select 1 from pv_iorserv where num_proceso = num_os );
    END IF;
    -- FIN FPP P_COL_09044 09-09-2010  Defecto 139

    -- INI. FPP 21-06-2010
    -- IF (ev_plan_origen = ev_plan_destino) OR (ev_plan_destino IS NULL) THEN -- FPP 06-09-2010 Defecto 106
    IF (ev_plan_origen = ev_plan_destino) OR (ev_plan_destino IS NULL) OR (ln_count_ooss > 0) THEN -- FPP 06-09-2010 Defecto 106
       -- Se deja variable de cargo ocasional en N para reordenamientos, ya que de esta forma se validara
       -- (para los PA obligatorios) si estaba previamente contratado
       lv_cargo_ocasional := 'N'; -- Es un traspaso, por lo que no hay que cobrar cargo ocasional
    ELSE
       lv_cargo_ocasional := 'S'; -- Es un cambio de plan, por lo que es necesario cobrar cargo ocasional
    END IF;
    -- INI. FPP 21-06-2010

    --------------------------------------------------------------------------------
    -- SE ABRE EL CURSOR
    --------------------------------------------------------------------------------
    OPEN c_agr_planes_opcionales FOR

    --Inicio Inc 170939 - 25/07/2011 -  FDL

    -- productos de destino que tiene el plan a contratar
    --Nueva consulta para obtener codigos de producto(Planes adicionales)
    SELECT pla_des.cod_prod_ofertado
    FROM PS_PLANTARIF_PLANADIC_TD pla_des
    WHERE pla_des.cod_plantarif = ev_plan_destino
    AND pla_des.tipo_relacion_pa = 5--ev_tipo_relacion
    AND sysdate between pla_des.fec_inicio_vigencia
    AND pla_des.fec_termino_vigencia
    AND EXISTS (
        SELECT 1
        FROM PF_PRODUCTOS_OFERTADOS_TD prod, PF_CATALOGO_OFERTADO_TD catal
        WHERE prod.cod_prod_ofertado = pla_des.cod_prod_ofertado
        AND prod.cod_prod_ofertado = catal.cod_prod_ofertado
        AND catal.cod_canal = ev_cod_canal
        AND SYSDATE BETWEEN prod.fec_inicio_vigencia AND NVL(prod.fec_termino_vigencia,SYSDATE)
        AND SYSDATE BETWEEN catal.fec_inicio_vigencia AND NVL(catal.fec_termino_vigencia,SYSDATE)
    )
    AND NOT EXISTS(
        SELECT cnt.cod_prod_ofertado, cnt.cod_prod_contratado
        FROM PS_PLANTARIF_PLANADIC_TD pla_org, PR_PRODUCTOS_CONTRATADOS_TO cnt
        WHERE pla_org.cod_prod_ofertado = cnt.cod_prod_ofertado
        --AND pla_org.cod_producto = 1
        AND cnt.cod_cliente_beneficiario = en_cliente_destino
        AND cnt.num_abonado_beneficiario = en_abonado_destino
        AND pla_org.cod_plantarif = ev_plan_origen
        AND pla_org.tipo_relacion_pa = 5--ev_tipo_relacion
        AND SYSDATE BETWEEN cnt.fec_inicio_vigencia AND cnt.fec_termino_vigencia
        AND pla_des.cod_prod_ofertado = pla_org.cod_prod_ofertado
    );

    --Fin Inc 170939 - 25/07/2011 -  FDL

    /*
    -- productos de destino que tiene el plan a contratar
      SELECT pla_des.cod_prod_ofertado
      FROM PS_PLANTARIF_PLANADIC_TD pla_des
      WHERE pla_des.cod_plantarif = ev_plan_destino -- PRT_plan_origen
      AND pla_des.cod_producto = 1 --160835|13-01-2011|EFR
      AND pla_des.tipo_relcion_pa = ev_tipo_relacion
      AND sysdate between pla_des.fecha_inicio AND pla_des.fecha_fin -- FPP 18-06-2010
      -- INI FPP P_COL_09027 24-09-2010
      -- INI COL 168609|26-04-2011|SAQL
      -- AND exists (select 1 from pf_productos_ofertados_td
      -- where cod_prod_ofertado = pla_des.cod_prod_ofertado
      -- and sysdate between fec_inicio_vigencia and fec_termino_vigencia)
      AND EXISTS (
         SELECT 1
         FROM PF_PRODUCTOS_OFERTADOS_TD PROD, PF_CATALOGO_OFERTADO_TD CATAL
         WHERE PROD.COD_PROD_OFERTADO = PLA_DES.cod_prod_ofertado
         AND PROD.COD_PROD_OFERTADO = CATAL.COD_PROD_OFERTADO
         AND CATAL.COD_CANAL = EV_COD_CANAL
         AND SYSDATE BETWEEN PROD.FEC_INICIO_VIGENCIA AND NVL(PROD.FEC_TERMINO_VIGENCIA,SYSDATE)
         AND SYSDATE BETWEEN CATAL.FEC_INICIO_VIGENCIA AND NVL(CATAL.FEC_TERMINO_VIGENCIA,SYSDATE)
      )
      -- FIN COL 168609|26-04-2011|SAQL
      -- FIN FPP P_COL_09027 24-09-2010
      -- PRT_tip_relacion
         AND NOT EXISTS
       (
              -- productos contratados por cliente en origen
              SELECT cnt.cod_prod_ofertado, cnt.cod_prod_contratado
                FROM PS_PLANTARIF_PLANADIC_TD    pla_org,
                      pr_productos_contratados_to cnt
               WHERE pla_org.cod_prod_ofertado = cnt.cod_prod_ofertado
                 AND pla_org.cod_producto = 1 --160835|13-01-2011|EFR
                 AND cnt.cod_cliente_beneficiario = en_cliente_destino
                    --PRT_cod_cliente
                 AND cnt.num_abonado_beneficiario = en_abonado_destino
                    --PRT_num_abonado
                 AND pla_org.cod_plantarif = ev_plan_origen
                    -- PRT_plan_origen
                 AND pla_org.tipo_relacion_pa = ev_tipo_relacion
                 AND SYSDATE BETWEEN cnt.fec_inicio_vigencia AND
                     cnt.fec_termino_vigencia
                 AND pla_des.cod_prod_ofertado = pla_org.cod_prod_ofertado);

    */

    LOOP
      FETCH c_agr_planes_opcionales
        --INTO ln_cod_prod_ofertado, ln_num_veces;
        INTO ln_cod_prod_ofertado;-- FPP P_COL_09044 17-06-2010

      EXIT WHEN c_agr_planes_opcionales%NOTFOUND;

        -- INI FPP P_COL_09044 17-06-2010
        ln_num_veces := 1;
        -- FIN FPP P_COL_09044 17-06-2010

      -- INI. FPP 09-07-2010 Defecto 77
      -- Si es traspaso y es un PA obigatorio se verifica si se acaba dar de baja el PA (para no cobrarlo)
      -- si no lo tenia previamente contratado, es necesario cobrar el cargo adicional
      lv_cargo_ocasional_tmp := lv_cargo_ocasional;

      IF (lv_cargo_ocasional = 'N') and (lv_ind_contratacion = 'B') THEN
         select count(1)
         into ln_count_contratado
         from pr_productos_contratados_th
         where num_abonado_beneficiario = en_abonado_destino
         and   cod_prod_ofertado = ln_cod_prod_ofertado
         and   fec_termino_vigencia between sysdate  - 1/(60*10) and sysdate;

         IF (ln_count_contratado = 0) THEN
            lv_cargo_ocasional_tmp := 'S'; -- Se cobra cargo ocasional pues no lo tenia contratado
         END IF;
      END IF;
      -- FIN FPP 09-07-2010 Defecto 77


      -- INI FPP 26-08-2010 Defecto 131
      -- Debido que para cambios de plan a ciclo, se esta generando cargos ocasionales y recurrentes
      -- se genera doble cobro al cliente para dicho ciclo. Por lo que se necesita suprimir el cobro
      -- del cargo ocasional.
      IF (lv_cargo_ocasional = 'S') THEN -- Esta variable es igual a S para cambios de plan (plan_origen = plan_destino)
         lv_cargo_ocasional_tmp := 'X';
      END IF;

      -- Otra casuistica que es cambio de plan, pero el plan_origen <> plan_destino, es cambio de plan de prepago a pospago a ciclo
      select count(1)
      into ln_count_ooss
      from pv_iorserv
      where num_os = en_num_proceso
      and cod_os in ('10036', '10037');

      IF (ln_count_ooss > 0) THEN
         lv_cargo_ocasional_tmp := 'X';
      END IF;
      -- FIN FPP 26-08-2010 Defecto 131

--------------------------------------------------------------
LV_DESESTADO := 'Tratamiento de cargo ocasional para traspasos-cpu';
LV_INFO_REG := 'lv_cargo_ocasional['||lv_cargo_ocasional||'] lv_ind_contratacion['||lv_ind_contratacion;
LV_INFO_REG := LV_INFO_REG || '] ln_count_contratado['||ln_count_contratado||'] lv_cargo_ocasional_tmp['||lv_cargo_ocasional_tmp;
LV_INFO_REG := LV_INFO_REG || '] en_num_proceso['||en_num_proceso||'] en_cliente_destino['||en_cliente_destino;
LV_INFO_REG := LV_INFO_REG || '] en_abonado_destino['||en_abonado_destino||'] ln_cod_prod_ofertado ['||ln_cod_prod_ofertado;
LV_INFO_REG := LV_INFO_REG || '] ed_fecha_alta['||to_char(ed_fecha_alta, 'dd-mm-yyyy hh24:mi:ss')||']';
LV_INFO_REG := LV_INFO_REG || '] ed_fecha_baja['||to_char(ed_fecha_baja, 'dd-mm-yyyy hh24:mi:ss')||']';

/* 160835|12-01-2011|EFR
pv_general_ooss_pg.PV_AUDREG_PR
                ('PA',   --> cod_modulo
                en_abonado_destino,   --> num_inter
                1,               --> tip_inter // 1= abonado / 8=cliente / [2-7] Cualquier wea
                '3',              --> tipo de ejecuccion 3=OK  // 4 NOOK
                NULL,             --> Numero incidencia (uno nunca sabe)
                'FR',             --> cod_tipmodi
                NULL,             --> cod_os
                LV_DESESTADO,  --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                LV_INFO_REG,   --> Variable pa guardar cualquier wea ( maximo 3000 creo, pero la uso siempre de 2000 para prevenitr)
                LV_NomProc,   --> Nombre procedimiento
                LV_Tabla,      --> Tabla en la que vas( del ruteo)
                LV_Act,        --> accion que se esta ejecutando (I= Insert / U=Update / D= Delete / S= Select)
                NULL,         --> Da lo mismo
                SQLCODE,      --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                SQLERRM,      --> por si controlas errores(exeption, yo siempre lo dejo por defecto :P asi nunca me falta)
                0,            --> Da lo mismo
                LNEstado,     --> Retorno
                LVCode, --> Retorno
                LVErrm);      --> Retorno
*/

--------------------------------------------------------------

      IF (NOT pv_agrega_fn(en_cliente_destino,
                           en_abonado_destino,
                           ln_cod_prod_ofertado,
                           ed_fecha_alta,
                           ed_fecha_baja,
                           en_num_mov_ant,
                           ln_num_veces,
                           en_num_proceso,
                           ev_cod_canal,
                           --'D',
                           lv_ind_contratacion,
                           NULL,
                           'N',
                           -- lv_cargo_ocasional, -- FPP 09-07-2010 Defecto 77
                           lv_cargo_ocasional_tmp, -- FPP 09-07-2010 Defecto 77
                           sn_cod_retorno,
                           sv_mens_retorno,
                           sn_num_evento)) THEN
        RAISE error_subfuncion;
      END IF;
    END LOOP;
    CLOSE c_agr_planes_opcionales; -- RRG COL 161846 22.01.2011
  EXCEPTION
    WHEN error_subfuncion THEN
      sn_cod_retorno := 156;

      IF NOT ge_errores_pg.mensajeerror(sn_cod_retorno, sv_mens_retorno) THEN
        sv_mens_retorno := cv_error_no_clasif;
      END IF;

      lv_des_error  := 'PV_PLANES_ADICIONALES_PG(' || '); - ' || SQLERRM;
      sn_num_evento := ge_errores_pg.grabarpl(sn_num_evento,
                                              'PV',
                                              sv_mens_retorno,
                                              cv_version,
                                              USER,
                                              ' PV_PLANES_ADICIONALES_PG.pv_agrega_planes_opcionales_pr',
                                              lv_ssql,
                                              sn_cod_retorno,
                                              lv_des_error);
  END pv_agrega_planes_opcionales_pr;
--Fin Inc. 170939 / 25-07-2011 / FDL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_PROVISION_ABONADO_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO       IN pr_productos_contratados_to.num_proceso%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*


 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_PROVISION_ABONADO_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Para los productos del cliente, que tengan acción en centrales, aprovisiona el comando al abonado informado</Descripción>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

LO_ABONADO                   GA_ABONADO_QT;
LO_LISTA_CENTRALES          IC_PROVISION_QT;
LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
C_PRO_CONTRATADOS         refcursor;

LN_cod_espec_prod        se_detalles_especificacion_to.cod_espec_prod%TYPE;
LN_cod_perfil_lista      se_detalles_especificacion_to.cod_perfil_lista%TYPE;
LN_cod_prov_serv          se_detalles_especificacion_to.cod_prov_serv%TYPE;
LV_cod_servicio_base     se_detalles_especificacion_to.cod_servicio_base%TYPE;
LV_ind_tipo_servicio     se_detalles_especificacion_to.ind_tipo_servicio%TYPE;
LV_tipo_comportamiento   ps_especificaciones_prod_td.tipo_comportamiento%TYPE;
LV_tipo_plataforma          ps_especificaciones_prod_td.tipo_plataforma%TYPE;
LV_tipo_unidad_bonificar se_planes_altamira_td.tipo_unidad_bonificar%TYPE;
LN_can_bonificar         se_planes_altamira_td.can_bonificar%TYPE;

LD_FECHA_ALTA DATE;
LV_USUARIO             ga_abocel.nom_usuarora%TYPE;
BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    --Se obtiene el usuario de la OOSS
    BEGIN
        SELECT usuario
        INTO   LV_USUARIO
        FROM   pv_iorserv
        WHERE  num_os = EN_NUM_PROCESO
        UNION
        SELECT usuario
        FROM   ci_orserv
        WHERE  num_os = EN_NUM_PROCESO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            LV_USUARIO := USER;
    END;
    LD_FECHA_ALTA := TO_DATE(EV_FECHA_ALTA,'DD-MM-YYYY HH24:MI:SS');

    LO_LISTA_CENTRALES := IC_PROVISION_QT();

    --Se prepara estructura para obtener datos del abonado
    LO_ABONADO:= GA_ABONADO_QT(EN_ABONADO_ORIGEN,'','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                        '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                        '','','','','','','','','','');
    --Se Obtienen los datos del abonado
    PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR(LO_ABONADO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
    IF (SN_COD_RETORNO != 0) THEN
        RAISE ERROR_SUBFUNCION;
    END IF;
    --Se obtienen los planes contratados para el cliente, excepto aquellos de los que es solo contratante
    --o solo beneficiario pues se analizan en forma posterior

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM pr_productos_contratados_to producto, pf_productos_ofertados_td ofertado';
    LV_sSql := LV_sSql || ' WHERE producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario = 0';
    LV_sSql := LV_sSql || ' AND producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario = producto.num_abonado_contratante';
    LV_sSql := LV_sSql || ' AND sysdate BETWEEN producto.fec_inicio_vigencia AND producto.fec_termino_vigencia';
    LV_sSql := LV_sSql || ' AND producto.cod_prod_ofertado = ofertado.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' AND DECODE (ofertado.tipo_plataforma, ''1'', 3, ''2'', 2, ''3'', 10) = '||LO_ABONADO.COD_USO;

    OPEN C_PRO_CONTRATADOS FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
    FROM   pr_productos_contratados_to producto, pf_productos_ofertados_td ofertado
    WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
    AND    producto.num_abonado_beneficiario = 0
    AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante
    AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante
    AND       sysdate BETWEEN producto.fec_inicio_vigencia AND NVL(producto.fec_termino_vigencia,TO_DATE('31-12-3000','DD-MM-YYYY'))
    AND       producto.cod_prod_ofertado = ofertado.cod_prod_ofertado
    AND       DECODE (ofertado.tipo_plataforma, '1', 3, '2', 2, '3', 10) = LO_ABONADO.COD_USO;

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO   LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        --Se buscan los datos necesarios para contratar productos

        SELECT servicio.cod_espec_prod, servicio.cod_perfil_lista, servicio.cod_prov_serv, servicio.cod_servicio_base,
               servicio.ind_tipo_servicio, espec.tipo_comportamiento, espec.tipo_plataforma
        INTO   LN_cod_espec_prod, LN_cod_perfil_lista, LN_cod_prov_serv, LV_cod_servicio_base,
               LV_ind_tipo_servicio, LV_tipo_comportamiento, LV_tipo_plataforma
        FROM   pf_productos_ofertados_td ofertado, ps_especificaciones_prod_td espec, se_detalles_especificacion_to servicio
        WHERE  ofertado.cod_espec_prod = espec.cod_espec_prod
        AND       ofertado.cod_espec_prod = servicio.cod_espec_prod
        AND       ofertado.cod_prod_ofertado = LN_COD_PROD_OFERTADO;

        IF (LV_ind_tipo_servicio = 'AA') THEN

            SELECT altamira.tipo_unidad_bonificar, altamira.can_bonificar
            INTO   LV_tipo_unidad_bonificar, LN_can_bonificar
            FROM   se_planes_altamira_td altamira
            WHERE  altamira.cod_plan_altamira = LV_cod_servicio_base;
        ELSE
            LV_tipo_unidad_bonificar := '0';
            LN_can_bonificar := '0';
        END IF;

        IF (LN_cod_prov_serv IS NOT NULL) THEN

            --Se prepara la estructura para enviar a centrales
            LO_LISTA_CENTRALES.COD_CLIENTE := LO_ABONADO.COD_CLIENTE;
            LO_LISTA_CENTRALES.COD_PROV_SERV := LN_cod_prov_serv;
            LO_LISTA_CENTRALES.TIP_ACCION := '1';
            LO_LISTA_CENTRALES.TIP_SER := LV_ind_tipo_servicio;
            LO_LISTA_CENTRALES.COD_PROD_CONTRAT := LN_COD_PROD_CONTRATADO;
            LO_LISTA_CENTRALES.FECHA_EJECUCION := LD_FECHA_ALTA;
            LO_LISTA_CENTRALES.NUM_CELULAR := LO_ABONADO.NUM_CELULAR;
            LO_LISTA_CENTRALES.NUM_ABONADO := LO_ABONADO.NUM_ABONADO;
            LO_LISTA_CENTRALES.TIP_TERMINAL := LO_ABONADO.TIP_TERMINAL;
            LO_LISTA_CENTRALES.COD_CENTRAL := LO_ABONADO.COD_CENTRAL;
            LO_LISTA_CENTRALES.NUM_SERIE := LO_ABONADO.NUM_SERIE;
            LO_LISTA_CENTRALES.COD_TECNOLOGIA := LO_ABONADO.COD_TECNOLOGIA;
            LO_LISTA_CENTRALES.ID_PLAN := LV_cod_servicio_base;
            LO_LISTA_CENTRALES.IMPORTE := '0';
            LO_LISTA_CENTRALES.COD_MONEDA := '0';
            LO_LISTA_CENTRALES.USUARIO := 'SCL';
            LO_LISTA_CENTRALES.COD_CAUSA := '00';
            LO_LISTA_CENTRALES.MONTO_BONIF := LN_can_bonificar;
            LO_LISTA_CENTRALES.TIPO_BONO := LV_tipo_unidad_bonificar;
            LO_LISTA_CENTRALES.COD_PERIODIF := NULL;
            LO_LISTA_CENTRALES.FECHA_EJEC_BONO := LD_FECHA_ALTA;
            LO_LISTA_CENTRALES.NUM_MOVANT := EN_NUM_MOV_ANT;
            LO_LISTA_CENTRALES.NOM_USUARORA := LV_USUARIO;
            --Se informa el movimiento a centrales
            IC_PROVISION_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_PROVISION_ABONADO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




PROCEDURE PV_LLAMADA_ODBC_APROVI_PR(EN_SECUENCIAL      IN GA_TRANSACABO.NUM_TRANSACCION%TYPE,
                                    EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                    EN_NUMERO_VENTA    IN ga_abocel.NUM_VENTA%TYPE,
                                    EN_NUMERO_MOVANT   IN ICC_MOVIMIENTO.NUM_MOVANT%TYPE
                                   ) IS

/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_LLAMADA_ODBC_APROVI_PR"
           Lenguaje="PL/SQL"
       Fecha="5-12-2008"
       Versión="La del package"
       Diseñador="oRLANDO cABEZAS"
       Programador="oRLANDO cABEZAS"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Llamada para aplicaciones ODBC</Descripción>
       <Parámetros>
          <Entrada>
                <param nom ="EN_SECUENCIAL" tipo="NUMERICO">SECUENCIAL</param>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">CODIGO CLIENTE</param>
                <param nom ="EN_NUMERO_VENTA  " tipo="NUMERICO">NUMERO VENTA</param>
          </Entrada>
          <Salida>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

C_PRO_ABOCEL          refcursor;
LN_NUM_ABONADO        GA_aBOCEL.NUM_ABONADO%TYPE;
LN_NUMERO_MOVANT      ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
LD_FEC_ALTA           GA_aBOCEL.FEC_ALTA%TYPE;
SSN_COD_RETORNO       ge_errores_td.cod_msgerror%TYPE;
SSV_MENS_RETORNO      ge_errores_td.det_msgerror%TYPE;
LN_CANTIDAD              integer;
SSN_NUM_EVENTO        integer;

BEGIN

    SSN_Cod_retorno     := 0;
    SSV_Mens_retorno := NULL;
    SSN_Num_evento     := 0;
    LN_CANTIDAD        :=0;

    LV_sSql := 'SELECT count(1)';
    LV_sSql := LV_sSql || ' FROM   GA_ABOCEL';
    LV_sSql := LV_sSql || ' WHERE  NUM_VENTA = '||EN_NUMERO_VENTA;


    SELECT COUNT(1)
    INTO LN_CANTIDAD
    FROM   GA_ABOCEL
    WHERE  COD_CLIENTE = EN_CLIENTE_ORIGEN AND
           NUM_VENTA  <> EN_NUMERO_VENTA;

    if LN_CANTIDAD > 0 then


            LV_sSql := 'SELECT NUM_ABONADO';
            LV_sSql := LV_sSql || ' FROM   GA_ABOCEL';
            LV_sSql := LV_sSql || ' WHERE  NUM_VENTA = '||EN_NUMERO_VENTA;


            OPEN C_PRO_ABOCEL FOR
                SELECT NUM_ABONADO,FEC_ALTA
                FROM   GA_ABOCEL
                WHERE  NUM_VENTA =EN_NUMERO_VENTA;

                IF EN_NUMERO_MOVANT = 0 THEN
                   BEGIN

                   SELECT  NUM_MOVIMIENTO
                   INTO LN_NUMERO_MOVANT
                   FROM ICC_MOVIMIENTO
                   WHERE
                   NUM_ABONADO =  LN_NUM_ABONADO
                   AND COD_ACTABO IN('VO','VT');

                   EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                           LN_NUMERO_MOVANT:=0;
                   END;


                ELSE
                  LN_NUMERO_MOVANT:=EN_NUMERO_MOVANT;

                END IF;

            LOOP

                FETCH C_PRO_ABOCEL
                INTO   LN_NUM_ABONADO,LD_FEC_ALTA;

                EXIT WHEN C_PRO_ABOCEL%NOTFOUND;
                  PV_PLANES_ADICIONALES_PG.PV_PROVISION_ABONADO_PR(EN_CLIENTE_ORIGEN,LN_NUM_ABONADO,LD_FEC_ALTA,LN_NUMERO_MOVANT,EN_NUMERO_VENTA,SSN_COD_RETORNO, SSV_MENS_RETORNO, SSN_NUM_EVENTO);
                    IF (SSN_COD_RETORNO != 0) THEN
                        RAISE ERROR_SUBFUNCION;
                    END IF;

            END LOOP;
   END IF;

   INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)VALUES (EN_SECUENCIAL ,0,'OK');


EXCEPTION
   WHEN NO_DATA_FOUND THEN
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)VALUES (EN_SECUENCIAL ,4,'NO HAY REGISTROS');
      SSN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SSN_Cod_retorno,SSV_mens_retorno) THEN
         SSV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SSN_num_evento  := Ge_Errores_Pg.Grabarpl( SSN_num_evento, 'PV', SSV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_LLAMADA_ODBC_APROVI_PR', LV_sSQL, SSN_cod_retorno, LV_des_error );

   WHEN ERROR_SUBFUNCION THEN
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)VALUES (EN_SECUENCIAL ,4,'PV_PLANES_ADICIONALES_PG.PV_PROVISION_ABONADO_PR');
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SSN_Cod_retorno,SSV_mens_retorno) THEN
         SSV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SSN_num_evento  := Ge_Errores_Pg.Grabarpl( SSN_num_evento, 'PV', SSV_mens_retorno, CV_version, USER, 'PV_PLANES_ADICIONALES_PG.PV_LLAMADA_ODBC_APROVI_PR', LV_sSQL, SSN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)VALUES (EN_SECUENCIAL ,4,'PV_PLANES_ADICIONALES_PG.PV_PROVISION_ABONADO_PR');
      SSN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SSN_Cod_retorno,SSV_mens_retorno) THEN
         SSV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SSN_num_evento  := Ge_Errores_Pg.Grabarpl( SSN_num_evento, 'PV', SSV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_LLAMADA_ODBC_APROVI_PR', LV_sSQL, SSN_cod_retorno, LV_des_error );

END PV_LLAMADA_ODBC_APROVI_PR;

PROCEDURE PV_FACHADA_UNIX_PR(  EN_NUM_OS  IN PV_IORSERV.NUM_OS%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                               ) IS

/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_FACHADA_UNIX_PR"
           Lenguaje="PL/SQL"
       Fecha="5-12-2008"
       Versión="La del package"
       Diseñador="oRLANDO cABEZAS"
       Programador="oRLANDO cABEZAS"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Llamada para aplicaciones UNIX</Descripción>
       <Parámetros>
          <Entrada>
        <param nom ="EN_NUM_OS" tipo="NUMERICO">NUMERO OS</param>
          </Entrada>
          <Salida>
          <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
LV_COD_OS        PV_IORSERV.COD_OS%TYPE;
ln_cod_cliente   GA_ABOCEL.COD_CLIENTE%TYPE;
ln_num_abonado   GA_ABOCEL.NUM_ABONADO%TYPE;
lv_tip_plantarif ga_abocel.tip_plantarif%type;
ln_cantidad      integer;
lv_plan             PV_PARAM_ABOCEL.COD_PLANTARIF%TYPE;
lv_plan_nue         PV_PARAM_ABOCEL.COD_PLANTARIF_NUE%TYPE;
lv_num_os         varchar2(10);
ld_fec_vigencia     DATE;
ERROR_SUBFUNCION EXCEPTION;
LN_OSEJECUTADAS     NUMBER := 0;
ln_cantidad_activos NUMBER := 0;

--Incidencia 174755 - P-CSR-11002 - FADL
ln_num_movimiento   PV_MOVIMIENTOS.NUM_MOVIMIENTO%TYPE;
lv_num_contrato        PV_CAMCOM.PREF_PLAZA%TYPE;
--Incidencia 174755 - P-CSR-11002 - FADL

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    lv_num_os       :=EN_NUM_OS;


    LV_sSql := 'SELECT COD_OS FROM PV_IORSERV WHERE NUM_OS = '||EN_NUM_OS;

    SELECT COD_OS
    INTO   LV_COD_OS
    FROM   pv_iorserv
    WHERE  num_os = EN_NUM_OS;


    LV_sSql := 'SELECT num_abonado ,cod_plantarif,cod_plantarif_nue FROM PV_PARAM_ABOCEL WHERE NUM_OS = '||EN_NUM_OS;

    SELECT num_abonado ,cod_plantarif,cod_plantarif_nue
    INTO   ln_num_abonado ,lv_plan,lv_plan_nue
    FROM   pv_param_abocel
    WHERE  num_os = EN_NUM_OS;

    LV_sSql := 'SELECT cod_cliente,tip_plantarif FROM GA_ABOCEL    WHERE  NUM_ABONADO = '||ln_num_abonado;

  ---Incidencia 130512 proyecto P-MIX-09003
    SELECT cod_cliente,tip_plantarif
    INTO   ln_cod_cliente, lv_tip_plantarif
    FROM   ga_abocel
    WHERE  num_abonado = ln_num_abonado
    UNION
    SELECT cod_cliente,tip_plantarif
    FROM   ga_aboamist
    WHERE  num_abonado = ln_num_abonado;


    CASE LV_COD_OS


        WHEN  '10233' THEN -- baja abonado(pos-pre,hib-pre)

            LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')
                ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

            PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,ln_num_abonado,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,
                en_num_os,'PV',sn_cod_retorno,sv_mens_retorno,sn_num_evento );

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

            LN_CANTIDAD:=0;

            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql ||' FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c';
            LV_sSql := LV_sSql ||' WHERE  a.cod_estado = 310';
            LV_sSql := LV_sSql ||' AND       c.cod_os = ''10233''';
            LV_sSql := LV_sSql ||' AND       a.tip_estado != 4';
            LV_sSql := LV_sSql ||' AND       a.num_os = c.num_os';
            LV_sSql := LV_sSql ||' AND       b.cod_cliente = '||ln_cod_cliente;
            LV_sSql := LV_sSql ||' AND       a.num_os = b.num_os';
            LV_sSql := LV_sSql ||' AND       trunc(c.fh_ejecucion) = trunc(sysdate)';

            SELECT count(0)
            INTO   LN_OSEJECUTADAS
            FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c
            WHERE  a.cod_estado = 310
            AND       c.cod_os = '10233'
            AND       a.tip_estado != 4
            AND       a.num_os = c.num_os
            AND       b.cod_cliente = ln_cod_cliente
            AND       a.num_os = b.num_os
            AND       trunc(NVL(c.fh_ejecucion,sysdate)) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
                ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  IN ('BAP','BAA')
            AND       trunc(FEC_BAJA) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
            ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD_ACTIVOS
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  NOT IN ('BAA','BAP');


            IF (LN_CANTIDAD <= LN_OSEJECUTADAS AND LN_CANTIDAD_ACTIVOS = 0) THEN

                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);

                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||0||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')
                    ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

                PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,0,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',
                    sn_cod_retorno,sv_mens_retorno,sn_num_evento);

            ELSE

                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);
            END IF;

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;



        WHEN  '10222' THEN -- baja abonado

            LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||
                TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||null||', '||0||', '||en_num_os||', ''PV'')';

            PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,ln_num_abonado,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,
                en_num_os,'PV',sn_cod_retorno,sv_mens_retorno,sn_num_evento );

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

            LN_CANTIDAD:=0;

            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql ||' FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c';
            LV_sSql := LV_sSql ||' WHERE  a.cod_estado = 310';
            LV_sSql := LV_sSql ||' AND       c.cod_os = ''10222''';
            LV_sSql := LV_sSql ||' AND       a.tip_estado != 4';
            LV_sSql := LV_sSql ||' AND       a.num_os = c.num_os';
            LV_sSql := LV_sSql ||' AND       b.cod_cliente = '||ln_cod_cliente;
            LV_sSql := LV_sSql ||' AND       trunc(c.fh_ejecucion) = trunc(sysdate)';

            SELECT count(0)
            INTO   LN_OSEJECUTADAS
            FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c
            WHERE  a.cod_estado = 310
            AND       c.cod_os = '10222'
            AND       a.tip_estado != 4
            AND       a.num_os = c.num_os
            AND       b.cod_cliente = ln_cod_cliente
            AND       a.num_os = b.num_os
            AND       trunc(NVL(c.fh_ejecucion,sysdate)) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
                ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  IN ('BAP','BAA')
            AND       trunc(FEC_BAJA) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
            ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD_ACTIVOS
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  NOT IN ('BAA','BAP');


            IF (LN_CANTIDAD <= LN_OSEJECUTADAS AND LN_CANTIDAD_ACTIVOS = 0) THEN
                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);


                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||0||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')
                    ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

                PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,0,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',
                    sn_cod_retorno,sv_mens_retorno,sn_num_evento);

            ELSE

                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);
            END IF;

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;


        WHEN  '10020' THEN --plan tarifario(pos-pos,hib-hib)

            LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan_nue||')';

            PV_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR(ln_cod_cliente,ln_num_abonado,lv_plan_nue,
                ld_fec_vigencia,sn_cod_retorno, sv_mens_retorno, sn_num_evento);

            IF (sn_cod_retorno>0 OR ld_fec_vigencia IS NULL) THEN
                RAISE error_subfuncion;
            END IF;

            LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan||', '||0||', '||
                ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan_nue||', '||TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS')||', '||null||', '||
                0||', '||en_num_os||', ''PV'')';

            PV_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR(ln_cod_cliente,ln_num_abonado,lv_plan,0,ln_cod_cliente,ln_num_abonado,lv_plan_nue,
                TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',sn_cod_retorno, sv_mens_retorno, sn_num_evento);

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        WHEN  '10022' THEN --plan tarifario empresa(pos-pos)

            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql ||' FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c';
            LV_sSql := LV_sSql ||' WHERE  a.cod_estado = 310';
            LV_sSql := LV_sSql ||' AND       c.cod_os = ''10022''';
            LV_sSql := LV_sSql ||' AND       a.tip_estado = 3';
            LV_sSql := LV_sSql ||' AND       a.num_os = c.num_os';
            LV_sSql := LV_sSql ||' AND       b.cod_cliente = '||ln_cod_cliente;
            LV_sSql := LV_sSql ||' AND       a.num_os = b.num_os';
            LV_sSql := LV_sSql ||' AND    a.num_os != '||en_num_os;
            LV_sSql := LV_sSql ||' AND       trunc(c.fh_ejecucion) = trunc(sysdate)';


            SELECT count(0)
            INTO   LN_OSEJECUTADAS
            FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c
            WHERE  a.cod_estado = 310
            AND       c.cod_os = '10022'
            AND       a.tip_estado = 3
            AND       a.num_os = c.num_os
            AND       b.cod_cliente = ln_cod_cliente
            AND       a.num_os = b.num_os
            AND    a.num_os != en_num_os
            AND       trunc(c.fh_ejecucion) = trunc(sysdate);

            IF LN_OSEJECUTADAS = 0 THEN

                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR('||ln_cod_cliente||', '||0||', '||lv_plan_nue||', )';

                PV_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR(ln_cod_cliente,0,lv_plan_nue,ld_fec_vigencia,sn_cod_retorno, sv_mens_retorno, sn_num_evento);

                IF (sn_cod_retorno>0 OR ld_fec_vigencia IS NULL) THEN
                    RAISE error_subfuncion;
                END IF;

                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR('||ln_cod_cliente||', '||0||', '||lv_plan||', '||0||', '||ln_cod_cliente
                    ||', '||0||', '||lv_plan_nue||', '||TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS')||', '||null
                    ||', '||0||', '||en_num_os||', ''PV'')';

                PV_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR(ln_cod_cliente,0,lv_plan,0,ln_cod_cliente,0,lv_plan_nue,
                    TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',sn_cod_retorno, sv_mens_retorno, sn_num_evento);

                IF SN_COD_RETORNO>0 THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;
            END IF;

        WHEN  '10530' THEN --plan tarifario (pos-hib)

            LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan_nue||', )';

            PV_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR(ln_cod_cliente,ln_num_abonado,lv_plan_nue,ld_fec_vigencia,sn_cod_retorno, sv_mens_retorno, sn_num_evento);

            IF (sn_cod_retorno>0 OR ld_fec_vigencia IS NULL) THEN
                RAISE error_subfuncion;
            END IF;

            LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan||', '||0
                ||', '||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan_nue||', '||TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS')
                ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

            PV_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR(ln_cod_cliente,ln_num_abonado,lv_plan,0,ln_cod_cliente,ln_num_abonado,lv_plan_nue,
                TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',sn_cod_retorno, sv_mens_retorno, sn_num_evento);

            IF sn_cod_retorno>0 THEN
                RAISE error_subfuncion;
            END IF;

        WHEN  '10539' THEN --plan tarifario (hib-pos)

            LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan_nue||')';

            PV_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR(ln_cod_cliente,ln_num_abonado,lv_plan_nue,ld_fec_vigencia,sn_cod_retorno, sv_mens_retorno, sn_num_evento);

            IF (sn_cod_retorno>0 OR ld_fec_vigencia IS NULL) THEN
                RAISE error_subfuncion;
            END IF;

            LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan||', '||0
                ||', '||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan_nue||', '||TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS')
                ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

            PV_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR(ln_cod_cliente,ln_num_abonado,lv_plan,0,ln_cod_cliente,ln_num_abonado,lv_plan_nue,
                TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',sn_cod_retorno, sv_mens_retorno, sn_num_evento);

            IF sn_cod_retorno>0 THEN
                RAISE error_subfuncion;
            END IF;

        WHEN  '50011' THEN -- baja abonado masiva por archivo

            LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||
                TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||null||', '||0||', '||en_num_os||', ''PV'')';

            PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,ln_num_abonado,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,
                en_num_os,'PV',sn_cod_retorno,sv_mens_retorno,sn_num_evento );

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

            LN_CANTIDAD:=0;

            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql ||' FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c';
            LV_sSql := LV_sSql ||' WHERE  a.cod_estado = 310';
            LV_sSql := LV_sSql ||' AND       c.cod_os = ''50011''';
            LV_sSql := LV_sSql ||' AND       a.tip_estado != 4';
            LV_sSql := LV_sSql ||' AND       a.num_os = c.num_os';
            LV_sSql := LV_sSql ||' AND       b.cod_cliente = '||ln_cod_cliente;
            LV_sSql := LV_sSql ||' AND       trunc(c.fh_ejecucion) = trunc(sysdate)';

            SELECT count(0)
            INTO   LN_OSEJECUTADAS
            FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c
            WHERE  a.cod_estado = 310
            AND       c.cod_os = '50011'
            AND       a.tip_estado != 4
            AND       a.num_os = c.num_os
            AND       b.cod_cliente = ln_cod_cliente
            AND       a.num_os = b.num_os
            AND       trunc(NVL(c.fh_ejecucion,sysdate)) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
                ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  IN ('BAP','BAA')
            AND       trunc(FEC_BAJA) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
            ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD_ACTIVOS
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  NOT IN ('BAA','BAP');


            IF (LN_CANTIDAD <= LN_OSEJECUTADAS AND LN_CANTIDAD_ACTIVOS = 0) THEN
                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);


                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||0||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')
                    ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

                PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,0,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',
                    sn_cod_retorno,sv_mens_retorno,sn_num_evento);

            ELSE

                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);
            END IF;

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        WHEN  '50013' THEN -- baja abonado por fraude

            LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||
                TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||null||', '||0||', '||en_num_os||', ''PV'')';

            PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,ln_num_abonado,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,
                en_num_os,'PV',sn_cod_retorno,sv_mens_retorno,sn_num_evento );

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

            LN_CANTIDAD:=0;

            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql ||' FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c';
            LV_sSql := LV_sSql ||' WHERE  a.cod_estado = 310';
            LV_sSql := LV_sSql ||' AND       c.cod_os = ''50013''';
            LV_sSql := LV_sSql ||' AND       a.tip_estado != 4';
            LV_sSql := LV_sSql ||' AND       a.num_os = c.num_os';
            LV_sSql := LV_sSql ||' AND       b.cod_cliente = '||ln_cod_cliente;
            LV_sSql := LV_sSql ||' AND       trunc(c.fh_ejecucion) = trunc(sysdate)';

            SELECT count(0)
            INTO   LN_OSEJECUTADAS
            FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c
            WHERE  a.cod_estado = 310
            AND       c.cod_os = '50013'
            AND       a.tip_estado != 4
            AND       a.num_os = c.num_os
            AND       b.cod_cliente = ln_cod_cliente
            AND       a.num_os = b.num_os
            AND       trunc(NVL(c.fh_ejecucion,sysdate)) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
                ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  IN ('BAP','BAA')
            AND       trunc(FEC_BAJA) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
            ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD_ACTIVOS
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  NOT IN ('BAA','BAP');


            IF (LN_CANTIDAD <= LN_OSEJECUTADAS AND LN_CANTIDAD_ACTIVOS = 0) THEN
                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);


                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||0||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')
                    ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

                PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,0,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',
                    sn_cod_retorno,sv_mens_retorno,sn_num_evento);

            ELSE

                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);
            END IF;

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

    WHEN  '50002' THEN -- baja abonado por fraude masiva

            LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||
                TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||null||', '||0||', '||en_num_os||', ''PV'')';

            PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,ln_num_abonado,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,
                en_num_os,'PV',sn_cod_retorno,sv_mens_retorno,sn_num_evento );

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

            LN_CANTIDAD:=0;

            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql ||' FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c';
            LV_sSql := LV_sSql ||' WHERE  a.cod_estado = 310';
            LV_sSql := LV_sSql ||' AND       c.cod_os = ''50002''';
            LV_sSql := LV_sSql ||' AND       a.tip_estado != 4';
            LV_sSql := LV_sSql ||' AND       a.num_os = c.num_os';
            LV_sSql := LV_sSql ||' AND       b.cod_cliente = '||ln_cod_cliente;
            LV_sSql := LV_sSql ||' AND       trunc(c.fh_ejecucion) = trunc(sysdate)';

            SELECT count(0)
            INTO   LN_OSEJECUTADAS
            FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c
            WHERE  a.cod_estado = 310
            AND       c.cod_os = '50002'
            AND       a.tip_estado != 4
            AND       a.num_os = c.num_os
            AND       b.cod_cliente = ln_cod_cliente
            AND       a.num_os = b.num_os
            AND       trunc(NVL(c.fh_ejecucion,sysdate)) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
                ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  IN ('BAP','BAA')
            AND       trunc(FEC_BAJA) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
            ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD_ACTIVOS
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  NOT IN ('BAA','BAP');


            IF (LN_CANTIDAD <= LN_OSEJECUTADAS AND LN_CANTIDAD_ACTIVOS = 0) THEN
                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);


                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||0||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')
                    ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

                PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,0,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',
                    sn_cod_retorno,sv_mens_retorno,sn_num_evento);

            ELSE

                LV_sSql := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);
            END IF;

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

    WHEN '10060' THEN -- aviso de siniestro

        LV_sSql := 'SELECT a.NUM_MOVIMIENTO,b.NUM_CONTRATO';
        LV_sSql := LV_sSql || 'from pv_movimientos a, pv_param_abocel b';
        LV_sSql := LV_sSql || 'where a.NUM_OS = EN_NUM_OS';
        LV_sSql := LV_sSql || 'and a.NUM_OS = b.NUM_OS';

        SELECT a.NUM_MOVIMIENTO,b.PREF_PLAZA
        INTO ln_num_movimiento, lv_num_contrato
        FROM pv_movimientos a, pv_camcom b
        WHERE a.NUM_OS = EN_NUM_OS
        AND a.NUM_OS = b.NUM_OS;

        IF(ln_num_movimiento IS NOT NULL ) THEN

            IF(lv_num_contrato IS NOT NULL) THEN

                UPDATE icc_movimiento
                SET NUM_CELULAR_NUE = lv_num_contrato
                WHERE NUM_MOVIMIENTO = ln_num_movimiento;
            END IF;
        END IF;

    ELSE
        SN_Cod_retorno     := 0;
        SV_Mens_retorno := 'OK';
        SN_Num_evento     := 0;

    END CASE;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;

      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_FACHADA_UNIX_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;

      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'PV_PLANES_ADICIONALES_PG.PV_FACHADA_UNIX_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;

      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_FACHADA_UNIX_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_FACHADA_UNIX_PR;

procedure PV_FEC_VIGENCIA_PLAN_PR (      en_cliente         in ge_clientes.cod_cliente%type,
                                en_abonado         in ga_abocel.num_abonado%type,
                                ev_plan_destino       in ta_plantarif.cod_plantarif%type,
                                sd_fecha           out nocopy ga_intarcel.fec_desde%type,
                                sn_cod_retorno     out nocopy ge_errores_td.cod_msgerror%type,
                                sv_mens_retorno    out nocopy ge_errores_td.det_msgerror%type,
                                sn_num_evento      out nocopy ge_errores_pg.evento
                             )         is

/*
 <documentación
   tipodoc = "Procedure">>
    <elemento
       nombre = "PV_FEC_VIGENCIA_PLAN_PR"
           lenguaje="PL/SQL"
       fecha="5-12-2008"
       versión="La del package"
       diseñador="oRLANDO cABEZAS"
       programador="oRLANDO cABEZAS"
       ambiente desarrollo="BD">
       <retorno>n/a</retorno>>
       <descripción>llamada para aplicaciones unix</descripción>
       <parámetros>
          <entrada>
                <param nom ="EN_CLIENTE" tipo="NUMERICO">cliente origen</param>
                <param nom ="EN_ABONADO" tipo="NUMERICO">abonado origen</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">plan tarifario destino</param>
          </entrada>
          <salida>
             <param nom="SD_FECHA" tipo="DATE">fecha vigencia plan</param>
             <param nom="SN_COD_RETORNO" tipo="NUMERICO">codigo de retorno</param>
             <param nom="SV_MENS_RETORNO" tipo="CARACTER">mensaje de retorno</param>
             <param nom="SN_NUM_EVENTO" tipo="NUMERICO">numero de evento</param>
          </salida>
       </parámetros>
    </elemento>
 </documentación>
*/
lv_des_error     ge_errores_pg.desevent;
lv_ssql          ge_errores_pg.vquery;
error_subfuncion exception;


begin

    sn_cod_retorno     := 0;
    sv_mens_retorno := null;
    sn_num_evento     := 0;
    sd_fecha        :=null;

    lv_ssql:='SELECT MAX(FEC_DESDE) INTO  SD_FECHA';
    lv_ssql:=lv_ssql || ' FROM GA_INTARCEL';
    lv_ssql:=lv_ssql || ' WHERE   COD_CLIENTE   = ' || en_cliente || ' AND';
    lv_ssql:=lv_ssql || ' NUM_ABONADO           = ' || en_abonado || ' AND';
    lv_ssql:=lv_ssql || ' COD_PLANTARIF         = ' || ev_plan_destino;

    select max(fec_desde) into  sd_fecha
    from ga_intarcel
    where   cod_cliente   = en_cliente and
             num_abonado   = en_abonado and
            cod_plantarif = ev_plan_destino;


exception
   WHEN no_data_found THEN
      sn_cod_retorno:=1540;

      IF not ge_errores_pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
         sv_mens_retorno := cv_error_no_clasif;
      END IF;

      lv_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || sqlerrm;
      sn_num_evento  := ge_errores_pg.grabarpl( sn_num_evento, 'PV', sv_mens_retorno, cv_version, user, ' PV_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR', lv_ssql, sn_cod_retorno, lv_des_error );

   WHEN error_subfuncion THEN
      IF not ge_errores_pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
         sv_mens_retorno := cv_error_no_clasif;
      END IF;

      lv_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || sqlerrm;
      sn_num_evento  := ge_errores_pg.grabarpl( sn_num_evento, 'PV', sv_mens_retorno, cv_version, user, 'PV_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR', lv_ssql, sn_cod_retorno, lv_des_error );

   WHEN others THEN
      sn_cod_retorno:=156;
      IF not ge_errores_pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
         sv_mens_retorno := cv_error_no_clasif;
      END IF;

      lv_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || sqlerrm;
      sn_num_evento  := ge_errores_pg.grabarpl( sn_num_evento, 'PV', sv_mens_retorno, cv_version, user, ' PV_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR', lv_ssql, sn_cod_retorno, lv_des_error );

END PV_FEC_VIGENCIA_PLAN_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_BAJA_PLANES_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EV_FECHA_BAJA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_BAJA_PLANES_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Descontrata todos los productos contratados</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LV_IND_CONTRATACION        pr_productos_contratados_to.ind_condicion_contratacion%TYPE;
C_PRO_CONTRATADOS         refcursor;

LD_FECHA_ALTA        DATE;
LD_FECHA_BAJA        DATE;


BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LD_FECHA_ALTA     := TO_DATE(EV_FECHA_ALTA,'DD-MM-YYYY HH24:MI:SS');
    LD_FECHA_BAJA     := TO_DATE(EV_FECHA_BAJA,'DD-MM-YYYY HH24:MI:SS');

    LD_FEC_ALTA := LD_FECHA_ALTA - (1/(24*60*60));
    --Se obtienen los planes contratados por el abonado, excepto aquellos de los que es solo contratante
    --o solo beneficiario pues se analizan en forma posterior

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
    LV_sSql := LV_sSql || ' WHERE  producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;

    OPEN C_PRO_CONTRATADOS FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado, producto.ind_condicion_contratacion
    FROM   pr_productos_contratados_to producto
    WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
    AND    producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN;

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO   LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LV_IND_CONTRATACION;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, LD_FECHA_BAJA,
           EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, LV_IND_CONTRATACION, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;

    --Se eliminan los beneficiarios del abonado origen
    PV_CADUCA_BENEFICIARIOS_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LD_FEC_ALTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
    IF (SN_COD_RETORNO != 0) THEN
        RAISE ERROR_SUBFUNCION;
    END IF;

    --Se gestiona la permanencia de la lista de vetados
    LV_sSql := 'PV_ELIMINA_VETADO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||LD_FEC_ALTA||')';
    PV_ELIMINA_VETADO_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LD_FEC_ALTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
    IF (SN_COD_RETORNO != 0) THEN
        RAISE ERROR_SUBFUNCION;
    END IF;


EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_FECHA_ALTA||', '||
                            EV_FECHA_BAJA||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_FECHA_ALTA||', '||
                            EV_FECHA_BAJA||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_FECHA_ALTA||', '||
                            EV_FECHA_BAJA||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_BAJA_PLANES_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_PROVISION_BAJA_ABO_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO       IN pr_productos_contratados_to.num_proceso%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_PROVISION_BAJA_ABO_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Para los productos del cliente, que tengan acción en centrales, aprovisiona el comando al abonado informado</Descripción>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

LO_ABONADO                   GA_ABONADO_QT;
LO_LISTA_CENTRALES          IC_PROVISION_QT;
LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
C_PRO_CONTRATADOS         refcursor;

LN_COD_USO                 ga_abocel.cod_uso%TYPE;
LN_COD_USO_ORI             ga_abocel.cod_uso%TYPE;
LN_CLIENTE_DES             ga_abocel.cod_cliente%TYPE;
LV_PLANTARIF_DES         ga_abocel.cod_plantarif%TYPE;

LN_cod_espec_prod        se_detalles_especificacion_to.cod_espec_prod%TYPE;
LN_cod_perfil_lista      se_detalles_especificacion_to.cod_perfil_lista%TYPE;
LN_cod_prov_serv          se_detalles_especificacion_to.cod_prov_serv%TYPE;
LV_cod_servicio_base     se_detalles_especificacion_to.cod_servicio_base%TYPE;
LV_ind_tipo_servicio     se_detalles_especificacion_to.ind_tipo_servicio%TYPE;
LV_tipo_comportamiento   ps_especificaciones_prod_td.tipo_comportamiento%TYPE;
LV_tipo_plataforma          ps_especificaciones_prod_td.tipo_plataforma%TYPE;
LV_tipo_unidad_bonificar se_planes_altamira_td.tipo_unidad_bonificar%TYPE;
LN_can_bonificar         se_planes_altamira_td.can_bonificar%TYPE;

LD_FECHA_ALTA DATE;
LV_USUARIO             ga_abocel.nom_usuarora%TYPE;
BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    --Se obtiene el usuario de la OOSS
    BEGIN
        SELECT usuario
        INTO   LV_USUARIO
        FROM   pv_iorserv
        WHERE  num_os = EN_NUM_PROCESO
        UNION
        SELECT usuario
        FROM   ci_orserv
        WHERE  num_os = EN_NUM_PROCESO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            LV_USUARIO := USER;
    END;

    LD_FECHA_ALTA := TO_DATE(EV_FECHA_ALTA,'DD-MM-YYYY HH24:MI:SS');

    LO_LISTA_CENTRALES := IC_PROVISION_QT();


    LV_sSql := ' SELECT a.num_celular, a.tip_terminal,';
    LV_sSql := LV_sSql || '        a.cod_central, a.num_serie, a.cod_tecnologia';
    LV_sSql := LV_sSql || ' FROM   ga_abocel a';
    LV_sSql := LV_sSql || ' WHERE  a.num_abonado = '||EN_ABONADO_ORIGEN;
    /* Se obtienen los datos del abonado */
    SELECT a.num_celular, a.tip_terminal,
           a.cod_central, a.num_serie, a.cod_tecnologia, a.cod_uso, a.cod_cliente, a.cod_plantarif
    INTO   LO_LISTA_CENTRALES.NUM_CELULAR,
           LO_LISTA_CENTRALES.TIP_TERMINAL,
           LO_LISTA_CENTRALES.COD_CENTRAL,
           LO_LISTA_CENTRALES.NUM_SERIE,
           LO_LISTA_CENTRALES.COD_TECNOLOGIA,
           LN_COD_USO,
           LN_CLIENTE_DES,
           LV_PLANTARIF_DES
    FROM   ga_abocel a
    WHERE  a.num_abonado = EN_ABONADO_ORIGEN;

    /* Se verifica si existió cambio de producto de pos a hib o de hib a pos */
    IF (EN_CLIENTE_ORIGEN != LN_CLIENTE_DES) THEN
        LV_sSql := 'SELECT cod_uso';
        LV_sSql := LV_sSql || ' FROM   ga_intarcel';
        LV_sSql := LV_sSql || ' WHERE  num_abonado = '||EN_ABONADO_ORIGEN;
        LV_sSql := LV_sSql || ' AND       cod_cliente = '||EN_CLIENTE_ORIGEN;
        LV_sSql := LV_sSql || ' AND    fec_hasta   = (  SELECT MAX(fec_hasta)';
        LV_sSql := LV_sSql || '    FROM   ga_intarcel';
        LV_sSql := LV_sSql || '    WHERE  num_abonado = '||EN_ABONADO_ORIGEN;
        LV_sSql := LV_sSql || '    AND       cod_cliente = '||EN_CLIENTE_ORIGEN||')';

        -- Se obtiene el ultimo registro par el abonado origen
        BEGIN
            SELECT cod_uso
            INTO   LN_COD_USO_ORI
            FROM   ga_intarcel
            WHERE  num_abonado = EN_ABONADO_ORIGEN
            AND       cod_cliente = EN_CLIENTE_ORIGEN
            AND    fec_hasta = (SELECT MAX(fec_hasta)
                                FROM   ga_intarcel
                                WHERE  num_abonado = EN_ABONADO_ORIGEN
                                AND       cod_cliente = EN_CLIENTE_ORIGEN);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                LN_COD_USO_ORI := LN_COD_USO;
        END;
    ELSE
        LV_sSql := 'SELECT cod_uso';
        LV_sSql := LV_sSql || ' FROM   ga_intarcel';
        LV_sSql := LV_sSql || ' WHERE  num_abonado = '||EN_ABONADO_ORIGEN;
        LV_sSql := LV_sSql || ' AND       cod_cliente = '||EN_CLIENTE_ORIGEN;
        LV_sSql := LV_sSql || ' AND       fec_desde = (SELECT MAX(fec_desde)';
        LV_sSql := LV_sSql || ' FROM   ga_intarcel';
        LV_sSql := LV_sSql || ' WHERE  num_abonado = '||EN_ABONADO_ORIGEN;
        LV_sSql := LV_sSql || ' AND       cod_cliente = '||EN_CLIENTE_ORIGEN;
        LV_sSql := LV_sSql || ' AND       cod_plantarif != '||LV_PLANTARIF_DES||')';
        -- Se obtiene el penultimo registro para verificar cambio de producto
        BEGIN
            SELECT cod_uso
            INTO   LN_COD_USO_ORI
            FROM   ga_intarcel
            WHERE  num_abonado = EN_ABONADO_ORIGEN
            AND       cod_cliente = EN_CLIENTE_ORIGEN
            AND       fec_desde = (SELECT MAX(fec_desde)
                                FROM   ga_intarcel
                                WHERE  num_abonado = EN_ABONADO_ORIGEN
                                AND       cod_cliente = EN_CLIENTE_ORIGEN
                                AND       cod_plantarif != LV_PLANTARIF_DES);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                LN_COD_USO_ORI := LN_COD_USO;
        END;
    END IF;


    IF (LN_COD_USO_ORI = LN_COD_USO) THEN

        LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
        LV_sSql := LV_sSql || ' FROM pr_productos_contratados_to producto, pf_productos_ofertados_td ofertado';
        LV_sSql := LV_sSql || ' WHERE producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
        LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario = 0';
        LV_sSql := LV_sSql || ' AND producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
        LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario = producto.num_abonado_contratante';
        LV_sSql := LV_sSql || ' AND sysdate BETWEEN producto.fec_inicio_vigencia AND producto.fec_termino_vigencia';
        LV_sSql := LV_sSql || ' AND producto.cod_prod_ofertado = ofertado.cod_prod_ofertado';
        LV_sSql := LV_sSql || ' AND DECODE (ofertado.tipo_plataforma, ''1'', 3, ''2'', 2, ''3'', 10) = '||LN_COD_USO;

        OPEN C_PRO_CONTRATADOS FOR
        SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
        FROM   pr_productos_contratados_to producto, pf_productos_ofertados_td ofertado
        WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
        AND    producto.num_abonado_beneficiario = 0
        AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante
        AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante
        AND       sysdate BETWEEN producto.fec_inicio_vigencia AND NVL(producto.fec_termino_vigencia,TO_DATE('31-12-3000','DD-MM-YYYY'))
        AND       producto.cod_prod_ofertado = ofertado.cod_prod_ofertado
        AND       DECODE (ofertado.tipo_plataforma, '1', 3, '2', 2, '3', 10) = LN_COD_USO;

    ELSE
        LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
        LV_sSql := LV_sSql || ' FROM pr_productos_contratados_to producto, pf_productos_ofertados_td ofertado';
        LV_sSql := LV_sSql || ' WHERE producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
        LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario = 0';
        LV_sSql := LV_sSql || ' AND producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
        LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario = producto.num_abonado_contratante';
        LV_sSql := LV_sSql || ' AND sysdate BETWEEN producto.fec_inicio_vigencia AND producto.fec_termino_vigencia';
        LV_sSql := LV_sSql || ' AND producto.cod_prod_ofertado = ofertado.cod_prod_ofertado';
        LV_sSql := LV_sSql || ' AND DECODE (ofertado.tipo_plataforma, ''1'', 3, ''2'', 10, ''3'', 2) = '||LN_COD_USO;

        OPEN C_PRO_CONTRATADOS FOR
        SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
        FROM   pr_productos_contratados_to producto, pf_productos_ofertados_td ofertado
        WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
        AND    producto.num_abonado_beneficiario = 0
        AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante
        AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante
        AND       sysdate BETWEEN producto.fec_inicio_vigencia AND NVL(producto.fec_termino_vigencia,TO_DATE('31-12-3000','DD-MM-YYYY'))
        AND       producto.cod_prod_ofertado = ofertado.cod_prod_ofertado
        AND       DECODE (ofertado.tipo_plataforma, '1', 3, '2', 10, '3', 2) = LN_COD_USO; --se invierten los usos para que aprovisione
                                                                                                          --las bajas de los planes que tenia antes.
    END IF;

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO   LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        --Se buscan los datos necesarios para contratar productos

        SELECT servicio.cod_espec_prod, servicio.cod_perfil_lista, servicio.cod_prov_serv, servicio.cod_servicio_base,
               servicio.ind_tipo_servicio, espec.tipo_comportamiento, espec.tipo_plataforma
        INTO   LN_cod_espec_prod, LN_cod_perfil_lista, LN_cod_prov_serv, LV_cod_servicio_base,
               LV_ind_tipo_servicio, LV_tipo_comportamiento, LV_tipo_plataforma
        FROM   pf_productos_ofertados_td ofertado, ps_especificaciones_prod_td espec, se_detalles_especificacion_to servicio
        WHERE  ofertado.cod_espec_prod = espec.cod_espec_prod
        AND       ofertado.cod_espec_prod = servicio.cod_espec_prod
        AND       ofertado.cod_prod_ofertado = LN_COD_PROD_OFERTADO;

        IF (LV_ind_tipo_servicio = 'AA') THEN

            SELECT altamira.tipo_unidad_bonificar, altamira.can_bonificar
            INTO   LV_tipo_unidad_bonificar, LN_can_bonificar
            FROM   se_planes_altamira_td altamira
            WHERE  altamira.cod_plan_altamira = LV_cod_servicio_base;
        ELSE
            LV_tipo_unidad_bonificar := '0';
            LN_can_bonificar := '0';
        END IF;

        IF (LN_cod_prov_serv IS NOT NULL) THEN

            --Se crea arreglo para invocar a centrales
            LO_LISTA_CENTRALES.TIP_ACCION :=   '2';
            LO_LISTA_CENTRALES.COD_PROD_CONTRAT := LN_COD_PROD_CONTRATADO;
            LO_LISTA_CENTRALES.FECHA_EJECUCION := LD_FECHA_ALTA;
            LO_LISTA_CENTRALES.USUARIO :=  'SCL';
            LO_LISTA_CENTRALES.NUM_MOVANT :=  EN_NUM_MOV_ANT;
            LO_LISTA_CENTRALES.COD_CLIENTE := EN_CLIENTE_ORIGEN;
            LO_LISTA_CENTRALES.NUM_ABONADO := EN_ABONADO_ORIGEN;
            LO_LISTA_CENTRALES.NOM_USUARORA := LV_USUARIO;
            --Se informa el movimiento a centrales
            IC_PROVISION_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_FECHA_ALTA||', '||EN_NUM_MOV_ANT||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_FECHA_ALTA||', '||EN_NUM_MOV_ANT||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_FECHA_ALTA||', '||EN_NUM_MOV_ANT||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_PROVISION_BAJA_ABO_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION IC_MANTIENE_PLAN_FN(EN_MOVIMIENTO IN icc_movimiento.num_movimiento%TYPE)
RETURN VARCHAR2 IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "IC_MANTIENE_PLAN_FN"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>CARACTER</Retorno>>
       <Descripción>Verifica si un movimiento corresponde a la mantencion de planes adicionales</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_MOVIMIENTO" tipo="NUMERICO">Numero de Movimiento</param>
          </Entrada>
          <Salida>
              N/A
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/

LN_ABONADO    icc_movimiento.num_abonado%TYPE;
LV_ACTABO      icc_movimiento.cod_actabo%TYPE;
LN_CLIENTE      ga_traspabo.cod_clienant%TYPE;
LN_PRODCONTRATADO pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_PRODOFERTADO   pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LN_COUNT NUMBER;

SN_COD_RETORNO  ge_errores_pg.coderror;
SV_MENS_RETORNO ge_errores_pg.msgerror;
SN_NUM_EVENTO   ge_errores_pg.evento;
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;

ERROR_PROCESO    EXCEPTION;

BEGIN
    SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := '';
    SN_NUM_EVENTO   := 0;

    LV_sSql := 'SELECT NUM_ABONADO FROM icc_movimiento WHERE num_movimiento = '||EN_MOVIMIENTO;
    BEGIN
        SELECT NUM_ABONADO, COD_ACTABO, COD_PROD_CONTRATADO
        INTO   LN_ABONADO, LV_ACTABO, LN_PRODCONTRATADO
        FROM   icc_movimiento
        WHERE  num_movimiento = EN_MOVIMIENTO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'FALSE';
    END;

    IF (LV_ACTABO = 'U1') THEN

        BEGIN
            LV_sSql := 'SELECT cod_cliente_beneficiario, cod_prod_ofertado FROM pr_productos_contratados_to WHERE  cod_prod_contratado = '||LN_PRODCONTRATADO;

            SELECT cod_cliente_beneficiario, cod_prod_ofertado
            INTO   LN_CLIENTE, LN_PRODOFERTADO
            FROM   pr_productos_contratados_to
            WHERE  cod_prod_contratado = LN_PRODCONTRATADO;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN '1';
        END;

        IF (LN_CLIENTE = 0) THEN
            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_th';
            LV_sSql := LV_sSql || ' WHERE  cod_prod_ofertado = '||LN_PRODOFERTADO;
            LV_sSql := LV_sSql || ' AND       cod_cliente_beneficiario = '||LN_CLIENTE;
            LV_sSql := LV_sSql || ' AND       num_abonado_beneficiario = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND       cod_prod_contratado IN (SELECT cod_prod_contratado';
            LV_sSql := LV_sSql || ' FROM icc_movimiento';
            LV_sSql := LV_sSql || ' WHERE num_abonado = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND cod_actabo = ''U2'')';

            SELECT count(0)
            INTO   LN_COUNT
            FROM   pr_productos_contratados_th
            WHERE  cod_prod_ofertado = LN_PRODOFERTADO
            AND       cod_cliente_beneficiario = LN_CLIENTE
            AND       num_abonado_beneficiario = LN_ABONADO
            AND       cod_prod_contratado IN (SELECT cod_prod_contratado
                                                 FROM icc_movimiento
                                           WHERE num_abonado = LN_ABONADO
                                           AND cod_actabo = 'U2');

            IF LN_COUNT > 0 THEN
                RAISE ERROR_PROCESO;
            END IF;
        ELSE
            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_th';
            LV_sSql := LV_sSql || ' WHERE  cod_prod_ofertado = '||LN_PRODOFERTADO;
            LV_sSql := LV_sSql || ' AND       cod_cliente_beneficiario = '||LN_CLIENTE;
            LV_sSql := LV_sSql || ' AND       num_abonado_beneficiario = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND       cod_prod_contratado IN (SELECT cod_prod_contratado';
            LV_sSql := LV_sSql || ' FROM icc_movimiento';
            LV_sSql := LV_sSql || ' WHERE num_abonado = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND cod_actabo = ''U2'')';

            SELECT count(0)
            INTO   LN_COUNT
            FROM   pr_productos_contratados_th
            WHERE  cod_prod_ofertado = LN_PRODOFERTADO
            AND       cod_cliente_beneficiario != LN_CLIENTE
            AND       num_abonado_beneficiario = LN_ABONADO
            AND       cod_prod_contratado IN (SELECT cod_prod_contratado
                                                 FROM icc_movimiento
                                           WHERE num_abonado = LN_ABONADO
                                           AND cod_actabo = 'U2');

            IF LN_COUNT > 0 THEN
                RAISE ERROR_PROCESO;
            END IF;

        END IF;

    END IF;

    IF (LV_ACTABO = 'U2') THEN

        BEGIN
            LV_sSql := 'SELECT cod_cliente_beneficiario, cod_prod_ofertado FROM pr_productos_contratados_to WHERE  cod_prod_contratado = '||LN_PRODCONTRATADO;

            SELECT cod_cliente_beneficiario, cod_prod_ofertado
            INTO   LN_CLIENTE, LN_PRODOFERTADO
            FROM   pr_productos_contratados_th
            WHERE  cod_prod_contratado = LN_PRODCONTRATADO;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN '1';
        END;

        IF (LN_CLIENTE = 0) THEN
            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to';
            LV_sSql := LV_sSql || ' WHERE  cod_prod_ofertado = '||LN_PRODOFERTADO;
            LV_sSql := LV_sSql || ' AND       cod_cliente_beneficiario = '||LN_CLIENTE;
            LV_sSql := LV_sSql || ' AND       num_abonado_beneficiario = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND       cod_prod_contratado IN (SELECT cod_prod_contratado';
            LV_sSql := LV_sSql || ' FROM icc_movimiento';
            LV_sSql := LV_sSql || ' WHERE num_abonado = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND cod_actabo = ''U1'')';

            SELECT count(0)
            INTO   LN_COUNT
            FROM   pr_productos_contratados_to
            WHERE  cod_prod_ofertado = LN_PRODOFERTADO
            AND       cod_cliente_beneficiario = LN_CLIENTE
            AND       num_abonado_beneficiario = LN_ABONADO
            AND       cod_prod_contratado IN (SELECT cod_prod_contratado
                                                 FROM icc_movimiento
                                           WHERE num_abonado = LN_ABONADO
                                           AND cod_actabo = 'U1');

            IF LN_COUNT > 0 THEN
                RAISE ERROR_PROCESO;
            END IF;
        ELSE
            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to';
            LV_sSql := LV_sSql || ' WHERE  cod_prod_ofertado = '||LN_PRODOFERTADO;
            LV_sSql := LV_sSql || ' AND       cod_cliente_beneficiario = '||LN_CLIENTE;
            LV_sSql := LV_sSql || ' AND       num_abonado_beneficiario = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND       cod_prod_contratado IN (SELECT cod_prod_contratado';
            LV_sSql := LV_sSql || ' FROM icc_movimiento';
            LV_sSql := LV_sSql || ' WHERE num_abonado = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND cod_actabo = ''U1'')';

            SELECT count(0)
            INTO   LN_COUNT
            FROM   pr_productos_contratados_to
            WHERE  cod_prod_ofertado = LN_PRODOFERTADO
            AND       cod_cliente_beneficiario != LN_CLIENTE
            AND       num_abonado_beneficiario = LN_ABONADO
            AND       cod_prod_contratado IN (SELECT cod_prod_contratado
                                                 FROM icc_movimiento
                                           WHERE num_abonado = LN_ABONADO
                                           AND cod_actabo = 'U1');

            IF LN_COUNT > 0 THEN
                RAISE ERROR_PROCESO;
            END IF;

        END IF;

    END IF;

    RETURN '1';

EXCEPTION
    WHEN ERROR_PROCESO THEN
        SN_cod_retorno := 295;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := cv_error_no_clasif;
        END IF;
        LV_des_error   := 'IC_MANTIENE_PLAN_FN('||EN_MOVIMIENTO||'); - ' || SQLERRM;
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'IC_MANTIENE_PLAN_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
        RETURN 'FALSE';
    WHEN NO_DATA_FOUND THEN
        SN_cod_retorno := 295;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := cv_error_no_clasif;
        END IF;
        LV_des_error   := 'IC_MANTIENE_PLAN_FN('||EN_MOVIMIENTO||'); - ' || SQLERRM;
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'IC_MANTIENE_PLAN_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
        RETURN 'FALSE';
    WHEN OTHERS THEN
        SN_cod_retorno := 156;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := cv_error_no_clasif;
        END IF;
        LV_des_error   := 'IC_MANTIENE_PLAN_FN('||EN_MOVIMIENTO||'); - ' || SQLERRM;
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'IC_MANTIENE_PLAN_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
        RETURN 'FALSE';
END IC_MANTIENE_PLAN_FN;
-------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_PROVISION_ODBC_BAJA_ABO_PR( EN_SECUENCIAL      IN GA_TRANSACABO.NUM_TRANSACCION%TYPE,
                                        EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                        EN_NUMERO_VENTA    IN ga_abocel.NUM_VENTA%TYPE
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_PROVISION_ODBC_BAJA_ABO_PR"
           Lenguaje="PL/SQL"
       Fecha="5-12-2008"
       Versión="La del package"
       Diseñador="oRLANDO cABEZAS"
       Programador="oRLANDO cABEZAS"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Llamada para aplicaciones ODBC</Descripción>
       <Parámetros>
          <Entrada>
                <param nom ="EN_SECUENCIAL" tipo="NUMERICO">SECUENCIAL</param>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">CODIGO CLIENTE</param>
                <param nom ="EN_NUMERO_VENTA  " tipo="NUMERICO">NUMERO VENTA</param>
          </Entrada>
          <Salida>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

C_PRO_ABOCEL          refcursor;
LN_NUM_ABONADO        GA_aBOCEL.NUM_ABONADO%TYPE;
LD_FEC_ALTA           GA_aBOCEL.FEC_ALTA%TYPE;
SSN_COD_RETORNO       ge_errores_td.cod_msgerror%TYPE;
SSV_MENS_RETORNO      ge_errores_td.det_msgerror%TYPE;
SSN_NUM_EVENTO        integer;

BEGIN

    SSN_Cod_retorno     := 0;
    SSV_Mens_retorno := NULL;
    SSN_Num_evento     := 0;

    OPEN C_PRO_ABOCEL FOR
    SELECT NUM_ABONADO,FEC_ALTA
    FROM   GA_ABOCEL
    WHERE  NUM_VENTA =EN_NUMERO_VENTA;


    LOOP

    FETCH C_PRO_ABOCEL
    INTO   LN_NUM_ABONADO,LD_FEC_ALTA;

    EXIT WHEN C_PRO_ABOCEL%NOTFOUND;

           PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(EN_CLIENTE_ORIGEN,LN_NUM_ABONADO,LD_FEC_ALTA,0,EN_NUMERO_VENTA,SSN_COD_RETORNO, SSV_MENS_RETORNO, SSN_NUM_EVENTO);

    IF (SSN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
    END IF;

   END LOOP;

   INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)VALUES (EN_SECUENCIAL ,0,'OK');


EXCEPTION
     WHEN ERROR_SUBFUNCION THEN
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)VALUES (EN_SECUENCIAL ,4,'PV_PLANES_ADICIONALES_PG.PV_PROVISION_ODBC_BAJA_ABO_PR');
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SSN_Cod_retorno,SSV_mens_retorno) THEN
         SSV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SSN_num_evento  := Ge_Errores_Pg.Grabarpl( SSN_num_evento, 'PV', SSV_mens_retorno, CV_version, USER, 'PV_PLANES_ADICIONALES_PG.PV_PROVISION_ODBC_BAJA_ABO_PR', LV_sSQL, SSN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)VALUES (EN_SECUENCIAL ,4,'PV_PLANES_ADICIONALES_PG.PV_PROVISION_ODBC_BAJA_ABO_PR');
      SSN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SSN_Cod_retorno,SSV_mens_retorno) THEN
         SSV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SSN_num_evento  := Ge_Errores_Pg.Grabarpl( SSN_num_evento, 'PV', SSV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_PROVISION_ODBC_BAJA_ABO_PR', LV_sSQL, SSN_cod_retorno, LV_des_error );

END PV_PROVISION_ODBC_BAJA_ABO_PR;

/*185264 BRC*/
PROCEDURE PV_PROVISION_ABONADO_PR_ALTA(  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO       IN pr_productos_contratados_to.num_proceso%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_PROVISION_ABONADO_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Para los productos del cliente, que tengan acción en centrales, aprovisiona el comando al abonado informado</Descripción>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">Nº de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">Nº Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

LO_ABONADO                   GA_ABONADO_QT;
LO_LISTA_CENTRALES          IC_PROVISION_QT;
LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
C_PRO_CONTRATADOS         refcursor;

LN_cod_espec_prod        se_detalles_especificacion_to.cod_espec_prod%TYPE;
LN_cod_perfil_lista      se_detalles_especificacion_to.cod_perfil_lista%TYPE;
LN_cod_prov_serv          se_detalles_especificacion_to.cod_prov_serv%TYPE;
LV_cod_servicio_base     se_detalles_especificacion_to.cod_servicio_base%TYPE;
LV_ind_tipo_servicio     se_detalles_especificacion_to.ind_tipo_servicio%TYPE;
LV_tipo_comportamiento   ps_especificaciones_prod_td.tipo_comportamiento%TYPE;
LV_tipo_plataforma          ps_especificaciones_prod_td.tipo_plataforma%TYPE;
LV_tipo_unidad_bonificar se_planes_altamira_td.tipo_unidad_bonificar%TYPE;
LN_can_bonificar         se_planes_altamira_td.can_bonificar%TYPE;
LV_DESESTADO       VARCHAR2(2000);  -- INC198495 JLGR
LV_INFO_REG          VARCHAR2(2000);      -- INC198495 JLGR
LV_Tabla   VARCHAR2(30);              -- INC198495 JLGR
LNEstado   NUMBER;                 -- INC198495 JLGR
LVCode     VARCHAR2(2000);            -- INC198495 JLGR
LVErrm     VARCHAR2(2000);           -- INC198495 JLGR

LD_FECHA_ALTA DATE;
LV_USUARIO             ga_abocel.nom_usuarora%TYPE;
BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    --Se obtiene el usuario de la OOSS
    BEGIN
        SELECT usuario
        INTO   LV_USUARIO
        FROM   pv_iorserv
        WHERE  num_os = EN_NUM_PROCESO
        UNION
        SELECT usuario
        FROM   ci_orserv
        WHERE  num_os = EN_NUM_PROCESO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            LV_USUARIO := USER;
    END;


    LD_FECHA_ALTA := TO_DATE(EV_FECHA_ALTA,'DD-MM-YYYY HH24:MI:SS');



    LO_LISTA_CENTRALES := IC_PROVISION_QT();

    --Se prepara estructura para obtener datos del abonado
    LO_ABONADO:= GA_ABONADO_QT(EN_ABONADO_ORIGEN,'','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                        '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                        '','','','','','','','','','');
    --Se Obtienen los datos del abonado
    PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR(LO_ABONADO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
    IF (SN_COD_RETORNO != 0) THEN
        RAISE ERROR_SUBFUNCION;
    END IF;
    --Se obtienen los planes contratados para el cliente, excepto aquellos de los que es solo contratante
    --o solo beneficiario pues se analizan en forma posterior

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM pr_productos_contratados_th producto, pf_productos_ofertados_td ofertado';
    LV_sSql := LV_sSql || ' WHERE producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario = '|| EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario = producto.num_abonado_contratante';
    LV_sSql := LV_sSql || ' AND sysdate BETWEEN producto.fec_inicio_vigencia AND producto.fec_termino_vigencia';
    LV_sSql := LV_sSql || ' AND producto.cod_prod_ofertado = ofertado.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' AND producto.ind_condicion_contratacion in (D, O, B)';
    LV_sSql := LV_sSql || ' AND DECODE (ofertado.tipo_plataforma, ''1'', 3, ''2'', 2, ''3'', 10) = '||LO_ABONADO.COD_USO;

OPEN C_PRO_CONTRATADOS FOR
SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
    FROM   pr_productos_contratados_th producto, pf_productos_ofertados_td ofertado
    WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
    AND    producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
    AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante
    AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante
    AND      to_date (sysdate,'DD-MM-YYYY') BETWEEN TO_DATE(producto.fec_inicio_vigencia, 'DD-MM-YYYY') AND NVL(producto.fec_termino_vigencia,TO_DATE('31-12-3000','DD-MM-YYYY'))
    AND       producto.cod_prod_ofertado = ofertado.cod_prod_ofertado
    AND     producto.ind_condicion_contratacion in ('D', 'O', 'B')
    AND       DECODE (ofertado.tipo_plataforma, '1', 3, '2', 2, '3', 10) = LO_ABONADO.COD_USO;

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO   LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        --Se buscan los datos necesarios para contratar productos



        SELECT servicio.cod_espec_prod, servicio.cod_perfil_lista, servicio.cod_prov_serv, servicio.cod_servicio_base,
               servicio.ind_tipo_servicio, espec.tipo_comportamiento, espec.tipo_plataforma
        INTO   LN_cod_espec_prod, LN_cod_perfil_lista, LN_cod_prov_serv, LV_cod_servicio_base,
               LV_ind_tipo_servicio, LV_tipo_comportamiento, LV_tipo_plataforma
        FROM   pf_productos_ofertados_td ofertado, ps_especificaciones_prod_td espec, se_detalles_especificacion_to servicio
        WHERE  ofertado.cod_espec_prod = espec.cod_espec_prod
        AND       ofertado.cod_espec_prod = servicio.cod_espec_prod
        AND       ofertado.cod_prod_ofertado = LN_COD_PROD_OFERTADO;


        IF (LV_ind_tipo_servicio = 'AA') THEN

            SELECT altamira.tipo_unidad_bonificar, altamira.can_bonificar
            INTO   LV_tipo_unidad_bonificar, LN_can_bonificar
            FROM   se_planes_altamira_td altamira
            WHERE  altamira.cod_plan_altamira = LV_cod_servicio_base;
        ELSE
            LV_tipo_unidad_bonificar := '0';
            LN_can_bonificar := '0';
        END IF;


/*INICIO BRC - 188867 31-10-2012

        IF (LN_cod_prov_serv IS NOT NULL) THEN
        se quita esta validación ya que al realizar la anulación de baja no vuelve a activar los PA que tengan el campo cod_prov_serv según tabla se_detalles_especificacion_to
        FIN BRC - 188867 31-10-2012*/
        --ini INC198495 JLGR
        LV_DESESTADO := 'PV_PLANES_ADICIONALES_PG.pv_agrega_fn('  ;
        LV_DESESTADO := LV_DESESTADO || EN_CLIENTE_ORIGEN || ',';
        LV_DESESTADO := LV_DESESTADO || EN_ABONADO_ORIGEN || ',';
        LV_DESESTADO := LV_DESESTADO || LN_COD_PROD_OFERTADO || ',';
        LV_DESESTADO := LV_DESESTADO || SYSDATE || ',';
        LV_DESESTADO := LV_DESESTADO || '31-12-3000,DD-MM-YYYY,';
        LV_DESESTADO := LV_DESESTADO || '0,';
        LV_DESESTADO := LV_DESESTADO || '1,';
        LV_DESESTADO :=  LV_DESESTADO || EN_NUM_PROCESO || ',';
        LV_DESESTADO :=  LV_DESESTADO || 'PV,D,NULL,N,N';
        LV_DESESTADO :=  LV_DESESTADO || 'SN_Cod_retorno';
        LV_DESESTADO :=  LV_DESESTADO || 'SV_mens_retorno';
        LV_DESESTADO :=  LV_DESESTADO || 'SN_num_evento)';
         --fin INC198495 JLGR
               IF (NOT PV_PLANES_ADICIONALES_PG.pv_agrega_fn(EN_CLIENTE_ORIGEN,
                         EN_ABONADO_ORIGEN,
                         LN_COD_PROD_OFERTADO,
                         SYSDATE,
                         TO_DATE('31-12-3000','DD-MM-YYYY'),
                         0,
                         1,
                         EN_NUM_PROCESO,
                         'PV',
                         'D', --
                         NULL,
                         'N',
                         'N',
                         SN_Cod_retorno,
                         SV_mens_retorno,
                         SN_num_evento)) then

                    if  SN_Cod_retorno <> 0 then
                                           
                        raise ERROR_SUBFUNCION;
                    end if;

            end if;
            /*INICIO BRC - 188867 31-10-2012
        END IF;
            FIN BRC - 188867 31-10-2012*/

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_PROVISION_ABONADO_PR_ALTA', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_PROVISION_ABONADO_PR_ALTA', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' PV_PLANES_ADICIONALES_PG.PV_PROVISION_ABONADO_PR_ALTA', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_PROVISION_ABONADO_PR_ALTA;


END PV_PLANES_ADICIONALES_PG;
/
show errors
