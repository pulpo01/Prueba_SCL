CREATE OR REPLACE PACKAGE BODY Pv_Orden_Servicio_Pg AS

--pv_orden_servicio_pg v1.0 --COL-72424|05-11-2008|GEZ

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_generass_ctaseg_central_pr (
      so_ga_abonado     IN OUT NOCOPY   ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
/*
   <Documentacion TipoDoc = "Procedimiento">
   <Elemento Nombre = "PV_GENERASS_CTASEG_CENTRAL_PR "
    Lenguaje="PL/SQL" Fecha="10-08-2007"
    Versión"1.0.0" Dise+ador"****"
    Programador="" Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion>   Funcion que devuelve Rango Antiguedad  </Descripcion>
   <Parametros>
   <Entrada>
         <param nom="SO_GA_ABONADO "    Tipo="Estructura Type GA_ABONADO_QT"> Datos de Estructura  </param>>
   </Entrada>
            <Salida>
             <param nom="SO_GA_ABONADO"         Tipo="NUMERICO">Codigo de Retorno         </param>>
               <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo de Retorno         </param>>
               <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje de Retorno        </param>>
               <param nom="SN_num_evento"             Tipo="NUMERICO">Numero de Evento       </param>>
            </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
   */
      lv_des_error                 ge_errores_pg.desevent;
      lv_ssql                      ge_errores_pg.vquery;
      lv_cod_servicio              VARCHAR2 (3);
      lb_generass_central          BOOLEAN;
      lb_datos_arreglo             BOOLEAN;
      lb_proc_trarif               BOOLEAN;
      lb_ins_servtrafic            BOOLEAN;
      lv_serv_trafic               VARCHAR2 (20);
      lv_bajahibrido               VARCHAR2 (20);
      lv_generasscadena            VARCHAR2 (255);
      lv_cant_servicios            INTEGER;
      ln_posx                      INTEGER;
      lv_aux_ss                    VARCHAR2 (6);
      lv_central_cadena_act        VARCHAR2 (255);
      lv_central_cadena_copia      VARCHAR2 (255);
      ln_cant_servicios            INTEGER;
      lv_central_ss_act            VARCHAR2 (6);
      lv_central_ss_act_servsupl   VARCHAR2 (2);
      lv_central_ss_act_nivel      VARCHAR2 (4);
      lb_sigoproceso               BOOLEAN;
      lv_servss_trafic             VARCHAR2 (6);
      ln_cadenagenera_nivel        INTEGER;
      lv_bd_nivel                  VARCHAR2 (4);
      ln_existe_serv               INTEGER;
      lv_servincom                 VARCHAR2 (3);
      lv_ssincom_desa              VARCHAR2 (6);
      lv_cod_concepto              VARCHAR2 (4);
      ln_ss_baja                   INTEGER;
      lv_servss_trafic_supl        VARCHAR2 (2);
      lv_servss_trafic_nivel       VARCHAR2 (4);
      ll_numdiasnum                LONG;
      lv_generasscadena_act        VARCHAR2 (255);
      lv_servss                    VARCHAR2 (6);
      ln_iserv                     INTEGER;
      eo_ged_parametros            pv_ged_parametros_qt
         := pv_ged_parametros_qt (NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL
                                 );

      CURSOR so_ss_def
      IS
         SELECT a.cod_servdef
           FROM ga_servsup_def a, GA_SERVSUPL b, icg_serviciotercen c
          WHERE a.cod_servicio = lv_cod_servicio
            AND a.tip_relacion = cn_incompatibilidad
            AND SYSDATE BETWEEN a.fec_desde AND a.fec_hasta
            AND a.cod_producto = b.cod_producto
            AND a.cod_servicio = b.cod_servicio
            AND b.cod_producto = c.cod_producto
            AND b.cod_servsupl = c.cod_servicio
            AND c.cod_sistema =
                   (SELECT cod_sistema
                      FROM icg_central
                     WHERE cod_central = so_ga_abonado.cod_central
                       AND cod_producto = 1)
            AND c.tip_terminal = so_ga_abonado.tip_terminal
            AND c.tip_tecnologia = so_ga_abonado.cod_tecnologia;

      CURSOR so_ss_abon
      IS
         SELECT LPAD (cod_servsupl, 2, 0) || LPAD (cod_nivel, 4, 0)
           FROM ga_servsuplabo
          WHERE num_abonado = so_ga_abonado.num_abonado AND ind_estado < 3;

      error_ejecucion              EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lb_generass_central := TRUE;
      lb_datos_arreglo := FALSE;
      lb_proc_trarif := TRUE;
      lb_ins_servtrafic := TRUE;
--    EO_GED_PARAMETROS := PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
--    EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_SERV_TRAF_NACC;
--    EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
--    EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
--
--    LV_sSql:= LV_sSql||'1 PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,'||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
--    PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
--    lv_Serv_Trafic := EO_GED_PARAMETROS.VAL_PARAMETRO;
--    IF SN_cod_retorno <> 0 THEN
--       RAISE ERROR_EJECUCION;
--    END IF;
      eo_ged_parametros := pv_inicia_estructuras_pg.pv_ged_parametros_qt_fn;
      eo_ged_parametros.nom_parametro := cv_baja_hibrido;
      eo_ged_parametros.cod_modulo := cv_cod_modulo;
      eo_ged_parametros.cod_producto := cn_producto;
      lv_ssql :=
            lv_ssql
         || '2 PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,'
         || sn_cod_retorno
         || ','
         || sv_mens_retorno
         || ','
         || sn_num_evento
         || '); ';
      pv_generales_pg.pv_obtiene_ged_parametros_pr (eo_ged_parametros,
                                                    sn_cod_retorno,
                                                    sv_mens_retorno,
                                                    sn_num_evento
                                                   );
      lv_bajahibrido := eo_ged_parametros.val_parametro;

      IF sn_cod_retorno <> 0
      THEN
         RAISE error_ejecucion;
      END IF;

      lv_generasscadena := so_ga_abonado.perfil_abonado;

      IF lv_generasscadena IS NOT NULL
      THEN
         lv_cant_servicios := LENGTH (lv_generasscadena) / 6;
         ln_posx := 1;

         FOR ln_iserv IN 1 .. lv_cant_servicios
         LOOP
            lv_aux_ss := SUBSTR (lv_generasscadena, ln_posx, 6);
            scadenagenera_ss (ln_iserv).cod_servicio := lv_aux_ss;
            ln_posx := ln_posx + 6;
            lb_datos_arreglo := TRUE;
         END LOOP;
      END IF;

      BEGIN
         SELECT cod_servicios
           INTO lv_central_cadena_act
           FROM icg_actuaciontercen
          WHERE cod_actuacion =
                   (SELECT cod_actcen
                      FROM ga_actabo
                     WHERE cod_actabo = so_ga_abonado.cod_actabo
                       AND cod_tecnologia = so_ga_abonado.cod_tecnologia
                       AND cod_modulo = 'GA')
            AND cod_producto = 1
            AND cod_sistema = 1
            AND tip_terminal = so_ga_abonado.tip_terminal
            AND tip_tecnologia = so_ga_abonado.cod_tecnologia;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            lv_central_cadena_act := '';
      END;

      lv_central_cadena_copia := lv_central_cadena_act;
      ln_cant_servicios := LENGTH (lv_central_cadena_act) / 6;

      FOR iserv IN 1 .. ln_cant_servicios
      LOOP
         lv_central_ss_act := SUBSTR (lv_central_cadena_act, 1, 6);
         lv_central_cadena_act := SUBSTR (lv_central_cadena_act, 7, 255);

         IF INSTR (lv_generasscadena, lv_central_ss_act) <> 0
         THEN
            lv_generasscadena :=
                           REPLACE (lv_generasscadena, lv_central_ss_act, '');
         ELSE
            -- grupo del servcio a activar en centrales por defecto
            lv_central_ss_act_servsupl :=
                                 TO_NUMBER (SUBSTR (lv_central_ss_act, 1, 2));
            -- nivel del servicio a activar en centrales por defecto
            lv_central_ss_act_nivel :=
                                 TO_NUMBER (SUBSTR (lv_central_ss_act, 3, 6));
            lv_ssql := ' SELECT cod_servicio';
            lv_ssql := lv_ssql || 'FROM ga_servsupl';
            lv_ssql :=
               lv_ssql || 'WHERE cod_servsupl= '
               || lv_central_ss_act_servsupl;
            lv_ssql :=
                 lv_ssql || ' AND cod_nivel    = ' || lv_central_ss_act_nivel;
            lv_ssql := lv_ssql || 'AND ind_estado   = 1';

            BEGIN
               SELECT cod_servicio
                 INTO lv_cod_servicio
                 FROM GA_SERVSUPL
                WHERE cod_servsupl = lv_central_ss_act_servsupl
                  AND cod_nivel = lv_central_ss_act_nivel
                  AND cod_producto = 1;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  lv_cod_servicio := '';
            END;

            --se comprueba que el grupo de centrales a activar no este en la cadena
            -- que se genero por visual con otro nivel
            lb_sigoproceso := TRUE;

            IF lb_datos_arreglo
            THEN
               FOR ln_posx IN 1 .. iserv - 1
               LOOP
                  IF lv_central_ss_act_servsupl =
                        TO_NUMBER
                             (SUBSTR (scadenagenera_ss (ln_posx).cod_servicio,
                                      1,
                                      2
                                     )
                             )
                  THEN
                     -- tienen el mismo grupo
                     IF     TRIM (so_ga_abonado.cod_actabo) =
                                                        TRIM (lv_bajahibrido)
                        AND TRIM (lv_servss_trafic) = TRIM (lv_cod_servicio)
                     THEN
                        lb_proc_trarif := FALSE;
                        lb_sigoproceso := FALSE;
                     ELSE
                        ln_cadenagenera_nivel :=
                           TO_NUMBER
                              (SUBSTR (scadenagenera_ss (ln_posx).cod_servicio,
                                       3
                                      )
                              );

                        IF ln_cadenagenera_nivel = 0
                        THEN
                           -- reviso servicio SS a desactivar
                           lv_ssql := ' ';
                           lv_ssql := ' SELECT cod_nivel';
                           lv_ssql := lv_ssql || 'FROM ga_servsuplabo';
                           lv_ssql :=
                                 lv_ssql
                              || 'WHERE num_abonado='
                              || so_ga_abonado.num_abonado;
                           lv_ssql := lv_ssql || ' AND ind_estado   = 3';
                           lv_ssql := lv_ssql || 'AND cod_producto = 1';
                           lv_ssql :=
                                 lv_ssql
                              || 'AND cod_servsupl = '
                              || lv_central_ss_act_servsupl;

                           BEGIN
                              SELECT cod_nivel
                                INTO lv_bd_nivel
                                FROM ga_servsuplabo
                               WHERE num_abonado = so_ga_abonado.num_abonado
                                 AND ind_estado = 3
                                 AND cod_producto = cn_producto
                                 AND cod_servsupl = lv_central_ss_act_servsupl;
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 lv_bd_nivel := '';
                           END;

                           IF TRIM (lv_central_ss_act_nivel) =
                                                            TRIM (lv_bd_nivel)
                           THEN
                              --tienen el mismo nivel el de centrales con el de la base de datos
                              lv_ssql := ' ';
                              lv_ssql :=
                                 ' UPDATE ga_servsuplabo SET ind_estado=1,fec_bajabd=NULL   ';
                              lv_ssql :=
                                    lv_ssql
                                 || 'WHERE num_abonado='
                                 || so_ga_abonado.num_abonado;
                              lv_ssql :=
                                    lv_ssql
                                 || 'AND cod_servicio = '
                                 || lv_cod_servicio;
                              lv_ssql :=
                                    lv_ssql
                                 || ' AND cod_servsupl = '
                                 || lv_central_ss_act_servsupl;
                              lv_ssql :=
                                    lv_ssql
                                 || ' AND cod_nivel    = '
                                 || lv_central_ss_act_nivel;
                              lv_ssql := lv_ssql || 'AND ind_estado   = 3';

                              UPDATE ga_servsuplabo
                                 SET ind_estado = 1,
                                     fec_bajabd = NULL
                               WHERE num_abonado = so_ga_abonado.num_abonado
                                 AND cod_servicio = lv_cod_servicio
                                 AND cod_servsupl = lv_central_ss_act_servsupl
                                 AND cod_nivel = lv_central_ss_act_nivel
                                 AND ind_estado = 3;

                              lb_sigoproceso := FALSE;
                           ELSE
                              lb_sigoproceso := TRUE;
                           END IF;
                        ELSE
                           -- reviso servicio SS a Activar
                           IF ln_cadenagenera_nivel <>
                                          TO_NUMBER (lv_central_ss_act_nivel)
                           THEN
                              IF TRIM (lv_central_ss_act_nivel) = '0'
                              THEN
                                 lv_ssql := ' ';
                                 lv_ssql :=
                                    ' UPDATE ga_servsuplabo SET   ind_estado=3  ,fec_bajaBD=SYSDATE     ';
                                 lv_ssql :=
                                       lv_ssql
                                    || ',fec_altacen=DECODE(fec_altacen,NULL,SYSDATE,fec_altacen) ';
                                 lv_ssql :=
                                       lv_ssql
                                    || 'WHERE num_abonado ='
                                    || so_ga_abonado.num_abonado;
                                 lv_ssql :=
                                       lv_ssql
                                    || ' AND cod_servsupl  = '
                                    || lv_central_ss_act_servsupl;
                                 lv_ssql :=
                                           lv_ssql || ' AND ind_estado    = 1';

                                 UPDATE ga_servsuplabo
                                    SET ind_estado = 3,
                                        fec_bajabd = SYSDATE,
                                        fec_altacen =
                                           DECODE (fec_altacen,
                                                   NULL, SYSDATE,
                                                   fec_altacen
                                                  )
                                  WHERE num_abonado =
                                                     so_ga_abonado.num_abonado
                                    AND cod_servsupl =
                                                    lv_central_ss_act_servsupl
                                    AND ind_estado = 1;
                              ELSE
                                 lv_ssql := ' ';
                                 lv_ssql := ' SELECT cod_nivel';
                                 lv_ssql := lv_ssql || 'FROM ga_servsuplabo';
                                 lv_ssql :=
                                       lv_ssql
                                    || 'WHERE num_abonado='
                                    || so_ga_abonado.num_abonado;
                                 lv_ssql := lv_ssql || ' AND ind_estado   = 3';
                                 lv_ssql :=
                                       lv_ssql
                                    || 'AND cod_producto = '
                                    || cn_producto;
                                 lv_ssql :=
                                       lv_ssql
                                    || 'AND cod_servsupl = '
                                    || lv_central_ss_act_servsupl;

                                 BEGIN
                                    SELECT cod_nivel
                                      INTO lv_bd_nivel
                                      FROM ga_servsuplabo
                                     WHERE num_abonado =
                                                     so_ga_abonado.num_abonado
                                       AND ind_estado = 3
                                       AND cod_producto = cn_producto
                                       AND cod_servsupl =
                                                    lv_central_ss_act_servsupl;
                                 EXCEPTION
                                    WHEN NO_DATA_FOUND
                                    THEN
                                       lv_bd_nivel := '';
                                 END;

                                 IF lv_bd_nivel <> ''
                                 THEN
                                    IF lv_bd_nivel = lv_central_ss_act_nivel
                                    THEN
                                       lv_ssql := ' ';
                                       lv_ssql := ' DELETE ga_servsuplabo ';
                                       lv_ssql := lv_ssql
                                          || 'WHERE num_abonado ='
                                          || so_ga_abonado.num_abonado;
                                       lv_ssql := lv_ssql
                                          || 'AND cod_servsupl  = '
                                          || lv_central_ss_act_servsupl;
                                       lv_ssql := lv_ssql
                                          || ' AND ind_estado    = 1    ';
                                       lv_ssql := lv_ssql
                                          || ' AND cod_producto  = '
                                          || cn_producto;
                                       lv_ssql := lv_ssql
                                          || ' AND cod_nivel    <> '
                                          || lv_central_ss_act_nivel;

                                       DELETE      ga_servsuplabo
                                             WHERE num_abonado =
                                                      so_ga_abonado.num_abonado
                                               AND cod_servsupl =
                                                      lv_central_ss_act_servsupl
                                               AND ind_estado = 1
                                               AND cod_producto = cn_producto
                                               AND cod_nivel <>
                                                       lv_central_ss_act_nivel;
                                    END IF;

                                    lv_ssql := ' ';
                                    lv_ssql := ' UPDATE ga_servsuplabo SET  ';
                                    lv_ssql :=
                                          lv_ssql
                                       || 'cod_servicio  = LV_Cod_Servicio';
                                    lv_ssql :=
                                          lv_ssql
                                       || ', cod_nivel    = LV_Central_SS_Act_Nivel';
                                    lv_ssql :=
                                         lv_ssql || ' , ind_estado    = 1    ';
                                    lv_ssql :=
                                            lv_ssql || ' ,fec_bajabd   =NULL ';
                                    lv_ssql :=
                                          lv_ssql
                                       || ' WHERE num_abonado ='
                                       || so_ga_abonado.num_abonado;
                                    lv_ssql :=
                                          lv_ssql
                                       || ' AND cod_servsupl  = '
                                       || lv_central_ss_act_servsupl;
                                    lv_ssql :=
                                           lv_ssql || ' AND ind_estado    = 1';

                                    UPDATE ga_servsuplabo
                                       SET cod_servicio = lv_cod_servicio,
                                           cod_nivel = lv_central_ss_act_nivel,
                                           ind_estado = 1,
                                           fec_bajabd = NULL
                                     WHERE num_abonado =
                                                     so_ga_abonado.num_abonado
                                       AND cod_servsupl =
                                                    lv_central_ss_act_servsupl
                                       AND ind_estado = 1;
                                 ELSE
                                    lv_ssql := ' ';
                                    lv_ssql := ' UPDATE ga_servsuplabo SET  ';
                                    lv_ssql :=
                                          lv_ssql
                                       || 'cod_servicio  = '
                                       || lv_cod_servicio;
                                    lv_ssql :=
                                          lv_ssql
                                       || ', cod_nivel    ='
                                       || lv_central_ss_act_nivel;
                                    lv_ssql :=
                                         lv_ssql || ' , ind_estado    = 1    ';
                                    lv_ssql :=
                                            lv_ssql || ' ,fec_bajabd   ='''' ';
                                    lv_ssql :=
                                          lv_ssql
                                       || ' WHERE num_abonado ='
                                       || so_ga_abonado.num_abonado;
                                    lv_ssql :=
                                          lv_ssql
                                       || ' AND cod_servsupl  ='
                                       || lv_central_ss_act_servsupl;
                                    lv_ssql :=
                                           lv_ssql || ' AND ind_estado    = 1';

                                    UPDATE ga_servsuplabo
                                       SET cod_servicio = lv_cod_servicio,
                                           cod_nivel = lv_central_ss_act_nivel,
                                           ind_estado = 1,
                                           fec_bajabd = ''
                                     WHERE num_abonado =
                                                     so_ga_abonado.num_abonado
                                       AND cod_servsupl =
                                                    lv_central_ss_act_servsupl
                                       AND ind_estado = 1;
                                 END IF;
                              END IF;

                              lb_sigoproceso := FALSE;
                           END IF;
                        END IF;

                        lv_generasscadena :=
                           REPLACE (lv_generasscadena,
                                    scadenagenera_ss (ln_posx).cod_servicio,
                                    ''
                                   );
                     END IF;
                  END IF;
               END LOOP;
            END IF;

            IF lb_sigoproceso
            THEN
               IF TRIM (lv_central_ss_act_nivel) <> '0'
               THEN
                  lv_ssql := ' ';
                  lv_ssql := ' SELECT count(*) ';
                  lv_ssql := lv_ssql || 'FROM ga_servsuplabo ';
                  lv_ssql :=
                        lv_ssql
                     || 'WHERE num_abonado='
                     || so_ga_abonado.num_abonado;
                  lv_ssql := lv_ssql || ' AND ind_estado  < 3';
                  lv_ssql := lv_ssql || 'AND cod_producto = ' || cn_producto;
                  lv_ssql :=
                        lv_ssql
                     || 'AND cod_servsupl = '
                     || lv_central_ss_act_servsupl;

                  BEGIN
                     SELECT COUNT (*)
                       INTO ln_existe_serv
                       FROM ga_servsuplabo
                      WHERE num_abonado = so_ga_abonado.num_abonado
                        AND ind_estado < 3
                        AND cod_servsupl = lv_central_ss_act_servsupl
                        AND cod_producto = cn_producto;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        ln_existe_serv := 0;
                  END;

                  IF ln_existe_serv = 0
                  THEN
                     lv_ssql := ' ';
                     lv_ssql := ' SELECT cod_nivel  ';
                     lv_ssql := lv_ssql || 'FROM ga_servsuplabo ';
                     lv_ssql :=
                           lv_ssql
                        || 'WHERE num_abonado='
                        || so_ga_abonado.num_abonado;
                     lv_ssql := lv_ssql || ' AND ind_estado  < 3';
                     lv_ssql :=
                               lv_ssql || 'AND cod_producto = ' || cn_producto;
                     lv_ssql :=
                           lv_ssql
                        || 'AND cod_servsupl = '
                        || lv_central_ss_act_servsupl;

                     BEGIN
                        SELECT cod_nivel
                          INTO lv_bd_nivel
                          FROM ga_servsuplabo
                         WHERE num_abonado = so_ga_abonado.num_abonado
                           AND ind_estado < 3
                           AND cod_servsupl = lv_central_ss_act_servsupl
                           AND cod_producto = cn_producto;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           lv_bd_nivel := '';
                     END;

                     IF lv_bd_nivel <> ''
                     THEN
                        lv_ssql := ' ';
                        lv_ssql :=
                           ' UPDATE ga_servsuplabo SET ind_estado=3,fec_bajabd=SYSDATE';
                        lv_ssql :=
                              lv_ssql
                           || 'WHERE num_abonado='
                           || so_ga_abonado.num_abonado;
                        lv_ssql :=
                              lv_ssql
                           || 'AND cod_servsupl = '
                           || lv_central_ss_act_servsupl;
                        lv_ssql :=
                               lv_ssql || ' AND cod_nivel    =' || lv_bd_nivel;
                        lv_ssql := lv_ssql || 'AND ind_estado   = 2';

                        --
                        UPDATE ga_servsuplabo
                           SET ind_estado = 3,
                               fec_bajabd = SYSDATE
                         WHERE num_abonado = so_ga_abonado.num_abonado
                           AND cod_servsupl = lv_central_ss_act_servsupl
                           AND cod_nivel = lv_bd_nivel
                           AND ind_estado = 2;
                     END IF;

                     OPEN so_ss_def;

                     LOOP
                        FETCH so_ss_def
                         INTO lv_servincom;

                        EXIT WHEN so_ss_def%NOTFOUND;
                        -- Buscamos el Servicio que es incompatible
                        -- si existe en los ya contrados en el abonado
                        lv_ssql := ' ';
                        lv_ssql :=
                             ' select lpad(cod_servsupl,2,''0'')||''0000''  ';
                        lv_ssql := lv_ssql || 'FROM ga_servsuplabo ';
                        lv_ssql :=
                              lv_ssql
                           || 'WHERE num_abonado='
                           || so_ga_abonado.num_abonado;
                        lv_ssql :=
                              lv_ssql || 'and cod_servicio = ' || lv_servincom;
                        lv_ssql := lv_ssql || ' AND ind_estado  < 3';

                        BEGIN
                           SELECT LPAD (cod_servsupl, 2, '0') || '0000'
                             INTO lv_ssincom_desa
                             FROM ga_servsuplabo
                            WHERE num_abonado = so_ga_abonado.num_abonado
                              AND cod_servicio = lv_servincom
                              AND ind_estado < 3;
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              lv_ssincom_desa := '';
                        END;

                        IF lv_ssincom_desa <> ''
                        THEN
                           lv_ssql := ' ';
                           lv_ssql := ' Update ga_servsuplabo';
                           lv_ssql := lv_ssql || ' set ind_estado   = 3, ';
                           lv_ssql :=
                                     lv_ssql || ' fec_bajaBD       = sysdate';
                           lv_ssql :=
                                 lv_ssql
                              || ' where num_abonado= '
                              || so_ga_abonado.num_abonado;
                           lv_ssql :=
                              lv_ssql || ' and cod_servicio = '
                              || lv_servincom;
                           lv_ssql := lv_ssql || ' and ind_estado   < 3';

                           UPDATE ga_servsuplabo
                              SET ind_estado = 3,
                                  fec_bajabd = SYSDATE
                            WHERE num_abonado = so_ga_abonado.num_abonado
                              AND cod_servicio = lv_servincom
                              AND ind_estado < 3;

                           lv_generasscadena :=
                                          lv_generasscadena || lv_ssincom_desa;
                        END IF;
                     END LOOP;

                     CLOSE so_ss_def;

                     lv_ssql := ' ';
                     lv_ssql := ' SELECT cod_concepto  ';
                     lv_ssql := lv_ssql || 'FROM ga_Actuaserv ';
                     lv_ssql :=
                         lv_ssql || 'WHERE COD_SERVICIO = ' || lv_cod_servicio;
                     lv_ssql := lv_ssql || ' AND cod_actabo     = ''FA''   ';
                     lv_ssql :=
                            lv_ssql || ' AND cod_producto   = ' || cn_producto;
                     lv_ssql := lv_ssql || ' AND cod_tipserv    = 2';

                     BEGIN
                        SELECT cod_concepto
                          INTO lv_cod_concepto
                          FROM ga_actuaserv
                         WHERE cod_servicio = lv_cod_servicio
                           AND cod_actabo = 'FA'
                           AND cod_producto = cn_producto
                           AND cod_tipserv = 2;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           lv_cod_concepto := '';
                     END;

                     IF (lv_cod_concepto = '')
                     THEN
                        lv_cod_concepto := NULL;
                     END IF;

                     lv_ssql := ' ';
                     lv_ssql := ' INSERT INTO ga_servsuplabo';
                     lv_ssql :=
                           lv_ssql
                        || ' (num_abonado, cod_servicio, fec_altabd, cod_servsupl, cod_nivel, ';
                     lv_ssql :=
                           lv_ssql
                        || ' cod_producto, NUM_TERMINAL, nom_usuarora, ind_estado, cod_concepto)';
                     lv_ssql :=
                           lv_ssql || ' VALUES (' || so_ga_abonado.num_abonado;
                     lv_ssql := lv_ssql || ' ,' || lv_cod_servicio;
                     lv_ssql := lv_ssql || ' ,SYSDATE ';
                     lv_ssql := lv_ssql || ' ,' || lv_central_ss_act_servsupl;
                     lv_ssql := lv_ssql || ' ,' || lv_central_ss_act_nivel;
                     lv_ssql := lv_ssql || ' ,1,' || so_ga_abonado.num_celular;
                     lv_ssql := lv_ssql || ' ,user';
                     lv_ssql := lv_ssql || ',1 ';
                     lv_ssql :=
                         lv_ssql || ' , ' || TO_NUMBER (lv_cod_concepto)
                         || ')';

                     INSERT INTO ga_servsuplabo
                                 (num_abonado, cod_servicio,
                                  fec_altabd, cod_servsupl,
                                  cod_nivel, cod_producto,
                                  num_terminal, nom_usuarora, ind_estado,
                                  cod_concepto
                                 )
                          VALUES (so_ga_abonado.num_abonado, lv_cod_servicio,
                                  SYSDATE, lv_central_ss_act_servsupl,
                                  lv_central_ss_act_nivel, 1,
                                  so_ga_abonado.num_celular, USER, 1,
                                  TO_NUMBER (lv_cod_concepto)
                                 );
                  ELSE
                     --centrales va a dar de baja el servicio
                     lv_ssql := ' ';
                     lv_ssql := ' SELECT COUNT(*)   ';
                     lv_ssql := lv_ssql || ' FROM ga_servsuplabo  ';
                     lv_ssql :=
                           lv_ssql
                        || 'WHERE num_abonado='
                        || so_ga_abonado.num_abonado;
                     lv_ssql :=
                           lv_ssql
                        || ' AND cod_servsupl = '
                        || lv_central_ss_act_servsupl;
                     lv_ssql := lv_ssql || ' AND ind_estado   = 2';
                     lv_ssql :=
                              lv_ssql || ' AND cod_producto = ' || cn_producto;

                     BEGIN
                        SELECT COUNT (*)
                          INTO ln_ss_baja
                          FROM ga_servsuplabo
                         WHERE num_abonado = so_ga_abonado.num_abonado
                           AND cod_servsupl = lv_central_ss_act_servsupl
                           AND ind_estado = 2
                           AND cod_producto = cn_producto;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           ln_ss_baja := 0;
                     END;

                     IF (ln_ss_baja) > 0
                     THEN
                        lv_ssql := ' ';
                        lv_ssql := 'UPDATE ga_servsuplabo SET';
                        lv_ssql := lv_ssql || 'ind_estado=3';
                        lv_ssql := lv_ssql || ' ,fec_bajabd=SYSDATE';
                        lv_ssql :=
                              lv_ssql
                           || 'WHERE num_abonado='
                           || so_ga_abonado.num_abonado;
                        lv_ssql :=
                              lv_ssql
                           || ' AND cod_servsupl = '
                           || lv_central_ss_act_servsupl;
                        lv_ssql := lv_ssql || ' AND ind_estado   = 2';

                        UPDATE ga_servsuplabo
                           SET ind_estado = 3,
                               fec_bajabd = SYSDATE
                         WHERE num_abonado = so_ga_abonado.num_abonado
                           AND cod_servsupl = lv_central_ss_act_servsupl
                           AND ind_estado = 2;
                     END IF;
                  END IF;
               END IF;
            END IF;
         END IF;
      END LOOP;

      IF     lb_proc_trarif
         AND so_ga_abonado.cod_actabo = lv_bajahibrido
         AND TRIM (lv_servss_trafic) <> ''
      THEN
         lv_ssql := ' ';
         lv_ssql := ' SELECT LPAD(cod_servsupl,2,0)||LPAD(cod_nivel,4,0), ';
         lv_ssql := lv_ssql || ' cod_servsupl,  ';
         lv_ssql := lv_ssql || 'cod_nivel';
         lv_ssql := lv_ssql || ' FROM ga_servsupl ';
         lv_ssql := lv_ssql || ' WHERE ind_estado   = 2';
         lv_ssql :=
            lv_ssql || ' AND cod_servicio=  trim("' || lv_servss_trafic
            || '")';

         BEGIN
            SELECT LPAD (cod_servsupl, 2, 0) || LPAD (cod_nivel, 4, 0),
                   cod_servsupl,
                   cod_nivel
              INTO lv_servss_trafic,                             --= sArray(1)
                   lv_servss_trafic_supl,                       -- = sArray(2)
                   lv_servss_trafic_nivel                       -- = sArray(3)
              FROM GA_SERVSUPL
             WHERE cod_servicio = TRIM (lv_servss_trafic);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               lv_servss_trafic := '';
               lv_servss_trafic_supl := '';
               lv_servss_trafic_nivel := '';
         END;

         IF lb_datos_arreglo
         THEN
            FOR ln_posx IN 1 .. ln_iserv - 1
            LOOP
               IF lv_servss_trafic_supl =
                       SUBSTR (scadenagenera_ss (ln_posx).cod_servicio, 1, 2)
               THEN
                  lb_ins_servtrafic := FALSE;
               END IF;
            END LOOP;
         END IF;

         IF lb_ins_servtrafic
         THEN
            FOR ln_posx IN 1 .. ln_cant_servicios
            LOOP
               lv_central_ss_act := SUBSTR (lv_central_cadena_copia, 1, 6);
               lv_central_cadena_act :=
                                     SUBSTR (lv_central_cadena_copia, 7, 255);

               IF TRIM (lv_servss_trafic) = TRIM (lv_central_ss_act)
               THEN
                  lb_ins_servtrafic := FALSE;
               END IF;
            END LOOP;
         END IF;

         IF lb_ins_servtrafic
         THEN
            lv_ssql := '';
            lv_ssql := 'UPDATE ga_servsuplabo SET';
            lv_ssql := lv_ssql || 'ind_estado=3';
            lv_ssql := lv_ssql || ' ,fec_bajabd=SYSDATE';
            lv_ssql :=
                  lv_ssql
               || ',fec_altacen      =DECODE(fec_altacen,NULL,SYSDATE,fec_altacen)';
            lv_ssql :=
                 lv_ssql || 'WHERE num_abonado =' || so_ga_abonado.num_abonado;
            lv_ssql :=
                    lv_ssql || ' AND cod_servsupl  =' || lv_servss_trafic_supl;
            lv_ssql := lv_ssql || ' AND ind_estado in (1,2)';

            UPDATE ga_servsuplabo
               SET ind_estado = 3,
                   fec_bajabd = SYSDATE,
                   fec_altacen =
                              DECODE (fec_altacen,
                                      NULL, SYSDATE,
                                      fec_altacen
                                     )
             WHERE num_abonado = so_ga_abonado.num_abonado
               AND cod_servsupl = lv_servss_trafic_supl
               AND ind_estado IN (1, 2);

            lv_ssql := ' ';
            lv_ssql := ' SELECT cod_concepto';
            lv_ssql := lv_ssql || ' FROM ga_Actuaserv ';
            lv_ssql := lv_ssql || 'WHERE COD_SERVICIO = ' || lv_cod_servicio;
            lv_ssql := lv_ssql || ' AND cod_actabo     = ''FA'' ';
            lv_ssql := lv_ssql || ' AND cod_producto   = ' || cn_producto;
            lv_ssql := lv_ssql || ' AND cod_tipserv    = ''2'' ';

            BEGIN
               SELECT cod_concepto
                 INTO lv_cod_concepto
                 FROM ga_actuaserv
                WHERE cod_servicio = lv_cod_servicio
                  AND cod_actabo = 'FA'
                  AND cod_producto = cn_producto
                  AND cod_tipserv = '2';
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  lv_cod_concepto := '';
            END;

            lv_ssql := ' ';
            lv_ssql :=
               ' SELECT ga_seq_numdiasnum.NEXTVAL into Ll_NUMDIASNUM FROM DUAL';

            SELECT ga_seq_numdiasnum.NEXTVAL
              INTO ll_numdiasnum
              FROM DUAL;

            IF (lv_cod_concepto = '')
            THEN
               lv_cod_concepto := NULL;
            END IF;

            lv_ssql := '';
            lv_ssql := 'INSERT INTO ga_servsuplabo';
            lv_ssql :=
                  lv_ssql
               || '(num_abonado,cod_servicio,fec_altabd,cod_servsupl,cod_nivel';
            lv_ssql :=
                  lv_ssql
               || ',cod_producto,num_terminal,nom_usuarora,ind_estado,cod_concepto,num_diasnum)';
            lv_ssql := lv_ssql || 'VALUES ( ' || so_ga_abonado.num_abonado;
            lv_ssql := lv_ssql || ',' || lv_servss_trafic;
            lv_ssql := lv_ssql || ' ,SYSDATE';
            lv_ssql := lv_ssql || ' ,' || lv_servss_trafic_supl;
            lv_ssql := lv_ssql || ' ,' || lv_servss_trafic_nivel;
            lv_ssql := lv_ssql || ' ,1, ' || so_ga_abonado.num_celular;
            lv_ssql := lv_ssql || ' ,user';
            lv_ssql := lv_ssql || ',1';
            lv_ssql := lv_ssql || ' ,' || lv_cod_concepto;
            lv_ssql := lv_ssql || ',' || ll_numdiasnum || ')';

            INSERT INTO ga_servsuplabo
                        (num_abonado, cod_servicio,
                         fec_altabd, cod_servsupl,
                         cod_nivel, cod_producto,
                         num_terminal, nom_usuarora, ind_estado,
                         cod_concepto, num_diasnum
                        )
                 VALUES (so_ga_abonado.num_abonado, lv_servss_trafic,
                         SYSDATE, lv_servss_trafic_supl,
                         lv_servss_trafic_nivel, 1,
                         so_ga_abonado.num_celular, USER, 1,
                         lv_cod_concepto, ll_numdiasnum
                        );
         END IF;
      END IF;

      lv_generasscadena_act := '';

      OPEN so_ss_abon;

      LOOP
         FETCH so_ss_abon
          INTO lv_servss;

         EXIT WHEN so_ss_abon%NOTFOUND;
         lv_generasscadena_act := lv_generasscadena_act || lv_servss;
      END LOOP;

      so_ga_abonado.clase_servicio := TRIM (lv_generasscadena_act);

      CLOSE so_ss_abon;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 149;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_GENERASS_CTASEG_CENTRAL_PR ('
            || so_ga_abonado.num_serie
            || ','
            || so_ga_abonado.fecha_alta
            || so_ga_abonado.fecha_prorroga
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                        (sn_num_evento,
                         cv_cod_modulo,
                         sv_mens_retorno,
                         cv_version,
                         USER,
                         'PV_ORDEN_SERVICIO_PG.PV_GENERASS_CTASEG_CENTRAL_PR',
                         lv_ssql,
                         sn_cod_retorno,
                         lv_des_error
                        );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_GENERASS_CTASEG_CENTRAL_PR ('
            || so_ga_abonado.num_serie
            || ','
            || so_ga_abonado.fecha_alta
            || so_ga_abonado.fecha_prorroga
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                        (sn_num_evento,
                         cv_cod_modulo,
                         sv_mens_retorno,
                         cv_version,
                         USER,
                         'PV_ORDEN_SERVICIO_PG.PV_GENERASS_CTASEG_CENTRAL_PR',
                         lv_ssql,
                         sn_cod_retorno,
                         lv_des_error
                        );
   END pv_generass_ctaseg_central_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_obtener_codpenaliza_pr (
      so_ga_abonado     IN OUT          ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
/*
   <Documentacion TipoDoc = "Procedimiento">
   <Elemento Nombre = "PV_RANGO_ANTIGUEDAD_PR "
    Lenguaje="PL/SQL" Fecha="10-08-2007"
    Versión"1.0.0" Dise+ador"****"
    Programador="" Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion>   Funcion que devuelve Rango Antiguedad  </Descripcion>
   <Parametros>
   <Entrada>
         <param nom="SO_GA_ABONADO "    Tipo="Estructura Type GA_ABONADO_QT"> Datos de Estructura  </param>>
   </Entrada>
            <Salida>
             <param nom="SO_GA_ABONADO"         Tipo="NUMERICO">Codigo de Retorno         </param>>
               <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo de Retorno         </param>>
               <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje de Retorno        </param>>
               <param nom="SN_num_evento"             Tipo="NUMERICO">Numero de Evento       </param>>
            </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
   */
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
      ln_indarriendo         ge_modventa.ind_cuotas%TYPE;
      ln_codpencontra        NUMBER;
      lv_codpencontra        VARCHAR2 (5);
      lv_tipoindemnizacion   VARCHAR2 (5);
      ln_mes                 NUMBER;
      ln_afecto              VARCHAR2 (5);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql := ' SELECT IND_CUOTAS ';
      lv_ssql := lv_ssql || ' INTO LN_IndArriendo';
      lv_ssql := lv_ssql || ' FROM GE_MODVENTA ';
      lv_ssql :=
         lv_ssql || ' WHERE COD_MODVENTA = '
         || so_ga_abonado.modalidad_de_pago;

      SELECT ind_cuotas
        INTO ln_indarriendo
        FROM ge_modventa
       WHERE cod_modventa = so_ga_abonado.modalidad_de_pago;

      IF (ln_indarriendo = -1)
      THEN                   --'Codigo de Penalización para modalidad comodato
         lv_ssql := ' SELECT COD_PENALIZA_COMODATO INTO   LN_CodPenContra ';
         lv_ssql := lv_ssql || '  FROM  GA_DATOSGENER';

         SELECT cod_penaliza_comodato
           INTO ln_codpencontra
           FROM ga_datosgener;

         so_ga_abonado.cod_pen_contra := ln_codpencontra;
         so_ga_abonado.tipo_indemnizacion := NULL;
      ELSE
--     LN_Mes :=  TRUNC(SYSDATE)  - TRUNC(SO_GA_ABONADO.FEC_FINCONTRA) ;
         SELECT   TRUNC (SYSDATE)
                - TO_DATE (so_ga_abonado.fec_fincontra, 'dd-mm-yyyy')
           INTO ln_mes
           FROM DUAL;

         --trunc(sysdate) - trunc(LD_FecSysCser)
         IF (ln_mes >= 0)
         THEN
            ln_afecto := 'FALSE';
         ELSE
            ln_afecto := 'TRUE';
         END IF;

         -- Select Decode(LN_Mes ,-1,  'TRUE', 'FALSE') into LN_AFECTO from dual;
         so_ga_abonado.afecto_indem := ln_afecto;

         IF so_ga_abonado.afecto_indem = 'FALSE'
         THEN
            so_ga_abonado.cod_pen_contra := NULL;
         ELSE
            lv_ssql :=
                  ' PV_PRC_PLAN_INDEMNIZACION('
               || so_ga_abonado.num_abonado
               || ','
               || lv_tipoindemnizacion
               || ','
               || lv_codpencontra
               || ')';
            pv_prc_plan_indemnizacion (so_ga_abonado.num_abonado,
                                       lv_tipoindemnizacion,
                                       lv_codpencontra
                                      );
            so_ga_abonado.cod_pen_contra := TO_NUMBER (lv_codpencontra);
            so_ga_abonado.tipo_indemnizacion := lv_tipoindemnizacion;
         END IF;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 149;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_OBTENER_CODPENALIZA_PR ('
            || so_ga_abonado.num_serie
            || ','
            || so_ga_abonado.fecha_alta
            || so_ga_abonado.fecha_prorroga
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                            (sn_num_evento,
                             cv_cod_modulo,
                             sv_mens_retorno,
                             cv_version,
                             USER,
                             'PV_ORDEN_SERVICIO_PG.PV_OBTENER_CODPENALIZA_PR',
                             lv_ssql,
                             sn_cod_retorno,
                             lv_des_error
                            );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_OBTENER_CODPENALIZA_PR ('
            || so_ga_abonado.num_serie
            || ','
            || so_ga_abonado.fecha_alta
            || so_ga_abonado.fecha_prorroga
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                            (sn_num_evento,
                             cv_cod_modulo,
                             sv_mens_retorno,
                             cv_version,
                             USER,
                             'PV_ORDEN_SERVICIO_PG.PV_OBTENER_CODPENALIZA_PR',
                             lv_ssql,
                             sn_cod_retorno,
                             lv_des_error
                            );
   END pv_obtener_codpenaliza_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_rango_antiguedad_pr (
      so_ga_abonado     IN OUT          ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
/*
   <Documentacion TipoDoc = "Procedimiento">
   <Elemento Nombre = "PV_RANGO_ANTIGUEDAD_PR "
    Lenguaje="PL/SQL" Fecha="10-08-2007"
    Versión"1.0.0" Dise+ador"****"
    Programador="" Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion>   Funcion que devuelve Rango Antiguedad  </Descripcion>
   <Parametros>
   <Entrada>
         <param nom="SO_GA_ABONADO "    Tipo="Estructura Type GA_ABONADO_QT"> Datos de Estructura  </param>>
   </Entrada>
            <Salida>
             <param nom="SO_GA_ABONADO"         Tipo="NUMERICO">Codigo de Retorno         </param>>
               <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo de Retorno         </param>>
               <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje de Retorno        </param>>
               <param nom="SN_num_evento"             Tipo="NUMERICO">Numero de Evento       </param>>
            </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
   */
      lv_des_error     ge_errores_pg.desevent;
      lv_ssql          ge_errores_pg.vquery;
      lv_fechacambio   VARCHAR (20);
      ld_fecsyscser    DATE;
      ln_nmes          NUMBER;
      cod_antiguedad   gad_rangos_antiguedad.cod_rango%TYPE;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql := 'SELECT to_char(min(fec_alta), ''DD-MM-YY'') ';
      lv_ssql := lv_ssql || ' FROM ga_equipaboser ';
      lv_ssql := lv_ssql || ' WHERE num_serie = ' || so_ga_abonado.num_serie;
      lv_ssql :=
            lv_ssql
         || ' AND NVL('
         || so_ga_abonado.causa_baja
         || ', cod_causa) NOT IN (';
      lv_ssql :=
            lv_ssql
         || ' SELECT COD_CAUCASER FROM GA_CAUCASER WHERE COD_PRODUCTO = '
         || cn_producto;
      lv_ssql := lv_ssql || '  AND IND_ANTIGUEDAD = ' || cn_cero || ')';

      SELECT TO_CHAR (MIN (fec_alta), 'DD-MM-YYYY')
        INTO lv_fechacambio
        FROM ga_equipaboser
       WHERE num_serie = so_ga_abonado.num_serie
         AND NVL (so_ga_abonado.causa_baja, cod_causa) NOT IN (
                 SELECT cod_caucaser
                   FROM ga_caucaser
                  WHERE cod_producto = cn_producto
                        AND ind_antiguedad = cn_cero);

      IF TRIM (lv_fechacambio) IS NOT NULL
      THEN
         ld_fecsyscser := TO_DATE (lv_fechacambio, 'dd-mm-yyyy');

         IF ld_fecsyscser IS NOT NULL
         THEN
            -- LN_nMes := DateDiff('m', LD_FecSysCser, sysdate);
            SELECT TRUNC (MONTHS_BETWEEN (TRUNC (SYSDATE),
                                          TO_DATE (ld_fecsyscser, 'dd-mm-yy')
                                         )
                         )
              INTO ln_nmes
              FROM DUAL;
         ELSE
            IF so_ga_abonado.fecha_prorroga IS NOT NULL
            THEN
               -- LN_nMes := DateDiff("m", Fecha_prorroga, sysdate);
               SELECT TRUNC
                         (MONTHS_BETWEEN
                                       (TRUNC (SYSDATE),
                                        TO_DATE (so_ga_abonado.fecha_prorroga,
                                                 'dd-mm-yy'
                                                )
                                       )
                         )
                 INTO ln_nmes
                 FROM DUAL;
            END IF;
         END IF;
      ELSE
         -- LN_nMes := DateDiff("m",  Fecha_alta, sysdate);
         SELECT TRUNC (MONTHS_BETWEEN (TRUNC (SYSDATE),
                                       TO_DATE (so_ga_abonado.fecha_alta,
                                                'dd-mm-yy'
                                               )
                                      )
                      )
           INTO ln_nmes
           FROM DUAL;
      END IF;

      lv_ssql := ' SELECT cod_rango INTO Cod_Antiguedad ';
      lv_ssql := lv_ssql || ' FROM gad_rangos_antiguedad';
      lv_ssql := lv_ssql || '  WHERE cod_tiprango =  ' || cn_tiprango;
      lv_ssql :=
           lv_ssql || ' AND ' || ln_nmes || ' BETWEEN ran_desde AND ran_hasta';

      SELECT cod_rango
        INTO cod_antiguedad
        FROM gad_rangos_antiguedad
       WHERE cod_tiprango = cn_tiprango
         AND ln_nmes BETWEEN ran_desde AND ran_hasta;

      so_ga_abonado.rango_antiguedad := cod_antiguedad;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 149;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_RANGO_ANTIGUEDAD_PR ('
            || so_ga_abonado.num_serie
            || ','
            || ln_nmes
            || ','
            || so_ga_abonado.causa_baja
            || ','
            || so_ga_abonado.fecha_alta
            || ','
            || so_ga_abonado.fecha_prorroga
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                               (sn_num_evento,
                                cv_cod_modulo,
                                sv_mens_retorno,
                                cv_version,
                                USER,
                                'PV_ORDEN_SERVICIO_PG.PV_RANGO_ANTIGUEDAD_PR',
                                lv_ssql,
                                sn_cod_retorno,
                                lv_des_error
                               );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_RANGO_ANTIGUEDAD_PR ('
            || so_ga_abonado.num_serie
            || ','
            || so_ga_abonado.causa_baja
            || ','
            || so_ga_abonado.fecha_alta
            || ','
            || so_ga_abonado.fecha_prorroga
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                               (sn_num_evento,
                                cv_cod_modulo,
                                sv_mens_retorno,
                                cv_version,
                                USER,
                                'PV_ORDEN_SERVICIO_PG.PV_RANGO_ANTIGUEDAD_PR',
                                lv_ssql,
                                sn_cod_retorno,
                                lv_des_error
                               );
   END pv_rango_antiguedad_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_causa_de_excepcion_pr (
      so_causas         OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   )
   IS
/*
   <Documentacion TipoDoc = "Funcion">
   <Elemento Nombre = "PV_CAUSA_DE_EXCEPCION_PR "
    Lenguaje="PL/SQL" Fecha="10-08-2007"
    Versión"1.0.0" Dise+ador"****"
    Programador="" Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion>   Funcion que valida la causa de excepción </Descripcion>
   <Parametros>
   <Entrada>
         <param nom="SO_CAUSAS"   Tipo="refcursor" > Datos de Estructura  </param>>
   </Entrada>
            <Salida>
               <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo de Retorno         </param>>
               <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje de Retorno        </param>>
               <param nom="SN_num_evento"             Tipo="NUMERICO">Numero de Evento       </param>>
            </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
   */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql := ' SELECT EP.COD_CAUSA, EP.DESC_CAUSA';
      lv_ssql := lv_ssql || ' FROM VE_EXCEPCION_PREPAGO_TD EP';
      lv_ssql := lv_ssql || ' WHERE EP.FECHA_VIGENCIA_DESDE < SYSDATE';
      lv_ssql :=
          lv_ssql || ' AND NVL(EP.FECHA_VIGENCIA_HASTA, SYSDATE ) >= SYSDATE';

      OPEN so_causas FOR
         SELECT ep.cod_causa, ep.desc_causa
           FROM ve_excepcion_prepago_td ep
          WHERE ep.fecha_vigencia_desde < SYSDATE
            AND NVL (ep.fecha_vigencia_hasta, SYSDATE) >= SYSDATE;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := 'PV_CAUSA_DE_EXCEPCION_PR (); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'PV_ORDEN_SERVICIO_PG.PV_CAUSA_DE_EXCEPCION_PR',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
   END pv_causa_de_excepcion_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_validar_serv_dupl_fn (
      so_ga_abonado     IN              ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN VARCHAR2
   AS
/*
   <Documentacion TipoDoc = "Funcion">
   <Elemento Nombre = "PV_VALIDAR_SERV_DUPL_FN "
    Lenguaje="PL/SQL" Fecha="10-08-2007"
    Versión"1.0.0" Dise+ador"****"
    Programador="" Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion>   Funcion que valida DUPLICIDAD serv_suplementario , retorna true o falso  </Descripcion>
   <Parametros>
   <Entrada>
         <param nom="SO_GA_ABONADO "    Tipo="Estructura Type GA_ABONADO_QT"> Datos de Estructura  </param>>
   </Entrada>
            <Salida>
               <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo de Retorno         </param>>
               <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje de Retorno        </param>>
               <param nom="SN_num_evento"             Tipo="NUMERICO">Numero de Evento       </param>>
            </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
   */
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
      sn_cod_servsupl        NUMBER (2);
      sn_count_cod_sersupl   NUMBER (10);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql :=
         ' SELECT A.COD_SERVSUPL, COUNT(A.COD_SERVSUPL) into SN_COD_SERVSUPL, SN_COUNT_COD_SERSUPL';
      lv_ssql :=
            lv_ssql
         || ' FROM GA_SERVSUPL A,ICG_SERVICIOTERCEN B,GAD_SERVSUP_PLAN C';
      lv_ssql := lv_ssql || ' Where C.Cod_producto =  ' || cn_producto;
      lv_ssql := lv_ssql || ' AND B.COD_PRODUCTO = A.COD_PRODUCTO';
      lv_ssql :=
             lv_ssql || ' AND B.TIP_TERMINAL = ' || so_ga_abonado.tip_terminal;
      lv_ssql := lv_ssql || ' AND B.COD_SISTEMA =  (';
      lv_ssql := lv_ssql || ' SELECT COD_SISTEMA  FROM ICG_CENTRAL ';
      lv_ssql :=
               lv_ssql || ' WHERE COD_CENTRAL = ' || so_ga_abonado.cod_central;
      lv_ssql := lv_ssql || ' AND COD_PRODUCTO = ' || cn_producto || ')';
      lv_ssql := lv_ssql || ' AND B.COD_SERVICIO = A.COD_SERVSUPL';
      lv_ssql :=
         lv_ssql || ' AND B.TIP_TECNOLOGIA = ' || so_ga_abonado.cod_tecnologia;
      lv_ssql := lv_ssql || ' AND A.COD_SERVICIO = C.COD_SERVICIO';
      lv_ssql := lv_ssql || ' AND A.COD_PRODUCTO = C.COD_PRODUCTO';
      lv_ssql :=
           lv_ssql || ' AND C.COD_PLANTARIF = ' || so_ga_abonado.cod_plantarif;
      lv_ssql := lv_ssql || ' AND C.TIP_RELACION = 3';
      lv_ssql := lv_ssql || ' AND SYSDATE BETWEEN C.FEC_DESDE AND C.FEC_HASTA';
      lv_ssql :=
         lv_ssql || ' GROUP BY A.COD_SERVSUPL HAVING COUNT(A.COD_SERVSUPL)>1;';

      SELECT   a.cod_servsupl, COUNT (a.cod_servsupl)
          INTO sn_cod_servsupl, sn_count_cod_sersupl
          FROM GA_SERVSUPL a, icg_serviciotercen b, gad_servsup_plan c
         WHERE c.cod_producto = cn_producto
           AND b.cod_producto = a.cod_producto
           AND b.tip_terminal = so_ga_abonado.tip_terminal
           AND b.cod_sistema =
                  (SELECT cod_sistema
                     FROM icg_central
                    WHERE cod_central = so_ga_abonado.cod_central
                      AND cod_producto = cn_producto)
           AND b.cod_servicio = a.cod_servsupl
           AND b.tip_tecnologia = so_ga_abonado.cod_tecnologia
           AND a.cod_servicio = c.cod_servicio
           AND a.cod_producto = c.cod_producto
           AND c.cod_plantarif = so_ga_abonado.cod_plantarif
           AND c.tip_relacion = 3
           AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta
      GROUP BY a.cod_servsupl
        HAVING COUNT (a.cod_servsupl) > 1;

      RETURN 'FALSE';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN 'TRUE';
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_VALIDAR_SERV_DUPL_FN ('
            || so_ga_abonado.cod_plantarif
            || ','
            || so_ga_abonado.cod_tecnologia
            || so_ga_abonado.cod_plantarif
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                              (sn_num_evento,
                               cv_cod_modulo,
                               sv_mens_retorno,
                               cv_version,
                               USER,
                               'PV_ORDEN_SERVICIO_PG.PV_VALIDAR_SERV_DUPL_FN',
                               lv_ssql,
                               sn_cod_retorno,
                               lv_des_error
                              );
         RETURN 'FALSE';
   END pv_validar_serv_dupl_fn;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_regist_nivel_modifi_pr (
      eo_regist_nivel_modif   IN OUT NOCOPY   pv_regist_nivel_modif_qt,
      sn_cod_retorno          OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno         OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento           OUT NOCOPY      ge_errores_pg.evento
   )
   IS
/*
<Documentación
     TipoDoc = "Procedure">>
      <Elemento
         Nombre = "PV_REGIST_NIVEL_MODIFI_PR     "
         Lenguaje="PL/SQL"
         Fecha="06-07-2007"
         Versión="La del package"
         Dise+ador=""
         Programador="Carlos Elizondo"
        Modificado="Juan Gonzalez C"
        Fecha Modificacion="16-01-2008"
         Ambiente Desarrollo="BD">
         <Retorno>N/A</Retorno>>
            <Descripción>Metodo  :  Ejecuta PL existente PV_REGISTRA_MODIFICACION_PR                </Descripción>>
         <Par+metros>
            <Entrada>
               <param nom="EO_REGIST_NIVEL_MODIF    Tipo="Estructura Type ">Estructura Type  </param>>
            </Entrada>
            <Salida>
               <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
               <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
               <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
            </Salida>
         </Par+metros>
      </Elemento>
</Documentación>
*/
      lv_des_error        ge_errores_pg.desevent;
      lv_ssql             ge_errores_pg.vquery;
      error_ejecucion     EXCEPTION;
      lv_fecha_modifica   DATE;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF TRIM (eo_regist_nivel_modif.cod_plantarif_antiguo) IS NULL
      THEN
         eo_regist_nivel_modif.cod_plantarif_antiguo := ' ';
      END IF;

      IF TRIM (eo_regist_nivel_modif.cod_plantarif_destino) IS NULL
      THEN
         eo_regist_nivel_modif.cod_plantarif_destino := ' ';
      END IF;

      IF TRIM (eo_regist_nivel_modif.cod_cargobasico_antiguo) IS NULL
      THEN
         eo_regist_nivel_modif.cod_cargobasico_antiguo := ' ';
      END IF;

      IF TRIM (eo_regist_nivel_modif.cod_cargobasico_destino) IS NULL
      THEN
         eo_regist_nivel_modif.cod_cargobasico_destino := ' ';
      END IF;

      IF TRIM (eo_regist_nivel_modif.cod_limconsumo_antiguo) IS NULL
      THEN
         eo_regist_nivel_modif.cod_limconsumo_antiguo := ' ';
      END IF;

      IF TRIM (eo_regist_nivel_modif.cod_limconsumo_destino) IS NULL
      THEN
         eo_regist_nivel_modif.cod_limconsumo_destino := ' ';
      END IF;

      IF TRIM (eo_regist_nivel_modif.cod_planserv_antiguo) IS NULL
      THEN
         eo_regist_nivel_modif.cod_planserv_antiguo := ' ';
      END IF;

      IF TRIM (eo_regist_nivel_modif.cod_planserv_destino) IS NULL
      THEN
         eo_regist_nivel_modif.cod_planserv_destino := ' ';
      END IF;

      IF TRIM (eo_regist_nivel_modif.cod_ciclo_antiguo) IS NULL
      THEN
         eo_regist_nivel_modif.cod_ciclo_antiguo := ' ';
      END IF;

      IF TRIM (eo_regist_nivel_modif.cod_ciclo_destino) IS NULL
      THEN
         eo_regist_nivel_modif.cod_ciclo_destino := ' ';
      END IF;

      IF (TRIM(EO_REGIST_NIVEL_MODIF.COD_TIPMODI) = 'A2') THEN
           EO_REGIST_NIVEL_MODIF.COD_TIPMODI :='AE';
      END IF;



      lv_fecha_modifica :=
         TO_DATE (eo_regist_nivel_modif.fec_modifica, 'DD-MM-YYYY HH24:MI:SS');

      IF eo_regist_nivel_modif.tip_subjeto = cv_tip_subjeto_a
      THEN
         lv_ssql := 'INSERT INTO GA_MODABOCEL';
         lv_ssql := lv_ssql || ' (';
         lv_ssql := lv_ssql || '         NUM_ABONADO,';
         lv_ssql := lv_ssql || '         COD_TIPMODI,';
         lv_ssql := lv_ssql || '         FEC_MODIFICA,';
         lv_ssql := lv_ssql || '         NOM_USUARORA';

         IF eo_regist_nivel_modif.cod_plantarif_antiguo <>
                                  eo_regist_nivel_modif.cod_plantarif_destino
         THEN
            lv_ssql := lv_ssql || '         ,COD_PLANTARIF';
         END IF;

         IF eo_regist_nivel_modif.cod_cargobasico_antiguo <>
                                 eo_regist_nivel_modif.cod_cargobasico_destino
         THEN
            lv_ssql := lv_ssql || '         ,COD_CARGOBASICO';
         END IF;

         IF eo_regist_nivel_modif.cod_planserv_antiguo <>
                                    eo_regist_nivel_modif.cod_planserv_destino
         THEN
            lv_ssql := lv_ssql || '         ,COD_PLANSERV';
         END IF;

         IF eo_regist_nivel_modif.cod_limconsumo_antiguo <>
                                  eo_regist_nivel_modif.cod_limconsumo_destino
         THEN
            lv_ssql := lv_ssql || '         ,COD_LIMCONSUMO';
         END IF;

         IF eo_regist_nivel_modif.cod_ciclo_antiguo <>
                                       eo_regist_nivel_modif.cod_ciclo_destino
         THEN
            lv_ssql := lv_ssql || '         ,COD_CICLO';
         END IF;

         lv_ssql := lv_ssql || ' )';
         lv_ssql := lv_ssql || ' VALUES';
         lv_ssql := lv_ssql || ' (';
         lv_ssql :=
                   lv_ssql || '         ' || eo_regist_nivel_modif.num_abonado;
         lv_ssql :=
               lv_ssql
            || '         ,'''
            || eo_regist_nivel_modif.cod_tipmodi
            || '''';
         lv_ssql :=
               lv_ssql
            || ' ,TO_DATE('''
            || eo_regist_nivel_modif.fec_modifica
            || ''',''DD-MM-YYYY HH24:MI:SS'')';
--                LV_sSql := LV_sSql || '         ,'''||EO_REGIST_NIVEL_MODIF.FEC_MODIFICA||'''';
         lv_ssql :=
               lv_ssql
            || '         ,'''
            || eo_regist_nivel_modif.nom_usuarora
            || '''';

         IF eo_regist_nivel_modif.cod_plantarif_antiguo <>
                                   eo_regist_nivel_modif.cod_plantarif_destino
         THEN
            lv_ssql :=
                  lv_ssql
               || '         ,'''
               || eo_regist_nivel_modif.cod_plantarif_antiguo
               || '''';
         END IF;

         IF eo_regist_nivel_modif.cod_cargobasico_antiguo <>
                                 eo_regist_nivel_modif.cod_cargobasico_destino
         THEN
            lv_ssql :=
                  lv_ssql
               || '         ,'''
               || eo_regist_nivel_modif.cod_cargobasico_antiguo
               || '''';
         END IF;

         IF eo_regist_nivel_modif.cod_planserv_antiguo <>
                                    eo_regist_nivel_modif.cod_planserv_destino
         THEN
            lv_ssql :=
                  lv_ssql
               || '         ,'''
               || eo_regist_nivel_modif.cod_planserv_antiguo
               || '''';
         END IF;

         IF eo_regist_nivel_modif.cod_limconsumo_antiguo <>
                                  eo_regist_nivel_modif.cod_limconsumo_destino
         THEN
            lv_ssql :=
                  lv_ssql
               || '         ,'''
               || eo_regist_nivel_modif.cod_limconsumo_antiguo
               || '''';
         END IF;

         IF eo_regist_nivel_modif.cod_ciclo_antiguo <>
                                       eo_regist_nivel_modif.cod_ciclo_destino
         THEN
            lv_ssql :=
                  lv_ssql
               || '         ,'
               || eo_regist_nivel_modif.cod_ciclo_antiguo;
         END IF;

         lv_ssql := lv_ssql || ' )';

         EXECUTE IMMEDIATE lv_ssql;
      ELSIF eo_regist_nivel_modif.tip_subjeto = cv_tip_subjeto_c
      THEN
         SELECT nom_cliente,
                nom_apeclien1,
                nom_apeclien2
           INTO eo_regist_nivel_modif.nom_cliente,
                eo_regist_nivel_modif.nom_apeclien1,
                eo_regist_nivel_modif.nom_apeclien2
           FROM ge_clientes
          WHERE cod_cliente = eo_regist_nivel_modif.cod_cliente;

         lv_ssql := 'INSERT INTO GA_MODCLI';
         lv_ssql := lv_ssql || ' (';
         lv_ssql := lv_ssql || '         COD_CLIENTE,';
         lv_ssql := lv_ssql || '         COD_TIPMODI,';
         lv_ssql := lv_ssql || '         FEC_MODIFICA,';
         lv_ssql := lv_ssql || '         NOM_USUARORA,';
         lv_ssql := lv_ssql || '         NOM_CLIENTE,';
         lv_ssql := lv_ssql || '         NOM_APECLIEN1,';
         lv_ssql := lv_ssql || '         NOM_APECLIEN2';

         IF eo_regist_nivel_modif.cod_plantarif_antiguo <>
                                   eo_regist_nivel_modif.cod_plantarif_destino
         THEN
            lv_ssql := lv_ssql || '         ,COD_PLANTARIF';
         END IF;

         IF eo_regist_nivel_modif.cod_cargobasico_antiguo <>
                                 eo_regist_nivel_modif.cod_cargobasico_destino
         THEN
            lv_ssql := lv_ssql || '         ,COD_CARGOBASICO';
         END IF;

         IF eo_regist_nivel_modif.cod_limconsumo_antiguo <>
                                  eo_regist_nivel_modif.cod_limconsumo_destino
         THEN
            lv_ssql := lv_ssql || '         ,COD_LIMCONSUMO';
         END IF;

         IF eo_regist_nivel_modif.cod_ciclo_antiguo <>
                                       eo_regist_nivel_modif.cod_ciclo_destino
         THEN
            lv_ssql := lv_ssql || '         ,COD_CICLO';
         END IF;

         lv_ssql := lv_ssql || ' )';
         lv_ssql := lv_ssql || ' VALUES';
         lv_ssql := lv_ssql || ' (';
         lv_ssql :=
                   lv_ssql || '         ' || eo_regist_nivel_modif.cod_cliente;
         lv_ssql :=
               lv_ssql
            || '         ,'''
            || eo_regist_nivel_modif.cod_tipmodi
            || '''';
         lv_ssql :=
               lv_ssql
            || ' ,TO_DATE('''
            || eo_regist_nivel_modif.fec_modifica
            || ''',''DD-MM-YYYY HH24:MI:SS'')';
         lv_ssql :=
               lv_ssql
            || '         ,'''
            || eo_regist_nivel_modif.nom_usuarora
            || '''';
         lv_ssql :=
               lv_ssql
            || '         ,'''
            || eo_regist_nivel_modif.nom_cliente
            || '''';
         lv_ssql :=
               lv_ssql
            || '         ,'''
            || eo_regist_nivel_modif.nom_apeclien1
            || '''';
         lv_ssql :=
               lv_ssql
            || '         ,'''
            || eo_regist_nivel_modif.nom_apeclien2
            || '''';

         IF eo_regist_nivel_modif.cod_plantarif_antiguo <>
                                   eo_regist_nivel_modif.cod_plantarif_destino
         THEN
            lv_ssql :=
                  lv_ssql
               || '         ,'''
               || eo_regist_nivel_modif.cod_plantarif_antiguo
               || '''';
         END IF;

         IF eo_regist_nivel_modif.cod_cargobasico_antiguo <>
                                 eo_regist_nivel_modif.cod_cargobasico_destino
         THEN
            lv_ssql :=
                  lv_ssql
               || '         ,'''
               || eo_regist_nivel_modif.cod_cargobasico_antiguo
               || '''';
         END IF;

         IF eo_regist_nivel_modif.cod_limconsumo_antiguo <>
                                  eo_regist_nivel_modif.cod_limconsumo_destino
         THEN
            lv_ssql :=
                  lv_ssql
               || '         ,'''
               || eo_regist_nivel_modif.cod_limconsumo_antiguo
               || '''';
         END IF;

         IF eo_regist_nivel_modif.cod_ciclo_antiguo <>
                                       eo_regist_nivel_modif.cod_ciclo_destino
         THEN
            lv_ssql :=
                  lv_ssql
               || '         ,'
               || eo_regist_nivel_modif.cod_ciclo_antiguo;
         END IF;

         lv_ssql := lv_ssql || ' )';

         EXECUTE IMMEDIATE lv_ssql;
      ELSE
         lv_des_error :=
               ' PV_REGIST_NIVEL_MODIFI_PR - TIP_SUBJETO ('
            || eo_regist_nivel_modif.tip_subjeto
            || ') ERRONEO. DEBE SER '
            || cv_tip_subjeto_a
            || ' o '
            || cv_tip_subjeto_c
            || '.';
         RAISE error_ejecucion;
      END IF;
   --dbms_output.PUT_LINE('LV_sSql: '||LV_sSql);
   EXCEPTION
      WHEN error_ejecucion
      THEN
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            cv_cod_modulo,
                            sv_mens_retorno,
                            cv_version,
                            USER,
                            'PV_ORDEN_SERVICIO_PG.PV_REGIST_NIVEL_MODIFI_PR',
                            lv_ssql,
                            sn_cod_retorno,
                            lv_des_error
                           );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_REGIST_NIVEL_MODIFI_PR('
            || eo_regist_nivel_modif.cod_tipmodi
            || ','
            || eo_regist_nivel_modif.tip_subjeto
            || ','
            || eo_regist_nivel_modif.cod_cliente
            || ','
            || eo_regist_nivel_modif.num_abonado
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                            (sn_num_evento,
                             cv_cod_modulo,
                             sv_mens_retorno,
                             cv_version,
                             USER,
                             'PV_ORDEN_SERVICIO_PG.PV_REGIST_NIVEL_MODIFI_PR',
                             lv_ssql,
                             sn_cod_retorno,
                             lv_des_error
                            );
   END pv_regist_nivel_modifi_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_obtiene_datos_tiporserv_pr (
      eo_orden_servicio   IN OUT NOCOPY   pv_orden_servicio_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_OBTIENE_DATOS_TIPORSERV_PR    "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  RegistraCambPlanBatch               </Descripción>>
               <Descripción>Metodo  :  Obtiene Tipo de Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="EO_ORDEN_SERVICIO    Tipo="Estructura Type ">Estructura Retorna Tipo de Orden de Servicio  </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := NULL;
      lv_ssql := '';
      lv_ssql := lv_ssql || 'SELECT a.descripcion, ';
      lv_ssql := lv_ssql || 'a.tip_procesa,         ';
      lv_ssql := lv_ssql || 'a.cod_modgener        ';
      lv_ssql := lv_ssql || 'INTO                    ';
      lv_ssql := lv_ssql || 'EO_ORDEN_SERVICIO.DESCRIPCION,  ';
      lv_ssql := lv_ssql || 'EO_ORDEN_SERVICIO.TIP_PROCESA,  ';
      lv_ssql := lv_ssql || 'EO_ORDEN_SERVICIO.COD_MODGENER  ';
      lv_ssql := lv_ssql || 'FROM ci_tiporserv a  ';
      lv_ssql :=
            lv_ssql || 'WHERE a.cod_os = ' || eo_orden_servicio.cod_os || ' ';

      SELECT a.descripcion, a.tip_procesa,
             a.cod_modgener
        INTO eo_orden_servicio.descripcion, eo_orden_servicio.tip_procesa,
             eo_orden_servicio.cod_modgener
        FROM ci_tiporserv a
       WHERE a.cod_os = eo_orden_servicio.cod_os;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 149;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_OBTIENE_DATOS_TIPORSERV_PR('
            || eo_orden_servicio.cod_os
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                        (sn_num_evento,
                         cv_cod_modulo,
                         sv_mens_retorno,
                         cv_version,
                         USER,
                         'PV_ORDEN_SERVICIO_PG.PV_OBTIENE_DATOS_TIPORSERV_PR',
                         lv_ssql,
                         sn_cod_retorno,
                         lv_des_error
                        );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_OBTIENE_DATOS_TIPORSERV_PR('
            || eo_orden_servicio.cod_os
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                        (sn_num_evento,
                         cv_cod_modulo,
                         sv_mens_retorno,
                         cv_version,
                         USER,
                         'PV_ORDEN_SERVICIO_PG.PV_OBTIENE_DATOS_TIPORSERV_PR',
                         lv_ssql,
                         sn_cod_retorno,
                         lv_des_error
                        );
   END pv_obtiene_datos_tiporserv_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_obtiene_datos_intestadoc_pr (
      eo_orden_servicio   IN OUT NOCOPY   pv_orden_servicio_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_OBTIENE_DATOS_INTESTADOC_PR   "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  RegistraCambPlanBatch                 </Descripción>>
               <Descripción>Metodo  :  Obtiene Estado de Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="EO_ORDEN_SERVICIO    Tipo="Estructura Type ">Estructura Retorna Estado de la Orden de Servicio  </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := NULL;
      lv_ssql := '';
      lv_ssql := lv_ssql || 'SELECT a.des_estadoc ';
      lv_ssql := lv_ssql || 'INTO   EO_ORDEN_SERVICIO.DES_ESTADOC ';
      lv_ssql := lv_ssql || 'FROM   FA_INTESTADOC    a ';
      lv_ssql := lv_ssql || 'WHERE a.cod_aplic   = ' || cv_cod_aplic || ' ';
      lv_ssql := lv_ssql || 'and   a.cod_estadoc = ' || cn_estado_10 || ' ';

      SELECT a.des_estadoc
        INTO eo_orden_servicio.des_estadoc
        FROM fa_intestadoc a
       WHERE a.cod_aplic = cv_cod_aplic AND a.cod_estadoc = cn_estado_10;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 149;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_OBTIENE_DATOS_INTESTADOC_PR('
            || cv_cod_aplic
            || '; '
            || TO_CHAR (cn_estado_10)
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                       (sn_num_evento,
                        cv_cod_modulo,
                        sv_mens_retorno,
                        cv_version,
                        USER,
                        'PV_ORDEN_SERVICIO_PG.PV_OBTIENE_DATOS_INTESTADOC_PR',
                        lv_ssql,
                        sn_cod_retorno,
                        lv_des_error
                       );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_OBTIENE_DATOS_INTESTADOC_PR('
            || cv_cod_aplic
            || '; '
            || TO_CHAR (cn_estado_10)
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                       (sn_num_evento,
                        cv_cod_modulo,
                        sv_mens_retorno,
                        cv_version,
                        USER,
                        'PV_ORDEN_SERVICIO_PG.PV_OBTIENE_DATOS_INTESTADOC_PR',
                        lv_ssql,
                        sn_cod_retorno,
                        lv_des_error
                       );
   END pv_obtiene_datos_intestadoc_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_insert_iorserv_pr (
      reg_pv_iorserv    IN              pv_tipos_pg.r_pv_iorserv,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_INSERT_IORSERV_PR     "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  RegistraCambPlanBatch                                     </Descripción>>
               <Descripción>Metodo  :  Insertar datos  numero de orden de servicio              </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="Reg_PV_IORSERV    Tipo="Estructura de Registro ">Estructura de Registro con datos a Insertar    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql := '';
      lv_ssql :=
            lv_ssql
         || 'INSERT INTO pv_iorserv  VALUES ('
         || reg_pv_iorserv (1).num_os
         || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).cod_os || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).num_ospadre || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).descripcion || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).fecha_ing || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).producto || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).usuario || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).status || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).tip_procesa || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).fh_ejecucion || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).cod_estado || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).cod_modgener || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).num_osf || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).tip_subsujeto || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).nfile || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).path_file || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).tip_sujeto || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).ind_lock || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).prioridad || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).num_osf_err || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).comentario || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).fh_recolector || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).fh_respaldo || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).cod_modulo || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).id_gestor || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).num_intentos || ', ';
      lv_ssql := lv_ssql || reg_pv_iorserv (1).num_osftotal || ') ';
      FORALL i IN reg_pv_iorserv.FIRST .. reg_pv_iorserv.LAST
         INSERT INTO pv_iorserv
              VALUES reg_pv_iorserv (i);
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_INSERT_IORSERV_PR('
            || reg_pv_iorserv (1).num_os
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                 (sn_num_evento,
                                  cv_cod_modulo,
                                  sv_mens_retorno,
                                  cv_version,
                                  USER,
                                  'PV_ORDEN_SERVICIO_PG.PV_INSERT_IORSERV_PR',
                                  lv_ssql,
                                  sn_cod_retorno,
                                  lv_des_error
                                 );
   END pv_insert_iorserv_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_insert_erecorrido_pr (
      reg_pv_erecorrido   IN              pv_tipos_pg.r_pv_erecorrido,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_INSERT_ERECORRIDO_PR    "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  RegistraCambPlanBatch                                     </Descripción>>
               <Descripción>Metodo  :  Insertar datos  numero de orden de servicio              </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="Reg_pv_erecorrido    Tipo="Estructura de Registro ">Estructura de Registro con datos a Insertar    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql := '';
      lv_ssql :=
            'INSERT INTO pv_erecorrido VALUES '
         || reg_pv_erecorrido (1).num_os
         || ', ';
      lv_ssql := lv_ssql || reg_pv_erecorrido (1).cod_estado || ', ';
      lv_ssql := lv_ssql || reg_pv_erecorrido (1).descripcion || ', ';
      lv_ssql := lv_ssql || reg_pv_erecorrido (1).tip_estado || ', ';
      lv_ssql := lv_ssql || reg_pv_erecorrido (1).fec_ingestado || ', ';
      lv_ssql := lv_ssql || reg_pv_erecorrido (1).msg_error || '  ';
      FORALL i IN reg_pv_erecorrido.FIRST .. reg_pv_erecorrido.LAST
         INSERT INTO pv_erecorrido
              VALUES reg_pv_erecorrido (i);
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_INSERT_ERECORRIDO_PR('
            || reg_pv_erecorrido (1).num_os
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                              (sn_num_evento,
                               cv_cod_modulo,
                               sv_mens_retorno,
                               cv_version,
                               USER,
                               'PV_ORDEN_SERVICIO_PG.PV_INSERT_ERECORRIDO_PR',
                               lv_ssql,
                               sn_cod_retorno,
                               lv_des_error
                              );
   END pv_insert_erecorrido_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_obtiene_ta_plantarif_pr (
      eo_orden_servicio   IN OUT NOCOPY   pv_orden_servicio_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_OBTIENE_TA_PLANTARIF_PR   "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  RegistraCambPlanBatch                                     </Descripción>>
               <Descripción>Metodo  :  Obtiene datos del Plantarifario de la Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="EO_ORDEN_SERVICIO    Tipo="Estructura Type ">Estructura Retorna datos Os. del Cliente    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := NULL;
      lv_ssql := 'SELECT TIP_PLANTARIF ';
      lv_ssql := lv_ssql || 'INTO   EO_ORDEN_SERVICIO.TIP_PLANTARIF  ';
      lv_ssql := lv_ssql || 'From  TA_PLANTARIF  ';
      lv_ssql :=
            lv_ssql
         || 'WHERE COD_PRODUCTO = '
         || eo_orden_servicio.cod_producto
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'AND COD_PLANTARIF  = '
         || eo_orden_servicio.cod_plantarif
         || ' ';

      SELECT tip_plantarif
        INTO eo_orden_servicio.tip_plantarif
        FROM ta_plantarif
       WHERE cod_producto = eo_orden_servicio.cod_producto
         AND cod_plantarif = eo_orden_servicio.cod_plantarif;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 149;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_OBTIENE_TA_PLANTARIF_PR('
            || eo_orden_servicio.cod_producto
            || '; '
            || eo_orden_servicio.cod_plantarif
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            cv_cod_modulo,
                            sv_mens_retorno,
                            cv_version,
                            USER,
                            'PV_ORDEN_SERVICIO_PG.PV_OBTIENE_TA_PLANTARIF_PR',
                            lv_ssql,
                            sn_cod_retorno,
                            lv_des_error
                           );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_OBTIENE_TA_PLANTARIF_PR('
            || eo_orden_servicio.cod_producto
            || '; '
            || eo_orden_servicio.cod_plantarif
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            cv_cod_modulo,
                            sv_mens_retorno,
                            cv_version,
                            USER,
                            'PV_ORDEN_SERVICIO_PG.PV_OBTIENE_TA_PLANTARIF_PR',
                            lv_ssql,
                            sn_cod_retorno,
                            lv_des_error
                           );
   END pv_obtiene_ta_plantarif_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_obtiene_ga_abocel_pr (
      eo_orden_servicio   IN OUT NOCOPY   pv_orden_servicio_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_OBTIENE_GA_ABOCEL_PR   "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  RegistraCambPlanBatch                               </Descripción>>
               <Descripción>Metodo  :  Obtiene datos del cliente de la Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="EO_ORDEN_SERVICIO    Tipo="Estructura Type ">Estructura Retorna datos Os. del Cliente    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := NULL;
      lv_ssql := '';
      lv_ssql := lv_ssql || 'SELECT a.NUM_CELULAR, ';
      lv_ssql := lv_ssql || 'a.COD_CLIENTE,   ';
      lv_ssql := lv_ssql || 'a.COD_CUENTA,    ';
      lv_ssql := lv_ssql || 'a.COD_PRODUCTO,  ';
      lv_ssql := lv_ssql || 'a.TIP_TERMINAL   ';
      lv_ssql := lv_ssql || ' INTO               ';
      lv_ssql := lv_ssql || ' EO_ORDEN_SERVICIO.NUM_CELULAR  , ';
      lv_ssql := lv_ssql || ' EO_ORDEN_SERVICIO.COD_CLIENTE  , ';
      lv_ssql := lv_ssql || ' EO_ORDEN_SERVICIO.COD_CUENTA   , ';
      lv_ssql := lv_ssql || ' EO_ORDEN_SERVICIO.COD_PRODUCTO , ';
      lv_ssql := lv_ssql || ' EO_ORDEN_SERVICIO.TIP_TERMINAL   ';
      lv_ssql := lv_ssql || ' FROM GA_ABOCEL a    ';
      lv_ssql :=
            lv_ssql
         || ' WHERE a.NUM_ABONADO = '
         || eo_orden_servicio.num_abonado
         || ' ';

      SELECT a.num_celular, a.cod_cliente,
             a.cod_cuenta, a.cod_producto,
             a.tip_terminal
        INTO eo_orden_servicio.num_celular, eo_orden_servicio.cod_cliente,
             eo_orden_servicio.cod_cuenta, eo_orden_servicio.cod_producto,
             eo_orden_servicio.tip_terminal
        FROM ga_abocel a
       WHERE a.num_abonado = eo_orden_servicio.num_abonado;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 149;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_OBTIENE_GA_ABOCEL_PR('
            || eo_orden_servicio.num_abonado
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                              (sn_num_evento,
                               cv_cod_modulo,
                               sv_mens_retorno,
                               cv_version,
                               USER,
                               'PV_ORDEN_SERVICIO_PG.PV_OBTIENE_GA_ABOCEL_PR',
                               lv_ssql,
                               sn_cod_retorno,
                               lv_des_error
                              );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_OBTIENE_GA_ABOCEL_PR('
            || eo_orden_servicio.num_abonado
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                              (sn_num_evento,
                               cv_cod_modulo,
                               sv_mens_retorno,
                               cv_version,
                               USER,
                               'PV_ORDEN_SERVICIO_PG.PV_OBTIENE_GA_ABOCEL_PR',
                               lv_ssql,
                               sn_cod_retorno,
                               lv_des_error
                              );
   END pv_obtiene_ga_abocel_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_insert_camcom_pr (
      reg_pv_camcom     IN              pv_tipos_pg.r_pv_camcom,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_INSERT_CAMCOM_PR   "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  RegistraCambPlanBatch                              </Descripción>>
               <Descripción>Metodo  :  Inserta Datos de Movimiento de Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="Reg_pv_camcom    Tipo="Estructura de Registro ">Estructura de Registro con los Datos a Insertar    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql :=
          'INSERT INTO pv_camcom VALUES ' || reg_pv_camcom (1).num_os || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).num_abonado || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).num_celular || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).cod_cliente || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).cod_cuenta || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).cod_producto || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).bdatos || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).num_venta || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).num_transaccion || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).num_folio || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).num_cuotas || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).num_proceso || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).cod_actabo || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).fh_anula || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).user_anula || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).cat_tribut || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).cod_estadoc || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).cod_causaelim || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).fec_vencimiento || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).abonados || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).tabla || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).clase_servicio_act || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).clase_servicio_des || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).ind_msg || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).num_cargo_os || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).imp_cargo_ser || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).ind_central_ss || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).ind_portable || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).tip_terminal || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).tip_susp_avsinie || ', ';
      lv_ssql := lv_ssql || reg_pv_camcom (1).pref_plaza || '  ';
      FORALL i IN reg_pv_camcom.FIRST .. reg_pv_camcom.LAST
         INSERT INTO pv_camcom
              VALUES reg_pv_camcom (i);
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;                                           --4

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_INSERT_CAMCOM_PR('
            || reg_pv_camcom (1).num_os
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                  (sn_num_evento,
                                   cv_cod_modulo,
                                   sv_mens_retorno,
                                   cv_version,
                                   USER,
                                   'PV_ORDEN_SERVICIO_PG.PV_INSERT_CAMCOM_PR',
                                   lv_ssql,
                                   sn_cod_retorno,
                                   lv_des_error
                                  );
   END pv_insert_camcom_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_insert_param_abocel_pr (
      reg_pv_param_abocel   IN              pv_tipos_pg.r_pv_param_abocel,
      sn_cod_retorno        OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno       OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_INSERT_PARAM_ABOCEL_PR   "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  RegistraCambPlanBatch                              </Descripción>>
               <Descripción>Metodo  :  Inserta Datos de Movimiento de Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="Reg_pv_param_abocel    Tipo="Estructura de Registro ">Estructura de Registro con los Datos a Insertar    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql :=
         'INSERT INTO pv_param_abocel  (NUM_OS,NUM_ABONADO,COD_TIPMODI,FEC_MODIFICA,NUOM_USUARORA,NUM_CELULAR,COD_USO,TIP_PLANTARIF,TIP_TERMINAL, ';
      lv_ssql :=
            lv_ssql
         || 'COD_PLANTARIF,COD_CARGOBASICO,COD_PLANSERV,COD_LIMCONSUMO,NUM_SERIE,NUM_SERIEHEX,COD_EMPRESA,COD_GRPSERV,COD_CARRIER,COD_CICLO, ';
      lv_ssql :=
            lv_ssql
         || 'IND_FACTUR,COD_CAUSA,NUM_MIN,COD_TIPCONTRATO,NUM_MESES,IND_EQPRESTADO,FEC_PRORROGA,NUM_CICLOS,NUM_MINUTOS,FEC_FINCONTRATO,COD_SERVICIO, ';
      lv_ssql :=
            lv_ssql
         || 'OBS_DETALLE,COD_TIPSEGU,NUM_CONTRATO,NUM_ANEXO,COD_PRODUCTO,COD_PLANTARIF_NUE,TIP_PLANTARIF_NUE,NUM_DIA,COD_VENDEDOR,PARAM1_MENS) ';
      lv_ssql :=
               lv_ssql || ' VALUES (' || reg_pv_param_abocel (1).num_os || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).num_abonado || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).cod_tipmodi || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).fec_modifica || ',';
      lv_ssql :=
                lv_ssql || ' ' || reg_pv_param_abocel (1).nuom_usuarora || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).num_celular || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).cod_uso || ',';
      lv_ssql :=
                lv_ssql || ' ' || reg_pv_param_abocel (1).tip_plantarif || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).tip_terminal || ',';
      lv_ssql :=
                lv_ssql || ' ' || reg_pv_param_abocel (1).cod_plantarif || ',';
      lv_ssql :=
              lv_ssql || ' ' || reg_pv_param_abocel (1).cod_cargobasico || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).cod_planserv || ',';
      lv_ssql :=
               lv_ssql || ' ' || reg_pv_param_abocel (1).cod_limconsumo || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).num_serie || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).num_seriehex || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).cod_empresa || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).cod_grpserv || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).cod_carrier || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).cod_ciclo || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).ind_factur || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).cod_causa || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).num_min || ',';
      lv_ssql :=
              lv_ssql || ' ' || reg_pv_param_abocel (1).cod_tipcontrato || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).num_meses || ',';
      lv_ssql :=
               lv_ssql || ' ' || reg_pv_param_abocel (1).ind_eqprestado || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).fec_prorroga || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).num_ciclos || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).num_minutos || ',';
      lv_ssql :=
              lv_ssql || ' ' || reg_pv_param_abocel (1).fec_fincontrato || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).cod_servicio || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).obs_detalle || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).cod_tipsegu || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).num_contrato || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).num_anexo || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).cod_producto || ',';
      lv_ssql :=
            lv_ssql || ' ' || reg_pv_param_abocel (1).cod_plantarif_nue || ',';
      lv_ssql :=
            lv_ssql || ' ' || reg_pv_param_abocel (1).tip_plantarif_nue || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).num_dia || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).cod_vendedor || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_abocel (1).param1_mens || ');';
      FORALL i IN reg_pv_param_abocel.FIRST .. reg_pv_param_abocel.LAST
         INSERT INTO pv_param_abocel
              VALUES reg_pv_param_abocel (i);
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_INSERT_PARAM_ABOCEL_PR('
            || reg_pv_param_abocel (1).num_os
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                            (sn_num_evento,
                             cv_cod_modulo,
                             sv_mens_retorno,
                             cv_version,
                             USER,
                             'PV_ORDEN_SERVICIO_PG.PV_INSERT_PARAM_ABOCEL_PR',
                             lv_ssql,
                             sn_cod_retorno,
                             lv_des_error
                            );
   END pv_insert_param_abocel_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_insert_param_cliente_pr (
      reg_pv_param_cliente   IN              pv_tipos_pg.r_pv_param_cliente,
      sn_cod_retorno         OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno        OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento          OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_INSERT_PARAM_CLIENTE_PR   "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  RegistraCambPlanBatch                              </Descripción>>
               <Descripción>Metodo  :  Inserta Datos de Movimiento de Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="Reg_pv_param_abocel    Tipo="Estructura de Registro ">Estructura de Registro con los Datos a Insertar    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql := 'INSERT INTO pv_param_CLIENTE  (';
      lv_ssql :=
            lv_ssql
         || ' NUM_OS           ,   COD_CLIENTE      ,  COD_TIPMODI       ,   FEC_MODIFICA     ,';
      lv_ssql :=
            lv_ssql
         || ' NOM_USUARORA     ,   NOM_CLIENTE      ,   COD_TIPIDENT     ,   NUM_IDENT        ,';
      lv_ssql :=
            lv_ssql
         || ' COD_CALCLIEN     ,   COD_PLANCOM      ,   IND_FACTUR       ,   IND_TRASPASO     ,';
      lv_ssql :=
            lv_ssql
         || ' COD_ACTIVIDAD    ,   COD_PAIS         ,   TEF_CLIENTE1     ,   TEF_CLIENTE2     ,';
      lv_ssql :=
            lv_ssql
         || ' NUM_FAX          ,   IND_DEBITO       ,   COD_SISPAGO      ,   NOM_APECLIEN1    ,';
      lv_ssql :=
            lv_ssql
         || ' NOM_APECLIEN2    ,   IMP_STOPDEBIT    ,   COD_BANCO        ,   COD_SUCURSAL     ,';
      lv_ssql :=
            lv_ssql
         || ' IND_TIPCUENTA    ,   COD_TIPTARJETA   ,   NUM_CTACORR      ,   NUM_TARJETA      ,';
      lv_ssql :=
            lv_ssql
         || ' FEC_VENCITARJ    ,   COD_BANCOTARJ    ,   COD_TIPIDTRIB    ,   NUM_IDENTTRIB    ,';
      lv_ssql :=
            lv_ssql
         || ' COD_TIPIDENTAPOR ,   NUM_IDENTAPOR    ,   NOM_APODERADO    ,   COD_OFICINA      ,';
      lv_ssql :=
            lv_ssql
         || ' COD_PINCLI       ,   NOM_EMAIL        ,   COD_CICLO        ,   COD_CATEGORIA    ,';
      lv_ssql :=
            lv_ssql
         || ' COD_SECTOR       ,   COD_SUPERVISOR   ,   COD_NPI          ,   COD_EMPRESA      ,';
      lv_ssql :=
            lv_ssql
         || ' COD_PLANTARIF    ,   COD_CARGOBASICO  ,   NUM_CICLOS       ,   NUM_MINUTOS      ,';
      lv_ssql := lv_ssql || ' COD_CLIENTE_NUE  ,   CUENTA_NUE)';
      lv_ssql :=
              lv_ssql || ' VALUES (' || reg_pv_param_cliente (1).num_os || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).cod_cliente || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).cod_tipmodi || ',';
      lv_ssql :=
                lv_ssql || ' ' || reg_pv_param_cliente (1).fec_modifica || ',';
      lv_ssql :=
                lv_ssql || ' ' || reg_pv_param_cliente (1).nom_usuarora || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).nom_cliente || ',';
      lv_ssql :=
                lv_ssql || ' ' || reg_pv_param_cliente (1).cod_tipident || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).num_ident || ',';
      lv_ssql :=
                lv_ssql || ' ' || reg_pv_param_cliente (1).cod_calclien || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).cod_plancom || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).ind_factur || ',';
      lv_ssql :=
                lv_ssql || ' ' || reg_pv_param_cliente (1).ind_traspaso || ',';
      lv_ssql :=
               lv_ssql || ' ' || reg_pv_param_cliente (1).cod_actividad || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).cod_pais || ',';
      lv_ssql :=
                lv_ssql || ' ' || reg_pv_param_cliente (1).tef_cliente1 || ',';
      lv_ssql :=
                lv_ssql || ' ' || reg_pv_param_cliente (1).tef_cliente2 || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).num_fax || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).ind_debito || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).cod_sispago || ',';
      lv_ssql :=
               lv_ssql || ' ' || reg_pv_param_cliente (1).nom_apeclien1 || ',';
      lv_ssql :=
               lv_ssql || ' ' || reg_pv_param_cliente (1).nom_apeclien2 || ',';
      lv_ssql :=
               lv_ssql || ' ' || reg_pv_param_cliente (1).imp_stopdebit || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).cod_banco || ',';
      lv_ssql :=
                lv_ssql || ' ' || reg_pv_param_cliente (1).cod_sucursal || ',';
      lv_ssql :=
               lv_ssql || ' ' || reg_pv_param_cliente (1).ind_tipcuenta || ',';
      lv_ssql :=
              lv_ssql || ' ' || reg_pv_param_cliente (1).cod_tiptarjeta || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).num_ctacorr || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).num_tarjeta || ',';
      lv_ssql :=
               lv_ssql || ' ' || reg_pv_param_cliente (1).fec_vencitarj || ',';
      lv_ssql :=
               lv_ssql || ' ' || reg_pv_param_cliente (1).cod_bancotarj || ',';
      lv_ssql :=
               lv_ssql || ' ' || reg_pv_param_cliente (1).cod_tipidtrib || ',';
      lv_ssql :=
               lv_ssql || ' ' || reg_pv_param_cliente (1).num_identtrib || ',';
      lv_ssql :=
            lv_ssql || ' ' || reg_pv_param_cliente (1).cod_tipidentapor || ',';
      lv_ssql :=
               lv_ssql || ' ' || reg_pv_param_cliente (1).num_identapor || ',';
      lv_ssql :=
               lv_ssql || ' ' || reg_pv_param_cliente (1).nom_apoderado || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).cod_oficina || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).cod_pincli || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).nom_email || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).cod_ciclo || ',';
      lv_ssql :=
               lv_ssql || ' ' || reg_pv_param_cliente (1).cod_categoria || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).cod_sector || ',';
      lv_ssql :=
              lv_ssql || ' ' || reg_pv_param_cliente (1).cod_supervisor || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).cod_npi || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).cod_empresa || ',';
      lv_ssql :=
               lv_ssql || ' ' || reg_pv_param_cliente (1).cod_plantarif || ',';
      lv_ssql :=
             lv_ssql || ' ' || reg_pv_param_cliente (1).cod_cargobasico || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).num_ciclos || ',';
      lv_ssql := lv_ssql || ' ' || reg_pv_param_cliente (1).num_minutos || ',';
      lv_ssql :=
             lv_ssql || ' ' || reg_pv_param_cliente (1).cod_cliente_nue || ',';
      lv_ssql :=
             lv_ssql || ' ' || reg_pv_param_cliente (1).cod_cuenta_nue || ');';
      FORALL i IN reg_pv_param_cliente.FIRST .. reg_pv_param_cliente.LAST
         INSERT INTO pv_param_cliente
              VALUES reg_pv_param_cliente (i);
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_INSERT_PARAM_CLIENTE_PR('
            || reg_pv_param_cliente (1).num_os
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            cv_cod_modulo,
                            sv_mens_retorno,
                            cv_version,
                            USER,
                            'PV_ORDEN_SERVICIO_PG.PV_INSERT_PARAM_CLIENTE_PR',
                            lv_ssql,
                            sn_cod_retorno,
                            lv_des_error
                           );
   END pv_insert_param_cliente_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_insert_pv_prog_pr (
      reg_pv_prog       IN              pv_tipos_pg.r_pv_prog,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_INSERT_PV_PROG_PR  "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  RegistraCambPlanBatch                              </Descripción>>
               <Descripción>Metodo  :  Inserta Datos de Movimiento de Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="Reg_pv_prog    Tipo="Estructura de Registro ">Estructura de Registro con los Datos a Insertar    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql :=
         'INSERT INTO pv_prog  (NUM_OS,F_PRORROGA,USUARIO,OBSERVACION,FEC_PROG) ';
      lv_ssql :=
            lv_ssql
         || 'VALUES  ('
         || reg_pv_prog (1).num_os
         || ','
         || reg_pv_prog (1).f_prorroga
         || ','
         || reg_pv_prog (1).usuario
         || ','
         || reg_pv_prog (1).observacion
         || ','
         || reg_pv_prog (1).fec_prog
         || '); ';
      FORALL i IN reg_pv_prog.FIRST .. reg_pv_prog.LAST
         INSERT INTO pv_prog
              VALUES reg_pv_prog (i);
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;                                           --4

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_INSERT_PV_PROG_PR('
            || reg_pv_prog (1).num_os
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                 (sn_num_evento,
                                  cv_cod_modulo,
                                  sv_mens_retorno,
                                  cv_version,
                                  USER,
                                  'PV_ORDEN_SERVICIO_PG.PV_INSERT_PV_PROG_PR',
                                  lv_ssql,
                                  sn_cod_retorno,
                                  lv_des_error
                                 );
   END pv_insert_pv_prog_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_insert_pv_movimientos_pr (
      reg_pv_movimientos   IN              pv_tipos_pg.r_pv_movimientos,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_INSERT_PV_MOVIMIENTOS_PR  "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  RegistraCambPlanBatch                          </Descripción>>
               <Descripción>Metodo  :  Inserta Datos de Movimiento de Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="Reg_pv_movimientos    Tipo="Estructura de Registro ">Estructura de Registro con los Datos a Insertar    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql :=
         'INSERT INTO pv_movimientos  (NUM_OS,F_EJECUCION,ORD_COMANDO,COD_ACTABO,COD_SERVICIO,IND_ESTADO,FEC_EXPIRA, ';
      lv_ssql :=
                lv_ssql || '        RESP_CENTRAL,NUM_MOVIMIENTO,CARGA,COD_ESTADO) ';
      lv_ssql :=
            lv_ssql
         || 'VALUES ('
         || reg_pv_movimientos (1).num_os
         || ','
         || reg_pv_movimientos (1).f_ejecucion
         || ','
         || reg_pv_movimientos (1).ord_comando
         || ', ';
      lv_ssql :=
            lv_ssql
         || ''
         || reg_pv_movimientos (1).cod_actabo
         || ','
         || reg_pv_movimientos (1).cod_servicio
         || ','
         || reg_pv_movimientos (1).ind_estado
         || ', ';
      lv_ssql :=
            lv_ssql
         || ''
         || reg_pv_movimientos (1).fec_expira
         || ','
         || reg_pv_movimientos (1).resp_central
         || ','
         || reg_pv_movimientos (1).num_movimiento
         || ', ';
      lv_ssql :=
            lv_ssql
         || ''
         || reg_pv_movimientos (1).carga
         || ','
         || reg_pv_movimientos (1).cod_estado
         || '); ';
      FORALL i IN reg_pv_movimientos.FIRST .. reg_pv_movimientos.LAST
         INSERT INTO pv_movimientos
              VALUES reg_pv_movimientos (i);
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;                                           --4

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_INSERT_PV_MOVIMIENTOS_PR('
            || reg_pv_movimientos (1).num_os
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sv_mens_retorno,
                           cv_version,
                           USER,
                           'PV_ORDEN_SERVICIO_PG.PV_INSERT_PV_MOVIMIENTOS_PR',
                           lv_ssql,
                           sn_cod_retorno,
                           lv_des_error
                          );
   END pv_insert_pv_movimientos_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_actual_iorserv_pr (
      reg_pv_iorserv    IN              pv_tipos_pg.r_pv_iorserv,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_ACTUAL_IORSERV_PR "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  RegistraCambPlanBatch                          </Descripción>>
               <Descripción>Metodo  :  Actualiza Status Numero de Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="Reg_pv_iorserv    Tipo="Estructura de Registro ">Estructura de Registro con los Datos a Actualizar    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      FOR i IN 1 .. reg_pv_iorserv.COUNT
      LOOP
         lv_ssql := 'UPDATE pv_iorserv SET ';
         lv_ssql :=
                   lv_ssql || 'status = ' || reg_pv_iorserv (i).status || ' ';
         lv_ssql := lv_ssql || 'WHERE ';
         lv_ssql :=
                   lv_ssql || 'num_os = ' || reg_pv_iorserv (i).num_os || ' ';

         UPDATE pv_iorserv
            SET status = reg_pv_iorserv (i).status
          WHERE num_os = reg_pv_iorserv (i).num_os;
      END LOOP;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 149;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := ' PV_ACTUAL_IORSERV_PR (); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                 (sn_num_evento,
                                  cv_cod_modulo,
                                  sv_mens_retorno,
                                  cv_version,
                                  USER,
                                  'PV_ORDEN_SERVICIO_PG.PV_ACTUAL_IORSERV_PR',
                                  lv_ssql,
                                  sn_cod_retorno,
                                  lv_des_error
                                 );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := ' PV_ACTUAL_IORSERV_PR (); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                 (sn_num_evento,
                                  cv_cod_modulo,
                                  sv_mens_retorno,
                                  cv_version,
                                  USER,
                                  'PV_ORDEN_SERVICIO_PG.PV_ACTUAL_IORSERV_PR',
                                  lv_ssql,
                                  sn_cod_retorno,
                                  lv_des_error
                                 );
   END pv_actual_iorserv_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_actual_erecorrido_pr (
      reg_pv_erecorrido   IN              pv_tipos_pg.r_pv_erecorrido,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_ACTUAL_ERECORRIDO_PR "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  RegistraCambPlanBatch                          </Descripción>>
               <Descripción>Metodo  :  Actualiza Estado Numero de Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="Reg_pv_erecorrido    Tipo="Estructura de Registro ">Estructura de Registro con datos  a Actualizar   </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      FOR i IN 1 .. reg_pv_erecorrido.COUNT
      LOOP
         lv_ssql := 'UPDATE pv_erecorrido  SET  ';
         lv_ssql :=
               lv_ssql
            || ' descripcion = '
            || reg_pv_erecorrido (i).descripcion
            || ', ';
         lv_ssql :=
               lv_ssql
            || ' tip_estado  = '
            || reg_pv_erecorrido (i).tip_estado
            || '  ';
         lv_ssql := lv_ssql || ' WHERE ';
         lv_ssql :=
               lv_ssql || ' num_os = ' || reg_pv_erecorrido (i).num_os || '; ';

         UPDATE pv_erecorrido
            SET descripcion = reg_pv_erecorrido (i).descripcion,
                tip_estado = reg_pv_erecorrido (i).tip_estado
          WHERE num_os = reg_pv_erecorrido (i).num_os;
      END LOOP;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 149;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := ' PV_ACTUAL_ERECORRIDO_PR (); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                              (sn_num_evento,
                               cv_cod_modulo,
                               sv_mens_retorno,
                               cv_version,
                               USER,
                               'PV_ORDEN_SERVICIO_PG.PV_ACTUAL_ERECORRIDO_PR',
                               lv_ssql,
                               sn_cod_retorno,
                               lv_des_error
                              );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := ' PV_ACTUAL_ERECORRIDO_PR (); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                              (sn_num_evento,
                               cv_cod_modulo,
                               sv_mens_retorno,
                               cv_version,
                               USER,
                               'PV_ORDEN_SERVICIO_PG.PV_ACTUAL_ERECORRIDO_PR',
                               lv_ssql,
                               sn_cod_retorno,
                               lv_des_error
                              );
   END pv_actual_erecorrido_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_registr_camb_plan_batch_pr (
      eo_orden_servicio   IN OUT NOCOPY   pv_orden_servicio_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_REGISTR_CAMB_PLAN_BATCH_PR  "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
            <Descripción>Metodo  :  RegistraCambPlanBatch   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="EO_ORDEN_SERVICIO    Tipo="Estructura">Estructura de los datos      </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
      error_ejecucion        EXCEPTION;
      reg_pv_iorserv         pv_tipos_pg.r_pv_iorserv;
      reg_pv_erecorrido      pv_tipos_pg.r_pv_erecorrido;
      reg_pv_camcom          pv_tipos_pg.r_pv_camcom;
      reg_pv_param_abocel    pv_tipos_pg.r_pv_param_abocel;
      reg_pv_param_cliente   pv_tipos_pg.r_pv_param_cliente;
      reg_pv_prog            pv_tipos_pg.r_pv_prog;
      reg_pv_movimientos     pv_tipos_pg.r_pv_movimientos;
      serv_aux               VARCHAR2 (255);
      lv_nom_cliente         ge_clientes.nom_cliente%TYPE;
      lv_num_serie           ga_abocel.num_serie%TYPE;
      lv_cod_uso             pv_param_abocel.cod_uso%TYPE;
      lv_cod_tiplan          ta_plantarif.cod_tiplan%TYPE;
      lv_comentario          pv_iorserv.comentario%TYPE;
      lv_plan_aux            ppd_planes.cod_plantarif%TYPE;

      LVFecProg                 pv_iorserv.fh_ejecucion%TYPE;            --COL-72424|05-11-2008|GEZ
      LVCodOsBajaOpta         ged_parametros.val_parametro%TYPE;    --COL-72424|05-11-2008|GEZ

   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_comentario := NULL;
      eo_orden_servicio.cod_servicio :=
                   eo_orden_servicio.codact_al || eo_orden_servicio.codact_ba;
      eo_orden_servicio.cod_estado := 10;
      eo_orden_servicio.tip_estado := 1;
      lv_ssql :=
            'PV_ORDEN_SERVICIO_PG.PV_OBTIENE_DATOS_TIPORSERV_PR('
         || eo_orden_servicio.cod_os
         || '); ';
      pv_obtiene_datos_tiporserv_pr (eo_orden_servicio,
                                     sn_cod_retorno,
                                     sv_mens_retorno,
                                     sn_num_evento
                                    );

      IF sn_cod_retorno > 0
      THEN
         RAISE error_ejecucion;
      END IF;

      lv_ssql := 'PV_ORDEN_SERVICIO_PG.PV_OBTIENE_DATOS_INTESTADOC_PR(''); ';
      pv_obtiene_datos_intestadoc_pr (eo_orden_servicio,
                                      sn_cod_retorno,
                                      sv_mens_retorno,
                                      sn_num_evento
                                     );

      IF sn_cod_retorno > 0
      THEN
         RAISE error_ejecucion;
      END IF;

      --INI COL-72424|05-11-2008|GEZ
      LVCodOsBajaOpta:= GE_FN_DEVVALPARAM('GA',1,'CODOS_BAJA_OPTAPREPA');

      IF LVCodOsBajaOpta=eo_orden_servicio.cod_os THEN
         IF TRUNC(TO_DATE(EO_ORDEN_SERVICIO.FEC_VENCIMIENTO,'DD-MM-YY')) <> TRUNC(SYSDATE) THEN -- INI COL|72424|11-11-2008|SAQL
            SELECT TO_DATE(TO_CHAR(TRUNC(b.fec_hastallam),'DD-MM-YYYY')||' '||GE_FN_DEVVALPARAM('GA',1,'HORA_OOSS_PROG_CPU'),'DD-MM-YYYY hh24:MI:SS')
            INTO     LVFecProg
            FROM   ga_abocel a,fa_ciclfact b
            WHERE  a.num_abonado = eo_orden_servicio.num_abonado
            AND    b.cod_ciclo=a.cod_ciclo
            AND     SYSDATE BETWEEN fec_desdellam AND fec_hastallam;
         -- INI COL|72424|11-11-2008|SAQL
         ELSE
            LVFecProg := SYSDATE;
         END IF;
         -- FIN COL|72424|11-11-2008|SAQL
      ELSE
            LVFecProg:=TO_DATE (eo_orden_servicio.fec_vencimiento, 'dd-mm-yy');
      END IF;
      --FIN COL-72424|05-11-2008|GEZ

      lv_comentario := SUBSTR (eo_orden_servicio.comentario, 1, 478);
      reg_pv_iorserv (1).num_os := eo_orden_servicio.idsecuencia;
      reg_pv_iorserv (1).cod_os := eo_orden_servicio.cod_os;
      reg_pv_iorserv (1).num_ospadre := NULL;
      reg_pv_iorserv (1).descripcion := eo_orden_servicio.descripcion;
      reg_pv_iorserv (1).fecha_ing := SYSDATE;
      reg_pv_iorserv (1).producto := 1;
      reg_pv_iorserv (1).usuario := eo_orden_servicio.usuario;
      reg_pv_iorserv (1).status := 'EN PROCESO';
      reg_pv_iorserv (1).tip_procesa := eo_orden_servicio.tip_procesa;

      --reg_pv_iorserv (1).fh_ejecucion :=TO_DATE (eo_orden_servicio.fec_vencimiento, 'dd-mm-yy'); --COL-72424|05-11-2008|GEZ
      reg_pv_iorserv (1).fh_ejecucion :=LVFecProg; --COL-72424|05-11-2008|GEZ

--       Reg_PV_IORSERV(1).FH_EJECUCION     := to_char(EO_ORDEN_SERVICIO.FEC_VENCIMIENTO,'dd-mm-yyyy');
      reg_pv_iorserv (1).cod_estado := eo_orden_servicio.cod_estado;
      reg_pv_iorserv (1).cod_modgener := eo_orden_servicio.cod_modgener;
      reg_pv_iorserv (1).num_osf := eo_orden_servicio.num_osf;
      reg_pv_iorserv (1).tip_subsujeto := '';
      reg_pv_iorserv (1).nfile := '';
      reg_pv_iorserv (1).path_file := '';
      reg_pv_iorserv (1).tip_sujeto := eo_orden_servicio.tip_sujeto;
      reg_pv_iorserv (1).ind_lock := 0;
      reg_pv_iorserv (1).prioridad := NULL;
      reg_pv_iorserv (1).num_osf_err := 0;
      reg_pv_iorserv (1).comentario :=
                                     'CAMBIO DE PLAN BATCH, ' || lv_comentario;
      reg_pv_iorserv (1).fh_recolector := NULL;
      reg_pv_iorserv (1).fh_respaldo := NULL;
      reg_pv_iorserv (1).cod_modulo := NULL;
      reg_pv_iorserv (1).id_gestor := NULL;
      reg_pv_iorserv (1).num_intentos := NULL;
      reg_pv_iorserv (1).num_osftotal := NULL;
      lv_ssql :=
         'Reg_PV_IORSERV(1).NUM_OS            := ' || reg_pv_iorserv (1).num_os
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).COD_OS            := '
         || reg_pv_iorserv (1).cod_os
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).NUM_OSPADRE       := '
         || reg_pv_iorserv (1).num_ospadre
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).DESCRIPCION       := '
         || reg_pv_iorserv (1).descripcion
         || ' ';
      lv_ssql := lv_ssql || ' Reg_PV_IORSERV(1).FECHA_ING            := SYSDATE ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).PRODUCTO            := '
         || reg_pv_iorserv (1).producto
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).USUARIO          := '
         || reg_pv_iorserv (1).usuario
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).STATUS            := '
         || reg_pv_iorserv (1).status
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).TIP_PROCESA       := '
         || reg_pv_iorserv (1).tip_procesa
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).FH_EJECUCION      := '
         || reg_pv_iorserv (1).fh_ejecucion
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).COD_ESTADO      := '
         || reg_pv_iorserv (1).cod_estado
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).COD_MODGENER      := '
         || reg_pv_iorserv (1).cod_modgener
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).NUM_OSF            := '
         || reg_pv_iorserv (1).num_osf
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).TIP_SUBSUJETO      := '
         || reg_pv_iorserv (1).tip_subsujeto
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).NFILE                := '
         || reg_pv_iorserv (1).nfile
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).PATH_FILE            := '
         || reg_pv_iorserv (1).path_file
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).TIP_SUJETO      := '
         || reg_pv_iorserv (1).tip_sujeto
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).IND_LOCK            := '
         || reg_pv_iorserv (1).ind_lock
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).PRIORIDAD            := '
         || reg_pv_iorserv (1).prioridad
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).NUM_OSF_ERR      := '
         || reg_pv_iorserv (1).num_osf_err
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).COMENTARIO      := '
         || reg_pv_iorserv (1).comentario
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).FH_RECOLECTOR      := '
         || reg_pv_iorserv (1).fh_recolector
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).FH_RESPALDO      := '
         || reg_pv_iorserv (1).fh_respaldo
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).COD_MODULO      := '
         || reg_pv_iorserv (1).cod_modulo
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).ID_GESTOR            := '
         || reg_pv_iorserv (1).id_gestor
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).NUM_INTENTOS      := '
         || reg_pv_iorserv (1).num_intentos
         || ' ';
      lv_ssql :=
            lv_ssql
         || ' Reg_PV_IORSERV(1).NUM_OSFTOTAL      := '
         || reg_pv_iorserv (1).num_osftotal
         || ' ';
      lv_ssql :=
            lv_ssql
         || '    PV_ORDEN_SERVICIO_PG.PV_INSERT_IORSERV_PR((Reg_PV_IORSERV'
         || ','
         || sn_cod_retorno
         || ','
         || sv_mens_retorno
         || ','
         || sn_num_evento
         || '); ';
      Pv_Orden_Servicio_Pg.pv_insert_iorserv_pr (reg_pv_iorserv,
                                                 sn_cod_retorno,
                                                 sv_mens_retorno,
                                                 sn_num_evento
                                                );

      IF sn_cod_retorno > 0
      THEN
         RAISE error_ejecucion;
      END IF;

      reg_pv_erecorrido (1).num_os := eo_orden_servicio.idsecuencia;
      reg_pv_erecorrido (1).cod_estado := eo_orden_servicio.cod_estado;
      reg_pv_erecorrido (1).descripcion := eo_orden_servicio.des_estadoc;
      reg_pv_erecorrido (1).tip_estado := eo_orden_servicio.tip_estado;
      reg_pv_erecorrido (1).fec_ingestado := SYSDATE;
      reg_pv_erecorrido (1).msg_error := '';
      lv_ssql :=
            'pv_orden_servicio_pg.PV_INSERT_ERECORRIDO_PR(('
         || reg_pv_erecorrido (1).num_os
         || ','
         || reg_pv_erecorrido (1).cod_estado
         || ','
         || reg_pv_erecorrido (1).descripcion
         || ','
         || reg_pv_erecorrido (1).tip_estado
         || ','
         || reg_pv_erecorrido (1).fec_ingestado
         || ','
         || reg_pv_erecorrido (1).msg_error
         || ','
         || sn_cod_retorno
         || ','
         || sv_mens_retorno
         || ','
         || sn_num_evento
         || ')';
      Pv_Orden_Servicio_Pg.pv_insert_erecorrido_pr (reg_pv_erecorrido,
                                                    sn_cod_retorno,
                                                    sv_mens_retorno,
                                                    sn_num_evento
                                                   );

      IF sn_cod_retorno > 0
      THEN
         RAISE error_ejecucion;
      END IF;

      lv_ssql :=
            'pv_orden_servicio_pg.PV_OBTIENE_TA_PLANTARIF_PR('
         || eo_orden_servicio.cod_producto
         || ','
         || eo_orden_servicio.cod_plantarif
         || ','
         || sn_cod_retorno
         || ','
         || sv_mens_retorno
         || ','
         || sn_num_evento
         || '); ';
      eo_orden_servicio.cod_producto := cn_producto;
      Pv_Orden_Servicio_Pg.pv_obtiene_ta_plantarif_pr (eo_orden_servicio,
                                                       sn_cod_retorno,
                                                       sv_mens_retorno,
                                                       sn_num_evento
                                                      );

      IF sn_cod_retorno > 0
      THEN
         RAISE error_ejecucion;
      END IF;

      lv_ssql :=
            'pv_orden_servicio_pg.PV_OBTIENE_GA_ABOCEL_PR('
         || eo_orden_servicio.num_abonado
         || ','
         || sn_cod_retorno
         || ','
         || sv_mens_retorno
         || ','
         || sn_num_evento
         || ')';
      Pv_Orden_Servicio_Pg.pv_obtiene_ga_abocel_pr (eo_orden_servicio,
                                                    sn_cod_retorno,
                                                    sv_mens_retorno,
                                                    sn_num_evento
                                                   );

      IF sn_cod_retorno > 0
      THEN
         RAISE error_ejecucion;
      END IF;

      reg_pv_camcom (1).num_os := eo_orden_servicio.idsecuencia;
      reg_pv_camcom (1).num_abonado := eo_orden_servicio.num_abonado;
      reg_pv_camcom (1).num_celular := eo_orden_servicio.num_celular;
      reg_pv_camcom (1).cod_cliente := eo_orden_servicio.cod_cliente;
      reg_pv_camcom (1).cod_cuenta := eo_orden_servicio.cod_cuenta;
      reg_pv_camcom (1).cod_producto := eo_orden_servicio.cod_producto;
      reg_pv_camcom (1).bdatos := 'SCEL';
      reg_pv_camcom (1).num_venta := NULL;
      reg_pv_camcom (1).num_transaccion := NULL;
      reg_pv_camcom (1).num_folio := NULL;
      reg_pv_camcom (1).num_cuotas := NULL;
      reg_pv_camcom (1).num_proceso := NULL;
      reg_pv_camcom (1).cod_actabo := eo_orden_servicio.cod_actabo;
      reg_pv_camcom (1).fh_anula := NULL;
      reg_pv_camcom (1).user_anula := NULL;
      reg_pv_camcom (1).cat_tribut := NULL;
      reg_pv_camcom (1).cod_estadoc := NULL;
      reg_pv_camcom (1).cod_causaelim := NULL;

      --reg_pv_camcom (1).fec_vencimiento := TO_DATE (eo_orden_servicio.fec_vencimiento, 'dd-mm-yy'); --COL-72424|05-11-2008|GEZ
      reg_pv_camcom (1).fec_vencimiento :=LVFecProg; --COL-72424|05-11-2008|GEZ

      --Reg_PV_CAMCOM(1).FEC_VENCIMIENTO  := to_char(EO_ORDEN_SERVICIO.FEC_VENCIMIENTO,'dd-mm-yyyy');
      reg_pv_camcom (1).abonados := '';
      reg_pv_camcom (1).tabla := '';

      --INI.PAGC 15-05-2008
      --IF EO_ORDEN_SERVICIO.CODACT_AL = ''  THEN
      IF TRIM (eo_orden_servicio.codact_al) IS NULL
      THEN
         --FIN.
         reg_pv_camcom (1).clase_servicio_act := '*';
      ELSE
         reg_pv_camcom (1).clase_servicio_act := eo_orden_servicio.codact_al;
      END IF;

      --INI.PAGC 15-05-2008
      --IF EO_ORDEN_SERVICIO.CODACT_BA = '' THEN
      IF TRIM (eo_orden_servicio.codact_ba) IS NULL
      THEN
         --FIN.
         reg_pv_camcom (1).clase_servicio_des := '*';
      ELSE
         reg_pv_camcom (1).clase_servicio_des := eo_orden_servicio.codact_ba;
      END IF;

      reg_pv_camcom (1).ind_msg := NULL;
      reg_pv_camcom (1).num_cargo_os := NULL;
      reg_pv_camcom (1).imp_cargo_ser := NULL;
      reg_pv_camcom (1).ind_central_ss := 1;
      reg_pv_camcom (1).ind_portable := eo_orden_servicio.ind_portable;
      reg_pv_camcom (1).tip_terminal := eo_orden_servicio.tip_terminal;
      reg_pv_camcom (1).tip_susp_avsinie := '';
      reg_pv_camcom (1).pref_plaza := '';
      lv_ssql :=
          'Reg_PV_CAMCOM(1).NUM_OS              := ' || reg_pv_camcom (1).num_os || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).NUM_ABONADO      := '
         || reg_pv_camcom (1).num_abonado
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).NUM_CELULAR      := '
         || reg_pv_camcom (1).num_celular
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).COD_CLIENTE      := '
         || reg_pv_camcom (1).cod_cliente
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).COD_CUENTA          := '
         || reg_pv_camcom (1).cod_cuenta
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).COD_PRODUCTO     := '
         || reg_pv_camcom (1).cod_producto
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).BDATOS              := '
         || reg_pv_camcom (1).bdatos
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).NUM_VENTA        := '
         || reg_pv_camcom (1).num_venta
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).NUM_TRANSACCION    := '
         || reg_pv_camcom (1).num_transaccion
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).NUM_FOLIO        := '
         || reg_pv_camcom (1).num_folio
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).NUM_CUOTAS        := '
         || reg_pv_camcom (1).num_cuotas
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).NUM_PROCESO        := '
         || reg_pv_camcom (1).num_proceso
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).COD_ACTABO        := '
         || reg_pv_camcom (1).cod_actabo
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).FH_ANULA        := '
         || reg_pv_camcom (1).fh_anula
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).USER_ANULA        := '
         || reg_pv_camcom (1).user_anula
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).CAT_TRIBUT        := '
         || reg_pv_camcom (1).cat_tribut
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).COD_ESTADOC        := '
         || reg_pv_camcom (1).cod_estadoc
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).COD_CAUSAELIM    := '
         || reg_pv_camcom (1).cod_causaelim
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).FEC_VENCIMIENTO    := '
         || reg_pv_camcom (1).fec_vencimiento
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).ABONADOS        := '
         || reg_pv_camcom (1).abonados
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).TABLA            := '
         || reg_pv_camcom (1).tabla
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'EO_ORDEN_SERVICIO.CODACT_AL = '
         || eo_orden_servicio.codact_al
         || '';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).CLASE_SERVICIO_ACT    := '
         || reg_pv_camcom (1).clase_servicio_act
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'EO_ORDEN_SERVICIO.CODACT_BA = '
         || eo_orden_servicio.codact_ba
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).CLASE_SERVICIO_DES := '
         || reg_pv_camcom (1).clase_servicio_des
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).IND_MSG            :='
         || reg_pv_camcom (1).ind_msg
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).NUM_CARGO_OS    :='
         || reg_pv_camcom (1).num_cargo_os
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).IMP_CARGO_SER    :='
         || reg_pv_camcom (1).imp_cargo_ser
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).IND_CENTRAL_SS    :='
         || reg_pv_camcom (1).ind_central_ss
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).IND_PORTABLE    :='
         || reg_pv_camcom (1).ind_portable
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).TIP_TERMINAL    :='
         || reg_pv_camcom (1).tip_terminal
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).TIP_SUSP_AVSINIE:='
         || reg_pv_camcom (1).tip_susp_avsinie
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'Reg_PV_CAMCOM(1).PREF_PLAZA        :='
         || reg_pv_camcom (1).pref_plaza
         || ' ';
      lv_ssql :=
            lv_ssql
         || 'pv_orden_servicio_pg.PV_INSERT_CAMCOM_PR (Reg_PV_CAMCOM,'
         || sn_cod_retorno
         || ','
         || sv_mens_retorno
         || ','
         || sn_num_evento
         || '); ';
      Pv_Orden_Servicio_Pg.pv_insert_camcom_pr (reg_pv_camcom,
                                                sn_cod_retorno,
                                                sv_mens_retorno,
                                                sn_num_evento
                                               );

      IF sn_cod_retorno > 0
      THEN
         RAISE error_ejecucion;
      END IF;

      SELECT num_serie
        INTO lv_num_serie
        FROM ga_abocel
       WHERE num_abonado = eo_orden_servicio.num_abonado;

      BEGIN
         SELECT cod_tiplan
           INTO lv_cod_tiplan
           FROM ta_plantarif
          WHERE cod_producto = 1
            AND cod_plantarif = eo_orden_servicio.cod_plantarif_nue;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SELECT cod_plantarif
              INTO lv_plan_aux
              FROM ppd_planes
             WHERE cod_plantarif = eo_orden_servicio.cod_plantarif_nue;

            lv_cod_uso := '3';
      END;

      IF TRIM (lv_cod_tiplan) = '2'
      THEN
         lv_cod_uso := '2';
      END IF;

      IF TRIM (lv_cod_tiplan) = '1'
      THEN
         lv_cod_uso := '3';
      END IF;

      IF TRIM (lv_cod_tiplan) = '3'
      THEN
         lv_cod_uso := '10';
      END IF;

      reg_pv_param_abocel (1).num_os := eo_orden_servicio.idsecuencia;
      reg_pv_param_abocel (1).num_abonado := eo_orden_servicio.num_abonado;
      reg_pv_param_abocel (1).cod_tipmodi := eo_orden_servicio.cod_actabo;

      --reg_pv_param_abocel (1).fec_modifica :=TO_DATE (eo_orden_servicio.fec_vencimiento, 'dd-mm-yy'); --COL-72424|05-11-2008|GEZ
      reg_pv_param_abocel (1).fec_modifica :=LVFecProg; --COL-72424|05-11-2008|GEZ

      -- Reg_PV_PARAM_ABOCEL(1).FEC_MODIFICA       :=  to_char(EO_ORDEN_SERVICIO.FEC_VENCIMIENTO,'dd-mm-yyyy');
      reg_pv_param_abocel (1).nuom_usuarora := eo_orden_servicio.usuario;
      reg_pv_param_abocel (1).num_celular := eo_orden_servicio.num_celular;
      reg_pv_param_abocel (1).cod_uso := lv_cod_uso;
      reg_pv_param_abocel (1).tip_plantarif := eo_orden_servicio.tip_plantarif;
      reg_pv_param_abocel (1).tip_terminal := eo_orden_servicio.tip_terminal;
      reg_pv_param_abocel (1).cod_plantarif := eo_orden_servicio.cod_plantarif;
      reg_pv_param_abocel (1).cod_cargobasico := NULL;
      reg_pv_param_abocel (1).cod_planserv := NULL;
      reg_pv_param_abocel (1).cod_limconsumo := NULL;
      reg_pv_param_abocel (1).num_serie := lv_num_serie;
      reg_pv_param_abocel (1).num_seriehex := NULL;
      reg_pv_param_abocel (1).cod_empresa := NULL;
      reg_pv_param_abocel (1).cod_grpserv := eo_orden_servicio.cod_grpserv;
      reg_pv_param_abocel (1).cod_carrier := NULL;
      reg_pv_param_abocel (1).cod_ciclo := NULL;
      reg_pv_param_abocel (1).ind_factur := NULL;
      reg_pv_param_abocel (1).cod_causa := eo_orden_servicio.cod_causa;
      reg_pv_param_abocel (1).num_min := NULL;
      reg_pv_param_abocel (1).cod_tipcontrato := NULL;
      reg_pv_param_abocel (1).num_meses := NULL;
      reg_pv_param_abocel (1).ind_eqprestado := NULL;
      reg_pv_param_abocel (1).fec_prorroga := NULL;
      reg_pv_param_abocel (1).num_ciclos := NULL;
      reg_pv_param_abocel (1).num_minutos := NULL;
      reg_pv_param_abocel (1).fec_fincontrato := NULL;
      reg_pv_param_abocel (1).cod_servicio := NULL;
      reg_pv_param_abocel (1).obs_detalle :=
                                          TRIM (eo_orden_servicio.periodofact);
      reg_pv_param_abocel (1).cod_tipsegu := 0;
      reg_pv_param_abocel (1).num_contrato := '';
      reg_pv_param_abocel (1).num_anexo := '';
      reg_pv_param_abocel (1).cod_producto := 1;
      reg_pv_param_abocel (1).cod_plantarif_nue :=
                                           eo_orden_servicio.cod_plantarif_nue;
      reg_pv_param_abocel (1).tip_plantarif_nue :=
                                           eo_orden_servicio.tip_plantarif_nue;
      reg_pv_param_abocel (1).num_dia := eo_orden_servicio.num_dia;
      reg_pv_param_abocel (1).cod_vendedor := eo_orden_servicio.cod_vendedor;
      reg_pv_param_abocel (1).param1_mens := eo_orden_servicio.param1_mens;
      lv_ssql :=
            'pv_orden_servicio_pg.PV_INSERT_PARAM_ABOCEL_PR            (Reg_PV_PARAM_ABOCEL,'
         || sn_cod_retorno
         || ','
         || sv_mens_retorno
         || ','
         || sn_num_evento
         || '); ';
      Pv_Orden_Servicio_Pg.pv_insert_param_abocel_pr (reg_pv_param_abocel,
                                                      sn_cod_retorno,
                                                      sv_mens_retorno,
                                                      sn_num_evento
                                                     );

      IF sn_cod_retorno > 0
      THEN
         RAISE error_ejecucion;
      END IF;

      reg_pv_param_cliente (1).cod_cliente := eo_orden_servicio.cod_cliente;

      IF     (eo_orden_servicio.cod_cliente_nue <>
                                                 eo_orden_servicio.cod_cliente
             )
         AND (    eo_orden_servicio.cod_cliente_nue > 0
              AND eo_orden_servicio.cod_cliente > 0
             )
      THEN
         eo_orden_servicio.cod_cliente := eo_orden_servicio.cod_cliente_nue;
      END IF;

      lv_ssql :=
            'SELECT  NOM_CLIENTE FROM GE_CLIENTES WHERE COD_CLIENTE ='
         || eo_orden_servicio.cod_cliente;

      SELECT nom_cliente
        INTO lv_nom_cliente
        FROM ge_clientes
       WHERE cod_cliente = eo_orden_servicio.cod_cliente;

      reg_pv_param_cliente (1).num_os := eo_orden_servicio.idsecuencia;
      reg_pv_param_cliente (1).cod_tipmodi := eo_orden_servicio.cod_actabo;

      --reg_pv_param_cliente (1).fec_modifica :=TO_DATE (eo_orden_servicio.fec_vencimiento, 'dd-mm-yy');  --COL-72424|05-11-2008|GEZ
      reg_pv_param_cliente (1).fec_modifica :=LVFecProg; --COL-72424|05-11-2008|GEZ

      reg_pv_param_cliente (1).nom_usuarora := eo_orden_servicio.usuario;
      reg_pv_param_cliente (1).nom_cliente := lv_nom_cliente;
      reg_pv_param_cliente (1).cod_tipident := NULL;
      reg_pv_param_cliente (1).num_ident := NULL;
      reg_pv_param_cliente (1).cod_calclien := NULL;
      reg_pv_param_cliente (1).cod_plancom := NULL;
      reg_pv_param_cliente (1).ind_factur := NULL;
      reg_pv_param_cliente (1).ind_traspaso := NULL;
      reg_pv_param_cliente (1).cod_actividad :=
                                               eo_orden_servicio.cod_causa_exc;
      reg_pv_param_cliente (1).cod_pais := NULL;
      reg_pv_param_cliente (1).tef_cliente1 := eo_orden_servicio.num_celu_pers;
      reg_pv_param_cliente (1).tef_cliente2 := NULL;
      reg_pv_param_cliente (1).num_fax := NULL;
      reg_pv_param_cliente (1).ind_debito := NULL;
      reg_pv_param_cliente (1).cod_sispago := NULL;
      reg_pv_param_cliente (1).nom_apeclien1 := NULL;
      reg_pv_param_cliente (1).nom_apeclien2 := NULL;
      reg_pv_param_cliente (1).imp_stopdebit := NULL;
      reg_pv_param_cliente (1).cod_banco := NULL;
      reg_pv_param_cliente (1).cod_sucursal := NULL;
      reg_pv_param_cliente (1).ind_tipcuenta := NULL;
      reg_pv_param_cliente (1).cod_tiptarjeta := NULL;
      reg_pv_param_cliente (1).num_ctacorr := NULL;
      reg_pv_param_cliente (1).num_tarjeta := NULL;
      reg_pv_param_cliente (1).fec_vencitarj := NULL;
      reg_pv_param_cliente (1).cod_bancotarj := NULL;
      reg_pv_param_cliente (1).cod_tipidtrib := NULL;
      reg_pv_param_cliente (1).num_identtrib := NULL;
      reg_pv_param_cliente (1).cod_tipidentapor := NULL;
      reg_pv_param_cliente (1).num_identapor := NULL;
      reg_pv_param_cliente (1).nom_apoderado := NULL;
      reg_pv_param_cliente (1).cod_oficina := NULL;
      reg_pv_param_cliente (1).cod_pincli := NULL;
      reg_pv_param_cliente (1).nom_email := NULL;
      reg_pv_param_cliente (1).cod_ciclo := NULL;
      reg_pv_param_cliente (1).cod_categoria := NULL;
      reg_pv_param_cliente (1).cod_sector := NULL;
      reg_pv_param_cliente (1).cod_supervisor := NULL;
      reg_pv_param_cliente (1).cod_npi := NULL;
      reg_pv_param_cliente (1).cod_empresa := eo_orden_servicio.abonado_nuevo;
      reg_pv_param_cliente (1).cod_plantarif := NULL;
      reg_pv_param_cliente (1).cod_cargobasico := NULL;
      reg_pv_param_cliente (1).num_ciclos := NULL;
      reg_pv_param_cliente (1).num_minutos := NULL;
      reg_pv_param_cliente (1).cod_cliente_nue :=
                                             eo_orden_servicio.cod_cliente_nue;
      reg_pv_param_cliente (1).cod_cuenta_nue :=
                                              eo_orden_servicio.cod_cuenta_nue;
      lv_ssql :=
            'pv_orden_servicio_pg.PV_INSERT_PARAM_CLIENTE_PR (Reg_PV_PARAM_CLIENTE,'
         || sn_cod_retorno
         || ','
         || sv_mens_retorno
         || ','
         || sn_num_evento
         || '); ';
      Pv_Orden_Servicio_Pg.pv_insert_param_cliente_pr (reg_pv_param_cliente,
                                                       sn_cod_retorno,
                                                       sv_mens_retorno,
                                                       sn_num_evento
                                                      );

      IF sn_cod_retorno > 0
      THEN
         RAISE error_ejecucion;
      END IF;

      reg_pv_prog (1).num_os := eo_orden_servicio.idsecuencia;

      --reg_pv_prog (1).f_prorroga :=TO_DATE (eo_orden_servicio.fec_vencimiento, 'dd-mm-yy'); --COL-72424|05-11-2008|GEZ
      reg_pv_prog (1).f_prorroga :=LVFecProg; --COL-72424|05-11-2008|GEZ
                                                                         --mal
--       Reg_PV_PROG(1).F_PRORROGA  := to_char(EO_ORDEN_SERVICIO.FEC_VENCIMIENTO,'dd-mm-yyyy');
      reg_pv_prog (1).usuario := eo_orden_servicio.usuario;
      reg_pv_prog (1).observacion := '';
      reg_pv_prog (1).fec_prog := SYSDATE;
      lv_ssql :=
            'pv_orden_servicio_pg.PV_INSERT_PV_PROG_PR (Reg_PV_PROG,'
         || sn_cod_retorno
         || ','
         || sv_mens_retorno
         || ','
         || sn_num_evento
         || '); ';
      Pv_Orden_Servicio_Pg.pv_insert_pv_prog_pr (reg_pv_prog,
                                                 sn_cod_retorno,
                                                 sv_mens_retorno,
                                                 sn_num_evento
                                                );

      IF sn_cod_retorno > 0
      THEN
         RAISE error_ejecucion;
      END IF;

      reg_pv_movimientos (1).num_os := eo_orden_servicio.idsecuencia;
      reg_pv_movimientos (1).f_ejecucion := SYSDATE;
      reg_pv_movimientos (1).ord_comando := 1;
      reg_pv_movimientos (1).cod_actabo := eo_orden_servicio.cod_actabo;
      reg_pv_movimientos (1).cod_servicio := eo_orden_servicio.cod_servicio;
      reg_pv_movimientos (1).ind_estado := '1';
      reg_pv_movimientos (1).fec_expira := NULL;
      reg_pv_movimientos (1).resp_central := NULL;
      reg_pv_movimientos (1).num_movimiento :=
                                              eo_orden_servicio.num_movimiento;
      reg_pv_movimientos (1).carga := NULL;
      reg_pv_movimientos (1).cod_estado := 1;
      lv_ssql :=
            'pv_orden_servicio_pg.PV_INSERT_PV_MOVIMIENTOS_PR (Reg_PV_MOVIMIENTOS,'
         || sn_cod_retorno
         || ','
         || sv_mens_retorno
         || ','
         || sn_num_evento
         || '); ';
      Pv_Orden_Servicio_Pg.pv_insert_pv_movimientos_pr (reg_pv_movimientos,
                                                        sn_cod_retorno,
                                                        sv_mens_retorno,
                                                        sn_num_evento
                                                       );

      IF sn_cod_retorno > 0
      THEN
         RAISE error_ejecucion;
      END IF;

      reg_pv_iorserv (1).status := 'Proceso exitoso orden_Servicio';
      reg_pv_iorserv (1).num_os := eo_orden_servicio.idsecuencia;
      lv_ssql :=
            'pv_orden_servicio_pg.PV_ACTUAL_IORSERV_PR (Reg_pv_iorserv,'
         || sn_cod_retorno
         || ','
         || sv_mens_retorno
         || ','
         || sn_num_evento
         || '); ';
      Pv_Orden_Servicio_Pg.pv_actual_iorserv_pr (reg_pv_iorserv,
                                                 sn_cod_retorno,
                                                 sv_mens_retorno,
                                                 sn_num_evento
                                                );

      IF sn_cod_retorno > 0
      THEN
         RAISE error_ejecucion;
      END IF;

      reg_pv_erecorrido (1).descripcion := eo_orden_servicio.des_estadoc;
      reg_pv_erecorrido (1).tip_estado := cn_tip_estado_3;
      reg_pv_erecorrido (1).num_os := eo_orden_servicio.idsecuencia;
      lv_ssql :=
            'pv_orden_servicio_pg.PV_ACTUAL_ERECORRIDO_PR (Reg_pv_erecorrido,'
         || sn_cod_retorno
         || ','
         || sv_mens_retorno
         || ','
         || sn_num_evento
         || '); ';
      Pv_Orden_Servicio_Pg.pv_actual_erecorrido_pr (reg_pv_erecorrido,
                                                    sn_cod_retorno,
                                                    sv_mens_retorno,
                                                    sn_num_evento
                                                   );

      IF sn_cod_retorno > 0
      THEN
         RAISE error_ejecucion;
      END IF;
   EXCEPTION
      WHEN error_ejecucion
      THEN
         lv_des_error := ' PV_REGISTR_CAMB_PLAN_BATCH_PR(''); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                       (sn_num_evento,
                        cv_cod_modulo,
                        sv_mens_retorno,
                        cv_version,
                        USER,
                        'pv_orden_servicio_pg.PV_REGISTR_CAMB_PLAN_BATCH_PR',
                        lv_ssql,
                        sn_cod_retorno,
                        lv_des_error
                       );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := 'PV_REGISTR_CAMB_PLAN_BATCH_PR(''); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                        (sn_num_evento,
                         cv_cod_modulo,
                         sv_mens_retorno,
                         cv_version,
                         USER,
                         'pv_orden_servicio_pg.PV_REGISTR_CAMB_PLAN_BATCH_PR',
                         lv_ssql,
                         sn_cod_retorno,
                         lv_des_error
                        );
   END pv_registr_camb_plan_batch_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_sel_numoos_fecejec_pr (
      eo_validaooss_pendplan   IN OUT NOCOPY   pv_validaooss_pendplan_qt,
      sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento            OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_SEL_NUMOoS_FECEJEC_PR "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
            <Descripción>Metodo  :  validaOossPendPlan   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="EO_VALIDAOoSS_PENDPLAN    Tipo="Estructura">Estructura de los datos    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error        ge_errores_pg.desevent;
      lv_ssql             ge_errores_pg.vquery;
      ln_cod_estado       pv_erecorrido.cod_estado%TYPE;
      ln_num_intentos     pv_iorserv.num_intentos%TYPE;
      eo_ged_parametros   pv_ged_parametros_qt;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := NULL;
      eo_validaooss_pendplan.num_os := 0;
      eo_validaooss_pendplan.fecha_ejecucion := NULL;
      ln_cod_estado := eo_validaooss_pendplan.cod_estado;
      ln_num_intentos := eo_validaooss_pendplan.num_intentos;
      lv_ssql :=
                'SELECT  e.num_os, TO_CHAR(e.fh_ejecucion, CV_formato_fecha)';
      lv_ssql :=
            lv_ssql
         || 'INTO    EO_VALIDAOOSS_PENDPLAN.NUM_OS, EO_VALIDAOOSS_PENDPLAN.FECHA_EJECUCION';
      lv_ssql :=
                lv_ssql || 'FROM   pv_iorserv e, pv_erecorrido f, pv_camcom g';
      lv_ssql := lv_ssql || 'WHERE e.num_os = f.num_os';
      lv_ssql := lv_ssql || 'AND     e.num_os = g.num_os';
      lv_ssql :=
            lv_ssql
         || 'AND     g.num_abonado = EO_VALIDAOOSS_PENDPLAN.NUM_ABONADO';
      lv_ssql := lv_ssql || 'AND     e.cod_os = EO_VALIDAOOSS_PENDPLAN.COD_OS';
      lv_ssql :=
            lv_ssql
         || 'AND     e.num_os NOT IN ( SELECT  a.num_os FROM pv_iorserv a, pv_erecorrido b, pv_camcom c, pv_arcos d';
      lv_ssql := lv_ssql || 'WHERE a.num_os = b.num_os';
      lv_ssql := lv_ssql || 'AND     a.cod_os = EO_VALIDAOOSS_PENDPLAN.COD_OS';
      lv_ssql := lv_ssql || 'AND     a.num_os = c.num_os';
      lv_ssql :=
            lv_ssql
         || 'AND     c.num_abonado = EO_VALIDAOOSS_PENDPLAN.NUM_ABONADO';
      lv_ssql := lv_ssql || 'AND     a.cod_modgener = d.cod_modgener';
      lv_ssql :=
            lv_ssql
         || 'AND     d.atrib_estado IN ('
         || cn_atrib_estado_2
         || ','
         || cn_atrib_estado_3
         || ')';
      lv_ssql := lv_ssql || 'AND     d.cod_aplic = CV_cod_aplic';
      lv_ssql :=
            lv_ssql
         || 'AND   ((b.cod_estado = d.est_final) OR (b.cod_estado = LN_cod_estado))';
      lv_ssql :=
                lv_ssql || 'AND     b.tip_estado = ' || cn_tip_estado_3 || ' ';
      lv_ssql := lv_ssql || 'AND     NVL(a.num_intentos, 0) < LN_num_intentos';
      lv_ssql := lv_ssql || 'UNION ALL';
      lv_ssql :=
            lv_ssql
         || 'SELECT  a.num_os FROM pv_iorserv a, pv_erecorrido b, pv_camcom c, pv_arcos d';
      lv_ssql := lv_ssql || 'WHERE a.num_os = b.num_os';
      lv_ssql := lv_ssql || 'AND     a.cod_os = EO_VALIDAOOSS_PENDPLAN.COD_OS';
      lv_ssql := lv_ssql || 'AND     a.num_os = c.num_os';
      lv_ssql :=
            lv_ssql
         || 'AND     c.num_abonado = EO_VALIDAOOSS_PENDPLAN.NUM_ABONADO';
      lv_ssql := lv_ssql || 'AND     a.cod_modgener = d.cod_modgener';
      lv_ssql :=
            lv_ssql
         || 'AND     D.atrib_estado IN ('
         || cn_atrib_estado_2
         || ','
         || cn_atrib_estado_3
         || ')';
      lv_ssql := lv_ssql || 'AND     d.cod_aplic = CV_cod_aplic';
      lv_ssql :=
                lv_ssql || 'AND     b.tip_estado = ' || cn_tip_estado_4 || ' ';
      lv_ssql :=
                lv_ssql || 'AND     NVL(a.num_intentos, 0) < LN_num_intentos)';

      SELECT e.num_os,
             TO_CHAR (e.fh_ejecucion, cv_formato_fecha)
        INTO eo_validaooss_pendplan.num_os,
             eo_validaooss_pendplan.fecha_ejecucion
        FROM pv_iorserv e, pv_erecorrido f, pv_camcom g
       WHERE e.num_os = f.num_os
         AND e.num_os = g.num_os
         AND g.num_abonado = eo_validaooss_pendplan.num_abonado
         AND e.cod_os = eo_validaooss_pendplan.cod_os
         AND e.num_os NOT IN (
                SELECT a.num_os
                  FROM pv_iorserv a, pv_erecorrido b, pv_camcom c, pv_arcos d
                 WHERE a.num_os = b.num_os
                   AND a.cod_os = eo_validaooss_pendplan.cod_os
                   AND a.num_os = c.num_os
                   AND c.num_abonado = eo_validaooss_pendplan.num_abonado
                   AND a.cod_modgener = d.cod_modgener
                   AND d.atrib_estado IN
                                       (cn_atrib_estado_2, cn_atrib_estado_3)
                   AND d.cod_aplic = cv_cod_aplic
                   AND (   (b.cod_estado = d.est_final)
                        OR (b.cod_estado = ln_cod_estado)
                       )
                   AND b.tip_estado = cn_tip_estado_3
                   AND NVL (a.num_intentos, 0) < ln_num_intentos
                UNION ALL
                SELECT a.num_os
                  FROM pv_iorserv a, pv_erecorrido b, pv_camcom c, pv_arcos d
                 WHERE a.num_os = b.num_os
                   AND a.cod_os = eo_validaooss_pendplan.cod_os
                   AND a.num_os = c.num_os
                   AND c.num_abonado = eo_validaooss_pendplan.num_abonado
                   AND a.cod_modgener = d.cod_modgener
                   AND d.atrib_estado IN
                                       (cn_atrib_estado_2, cn_atrib_estado_3)
                   AND d.cod_aplic = cv_cod_aplic
                   AND b.tip_estado = cn_tip_estado_4
                   AND NVL (a.num_intentos, 0) < ln_num_intentos);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         eo_validaooss_pendplan.num_os := 0;
         eo_validaooss_pendplan.fecha_ejecucion := NULL;
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_SEL_NUMOoS_FECEJEC_PR('
            || TO_CHAR (eo_validaooss_pendplan.num_abonado)
            || eo_validaooss_pendplan.cod_os
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'pv_orden_servicio_pg.PV_SEL_NUMOoS_FECEJEC_PR',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
   END pv_sel_numoos_fecejec_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_validaooss_pendplan_pr (
      eo_validaooss_pendplan   IN OUT NOCOPY   pv_validaooss_pendplan_qt,
      sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento            OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_VALIDAOoSS_PENDPLAN_PR"
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
            <Descripción>Metodo  :  validaOossPendPlan  </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="EO_VALIDAOoSS_PENDPLAN.COD_ESTADO    Tipo="Estructura">Estructura de los datos codigo de estado     </param>>
                  <param nom="EO_VALIDAOoSS_PENDPLAN.NUM_INTENTOS  Tipo="Estructura">Estructura de los datos numero de intentos   </param>>
                  <param nom="EO_VALIDAOoSS_PENDPLAN.COD_MODULO    Tipo="Estructura">Estructura de los datos codigo del modulo    </param>>
                  <param nom="EO_VALIDAOoSS_PENDPLAN.COD_OS        Tipo="Estructura">Estructura de los datos codigo os            </param>>
                  <param nom="EO_VALIDAOoSS_PENDPLAN.NUM_ABONADO   Tipo="Estructura">Estructura de los datos Numero Abonado       </param>>
               </Entrada>
               <Salida>
                  <param nom="EO_VALIDAOoSS_PENDPLAN.NUM_OS"          Tipo="Estructura">Estructura de los datos Numero os         </param>>
                  <param nom="EO_VALIDAOoSS_PENDPLAN.FECHA_EJECUCION"  Tipo="Estructura">Estructura de los datos fecha ejecucion   </param>>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error      ge_errores_pg.desevent;
      lv_ssql           ge_errores_pg.vquery;
      sv_cod_retorno    VARCHAR2 (1);
      n_count           NUMBER;
      error_ejecucion   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF (eo_validaooss_pendplan.cod_cliente_dest > 0)
      THEN
         lv_ssql :=
            'SELECT COUNT(1) FROM PV_IORSERV WHERE COD_OS IN (10020,10022,10029,10233,10530,10539) AND NUM_OSF_ERR <> 1';
         lv_ssql :=
               lv_ssql
            || ' AND TRUNC(FH_EJECUCION) >= TRUNC(SYSDATE) AND NUM_OS IN (SELECT  NUM_OS FROM PV_CAMCOM';
         lv_ssql :=
               lv_ssql
            || ' WHERE   COD_CLIENTE = '
            || eo_validaooss_pendplan.cod_cliente_dest
            || ' AND';
         lv_ssql :=
               lv_ssql
            || ' TRUNC(FEC_VENCIMIENTO) >= TRUNC(SYSDATE)) AND COD_ESTADO <=210';

         SELECT COUNT (1)
           INTO n_count
           FROM pv_iorserv
          WHERE cod_os IN (10020, 10022, 10029, 10233, 10530, 10539)
            AND num_osf_err <> 1
            AND TRUNC (fh_ejecucion) >= TRUNC (SYSDATE)
            AND num_os IN (
                   SELECT num_os
                     FROM pv_camcom
                    WHERE cod_cliente =
                                       eo_validaooss_pendplan.cod_cliente_dest
                      AND TRUNC (fec_vencimiento) >= TRUNC (SYSDATE))
            AND cod_estado <= 210;

         IF n_count > 0
         THEN
            sv_cod_retorno := 1;
            sv_mens_retorno :=
               'El cliente destino tiene un Cambio de Plan Pendiente. Elija otro cliente';
            eo_validaooss_pendplan.codigo := 1;
            eo_validaooss_pendplan.mensaje :=
               'El cliente destino tiene un Cambio de Plan Pendiente. Elija otro cliente';
            RAISE error_ejecucion;
         ELSE
            sv_cod_retorno := 0;
            sv_mens_retorno := 'NO EXISTEN OOSS PENDIENTES DE CAMBIO DE PLAN';
            eo_validaooss_pendplan.codigo := 0;
            eo_validaooss_pendplan.mensaje :=
                               'NO EXISTEN OOSS PENDIENTES DE CAMBIO DE PLAN';
            RAISE error_ejecucion;
         END IF;
      ELSE
         lv_ssql := 'PV_VAL_CAMPLAN_A_CICLO_PG.PV_VAL_CAMPLAN_A_CICLO_PR()';
         pv_val_camplan_a_ciclo_pg.pv_val_camplan_a_ciclo_pr
                                 (eo_validaooss_pendplan.cod_cliente,     --in
                                  eo_validaooss_pendplan.num_abonado,     --in
                                  eo_validaooss_pendplan.cod_os,          --in
                                  eo_validaooss_pendplan.cod_plantarif,   --in
                                  eo_validaooss_pendplan.codigo,
                                  eo_validaooss_pendplan.mensaje,
                                  eo_validaooss_pendplan.cod_plantarif_nuevo,
                                  eo_validaooss_pendplan.num_os,
                                  sn_cod_retorno,
                                  sv_mens_retorno,
                                  sn_num_evento
                                 );

         IF (sn_cod_retorno > 0)
         THEN
            RAISE error_ejecucion;
         END IF;
      END IF;
   EXCEPTION
      WHEN error_ejecucion
      THEN
         lv_des_error :=
               'PV_VALIDAOoSS_PENDPLAN_PR('
            || TO_CHAR (eo_validaooss_pendplan.num_os)
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                            (sn_num_evento,
                             cv_cod_modulo,
                             sv_mens_retorno,
                             cv_version,
                             USER,
                             'pv_orden_servicio_pg.PV_VALIDAOoSS_PENDPLAN_PR',
                             lv_ssql,
                             sn_cod_retorno,
                             lv_des_error
                            );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_VALIDAOoSS_PENDPLAN_PR('
            || TO_CHAR (   eo_validaooss_pendplan.cod_os
                        || ','
                        || eo_validaooss_pendplan.num_abonado
                       )
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                            (sn_num_evento,
                             cv_cod_modulo,
                             sv_mens_retorno,
                             cv_version,
                             USER,
                             'pv_orden_servicio_pg.PV_VALIDAOoSS_PENDPLAN_PR',
                             lv_ssql,
                             sn_cod_retorno,
                             lv_des_error
                            );
   END pv_validaooss_pendplan_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_actu_num_intentos_pr (
      reg_pv_iorserv    IN              pv_tipos_pg.r_pv_iorserv,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_ACTU_NUM_INTENTOS_PR "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
                  <Descripción>Metodo  :  AnulaOossPendPlan                   </Descripción>>
                  <Descripción>           Actualiza Numero de Intentos        </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="Reg_pv_iorserv   Tipo="Estructura de Registro "> Estructura de registro con datos a Actualizar  </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      FOR i IN reg_pv_iorserv.FIRST .. reg_pv_iorserv.LAST
      LOOP
         lv_ssql := '';
         lv_ssql := lv_ssql || ' ';
         lv_ssql :=
               lv_ssql
            || ' UPDATE  pv_iorserv SET NUM_INTENTOS = '
            || reg_pv_iorserv (i).num_intentos
            || ' ';
         lv_ssql :=
            lv_ssql || ' WHERE NUM_OS = ' || reg_pv_iorserv (i).num_os || '  ';
         lv_ssql :=
            lv_ssql || ' AND   COD_OS = ' || reg_pv_iorserv (i).cod_os || '; ';

         UPDATE pv_iorserv
            SET num_intentos = reg_pv_iorserv (i).num_intentos
          WHERE num_os = reg_pv_iorserv (i).num_os
            AND cod_os = reg_pv_iorserv (i).cod_os;
      END LOOP;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;                                           --4

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := ' PV_ACTU_NUM_INTENTOS_PR(''); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                              (sn_num_evento,
                               cv_cod_modulo,
                               sv_mens_retorno,
                               cv_version,
                               USER,
                               'pv_orden_servicio_pg.PV_ACTU_NUM_INTENTOS_PR',
                               lv_ssql,
                               sn_cod_retorno,
                               lv_des_error
                              );
   END pv_actu_num_intentos_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_actu_tip_estado_pr (
      reg_pv_erecorrido   IN              pv_tipos_pg.r_pv_erecorrido,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_ACTU_TIP_ESTADO_PR  "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
                  <Descripción>Metodo  :  AnulaOossPendPlan                 </Descripción>>
                  <Descripción>           Actualiza Tipo de estado         </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="Reg_pv_erecorrido   Tipo="Estructura de Registro "> Estructura de registro con datos a Actualizar  </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      FOR i IN reg_pv_erecorrido.FIRST .. reg_pv_erecorrido.LAST
      LOOP
         lv_ssql := '';
         lv_ssql := lv_ssql || 'UPDATE pv_erecorrido ';
         lv_ssql :=
               lv_ssql
            || '          SET TIP_ESTADO = '
            || reg_pv_erecorrido (i).tip_estado
            || ' ';
         lv_ssql :=
               lv_ssql
            || 'WHERE NUM_OS          = '
            || reg_pv_erecorrido (i).num_os
            || ' ';
         lv_ssql :=
               lv_ssql
            || 'AND   COD_ESTADO < '
            || reg_pv_erecorrido (i).cod_estado
            || '; ';

         UPDATE pv_erecorrido
            SET tip_estado = reg_pv_erecorrido (i).tip_estado
          WHERE num_os = reg_pv_erecorrido (i).num_os
            AND cod_estado < reg_pv_erecorrido (i).cod_estado;
      END LOOP;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;                                           --4

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := ' PV_ACTU_TIP_ESTADO_PR(''); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                (sn_num_evento,
                                 cv_cod_modulo,
                                 sv_mens_retorno,
                                 cv_version,
                                 USER,
                                 'pv_orden_servicio_pg.PV_ACTU_TIP_ESTADO_PR',
                                 lv_ssql,
                                 sn_cod_retorno,
                                 lv_des_error
                                );
   END pv_actu_tip_estado_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_anulaooss_pendplan_pr (
      eo_iorserv        IN OUT NOCOPY   pv_iorserv_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_ANULAOoSS_PENDPLAN_PR"
            Lenguaje="PL/SQL"
            Fecha="03-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
            <Descripción>Metodo  :  AnulaOossPendPlan  </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="PV_IORSERV_QT.NUM_OS"         Tipo="Estructura">Estructura de los datos Numero de Orden de Servicio     </param>>
                  <param nom="PV_IORSERV_QT.COD_OS"         Tipo="Estructura">Estructura de los datos Codugo de Orden de Servicio     </param>>
                  <param nom="PV_IORSERV_QT.NUM_INTENTOS"  Tipo="Estructura">Estructura de los datos Numero de intentos de Reproceso  </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error        ge_errores_pg.desevent;
      lv_ssql             ge_errores_pg.vquery;
      sv_cod_retorno      VARCHAR2 (1);
      sv_glosa_retorno    VARCHAR2 (100);
      error_ejecucion     EXCEPTION;
      reg_pv_iorserv      pv_tipos_pg.r_pv_iorserv;
      reg_pv_erecorrido   pv_tipos_pg.r_pv_erecorrido;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql := 'PV_ANULA_CAMPLAN_A_CICLO_PG.PV_ANULA_CAMPLAN_A_CICLO_PR(';
      lv_ssql :=
            lv_ssql
         || eo_iorserv.cod_cliente
         || ','
         || eo_iorserv.num_abonado
         || ','
         || eo_iorserv.cod_plantarif
         || ',';
      lv_ssql :=
            lv_ssql
         || eo_iorserv.codigo
         || ','
         || eo_iorserv.mensaje
         || ','
         || eo_iorserv.cod_plantarif_nuevo
         || ',';
      lv_ssql := lv_ssql || eo_iorserv.num_os || ')';
      pv_anula_camplan_a_ciclo_pg.pv_anula_camplan_a_ciclo_pr
                                              (eo_iorserv.cod_cliente,
                                               eo_iorserv.num_abonado,
                                               eo_iorserv.cod_plantarif,
                                               eo_iorserv.codigo,
                                               eo_iorserv.mensaje,
                                               eo_iorserv.cod_plantarif_nuevo,
                                               eo_iorserv.num_os,
                                               sn_cod_retorno,
                                               sv_mens_retorno,
                                               sn_num_evento
                                              );

      IF sn_cod_retorno > 0
      THEN
         RAISE error_ejecucion;
      END IF;
   EXCEPTION
      WHEN error_ejecucion
      THEN
         lv_des_error :=
               'PV_ANULAOoSS_PENDPLAN_PR('
            || TO_CHAR (eo_iorserv.num_os)
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'pv_orden_servicio_pg.PV_ANULAOoSS_PENDPLAN_PR',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_ANULAOoSS_PENDPLAN_PR('
            || TO_CHAR (eo_iorserv.num_os)
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'pv_orden_servicio_pg.PV_ANULAOoSS_PENDPLAN_PR',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
   END pv_anulaooss_pendplan_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_val_restric_comer_ooss_pr (
      eo_val_restric_comer_ooss   IN              pv_val_restr_comer_os_qt,
      sn_cod_retorno              OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno             OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento               OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_VAL_RESTRIC_COMER_OoSS_PR   "
            Lenguaje="PL/SQL"
            Fecha="06-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
                  <Descripción>Metodo  :  validarRestriccionComerOoss                     </Descripción>>
                  <Descripción>           Ejecuta PL Existente PV_PR_EJECUTA_RESTRICCION    </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="EO_VAL_RESTRIC_COMER_OoSS    Tipo="Estructura de Type "> Estructura Type  </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error      ge_errores_pg.desevent;
      lv_ssql           ge_errores_pg.vquery;
      error_ejecucion   EXCEPTION;
      lv_version        ge_programas.num_version%TYPE;
      lv_subversion     ge_programas.num_subversion%TYPE;
      v_secuencia       VARCHAR2 (09);
      v_modulo          VARCHAR2 (02);
      v_producto        NUMBER (01);
      v_actuacion       VARCHAR2 (02);
      v_evento          VARCHAR2 (10);
      v_param_entrada   VARCHAR2 (2000);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      v_secuencia := TO_CHAR (eo_val_restric_comer_ooss.num_transaccion);
      v_modulo := cv_cod_modulo;
      v_producto := cn_producto;
      v_actuacion := eo_val_restric_comer_ooss.cod_actuacion;
      v_evento := eo_val_restric_comer_ooss.cod_evento;
      lv_ssql :=
            'PV_GENERALES_PG.PV_obtiene_version_FN('
         || lv_version
         || ','
         || lv_subversion
         || ','
         || sn_cod_retorno
         || ','
         || sv_mens_retorno
         || ','
         || sn_num_evento
         || ') ';

      IF pv_generales_pg.pv_obtiene_version_fn (lv_version,
                                                lv_subversion,
                                                sn_cod_retorno,
                                                sv_mens_retorno,
                                                sn_num_evento
                                               ) = FALSE
      THEN
         RAISE error_ejecucion;
      END IF;

      v_param_entrada := '';
      v_param_entrada :=
                  v_param_entrada || '|' || eo_val_restric_comer_ooss.programa;
                                           --:= 'GPA';      --  VARCHAR2 (22),
      v_param_entrada := v_param_entrada || '|' || TO_CHAR (lv_version);
                                           --:= 16;         --  NUMBER   (02),
      v_param_entrada :=
                   v_param_entrada || '|' || eo_val_restric_comer_ooss.proceso;
                                        --:= 'proceso';     --  VARCHAR2 (30),
      v_param_entrada :=
             v_param_entrada || '|' || eo_val_restric_comer_ooss.cod_actuacion;
                                                                   -- := 'C7';
      v_param_entrada :=
            v_param_entrada
         || '|'
         || TO_CHAR (eo_val_restric_comer_ooss.num_abonado);
                                           --:= 8138613;    --  NUMBER   (08),
      v_param_entrada :=
            v_param_entrada
         || '|'
         || TO_CHAR (eo_val_restric_comer_ooss.cod_cliente);
                                           --:= 3395144;    --  NUMBER   (08),
      v_param_entrada :=
              v_param_entrada || '|' || eo_val_restric_comer_ooss.cod_modgener;
                                                                 -- := 'DDAF';
      v_param_entrada :=
         v_param_entrada || '|'
         || TO_CHAR (eo_val_restric_comer_ooss.num_venta);
                                           -- := 0;          -- NUMBER   (09),
      v_param_entrada :=
                  v_param_entrada || '|' || eo_val_restric_comer_ooss.cod_ooss;
                                        --:= '10225';        -- VARCHAR2 (05),
      v_param_entrada :=
            v_param_entrada
         || '|'
         || TO_CHAR (eo_val_restric_comer_ooss.cod_vendedor);
                                           --:= 0;           -- NUMBER   (06),
      v_param_entrada :=
            v_param_entrada
         || '|'
         || TO_CHAR (eo_val_restric_comer_ooss.desactivacion_ss);
                                           --:= 0;           -- NUMBER   (03),
      v_param_entrada :=
              v_param_entrada || '|' || eo_val_restric_comer_ooss.plan_destino;
                                        --:= '123';          -- VARCHAR2 (03),
      v_param_entrada :=
         v_param_entrada || '|' || TO_CHAR (eo_val_restric_comer_ooss.cod_uso);
                                           --:= 01;          -- NUMBER   (02),
      v_param_entrada :=
            v_param_entrada
         || '|'
         || TO_CHAR (eo_val_restric_comer_ooss.cod_cuenta_origen);
                                       --   := 1;            -- NUMBER   (08),
      v_param_entrada :=
            v_param_entrada
         || '|'
         || TO_CHAR (eo_val_restric_comer_ooss.cod_cuenta_destino);
                                          --   := 2430776;   -- NUMBER   (08),
      v_param_entrada :=
            v_param_entrada
         || '|'
         || TO_CHAR (eo_val_restric_comer_ooss.cod_cliente_destino);
                                       --  := 2685180;       -- NUMBER   (08),
      v_param_entrada :=
                 v_param_entrada || '|' || eo_val_restric_comer_ooss.tipo_plan;
                                          -- := 'I';         -- VARCHAR2 (01),
      v_param_entrada :=
         v_param_entrada || '|' || eo_val_restric_comer_ooss.tipo_plan_destino;
                                          --    := 'G';      -- VARCHAR2 (01),
      v_param_entrada :=
         v_param_entrada || '|'
         || TO_CHAR (eo_val_restric_comer_ooss.num_ciclo);
                                          --   := 1;         -- NUMBER   (10),
--    v_param_entrada  := v_param_entrada ||'|'||to_char(to_date(EO_VAL_RESTRIC_COMER_OoSS.FECHA_SISTEMA,'dd/mm/yyyy HH24:MI:SS'),'dd/mm/yyyy HH24:MI:SS');  -- .= sysdate;
      v_param_entrada :=
            v_param_entrada
         || '|'
         || TO_CHAR (eo_val_restric_comer_ooss.fecha_sistema, 'DD-MM-YYYY');
                                                                -- .= sysdate;
      v_param_entrada :=
            v_param_entrada
         || '|'
         || eo_val_restric_comer_ooss.restriccion_auxiliar;
                                          -- := II;         -- VARCHAR2  (10),
      v_param_entrada :=
                v_param_entrada || '|' || eo_val_restric_comer_ooss.cod_modulo;
                                         ---:= 'GA';       --   VARCHAR2 (02),
      v_param_entrada :=
         v_param_entrada || '|'
         || TO_CHAR (eo_val_restric_comer_ooss.cod_tarea);
                                        --   := 43;          -- NUMBER   (06),
      v_param_entrada :=
            v_param_entrada
         || '|'
         || TO_CHAR (eo_val_restric_comer_ooss.cod_central)
         || '|';                            --   := 1;        -- NUMBER   (03)
      lv_ssql :=
            'PV_PR_EJECUTA_RESTRICCION ('
         || v_secuencia
         || ','
         || v_modulo
         || ','
         || v_producto
         || ','
         || v_actuacion
         || ','
         || v_evento
         || ','
         || v_param_entrada
         || '); ';
      pv_pr_ejecuta_restriccion (v_secuencia,
                                 v_modulo,
                                 v_producto,
                                 v_actuacion,
                                 v_evento,
                                 v_param_entrada
                                );
      lv_ssql :=
         'SELECT COD_RETORNO, DES_CADENA     INTO SN_cod_retorno, SV_mens_retorno ';
      lv_ssql := lv_ssql || 'FROM GA_TRANSACABO ';
      lv_ssql := lv_ssql || 'WHERE num_transaccion =' || v_secuencia || ';';

      SELECT cod_retorno, des_cadena
        INTO sn_cod_retorno, sv_mens_retorno
        FROM ga_transacabo
       WHERE num_transaccion = v_secuencia;

      IF sn_cod_retorno > 0
      THEN
         RAISE error_ejecucion;
      END IF;
   EXCEPTION
      WHEN error_ejecucion
      THEN
         lv_des_error :=
               'PV_VAL_RESTRIC_COMER_OoSS_PR('
            || TO_CHAR (v_secuencia)
            || ', '
            || v_modulo
            || ','
            || v_producto
            || ','
            || v_actuacion
            || ','
            || v_evento
            || ','
            || v_param_entrada
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                         (sn_num_evento,
                          cv_cod_modulo,
                          sv_mens_retorno,
                          cv_version,
                          USER,
                          'pv_orden_servicio_pg.PV_VAL_RESTRIC_COMER_OoSS_PR',
                          lv_ssql,
                          sn_cod_retorno,
                          lv_des_error
                         );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_VAL_RESTRIC_COMER_OoSS_PR ('
            || TO_CHAR (v_secuencia)
            || ', '
            || v_modulo
            || ','
            || v_producto
            || ','
            || v_actuacion
            || ','
            || v_evento
            || ','
            || v_param_entrada
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                         (sn_num_evento,
                          cv_cod_modulo,
                          sv_mens_retorno,
                          cv_version,
                          USER,
                          'pv_orden_servicio_pg.PV_VAL_RESTRIC_COMER_OoSS_PR',
                          lv_ssql,
                          sn_cod_retorno,
                          lv_des_error
                         );
   END pv_val_restric_comer_ooss_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_obtener_conversion_pr (
      eo_orserv         IN              pv_orden_servicio_qt,
      so_conversion     OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_OBTENER_CONVERSION_PR"
            Lenguaje="PL/SQL"
            Fecha="03-07-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
            <Descripción> Obtener datos de Conversion   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="PV_IORSERV_QT.NUM_OS"         Tipo="Estructura">Estructura de los datos Numero de Orden de Servicio     </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
      lv_codosant    pv_restric_converooss_td.cod_os_ant%TYPE;
      lv_codactua    ga_actabo.cod_actabo%TYPE;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql :=
         ' OPEN SO_Conversion FOR SELECT NULL cod_plantarif, NULL des_plantarif, NULL cod_limconsumo, NULL des_limconsumo, NULL cod_cargobasico, NULL des_cargobasico, NULL IMP_CARGOBASICO , null imp_final FROM DUAL WHERE ROWNUM = 0; ';

      OPEN so_conversion FOR
         SELECT NULL cod_os_ant, NULL cod_actuacion, NULL cod_actuacion_web,
                NULL descripcion_ant, NULL descripcion_nue
           FROM DUAL
          WHERE ROWNUM = 0;

      lv_ssql := ' OPEN SO_Conversion FOR';
      lv_ssql :=
            lv_ssql
         || ' SELECT a.cod_os_ant, a.cod_actuacion, a.cod_actuacion_web, b.descripcion as descripcion_ant, c.descripcion as descripcion_nue';
      lv_ssql :=
            lv_ssql
         || ' FROM PV_RESTRIC_CONVEROOSS_TD a, CI_TIPORSERV b, CI_TIPORSERV c';
      lv_ssql := lv_ssql || ' WHERE cod_os_nue = ' || eo_orserv.cod_os;
      lv_ssql :=
                lv_ssql || ' AND tipo_movimiento = ' || eo_orserv.combinatoria;
      lv_ssql := lv_ssql || ' AND a.cod_os_ant = b.cod_os';
      lv_ssql := lv_ssql || ' AND a.cod_os_nue = c.cod_os';

      OPEN so_conversion FOR
         SELECT a.cod_os_ant, a.cod_actuacion, a.cod_actuacion_web,
                b.descripcion AS descripcion_ant,
                c.descripcion AS descripcion_nue
           FROM pv_restric_converooss_td a, ci_tiporserv b, ci_tiporserv c
          WHERE a.cod_os_nue = eo_orserv.cod_os
            AND a.tipo_movimiento = eo_orserv.combinatoria
            AND a.cod_os_ant = b.cod_os
            AND a.cod_os_nue = c.cod_os;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 1361;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := 'No es posible clasificar el error';
         END IF;

         lv_des_error := 'PV_OBTENER_CONVERSION_PR(''); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'pv_orden_servicio_pg.PV_OBTENER_CONVERSION_PR',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := 'PV_OBTENER_CONVERSION_PR (''); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'pv_orden_servicio_pg.PV_OBTENER_CONVERSION_PR',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
   END pv_obtener_conversion_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_act_coment_pviorserv_pr (
      so_iorserv_qt     IN              pv_iorserv_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_ACT_COMENT_PVIORSERV_PR "
            Lenguaje="PL/SQL"
            Fecha="09-08-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Carlos Elizondo"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  Actualiza Comentario Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="SO_IORSERV_QT    Tipo="Estructura de Type ">Estructura de Type    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql :=
            'UPDATE PV_IORSERV SET COMENTARIO = trim('
         || so_iorserv_qt.comentario
         || so_iorserv_qt.num_os_origen
         || ') WHERE NUM_OS = '
         || so_iorserv_qt.num_os
         || '; ';

      UPDATE pv_iorserv
         SET comentario =
                TRIM (so_iorserv_qt.comentario || so_iorserv_qt.num_os_origen)
       WHERE num_os = so_iorserv_qt.num_os;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_ACT_COMENT_PVIORSERV_PR ('
            || so_iorserv_qt.num_os
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            cv_cod_modulo,
                            sv_mens_retorno,
                            cv_version,
                            USER,
                            'pv_orden_servicio_pg.PV_ACT_COMENT_PVIORSERV_PR',
                            lv_ssql,
                            sn_cod_retorno,
                            lv_des_error
                           );
   END pv_act_coment_pviorserv_pr;

--------------------------------------------------------------------------------------------------------
   FUNCTION pv_validar_portabilidad_fn (
      so_ga_abonado     IN OUT NOCOPY   ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN VARCHAR
   AS
/*
   <Documentacion TipoDoc = "Funcion">
   <Elemento Nombre = "PV_VALIDAR_PORTABILIDAD_FN "
    Lenguaje="PL/SQL" Fecha="10-08-2007"
    Versión"1.0.0" Dise+ador"****"
    Programador="" Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion>   Funcion que valida indicador de portabilidad , retorna true o falso  </Descripcion>
   <Parametros>
   <Entrada>
         <param nom="SO_GA_ABONADO "    Tipo="Estructura Type GA_ABONADO_QT"> Datos de Estructura  </param>>
   </Entrada>
            <Salida>
               <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo de Retorno         </param>>
               <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje de Retorno        </param>>
               <param nom="SN_num_evento"             Tipo="NUMERICO">Numero de Evento       </param>>
            </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
   */
      lv_des_error    ge_errores_pg.desevent;
      lv_ssql         ge_errores_pg.vquery;
      lv_ind_portab   NUMBER (1);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql :=
         'SELECT IND_PORTAB, USO_DESTINO INTO LV_IND_PORTAB, SO_GA_ABONADO.COD_USO_DESTINO ';
      lv_ssql := ' FROM GAD_ORIDESUSO ';
      lv_ssql :=
              lv_ssql || ' WHERE USO_ORIGEN=' || so_ga_abonado.cod_uso || ' ';
      lv_ssql :=
         lv_ssql || ' AND TEC_ORIGEN  =' || so_ga_abonado.cod_tecnologia
         || ' ';
      lv_ssql :=
         lv_ssql || ' AND USO_DESTINO =' || so_ga_abonado.cod_uso_destino
         || ' ';
      lv_ssql :=
         lv_ssql || ' AND TEC_DESTINO =' || so_ga_abonado.cod_tecnologia
         || ' ';
      lv_ssql :=
           lv_ssql || ' AND COD_ACTABO  =' || so_ga_abonado.cod_actabo || ' ';
      lv_ssql := lv_ssql || ' AND COD_MODULO  =' || cv_cod_modulo || ' ';
      lv_ssql := lv_ssql || ' AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA; ';

      SELECT ind_portab, uso_destino
        INTO lv_ind_portab, so_ga_abonado.cod_uso_destino
        FROM gad_oridesuso
       WHERE uso_origen = so_ga_abonado.cod_uso
         AND tec_origen = so_ga_abonado.cod_tecnologia
         AND uso_destino = so_ga_abonado.cod_uso_destino
         AND tec_destino = so_ga_abonado.cod_tecnologia
         AND cod_actabo = so_ga_abonado.cod_actabo
         AND cod_modulo = cv_cod_modulo
         AND SYSDATE BETWEEN fec_desde AND fec_hasta;

      IF lv_ind_portab = 1
      THEN
         RETURN 'TRUE';
      ELSE
         RETURN 'FALSE';
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 1408;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_VALIDAR_PORTABILIDAD_FN ('
            || so_ga_abonado.cod_uso
            || ','
            || so_ga_abonado.cod_tecnologia
            || so_ga_abonado.cod_actabo
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            cv_cod_modulo,
                            sv_mens_retorno,
                            cv_version,
                            USER,
                            'pv_orden_servicio_pg.PV_VALIDAR_PORTABILIDAD_FN',
                            lv_ssql,
                            sn_cod_retorno,
                            lv_des_error
                           );
         RETURN 'FALSE';
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_VALIDAR_PORTABILIDAD_FN ('
            || so_ga_abonado.cod_uso
            || ','
            || so_ga_abonado.cod_tecnologia
            || so_ga_abonado.cod_actabo
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            cv_cod_modulo,
                            sv_mens_retorno,
                            cv_version,
                            USER,
                            'pv_orden_servicio_pg.PV_VALIDAR_PORTABILIDAD_FN',
                            lv_ssql,
                            sn_cod_retorno,
                            lv_des_error
                           );
         RETURN 'FALSE';
   END pv_validar_portabilidad_fn;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_insertar_trasacabo_pr (
      en_num_secuencia   IN              NUMBER,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_INSERTAR_TRASACABO_PR "
            Lenguaje="PL/SQL"
            Fecha="14-08-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Elizabeth Vera"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  Inserta secuencia en tabla ga_trasacabo </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="EN_num_secuencia"   Tipo="NUMERICO">Secuencia   </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql :=
            'INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA) VALUES('
         || en_num_secuencia
         || ',  0,ok ) ';

      INSERT INTO ga_transacabo
                  (num_transaccion, cod_retorno, des_cadena
                  )
           VALUES (en_num_secuencia, 0, 'ok'
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
            ' PV_INSERTAR_TRASACABO_PR (' || en_num_secuencia || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'pv_orden_servicio_pg.PV_INSERTAR_TRASACABO_PR',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
   END pv_insertar_trasacabo_pr;

   PROCEDURE pv_baja_ss_prepago_pr (
      so_abonado_qt     IN              ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_BAJA_SS_PREPAGO_PR "
            Lenguaje="PL/SQL"
            Fecha="09-08-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Alejandro Díaz"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  Actualiza Comentario Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="SO_IORSERV_QT    Tipo="Estructura de Type ">Estructura de Type    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error          ge_errores_pg.desevent;
      lv_ssql               ge_errores_pg.vquery;
      cv_modulo             ged_parametros.cod_modulo%TYPE      := 'GA';
      cv_nomparametro       ged_parametros.nom_parametro%TYPE
                                                     := 'CAU_BAJA_OP_CTA_TOT';
      cv_situacionbaja      ga_situabo.cod_situacion%TYPE       := 'BAA';
      dfecha                DATE;
      lv_optactatotal       ged_parametros.val_parametro%TYPE;
      ln_codcliente         ga_aboamist.cod_cliente%TYPE;
      no_existe_parametro   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      dfecha := SYSDATE;
      lv_ssql :=
            'SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE COD_MODULO ='
         || cv_modulo;
      lv_ssql := lv_ssql || ' AND NOM_PARAMETRO =' || cv_nomparametro;

      BEGIN
         SELECT val_parametro
           INTO lv_optactatotal
           FROM ged_parametros
          WHERE cod_modulo = cv_modulo AND nom_parametro = cv_nomparametro;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RAISE no_existe_parametro;
      END;

      lv_ssql := 'UPDATE GA_ABOAMIST SET COD_SITUACION = ' || cv_situacionbaja;
      lv_ssql := lv_ssql || ' FEC_BAJA = ' || dfecha;
      lv_ssql := lv_ssql || ' FEC_ULTMOD = ' || dfecha;
      lv_ssql := lv_ssql || ' COD_CAUSABAJA = ' || lv_optactatotal;
      lv_ssql := lv_ssql || ' FEC_BAJACEN = ' || dfecha;
      lv_ssql :=
               lv_ssql || ' WHERE NUM_ABONADO = ' || so_abonado_qt.num_abonado;

      UPDATE ga_aboamist
         SET cod_situacion = cv_situacionbaja,
             fec_baja = dfecha,
             fec_ultmod = dfecha,
             cod_causabaja = lv_optactatotal,
             fec_bajacen = dfecha
       WHERE num_abonado = so_abonado_qt.num_abonado;

      SELECT cod_cliente
        INTO ln_codcliente
        FROM ga_aboamist
       WHERE num_abonado = so_abonado_qt.num_abonado;

      UPDATE ge_clientes
         SET num_abocel = num_abocel - 1
       WHERE cod_cliente = ln_codcliente;

      lv_ssql :=
            'UPDATE GA_SERVSUPLABO SET FEC_BAJABD = SYSDATE,  IND_ESTADO = 5 ';
      lv_ssql :=
               lv_ssql || ' WHERE NUM_ABONADO = ' || so_abonado_qt.num_abonado;
      lv_ssql := lv_ssql || ' AND IND_ESTADO < 3';

      UPDATE ga_servsuplabo
         SET fec_bajabd = SYSDATE,
             ind_estado = 5
       WHERE num_abonado = so_abonado_qt.num_abonado AND ind_estado < 3;
   EXCEPTION
      WHEN no_existe_parametro
      THEN
         sn_cod_retorno := 1362;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_BAJA_SS_PREPAGO_PR ('
            || so_abonado_qt.num_abonado
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                (sn_num_evento,
                                 cv_cod_modulo,
                                 sv_mens_retorno,
                                 cv_version,
                                 USER,
                                 'pv_orden_servicio_pg.PV_BAJA_SS_PREPAGO_PR',
                                 lv_ssql,
                                 sn_cod_retorno,
                                 lv_des_error
                                );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_BAJA_SS_PREPAGO_PR ('
            || so_abonado_qt.num_abonado
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                (sn_num_evento,
                                 cv_cod_modulo,
                                 sv_mens_retorno,
                                 cv_version,
                                 USER,
                                 'pv_orden_servicio_pg.PV_BAJA_SS_PREPAGO_PR',
                                 lv_ssql,
                                 sn_cod_retorno,
                                 lv_des_error
                                );
   END pv_baja_ss_prepago_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_baja_reg_tarif_pr (
      so_abonado_qt     IN              ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_BAJA_REG_TARIF_PR "
            Lenguaje="PL/SQL"
            Fecha="09-08-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Alejandro Díaz"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  Actualiza Comentario Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="SO_IORSERV_QT    Tipo="Estructura de Type ">Estructura de Type    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := NULL;
      lv_ssql :=
            'UPDATE GA_INTARCEL  SET FEC_HASTA  = SYSDATE,  IND_ESTADO = 5  WHERE COD_CLIENTE = '
         || so_abonado_qt.cod_cliente
         || ' AND NUM_ABONADO = '
         || so_abonado_qt.num_abonado
         || '; ';

      UPDATE ga_intarcel
         SET fec_hasta = SYSDATE
       WHERE cod_cliente = so_abonado_qt.cod_cliente
         AND num_abonado = so_abonado_qt.num_abonado;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 149;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_BAJA_REG_TARIF_PR ('
            || so_abonado_qt.num_abonado
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                 (sn_num_evento,
                                  cv_cod_modulo,
                                  sv_mens_retorno,
                                  cv_version,
                                  USER,
                                  'pv_orden_servicio_pg.PV_BAJA_REG_TARIF_PR',
                                  lv_ssql,
                                  sn_cod_retorno,
                                  lv_des_error
                                 );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_BAJA_REG_TARIF_PR ('
            || so_abonado_qt.num_abonado
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                 (sn_num_evento,
                                  cv_cod_modulo,
                                  sv_mens_retorno,
                                  cv_version,
                                  USER,
                                  'pv_orden_servicio_pg.PV_BAJA_REG_TARIF_PR',
                                  lv_ssql,
                                  sn_cod_retorno,
                                  lv_des_error
                                 );
   END pv_baja_reg_tarif_pr;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--obtenerGrupoNivelContratado
   PROCEDURE pv_obt_grupo_nivelcont_pr (
      so_servsuplabo_qt   IN OUT NOCOPY   ga_servsuplabo_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_OBTENER_CONVERT_ACTABO_PR "
            Lenguaje="PL/SQL"
            Fecha="09-08-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Alejandro Díaz, Elizabeth Vera"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  Actualiza Comentario Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="SO_IORSERV_QT    Tipo="Estructura de Type ">Estructura de Type    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error     ge_errores_pg.desevent;
      lv_ssql          ge_errores_pg.vquery;
      lv_cod_serv      icc_movimiento.cod_servicios%TYPE;
      lv_cod_servtmp   icc_movimiento.cod_servicios%TYPE;

      CURSOR cur_serv
      IS
         SELECT LPAD (TO_CHAR (cod_servsupl), 2, '00') || '0000'
           FROM ga_servsuplabo
          WHERE num_abonado = so_servsuplabo_qt.num_abonado
                AND ind_estado < 3;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_cod_serv := '';

      OPEN cur_serv;

      LOOP
         FETCH cur_serv
          INTO lv_cod_servtmp;

         EXIT WHEN cur_serv%NOTFOUND;
         lv_cod_serv := lv_cod_serv || lv_cod_servtmp;
      END LOOP;

      CLOSE cur_serv;

      so_servsuplabo_qt.grupo_nivel := lv_cod_serv;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 149;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_OBT_GRUPO_NIVELCONT_PR ('
            || so_servsuplabo_qt.num_abonado
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                            (sn_num_evento,
                             cv_cod_modulo,
                             sv_mens_retorno,
                             cv_version,
                             USER,
                             'pv_orden_servicio_pg.PV_OBT_GRUPO_NIVELCONT_PR',
                             lv_ssql,
                             sn_cod_retorno,
                             lv_des_error
                            );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_OBT_GRUPO_NIVELCONT_PR ('
            || so_servsuplabo_qt.num_abonado
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                            (sn_num_evento,
                             cv_cod_modulo,
                             sv_mens_retorno,
                             cv_version,
                             USER,
                             'pv_orden_servicio_pg.PV_OBT_GRUPO_NIVELCONT_PR',
                             lv_ssql,
                             sn_cod_retorno,
                             lv_des_error
                            );
   END pv_obt_grupo_nivelcont_pr;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_obtener_convert_actabo_pr (
      so_actabotiplan_qt   IN OUT NOCOPY   pv_actabo_tiplan_qt,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_OBTENER_CONVERT_ACTABO_PR "
            Lenguaje="PL/SQL"
            Fecha="09-08-2007"
            Versión="La del package"
            Dise+ador=""
            Programador="Alejandro Díaz"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  Actualiza Comentario Orden de Servicio   </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="SO_IORSERV_QT    Tipo="Estructura de Type ">Estructura de Type    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error    ge_errores_pg.desevent;
      lv_ssql         ge_errores_pg.vquery;
      lv_cod_actabo   VARCHAR2 (2);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql := ' SELECT COD_ACTABO';
      lv_ssql := lv_ssql || ' INTO  LV_COD_ACTABO';
      lv_ssql := lv_ssql || '  FROM PV_ACTABO_TIPLAN';
      lv_ssql :=
          lv_ssql || ' WHERE COD_TIPMODI = ' || so_actabotiplan_qt.cod_actabo;
      lv_ssql :=
         lv_ssql || '   AND   COD_TIPLAN  = '
         || so_actabotiplan_qt.cod_tiplan;

      SELECT cod_actabo
        INTO lv_cod_actabo
        FROM pv_actabo_tiplan
       WHERE cod_tipmodi = so_actabotiplan_qt.cod_actabo
         AND cod_tiplan = so_actabotiplan_qt.cod_tiplan;

      so_actabotiplan_qt.cod_actabo_hom := lv_cod_actabo;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         so_actabotiplan_qt.cod_actabo_hom := '';
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_OBTENER_CONVERT_ACTABO_PR('
            || so_actabotiplan_qt.cod_actabo
            || ','
            || so_actabotiplan_qt.cod_tiplan
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                         (sn_num_evento,
                          cv_cod_modulo,
                          sv_mens_retorno,
                          cv_version,
                          USER,
                          'pv_orden_servicio_pg.PV_OBTENER_CONVERT_ACTABO_PR',
                          lv_ssql,
                          sn_cod_retorno,
                          lv_des_error
                         );
   END pv_obtener_convert_actabo_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_registra_ooss_enlinea_pr (
      so_ooss_online    IN              ge_ooss_en_linea_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_REGISTRA_OOSS_ENLINEA_PR"
            Lenguaje="PL/SQL"
            Fecha="18-07-2007"
            Versión="1.0"
            Dise+ador="Marcelo Godoy'
            Programador="Marcelo Godoy"
            Ambiente Desarrollo="BD">
            <Retorno></Retorno>>
            <Descripción>Registra orden de servcio en linea</Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="GE_OOSS_EN_LINEA_QT" Tipo="estructura">estructura de plan tarifario</param>>
               </Entrada>
               <Salida>
               <param nom="SO_planTarif" Tipo="cursor">estructura de plan tarifario</param>>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error    ge_errores_pg.desevent;
      lv_ssql         ge_errores_pg.vquery;
      lv_fecha        DATE;
      lv_comentario   pv_iorserv.comentario%TYPE;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_comentario := NULL;
      lv_fecha := TO_DATE (so_ooss_online.fecha, 'DD-MM-YYYY HH24:MI:SS');
      lv_ssql :=
            'INSERT INTO ci_orserv (num_os, cod_os, producto, tip_inter, cod_inter, usuario, fecha, comentario, num_movimiento, cod_estado, cod_modulo, id_gestor)'
         || ' VALUES ('
         || so_ooss_online.num_os
         || ', '
         || so_ooss_online.cod_os
         || ', '
         || so_ooss_online.cod_producto
         || ', '
         || so_ooss_online.tip_inter
         || ', '
         || so_ooss_online.cod_inter
         || ', '
         || so_ooss_online.usuario
         || ', '
         || so_ooss_online.fecha
         || ', '
         || so_ooss_online.comentario
         || ', '
         || so_ooss_online.num_movimiento
         || ', '
         || so_ooss_online.cod_estado
         || ', '
         || so_ooss_online.cod_modulo
         || ', '
         || so_ooss_online.id_gestor
         || ')';

      INSERT INTO ci_orserv
                  (num_os, cod_os,
                   producto, tip_inter,
                   cod_inter, usuario,
                   fecha, comentario,
                   num_movimiento, cod_estado,
                   cod_modulo, id_gestor
                  )
           VALUES (so_ooss_online.num_os, so_ooss_online.cod_os,
                   so_ooss_online.cod_producto, so_ooss_online.tip_inter,
                   so_ooss_online.cod_inter, so_ooss_online.usuario,
                   lv_fecha, so_ooss_online.comentario,
                   so_ooss_online.num_movimiento, so_ooss_online.cod_estado,
                   so_ooss_online.cod_modulo, so_ooss_online.id_gestor
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_orden_servicio_pg.PV_REGISTRA_OOSS_ENLINEA_PR('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sv_mens_retorno,
                           cv_version,
                           USER,
                           'pv_orden_servicio_pg.PV_REGISTRA_OOSS_ENLINEA_PR',
                           lv_ssql,
                           sn_cod_retorno,
                           lv_des_error
                          );
   END pv_registra_ooss_enlinea_pr;

-----------------------------------------------------------------------------------------------
   PROCEDURE pv_insert_traspaso_cargo_pr (
      reg_pv_traspaso_cargos   IN              pv_trasp_cargos,
      sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento            OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_INSERT_TRASPASO_CARGO_PR"
            Lenguaje="PL/SQL"
            Fecha="11-09-2007"
            Versión="La del package"
            Dise+ador="Orlando Cabezas"
            Programador="Orlando Cabezas"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  RegistraCambPlanBatch                              </Descripción>>
               <Descripción>Metodo  :  Inserta Datos de cargos batch  </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="Reg_pv_traspaso_cargos   Tipo="Estructura de Registro ">Estructura de Registro con los Datos a Insertar    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_num_evento := 0;
      lv_ssql :=
            'INSERT INTO pv_traspaso_cargos VALUES '
         || reg_pv_traspaso_cargos.num_os
         || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.num_cargo || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.cod_concepto || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.fec_alta || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.imp_cargo || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.cod_moneda || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.cod_plancom || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.num_unidades || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.ind_factur || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.num_paquete || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.num_abonado || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.cod_ciclfact || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.mes_garantia || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.num_preguia || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.num_guia || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.num_factura || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.cod_concepto_dto || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.val_dto || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.tip_dto || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.ind_cuota || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.ind_supertel || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.ind_manual || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.nom_usuarora || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.cod_cliente || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.cod_producto || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.num_transaccion || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.num_venta || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.num_terminal || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.num_serie || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.cap_code || ', ';
      lv_ssql := lv_ssql || reg_pv_traspaso_cargos.num_seriemec || '  ';

      INSERT INTO pv_traspaso_cargos
                  (num_os,
                   num_cargo,
                   cod_concepto,
                   fec_alta,
                   imp_cargo,
                   cod_moneda,
                   cod_plancom,
                   num_unidades,
                   ind_factur,
                   num_paquete,
                   num_abonado,
                   cod_ciclfact,
                   mes_garantia,
                   num_preguia,
                   num_guia,
                   num_factura,
                   cod_concepto_dto,
                   val_dto,
                   tip_dto,
                   ind_cuota,
                   ind_supertel,
                   ind_manual,
                   nom_usuarora,
                   cod_cliente,
                   cod_producto,
                   num_transaccion,
                   num_venta,
                   num_terminal,
                   num_serie,
                   cap_code,
                   num_seriemec
                  )
           VALUES (reg_pv_traspaso_cargos.num_os,
                   reg_pv_traspaso_cargos.num_cargo,
                   reg_pv_traspaso_cargos.cod_concepto,
                   reg_pv_traspaso_cargos.fec_alta,
                   TO_NUMBER (reg_pv_traspaso_cargos.imp_cargo),
                   reg_pv_traspaso_cargos.cod_moneda,
                   reg_pv_traspaso_cargos.cod_plancom,
                   reg_pv_traspaso_cargos.num_unidades,
                   reg_pv_traspaso_cargos.ind_factur,
                   reg_pv_traspaso_cargos.num_paquete,
                   reg_pv_traspaso_cargos.num_abonado,
                   reg_pv_traspaso_cargos.cod_ciclfact,
                   reg_pv_traspaso_cargos.mes_garantia,
                   reg_pv_traspaso_cargos.num_preguia,
                   reg_pv_traspaso_cargos.num_guia,
                   reg_pv_traspaso_cargos.num_factura,
                   reg_pv_traspaso_cargos.cod_concepto_dto,
                   TO_NUMBER (reg_pv_traspaso_cargos.val_dto),
                   reg_pv_traspaso_cargos.tip_dto,
                   reg_pv_traspaso_cargos.ind_cuota,
                   reg_pv_traspaso_cargos.ind_supertel,
                   reg_pv_traspaso_cargos.ind_manual,
                   NVL (reg_pv_traspaso_cargos.nom_usuarora, USER),
                                                             --PAGC 19-05-2007
                   reg_pv_traspaso_cargos.cod_cliente,
                   reg_pv_traspaso_cargos.cod_producto,
                   reg_pv_traspaso_cargos.num_transaccion,
                   reg_pv_traspaso_cargos.num_venta,
                   reg_pv_traspaso_cargos.num_terminal,
                   reg_pv_traspaso_cargos.num_serie,
                   reg_pv_traspaso_cargos.cap_code,
                   reg_pv_traspaso_cargos.num_seriemec
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_INSERT_TRASPASO_CARGO_PR('
            || reg_pv_traspaso_cargos.num_os
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sv_mens_retorno,
                           cv_version,
                           USER,
                           'pv_orden_servicio_pg.PV_INSERT_TRASPASO_CARGO_PR',
                           lv_ssql,
                           sn_cod_retorno,
                           lv_des_error
                          );
   END pv_insert_traspaso_cargo_pr;

-------------------------------------------------------------------------------------------------------
   FUNCTION pv_vtipcomis_fn (
      eo_abonado        IN              ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN VARCHAR2
   IS
/*
   <Documentación
     TipoDoc = "FUNCION">>
      <Elemento
         Nombre = "PV_vTipComis_fn"
         Lenguaje="PL/SQL"
         Fecha="11-09-2007"
         Versión="La del package"
         Dise+ador="Orlando Cabezas"
         Programador="  "
         Ambiente Desarrollo="BD">
         <Retorno>VARCHAR2</Retorno>>
         <Descripción></Descripción>>
         <Par+metros>
            <Entrada>
               <param nom="EO_ABONADO" Tipo="Estructura">Datos del Abonado</param>>
               </Entrada>
            <Salida>
               <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
               <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
               <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
         </Par+metros>
      </Elemento>
   </Documentación>
   */
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      ln_tipcomis    ve_tipcomis.ind_vta_externa%TYPE;
      lv_tipcomis    ga_ventas.cod_tipcomis%TYPE;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_num_evento := 0;
      lv_ssql := 'SELECT COD_TIPCOMIS';
      lv_ssql := lv_ssql || ' FROM GA_VENTAS';
      lv_ssql := lv_ssql || ' WHERE NUM_VENTA =' || eo_abonado.num_venta;

      SELECT cod_tipcomis
        INTO lv_tipcomis
        FROM ga_ventas
       WHERE num_venta = eo_abonado.num_venta;

      lv_ssql := 'SELECT ind_vta_externa';
      lv_ssql := lv_ssql || 'FROM ve_tipcomis';
      lv_ssql := lv_ssql || ' WHERE cod_tipcomis = ' || lv_tipcomis;

      SELECT ind_vta_externa
        INTO ln_tipcomis
        FROM ve_tipcomis
       WHERE cod_tipcomis = lv_tipcomis;

      RETURN TO_CHAR (ln_tipcomis);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN '0';
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_vTipComis_fn (' || eo_abonado.num_venta || '); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                  (sn_num_evento,
                                   cv_cod_modulo,
                                   sv_mens_retorno,
                                   cv_version,
                                   USER,
                                   'PV_REG_MOVCCONTRALADA_PG.PV_vTipComis_fn',
                                   lv_ssql,
                                   sn_cod_retorno,
                                   lv_des_error
                                  );
         RETURN '0';
   END pv_vtipcomis_fn;

------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_sgenmovi_fn (
      eo_abonado        IN              ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN VARCHAR2
   IS
/*
   <Documentación
     TipoDoc = "FUNCION">>
      <Elemento
         Nombre = "PV_sGenMovi_FN"
         Lenguaje="PL/SQL"
         Fecha="11-09-2007"
         Versión="La del package"
         Dise+ador="Orlando Cabezas"
         Programador="  "
         Ambiente Desarrollo="BD">
         <Retorno>VARCHAR2</Retorno>>
         <Descripción></Descripción>>
         <Par+metros>
            <Entrada>
               <param nom="EO_ABONADO" Tipo="number">Datos del Abonado</param>>
               </Entrada>
            <Salida>
               <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
               <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
               <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
         </Par+metros>
      </Elemento>
   </Documentación>
   */
      lv_retorno          VARCHAR2 (1);
      lv_snum_serie       ga_abocel.num_serie%TYPE;
      lv_num_serie        ga_abocel.num_serie%TYPE;
      lv_num_imei         ga_abocel.num_imei%TYPE;
      lv_cod_tecnologia   ga_abocel.cod_tecnologia%TYPE;
      lv_stec             ged_parametros.val_parametro%TYPE;
      lv_numserieabo      ga_abocel.num_serie%TYPE;
      lv_ind_procequi     ga_equipaboser.ind_procequi%TYPE;
      lv_cod_articulo     ga_equipaboser.cod_articulo%TYPE;
      lv_indprocequi      al_series.ind_telefono%TYPE;
      lv_ssql             ge_errores_pg.vquery;
      lv_des_error        ge_errores_pg.desevent;
      lv_parametros       VARCHAR2 (500);
      v_bactestmovim      BOOLEAN;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_num_evento := 0;
      lv_retorno := '';
      lv_ssql := 'SELECT NUM_SERIE, NUM_IMEI, COD_TECNOLOGIA';
      lv_ssql := lv_ssql || ' FROM GA_ABOCEL';
      lv_ssql := lv_ssql || ' WHERE NUM_ABONADO =' || eo_abonado.num_abonado;

      SELECT num_serie, num_imei, cod_tecnologia
        INTO lv_num_serie, lv_num_imei, lv_cod_tecnologia
        FROM ga_abocel
       WHERE num_abonado = eo_abonado.num_abonado;

      lv_ssql := 'SELECT VAL_PARAMETRO';
      lv_ssql := lv_ssql || ' FROM ged_parametros';
      lv_ssql := lv_ssql || ' WHERE NOM_PARAMETRO = ''TECNOLOGIA_GSM'' ';
      lv_ssql := lv_ssql || 'AND COD_MODULO = ''GA'' ';

      SELECT val_parametro
        INTO lv_stec
        FROM ged_parametros
       WHERE nom_parametro = 'TECNOLOGIA_GSM' AND cod_modulo = 'GA';

      IF lv_cod_tecnologia = lv_stec
      THEN
         lv_snum_serie := lv_num_imei;
      ELSE
         lv_snum_serie := lv_num_serie;
      END IF;

      lv_numserieabo := lv_num_serie;
      lv_ssql := 'SELECT IND_PROCEQUI, NUM_SERIE, COD_ARTICULO';
      lv_ssql := lv_ssql || '  FROM GA_EQUIPABOSER';
      lv_ssql := lv_ssql || ' WHERE NUM_ABONADO =' || eo_abonado.num_abonado;
      lv_ssql := lv_ssql || ' AND NUM_SERIE = Lv_NUM_SERIE ';
      lv_ssql :=
            lv_ssql
         || '  AND FEC_ALTA = (SELECT MAX(FEC_ALTA) FROM GA_EQUIPABOSER WHERE NUM_ABONADO ='
         || eo_abonado.num_abonado
         || '   AND NUM_SERIE = Lv_NUM_SERIE) ';

      SELECT ind_procequi, num_serie, cod_articulo
        INTO lv_ind_procequi, lv_num_serie, lv_cod_articulo
        FROM ga_equipaboser
       WHERE num_abonado = eo_abonado.num_abonado
         AND num_serie = lv_num_serie
         AND fec_alta =
                (SELECT MAX (fec_alta)
                   FROM ga_equipaboser
                  WHERE num_abonado = eo_abonado.num_abonado
                    AND num_serie = lv_num_serie);

      IF lv_ind_procequi = 'E'
      THEN                                    --procedencia del equipo Externa
         lv_retorno := lv_ind_procequi;
      ELSE
         lv_retorno := lv_ind_procequi;
         lv_ssql := 'SELECT ind_telefono';
         lv_ssql := lv_ssql || '  FROM AL_SERIES';
         lv_ssql := lv_ssql || ' WHERE NUM_SERIE = Lv_NumSerieAbo';
         lv_ssql := lv_ssql || '  AND NUM_TELEFONO IS NOT NULL ';
         lv_ssql := lv_ssql || '  AND NUM_TELEFONO > 0 ';
         lv_ssql :=
               lv_ssql
            || '  AND IND_TELEFONO <> (SELECT VAL_PARAMETRO  FROM GED_PARAMETROS WHERE COD_MODULO = ''GE''   AND COD_PRODUCTO = 1  AND NOM_PARAMETRO = ''IND_TEL_OUT'')';

         SELECT ind_telefono
           INTO lv_indprocequi
           FROM al_series
          WHERE num_serie = lv_numserieabo
            AND num_telefono IS NOT NULL
            AND num_telefono > 0
            AND ind_telefono <>
                   (SELECT val_parametro
                      FROM ged_parametros
                     WHERE cod_modulo = 'GE'
                       AND cod_producto = 1
                       AND nom_parametro = 'IND_TEL_OUT');

         IF lv_indprocequi = '' OR lv_indprocequi IS NULL
         THEN
            lv_ssql := '';
            lv_ssql := 'SELECT ind_telefono';
            lv_ssql := lv_ssql || '  FROM  AL_COMPONENTE_KIT';
            lv_ssql := lv_ssql || ' WHERE NUM_SERIE = Lv_NumSerieAbo';
            lv_ssql := lv_ssql || '  AND NUM_TELEFONO IS NOT NULL ';
            lv_ssql := lv_ssql || '  AND NUM_TELEFONO > 0 ';
            lv_ssql :=
                  lv_ssql
               || '  AND IND_TELEFONO <> (SELECT VAL_PARAMETRO  FROM GED_PARAMETROS WHERE COD_MODULO = ''GE''   AND COD_PRODUCTO = 1  AND NOM_PARAMETRO = ''IND_TEL_OUT'')';

            SELECT ind_telefono
              INTO lv_indprocequi
              FROM al_componente_kit
             WHERE num_serie = lv_numserieabo
               AND num_telefono IS NOT NULL
               AND num_telefono > 0
               AND ind_telefono <>
                      (SELECT val_parametro
                         FROM ged_parametros
                        WHERE cod_modulo = 'GE'
                          AND cod_producto = 1
                          AND nom_parametro = 'IND_TEL_OUT');
         END IF;

         IF (lv_indprocequi = '1') OR (lv_indprocequi = '6')
         THEN
            v_bactestmovim := FALSE;
         ELSIF    (lv_indprocequi = '4')
               OR (lv_indprocequi = '5')
               OR (lv_indprocequi = '7')
         THEN
            v_bactestmovim := TRUE;
         END IF;
      END IF;

      RETURN lv_retorno;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
              'PV_sGenMovi_FN (' || eo_abonado.num_abonado || '); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    cv_cod_modulo,
                                    sv_mens_retorno,
                                    cv_version,
                                    USER,
                                    'PV_REG_MOVCCONTRALADA_PG.PV_sGenMovi_FN',
                                    lv_ssql,
                                    sn_cod_retorno,
                                    lv_des_error
                                   );
         RETURN ' ';
   END pv_sgenmovi_fn;

------------------------------------------------------------------------------------------------------
   PROCEDURE pv_bregvalccontrolada_pr (
      eo_abonado        IN OUT          ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
/*
   <Documentación
     TipoDoc = "PROCEDURE">>
      <Elemento
         Nombre = "PV_bRegValCControlada_PR"
         Lenguaje="PL/SQL"
         Fecha="11-09-2007"
         Versión="La del package"
         Dise+ador="Orlando Cabezas"
         Programador="  "
         Ambiente Desarrollo="BD">
         <Retorno>BOOLEAN</Retorno>>
         <Descripción></Descripción>>
         <Par+metros>
            <Entrada>
               <param nom="EO_COD_ACTABO" Tipo="varchar">Código Actabo</param>>
             <param nom="EO_NUM_ABONADO" Tipo="number">Numero Abonado</param>>
              <param nom="EO_NUM_SERIE" Tipo="number">Numero de serie</param>>
               <param nom="EO_TipMov" Tipo="varchar">Tipo Movimiento</param>>
            </Entrada>
            <Salida>
               <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
               <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
            </Salida>
         </Par+metros>
      </Elemento>
   </Documentación>
   */
      lv_des_error           ge_errores_pg.desevent;
      lv_parametros          VARCHAR2 (500);
      lv_ssql                ge_errores_pg.vquery;
      lv_codusoamistar       ged_parametros.val_parametro%TYPE;
      lv_codtipplanprepago   ged_parametros.val_parametro%TYPE;
      ln_cod_uso             ga_abocel.cod_uso%TYPE;
      ln_codusoamistar       ga_abocel.cod_uso%TYPE;
      ln_num_celular         ga_abocel.num_celular%TYPE;
      lv_cod_plantarif       ga_abocel.cod_plantarif%TYPE;
      lv_tip_terminal        ga_abocel.tip_terminal%TYPE;
      ld_fec_alta            ga_abocel.fec_alta%TYPE;
      ln_cod_ciclo           ga_abocel.cod_ciclo%TYPE;
      lv_num_serie           ga_abocel.num_serie%TYPE;
      ln_cod_cliente         ga_abocel.cod_cliente%TYPE;
      ln_num_venta           ga_abocel.num_venta%TYPE;
      lv_scodtiplan          ta_plantarif.cod_tiplan%TYPE;
      ln_nsaldoamistar       NUMBER;
      ld_dfec_alta           DATE;
      lv_splan               ta_plantarif.cod_plan_comverse%TYPE;
      lv_scodoficina         ga_ventas.cod_oficina%TYPE;
      ln_scargacel           al_series.carga%TYPE;
      ln_nvalor              ta_cargosbasico.imp_cargobasico%TYPE;
      ln_cod_categoria       ve_catplantarif.cod_categoria%TYPE;
      lv_codcatctasegant     ged_parametros.val_parametro%TYPE;
      ln_dia_periodo         fa_ciclfact.dia_periodo%TYPE;
      ld_fec_desdellam       fa_ciclfact.fec_desdellam%TYPE;
      ld_fec_hastallam       fa_ciclfact.fec_hastallam%TYPE;
      ln_nnumtransac         NUMBER;
      ln_scod_concepto       fa_datosgener.cod_abonocel%TYPE;
      ln_scod_tipconce       fa_conceptos.cod_tipconce%TYPE;
      ln_cod_catimpos        ge_catimpclientes.cod_catimpos%TYPE;
      ln_nimpuesto           NUMBER;
      ln_cod_kit             al_componente_kit.cod_kit%TYPE;
      ln_cod_articulo        al_componente_kit.cod_articulo%TYPE;
      ln_carga               al_componente_kit.carga%TYPE;
      ln_ind_telefono        al_componente_kit.ind_telefono%TYPE;
      ln_cargacel            ga_plantillas_kit.carga_inicial%TYPE;
      lv_concargakit         VARCHAR2 (1)                           := '0';
      lb_es_kit              BOOLEAN;
      ln_nummovimiento       icc_movimiento.num_movimiento%TYPE;
      lv_actabomovim         icc_movimiento.cod_actabo%TYPE;
      ln_num_movimiento      icc_movimiento.num_movimiento%TYPE;
      lv_proseq              VARCHAR2 (1);
      lb_dealer              BOOLEAN;
      lv_actabo              VARCHAR2 (2);
      ln_tipmov              NUMBER;
      lv_proc                VARCHAR2 (50);
      lv_cod_prorrateo       VARCHAR2 (1);
      lv_squery              VARCHAR2 (5000);
      v_serror               VARCHAR2 (1);
      v_smess                VARCHAR2 (200);
      v_bactestmovim         BOOLEAN;
      error_retorno          EXCEPTION;
      error_retorno_ok       EXCEPTION;
      error_retorno_i        EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_num_evento := 0;
      ln_tipmov := eo_abonado.tipmov;
      lv_num_serie := eo_abonado.num_serie;
      lv_ssql := '';
      lv_ssql := 'SELECT VAL_PARAMETRO';
      lv_ssql := lv_ssql || 'FROM GED_PARAMETROS';
      lv_ssql := lv_ssql || 'WHERE NOM_PARAMETRO = ''USO_PREPAGO'' ';
      lv_ssql := lv_ssql || 'AND COD_MODULO = ''GA'' ';
      lv_ssql := lv_ssql || 'AND COD_PRODUCTO = 1';

      SELECT val_parametro
        INTO ln_codusoamistar
        FROM ged_parametros
       WHERE nom_parametro = 'USO_PREPAGO'
         AND cod_modulo = 'GA'
         AND cod_producto = 1;

      lv_ssql := '';
      lv_ssql := 'SELECT VAL_PARAMETRO';
      lv_ssql := lv_ssql || 'FROM GED_PARAMETROS';
      lv_ssql := lv_ssql || 'WHERE NOM_PARAMETRO = ''TIP_PLAN_PREPAGO'' ';
      lv_ssql := lv_ssql || 'AND COD_MODULO = ''GA'' ';
      lv_ssql := lv_ssql || 'AND COD_PRODUCTO = 1';

      SELECT val_parametro
        INTO lv_codtipplanprepago
        FROM ged_parametros
       WHERE nom_parametro = 'TIP_PLAN_PREPAGO'
         AND cod_modulo = 'GA'
         AND cod_producto = 1;

      lv_ssql := '';
      lv_ssql :=
         'SELECT COD_USO, NUM_CELULAR, COD_PLANTARIF, TIP_TERMINAL,FEC_ALTA, 0, NUM_SERIE, COD_CLIENTE, NUM_VENTA';
      lv_ssql := lv_ssql || ' FROM GA_ABOAMIST';
      lv_ssql := lv_ssql || ' WHERE NUM_ABONADO =' || eo_abonado.num_abonado;
      lv_ssql := lv_ssql || 'UNION';
      lv_ssql :=
            lv_ssql
         || 'SELECT COD_USO, NUM_CELULAR, COD_PLANTARIF, TIP_TERMINAL,FEC_ALTA,COD_CICLO, NUM_SERIE, COD_CLIENTE, NUM_VENTA';
      lv_ssql := lv_ssql || 'FROM GA_ABOCEL';
      lv_ssql := lv_ssql || 'WHERE NUM_ABONADO =' || eo_abonado.num_abonado;

      SELECT cod_uso, num_celular, cod_plantarif, tip_terminal,
             fec_alta, 0, num_serie, cod_cliente,
             num_venta
        INTO ln_cod_uso, ln_num_celular, lv_cod_plantarif, lv_tip_terminal,
             ld_fec_alta, ln_cod_ciclo, lv_num_serie, ln_cod_cliente,
             ln_num_venta
        FROM ga_aboamist
       WHERE num_abonado = eo_abonado.num_abonado
      UNION
      SELECT cod_uso, num_celular, cod_plantarif, tip_terminal, fec_alta,
             cod_ciclo, num_serie, cod_cliente, num_venta
        FROM ga_abocel
       WHERE num_abonado = eo_abonado.num_abonado;

      --USO_SEGURA= "10"
      --USO_SEGURA_CTC = "15"
      IF    ln_cod_uso IS NULL
         OR (    ln_cod_uso <> '10'
             AND ln_cod_uso <> '15'
             AND ln_cod_uso <> ln_codusoamistar
            )
      THEN
         v_serror := '0';
         v_smess := '';
         RAISE error_retorno_ok;
      END IF;

      lv_ssql := 'SELECT COD_TIPLAN';
      lv_ssql := lv_ssql || ' FROM TA_PLANTARIF';
      lv_ssql := lv_ssql || ' WHERE COD_PLANTARIF = ' || lv_cod_plantarif;

      SELECT cod_tiplan
        INTO lv_scodtiplan
        FROM ta_plantarif
       WHERE cod_plantarif = lv_cod_plantarif;

      --este valor es opcional y para este proceso queda en cero
      ln_nsaldoamistar := 0;

      IF lv_scodtiplan = lv_codtipplanprepago
      THEN
         ln_nsaldoamistar := 0;
      ELSIF ln_nsaldoamistar < 0
      THEN
         ln_nsaldoamistar := 0;
      END IF;

      IF ln_cod_uso = '10'
      THEN
         lv_ssql := 'SELECT SYSDATE FROM DUAL';

         SELECT SYSDATE
           INTO ld_dfec_alta
           FROM DUAL;
      END IF;

      lv_ssql :=
         'SELECT DECODE(COD_PLAN_COMVERSE, NULL, COD_PLANTARIF,COD_PLAN_COMVERSE)';
      lv_ssql := lv_ssql || ' FROM TA_PLANTARIF';
      lv_ssql := lv_ssql || ' WHERE COD_PLANTARIF = ' || lv_cod_plantarif;
      lv_ssql := lv_ssql || '  AND COD_PRODUCTO = ' || cn_cod_prod;

      SELECT DECODE (cod_plan_comverse,
                     NULL, cod_plantarif,
                     cod_plan_comverse
                    )
        INTO lv_splan
        FROM ta_plantarif
       WHERE cod_plantarif = lv_cod_plantarif AND cod_producto = cn_cod_prod;

      lv_ssql := '';
      lv_ssql := 'SELECT COD_OFICINA';
      lv_ssql := lv_ssql || ' FROM GA_VENTAS';
      lv_ssql := lv_ssql || ' WHERE NUM_VENTA = ' || ln_num_venta;

      SELECT cod_oficina
        INTO lv_scodoficina
        FROM ga_ventas
       WHERE num_venta = ln_num_venta;

      lv_ssql := '';
      lv_ssql := 'SELECT NVL(CARGA,0)';
      lv_ssql := lv_ssql || ' FROM AL_SERIES';
      lv_ssql := lv_ssql || ' WHERE NUM_SERIE = ' || lv_num_serie;

      SELECT NVL (carga, 0)
        INTO ln_scargacel
        FROM al_series
       WHERE num_serie = lv_num_serie;

      lv_proseq :=
         pv_sgenmovi_fn (eo_abonado,
                         sn_cod_retorno,
                         sv_mens_retorno,
                         sn_num_evento
                        );

      IF     (eo_abonado.tipmov = 1 OR eo_abonado.tipmov = 4)
         AND (lv_scodtiplan <> lv_codtipplanprepago)
      THEN
         BEGIN
            --Lee el IMP_CARGO de TA_CARGOSBASICO.
            lv_ssql := '';
            lv_ssql := 'SELECT A.IMP_CARGOBASICO';
            lv_ssql := lv_ssql || '  FROM TA_CARGOSBASICO A, TA_PLANTARIF B ';
            lv_ssql :=
                    lv_ssql || '   WHERE B.COD_PLANTARIF = Lv_COD_PLANTARIF ';
            lv_ssql :=
                    lv_ssql || '   AND A.COD_CARGOBASICO = B.COD_CARGOBASICO';
            lv_ssql := lv_ssql || '  AND A.COD_PRODUCTO = ' || cn_cod_prod;
            lv_ssql :=
                  lv_ssql
               || '  AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) ';

            SELECT a.imp_cargobasico
              INTO ln_nvalor
              FROM ta_cargosbasico a, ta_plantarif b
             WHERE b.cod_plantarif = lv_cod_plantarif
               AND a.cod_cargobasico = b.cod_cargobasico
               AND a.cod_producto = cn_cod_prod
               AND SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE);
         EXCEPTION
            WHEN OTHERS
            THEN
               ln_nvalor := NULL;
         END;

         IF ln_nvalor IS NULL
         THEN
            v_serror := '0';
            v_smess := '';
            RAISE error_retorno_i;
         END IF;

         --Para Cuenta Segura
         lv_ssql := '';
         lv_ssql := ' SELECT COD_CATEGORIA';
         lv_ssql := lv_ssql || '  FROM VE_CATPLANTARIF ';
         lv_ssql := lv_ssql || '   WHERE COD_PRODUCTO = ' || cn_cod_prod;
         lv_ssql := lv_ssql || '   AND COD_PLANTARIF = ' || lv_cod_plantarif;

         SELECT cod_categoria
           INTO ln_cod_categoria
           FROM ve_catplantarif
          WHERE cod_producto = cn_cod_prod
                AND cod_plantarif = lv_cod_plantarif;

         lv_ssql := ' SELECT VAL_PARAMETRO';
         lv_ssql := lv_ssql || '  FROM GED_PARAMETROS ';
         lv_ssql :=
                lv_ssql || '   WHERE NOM_PARAMETRO = ''COD_CAT_CTA_SEG_ANT'' ';

         SELECT val_parametro
           INTO lv_codcatctasegant
           FROM ged_parametros
          WHERE nom_parametro = 'COD_CAT_CTA_SEG_ANT';

         IF lv_codcatctasegant <> ln_cod_categoria
         THEN
            --USO_SEGURA = "10"
            IF ln_cod_uso = '10'
            THEN
               BEGIN
                  --Es Cuenta Segura y se calcula Proporcionalidad
                  lv_ssql :=
                          'SELECT DIA_PERIODO, FEC_DESDELLAM, FEC_HASTALLAM ';
                  lv_ssql := lv_ssql || ' FROM FA_CICLFACT ';
                  lv_ssql := lv_ssql || '  WHERE COD_CICLO = Ln_COD_CICLO ';
                  lv_ssql :=
                        lv_ssql
                     || '   AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM ';

                  SELECT dia_periodo, fec_desdellam, fec_hastallam
                    INTO ln_dia_periodo, ld_fec_desdellam, ld_fec_hastallam
                    FROM fa_ciclfact
                   WHERE cod_ciclo = ln_cod_ciclo
                     AND SYSDATE BETWEEN fec_desdellam AND fec_hastallam;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     ln_dia_periodo := NULL;
               END;

               BEGIN
                  lv_ssql := 'SELECT TRIM(VAL_PARAMETRO) ';
                  lv_ssql :=
                        lv_ssql
                     || '  FROM GED_PARAMETROS WHERE NOM_PARAMETRO = ''OPER_CARG_PRORRATEAB'' ';

                  SELECT TRIM (val_parametro)
                    INTO lv_cod_prorrateo
                    FROM ged_parametros
                   WHERE nom_parametro = 'OPER_CARG_PRORRATEAB';
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     lv_cod_prorrateo := '0';
               END;

               IF ln_dia_periodo IS NOT NULL AND lv_cod_prorrateo = '1'
               THEN
                  ln_nvalor :=
                     (  ln_nvalor
                      * (ld_fec_hastallam - ld_dfec_alta + 1)
                      / ln_dia_periodo
                     );
               END IF;
            END IF;
         END IF;
      END IF;

      SELECT fas_presuptemp.NEXTVAL
        INTO ln_nnumtransac
        FROM DUAL;

      lv_ssql := 'SELECT COD_ABONOCEL ';
      lv_ssql := lv_ssql || ' FROM FA_DATOSGENER ';

      SELECT cod_abonocel
        INTO ln_scod_concepto
        FROM fa_datosgener;

      lv_ssql := ' SELECT A.COD_TIPCONCE ';
      lv_ssql := lv_ssql || ' FROM FA_CONCEPTOS A, FA_DATOSGENER B ';
      lv_ssql := lv_ssql || ' WHERE A.COD_CONCEPTO = B.COD_ABONOCEL';

      SELECT a.cod_tipconce
        INTO ln_scod_tipconce
        FROM fa_conceptos a, fa_datosgener b
       WHERE a.cod_concepto = b.cod_abonocel;

      lv_ssql := 'INSERT INTO FAT_PRESUPTEMP ';
      lv_ssql :=
            lv_ssql
         || ' (NUM_PROCESO,COD_CONCEPTO,COLUMNA,COD_CLIENTE,FEC_EFECTIVIDAD,IMP_CONCEPTO,IMP_FACTURABLE,COD_TIPCONCE)';
      lv_ssql :=
            lv_ssql
         || ' VALUES ('
         || ln_nnumtransac
         || ','
         || ln_scod_concepto
         || ',1,'
         || ln_cod_cliente
         || ', SYSDATE, '
         || ln_nvalor
         || ','
         || ln_nvalor
         || ','
         || ln_scod_tipconce
         || ')';

      INSERT INTO fat_presuptemp
                  (num_proceso, cod_concepto, columna, cod_cliente,
                   fec_efectividad, imp_concepto, imp_facturable, cod_tipconce
                  )
           VALUES (ln_nnumtransac, ln_scod_concepto, 1, ln_cod_cliente,
                   SYSDATE, ln_nvalor, ln_nvalor, ln_scod_tipconce
                  );

      lv_ssql := '';
      lv_ssql := '  SELECT cod_catimpos ';
      lv_ssql := lv_ssql || ' FROM ge_catimpclientes';
      lv_ssql := lv_ssql || ' WHERE cod_cliente = ' || ln_cod_cliente;
      lv_ssql := lv_ssql || '  AND SYSDATE BETWEEN fec_desde AND fec_hasta';

      SELECT cod_catimpos
        INTO ln_cod_catimpos
        FROM ge_catimpclientes
       WHERE cod_cliente = ln_cod_cliente
         AND SYSDATE BETWEEN fec_desde AND fec_hasta;

      v_serror := '';
      fa_proc_imptos (ln_nnumtransac,
                      ln_cod_catimpos,
                      lv_scodoficina,
                      lv_proc,
                      lv_proc,
                      lv_proc,
                      lv_proc,
                      v_serror,
                      v_smess
                     );

      IF v_serror <> ''
      THEN
         RAISE error_retorno_i;
      END IF;

      --RECUPERAMOS EL IMPUESTO ASOCIADO AL VALOR
      lv_ssql := '';
      lv_ssql := '  SELECT SUM(IMP_FACTURABLE) ';
      lv_ssql := lv_ssql || ' FROM FAT_PRESUPTEMP';
      lv_ssql := lv_ssql || ' WHERE NUM_PROCESO = ' || ln_nnumtransac;
      lv_ssql := lv_ssql || '  AND COD_TIPCONCE = ''1'' ';
      lv_ssql := lv_ssql || '  GROUP BY COD_CONCEREL ';

      SELECT   SUM (imp_facturable)
          INTO ln_nimpuesto
          FROM fat_presuptemp
         WHERE num_proceso = ln_nnumtransac AND cod_tipconce = '1'
      GROUP BY cod_concerel;

      ln_nvalor := ln_nvalor + ln_nimpuesto;
      eo_abonado.num_venta := ln_num_venta;

      IF pv_vtipcomis_fn (eo_abonado,
                          sn_cod_retorno,
                          sv_mens_retorno,
                          sn_num_evento
                         ) = '1'
      THEN
         lb_dealer := TRUE;
      ELSE
         lb_dealer := FALSE;
      END IF;

      --Genera Comando
      IF eo_abonado.tipmov = 1
      THEN
         lv_actabo := eo_abonado.cod_actabo;

         IF ln_cod_uso = ln_codusoamistar
         THEN                                                    --Es Amistar
            IF lv_proseq = 'I'
            THEN                                    --si el equipo es interno
               BEGIN
                  --Si es Kit, debo sacar la carga asociada
                  lv_ssql := '';
                  lv_ssql :=
                     ' SELECT COD_KIT, COD_ARTICULO, NVL(CARGA, 0), IND_TELEFONO ';
                  lv_ssql := lv_ssql || '  FROM AL_COMPONENTE_KIT';
                  lv_ssql := lv_ssql || ' WHERE NUM_SERIE = ' || lv_num_serie;

                  SELECT cod_kit, cod_articulo, NVL (carga, 0),
                         ind_telefono
                    INTO ln_cod_kit, ln_cod_articulo, ln_carga,
                         ln_ind_telefono
                    FROM al_componente_kit
                   WHERE num_serie = lv_num_serie;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     ln_cod_kit := NULL;
               END;

               IF ln_cod_kit IS NOT NULL
               THEN
                  lb_es_kit := TRUE;

                  IF     ln_cod_kit <> ''
                     AND ln_cod_articulo <> ''
                     AND ln_carga <= 0
                  THEN
                     BEGIN
                        --Solo aplicable a MPR
                        lv_ssql := '';
                        lv_ssql := ' SELECT NVL(CARGA_INICIAL,0) ';
                        lv_ssql := lv_ssql || '  FROM GA_PLANTILLAS_KIT';
                        lv_ssql :=
                                lv_ssql || '  WHERE COD_KIT = ' || ln_cod_kit;
                        lv_ssql :=
                              lv_ssql
                           || '  AND COD_ARTICULO = '
                           || ln_cod_articulo;
                        lv_ssql :=
                              lv_ssql
                           || '  AND SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO ';

                        SELECT NVL (carga_inicial, 0)
                          INTO ln_cargacel
                          FROM ga_plantillas_kit
                         WHERE cod_kit = ln_cod_kit
                           AND cod_articulo = ln_cod_articulo
                           AND SYSDATE BETWEEN fec_inicio AND fec_termino;
                     EXCEPTION
                        WHEN OTHERS
                        THEN
                           ln_cargacel := NULL;
                     END;

                     IF ln_cargacel IS NULL
                     THEN
                        ln_cargacel := 0;
                     END IF;

                     lv_concargakit := '1';
                  ELSE
                     ln_scargacel := ln_carga;
                  END IF;
               END IF;
            END IF;
         END IF;
      ELSIF ln_tipmov = 2
      THEN
         lv_actabo := 'BP';
      ELSIF ln_tipmov = 3
      THEN
         lv_actabo := 'MP';
      ELSIF ln_tipmov = 4
      THEN
         lv_actabo := 'AM';
         ln_tipmov := 1;
      END IF;

      IF ln_tipmov = 1 OR ln_tipmov = 1
      THEN
         lv_ssql := '';
         lv_ssql := ' SELECT NUM_MOVIMIENTO, COD_ACTABO ';
         lv_ssql := lv_ssql || '   FROM ICC_MOVIMIENTO ';
         lv_ssql := lv_ssql || '  WHERE NUM_CELULAR = ' || ln_num_celular;
         lv_ssql := lv_ssql || '  AND COD_ACTABO = ' || lv_actabo;

         SELECT num_movimiento, cod_actabo
           INTO ln_nummovimiento, lv_actabomovim
           FROM icc_movimiento
          WHERE num_celular = ln_num_celular AND cod_actabo = lv_actabo;

         IF lv_proseq = 'E'
         THEN                                                     --Es externo
            IF ln_nummovimiento = ''
            THEN
               v_serror := '1';
               v_smess := 'Error al recuperar Movimiento en Central.';
               RAISE error_retorno_i;
            END IF;

            lv_squery := 'UPDATE ICC_MOVIMIENTO';
            lv_squery := lv_squery || 'SET PLAN = ' || lv_splan;

            IF (ln_cod_uso = '10') OR (ln_cod_uso = '15')
            THEN                                               --Cuenta Segura
               lv_squery := lv_squery || ', VALOR_PLAN = ' || ln_nvalor;
            ELSIF ln_cod_uso = '3'
            THEN
               lv_squery := lv_squery || ', CARGA = ' || ln_scargacel;
            END IF;

            lv_squery :=
                   lv_squery || ' WHERE NUM_MOVIMIENTO = ' || ln_nummovimiento;

            BEGIN
               EXECUTE IMMEDIATE lv_squery;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_serror := SQLCODE;
                  v_smess :=
                       'ICC_MOVIMIENTO 1 PKG  bRegMovCControlada ' || SQLERRM;
                  RAISE error_retorno_i;
            END;
         ELSE                                                     --Es interno
            IF lv_concargakit = '1'
            THEN                                       --Solo aplicable a MPR
               lv_squery := 'UPDATE ICC_MOVIMIENTO ';
               lv_squery := lv_squery || ' SET CARGA = ' || ln_scargacel;
               lv_squery := lv_squery || ', PLAN = ' || lv_splan;

               IF ln_cargacel > 0 AND ln_ind_telefono = '6'
               THEN
                  lv_squery :=
                     lv_squery || ', COD_ACTABO = "VD", COD_ACTUACION = 300 ';
               END IF;

               lv_squery :=
                   lv_squery || ' WHERE NUM_MOVIMIENTO = ' || ln_nummovimiento;

               BEGIN
                  EXECUTE IMMEDIATE lv_squery;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     v_serror := SQLCODE;
                     v_smess :=
                           'UPDATE ICC_MOVIMIENTO (2)(PK)bRegMovCControlada '
                        || SQLERRM;
                     RAISE error_retorno_i;
               END;
            ELSE
               IF v_bactestmovim
               THEN   --Si ind_telefono es 7 -> Prepago con telefono activado
                  IF ln_nummovimiento = '' AND lv_actabomovim = ''
                  THEN
                     v_serror := '1';
                     v_smess := 'Error al recuperar Movimiento en Central';
                     RAISE error_retorno_i;
                  END IF;

                  IF lv_actabomovim = 'AM'
                  THEN
                     lv_squery := 'UPDATE ICC_MOVIMIENTO ';
                     lv_squery := lv_squery || 'SET COD_ESTADO = 1';
                     lv_squery := lv_squery || ', PLAN = ' || lv_splan;

                     IF ln_cargacel > 0
                     THEN
                        lv_squery :=
                                    lv_squery || ', CARGA = ' || ln_scargacel;
                     END IF;

                     lv_squery :=
                           lv_squery
                        || ' WHERE NUM_MOVIMIENTO = '
                        || ln_nummovimiento;

                     BEGIN
                        EXECUTE IMMEDIATE lv_squery;
                     EXCEPTION
                        WHEN OTHERS
                        THEN
                           v_serror := SQLCODE;
                           v_smess :=
                                 'UPDATE ICC_MOVIMIENTO (3)(PK)bRegMovCControlada '
                              || SQLERRM;
                           RAISE error_retorno_i;
                     END;

                     lv_ssql := 'UPDATE ICC_MOVIMIENTO ';
                     lv_ssql := lv_ssql || '   SET COD_ESTADO = 0 ';
                     lv_ssql :=
                        lv_ssql
                        || '  WHERE NUM_MOVIMIENTO = LN_NumMovimiento ';

                     UPDATE icc_movimiento
                        SET cod_estado = 0
                      WHERE num_movimiento = ln_nummovimiento;
                  END IF;
               ELSE                         --Si ind_telefono es distinto de 7
                  --Envia movimiento dependiente de Indtelefono de Almacen
                  IF ln_nummovimiento <> ''
                  THEN
                     lv_squery := 'UPDATE ICC_MOVIMIENTO ';
                     lv_squery := lv_squery || 'SET PLAN = ' || lv_splan;

                     --USO_AMISTAR = "3" / USO_SEGURA_CTC = "15" / USO_SEGURA = "10"
                     IF (ln_cod_uso = '10') OR (ln_cod_uso = '15')
                     THEN                                     --Cuenta Segura
                        lv_squery :=
                                  lv_squery || ', VALOR_PLAN = ' || ln_nvalor;
                     ELSIF ln_cod_uso = '3'
                     THEN
                        ln_nvalor := 0;
                        lv_squery := lv_squery || ', CARGA = ' || ln_nvalor;
                     END IF;

                     lv_squery :=
                           lv_squery
                        || ' WHERE NUM_MOVIMIENTO = '
                        || ln_nummovimiento;

                     BEGIN
                        EXECUTE IMMEDIATE lv_squery;
                     EXCEPTION
                        WHEN OTHERS
                        THEN
                           v_serror := SQLCODE;
                           v_smess :=
                                 'UPDATE ICC_MOVIMIENTO (4)(PK)bRegMovCControlada '
                              || SQLERRM;
                           RAISE error_retorno_i;
                     END;
                  END IF;
               END IF;
            END IF;
         END IF;
      END IF;

      IF ln_tipmov = 1
      THEN                                                              --Alta
         IF ln_nummovimiento = ''
         THEN
            BEGIN
               lv_ssql := 'SELECT NUM_MOVIMIENTO ';
               lv_ssql := lv_ssql || ' FROM ICC_MOVIMIENTO ';
               lv_ssql :=
                        lv_ssql || '  WHERE NUM_CELULAR = ' || ln_num_celular;
               lv_ssql :=
                   lv_ssql || ' AND NUM_ABONADO = ' || eo_abonado.num_abonado;

               SELECT num_movimiento
                 INTO ln_num_movimiento
                 FROM icc_movimiento
                WHERE num_celular = ln_num_celular
                  AND num_abonado = eo_abonado.num_abonado;
            EXCEPTION
               WHEN OTHERS
               THEN
                  ln_num_movimiento := NULL;
            END;

            IF ln_num_movimiento IS NOT NULL
            THEN
               ln_nummovimiento := ln_num_movimiento;
            END IF;
         END IF;

         BEGIN
            lv_ssql := 'UPDATE ICC_MOVIMIENTO';
            lv_ssql := lv_ssql || ' SET CARGA = ' || ln_cargacel;
            lv_ssql :=
                   lv_ssql || '  WHERE NUM_MOVIMIENTO = ' || ln_nummovimiento;

            UPDATE icc_movimiento
               SET carga = ln_cargacel
             WHERE num_movimiento = ln_nummovimiento;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_serror := SQLCODE;
               v_smess :=
                     'UPDATE ICC_MOVIMIENTO (5)(PK)bRegMovCControlada '
                  || SQLERRM;
               RAISE error_retorno_i;
         END;
      END IF;
   EXCEPTION
      WHEN error_retorno_ok
      THEN
         sn_cod_retorno := 0;
      WHEN error_retorno_i
      THEN
         sn_cod_retorno := 17;
         sv_mens_retorno := v_smess;
         lv_des_error := lv_parametros || '- ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    cv_cod_modulo,
                                    sv_mens_retorno,
                                    cv_version,
                                    USER,
                                    cv_pak_func_valida,
                                    lv_squery,
                                    SQLCODE,
                                    lv_des_error
                                   );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;
         sv_mens_retorno := cv_error_no_clasif;
         lv_des_error := lv_parametros || '- ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    cv_cod_modulo,
                                    sv_mens_retorno,
                                    cv_version,
                                    USER,
                                    cv_pak_func_valida,
                                    lv_squery,
                                    SQLCODE,
                                    lv_des_error
                                   );
   END pv_bregvalccontrolada_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE pv_bregmovccontrolada_pr (
      eo_abonado        IN OUT          ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
/*
   <Documentación
     TipoDoc = "PROCEDURE">>
      <Elemento
         Nombre = "PV_bRegMovCControlada_PR"
         Lenguaje="PL/SQL"
         Fecha="11-09-2007"
         Versión="La del package"
         Dise+ador="Orlando Cabezas"
         Programador="  "
         Ambiente Desarrollo="BD">
         <Retorno>BOOLEAN</Retorno>>
         <Descripción></Descripción>>
         <Par+metros>
            <Entrada>
               <param nom="EO_COD_ACTABO" Tipo="varchar">Código Actabo</param>>
             <param nom="EO_NUM_ABONADO" Tipo="number">Numero Abonado</param>>
              <param nom="EO_NUM_SERIE" Tipo="number">Numero de serie</param>>
               <param nom="EO_TipMov" Tipo="varchar">Tipo Movimiento</param>>
            </Entrada>
            <Salida>
               <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
               <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
            </Salida>
         </Par+metros>
      </Elemento>
   </Documentación>
   */
      error_ejecucion   EXCEPTION;
      lv_des_error      ge_errores_pg.desevent;
      lv_parametros     VARCHAR2 (500);
      lv_ssql           ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_num_evento := 0;

      --  PARA OOSS POSPAGO/HIBRIDO O HIBRIDO/POSPAGO  ASUME EL VALOR DE USO DE LA LINEA EN EL CAMPO EO_ABONADO.CAUSA_BAJA
      IF    (    (eo_abonado.cod_uso = '10' OR eo_abonado.cod_uso = '15')
             AND eo_abonado.tipmov = 3
            )
         OR (eo_abonado.causa_baja = '10' AND eo_abonado.tipmov = 1)
      THEN
         lv_ssql :=
               'PV_bRegValCControlada_PR('
            || eo_abonado.cod_uso
            || ','
            || eo_abonado.causa_baja
            || ',)';
         pv_bregvalccontrolada_pr (eo_abonado,
                                   sn_cod_retorno,
                                   sv_mens_retorno,
                                   sn_num_evento
                                  );

         IF sn_cod_retorno > 0
         THEN
            RAISE error_ejecucion;
         END IF;
      END IF;
   EXCEPTION
      WHEN error_ejecucion
      THEN
         lv_des_error := 'PV_bRegMovCControlada_PR(''); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                        (sn_num_evento,
                         cv_cod_modulo,
                         sv_mens_retorno,
                         cv_version,
                         USER,
                         'PV_REG_MOVCCONTRALADA_PG.PV_bRegMovCControlada_PR',
                         lv_ssql,
                         sn_cod_retorno,
                         lv_des_error
                        );
      WHEN OTHERS
      THEN
         sn_cod_retorno := '156';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := 'PV_bRegMovCControlada_PR' || '- ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                         (sn_num_evento,
                          cv_cod_modulo,
                          sv_mens_retorno,
                          cv_version,
                          USER,
                          'PV_REG_MOVCCONTRALADA_PG.PV_bRegMovCControlada_PR',
                          lv_ssql,
                          SQLCODE,
                          lv_des_error
                         );
   END pv_bregmovccontrolada_pr;

------------------------------------------------------------------------------------------------
   PROCEDURE pv_registra_excepcion_pv_pr (
      eo_ga_cliente     IN OUT NOCOPY   pv_ga_abocel_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
/*
   <Documentación
     TipoDoc = "PROCEDURE">>
      <Elemento
         Nombre = " PV_registra_excepcion_PV_pr"
         Lenguaje="PL/SQL"
         Fecha="11-09-2007"
         Versión="La del package"
         Dise+ador="Orlando Cabezas"
         Programador="  "
         Ambiente Desarrollo="BD">
         <Retorno>BOOLEAN</Retorno>>
         <Descripción></Descripción>>
         <Par+metros>
            <Entrada>
               <param nom="EO_GA_CLIENTE" Tipo="number">Datos del Abonado</param>>
               </Entrada>
            <Salida>
               <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
               <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
               <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
         </Par+metros>
      </Elemento>
   </Documentación>
   */
   IS
      error_proceso   EXCEPTION;
      lv_des_error    ge_errores_pg.desevent;
      lv_parametros   VARCHAR2 (500);
      lv_ssql         ge_errores_pg.vquery;
   BEGIN
      INSERT INTO ve_excepcion_vta_prepago_to
                  (cod_excepcion_vta, num_venta,
                   cod_cliente, num_abonado,
                   cod_causa, fecha_venta, nom_usuario,
                   cod_plantarif
                  )
           VALUES (ve_venta_excepcionada_sq.NEXTVAL, 0,
                   eo_ga_cliente.cod_cliente, eo_ga_cliente.num_abonado,
                   eo_ga_cliente.cod_causa_venta, SYSDATE, USER,
                   eo_ga_cliente.cod_plantarif
                  );
   EXCEPTION
      WHEN error_proceso
      THEN
         lv_des_error := 'PV_REGISTRA_EXCEPCION_PV_PR(''); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                         (sn_num_evento,
                          cv_cod_modulo,
                          sv_mens_retorno,
                          cv_version,
                          USER,
                          'pv_orden_servicio_pg.PV_REGISTRA_EXCEPCION_PV_PR',
                          lv_ssql,
                          sn_cod_retorno,
                          lv_des_error
                         );
      WHEN OTHERS
      THEN
         sn_cod_retorno := '156';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := 'PV_REGISTRA_EXCEPCION_PV_PR' || '- ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sv_mens_retorno,
                           cv_version,
                           USER,
                           'pv_orden_servicio_pg.PV_REGISTRA_EXCEPCION_PV_PR',
                           lv_ssql,
                           SQLCODE,
                           lv_des_error
                          );
   END pv_registra_excepcion_pv_pr;

------------------------------------------------------------------------------------------------
   PROCEDURE pv_fachada_excepcion_pv_pr (
      en_num_abonado     IN              ga_abocel.num_abonado%TYPE,
      en_plan_destino    IN              ga_abocel.cod_plantarif%TYPE,
      en_cod_cliente     IN              ga_abocel.cod_cliente%TYPE,
      ev_param           IN              VARCHAR2,
      sv_insertookv      OUT NOCOPY      NUMBER,
      sn_cod_retornov    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retornov   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_eventov     OUT NOCOPY      ge_errores_pg.evento
   )
/*
   <Documentación
     TipoDoc = "PROCEDURE">>
      <Elemento
         Nombre = " PV_FACHADA_excepcion_PV_pr"
         Lenguaje="PL/SQL"
         Fecha="11-09-2007"
         Versión="La del package"
         Dise+ador="Orlando Cabezas"
         Programador="  "
         Ambiente Desarrollo="BD">
         <Retorno>BOOLEAN</Retorno>>
         <Descripción></Descripción>>
         <Par+metros>
            <Entrada>
               <param nom="EO_GA_CLIENTE" Tipo="number">Datos del Abonado</param>>
               </Entrada>
            <Salida>
               <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
               <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
               <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
         </Par+metros>
      </Elemento>
   </Documentación>
   */
   IS
      error_proceso     EXCEPTION;
      lv_des_error      ge_errores_pg.desevent;
      lv_parametros     VARCHAR2 (500);
      lv_ssql           ge_errores_pg.vquery;
      eo_exception      pv_ga_abocel_qt;
      sn_cod_retorno    ge_errores_td.cod_msgerror%TYPE;
      sv_mens_retorno   ge_errores_td.det_msgerror%TYPE;
      sn_num_evento     ge_errores_pg.evento;
   BEGIN
      sv_insertookv := 4;
      sn_cod_retornov := 4;
      sv_mens_retornov := '';
      sn_num_eventov := 0;
      eo_exception := pv_inicia_estructuras_pg.pv_ga_abocel_qt_fn;
      eo_exception.num_abonado := en_num_abonado;
      eo_exception.cod_cliente := en_cod_cliente;
      eo_exception.cod_plantarif := en_plan_destino;
      eo_exception.cod_causa_venta := ev_param;
      Pv_Orden_Servicio_Pg.pv_registra_excepcion_pv_pr (eo_exception,
                                                        sn_cod_retorno,
                                                        sv_mens_retorno,
                                                        sn_num_evento
                                                       );

      IF sn_cod_retorno = 0
      THEN
         sv_insertookv := 1;
         sn_cod_retornov := 0;
         sv_mens_retornov := 'OK';
      ELSE
         RAISE error_proceso;
      END IF;
   EXCEPTION
      WHEN error_proceso
      THEN
         lv_des_error := 'PV_FACHADA_EXCEPCION_PV_PR(''); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sv_mens_retorno,
                           cv_version,
                           USER,
                           'pv_orden_servicio_pg.PV_FACHADA_EXCEPCION_PV_PR',
                           lv_ssql,
                           sn_cod_retorno,
                           lv_des_error
                          );
      WHEN OTHERS
      THEN
         sn_cod_retorno := '156';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := 'PV_FACHADA_EXCEPCION_PV_PR' || '- ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            cv_cod_modulo,
                            sv_mens_retorno,
                            cv_version,
                            USER,
                            'pv_orden_servicio_pg.PV_FACHADA_EXCEPCION_PV_PR',
                            lv_ssql,
                            SQLCODE,
                            lv_des_error
                           );
   END pv_fachada_excepcion_pv_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_valida_lista_negra_pr (
      so_abonado        IN OUT NOCOPY   ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
       /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_VALIDA_LISTA_NEGRA_PR
            Lenguaje="PL/SQL"
            Fecha="04-02-2008"
            Versión="La del package"
            Dise+ador="*"
            Programador="*
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
            <Descripción></Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="SO_ABONADO" Tipo="estructura">estructura de abonado</param>>
               </Entrada>
               <Salida>
                  <param nom="" Tipo=""></param>>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error                   ge_errores_pg.desevent;
      lv_ssql                        ge_errores_pg.vquery;
      cv_grupotecdma        CONSTANT VARCHAR2 (20)         := 'GRUPO_TEC_DMA';
      lv_obtcodgrupo_al_tecnologia   al_tecnologia.cod_grupo%TYPE;
      eo_ged_parametros              pv_ged_parametros_qt;
      lv_cdma                        VARCHAR2 (20);
      eo_secuencia                   pv_secuencia_qt;
      lv_numtransac                  NUMBER;
      lv_error                       NUMBER;
      ln_existe                      NUMBER;
      formato_serie                  EXCEPTION;
      asigando_a_otro                EXCEPTION;
      lista_negras                   EXCEPTION;
      error_ejecucion                EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql :=
            ' GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN('
         || so_abonado.cod_tecnologia
         || ')';
      lv_obtcodgrupo_al_tecnologia :=
         ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn
                                                    (so_abonado.cod_tecnologia);

      IF lv_obtcodgrupo_al_tecnologia = 'ERROR'
      THEN
         sn_cod_retorno := 1363;
         RAISE error_ejecucion;
      END IF;

      IF lv_obtcodgrupo_al_tecnologia IS NOT NULL
      THEN
         eo_ged_parametros :=
                             pv_inicia_estructuras_pg.pv_ged_parametros_qt_fn;
         eo_ged_parametros.nom_parametro := cv_grupotecdma;
         eo_ged_parametros.cod_modulo := cv_cod_modulo;
         eo_ged_parametros.cod_producto := cn_producto;
         lv_ssql :=
               'PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR('
            || eo_ged_parametros.nom_parametro
            || ','
            || eo_ged_parametros.cod_modulo
            || ','
            || eo_ged_parametros.cod_producto
            || ')';
         pv_generales_pg.pv_obtiene_ged_parametros_pr (eo_ged_parametros,
                                                       sn_cod_retorno,
                                                       sv_mens_retorno,
                                                       sn_num_evento
                                                      );
         lv_cdma := eo_ged_parametros.val_parametro;

         IF sn_cod_retorno <> 0
         THEN
            RAISE error_ejecucion;
         END IF;

         IF (lv_obtcodgrupo_al_tecnologia = lv_cdma)
         THEN
            /*LV_sSql:= 'FN_RECUPERA_IMSI('||EO_APROVISIONAR.NUM_SERIE||')';

              LV_sImsi:=FN_RECUPERA_IMSI(EO_APROVISIONAR.NUM_SERIE);
              IF Trim(LV_sImsi) IS NULL THEN
               SN_cod_retorno  := 1366;
               RAISE ERROR_GENERICO;
              END IF;*/
            eo_secuencia := pv_inicia_estructuras_pg.pv_secuencia_qt_fn;
            eo_secuencia.nom_secuencia := 'PV_ERRORES_SQ';
            eo_secuencia.num_secuencia := NULL;
            lv_ssql :=
                'EO_SECUENCIA:=PV_INICIA_ESTRUCTURAS_PG.PV_SECUENCIA_QT_FN; ';
            lv_ssql :=
                  lv_ssql
               || 'EO_SECUENCIA.NOM_SECUENCIA:='
               || 'GA_SEQ_TRANSACABO'
               || '; ';
            lv_ssql :=
                  lv_ssql
               || 'PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR (EO_SECUENCIA,'
               || sn_cod_retorno
               || ','
               || sv_mens_retorno
               || ','
               || sn_num_evento
               || '); ';
            pv_generales_pg.pv_obtiene_secuencia_pr (eo_secuencia,
                                                     sn_cod_retorno,
                                                     sv_mens_retorno,
                                                     sn_num_evento
                                                    );

            IF sn_cod_retorno <> 0
            THEN
               RAISE error_ejecucion;
            END IF;

            lv_numtransac := eo_secuencia.num_secuencia;
            p_valida_serie (lv_numtransac, so_abonado.num_serie);
            lv_ssql :=
                  'SELECT COD_RETORNO FROM GA_TRANSACABO WHERE NUM_TRANSACCION ='
               || lv_numtransac;

            SELECT cod_retorno
              INTO lv_error
              FROM ga_transacabo
             WHERE num_transaccion = lv_numtransac;

            IF lv_error = 1
            THEN
               RAISE formato_serie;
            ELSIF lv_error = 2
            THEN
               RAISE asigando_a_otro;
            ELSIF lv_error = 3
            THEN
               RAISE lista_negras;
            ELSIF lv_error = 4
            THEN
               RAISE error_ejecucion;
            END IF;
         ELSE
            lv_ssql :=
                  'SELECT 1 FROM GA_LNCELU WHERE NUM_SERIE = '
               || so_abonado.num_serie;

            BEGIN
               SELECT 1
                 INTO ln_existe
                 FROM ga_lncelu
                WHERE num_serie = so_abonado.num_serie;

               IF ln_existe = 1
               THEN
                  RAISE lista_negras;
               END IF;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         END IF;
      END IF;
   EXCEPTION
      WHEN formato_serie
      THEN
         sn_cod_retorno := 300121;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno:= 'FORMATO DE SERIE INCORRECTO';
         lv_des_error :=
               ' PV_OBTIENE_DATOS_CLIENTE_PR('
            || so_abonado.num_abonado
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'PV_DATOS_CLIENTES_PG.PV_VALIDA_LISTA_NEGRA_PR',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
      WHEN asigando_a_otro
      THEN
         sn_cod_retorno := 1705;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno:= 'Número asignado a otro abonado';
         lv_des_error :=
               ' PV_OBTIENE_DATOS_CLIENTE_PR('
            || so_abonado.num_abonado
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'PV_DATOS_CLIENTES_PG.PV_VALIDA_LISTA_NEGRA_PR',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
      WHEN lista_negras
      THEN
         sn_cod_retorno := 567;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno:= 'Serie Catalogada en listas negras';
         lv_des_error :=
               ' PV_OBTIENE_DATOS_CLIENTE_PR('
            || so_abonado.num_abonado
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'PV_DATOS_CLIENTES_PG.PV_VALIDA_LISTA_NEGRA_PR',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
      WHEN error_ejecucion
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_OBTIENE_DATOS_CLIENTE_PR('
            || so_abonado.num_abonado
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'PV_DATOS_CLIENTES_PG.PV_VALIDA_LISTA_NEGRA_PR',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               ' PV_OBTIENE_DATOS_CLIENTE_PR('
            || so_abonado.num_abonado
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'PV_DATOS_CLIENTES_PG.PV_VALIDA_LISTA_NEGRA_PR',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
   END pv_valida_lista_negra_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_grpsersupl_frm_fn (
      em_tabla          IN OUT NOCOPY   tip_ga_grupos_servsup,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sv_sql            OUT NOCOPY      ge_evento_detalle_to.QUERY%TYPE
   )
      RETURN BOOLEAN
   IS
      error_funcion   EXCEPTION;
   BEGIN
      sv_sql := ' SELECT  serv.cod_producto';
      sv_sql := sv_sql || '  ,serv.cod_grupo';
      sv_sql := sv_sql || '  ,serv.des_grupo';
      sv_sql := sv_sql || '  ,serv.cod_servicio';
      sv_sql := sv_sql || '  ,serv.fec_desde';
      sv_sql := sv_sql || '  ,serv.nom_usuario';
      sv_sql := sv_sql || '  ,serv.fec_hasta';
      sv_sql := sv_sql || '  ,serv.num_lineas';
      sv_sql := sv_sql || '   FROM   ga_grupos_servsup serv';
      sv_sql :=
            sv_sql
         || '   WHERE  EXISTS (SELECT param.val_parametro from ged_parametros param';
      sv_sql := sv_sql || '   WHERE  param.val_parametro =  serv.cod_grupo';
      sv_sql :=
         sv_sql || '   AND    param.nom_parametro =''' || cv_serv_frm || ''')';
      sv_sql :=
            sv_sql
         || '   AND    sysdate BETWEEN serv.fec_desde and nvl(serv.fec_hasta, sysdate)';

      SELECT serv.cod_producto,
             serv.cod_grupo,
             serv.des_grupo,
             serv.cod_servicio,
             serv.fec_desde,
             serv.nom_usuario,
             serv.fec_hasta,
             serv.num_lineas
      BULK COLLECT INTO em_tabla
        FROM ga_grupos_servsup serv
       WHERE EXISTS (
                SELECT param.val_parametro
                  FROM ged_parametros param
                 WHERE param.val_parametro = serv.cod_grupo
                   AND param.nom_parametro = cv_serv_frm)
         AND SYSDATE BETWEEN serv.fec_desde AND NVL (serv.fec_hasta, SYSDATE);

      IF em_tabla.COUNT = 0
      THEN
         RAISE error_funcion;
      END IF;

      RETURN TRUE;
   EXCEPTION
      WHEN error_funcion
      THEN
         sn_cod_retorno := 214;
         sv_mens_retorno :=
               'PV_REC_GRPSERSUPL_FRM_FN'
            || ' : '
            || 'Error no se encontro códigos de servicio';
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := SQLCODE;
         sv_mens_retorno := 'PV_REC_GRPSERSUPL_FRM_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_rec_grpsersupl_frm_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_actuaserv_frm_fn (
      em_tabla          IN OUT NOCOPY   tip_ga_actuaserv,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sv_sql            OUT NOCOPY      ge_evento_detalle_to.QUERY%TYPE
   )
      RETURN BOOLEAN
   IS
      ln_cod_producto   ga_actuaserv.cod_producto%TYPE;
      lv_cod_tipserv    ga_actuaserv.cod_tipserv%TYPE;
      lv_cod_servicio   ga_actuaserv.cod_servicio%TYPE;
      lv_cod_actabo     ga_actuaserv.cod_actabo%TYPE;
      error_funcion     EXCEPTION;
   BEGIN
      ln_cod_producto := em_tabla (1).cod_producto;
      lv_cod_tipserv := em_tabla (1).cod_tipserv;
      lv_cod_servicio := em_tabla (1).cod_servicio;
      lv_cod_actabo := em_tabla (1).cod_actabo;
      sv_sql := ' SELECT  act.cod_producto';
      sv_sql := sv_sql || ' ,act.cod_actabo';
      sv_sql := sv_sql || ' ,act.cod_tipserv';
      sv_sql := sv_sql || ' ,act.cod_servicio';
      sv_sql := sv_sql || ' ,act.cod_concepto';
      sv_sql := sv_sql || ' FROM    ga_actuaserv act ';
      sv_sql := sv_sql || ' WHERE   act.cod_producto = ' || ln_cod_producto;
      sv_sql :=
         sv_sql || ' AND     act.cod_tipserv  = ''' || lv_cod_tipserv || '''';
      sv_sql :=
         sv_sql || ' AND     act.cod_servicio = ''' || lv_cod_servicio
         || '''';
      sv_sql :=
          sv_sql || ' AND     act.cod_actabo   = ''' || lv_cod_actabo || '''';

      SELECT act.cod_producto,
             act.cod_actabo,
             act.cod_tipserv,
             act.cod_servicio,
             act.cod_concepto
      BULK COLLECT INTO em_tabla
        FROM ga_actuaserv act
       WHERE act.cod_producto = ln_cod_producto
         AND act.cod_tipserv = lv_cod_tipserv
         AND act.cod_servicio = lv_cod_servicio
         AND act.cod_actabo = lv_cod_actabo;

      IF em_tabla.COUNT = 0
      THEN
         RAISE error_funcion;
      END IF;

      RETURN TRUE;
   EXCEPTION
      WHEN error_funcion
      THEN
         sn_cod_retorno := 403;
         sv_mens_retorno := 'PV_REC_ACTUASERV_FRM_FN';
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := SQLCODE;
         sv_mens_retorno := 'PV_REC_ACTUASERV_FRM_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_rec_actuaserv_frm_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_servspl_frm_fn (
      em_tabla          IN OUT NOCOPY   tip_ga_servsupl,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sv_sql            OUT NOCOPY      ge_evento_detalle_to.QUERY%TYPE
   )
      RETURN BOOLEAN
   IS
      ln_cod_producto   GA_SERVSUPL.cod_producto%TYPE;
      lv_cod_servicio   GA_SERVSUPL.cod_servicio%TYPE;
      lv_cod_nivel      GA_SERVSUPL.cod_nivel%TYPE;
      error_funcion     EXCEPTION;
   BEGIN
      ln_cod_producto := em_tabla (1).cod_producto;
      lv_cod_servicio := em_tabla (1).cod_servicio;
      lv_cod_nivel := em_tabla (1).cod_nivel;
      sv_sql := ' SELECT  serv.cod_producto';
      sv_sql := sv_sql || ' ,serv.cod_servicio';
      sv_sql := sv_sql || ' ,serv.cod_servsupl';
      sv_sql := sv_sql || ' ,serv.cod_nivel';
      sv_sql := sv_sql || ' ,serv.des_servicio';
      sv_sql := sv_sql || ' ,serv.ind_autman';
      sv_sql := sv_sql || ' ,serv.ind_comerc';
      sv_sql := sv_sql || ' ,serv.ind_pro';
      sv_sql := sv_sql || ' ,serv.ind_central';
      sv_sql := sv_sql || ' ,serv.cod_aplic';
      sv_sql := sv_sql || ' ,serv.ind_traspaso';
      sv_sql := sv_sql || ' ,serv.des_servicio_web';
      sv_sql := sv_sql || ' ,serv.ind_gestor';
      sv_sql := sv_sql || ' ,serv.ind_cobro';
      sv_sql := sv_sql || ' ,serv.ind_prioridad';
      sv_sql := sv_sql || ' ,serv.tip_servicio';
      sv_sql := sv_sql || ' ,serv.ind_tuxedo';
      sv_sql := sv_sql || ' ,serv.ind_infranet';
      sv_sql := sv_sql || ' FROM    ga_servsupl serv ';
      sv_sql := sv_sql || ' WHERE   serv.cod_producto = ' || ln_cod_producto;
      sv_sql :=
         sv_sql || ' AND     serv.cod_servicio = ''' || lv_cod_servicio
         || '''';
      sv_sql :=
          sv_sql || ' AND     serv.cod_nivel    = ''' || lv_cod_nivel || '''';

      SELECT serv.cod_producto,
             serv.cod_servicio,
             serv.cod_servsupl,
             serv.cod_nivel,
             serv.des_servicio,
             serv.ind_autman,
             serv.ind_comerc,
             serv.ind_pro,
             serv.ind_central,
             serv.cod_aplic,
             serv.ind_traspaso,
             serv.des_servicio_web,
             serv.ind_gestor,
             serv.ind_cobro,
             serv.ind_prioridad,
             serv.tip_servicio,
             serv.ind_tuxedo,
             serv.ind_infranet,
             serv.sub_categoria,
             serv.tip_red,
             serv.ind_ip,
             serv.tip_cobro,
             serv.ind_cobretr,
             serv.IND_RESTRINGIBLE
      BULK COLLECT INTO em_tabla
        FROM GA_SERVSUPL serv
       WHERE serv.cod_producto = ln_cod_producto
         AND serv.cod_servicio = lv_cod_servicio
         AND serv.cod_nivel <> lv_cod_nivel;

      IF em_tabla.COUNT = 0
      THEN
         RAISE error_funcion;
      END IF;

      RETURN TRUE;
   EXCEPTION
      WHEN error_funcion
      THEN
         sn_cod_retorno := 214;
         sv_mens_retorno :=
               'PV_REC_SERVSPL_FRM_FN'
            || ' : '
            || 'Error no se encontro servicio suplementarios';
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := SQLCODE;
         sv_mens_retorno := 'PV_REC_SERVSPL_FRM_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_rec_servspl_frm_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pr_reg_servsuplabo_fn (
      em_tabla          IN              tip_ga_servsuplabo,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sv_sql            OUT NOCOPY      ge_evento_detalle_to.QUERY%TYPE
   )
      RETURN BOOLEAN
   IS
   BEGIN
      sv_sql := ' INSERT INTO GA_SERVSUPLABO';
      sv_sql := sv_sql || ' (NUM_ABONADO  ';
      sv_sql := sv_sql || ' ,COD_SERVICIO ';
      sv_sql := sv_sql || ' ,FEC_ALTABD   ';
      sv_sql := sv_sql || ' ,COD_SERVSUPL ';
      sv_sql := sv_sql || ' ,COD_NIVEL    ';
      sv_sql := sv_sql || ' ,COD_PRODUCTO ';
      sv_sql := sv_sql || ' ,NUM_TERMINAL ';
      sv_sql := sv_sql || ' ,NOM_USUARORA ';
      sv_sql := sv_sql || ' ,IND_ESTADO   ';
      sv_sql := sv_sql || ' ,FEC_ALTACEN  ';
      sv_sql := sv_sql || ' ,FEC_BAJABD   ';
      sv_sql := sv_sql || ' ,FEC_BAJACEN  ';
      sv_sql := sv_sql || ' ,COD_CONCEPTO ';
      sv_sql := sv_sql || ' ,NUM_DIASNUM) ';
      sv_sql := sv_sql || ' VALUES(' || em_tabla (1).num_abonado;
      sv_sql := sv_sql || ' ,' || em_tabla (1).cod_servicio;
      sv_sql := sv_sql || ' ,' || em_tabla (1).fec_altabd;
      sv_sql := sv_sql || ' ,' || em_tabla (1).cod_servsupl;
      sv_sql := sv_sql || ' ,' || em_tabla (1).cod_nivel;
      sv_sql := sv_sql || ' ,' || em_tabla (1).cod_producto;
      sv_sql := sv_sql || ' ,' || em_tabla (1).num_terminal;
      sv_sql := sv_sql || ' ,' || em_tabla (1).nom_usuarora;
      sv_sql := sv_sql || ' ,' || em_tabla (1).ind_estado;
      sv_sql := sv_sql || ' ,' || em_tabla (1).fec_altacen;
      sv_sql := sv_sql || ' ,' || em_tabla (1).fec_bajabd;
      sv_sql := sv_sql || ' ,' || em_tabla (1).fec_bajacen;
      sv_sql := sv_sql || ' ,' || em_tabla (1).cod_concepto;
      sv_sql := sv_sql || ' ,' || em_tabla (1).num_diasnum || ')';

      INSERT INTO ga_servsuplabo
           VALUES em_tabla (1);

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 4;
         sv_mens_retorno := 'PR_REG_SERVSUPLABO_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pr_reg_servsuplabo_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_abonserv_fn (
      em_tabla          IN OUT NOCOPY   tip_abon_serv_list,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sv_sql            OUT NOCOPY      ge_evento_detalle_to.QUERY%TYPE
   )
      RETURN BOOLEAN
   IS
      lv_cod_situacion   ga_abocel.cod_situacion%TYPE;
      ln_num_abonado     ga_abocel.num_abonado%TYPE;
      error_funcion      EXCEPTION;
   BEGIN
      lv_cod_situacion := em_tabla (1).cod_situacion;
      ln_num_abonado := em_tabla (1).num_abonado;
      sv_sql := '    SELECT  abo.clase_servicio';
      sv_sql := sv_sql || ' ,abo.perfil_abonado';
      sv_sql := sv_sql || ' ,abo.num_abonado';
      sv_sql := sv_sql || ' ,abo.cod_situacion';
      sv_sql := sv_sql || ' FROM    ga_abocel abo';
      sv_sql := sv_sql || ' WHERE   abo.num_abonado       = ' || ln_num_abonado;
      sv_sql :=
         sv_sql || ' AND   abo.cod_situacion      !=''' || lv_cod_situacion
         || '''';

      SELECT abo.clase_servicio,
             abo.perfil_abonado,
             abo.num_abonado,
             abo.cod_situacion
      BULK COLLECT INTO em_tabla
        FROM ga_abocel abo
       WHERE abo.num_abonado = ln_num_abonado
         AND abo.cod_situacion != lv_cod_situacion;

      IF em_tabla.COUNT = 0
      THEN
         RAISE error_funcion;
      END IF;

      RETURN TRUE;
   EXCEPTION
      WHEN error_funcion
      THEN
         sn_cod_retorno := 203;
         sv_mens_retorno :=
               'PV_REC_ABONSERV_FN'
            || ' : '
            || 'Error no se encontro clases de servicio';
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := SQLCODE;
         sv_mens_retorno := 'PV_REC_ABONSERV_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_rec_abonserv_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_act_abonserv_fn (
      em_tabla          IN              tip_abon_serv_list,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sv_sql            OUT NOCOPY      ge_evento_detalle_to.QUERY%TYPE
   )
      RETURN BOOLEAN
   IS
      lv_clase_servicio   ga_abocel.clase_servicio%TYPE;
      lv_perfil_abonado   ga_abocel.perfil_abonado%TYPE;
      ln_num_abonado      ga_abocel.num_abonado%TYPE;
      lv_cod_situacion    ga_abocel.cod_situacion%TYPE;
      error_funcion       EXCEPTION;
   BEGIN
      lv_clase_servicio := em_tabla (1).clase_servicio;
      lv_perfil_abonado := em_tabla (1).perfil_abonado;
      lv_cod_situacion := em_tabla (1).cod_situacion;
      ln_num_abonado := em_tabla (1).num_abonado;
      sv_sql := '    UPDATE ga_abocel abo';
      sv_sql :=
            sv_sql
         || ' SET    abo.clase_servicio = '''
         || lv_clase_servicio
         || '''';
      sv_sql :=
         sv_sql || ' ,         abo.perfil_abonado = ''' || lv_perfil_abonado
         || '''';
      sv_sql := sv_sql || ' WHERE  abo.num_abonado       = ' || ln_num_abonado;
      sv_sql :=
            sv_sql
         || ' AND    abo.cod_situacion       = '''
         || lv_cod_situacion
         || '''';

      UPDATE ga_abocel abo
         SET abo.clase_servicio = lv_clase_servicio,
             abo.perfil_abonado = lv_perfil_abonado
       WHERE abo.num_abonado = ln_num_abonado
         AND abo.cod_situacion != lv_cod_situacion;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 2;
         sv_mens_retorno := 'PV_ACT_ABONSERV_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_act_abonserv_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_act_intarcel_fn (
      em_tabla          IN              tip_ga_intarcel,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sv_sql            OUT NOCOPY      ge_evento_detalle_to.QUERY%TYPE
   )
      RETURN BOOLEAN
   IS
      ln_ind_friends   ga_intarcel.ind_friends%TYPE;
      ln_cod_cliente   ga_intarcel.cod_cliente%TYPE;
      ln_num_abonado   ga_intarcel.num_abonado%TYPE;
      error_funcion    EXCEPTION;
   BEGIN
      ln_ind_friends := em_tabla (1).ind_friends;
      ln_cod_cliente := em_tabla (1).cod_cliente;
      ln_num_abonado := em_tabla (1).num_abonado;
      sv_sql := '    UPDATE ga_intarcel intar';
      sv_sql :=
         sv_sql || ' SET    intar.ind_friends = ''' || ln_ind_friends || '''';
      sv_sql := sv_sql || ' WHERE  intar.cod_cliente = ' || ln_cod_cliente;
      sv_sql := sv_sql || ' AND     intar.num_abonado = ' || ln_num_abonado;
      sv_sql :=
            sv_sql
         || ' AND    ((sysdate between intar.fec_desde and intar.fec_hasta)';
      sv_sql := sv_sql || ' OR (fec_desde >= sysdate))';

      UPDATE ga_intarcel intar
         SET intar.ind_friends = ln_ind_friends
       WHERE intar.cod_cliente = ln_cod_cliente
         AND intar.num_abonado = ln_num_abonado
         AND (   (SYSDATE BETWEEN intar.fec_desde AND intar.fec_hasta)
              OR (fec_desde >= SYSDATE)
             );

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 2;
         sv_mens_retorno := 'PV_ACT_INTARCEL_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_act_intarcel_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_val_numfrec_fn (
      em_tabla          IN              tip_ga_numespabo,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sv_sql            OUT NOCOPY      ge_evento_detalle_to.QUERY%TYPE
   )
      RETURN BOOLEAN
   IS
      ln_existe   NUMBER;
   BEGIN
      sv_sql := '    SELECT COUNT(0)';
      sv_sql := sv_sql || 'FROM   ga_numespabo num';
      sv_sql :=
             sv_sql || 'WHERE  num.num_abonado =' || em_tabla (1).num_abonado;
      sv_sql :=
            sv_sql
         || 'AND    num_telefesp    ='''
         || em_tabla (1).num_telefesp
         || '''';

      SELECT COUNT (0)
        INTO ln_existe
        FROM ga_numespabo num
       WHERE num.num_abonado = em_tabla (1).num_abonado
         AND num_telefesp = em_tabla (1).num_telefesp;

      IF ln_existe = 0
      THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 1;
         sv_mens_retorno := 'PV_VAL_NUMFREC_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_val_numfrec_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pr_reg_numespabo_fn (
      em_tabla          IN              tip_ga_numespabo,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sv_sql            OUT NOCOPY      ge_evento_detalle_to.QUERY%TYPE
   )
      RETURN BOOLEAN
   IS
   BEGIN
      sv_sql := ' INSERT INTO GA_NUMESPABO';
      sv_sql := sv_sql || ' (NUM_ABONADO  ';
      sv_sql := sv_sql || ' ,NUM_TELEFESP ';
      sv_sql := sv_sql || ' ,NUM_DIASNUM   ';
      sv_sql := sv_sql || ' ,TIP_FRECUENTE ';
      sv_sql := sv_sql || ' VALUES(' || em_tabla (1).num_abonado;
      sv_sql := sv_sql || ' ,' || em_tabla (1).num_telefesp;
      sv_sql := sv_sql || ' ,' || em_tabla (1).num_diasnum;
      sv_sql := sv_sql || ' ,' || em_tabla (1).tip_frecuente || ')';

      INSERT INTO ga_numespabo
           VALUES em_tabla (1);

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 4;
         sv_mens_retorno := 'PR_REG_NUMESPABO_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pr_reg_numespabo_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_secuencia_fn (ev_nom_secuencia IN VARCHAR2)
      RETURN NUMBER
   IS
      lv_sql         VARCHAR2 (250);
      ln_secuencia   NUMBER;
   BEGIN
      lv_sql := 'SELECT ' || ev_nom_secuencia || '.NEXTVAL FROM DUAL';

      EXECUTE IMMEDIATE lv_sql
                   INTO ln_secuencia;

      RETURN ln_secuencia;
   END pv_rec_secuencia_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_reg_frec_programados_pr (
      eo_servfrec         IN              pv_desact_servfrec_qt,
      eo_frecuentes_lst   IN              pv_frecuentes_lst_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   IS
/*
   <Documentacion TipoDoc = "Funcion">
   <Elemento Nombre = "PV_REG_FREC_PROGRAMADOS_PR "
    Lenguaje="PL/SQL" Fecha="10-08-2007"
    Versión"1.0.0" Dise+ador"****"
    Programador="" Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion>   Funcion que inserta los número frecuentes </Descripcion>
   <Parametros>
   <Entrada>
         <param nom="EO_SERVFREC"    Tipo="PV_DESACT_SERVFREC_QT" > Datos de Estructura  </param>>
         <param nom="EO_FRECUENTES_LST"    Tipo="PV_FRECUENTES_LST_QT" > Datos de Estructura  </param>>
   </Entrada>
            <Salida>
               <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo de Retorno         </param>>
               <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje de Retorno        </param>>
               <param nom="SN_num_evento"             Tipo="NUMERICO">Numero de Evento       </param>>
            </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
   */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF (    (eo_frecuentes_lst.FIRST IS NOT NULL)
          AND (eo_frecuentes_lst.LAST IS NOT NULL)
         )
      THEN
         FOR i IN 1 .. eo_frecuentes_lst.LAST
         LOOP
            lv_ssql := ' INSERT INTO ga_frec_ciclo (num_abonado';
            lv_ssql := lv_ssql || ' ,cod_ciclfact';
            lv_ssql := lv_ssql || ' ,cod_plantarif';
            lv_ssql := lv_ssql || ' ,tip_frecuente';
            lv_ssql := lv_ssql || ' ,num_frecuente)';
            lv_ssql := lv_ssql || ' values (' || eo_servfrec.num_abonado;
            lv_ssql := lv_ssql || '        ,' || eo_servfrec.cod_ciclfact;
            lv_ssql :=
                    lv_ssql || '        ,' || eo_servfrec.cod_plantarif_nuevo;
            lv_ssql :=
                  lv_ssql
               || '        ,'''
               || eo_frecuentes_lst (i).tip_frecuente
               || '';
            lv_ssql :=
                  lv_ssql
               || '        ,'''
               || eo_frecuentes_lst (i).num_frecuente
               || ''')';

            INSERT INTO ga_frec_ciclo
                        (num_abonado, cod_ciclfact,
                         cod_plantarif,
                         tip_frecuente,
                         num_frecuente
                        )
                 VALUES (eo_servfrec.num_abonado, eo_servfrec.cod_ciclfact,
                         eo_servfrec.cod_plantarif_nuevo,
                         eo_frecuentes_lst (i).tip_frecuente,
                         eo_frecuentes_lst (i).num_frecuente
                        );
         END LOOP;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 4;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := 'PV_REG_FREC_PROGRAMADOS_PR (); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    cv_cod_modulo,
                                    sv_mens_retorno,
                                    cv_version,
                                    USER,
                                    'PV_REG_FREC_PROGRAMADOS_PR',
                                    lv_ssql,
                                    sn_cod_retorno,
                                    lv_des_error
                                   );
   END pv_reg_frec_programados_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_numfrec_frm_fn (
      em_tabla          IN OUT NOCOPY   tip_numfrec_serv_list,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sv_sql            OUT NOCOPY      ge_evento_detalle_to.QUERY%TYPE
   )
      RETURN BOOLEAN
   IS
      ln_cod_cliente   ga_abocel.cod_cliente%TYPE;
      ln_ind_ff        NUMBER;
      exit_funtion     EXCEPTION;
   BEGIN
      ln_cod_cliente := em_tabla (1).cod_cliente;
      ln_ind_ff := em_tabla (1).ind_ff;
      sv_sql :=
         ' SELECT UNIQUE a.num_telefesp,a.tip_frecuente,LN_IND_FF,b.cod_cliente ';
      sv_sql := sv_sql || ' FROM   ga_numespabo a, ga_abocel b';
      sv_sql := sv_sql || ' WHERE  a.num_abonado = b.num_abonado';
      sv_sql := sv_sql || ' AND    b.cod_cliente =' || ln_cod_cliente;
      sv_sql := sv_sql || ' AND   ((LN_IND_FF in (0,1)';
      sv_sql := sv_sql || ' AND   not exists (select to_char(c.num_celular)';
      sv_sql := sv_sql || '                        from      ga_abocel c';
      sv_sql := sv_sql || '                      where  cod_cliente = b.cod_cliente';
      sv_sql := sv_sql || '                      and    c.num_celular = a.num_telefesp))) ';

      SELECT UNIQUE a.num_telefesp,
                    a.tip_frecuente,
                    ln_ind_ff,
                    b.cod_cliente
      BULK COLLECT INTO em_tabla
               FROM ga_numespabo a, ga_abocel b
              WHERE a.num_abonado = b.num_abonado
                AND b.cod_cliente = ln_cod_cliente
                AND ((    ln_ind_ff IN (0, 1)
                      AND NOT EXISTS (
                             SELECT TO_CHAR (c.num_celular)
                               FROM ga_abocel c
                              WHERE cod_cliente = b.cod_cliente
                                AND c.num_celular = a.num_telefesp)
                     )
                    );

      IF em_tabla.COUNT = 0
      THEN
         RAISE exit_funtion;
      END IF;

      RETURN TRUE;
   EXCEPTION
      WHEN exit_funtion
      THEN
--        SN_cod_retorno  := 1;
--        SV_mens_retorno := 'PV_REC_NUMFREC_FRM_FN' ||' : '||'Error no se encontro códigos de servicio';
         sn_cod_retorno := 0;
         sv_mens_retorno := NULL;
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := SQLCODE;
         sv_mens_retorno := 'PV_REC_NUMFREC_FRM_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_rec_numfrec_frm_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_reg_frec_online_pr (
      eo_servfrec         IN              pv_desact_servfrec_qt,
      eo_frecuentes_lst   IN              pv_frecuentes_lst_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   IS
/*
   <Documentacion TipoDoc = "Funcion">
   <Elemento Nombre = "PV_REG_FREC_ONLINE_PR "
    Lenguaje="PL/SQL" Fecha="10-08-2007"
    Versión"1.0.0" Dise+ador"****"
    Programador="" Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion>   Funcion que inserta los número frecuentes </Descripcion>
   <Parametros>
   <Entrada>
         <param nom="EO_SERVFREC"    Tipo="PV_DESACT_SERVFREC_QT" > Datos de Estructura  </param>>
         <param nom="EO_FRECUENTES_LST"    Tipo="PV_FRECUENTES_LST_QT" > Datos de Estructura  </param>>
   </Entrada>
            <Salida>
               <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo de Retorno         </param>>
               <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje de Retorno        </param>>
               <param nom="SN_num_evento"             Tipo="NUMERICO">Numero de Evento       </param>>
            </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
   */
      lv_des_error          ge_errores_pg.desevent;
      lv_ssql               ge_errores_pg.vquery;
      lv_cadena             VARCHAR2 (1000);
      lv_cadena_serv        VARCHAR2 (1000);
      lv_cadena_perf        VARCHAR2 (1000);
      ln_largo              NUMBER;
      i                     NUMBER;
      x                     NUMBER;
      k                     NUMBER;
      em_ga_grupos_servsu   tip_ga_grupos_servsup;
      em_ga_actuaserv       tip_ga_actuaserv;
      em_ga_servsupl        tip_ga_servsupl;
      em_ga_servsuplabo     tip_ga_servsuplabo;
      em_ga_abon_serv       tip_abon_serv_list;
      em_ga_intarcel        tip_ga_intarcel;
      em_ga_numespabo       tip_ga_numespabo;
      em_numfrec            tip_numfrec_serv_list;
      lv_mens_retorno       ge_errores_td.det_msgerror%TYPE;
      error_funcion         EXCEPTION;
      exit_funtion          EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF     cn_cero = eo_servfrec.ind_ff
         AND cn_cero = eo_servfrec.num_frec_fijos
         AND cn_cero = eo_servfrec.num_frec_movil
      THEN
         RAISE exit_funtion;
      END IF;

      IF pv_rec_grpsersupl_frm_fn (em_ga_grupos_servsu,
                                   sn_cod_retorno,
                                   sv_mens_retorno,
                                   lv_ssql
                                  )
      THEN
         FOR i IN 1 .. em_ga_grupos_servsu.COUNT
         LOOP
            em_ga_actuaserv (1).cod_producto := cn_producto;
            em_ga_actuaserv (1).cod_tipserv := cv_tip_serv;
            em_ga_actuaserv (1).cod_servicio :=
                                         em_ga_grupos_servsu (i).cod_servicio;
            em_ga_actuaserv (1).cod_actabo := cv_act_frm;

            IF NOT pv_rec_actuaserv_frm_fn (em_ga_actuaserv,
                                            sn_cod_retorno,
                                            sv_mens_retorno,
                                            lv_ssql
                                           )
            THEN
               RAISE error_funcion;
            END IF;

            em_ga_servsupl (1).cod_producto := cn_producto;
            em_ga_servsupl (1).cod_servicio :=
                                          em_ga_grupos_servsu (i).cod_servicio;
            em_ga_servsupl (1).cod_nivel := cn_cero;

            IF NOT pv_rec_servspl_frm_fn (em_ga_servsupl,
                                          sn_cod_retorno,
                                          sv_mens_retorno,
                                          lv_ssql
                                         )
            THEN
               RAISE error_funcion;
            END IF;

            em_ga_servsuplabo (i).num_abonado := eo_servfrec.num_abonado;
            em_ga_servsuplabo (i).cod_servicio :=
                                          em_ga_grupos_servsu (i).cod_servicio;
            em_ga_servsuplabo (i).fec_altabd := SYSDATE;
            em_ga_servsuplabo (i).fec_altacen := SYSDATE;
            em_ga_servsuplabo (i).cod_servsupl :=
                                               em_ga_servsupl (1).cod_servsupl;
            em_ga_servsuplabo (i).cod_nivel := em_ga_servsupl (1).cod_nivel;
            em_ga_servsuplabo (i).cod_producto :=
                                               em_ga_servsupl (1).cod_producto;
            em_ga_servsuplabo (i).num_terminal := eo_servfrec.num_celular;
            em_ga_servsuplabo (i).nom_usuarora := eo_servfrec.nom_usuarora;
            em_ga_servsuplabo (i).cod_concepto :=
                                              em_ga_actuaserv (1).cod_concepto;
            em_ga_servsuplabo (i).num_diasnum :=
                                     pv_rec_secuencia_fn ('GA_SEQ_NUMDIASNUM');
            em_ga_servsuplabo (i).ind_estado := cn_tip_estado;

            IF NOT pr_reg_servsuplabo_fn (em_ga_servsuplabo,
                                          sn_cod_retorno,
                                          sv_mens_retorno,
                                          lv_ssql
                                         )
            THEN
               RAISE error_funcion;
            END IF;

            em_ga_abon_serv (1).num_abonado := eo_servfrec.num_abonado;
            em_ga_abon_serv (1).cod_situacion := cv_sit_baja;

            IF NOT pv_rec_abonserv_fn (em_ga_abon_serv,
                                       sn_cod_retorno,
                                       sv_mens_retorno,
                                       lv_ssql
                                      )
            THEN
               RAISE error_funcion;
            END IF;

            lv_cadena := '';
            lv_cadena :=
                  LPAD (em_ga_servsupl (1).cod_servsupl, 2, '0')
               || LPAD (em_ga_servsupl (1).cod_nivel, 4, '0');
            ln_largo :=
                LENGTH (REPLACE (em_ga_abon_serv (1).clase_servicio, ' ', ''));
            lv_cadena_serv := '';
            x := 0;

            WHILE (ln_largo >= x)
            LOOP
               x := x + 6;

               IF REPLACE (SUBSTR (em_ga_abon_serv (1).clase_servicio, x, 6),
                           ' ',
                           ''
                          ) <> REPLACE (lv_cadena, ' ', '')
               THEN
                  lv_cadena_serv :=
                        lv_cadena_serv
                     || SUBSTR (em_ga_abon_serv (1).clase_servicio, x, 6);
               END IF;
            END LOOP;

            ln_largo :=
                LENGTH (REPLACE (em_ga_abon_serv (1).perfil_abonado, ' ', ''));
            lv_cadena_perf := '';
            x := 0;

            WHILE (ln_largo >= x)
            LOOP
               x := x + 6;

               IF REPLACE (SUBSTR (em_ga_abon_serv (1).perfil_abonado, x, 6),
                           ' ',
                           ''
                          ) <> REPLACE (lv_cadena, ' ', '')
               THEN
                  lv_cadena_perf :=
                        lv_cadena_perf
                     || SUBSTR (em_ga_abon_serv (1).perfil_abonado, x, 6);
               END IF;
            END LOOP;

            em_ga_abon_serv (1).clase_servicio := lv_cadena_serv || lv_cadena;
            em_ga_abon_serv (1).perfil_abonado := lv_cadena_perf || lv_cadena;
            em_ga_abon_serv (1).cod_situacion := cv_sit_baja;

            IF NOT pv_act_abonserv_fn (em_ga_abon_serv,
                                       sn_cod_retorno,
                                       sv_mens_retorno,
                                       lv_ssql
                                      )
            THEN
               RAISE error_funcion;
            END IF;

            em_ga_intarcel (1).num_abonado := eo_servfrec.num_abonado;
            em_ga_intarcel (1).cod_cliente := eo_servfrec.cod_cliente;
            em_ga_intarcel (1).ind_friends := cn_ind_frf;

            IF NOT pv_act_intarcel_fn (em_ga_intarcel,
                                       sn_cod_retorno,
                                       sv_mens_retorno,
                                       lv_ssql
                                      )
            THEN
               RAISE error_funcion;
            END IF;

            IF (    (eo_frecuentes_lst.FIRST IS NOT NULL)
                AND (eo_frecuentes_lst.LAST IS NOT NULL)
               )
            THEN
               FOR k IN 1 .. eo_frecuentes_lst.LAST
               LOOP
                  em_ga_numespabo (1).num_abonado := eo_servfrec.num_abonado;
                  em_ga_numespabo (1).num_telefesp :=
                                          eo_frecuentes_lst (k).num_frecuente;

                  IF pv_val_numfrec_fn (em_ga_numespabo,
                                        sn_cod_retorno,
                                        sv_mens_retorno,
                                        lv_ssql
                                       )
                  THEN
                     em_ga_numespabo (1).num_diasnum :=
                                            em_ga_servsuplabo (i).num_diasnum;
                     em_ga_numespabo (1).tip_frecuente :=
                                          eo_frecuentes_lst (k).tip_frecuente;

                     IF NOT pr_reg_numespabo_fn (em_ga_numespabo,
                                                 sn_cod_retorno,
                                                 sv_mens_retorno,
                                                 lv_ssql
                                                )
                     THEN
                        RAISE error_funcion;
                     END IF;
                  END IF;
               END LOOP;
            ELSE
               em_numfrec (1).cod_cliente := eo_servfrec.cod_cliente;
               em_numfrec (1).ind_ff := cn_ind_frf;

               IF NOT pv_rec_numfrec_frm_fn (em_numfrec,
                                             sn_cod_retorno,
                                             sv_mens_retorno,
                                             lv_ssql
                                            )
               THEN
                  RAISE exit_funtion;
               END IF;

               FOR k IN 1 .. em_numfrec.COUNT
               LOOP
                  em_ga_numespabo (1).num_abonado := eo_servfrec.num_abonado;
                  em_ga_numespabo (1).num_telefesp :=
                                                  em_numfrec (k).num_telefesp;

                  IF pv_val_numfrec_fn (em_ga_numespabo,
                                        sn_cod_retorno,
                                        sv_mens_retorno,
                                        lv_ssql
                                       )
                  THEN
                     em_ga_numespabo (1).num_diasnum :=
                                            em_ga_servsuplabo (i).num_diasnum;
                     em_ga_numespabo (1).tip_frecuente :=
                                                 em_numfrec (k).tip_frecuente;

                     IF NOT pr_reg_numespabo_fn (em_ga_numespabo,
                                                 sn_cod_retorno,
                                                 sv_mens_retorno,
                                                 lv_ssql
                                                )
                     THEN
                        RAISE error_funcion;
                     END IF;
                  END IF;
               END LOOP;
            END IF;
         END LOOP;
      ELSE
         RAISE error_funcion;
      END IF;
   EXCEPTION
      WHEN exit_funtion
      THEN
         sn_cod_retorno := 0;
         sv_mens_retorno := NULL;
         sn_num_evento := 0;
      WHEN error_funcion
      THEN
         lv_des_error := 'PV_REG_FREC_ONLINE_PR;';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, lv_mens_retorno)
         THEN
            sv_mens_retorno := sv_mens_retorno || ':' || lv_mens_retorno;
         END IF;

         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    cv_cod_modulo,
                                    sv_mens_retorno,
                                    cv_version,
                                    USER,
                                    'PV_REG_FREC_PROGRAMADOS_PR',
                                    lv_ssql,
                                    sn_cod_retorno,
                                    lv_des_error
                                   );
   END pv_reg_frec_online_pr;

--Nuevo...
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pr_rec_servsuplabo_fn (
      em_tabla          IN OUT NOCOPY   tip_ga_servsuplabo,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sv_sql            OUT NOCOPY      ge_evento_detalle_to.QUERY%TYPE
   )
      RETURN BOOLEAN
   IS
      ln_num_abonado    ga_servsuplabo.num_abonado%TYPE;
      lv_cod_servicio   ga_servsuplabo.cod_servicio%TYPE;
      ln_ind_estado     ga_servsuplabo.ind_estado%TYPE;
      error_funcion     EXCEPTION;
   BEGIN
      ln_num_abonado := em_tabla (1).num_abonado;
      lv_cod_servicio := em_tabla (1).cod_servicio;
      ln_ind_estado := em_tabla (1).ind_estado;
      sv_sql := ' SELECT  serv.num_abonado';
      sv_sql := sv_sql || ' ,serv.cod_servicio';
      sv_sql := sv_sql || ' ,serv.fec_altabd';
      sv_sql := sv_sql || ' ,serv.cod_servsupl';
      sv_sql := sv_sql || ' ,serv.cod_nivel';
      sv_sql := sv_sql || ' ,serv.cod_producto';
      sv_sql := sv_sql || ' ,serv.num_terminal';
      sv_sql := sv_sql || ' ,serv.nom_usuarora';
      sv_sql := sv_sql || ' ,serv.ind_estado';
      sv_sql := sv_sql || ' ,serv.fec_altacen';
      sv_sql := sv_sql || ' ,serv.fec_bajabd';
      sv_sql := sv_sql || ' ,serv.fec_bajacen';
      sv_sql := sv_sql || ' ,serv.cod_concepto';
      sv_sql := sv_sql || ' ,serv.num_diasnum';
      sv_sql := sv_sql || ' FROM    ga_servsuplabo serv';
      sv_sql := sv_sql || ' WHERE   serv.num_abonado   = ' || ln_num_abonado;
      sv_sql :=
         sv_sql || ' AND     serv.cod_servicio     =''' || lv_cod_servicio
         || '''';
      sv_sql := sv_sql || ' AND     serv.ind_estado    < ' || ln_ind_estado;

      SELECT serv.num_abonado,
             serv.cod_servicio,
             serv.fec_altabd,
             serv.cod_servsupl,
             serv.cod_nivel,
             serv.cod_producto,
             serv.num_terminal,
             serv.nom_usuarora,
             serv.ind_estado,
             serv.fec_altacen,
             serv.fec_bajabd,
             serv.fec_bajacen,
             serv.cod_concepto,
             serv.num_diasnum,
-- Se incluyen campos nuevos P-MIX-09003
             serv.cod_prioridad,
             serv.ind_desborde
-- Fin
      BULK COLLECT INTO em_tabla
        FROM ga_servsuplabo serv
       WHERE serv.num_abonado = ln_num_abonado
         AND serv.cod_servicio = lv_cod_servicio
         AND serv.ind_estado < ln_ind_estado;

      IF em_tabla.COUNT = 0
      THEN
         RAISE error_funcion;
      END IF;

      RETURN TRUE;
   EXCEPTION
      WHEN error_funcion
      THEN
         sn_cod_retorno := 150;
         sv_mens_retorno :=
               'PR_REC_SERVSUPLABO_FN'
            || ' : '
            || 'Error no se encontro códigos de servicio';
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := SQLCODE;
         sv_mens_retorno := 'PR_REC_SERVSUPLABO_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pr_rec_servsuplabo_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_aboncel_fn (
      em_tabla          IN OUT NOCOPY   tip_abon_cel_list,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sv_sql            OUT NOCOPY      ge_evento_detalle_to.QUERY%TYPE
   )
      RETURN BOOLEAN
   IS
      ln_num_abonado   ga_abocel.num_abonado%TYPE;
      ln_cod_cliente   ga_abocel.cod_cliente%TYPE;
      exit_funtion     EXCEPTION;
   BEGIN
      ln_cod_cliente := em_tabla (1).cod_cliente;
      ln_num_abonado := em_tabla (1).num_abonado;
      sv_sql := ' SELECT  SELECT  abo.num_abonado';
      sv_sql := sv_sql || ' ,abo.num_celular';
      sv_sql := sv_sql || ' ,abo.cod_cliente';
      sv_sql := sv_sql || ' FROM    ga_abocel abo';
      sv_sql := sv_sql || ' WHERE   abo.num_abonado      <> ' || ln_num_abonado;
      sv_sql := sv_sql || ' AND     abo.cod_cliente       = ' || ln_cod_cliente;
      sv_sql :=
            sv_sql
         || ' AND     abo.cod_situacion NOT IN ('''
         || cv_sit_baja
         || ''','''
         || cv_sit_baja_proceso
         || ''')';

      SELECT abo.num_abonado,
             abo.num_celular,
             abo.cod_cliente
      BULK COLLECT INTO em_tabla
        FROM ga_abocel abo
       WHERE abo.num_abonado <> ln_num_abonado
         AND abo.cod_cliente = ln_cod_cliente
         AND abo.cod_situacion NOT IN (cv_sit_baja, cv_sit_baja_proceso);

      IF em_tabla.COUNT = 0
      THEN
         RAISE exit_funtion;
      END IF;

      RETURN TRUE;
   EXCEPTION
      WHEN exit_funtion
      THEN
--        SN_cod_retorno    := 203;
--        SV_mens_retorno := 'PV_REC_ABONCEL_FN' ||' : '||'Error no se encontro clases de servicio';
         sn_cod_retorno := 0;
         sv_mens_retorno := NULL;
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := SQLCODE;
         sv_mens_retorno := 'PV_REC_ABONCEL_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_rec_aboncel_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_val_empresa_fn (
      en_cod_cliente    IN              ga_empresa.cod_cliente%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sv_sql            OUT NOCOPY      ge_evento_detalle_to.QUERY%TYPE
   )
      RETURN BOOLEAN
   IS
      ln_existe   NUMBER;
   BEGIN
      sv_sql := '    SELECT COUNT(0)';
      sv_sql := sv_sql || 'FROM   ga_empresa num';
      sv_sql := sv_sql || 'WHERE  num.cod_cliente =' || en_cod_cliente;

      SELECT COUNT (0)
        INTO ln_existe
        FROM ga_empresa num
       WHERE num.cod_cliente = en_cod_cliente;

      IF ln_existe > 0
      THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 1155;
         sv_mens_retorno := 'PV_VAL_EMPRESA_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_val_empresa_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_reg_frec_ff_online_pr (
      eo_servfrec         IN              pv_desact_servfrec_qt,
      eo_frecuentes_lst   IN              pv_frecuentes_lst_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_des_error          ge_errores_pg.desevent;
      lv_ssql               ge_errores_pg.vquery;
      i                     NUMBER;
      x                     NUMBER;
      k                     NUMBER;
      em_ga_grupos_servsu   tip_ga_grupos_servsup;
      em_ga_servsuplabo     tip_ga_servsuplabo;
      em_abon_cel_list      tip_abon_cel_list;
      em_ga_numespabo       tip_ga_numespabo;
      lv_mens_retorno       ge_errores_td.det_msgerror%TYPE;
      error_funcion         EXCEPTION;
      exit_funtion          EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF cn_cero = eo_servfrec.ind_ff
      THEN
         RAISE exit_funtion;
      END IF;

      IF NOT pv_val_empresa_fn (eo_servfrec.cod_cliente,
                                sn_cod_retorno,
                                sv_mens_retorno,
                                lv_ssql
                               )
      THEN
         RAISE exit_funtion;
      END IF;

--    FOR i IN 1..EO_FRECUENTES_LST.LAST LOOP
--       IF EO_SERVFREC.IND_FF = CN_IND_FRF THEN
      IF NOT pv_rec_grpsersupl_frm_fn (em_ga_grupos_servsu,
                                       sn_cod_retorno,
                                       sv_mens_retorno,
                                       lv_ssql
                                      )
      THEN
         RAISE error_funcion;
      END IF;

      FOR k IN 1 .. em_ga_grupos_servsu.COUNT
      LOOP
         em_abon_cel_list (1).num_abonado := eo_servfrec.num_abonado;
         em_abon_cel_list (1).cod_cliente := eo_servfrec.cod_cliente;

         IF pv_rec_aboncel_fn (em_abon_cel_list,
                               sn_cod_retorno,
                               sv_mens_retorno,
                               lv_ssql
                              )
         THEN
            em_ga_servsuplabo (1).cod_servicio :=
                                         em_ga_grupos_servsu (k).cod_servicio;
            em_ga_servsuplabo (1).ind_estado := cn_atrib_estado_3;

            FOR x IN 1 .. em_abon_cel_list.COUNT
            LOOP
               em_ga_servsuplabo (1).num_abonado := eo_servfrec.num_abonado;

               IF pr_rec_servsuplabo_fn (em_ga_servsuplabo,
                                         sn_cod_retorno,
                                         sv_mens_retorno,
                                         lv_ssql
                                        )
               THEN
                  em_ga_numespabo (1).num_abonado := eo_servfrec.num_abonado;
                  em_ga_numespabo (1).num_telefesp :=
                                             em_abon_cel_list (x).num_celular;

                  IF pv_val_numfrec_fn (em_ga_numespabo,
                                        sn_cod_retorno,
                                        sv_mens_retorno,
                                        lv_ssql
                                       )
                  THEN
                     em_ga_numespabo (1).num_diasnum :=
                                            em_ga_servsuplabo (1).num_diasnum;
                     em_ga_numespabo (1).tip_frecuente := cv_tip_frec_m;

                     IF NOT pr_reg_numespabo_fn (em_ga_numespabo,
                                                 sn_cod_retorno,
                                                 sv_mens_retorno,
                                                 lv_ssql
                                                )
                     THEN
                        RAISE error_funcion;
                     END IF;
                  END IF;

                  em_ga_servsuplabo (1).num_abonado :=
                                              em_abon_cel_list (x).num_abonado;

                  IF NOT pr_rec_servsuplabo_fn (em_ga_servsuplabo,
                                                sn_cod_retorno,
                                                sv_mens_retorno,
                                                lv_ssql
                                               )
                  THEN
                     em_ga_servsuplabo (1).num_diasnum :=
                                              em_ga_numespabo (1).num_diasnum;
                  END IF;

                  em_ga_numespabo (1).num_abonado :=
                                              em_abon_cel_list (x).num_abonado;
                  em_ga_numespabo (1).num_telefesp := eo_servfrec.num_celular;

                  IF pv_val_numfrec_fn (em_ga_numespabo,
                                        sn_cod_retorno,
                                        sv_mens_retorno,
                                        lv_ssql
                                       )
                  THEN
                     em_ga_numespabo (1).num_diasnum :=
                                            em_ga_servsuplabo (1).num_diasnum;
                     em_ga_numespabo (1).tip_frecuente := cv_tip_frec_m;

                     IF NOT pr_reg_numespabo_fn (em_ga_numespabo,
                                                 sn_cod_retorno,
                                                 sv_mens_retorno,
                                                 lv_ssql
                                                )
                     THEN
                        RAISE error_funcion;
                     END IF;
                  END IF;
               END IF;
            END LOOP;                                                 -- FOR x
         END IF;
      END LOOP;                                                       -- FOR k
--       END IF;
--    END LOOP;
   EXCEPTION
      WHEN exit_funtion
      THEN
         sn_cod_retorno := 0;
         sv_mens_retorno := NULL;
         sn_num_evento := 0;
      WHEN error_funcion
      THEN
         lv_des_error := 'PV_REG_FREC_FF_ONLINE_PR;';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, lv_mens_retorno)
         THEN
            sv_mens_retorno := sv_mens_retorno || ':' || lv_mens_retorno;
         END IF;

         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    cv_cod_modulo,
                                    sv_mens_retorno,
                                    cv_version,
                                    USER,
                                    'PV_REG_FREC_FF_ONLINE_PR',
                                    lv_ssql,
                                    sn_cod_retorno,
                                    lv_des_error
                                   );
   END pv_reg_frec_ff_online_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_del_numespabo_fn (
      em_tabla          IN              tip_ga_numespabo,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sv_sql            OUT NOCOPY      ge_evento_detalle_to.QUERY%TYPE
   )
      RETURN BOOLEAN
   IS
      ln_num_abonado   ga_servsuplabo.num_abonado%TYPE;
      error_funcion    EXCEPTION;
   BEGIN
      ln_num_abonado := em_tabla (1).num_abonado;
      sv_sql := '    DELETE  FROM ga_numespabo abo';
      sv_sql := sv_sql || ' WHERE  abo.num_abonado  =   ' || ln_num_abonado;

      DELETE FROM ga_numespabo abo
            WHERE abo.num_abonado = ln_num_abonado;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 2;
         sv_mens_retorno := 'PV_DEL_NUMESPABO_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_del_numespabo_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_act_servsuplabo_fn (
      em_tabla          IN              tip_ga_servsuplabo,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sv_sql            OUT NOCOPY      ge_evento_detalle_to.QUERY%TYPE
   )
      RETURN BOOLEAN
   IS
      lv_cod_servicio   ga_servsuplabo.cod_servicio%TYPE;
      ln_num_abonado    ga_servsuplabo.num_abonado%TYPE;
      ln_ind_estado     ga_servsuplabo.ind_estado%TYPE;
      lv_sysdate        VARCHAR2 (20);
      error_funcion     EXCEPTION;
   BEGIN
      lv_cod_servicio := em_tabla (1).cod_servicio;
      ln_num_abonado := em_tabla (1).num_abonado;
      ln_ind_estado := em_tabla (1).ind_estado;
      lv_sysdate := TO_CHAR (SYSDATE, cv_formato_fecha);
      sv_sql := '    UPDATE ga_servsuplabo abo';
      sv_sql :=
           sv_sql || ' SET    abo.ind_estado   = ''' || ln_ind_estado || '''';
      sv_sql :=
              sv_sql || ' ,         abo.fec_bajabd   = ''' || lv_sysdate || '''';
      sv_sql :=
              sv_sql || ' ,         abo.fec_bajacen  = ''' || lv_sysdate || '''';
      sv_sql := sv_sql || ' WHERE  abo.num_abonado  =   ' || ln_num_abonado;
      sv_sql :=
         sv_sql || ' AND    abo.cod_servicio = ''' || lv_cod_servicio || '''';
      sv_sql := sv_sql || ' AND    abo.ind_estado   <   ' || cn_tip_estado_3;

      UPDATE ga_servsuplabo abo
         SET abo.ind_estado = ln_ind_estado,
             abo.fec_bajabd = SYSDATE,
             abo.fec_bajacen = SYSDATE
       WHERE abo.num_abonado = ln_num_abonado
         AND abo.cod_servicio = lv_cod_servicio
         AND abo.ind_estado < cn_tip_estado_3;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 2;
         sv_mens_retorno := 'PV_ACT_SERVSUPLABO_FN' || ' : ' || SQLERRM;
         RETURN FALSE;
   END pv_act_servsuplabo_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_eli_frec_online_pr (
      eo_servfrec       IN              pv_desact_servfrec_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_des_error          ge_errores_pg.desevent;
      lv_ssql               ge_errores_pg.vquery;
      lv_cadena             VARCHAR2 (1000);
      lv_cadena_serv        VARCHAR2 (1000);
      lv_cadena_perf        VARCHAR2 (1000);
      ln_largo              NUMBER;
      i                     NUMBER;
      x                     NUMBER;
      em_ga_grupos_servsu   tip_ga_grupos_servsup;
      em_ga_servsuplabo     tip_ga_servsuplabo;
      em_ga_servsupl        tip_ga_servsupl;
      em_ga_abon_serv       tip_abon_serv_list;
      em_ga_intarcel        tip_ga_intarcel;
      em_ga_numespabo       tip_ga_numespabo;
      lv_mens_retorno       ge_errores_td.det_msgerror%TYPE;
      error_funcion         EXCEPTION;
      exit_funtion          EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF pv_rec_grpsersupl_frm_fn (em_ga_grupos_servsu,
                                   sn_cod_retorno,
                                   sv_mens_retorno,
                                   lv_ssql
                                  )
      THEN
         FOR i IN 1 .. em_ga_grupos_servsu.COUNT
         LOOP
            em_ga_servsuplabo (1).num_abonado := eo_servfrec.num_abonado;
            em_ga_servsuplabo (1).cod_servicio :=
                                         em_ga_grupos_servsu (1).cod_servicio;
            em_ga_servsuplabo (1).ind_estado := cn_tip_estado_4;

            IF NOT pv_act_servsuplabo_fn (em_ga_servsuplabo,
                                          sn_cod_retorno,
                                          sv_mens_retorno,
                                          lv_ssql
                                         )
            THEN
               RAISE error_funcion;
            END IF;

            em_ga_abon_serv (1).num_abonado := eo_servfrec.num_abonado;
            em_ga_abon_serv (1).cod_situacion := cv_sit_baja;

            IF NOT pv_rec_abonserv_fn (em_ga_abon_serv,
                                       sn_cod_retorno,
                                       sv_mens_retorno,
                                       lv_ssql
                                      )
            THEN
               RAISE error_funcion;
            END IF;

            em_ga_servsupl (1).cod_producto := cn_producto;
            em_ga_servsupl (1).cod_servicio :=
                                          em_ga_grupos_servsu (i).cod_servicio;
            em_ga_servsupl (1).cod_nivel := cn_cero;

            IF NOT pv_rec_servspl_frm_fn (em_ga_servsupl,
                                          sn_cod_retorno,
                                          sv_mens_retorno,
                                          lv_ssql
                                         )
            THEN
               RAISE error_funcion;
            END IF;

            lv_cadena := '';
            lv_cadena :=
                  LPAD (em_ga_servsupl (1).cod_servsupl, 2, '0')
               || LPAD (em_ga_servsupl (1).cod_nivel, 4, '0');
            ln_largo :=
                LENGTH (REPLACE (em_ga_abon_serv (1).clase_servicio, ' ', ''));
            lv_cadena_serv := '';
            x := 0;

            WHILE (ln_largo >= x)
            LOOP
               x := x + 6;

               IF REPLACE (SUBSTR (em_ga_abon_serv (1).clase_servicio, x, 6),
                           ' ',
                           ''
                          ) <> REPLACE (lv_cadena, ' ', '')
               THEN
                  lv_cadena_serv :=
                        lv_cadena_serv
                     || SUBSTR (em_ga_abon_serv (1).clase_servicio, x, 6);
               END IF;
            END LOOP;

            ln_largo :=
                LENGTH (REPLACE (em_ga_abon_serv (1).perfil_abonado, ' ', ''));
            lv_cadena_perf := '';
            x := 0;

            WHILE (ln_largo >= x)
            LOOP
               x := x + 6;

               IF REPLACE (SUBSTR (em_ga_abon_serv (1).perfil_abonado, x, 6),
                           ' ',
                           ''
                          ) <> REPLACE (lv_cadena, ' ', '')
               THEN
                  lv_cadena_perf :=
                        lv_cadena_perf
                     || SUBSTR (em_ga_abon_serv (1).perfil_abonado, x, 6);
               END IF;
            END LOOP;

            em_ga_abon_serv (1).clase_servicio := lv_cadena_serv;
            em_ga_abon_serv (1).perfil_abonado := lv_cadena_perf;
            em_ga_abon_serv (1).cod_situacion := cv_sit_baja;

            IF NOT pv_act_abonserv_fn (em_ga_abon_serv,
                                       sn_cod_retorno,
                                       sv_mens_retorno,
                                       lv_ssql
                                      )
            THEN
               RAISE error_funcion;
            END IF;

            em_ga_intarcel (1).num_abonado := eo_servfrec.num_abonado;
            em_ga_intarcel (1).cod_cliente := eo_servfrec.cod_cliente;
            em_ga_intarcel (1).ind_friends := cn_cero;

            IF NOT pv_act_intarcel_fn (em_ga_intarcel,
                                       sn_cod_retorno,
                                       sv_mens_retorno,
                                       lv_ssql
                                      )
            THEN
               RAISE error_funcion;
            END IF;

            em_ga_numespabo (1).num_abonado := eo_servfrec.num_abonado;

            IF NOT pv_del_numespabo_fn (em_ga_numespabo,
                                        sn_cod_retorno,
                                        sv_mens_retorno,
                                        lv_ssql
                                       )
            THEN
               RAISE error_funcion;
            END IF;
         END LOOP;
      ELSE
      
        IF(sn_cod_retorno = 214) THEN
        
            sn_cod_retorno := 0;
            sv_mens_retorno := NULL;
            sn_num_evento := 0;
      
        ELSE
         RAISE error_funcion;
        
        END IF;
        
      END IF;
     
   END pv_eli_frec_online_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_reg_frec_ff_programados_pr (
      eo_servfrec       IN              pv_desact_servfrec_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
/*
   <Documentacion TipoDoc = "Funcion">
   <Elemento Nombre = "PV_REG_FREC_FF_PROGRAMADOS_PR "
    Lenguaje="PL/SQL" Fecha="10-08-2007"
    Versión"1.0.0" Dise+ador"****"
    Programador="" Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion>   Funcion que inserta los número frecuentes </Descripcion>
   <Parametros>
   <Entrada>
         <param nom="EO_SERVFREC"    Tipo="PV_DESACT_SERVFREC_QT" > Datos de Estructura  </param>>
   </Entrada>
            <Salida>
               <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo de Retorno         </param>>
               <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje de Retorno        </param>>
               <param nom="SN_num_evento"             Tipo="NUMERICO">Numero de Evento       </param>>
            </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
   */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql := ' INSERT INTO ga_frec_ciclo (num_abonado';
      lv_ssql := lv_ssql || ' ,cod_ciclfact';
      lv_ssql := lv_ssql || ' ,cod_plantarif';
      lv_ssql := lv_ssql || ' ,tip_frecuente';
      lv_ssql := lv_ssql || ' ,num_frecuente)';
      lv_ssql := lv_ssql || ' select  a.num_abonado';
      lv_ssql := lv_ssql || ' ,''' || eo_servfrec.cod_plantarif_nuevo || '''';
      lv_ssql := lv_ssql || ' ,' || eo_servfrec.cod_ciclfact;
      lv_ssql := lv_ssql || ' ,''' || cn_tiprango || '''';
      lv_ssql := lv_ssql || ' ,b.num_celular';
      lv_ssql := lv_ssql || ' from   ga_abocel a,ga_abocel b';
      lv_ssql :=
         lv_ssql || ' where  a.cod_cliente        ='
         || eo_servfrec.cod_cliente;
      lv_ssql :=
            lv_ssql
         || ' and    a.cod_situacion not in ('''
         || cv_sit_baja
         || ','
         || ''''
         || cv_sit_baja_proceso
         || ''')';
      lv_ssql := lv_ssql || ' and    b.cod_cliente        = a.cod_cliente';
      lv_ssql := lv_ssql || ' and    b.num_abonado       <> a.num_abonado';
      lv_ssql :=
            lv_ssql
         || ' and    b.cod_situacion not in ('''
         || cv_sit_baja
         || ','
         || ''''
         || cv_sit_baja_proceso
         || ''')';
      lv_ssql := lv_ssql || ' and    not exists (select  frec.num_abonado';
      lv_ssql := lv_ssql || '                           from    ga_frec_ciclo frec';
      lv_ssql :=
           lv_ssql || '                           where   frec.num_abonado   = a.num_abonado';
      lv_ssql :=
          lv_ssql || '                           and     frec.num_frecuente = b.num_celular)';

      INSERT INTO ga_frec_ciclo
                  (num_abonado, cod_ciclfact, cod_plantarif, tip_frecuente,
                   num_frecuente)
         SELECT a.num_abonado, eo_servfrec.cod_ciclfact,
                eo_servfrec.cod_plantarif_nuevo, cn_tiprango, b.num_celular
           FROM ga_abocel a, ga_abocel b
          WHERE a.cod_cliente = eo_servfrec.cod_cliente
            AND a.cod_situacion NOT IN (cv_sit_baja, cv_sit_baja_proceso)
            AND b.cod_cliente = a.cod_cliente
            AND b.num_abonado <> a.num_abonado
            AND b.cod_situacion NOT IN (cv_sit_baja, cv_sit_baja_proceso)
            AND NOT EXISTS (
                   SELECT frec.num_abonado
                     FROM ga_frec_ciclo frec
                    WHERE frec.num_abonado = a.num_abonado
                      AND frec.num_frecuente = b.num_celular);
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 4;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error := 'PV_REG_FREC_PROGRAMADOS_PR (); ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    cv_cod_modulo,
                                    sv_mens_retorno,
                                    cv_version,
                                    USER,
                                    'PV_REG_FREC_PROGRAMADOS_PR',
                                    lv_ssql,
                                    sn_cod_retorno,
                                    lv_des_error
                                   );
   END pv_reg_frec_ff_programados_pr;

---------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_validareversa_pr (
      eo_orden_servicio   IN OUT          pv_orden_servicio_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   IS
/*
   <Documentacion TipoDoc = "Procedimiento">
   <Elemento Nombre = "PV_VALIDAREVERSA_PR "
    Lenguaje="PL/SQL" Fecha="28-02-2008"
    Versión"1.0.0" Dise+ador"****"
    Programador="" Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion>   PV_VALIDAREVERSA_PR  </Descripcion>
   <Parametros>
   <Entrada>
         <param nom="EO_ORDEN_SERVICIO "   Tipo="Estructura Type PV_ORDEN_SERVICIO_QT"> Datos de Estructura  </param>>
   </Entrada>
            <Salida>
             <param nom="SO_GA_ABONADO"         Tipo="NUMERICO">Codigo de Retorno         </param>>
               <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo de Retorno         </param>>
               <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje de Retorno        </param>>
               <param nom="SN_num_evento"             Tipo="NUMERICO">Numero de Evento       </param>>
            </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
   */
      lv_des_error         ge_errores_pg.desevent;
      lv_ssql              ge_errores_pg.vquery;
      error_ejecucion      EXCEPTION;
      ln_max_dias          NUMBER;
      lv_ooss_reversa      VARCHAR2 (20);
      lv_sigla_reversa     VARCHAR2 (20);
      lv_sigla_norctaseg   VARCHAR2 (20);
      lv_sigla_ctasegnor   VARCHAR2 (20);
      ln_filas             NUMBER;
   BEGIN
      --ln_max_dias := 60; --157833|16-12-2010|EFR
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      ln_filas := 0;
      
      --ini 157833|16-12-2010|EFR
      
      lv_ssql := ' SELECT VAL_PARAMETRO ';
      lv_ssql := lv_ssql || ' INTO LN_MAX_DIAS';
      lv_ssql := lv_ssql || ' FROM GED_PARAMETROS ';
      lv_ssql := lv_ssql || ' WHERE NOM_PARAMETRO = "NUM_DIASCPLAN"';

      SELECT to_number(val_parametro)
        INTO LN_MAX_DIAS
        FROM ged_parametros
       WHERE nom_parametro = 'NUM_DIASCPLAN'
       AND      cod_modulo = 'GA';
       
      --fin 157833|16-12-2010|EFR
      
/* INI PARAMETROS */
   /*  NOM_PARAMETRO = 'OOSS_DE_REVERSA' */
      lv_ssql := ' SELECT VAL_PARAMETRO ';
      lv_ssql := lv_ssql || ' INTO LV_OOSS_REVERSA';
      lv_ssql := lv_ssql || ' FROM GED_PARAMETROS ';
      lv_ssql := lv_ssql || ' WHERE NOM_PARAMETRO = "OOSS_DE_REVERSA"';

      SELECT val_parametro
        INTO lv_ooss_reversa
        FROM ged_parametros
       WHERE nom_parametro = 'OOSS_DE_REVERSA';

      /*  NOM_PARAMETRO = 'REVERSA_NCT_O_CTN' */
      lv_ssql := ' SELECT VAL_PARAMETRO ';
      lv_ssql := lv_ssql || ' INTO LV_SIGLA_REVERSA';
      lv_ssql := lv_ssql || ' FROM GED_PARAMETROS ';
      lv_ssql := lv_ssql || ' WHERE NOM_PARAMETRO = "REVERSA_NCT_O_CTN"';

      SELECT val_parametro
        INTO lv_sigla_reversa
        FROM ged_parametros
       WHERE nom_parametro = 'REVERSA_NCT_O_CTN';

      /*  NOM_PARAMETRO = 'PLAN_NOR_A_CUE_TOT'*/
      lv_ssql := ' SELECT VAL_PARAMETRO ';
      lv_ssql := lv_ssql || ' INTO LV_SIGLA_NORCTASEG';
      lv_ssql := lv_ssql || ' FROM GED_PARAMETROS ';
      lv_ssql := lv_ssql || ' WHERE NOM_PARAMETRO = "PLAN_NOR_A_CUE_TOT"';

      SELECT val_parametro
        INTO lv_sigla_norctaseg
        FROM ged_parametros
       WHERE nom_parametro = 'PLAN_NOR_A_CUE_TOT';

      /*  NOM_PARAMETRO = 'PLAN_CUE_TOT_A_NOR' */
      lv_ssql := ' SELECT VAL_PARAMETRO ';
      lv_ssql := lv_ssql || ' INTO LV_SIGLA_CTASEGNOR';
      lv_ssql := lv_ssql || ' FROM GED_PARAMETROS ';
      lv_ssql := lv_ssql || ' WHERE NOM_PARAMETRO = "PLAN_CUE_TOT_A_NOR"';

      SELECT val_parametro
        INTO lv_sigla_ctasegnor
        FROM ged_parametros
       WHERE nom_parametro = 'PLAN_CUE_TOT_A_NOR';

/* FIN PARAMETROS */
      lv_ssql := ' SELECT 1 INTO LN_FILAS FROM GA_TRASPABO A';
      lv_ssql :=
           lv_ssql || ' WHERE NUM_ABONADO = ' || eo_orden_servicio.num_abonado;
      lv_ssql := lv_ssql || ' AND FEC_MODIFICA > SYSDATE - ' || ln_max_dias;
      lv_ssql :=
            lv_ssql
         || ' AND IND_TRASPASO IN ('
         || lv_sigla_norctaseg
         || ','
         || lv_sigla_ctasegnor
         || ','
         || lv_sigla_reversa
         || ')';
      lv_ssql :=
            lv_ssql
         || ' AND FEC_MODIFICA IN (SELECT MAX(FEC_MODIFICA) FROM GA_TRASPABO ';
      lv_ssql :=
           lv_ssql || ' WHERE NUM_ABONADO = ' || eo_orden_servicio.num_abonado;
      lv_ssql := lv_ssql || ' AND FEC_MODIFICA > SYSDATE -' || ln_max_dias;
      lv_ssql :=
            lv_ssql
         || ' AND IND_TRASPASO IN  ('
         || lv_sigla_norctaseg
         || ','
         || lv_sigla_ctasegnor
         || ','
         || lv_sigla_reversa
         || '))';

      SELECT 1
        INTO ln_filas
        FROM ga_traspabo a
       WHERE num_abonado = eo_orden_servicio.num_abonado
         AND fec_modifica > SYSDATE - ln_max_dias
         AND ind_traspaso IN
                   (lv_sigla_norctaseg, lv_sigla_ctasegnor, lv_sigla_reversa)
         AND fec_modifica IN (
                SELECT MAX (fec_modifica)
                  FROM ga_traspabo
                 WHERE num_abonado = eo_orden_servicio.num_abonado
                   AND fec_modifica > SYSDATE - ln_max_dias
                   AND ind_traspaso IN
                          (lv_sigla_norctaseg,
                           lv_sigla_ctasegnor,
                           lv_sigla_reversa
                          ));

--si no encuentra registro
      IF eo_orden_servicio.cod_os <> lv_ooss_reversa AND ln_filas = 1
      THEN
         sn_cod_retorno := -1;
         --sv_mens_retorno :='Debe Realizar orden de Servicio de Reversa Cambio Plan'; --157833|21-12-2010|EFR
         sv_mens_retorno :='No puede hacer cambio de plan de regreso a plan anterior en menos de '|| ln_max_dias ||' días.'; --157833|21-12-2010|EFR 
      END IF;
   /*  IF LN_FILAS = 1 THEN
         EO_ORDEN_SERVICIO.COMBINATORIA := LV_SIGLA_REVERSA; -- sIndTraspaso = sSiglaReversa
     END IF;*/
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         IF eo_orden_servicio.cod_os = lv_ooss_reversa
         THEN
            sn_cod_retorno := -1;
            sv_mens_retorno :=
               'NO PUEDE REALIZAR ORDEN DE SERVICIO DE REVERSA CAMBIO PLAN. NO EXISTE CAMBIO DE PLAN EN LOS ULTIMOS 60 DíAS.';
         END IF;
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_ORDEN_SERVICIO_TMP_PG.PV_VALIDAREVERSA_PR('
            || eo_orden_servicio.num_abonado
            || ','
            || eo_orden_servicio.cod_os
            || ') '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                              (sn_num_evento,
                               cv_cod_modulo,
                               sv_mens_retorno,
                               cv_version,
                               USER,
                               'PV_ORDEN_SERVICIO_TMP_PG.PV_VALIDAREVERSA_PR',
                               lv_ssql,
                               sn_cod_retorno,
                               lv_des_error
                              );
   END pv_validareversa_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_act_uso_intarcel_pr (
      so_ga_abocel      IN              pv_ga_abocel_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
/*
   <Documentacion TipoDoc = "Procedimiento">
   <Elemento Nombre = "PV_ACT_USO_INTARCEL_PR "
    Lenguaje="PL/SQL" Fecha="11-04-2008"
    Versión"1.0.0" Dise+ador"Orlando Cabezas"
    Programador="" Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion>   Acualiza uso</Descripcion>
   <Parametros>
   <Entrada>
         <param nom="SO_GA_ABOCEL"   Tipo="Estructura Type PV_GA_ABOCEL_QT> Datos de Estructura  </param>>
   </Entrada>
            <Salida>
               <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo de Retorno         </param>>
               <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje de Retorno        </param>>
               <param nom="SN_num_evento"             Tipo="NUMERICO">Numero de Evento       </param>>
            </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
   */
      lv_des_error       ge_errores_pg.desevent;
      lv_ssql            ge_errores_pg.vquery;
      error_controlado   EXCEPTION;
      ln_cod_cliente     ga_intarcel.cod_cliente%TYPE;
      ln_num_abonado     ga_intarcel.num_abonado%TYPE;
      lv_cod_plantarif   ga_abocel.cod_plantarif%TYPE;
   BEGIN
      ln_cod_cliente := so_ga_abocel.cod_cliente;
      ln_num_abonado := so_ga_abocel.num_abonado;
      lv_cod_plantarif := so_ga_abocel.cod_plantarif;
      lv_ssql := '  UPDATE ga_intarcel intar';
      lv_ssql :=
         lv_ssql || ' intar.cod_uso       =  ''' || so_ga_abocel.cod_uso
         || '''';
      lv_ssql := lv_ssql || ' WHERE  intar.cod_cliente = ' || ln_cod_cliente;
      lv_ssql := lv_ssql || ' AND intar.num_abonado = ' || ln_num_abonado;
      lv_ssql :=
           lv_ssql || ' intar.cod_plantarif = ''' || lv_cod_plantarif || '''';

      UPDATE ga_intarcel intar
         SET intar.cod_uso = so_ga_abocel.cod_uso
       WHERE intar.cod_cliente = ln_cod_cliente
         AND intar.num_abonado = ln_num_abonado
         AND intar.cod_plantarif = lv_cod_plantarif;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'PV_ACT_USO_INTARCEL_PR ('
            || so_ga_abocel.num_abonado
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                               (sn_num_evento,
                                cv_cod_modulo,
                                sv_mens_retorno,
                                cv_version,
                                USER,
                                'pv_orden_servicio_pg.PV_ACT_USO_INTARCEL_FN',
                                lv_ssql,
                                sn_cod_retorno,
                                lv_des_error
                               );
   END pv_act_uso_intarcel_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_obtieneooss_pendplan_pr (
      eo_iorserv        IN OUT NOCOPY   pv_iorserv_qt,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   AS
/*--
<Documentacion TipoDoc = "Procedimiento">
      Elemento Nombre = "PV_OBTIENEOoSS_PENDPLAN_PR"
      Lenguaje="PL/SQL"
      Fecha="21-12-2007"
      Version="1.0.0"
      Dise?ador="Patricio Vargas"
      Programador="Patricio Vargas"
      Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
      Obtiene los cargos por Servicios Ocasionales
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_codproducto" Tipo="VARCHAR2"> codigo producto</param>
      </Entrada>
      <Salida>
                      <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos por servicios o </param>
      <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
      <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
      <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
</Documentacion>
--*/
      lv_codesql             ga_errores.cod_sqlcode%TYPE;
      lv_errmsql             ga_errores.cod_sqlerrm%TYPE;
      ln_numevento           NUMBER;
      lv_sql                 ge_errores_pg.vquery;
      lv_des_error           ge_errores_pg.desevent;
      lv_codmoneda           VARCHAR2 (20);
      lv_codservhab          VARCHAR2 (20);
      ln_contador            NUMBER;
      cv_modulo_pv           VARCHAR2 (25);
      no_data_found_cursor   EXCEPTION;
   BEGIN
      lv_sql :=
            'SELECT  C.NUM_ABONADO, C.NUM_CELULAR, I.NUM_OS, P.COD_PLANTARIF, '
         || ' P.COD_PLANTARIF_NUE, I.DESCRIPCION, I.FH_EJECUCION '
         || ' FROM  PV_IORSERV I, PV_CAMCOM C, PV_PARAM_ABOCEL P'
         || ' WHERE C.COD_CLIENTE          = '
         || eo_iorserv.cod_cliente
         || ' AND   I.COD_OS IN (10020,10022,10029,10233,10530,10539) '
         || ' AND   I.NUM_OSF_ERR         <> 1 '
         || ' AND   TRUNC(I.FH_EJECUCION) >= TRUNC(SYSDATE) '
         || ' AND   I.NUM_OS              IN (SELECT NUM_OS '
         || '                               FROM   PV_CAMCOM '
         || '                               WHERE  TRUNC(FEC_VENCIMIENTO) >= TRUNC(SYSDATE)) '
         || ' AND   I.COD_ESTADO          <= 210 '
         || ' AND   I.NUM_OS              = C.NUM_OS '
         || ' AND   C.NUM_OS              = P.NUM_OS ';

      OPEN sc_cursordatos FOR lv_sql;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'OTHERS:PV_OBTIENEOoSS_PENDPLAN_PR('
            || eo_iorserv.cod_cliente
            || ');- '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
               (sn_num_evento,
                cv_modulo_pv,
                sv_mens_retorno,
                '1.0',
                USER,
                   'PV_OBTIENEOoSS_PENDPLAN_PR.VE_List_cargos_Ocasionales_PR('
                || eo_iorserv.cod_cliente
                || ')',
                lv_sql,
                SQLCODE,
                lv_des_error
               );
         sv_mens_retorno := lv_sql;
   END pv_obtieneooss_pendplan_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_cnslta_combinatoria_pr (
      eo_combinatoria_os   IN OUT NOCOPY   pv_combinatoria_os_qt,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_des_error   ge_errores_pg.desevent;
      ssql           ge_errores_pg.vquery;
   BEGIN
      SELECT flg_estado
        INTO eo_combinatoria_os.flg_estado
        FROM pv_combinatoria_os_td
       WHERE cod_os = eo_combinatoria_os.cod_os
         AND nom_combinatoria = eo_combinatoria_os.nom_combinatoria;

      sn_cod_retorno := 0;
      sv_mens_retorno := 'OK';
      sn_num_evento := 0;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 1;
         sv_mens_retorno := 'La combinatoria no existe.';
         sn_num_evento := 0;
      WHEN OTHERS
      THEN
         sn_cod_retorno := 4;
         sv_mens_retorno :=
                       'Error en ejecución PL-SQL PV_cnslta_combinatoria_PR.';
         lv_des_error := SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (0,
                                    'PV',
                                    sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'PV_cnslta_combinatoria_PR',
                                    ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
   END pv_cnslta_combinatoria_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE pv_cnslta_datos_comis_pr (
      eo_seg_usuario     IN OUT NOCOPY   ge_seg_usuario_qt,
      eo_pv_comis_ooss   IN OUT NOCOPY   pv_comis_ooss_qt,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      ln_ind_interno    ve_vendedores.ind_interno%TYPE;
      ec_cursor         refcursor;
      ln_valor          NUMBER (1);
      ln_cod_comuna     ge_comunas.cod_comuna%TYPE;
      lv_des_comuna     ge_comunas.des_comuna%TYPE;
      ln_cod_vendedor   ve_vendedores.cod_vendedor%TYPE;
      lv_des_error      ge_errores_pg.desevent;
      ssql              ge_errores_pg.vquery;
      cant              NUMBER;
      error_vendedor    EXCEPTION;
   BEGIN
      IF pv_cambio_serie_sb_pg.pv_rec_ge_seg_usuario_fn (eo_seg_usuario,
                                                         sn_cod_retorno,
                                                         sv_mens_retorno,
                                                         sn_num_evento
                                                        )
      THEN
         IF sn_cod_retorno = 0 AND eo_seg_usuario.grup_callcenter = 'N'
         THEN
            SELECT COUNT (1)
              INTO cant
              FROM ve_vendedores a
             WHERE a.cod_vendedor = eo_seg_usuario.cod_vendedor;

            IF cant < 1
            THEN
               sv_mens_retorno :=
                  'El vendedor no es v+lido o bien el usuario de ingreso no est+ dado de alta como vendedor en el sistema.';
               RAISE error_vendedor;
            END IF;

            SELECT ind_interno
              INTO ln_ind_interno
              FROM ve_vendedores
             WHERE cod_vendedor = eo_seg_usuario.cod_vendedor;

            eo_pv_comis_ooss.cod_vendedor := eo_seg_usuario.cod_vendedor;
            eo_pv_comis_ooss.ind_interno := ln_ind_interno;
            pv_comis_ooss_pg.pv_obtiene_datos_vendedor_pr (eo_pv_comis_ooss,
                                                           ec_cursor,
                                                           sn_cod_retorno,
                                                           sv_mens_retorno,
                                                           sn_num_evento
                                                          );

            IF sn_cod_retorno = 0
            THEN
               FETCH ec_cursor
                INTO ln_cod_vendedor, eo_pv_comis_ooss.cod_oficina,
                     eo_pv_comis_ooss.cod_tipcomis, ln_cod_vendedor,
                     eo_pv_comis_ooss.nom_vendedor, ln_valor,
                     eo_pv_comis_ooss.cod_oficina,
                     eo_pv_comis_ooss.des_oficina,
                     eo_pv_comis_ooss.cod_tipcomis,
                     eo_pv_comis_ooss.des_tipcomis,
                     eo_pv_comis_ooss.cod_region,
                     eo_pv_comis_ooss.des_region,
                     eo_pv_comis_ooss.cod_provincia,
                     eo_pv_comis_ooss.des_provincia, ln_cod_comuna,
                     lv_des_comuna, eo_pv_comis_ooss.cod_vendealer,
                     eo_pv_comis_ooss.nom_vendealer,
                     eo_pv_comis_ooss.cod_ciudad,
                     eo_pv_comis_ooss.des_ciudad;

               sn_cod_retorno := 0;
               sv_mens_retorno := 'OK';
               sn_num_evento := 0;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN error_vendedor
      THEN
         sn_cod_retorno := 203;
         lv_des_error :=
               'pv_orden_servicio_pg.pv_cnslta_datos_comis_pr('
            || eo_seg_usuario.cod_vendedor
            || '); '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (0,
                              'PV',
                              sv_mens_retorno,
                              '1.0',
                              USER,
                              'pv_orden_servicio_pg.pv_cnslta_datos_comis_pr',
                              ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 4;
         sv_mens_retorno :=
                        'Error en ejecución PL-SQL pv_cnslta_datos_comis_pr.';
         lv_des_error := SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (0,
                                    'PV',
                                    sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'pv_cnslta_datos_comis_pr',
                                    ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
   END pv_cnslta_datos_comis_pr;

--------------------------------------------------------------------------------------------------------
   PROCEDURE cambia_estado_solicitud_pr (
      en_numsolicitud   IN              ert_solicitud.num_solicitud%TYPE,
      en_codestado      IN              ert_solicitud.cod_estado%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_des_error   ge_errores_pg.desevent;
      ssql           ge_errores_pg.vquery;
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := 'OK';
      sn_num_evento := 0;
      er_servicios_evalriesgo_web_pg.er_cambia_estado_solicitud_pr
                                                            (en_numsolicitud,
                                                             en_codestado,
                                                             sn_cod_retorno,
                                                             sv_mens_retorno,
                                                             sn_num_evento
                                                            );

      IF (sn_cod_retorno > 0)
      THEN
         ROLLBACK;
         sn_cod_retorno := 4;
         sv_mens_retorno :=
                      'Error en ejecución PL-SQL cambia_estado_solicitud_PR.';
      ELSE
         COMMIT;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         sn_cod_retorno := 4;
         sv_mens_retorno :=
                      'Error en ejecución PL-SQL cambia_estado_solicitud_PR.';
         lv_des_error := SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (0,
                                    'PV',
                                    sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'cambia_estado_solicitud_PR',
                                    ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
   END cambia_estado_solicitud_pr;
/************************************************************************************************************/
PROCEDURE PV_ACTUALIZA_CLASESERVICIO_PR(   EN_COD_PRODUCTO IN GA_ABOCEL.COD_PRODUCTO%TYPE,
                                            EN_NUM_ABONADO  IN GA_ABOCEL.NUM_ABONADO%TYPE

                                       )
IS
/*--
<Documentacion TipoDoc = "Procedimiento">
      Elemento Nombre = "PV_ACTUALIZA_CLASESERVICIO_PR"
      Lenguaje="PL/SQL"
      Fecha="21-12-2007"
      Version="1.0.0"
      Dise?ador="Andres Osorio"
      Programador="Andres Osorio""
      Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
      Actualiza la clase de servicio del abonado
      </Descripcion>
      <Parametros>
      <Entrada>
          <param nom="EN_COD_PRODUCTO" Tipo="NUMBER> codigo producto</param>
         <param nom="EN_NUM_ABONADO" Tipo="NUMBER"> Numero de Abonado</param>

      </Entrada>
      <Salida>
          <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
          <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
          <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
</Documentacion>
--*/
LV_sSql GE_ERRORES_PG.vquery;
lv_des_error ge_errores_pg.desevent;
LV_CLASESERVICIO GA_ABOCEL.CLASE_SERVICIO%TYPE;
LV_ClaseAux VARCHAR2(10);
LN_ABOCEL NUMBER;
LN_ABOAMIST NUMBER;

sn_cod_retorno         ge_errores_td.cod_msgerror%TYPE;
sv_mens_retorno        ge_errores_td.det_msgerror%TYPE;
sn_num_evento          ge_errores_pg.evento;

ERROR_ABONADO EXCEPTION;

CURSOR c_ClaseServicio IS
SELECT TRIM(TO_CHAR(COD_SERVSUPL, '00'))||TRIM(TO_CHAR(COD_NIVEL, '0000'))
FROM   GA_SERVSUPLABO
WHERE  NUM_ABONADO   = EN_NUM_ABONADO
AND    COD_PRODUCTO  = EN_COD_PRODUCTO
AND    IND_ESTADO   <= 2
ORDER BY COD_SERVSUPL;

BEGIN
    LN_ABOCEL := 0;
    LN_ABOAMIST := 0;
    LV_CLASESERVICIO := NULL;
    LV_ClaseAux := NULL;

    LV_sSql := 'SELECT COUNT(0)';
    LV_sSql := LV_sSql || ' FROM   GA_ABOCEL';
    LV_sSql := LV_sSql || ' WHERE  NUM_ABONADO = '||EN_NUM_ABONADO;
    LV_sSql := LV_sSql || ' AND       COD_PRODUCTO = '||EN_COD_PRODUCTO;

    SELECT COUNT(0)
    INTO   LN_ABOCEL
    FROM   GA_ABOCEL
    WHERE  NUM_ABONADO = EN_NUM_ABONADO
    AND       COD_PRODUCTO = EN_COD_PRODUCTO;

    LV_sSql := 'SELECT COUNT(0)';
    LV_sSql := LV_sSql || ' FROM   GA_ABOAMIST';
    LV_sSql := LV_sSql || ' WHERE  NUM_ABONADO = '||EN_NUM_ABONADO;
    LV_sSql := LV_sSql || ' AND       COD_PRODUCTO = '||EN_COD_PRODUCTO;

    SELECT COUNT(0)
    INTO   LN_ABOAMIST
    FROM   GA_ABOAMIST
    WHERE  NUM_ABONADO = EN_NUM_ABONADO
    AND       COD_PRODUCTO = EN_COD_PRODUCTO;


    IF (LN_ABOCEL = 0) AND (LN_ABOAMIST=0) THEN
       RAISE ERROR_ABONADO;
    END IF;

    LV_sSql := 'SELECT TRIM(TO_CHAR(COD_SERVSUPL, ''00''))||TRIM(TO_CHAR(COD_NIVEL, ''0000''))';
    LV_sSql := LV_sSql || ' FROM   GA_SERVSUPLABO ';
    LV_sSql := LV_sSql || ' WHERE  NUM_ABONADO   = '||EN_NUM_ABONADO;
    LV_sSql := LV_sSql || ' AND    COD_PRODUCTO  = '||EN_COD_PRODUCTO;
    LV_sSql := LV_sSql || ' AND    IND_ESTADO   <= 2';
    LV_sSql := LV_sSql || ' ORDER BY COD_SERVSUPL';

    OPEN c_ClaseServicio;

    LOOP
        FETCH c_ClaseServicio INTO LV_ClaseAux;

        EXIT WHEN c_ClaseServicio%NOTFOUND;

        LV_CLASESERVICIO := LV_CLASESERVICIO || LV_ClaseAux;

    END LOOP;

    IF (LN_ABOCEL > 0) THEN

        LV_sSql := 'UPDATE GA_ABOCEL';
        LV_sSql := LV_sSql || ' SET       CLASE_SERVICIO = '||LV_CLASESERVICIO;
        LV_sSql := LV_sSql || ' WHERE  NUM_ABONADO = '||EN_NUM_ABONADO;
        LV_sSql := LV_sSql || ' AND       COD_PRODUCTO = '||EN_COD_PRODUCTO;

        UPDATE GA_ABOCEL
        SET       CLASE_SERVICIO = LV_CLASESERVICIO
        WHERE  NUM_ABONADO = EN_NUM_ABONADO
        AND       COD_PRODUCTO = EN_COD_PRODUCTO;

    ELSE

        LV_sSql := 'UPDATE GA_ABOAMIST';
        LV_sSql := LV_sSql || ' SET       CLASE_SERVICIO = '||LV_CLASESERVICIO;
        LV_sSql := LV_sSql || ' WHERE  NUM_ABONADO = '||EN_NUM_ABONADO;
        LV_sSql := LV_sSql || ' AND       COD_PRODUCTO = '||EN_COD_PRODUCTO;

        UPDATE GA_ABOAMIST
        SET       CLASE_SERVICIO = LV_CLASESERVICIO
        WHERE  NUM_ABONADO = EN_NUM_ABONADO
        AND       COD_PRODUCTO = EN_COD_PRODUCTO;
    END IF;


EXCEPTION
      WHEN ERROR_ABONADO THEN
        SN_cod_retorno := 218;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error   := ' pv_orden_servicio_pg.PV_ACTUALIZA_CLASESERVICIO_PR('||EN_NUM_ABONADO||');['||SQLERRM||']';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ACTUALIZA_CLASESERVICIO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
        SN_cod_retorno := 156;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error   := ' pv_orden_servicio_pg.PV_ACTUALIZA_CLASESERVICIO_PR('||EN_NUM_ABONADO||');['||SQLERRM||']';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ACTUALIZA_CLASESERVICIO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_ACTUALIZA_CLASESERVICIO_PR;


/************************************************************************************************************/
PROCEDURE PV_CONS_EVENTO_NUMFREC_PR(
      EN_NUM_ABONADO       IN        GA_ABOCEL.NUM_ABONADO%TYPE,
      EN_COD_CLIENTE       IN        GA_ABOCEL.COD_CLIENTE%TYPE,
      EV_COD_OS            IN        PV_IORSERV.COD_OS%TYPE,
      SN_RETORNO        OUT NOCOPY      NUMBER,
      SN_COD_RETORNO    OUT NOCOPY      GE_ERRORES_TD.COD_MSGERROR%TYPE,
      SV_MENS_RETORNO   OUT NOCOPY      GE_ERRORES_TD.DET_MSGERROR%TYPE,
      SN_NUM_EVENTO     OUT NOCOPY      GE_ERRORES_PG.EVENTO
   )
/*
   <Documentacion TipoDoc = "Funcion">
   <Elemento Nombre = "PV_CONS_EVENTO_NUMFREC_FN "
    Lenguaje="PL/SQL" Fecha="28-08-2009"
    Versión"1.0.0" Dise±ador"****"
    Programador="" Ambiente="BD">
   <Retorno>NA</Retorno>
   <Descripcion>Funci¿n que contabiliza la cantidad de eventos realizados en las ooss cambio de numeros frecuente</Descripcion>
   <Parametros>
    <Entrada>
        <param nom="EN_NUM_ABONADO"       Tipo="">NUNERO DEL ABONADO</param>>
        <param nom="EN_COD_CLIENTE"       Tipo="">CODIGO DEL CLIENTE</param>>
        <param nom="EV_COD_OS"        Tipo="">CODIGO DE LA OOSS</param>>
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo de Retorno         </param>>
        <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje de Retorno        </param>>
        <param nom="SN_num_evento"             Tipo="NUMERICO">Numero de Evento       </param>>
    </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
   */
   IS
    lv_des_error            ge_errores_pg.desevent;
    lv_sql                 ge_errores_pg.vquery;

   BEGIN

          lv_sql:= 'SELECT COUNT(NUM_OS) ';
          lv_sql := lv_sql || ' FROM ';
          lv_sql := lv_sql || ' PV_NUMFREC_EVENTO_TO';
          lv_sql := lv_sql || ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
          lv_sql := lv_sql || ' AND COD_CLIENTE = ' || EN_COD_CLIENTE;
          lv_sql := lv_sql || ' AND COD_OS = ' ||  EV_COD_OS;


          SELECT COUNT(NUM_OS)
          INTO SN_RETORNO
          FROM
          PV_NUMFREC_EVENTO_TO
          WHERE NUM_ABONADO =   EN_NUM_ABONADO
          AND COD_CLIENTE =  EN_COD_CLIENTE
          AND COD_OS =  EV_COD_OS;


      EXCEPTION
    WHEN OTHERS THEN
        SN_cod_retorno := 156;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error   := ' pv_orden_servicio_pg.PV_CONS_EVENTO_NUMFREC_PG('||EN_NUM_ABONADO||');['||SQLERRM||']';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CONS_EVENTO_NUMFREC_PG', LV_sQL, SN_cod_retorno, LV_des_error );

   END PV_CONS_EVENTO_NUMFREC_PR;

/************************************************************************************************************/

PROCEDURE PV_INSER_EVENTO_NUMFREC_PR(
      EN_NUM_ABONADO    IN            GA_ABOCEL.NUM_ABONADO%TYPE,
      EN_COD_CLIENTE    IN            GA_ABOCEL.COD_CLIENTE%TYPE,
      EV_COD_OS            IN        PV_IORSERV.COD_OS%TYPE,
      EN_NUM_OS            IN        PV_IORSERV.NUM_OS%TYPE,
      SN_COD_RETORNO    OUT NOCOPY      GE_ERRORES_TD.COD_MSGERROR%TYPE,
      SV_MENS_RETORNO   OUT NOCOPY      GE_ERRORES_TD.DET_MSGERROR%TYPE,
      SN_NUM_EVENTO     OUT NOCOPY      GE_ERRORES_PG.EVENTO
  )
IS
/*--
<Documentacion TipoDoc = "Procedimiento">
      Elemento Nombre = "PV_INSER_EVENTO_NUMFREC_PR"
      Lenguaje="PL/SQL"
      Fecha="28-08-09"
      Version="1.0.0"
      Dise±dor=""
      Programador=""
      Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
      Actualiza la clase de servicio del abonado
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="NUM_ABONADO" Tipo="NUMBER"> Numero de Abonado</param>
         <param nom="COD_CLIENTE" Tipo="NUMBER"> codigo Cliente</param>
         <param nom="COD_OS" Tipo="NUMBER"> codigo OOSS</param>
     <param nom="NUM_OS" Tipo="NUMBER"> Numero OOSS</param>
      </Entrada>
      <Salida>
          <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
          <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
          <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
</Documentacion>
--*/

    lv_des_error                 ge_errores_pg.desevent;
    lv_ssql                      ge_errores_pg.vquery;
BEGIN

    LV_sSql := 'INSERT INTO PV_NUMFREC_EVENTO_TO (NUM_ABONADO, COD_CLIENTE, COD_OS, NUM_OS, NOM_USUARIO,FEC_INSERCION) VALUES( ';
    LV_sSql := LV_sSql || EN_NUM_ABONADO || ', ';
    LV_sSql := LV_sSql || EN_COD_CLIENTE || ', ';
    LV_sSql := LV_sSql || EV_COD_OS || ', ';
    LV_sSql := LV_sSql || EN_NUM_OS || ', ';
    LV_sSql := LV_sSql || 'USER, SYSDATE )';


    INSERT INTO PV_NUMFREC_EVENTO_TO
        (NUM_ABONADO, COD_CLIENTE, COD_OS, NUM_OS, NOM_USUARIO,FEC_INSERCION)
    VALUES
        (EN_NUM_ABONADO, EN_COD_CLIENTE, EV_COD_OS, EN_NUM_OS, USER, SYSDATE);

   EXCEPTION
    WHEN OTHERS THEN
        SN_cod_retorno := 156;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error   := ' pv_orden_servicio_pg.PV_INSER_EVENTO_NUMFREC_PR('||EN_NUM_ABONADO||');['||SQLERRM||']';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_INSER_EVENTO_NUMFREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 END PV_INSER_EVENTO_NUMFREC_PR;
/************************************************************************************************************/


PROCEDURE PV_MONTO_EVENTO_NUMFREC_PR(
      EN_NUM_ABONADO       IN        GA_ABOCEL.NUM_ABONADO%TYPE,
      EN_COD_CLIENTE       IN        GA_ABOCEL.COD_CLIENTE%TYPE,
      EV_COD_OS            IN        PV_IORSERV.COD_OS%TYPE,
      SN_MONTO          OUT NOCOPY      NUMBER,
      EN_COD_CONCEPTO   OUT NOCOPY      NUMBER,
      SN_COD_RETORNO    OUT NOCOPY      GE_ERRORES_TD.COD_MSGERROR%TYPE,
      SV_MENS_RETORNO   OUT NOCOPY      GE_ERRORES_TD.DET_MSGERROR%TYPE,
      SN_NUM_EVENTO     OUT NOCOPY      GE_ERRORES_PG.EVENTO
   )
  IS

    lv_des_error                ge_errores_pg.desevent;
    lv_sql                      ge_errores_pg.vquery;
    EN_Cantidad                 NUMBER;
    SN_Tiplan                   ta_plantarif.cod_tiplan%type;
    SN_COD_MONEDA               GA_CARGOS_EVENTOS_TD.COD_MONEDA%type;
    EN_CAMBIO                   GE_CONVERSION.CAMBIO%type;
    error_ejecucion             EXCEPTION;
    error_ejecucion             EXCEPTION;

    BEGIN

        SN_MONTO    := 0;
        EN_COD_CONCEPTO :=0;

        lv_sql:= 'SELECT COUNT(NUM_OS) ';
        lv_sql := lv_sql || ' FROM ';
        lv_sql := lv_sql || ' PV_NUMFREC_EVENTO_TO';
        lv_sql := lv_sql || ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
        lv_sql := lv_sql || ' AND COD_CLIENTE = ' || EN_COD_CLIENTE;
        lv_sql := lv_sql || ' AND COD_OS = ' ||  EV_COD_OS;

        SELECT COUNT(NUM_OS)
        INTO EN_Cantidad
        FROM
        PV_NUMFREC_EVENTO_TO
        WHERE NUM_ABONADO =   EN_NUM_ABONADO
        AND COD_CLIENTE =  EN_COD_CLIENTE
        AND COD_OS =  EV_COD_OS;

    IF EN_Cantidad > 0 THEN


        lv_sql := '';
        lv_sql := ' SELECT A.COD_TIPLAN, FROM TA_PLANTARIF A, GA_ABOCEL B ';
        lv_sql := lv_sql || ' INTO SN_Tiplan ';
        lv_sql := lv_sql || ' WHERE B.NUM_ABONADO = ' || EN_NUM_ABONADO;
        lv_sql := lv_sql || ' AND A.COD_PLANTARIF = B.COD_PLANTARIF ';
        lv_sql := lv_sql || ' UNION ';
        lv_sql := lv_sql || ' SELECT A.COD_TIPLAN FROM TA_PLANTARIF A, GA_ABOAMIST B ';
        lv_sql := lv_sql || ' WHERE B.NUM_ABONADO = ' || EN_NUM_ABONADO;
        lv_sql := lv_sql || ' AND A.COD_PLANTARIF = B.COD_PLANTARIF ';
        BEGIN
            SELECT A.COD_TIPLAN
            INTO SN_Tiplan
            FROM TA_PLANTARIF A, GA_ABOCEL B
            WHERE B.NUM_ABONADO = EN_NUM_ABONADO
            AND A.COD_PLANTARIF = B.COD_PLANTARIF
            UNION
            SELECT A.COD_TIPLAN FROM TA_PLANTARIF A, GA_ABOAMIST B
            WHERE B.NUM_ABONADO = EN_NUM_ABONADO
            AND A.COD_PLANTARIF = B.COD_PLANTARIF;
          EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  SN_Tiplan := '';
        END;

        IF SN_Tiplan <> '' THEN
                lv_sql := ' SELECT COD_MONEDA ';
                lv_sql := lv_sql || ' INTO SN_COD_MONEDA ';
                lv_sql := lv_sql || ' FROM GA_CARGOS_EVENTOS_TD ';
                lv_sql := lv_sql || ' WHERE SYSDATE BETWEEN FEC_DESDE ';
                lv_sql := lv_sql || ' AND FEC_HASTA ';
                lv_sql := lv_sql || ' AND COD_USO = ' || SN_Tiplan;
                lv_sql := lv_sql || ' AND '|| EN_Cantidad || 'BETWEEN CANT_MINIMO ';
                lv_sql := lv_sql || ' AND CANT_MAXIMO; ';
            BEGIN
                SELECT COD_MONEDA
                INTO SN_COD_MONEDA
                FROM  GA_CARGOS_EVENTOS_TD
                WHERE SYSDATE BETWEEN FEC_DESDE
                AND FEC_HASTA
                AND COD_USO = SN_Tiplan
                AND EN_Cantidad BETWEEN CANT_MINIMO
                AND CANT_MAXIMO;

             EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  SN_COD_MONEDA := '';

              END ;


        IF SN_COD_MONEDA <> '' THEN
                lv_sql := ' SELECT CAMBIO ';
                lv_sql := lv_sql || ' into EN_CAMBIO ';
                lv_sql := lv_sql || ' FROM GE_CONVERSION ';
                lv_sql := lv_sql || ' WHERE SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA ';
                lv_sql := lv_sql || ' AND COD_MONEDA = ' ||SN_COD_MONEDA;
             BEGIN
                SELECT CAMBIO
                into EN_CAMBIO
                FROM GE_CONVERSION
                WHERE SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA
                AND COD_MONEDA = SN_COD_MONEDA;
               EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  EN_CAMBIO := 1;

              END;

                lv_sql := ' SELECT (MTO_VALOR * EN_CAMBIO),COD_CONCEPTO ';
                lv_sql := lv_sql || ' INTO SN_MONTO, EN_COD_CONCEPTO ';
                lv_sql := lv_sql || ' FROM GA_CARGOS_EVENTOS_TD ';
                lv_sql := lv_sql || ' WHERE SYSDATE BETWEEN FEC_DESDE ';
                lv_sql := lv_sql || ' AND FEC_HASTA ';
                lv_sql := lv_sql || ' AND COD_USO = ' || SN_Tiplan ;
                lv_sql := lv_sql || ' AND ' || EN_Cantidad || ' BETWEEN CANT_MINIMO ';
                lv_sql := lv_sql || ' AND CANT_MAXIMO; ';

                SELECT (MTO_VALOR * EN_CAMBIO),COD_CONCEPTO
                INTO SN_MONTO, EN_COD_CONCEPTO
                FROM  GA_CARGOS_EVENTOS_TD
                WHERE SYSDATE BETWEEN FEC_DESDE
                AND FEC_HASTA
                AND COD_USO = SN_Tiplan
                AND EN_Cantidad BETWEEN CANT_MINIMO
                AND CANT_MAXIMO;
          END IF;

       END IF;
     END IF;

   EXCEPTION
    WHEN OTHERS THEN
        SN_cod_retorno := 156;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error   := ' pv_orden_servicio_pg.PV_MONTO_EVENTO_NUMFREC_PR('||EN_NUM_ABONADO||');['||SQLERRM||']';
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_MONTO_EVENTO_NUMFREC_PR', LV_sQL, SN_cod_retorno, LV_des_error );

END PV_MONTO_EVENTO_NUMFREC_PR;

/************************************************************************************************************/



PROCEDURE PV_REG_CAUSACAMBIOPLAN_OS_PR(
      EN_NUM_OS            IN        PV_CAUSA_PLAN_OOSS_TO.NUM_OS%TYPE,
      EV_COD_OS            IN        PV_CAUSA_PLAN_OOSS_TO.COD_OS%TYPE,
      EV_CAUSA             IN        PV_CAUSA_PLAN_OOSS_TO.COD_CAUSA%TYPE,
      EV_COD_PLANTARIF     IN        PV_CAUSA_PLAN_OOSS_TO.COD_PLANTARIF%TYPE,
      EV_USUARIO           IN        PV_CAUSA_PLAN_OOSS_TO.NOM_USUARORA%TYPE,
      EN_NUM_ABONADO       IN        PV_CAUSA_PLAN_OOSS_TO.NUM_ABONADO%TYPE,
      SN_COD_RETORNO    OUT NOCOPY      GE_ERRORES_TD.COD_MSGERROR%TYPE,
      SV_MENS_RETORNO   OUT NOCOPY      GE_ERRORES_TD.DET_MSGERROR%TYPE,
      SN_NUM_EVENTO     OUT NOCOPY      GE_ERRORES_PG.EVENTO
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = " PV_REG_CAUSACAMBIOPLAN_OS_PR"
            Lenguaje="PL/SQL"
            Fecha="10-09-2009"
            Versión="La del package"
            Dise+ador=""
            Programador="Orlando Cabezas"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  Registra causa de cambio de plan </Descripción>>
            <Par+metros>
               <Entrada>
                  <param nom="EN_NUM_OS "   Tipo="NUMERICO">Secuencia de os  </param>>
                  <param nom="EV_COD_OS"   Tipo="NUMERICO">codigo de os   </param>>
                  <param nom="EV_CAUSA"   Tipo="NUMERICO">Scodigo de causa  </param>>
                  <param nom="EV_COD_PLANTARIF   Tipo="NUMERICO">plan tarifario   </param>>
                  <param nom="EV_USUARIO"   Tipo="NUMERICO">usuario</param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;


      lv_ssql  :='insert into PV_CAUSA_PLAN_OOSS_TO( NUM_OS,COD_OS,COD_CAUSA,COD_PLANTARIF,FECHA_ING,NOM_USUARORA,NUM_ABONADO)';
      lv_ssql  :=lv_ssql || 'values ( '||EN_NUM_OS||','||EV_COD_OS||','||EV_CAUSA||','||EV_COD_PLANTARIF||','|| sysdate||','|| EV_USUARIO||','||EN_NUM_ABONADO||')';

      insert into PV_CAUSA_PLAN_OOSS_TO(
      NUM_OS        ,
      COD_OS        ,
      COD_CAUSA     ,
      COD_PLANTARIF ,
      FECHA_ING     ,
      NOM_USUARORA,
      NUM_ABONADO)
      values
      ( EN_NUM_OS     ,
      EV_COD_OS       ,
      EV_CAUSA        ,
      EV_COD_PLANTARIF ,
      sysdate,
      EV_USUARIO,
      EN_NUM_ABONADO);

   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;
         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=' PV_REG_CAUSACAMBIOPLAN_OS_PR ('||EN_NUM_OS||','||EV_COD_OS||','||EV_CAUSA||','||EV_COD_PLANTARIF||','|| sysdate|| EV_USUARIO||');' || SQLERRM;
         sn_num_evento :=
         ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'pv_orden_servicio_pg.PV_REG_CAUSACAMBIOPLAN_OS_PR',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
   END PV_REG_CAUSACAMBIOPLAN_OS_PR;



PROCEDURE PV_CARGA_CAUSACAMBIOPLAN_PR(
      SV_CAUSAS         OUT NOCOPY      refcursor ,
      SN_COD_RETORNO    OUT NOCOPY      GE_ERRORES_TD.COD_MSGERROR%TYPE,
      SV_MENS_RETORNO   OUT NOCOPY      GE_ERRORES_TD.DET_MSGERROR%TYPE,
      SN_NUM_EVENTO     OUT NOCOPY      GE_ERRORES_PG.EVENTO
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = " PV_CARGA_CAUSACAMBIOPLAN_PR
            Lenguaje="PL/SQL"
            Fecha="10-09-2009"
            Versión="La del package"
            Dise+ador=""
            Programador="Orlando Cabezas"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  Registra causa de cambio de plan </Descripción>>
            <Par+metros>
               <Entrada>
               </Entrada>
               <Salida>
                  <param nom="SV_CAUSAS     "                   Tipo="refcursor">causas de cambio de plan</param>>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                    Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;


      lv_ssql  :='select cod_causa ,des_causa from  GA_CAUSAL_CAMBIO_TD';
      lv_ssql  :=lv_ssql || 'sysdate between fec_desde and fec_hasta';

      OPEN SV_CAUSAS FOR
      select cod_causa ,des_causa
      from
      GA_CAUSAL_CAMBIO_TD
      where
      sysdate between fec_desde and fec_hasta;

   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;
         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :='PV_CARGA_CAUSACAMBIOPLAN_PR(  SV_CAUSAS    ); ' || SQLERRM;
         sn_num_evento :=
         ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'pv_orden_servicio_pg.PV_CARGA_CAUSACAMBIOPLAN_PR',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
   END PV_CARGA_CAUSACAMBIOPLAN_PR;


PROCEDURE PV_ACT_PARAM_COMERCIAL_PR(
      EO_PARAM_COMER     IN             PV_ACT_PARAM_COMERCIAL_QT,
      SN_COD_RETORNO    OUT NOCOPY      GE_ERRORES_TD.COD_MSGERROR%TYPE,
      SV_MENS_RETORNO   OUT NOCOPY      GE_ERRORES_TD.DET_MSGERROR%TYPE,
      SN_NUM_EVENTO     OUT NOCOPY      GE_ERRORES_PG.EVENTO
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_ACT_PARAM_COMERCIAL_PR
            Lenguaje="PL/SQL"
            Fecha="11-05-2010"
            Versión="La del package"
            Dise+ador=""
            Programador="Orlando Cabezas"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  Actualiza parametros comerciales</Descripción>>
            <Par+metros>
               <Entrada>
               </Entrada>
               <Salida>
                  <param nom="EO_PARAM_COMER   "                   Tipo="refcursor">causas de cambio de plan</param>>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                    Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Par+metros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
      LV_COD_TIPLAN  TA_PLANTARIF.COD_TIPLAN%TYPE;
      LV_COD_USO     GA_ABOCEL.COD_USO%TYPE;
      LV_FEC_DESDELLAM FA_CICLFACT.FEC_DESDELLAM%TYPE;
      LV_COD_CICLFACT  FA_CICLFACT.COD_CICLFACT%TYPE;
      LV_CICLO         GA_ABOCEL.COD_CICLO%TYPE;
      LV_COD_SEGMENTO  GE_CLIENTES.COD_SEGMENTO%TYPE;
      LV_COD_COLOR     GE_CLIENTES.COD_COLOR%TYPE;
      LV_COD_LIM_AUX   TOL_LIMITE_PLAN_TD.COD_LIMCONS%TYPE;
      LV_MTO_CONS      TOL_LIMITE_PLAN_TD.MTO_CONS%TYPE;

   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;


      if EO_PARAM_COMER.IND_EJECUCION='I' then

              BEGIN



                      lv_ssql  :=' SELECT  COD_TIPLAN INTO LV_COD_TIPLAN';
                      lv_ssql  :=lv_ssql || ' FROM TA_PLANTARIF ';
                      lv_ssql  :=lv_ssql || ' WHERE';
                      lv_ssql  :=lv_ssql || ' COD_PLANTARIF = ' || EO_PARAM_COMER.COD_PLANTARIF_NUE;


                      SELECT  COD_TIPLAN INTO LV_COD_TIPLAN
                      FROM TA_PLANTARIF
                      WHERE
                      COD_PLANTARIF =EO_PARAM_COMER.COD_PLANTARIF_NUE;

              EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                            LV_COD_TIPLAN:=NULL;
              END;

              IF LV_COD_TIPLAN='2' THEN
                 LV_COD_USO :=2;
              END IF;


              IF LV_COD_TIPLAN='3' THEN
                 LV_COD_USO :=10;
              END IF;

              IF LV_COD_TIPLAN='1' OR LV_COD_TIPLAN=NULL THEN
                 LV_COD_USO :=3;
              END IF;


              SELECT COD_CICLO INTO LV_CICLO
              FROM GA_aBOCEL
              WHERE NUM_ABONADO =EO_PARAM_COMER.NUM_ABONADO;

              SELECT FEC_DESDELLAM,COD_CICLFACT
              INTO  LV_FEC_DESDELLAM,LV_COD_CICLFACT
              FROM FA_CICLFACT
              WHERE COD_CICLO = LV_CICLO
              AND TRUNC(SYSDATE) < TRUNC(FEC_DESDELLAM)
              AND IND_FACTURACION =0
              AND ROWNUM = 1;



              lv_ssql  :=' UPDATE GA_ABOCEL';
              lv_ssql  :=lv_ssql || ' SET COD_PLANTARIF     = '|| EO_PARAM_COMER.COD_PLANTARIF_NUE ;
              lv_ssql  :=lv_ssql || '  ,COD_CARGOBASICO   = '  || EO_PARAM_COMER.COD_CARGOBASICO ;
              lv_ssql  :=lv_ssql || ' ,COD_LIMCONSUMO    = '   || EO_PARAM_COMER.COD_LIMCONSUMO ;
              lv_ssql  :=lv_ssql || ' ,TIP_PLANTARIF     = '   || EO_PARAM_COMER.TIP_PLANTARIF_NUE ;
              lv_ssql  :=lv_ssql || ' ,COD_EMPRESA       = NULL';
              lv_ssql  :=lv_ssql || ' ,COD_HOLDING       = NULL';
              lv_ssql  :=lv_ssql || ' ,FEC_CUMPLAN       = SYSDATE';
              lv_ssql  :=lv_ssql || ' ,COD_USO           = '|| LV_COD_USO;
              lv_ssql  :=lv_ssql || ' WHERE NUM_ABONADO ='||EO_PARAM_COMER.NUM_ABONADO;

              UPDATE GA_ABOCEL
              SET COD_PLANTARIF     = EO_PARAM_COMER.COD_PLANTARIF_NUE ,
                  COD_CARGOBASICO   = EO_PARAM_COMER.COD_CARGOBASICO ,
                  COD_LIMCONSUMO    = EO_PARAM_COMER.COD_LIMCONSUMO ,
                  TIP_PLANTARIF     = EO_PARAM_COMER.TIP_PLANTARIF_NUE ,
                  COD_EMPRESA       = NULL,
                  COD_HOLDING       = NULL,
                  FEC_CUMPLAN       = SYSDATE ,
                  COD_USO           = LV_COD_USO
              WHERE NUM_ABONADO =EO_PARAM_COMER.NUM_ABONADO;




              lv_ssql  := ' DELETE GA_FINCICLO';
              lv_ssql  :=lv_ssql || ' WHERE ';
              lv_ssql  :=lv_ssql || ' COD_CLIENTE   =  '|| EO_PARAM_COMER.COD_CLIENTE       || ' AND';
              lv_ssql  :=lv_ssql || ' NUM_ABONADO   =  '|| EO_PARAM_COMER.NUM_ABONADO       || ' AND';
              lv_ssql  :=lv_ssql || ' COD_PLANTARIF =  '|| EO_PARAM_COMER.COD_PLANTARIF_NUE || ' AND';
              lv_ssql  :=lv_ssql || ' COD_CICLFACT  =  '|| EO_PARAM_COMER.PERIODOFACT       ;

              DELETE GA_FINCICLO
              WHERE
              COD_CLIENTE   =  EO_PARAM_COMER.COD_CLIENTE       AND
              NUM_ABONADO   =  EO_PARAM_COMER.NUM_ABONADO       AND
              COD_PLANTARIF =  EO_PARAM_COMER.COD_PLANTARIF_NUE AND
              COD_CICLFACT  =  LV_COD_CICLFACT       ;


              lv_ssql  :=' UPDATE GA_INTARCEL';
              lv_ssql  :=lv_ssql || ' SET FEC_HASTA   =  SYSDATE - (1/(24*60*60))';
              lv_ssql  :=lv_ssql || ' WHERE ';
              lv_ssql  :=lv_ssql || ' COD_CLIENTE   = ' ||EO_PARAM_COMER.COD_CLIENTE      || ' AND';
              lv_ssql  :=lv_ssql || ' NUM_ABONADO   = ' ||EO_PARAM_COMER.NUM_ABONADO      || ' AND';
              lv_ssql  :=lv_ssql || ' COD_PLANTARIF = ' || EO_PARAM_COMER.COD_PLANTARIF   || ' AND';
              lv_ssql  :=lv_ssql || ' FEC_HASTA =  TO_DATE (TRUNC((LV_FEC_DESDELLAM - 1))' || ' 23:59:59'||'DD-MM-YY HH24:MI:SS)';


              lv_ssql :=EO_PARAM_COMER.FEC_VENCIMIENTO||'1';
               UPDATE GA_INTARCEL
              SET FEC_HASTA   = SYSDATE - (1/(24*60*60))
              WHERE
              COD_CLIENTE   =  EO_PARAM_COMER.COD_CLIENTE       AND
              NUM_ABONADO   =  EO_PARAM_COMER.NUM_ABONADO       AND
              COD_PLANTARIF =  EO_PARAM_COMER.COD_PLANTARIF     AND
              FEC_HASTA =  TO_DATE (TRUNC((LV_FEC_DESDELLAM - 1)) || ' 23:59:59','DD-MM-YY HH24:MI:SS');



              lv_ssql  :=' UPDATE ga_INTARCEL ';
              lv_ssql  :=lv_ssql || ' SET FEC_DESDE   =  SYSDATE';
              lv_ssql  :=lv_ssql || ' WHERE ';
              lv_ssql  :=lv_ssql || ' COD_CLIENTE        = ' ||EO_PARAM_COMER.COD_CLIENTE        || ' AND';
              lv_ssql  :=lv_ssql || ' NUM_ABONADO        = ' ||EO_PARAM_COMER.NUM_ABONADO        || ' AND';
              lv_ssql  :=lv_ssql || ' COD_PLANTARIF      = ' ||EO_PARAM_COMER.COD_PLANTARIF_NUE  || ' AND';
              lv_ssql  :=lv_ssql || ' TRUNC(FEC_DESDE)   =  TO_DATE(TRUNC(LV_FEC_DESDELLAM),DD-MM-YY)';


              lv_ssql :=EO_PARAM_COMER.FEC_VENCIMIENTO||'2';
              UPDATE ga_INTARCEL
              SET FEC_DESDE   =  SYSDATE
              WHERE
              COD_CLIENTE        =  EO_PARAM_COMER.COD_CLIENTE        AND
              NUM_ABONADO        =  EO_PARAM_COMER.NUM_ABONADO        AND
              COD_PLANTARIF      =  EO_PARAM_COMER.COD_PLANTARIF_NUE  AND
              TRUNC(FEC_DESDE)   =  TO_DATE(TRUNC(LV_FEC_DESDELLAM),'DD-MM-YY');




              lv_ssql  :=' UPDATE TOL_CLIENTE_TD';
              lv_ssql  :=lv_ssql || ' SET FEC_TER_VIG   =  SYSDATE';
              lv_ssql  :=lv_ssql || ' WHERE ';
              lv_ssql  :=lv_ssql || ' COD_CLIENTE   = ' || EO_PARAM_COMER.COD_CLIENTE     || ' AND';
              lv_ssql  :=lv_ssql || ' COD_ABONADO   = ' || EO_PARAM_COMER.NUM_ABONADO     || ' AND';
              lv_ssql  :=lv_ssql || ' COD_PLAN      = ' || EO_PARAM_COMER.COD_PLANTARIF   || ' AND';
              lv_ssql  :=lv_ssql || ' FEC_TER_VIG   = ' || TO_DATE (TRUNC((LV_FEC_DESDELLAM - 1)) || ' 23:59:59','DD-MM-YY HH24:MI:SS');


              UPDATE TOL_CLIENTE_TD
              SET FEC_TER_VIG   =  SYSDATE
              WHERE
              COD_CLIENTE   =  EO_PARAM_COMER.COD_CLIENTE       AND
              COD_ABONADO   =  EO_PARAM_COMER.NUM_ABONADO       AND
              COD_PLAN      =  EO_PARAM_COMER.COD_PLANTARIF     AND
              FEC_TER_VIG   =  TO_DATE (TRUNC((LV_FEC_DESDELLAM - 1)) || ' 23:59:59','DD-MM-YY HH24:MI:SS');




              lv_ssql  := ' UPDATE TOL_CLIENTE_TD';
              lv_ssql  :=lv_ssql || 'SET FEC_INI_VIG   =  SYSDATE';
              lv_ssql  :=lv_ssql || 'WHERE ';
              lv_ssql  :=lv_ssql || 'COD_CLIENTE   =  ' || EO_PARAM_COMER.COD_CLIENTE       || ' AND';
              lv_ssql  :=lv_ssql || 'COD_ABONADO   =  ' || EO_PARAM_COMER.NUM_ABONADO       || ' AND';
              lv_ssql  :=lv_ssql || 'COD_PLAN      =  ' || EO_PARAM_COMER.COD_PLANTARIF_NUE || ' AND';
              lv_ssql  :=lv_ssql || 'TRUNC(FEC_INI_VIG)   = ' || TO_DATE(TRUNC(LV_FEC_DESDELLAM),'DD-MM-YY');



              UPDATE TOL_CLIENTE_TD
              SET FEC_INI_VIG   =  SYSDATE
              WHERE
              COD_CLIENTE   =  EO_PARAM_COMER.COD_CLIENTE        AND
              COD_ABONADO   =  EO_PARAM_COMER.NUM_ABONADO        AND
              COD_PLAN      =  EO_PARAM_COMER.COD_PLANTARIF_NUE  AND
              TRUNC(FEC_INI_VIG)   =  TO_DATE(TRUNC(LV_FEC_DESDELLAM),'DD-MM-YY');


              lv_ssql  :=' UPDATE GA_INTARCEL_ACCIONES_TO ';
              lv_ssql  :=lv_ssql || ' SET FEC_DESDE        =  ' || TO_DATE(SYSDATE,'DD-MM-YY');
              lv_ssql  :=lv_ssql || ' WHERE';
              lv_ssql  :=lv_ssql || ' COD_CLIENTE          = ' || EO_PARAM_COMER.COD_CLIENTE       ||  ' AND';
              lv_ssql  :=lv_ssql || ' NUM_ABONADO          = ' || EO_PARAM_COMER.NUM_ABONADO       ||  ' AND';
              lv_ssql  :=lv_ssql || ' COD_ACTABO           = ' || EO_PARAM_COMER.COD_ACTABO        ||  ' AND';
              lv_ssql  :=lv_ssql || ' TRUNC(FEC_DESDE)     = ' || TO_DATE(TRUNC(LV_FEC_DESDELLAM),'DD-MM-YY');


              UPDATE GA_INTARCEL_ACCIONES_TO
              SET FEC_DESDE            =  SYSDATE
              WHERE
              COD_CLIENTE          =  EO_PARAM_COMER.COD_CLIENTE          AND
              NUM_ABONADO          =  EO_PARAM_COMER.NUM_ABONADO          AND
              COD_ACTABO           =  EO_PARAM_COMER.COD_ACTABO           AND
              TRUNC(FEC_DESDE)     =TO_DATE(TRUNC(LV_FEC_DESDELLAM),'DD-MM-YY')
              AND ROWNUM=1;


              lv_ssql  :=' UPDATE GA_LIMITE_CLIABO_TO';
              lv_ssql  :=lv_ssql || ' SET FEC_DESDE            = '|| TO_DATE(SYSDATE,'DD-MM-YY');
              lv_ssql  :=lv_ssql || ' WHERE ';
              lv_ssql  :=lv_ssql || ' COD_CLIENTE          =' || EO_PARAM_COMER.COD_CLIENTE        || ' AND ';
              lv_ssql  :=lv_ssql || ' NUM_ABONADO          =' || EO_PARAM_COMER.NUM_ABONADO        || ' AND ';
              lv_ssql  :=lv_ssql || ' COD_PLANTARIF        =' || EO_PARAM_COMER.COD_PLANTARIF_NUE  || ' AND ';
              lv_ssql  :=lv_ssql || ' TRUNC(FEC_DESDE)     =' || TO_DATE(TRUNC(LV_FEC_DESDELLAM),'DD-MM-YY');


              UPDATE GA_LIMITE_CLIABO_TO
              SET FEC_HASTA   = SYSDATE - (1/(24*60*60))
              WHERE
              COD_CLIENTE          =  EO_PARAM_COMER.COD_CLIENTE          AND
              NUM_ABONADO          =  EO_PARAM_COMER.NUM_ABONADO          AND
              COD_PLANTARIF        =  EO_PARAM_COMER.COD_PLANTARIF        AND
              FEC_DESDE            IN ( SELECT  MAX(FEC_DESDE) FROM GA_LIMITE_CLIABO_TO
                                        WHERE
                                        COD_CLIENTE          =  EO_PARAM_COMER.COD_CLIENTE          AND
                                        NUM_ABONADO          =  EO_PARAM_COMER.NUM_ABONADO          AND
                                        COD_PLANTARIF        =  EO_PARAM_COMER.COD_PLANTARIF);



              IF LV_COD_USO =2 THEN


                      UPDATE GA_LIMITE_CLIABO_TO
                      SET FEC_DESDE            =  SYSDATE + (1/(24*60*60))
                      WHERE
                      COD_CLIENTE          =  EO_PARAM_COMER.COD_CLIENTE          AND
                      NUM_ABONADO          =  EO_PARAM_COMER.NUM_ABONADO          AND
                      COD_LIMCONS          =  EO_PARAM_COMER.COD_LIMCONSUMO       AND
                      COD_PLANTARIF        =  EO_PARAM_COMER.COD_PLANTARIF_NUE    AND
                      FEC_DESDE            IN ( SELECT  MAX(FEC_DESDE) FROM GA_LIMITE_CLIABO_TO
                                                WHERE
                                                COD_CLIENTE          =  EO_PARAM_COMER.COD_CLIENTE          AND
                                                NUM_ABONADO          =  EO_PARAM_COMER.NUM_ABONADO          AND
                                                COD_LIMCONS         =  EO_PARAM_COMER.COD_LIMCONSUMO       AND
                                                COD_PLANTARIF        =  EO_PARAM_COMER.COD_PLANTARIF_NUE);

             ELSE

                  SELECT  NVL(COD_SEGMENTO,0),NVL(COD_COLOR,0)
                  INTO  LV_COD_SEGMENTO,LV_COD_COLOR
                  FROM GE_CLIENTES
                  WHERE
                  COD_CLIENTE   =  EO_PARAM_COMER.COD_CLIENTE;



                  BEGIN
                  SELECT  COD_LIMCONS ,MTO_CONS INTO LV_COD_LIM_AUX ,LV_MTO_CONS FROM TOL_LIMITE_PLAN_TD
                  WHERE COD_PLANTARIF = EO_PARAM_COMER.COD_PLANTARIF_NUE AND
                  IND_DEFAULT  ='S'         AND
                  ID_SUBSEGMENTO = LV_COD_SEGMENTO         AND
                  IND_PRIORIDAD   =  LV_COD_COLOR        AND
                  ROWNUM  =1  ;

                  EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                        LV_COD_LIM_AUX:=-1;
                        LV_MTO_CONS:=0;
                  END;


                  INSERT INTO GA_LIMITE_CLIABO_TO
                  VALUE
                  (SELECT
                      COD_CLIENTE,
                      NUM_ABONADO,
                      LV_COD_LIM_AUX,
                      SYSDATE  ,
                      NULL  ,
                      USER,
                      SYSDATE ,
                      EST_APLICA_TOL ,
                      FEC_APLICA_TOL ,
                      EO_PARAM_COMER.COD_PLANTARIF_NUE ,
                      LV_MTO_CONS
                  FROM GA_LIMITE_CLIABO_TO WHERE
                  COD_CLIENTE          =  EO_PARAM_COMER.COD_CLIENTE          AND
                  NUM_ABONADO          =  EO_PARAM_COMER.NUM_ABONADO          AND
                  COD_PLANTARIF        =  EO_PARAM_COMER.COD_PLANTARIF        AND
                  FEC_DESDE            IN ( SELECT  MAX(FEC_DESDE) FROM GA_LIMITE_CLIABO_TO
                                            WHERE
                                            COD_CLIENTE          =  EO_PARAM_COMER.COD_CLIENTE          AND
                                            NUM_ABONADO          =  EO_PARAM_COMER.NUM_ABONADO          AND
                                            COD_PLANTARIF        =  EO_PARAM_COMER.COD_PLANTARIF)
                  );

             END IF;

      end if;


   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;
         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :='PV_ACT_PARAM_COMERCIAL_PR(   EO_PARAM_COMER   ); ' || SQLERRM;
         sn_num_evento :=
         ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'pv_orden_servicio_pg.PV_ACT_PARAM_COMERCIAL_PR',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
   END PV_ACT_PARAM_COMERCIAL_PR;
   
procedure pv_registrar_carta_pr   (EN_NUM_OOSS         IN CI_ORSERV.NUM_OS%TYPE,
                                  EN_COD_OOSS         IN CI_TIPORSERV.COD_OS%TYPE,
                                  EV_Texto            in CI_CARTAS.TEXTO%TYPE,
                                  SN_COD_RETORNO    OUT NOCOPY      GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                  SV_MENS_RETORNO   OUT NOCOPY      GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                  SN_NUM_EVENTO     OUT NOCOPY      GE_ERRORES_PG.EVENTO)
                                  is
                                 
/*
<DOC>
<NOMBRE>       pv_regsitrar_carta_pr                      </NOMBRE>
<FECHACREA>   22/11/2010                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       OCB                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>     SN_COD_RETORNO : Codgio Error Controlado                  </ParamSal>
<ParamSal>     SV_MENS_RETORNO :mensaje de retorno                     </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SN_NUM_EVENTO: evento del error                 </ParamSal>
</DOC>
*/

   lv_des_error   ge_errores_pg.desevent;
   lv_ssql        ge_errores_pg.vquery;
    
BEGIN

           sn_cod_retorno := 0;
           sv_mens_retorno := NULL;
           sn_num_evento := 0;
           
           lv_ssql :='INSERT INTO CI_CARTAS(NUM_OS,FECHA,TEXTO,cod_os)';
           lv_ssql := lv_ssql || ' VALUES('||EN_NUM_OOSS||',SYSDATE,'||ev_Texto||','||EN_COD_OOSS||')';

           INSERT INTO CI_CARTAS(NUM_OS,FECHA,TEXTO,cod_os)
                        VALUES(EN_NUM_OOSS,SYSDATE,ev_Texto,EN_COD_OOSS);

  EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;
         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         sn_num_evento:=0;
         lv_des_error :='pv_registrar_carta_pr(   '||EN_NUM_OOSS||',SYSDATE,'||ev_Texto||','||EN_COD_OOSS||') ' || SQLERRM;
         sn_num_evento :=    ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'pv_orden_servicio_pg.pv_registrar_carta_pr',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
  

END pv_registrar_carta_pr;   

   

procedure pv_update_carta_pr  (EN_NUM_OOSS         IN CI_ORSERV.NUM_OS%TYPE,
                                  SN_COD_RETORNO    OUT      varchar2,
                                  SV_MENS_RETORNO   OUT      varchar2,
                                  SN_NUM_EVENTO     OUT       varchar2)
                                  is

/*
<DOC>
<NOMBRE>       pv_update_carta_pr                  </NOMBRE>
<FECHACREA>   22/11/2010                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       OCB                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>     SN_COD_RETORNO : Codgio Error Controlado                  </ParamSal>
<ParamSal>     SV_MENS_RETORNO :mensaje de retorno                     </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SN_NUM_EVENTO: evento del error                 </ParamSal>
</DOC>
*/

    lv_des_error   ge_errores_pg.desevent;
    lv_ssql        ge_errores_pg.vquery;
   
   
    LN_NUM_OS        CI_ORSERV.NUM_OS%TYPE;  
    LN_COD_OS        CI_ORSERV.COD_OS%TYPE;
    LV_NUM_ABONADO   CI_ORSERV.COD_INTER%TYPE;
    LV_FECHA         VARCHAR(21);
    LV_FEC_ALTA_MIN  VARCHAR(21);
    LV_FEC_ALTA_MIN_IMEI VARCHAR(21);
    LV_FECHA_MINIMA_EQUIPA GA_EQUIPABOSER.FEC_ALTA%TYPE;


    LV_NUM_SERIE_ABO GA_ABOCEL.NUM_SERIE%TYPE;
    LV_NUM_IMEI_ABO  GA_ABOCEL.NUM_IMEI%TYPE;

    LN_NUM_SERIE_AUX GA_EQUIPABOSER.NUM_SERIE%TYPE;
    LN_NUM_IMEI_AUX  GA_EQUIPABOSER.NUM_SERIE%TYPE;
    LV_SERIE_FINAL      GA_EQUIPABOSER.NUM_SERIE%TYPE;  

    LV_TEXTO         ci_cartas.TEXTO%TYPE;

    LN_NUM_MOVIMIENTO     GA_EQUIPABOSER.NUM_MOVIMIENTO%TYPE; 
    LV_NUM_MOVIMIENTO_AUX GA_EQUIPABOSER.NUM_MOVIMIENTO%TYPE;

BEGIN

    sn_cod_retorno := '0';
    sv_mens_retorno := 'NULL';
    sn_num_evento := '0';


    lv_ssql:='SELECT COD_INTER,  COD_OS,    TO_CHAR(FECHA,DD-MM-YYYY HH24:MI)';
    lv_ssql:=lv_ssql || 'FROM CI_ORSERV WHERE   NUM_OS ='||EN_NUM_OOSS||' and cod_os= 10070';
    
    
    SELECT COD_INTER,
           COD_OS,
         TO_CHAR(FECHA,'DD-MM-YYYY HH24:MI')
    INTO   LV_NUM_ABONADO,LN_COD_OS,LV_FECHA      
    FROM CI_ORSERV WHERE   NUM_OS =EN_NUM_OOSS   and cod_os= '10070';
    
    
    --DBMS_OUTPUT.PUT_LINE('NUM_ABONADO :'||LV_NUM_ABONADO);
    --DBMS_OUTPUT.PUT_LINE('COD_OS:'||LN_COD_OS);
    --DBMS_OUTPUT.PUT_LINE('FECHA:'||LV_FECHA);
    
    if  trim(LN_COD_OS) ='10070' then
            
    
            lv_ssql:=' SELECT  NUM_SERIE,NUM_IMEI';
            lv_ssql:=lv_ssql || ' INTO  LV_NUM_SERIE_ABO,LV_NUM_IMEI_ABO';
            lv_ssql:=lv_ssql || ' FROM  GA_ABOCEL WHERE NUM_ABONADO = '|| LV_NUM_ABONADO;
            lv_ssql:=lv_ssql || ' UNION';
            lv_ssql:=lv_ssql || ' SELECT  NUM_SERIE,NUM_IMEI';
            lv_ssql:=lv_ssql || ' FROM  GA_ABOAMIST WHERE NUM_ABONADO ='||LV_NUM_ABONADO;
    
    
            SELECT  NUM_SERIE,NUM_IMEI
            INTO  LV_NUM_SERIE_ABO,LV_NUM_IMEI_ABO
            FROM  GA_ABOCEL WHERE NUM_ABONADO =  LV_NUM_ABONADO
            UNION
            SELECT  NUM_SERIE,NUM_IMEI
            FROM  GA_ABOAMIST WHERE NUM_ABONADO =  LV_NUM_ABONADO;
             
            --DBMS_OUTPUT.PUT_LINE('NUM_SERIE :'||LV_NUM_SERIE_ABO);
            --DBMS_OUTPUT.PUT_LINE('NUM_IMEI:'||LV_NUM_IMEI_ABO);
            
            
            
            
            lv_ssql:='SELECT  NUM_MOVIMIENTO ';
            lv_ssql:=lv_ssql || ' INTO LN_NUM_MOVIMIENTO';
            lv_ssql:=lv_ssql || ' FROM GA_EQUIPABOSER';
            lv_ssql:=lv_ssql || ' WHERE NUM_ABONADO  =LV_NUM_ABONADO';
            lv_ssql:=lv_ssql || ' AND FEC_ALTA IN (  SELECT  MAX(FEC_ALTA)';
            lv_ssql:=lv_ssql || ' FROM GA_EQUIPABOSER ';
            lv_ssql:=lv_ssql || '                    WHERE NUM_ABONADO  =LV_NUM_ABONADO';
            lv_ssql:=lv_ssql || '                   AND   NUM_SERIE= LV_NUM_SERIE_ABO';
            lv_ssql:=lv_ssql || '                             )'  ;
            lv_ssql:=lv_ssql || ' AND   NUM_SERIE= LV_NUM_SERIE_ABO';
            
            
            SELECT  NUM_MOVIMIENTO 
            INTO LN_NUM_MOVIMIENTO
            FROM GA_EQUIPABOSER
            WHERE NUM_ABONADO  =LV_NUM_ABONADO
            AND FEC_ALTA IN (  SELECT  MAX(FEC_ALTA)
                               FROM GA_EQUIPABOSER 
                               WHERE NUM_ABONADO  =LV_NUM_ABONADO
                               AND   NUM_SERIE= LV_NUM_SERIE_ABO
                             )  
            AND   NUM_SERIE= LV_NUM_SERIE_ABO;
            
            -- DBMS_OUTPUT.PUT_LINE('MOVIMIENTO:'||LN_NUM_MOVIMIENTO);
            
            
            
            lv_ssql:=' SELECT   MIN( TO_CHAR(FEC_ALTA,DD-MM-YYYY HH24:MI))';
            lv_ssql:=lv_ssql || ' INTO LV_FEC_ALTA_MIN';
            lv_ssql:=lv_ssql || ' FROM GA_EQUIPABOSER';
            lv_ssql:=lv_ssql || ' WHERE   NUM_ABONADO  =LV_NUM_ABONADO';
            lv_ssql:=lv_ssql || ' AND  NUM_SERIE= LV_NUM_SERIE_ABO;';
            
            
            
            
            
            SELECT   MIN( TO_CHAR(FEC_ALTA,'DD-MM-YYYY HH24:MI'))
            INTO LV_FEC_ALTA_MIN
            FROM GA_EQUIPABOSER
            WHERE   NUM_ABONADO  =LV_NUM_ABONADO
            AND  NUM_SERIE= LV_NUM_SERIE_ABO;
            
            -- DBMS_OUTPUT.PUT_LINE('FECHA MINIMA SERIE  :'||LV_FEC_ALTA_MIN);
            
            SELECT   MIN( TO_CHAR(FEC_ALTA,'DD-MM-YYYY HH24:MI'))
            INTO LV_FEC_ALTA_MIN_IMEI
            FROM GA_EQUIPABOSER
            WHERE   NUM_ABONADO  =LV_NUM_ABONADO
            AND  NUM_SERIE= LV_NUM_IMEI_ABO;
            
            
            lv_ssql:= ' SELECT   MIN( TO_CHAR(FEC_ALTA,DD-MM-YYYY HH24:MI))';
            lv_ssql:=lv_ssql || ' INTO LV_FEC_ALTA_MIN_IMEI';
            lv_ssql:=lv_ssql || ' FROM GA_EQUIPABOSER';
            lv_ssql:=lv_ssql || ' WHERE   NUM_ABONADO  =LV_NUM_ABONADO';
            lv_ssql:=lv_ssql || ' AND  NUM_SERIE= LV_NUM_IMEI_ABO;';
            
            
            
            
            -- DBMS_OUTPUT.PUT_LINE('FECHA MINIMA IMEI  :'||LV_FEC_ALTA_MIN_IMEI);
            
            
            IF TRIM(LV_FEC_ALTA_MIN) IS NOT NULL THEN
               IF TRIM(LV_FEC_ALTA_MIN)= TRIM(LV_FECHA) THEN
               
               
                   BEGIN


                            lv_ssql:=' SELECT  NUM_SERIE';
                            lv_ssql:=lv_ssql || ' INTO LN_NUM_SERIE_AUX';
                            lv_ssql:=lv_ssql || ' FROM GA_EQUIPABOSER';
                            lv_ssql:=lv_ssql || ' WHERE NUM_ABONADO  =LV_NUM_ABONADO';
                            lv_ssql:=lv_ssql || ' AND TO_CHAR(FEC_ALTA,DD-MM-YYYY HH24:MI) =LV_FECHA';
                            lv_ssql:=lv_ssql || ' AND   NUM_SERIE= LV_NUM_SERIE_ABO ;';

                             
                            SELECT  NUM_SERIE
                            INTO LN_NUM_SERIE_AUX
                            FROM GA_EQUIPABOSER
                            WHERE NUM_ABONADO  =LV_NUM_ABONADO
                            AND TO_CHAR(FEC_ALTA,'DD-MM-YYYY HH24:MI') =LV_FECHA
                            AND   NUM_SERIE= LV_NUM_SERIE_ABO ;
                            
                            
                            
                            SELECT  NUM_SERIE,NUM_MOVIMIENTO
                            INTO LN_NUM_SERIE_AUX,LV_NUM_MOVIMIENTO_AUX
                            FROM GA_EQUIPABOSER
                            WHERE NUM_ABONADO  =LV_NUM_ABONADO
                            AND TO_CHAR(FEC_ALTA,'DD-MM-YYYY HH24:MI') = LV_FECHA
                            AND   NUM_SERIE<> LV_NUM_SERIE_ABO AND NUM_MOVIMIENTO>0;
                            
                            
                            lv_ssql:= ' SELECT  NUM_SERIE,NUM_MOVIMIENTO';
                            lv_ssql:=lv_ssql || ' INTO LN_NUM_SERIE_AUX,LV_NUM_MOVIMIENTO_AUX';
                            lv_ssql:=lv_ssql || ' FROM GA_EQUIPABOSER';
                            lv_ssql:=lv_ssql || ' WHERE NUM_ABONADO  =LV_NUM_ABONADO';
                            lv_ssql:=lv_ssql || ' AND TO_CHAR(FEC_ALTA,DD-MM-YYYY HH24:MI) = LV_FECHA';
                            lv_ssql:=lv_ssql || ' AND   NUM_SERIE<> LV_NUM_SERIE_ABO AND NUM_MOVIMIENTO>0;';
                            
                            IF LV_NUM_MOVIMIENTO_AUX> 0 THEN 
                                SELECT MIN(FEC_ALTA)
                                INTO LV_FECHA_MINIMA_EQUIPA
                                FROM GA_EQUIPABOSER
                                WHERE 
                                NUM_ABONADO    =LV_NUM_ABONADO
                                and   NUM_MOVIMIENTO = LV_NUM_MOVIMIENTO_AUX;
                                --DBMS_OUTPUT.PUT_LINE('LA OTRA OPCION2');
                                
                                --DBMS_OUTPUT.PUT_LINE('lv_fecha:'||TO_DATE(LV_FECHA,'DD-MM-YYYY HH24:MI'));
                                --DBMS_OUTPUT.PUT_LINE('LV_FECHA_MINIMA_EQUIPA:'||LV_FECHA_MINIMA_EQUIPA);
                                IF LV_FECHA_MINIMA_EQUIPA <  TO_DATE(LV_FECHA,'DD-MM-YYYY HH24:MI') THEN
                                
                                        --DBMS_OUTPUT.PUT_LINE('LA OTRA OPCION2');
                                        SELECT  NUM_SERIE
                                        INTO LN_NUM_SERIE_AUX
                                        FROM GA_EQUIPABOSER
                                        WHERE NUM_ABONADO  =LV_NUM_ABONADO
                                        AND TO_CHAR(FEC_ALTA,'DD-MM-YYYY HH24:MI') = LV_FECHA
                                        AND   NUM_SERIE<> LV_NUM_SERIE_ABO AND NUM_MOVIMIENTO<>LV_NUM_MOVIMIENTO_AUX;
                                        --DBMS_OUTPUT.PUT_LINE('Serie de la Simcard:'||LN_NUM_SERIE_AUX||' asociada a la OOSS N°:'||LN_NUM_OS);
                                        LV_SERIE_FINAL:=LN_NUM_SERIE_AUX;
                                        
                                else
                                  --DBMS_OUTPUT.PUT_LINE('Serie del Equipo:'||LN_NUM_SERIE_AUX||' asociada a la OOSS N°:'||LN_NUM_OS);
                                        LV_SERIE_FINAL:=LN_NUM_SERIE_AUX;        
                                END IF;  
                                
                            ELSE
                                --DBMS_OUTPUT.PUT_LINE('Serie del Simcard:'||LN_NUM_SERIE_AUX||' asociada a la OOSS N°:'||LN_NUM_OS);
                                      LV_SERIE_FINAL:=LN_NUM_SERIE_AUX;
                            END IF;
                            
                            EXCEPTION
                                      WHEN NO_DATA_FOUND THEN
                                      
                                      
                                      BEGIN
                                      
                                      SELECT  NUM_SERIE
                                      INTO LN_NUM_IMEI_AUX
                                      FROM GA_EQUIPABOSER
                                      WHERE NUM_ABONADO  =LV_NUM_ABONADO
                                      AND TO_CHAR(FEC_ALTA,'DD-MM-YYYY HH24:MI') =LV_FECHA
                                      AND   NUM_SERIE=LV_NUM_IMEI_ABO;
                                      
                                      SELECT  NUM_SERIE
                                      INTO LN_NUM_IMEI_AUX
                                      FROM GA_EQUIPABOSER
                                      WHERE NUM_ABONADO  =LV_NUM_ABONADO
                                      AND TO_CHAR(FEC_ALTA,'DD-MM-YYYY HH24:MI') =LV_FECHA
                                      AND   NUM_SERIE<>LV_NUM_IMEI_ABO AND NUM_MOVIMIENTO>0;
                                      
                                      
                                      --DBMS_OUTPUT.PUT_LINE('Serie del Equipo:'||LN_NUM_IMEI_AUX||' asociada a la OOSS N°:'||LN_NUM_OS);
                                            LV_SERIE_FINAL:=LN_NUM_IMEI_AUX;
                                      
                                      EXCEPTION    WHEN NO_DATA_FOUND THEN
                                                   NULL;
                                      END;
                                        
                            END;
               
                   --DBMS_OUTPUT.PUT_LINE('Serie de la Simcard:'||LV_NUM_SERIE_ABO||' asociada a la OOSS N°:'||LN_NUM_OS);
                       LV_SERIE_FINAL:=LV_NUM_SERIE_ABO;
                   
               ELSE 
                     IF TRIM(LV_FEC_ALTA_MIN_IMEI)= TRIM(LV_FECHA) THEN
                       --DBMS_OUTPUT.PUT_LINE('Serie del Equipo:'||LV_NUM_IMEI_ABO||' asociada a la OOSS N°:'||LN_NUM_OS);
                        LV_SERIE_FINAL:=LV_NUM_IMEI_ABO;
                     ELSE
                           --DBMS_OUTPUT.PUT_LINE('LA OTRA OPCION');
                                          
                            BEGIN
                             
                            SELECT  NUM_SERIE
                            INTO LN_NUM_SERIE_AUX
                            FROM GA_EQUIPABOSER
                            WHERE NUM_ABONADO  =LV_NUM_ABONADO
                            AND TO_CHAR(FEC_ALTA,'DD-MM-YYYY HH24:MI') =LV_FECHA
                            AND   NUM_SERIE<> LV_NUM_SERIE_ABO;
                            
                            --DBMS_OUTPUT.PUT_LINE('Serie de la Simcard:'||LN_NUM_SERIE_AUX||' asociada a la OOSS N°:'||LN_NUM_OS);
                            LV_SERIE_FINAL:=LN_NUM_SERIE_AUX;
                            
                            EXCEPTION
                                      WHEN NO_DATA_FOUND THEN
                                      
                                      
                                      BEGIN
                                      
                                      SELECT  NUM_SERIE
                                      INTO LN_NUM_IMEI_AUX
                                      FROM GA_EQUIPABOSER
                                      WHERE NUM_ABONADO  =LV_NUM_ABONADO
                                      AND TO_CHAR(FEC_ALTA,'DD-MM-YYYY HH24:MI') =LV_FECHA
                                      AND   NUM_SERIE<> LV_NUM_IMEI_ABO;
                                      
                                      --DBMS_OUTPUT.PUT_LINE('Serie de la Simcard:'||LN_NUM_IMEI_AUX||' asociada a la OOSS N°:'||LN_NUM_OS);
                                      LV_SERIE_FINAL:=LN_NUM_IMEI_AUX;
                                      
                                      EXCEPTION    WHEN NO_DATA_FOUND THEN
                                                   NULL;
                                      END;
                                        
                            END;
                     end if;  
               END IF;
               
               
                if LV_SERIE_FINAL is not null then
                --DBMS_OUTPUT.PUT_LINE('Serie :'||LV_SERIE_FINAL||' asociada a la OOSS N°:'||LN_NUM_OS);
    
                UPDATE CI_CARTAS
                SET TEXTO='Informamos a Ud. que hemos procedido a efectuar la restitucion de su equipo, quedando su nuevo Nro. de serie en '|| LV_SERIE_FINAL|| CHR(13)||CHR(13)|| 'Saluda atentamente,';
              
               end if;
               
           END IF;
    
    end if;
           

  EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;
         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         sn_num_evento:=0;
         lv_des_error :='pv_registrar_carta_pr(   '||EN_NUM_OOSS||') ' || SQLERRM;
         sn_num_evento :=    ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'pv_orden_servicio_pg.pv_update_carta_pr',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );


END pv_update_carta_pr;



END Pv_Orden_Servicio_Pg;
/
SHOW ERRORS