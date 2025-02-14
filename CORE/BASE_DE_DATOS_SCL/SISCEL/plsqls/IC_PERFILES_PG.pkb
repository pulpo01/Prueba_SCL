CREATE OR REPLACE PACKAGE BODY IC_PERFILES_PG AS

/*
<NOMBRE>       : IC_PERFILES_PG</NOMBRE>
<FECHACREA>    : <FECHACREA/>
<MODULO >      : IC</MODULO >
<AUTOR >       : Carlos Sellao H.</AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Parametros Interfaz con Centrales para Generacion de comandos y lógicas de perfiles en Altamira.</DESCRIPCION>
<FECHAMOD >    : </FECHAMOD>
<DESCMOD >     : </DESCMOD>
*/


PROCEDURE pv_registra_error_pr
         (
         EN_cod_error     IN OUT  ge_errores_pg.CodError,
         EV_cadena_error  IN      ge_errores_pg.vQuery,
         EV_procedimiento IN      VARCHAR2,
         SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
         SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
         SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
         )
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ga_registra_error_fn"
      Lenguaje="PL/SQL"
      Fecha="11-11-2009"
      Versión="1.0"
      Diseñador=""
      Programador=""
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Registra errores</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_error"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="EV_cadena_error"  Tipo="CARACTER">Query que tubo el problema</param>
            <param nom="EV_procedimiento" Tipo="CARACTER">Procedimiento Afectado</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

BEGIN
     SN_cod_retorno  := 0;
     SN_num_evento   := 0;
     SV_mens_retorno := '';

     IF NOT Ge_Errores_Pg.MENSAJEERROR(EN_cod_error,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
     END IF;
     GV_des_error   := EV_procedimiento || ' ' || SQLERRM;
     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_Modulo_GA, SV_mens_retorno, GV_version, USER, 'IC_PERFILES_PG', EV_cadena_error, SQLCODE, GV_des_error );
     SN_cod_retorno := EN_cod_error;

END pv_registra_error_pr;


PROCEDURE GA_INGRESA_PERFIL_PR(EN_tip_abonado  IN          GA_PERFIL_AA_TD.tip_abonado%TYPE,
                               EN_num_celular  IN          GA_PERFIL_AA_TD.num_celular%TYPE,
                               EV_num_imei     IN          GA_PERFIL_AA_TD.num_imei%TYPE,
                               EN_cod_distrib  IN          GA_PERFIL_AA_TD.cod_distribuidor%TYPE,
                               EN_id_terminal  IN          GA_PERFIL_AA_TD.id_terminal%TYPE,
                               EV_kit          IN          GA_PERFIL_AA_TD.kit%TYPE,
                               EV_cod_perfil   IN          GA_PERFIL_AA_TD.cod_perfil%TYPE,
                               EN_num_dias_vig IN          GA_PERFIL_AA_TD.num_dias_vig%TYPE,
                               ED_fec_desdevig IN          VARCHAR2,
                               ED_fec_hastavig IN          VARCHAR2,
                               EV_cod_plan     IN          GA_PERFIL_AA_TD.cod_plan%TYPE,
                               SN_COD_RETORNO  OUT NOCOPY  ge_errores_pg.CodError,
                               SV_MENS_RETORNO OUT NOCOPY  ge_errores_pg.MsgError,
                               SN_NUM_EVENTO   OUT NOCOPY  ge_errores_pg.evento )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_BUSCA_PERFIL_PR"
      Lenguaje="PL/SQL"
      Fecha="10-03-2010"
      Versión="1.0"
      Diseñador="Carlos Sellao"
      Programador="Carlos Sellao"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Genera un registro en la tabla de perfiles.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_tip_abonado"      Tipo="NUMERICO" >tipo de Abonado</param>
            <param nom="EN_num_celular"      Tipo="NUMERICO" >Numero de celular</param>
            <param nom="EV_num_imei"      Tipo="VARCHAR2">numero de imei</param>
            <param nom="EN_cod_distrib"      Tipo="NUMERICO" >Codigo de distribuidor o cliente</param>
            <param nom="EN_id_terminal"      Tipo="NUMERICO" >id de terminal</param>
            <param nom="EV_kit"      Tipo="VARCHAR2">indicador de kit</param>
            <param nom="EV_cod_perfil"      Tipo="VARCHAR2">codigo de perfil Altamira</param>
            <param nom="EN_num_dias_vig"      Tipo="NUMERICO" >Numero de dias de vigencia</param>
            <param nom="ED_fecdesde_vig"      Tipo="VARCHAR2" >fecha inicio de vigencia</param>
            <param nom="ED_fechasta_vig"      Tipo="VARCHAR2" >fecha de fin de vigencia</param>
            <param nom="EV_cod_plan"      Tipo="VARCHAR2">codigo de plan en SCL</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno  " Tipo="NUMERICO">Codigo de Retorno </param>
            <param nom="SV_mens_retorno " Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento   " Tipo="NUMERICO">Numero de Evento  </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
    LD_fec_desdevig GA_PERFIL_AA_TD.fec_desdevig%TYPE;
    LD_fec_hastavig GA_PERFIL_AA_TD.fec_hastavig%TYPE;
BEGIN
    sn_cod_retorno  := 0;
    sn_num_evento  := 0;

    LD_fec_desdevig := TO_DATE(ED_fec_desdevig,'yyyymmddHH24MISS');
    LD_fec_hastavig := TO_DATE(ED_fec_hastavig,'yyyymmddHH24MISS');

    LV_sSql := 'INSERT INTO GA_PERFIL_AA_TD (id_registro,tip_abonado,num_celular,num_imei,cod_distribuidor,id_terminal,kit, ';
    LV_sSql := LV_sSql || ' cod_perfil,num_dias_vig,fec_desdevig,fec_hastavig,fec_ultmod,nom_usuario,cod_plan) ';
    LV_sSql := LV_sSql || ' VALUES (GA_PERFILAA_SQ.nextval, EN_tip_abonado, EN_num_celular, EV_num_imei, EN_cod_distrib, EN_id_terminal, EV_kit, ';
    LV_sSql := LV_sSql || ' EV_cod_perfil, EN_num_dias_vig, ED_fec_desde, ED_fec_hasta, sysdate, USER, EV_cod_plan);';

    INSERT INTO GA_PERFIL_AA_TD (id_registro,tip_abonado,num_celular,num_imei,cod_distribuidor,id_terminal,kit,
                cod_perfil,num_dias_vig,fec_desdevig,fec_hastavig,fec_ultmod,nom_usuario,cod_plan)
    VALUES (GA_PERFILAA_SQ.nextval, EN_tip_abonado, EN_num_celular, EV_num_imei, EN_cod_distrib, EN_id_terminal, EV_kit,
                EV_cod_perfil, EN_num_dias_vig, LD_fec_desdevig, LD_fec_hastavig, sysdate, USER, EV_cod_plan);

    COMMIT;

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := CN_Err_Usuario;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_PERFIL_AA_PG.GA_INGRESA_PERFIL_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_Modulo_GA, sv_mens_retorno, GV_version, USER, 'GA_PERFIL_AA_PG.GA_INGRESA_PERFIL_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GA_INGRESA_PERFIL_PR;

----------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_BUSCA_PERFIL_PR
          (
          EN_num_abonado   IN  icc_movimiento.num_abonado%TYPE,
          EN_num_celular   IN  icc_movimiento.num_celular%TYPE,
          EV_icc           IN  icc_movimiento.icc%TYPE,
          SV_cod_perfil    OUT GA_PERFIL_AA_TD.cod_perfil%TYPE,
          SN_num_dias_vig  OUT GA_PERFIL_AA_TD.num_dias_vig%TYPE,
          SD_fec_desdevig  OUT GA_PERFIL_AA_TD.fec_desdevig%TYPE,
          SD_fec_hastavig  OUT GA_PERFIL_AA_TD.fec_hastavig%TYPE,
          SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
          SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
          SN_num_evento    OUT NOCOPY ge_errores_pg.evento
          )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_BUSCA_PERFIL_PR"
      Lenguaje="PL/SQL"
      Fecha="23-02-2010"
      Versión="1.0"
      Diseñador="Carlos Sellao"
      Programador="Carlos Sellao"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Determina el perfil a aplicar de acuerdo a criterios de tabla de perfiles.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_abonado"      Tipo="NUMERICO" >Numero de Abonado</param>
            <param nom="EN_num_celular"      Tipo="NUMERICO" >Numero de celular</param>
            <param nom="EV_icc"      Tipo="NUMERICO">numero de icc</param>
         </Entrada>
         <Salida>
            <param nom="SV_cod_perfil   " Tipo="CARACTER">Codigo de Perfil  </param>
            <param nom="SN_num_dias_vig   " Tipo="NUMERICO">Numero de Dias de Vigencia  </param>
            <param nom="SD_fec_desdevig   " Tipo="DATE">Fecha de inicio de Vigencia  </param>
            <param nom="SD_fec_hastavig   " Tipo="DATE">Fecha de fin de Vigencia  </param>
            <param nom="SN_cod_retorno  " Tipo="NUMERICO">Codigo de Retorno </param>
            <param nom="SV_mens_retorno " Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento   " Tipo="NUMERICO">Numero de Evento  </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

        LV_num_imei       ga_abocel.num_imei%type;
        LV_cod_plan       ga_abocel.cod_plantarif%type;
        LN_kit            al_tipos_articulos.tip_articulo%type;
        LN_cod_distrib    ga_abocel.cod_cliente%type;
        LN_terminal       al_articulos.cod_articulo%type;
        LV_kit            GA_PERFIL_AA_TD.kit%type;
        LV_cod_perfil     GA_PERFIL_AA_TD.cod_perfil%type;
        LN_num_dias_vig   GA_PERFIL_AA_TD.num_dias_vig%type;
        LD_fec_desdevig   GA_PERFIL_AA_TD.fec_desdevig%type;
        LD_fec_hastavig   GA_PERFIL_AA_TD.fec_hastavig%type;

        CV_nom_proced      VARCHAR2(25):='GA_BUSCA_PERFIL_PR';
        LN_cod_retorno     ge_errores_pg.CodError;
        LV_mens_retorno    ge_errores_pg.MsgError;
        LN_num_evento      ge_errores_pg.Evento;
        sSql               GE_Errores_PG.vQuery;
        error_proceso      EXCEPTION;
        dato_encontrado    EXCEPTION;

BEGIN
     LN_cod_retorno  := 0;
     LN_num_evento   := 0;
     LV_mens_retorno := '';

        LV_cod_perfil := NULL;

        -- Criterio 1.- por numero de telefono.-
        BEGIN
            sSql := 'SELECT cod_perfil';
            sSql := sSql||' INTO LV_cod_perfil';
            sSql := sSql||' FROM GA_PERFIL_AA_TD';
            sSql := sSql||' WHERE num_celular = '||EN_num_celular;

            SELECT cod_perfil, num_dias_vig, fec_desdevig, fec_hastavig
            INTO LV_cod_perfil, LN_num_dias_vig, LD_fec_desdevig, LD_fec_hastavig
            FROM GA_PERFIL_AA_TD
            WHERE num_celular = EN_num_celular;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
               LV_cod_perfil := NULL;
            WHEN OTHERS THEN
               RAISE error_proceso;
        END;

        IF LV_cod_perfil IS NOT NULL THEN
            SV_cod_perfil   := LV_cod_perfil;
            SN_num_dias_vig := LN_num_dias_vig;
            SD_fec_desdevig := LD_fec_desdevig;
            SD_fec_hastavig := LD_fec_hastavig;
            RAISE dato_encontrado;
        END IF;


        -- Rescata datos de cliente(distribuidor), plan e imei.-
        BEGIN
           sSql := 'SELECT cod_cliente, cod_plantarif, NVL(num_imei,CHR(0))';
           sSql := sSql||' INTO LN_cod_cliente, LV_cod_plan, LV_num_imei';
           sSql := sSql||' FROM ga_abocel';
           sSql := sSql||' WHERE abo.num_abonado = '||TO_CHAR(EN_num_abonado);

           SELECT  cod_cliente, cod_plantarif, NVL(num_imei,CHR(0))
           INTO  LN_cod_distrib, LV_cod_plan, LV_num_imei
           FROM  ga_abocel
           WHERE  num_abonado = EN_num_abonado;

           EXCEPTION
               WHEN NO_DATA_FOUND THEN
                  BEGIN
                      sSql := 'SELECT cod_cliente, cod_plantarif, NVL(num_imei,CHR(0))';
                      sSql := sSql||' INTO LN_cod_cliente, LV_cod_plan, LV_num_imei';
                      sSql := sSql||' FROM ga_aboamist';
                      sSql := sSql||' WHERE num_abonado = '||EN_num_abonado;

                      SELECT cod_cliente, cod_plantarif, NVL(num_imei,CHR(0))
                      INTO LN_cod_distrib, LV_cod_plan, LV_num_imei
                      FROM ga_aboamist
                      WHERE num_abonado = EN_num_abonado;
                  EXCEPTION
                     WHEN OTHERS THEN
                         raise error_proceso;
               END;
        END;


        -- Criterio 2.- por plan.-
        BEGIN
            sSql := 'SELECT cod_perfil';
            sSql := sSql||' INTO LV_cod_perfil';
            sSql := sSql||' FROM GA_PERFIL_AA_TD';
            sSql := sSql||' WHERE cod_plan = '||LV_cod_plan;

            SELECT cod_perfil, num_dias_vig, fec_desdevig, fec_hastavig
            INTO LV_cod_perfil, LN_num_dias_vig, LD_fec_desdevig, LD_fec_hastavig
            FROM GA_PERFIL_AA_TD
            WHERE cod_plan = LV_cod_plan;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
               LV_cod_perfil := NULL;
            WHEN OTHERS THEN
               RAISE error_proceso;
        END;

        IF LV_cod_perfil IS NOT NULL THEN
            SV_cod_perfil   := LV_cod_perfil;
            SN_num_dias_vig := LN_num_dias_vig;
            SD_fec_desdevig := LD_fec_desdevig;
            SD_fec_hastavig := LD_fec_hastavig;
            RAISE dato_encontrado;
        END IF;


        -- Criterio 3.- por numero de imei.-
        BEGIN
            sSql := 'SELECT cod_perfil';
            sSql := sSql||' INTO LV_cod_perfil';
            sSql := sSql||' FROM GA_PERFIL_AA_TD';
            sSql := sSql||' WHERE imei = '||LV_num_imei;

            SELECT cod_perfil, num_dias_vig, fec_desdevig, fec_hastavig
            INTO LV_cod_perfil, LN_num_dias_vig, LD_fec_desdevig, LD_fec_hastavig
            FROM GA_PERFIL_AA_TD
            WHERE num_imei = LV_num_imei;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
               LV_cod_perfil := NULL;
            WHEN OTHERS THEN
               RAISE error_proceso;
        END;

        IF LV_cod_perfil IS NOT NULL THEN
            SV_cod_perfil   := LV_cod_perfil;
            SN_num_dias_vig := LN_num_dias_vig;
            SD_fec_desdevig := LD_fec_desdevig;
            SD_fec_hastavig := LD_fec_hastavig;
            RAISE dato_encontrado;
        END IF;


        -- Identifica el tipo de articulo KIT.-
        sSql := 'SELECT to_number(val_parametro)';
        sSql := sSql||' INTO LN_kit';
        sSql := sSql||' FROM ged_parametros';
        sSql := sSql||' WHERE nom_parametro = '||CV_tipo_KIT;
        sSql := sSql||' AND cod_modulo = '||CV_Modulo_AL;
        sSql := sSql||' AND cod_producto = '||CN_Producto;

        SELECT to_number(val_parametro)
        INTO LN_kit
        FROM ged_parametros
        WHERE nom_parametro = CV_tipo_KIT
        AND cod_modulo = CV_Modulo_AL
        AND cod_producto = CN_Producto;


        -- Se rescata data de terminal y kit.
        sSql := 'SELECT a.cod_articulo, DECODE(c.tip_articulo,LN_kit,CV_SIKIT,CV_NOKIT)';
        sSql := sSql||' INTO LN_terminal, LV_kit';
        sSql := sSql||' FROM GA_EQUIPABOSER A, AL_ARTICULOS C';
        sSql := sSql||' WHERE NUM_ABONADO = '||EN_num_abonado;
        sSql := sSql||' AND NUM_SERIE = '||EV_icc;
        sSql := sSql||' AND FEC_ALTA =(SELECT MAX(fec_alta)';
        sSql := sSql||'   FROM ga_equipaboser B';
        sSql := sSql||'   WHERE A.num_abonado=B.num_abonado';
        sSql := sSql||'   AND A.num_serie=B.num_serie)';
        sSql := sSql||' AND A.COD_ARTICULO=C.COD_ARTICULO;';

        SELECT a.cod_articulo, DECODE(c.tip_articulo,LN_kit,CV_SIKIT,CV_NOKIT)
        INTO  LN_terminal, LV_kit
        FROM GA_EQUIPABOSER A, AL_ARTICULOS C
        WHERE NUM_ABONADO = EN_num_abonado
        AND NUM_SERIE     = EV_icc
        AND FEC_ALTA =(SELECT MAX(FEC_ALTA)
                       FROM GA_EQUIPABOSER B
                       WHERE A.NUM_ABONADO=B.NUM_ABONADO
                       AND A.NUM_SERIE=B.NUM_SERIE)
        AND A.COD_ARTICULO=C.COD_ARTICULO;


        -- Criterio 4.- por distribuidor, terminal y kit.-
        BEGIN
            SELECT cod_perfil, num_dias_vig, fec_desdevig, fec_hastavig
            INTO LV_cod_perfil, LN_num_dias_vig, LD_fec_desdevig, LD_fec_hastavig
            FROM GA_PERFIL_AA_TD
            WHERE cod_distribuidor = LN_cod_distrib
            AND   id_terminal = LN_terminal
            AND   kit =      LV_kit;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
               LV_cod_perfil := NULL;
            WHEN OTHERS THEN
               RAISE error_proceso;
        END;

        IF LV_cod_perfil IS NOT NULL THEN
            SV_cod_perfil   := LV_cod_perfil;
            SN_num_dias_vig := LN_num_dias_vig;
            SD_fec_desdevig := LD_fec_desdevig;
            SD_fec_hastavig := LD_fec_hastavig;
            RAISE dato_encontrado;
        END IF;


        -- Criterio 5.- por distribuidor y terminal.-
        BEGIN
            sSql := 'SELECT cod_perfil';
            sSql := sSql||' INTO LV_cod_perfil';
            sSql := sSql||' FROM GA_PERFIL_AA_TD';
            sSql := sSql||' WHERE cod_distribuidor = '||LN_cod_distrib;
            sSql := sSql||' AND id_terminal = '||LN_terminal;

            SELECT cod_perfil, num_dias_vig, fec_desdevig, fec_hastavig
            INTO LV_cod_perfil, LN_num_dias_vig, LD_fec_desdevig, LD_fec_hastavig
            FROM GA_PERFIL_AA_TD
            WHERE cod_distribuidor = LN_cod_distrib
            AND   id_terminal = LN_terminal;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
               LV_cod_perfil := NULL;
            WHEN OTHERS THEN
               RAISE error_proceso;
        END;

        IF LV_cod_perfil IS NOT NULL THEN
            SV_cod_perfil   := LV_cod_perfil;
            SN_num_dias_vig := LN_num_dias_vig;
            SD_fec_desdevig := LD_fec_desdevig;
            SD_fec_hastavig := LD_fec_hastavig;
            RAISE dato_encontrado;
        END IF;


        -- Criterio 6.- por distribuidor y kit.-
        BEGIN
            sSql := 'SELECT cod_perfil';
            sSql := sSql||' INTO LV_cod_perfil';
            sSql := sSql||' FROM GA_PERFIL_AA_TD';
            sSql := sSql||' WHERE cod_distribuidor = '||LN_cod_distrib;
            sSql := sSql||' AND kit = '||LV_kit;

            SELECT cod_perfil, num_dias_vig, fec_desdevig, fec_hastavig
            INTO LV_cod_perfil, LN_num_dias_vig, LD_fec_desdevig, LD_fec_hastavig
            FROM GA_PERFIL_AA_TD
            WHERE cod_distribuidor = LN_cod_distrib
            AND   kit =      LV_kit;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
               LV_cod_perfil := NULL;
            WHEN OTHERS THEN
               RAISE error_proceso;
        END;

        IF LV_cod_perfil IS NOT NULL THEN
            SV_cod_perfil   := LV_cod_perfil;
            SN_num_dias_vig := LN_num_dias_vig;
            SD_fec_desdevig := LD_fec_desdevig;
            SD_fec_hastavig := LD_fec_hastavig;
            RAISE dato_encontrado;
        END IF;


        -- Criterio 7.- por terminal y kit.-
        BEGIN
            sSql := 'SELECT cod_perfil';
            sSql := sSql||' INTO LV_cod_perfil';
            sSql := sSql||' FROM GA_PERFIL_AA_TD';
            sSql := sSql||' WHERE id_terminal = '||LN_terminal;
            sSql := sSql||' AND kit = '||LV_kit;

            SELECT cod_perfil, num_dias_vig, fec_desdevig, fec_hastavig
            INTO LV_cod_perfil, LN_num_dias_vig, LD_fec_desdevig, LD_fec_hastavig
            FROM GA_PERFIL_AA_TD
            WHERE id_terminal = LN_terminal
            AND   kit =      LV_kit;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
               LV_cod_perfil := NULL;
            WHEN OTHERS THEN
               RAISE error_proceso;
        END;

        IF LV_cod_perfil IS NOT NULL THEN
            SV_cod_perfil   := LV_cod_perfil;
            SN_num_dias_vig := LN_num_dias_vig;
            SD_fec_desdevig := LD_fec_desdevig;
            SD_fec_hastavig := LD_fec_hastavig;
            RAISE dato_encontrado;
        END IF;


        -- Criterio 8.- por distribuidor.-
        BEGIN
            sSql := 'SELECT cod_perfil';
            sSql := sSql||' INTO LV_cod_perfil';
            sSql := sSql||' FROM GA_PERFIL_AA_TD';
            sSql := sSql||' WHERE cod_distribuidor = '||LN_cod_distrib;

            SELECT cod_perfil, num_dias_vig, fec_desdevig, fec_hastavig
            INTO LV_cod_perfil, LN_num_dias_vig, LD_fec_desdevig, LD_fec_hastavig
            FROM GA_PERFIL_AA_TD
            WHERE cod_distribuidor = LN_cod_distrib;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
               LV_cod_perfil := NULL;
            WHEN OTHERS THEN
               RAISE error_proceso;
        END;

        IF LV_cod_perfil IS NOT NULL THEN
            SV_cod_perfil   := LV_cod_perfil;
            SN_num_dias_vig := LN_num_dias_vig;
            SD_fec_desdevig := LD_fec_desdevig;
            SD_fec_hastavig := LD_fec_hastavig;
            RAISE dato_encontrado;
        END IF;


        -- Criterio 9.- por terminal.-
        BEGIN
            sSql := 'SELECT cod_perfil';
            sSql := sSql||' INTO LV_cod_perfil';
            sSql := sSql||' FROM GA_PERFIL_AA_TD';
            sSql := sSql||' WHERE id_terminal = '||LN_terminal;

            SELECT cod_perfil, num_dias_vig, fec_desdevig, fec_hastavig
            INTO LV_cod_perfil, LN_num_dias_vig, LD_fec_desdevig, LD_fec_hastavig
            FROM GA_PERFIL_AA_TD
            WHERE id_terminal = LN_terminal;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
               LV_cod_perfil := NULL;
            WHEN OTHERS THEN
               RAISE error_proceso;
        END;

        IF LV_cod_perfil IS NOT NULL THEN
            SV_cod_perfil   := LV_cod_perfil;
            SN_num_dias_vig := LN_num_dias_vig;
            SD_fec_desdevig := LD_fec_desdevig;
            SD_fec_hastavig := LD_fec_hastavig;
            RAISE dato_encontrado;
        END IF;


        -- Criterio 10.- por kit.-
        BEGIN
            sSql := 'SELECT cod_perfil';
            sSql := sSql||' INTO LV_cod_perfil';
            sSql := sSql||' FROM GA_PERFIL_AA_TD';
            sSql := sSql||' WHERE kit = '||LV_kit;

            SELECT cod_perfil, num_dias_vig, fec_desdevig, fec_hastavig
            INTO LV_cod_perfil, LN_num_dias_vig, LD_fec_desdevig, LD_fec_hastavig
            FROM GA_PERFIL_AA_TD
            WHERE kit =      LV_kit;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
               LV_cod_perfil := NULL;
            WHEN OTHERS THEN
               RAISE error_proceso;
        END;

        IF LV_cod_perfil IS NOT NULL THEN
            SV_cod_perfil   := LV_cod_perfil;
            SN_num_dias_vig := LN_num_dias_vig;
            SD_fec_desdevig := LD_fec_desdevig;
            SD_fec_hastavig := LD_fec_hastavig;
            RAISE dato_encontrado;
        END IF;

        -- Criterio 11.- Entrega perfil por defecto.-
        SV_cod_perfil   := 'PER_GENERICO';
        SN_num_dias_vig := LN_num_dias_vig;
        SD_fec_desdevig := LD_fec_desdevig;
        SD_fec_hastavig := LD_fec_hastavig;


EXCEPTION
     WHEN dato_encontrado THEN
           NULL;
     WHEN error_proceso THEN
           pv_registra_error_pr (CN_err_ejecutar_servicio, sSql, CV_nom_proced, LN_cod_retorno, LV_mens_retorno, LN_num_evento);
     WHEN OTHERS THEN
           pv_registra_error_pr (CN_err_ejecutar_servicio, sSql, CV_nom_proced, LN_cod_retorno, LV_mens_retorno, LN_num_evento);

END GA_BUSCA_PERFIL_PR;




----------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_INICIA_PERFIL_PR
          (
          EN_num_movimiento IN  icc_movimiento.num_movimiento%TYPE
          )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_INICIA_PERFIL_PR"
      Lenguaje="PL/SQL"
      Fecha="23-02-2010"
      Versión="1.0"
      Diseñador="Carlos Sellao"
      Programador="Carlos Sellao"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Genera un registro de asociacion de perfil aprovisionado con el numero de celular.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_movimiento"      Tipo="NUMERICO" >Numero de Movimiento</param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

CN_nom_proced      VARCHAR2(25):='ga_inicia_perfil_pr';
LN_Found           number(2);
LN_num_abonado     icc_movimiento.num_abonado%TYPE;
LN_num_celular     icc_movimiento.num_celular%type;
LV_icc             icc_movimiento.icc%type;
LV_cod_perfil      GA_PERFIL_AA_TD.cod_perfil%type;
LN_num_dias_vig    GA_PERFIL_AA_TD.num_dias_vig%type;
LD_fec_desdevig    GA_PERFIL_AA_TD.fec_desdevig%type;
LD_fec_hastavig    GA_PERFIL_AA_TD.fec_hastavig%type;
LD_fec_inicio      date;
LN_cod_retorno     ge_errores_pg.CodError;
LV_mens_retorno    ge_errores_pg.MsgError;
LN_num_evento      ge_errores_pg.Evento;
error_inicia       EXCEPTION;

BEGIN
     LN_cod_retorno  := 0;
     LN_num_evento   := 0;
     LV_mens_retorno := '';


        -- Lee el datos basicos desde el movimiento.-
        GV_sSql := 'SELECT num_abonado, num_celular, icc';
        GV_sSql := GV_sSql||' INTO LN_num_abonado, LN_num_celular, LV_icc';
        GV_sSql := GV_sSql||' FROM icc_movimiento';
        GV_sSql := GV_sSql||' WHERE num_movimiento = '||EN_num_movimiento;

        SELECT num_abonado, num_celular, icc
        INTO LN_num_abonado, LN_num_celular, LV_icc
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_movimiento;

        LV_cod_perfil := NULL;
        LN_num_dias_vig := 0;

        GA_BUSCA_PERFIL_PR(LN_num_abonado,LN_num_celular,LV_icc,LV_cod_perfil,LN_num_dias_vig,LD_fec_desdevig,
                           LD_fec_hastavig,LN_cod_retorno,LV_mens_retorno,LN_num_evento);

        IF LN_cod_retorno <> 0 OR LV_cod_perfil IS NULL THEN
           raise error_inicia;
        END IF;

        SELECT count(*)
        INTO LN_Found
        FROM GA_PERFIL_CELULAR_TO
        WHERE num_celular = LN_num_celular;

        LD_fec_inicio := sysdate;
        LN_num_dias_vig := trunc(LD_fec_hastavig) - trunc(LD_fec_inicio);


        IF LN_Found = 0 THEN
           GV_sSql := 'INSERT INTO GA_PERFIL_CELULAR_TO (num_celular,num_abonado,cod_perfil,num_dias_vig,fec_desdevig,fec_hastavig)';
           GV_sSql := GV_sSql||' VALUES ('||LN_num_celular||','||LN_num_abonado||','||LV_cod_perfil||','||LN_num_dias_vig||','||LD_fec_inicio||','||LD_fec_hastavig||');';

           INSERT INTO GA_PERFIL_CELULAR_TO (
               num_celular,
               num_abonado,
               cod_perfil,
               num_dias_vig,
               fec_desdevig,
               fec_hastavig)
           VALUES (
               LN_num_celular,
               LN_num_abonado,
               LV_cod_perfil,
               LN_num_dias_vig, -- dias reales para el celular.-
               LD_fec_inicio,   -- un sysdate, ya que es solo para el celular.-
               LD_fec_hastavig);
        ELSE
           GV_sSql := 'UPDATE GA_PERFIL_CELULAR_TO';
           GV_sSql := GV_sSql||' SET cod_perfil ='||LV_cod_perfil;
           GV_sSql := GV_sSql||' ,num_dias_vig ='||LN_num_dias_vig;
           GV_sSql := GV_sSql||' ,fec_desdevig ='||LD_fec_inicio;
           GV_sSql := GV_sSql||' ,fec_hastavig ='||LD_fec_hastavig;
           GV_sSql := GV_sSql||' WHERE num_celular = '||TO_CHAR(LN_num_celular);

           UPDATE GA_PERFIL_CELULAR_TO
           SET cod_perfil=LV_cod_perfil
              ,num_dias_vig=LN_num_dias_vig
              ,fec_desdevig=LD_fec_inicio
              ,fec_hastavig=LD_fec_hastavig
           WHERE num_celular = LN_num_celular;
        END IF;

        --COMMIT;

EXCEPTION
     WHEN error_inicia THEN
           pv_registra_error_pr (CN_err_ejecutar_servicio, GV_sSql, CN_nom_proced, LN_cod_retorno, LV_mens_retorno, LN_num_evento);
     WHEN OTHERS THEN
           pv_registra_error_pr (CN_err_ejecutar_servicio, GV_sSql, CN_nom_proced, LN_cod_retorno, LV_mens_retorno, LN_num_evento);

END GA_INICIA_PERFIL_PR;


FUNCTION IC_PERFIL_AA_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_PERFIL_AA_FN"
                Lenguaje="PL/SQL"
                Fecha creación="02-2010"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el perfil especial que se informara a Altamira.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado    icc_movimiento.num_abonado%TYPE;
        LN_num_celular    icc_movimiento.num_celular%type;
        LV_icc            icc_movimiento.icc%type;
        LV_cod_perfil     GA_PERFIL_AA_TD.cod_perfil%type;
        LN_num_dias_vig   GA_PERFIL_AA_TD.num_dias_vig%type;
        LD_fec_desdevig   GA_PERFIL_AA_TD.fec_desdevig%type;
        LD_fec_hastavig   GA_PERFIL_AA_TD.fec_hastavig%type;
        LN_cod_retorno    GE_Errores_PG.coderror;
        LV_mens_retorno   GE_Errores_PG.msgerror;
        LN_num_evento     GE_Errores_PG.evento;
        LV_des_error      VARCHAR2(512);
        sSql              GE_Errores_PG.vQuery;
        error_proceso     EXCEPTION;
BEGIN

        -- Lee el datos basicos desde el movimiento.-
        sSql := 'SELECT num_abonado, num_celular, icc';
        sSql := sSql||' INTO LN_num_abonado, LN_num_celular, LV_icc';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;

        SELECT num_abonado, num_celular, icc
        INTO LN_num_abonado, LN_num_celular, LV_icc
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_mov;

        LV_cod_perfil := NULL;


        GA_BUSCA_PERFIL_PR(LN_num_abonado,LN_num_celular,LV_icc,LV_cod_perfil,LN_num_dias_vig,LD_fec_desdevig,
                           LD_fec_hastavig,LN_cod_retorno,LV_mens_retorno,LN_num_evento);

        IF LN_cod_retorno <> 0 OR LV_cod_perfil IS NULL THEN
           raise error_proceso;
        END IF;

        RETURN LV_cod_perfil;

EXCEPTION
        WHEN error_proceso THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PERFILES_PG.IC_PERFIL_AA_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PERFILES_PG.IC_PERFIL_AA_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER PERFIL PARA PLATAFORMA-' || SQLERRM;

        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PERFILES_PG.IC_PERFIL_AA_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PERFILES_PG.IC_PERFIL_AA_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER PERFIL PARA PLATAFORMA-' || SQLERRM;
END;


FUNCTION IC_PERFIL_AA_BAJA_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_PERFIL_AA_BAJA_FN"
                Lenguaje="PL/SQL"
                Fecha creación="02-2010"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el perfil especial que se dará de baja en Altamira.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado    icc_movimiento.num_abonado%TYPE;
        LN_num_celular    icc_movimiento.num_celular%type;
        LV_icc            icc_movimiento.icc%type;
        LV_cod_perfil     GA_PERFIL_AA_TD.cod_perfil%type;
        LN_num_dias_vig   GA_PERFIL_AA_TD.num_dias_vig%type;
        LD_fec_desdevig   GA_PERFIL_AA_TD.fec_desdevig%type;
        LD_fec_hastavig   GA_PERFIL_AA_TD.fec_hastavig%type;
        LN_cod_retorno    GE_Errores_PG.coderror;
        LV_mens_retorno   GE_Errores_PG.msgerror;
        LN_num_evento     GE_Errores_PG.evento;
        LV_des_error      VARCHAR2(512);
        sSql              GE_Errores_PG.vQuery;
        error_proceso     EXCEPTION;
BEGIN

        -- Lee el datos basicos desde el movimiento.-
        sSql := 'SELECT num_abonado, num_celular';
        sSql := sSql||' INTO LN_num_abonado, LN_num_celular';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;

        SELECT num_abonado, num_celular
        INTO LN_num_abonado, LN_num_celular
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_mov;

        LV_cod_perfil := NULL;

        -- Busca el perfil que se aprovisionó al celular y que se dará de baja.-
        sSql := 'SELECT cod_perfil';
        sSql := sSql||' INTO LV_cod_perfil';
        sSql := sSql||' FROM GA_PERFIL_CELULAR_TO';
        sSql := sSql||' WHERE num_celular = '||LN_num_celular;

        SELECT NVL(cod_perfil,CHR(0))
        INTO LV_cod_perfil
        FROM GA_PERFIL_CELULAR_TO
        WHERE num_celular = LN_num_celular;

        IF LV_cod_perfil = CHR(0) THEN
            raise error_proceso;
        END IF;

        RETURN LV_cod_perfil;

EXCEPTION
        WHEN error_proceso THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PERFILES_PG.IC_PERFIL_AA_BAJA_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PERFILES_PG.IC_PERFIL_AA_BAJA_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER PERFIL PARA PLATAFORMA-' || SQLERRM;

        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PERFILES_PG.IC_PERFIL_AA_BAJA_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PERFILES_PG.IC_PERFIL_AA_BAJA_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER PERFIL PARA PLATAFORMA-' || SQLERRM;
END;


FUNCTION ic_busca_parametros_fn (
        ev_nom_parametro    IN               ged_parametros.nom_parametro%TYPE,
        ev_cod_modulo       IN               ged_parametros.cod_modulo%TYPE,
        en_cod_producto     IN               ged_parametros.cod_producto%TYPE,
        sv_val_parametro    OUT NOCOPY       ged_parametros.val_parametro%TYPE,
        sn_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento       OUT NOCOPY       ge_errores_pg.evento
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ic_busca_parametros_fn""
      Lenguaje="PL/SQL"
      Fecha="06-2009"
      Versión="1.0"
      Diseñador=""
      Programador=""
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción></Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_nom_parametro" Tipo="CARACTER">Nombre de parametro </param>
			<param nom="EV_cod_modulo   " Tipo="CARACTER">Codigo de Modulo    </param>
			<param nom="EN_cod_producto " Tipo="NUMERICO">Cod.Producto Celular</param>
         </Entrada>
         <Salida>
            <param nom="SV_val_parametro" Tipo="CARACTER">Valor parametro   </param>
            <param nom="SN_cod_retorno  " Tipo="NUMERICO">Codigo de Retorno </param>
            <param nom="SV_mens_retorno " Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento   " Tipo="NUMERICO">Numero de Evento  </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    exception_ErrParam EXCEPTION;
	V_des_error  	   ge_errores_pg.DesEvent;
	LV_sql         	   ge_errores_pg.vQuery;
	LV_nomparametro    ged_parametros.nom_parametro%TYPE;
BEGIN
    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= NULL;

    LV_sql := 'SELECT val_parametro';
    LV_sql := LV_sql || ' INTO EV_val_parametro';
    LV_sql := LV_sql || ' FROM ged_parametros';
    LV_sql := LV_sql || ' WHERE nom_parametro = '|| EV_nom_parametro;
    LV_sql := LV_sql || ' AND cod_modulo = '|| EV_cod_modulo;
    LV_sql := LV_sql || ' AND cod_producto = '|| EN_cod_producto;

    SELECT val_parametro
      INTO SV_val_parametro
      FROM ged_parametros
     WHERE nom_parametro = EV_nom_parametro
       AND cod_modulo = EV_cod_modulo
       AND cod_producto = EN_cod_producto;

    RETURN TRUE;

EXCEPTION
WHEN OTHERS THEN
		SN_cod_retorno := 156;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		    SV_mens_retorno := CV_Err_NoClasif;
		END IF;
		V_des_error := 'IC_PROCPROVISION_PG.ic_busca_parametros_fn('|| EV_nom_parametro||', '||EV_cod_modulo||', '||EN_cod_producto||'); - ' || SQLERRM;
		SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'IC', SV_mens_retorno, '1.0', USER, 'IC_PROCPROVISION_PG.ic_busca_parametros_fn', LV_sql, SQLCODE, V_des_error );
		RETURN FALSE;
END ic_busca_parametros_fn;


PROCEDURE IC_SOLBAJAPERFIL_PR
          (
          EN_num_abonado   IN  icc_movimiento.num_abonado%TYPE,
          EN_num_celular   IN  icc_movimiento.num_celular%TYPE,
          EV_cod_actabo    IN  icc_movimiento.cod_actabo%TYPE,
          EN_cod_actuacion IN  icc_movimiento.cod_actuacion%TYPE,
          SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
          SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
          SN_num_evento    OUT NOCOPY ge_errores_pg.evento
          ) IS
/*
<Documentación
        TipoDoc = "Procedure">
        <Elemento
                Nombre = "ic_solbajaperfil_pr"
                Lenguaje="PL/SQL"
                Fecha creación="03-2010"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Procedure para generar un movimiento de baja de perfil.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_abonado" Tipo="NUMERICO">numero de abonado</param>
                                <param nom="EN_num_celular" Tipo="NUMERICO">Numero del celular</param>
                                <param nom="EV_cod_actabo" Tipo="VARCHAR2">codigo del Actabo</param>
                                <param nom="EN_cod_actuacion" Tipo="NUMERICO">codigo de Actuacion</param>
                        </Entrada>
                        <Salida>
                                <param nom="SN_cod_retorno  " Tipo="NUMERICO">Codigo de Retorno </param>
                                <param nom="SV_mens_retorno " Tipo="CARACTER">Mensaje de Retorno</param>
                                <param nom="SN_num_evento   " Tipo="NUMERICO">Numero de Evento  </param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/

CN_nom_proced      VARCHAR2(25):='IC_SOLBAJAPERFIL_PR';
LB_retorno         BOOLEAN;
LN_cod_retorno     ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno    ge_errores_td.det_msgerror%TYPE;
LN_num_evento      ge_errores_pg.evento;
error_datos        EXCEPTION;
error_insert       EXCEPTION;
LN_NUM_MOVIMIENTO  icc_movimiento.num_movimiento%TYPE;
LN_COD_ESTADO      icc_movimiento.cod_estado%TYPE;
LV_COD_MODULO      icc_movimiento.cod_modulo%TYPE;
LN_NUM_INTENTOS    icc_movimiento.num_intentos%TYPE;
LV_DES_RESPUESTA   icc_movimiento.des_respuesta%TYPE;
LV_NOM_USUARORA    icc_movimiento.nom_usuarora%TYPE;
LD_FEC_INGRESO     icc_movimiento.fec_ingreso%TYPE;
LV_TIP_TERMINAL    icc_movimiento.tip_terminal%TYPE;
LN_COD_CENTRAL     icc_movimiento.cod_central%TYPE;
LN_IND_BLOQUEO     icc_movimiento.ind_bloqueo%TYPE;
LV_NUM_SERIE       icc_movimiento.num_serie%TYPE;
LV_TIP_TECNOLOGIA  icc_movimiento.tip_tecnologia%TYPE;
sSql               GE_Errores_PG.vQuery;

BEGIN

   SN_cod_retorno := 0;
   SN_num_evento  := 0;
   SV_mens_retorno:= NULL;

   -- Inicializa valores básicos.-
   LN_NUM_MOVIMIENTO := NULL;
   LN_COD_ESTADO     := 1;
   LN_NUM_INTENTOS   := 0;
   LV_DES_RESPUESTA  := 'PENDIENTE';
   LV_NOM_USUARORA   := USER;
   LD_FEC_INGRESO    := SYSDATE;
   LV_TIP_TERMINAL   := 'G';
   LN_IND_BLOQUEO    := 0;
   LV_COD_MODULO     := CV_Modulo_Cen;

   -- Lee el datos basicos desde el abonado.-
   BEGIN
      sSql := 'SELECT cod_central, num_serie, cod_tecnologia';
      sSql := sSql||' INTO LN_cod_central, LV_num_serie, LV_tip_tecnologia';
      sSql := sSql||' FROM ga_abocel';
      sSql := sSql||' WHERE abo.num_abonado = '||TO_CHAR(EN_num_abonado);

      SELECT cod_central, num_serie, cod_tecnologia
      INTO LN_cod_central, LV_num_serie, LV_tip_tecnologia
      FROM  ga_abocel
      WHERE  num_abonado = EN_num_abonado;

   EXCEPTION
          WHEN NO_DATA_FOUND THEN
             BEGIN
                 sSql := 'SELECT cod_central, num_serie, cod_tecnologia';
                 sSql := sSql||' INTO LN_cod_central, LV_num_serie, LV_tip_tecnologia';
                 sSql := sSql||' FROM ga_aboamist';
                 sSql := sSql||' WHERE num_abonado = '||TO_CHAR(EN_num_abonado);

                 SELECT cod_central, num_serie, cod_tecnologia
                 INTO LN_cod_central, LV_num_serie, LV_tip_tecnologia
                 FROM ga_aboamist
                 WHERE num_abonado = EN_num_abonado;
             EXCEPTION
                 WHEN OTHERS THEN
                    raise error_datos;
             END;
   END;


   BEGIN

      sSql := 'INSERT INTO ICC_MOVIMIENTO ( ';
      sSql := sSql||' NUM_MOVIMIENTO,NUM_ABONADO,COD_ESTADO,COD_ACTABO,COD_MODULO,NUM_INTENTOS,COD_CENTRAL_NUE,';
      sSql := sSql||' DES_RESPUESTA,COD_ACTUACION,NOM_USUARORA,FEC_INGRESO,TIP_TERMINAL,COD_CENTRAL,FEC_LECTURA,';
      sSql := sSql||' IND_BLOQUEO,FEC_EJECUCION,TIP_TERMINAL_NUE,NUM_MOVANT,NUM_CELULAR,NUM_MOVPOS,NUM_SERIE,';
      sSql := sSql||' NUM_PERSONAL,NUM_CELULAR_NUE,NUM_SERIE_NUE,NUM_PERSONAL_NUE,NUM_MSNB,NUM_MSNB_NUE,COD_SUSPREHA,';
      sSql := sSql||' COD_SERVICIOS,NUM_MIN,NUM_MIN_NUE,STA,COD_MENSAJE,PARAM1_MENS,PARAM2_MENS,PARAM3_MENS,PLAN,CARGA,';
      sSql := sSql||' VALOR_PLAN,PIN,FEC_EXPIRA,DES_MENSAJE,COD_PIN,COD_IDIOMA,COD_ENRUTAMIENTO,TIP_ENRUTAMIENTO,';
      sSql := sSql||' DES_ORIGEN_PIN,NUM_LOTE_PIN,NUM_SERIE_PIN,TIP_TECNOLOGIA,IMSI,IMSI_NUE,IMEI,IMEI_NUE,';
      sSql := sSql||' ICC,ICC_NUE,FEC_ACTIVACION,COD_ESPEC_PROV,COD_PROD_CONTRATADO,IND_BAJATRANS)';
      sSql := sSql||' VALUES ( ';
      sSql := sSql||' LN_NUM_MOVIMIENTO'||','||EN_NUM_ABONADO||','||LN_COD_ESTADO||','||EV_COD_ACTABO||',';
      sSql := sSql||  LV_COD_MODULO||','||LN_NUM_INTENTOS||','||'NULL,'||LV_DES_RESPUESTA||',';
      sSql := sSql||  EN_COD_ACTUACION||','||LV_NOM_USUARORA||','||LD_FEC_INGRESO||','||LV_TIP_TERMINAL||',';
      sSql := sSql||  LN_COD_CENTRAL||','||'NULL,'||LN_IND_BLOQUEO||','||'NULL,NULL,NULL,';
      sSql := sSql||  EN_NUM_CELULAR||','||'NULL,'||LV_NUM_SERIE||',';
      sSql := sSql||' NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,';
      sSql := sSql||' NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,';
      sSql := sSql||  LV_TIP_TECNOLOGIA||','||'NULL,NULL,NULL,NULL,'||LV_NUM_SERIE||','||'NULL,NULL,NULL,NULL,NULL';
      sSql := sSql||' )RETURNING NUM_MOVIMIENTO INTO LN_NUM_MOVIMIENTO; ';


      INSERT INTO ICC_MOVIMIENTO
      (
           NUM_MOVIMIENTO,
           NUM_ABONADO,
           COD_ESTADO,
           COD_ACTABO,
           COD_MODULO,
           NUM_INTENTOS,
           COD_CENTRAL_NUE,
           DES_RESPUESTA,
           COD_ACTUACION,
           NOM_USUARORA,
           FEC_INGRESO,
           TIP_TERMINAL,
           COD_CENTRAL,
           FEC_LECTURA,
           IND_BLOQUEO,
           FEC_EJECUCION,
           TIP_TERMINAL_NUE,
           NUM_MOVANT,
           NUM_CELULAR,
           NUM_MOVPOS,
           NUM_SERIE,
           NUM_PERSONAL,
           NUM_CELULAR_NUE,
           NUM_SERIE_NUE,
           NUM_PERSONAL_NUE,
           NUM_MSNB,
           NUM_MSNB_NUE,
           COD_SUSPREHA,
           COD_SERVICIOS,
           NUM_MIN,
           NUM_MIN_NUE,
           STA,
           COD_MENSAJE,
           PARAM1_MENS,
           PARAM2_MENS,
           PARAM3_MENS,
           PLAN,
           CARGA,
           VALOR_PLAN,
           PIN,
           FEC_EXPIRA,
           DES_MENSAJE,
           COD_PIN,
           COD_IDIOMA,
           COD_ENRUTAMIENTO,
           TIP_ENRUTAMIENTO,
           DES_ORIGEN_PIN,
           NUM_LOTE_PIN,
           NUM_SERIE_PIN,
           TIP_TECNOLOGIA,
           IMSI,
           IMSI_NUE,
           IMEI,
           IMEI_NUE,
           ICC,
           ICC_NUE,
           FEC_ACTIVACION,
           COD_ESPEC_PROV,
           COD_PROD_CONTRATADO,
           IND_BAJATRANS
      )
      VALUES
      (
           NVL(LN_NUM_MOVIMIENTO, ICC_SEQ_NUMMOV.NEXTVAL),
           EN_NUM_ABONADO,
           LN_COD_ESTADO,
           EV_COD_ACTABO,
           LV_COD_MODULO,
           LN_NUM_INTENTOS,
           NULL,
           LV_DES_RESPUESTA,
           EN_COD_ACTUACION,
           LV_NOM_USUARORA,
           LD_FEC_INGRESO,
           LV_TIP_TERMINAL,
           LN_COD_CENTRAL,
           NULL,
           LN_IND_BLOQUEO,
           NULL,
           NULL,
           NULL,
           EN_NUM_CELULAR,
           NULL,
           LV_NUM_SERIE,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           LV_TIP_TECNOLOGIA,
           NULL,
           NULL,
           NULL,
           NULL,
           LV_NUM_SERIE,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL
       )RETURNING NUM_MOVIMIENTO INTO LN_NUM_MOVIMIENTO;


   EXCEPTION
      WHEN OTHERS THEN
         RAISE error_insert;
   END;


EXCEPTION
     WHEN error_datos THEN
           pv_registra_error_pr (CN_Err_Abo, sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
     WHEN error_insert THEN
           sSql := sSql||' --MOVIMIENTO:'||LN_num_movimiento;
           pv_registra_error_pr (CN_Err_Abo, sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
     WHEN OTHERS THEN
           pv_registra_error_pr (CN_err_ejecutar_servicio, sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

END IC_SOLBAJAPERFIL_PR;



PROCEDURE IC_BUSCABAJASPERFIL_PR
          (
          SN_reg_leidos     OUT NOCOPY NUMBER,
          SN_reg_procesados OUT NOCOPY NUMBER,
          SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
          SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
          SN_num_evento     OUT NOCOPY ge_errores_pg.evento
          ) IS
/*
<Documentación
        TipoDoc = "Procedure">
        <Elemento
                Nombre = "ic_buscabajasperfil_pr"
                Lenguaje="PL/SQL"
                Fecha creación="03-2010"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Procedure para generar una solicitud de baja de perfil.</Descripción>
                <Parámetros>
                        <Entrada>
                        </Entrada>
                        <Salida>
                                <param nom="SN_cod_retorno  " Tipo="NUMERICO">Codigo de Retorno </param>
                                <param nom="SV_mens_retorno " Tipo="CARACTER">Mensaje de Retorno</param>
                                <param nom="SN_num_evento   " Tipo="NUMERICO">Numero de Evento  </param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/

LB_retorno         BOOLEAN;
CN_nom_proced      VARCHAR2(25):='IC_SOLBAJAPERFIL_PR';
LN_cod_retorno     ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno    ge_errores_td.det_msgerror%TYPE;
LN_num_evento      ge_errores_pg.evento;
LN_Procesados      number := 0;
LN_Leidos          number := 0;
error_datos        EXCEPTION;
error_solbaja      EXCEPTION;
LV_cod_actabo      icc_movimiento.cod_actabo%TYPE;
LN_cod_actuacion   icc_movimiento.cod_actuacion%TYPE;
sSql               GE_Errores_PG.vQuery;


 CURSOR cBuscaBajasPerfil IS
     SELECT num_celular, num_abonado, NVL(cod_perfil,CHR(0)) cod_perfil
     FROM GA_PERFIL_CELULAR_TO
     WHERE fec_hastavig <= SYSDATE;

 C1 cBuscaBajasPerfil%ROWTYPE;

BEGIN

   SN_cod_retorno := 0;
   SN_num_evento  := 0;
   SV_mens_retorno:= NULL;

   -- Lee actabo aplicable a movimientos.-
   sSql := 'ic_busca_parametros_fn(''ACTABO_BAJA_PERFIL'', '''|| CV_Modulo_Cen ||''','||CN_Producto||',...)';

   LB_retorno:= ic_busca_parametros_fn('ACTABO_BAJA_PERFIL', CV_Modulo_Cen, CN_Producto, LV_cod_actabo, LN_cod_retorno, LV_mens_retorno,LN_num_evento);
   IF NOT LB_retorno THEN
        RAISE error_datos;
   END IF;

   BEGIN
        -- Lee actuacion aplicable a movimientos.-
        sSql := 'SELECT cod_actcen';
        sSql := sSql||' INTO LN_cod_actuacion';
        sSql := sSql||' FROM ga_actabo';
        sSql := sSql||' WHERE cod_producto = '||CN_Producto;
        sSql := sSql||' AND cod_actabo = '||LV_cod_actabo||'''';
        sSql := sSql||' AND cod_tecnologia = '||CV_TecnoGSM||'''';
        sSql := sSql||' AND cod_modulo = '||CV_Modulo_Cen||'''';

        SELECT cod_actcen
        INTO LN_cod_actuacion
        FROM  ga_actabo
        WHERE cod_producto = CN_Producto
        AND   cod_actabo = LV_cod_actabo
        AND   cod_tecnologia = CV_TecnoGSM
        AND   cod_modulo = CV_Modulo_Cen;
   EXCEPTION
      WHEN OTHERS THEN
        RAISE error_datos;
   END;


   -- Analiza tabla de perfiles por celular.-
   OPEN cBuscaBajasPerfil;
   LOOP
       FETCH cBuscaBajasPerfil INTO C1;
       EXIT WHEN cBuscaBajasPerfil%NOTFOUND;
       BEGIN
           -- Por cada uno que cumpla condicion (de cursor), se genera un movimiento de solicitud de baja.-
           IC_SOLBAJAPERFIL_PR(C1.num_abonado,C1.num_celular,LV_cod_actabo,LN_cod_actuacion,LN_cod_retorno,LV_mens_retorno,LN_num_evento);

           IF LN_cod_retorno = 0 THEN
              DELETE FROM GA_PERFIL_CELULAR_TO
              WHERE num_celular = C1.num_celular
                AND num_abonado = C1.num_abonado;

              COMMIT;

              LN_Procesados := LN_Procesados + 1; -- Contador de solicitudes de baja generadas correctamente.-
           END IF;


       END;
   END LOOP;
   LN_Leidos := cBuscaBajasPerfil%ROWCOUNT;
   CLOSE cBuscaBajasPerfil;

   SN_reg_leidos := LN_Leidos;
   SN_reg_procesados := LN_Procesados;

   IF LN_Leidos <> LN_Procesados THEN
      SV_mens_retorno := 'Se procesaron menos de los registros leidos. Revisar eventos generados.';
   END IF;


EXCEPTION
     WHEN error_datos THEN
           pv_registra_error_pr (CN_Err_Abo, sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
     WHEN error_solbaja THEN
           sSql := 'IC_SOLBAJAPERFIL_PR('||C1.num_abonado||','||C1.num_celular||','||LV_cod_actabo||','||LN_cod_actuacion;
           sSql := sSql||','||LN_cod_retorno||','||LV_mens_retorno||','||LN_num_evento||')';
           pv_registra_error_pr (CN_Err_Abo, sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
     WHEN OTHERS THEN
           pv_registra_error_pr (CN_err_ejecutar_servicio, sSql, CN_nom_proced, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
END IC_BUSCABAJASPERFIL_PR;


END IC_PERFILES_PG;
/
SHOW ERRORS
