CREATE OR REPLACE PACKAGE BODY pv_suspvolprog_pg
AS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
 <Documentacion TipoDoc = "Package">
    <Elemento
       Nombre = "GA_CONS_EUREKA_PG"
       Fecha modificacion=" "
       Fecha creacion="22-07-2008"
       Programador="Marcelo Godoy S."
       Dise?ador="Marcelo Godoy S."
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>
       <Descripcion></Descripcion>
       <Parametros>
          <Entrada>         </Entrada>
          <Salida>          </Salida>
       </Parametros>
    </Elemento>
 </Documentacion>
 <FECHAMOD></FECHAMOD>
 <AUTORMOD></AUTORMOD>
 <VERSIONMOD> 1.1  </VERSIONMOD>
 <DESCMOD></DESCMOD>
*/

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_upd_fh_eje_iorserv_fn (
      pv_iorserv        IN              pv_iorserv_ot,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

          ssql := ' UPDATE pv_iorserv a'
           || ' SET a.fh_ejecucion = pv_iorserv.fh_ejecucion'
           || ' WHERE a.num_os = '||pv_iorserv.num_os;

      UPDATE pv_iorserv a
         SET a.fh_ejecucion = pv_iorserv.fh_ejecucion
       WHERE a.num_os = pv_iorserv.num_os;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10027';
         sv_mens_retorno := 'Error: no determinado al modificar fecha de ejecución OOSS';
         v_des_error     := 'pv_suspvolprog_pg.pv_upd_fh_eje_iorserv_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_upd_fh_eje_iorserv_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END pv_upd_fh_eje_iorserv_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_obtiene_grupo_tecnologia_fn(
      EV_cod_tecnologia IN           al_tecnologia.cod_tecnologia%TYPE ,
      SV_cod_grupo              OUT NOCOPY   al_tecnologia.cod_grupo%TYPE ,
      SN_cod_retorno    OUT NOCOPY   ge_errores_pg.codError,
      SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
      SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
   )
      RETURN BOOLEAN
   IS
      LV_des_error                                       ge_errores_pg.DesEvent;
      LV_sSql                            ge_errores_pg.vQuery;
      CV_num_version                             CONSTANT VARCHAR2(5) :='1.0';
   BEGIN

      LV_sSql := 'SELECT a.cod_grupo '
              || 'FROM al_tecnologia a '
              || 'WHERE a.cod_tecnologia = ' || EV_cod_tecnologia;

      SELECT a.cod_grupo
        INTO SV_cod_grupo
        FROM AL_TECNOLOGIA a
       WHERE a.cod_tecnologia = EV_cod_tecnologia;

           RETURN TRUE;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         SN_cod_retorno  := 10040;
         SV_mens_retorno := 'Error: al recuperar grupo tecnologico';
         LV_des_error := 'pv_suspvolprog_pg.pv_obtiene_grupo_tecnologia_fn('||EV_cod_tecnologia||'); - ' || SQLERRM;
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,'pv_suspvolprog_pg.pv_obtiene_grupo_tecnologia_fn', LV_sSql, SQLCODE, SV_mens_retorno );
         RETURN FALSE;
     WHEN OTHERS THEN
         SN_cod_retorno  := 10041;
         SV_mens_retorno := 'Error: no determinado al Recuperar grupo tecnologico';
         LV_des_error := 'pv_suspvolprog_pg.pv_obtiene_grupo_tecnologia_fn('||EV_cod_tecnologia||'); - ' || SQLERRM;
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,'pv_suspvolprog_pg.pv_obtiene_grupo_tecnologia_fn', LV_sSql, SQLCODE, SV_mens_retorno );
         RETURN FALSE;

   END  pv_obtiene_grupo_tecnologia_fn;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_parametros_ooss_fn (
      pv_iorserv        IN OUT NOCOPY   pv_iorserv_ot,
      pv_erecorrido     IN OUT NOCOPY   pv_erecorrido_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error     ge_errores_pg.desevent;
      ssql            ge_errores_pg.vquery;
      v_table_name    VARCHAR2 (45);
      n_periodosusp   NUMBER (16);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := ' SELECT descripcion, tip_procesa, cod_modgener'
               || ' FROM ci_tiporserv'
                   || ' WHERE cod_os = '|| pv_iorserv.cod_os;

      SELECT descripcion, tip_procesa, cod_modgener
        INTO pv_iorserv.descripcion, pv_iorserv.tip_procesa, pv_iorserv.cod_modgener
        FROM ci_tiporserv
       WHERE cod_os = pv_iorserv.cod_os;

      ssql := ' SELECT des_estadoc'
               || ' FROM fa_intestadoc'
                   || ' WHERE cod_aplic = ''PVA'''
                   || ' AND cod_estadoc = ' || pv_erecorrido.cod_estado;

      SELECT des_estadoc
        INTO pv_erecorrido.descripcion
        FROM fa_intestadoc
       WHERE cod_aplic = 'PVA' AND cod_estadoc = pv_erecorrido.cod_estado;

      RETURN TRUE;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := '10000';
         sv_mens_retorno := 'Error: al recuperar parámetros OOSS';
         v_des_error     := 'pv_suspvolprog_pg.ga_parametros_ooss_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_parametros_ooss_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno  := '10001';
         sv_mens_retorno := 'Error: no determinado al Recuperar parametros OOSS';
         v_des_error     := 'pv_suspvolprog_pg.ga_parametros_ooss_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_parametros_ooss_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ga_parametros_ooss_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_del_susp_volprog_fn (
      pv_det_suspvolprog   IN OUT NOCOPY   pv_det_suspvolprog_qt,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error     ge_errores_pg.desevent;
      ssql            ge_errores_pg.vquery;
      v_table_name    VARCHAR2 (45);
      n_periodosusp   NUMBER (16);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := 'DELETE pv_det_suspvolprog_to a '
               || 'WHERE a.num_det_sus_vol_prg = '|| pv_det_suspvolprog.num_det_sus_vol_prg;

      DELETE pv_det_suspvolprog_to a
       WHERE a.num_det_sus_vol_prg = pv_det_suspvolprog.num_det_sus_vol_prg;

      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10002';
         sv_mens_retorno := 'Error: no determinado al eliminar suspensión voluntaria';
         v_des_error     := 'pv_suspvolprog_pg.ga_del_susp_volprog_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_del_susp_volprog_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ga_del_susp_volprog_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_rec_susp_volprog_fn (
      pv_det_suspvolprog   IN OUT NOCOPY   pv_det_suspvolprog_qt,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error     ge_errores_pg.desevent;
      ssql            ge_errores_pg.vquery;
      v_table_name    VARCHAR2 (45);
      n_periodosusp   NUMBER (16);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql :=
            'SELECT a.num_abonado, a.num_periodosusp_1, a.num_periodosusp_2,'
         || ' a.fec_solicitud, a.fec_suspension, a.fec_rehabilitacion,'
         || ' a.fec_actualizacion, a.dias_periodosusp_1, a.dias_periodosusp_2,'
         || ' a.estado, a.cod_causal, a.usuario, a.num_os_sus, a.num_os_reh'
         || ' FROM pv_det_suspvolprog_to a'
         || ' WHERE a.num_det_sus_vol_prg ='|| pv_det_suspvolprog.num_det_sus_vol_prg;

      SELECT a.num_abonado, a.num_periodosusp_1, a.num_periodosusp_2, a.fec_solicitud, a.fec_suspension,
             a.fec_rehabilitacion, a.fec_actualizacion, a.dias_periodosusp_1, a.dias_periodosusp_2, a.estado,
             a.cod_causal, a.usuario, a.num_os_sus, a.num_os_reh
        INTO pv_det_suspvolprog.num_abonado, pv_det_suspvolprog.num_periodosusp_1, pv_det_suspvolprog.num_periodosusp_2, pv_det_suspvolprog.fec_solicitud, pv_det_suspvolprog.fec_suspension,
             pv_det_suspvolprog.fec_rehabilitacion, pv_det_suspvolprog.fec_actualizacion, pv_det_suspvolprog.dias_periodosusp_1, pv_det_suspvolprog.dias_periodosusp_2, pv_det_suspvolprog.estado,
             pv_det_suspvolprog.cod_causal, pv_det_suspvolprog.usuario, pv_det_suspvolprog.num_os_sus, pv_det_suspvolprog.num_os_reh
        FROM pv_det_suspvolprog_to a
       WHERE a.num_det_sus_vol_prg = pv_det_suspvolprog.num_det_sus_vol_prg;

      RETURN TRUE;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := '10003';
         sv_mens_retorno := 'Error: al recuperar suspensión voluntaria';
         v_des_error     := 'pv_suspvolprog_pg.ga_rec_susp_volprog_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_rec_susp_volprog_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno  := '10004';
         sv_mens_retorno := 'Error: no determinado al recuperar suspensión voluntaria';
         v_des_error     := 'pv_suspvolprog_pg.ga_rec_susp_volprog_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_rec_susp_volprog_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ga_rec_susp_volprog_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_rec_utl_periodo_fn (
      en_num_abonado    IN              pv_suspvolprog_to.num_abonado%TYPE,
      sn_num_periodo    OUT NOCOPY      pv_suspvolprog_to.num_periodosusp%TYPE,
      sd_fec_inicio     OUT NOCOPY      DATE,
      sd_fec_fin        OUT NOCOPY      DATE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error     ge_errores_pg.desevent;
      ssql            ge_errores_pg.vquery;
      v_table_name    VARCHAR2 (45);
      n_periodosusp   NUMBER (16);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := 'SELECT MAX (a.num_periodosusp), a.fec_inicio, a.fec_fin'
               || '  FROM pv_suspvolprog_to a'
                   || ' WHERE a.num_abonado =' || en_num_abonado;

      SELECT a.num_periodosusp, a.fec_inicio, a.fec_fin
        INTO sn_num_periodo, sd_fec_inicio, sd_fec_fin
        FROM pv_suspvolprog_to a
       WHERE a.num_abonado = en_num_abonado
         AND a.num_periodosusp = (SELECT MAX (b.num_periodosusp)
                                    FROM pv_suspvolprog_to b
                                   WHERE b.num_abonado = en_num_abonado);

      RETURN TRUE;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RETURN TRUE;
      WHEN OTHERS THEN
         sn_cod_retorno  := '10005';
         sv_mens_retorno := 'Error: no determinado al Recuperar último periodo de suspensión de abonado';
         v_des_error     := 'pv_suspvolprog_pg.ga_rec_utl_periodo_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_rec_utl_periodo_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ga_rec_utl_periodo_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_cal_dias_suspension_fn (
      en_num_abonado        IN              pv_suspvolprog_to.num_abonado%TYPE,
      en_num_periodosusp1   IN              pv_det_suspvolprog_to.num_periodosusp_1%TYPE,
      en_num_periodosusp2   IN              pv_det_suspvolprog_to.num_periodosusp_1%TYPE,
      ed_fec_inicio         IN              DATE,
      ed_fec_fin            IN              DATE,
      sn_can_dias_1         OUT NOCOPY      NUMBER,
      sn_can_dias_2         OUT NOCOPY      NUMBER,
      sn_cod_retorno        OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno       OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error     ge_errores_pg.desevent;
      ssql            ge_errores_pg.vquery;
      v_table_name    VARCHAR2 (45);
      n_periodosusp   NUMBER (16);
   BEGIN
      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      IF en_num_periodosusp1 <> en_num_periodosusp2 THEN
         ssql := 'SELECT a.fec_fin - ed_fec_inicio'
                      || ' FROM pv_suspvolprog_to a'
                          || ' WHERE a.num_periodosusp = ' || en_num_periodosusp1
                          || ' AND a.num_abonado = ' || en_num_abonado;

         SELECT a.fec_fin - ed_fec_inicio
           INTO sn_can_dias_1
           FROM pv_suspvolprog_to a
          WHERE a.num_periodosusp = en_num_periodosusp1 AND a.num_abonado = en_num_abonado;

         ssql := 'SELECT SELECT ed_dec_fin - a.fec_inicio'
                      || ' FROM pv_suspvolprog_to a'
                          || ' WHERE a.num_periodosusp = ' || en_num_periodosusp2
                          || ' AND a.num_abonado = ' || en_num_abonado;

         SELECT ed_fec_fin - a.fec_inicio
           INTO sn_can_dias_2
           FROM pv_suspvolprog_to a
          WHERE a.num_periodosusp = en_num_periodosusp2 AND a.num_abonado = en_num_abonado;

         sn_can_dias_1 := sn_can_dias_1+1;
         sn_can_dias_2 := sn_can_dias_2;
      ELSE
         sn_can_dias_1 := ed_fec_fin - ed_fec_inicio;
                 sn_can_dias_2 := 0;
      END IF;

      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RETURN TRUE;
      WHEN OTHERS THEN
         sn_cod_retorno  := '10006';
         sv_mens_retorno := 'Error: no determinado al calcular días de suspensión';
         v_des_error     := 'pv_suspvolprog_pg.ga_cal_dias_suspension_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_cal_dias_suspension_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ga_cal_dias_suspension_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_val_fecha_suspension_fn (
      en_num_abonado       IN              pv_suspvolprog_to.num_abonado%TYPE,
      ed_fec_validar       IN              pv_suspvolprog_to.fec_inicio%TYPE,
      sn_num_periodosusp   OUT NOCOPY      pv_suspvolprog_to.dias_acum%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error     ge_errores_pg.desevent;
      ssql            ge_errores_pg.vquery;
      v_table_name    VARCHAR2 (45);
      n_periodosusp   NUMBER (16);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := ' SELECT num_periodosusp'
               || ' FROM pv_suspvolprog_to a'
                   || ' WHERE a.num_abonado = ' || en_num_abonado
                   || ' AND a.fec_inicio <= ' || ed_fec_validar
                   || ' AND a.fec_fin >= ' || ed_fec_validar;

      SELECT num_periodosusp
        INTO sn_num_periodosusp
        FROM pv_suspvolprog_to a
       WHERE a.num_abonado = en_num_abonado
             AND a.fec_inicio <= ed_fec_validar
                 AND a.fec_fin >= ed_fec_validar;

      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RETURN TRUE;
      WHEN OTHERS THEN
         sn_cod_retorno  := '10007';
         sv_mens_retorno := 'Error: no determinado al validar fechas de suspensión';
         v_des_error     := 'pv_suspvolprog_pg.ga_val_fecha_suspension_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_val_fecha_suspension_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ga_val_fecha_suspension_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_ins_periodo_suspension_fn (
      en_num_periodosusp   IN              pv_suspvolprog_to.num_periodosusp%TYPE,
      en_num_abonado       IN              pv_suspvolprog_to.num_abonado%TYPE,
      en_cod_cliente       IN              pv_suspvolprog_to.cod_cliente%TYPE,
      ed_fec_inicio        IN              pv_suspvolprog_to.fec_inicio%TYPE,
      ed_fec_fin           IN              pv_suspvolprog_to.fec_fin%TYPE,
      en_dias_acum         IN              pv_suspvolprog_to.dias_acum%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := 'INSERT INTO pv_suspvolprog_to'
           || ' (num_periodosusp, num_abonado, cod_cliente, fec_inicio, fec_fin, dias_acum)'
           || ' VALUES ('||en_num_periodosusp||', '|| en_num_abonado||', '||en_cod_cliente||', '|| ed_fec_inicio||', '||ed_fec_fin||', '||en_dias_acum
           || ')';

      INSERT INTO pv_suspvolprog_to
                  (num_periodosusp, num_abonado, cod_cliente, fec_inicio, fec_fin, dias_acum
                  )
           VALUES (en_num_periodosusp, en_num_abonado, en_cod_cliente, ed_fec_inicio, ed_fec_fin, en_dias_acum
                  );

      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10008';
         sv_mens_retorno := 'Error: no determinado al registrar periodo de suspensión';
         v_des_error     := 'pv_suspvolprog_pg.ga_ins_periodo_suspension_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_ins_periodo_suspension_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ga_ins_periodo_suspension_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_cat_plan_tarif_fn (
      eso_catplantarif   IN OUT NOCOPY   ve_catplantarif_qt,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error    ge_errores_pg.desevent;
      ssql           ge_errores_pg.vquery;
      v_table_name   VARCHAR2 (45);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

          ssql := 'SELECT cod_categoria, cod_producto, cod_plantarif, nom_usuario, fec_efectividad,fec_finefectividad'
           || ' FROM ve_catplantarif'
           || ' WHERE cod_plantarif =  '||eso_catplantarif.cod_plantarif
               || ' AND fec_efectividad <= '||SYSDATE
                   || ' AND NVL (fec_finefectividad, '||SYSDATE||')>= '||SYSDATE;

      SELECT cod_categoria, cod_producto, cod_plantarif, nom_usuario, fec_efectividad, fec_finefectividad
        INTO eso_catplantarif.cod_categoria, eso_catplantarif.cod_producto, eso_catplantarif.cod_plantarif, eso_catplantarif.nom_usuario, eso_catplantarif.fec_efectividad,
             eso_catplantarif.fec_finefectividad
        FROM ve_catplantarif
       WHERE cod_plantarif = eso_catplantarif.cod_plantarif
             AND fec_efectividad <= SYSDATE
                 AND NVL (fec_finefectividad, SYSDATE) >= SYSDATE;

      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := '10009';
         sv_mens_retorno := 'Error: al recuperar categoría de plan tarifario';
         v_des_error     := 'pv_suspvolprog_pg.pv_rec_cat_plan_tarif_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_rec_cat_plan_tarif_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno  := '10010';
         sv_mens_retorno := 'Error: no determinado al recuperar categoría de plan tarifario';
         v_des_error     := 'pv_suspvolprog_pg.pv_rec_cat_plan_tarif_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_rec_cat_plan_tarif_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END pv_rec_cat_plan_tarif_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_info_abonado_fn (
      seo_dat_abo       IN OUT NOCOPY   pv_abo_sus_vol_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error       ge_errores_pg.desevent;
      v_ssql            ge_errores_pg.vquery;
      eso_catplantarif   ve_catplantarif_qt     := NEW ve_catplantarif_qt;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      v_ssql := ' SELECT b.nom_usuario,b.nom_apellido1,b.nom_apellido2,c.des_equipo,c.num_serie,'
             || ' DECODE (c.ind_procequi,''I'',''INTERNO'',''E'',''EXTERNO'',''S'',''SUBSIDIADO'') AS des_procequi,'
             || ' f.des_terminal,d.des_modventa,c.num_seriemec,DECODE (c.ind_propiedad,''C'',''CLIENTE'','
             || ' ''E'', ''EMPRESA'') AS ind_propiedad,e.des_uso,c.ind_procequi,d.ind_cuotas,d.cod_modventa,'
             || ' g.des_tipcontrato,h.cod_tiplan,a.num_imei,g.cod_tipcontrato,a.cod_plantarif,a.num_contrato,'
             || ' a.num_anexo,a.cod_region,a.cod_provincia,a.cod_ciudad,a.cod_cliente,'
             || ' a.num_celular,a.cod_tecnologia,a.fec_alta,a.tip_plantarif,a.tip_terminal,a.cod_situacion,'
             || ' i.des_situacion,a.cod_central,a.cod_ciclo,a.cod_planserv,''C'',a.cod_uso,'
             || ' a.num_seriehex,a.num_min,a.cod_cargobasico,a.cod_producto,c.cod_articulo'
             || ' FROM ga_abocel a, ga_usuarios b, ga_equipaboser c, ge_modventa d, al_usos e, al_tipos_terminales f,'
             || ' ga_tipcontrato g, ta_plantarif h'
             || ' WHERE a.num_abonado = '|| seo_dat_abo.num_abonado
             || ' AND b.cod_usuario = a.cod_usuario'
             || ' AND c.num_abonado = a.num_abonado'
             || ' AND (c.ind_equiacc = ''E'' OR c.ind_equiacc IS NULL)'
             || ' AND c.fec_alta = (SELECT MAX (fec_alta)'
             || ' FROM ga_equipaboser'
             || ' WHERE num_abonado = '|| seo_dat_abo.num_abonado
             || ' AND (ind_equiacc = ''E'' OR ind_equiacc IS NULL) AND'
             || ' tip_terminal <> ''G'')'
             || ' AND c.tip_terminal <> ''G'''
             || ' AND d.cod_modventa(+) = c.cod_modventa'
             || ' AND e.cod_uso = c.cod_uso'
             || ' AND f.cod_producto = '|| cv_prod_celular
             || ' AND f.tip_terminal = c.tip_terminal'
             || ' AND g.cod_producto = '|| cv_prod_celular
             || ' AND g.cod_tipcontrato = a.cod_tipcontrato'
             || ' AND h.cod_plantarif = a.cod_plantarif'
             || ' AND i.cod_situacion = a.cod_situacion'
             || ' UNION'
             || ' SELECT b.nom_usuario,b.nom_apellido1,b.nom_apellido2,c.des_equipo,c.num_serie,'
             || ' DECODE (c.ind_procequi,''I'',''INTERNO'',''E'',''EXTERNO'',''S'',''SUBSIDIADO'') AS des_procequi,'
             || ' f.des_terminal,d.des_modventa,c.num_seriemec,DECODE (c.ind_propiedad,''C'',''CLIENTE'','
             || ' ''E'', ''EMPRESA'') AS ind_propiedad, e.des_uso, c.ind_procequi, d.ind_cuotas, d.cod_modventa,'
             || ' g.des_tipcontrato,h.cod_tiplan,a.num_imei,g.cod_tipcontrato,a.cod_plantarif,a.num_contrato,'
             || ' a.num_anexo,a.cod_region,a.cod_provincia,a.cod_ciudad,a.cod_cliente,'
             || ' a.num_celular,a.cod_tecnologia,a.fec_alta,a.tip_plantarif,a.tip_terminal,a.cod_situacion,'
             || ' i.des_situacion,a.cod_central,a.cod_ciclo,a.cod_planserv,''C'',a.cod_uso,'
             || ' a.num_seriehex,a.num_min,a.cod_cargobasico,a.cod_producto,c.cod_articulo'
             || ' FROM ga_aboamist a, ga_usuarios b, ga_equipaboser c, ge_modventa d, al_usos e, al_tipos_terminales f,'
             || ' ga_tipcontrato g, ta_plantarif h'
             || ' WHERE a.num_abonado = '|| seo_dat_abo.num_abonado
             || ' AND b.cod_usuario = a.cod_usuario'
             || ' AND c.num_abonado = a.num_abonado'
             || ' AND (c.ind_equiacc = ''E'' OR c.ind_equiacc IS NULL)'
             || ' AND c.fec_alta = (SELECT MAX (fec_alta)'
             || ' FROM ga_equipaboser'
             || ' WHERE num_abonado = '|| seo_dat_abo.num_abonado
             || ' AND (ind_equiacc = ''E'' OR ind_equiacc IS NULL) AND'
             || ' tip_terminal <> ''G'')'
             || ' AND c.tip_terminal <> ''G'''
             || ' AND d.cod_modventa(+) = c.cod_modventa'
             || ' AND e.cod_uso = c.cod_uso'
             || ' AND f.cod_producto = '|| cv_prod_celular
             || ' AND f.tip_terminal = c.tip_terminal'
             || ' AND g.cod_producto = '|| cv_prod_celular
             || ' AND g.cod_tipcontrato = a.cod_tipcontrato'
             || ' AND h.cod_plantarif = a.cod_plantarif'
             || ' AND i.cod_situacion = a.cod_situacion';

      SELECT b.nom_usuario, b.nom_apellido1, b.nom_apellido2, c.des_equipo, a.num_serie, DECODE (c.ind_procequi, 'I', 'INTERNO', 'E', 'EXTERNO', 'S', 'SUBSIDIADO') AS des_procequi, f.des_terminal,
             d.des_modventa, c.num_seriemec, DECODE (c.ind_propiedad, 'C', 'CLIENTE', 'E', 'EMPRESA') AS ind_propiedad, e.des_uso, c.ind_procequi, d.ind_cuotas, d.cod_modventa,
             g.des_tipcontrato, h.cod_tiplan, a.num_imei, g.cod_tipcontrato, a.cod_plantarif, a.num_contrato, a.num_anexo,
             a.cod_region, a.cod_provincia, a.cod_ciudad, a.cod_cliente, a.num_celular, a.cod_tecnologia, a.fec_alta,
             a.tip_plantarif, a.tip_terminal, a.cod_situacion, i.des_situacion, a.cod_central, a.cod_ciclo, a.cod_planserv,
             'C', a.cod_uso, a.num_seriehex, a.num_min, a.cod_cargobasico, a.cod_producto, c.cod_articulo,
             a.cod_cuenta
        INTO seo_dat_abo.nom_usuario, seo_dat_abo.nom_apellido1, seo_dat_abo.nom_apellido2, seo_dat_abo.des_equipo, seo_dat_abo.num_serie, seo_dat_abo.des_procequi, seo_dat_abo.des_terminal,
             seo_dat_abo.des_modventa, seo_dat_abo.num_seriemec, seo_dat_abo.ind_propiedad, seo_dat_abo.des_uso, seo_dat_abo.ind_procequi, seo_dat_abo.ind_cuotas, seo_dat_abo.cod_modventa,
             seo_dat_abo.des_tipcontrato, seo_dat_abo.cod_tiplan, seo_dat_abo.num_imei, seo_dat_abo.cod_tipcontrato, seo_dat_abo.cod_plantarif, seo_dat_abo.num_contrato, seo_dat_abo.num_anexo,
             seo_dat_abo.cod_region, seo_dat_abo.cod_provincia, seo_dat_abo.cod_ciudad, seo_dat_abo.cod_cliente, seo_dat_abo.num_celular, seo_dat_abo.cod_tecnologia, seo_dat_abo.fec_alta,
             seo_dat_abo.tip_plantarif, seo_dat_abo.tip_terminal, seo_dat_abo.cod_situacion, seo_dat_abo.des_situacion, seo_dat_abo.cod_central, seo_dat_abo.cod_ciclo, seo_dat_abo.cod_planserv,
             seo_dat_abo.des_origen, seo_dat_abo.cod_uso, seo_dat_abo.num_seriehex, seo_dat_abo.num_min, seo_dat_abo.cod_cargobasico, seo_dat_abo.cod_producto, seo_dat_abo.cod_articulo,
             seo_dat_abo.cod_cuenta
        FROM ga_abocel a, ga_usuarios b, ga_equipaboser c, ge_modventa d, al_usos e, al_tipos_terminales f, ga_tipcontrato g, ta_plantarif h, ga_situabo i
       WHERE a.num_abonado = seo_dat_abo.num_abonado
         AND b.cod_usuario = a.cod_usuario
         AND c.num_abonado = a.num_abonado
         AND (c.ind_equiacc = 'E' OR c.ind_equiacc IS NULL)
         AND c.fec_alta = (SELECT MAX (fec_alta)
                             FROM ga_equipaboser
                            WHERE num_abonado = seo_dat_abo.num_abonado AND (ind_equiacc = 'E' OR ind_equiacc IS NULL) AND tip_terminal <> 'G')
         AND c.tip_terminal <> 'G'
         AND d.cod_modventa(+) = c.cod_modventa
         AND e.cod_uso = a.cod_uso
         AND f.cod_producto = cv_prod_celular
         AND f.tip_terminal = c.tip_terminal
         AND g.cod_producto = cv_prod_celular
         AND g.cod_tipcontrato = a.cod_tipcontrato
         AND h.cod_plantarif = a.cod_plantarif
         AND i.cod_situacion = a.cod_situacion
      UNION
      SELECT b.nom_usuario, b.nom_apellido1, b.nom_apellido2, c.des_equipo, a.num_serie, DECODE (c.ind_procequi, 'I', 'INTERNO', 'E', 'EXTERNO', 'S', 'SUBSIDIADO') AS des_procequi, f.des_terminal,
             d.des_modventa, c.num_seriemec, DECODE (c.ind_propiedad, 'C', 'CLIENTE', 'E', 'EMPRESA') AS ind_propiedad, e.des_uso, c.ind_procequi, d.ind_cuotas, d.cod_modventa, g.des_tipcontrato,
             h.cod_tiplan, a.num_imei, g.cod_tipcontrato, a.cod_plantarif, a.num_contrato, a.num_anexo, a.cod_region, a.cod_provincia, a.cod_ciudad, a.cod_cliente, a.num_celular, a.cod_tecnologia,
             a.fec_alta, a.tip_plantarif, a.tip_terminal, a.cod_situacion, i.des_situacion, a.cod_central, a.cod_ciclo, a.cod_planserv, 'P', a.cod_uso, a.num_seriehex, a.num_min, a.cod_cargobasico,
             a.cod_producto, c.cod_articulo, a.cod_cuenta
        FROM ga_aboamist a, ga_usuamist b, ga_equipaboser c, ge_modventa d, al_usos e, al_tipos_terminales f, ga_tipcontrato g, ta_plantarif h, ga_situabo i
       WHERE a.num_abonado = seo_dat_abo.num_abonado
         AND b.cod_usuario = a.cod_usuario
         AND c.num_abonado = a.num_abonado
         AND (c.ind_equiacc = 'E' OR c.ind_equiacc IS NULL)
         AND c.fec_alta = (SELECT MAX (fec_alta)
                             FROM ga_equipaboser
                            WHERE num_abonado = seo_dat_abo.num_abonado AND (ind_equiacc = 'E' OR ind_equiacc IS NULL) AND tip_terminal <> 'G')
         AND c.tip_terminal <> 'G'
         AND d.cod_modventa(+) = c.cod_modventa
         AND e.cod_uso = a.cod_uso
         AND f.cod_producto = cv_prod_celular
         AND f.tip_terminal = c.tip_terminal
         AND g.cod_producto = cv_prod_celular
         AND g.cod_tipcontrato = a.cod_tipcontrato
         AND h.cod_plantarif = a.cod_plantarif
         AND i.cod_situacion = a.cod_situacion;

      eso_catplantarif.cod_plantarif := seo_dat_abo.cod_plantarif;

      IF NOT (pv_rec_cat_plan_tarif_fn (eso_catplantarif, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
         sn_cod_retorno := 0;
         sv_mens_retorno := NULL;
         sn_num_evento := 0;
      ELSE
         eso_catplantarif.cod_categoria := eso_catplantarif.cod_categoria;
      END IF;

      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := '10011';
         sv_mens_retorno := 'Error: al recuperar información de abonado';
         v_des_error     := 'pv_suspvolprog_pg.pv_rec_info_abonado_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_rec_info_abonado_fn', v_ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno  := '10012';
         sv_mens_retorno := 'Error: no determinado al recuperar información de abonado';
         v_des_error     := 'pv_suspvolprog_pg.pv_rec_info_abonado_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_rec_info_abonado_fn', v_ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END pv_rec_info_abonado_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_obtiene_ged_parametros_fn (
      ev_nom_parametro   IN              ged_parametros.nom_parametro%TYPE,
      ev_cod_modulo      IN              ged_parametros.cod_modulo%TYPE,
      sv_val_parametro   OUT NOCOPY      ged_parametros.val_parametro%TYPE,
      sv_des_parametro   OUT NOCOPY      ged_parametros.des_parametro%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error    ge_errores_pg.desevent;
      ssql           ge_errores_pg.vquery;
      v_table_name   VARCHAR2 (45);
      n_cantidad     NUMBER;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := 'SELECT VAL_PARAMETRO,DES_PARAMETRO FROM  GED_PARAMETROS  ';
      ssql := ssql || ' WHERE NOM_PARAMETRO = ' || ev_nom_parametro || ' ';
      ssql := ssql || ' AND      COD_MODULO    = ' || ev_cod_modulo || ' ';

      SELECT val_parametro, des_parametro
        INTO sv_val_parametro, sv_des_parametro
        FROM ged_parametros
       WHERE nom_parametro = ev_nom_parametro
             AND cod_modulo = ev_cod_modulo
                 AND cod_producto = cv_prod_celular;

      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := '10013';
         sv_mens_retorno := 'Error: al recuperar parametros';
         v_des_error     := 'pv_suspvolprog_pg.pv_obtiene_ged_parametros_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_obtiene_ged_parametros_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno  := '10014';
         sv_mens_retorno := 'Error: no determinado al recuperar parametros';
         v_des_error     := 'pv_suspvolprog_pg.pv_obtiene_ged_parametros_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_obtiene_ged_parametros_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END pv_obtiene_ged_parametros_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_rec_causa_suspension_pr (
      sc_resultado      OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   )
   AS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := 'SELECT a.num_periodosusp, a.num_abonado, a.cod_cliente, a.fec_inicio, a.fec_fin, a.dias_acum'
               || ' FROM pv_suspvolprog_to a'
                   || ' WHERE a.fec_fin >= ' || SYSDATE
                   || ' AND a.num_abonado = ';

        OPEN sc_resultado FOR
      SELECT cod_caususp, des_caususp
        FROM ga_caususp
       WHERE cod_producto = 1
             AND cod_modulo = 'GA'
                 AND ind_suspension = 1
                 AND cod_suspreha IS NOT NULL;

   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10015';
         sv_mens_retorno := 'Error: no determinado al Recuperar causas de suspensión';
         v_des_error     := 'pv_suspvolprog_pg.ga_rec_causa_suspension_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_rec_causa_suspension_pr', ssql, SQLCODE, v_des_error);
   END ga_rec_causa_suspension_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_cons_hist_suspension_vol_pr (
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      ed_fec_inicio     IN              DATE,
      ed_fec_fin        IN              DATE,
      sc_resultado      OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   AS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := '0';
      sn_num_evento := 0;
      sv_mens_retorno := '0';

      ssql := 'SELECT num_det_sus_vol_prg,num_abonado,num_periodosusp_1,num_periodosusp_2,fec_solicitud,fec_suspension,'
               || ' fec_rehabilitacion,fec_actualizacion,dias_periodosusp_1,dias_periodosusp_2,estado,cod_causal,'
                   || ' b.des_caususp,usuario,num_os_sus,num_os_reh'
           || ' FROM pv_det_suspvolprog_to a'
           || ' WHERE a.num_abonado = '|| en_num_abonado
           || ' AND a.fec_suspension >= '|| ed_fec_inicio
           || ' AND a.fec_suspension <= '|| NVL (ed_fec_fin, SYSDATE);

        OPEN sc_resultado FOR
      SELECT num_det_sus_vol_prg,num_abonado,num_periodosusp_1,num_periodosusp_2,fec_solicitud,fec_suspension,
                 fec_rehabilitacion,fec_actualizacion,dias_periodosusp_1,dias_periodosusp_2,estado,cod_causal,
                         b.des_caususp,usuario,num_os_sus,num_os_reh
        FROM pv_det_suspvolprog_to a, ga_caususp b
       WHERE a.num_abonado = en_num_abonado
             AND a.cod_causal = b.cod_caususp
                 AND b.cod_modulo = 'GA'
                 ANd b.cod_producto = 1
         AND trunc(a.fec_suspension) >= trunc(ed_fec_inicio)
         AND trunc(a.fec_suspension) <= trunc(NVL(ed_fec_fin, SYSDATE));

   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10016';
         sv_mens_retorno := 'Error: no determinado al recuperar histórico de suspensión';
         v_des_error     := 'pv_suspvolprog_pg.ga_cons_hist_suspension_vol_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_cons_hist_suspension_vol_pr', ssql, SQLCODE, v_des_error);
   END ga_cons_hist_suspension_vol_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_rec_periodo_suspension_pr (
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      sc_resultado      OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   AS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := 'SELECT a.num_periodosusp, a.num_abonado, a.cod_cliente, a.fec_inicio, a.fec_fin, a.dias_acum'
           || ' FROM pv_suspvolprog_to a'
           || ' WHERE a.fec_fin >= '||SYSDATE
           || ' AND a.num_abonado = '||en_num_abonado;

        OPEN sc_resultado FOR
      SELECT a.num_periodosusp, a.num_abonado, a.cod_cliente, a.fec_inicio, a.fec_fin, a.dias_acum
        FROM pv_suspvolprog_to a
       WHERE a.fec_fin >= SYSDATE
             AND a.num_abonado = en_num_abonado;

   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10017';
         sv_mens_retorno := 'Error: no determinado al recuperar periodos de suspensión';
         v_des_error     := 'pv_suspvolprog_pg.ga_rec_periodo_suspension_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_rec_periodo_suspension_pr', ssql, SQLCODE, v_des_error);
   END ga_rec_periodo_suspension_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_rec_cant_periodo_susp_fn (
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      cant_periodo      OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   AS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := 'SELECT count(1)'
               || ' FROM pv_suspvolprog_to a'
                   || ' WHERE a.num_abonado = ' || en_num_abonado;

      SELECT COUNT (1)
        INTO cant_periodo
        FROM pv_suspvolprog_to a
       WHERE a.num_abonado = en_num_abonado;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10018';
         sv_mens_retorno := 'Error: no determinado al recuperar cantidad de periodos';
         v_des_error     := 'pv_suspvolprog_pg.ga_rec_cant_periodo_susp_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_rec_cant_periodo_susp_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ga_rec_cant_periodo_susp_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_ins_periodo_suspension_pr (
      en_num_abonado    IN              pv_suspvolprog_to.num_abonado%TYPE,
      ed_fec_inicio     IN              pv_suspvolprog_to.fec_inicio%TYPE,
      ed_fec_fin        IN              pv_suspvolprog_to.fec_fin%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   AS
      v_des_error       ge_errores_pg.desevent;
      ssql              ge_errores_pg.vquery;
      n_periodosusp     NUMBER (16);
      cant_periodo      NUMBER;
      error_ejecucion   EXCEPTION;
      o_dat_abo         pv_abo_sus_vol_qt      := NEW pv_abo_sus_vol_qt ();
      d_fec_inicio      DATE;
      d_fec_fin         DATE;
      n_dias_acum       NUMBER;
      n_num_periodo     NUMBER;
          cantperiodos      NUMBER :=0;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';
      n_dias_acum     := 0;

      IF NOT (ga_rec_cant_periodo_susp_fn (en_num_abonado, cant_periodo, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      o_dat_abo.num_abonado := en_num_abonado;
      IF NOT (pv_rec_info_abonado_fn (o_dat_abo, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      IF (cant_periodo = 0) THEN

         d_fec_inicio := TO_DATE(TO_CHAR(o_dat_abo.fec_alta,'DD-MM') || '-' || TO_CHAR(TO_NUMBER(TO_CHAR (SYSDATE, 'YYYY'))-1),'DD-MM-YYYY');
         d_fec_fin := ADD_MONTHS (TRUNC (d_fec_inicio), 12) - 1;

         FOR i IN 1 ..2 LOOP
            IF NOT (ga_ins_periodo_suspension_fn (i, en_num_abonado, o_dat_abo.cod_cliente, d_fec_inicio, d_fec_fin, n_dias_acum, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
               RAISE error_ejecucion;
            END IF;

            d_fec_inicio := d_fec_fin + 1;
            d_fec_fin := ADD_MONTHS (TRUNC (d_fec_inicio), 12) - 1;
         END LOOP;
      ELSE
         IF NOT (ga_rec_utl_periodo_fn (en_num_abonado, n_num_periodo, d_fec_inicio, d_fec_fin, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
         END IF;

         cantperiodos := TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY') - TO_CHAR (d_fec_inicio, 'YYYY')) + 1;
         d_fec_inicio := TRUNC (d_fec_fin + 1);
         d_fec_fin := ADD_MONTHS (TRUNC (d_fec_inicio), 12) - 1;

         FOR i IN (n_num_periodo + 1) .. (n_num_periodo + cantperiodos) LOOP
            IF NOT (ga_ins_periodo_suspension_fn (i, en_num_abonado, o_dat_abo.cod_cliente, d_fec_inicio, d_fec_fin, n_dias_acum, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
               RAISE error_ejecucion;
            END IF;
            d_fec_inicio := d_fec_fin + 1;
            d_fec_fin := ADD_MONTHS (TRUNC (d_fec_inicio), 12) - 1;
         END LOOP;
      END IF;



   EXCEPTION
      WHEN error_ejecucion THEN
         v_des_error     := 'pv_suspvolprog_pg.ga_ins_periodo_suspension_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_ins_periodo_suspension_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno  := '10019';
         sv_mens_retorno := 'Error: no determinado al registrar periodos de suspensión';
         v_des_error     := 'pv_suspvolprog_pg.ga_ins_periodo_suspension_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_ins_periodo_suspension_pr', ssql, SQLCODE, v_des_error);
   END ga_ins_periodo_suspension_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_upd_diasacum_suspension_fn (
      en_num_periodosusp   IN              pv_suspvolprog_to.num_periodosusp%TYPE,
      en_num_abonado       IN              pv_suspvolprog_to.num_abonado%TYPE,
      en_dias_acum         IN              pv_suspvolprog_to.dias_acum%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
          LN_dias_acum   NUMBER;
          LN_num_periodo NUMBER;
          LV_fec_inicio  pv_suspvolprog_to.fec_inicio%TYPE;
          LV_fec_fin     pv_suspvolprog_to.fec_fin%TYPE;
          error_ejecucion   EXCEPTION;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';
          LN_dias_acum    := 0;

          ssql := 'UPDATE pv_suspvolprog_to a'
               || ' SET a.dias_acum = ' || en_dias_acum
                   || ' WHERE a.num_periodosusp = '|| en_num_periodosusp;

      UPDATE pv_suspvolprog_to a
         SET a.dias_acum = (a.dias_acum + en_dias_acum)
       WHERE a.num_periodosusp = en_num_periodosusp
           AND a.num_abonado = en_num_abonado;


      RETURN TRUE;
   EXCEPTION
      WHEN error_ejecucion THEN
         v_des_error     := 'pv_suspvolprog_pg.ga_upd_diasacum_suspension_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_ins_periodo_suspension_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno  := '10020';
         sv_mens_retorno := 'Error: no determinado al modificar días acumulados periodo de suspensión';
         v_des_error     := 'pv_suspvolprog_pg.ga_upd_diasacum_suspension_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_upd_diasacum_suspension_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ga_upd_diasacum_suspension_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_ins_suspension_prg_pr (
      en_num_abonado          IN              pv_det_suspvolprog_to.num_abonado%TYPE,
      ed_fec_suspension       IN OUT NOCOPY   pv_det_suspvolprog_to.fec_suspension%TYPE,
      ed_fec_rehabilitacion   IN OUT NOCOPY   pv_det_suspvolprog_to.fec_rehabilitacion%TYPE,
      ev_causal               IN              pv_det_suspvolprog_to.cod_causal%TYPE,
      ev_usuario              IN              pv_det_suspvolprog_to.usuario%TYPE,
      num_os_sus              IN              pv_det_suspvolprog_to.num_os_sus%TYPE,
      num_os_reh              IN              pv_det_suspvolprog_to.num_os_reh%TYPE,
      ev_comentario           IN              pv_iorserv.comentario%TYPE,
      sn_cod_retorno          OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno         OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento           OUT NOCOPY      ge_errores_pg.evento
   )
   AS
      v_des_error            ge_errores_pg.desevent;
      ssql                   ge_errores_pg.vquery;
      error_ejecucion        EXCEPTION;
          error_periodos         EXCEPTION;
      salir                  BOOLEAN                := FALSE;
      n_num_periodosusp_1    NUMBER;
      n_num_periodosusp_2    NUMBER;
      n_dias_periodosusp_1   NUMBER;
      n_dias_periodosusp_2   NUMBER;
      pv_iorserv             pv_iorserv_ot          := NEW pv_iorserv_ot;
      pv_erecorrido          pv_erecorrido_qt       := NEW pv_erecorrido_qt;
      pv_movimientos         pv_movimientos_ot      := NEW pv_movimientos_ot;
      pv_camcom              pv_camcom_ot           := NEW pv_camcom_ot;
      pv_param_abocel        pv_param_abocel_qt     := NEW pv_param_abocel_qt;
      seo_dat_abo            pv_abo_sus_vol_qt      := NEW pv_abo_sus_vol_qt;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      WHILE NOT salir LOOP
         IF NOT (ga_val_fecha_suspension_fn (en_num_abonado, ed_fec_suspension, n_num_periodosusp_1, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
         END IF;

         IF (n_num_periodosusp_1 IS NULL) THEN
            ga_ins_periodo_suspension_pr (en_num_abonado, ed_fec_suspension, ed_fec_rehabilitacion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
         ELSE
            IF NOT (ga_val_fecha_suspension_fn (en_num_abonado, ed_fec_rehabilitacion, n_num_periodosusp_2, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
               RAISE error_ejecucion;
            END IF;

            IF (n_num_periodosusp_2 IS NULL) THEN
               ga_ins_periodo_suspension_pr (en_num_abonado, ed_fec_suspension, ed_fec_rehabilitacion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
            END IF;
         END IF;

         IF (n_num_periodosusp_1 IS NOT NULL AND n_num_periodosusp_2 IS NOT NULL) THEN
                    IF ((n_num_periodosusp_2-n_num_periodosusp_1)>1) THEN
                           RAISE error_periodos;
                        END IF;
            salir := TRUE;
         END IF;
      END LOOP;

      IF NOT (ga_cal_dias_suspension_fn (en_num_abonado, n_num_periodosusp_1, n_num_periodosusp_2, ed_fec_suspension, ed_fec_rehabilitacion, n_dias_periodosusp_1, n_dias_periodosusp_2,sn_cod_retorno,sv_mens_retorno, sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      seo_dat_abo.num_abonado := en_num_abonado;
      IF NOT (pv_rec_info_abonado_fn (seo_dat_abo, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      SELECT instance_name
        INTO pv_camcom.bdatos
        FROM v$instance;

          pv_iorserv.prioridad := 1;
      pv_iorserv.comentario := ev_comentario;
      pv_camcom.cod_actabo := 'ST';
      pv_iorserv.num_os := num_os_sus;
      pv_camcom.num_abonado := seo_dat_abo.num_abonado;
      pv_iorserv.usuario := ev_usuario;
      pv_iorserv.cod_os := cod_os_sus_vol_prog;
      pv_iorserv.producto := cv_prod_celular;
      pv_iorserv.fh_ejecucion := ed_fec_suspension;
      pv_camcom.num_celular := seo_dat_abo.num_celular;
      pv_camcom.cod_cliente := seo_dat_abo.cod_cliente;
      pv_camcom.cod_producto := cv_prod_celular;
      pv_camcom.num_proceso := cn_number_cero;
      pv_camcom.ind_portable := cn_number_cero;
      pv_camcom.cod_cuenta := seo_dat_abo.cod_cuenta;
      pv_camcom.ind_central_ss := 1;
      pv_movimientos.ind_estado := 1;
          pv_param_abocel.cod_causa := ev_causal;

      pv_inscribe_ooss_pr (pv_iorserv, pv_erecorrido, pv_movimientos, pv_camcom, pv_param_abocel, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
          IF (sn_cod_retorno <> 0) THEN
             RAISE error_ejecucion;
          END IF;

          pv_param_abocel.cod_causa := ev_causal;
      pv_iorserv.cod_os := cod_os_reh_vol_prog;
      pv_iorserv.num_os := num_os_reh;
      pv_camcom.cod_actabo := 'RT';
      pv_iorserv.fh_ejecucion := ed_fec_rehabilitacion;

      pv_inscribe_ooss_pr (pv_iorserv, pv_erecorrido, pv_movimientos, pv_camcom, pv_param_abocel, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
          IF (sn_cod_retorno <> 0) THEN
             RAISE error_ejecucion;
          END IF;

      ssql := 'INSERT INTO pv_det_suspvolprog_to'
           || ' (num_abonado, num_periodosusp_1, num_periodosusp_2,'
           || ' fec_solicitud, fec_suspension, fec_rehabilitacion,'
           || ' fec_actualizacion, dias_periodosusp_1,'
           || ' dias_periodosusp_2, estado, causal, usuario)'
           || ' VALUES ('|| en_num_abonado|| ', '|| n_num_periodosusp_1|| ', '|| n_num_periodosusp_2|| ', '|| SYSDATE|| ', '|| ed_fec_suspension|| ', '|| ed_fec_rehabilitacion|| ', '|| SYSDATE|| ', '|| n_dias_periodosusp_1|| ', '|| n_dias_periodosusp_2|| ', '|| 'PRG'|| ', '|| ev_causal|| ', '|| ev_usuario|| ')';

      INSERT INTO pv_det_suspvolprog_to a
                  (num_det_sus_vol_prg, num_abonado, num_periodosusp_1, num_periodosusp_2, fec_solicitud, fec_suspension, fec_rehabilitacion, fec_actualizacion, dias_periodosusp_1,
                   dias_periodosusp_2, estado, cod_causal, usuario, num_os_sus, num_os_reh
                  )
           VALUES (ga_seq_num_sus_vol_prg.NEXTVAL, en_num_abonado, n_num_periodosusp_1, n_num_periodosusp_2, SYSDATE, ed_fec_suspension, ed_fec_rehabilitacion, SYSDATE, n_dias_periodosusp_1,
                   n_dias_periodosusp_2, 'PRG', ev_causal, ev_usuario, num_os_sus, num_os_reh
                  );

      IF (n_num_periodosusp_1 = n_num_periodosusp_2) THEN
         IF NOT (ga_upd_diasacum_suspension_fn (n_num_periodosusp_1, en_num_abonado, n_dias_periodosusp_1, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
         END IF;
      ELSE
         IF NOT (ga_upd_diasacum_suspension_fn (n_num_periodosusp_1, en_num_abonado, n_dias_periodosusp_1, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
         END IF;

         IF NOT (ga_upd_diasacum_suspension_fn (n_num_periodosusp_2, en_num_abonado, n_dias_periodosusp_2, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
         END IF;
      END IF;

   EXCEPTION
      WHEN error_periodos  THEN
         sn_cod_retorno  := '10100';
         sv_mens_retorno := 'Error: no es posible asignar una suspensión en mas de 2 periodos';
         v_des_error     := 'pv_suspvolprog_pg.ga_ins_suspension_prg_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_ins_suspension_prg_pr', ssql, SQLCODE, v_des_error);
      WHEN error_ejecucion THEN
         v_des_error     := 'pv_suspvolprog_pg.ga_ins_suspension_prg_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_ins_suspension_prg_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno  := '10021';
         sv_mens_retorno := 'Error: no determinado al registrar suspensión voluntaria';
         v_des_error     := 'pv_suspvolprog_pg.ga_ins_suspension_prg_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_ins_suspension_prg_pr', ssql, SQLCODE, v_des_error);
   END ga_ins_suspension_prg_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_upd_suspension_abonado_fn (
      pv_det_suspvolprog   IN OUT NOCOPY   pv_det_suspvolprog_qt,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := 'UPDATE pv_det_suspvolprog_to a'
           || ' SET num_periodosusp_1  = '||pv_det_suspvolprog.num_periodosusp_1|| ','
                   || ' num_periodosusp_2  = '||pv_det_suspvolprog.num_periodosusp_2|| ','
           || ' fec_rehabilitacion = '|| pv_det_suspvolprog.fec_rehabilitacion|| ','
           || ' fec_actualizacion =  '|| SYSDATE|| ','
           || ' dias_periodosusp_1 = '|| pv_det_suspvolprog.dias_periodosusp_1|| ','
           || ' dias_periodosusp_2 = '|| pv_det_suspvolprog.dias_periodosusp_2|| ','
           || ' usuario = '|| pv_det_suspvolprog.usuario|| ','
           || ' estado = '|| pv_det_suspvolprog.estado
           || ' WHERE a.num_det_sus_vol_prg = '|| pv_det_suspvolprog.num_det_sus_vol_prg;

      UPDATE pv_det_suspvolprog_to a
         SET num_periodosusp_1  = pv_det_suspvolprog.num_periodosusp_1,
                     num_periodosusp_2  = pv_det_suspvolprog.num_periodosusp_2,
                     fec_rehabilitacion = pv_det_suspvolprog.fec_rehabilitacion,
             fec_actualizacion = SYSDATE,
             dias_periodosusp_1 = pv_det_suspvolprog.dias_periodosusp_1,
             dias_periodosusp_2 = pv_det_suspvolprog.dias_periodosusp_2,
             usuario = pv_det_suspvolprog.usuario,
             estado = pv_det_suspvolprog.estado
       WHERE a.num_det_sus_vol_prg = pv_det_suspvolprog.num_det_sus_vol_prg;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10022';
         sv_mens_retorno := 'Error: no determinado al modificar parámetro suspensión de abonado';
         v_des_error     := 'pv_suspvolprog_pg.ga_upd_suspension_abonado_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_upd_suspension_abonado_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ga_upd_suspension_abonado_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_modifica_suspension_pr (
      pv_det_suspvolprog   IN OUT NOCOPY   pv_det_suspvolprog_qt,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      pv_det_suspvolprogin   pv_det_suspvolprog_qt := new pv_det_suspvolprog_qt;
      v_des_error            ge_errores_pg.desevent;
      ssql                   ge_errores_pg.vquery;
      error_ejecucion        EXCEPTION;
          pv_iorserv             pv_iorserv_ot := new pv_iorserv_ot;
      dias                   NUMBER;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      pv_det_suspvolprogin.num_det_sus_vol_prg := pv_det_suspvolprog.num_det_sus_vol_prg;

      IF NOT (ga_rec_susp_volprog_fn (pv_det_suspvolprogin, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;


          IF (pv_det_suspvolprogin.fec_rehabilitacion <> pv_det_suspvolprog.fec_rehabilitacion) THEN

         IF (pv_det_suspvolprogin.num_periodosusp_1 = pv_det_suspvolprogin.num_periodosusp_2) THEN
            dias := pv_det_suspvolprogin.fec_rehabilitacion - pv_det_suspvolprog.fec_rehabilitacion;

            IF NOT (ga_upd_diasacum_suspension_fn (pv_det_suspvolprogin.num_periodosusp_1,pv_det_suspvolprogin.num_abonado,0- dias,sn_cod_retorno,sv_mens_retorno,sn_num_evento))THEN
               RAISE error_ejecucion;
            END IF;
         ELSE
            dias := pv_det_suspvolprogin.fec_rehabilitacion - pv_det_suspvolprog.fec_rehabilitacion;

            IF (pv_det_suspvolprogin.dias_periodosusp_2 - dias >= 0) THEN
               IF NOT (ga_upd_diasacum_suspension_fn (pv_det_suspvolprogin.num_periodosusp_2, pv_det_suspvolprogin.num_abonado, 0-dias, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
                  RAISE error_ejecucion;
               END IF;
            ELSE
               IF NOT (ga_upd_diasacum_suspension_fn (pv_det_suspvolprogin.num_periodosusp_2, pv_det_suspvolprogin.num_abonado, 0 - pv_det_suspvolprogin.dias_periodosusp_2, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
                  RAISE error_ejecucion;
               END IF;

               dias := dias - pv_det_suspvolprog.dias_periodosusp_2;

               IF NOT (ga_upd_diasacum_suspension_fn (pv_det_suspvolprogin.num_periodosusp_1,pv_det_suspvolprogin.num_abonado,0-dias,sn_cod_retorno,sv_mens_retorno,sn_num_evento))THEN
                  RAISE error_ejecucion;
               END IF;
            END IF;
         END IF;

         pv_det_suspvolprogin.fec_rehabilitacion := pv_det_suspvolprog.fec_rehabilitacion;

         IF NOT (ga_val_fecha_suspension_fn (pv_det_suspvolprogin.num_abonado, pv_det_suspvolprogin.fec_suspension, pv_det_suspvolprogin.num_periodosusp_1, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
            RAISE error_ejecucion;
         END IF;

         IF NOT (ga_val_fecha_suspension_fn (pv_det_suspvolprogin.num_abonado,pv_det_suspvolprogin.fec_rehabilitacion,pv_det_suspvolprogin.num_periodosusp_2,sn_cod_retorno,sv_mens_retorno,sn_num_evento))THEN
            RAISE error_ejecucion;
         END IF;

         IF NOT (ga_cal_dias_suspension_fn (pv_det_suspvolprogin.num_abonado,pv_det_suspvolprogin.num_periodosusp_1,pv_det_suspvolprogin.num_periodosusp_2,pv_det_suspvolprogin.fec_suspension,pv_det_suspvolprogin.fec_rehabilitacion,pv_det_suspvolprogin.dias_periodosusp_1,pv_det_suspvolprogin.dias_periodosusp_2,sn_cod_retorno,sv_mens_retorno,sn_num_evento))THEN
            RAISE error_ejecucion;
         END IF;

         IF NOT (ga_upd_suspension_abonado_fn (pv_det_suspvolprogin, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
         END IF;

                 pv_iorserv.fh_ejecucion := pv_det_suspvolprogin.fec_rehabilitacion;
                 pv_iorserv.num_os       := pv_det_suspvolprogin.num_os_reh;
                 IF NOT (pv_upd_fh_eje_iorserv_fn(pv_iorserv,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
            RAISE error_ejecucion;
                 END IF;


      END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
         v_des_error     := 'pv_suspvolprog_pg.ga_modifica_suspension_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_modifica_suspension_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno  := '10023';
         sv_mens_retorno := 'Error: no determinado al modificar fecha suspensión de abonado';
         v_des_error     := 'pv_suspvolprog_pg.ga_modifica_suspension_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_modifica_suspension_pr', ssql, SQLCODE, v_des_error);
   END ga_modifica_suspension_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_cons_suspension_vol_pr (
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      sc_resultado      OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   AS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := 'SELECT a.num_abonado, a.num_periodosusp_1, a.num_periodosusp_2, a.fec_solicitud, a.fec_suspension, a.fec_rehabilitacion,'
           || ' a.fec_actualizacion, a.dias_periodosusp_1, a.dias_periodosusp_2, a.estado, a.causal, a.usuario'
           || ' FROM pv_det_suspvolprog_to a'
           || ' WHERE a.num_abonado = '|| en_num_abonado;

        OPEN sc_resultado FOR
      SELECT a.num_det_sus_vol_prg, a.num_abonado, a.num_periodosusp_1, a.num_periodosusp_2, a.fec_solicitud, a.fec_suspension, a.fec_rehabilitacion, a.fec_actualizacion, a.dias_periodosusp_1,
             a.dias_periodosusp_2, a.estado, a.cod_causal, b.des_caususp, a.usuario, a.num_os_sus, a.num_os_reh
        FROM pv_det_suspvolprog_to a, ga_caususp b
       WHERE a.num_abonado = en_num_abonado
                 AND b.cod_caususp = a.cod_causal
                 AND b.cod_producto = 1
                 AND b.cod_modulo = 'GA'
             AND a.estado <> 'ANU'
             AND a.estado <> 'REH'
                 ORDER BY fec_suspension;

   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10024';
         sv_mens_retorno := 'Error: no determinado al recuperar suspensiones de abonado';
         v_des_error     := 'pv_suspvolprog_pg.ga_cons_suspension_vol_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_cons_suspension_vol_pr', ssql, SQLCODE, v_des_error);
   END ga_cons_suspension_vol_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_param_general_susp_vol_pr (
      sv_dias_max_susp_vol    OUT NOCOPY   ged_parametros.val_parametro%TYPE,
      sv_dias_antes_sus_vol   OUT NOCOPY   ged_parametros.val_parametro%TYPE,
      sn_cod_retorno          OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno         OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento           OUT NOCOPY   ge_errores_pg.evento
   )
   AS
      v_des_error        ge_errores_pg.desevent;
      ssql               ge_errores_pg.vquery;
      sv_des_parametro   ged_parametros.des_parametro%TYPE;
      error_ejecucion    EXCEPTION;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      IF NOT (pv_obtiene_ged_parametros_fn ('DIAS_MAX_SUSPROG', 'GA', sv_dias_max_susp_vol, sv_des_parametro, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (pv_obtiene_ged_parametros_fn ('DIAS_ANTES_SUS_VOL', 'PV', sv_dias_antes_sus_vol, sv_des_parametro, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
         v_des_error     := 'pv_suspvolprog_pg.ga_param_general_susp_vol_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_param_general_susp_vol_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno  := '10025';
         sv_mens_retorno := 'Error: no determinado al recuperar parámetros generales de suspensión';
         v_des_error     := 'pv_suspvolprog_pg.ga_param_general_susp_vol_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_param_general_susp_vol_pr', ssql, SQLCODE, v_des_error);
   END ga_param_general_susp_vol_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_rec_fec_susp_vol_pr (
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      sc_resultado      OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   AS
      v_des_error             ge_errores_pg.desevent;
      ssql                    ge_errores_pg.vquery;
      sv_des_parametro        ged_parametros.des_parametro%TYPE;
      error_ejecucion         EXCEPTION;
      sv_dias_antes_sus_vol   ged_parametros.val_parametro%TYPE;
      seo_dat_abo             pv_abo_sus_vol_qt                   := NEW pv_abo_sus_vol_qt;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      seo_dat_abo.num_abonado := en_num_abonado;

      IF NOT (pv_rec_info_abonado_fn (seo_dat_abo, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (pv_obtiene_ged_parametros_fn ('DIAS_ANTES_SUS_VOL', 'PV', sv_dias_antes_sus_vol, sv_des_parametro, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      ssql := 'SELECT fec_desdellam'
              || ' FROM fa_ciclfact'
                  || ' WHERE fec_desdellam > ' || SYSDATE
                  || ' AND ROWNUM <= ' || sv_dias_antes_sus_vol;

      OPEN sc_resultado FOR
      SELECT fec_desdellam
        FROM fa_ciclfact
       WHERE fec_desdellam > SYSDATE
             AND cod_ciclo = seo_dat_abo.cod_ciclo
                 AND ROWNUM <= sv_dias_antes_sus_vol;

   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10026';
         sv_mens_retorno := 'Error: no determinado al Recuperar fechas de suspensión';
         v_des_error     := 'pv_suspvolprog_pg.ga_rec_fec_susp_vol_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_rec_fec_susp_vol_pr', ssql, SQLCODE, v_des_error);
   END ga_rec_fec_susp_vol_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION pv_ins_iorserv_fn (
      pv_iorserv        IN              pv_iorserv_ot,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := 'INSERT INTO pv_iorserv a'
           || ' (num_os, cod_os, num_ospadre, descripcion, fecha_ing, producto, usuario, status, tip_procesa, fh_ejecucion,'
           || ' cod_estado, cod_modgener, num_osf, tip_subsujeto, nfile, path_file, tip_sujeto, ind_lock, prioridad,'
           || ' num_osf_err, comentario, fh_recolector, fh_respaldo, cod_modulo, id_gestor,num_intentos, num_osftotal)'
           || ' VALUES ('||pv_iorserv.num_os||', '||pv_iorserv.cod_os||', '||pv_iorserv.num_ospadre||', '||pv_iorserv.descripcion||', '
           || pv_iorserv.fecha_ing||', '||pv_iorserv.producto||', '||pv_iorserv.usuario||', '||pv_iorserv.status||', '|| pv_iorserv.tip_procesa||', '
           || pv_iorserv.fh_ejecucion||', '|| pv_iorserv.cod_estado||', '|| pv_iorserv.cod_modgener||', '
           || pv_iorserv.num_osf||', '|| pv_iorserv.tip_subsujeto||', '|| pv_iorserv.nfile||', '|| pv_iorserv.path_file||', '
           || pv_iorserv.tip_sujeto||', '|| pv_iorserv.ind_lock||', '|| pv_iorserv.prioridad||', '|| pv_iorserv.num_osf_err||', '
           || pv_iorserv.comentario||', '|| pv_iorserv.fh_recolector||', '|| pv_iorserv.fh_respaldo||', '|| pv_iorserv.cod_modulo||', '
           || pv_iorserv.id_gestor||', '|| pv_iorserv.num_intentos||', '|| pv_iorserv.num_osftotal||')';

      INSERT INTO pv_iorserv a
                  (num_os, cod_os, num_ospadre, descripcion, fecha_ing, producto, usuario, status,
                   tip_procesa, fh_ejecucion, cod_estado, cod_modgener, num_osf, tip_subsujeto, nfile,
                   path_file, tip_sujeto, ind_lock, prioridad, num_osf_err, comentario, fh_recolector,
                   fh_respaldo, cod_modulo, id_gestor, num_intentos, num_osftotal
                  )
           VALUES (pv_iorserv.num_os, pv_iorserv.cod_os, pv_iorserv.num_ospadre, pv_iorserv.descripcion, pv_iorserv.fecha_ing, pv_iorserv.producto, pv_iorserv.usuario, pv_iorserv.status,
                   pv_iorserv.tip_procesa, pv_iorserv.fh_ejecucion, pv_iorserv.cod_estado, pv_iorserv.cod_modgener, pv_iorserv.num_osf, pv_iorserv.tip_subsujeto, pv_iorserv.nfile,
                   pv_iorserv.path_file, pv_iorserv.tip_sujeto, pv_iorserv.ind_lock, pv_iorserv.prioridad, pv_iorserv.num_osf_err, pv_iorserv.comentario, pv_iorserv.fh_recolector,
                   pv_iorserv.fh_respaldo, pv_iorserv.cod_modulo, pv_iorserv.id_gestor, pv_iorserv.num_intentos, pv_iorserv.num_osftotal
                  );

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10028';
         sv_mens_retorno := 'Error: no determinado al registrar parámetros OOSS';
         v_des_error     := 'pv_suspvolprog_pg.pv_ins_iorserv_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_ins_iorserv_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END pv_ins_iorserv_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_upd_anula_erecorrido_fn (
      pv_erecorrido     IN              pv_erecorrido_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := ' UPDATE pv_erecorrido a'
           || ' SET a.tip_estado = '||pv_erecorrido.tip_estado
           || ' WHERE a.num_os = '||pv_erecorrido.num_os;

      UPDATE pv_erecorrido a
         SET a.tip_estado = pv_erecorrido.tip_estado
       WHERE a.num_os = pv_erecorrido.num_os;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10029';
         sv_mens_retorno := 'Error: no determinado al anular OOSS';
         v_des_error     := 'pv_suspvolprog_pg.pv_upd_anula_erecorrido_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_upd_anula_erecorrido_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END pv_upd_anula_erecorrido_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_ins_erecorrido_fn (
      pv_erecorrido     IN              pv_erecorrido_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := 'INSERT INTO pv_erecorrido (num_os, cod_estado, descripcion, tip_estado, fec_ingestado, msg_error )'
                   || ' VALUES ('|| pv_erecorrido.num_os||', '||pv_erecorrido.cod_estado||', '||pv_erecorrido.descripcion||', '
           || pv_erecorrido.tip_estado||', '|| pv_erecorrido.fec_ingestado|| ', '|| pv_erecorrido.msg_error||')';

      INSERT INTO pv_erecorrido
                  (num_os, cod_estado, descripcion, tip_estado, fec_ingestado, msg_error
                  )
           VALUES (pv_erecorrido.num_os, pv_erecorrido.cod_estado, pv_erecorrido.descripcion, pv_erecorrido.tip_estado, pv_erecorrido.fec_ingestado, pv_erecorrido.msg_error
                  );

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10030';
         sv_mens_retorno := 'Error: no determinado al registrar seguimiento de OOSS';
         v_des_error     := 'pv_suspvolprog_pg.pv_ins_erecorrido_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_ins_erecorrido_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END pv_ins_erecorrido_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_ins_movimientos_fn (
      pv_movimientos    IN              pv_movimientos_ot,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql :='INSERT INTO pv_movimientos(num_os, f_ejecucion,ord_comando, cod_actabo,cod_servicio, ind_estado,fec_expira, resp_central,'
           || ' num_movimiento, carga, cod_estado)'
           || ' VALUES ('||pv_movimientos.num_os||', '||pv_movimientos.f_ejecucion||', '|| pv_movimientos.ord_comando||', '|| pv_movimientos.cod_actabo||', '||pv_movimientos.cod_servicio||', '||pv_movimientos.ind_estado||', '
           || pv_movimientos.fec_expira||', '||pv_movimientos.resp_central||', '||pv_movimientos.num_movimiento||', '||pv_movimientos.carga||', '||pv_movimientos.cod_estado||')';

      INSERT INTO pv_movimientos
                  (num_os, f_ejecucion, ord_comando, cod_actabo, cod_servicio, ind_estado,
                   fec_expira, resp_central, num_movimiento, carga, cod_estado
                  )
           VALUES (pv_movimientos.num_os, pv_movimientos.f_ejecucion, pv_movimientos.ord_comando, pv_movimientos.cod_actabo, pv_movimientos.cod_servicio, pv_movimientos.ind_estado,
                   pv_movimientos.fec_expira, pv_movimientos.resp_central, pv_movimientos.num_movimiento, pv_movimientos.carga, pv_movimientos.cod_estado
                  );

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10031';
         sv_mens_retorno := 'Error: no determinado al registrar movimiento';
         v_des_error     := 'pv_suspvolprog_pg.pv_ins_movimientos_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_ins_movimientos_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END pv_ins_movimientos_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_upd_anula_camcom_fn (
      pv_camcom         IN              pv_camcom_ot,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

          ssql := 'UPDATE pv_camcom a'
           || ' SET a.fh_anula = '||pv_camcom.fh_anula
           || ' WHERE a.num_os = '||pv_camcom.num_os;

      UPDATE pv_camcom a
         SET a.fh_anula = pv_camcom.fh_anula
       WHERE a.num_os = pv_camcom.num_os;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10032';
         sv_mens_retorno := 'Error: no determinado al modificar parámetros generales de OOSS';
         v_des_error     := 'pv_suspvolprog_pg.pv_upd_anula_camcom_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_upd_anula_camcom_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END pv_upd_anula_camcom_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_ins_camcom_fn (
      pv_camcom         IN              pv_camcom_ot,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := 'INSERT INTO pv_camcom, num_os, num_abonado, num_celular,cod_cliente, cod_cuenta, cod_producto, bdatos, num_venta,'
           || ' num_transaccion, num_folio, num_cuotas, num_proceso, cod_actabo, fh_anula, user_anula, cat_tribut, cod_estadoc,'
           || ' cod_causaelim, fec_vencimiento, abonados, tabla, clase_servicio_act, clase_servicio_des, ind_msg, num_cargo_os, imp_cargo_ser,'
           || ' ind_central_ss, ind_portable, tip_terminal, tip_susp_avsinie, pref_plaza)'
           || ' VALUES ('|| pv_camcom.num_os|| ', '|| pv_camcom.num_abonado|| ', '|| pv_camcom.num_celular|| ', '|| pv_camcom.cod_cliente|| ', '
           || pv_camcom.cod_cuenta||', '||pv_camcom.cod_producto||', '||pv_camcom.bdatos||', '||pv_camcom.num_venta||', '||pv_camcom.num_transaccion||', '
           || pv_camcom.num_folio||', '||pv_camcom.num_cuotas||', '||pv_camcom.num_proceso||', '||pv_camcom.cod_actabo||', '|| pv_camcom.fh_anula||', '
           || pv_camcom.user_anula||', '||pv_camcom.cat_tribut||', '||pv_camcom.cod_estadoc||', '||pv_camcom.cod_causaelim||', '||pv_camcom.fec_vencimiento||', '||pv_camcom.abonados||', '||pv_camcom.tabla||', '
           || pv_camcom.clase_servicio_act||', '||pv_camcom.clase_servicio_des||', '||pv_camcom.ind_msg||', '||pv_camcom.num_cargo_os||', '||pv_camcom.imp_cargo_ser||', '
           || pv_camcom.ind_central_ss||', '|| pv_camcom.ind_portable||', '||pv_camcom.tip_terminal||', '||pv_camcom.tip_susp_avsinie||', '||pv_camcom.pref_plaza||' )';

      INSERT INTO pv_camcom
                  (num_os, num_abonado, num_celular, cod_cliente, cod_cuenta, cod_producto, bdatos, num_venta,
                   num_transaccion, num_folio, num_cuotas, num_proceso, cod_actabo, fh_anula, user_anula, cat_tribut,
                   cod_estadoc, cod_causaelim, fec_vencimiento, abonados, tabla, clase_servicio_act, clase_servicio_des,
                   ind_msg, num_cargo_os, imp_cargo_ser, ind_central_ss, ind_portable, tip_terminal, tip_susp_avsinie,
                   pref_plaza
                  )
           VALUES (pv_camcom.num_os, pv_camcom.num_abonado, pv_camcom.num_celular, pv_camcom.cod_cliente, pv_camcom.cod_cuenta, pv_camcom.cod_producto, pv_camcom.bdatos, pv_camcom.num_venta,
                   pv_camcom.num_transaccion, pv_camcom.num_folio, pv_camcom.num_cuotas, pv_camcom.num_proceso, pv_camcom.cod_actabo, pv_camcom.fh_anula, pv_camcom.user_anula, pv_camcom.cat_tribut,
                   pv_camcom.cod_estadoc, pv_camcom.cod_causaelim, pv_camcom.fec_vencimiento, pv_camcom.abonados, pv_camcom.tabla, pv_camcom.clase_servicio_act, pv_camcom.clase_servicio_des,
                   pv_camcom.ind_msg, pv_camcom.num_cargo_os, pv_camcom.imp_cargo_ser, pv_camcom.ind_central_ss, pv_camcom.ind_portable, pv_camcom.tip_terminal, pv_camcom.tip_susp_avsinie,
                   pv_camcom.pref_plaza
                  );

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10033';
         sv_mens_retorno := 'Error: no determinado al registrar parámetros generales de OOSS';
         v_des_error     := 'pv_suspvolprog_pg.pv_ins_camcom_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_ins_camcom_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END pv_ins_camcom_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_recupera_codigo_servicio_fn (
      pv_param_abocel   IN OUT NOCOPY   pv_param_abocel_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      o_dat_abo         pv_abo_sus_vol_qt      := NEW pv_abo_sus_vol_qt;
      v_des_error       ge_errores_pg.desevent;
      ssql              ge_errores_pg.vquery;
      error_ejecucion   EXCEPTION;
          v_grupo_tecno     al_tecnologia.cod_grupo%TYPE;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      o_dat_abo.num_abonado := pv_param_abocel.num_abonado;

      IF NOT (pv_rec_info_abonado_fn (o_dat_abo, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (pv_obtiene_grupo_tecnologia_fn(o_dat_abo.cod_tecnologia,v_grupo_tecno,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

          ssql := ' SELECT a.cod_servicio'
           || ' FROM pv_serv_suspreha_to a'
           || ' WHERE a.cod_producto = '||cv_prod_celular
           || ' AND a.cod_modulo = '||cv_cod_modulo
           || ' AND EXISTS (SELECT b.cod_tiplan'
           || ' FROM ta_plantarif b'
           || ' WHERE b.cod_producto = '||cv_prod_celular
                   || ' AND b.cod_plantarif = '||o_dat_abo.cod_plantarif
                   || ' AND a.cod_tiplan = b.cod_tiplan)'
           || ' AND a.cod_tecnologia = '||v_grupo_tecno
           || ' AND a.cod_actabo = '||cv_cod_actabo;

      SELECT a.cod_servicio
        INTO pv_param_abocel.cod_servicio
        FROM pv_serv_suspreha_to a
       WHERE a.cod_producto = cv_prod_celular
         AND a.cod_modulo = cv_cod_modulo
         AND EXISTS (SELECT b.cod_tiplan
                       FROM ta_plantarif b
                      WHERE b.cod_producto = cv_prod_celular
                                            AND b.cod_plantarif = o_dat_abo.cod_plantarif
                                                AND a.cod_tiplan = b.cod_tiplan)
         AND a.cod_tecnologia = v_grupo_tecno
         AND a.cod_actabo = cv_cod_actabo;

      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := '10034';
         sv_mens_retorno := 'Error: al recuperar códigos OOSS';
         v_des_error     := 'pv_suspvolprog_pg.pv_recupera_codigo_servicio_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_recupera_codigo_servicio_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno  := '10035';
         sv_mens_retorno := 'Error: no determinado al recuperar códigos OOSS';
         v_des_error     := 'pv_suspvolprog_pg.pv_recupera_codigo_servicio_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_recupera_codigo_servicio_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END pv_recupera_codigo_servicio_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_ins_param_abocel_fn (
      pv_param_abocel   IN              pv_param_abocel_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
   IS
      v_des_error   ge_errores_pg.desevent;
      ssql          ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := '0';
      sn_num_evento   := 0;
      sv_mens_retorno := '0';

          ssql := 'INSERT INTO pv_param_abocel'
           || ' (num_os, num_abonado, cod_tipmodi, fec_modifica, nuom_usuarora, num_celular,'
           || ' cod_uso, tip_plantarif, tip_terminal, cod_plantarif, cod_cargobasico, cod_planserv,'
           || ' cod_limconsumo, num_serie, num_seriehex, cod_empresa, cod_grpserv, cod_carrier,'
           || ' cod_ciclo, ind_factur, cod_causa, num_min, cod_tipcontrato, num_meses,'
           || ' ind_eqprestado, fec_prorroga, num_ciclos, num_minutos, fec_fincontrato,'
           || ' cod_servicio, obs_detalle, cod_tipsegu, num_contrato, num_anexo, cod_producto,'
           || ' cod_plantarif_nue, tip_plantarif_nue, num_dia, cod_vendedor, param1_mens'
           || ' )'
           || ' VALUES ('||pv_param_abocel.num_os||', '||pv_param_abocel.num_abonado||', '||pv_param_abocel.cod_tipmodi||', '||pv_param_abocel.fec_modifica||', '||pv_param_abocel.nuom_usuarora||', '||pv_param_abocel.num_celular
                   ||', '||pv_param_abocel.cod_uso||', '||pv_param_abocel.tip_plantarif||', '||pv_param_abocel.tip_terminal||', '||pv_param_abocel.cod_plantarif||', '||pv_param_abocel.cod_cargobasico||', '||pv_param_abocel.cod_planserv
           ||', '||pv_param_abocel.cod_limconsumo||', '||pv_param_abocel.num_serie||', '||pv_param_abocel.num_seriehex||', '||pv_param_abocel.cod_empresa||', '||pv_param_abocel.cod_grpserv||', '||pv_param_abocel.cod_carrier
           ||', '||pv_param_abocel.cod_ciclo||', '||pv_param_abocel.ind_factur||', '||pv_param_abocel.cod_causa||', '||pv_param_abocel.num_min||', '||pv_param_abocel.cod_tipcontrato||', '||pv_param_abocel.num_meses
           ||', '||pv_param_abocel.ind_eqprestado||', '||pv_param_abocel.fec_prorroga||', '||pv_param_abocel.num_ciclos||', '||pv_param_abocel.num_minutos||', '||pv_param_abocel.fec_fincontrato
           ||', '||pv_param_abocel.cod_servicio||', '||pv_param_abocel.obs_detalle||', '||pv_param_abocel.cod_tipsegu||', '||pv_param_abocel.num_contrato||', '||pv_param_abocel.num_anexo||', '||pv_param_abocel.cod_producto
           ||', '||pv_param_abocel.cod_plantarif_nue||', '||pv_param_abocel.tip_plantarif_nue||', '||pv_param_abocel.num_dia||', '||pv_param_abocel.cod_vendedor||', '||pv_param_abocel.param1_mens
           ||')';

      INSERT INTO pv_param_abocel
                  (num_os, num_abonado, cod_tipmodi, fec_modifica, nuom_usuarora, num_celular,
                   cod_uso, tip_plantarif, tip_terminal, cod_plantarif, cod_cargobasico, cod_planserv,
                   cod_limconsumo, num_serie, num_seriehex, cod_empresa, cod_grpserv, cod_carrier,
                   cod_ciclo, ind_factur, cod_causa, num_min, cod_tipcontrato, num_meses,
                   ind_eqprestado, fec_prorroga, num_ciclos, num_minutos, fec_fincontrato,
                   cod_servicio, obs_detalle, cod_tipsegu, num_contrato, num_anexo, cod_producto,
                   cod_plantarif_nue, tip_plantarif_nue, num_dia, cod_vendedor, param1_mens
                  )
           VALUES (pv_param_abocel.num_os, pv_param_abocel.num_abonado, pv_param_abocel.cod_tipmodi, pv_param_abocel.fec_modifica, pv_param_abocel.nuom_usuarora, pv_param_abocel.num_celular,
                   pv_param_abocel.cod_uso, pv_param_abocel.tip_plantarif, pv_param_abocel.tip_terminal, pv_param_abocel.cod_plantarif, pv_param_abocel.cod_cargobasico, pv_param_abocel.cod_planserv,
                   pv_param_abocel.cod_limconsumo, pv_param_abocel.num_serie, pv_param_abocel.num_seriehex, pv_param_abocel.cod_empresa, pv_param_abocel.cod_grpserv, pv_param_abocel.cod_carrier,
                   pv_param_abocel.cod_ciclo, pv_param_abocel.ind_factur, pv_param_abocel.cod_causa, pv_param_abocel.num_min, pv_param_abocel.cod_tipcontrato, pv_param_abocel.num_meses,
                   pv_param_abocel.ind_eqprestado, pv_param_abocel.fec_prorroga, pv_param_abocel.num_ciclos, pv_param_abocel.num_minutos, pv_param_abocel.fec_fincontrato,
                   pv_param_abocel.cod_servicio, pv_param_abocel.obs_detalle, pv_param_abocel.cod_tipsegu, pv_param_abocel.num_contrato, pv_param_abocel.num_anexo, pv_param_abocel.cod_producto,
                   pv_param_abocel.cod_plantarif_nue, pv_param_abocel.tip_plantarif_nue, pv_param_abocel.num_dia, pv_param_abocel.cod_vendedor, pv_param_abocel.param1_mens
                  );

      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := '10036';
         sv_mens_retorno := 'Error: no determinado al Recuperar parametros OOSS';
         v_des_error     := 'pv_suspvolprog_pg.pv_ins_param_abocel_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_ins_param_abocel_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END pv_ins_param_abocel_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE pv_inscribe_ooss_pr (
      pv_iorserv        IN OUT NOCOPY   pv_iorserv_ot,
      pv_erecorrido     IN OUT NOCOPY   pv_erecorrido_qt,
      pv_movimientos    IN OUT NOCOPY   pv_movimientos_ot,
      pv_camcom         IN OUT NOCOPY   pv_camcom_ot,
      pv_param_abocel   IN OUT NOCOPY   pv_param_abocel_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      error_ejecucion   EXCEPTION;
      v_des_error       ge_errores_pg.desevent;
      ssql              ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';



      pv_param_abocel.num_abonado := pv_camcom.num_abonado;
      pv_param_abocel.nuom_usuarora := pv_iorserv.usuario;
          pv_param_abocel.cod_producto := gn_cod_producto;
      pv_erecorrido.num_os := pv_iorserv.num_os;
      pv_movimientos.num_os := pv_iorserv.num_os;
          pv_camcom.cod_producto := gn_cod_producto;
      pv_camcom.num_os := pv_iorserv.num_os;
      pv_param_abocel.num_os := pv_iorserv.num_os;
      pv_movimientos.cod_actabo := pv_camcom.cod_actabo;
      pv_iorserv.status := 'Proceso exitoso';
      pv_iorserv.num_osf := 0;
      pv_iorserv.tip_sujeto := 'A';
      pv_iorserv.fecha_ing := SYSDATE;
      pv_iorserv.cod_estado := 10;
      pv_iorserv.ind_lock := 0;
      pv_iorserv.num_osf_err := 0;
      pv_erecorrido.tip_estado := 3;
      pv_erecorrido.cod_estado := 10;
      pv_erecorrido.fec_ingestado := SYSDATE;
      pv_movimientos.ord_comando := 1;
      pv_movimientos.cod_estado := 0;
      pv_param_abocel.fec_modifica := SYSDATE;
      pv_param_abocel.cod_tipmodi := pv_camcom.cod_actabo;

      IF NOT (ga_parametros_ooss_fn (pv_iorserv, pv_erecorrido, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (pv_ins_iorserv_fn (pv_iorserv, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (pv_ins_erecorrido_fn (pv_erecorrido, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (pv_ins_movimientos_fn (pv_movimientos, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (pv_ins_camcom_fn (pv_camcom, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (pv_recupera_codigo_servicio_fn (pv_param_abocel, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (pv_ins_param_abocel_fn (pv_param_abocel, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
         v_des_error     := 'pv_suspvolprog_pg.pv_inscribe_ooss_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_inscribe_ooss_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno  := '10038';
         sv_mens_retorno := 'Error: no determinado en el proceso de inscripción de OOSS';
         v_des_error     := 'pv_suspvolprog_pg.pv_inscribe_ooss_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_inscribe_ooss_pr', ssql, SQLCODE, v_des_error);
   END pv_inscribe_ooss_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_anula_susvolprog_pr (
      pv_det_suspvolprog   IN OUT NOCOPY   pv_det_suspvolprog_qt,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      error_ejecucion   EXCEPTION;
      pv_camcom         pv_camcom_ot           := NEW pv_camcom_ot;
      pv_erecorrido     pv_erecorrido_qt       := NEW pv_erecorrido_qt;
      pv_iorserv        pv_iorserv_ot          := NEW pv_iorserv_ot;
      v_des_error       ge_errores_pg.desevent;
      ssql              ge_errores_pg.vquery;
          iDiasAcumulados_1 NUMBER;
          iDiasAcumulados_2 NUMBER;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';


      IF NOT (ga_rec_susp_volprog_fn (pv_det_suspvolprog,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

      pv_det_suspvolprog.estado := 'ANU';


      IF (pv_det_suspvolprog.fec_suspension <= TRUNC (SYSDATE))THEN


         pv_iorserv.fh_ejecucion := SYSDATE;

         IF NOT (pv_upd_fh_eje_iorserv_fn (pv_iorserv, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
         END IF;

         pv_erecorrido.num_os := pv_det_suspvolprog.num_os_reh;
         pv_erecorrido.tip_estado := 3;

         IF NOT (pv_upd_anula_erecorrido_fn (pv_erecorrido, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
         END IF;

         /*IF NOT (ga_upd_diasacum_suspension_fn (pv_det_suspvolprog.num_periodosusp_1, pv_det_suspvolprog.num_abonado, TRUNC (SYSDATE) - pv_det_suspvolprog.fec_rehabilitacion ,sn_cod_retorno,sv_mens_retorno,sn_num_evento))THEN
            RAISE error_ejecucion;
         END IF;*/

                 pv_det_suspvolprog.fec_rehabilitacion := TRUNC(SYSDATE);

                 IF NOT (ga_upd_suspension_abonado_fn (pv_det_suspvolprog, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
                        RAISE error_ejecucion;
                 END IF;

         pv_iorserv.num_os := pv_det_suspvolprog.num_os_sus;
             IF NOT (pv_upd_anula_iorserv_fn (pv_iorserv, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
                 RAISE error_ejecucion;
             END IF;



         pv_iorserv.num_os := pv_det_suspvolprog.num_os_reh;
             IF NOT (pv_upd_anula_iorserv_fn (pv_iorserv, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
                 RAISE error_ejecucion;
             END IF;

             IF NOT (pv_upd_fh_ejecucion_reh_fn (pv_det_suspvolprog, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
                 RAISE error_ejecucion;
             END IF;

      ELSE
                 IF NOT (ga_upd_suspension_abonado_fn (pv_det_suspvolprog, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
                        RAISE error_ejecucion;
                 END IF;

         pv_camcom.num_os := pv_det_suspvolprog.num_os_sus;
         pv_camcom.fh_anula := SYSDATE;

         IF NOT (pv_upd_anula_camcom_fn (pv_camcom, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
         END IF;

         pv_erecorrido.num_os := pv_det_suspvolprog.num_os_sus;
         pv_erecorrido.tip_estado := 5;

         IF NOT (pv_upd_anula_erecorrido_fn (pv_erecorrido, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
            RAISE error_ejecucion;
         END IF;

         pv_camcom.num_os := pv_det_suspvolprog.num_os_reh;

         IF NOT (pv_upd_anula_camcom_fn (pv_camcom, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
         END IF;

         pv_erecorrido.num_os := pv_det_suspvolprog.num_os_reh;

         IF NOT (pv_upd_anula_erecorrido_fn (pv_erecorrido, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
         END IF;

                 IF NOT (ga_cal_dias_suspension_fn (pv_det_suspvolprog.num_abonado, pv_det_suspvolprog.num_periodosusp_1, pv_det_suspvolprog.num_periodosusp_2, pv_det_suspvolprog.fec_suspension, pv_det_suspvolprog.fec_rehabilitacion, pv_det_suspvolprog.dias_periodosusp_1, pv_det_suspvolprog.dias_periodosusp_2,sn_cod_retorno,sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
         END IF;

         IF NOT (ga_upd_diasacum_suspension_fn (pv_det_suspvolprog.num_periodosusp_1,pv_det_suspvolprog.num_abonado, 0- pv_det_suspvolprog.dias_periodosusp_1 ,sn_cod_retorno,sv_mens_retorno,sn_num_evento))THEN
            RAISE error_ejecucion;
         END IF;

         IF NOT (ga_upd_diasacum_suspension_fn (pv_det_suspvolprog.num_periodosusp_2,pv_det_suspvolprog.num_abonado, 0- pv_det_suspvolprog.dias_periodosusp_2 ,sn_cod_retorno,sv_mens_retorno,sn_num_evento))THEN
            RAISE error_ejecucion;
         END IF;

         pv_iorserv.num_os := pv_det_suspvolprog.num_os_sus;
             IF NOT (pv_upd_anula_iorserv_fn (pv_iorserv, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
                 RAISE error_ejecucion;
             END IF;

         pv_iorserv.num_os := pv_det_suspvolprog.num_os_reh;
             IF NOT (pv_upd_anula_iorserv_fn (pv_iorserv, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
                 RAISE error_ejecucion;
             END IF;

             IF NOT (pv_upd_fh_ejecucion_reh_fn (pv_det_suspvolprog, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
                 RAISE error_ejecucion;
             END IF;

      END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
         v_des_error     := 'pv_suspvolprog_pg.ga_anula_susvolprog_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_anula_susvolprog_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno  := '10039';
         sv_mens_retorno := 'Error: no determinado al anular suspensión';
         v_des_error     := 'pv_suspvolprog_pg.ga_anula_susvolprog_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_anula_susvolprog_pr', ssql, SQLCODE, v_des_error);
   END ga_anula_susvolprog_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_anulaXbatch_pr (
      pv_det_suspvolprog   IN OUT NOCOPY   pv_det_suspvolprog_qt,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      error_ejecucion   EXCEPTION;
      pv_camcom         pv_camcom_ot           := NEW pv_camcom_ot;
      pv_erecorrido     pv_erecorrido_qt       := NEW pv_erecorrido_qt;
      pv_iorserv        pv_iorserv_ot          := NEW pv_iorserv_ot;
      v_des_error       ge_errores_pg.desevent;
      ssql              ge_errores_pg.vquery;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      pv_det_suspvolprog.estado := 'ANU';

      IF NOT (ga_upd_suspension_abonado_fn (pv_det_suspvolprog, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;

      pv_camcom.num_os := pv_det_suspvolprog.num_os_sus;
      pv_camcom.fh_anula := SYSDATE;

      IF NOT (pv_upd_anula_camcom_fn (pv_camcom, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      pv_erecorrido.num_os := pv_det_suspvolprog.num_os_sus;
      pv_erecorrido.tip_estado := 5;
      pv_iorserv.num_os := pv_det_suspvolprog.num_os_sus;

          DELETE pv_erecorrido WHERE num_os=pv_det_suspvolprog.num_os_sus AND cod_estado <> 10;

      IF NOT (pv_upd_anula_erecorrido_fn (pv_erecorrido, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (pv_upd_anula_iorserv_fn (pv_iorserv, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;

      pv_camcom.num_os := pv_det_suspvolprog.num_os_reh;

      IF NOT (pv_upd_anula_camcom_fn (pv_camcom, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      pv_erecorrido.num_os := pv_det_suspvolprog.num_os_reh;
      pv_iorserv.num_os := pv_det_suspvolprog.num_os_reh;

      IF NOT (pv_upd_anula_erecorrido_fn (pv_erecorrido, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (pv_upd_anula_iorserv_fn (pv_iorserv, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;

     IF NOT (pv_upd_fh_ejecucion_reh_fn ( pv_det_suspvolprog, sn_cod_retorno, sv_mens_retorno, sn_num_evento))THEN
         RAISE error_ejecucion;
     END IF;

          /*IF NOT (ga_cal_dias_suspension_fn (pv_det_suspvolprog.num_abonado, pv_det_suspvolprog.num_periodosusp_1, pv_det_suspvolprog.num_periodosusp_2, pv_det_suspvolprog.fec_suspension, pv_det_suspvolprog.fec_rehabilitacion, pv_det_suspvolprog.dias_periodosusp_1, pv_det_suspvolprog.dias_periodosusp_2,sn_cod_retorno,sv_mens_retorno, sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (ga_upd_diasacum_suspension_fn (pv_det_suspvolprog.num_periodosusp_1,pv_det_suspvolprog.num_abonado, 1- pv_det_suspvolprog.dias_periodosusp_1 ,sn_cod_retorno,sv_mens_retorno,sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (ga_upd_diasacum_suspension_fn (pv_det_suspvolprog.num_periodosusp_2,pv_det_suspvolprog.num_abonado, 1- pv_det_suspvolprog.dias_periodosusp_2 ,sn_cod_retorno,sv_mens_retorno,sn_num_evento))THEN
         RAISE error_ejecucion;
      END IF;*/

   EXCEPTION
      WHEN error_ejecucion THEN
         v_des_error     := 'pv_suspvolprog_pg.ga_anulaXbatch_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_anulaXbatch_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno  := '10039';
         sv_mens_retorno := 'Error: no determinado al anular suspensión';
         v_des_error     := 'pv_suspvolprog_pg.ga_anulaXbatch_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_anulaXbatch_pr', ssql, SQLCODE, v_des_error);
   END ga_anulaXbatch_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_reg_hist_srvsupl_fn (
      en_cod_servicio   IN              ga_servsupl_cob_to.cod_servicio%TYPE,
      en_cod_servsupl   IN              ga_servsupl_cob_to.cod_servsupl%TYPE,
      sn_cod_error      OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2,
      sv_sql            OUT NOCOPY      VARCHAR2
   )
      RETURN BOOLEAN
   IS
   /*
   <Documentación
      TipoDoc = "FUNCTION">
      <Elemento
         Nombre = "PV_REG_HIST_SRVSUPL_FN"
         Lenguaje="PL/SQL"
         Fecha creación="Agosto 2008""
         Creado por="Jorge Marín"
         Fecha modificacion=""
         Modificado por=""
         Ambiente Desarrollo="BD">
         <Retorno>n/a</Retorno>
         <Descripción> Carga los servicios suplementarios nuevos en modelo de cobros de  Sersupl. </Descripción>
         <Parámetros>
            <Entrada>
            </Entrada>
            <Salida>
               <param nom="SN_COD_ERROR"       Tipo="NUMERICO">Numero de Reclamo a Generar</param>
               <param nom="SV_MENS_RETORNO"    Tipo="NUMERICO">Codigo de Retorno</param>
            </Salida>
         </Parámetros>
      </Elemento>
   </Documentación>
   */
   BEGIN
      sv_sql := ' insert into ga_servsupl_cob_th (cod_servicio,';
      sv_sql := sv_sql || ' cod_servsupl,';
      sv_sql := sv_sql || ' des_servicio,';
      sv_sql := sv_sql || ' fec_ingreso, ';
      sv_sql := sv_sql || ' fec_modifica,';
      sv_sql := sv_sql || ' cod_usuario, ';
      sv_sql := sv_sql || ' ind_cobro)  ';
      sv_sql := sv_sql || ' select serv.cod_servicio, ';
      sv_sql := sv_sql || '               serv.cod_servsupl, ';
      sv_sql := sv_sql || '               serv.des_servicio, ';
      sv_sql := sv_sql || '               serv.fec_ingreso, ';
      sv_sql := sv_sql || '               sysdate,                       ';
      sv_sql := sv_sql || '               user,                          ';
      sv_sql := sv_sql || gn_ncobrar;
      sv_sql := sv_sql || ' from  ga_servsupl_cob_to serv ';
      sv_sql := sv_sql || ' where serv.cod_servicio =''' || en_cod_servicio || '''';
      sv_sql := sv_sql || ' and   serv.cod_servsupl =' || en_cod_servsupl;
      sv_sql := sv_sql || ' union all';
      sv_sql := sv_sql || ' select serv.cod_servicio, ';
      sv_sql := sv_sql || '               serv.cod_servsupl, ';
      sv_sql := sv_sql || '               serv.des_servicio, ';
      sv_sql := sv_sql || '               sysdate,                       ';
      sv_sql := sv_sql || '               sysdate,                       ';
      sv_sql := sv_sql || '               user,                          ';
      sv_sql := sv_sql || gn_ncobrar;
      sv_sql := sv_sql || ' from  ga_servsupl serv ';
      sv_sql := sv_sql || ' where serv.cod_producto =' || gn_cod_producto;
      sv_sql := sv_sql || ' and   serv.cod_servicio =''' || en_cod_servicio || '''';
      sv_sql := sv_sql || ' and   serv.cod_servsupl =' || en_cod_servsupl;
      sv_sql := sv_sql || ' and    not exists (select cob.cod_servicio from ga_servsupl_cob_to cob';
      sv_sql := sv_sql || ' where  cob.cod_servicio = serv.cod_servicio';
      sv_sql := sv_sql || ' and    cob.cod_servsupl = serv.cod_servsupl)';

      INSERT INTO ga_servsupl_cob_th
                  (cod_servicio, cod_servsupl, des_servicio, fec_ingreso, fec_modifica, cod_usuario, ind_cobro)
         SELECT serv.cod_servicio, serv.cod_servsupl, serv.des_servicio, serv.fec_ingreso, SYSDATE, USER, gn_ncobrar
           FROM ga_servsupl_cob_to serv
          WHERE serv.cod_servicio = en_cod_servicio AND serv.cod_servsupl = en_cod_servsupl
         UNION ALL
         SELECT serv.cod_servicio, serv.cod_servsupl, serv.des_servicio, SYSDATE, SYSDATE, USER, gn_cobrar
           FROM ga_servsupl serv
          WHERE serv.cod_producto = gn_cod_producto
            AND serv.cod_servicio = en_cod_servicio
            AND serv.cod_servsupl = en_cod_servsupl
            AND NOT EXISTS (SELECT cob.cod_servicio
                              FROM ga_servsupl_cob_to cob
                             WHERE cob.cod_servicio = serv.cod_servicio AND cob.cod_servsupl = serv.cod_servsupl);

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_error := -1;
         sv_mens_retorno := 'PV_REG_HIST_SRVSUPL_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_reg_hist_srvsupl_fn;

-------------------------------------------------------------------------------------*/
   FUNCTION pv_reg_cobros_srvsupl_fn (
      en_cod_servicio   IN              ga_servsupl_cob_to.cod_servicio%TYPE,
      en_cod_servsupl   IN              ga_servsupl_cob_to.cod_servsupl%TYPE,
      sn_cod_error      OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2,
      sv_sql            OUT NOCOPY      VARCHAR2
   )
      RETURN BOOLEAN
   IS
   /*
   <Documentación
      TipoDoc = "FUNCTION">
      <Elemento
         Nombre = "PV_REG_COBROS_SRVSUPL_FN"
         Lenguaje="PL/SQL"
         Fecha creación="Agosto 2008""
         Creado por="Jorge Marín"
         Fecha modificacion=""
         Modificado por=""
         Ambiente Desarrollo="BD">
         <Retorno>n/a</Retorno>
         <Descripción> Carga los servicios suplementarios nuevos en modelo de cobros de  Sersupl. </Descripción>
         <Parámetros>
            <Entrada>
            </Entrada>
            <Salida>
               <param nom="SN_COD_ERROR"       Tipo="NUMERICO">Numero de Reclamo a Generar</param>
               <param nom="SV_MENS_RETORNO"    Tipo="NUMERICO">Codigo de Retorno</param>
            </Salida>
         </Parámetros>
      </Elemento>
   </Documentación>
   */
   BEGIN
      sv_sql := ' insert into ga_servsupl_cob_to (cod_servicio,';
      sv_sql := sv_sql || ' cod_servsupl,';
      sv_sql := sv_sql || ' des_servicio,';
      sv_sql := sv_sql || ' fec_ingreso, ';
      sv_sql := sv_sql || ' cod_usuario) ';
      sv_sql := sv_sql || ' select serv.cod_servicio, ';
      sv_sql := sv_sql || '               serv.cod_servsupl, ';
      sv_sql := sv_sql || '               serv.des_servicio, ';
      sv_sql := sv_sql || '               sysdate,                       ';
      sv_sql := sv_sql || '               user,                          ';
      sv_sql := sv_sql || gn_ncobrar;
      sv_sql := sv_sql || ' from  ga_servsupl serv ';
      sv_sql := sv_sql || ' where serv.cod_producto =' || gn_cod_producto;
      sv_sql := sv_sql || ' and   serv.cod_servicio =''' || en_cod_servicio || '''';
      sv_sql := sv_sql || ' and   serv.cod_servsupl =' || en_cod_servsupl;
      sv_sql := sv_sql || ' and    not exists (select cob.cod_servicio from ga_servsupl_cob_to cob';
      sv_sql := sv_sql || ' where  cob.cod_servicio = serv.cod_servicio';
      sv_sql := sv_sql || ' and    cob.cod_servsupl = serv.cod_servsupl)';

      INSERT INTO ga_servsupl_cob_to
                  (cod_servicio, cod_servsupl, des_servicio, fec_ingreso, cod_usuario)
         SELECT serv.cod_servicio, serv.cod_servsupl, serv.des_servicio, SYSDATE, USER
           FROM ga_servsupl serv
          WHERE serv.cod_producto = gn_cod_producto AND serv.cod_servicio = en_cod_servicio AND serv.cod_servsupl = en_cod_servsupl;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_error := -1;
         sv_mens_retorno := 'PV_REG_COBROS_SRVSUPL_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_reg_cobros_srvsupl_fn;

-------------------------------------------------------------------------------------*/
   FUNCTION pv_del_cobros_srvsupl_fn (
      en_cod_servicio   IN              ga_servsupl_cob_to.cod_servicio%TYPE,
      en_cod_servsupl   IN              ga_servsupl_cob_to.cod_servsupl%TYPE,
      sn_cod_error      OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2,
      sv_sql            OUT NOCOPY      VARCHAR2
   )
      RETURN BOOLEAN
   IS
   /*
   <Documentación
      TipoDoc = "FUNCTION">
      <Elemento
         Nombre = "PV_DEL_COBROS_SRVSUPL_FN"
         Lenguaje="PL/SQL"
         Fecha creación="Agosto 2008""
         Creado por="Jorge Marín"
         Fecha modificacion=""
         Modificado por=""
         Ambiente Desarrollo="BD">
         <Retorno>n/a</Retorno>
         <Descripción> Carga los servicios suplementarios nuevos en modelo de cobros de  Sersupl. </Descripción>
         <Parámetros>
            <Entrada>
            </Entrada>
            <Salida>
               <param nom="SN_COD_ERROR"       Tipo="NUMERICO">Numero de Reclamo a Generar</param>
               <param nom="SV_MENS_RETORNO"    Tipo="NUMERICO">Codigo de Retorno</param>
            </Salida>
         </Parámetros>
      </Elemento>
   </Documentación>
   */
   BEGIN
      sv_mens_retorno := '';
      sv_sql := ' delete from ga_servsupl_cob_to serv';
      sv_sql := sv_sql || ' where serv.cod_servicio =''' || en_cod_servicio || '''';
      sv_sql := sv_sql || ' and   serv.cod_servsupl =' || en_cod_servsupl;

      DELETE FROM ga_servsupl_cob_to serv
            WHERE serv.cod_servicio = en_cod_servicio AND serv.cod_servsupl = en_cod_servsupl;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_error := -1;
         sv_mens_retorno := 'PV_DEL_COBROS_SRVSUPL_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_del_cobros_srvsupl_fn;

/*-------------------------------------------------------------------------------------*/
   FUNCTION pv_rec_cobros_srvsupl_fn (
      en_cod_servicio   IN              ga_servsupl_cob_to.cod_servicio%TYPE,
      en_cod_servsupl   IN              ga_servsupl_cob_to.cod_servsupl%TYPE,
      sc_cursor         OUT NOCOPY      refcursor,
      sn_cod_error      OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2,
      sv_sql            OUT NOCOPY      VARCHAR2
   )
      RETURN BOOLEAN
   IS
   BEGIN
      sv_mens_retorno := '';
      sv_sql := sv_sql || ' select to_char(cob.cod_servsupl), ';
      sv_sql := sv_sql || '               serv.cod_servicio, ';
      sv_sql := sv_sql || '               serv.des_servicio, ';
      sv_sql := sv_sql || '               serv.fec_ingreso, ';
      sv_sql := sv_sql || '               sysdate,                       ';
      sv_sql := sv_sql || '               user,                          ';
      sv_sql := sv_sql || ' from  ga_servsupl_cob_to serv ';
      sv_sql := sv_sql || ' where serv.cod_servicio =nvl(''' || en_cod_servicio || ''',cob.cod_servicio)';
      sv_sql := sv_sql || ' and   serv.cod_servsupl =nvl(' || en_cod_servsupl || '  ,cob.cod_servsupl)';
      sv_sql := sv_sql || ' order by cob.des_servicio;';

      OPEN sc_cursor FOR
         SELECT   TO_CHAR (cob.cod_servsupl), cob.cod_servicio, cob.des_servicio, cob.fec_ingreso
             FROM ga_servsupl_cob_to cob
            WHERE cob.cod_servicio = NVL (en_cod_servicio, cob.cod_servicio) AND cob.cod_servsupl = NVL (en_cod_servsupl, cob.cod_servsupl)
         ORDER BY cob.des_servicio;

      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_error := -2;
         sv_mens_retorno := 'PV_REC_COBROS_SRVSUPL_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_error := -2;
         sv_mens_retorno := 'PV_REC_COBROS_SRVSUPL_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_rec_cobros_srvsupl_fn;

/*-------------------------------------------------------------------------------------*/
   FUNCTION pv_rec_srvsupl_fn (
      en_cod_servicio   IN              ga_servsupl_cob_to.cod_servicio%TYPE,
      en_cod_servsupl   IN              ga_servsupl_cob_to.cod_servsupl%TYPE,
      sc_cursor         OUT NOCOPY      refcursor,
      sn_cod_error      OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2,
      sv_sql            OUT NOCOPY      VARCHAR2
   )
      RETURN BOOLEAN
   IS
   BEGIN
      sv_mens_retorno := '';
      sv_sql := sv_sql || ' select to_char(cob.cod_servsupl), ';
      sv_sql := sv_sql || '               serv.cod_servicio, ';
      sv_sql := sv_sql || '               serv.des_servicio, ';
      sv_sql := sv_sql || '''' || gv_blanco || '''';
      sv_sql := sv_sql || ' from  ga_servsupl_cob_to serv ';
      sv_sql := sv_sql || ' where serv.cod_servicio =nvl(''' || en_cod_servicio || ''',cob.cod_servicio)';
      sv_sql := sv_sql || ' and   serv.cod_servsupl =nvl(' || en_cod_servsupl || '  ,cob.cod_servsupl)';
      sv_sql := sv_sql || ' not exists (select cob.cod_servicio from ga_servsupl_cob_to cob                        ';
      sv_sql := sv_sql || ' where  cob.cod_servicio = serv.cod_servicio                                                            ';
      sv_sql := sv_sql || ' and    cob.cod_servsupl = serv.cod_servsupl)                                                                   ';
      sv_sql := sv_sql || ' order by cob.des_servicio;';

      OPEN sc_cursor FOR
         SELECT   TO_CHAR (serv.cod_servsupl), serv.cod_servicio, serv.des_servicio, ' '
             FROM ga_servsupl serv
            WHERE serv.cod_servicio = NVL (en_cod_servicio, serv.cod_servicio)
              AND serv.cod_servsupl = NVL (en_cod_servsupl, serv.cod_servsupl)
              AND NOT EXISTS (SELECT cob.cod_servicio
                                FROM ga_servsupl_cob_to cob
                               WHERE cob.cod_servicio = serv.cod_servicio AND cob.cod_servsupl = serv.cod_servsupl)
         ORDER BY 3;

      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_error := -2;
         sv_mens_retorno := 'PV_REC_SRVSUPL_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_error := -2;
         sv_mens_retorno := 'PV_REC_SRVSUPL_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_rec_srvsupl_fn;

/*-------------------------------------------------------------------------------------*/
   PROCEDURE pv_recupera_servsupl_cob_pr (
      en_cod_servsupl   IN              ga_servsupl_cob_to.cod_servsupl%TYPE,
      en_cod_servicio   IN              ga_servsupl_cob_to.cod_servicio%TYPE,
      sc_cursor         OUT NOCOPY      refcursor,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2
   )
   IS
      /*
      <Documentación
         TipoDoc = "PROCEDURE">
         <Elemento
            Nombre = "PV_RECUPERA_SERVSUPL_COB_PR"
            Lenguaje="PL/SQL"
            Fecha creación="Agosto 2008"
            Creado por="Jorge Marín."
            Fecha modificacion=""
            Modificado por=""
            Ambiente Desarrollo="BD">
            <Retorno>n/a</Retorno>
            <Descripción> Recupera información de servicios suplementarios</Descripción>
            <Parámetros>
               <Salida>
                  <param nom="SV_MENS_RETORNO"       Tipo="NUMERICO">Codigo de Retorno</param>
                  <param nom="SN_NUM_EVENTO"      Tipo="CARACTER">Mensaje de Retorno</param>
               </Salida>
            </Parámetros>
         </Elemento>
      </Documentación>
      */
      lv_sql            VARCHAR2 (2000);
      ln_cod_error      NUMBER;
      sn_num_evento     NUMBER;
      error_funcion     EXCEPTION;
      lb_error          BOOLEAN;
      lv_mens_retorno   VARCHAR2 (2000);
   BEGIN
      ln_cod_error := 0;
      sv_mens_retorno := 'PV_RECUPERA_SERVSUPL_COB_PR';
      sn_num_evento := 0;

      IF NOT pv_rec_cobros_srvsupl_fn (en_cod_servicio, en_cod_servsupl, sc_cursor, ln_cod_error, sv_mens_retorno, lv_sql)THEN
         RAISE error_funcion;
      END IF;

   EXCEPTION
      WHEN error_funcion THEN
         IF NOT ge_errores_pg.mensajeerror (ln_cod_error, gv_mensaje_retorno) THEN
            gv_mensaje_retorno := SQLERRM;
         END IF;
         --sv_mens_retorno := gv_mensaje_retorno;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, gv_cod_modulo, gv_mensaje_retorno, gv_version, USER, 'PV_SUSPVOLPROG_PG.GA_ACTUALIZA_BALANCE_PR', lv_sql, ln_cod_error, sv_mens_retorno);
         ROLLBACK;
      WHEN OTHERS THEN
         ln_cod_error := 1897;
         IF NOT ge_errores_pg.mensajeerror (ln_cod_error, gv_mensaje_retorno) THEN
            gv_mensaje_retorno := SQLERRM;
         END IF;
         --sv_mens_retorno := gv_mensaje_retorno;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, gv_cod_modulo, gv_mensaje_retorno, gv_version, USER, 'PV_SUSPVOLPROG_PG.GA_ACTUALIZA_BALANCE_PR', lv_sql, ln_cod_error, sv_mens_retorno);
         ROLLBACK;
   END pv_recupera_servsupl_cob_pr;

/*-------------------------------------------------------------------------------------*/
   PROCEDURE pv_recupera_servsupl_pr (
      en_cod_servsupl   IN              ga_servsupl_cob_to.cod_servsupl%TYPE,
      en_cod_servicio   IN              ga_servsupl_cob_to.cod_servicio%TYPE,
      sc_cursor         OUT NOCOPY      refcursor,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2
   )
   IS
      /*
      <Documentación
         TipoDoc = "PROCEDURE">
         <Elemento
            Nombre = "PV_RECUPERA_SERVSUPL_COB_PR"
            Lenguaje="PL/SQL"
            Fecha creación="Agosto 2008"
            Creado por="Jorge Marín."
            Fecha modificacion=""
            Modificado por=""
            Ambiente Desarrollo="BD">
            <Retorno>n/a</Retorno>
            <Descripción> Recupera información de servicios suplementarios</Descripción>
            <Parámetros>
               <Salida>
                  <param nom="SV_MENS_RETORNO"       Tipo="NUMERICO">Codigo de Retorno</param>
                  <param nom="SN_NUM_EVENTO"      Tipo="CARACTER">Mensaje de Retorno</param>
               </Salida>
            </Parámetros>
         </Elemento>
      </Documentación>
      */
      lv_sql            VARCHAR2 (2000);
      ln_cod_error      NUMBER;
      error_funcion     EXCEPTION;
      lb_error          BOOLEAN;
      lv_mens_retorno   VARCHAR2 (2000);
      sn_num_evento     NUMBER;
   BEGIN
      ln_cod_error := 0;
      sv_mens_retorno := 'PV_RECUPERA_SERVSUPL_PR';
      sn_num_evento := 0;

      IF NOT pv_rec_srvsupl_fn (en_cod_servicio, en_cod_servsupl, sc_cursor, ln_cod_error, sv_mens_retorno, lv_sql) THEN
         RAISE error_funcion;
      END IF;
   EXCEPTION
      WHEN error_funcion THEN
         IF NOT ge_errores_pg.mensajeerror (ln_cod_error, gv_mensaje_retorno) THEN
            gv_mensaje_retorno := SQLERRM;
         END IF;
         --sv_mens_retorno := gv_mensaje_retorno;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, gv_cod_modulo, gv_mensaje_retorno, gv_version, USER, 'PV_SUSPVOLPROG_PG.GA_ACTUALIZA_BALANCE_PR', lv_sql, ln_cod_error, sv_mens_retorno);
         ROLLBACK;
      WHEN OTHERS THEN
         ln_cod_error := 1897;
         IF NOT ge_errores_pg.mensajeerror (ln_cod_error, gv_mensaje_retorno) THEN
            gv_mensaje_retorno := SQLERRM;
         END IF;
         --sv_mens_retorno := gv_mensaje_retorno;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, gv_cod_modulo, gv_mensaje_retorno, gv_version, USER, 'PV_SUSPVOLPROG_PG.GA_ACTUALIZA_BALANCE_PR', lv_sql, ln_cod_error, sv_mens_retorno);
         ROLLBACK;
   END pv_recupera_servsupl_pr;

/*---------------------------------------------------------------------------------------------------------------------------------*/
   PROCEDURE pv_modifica_servcob_pr (
      en_cod_servsupl   IN              ga_servsupl_cob_to.cod_servsupl%TYPE,
      en_cod_servicio   IN              ga_servsupl_cob_to.cod_servicio%TYPE,
      en_ind_cob        IN              NUMBER,
      sn_num_evento     OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2
   )
   IS
      /*
      <Documentación
         TipoDoc = "PROCEDURE">
         <Elemento
            Nombre = "PV_MODIFICA_SERVCOB_PR"
            Lenguaje="PL/SQL"
            Fecha creación="Agosto 2008"
            Creado por="Jorge Marín."
            Fecha modificacion=""
            Modificado por=""
            Ambiente Desarrollo="BD">
            <Retorno>n/a</Retorno>
            <Descripción> Recupera información de servicios suplementarios</Descripción>
            <Parámetros>
               <Salida>
                  <param nom="SV_MENS_RETORNO"       Tipo="NUMERICO">Codigo de Retorno</param>
                  <param nom="SN_NUM_EVENTO"      Tipo="CARACTER">Mensaje de Retorno</param>
               </Salida>
            </Parámetros>
         </Elemento>
      </Documentación>
      */
      lv_sql            VARCHAR2 (2000);
      ln_cod_error      NUMBER;
      error_funcion     EXCEPTION;
      lb_error          BOOLEAN;
      lv_mens_retorno   VARCHAR2 (2000);
   BEGIN
      ln_cod_error := 0;
      sv_mens_retorno := 'PV_RECUPERA_SERVSUPL_PR';
      sn_num_evento := 0;

      IF en_ind_cob = gn_cobrar THEN
         IF NOT pv_reg_hist_srvsupl_fn (en_cod_servicio, en_cod_servsupl, ln_cod_error, sv_mens_retorno, lv_sql) THEN
            RAISE error_funcion;
         END IF;

         IF NOT pv_reg_cobros_srvsupl_fn (en_cod_servicio, en_cod_servsupl, ln_cod_error, sv_mens_retorno, lv_sql) THEN
            RAISE error_funcion;
         END IF;
      ELSE
         IF NOT pv_reg_hist_srvsupl_fn (en_cod_servicio, en_cod_servsupl, ln_cod_error, sv_mens_retorno, lv_sql) THEN
            RAISE error_funcion;
         END IF;

         IF NOT pv_del_cobros_srvsupl_fn (en_cod_servicio, en_cod_servsupl, ln_cod_error, sv_mens_retorno, lv_sql) THEN
            RAISE error_funcion;
         END IF;
      END IF;

   EXCEPTION
      WHEN error_funcion THEN
         IF NOT ge_errores_pg.mensajeerror (ln_cod_error, gv_mensaje_retorno) THEN
            gv_mensaje_retorno := SQLERRM;
         END IF;
         --sv_mens_retorno := gv_mensaje_retorno;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, gv_cod_modulo, gv_mensaje_retorno, gv_version, USER, 'PV_SUSPVOLPROG_PG.GA_ACTUALIZA_BALANCE_PR', lv_sql, ln_cod_error, sv_mens_retorno);
         ROLLBACK;
      WHEN OTHERS THEN
         ln_cod_error := 1897;
         IF NOT ge_errores_pg.mensajeerror (ln_cod_error, gv_mensaje_retorno) THEN
            gv_mensaje_retorno := SQLERRM;
         END IF;
         --sv_mens_retorno := gv_mensaje_retorno;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, gv_cod_modulo, gv_mensaje_retorno, gv_version, USER, 'PV_SUSPVOLPROG_PG.GA_ACTUALIZA_BALANCE_PR', lv_sql, ln_cod_error, sv_mens_retorno);
         ROLLBACK;
   END pv_modifica_servcob_pr;
/*-------------------------------------------------------------------------------------*/

   PROCEDURE ga_rehabilita_pr (
      pv_det_suspvolprog IN OUT NOCOPY pv_det_suspvolprog_qt,
          EN_num_oosss       IN pv_iorserv.num_os%TYPE,
          EV_cod_os          IN pv_iorserv.cod_os%TYPE,
          SN_cod_retorno     OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno    OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      SN_num_evento      OUT NOCOPY   ge_errores_pg.evento
   )
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "ga_rehabilita_pr"
      Fecha modificacion=" "
      Fecha creacion="22-07-2008"
      Programador=""
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion></Descripcion>
      <Parametros>
         <Entrada>
            <param nom="ev_modulo" Tipo="CARACTER">Identificador de módulo</param>
            <param nom="en_correlativo" Tipo="NUMERICO">Correlativo</param>
            <param nom="ev_param_entrada" Tipo="NUMERICO">String de entrada</param>
         </Entrada>
         <Salida>
            <param nom="sv_resultado" Tipo="CARACTER">Resultado obtenido</param>
            <param nom="sn_cod_retorno" Tipo="NUMERICO">Código de retorno</param>
            <param nom="sv_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="sn_num_evento" Tipo="NUMERICO">Número de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
AS
V_des_error            ge_errores_pg.DesEvent;
sSql                   ge_errores_pg.vQuery;
LN_num_peticion        ga_susprehabo.num_peticion%type;
LV_cod_cargobasico         ga_susprehabo.cod_cargobasico%type;
LN_cod_cliente         ga_abocel.cod_cliente%type;
LN_num_abonado         ga_abocel.num_abonado%type;
LV_cod_actabo          VARCHAR2(3):= 'RT';
LN_num_transacabo      NUMBER;
LN_num_error           NUMBER;
LN_porcentaje_cobro    NUMBER;
LN_monto_cargobas      TA_CARGOSBASICO.IMP_CARGOBASICO%type;
LN_monto_ge_cargo      NUMBER;
LN_cod_producto        GA_ABOCEL.COD_PRODUCTO%type;
LV_cod_moneda          TA_CARGOSBASICO.COD_MONEDA%type;
LV_concepto_cargo      GED_PARAMETROS.VAL_PARAMETRO%type;
LN_concepto_cargo      NUMBER;
LN_seccargo            NUMBER;
LN_num_periodosusp_1   PV_DET_SUSPVOLPROG_TO.NUM_PERIODOSUSP_1%type;
LN_num_periodosusp_2   PV_DET_SUSPVOLPROG_TO.NUM_PERIODOSUSP_2%type;
LN_cod_retorno             ge_errores_td.cod_msgerror%type;
LV_mens_retorno            ge_errores_td.det_msgerror%type;
LN_num_evento              NUMBER;
LN_dias_periodosusp_1  PV_DET_SUSPVOLPROG_TO.DIAS_PERIODOSUSP_1%type;
LN_dias_periodosusp_2  PV_DET_SUSPVOLPROG_TO.DIAS_PERIODOSUSP_2%type;
LN_dias_suspension     NUMBER;
LN_fec_fincontra       NUMBER;
LN_fec_sysdate         NUMBER;
LV_cod_ciclo           GA_ABOCEL.COD_CICLO%type;
LN_cod_ciclfact        FA_CICLFACT.COD_CICLFACT%type;
LN_sumadias                        NUMBER := 0;
LN_diasUtilizados          NUMBER := 0;
LD_fechaSusp               DATE;
LD_fechaReha               DATE;
iDiasAcumulados_1 NUMBER;
iDiasAcumulados_2 NUMBER;
LV_CAUSA          GA_SUSPREHABO.COD_CAUSUSP%TYPE;
LV_CAUSA_REV      GA_LISTACAUSAEIR_TD.COD_CAUSA%TYPE;
LV_NUM_SERIE      GA_LNCELU.NUM_SERIE%TYPE;


cursor c1 is
SELECT  NUM_SERIE
FROM  GA_LNCELU  WHERE   NUM_ABONADO =LN_num_abonado;


ERROR_PROCESO    EXCEPTION;

BEGIN

    SN_cod_retorno := '0';
    SN_num_evento  :=  0;
    SV_mens_retorno:= 'OK';
        LN_num_abonado := pv_det_suspvolprog.num_abonado;
        LN_num_periodosusp_1:=pv_det_suspvolprog.num_periodosusp_1;
        LN_num_periodosusp_2:=pv_det_suspvolprog.num_periodosusp_2;

        /* Obtiene data de la suspension */
        sSQL:='SELECT a.num_peticion, a.cod_cargobasico ';
        sSQL:= sSQL || 'FROM GA_SUSPREHABO A ';
        sSQL:= sSQL || 'WHERE A.COD_SERVSUPL IS NULL ';
        sSQL:= sSQL || 'AND A.COD_NIVEL IS NULL ';
        sSQL:= sSQL || 'AND A.NUM_ABONADO = '||LN_num_abonado;
        sSQL:= sSQL || 'AND A.TIP_SUSP = T ';
        sSQL:= sSQL || 'AND A.COD_MODULO = GA ';
        sSQL:= sSQL || 'AND A.IND_SINIESTRO = 0 ';
        sSQL:= sSQL || 'AND A.FEC_REHABD IS NULL ';
        SELECT a.num_peticion, a.cod_cargobasico,COD_CAUSUSP
        into   LN_num_peticion , LV_cod_cargobasico,LV_CAUSA
        FROM GA_SUSPREHABO A
        WHERE A.COD_SERVSUPL IS NULL
        AND A.COD_NIVEL IS NULL
        AND A.NUM_ABONADO = LN_num_abonado
        AND A.TIP_SUSP = 'T'
        AND A.COD_MODULO = 'GA'
        AND A.IND_SINIESTRO = 0
        AND A.FEC_REHABD IS NULL;


        /* Obtiene data del abonado y del cargo basico */
        sSQL:='A.COD_CLIENTE , B.IMP_CARGOBASICO, A.COD_PRODUCTO, B.COD_MONEDA,';
        sSQL:= sSQL || 'TO_NUMBER(TO_CHAR(FEC_FINCONTRA,YYYYMMDD)),TO_NUMBER(TO_CHAR(SYSDATE,YYYYMMDD)),';
        sSQL:= sSQL || 'FROM GA_ABOCEL WHERE NUM_ABONADO = '||LN_num_abonado;
    SELECT A.COD_CLIENTE , B.IMP_CARGOBASICO, A.COD_PRODUCTO, B.COD_MONEDA,
                    TO_NUMBER(TO_CHAR(FEC_FINCONTRA,'YYYYMMDD')),TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD')),
                    A.COD_CICLO
    INTO  LN_cod_cliente, LN_monto_cargobas, LN_cod_producto, LV_cod_moneda,
                    LN_fec_fincontra, LN_fec_sysdate, LV_cod_ciclo
    FROM  GA_ABOCEL A, TA_CARGOSBASICO B
    WHERE A.NUM_ABONADO = LN_num_abonado
    AND   A.COD_PRODUCTO = B.COD_PRODUCTO
    AND   A.COD_CARGOBASICO = B.COD_CARGOBASICO
    AND   SYSDATE BETWEEN B.FEC_DESDE AND B.FEC_HASTA;


        sSQL:='SELECT GA_SEQ_TRANSACABO.NEXTVAL';
        SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transacabo FROM DUAL;

        sSQL:='SELECT PV_ERRORES_SQ.NEXTVAL';
    SELECT PV_ERRORES_SQ.NEXTVAL INTO LN_num_error FROM DUAL;

        IF (LV_cod_cargobasico IS NOT NULL) OR (LV_cod_cargobasico<>'') THEN
                /* ejecuta pl para cambiar el cargo basico de cliente dejando el anterior que tenia antes de la suspension */
                sSQL:='P_INTERFASES_ABONADOS';
                P_INTERFASES_ABONADOS(LN_num_transacabo, 'CB', 1, LN_num_abonado, 'R', LV_cod_cargobasico, '');
        END IF;

        LV_CAUSA_REV:= NULL;
        BEGIN

            select cod_causa
            INTO LV_CAUSA_REV
            From GA_LISTACAUSAEIR_TD
            where   cod_tipolista ='B'
            and    cod_os ='10096'
            and    ind_causa ='2'
            and sysdate between fec_desde and fec_hasta;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
               NULL;
        END;


        IF (EV_cod_os ='10096' AND TRIM(LV_CAUSA_REV) IS NOT NULL) THEN

                 open c1;
                 LOOP
                 LV_NUM_SERIE:='';
                 FETCH C1 INTO LV_NUM_SERIE;
                 EXIT WHEN C1%NOTFOUND;


                        UPDATE  GA_CAUSAEIR_TO
                        SET
                        COD_estado ='1'
                        ,NOM_USUARIO= USER
                        ,COD_OS_REV= '10096'
                        ,COD_CAUSA_OS_REV=  LV_CAUSA
                        ,COD_CAUSA_REV=  LV_CAUSA_REV
                        WHERE NUM_serie = LV_NUM_SERIE
                        and cod_estado = '0';
                END LOOP;
                CLOSE C1;
        END IF;

              --elimina de listas negras
        DELETE GA_LNCELU  WHERE   NUM_ABONADO =LN_num_abonado;

        sSQL:='SELECT GA_SEQ_TRANSACABO.NEXTVAL';
        SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transacabo FROM DUAL;
    /* ejecuta la rehabilitacion de postventa */
        sSQL:='PV_REHABILITACION_PG.PV_EJECUTA_OOSS_PR';
        PV_REHABILITACION_PG.PV_EJECUTA_OOSS_PR(LN_num_transacabo, LV_cod_actabo, LN_num_peticion, 'RTP', LN_num_abonado, 'GA', 3, 2);

   BEGIN
                sSQL:='SELECT COD_CICLFACT';
                sSQL:= sSQL || 'FROM   FA_CICLFACT';
                sSQL:= sSQL || 'WHERE  COD_CICLO ='||LV_cod_ciclo;
                sSQL:= sSQL || 'AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM';
            SELECT COD_CICLFACT
            INTO   LN_cod_ciclfact
            FROM   FA_CICLFACT
            WHERE  COD_CICLO = LV_cod_ciclo
            AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

                sSQL:='UPDATE GA_INFACCEL SET';
                sSQL:= sSQL || 'IND_BLOQUEO = 0';
                sSQL:= sSQL || 'WHERE  COD_CLIENTE ='||LN_cod_cliente;
                sSQL:= sSQL || 'AND    NUM_ABONADO ='||LN_num_abonado;
                sSQL:= sSQL || 'AND    COD_CICLFACT='||LN_cod_ciclfact;
                UPDATE GA_INFACCEL SET
                       IND_BLOQUEO = 0
            WHERE  COD_CLIENTE = LN_cod_cliente
                AND    NUM_ABONADO = LN_num_abonado
                AND    COD_CICLFACT= LN_cod_ciclfact;

   EXCEPTION
       WHEN NO_DATA_FOUND THEN
       NULL;
   END;


        /* obtiene parametro para el porcentaje de cobro de reconexion */
        sSQL:='SELECT VAL_PARAMETRO';
        sSQL:= sSQL || 'FROM  GED_PARAMETROS';
        sSQL:= sSQL || 'WHERE NOM_PARAMETRO = POR_COBRO_RECONPROG';
        SELECT VAL_PARAMETRO
        INTO  LN_porcentaje_cobro
        FROM  GED_PARAMETROS
        WHERE NOM_PARAMETRO = 'POR_COBRO_RECONPROG';

        /* obtiene parametro de concepto de rehabilitacion de PV para generar cargos */
        sSQL:='SELECT a.cod_concepto';
        sSQL:= sSQL || ' FROM ga_actuaserv a';
        sSQL:= sSQL || ' WHERE cod_producto = 1 AND';
        sSQL:= sSQL || ' a.cod_actabo=''RT'' AND';
        sSQL:= sSQL || ' a.cod_tipserv = ''1'' AND';
        sSQL:= sSQL || ' a.cod_servicio = ''05''';

    SELECT a.cod_concepto
    INTO  LN_concepto_cargo
        FROM ga_actuaserv a
        WHERE a.cod_producto = 1 AND
                  a.cod_actabo = 'RT' AND
                  a.cod_tipserv = '1' AND
                  a.cod_servicio = '05';

        LV_concepto_cargo:=LN_concepto_cargo;

        /* obtiene el monto del cargo a generar segun el porcentaje del cobro de reconexion */
        LN_monto_ge_cargo:=(LN_monto_cargobas*LN_porcentaje_cobro)/100;

        sSQL:='SELECT GE_SEQ_CARGOS.NEXTVAL';
        SELECT GE_SEQ_CARGOS.NEXTVAL INTO LN_seccargo FROM DUAL;

    /* ejecuta PL para generar cargos */
        sSQL:='Co_Gen_Cargo()';
        Co_Gen_Cargo(LN_cod_cliente, LN_num_abonado, LV_concepto_cargo, LN_monto_ge_cargo, LV_cod_moneda, LN_cod_producto, LN_seccargo, LN_cod_ciclfact);

     SELECT dias_periodosusp_1
     INTO  iDiasAcumulados_1
     FROM pv_det_suspvolprog_to
     WHERE num_abonado = pv_det_suspvolprog.num_abonado
         AND  num_periodosusp_1 = pv_det_suspvolprog.num_periodosusp_1
		 AND num_det_sus_vol_prg = pv_det_suspvolprog.num_det_sus_vol_prg;

     UPDATE pv_suspvolprog_to
     SET dias_acum = dias_acum - iDiasAcumulados_1
     WHERE num_periodosusp = pv_det_suspvolprog.num_periodosusp_1
     AND num_abonado = pv_det_suspvolprog.num_abonado;

     IF pv_det_suspvolprog.num_periodosusp_1 != pv_det_suspvolprog.num_periodosusp_2 THEN

         SELECT dias_periodosusp_2
         INTO  iDiasAcumulados_2
         FROM pv_det_suspvolprog_to
         WHERE num_abonado = pv_det_suspvolprog.num_abonado
                 AND  num_periodosusp_2 = pv_det_suspvolprog.num_periodosusp_2
				 AND  num_det_sus_vol_prg = pv_det_suspvolprog.num_det_sus_vol_prg;

         UPDATE pv_suspvolprog_to
         SET dias_acum = dias_acum - iDiasAcumulados_2
         WHERE num_periodosusp = pv_det_suspvolprog.num_periodosusp_2
         AND num_abonado = pv_det_suspvolprog.num_abonado;

         END IF;


        SELECT fec_suspension
        INTO LD_fechaSusp
        FROM pv_det_suspvolprog_to
        WHERE num_det_sus_vol_prg = pv_det_suspvolprog.num_det_sus_vol_prg
        AND       estado IN ('ANU', 'SUS');


        /*LN_sumadias := pv_det_suspvolprog.dias_periodosusp_1 + pv_det_suspvolprog.dias_periodosusp_2;*/

        LN_diasUtilizados := (TRUNC (pv_det_suspvolprog.fec_rehabilitacion) - LD_fechaSusp);

        IF LN_diasUtilizados >= pv_det_suspvolprog.dias_periodosusp_1 THEN
                pv_det_suspvolprog.dias_periodosusp_2 := LN_diasUtilizados - pv_det_suspvolprog.dias_periodosusp_1;
        ELSE -- esta es la condición tácita que hay aquí IF LN_diasUtilizados < pv_det_suspvolprog.dias_periodosusp_1 THEN
                pv_det_suspvolprog.dias_periodosusp_2 := 0;
                pv_det_suspvolprog.dias_periodosusp_1 := LN_diasUtilizados;
        END IF;

        /*IF pv_det_suspvolprog.fec_rehabilitacion <> TRUNC(SYSDATE) THEN
           pv_det_suspvolprog.fec_rehabilitacion := TRUNC(SYSDATE);
        END IF;*/

        /* ejecuta PL que actualiza fecha de rehabilitacion, fecha de actualizacion y usuario */
        sSQL:='pv_suspvolprog_pg.ga_upd_suspension_abonado_pr()';
        IF NOT (ga_upd_suspension_abonado_fn(pv_det_suspvolprog, LN_cod_retorno, LV_mens_retorno, LN_num_evento)) THEN
           RAISE ERROR_PROCESO;
        END IF;

    SELECT dias_periodosusp_1
    INTO  iDiasAcumulados_1
    FROM pv_det_suspvolprog_to
    WHERE num_abonado = pv_det_suspvolprog.num_abonado
    AND  num_periodosusp_1 = pv_det_suspvolprog.num_periodosusp_1
	AND num_det_sus_vol_prg = pv_det_suspvolprog.num_det_sus_vol_prg;

    UPDATE pv_suspvolprog_to
    SET dias_acum = dias_acum + iDiasAcumulados_1
    WHERE num_periodosusp = pv_det_suspvolprog.num_periodosusp_1
    AND num_abonado = pv_det_suspvolprog.num_abonado;

    IF pv_det_suspvolprog.num_periodosusp_1 != pv_det_suspvolprog.num_periodosusp_2 THEN

        SELECT dias_periodosusp_2
        INTO  iDiasAcumulados_2
        FROM pv_det_suspvolprog_to
        WHERE num_abonado = pv_det_suspvolprog.num_abonado
            AND  num_periodosusp_2 = pv_det_suspvolprog.num_periodosusp_2
			AND num_det_sus_vol_prg = pv_det_suspvolprog.num_det_sus_vol_prg;

        UPDATE pv_suspvolprog_to
        SET dias_acum = dias_acum + iDiasAcumulados_2
        WHERE num_periodosusp = pv_det_suspvolprog.num_periodosusp_2
        AND num_abonado = pv_det_suspvolprog.num_abonado;

    END IF;


    LN_dias_suspension:=0;
        /* valida si la fecha de fin  de contrato del abonado esta aun vigente*/
        IF LN_fec_fincontra>=LN_fec_sysdate THEN
       LN_dias_suspension:=LN_diasUtilizados;
    END IF;

        /* actualiza el campo fec_fincontra del abonado sumando los dias de la suspension programada */
        sSQL:='UPDATE GA_ABOCEL SET';
        sSQL:= sSQL || 'FEC_FINCONTRA=FEC_FINCONTRA+'|| LN_dias_suspension;
        sSQL:= sSQL || 'WHERE NUM_ABONADO = '||LN_num_abonado;
        UPDATE GA_ABOCEL SET
               FEC_FINCONTRA=FEC_FINCONTRA+LN_dias_suspension,
                   IND_DISP = 1
    WHERE  NUM_ABONADO = LN_num_abonado;


EXCEPTION
   WHEN ERROR_PROCESO THEN
      SN_cod_retorno := '1';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_rehabilita_pr( ); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_rehabilita_pr', sSql, SQLCODE, V_des_error );
   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := '218';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_rehabilita_pr( ); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_rehabilita_pr', sSql, SQLCODE, V_des_error );
   WHEN OTHERS THEN
      SN_cod_retorno := '110';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_rehabilita_pr( ); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.ga_rehabilita_pr', sSql, SQLCODE, V_des_error );


END ga_rehabilita_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE pv_val_siniestro_pendiente_pr(
      v_param_entrada IN  VARCHAR2,
      bRESULTADO      OUT NOCOPY VARCHAR2,
      vMENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
   )
   IS
      string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
      nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
      o_dat_abo         pv_datos_abo_qt := NEW pv_datos_abo_qt;
          n_cant_siniestro_serie  NUMBER;
          n_cant_siniestro_imei   NUMBER;
          SN_cod_retorno          NUMBER;
          SV_mens_retorno         VARCHAR2(200);
          SN_num_evento           NUMBER;
          LN_icount               NUMBER;
          error_ejecucion         EXCEPTION;
   BEGIN

      GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
      nABONADO         := -1;
      nABONADO         := TO_NUMBER(string(5));
      bRESULTADO  := 'TRUE';
          o_dat_abo.num_abonado := nABONADO;
      pv_cambio_serie_sb_pg.pv_rec_info_abonado_pr(o_dat_abo,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
          IF SN_cod_retorno <> 0 THEN
             RAISE error_ejecucion;
          END IF;

          select count(*)
          into  LN_icount
          from pv_iorserv a, pv_param_abocel b
          where a.cod_os = 10060
          and a.num_os = b.num_os
          and b.num_abonado = o_dat_abo.num_abonado;

          IF LN_icount > 0 THEN
         bRESULTADO := 'FALSE';
         vMENSAJE   := 'EL ABONADO PRESENTA OOSS DE AVISO DE SINIESTRO';

          ELSIF (o_dat_abo.cod_tecnologia <> 'GSM') THEN

         SELECT COUNT(1)
                   INTO n_cant_siniestro_serie
                   FROM ga_siniestros
              WHERE num_abonado = o_dat_abo.num_abonado
                AND num_serie = o_dat_abo.num_serie;

         IF n_cant_siniestro_serie > 0 THEN
            bRESULTADO := 'FALSE';
            vMENSAJE   := 'EL ABONADO PRESENTA SINIESTROS DECLARADOS';
                 END IF;
      ELSE

         SELECT COUNT(1)
                   INTO n_cant_siniestro_serie
                   FROM ga_siniestros
              WHERE num_abonado = o_dat_abo.num_abonado
                AND num_serie = o_dat_abo.num_serie;

		  -- inicio -- RRG col 25-02-2009 79606

          /*SELECT COUNT(1)
                   INTO n_cant_siniestro_imei
                   FROM ga_siniestros
              WHERE num_abonado = o_dat_abo.num_abonado
                AND num_serie = o_dat_abo.num_imei;*/

		 n_cant_siniestro_imei := 0; -- RRG col 25-02-2009 79606

		 -- fin RRG col 25-02-2009 79606

         IF (n_cant_siniestro_serie > 0 OR n_cant_siniestro_imei > 0 )THEN
             bRESULTADO := 'FALSE';
             vMENSAJE   := 'EL ABONADO PRESENTA SINIESTROS DECLARADOS PARA EQUIPO Y/O SIMCARD';
                 END IF;
    END IF;


   EXCEPTION
      WHEN error_ejecucion THEN
         bRESULTADO := 'FALSE';
         vMENSAJE   := 'ERROR: NO SE PUEDE RECUPERAR INFO. ABONADO.';
      WHEN OTHERS THEN
         bRESULTADO := 'FALSE';
         vMENSAJE   := 'ERROR: NO SE PUEDE VALIDAR SINIESTROS PENDIENTES.';
END pv_val_siniestro_pendiente_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE pv_borra_periodos_pr (
      en_num_ooss       IN  pv_det_suspvolprog_to.num_os_sus%type,
          en_num_abonado    IN  ga_abocel.num_abonado%type,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
IS
      error_ejecucion    EXCEPTION;
      v_des_error        ge_errores_pg.desevent;
      sSQL               ge_errores_pg.vquery;
          ln_num_periodosusp pv_suspvolprog_to.num_periodosusp%type;
          ln_count           NUMBER(3);
BEGIN

    sn_cod_retorno  := 0;
    sn_num_evento   := 0;
    sv_mens_retorno := '';

        IF en_num_ooss != 0 OR en_num_ooss IS NOT NULL THEN

                /* Valida si existe periodo en el detalle para el num_abonado y num_ooss ingresado por parametro*/
                sSQL:='select count(1)';
                sSQL:= sSQL || ' from   pv_det_suspvolprog_to';
                sSQL:= sSQL || ' where  num_os_sus != '||en_num_ooss;
                sSQL:= sSQL || ' and    num_abonado = '||en_num_abonado;
            select count(1)
                into   ln_count
            from   pv_det_suspvolprog_to
            where  num_os_sus != en_num_ooss
                and    num_abonado = en_num_abonado;

                IF ln_count < 1 THEN
                   BEGIN
                          /* Si no encuentra detalle de la ooss ingresada elimina los periosos anteriores al sysdate*/
                          sSQL:='delete pv_suspvolprog_to';
                          sSQL:= sSQL || ' where num_abonado = '||en_num_abonado;
                          sSQL:= sSQL || ' and trunc(fec_fin) < trunc(sysdate)';
                          delete pv_suspvolprog_to
                  where num_abonado = en_num_abonado
                  and   trunc(fec_fin) < trunc(sysdate);
                   END;
                END IF;

        ELSE

                /* Valida si existe algun periodo en el detalle para el num_abonado.*/
                sSQL:='select count(1)';
                sSQL:= sSQL || ' from   pv_det_suspvolprog_to';
                sSQL:= sSQL || ' where  num_os_sus != '||en_num_ooss;
                sSQL:= sSQL || ' and    num_abonado = '||en_num_abonado;
            select count(1)
                into   ln_count
            from   pv_det_suspvolprog_to
            where  num_abonado = en_num_abonado;

                IF ln_count < 1 THEN
                   BEGIN
                          /* Si no encuentra detalle de la ooss ingresada elimina los periosos anteriores al sysdate*/
                          sSQL:='delete pv_suspvolprog_to';
                          sSQL:= sSQL || ' where num_abonado = '||en_num_abonado;
                          delete pv_suspvolprog_to
                  where num_abonado = en_num_abonado;
                   END;
                END IF;

        END IF;

EXCEPTION
      WHEN error_ejecucion THEN
         v_des_error     := 'pv_suspvolprog_pg.pv_borra_periodos_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_borra_periodos_pr', sSQL, SQLCODE, v_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := '10038';
         sv_mens_retorno := 'Error: no es posible eliminar periodos del abonado '||en_num_abonado;
         v_des_error     := 'pv_suspvolprog_pg.pv_borra_periodos_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_borra_periodos_pr', sSQL, SQLCODE, v_des_error);
END pv_borra_periodos_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_cons_ciclo_fact_fn (
      en_cod_cliente    IN fa_ciclocli.cod_cliente%TYPE,
          en_num_abonado        IN fa_ciclocli.num_abonado%TYPE,
      sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
      sn_num_evento             OUT NOCOPY ge_errores_pg.evento
   )
      RETURN NUMBER
   IS
      v_des_error     ge_errores_pg.desevent;
      ssql            ge_errores_pg.vquery;
      LN_valor            NUMBER (16);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      ssql := 'select 1';
      ssql := ssql || ' from fa_ciclocli cli,';
      ssql := ssql || ' ga_infaccel infa';
      ssql := ssql || ' where cli.cod_cliente = ' || en_cod_cliente || ' and';
      ssql := ssql || ' cli.num_abonado = ' || en_num_abonado || ' and';
      ssql := ssql || ' infa.cod_cliente = cli.cod_cliente and';
      ssql := ssql || ' infa.num_abonado = cli.num_abonado and';
      ssql := ssql || ' exists (select 1';
      ssql := ssql || ' from fa_ciclfact ciclo';
      ssql := ssql || ' where ciclo.cod_ciclfact =infa.cod_ciclfact and';
      ssql := ssql || ' ciclo.fec_desdecfijos <= SYSDATE and';
      ssql := ssql || ' ciclo.fec_hastacfijos >= SYSDATE)';

          SELECT 1
          INTO LN_valor
          FROM fa_ciclocli cli,
                   ga_infaccel infa
          WHERE cli.cod_cliente = en_cod_cliente AND
                        cli.num_abonado = en_num_abonado AND
                        infa.cod_cliente = cli.cod_cliente AND
                        infa.num_abonado = cli.num_abonado AND
                        EXISTS (SELECT 1
                   FROM fa_ciclfact ciclo
                                   WHERE ciclo.cod_ciclfact =infa.cod_ciclfact AND
                                                 ciclo.fec_desdecfijos <= SYSDATE AND
                                                 ciclo.fec_hastacfijos >= SYSDATE);
      RETURN 1;

   EXCEPTION
          WHEN NO_DATA_FOUND THEN
                 RETURN 0;
      WHEN OTHERS THEN
         sn_cod_retorno  := '10050';
         sv_mens_retorno := 'Error al obtener ciclo de facturación del abonado';
         v_des_error     := 'pv_suspvolprog_pg.pv_cons_ciclo_fact_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_cons_ciclo_fact_fn', ssql, SQLCODE, v_des_error);
         RETURN -1;
   END pv_cons_ciclo_fact_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_cons_proxciclo_fact_fn (
      en_cod_cliente    IN fa_ciclocli.cod_cliente%TYPE,
          en_num_abonado        IN fa_ciclocli.num_abonado%TYPE,
      sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
      sn_num_evento             OUT NOCOPY ge_errores_pg.evento
   )
      RETURN NUMBER
   IS
      v_des_error     ge_errores_pg.desevent;
      ssql            ge_errores_pg.vquery;
      LN_valor            NUMBER (16);
          LN_Resultado    NUMBER;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

          LN_Resultado := pv_cons_ciclo_fact_fn(en_cod_cliente, en_num_abonado, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

          IF LN_Resultado=1 THEN
              ssql := 'select 1';
              ssql := ssql || ' from fa_ciclocli cli,';
              ssql := ssql || ' ga_infaccel infa';
              ssql := ssql || ' where cli.cod_cliente = ' || en_cod_cliente || ' and';
              ssql := ssql || ' cli.num_abonado = ' || en_num_abonado || ' and';
              ssql := ssql || ' infa.cod_cliente = cli.cod_cliente and';
              ssql := ssql || ' infa.num_abonado = cli.num_abonado and';
              ssql := ssql || ' exists (select 1';
              ssql := ssql || ' from fa_ciclfact ciclo';
              ssql := ssql || ' where ciclo.cod_ciclfact =infa.cod_ciclfact and';
              ssql := ssql || ' ciclo.fec_desdellam <= SYSDATE and';
              ssql := ssql || ' ciclo.fec_hastallam >= SYSDATE)';

              SELECT 1
              INTO LN_valor
              FROM fa_ciclocli cli,
                   ga_infaccel infa
              WHERE cli.cod_cliente = en_cod_cliente AND
                    cli.num_abonado = en_num_abonado AND
                    infa.cod_cliente = cli.cod_cliente AND
                    infa.num_abonado = cli.num_abonado AND
                    EXISTS (SELECT 1
                           FROM fa_ciclfact ciclo
                           WHERE ciclo.cod_ciclfact =infa.cod_ciclfact AND
                                         ciclo.fec_desdellam <= SYSDATE AND
                                 ciclo.fec_hastallam >= SYSDATE);
              RETURN 1;
          ELSE
                  RETURN LN_Resultado;
          END IF;

   EXCEPTION
          WHEN NO_DATA_FOUND THEN
                 RETURN 0;
      WHEN OTHERS THEN
         sn_cod_retorno  := '10051';
         sv_mens_retorno := 'Error al obtener próximo ciclo de facturación del abonado';
         v_des_error     := 'pv_suspvolprog_pg.pv_cons_proxciclo_fact_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_cons_proxciclo_fact_fn', ssql, SQLCODE, v_des_error);
         RETURN -1;
   END pv_cons_proxciclo_fact_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_rec_periodos_histabonado_pr (
          en_num_abonado    IN  ga_abocel.num_abonado%type,
          sc_resultado      OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
IS
      error_ejecucion    EXCEPTION;
      v_des_error        ge_errores_pg.desevent;
      sSQL               ge_errores_pg.vquery;
          ln_num_periodosusp pv_suspvolprog_to.num_periodosusp%type;
          ln_count           NUMBER(3);
BEGIN

    sn_cod_retorno  := 0;
    sn_num_evento   := 0;
    sv_mens_retorno := '';

        ssql := 'SELECT a.num_periodosusp, a.cod_cliente, a.fec_inicio, a.fec_fin, a.dias_acum';
        ssql := ssql || ' FROM pv_suspvolprog_to a';
        ssql := ssql || ' WHERE a.num_abonado = ' || en_num_abonado;
        ssql := ssql || ' ORDER BY a.num_periodosusp ASC';

        OPEN sc_resultado FOR
                 SELECT a.num_periodosusp, a.cod_cliente, a.fec_inicio, a.fec_fin, a.dias_acum
                 FROM pv_suspvolprog_to a
                 WHERE a.num_abonado = en_num_abonado
                 ORDER BY a.num_periodosusp ASC;

EXCEPTION
      WHEN error_ejecucion THEN
         v_des_error     := 'pv_suspvolprog_pg.pv_rec_periodos_histabonado_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_rec_periodos_histabonado_pr', sSQL, SQLCODE, v_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := '10042';
         sv_mens_retorno := 'Error: no es posible recuperar periodos del abonado: '||en_num_abonado;
         v_des_error     := 'pv_suspvolprog_pg.pv_rec_periodos_histabonado_pr(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_rec_periodos_histabonado_pr', sSQL, SQLCODE, v_des_error);
END pv_rec_periodos_histabonado_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE pv_val_baja_abonado_pr(
      v_param_entrada IN  VARCHAR2,
      bRESULTADO      OUT NOCOPY VARCHAR2,
      vMENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
   )
   IS
      string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
      nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
          SN_cod_retorno          NUMBER;
          SV_mens_retorno         VARCHAR2(200);
          SN_num_evento           NUMBER;
          vCantidad                               NUMBER;
          iTIPESTADOA                     NUMBER;
          iCODESTADO        NUMBER(3);
          iCODESTCANCELADA      NUMBER(2);
          iMAXINTENTOS          NUMBER(2);
          error_ejecucion       EXCEPTION;

   BEGIN

      GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
      nABONADO         := -1;
      nABONADO         := TO_NUMBER(string(5));
      bRESULTADO  := 'TRUE';
          vCantidad   := 0;
          iTIPESTADOA := 3;

          BEGIN
                 SELECT val_parametro
                 INTO iCODESTADO
                 FROM ged_parametros
                 WHERE nom_parametro = 'ESTADO_PV_MENSAJE';

          EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                         bRESULTADO := 'FALSE';
                         vMENSAJE   := 'NO SE ENCONTRO PARAMETRO ESTADO_PV_MENSAJES EN GED_PARAMETROS.' || SQLERRM || '.';
          END;

          BEGIN
                 SELECT val_parametro
                 INTO iCODESTCANCELADA
                 FROM ged_parametros
                 WHERE nom_parametro = 'EST_BAJA_CANCELADA';

          EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                     bRESULTADO := 'FALSE';
                     vMENSAJE   := 'NO SE ENCONTRO PARAMETRO EST_BAJA_CANCELADA EN GED_PARAMETROS.' || SQLERRM || '.';
      END;

          BEGIN
                 SELECT val_parametro
                 INTO iMAXINTENTOS
                 FROM ged_parametros
                 WHERE nom_parametro = 'MAX_INTENTOS';

                 EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                     bRESULTADO := 'FALSE';
                     vMENSAJE   := 'NO SE ENCONTRO PARAMETRO MAX_INTENTOS EN GED_PARAMETROS.' || SQLERRM || '.';

      END;

      IF nABONADO <> -1 THEN
                 SELECT COUNT(a.cod_estado)
                 INTO vCantidad
                 FROM pv_iorserv a, pv_camcom b, pv_erecorrido c
                 WHERE a.num_os = b.num_os AND
                           a.num_os = c.num_os AND
                           b.num_os = c.num_os AND
                           b.num_abonado = nABONADO AND
                           a.cod_os in ('10222','10232') AND
                           c.tip_estado = iTIPESTADOA;

                 IF vCantidad>0 THEN
                        RAISE error_ejecucion;
                 ELSE
                         IF vCantidad = 0 THEN
                                SELECT COUNT(a.cod_estado)
                                INTO vCantidad
                                FROM pv_iorserv a, pv_camcom b, pv_erecorrido c
                                WHERE a.num_os = b.num_os AND
                                          a.num_os = c.num_os AND
                                          b.num_os = c.num_os AND
                                          b.num_abonado = nABONADO AND
                                          a.cod_os in ('10222','10232') AND
                                          c.tip_estado = 4 and
                                          NVL(a.num_intentos,0) < iMAXINTENTOS;
                         END IF;

                         IF vCantidad>0 THEN
                                RAISE error_ejecucion;
                         END IF;
                 END IF;
          END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
         bRESULTADO := 'FALSE';
         vMENSAJE   := 'ERROR: ABONADO POSEE BAJA DE ABONADO PENDIENTE.';
      WHEN OTHERS THEN
         bRESULTADO := 'FALSE';
         vMENSAJE   := 'ERROR: NO SE PUEDE VALIDAR SI EXISTE BAJA DE ABONADO PENDIENTE';
END pv_val_baja_abonado_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_ESTADO_SUS_PROG_ABONADO_PR(
      EV_v_param_entrada IN  VARCHAR2,
      EV_bRESULTADO      OUT NOCOPY VARCHAR2,
      EV_vMENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
   )
   IS
      string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
      LN_ABONADO           GA_ABOCEL.NUM_ABONADO%TYPE;
      LN_vCantidad         NUMBER(8);
   BEGIN
      GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_v_param_entrada, string);
      LN_ABONADO        := -1;
      LN_ABONADO        := TO_NUMBER(string(5));

      EV_bRESULTADO  := 'TRUE';
      EV_vMENSAJE    := 'OK';
      LN_vCantidad   := 0;

      SELECT COUNT (1)
        INTO LN_vCantidad
        FROM PV_DET_SUSPVOLPROG_TO
       WHERE num_abonado = LN_ABONADO
         AND estado     = 'SUS';

      IF (LN_vCantidad > 0) THEN
          EV_bRESULTADO    := 'FALSE';
          EV_vMENSAJE      := 'No se podrá rehabilitar el abonado por esta ooss, deberá realizarla por ooss rehabilitación voluntaria sin cobro';
          END IF;

END PV_ESTADO_SUS_PROG_ABONADO_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION pv_upd_anula_iorserv_fn (
     pv_iorserv     IN              pv_iorserv_ot,
     sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
     sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
     sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
  )
     RETURN BOOLEAN
  IS
     v_des_error   ge_errores_pg.desevent;
     ssql          ge_errores_pg.vquery;
  BEGIN

     sn_cod_retorno  := 0;
     sn_num_evento   := 0;
     sv_mens_retorno := '';

     ssql := ' UPDATE pv_iorserv a'
          || ' SET a.tip_estado = 10'
          || ' WHERE a.num_os = '||pv_iorserv.num_os;

     UPDATE pv_iorserv a
        SET a.cod_estado = 10,
                    a.num_ospadre = null,
                        a.status = 'ANULADA'
      WHERE a.num_os = pv_iorserv.num_os;

     RETURN TRUE;
  EXCEPTION
     WHEN OTHERS THEN
        sn_cod_retorno  := '10029';
        sv_mens_retorno := 'Error: no determinado al anular OOSS';
        v_des_error     := 'pv_suspvolprog_pg.pv_upd_anula_iorserv_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_upd_anula_iorserv_fn', ssql, SQLCODE, v_des_error);
        RETURN FALSE;
END pv_upd_anula_iorserv_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


FUNCTION pv_upd_fh_ejecucion_reh_fn (
     pv_det_suspvolprog   IN           pv_det_suspvolprog_qt,
     sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
     sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
     sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
  )
     RETURN BOOLEAN
  IS
     v_des_error   ge_errores_pg.desevent;
     ssql          ge_errores_pg.vquery;
     iCount        NUMBER;
  BEGIN

     sn_cod_retorno  := 0;
     sn_num_evento   := 0;
     sv_mens_retorno := '';

     SELECT COUNT(1)
         INTO   iCount
     FROM  PV_DET_SUSPVOLPROG_TO
     WHERE num_os_reh = pv_det_suspvolprog.num_os_reh
         and estado = 'ANU';

     IF iCount > 0 THEN

             SELECT COUNT(1)
                 INTO   iCount
             FROM  PV_DET_SUSPVOLPROG_TH
             WHERE num_os_reh = pv_det_suspvolprog.num_os_reh
                 and estado = 'SUS';

                 IF iCount > 0 THEN
                         ssql := ' UPDATE pv_iorserv a'
                          || ' SET a.fh_ejecucion = TRUNC(sysdate)'
                          || ' WHERE a.num_os = '||pv_det_suspvolprog.num_os_reh;

                     UPDATE pv_iorserv a
                        SET a.fh_ejecucion = TRUNC(sysdate)
                      WHERE a.num_os = pv_det_suspvolprog.num_os_reh;

          END IF;
         END IF;

     RETURN TRUE;
  EXCEPTION
     WHEN OTHERS THEN
        sn_cod_retorno  := '10029';
        sv_mens_retorno := 'Error: no determinado al anular OOSS';
        v_des_error     := 'pv_suspvolprog_pg.pv_upd_fh_ejecucion_reh_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'pv_suspvolprog_pg.pv_upd_fh_ejecucion_reh_fn', ssql, SQLCODE, v_des_error);
        RETURN FALSE;
END pv_upd_fh_ejecucion_reh_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


END pv_suspvolprog_pg;
/
SHOW ERRORS