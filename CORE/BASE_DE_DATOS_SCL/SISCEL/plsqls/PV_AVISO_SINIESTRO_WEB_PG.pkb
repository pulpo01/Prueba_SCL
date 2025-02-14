CREATE OR REPLACE PACKAGE BODY SISCEL.PV_AVISO_SINIESTRO_WEB_PG IS

--PV_AVISO_SINIESTRO_WEB_PG v1.1 COL-70900;20-11-2008;AVC

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION pv_rec_cant_siniestro_fn (
          en_num_abonado      IN              ga_abocel.num_abonado%TYPE,
      ev_num_serie        IN              ga_abocel.num_serie%TYPE,
      sn_cant_siniestro   OUT NOCOPY      NUMBER,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_RECUPERA_ESTADO_OOSS_FN"
              Lenguaje="PL/SQL"
              Fecha="20-11-2007"
              Versión="1.0"
              Diseñador="Marcelo Godoy"
              Programador="CAGV"
              Ambiente Desarrollo="BD">
              <Retorno>SEO_dat_abo</Retorno>>
              <Descripción>Retorna estado orden de servicio</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="en_num_ooss Tipo="NUMERICO">número orden de servicio</param>>
                 </Entrada>
                 <Salida>
                            <param nom="sv_estado_ooss" Tipo="CARACTER">Estado orden de servicio</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
IS

    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;
        LN_cod_estado     number;
        LN_tip_estado     number;

        BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

        SELECT COUNT(1)
          INTO sn_cant_siniestro
          FROM ga_siniestros
         WHERE num_abonado = en_num_abonado
           AND num_serie = ev_num_serie;

    RETURN TRUE;

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 999;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_RECUPERA_ESTADO_OOSS_FN'||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_RECUPERA_ESTADO_OOSS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;

   END pv_rec_cant_siniestro_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION pv_val_sinistro_pendiente_fn (
      eo_dat_abo        IN              pv_datos_abo_qt,
      ev_tipo_sinie     IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_RECUPERA_ESTADO_OOSS_FN"
              Lenguaje="PL/SQL"
              Fecha="20-11-2007"
              Versión="1.0"
              Diseñador="Marcelo Godoy"
              Programador="CAGV"
              Ambiente Desarrollo="BD">
              <Retorno>SEO_dat_abo</Retorno>>
              <Descripción>Retorna estado orden de servicio</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="en_num_ooss Tipo="NUMERICO">número orden de servicio</param>>
                 </Entrada>
                 <Salida>
                            <param nom="sv_estado_ooss" Tipo="CARACTER">Estado orden de servicio</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
IS

    LV_des_error            ge_errores_pg.DesEvent;
    LV_sSql                 ge_errores_pg.vQuery;
        LN_cod_estado           number;
        LN_tip_estado           number;
    n_cant_siniestro_serie  NUMBER;
        n_cant_siniestro_imei   NUMBER;
        error_aplicacion        EXCEPTION;
        BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';


        IF eo_dat_abo.cod_tecnologia = 'CDMA' THEN

        IF NOT (pv_rec_cant_siniestro_fn(eo_dat_abo.num_abonado, eo_dat_abo.num_serie,n_cant_siniestro_serie,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
                RAISE error_aplicacion;
        END IF;

        IF n_cant_siniestro_serie >0 THEN
                        SV_mens_retorno := 'ABONADO YA CUENTA CON SINIESTRO DEL EQUIPO.';
                        RAISE error_aplicacion;
                END IF;

        ELSE -- TECNOLOGIA GSM

        IF NOT (pv_rec_cant_siniestro_fn(eo_dat_abo.num_abonado, eo_dat_abo.num_serie,n_cant_siniestro_serie,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
                RAISE error_aplicacion;
            END IF;

        IF NOT (pv_rec_cant_siniestro_fn(eo_dat_abo.num_abonado, eo_dat_abo.num_imei,n_cant_siniestro_imei,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
                RAISE error_aplicacion;
            END IF;

                IF EV_tipo_sinie = 'A' THEN
                    IF n_cant_siniestro_imei > 0 THEN
                                SV_mens_retorno := 'ABONADO YA CUENTA CON SINIESTRO DEL EQUIPO.';
                                RAISE error_aplicacion;
                        END IF;

                        IF n_cant_siniestro_serie > 0 THEN
                                SV_mens_retorno := 'ABONADO YA CUENTA CON SINIESTRO DE SIMCARD.';
                                RAISE error_aplicacion;
                        END IF;
                END IF;

                IF EV_tipo_sinie = 'E' THEN
                        IF n_cant_siniestro_imei >0 THEN
                                SV_mens_retorno := 'ABONADO YA CUENTA CON SINIESTRO DEL EQUIPO.';
                                RAISE error_aplicacion;
                        END IF;
                END IF;

                IF EV_tipo_sinie = 'S' THEN
                        IF n_cant_siniestro_serie >0 THEN
                                SV_mens_retorno := 'ABONADO YA CUENTA CON SINIESTRO DE LA SIMCARD.';
                                RAISE error_aplicacion;
                        END IF;
                END IF;

        END IF;

        RETURN TRUE;

        EXCEPTION
        WHEN error_aplicacion THEN
                  LV_des_error   := 'pv_aviso_siniestro_web_pg.pv_val_sinistro_pendiente_fn'||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'pv_aviso_siniestro_web_pg.pv_val_sinistro_pendiente_fn', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;

   END pv_val_sinistro_pendiente_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE pv_tipos_siniestro_pr (
      eo_dat_abo         IN              pv_datos_abo_qt,
      sc_tip_siniestro   OUT             refcursor,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_TIPOS_SINIESTRO_PR"
              Lenguaje="PL/SQL"
              Fecha="20-11-2007"
              Versión="1.0"
              Diseñador="Marcelo Godoy"
              Programador="CAGV"
              Ambiente Desarrollo="BD">
              <Retorno>SEO_dat_abo</Retorno>>
              <Descripción>Retorna información de los tipos de siniestros</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="eo_dat_abo Tipo="OBJETO ">Datos abonado</param>>
                 </Entrada>
                 <Salida>
                            <param nom="SC_tip_siniestro" Tipo="CURSOR">Lista de siniestros</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
IS

    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;
    o_dat_abo         pv_datos_abo_qt := NEW pv_datos_abo_qt;
        TIPO              VARCHAR2(2);
        error_datos       EXCEPTION;
        error_aplicacion  EXCEPTION;
        n_cant_siniestro_serie  NUMBER;
        n_cant_siniestro_imei   NUMBER;
        BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

        o_dat_abo.num_abonado := eo_dat_abo.num_abonado;
    pv_cambio_serie_sb_pg.pv_rec_info_abonado_pr(o_dat_abo,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno <> 0 THEN
            RAISE error_datos;
        END IF;


        IF eo_dat_abo.cod_tecnologia <> 'GSM' THEN

        IF NOT (pv_rec_cant_siniestro_fn(o_dat_abo.num_abonado, o_dat_abo.num_serie,n_cant_siniestro_serie,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
                RAISE error_aplicacion;
        END IF;

        IF n_cant_siniestro_serie >0 THEN
                    TIPO := '';                  -- Existe Siniestro en equipo con tecnologia <> a GSM
                ELSE
                    TIPO := 'E';                         -- No Existe Siniestro en equipo con tecnologia <> a GSM  Muestra Solo SINIESTRO EQUIPO
                END IF;

        ELSE -- TECNOLOGIA GSM

        IF NOT (pv_rec_cant_siniestro_fn(o_dat_abo.num_abonado, o_dat_abo.num_serie,n_cant_siniestro_serie,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
                RAISE error_aplicacion;
            END IF;

        IF NOT (pv_rec_cant_siniestro_fn(o_dat_abo.num_abonado, o_dat_abo.num_imei,n_cant_siniestro_imei,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
                RAISE error_aplicacion;
            END IF;


                IF (n_cant_siniestro_imei > 0 AND n_cant_siniestro_serie > 0) THEN
                    TIPO := '';
                ELSIF (n_cant_siniestro_imei > 0 AND n_cant_siniestro_serie = 0) THEN
                    TIPO := 'S';
                ELSIF (n_cant_siniestro_imei = 0 AND n_cant_siniestro_serie > 0) THEN
                    TIPO := 'E';
                ELSIF (n_cant_siniestro_imei = 0 AND n_cant_siniestro_serie = 0) THEN
                    TIPO := '%';
                ELSE
                    RAISE error_datos;
                END IF;

        END IF;



        LV_sSql:='SELECT  cod_valor, des_valor  FROM ged_codigos ';
        LV_sSql:=LV_sSql||' WHERE cod_modulo = '''||cv_cod_modulo_ga||'''';
        LV_sSql:=LV_sSql||'  AND nom_tabla = ''GA_SINIESTROS''';
        LV_sSql:=LV_sSql||'  AND nom_columna = ''TIP_SINIESTRO''';
        LV_sSql:=LV_sSql||'  AND cod_valor LIKE '''||TIPO||'''';
        LV_sSql:=LV_sSql||' ORDER BY des_valor ASC';

        OPEN sc_tip_Siniestro FOR
        SELECT   cod_valor, des_valor
            FROM ged_codigos
           WHERE cod_modulo = cv_cod_modulo_ga
             AND nom_tabla = 'GA_SINIESTROS'
             AND nom_columna = 'TIP_SINIESTRO'
             AND cod_valor LIKE TIPO

        ORDER BY des_valor ASC;






        EXCEPTION
        WHEN error_datos THEN
              SN_cod_retorno := 56987;
          SV_mens_retorno := 'Error datos Abonado';
                  LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_TIPOS_SINIESTRO_PR'||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_TIPOS_SINIESTRO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
              SN_cod_retorno := 999;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_TIPOS_SINIESTRO_PR'||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_TIPOS_SINIESTRO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_TIPOS_SINIESTRO_PR;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_tipo_suspension_pr (
      sc_tip_suspension   OUT          refcursor,
      sn_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY   ge_errores_pg.evento
   )
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_TIPO_SUSPENSION_PR
              Lenguaje="PL/SQL"
              Fecha="20-11-2007"
              Versión="1.0"
              Diseñador="Marcelo Godoy"
              Programador="CAGV"
              Ambiente Desarrollo="BD">
              <Retorno>SEO_dat_abo</Retorno>>
              <Descripción>Retorna información de los tipos de suspencion</Descripción>>
              <Parámetros>
                 <Entrada>
                 </Entrada>
                 <Salida>
                            <param nom="SC_tip_suspension" Tipo="CURSOR">Lista de suspenciones</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
IS

    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;
    v_cod_retorno      ge_errores_pg.CodError;
    v_mens_retorno     ge_errores_pg.MsgError;
    v_num_evento       ge_errores_pg.Evento;
    v_cod_operadora    ge_parametros_sistema_vw.VALOR_TEXTO%TYPE;

        BEGIN

       SN_cod_retorno := 0;
       SN_num_evento  := 0;
       SV_mens_retorno:= '';
       v_cod_retorno:=0;
       v_mens_retorno:='';
       v_num_evento:=0;


       v_cod_operadora:=GE_OBTIENE_OPERADORA_LOCAL_FN(v_cod_retorno,v_mens_retorno,v_num_evento);
       IF v_cod_retorno <> 0 THEN
          NULL;
       END IF;





        IF TRIM(V_cod_operadora)='TMS' THEN
            LV_sSql:='SELECT cod_valor, des_valor FROM GED_CODIGOS ';
            LV_sSql:=LV_sSql||' WHERE  cod_modulo = '''||cv_cod_modulo_ga||'''';
            LV_sSql:=LV_sSql||'  AND    nom_tabla = ''GA_SINIESTROS''';
            LV_sSql:=LV_sSql||'  AND    nom_columna = ''TIP_SUSPENSION''';
            LV_sSql:=LV_sSql||'  AND    COD_VALOR  <> ''0''';
            LV_sSql:=LV_sSql||' ORDER BY DES_VALOR ASC';

            OPEN sc_tip_suspension FOR
            SELECT   cod_valor, des_valor
                FROM ged_codigos
               WHERE cod_modulo = cv_cod_modulo_ga
                 AND nom_tabla = 'GA_SINIESTROS'
                 AND nom_columna = 'TIP_SUSPENSION'
                 AND COD_VALOR  <> '0'
            ORDER BY des_valor ASC;
        ELSE

            LV_sSql:='SELECT cod_valor, des_valor FROM GED_CODIGOS ';
            LV_sSql:=LV_sSql||' WHERE  cod_modulo = '''||cv_cod_modulo_ga||'''';
            LV_sSql:=LV_sSql||'  AND    nom_tabla = ''GA_SINIESTROS''';
            LV_sSql:=LV_sSql||'  AND    nom_columna = ''TIP_SUSPENSION''';
            LV_sSql:=LV_sSql||'  AND    COD_VALOR  <> ''0'' AND COD_VALOR <> ''2''';
            LV_sSql:=LV_sSql||' ORDER BY DES_VALOR ASC';

            OPEN sc_tip_suspension FOR
            SELECT   cod_valor, des_valor
                FROM ged_codigos
               WHERE cod_modulo = cv_cod_modulo_ga
                 AND nom_tabla = 'GA_SINIESTROS'
                 AND nom_columna = 'TIP_SUSPENSION'
                 AND COD_VALOR  <> '0' AND  COD_VALOR  <> '2'
            ORDER BY des_valor ASC;
        END IF;






        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 999;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_TIPO_SUSPENSION_PR'||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_TIPO_SUSPENSION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


   END PV_TIPO_SUSPENSION_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE pv_causa_siniestro_pr (
      eo_dat_abo           IN              pv_datos_abo_qt,
      ev_cod_actabo        IN              pv_serv_suspreha_to.cod_actabo%TYPE,
      sc_causa_siniestro   OUT             refcursor,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_CAUSA_SINIESTRO_PR
              Lenguaje="PL/SQL"
              Fecha="20-11-2007"
              Versión="1.0"
              Diseñador="Marcelo Godoy"
              Programador="CAGV"
              Ambiente Desarrollo="BD">
              <Retorno>SEO_dat_abo</Retorno>>
              <Descripción>Retorna información de la causa siniestro</Descripción>>
              <Parámetros>
                 <Entrada>
                            <param nom="eo_dat_abo Tipo="OBJETO ">Datos abonado</param>>
                    <param nom="ev_cod_actabo Tipo="CARACTER">Código actuacion abonado</param>>
                 </Entrada>
                 <Salida>
                            <param nom="sc_causa_siniestro" Tipo="CURSOR">Lista de causa siniestros</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
IS
        LV_cod_servicio   PV_SERV_SUSPREHA_TO.COD_SERVICIO%TYPE;
    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;

        BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

        LV_sSql:='SELECT a.cod_servicio FROM pv_serv_suspreha_to a';
        LV_sSql:=LV_sSql||' WHERE a.cod_producto = 1 AND a.cod_modulo = '''||cv_cod_modulo_ga||'''';
        LV_sSql:=LV_sSql||' AND EXISTS (SELECT b.cod_tiplan FROM ta_plantarif b WHERE b.cod_producto = 1 ';
        LV_sSql:=LV_sSql||' AND b.cod_plantarif = '''||eo_dat_abo.cod_plantarif||''' AND a.cod_tiplan = b.cod_tiplan)';
        LV_sSql:=LV_sSql||' AND a.cod_tecnologia = eo_dat_abo.cod_tecnologia';
        LV_sSql:=LV_sSql||' AND a.cod_actabo = ev_cod_actabo';

        SELECT a.cod_servicio
          INTO lv_cod_servicio
          FROM pv_serv_suspreha_to a
         WHERE a.cod_producto = 1
           AND a.cod_modulo = cv_cod_modulo_ga
           AND EXISTS (
                  SELECT b.cod_tiplan
                    FROM ta_plantarif b
                   WHERE b.cod_producto = 1
                     AND b.cod_plantarif = eo_dat_abo.cod_plantarif
                     AND a.cod_tiplan = b.cod_tiplan)
           AND a.cod_tecnologia = eo_dat_abo.cod_tecnologia
           AND a.cod_actabo = ev_cod_actabo;


        LV_sSql:='SELECT des_causa, cod_causa, cod_servicio, lv_cod_servicio, cod_caususp ';
        LV_sSql:=LV_sSql||' FROM ga_causinie';
        LV_sSql:=LV_sSql||' WHERE cod_producto ='''||cv_prod_celular||''' AND cod_servicio ='''||lv_cod_servicio||'''';

        OPEN sc_causa_siniestro FOR
        SELECT des_causa, cod_causa, cod_servicio, lv_cod_servicio, cod_caususp
          FROM ga_causinie
         WHERE cod_producto = cv_prod_celular;

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 999;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_CAUSA_SINIESTRO_PR'||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_CAUSA_SINIESTRO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CAUSA_SINIESTRO_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION pv_recupera_estado_ooss_fn (
      en_num_ooss       IN              pv_iorserv.num_os%TYPE,
      sv_estado_ooss    OUT             pv_iorserv.cod_estado%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_RECUPERA_ESTADO_OOSS_FN"
              Lenguaje="PL/SQL"
              Fecha="20-11-2007"
              Versión="1.0"
              Diseñador="Marcelo Godoy"
              Programador="CAGV"
              Ambiente Desarrollo="BD">
              <Retorno>SEO_dat_abo</Retorno>>
              <Descripción>Retorna estado orden de servicio</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="en_num_ooss Tipo="NUMERICO">número orden de servicio</param>>
                 </Entrada>
                 <Salida>
                            <param nom="sv_estado_ooss" Tipo="CARACTER">Estado orden de servicio</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
IS

    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;
        LN_cod_estado     number;
        LN_tip_estado     number;

        BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';


                LV_sSql:='SELECT a.cod_estado,b.tip_estado FROM PV_IORSERV a, PV_ERECORRIDO b ';
                LV_sSql:=LV_sSql||' WHERE  a.num_os = b.num_os AND a.cod_estado = b.cod_estado ';
                LV_sSql:=LV_sSql||' AND    a.cod_modgener = ''ACF'' AND a.cod_os ='||CN_cod_ooss;
                LV_sSql:=LV_sSql||' AND    a.num_os = '||EN_num_ooss;
                LV_sSql:=LV_sSql||' UNION ';
                LV_sSql:=LV_sSql||' SELECT a.cod_estado,b.tip_estado FROM PVH_IORSERV a, PVH_ERECORRIDO b ';
                LV_sSql:=LV_sSql||' WHERE  a.num_os = b.num_os AND a.cod_estado = b.cod_estado ';
                LV_sSql:=LV_sSql||' AND    a.cod_modgener = ''ACF'' AND a.cod_os = '||CN_cod_ooss;
                LV_sSql:=LV_sSql||' and    a.num_os = '||EN_num_ooss;

                SELECT a.cod_estado, b.tip_estado
                  INTO ln_cod_estado, ln_tip_estado
                  FROM pv_iorserv a, pv_erecorrido b
                 WHERE a.num_os = b.num_os
                   AND a.cod_estado = b.cod_estado
                   AND a.cod_modgener = 'ACF'
                   AND a.cod_os = cn_cod_ooss
                   AND a.num_os = en_num_ooss
                UNION
                SELECT a.cod_estado, b.tip_estado
                  FROM pvh_iorserv a, pvh_erecorrido b
                 WHERE a.num_os = b.num_os
                   AND a.cod_estado = b.cod_estado
                   AND a.cod_modgener = 'ACF'
                   AND a.cod_os = cn_cod_ooss
                   AND a.num_os = en_num_ooss;

                SV_estado_ooss:=LN_cod_estado;

                RETURN TRUE;

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 999;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_RECUPERA_ESTADO_OOSS_FN'||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_RECUPERA_ESTADO_OOSS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;

END PV_RECUPERA_ESTADO_OOSS_FN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION pv_recupera_num_sinies_fn (
      eo_dat_abo         IN              pv_datos_abo_qt,
      ev_cod_servicio    IN              ga_siniestros.cod_servicio%TYPE,
      sn_num_siniestro   OUT             ga_siniestros.num_siniestro%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_RECUPERA_NUM_SINIES_FN"
              Lenguaje="PL/SQL"
              Fecha="20-11-2007"
              Versión="1.0"
              Diseñador="Marcelo Godoy"
              Programador="CAGV"
              Ambiente Desarrollo="BD">
              <Retorno>SEO_dat_abo</Retorno>>
              <Descripción>Retorna numero siniestro/Descripción>>
              <Parámetros>
                 <Entrada>
                            <param nom="eo_dat_abo Tipo="OBJETO ">Datos abonado</param>>
                    <param nom="ev_cod_servicio Tipo="CARACTER">código servicio</param>>
                 </Entrada>
                 <Salida>
                            <param nom="sn_num_siniestro" Tipo="NUMERICO">Número siniestro</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
IS
    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;

        BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

        LV_sSql:='SELECT num_siniestro FROM ga_siniestros ';
        LV_sSql:=LV_sSql||' WHERE num_abonado = '||eo_dat_abo.num_abonado;
        LV_sSql:=LV_sSql||' AND cod_servicio = '''||ev_cod_servicio||'''';
        LV_sSql:=LV_sSql||' AND num_serie = '''||eo_dat_abo.num_serie||'''';

        SELECT num_siniestro
          INTO sn_num_siniestro
          FROM ga_siniestros
         WHERE num_abonado = eo_dat_abo.num_abonado
           AND cod_servicio = ev_cod_servicio
           AND num_serie = eo_dat_abo.num_serie;

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 999;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_RECUPERA_NUM_SINIES_FN'||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_RECUPERA_NUM_SINIES_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
END PV_RECUPERA_NUM_SINIES_FN;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION pv_valida_ooss_fn (
      eo_dat_abo        IN              pv_datos_abo_qt,
      en_num_ooss       IN              pv_camcom.num_os%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_VALIDA_OOSS_FN"
              Lenguaje="PL/SQL"
              Fecha="20-11-2007"
              Versión="1.0"
              Diseñador="Marcelo Godoy"
              Programador="CAGV"
              Ambiente Desarrollo="BD">
              <Retorno>SEO_dat_abo</Retorno>>
              <Descripción>Valida orden de servicio</Descripción>>
              <Parámetros>
                 <Entrada>
                            <param nom="eo_dat_abo Tipo="OBJETO ">Datos abonado</param>>
                    <param nom="en_num_ooss Tipo="NUMERICO">número orden de servicio</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
IS
        LN_num_os                 pv_camcom.num_os%TYPE;
    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;

        BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

        LV_sSql:='SELECT num_os FROM pv_camcom ';
        LV_sSql:=LV_sSql||' WHERE num_os = '||en_num_ooss||' AND num_celular ='||eo_dat_abo.num_celular;
        LV_sSql:=LV_sSql||' UNION ';
        LV_sSql:=LV_sSql||' SELECT num_os FROM pvh_camcom ';
        LV_sSql:=LV_sSql||' WHERE num_os = '||en_num_ooss||' AND num_celular = '||eo_dat_abo.num_celular;

        SELECT num_os
          INTO ln_num_os
          FROM pv_camcom
         WHERE num_os = en_num_ooss AND num_celular = eo_dat_abo.num_celular
        UNION
        SELECT num_os
          FROM pvh_camcom
         WHERE num_os = en_num_ooss AND num_celular = eo_dat_abo.num_celular;

        RETURN TRUE;

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 999;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_VALIDA_OOSS_FN'||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_VALIDA_OOSS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
END PV_VALIDA_OOSS_FN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION pv_dett_siniestro_fn (
      en_num_siniestro   IN              ga_detsinie.num_siniestro%TYPE,
      sv_det_siniestro   OUT             ga_detsinie.obs_detalle%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_DETT_SINIESTRO_FN"
              Lenguaje="PL/SQL"
              Fecha="20-11-2007"
              Versión="1.0"
              Diseñador="Marcelo Godoy"
              Programador="CAGV"
              Ambiente Desarrollo="BD">
              <Retorno>SEO_dat_abo</Retorno>>
              <Descripción>Retorna detalle siniestro/Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="en_num_siniestro" Tipo="NUMERICO">número siniestro</param>>
                 </Entrada>
                 <Salida>
                            <param nom="sv_det_siniestro" Tipo="CARACTER">Detalle siniestro</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
IS
    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;

        BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

        LV_sSql:='SELECT obs_detalle FROM ga_detsinie ';
        LV_sSql:=LV_sSql||' WHERE num_siniestro = '||en_num_siniestro;

        SELECT obs_detalle
          INTO sv_det_siniestro
          FROM ga_detsinie
         WHERE num_siniestro = en_num_siniestro;

        IF sv_det_siniestro = '' OR LTRIM(RTRIM(sv_det_siniestro)) IS NULL THEN
           sv_det_siniestro := 'SINIESTRO SIN OBSERVACIONES';
        END IF;

        RETURN TRUE;

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 999;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_DETT_SINIESTRO_FN'||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_DETT_SINIESTRO_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;

END PV_DETT_SINIESTRO_FN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION pv_val_tipo_siniestro_fn (
      eo_dat_abo         IN              pv_datos_abo_qt,
      en_tipo_terminal   IN              ga_siniestros.tip_terminal%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_VAL_TIPO_SINIESTRO_FN"
              Lenguaje="PL/SQL"
              Fecha="20-11-2007"
              Versión="1.0"
              Diseñador="Marcelo Godoy"
              Programador="CAGV"
              Ambiente Desarrollo="BD">
              <Retorno>SEO_dat_abo</Retorno>>
              <Descripción>Retorna val tipo siniestro</Descripción>>
              <Parámetros>
                 <Entrada>
                            <param nom="eo_dat_abo" Tipo="OBJETO ">Datos abonado</param>>
                    <param nom="en_tipo_terminal" Tipo="NUMERICO">Tipo terminal</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
IS

        LN_contador      NUMBER;
    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;

        BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

        LV_sSql:='SELECT COUNT (1) FROM ga_siniestros ';
        LV_sSql:=LV_sSql||' WHERE num_abonado = '||eo_dat_abo.num_abonado;
        LV_sSql:=LV_sSql||' AND tip_terminal = '''||en_tipo_terminal||'''';

        SELECT COUNT (1)
          INTO ln_contador
          FROM ga_siniestros
         WHERE num_abonado = eo_dat_abo.num_abonado
               AND tip_terminal = en_tipo_terminal;

        IF LN_contador > 0 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 999;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_VAL_TIPO_SINIESTRO_FN'||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_VAL_TIPO_SINIESTRO_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
END PV_VAL_TIPO_SINIESTRO_FN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_val_ooss_pendiente_fn (
      eo_dat_abo        IN              pv_datos_abo_qt,
      ev_cod_os         IN              pv_iorserv.cod_os%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_VAL_SINIESTRO_PENDIENTE_FN"
              Lenguaje="PL/SQL"
              Fecha="20-11-2007"
              Versión="1.0"
              Diseñador="Marcelo Godoy"
              Programador="CAGV"
              Ambiente Desarrollo="BD">
              <Retorno>SEO_dat_abo</Retorno>>
              <Descripción>Valida si el siniestro esta pendiente</Descripción>>
              <Parámetros>
                 <Entrada>
                            <param nom="eo_dat_abo" Tipo="OBJETO ">Datos abonado</param>>
                    <param nom="ev_cod_os" Tipo="CARACTER">código orden de servicio</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
IS

        LN_numordp        NUMBER;
        LN_contador           NUMBER;
    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;


        BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

    LV_sSql:='ge_fn_devvalparam('''||cv_cod_modulo_ga||''','''||cv_prod_celular||''',''EST_RESPCENTRAL'')';
        LN_numordp := ge_fn_devvalparam(cv_cod_modulo_ga, cv_prod_celular,'EST_RESPCENTRAL');

        LV_sSql:='SELECT COUNT (1) FROM pv_iorserv e, pv_erecorrido f, pv_camcom g';
        LV_sSql:=LV_sSql||' WHERE e.num_os = f.num_os  AND e.num_os = g.num_os';
        LV_sSql:=LV_sSql||' AND g.num_abonado = '||eo_dat_abo.num_abonado;
        LV_sSql:=LV_sSql||' AND e.cod_os = '''||ev_cod_os||''' AND e.num_os NOT IN ( ';
        LV_sSql:=LV_sSql||' SELECT a.num_os FROM pv_iorserv a, pv_erecorrido b, pv_camcom c, pv_arcos d';
        LV_sSql:=LV_sSql||' WHERE a.num_os = b.num_os AND a.cod_os = '''||ev_cod_os||'''';
        LV_sSql:=LV_sSql||' AND (a.fh_ejecucion IS NULL OR a.fh_ejecucion <= SYSDATE) ';
        LV_sSql:=LV_sSql||' AND a.num_os = c.num_os AND c.num_abonado = '||eo_dat_abo.num_abonado;
        LV_sSql:=LV_sSql||' AND a.cod_modgener = d.cod_modgener AND d.atrib_estado IN (2, 3) ';
        LV_sSql:=LV_sSql||' AND d.cod_aplic = ''PVA''';
        LV_sSql:=LV_sSql||' AND ((b.cod_estado = d.est_final) OR (b.cod_estado = '||LN_numordp||'))';
        LV_sSql:=LV_sSql||' AND b.tip_estado = 3 ';
        LV_sSql:=LV_sSql||' UNION ALL';
        LV_sSql:=LV_sSql||' SELECT a.num_os FROM pv_iorserv a, pv_erecorrido b, pv_camcom c, pv_arcos d';
        LV_sSql:=LV_sSql||' WHERE a.num_os = b.num_os AND a.cod_os = '''||ev_cod_os||'''';
        LV_sSql:=LV_sSql||' AND a.num_os = c.num_os AND (a.fh_ejecucion IS NULL OR a.fh_ejecucion <= SYSDATE)';
        LV_sSql:=LV_sSql||' AND c.num_abonado = '||eo_dat_abo.num_abonado;
        LV_sSql:=LV_sSql||' AND a.cod_modgener = d.cod_modgener AND d.atrib_estado IN (2, 3)';
        LV_sSql:=LV_sSql||' AND d.cod_aplic = ''PVA'' AND b.tip_estado = 4) ';

        SELECT COUNT (1)
          INTO ln_contador
          FROM pv_iorserv e, pv_erecorrido f, pv_camcom g
         WHERE e.num_os = f.num_os
           AND e.num_os = g.num_os
           AND g.num_abonado = eo_dat_abo.num_abonado
           AND e.cod_os = ev_cod_os
           AND e.num_os NOT IN (
                  SELECT a.num_os
                    FROM pv_iorserv a, pv_erecorrido b, pv_camcom c, pv_arcos d
                   WHERE a.num_os = b.num_os
                     AND a.cod_os = ev_cod_os
                     AND (a.fh_ejecucion IS NULL OR a.fh_ejecucion <= SYSDATE)
                     AND a.num_os = c.num_os
                     AND c.num_abonado = eo_dat_abo.num_abonado
                     AND a.cod_modgener = d.cod_modgener
                     AND d.atrib_estado IN (2, 3)
                     AND d.cod_aplic = 'PVA'
                     AND ((b.cod_estado = d.est_final) OR (b.cod_estado = ln_numordp)
                         )
                     AND b.tip_estado = 3
                  UNION ALL
                  SELECT a.num_os
                    FROM pv_iorserv a, pv_erecorrido b, pv_camcom c, pv_arcos d
                   WHERE a.num_os = b.num_os
                     AND a.cod_os = ev_cod_os
                     AND a.num_os = c.num_os
                     AND (a.fh_ejecucion IS NULL OR a.fh_ejecucion <= SYSDATE)
                     AND c.num_abonado = eo_dat_abo.num_abonado
                     AND a.cod_modgener = d.cod_modgener
                     AND d.atrib_estado IN (2, 3)
                     AND d.cod_aplic = 'PVA'
                     AND b.tip_estado = 4);

        IF LN_contador > 0 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 999;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_VAL_SINIESTRO_PENDIENTE_FN'||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_VAL_SINIESTRO_PENDIENTE_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
END pv_val_ooss_pendiente_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_estado_transaccion_pr (
      eo_dat_abo         IN              pv_datos_abo_qt,
      en_num_ooss        IN              pv_camcom.num_os%TYPE,
      ev_cod_servicio    IN              ga_siniestros.cod_servicio%TYPE,
      sv_des_estado      OUT             pv_erecorrido.descripcion%TYPE,
      sn_num_siniestro   OUT             ga_siniestros.num_siniestro%TYPE,
      sv_det_siniestro   OUT             ga_detsinie.obs_detalle%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_ESTADO_TRANSACCION_PR"
              Lenguaje="PL/SQL"
              Fecha="20-11-2007"
              Versión="1.0"
              Diseñador="Marcelo Godoy"
              Programador="CAGV"
              Ambiente Desarrollo="BD">
              <Retorno>SEO_dat_abo</Retorno>>
              <Descripción>Retorna estado transaccion</Descripción>>
              <Parámetros>
                 <Entrada>
                            <param nom="eo_dat_abo" Tipo="OBJETO ">Datos abonado</param>>
                            <param nom="en_num_ooss Tipo="NUMERICO">número orden de servicio</param>>
                    <param nom="ev_cod_servicio Tipo="CARACTER">Código servicio</param>>
                 </Entrada>
                 <Salida>
                            <param nom="sv_des_estado Tipo="CARACTER">descripcion estado</param>>
                                <param nom="sn_num_siniestro" Tipo="NUMERICO">número siniestro</param>>
                            <param nom="sv_det_siniestro" Tipo="CARACTER">detalle siniestro</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
IS

    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;

        error_proceso     exception;

        BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

        sv_des_estado:='';
        sn_num_siniestro:=0;
        sv_det_siniestro:='';

            IF PV_VALIDA_OOSS_FN(eo_dat_abo, en_num_ooss, sn_cod_retorno,sv_mens_retorno, sn_num_evento ) THEN
                   IF PV_RECUPERA_ESTADO_OOSS_FN(en_num_ooss, sv_des_estado, sn_cod_retorno, sv_mens_retorno, sn_num_evento) THEN
                          IF PV_RECUPERA_NUM_SINIES_FN(eo_dat_abo, ev_cod_servicio, sn_num_siniestro, sn_cod_retorno,sv_mens_retorno, sn_num_evento) THEN
                                 IF PV_DETT_SINIESTRO_FN(sn_num_siniestro, sv_det_siniestro, sn_cod_retorno,sv_mens_retorno, sn_num_evento) THEN
                                         RAISE error_proceso;
                                 END IF;
                          ELSE
                                 SN_num_siniestro := 0;
                                 SV_det_siniestro :='Robo/Extravio aún no Registrado';
                          END IF;
                   END IF;
        ELSE
                        RAISE error_proceso;
            END IF;

        EXCEPTION
        WHEN error_proceso THEN
              SN_cod_retorno := 999;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_ESTADO_TRANSACCION_PR'||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_ESTADO_TRANSACCION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
              SN_cod_retorno := 999;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_ESTADO_TRANSACCION_PR'||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_ESTADO_TRANSACCION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_ESTADO_TRANSACCION_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE pv_acepta_as_pr (
      eo_dat_abo        IN              pv_datos_abo_qt,
      ev_cod_actabo     IN              pv_camcom.cod_actabo%TYPE,
      ev_tipo_sinie     IN              ged_codigos.cod_valor%TYPE,
      en_tipo_susp      IN              ged_codigos.cod_valor%TYPE,
      en_causa_sinie    IN              ga_siniestros.cod_causa%TYPE,
      ev_usuario        IN              VARCHAR2,
      num_os            IN              NUMBER,
      ev_comentario     IN              pv_iorserv.comentario%TYPE,
      ev_desvio_numero  IN              PV_CAMCOM.PREF_PLAZA%TYPE,    
      sn_num_solequ     OUT             NUMBER,
      sn_num_solsim     OUT             NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_ACEPTA_AS_PR
              Lenguaje="PL/SQL"
              Fecha="20-11-2007"
              Versión="1.0"
              Diseñador="Marcelo Godoy"
              Programador="CAGV"
              Ambiente Desarrollo="BD">
              <Retorno>SEO_dat_abo</Retorno>>
              <Descripción>Acepta aviso siniestro</Descripción>>
              <Parámetros>
                 <Entrada>
                            <param nom="eo_dat_abo" Tipo="OBJETO ">Datos abonado</param>>
                            <param nom="ev_cod_actabo Tipo="CARACTER">código actuacion abonado</param>>
                    <param nom="ev_tipo_sinie Tipo="CARACTER">tipo siniestro</param>>
                    <param nom="en_tipo_susp Tipo="NUMERICO">tipo suspencion/param>>
                                <param nom="en_causa_sinie Tipo="NUMERICO">Causa siniestro</param>>
                                <param nom="ev_usuario Tipo="CARACTER">Usuario</param>>
                 </Entrada>
                 <Salida>
                            <param nom="sn_num_solEqu" Tipo="NUMERICO">Número solicitud equipo</param>>
                            <param nom="sn_num_solSim" Tipo="NUMERICO">Número solicitud simcard</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
IS

        LN_tip_terminal           GA_ABOCEL.TIP_TERMINAL%TYPE;
        LV_tip_susp_avsinie   PV_CAMCOM.TIP_SUSP_AVSINIE%TYPE;
        LN_ind_central_ss         PV_CAMCOM.IND_CENTRAL_SS%TYPE;
        LN_tip_term_sin           GA_ABOCEL.TIP_TERMINAL%TYPE;

        SV_descripcion            CI_TIPORSERV.DESCRIPCION%TYPE;
        SN_tip_procesa            CI_TIPORSERV.TIP_PROCESA%TYPE;
        SN_modgener                       CI_TIPORSERV.COD_MODGENER%TYPE;
        SV_des_estadoc            FA_INTESTADOC.DES_ESTADOC%TYPE;

        LN_secuencia1             NUMBER(10);
        LN_seq_enviada        NUMBER(10);
        LN_CantNumSerie           NUMBER(2);
        LN_veces                          NUMBER(1);
        LN_pos                            NUMBER(1) := 1;
        LN_secuencia2             NUMBER(10);
        LV_parametros             VARCHAR2(300);

        SV_proc                       VARCHAR2(50);
        SV_tabla                      VARCHAR2(50);
        SV_act                            VARCHAR2(2);
        SV_sqlcode                        VARCHAR2(50);
        SV_sqlerrm                        VARCHAR2(250);
        SV_error                          VARCHAR2(250);
        SV_glosa_retorno      VARCHAR2(250);
        SV_plan_NUEVO         ta_plantarif.cod_plantarif%TYPE;
        SV_NUM_OOSS           pv_camcom.num_os%TYPE;
        SV_cod_retorno        VARCHAR2(250);
        LV_ACTABO_AUX         GA_ACTABO.COD_ACTABO%TYPE;


        error_proceso             EXCEPTION;
        error_restricciones       EXCEPTION;
        error_terminal        EXCEPTION;
        error_num_os          EXCEPTION;
        error_ejecucion       EXCEPTION;

    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;

        o_dat_abo         pv_datos_abo_qt := NEW pv_datos_abo_qt;
        BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

        IF NOT (pv_val_sinistro_pendiente_fn (eo_dat_abo,ev_tipo_sinie,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
           RAISE error_restricciones;
        END IF;

        PV_ANULA_CAMPLAN_A_CICLO_PG.PV_ANULA_CAMPLAN_A_CICLO_PR(eo_dat_abo.cod_cliente, eo_dat_abo.num_abonado, eo_dat_abo.cod_plantarif, SV_cod_retorno, SV_glosa_retorno, SV_plan_NUEVO, SV_NUM_OOSS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

        IF (SV_cod_retorno=4) THEN
           RAISE error_proceso;
        END IF;

        pv_general_ooss_pg.pv_parametros_ooss_pr(CN_cod_ooss,SV_descripcion, SN_tip_procesa, SN_modgener, SV_des_estadoc, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm);

        SN_num_solEqu := 0;
        SN_num_solSim := 0;

    IF (num_os IS NULL) THEN
           RAISE error_proceso;
        END IF;

    LN_seq_enviada := num_os;


        IF EV_tipo_sinie = 'A' THEN
            LN_veces := 2;
        ELSE
           LN_veces := 1;
        END IF;

        WHILE LN_pos <= LN_veces LOOP

                  IF EV_tipo_sinie = 'A' THEN
                      IF LN_pos = 1 THEN
                                  LN_tip_term_sin := ge_fn_devvalparam('AL', cv_prod_celular, 'COD_SIMCARD_GSM');--'G';



                                  IF EN_tipo_susp = 1 THEN
                                          LV_tip_susp_avsinie := '1';
                                          LN_ind_central_ss := 1;
                                  END IF;

                                  IF EN_tipo_susp = 2 THEN
                                          LV_tip_susp_avsinie := '2';
                                          LN_ind_central_ss := 1;
                                  END IF;

                                  SN_num_solSim := LN_seq_enviada;
                      ELSE
                             LN_tip_term_sin := ge_fn_devvalparam('AL', cv_prod_celular,'COD_TERMINAL_GSM');--'T';
                             LV_tip_susp_avsinie := '0';
                             LN_ind_central_ss := 0;

                                 SELECT ci_seq_numos.NEXTVAL
                                   INTO ln_secuencia2
                                   FROM DUAL;

                               LN_seq_enviada := LN_secuencia2;
                               SN_num_solEqu  := LN_seq_enviada;
                      END IF;
                  ELSE
                  
                          /* INICIO 180150 Costa Rica RRG  */
                         /*
                         Si el siniestro es por equipo no debe suspender nunca  
                         IF EN_tipo_susp = 0 THEN
                                  LV_tip_susp_avsinie := '0';
                                  LN_ind_central_ss := 0;
                          END IF;

                          IF EN_tipo_susp = 1 THEN
                                  LV_tip_susp_avsinie := '1';
                                  LN_ind_central_ss := 1;
                          END IF;

                          IF EN_tipo_susp = 2 THEN
                                  LV_tip_susp_avsinie := '2';
                                  LN_ind_central_ss := 1;
                          END IF;
                          */
                          
                          LV_tip_susp_avsinie := '0';
                          LN_ind_central_ss := 0;
                          
                          /* FIN 180150 Costa Rica RRG  */

                          IF eo_dat_abo.cod_tecnologia = ge_fn_devvalparam(cv_cod_modulo_ga, cv_prod_celular,'TECNOLOGIA_GSM') THEN
                                IF EV_tipo_sinie = 'E' THEN
                                  LN_tip_term_sin := ge_fn_devvalparam('AL', cv_prod_celular,'COD_TERMINAL_GSM');
                                  SN_num_solEqu := LN_seq_enviada;
                                ELSE
                                  LN_tip_term_sin := ge_fn_devvalparam('AL', cv_prod_celular,'COD_SIMCARD_GSM');
                                  SN_num_solSim := LN_seq_enviada;
                                END IF;
                          ELSE
                                  o_dat_abo := eo_dat_abo;
                                  pv_cambio_serie_sb_pg.pv_rec_info_abonado_pr (o_dat_abo,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                  IF (SN_cod_retorno <> 0) THEN
                                         SN_cod_retorno := 125;
                                         SV_mens_retorno:= 'No es Posible Recuperar el Tipo de Terminal';
                                         RAISE error_terminal;
                                  END IF;
                                  LN_tip_term_sin := o_dat_abo.tip_terminal;
                                  SN_num_solEqu := LN_seq_enviada;
                          END IF;
                  END IF;


                 LV_ACTABO_AUX:=ev_cod_actabo;




                  IF EN_tipo_susp = 1 THEN --SUSPENSION BIDIRECCIONAL
                     LV_ACTABO_AUX:='ST';
                  END IF ;


                  IF EN_tipo_susp = 2 THEN --SUSPENSION UNIDIRECCIONAL
                     LV_ACTABO_AUX:='S7';
                  END IF;


                  pv_general_ooss_pg.pv_inscribe_ooss_pr(eo_dat_abo.num_celular, CN_cod_ooss, ev_usuario, LN_seq_enviada, SN_modgener, LV_ACTABO_AUX, eo_dat_abo.num_abonado, cv_prod_celular, LN_ind_central_ss, LN_tip_term_sin, LV_tip_susp_avsinie, EN_causa_sinie, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, ev_desvio_numero, 0,  SV_descripcion, SN_tip_procesa, SN_modgener, SV_des_estadoc, 3, 0, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm);

                  IF NOT (pv_reg_coment_pv_iorserv_fn (ev_comentario,LN_seq_enviada,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
                      RAISE error_ejecucion;
                  END IF;


                  IF SV_error = 4 THEN
                          SV_mens_retorno:= 'Transacción Erronea';
                          RAISE error_proceso;
                  END IF;
                  LN_pos := LN_pos +1;
    END LOOP;

   EXCEPTION
      WHEN error_proceso THEN
             SN_num_solEqu  := 0;
                 SN_num_solSim  := 0;
                 SN_cod_retorno := 1;
                 LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_ACEPTA_AS_PR'||'); - ' || SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_ACEPTA_AS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

          WHEN error_restricciones THEN
         SN_num_solEqu  := 0;
         SN_num_solSim  := 0;
         SN_cod_retorno := 2;
         LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_ACEPTA_AS_PR'||'); - ' || SQLERRM;
         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_ACEPTA_AS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN error_terminal THEN
         SN_num_solEqu  := 0;
         SN_num_solSim  := 0;
         LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_ACEPTA_AS_PR'||'); - ' || SQLERRM;
         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_ACEPTA_AS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN error_ejecucion THEN
         SN_num_solEqu  := 0;
         SN_num_solSim  := 0;
         LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_ACEPTA_AS_PR'||'); - ' || SQLERRM;
         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_ACEPTA_AS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

   END pv_acepta_as_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION pv_reg_coment_pv_iorserv_fn (
      ev_comentario       IN              pv_iorserv.comentario%TYPE,
          en_num_os                       IN              pv_iorserv.num_os%TYPE,
          sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
        /*
        <Documentación
          TipoDoc = "Función">>
           <Elemento
              Nombre = "pv_reg_coment_pv_iorserv_fn"
              Lenguaje="PL/SQL"
              Fecha="13-03-2008"
              Versión="1.0"
              Diseñador="Marcelo Godoy"
              Programador=""
              Ambiente Desarrollo="BD">
              <Retorno></Retorno>>
              <Descripción>Registra el comentario en la tabla PV_IORSERV para un aviso de siniestro WEB</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="ev_comentario Tipo="CARACTER">Comentario a registrar</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
IS

    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;
    LN_cod_estado     number;
    LN_tip_estado     number;

BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

        LV_sSql:= 'UPDATE pv_iorserv a'
                          || ' SET a.comentario = ' || ev_comentario
                          || ' WHERE a.num_os = ' || en_num_os;

        UPDATE pv_iorserv a
        SET a.comentario = ev_comentario
        WHERE a.num_os = en_num_os;

        --INI COL-70900|20-11-2008|AVC
        LV_sSql:= 'UPDATE pv_param_abocel'
                          || ' SET obs_detalle = ' || ev_comentario
                          || ' WHERE num_os = ' || en_num_os;

        UPDATE pv_param_abocel
        SET    obs_detalle = ev_comentario
        WHERE  num_os        = en_num_os;

        --FIN COL-70900|20-11-2008|AVC

    RETURN TRUE;

EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;

              LV_des_error   := 'PV_AVISO_SINIESTRO_WEB_PG.PV_RECUPERA_ESTADO_OOSS_FN'||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_RECUPERA_ESTADO_OOSS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );

              RETURN FALSE;

END pv_reg_coment_pv_iorserv_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END pv_aviso_siniestro_web_pg;
/
SHOW ERRORS