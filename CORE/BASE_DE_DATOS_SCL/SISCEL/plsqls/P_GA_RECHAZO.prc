CREATE OR REPLACE PROCEDURE P_Ga_Rechazo
IS
--
-- *************************************************************
-- * procedimiento      : P_Ga_Rechazo
-- * Descripcisn        : Proceso de regularizacisn del rechazo de la venta
-- * Fecha de creacisn  : Septiembre 2002
-- * Responsable        : CRM
-- *************************************************************
   -- Definiendo los posibles errores
   -- invalid_abonado        EXCEPTION;
   -- PRAGMA EXCEPTION_INIT (invalid_abonado,  -20501);
   -- Definiendo varibles
   v_msj                  VARCHAR2 (256);
   v_error                NUMBER (8);
   v_exite_abonado        INTEGER (1);
   v_fecha_devolucion     DATE;
   v_mod_contrato         VARCHAR2 (32);
   v_imp_cargobasico      ta_cargosbasico.imp_cargobasico%TYPE;
   v_num_transacf         INTEGER (12);
   v_cod_catimpos         ge_catimpclientes.cod_catimpos%TYPE;
   v_sum_imp_facturable   NUMBER (14, 4);
   v_plan_tarifario       ged_parametros.val_parametro%TYPE;
   i_n                    INTEGER;
   num_transaccion        INTEGER;
   i_cod_retorno          ga_transacabo.cod_retorno%TYPE;
   v_des_cadena           ga_transacabo.des_cadena%TYPE;
   v_producto             ge_datosgener.prod_celular%TYPE;
   v_seq_transacabo       INTEGER;
   v_p_proc               VARCHAR2 (256);  /* En que parte del proceso estoy*/
   v_p_tabla              VARCHAR2 (256);  /* En que tabla estoy trabajando*/
   v_p_act                VARCHAR2 (256);  /* Que accion estoy ejecutando*/
   v_p_sqlcode            VARCHAR2 (256);  /* sqlcode*/
   v_p_sqlerrm            VARCHAR2 (256);  /* sqlerrm*/
   v_p_error              VARCHAR2 (256);
   n_cod_sqlcode          ga_errores.cod_sqlcode%TYPE;
   v_cod_sqlerrm          ga_errores.cod_sqlerrm%TYPE;
   v_cod_tecnologia_gsm   ged_parametros.val_parametro%TYPE;
   v_cod_tecnologia       ga_abocel.cod_tecnologia%TYPE;
   v_imsi                 icc_movimiento.imsi%TYPE;
   v_num_serie            ga_abocel.num_serie %TYPE;
   v_debug                VARCHAR2 (256);
   v_folio_venta          ga_docventa.num_folio%TYPE;
   v_pos                  INTEGER;
   v_hist_tol			  ged_parametros.val_parametro%TYPE;

   /* Error enviando por nosotros u otro.*/
   CURSOR c_rechazo
   IS
      SELECT a.num_venta, a.cod_producto, a.cod_oficina, a.cod_tipcomis,
             a.cod_vendedor, a.cod_vendedor_agente, a.num_unidades,
             a.fec_venta, a.cod_region, a.cod_provincia, a.cod_ciudad,
             a.num_transaccion, a.ind_pasocob, a.nom_usuar_vta, a.ind_venta,
             a.cod_moneda, a.cod_causarec, a.imp_venta, a.cod_tipcontrato,
             a.num_contrato, a.ind_tipventa, a.cod_cliente, a.cod_modventa,
             a.tip_valor, a.cod_cuota, a.cod_tiptarjeta, a.num_tarjeta,
             a.cod_auttarj, a.fec_vencitarj, a.cod_bancotarj, a.num_ctacorr,
             a.num_cheque, a.cod_banco, a.cod_sucursal, a.fec_cumplimenta,
             a.fec_recdocum, a.fec_aceprec, a.nom_usuar_acerec,
             a.nom_usuar_recdoc, a.nom_usuar_cumpl, a.ind_ofiter,
             a.ind_chkdicom, a.num_consulta, a.cod_vendealer, a.num_foldealer,
             a.cod_docdealer, a.ind_doccomp, a.obs_incump, a.cod_causarep,
             a.fec_recprov, a.nom_usuar_recprov, a.num_dias, a.obs_recprov,
             a.imp_abono, a.ind_abono, a.fec_recep_admvtas,
             a.usu_recep_admvtas, a.obs_gralcumpl, a.mto_garantia,
             a.ind_cont_telef, a.fecha_cont_telef, a.usuario_cont_telef,
             b.cod_tipcomis AS cod_tipcomis_vendedor_agente,
             NVL (a.cod_vendealer, a.cod_vendedor) AS cod_vendealer_nvl
        FROM ga_ventas a, ve_vendedores b
       WHERE a.ind_estventa = 'RT'
         AND b.cod_vendedor = a.cod_vendedor_agente
         AND a.fec_aceprec <= (SELECT SYSDATE - val_parametro
                                 FROM ged_parametros
                                WHERE nom_parametro = 'PLAZO_ANUL_REC');

   CURSOR c_abonado (numventa NUMBER)
   IS
      SELECT num_abonado, cod_tecnologia, num_serie, cod_cliente, num_celular, num_contrato,
             ind_procequi
        FROM ga_abocel
       WHERE num_venta = numventa;

   sql_stmt               VARCHAR2 (200);
   v_msj_error            VARCHAR2 (200);

   PROCEDURE l_baja_abonado (
      n_num_venta   IN       NUMBER, -- Nzmero de venta
      n_cod_error   OUT      NUMBER, -- Csdigo de Error
      s_men_error   OUT      VARCHAR2 -- Mensaje de Error
   )
   IS
      s_men_error_f   VARCHAR (256);
      v_debug         VARCHAR (256);
   BEGIN
      s_men_error := 'ps 2: insertar en la ga_celnum_reutil';

      INSERT INTO ga_celnum_reutil
                  (num_celular, cod_subalm, cod_producto, cod_central, cod_cat,
                   uso_anterior, fec_baja, ind_equipado, cod_uso)
         SELECT b.num_celular, a.cod_subalm, a.cod_producto, a.cod_central,
                a.cod_cat, a.cod_uso, SYSDATE, 1, 2
         FROM  ga_celnum_uso a, ga_abocel b
         WHERE a.cod_producto = 1
         AND   b.num_venta = n_num_venta
         AND   b.num_celular BETWEEN a.num_desde AND a.num_hasta
         AND   NOT EXISTS ( SELECT 1
                            FROM ga_celnum_uso
                            WHERE b.num_celular BETWEEN num_desde
                                                      AND num_hasta
                            AND num_siguiente <= b.num_celular
                            UNION
                            SELECT 1
                            FROM ga_resnumcel
                            WHERE num_celular = b.num_celular
                            UNION
                            SELECT 1
                            FROM al_fic_series
                            WHERE num_telefono = b.num_celular
                            UNION
                            SELECT 1
                            FROM al_series
                            WHERE num_telefono = b.num_celular
                            UNION
                            SELECT 1
                            FROM ga_abocel
                            WHERE num_celular = b.num_celular
                            AND num_abonado != b.num_abonado
                            AND cod_situacion != 'BAA');

      -- Pasamos a tablas de Historicos los Datos del Abonado
      s_men_error := 'ps 2: insertar en la ga_habocel';

      INSERT INTO ga_habocel
                  (num_abonado, num_celular, cod_producto, cod_cliente,
                   cod_cuenta, cod_subcuenta, cod_usuario, cod_region,
                   cod_provincia, cod_ciudad, cod_celda, cod_central, cod_uso,
                   cod_situacion, ind_procalta, ind_procequi, cod_vendedor,
                   cod_vendedor_agente, tip_plantarif, tip_terminal,
                   cod_plantarif, cod_cargobasico, cod_planserv,
                   cod_limconsumo, num_serie, num_seriehex, nom_usuarora,
                   fec_alta, num_percontrato, cod_estado, num_seriemec,
                   cod_holding, cod_empresa, cod_grpserv, ind_supertel,
                   num_telefija, cod_opredfija, cod_carrier, ind_prepago,
                   ind_plexsys, cod_central_plex, num_celular_plex, num_venta,
                   cod_modventa, cod_tipcontrato, num_contrato, num_anexo,
                   fec_cumplan, cod_credmor, cod_credcon, cod_ciclo,
                   ind_factur, ind_suspen, ind_rehabi, ind_insguias,
                   fec_fincontra, fec_recdocum, fec_cumplimen, fec_acepventa,
                   fec_actcen, fec_bajacen, fec_ultmod, cod_causabaja,
                   num_personal, ind_seguro, clase_servicio, perfil_abonado,
                   fec_baja, num_min, fec_historico, cod_tecnologia, num_imei)
         SELECT num_abonado, num_celular, cod_producto, cod_cliente,
                cod_cuenta, cod_subcuenta, cod_usuario, cod_region,
                cod_provincia, cod_ciudad, cod_celda, cod_central, cod_uso,
                cod_situacion, ind_procalta, ind_procequi, cod_vendedor,
                cod_vendedor_agente, tip_plantarif, tip_terminal,
                cod_plantarif, cod_cargobasico, cod_planserv, cod_limconsumo,
                num_serie, num_seriehex, nom_usuarora, fec_alta,
                num_percontrato, cod_estado, num_seriemec, cod_holding,
                cod_empresa, cod_grpserv, ind_supertel, num_telefija,
                cod_opredfija, cod_carrier, ind_prepago, ind_plexsys,
                cod_central_plex, num_celular_plex, num_venta, cod_modventa,
                cod_tipcontrato, num_contrato, num_anexo, fec_cumplan,
                cod_credmor, cod_credcon, cod_ciclo, ind_factur, ind_suspen,
                ind_rehabi, ind_insguias, fec_fincontra, fec_recdocum,
                fec_cumplimen, fec_acepventa, fec_actcen, fec_bajacen,
                fec_ultmod, cod_causabaja, num_personal, ind_seguro,
                clase_servicio, perfil_abonado, fec_baja, num_min, SYSDATE,
				cod_tecnologia, num_imei
          FROM  ga_abocel
          WHERE num_venta = n_num_venta;

      s_men_error := 'ps 2: insertar en la ga_hequipaboser';

      INSERT INTO ga_hequipaboser
                  (num_abonado, num_serie, cod_producto, ind_procequi,
                   fec_alta, ind_propiedad, cod_bodega, tip_stock,
                   cod_articulo, ind_equiacc, cod_modventa, tip_terminal,
                   cod_uso, cod_estado, cap_code, num_seriemec, des_equipo,
                   cod_paquete, num_movimiento, cod_causa, cod_protocolo,
                   cod_frecuencia, num_velocidad, cod_cuota, fec_historico,
				   num_imei)
         SELECT num_abonado, num_serie, cod_producto, ind_procequi, fec_alta,
                ind_propiedad, cod_bodega, tip_stock, cod_articulo,
                ind_equiacc, cod_modventa, tip_terminal, cod_uso, cod_estado,
                cap_code, num_seriemec, des_equipo, cod_paquete,
                num_movimiento, cod_causa, cod_protocolo, cod_frecuencia,
                num_velocidad, cod_cuota, SYSDATE, num_imei
         FROM  ga_equipaboser
         WHERE num_abonado IN (SELECT num_abonado
                               FROM  ga_abocel
                               WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: insertar en la ga_hequipabonoser';

      INSERT INTO ga_hequipabonoser
                  (num_abonado, cod_articulo, fec_alta, num_movimiento,
                   cod_producto, num_unidades, cod_bodega, tip_stock, cod_uso,
                   cod_estado, cod_paquete, fec_historico)
         SELECT num_abonado, cod_articulo, fec_alta, num_movimiento,
                cod_producto, num_unidades, cod_bodega, tip_stock, cod_uso,
                cod_estado, cod_paquete, SYSDATE
         FROM  ga_equipabonoser
         WHERE num_abonado IN (SELECT num_abonado
                               FROM  ga_abocel
                               WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: insertar en la ga_hmodabocel';

      INSERT INTO ga_hmodabocel
                  (num_abonado, cod_tipmodi, fec_modifica, nom_usuarora,
                   num_celular, cod_region, cod_provincia, cod_ciudad,
                   cod_celda, cod_central, cod_uso, tip_plantarif,
                   tip_terminal, cod_plantarif, cod_cargobasico, cod_planserv,
                   cod_limconsumo, num_serie, num_seriehex, num_seriemec,
                   cod_holding, cod_empresa, cod_grpserv, num_telefija,
                   cod_carrier, ind_plexsys, cod_central_plex,
                   num_celular_plex, cod_credmor, cod_credcon, cod_ciclo,
                   ind_factur, ind_suspen, ind_rehabi, ind_insguias,
                   num_personal, cod_causa, fec_historico, cod_tecnologia,
				   num_imei)
         SELECT num_abonado, cod_tipmodi, fec_modifica, nom_usuarora,
                num_celular, cod_region, cod_provincia, cod_ciudad, cod_celda,
                cod_central, cod_uso, tip_plantarif, tip_terminal,
                cod_plantarif, cod_cargobasico, cod_planserv, cod_limconsumo,
                num_serie, num_seriehex, num_seriemec, cod_holding,
                cod_empresa, cod_grpserv, num_telefija, cod_carrier,
                ind_plexsys, cod_central_plex, num_celular_plex, cod_credmor,
                cod_credcon, cod_ciclo, ind_factur, ind_suspen, ind_rehabi,
                ind_insguias, num_personal, cod_causa, SYSDATE, cod_tecnologia,
				num_imei
         FROM  ga_modabocel
         WHERE num_abonado IN (SELECT num_abonado
                               FROM  ga_abocel
                               WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: insertar en la ga_hsegurado';

      INSERT INTO ga_hsegurabo
                  (num_abonado, fec_alta, cod_producto, num_terminal,
                   num_serie, cod_tipsegu, num_contrato, num_periodo,
                   fec_fincontrato, nom_usuarora, num_anexo, fec_historico)
         SELECT num_abonado, fec_alta, cod_producto, num_terminal, num_serie,
                cod_tipsegu, num_contrato, num_periodo, fec_fincontrato,
                nom_usuarora, num_anexo, SYSDATE
         FROM  ga_segurabo
         WHERE num_abonado IN (SELECT num_abonado
                               FROM  ga_abocel
                               WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: insertar en la ga_hservsuplado';

      INSERT INTO ga_hservsuplabo
                  (num_abonado, cod_servicio, fec_altabd, cod_servsupl,
                   cod_nivel, cod_producto, num_terminal, nom_usuarora,
                   ind_estado, fec_altacen, fec_bajabd, fec_bajacen,
                   cod_concepto, num_diasnum, fec_historico)
         SELECT num_abonado, cod_servicio, fec_altabd, cod_servsupl,
                cod_nivel, cod_producto, num_terminal, nom_usuarora,
                ind_estado, fec_altacen, fec_bajabd, fec_bajacen,
                cod_concepto, num_diasnum, SYSDATE
         FROM  ga_servsuplabo
         WHERE num_abonado IN (SELECT num_abonado
                               FROM  ga_abocel
                               WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: insertar en la ga_hdiasabo';

      INSERT INTO ga_hdiasabo
                  (num_abonado, cod_producto, des_diaesp, cod_tipdia,
                   fec_diaesp, num_diasnum, fec_historico)
         SELECT num_abonado, cod_producto, des_diaesp, cod_tipdia, fec_diaesp,
                num_diasnum, SYSDATE
         FROM  ga_diasabo
         WHERE num_abonado IN (SELECT num_abonado
                               FROM  ga_abocel
                               WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: insertar en la ga_hnumespabo';

      INSERT INTO ga_hnumespabo
                  (num_abonado, num_telefesp, num_diasnum, fec_historico)
         SELECT num_abonado, num_telefesp, num_diasnum, SYSDATE
         FROM  ga_numespabo
         WHERE num_abonado IN (SELECT num_abonado
                               FROM  ga_abocel
                               WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: insertar en la ga_hsiniestros';

      INSERT INTO GA_HSINIESTROS
                  (num_siniestro, num_abonado, cod_producto, cod_causa,
                   cod_estado, num_terminal, num_serie, fec_siniestro,
                   cod_cargobasico, cod_servicio, fec_formaliza, fec_anula,
                   fec_restituc, num_constpol, num_solliq, num_serierep,
                   fec_historico)
         SELECT num_siniestro, num_abonado, cod_producto, cod_causa,
                cod_estado, num_terminal, num_serie, fec_siniestro,
                cod_cargobasico, cod_servicio, fec_formaliza, fec_anula,
                fec_restituc, num_constpol, num_solliq, num_serierep, SYSDATE
         FROM  GA_SINIESTROS
         WHERE num_abonado IN (SELECT num_abonado
                               FROM  ga_abocel
                               WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: insertando en la ga_hdetsinie';

      INSERT INTO ga_hdetsinie
                  (num_siniestro, cod_estado, fec_detalle, nom_usuarora,
                   obs_detalle, fec_historico)
         SELECT num_siniestro, cod_estado, fec_detalle, nom_usuarora,
                obs_detalle, SYSDATE
         FROM  ga_detsinie
         WHERE num_siniestro IN
                      (SELECT num_siniestro
                       FROM  GA_SINIESTROS
                       WHERE num_abonado IN (SELECT num_abonado
                                             FROM  ga_abocel
                                             WHERE num_venta = n_num_venta)
                       AND   cod_producto = 1);

      s_men_error := 'ps 2: insertando en la ga_hsusprehabo';

      INSERT INTO ga_hsusprehabo
                  (num_abonado, cod_servicio, fec_suspbd, cod_producto,
                   num_terminal, nom_usuarora, cod_modulo, tip_registro,
                   cod_caususp, tip_susp, cod_servsupl, cod_nivel, fec_suspcen,
                   fec_rehabd, fec_rehacen, cod_cargobasico, cod_operador,
                   ind_siniestro, fec_historico)
         SELECT num_abonado, cod_servicio, fec_suspbd, cod_producto,
                num_terminal, nom_usuarora, cod_modulo, tip_registro,
                cod_caususp, tip_susp, cod_servsupl, cod_nivel, fec_suspcen,
                fec_rehabd, fec_rehacen, cod_cargobasico, cod_operador,
                ind_siniestro, SYSDATE
         FROM  ga_susprehabo
         WHERE num_abonado IN (SELECT num_abonado
                               FROM  ga_abocel
                               WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: insertando en la ga_htraspabo';

      INSERT INTO ga_htraspabo
                  (num_abonado, fec_modifica, cod_cliennue, cod_cuentanue,
                   cod_subctanue, cod_usuarnue, cod_producto, num_terminal,
                   num_abonadoant, cod_clienant, cod_cuentaant, cod_subctaant,
                   cod_usuarant, ind_trasdeuda, nom_usuarora, fec_historico)
         SELECT num_abonado, fec_modifica, cod_cliennue, cod_cuentanue,
                cod_subctanue, cod_usuarnue, cod_producto, num_terminal,
                num_abonadoant, cod_clienant, cod_cuentaant, cod_subctaant,
                cod_usuarant, ind_trasdeuda, nom_usuarora, SYSDATE
         FROM  ga_traspabo
         WHERE num_abonado IN (SELECT num_abonado
                               FROM  ga_abocel
                               WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: insertando en la ga_hdtostarif';

      INSERT INTO ga_hdtostarif
                  (num_abonado, cod_ciclfact, num_minutos, tip_plantarif,
                   cod_vendedor, nom_usuarora, fec_grabacion, fec_baja)
         SELECT num_abonado, cod_ciclfact, num_minutos, tip_plantarif,
                cod_vendedor, nom_usuarora, fec_grabacion, SYSDATE
         FROM  ga_dtostarif
         WHERE num_abonado IN (SELECT num_abonado
                               FROM  ga_abocel
                               WHERE num_venta = n_num_venta);


	  s_men_error := 'ps 2: eliminado registro de la ga_equipaboser';

      DELETE FROM ga_equipaboser
      WHERE num_abonado IN (SELECT num_abonado
                            FROM  ga_abocel
                            WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: eliminado registro de la ga_equipabonoser';

      DELETE FROM ga_equipabonoser
      WHERE num_abonado IN (SELECT num_abonado
                            FROM  ga_abocel
                            WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: eliminado registro de la ga_segurabo';

      DELETE FROM ga_segurabo
      WHERE num_abonado IN (SELECT num_abonado
                            FROM  ga_abocel
                            WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: eliminado registro de la ga_servsuplabo';

      DELETE FROM ga_servsuplabo
      WHERE num_abonado IN (SELECT num_abonado
                            FROM  ga_abocel
                            WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: eliminado registro de la ga_diasabo';

      DELETE FROM ga_diasabo
      WHERE num_abonado IN (SELECT num_abonado
                            FROM  ga_abocel
                            WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: eliminado registro de la ga_numespabo';

      DELETE FROM ga_numespabo
      WHERE num_abonado IN (SELECT num_abonado
                            FROM  ga_abocel
                            WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: eliminado registro de la ga_susprehabo';

      DELETE FROM ga_susprehabo
      WHERE num_abonado IN (SELECT num_abonado
                            FROM  ga_abocel
                            WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: eliminado registro de la ga_traspabo';

      DELETE FROM ga_traspabo
      WHERE num_abonado IN (SELECT num_abonado
                            FROM  ga_abocel
                            WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: eliminado registro de la ga_siniestros';

      DELETE FROM GA_SINIESTROS
      WHERE num_abonado IN (SELECT num_abonado
                            FROM  ga_abocel
                            WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: eliminado registro de la ga_modabocel';

      DELETE FROM ga_modabocel
      WHERE num_abonado IN (SELECT num_abonado
                            FROM  ga_abocel
                            WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: eliminado registro de la ga_post_movivox';

      DELETE FROM ga_post_movivox
      WHERE num_abonado IN (SELECT num_abonado
                            FROM  ga_abocel
                            WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: eliminado registro de la ga_det_movivox';

      DELETE FROM ga_det_movivox
      WHERE num_abonado IN (SELECT num_abonado
                            FROM  ga_abocel
                            WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: eliminado registro de la ga_cab_movivox';

      DELETE FROM ga_cab_movivox
      WHERE num_abonado IN (SELECT num_abonado
                            FROM  ga_abocel
                            WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: eliminado registro de la ga_dtostarif';

      DELETE FROM ga_dtostarif
      WHERE num_abonado IN (SELECT num_abonado
                            FROM  ga_abocel
                            WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: eliminado registro de la ga_petsr';

      DELETE FROM ga_petsr
      WHERE num_abonado IN (SELECT num_abonado
                            FROM  ga_abocel
                            WHERE num_venta = n_num_venta);

      s_men_error := 'ps 2: eliminado registro de la ga_detsinie';

      DELETE FROM ga_detsinie
      WHERE num_siniestro IN (SELECT num_siniestro
                              FROM  GA_SINIESTROS
                              WHERE num_abonado IN
                                              (SELECT num_abonado
                                               FROM  ga_abocel
                                               WHERE num_venta = n_num_venta));


	  --s_men_error := 'ps 2: eliminado registro de la ga_limite_cliabo_to';

      --DELETE FROM ga_limite_cliabo_to
      --WHERE num_abonado IN (SELECT num_abonado
      --                      FROM  ga_abocel
      --                      WHERE num_venta = n_num_venta);


	  s_men_error := 'ps 2: eliminado registro de la ga_abocel';

      DELETE FROM ga_abocel
      WHERE num_venta = n_num_venta;
   EXCEPTION
      WHEN OTHERS
      THEN
         n_cod_sqlcode := SQLCODE;
         v_debug := SQLERRM;
         s_men_error_f := SUBSTR (
                                'NV:'
                             || n_num_venta
                             || ' '
                             || s_men_error
                             || ':'
                             || SQLERRM,
                             1,
                             60
                          );
         RAISE_APPLICATION_ERROR (-20502, 'l_baja_abonado');
   END l_baja_abonado;
BEGIN
   -- DBMS_OUTPUT.disable;
   -- DBMS_OUTPUT.enable;
   FOR cc IN c_rechazo
   LOOP
      BEGIN
         SAVEPOINT pto_num_venta;
	     -- Obtengo el Parametro asigando a GSM desde GED_PARAMETROS
 	     v_msj := 'ps 0: Obtengo el Parametro asigando a GSM desde GED_PARAMETROS';
	     v_cod_tecnologia_gsm := GE_FN_DEVVALPARAM('GA',1,'TECNOLOGIA_GSM');

         -- Verifica existencia del abonado
         v_msj := 'ps 1: verifica existencia de abonado';
         SELECT SIGN (COUNT (1))
         INTO v_exite_abonado
         FROM ga_abocel
         WHERE num_venta = cc.num_venta;

         IF v_exite_abonado = 0
         THEN
            RAISE_APPLICATION_ERROR (
               -20501,
                  'Numero de abonado no valido Reg: num_venta '
               || cc.num_venta
            );
         END IF;

         -- Extraccisn del Tipo de TecNologia Asociada a la Venta
         --v_msj := 'ps 1.1: Extraccisn del Tipo de TecNologia Asociada a la Venta';
         --SELECT cod_tecnologia, num_serie
         --INTO  v_cod_tecnologia, v_num_serie
         --FROM  ga_abocel
         --WHERE num_venta = cc.num_venta;

         -- actualiza ga_venta.ind_estventa = 'RD'
         v_msj := 'ps 2: actualiza ga_venta.ind_estventa = RD';

         UPDATE ga_ventas
         SET ind_estventa = 'RD',
             fec_aceprec = SYSDATE,
             nom_usuar_acerec = USER
         WHERE num_venta = cc.num_venta;

         v_msj := 'ps 2.1: actualiza ga_anulrech_th';

         UPDATE ga_anulrech_th
         SET fec_anulre = SYSDATE,
                tip_rechdef = 1
         WHERE num_venta = cc.num_venta;

	     v_msj := 'ps 2.2: obtiene parametro del causal paso historico TOL';
		 SELECT val_parametro
         INTO  v_hist_tol
         FROM  ged_parametros
         WHERE nom_parametro = 'IND_TOL_RECHAZO_VTA';

         FOR aa IN c_abonado (cc.num_venta)
         LOOP

		    -- inserta movimiento para tecnologia GSM
	     	IF aa.cod_tecnologia = v_cod_tecnologia_gsm THEN
	           -- recuperar imsi de la simcard
               v_msj := 'ps 3.0: recupera IMSI de SIMCARD';

			   SELECT FRECUPERSIMCARD_FN(v_num_serie, 'IMSI')
			   INTO v_imsi
			   FROM DUAL;

		       -- inserta movimiento
               v_msj := 'ps 3.1: inserta movimiento tecnologia GSM';

               INSERT INTO icc_movimiento
                       (num_movimiento, num_abonado, cod_estado, cod_modulo,
                        nom_usuarora, cod_central, num_celular, cod_actuacion,
                        fec_ingreso, num_serie, tip_terminal, cod_actabo, num_min,
						tip_tecnologia, imsi, imei, icc)
               SELECT icc_seq_nummov.NEXTVAL, a.num_abonado, '1', 'GA', USER,
                   	  a.cod_central, a.num_celular, b.cod_actcen, SYSDATE,
                   	  a.num_serie, a.tip_terminal, 'RV', a.num_min, a.cod_tecnologia,
				   	  v_imsi, a.num_imei, a.num_serie
               FROM  ga_abocel a, ga_actabo b
               WHERE a.num_venta    = cc.num_venta
               AND   b.cod_actabo   = 'RV'
               AND   b.cod_producto = 1
			   AND   a.num_abonado  = aa.num_abonado;
         	ELSE
		    	v_msj := 'ps 3: inserta movimiento tecnologia TDMA';

            	INSERT INTO icc_movimiento
                        (num_movimiento, num_abonado, cod_estado, cod_modulo,
                         nom_usuarora, cod_central, num_celular, cod_actuacion,
                         fec_ingreso, num_serie, tip_terminal, cod_actabo, num_min,
						 tip_tecnologia)
            	SELECT icc_seq_nummov.NEXTVAL, a.num_abonado, '1', 'GA', USER,
                   	   a.cod_central, a.num_celular, b.cod_actcen, SYSDATE,
                   	   a.num_seriehex, a.tip_terminal, 'RV', a.num_min, a.cod_tecnologia
            	FROM  ga_abocel a, ga_actabo b
            	WHERE a.num_venta    = cc.num_venta
            	AND   b.cod_actabo   = 'RV'
            	AND   b.cod_producto = 1
				AND   a.NUM_ABONADO = aa.NUM_ABONADO;
		 	END IF;

         	-- genera movimiento
         	v_msj := 'ps 4: genera movimiemto';

			-- baja abonado
            v_msj := 'ps 5: determina producto ';
            SELECT prod_celular
            INTO v_producto
            FROM ge_datosgener
            WHERE ROWNUM = 1;

			v_msj :=    'ps 6: baja abonado num '
                     || aa.num_abonado;
            SELECT ga_seq_transacabo.NEXTVAL
            INTO v_seq_transacabo
            FROM DUAL;

			P_Interfases_Abonados (
               v_seq_transacabo,
               'BA',
               v_producto,
               aa.num_abonado,
               '',
               '',
               ''
            );
            -- devolucion almacen
            v_msj := 'ps 7: dias de devolucion ';

            -- pendiente *** RV ***
            SELECT MIN (  SYSDATE
                        + dias_devolucion)
            INTO v_fecha_devolucion
            FROM gad_plazo_devdif
            WHERE cod_tipcontrato = (SELECT cod_tipcontrato
                                     FROM ga_abocel
                                     WHERE num_abonado = aa.num_abonado)
            AND num_meses = (SELECT num_meses
                             FROM ga_percontrato
                             WHERE cod_tipcontrato = cc.cod_tipcontrato)
            AND cod_operacion = 'RV'
            AND ind_causa = 1
            AND cod_causa = cc.cod_causarec
            AND cod_categoria = (SELECT cod_categoria
                                 FROM ve_catplantarif
                                 WHERE cod_plantarif =
                                              (SELECT cod_plantarif
                                               FROM ga_abocel
                                               WHERE num_abonado =
                                                               aa.num_abonado))
            AND cod_canal_vta = (SELECT ind_vta_externa
                                 FROM ve_tipcomis
                                 WHERE cod_tipcomis = cc.cod_tipcomis)
            AND SYSDATE BETWEEN fec_desde AND fec_hasta;

			v_msj := 'ps 8: modalidad de contrato ';

			SELECT DECODE (
                      ind_cuotas,
                      2, 'ARRIENDO',
                      -1, 'COMODATO',
                      1, 'COMODATO',
                      'SUBSIDIO'
                   )
            INTO v_mod_contrato
            FROM ge_modventa
            WHERE cod_modventa = cc.cod_modventa;

			v_msj := 'ps 7: inserta en gat_equipos_devdif ';

            INSERT INTO GAT_EQUIPOS_DEVDIF
                        (cod_cliente, num_abonado, num_serie, cod_tipmov,
                         cod_operacion, cod_causa, fec_ingreso, nom_usuario,
                         cod_estado_dev, fec_maxima_dev, ind_cobro,
                         num_cargo, fec_devolucion, nom_usuario_receptor,
                         num_venta, ind_canal,
                         mod_contrato)
            VALUES (aa.cod_cliente, aa.num_abonado, aa.num_serie, '1',
                    'RV', cc.cod_causarec, SYSDATE, USER,
                    'ND', v_fecha_devolucion, NULL,
                    NULL, NULL, NULL,
                    cc.num_venta, DECODE (cc.cod_tipcomis, 1, 'E', 'I'),
                    v_mod_contrato);

            -- inserta rechazo
            v_msj := 'ps 7: inserta rechazo ';

			v_debug :=    cc.num_venta
                       || ','
                       || aa.num_abonado
                       || ','
                       || aa.cod_cliente
                       || ','
                       || aa.num_celular
                       || ','
                       || aa.num_contrato
                       || ','
                       || aa.num_serie
                       || ','
                       || aa.ind_procequi
                       || ','
                       || v_mod_contrato
                       || ','
                       || cc.cod_tipcomis_vendedor_agente
                       || ','
                       || cc.cod_vendedor_agente
                       || ','
                       || cc.cod_vendedor
                       || ','
                       || cc.cod_vendealer_nvl
                       || ','
                       || cc.cod_tipcomis
                       || ','
                       || cc.fec_venta
                       || ','
                       || cc.fec_recdocum
                       || ','
                       || SYSDATE
                       || ','
                       || cc.cod_causarec
                       || ','
                       || USER;

            INSERT INTO gat_rechazos
                        (num_venta, num_abonado, cod_cliente,
                         num_celular, num_contrato, num_serie,
                         ind_procequi, mod_contrato,
                         cod_tipcomis,
                         cod_comisionista, cod_agencia,
                         cod_vend_final,
                         ind_canal, fec_venta,
                         fec_recepcion, fec_rechazo, cod_causarec,
                         nom_usuario)
                 VALUES (cc.num_venta, aa.num_abonado, aa.cod_cliente,
                         aa.num_celular, aa.num_contrato, aa.num_serie,
                         aa.ind_procequi, v_mod_contrato,
                         cc.cod_tipcomis_vendedor_agente,
                         cc.cod_vendedor_agente, cc.cod_vendedor,
                         cc.cod_vendealer_nvl,
                         DECODE (cc.cod_tipcomis, 1, 'E', 'I'), cc.fec_venta,
                         cc.fec_recdocum, SYSDATE, cc.cod_causarec,
                         USER);

            -- movimiento cuenta controlada
            v_msj := 'ps 2: obtiene sequencia as_presuptemp';
            SELECT fas_presuptemp.NEXTVAL
            INTO v_num_transacf
            FROM DUAL;

			v_msj := 'ps 2: obtiene importe cargo basico';
            SELECT MAX (a.imp_cargobasico)
            INTO v_imp_cargobasico
            FROM ta_cargosbasico a, ta_plantarif b
            WHERE b.cod_cargobasico = (SELECT cod_plantarif
                                       FROM ga_abocel
                                       WHERE num_abonado = aa.num_abonado)
            AND a.cod_cargobasico = b.cod_cargobasico
            AND a.cod_producto = 1
            AND SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE);

			v_msj := 'ps 2: inserta en  fat_presuptemp';
            v_imp_cargobasico := NVL (v_imp_cargobasico, 0);

            INSERT INTO fat_presuptemp
                        (num_proceso, cod_concepto, columna, cod_cliente,
                         fec_efectividad, imp_concepto, imp_facturable,
                         cod_tipconce)
               SELECT v_num_transacf, c.cod_abonocel, 1, aa.cod_cliente,
                      SYSDATE, v_imp_cargobasico, v_imp_cargobasico,
                      a.cod_tipconce
               FROM fa_conceptos a, fa_datosgener b, fa_datosgener c
               WHERE a.cod_concepto = b.cod_abonocel;

            -- llamado a la PL que realiza el calculo de impuesto
            v_msj := 'ps 2: obtiene ge_catimpclientes.cod_catimpos';
            SELECT cod_catimpos
            INTO v_cod_catimpos
            FROM ge_catimpclientes
            WHERE cod_cliente = aa.cod_cliente
            AND SYSDATE BETWEEN fec_desde AND fec_hasta;

			v_msj := 'ps 2: ejecuta procedimiento fa_proc_imptos';
            fa_proc_imptos (
               v_num_transacf,
               v_cod_catimpos,
			   cc.cod_oficina,
               v_p_proc,
               v_p_tabla,
               v_p_act,
               v_p_sqlcode,
               v_p_sqlerrm,
               v_p_error
            );

            -- recupero impuesto asociado
            v_msj := 'ps 2: obtiene el impuesto asociado';
            SELECT SUM (imp_facturable)
            INTO  v_sum_imp_facturable
            FROM  fat_presuptemp
            WHERE num_proceso = v_num_transacf
            AND   cod_tipconce = 1
            GROUP BY cod_concerel;

			v_msj := 'ps 2: obtiene parametro del plan tarifario';
            SELECT val_parametro
            INTO  v_plan_tarifario
            FROM  ged_parametros
            WHERE nom_parametro = 'COD_AMI_PLANTARIF';

			-- Inserta un registro con los datos en GA_MOVCCONTROL
            v_msj := 'ps 2: Insertando en la ga_movccontrol';
            INSERT INTO ga_movccontrol
                        (num_linea, fec_inicio, cod_plantarif, ind_tipmov,
                         ind_procesado,
                         cmd_comverse)
                 VALUES (aa.num_celular, SYSDATE, v_plan_tarifario, 2, -- baja
                         1,
                            'm 9'
                         || aa.num_celular
                         || ',SERVICE=PPS,STATE=DISABLED,USER=INFOHIA|D 9'
                         || aa.num_celular
                         || ',SERVICE=PPS,USER=INFOHIA');

			-- Inserta registro en la ga_limite_cliabo_th
			-- v_msj := 'ps 2: insertando en la ga_limite_cliabo_th';

      		-- INSERT INTO ga_limite_cliabo_th
            --       (cod_cliente, num_abonado, cod_limcons, cod_plantarif, fec_desde, fec_historico,
            --       	fec_hasta, nom_usuarora, fec_asignacion, cod_causa_hist, est_aplica_tol, fec_aplica_tol)
         	-- SELECT cod_cliente, num_abonado, cod_limcons, cod_plantarif, fec_desde, SYSDATE,
		    --    	fec_hasta, USER, fec_asignacion, v_hist_tol, est_aplica_tol, fec_aplica_tol
         	-- FROM  ga_limite_cliabo_to
         	-- WHERE num_abonado = aa.num_abonado;

         END LOOP;

         -- actualizacion abonado
         v_msj := 'ps 2: actualiza cod_situacion y fec_ultmod de la ga_abocel';

         UPDATE ga_abocel
         SET cod_situacion = 'REP',
             fec_ultmod = SYSDATE
         WHERE num_venta = cc.num_venta;

         -- rechaza cargos
         v_msj := 'ps 2: inserta en la ga_cargos_rechazados';

         INSERT INTO ga_cargos_rechazados
                     (num_venta, num_cargo, cod_cliente, cod_producto,
                      cod_ciclfact, num_transaccion, cod_concepto, imp_cargo,
                      cod_moneda, num_unidades, nom_usuario, num_paquete,
                      num_abonado, num_terminal, num_serie, cap_code,
                      cod_concepto_dto, val_dto, tip_dto, ind_cuota)
         SELECT a.num_venta, b.num_cargo, b.cod_cliente, b.cod_producto,
                b.cod_ciclfact, 0, b.cod_concepto, b.imp_cargo,
                b.cod_moneda, b.num_unidades, USER, b.num_paquete,
                b.num_abonado, b.num_terminal, b.num_serie, b.cap_code,
                b.cod_concepto_dto, b.val_dto, b.tip_dto, b.ind_cuota
         FROM  ge_cargos b, ga_abocel a
         WHERE a.num_venta = cc.num_venta
         AND   a.cod_cliente = b.cod_cliente
         AND   a.num_abonado = b.num_abonado
         AND   TRUNC (b.fec_alta) = TRUNC (a.fec_alta)
         AND   b.num_venta = 0;

         v_msj := 'ps 2: elimina registro de la ge_cargos';

         DELETE FROM ge_cargos
         WHERE num_cargo IN (SELECT DISTINCT b.num_cargo
                             FROM  ge_cargos b, ga_abocel a
                             WHERE a.num_venta = cc.num_venta
                             AND   a.cod_cliente = b.cod_cliente
                             AND   a.num_abonado = b.num_abonado
                             AND   TRUNC (b.fec_alta) = TRUNC (a.fec_alta)
                             AND   b.num_venta = 0);

         -- actualizacion de de preliquidacion (solo si es distribuidor -1-)
         IF cc.cod_tipcomis_vendedor_agente =
                                          1 -- **** dudas si es cc.cod_tipcomis
         THEN
            v_msj := 'ps 2: actualiza ga_preliquidacion';

            UPDATE ga_preliquidacion
            SET ind_estventa = 'RE',
                fec_aceprec = SYSDATE,
                cod_causarec = cc.cod_causarec
            WHERE num_venta = cc.num_venta;
         END IF;

         -- ejecuta nota de credito
         v_msj := 'ps 2: obtiene ind_pagado';
         SELECT ind_pagado
         INTO  i_n
         FROM  ge_modventa a, ga_ventas b
         WHERE b.num_venta = cc.num_venta
         AND   a.cod_modventa = b.cod_modventa;

         IF i_n != 1 THEN -- pagado
            --Valida si la venta se encuentra en estado < 500, azn no ha sido visada
            -- Debe actualizar registro en interfact con estado 920.
            v_msj := 'ps 2: verifica la fa_interfact con cod_estado >= 400';
            SELECT COUNT (*)
            INTO  i_n
            FROM  fa_interfact
            WHERE num_venta = cc.num_venta
            AND   cod_estadoc >= 400
            AND   cod_estproc = 3;

            IF i_n = 0 THEN
               v_msj := 'ps 2: verifica la fa_interfact con cod_estado < 500';
               SELECT COUNT (*)
               INTO  i_n
               FROM  fa_interfact
               WHERE num_venta = cc.num_venta
               AND   cod_estadoc < 500
               AND   cod_estproc = 3;

               IF i_n = 0 THEN
                  v_msj := 'ps 2: actualiza la fa_interfact';

                  UPDATE fa_interfact
                  SET cod_estadoc = '920',
                      nom_usuaelim = USER,
                      cod_causaelim = '00007'
                  WHERE num_venta = cc.num_venta;
               END IF;
            ELSE
               v_msj := 'ps 2: obtiene la secuencia ga_seq_transacabo';
               SELECT ga_seq_transacabo.NEXTVAL
               INTO num_transaccion
               FROM DUAL;

			   v_msj := 'ps 2: ejecuta el proceso p_liquidacion_deuda';
               /*Inicio Modificacion - ACB - 10/01/2005 - MA-200412060535*/
               /*p_liquidacion_deuda (cc.num_venta, num_transaccion);*/
               p_liquidacion_deuda (num_transaccion, cc.num_venta);
               /*Fin Modificacion - ACB - 10/01/2005 - MA-200412060535*/

			   v_msj := 'ps 2: verifica el retorno p_liquidacion_deuda';
               SELECT cod_retorno, des_cadena
               INTO  i_cod_retorno, v_des_cadena
               FROM  ga_transacabo
               WHERE num_transaccion = num_transaccion;

               IF i_cod_retorno = 0 THEN
                  -- Inserta solicitud de liquidacion
                  v_msj := 'ps 2: inserta en la gat_solicliq_deuda';

				  SELECT num_folio
				  INTO  v_folio_venta
                  FROM  ga_docventa
                  WHERE num_venta = cc.num_venta
                  AND   cod_tipdocum IN (SELECT cod_docboleta
                                         FROM ga_datosgener
                                         UNION
                                         SELECT cod_docguia
                                         FROM ga_datosgener);

                  v_pos := INSTR(v_folio_venta, '-', 1, 1);

				  IF v_pos > 0 then
	                  INSERT INTO gat_solicliq_deuda
	                              (num_venta, cod_cliente, cod_tipdocum, pref_plaza,
								   num_folio, num_proceso, fec_ingreso_sol)
	                     SELECT cc.num_venta, cc.cod_cliente, cod_docdealer,
	                            pref_plaza, num_foldealer, 0, SYSDATE
	                     FROM (SELECT cod_docdealer,
						 	  		  '' AS pref_plaza,
	                                  TO_CHAR (num_foldealer) AS num_foldealer,
	                                  0 AS ss_ind_vta_externa
	                           FROM ga_preliquidacion
	                           WHERE num_venta = cc.num_venta
	                           UNION
	                           SELECT cod_tipdocum, SUBSTR(num_folio, 1, v_pos - 1),
							   		  SUBSTR(num_folio, v_pos + 1), 1
	                           FROM ga_docventa
	                           WHERE num_venta = cc.num_venta
	                           AND cod_tipdocum IN (SELECT cod_docboleta
	                                                FROM ga_datosgener
	                                                UNION
	                                                SELECT cod_docguia
	                                                FROM ga_datosgener)
	                           UNION
	                           SELECT 0, '', '0', -1
	                           FROM DUAL) a
	                     WHERE ss_ind_vta_externa =
	                                  (SELECT MAX (ind)
	                                   FROM (SELECT ind_vta_externa AS ind
	                                         FROM ve_tipcomis
	                                         WHERE cod_tipcomis =
	                                                     (SELECT cod_tipcomis
	                                                      FROM ve_vendedores
	                                                      WHERE cod_vendedor =
	                                                                cc.cod_vendedor
	                                                      AND cod_tipcomis IN (0, 1))
	                                         UNION
	                                         SELECT -1
	                                         FROM DUAL));
				  ELSE
	                  INSERT INTO gat_solicliq_deuda
	                              (num_venta, cod_cliente, cod_tipdocum, num_folio,
	                               num_proceso, fec_ingreso_sol)
	                     SELECT cc.num_venta, cc.cod_cliente, cod_docdealer,
	                            num_foldealer, 0, SYSDATE
	                     FROM (SELECT cod_docdealer,
	                                  TO_CHAR (num_foldealer) AS num_foldealer,
	                                  0 AS ss_ind_vta_externa
	                           FROM ga_preliquidacion
	                           WHERE num_venta = cc.num_venta
	                           UNION
	                           SELECT cod_tipdocum, num_folio, 1
	                           FROM ga_docventa
	                           WHERE num_venta = cc.num_venta
	                           AND cod_tipdocum IN (SELECT cod_docboleta
	              			                                     FROM ga_datosgener
	                                                UNION
	                                                SELECT cod_docguia
	                                                FROM ga_datosgener)
	                           UNION
	                           SELECT 0, '0', -1
	                           FROM DUAL) a
	                     WHERE ss_ind_vta_externa =
	                                  (SELECT MAX (ind)
	                                   FROM (SELECT ind_vta_externa AS ind
	                                         FROM ve_tipcomis
	                                         WHERE cod_tipcomis =
	                                                     (SELECT cod_tipcomis
	                                                      FROM ve_vendedores
	                                                      WHERE cod_vendedor =
	                                                                cc.cod_vendedor
	                                                      AND cod_tipcomis IN (0, 1))
	                                         UNION
	                                         SELECT -1
	                                         FROM DUAL));
				  END IF;
               ELSIF i_cod_retorno = 9 THEN
                  -- continuar
                  SELECT 0
                  INTO i_n
                  FROM DUAL;
               ELSIF i_cod_retorno = 8 THEN
                  RAISE_APPLICATION_ERROR (
                     -20551,
                     'No posee permiso para generar Nota de Credito'
                  );
               ELSE
                  RAISE_APPLICATION_ERROR (
                     -20552,
                     'Error al ejecutar PL  P_LIQUIDACION_DEUDA'
                  );
               END IF;
            END IF;
         END IF;


         -- envia movimiento
         -- ** PENDIENTE ** --

         -- baja abonado
         -- Una vez ejecutado el rechazo, hay que dar de baja los abonados
         l_baja_abonado (cc.num_venta, v_error, v_msj);
      EXCEPTION
         WHEN OTHERS
         THEN
            n_cod_sqlcode := SQLCODE;
            v_debug := SQLERRM;
            v_cod_sqlerrm := SUBSTR (
                                   'NV:'
                                || cc.num_venta
                                || ' '
                                || v_msj
                                || ':'
                                || SQLERRM,
                                1,
                                60
                             );
            ROLLBACK TO pto_num_venta;

            INSERT INTO ga_errores
                        (cod_actabo, codigo, fec_error, cod_producto,
                         nom_proc, nom_tabla, cod_act, cod_sqlcode,
                         cod_sqlerrm)
                 VALUES ('GA', cc.cod_cliente, SYSDATE, 1,
                         'P_GA_RECHAZO', NULL, NULL, n_cod_sqlcode,
                         v_cod_sqlerrm);
      END;
   END LOOP;
END;
/
SHOW ERRORS
