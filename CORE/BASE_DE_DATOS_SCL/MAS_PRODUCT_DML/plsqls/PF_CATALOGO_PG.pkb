CREATE OR REPLACE PACKAGE BODY PF_CATALOGO_PG

AS

  PROCEDURE PF_CANAL_S_PR(EO_Catalogos      IN          PF_CATALOGO_OFER_TD_QT,
                          SO_Lista_Catalogos OUT NOCOPY    refCursor,
                          SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
                          SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
                          SN_num_evento       OUT NOCOPY    ge_errores_pg.evento)
    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PF_CANAL_S_PR"
          Lenguaje="PL/SQL"
          Fecha="20-07-2007"
          Versión="La del package"
          Diseñador="Andrés Osorio"
          Programador="Hilda Quezada"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción></Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="EO_Catalogos" Tipo="estructura">Datos catalogo/param>>
             </Entrada>
             <Salida>
                <param nom="SO_Lista_Catalogos" Tipo="Cursor">Lista de Productos</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    v_contador           number(9);
    ERROR_PARAMETROS EXCEPTION;

    BEGIN
            SN_cod_retorno     := 0;
            SV_mens_retorno := ' ';
            SN_num_evento     := 0;

    IF EO_Catalogos IS NULL THEN
             RAISE ERROR_PARAMETROS;
    ELSE

          --EO_Catalogos.COD_CANAL;

          --IF  NVL( EO_Catalogos.IND_NIVEL_APLICA, -1) <> -1 THEN
          IF EO_Catalogos.IND_NIVEL_APLICA IS NOT NULL THEN
                LV_sSql := 'SELECT distinct A.COD_PROD_OFERTADO, b.COD_CATEGORIA, b.TIPO_PLATAFORMA ';
                LV_sSql := LV_sSql || 'FROM PF_CATALOGO_OFERTADO_TD a, PF_PRODUCTOS_OFERTADOS_TD b ';
                LV_sSql := LV_sSql || 'WHERE a.COD_CANAL = ' ||EO_Catalogos.COD_CANAL;
                LV_sSql := LV_sSql || 'AND '||EO_Catalogos.FEC_INICIO_VIGENCIA ||' >= A.FEC_INICIO_VIGENCIA ';
                LV_sSql := LV_sSql || 'AND A.FEC_TERMINO_VIGENCIA< = '|| trunc(EO_Catalogos.FEC_TERMINO_VIGENCIA);
                LV_sSql := LV_sSql || 'AND B.IND_NIVEL_APLICA =  ' ||EO_Catalogos.IND_NIVEL_APLICA;
                LV_sSql := LV_sSql || 'AND a.COD_PROD_OFERTADO = b.COD_PROD_OFERTADO';

                OPEN SO_Lista_Catalogos FOR
                SELECT distinct A.COD_PROD_OFERTADO, b.COD_CATEGORIA, b.TIPO_PLATAFORMA
                FROM   PF_CATALOGO_OFERTADO_TD a, PF_PRODUCTOS_OFERTADOS_TD b
                WHERE  a.COD_CANAL = EO_Catalogos.COD_CANAL
                AND    EO_Catalogos.FEC_INICIO_VIGENCIA >= A.FEC_INICIO_VIGENCIA
                AND    A.FEC_TERMINO_VIGENCIA >=  trunc(EO_Catalogos.FEC_TERMINO_VIGENCIA)
                AND    B.IND_NIVEL_APLICA =  EO_Catalogos.IND_NIVEL_APLICA
                AND    a.COD_PROD_OFERTADO = b.COD_PROD_OFERTADO;
          ELSE
                LV_sSql := 'SELECT distinct A.COD_PROD_OFERTADO, b.COD_CATEGORIA, b.TIPO_PLATAFORMA ';
                LV_sSql := LV_sSql || 'FROM PF_CATALOGO_OFERTADO_TD a, PF_PRODUCTOS_OFERTADOS_TD b ';
                LV_sSql := LV_sSql || 'WHERE a.COD_CANAL = ' ||EO_Catalogos.COD_CANAL;
                LV_sSql := LV_sSql || 'AND ' ||EO_Catalogos.FEC_INICIO_VIGENCIA|| ' >= A.FEC_INICIO_VIGENCIA ';
                LV_sSql := LV_sSql || 'AND A.FEC_TERMINO_VIGENCIA <= '|| trunc(EO_Catalogos.FEC_TERMINO_VIGENCIA);
                LV_sSql := LV_sSql || 'AND a.COD_PROD_OFERTADO = b.COD_PROD_OFERTADO';

                OPEN SO_Lista_Catalogos FOR
                SELECT distinct A.COD_PROD_OFERTADO, b.COD_CATEGORIA, b.TIPO_PLATAFORMA
                FROM   PF_CATALOGO_OFERTADO_TD a, PF_PRODUCTOS_OFERTADOS_TD b
                WHERE  a.COD_CANAL = EO_Catalogos.COD_CANAL
                AND    EO_Catalogos.FEC_INICIO_VIGENCIA >= A.FEC_INICIO_VIGENCIA
                AND    A.FEC_TERMINO_VIGENCIA >=  trunc(EO_Catalogos.FEC_TERMINO_VIGENCIA)
                AND    a.COD_PROD_OFERTADO = b.COD_PROD_OFERTADO;
          END IF;
    END IF;

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
          SN_cod_retorno := 98;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_CANAL_S_PR(Lista Catalogos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_CANAL_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 1397;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_CANAL_S_PR(Lista Catalogos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_CANAL_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_CANAL_S_PR(Lista Catalogos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_CANAL_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PF_CANAL_S_PR;
--*******************************************************************************************************************************************************************************************
  PROCEDURE PF_CANAL_S_PA_PR(EO_Catalogos         IN  PF_CATALOGO_OFER_PA_TD_QT,
                             SO_Lista_Catalogos  OUT NOCOPY    refCursor,
                             SN_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
                             SV_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
                             SN_num_evento       OUT NOCOPY    ge_errores_pg.evento)
    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PF_CANAL_S_PA_PR"
          Lenguaje="PL/SQL"
          Fecha="15-11-2010"
          Versión="La del package"
          Diseñador="Jacqueline Mendez Ortega INC-155400"
          Programador="Jacqueline Mendez Ortega"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción>Obtiene planes adicionales opcionales y obligatorios</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="EO_Catalogos"       Tipo="estructura">Datos catalogo    </param>>
             </Entrada>
             <Salida>
                <param nom="SO_Lista_Catalogos" Tipo="Cursor">   Lista de Productos </param>>
                <param nom="SN_cod_retorno"     Tipo="NUMERICO"> Codigo de Retorno  </param>>
                <param nom="SV_mens_retorno"    Tipo="CARACTER"> Mensaje de Retorno </param>>
                <param nom="SN_num_evento"      Tipo="NUMERICO"> Numero de Evento   </param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error            ge_errores_pg.DesEvent;
    LV_sSql                    ge_errores_pg.vQuery;
    v_contador                NUMBER(9);
    ERROR_PARAMETROS        EXCEPTION;
    LV_APLICA_PLAN_ADIC_OO  VARCHAR2(5);
    LV_cod_plantarif        ta_plantarif.cod_plantarif%TYPE;
    LN_empresa              NUMBER(1);

    BEGIN
            SN_cod_retorno     := 0;
            SV_mens_retorno := ' ';
            SN_num_evento     := 0;

    IF EO_Catalogos IS NULL THEN
             RAISE ERROR_PARAMETROS;
    ELSE

          BEGIN

             LV_sSql := 'SELECT VAL_PARAMETRO '
                     || ' FROM GED_PARAMETROS '
                     || ' WHERE COD_PRODUCTO = '||CN_COD_PRODUCTO
                     || ' AND COD_MODULO = '||CV_GE
                     || ' AND NOM_PARAMETRO = '||CV_APLICA_PLAN_ADIC_OO;

             SELECT VAL_PARAMETRO
             INTO LV_APLICA_PLAN_ADIC_OO
             FROM GED_PARAMETROS
             WHERE COD_PRODUCTO = CN_COD_PRODUCTO
             AND COD_MODULO = CV_GE
             AND NOM_PARAMETRO = CV_APLICA_PLAN_ADIC_OO;

          EXCEPTION
             WHEN NO_DATA_FOUND THEN
                LV_APLICA_PLAN_ADIC_OO := 'FALSE';
          END;

          IF LV_APLICA_PLAN_ADIC_OO IS NULL OR LV_APLICA_PLAN_ADIC_OO = '' THEN
                LV_APLICA_PLAN_ADIC_OO:='FALSE';
          END IF;


          IF EO_Catalogos.NUM_ABONADO <> 0 THEN

             --------------------------------- ABONADO -----------------------------------
             LV_sSql := ' SELECT COD_PLANTARIF '
                     || ' FROM GA_ABOCEL '
                     || ' WHERE NUM_ABONADO = '||EO_Catalogos.NUM_ABONADO
                     || ' UNION '
                     || ' SELECT COD_PLANTARIF '
                     || ' FROM GA_ABOAMIST '
                     || ' WHERE NUM_ABONADO = '||EO_Catalogos.NUM_ABONADO||' ';

             SELECT COD_PLANTARIF
             INTO LV_cod_plantarif
             FROM GA_ABOCEL
             WHERE NUM_ABONADO = EO_Catalogos.NUM_ABONADO
             UNION
             SELECT COD_PLANTARIF
             FROM GA_ABOAMIST
             WHERE NUM_ABONADO = EO_Catalogos.NUM_ABONADO;

             IF EO_Catalogos.IND_NIVEL_APLICA IS NOT NULL THEN

                IF LV_APLICA_PLAN_ADIC_OO = 'FALSE' THEN

                    LV_sSql := ' SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, c.tipo_relacion_pa TIPO_PLAN_ADIC '
                            || ' FROM pf_catalogo_ofertado_td a, pf_productos_ofertados_td b, ps_plantarif_planadic_td c '
                            || ' WHERE a.cod_canal = '|| EO_Catalogos.COD_CANAL
                            || ' AND '||EO_Catalogos.FEC_INICIO_VIGENCIA||' BETWEEN a.fec_inicio_vigencia AND a.fec_termino_vigencia '
                            || ' AND b.ind_nivel_aplica = '||EO_Catalogos.IND_NIVEL_APLICA
                            || ' AND a.cod_prod_ofertado = b.cod_prod_ofertado '
                            || ' AND b.cod_prod_ofertado = c.cod_prod_ofertado '
                            || ' AND c.cod_plantarif = '||LV_cod_plantarif
                            || ' AND SYSDATE BETWEEN c.fecha_inicio AND c.fecha_fin';

                    OPEN SO_Lista_Catalogos FOR
                        SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, c.tipo_relacion_pa tipo_plan_adic
                        FROM   pf_catalogo_ofertado_td a, pf_productos_ofertados_td b, ps_plantarif_planadic_td c
                        WHERE  a.cod_canal = EO_Catalogos.COD_CANAL
                        AND    EO_Catalogos.FEC_INICIO_VIGENCIA BETWEEN a.fec_inicio_vigencia AND a.fec_termino_vigencia
                        AND    b.ind_nivel_aplica =  EO_Catalogos.IND_NIVEL_APLICA
                        AND    a.cod_prod_ofertado = b.cod_prod_ofertado
                        AND    b.cod_prod_ofertado = c.cod_prod_ofertado
                        AND    c.cod_plantarif = LV_cod_plantarif
                        AND    SYSDATE BETWEEN c.fec_inicio_vigencia AND NVL (c.fec_termino_vigencia, SYSDATE);

                ELSE

                    --CSR-11002 INC-174126
                    /*LV_sSql := ' SELECT DISTINCT A.COD_PROD_OFERTADO, b.COD_CATEGORIA, b.TIPO_PLATAFORMA, 1 tipo_plan_adic '
                            || ' FROM PF_CATALOGO_OFERTADO_TD a, PF_PRODUCTOS_OFERTADOS_TD b '
                            || ' WHERE a.COD_CANAL = ' ||EO_Catalogos.COD_CANAL
                            || ' AND '||EO_Catalogos.FEC_INICIO_VIGENCIA ||' >= A.FEC_INICIO_VIGENCIA '
                            || ' AND A.FEC_TERMINO_VIGENCIA< = '|| ' trunc('||EO_Catalogos.FEC_TERMINO_VIGENCIA||') '
                            || ' AND B.IND_NIVEL_APLICA =  ' ||EO_Catalogos.IND_NIVEL_APLICA
                            || ' AND a.COD_PROD_OFERTADO = b.COD_PROD_OFERTADO ';

                    OPEN SO_Lista_Catalogos FOR
                        SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, 1 tipo_plan_adic
                        FROM   pf_catalogo_ofertado_td a, pf_productos_ofertados_td b
                        WHERE  a.cod_canal = EO_Catalogos.COD_CANAL
                        AND    EO_Catalogos.FEC_INICIO_VIGENCIA >= a.fec_inicio_vigencia
                        AND    a.fec_termino_vigencia >=  TRUNC(EO_Catalogos.FEC_TERMINO_VIGENCIA)
                        AND    b.ind_nivel_aplica =  EO_Catalogos.IND_NIVEL_APLICA
                        AND    a.cod_prod_ofertado = b.cod_prod_ofertado;*/

                    --CSR-11002 INC-174126
                    LV_sSql := ' SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, c.tipo_relacion_pa TIPO_PLAN_ADIC '
                            || ' FROM pf_catalogo_ofertado_td a, pf_productos_ofertados_td b, ps_plantarif_planadic_td c '
                            || ' WHERE a.cod_canal = '|| EO_Catalogos.COD_CANAL
                            || ' AND '||EO_Catalogos.FEC_INICIO_VIGENCIA||' BETWEEN a.fec_inicio_vigencia AND a.fec_termino_vigencia '
                            || ' AND b.ind_nivel_aplica = '||EO_Catalogos.IND_NIVEL_APLICA
                            || ' AND a.cod_prod_ofertado = b.cod_prod_ofertado '
                            || ' AND b.cod_prod_ofertado = c.cod_prod_ofertado '
                            || ' AND c.cod_plantarif = '||LV_cod_plantarif
                            || ' AND SYSDATE BETWEEN c.fecha_inicio AND c.fecha_fin';

                    OPEN SO_Lista_Catalogos FOR
                        SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, c.tipo_relacion_pa tipo_plan_adic
                        FROM   pf_catalogo_ofertado_td a, pf_productos_ofertados_td b, ps_plantarif_planadic_td c
                        WHERE  a.cod_canal = EO_Catalogos.COD_CANAL
                        AND    EO_Catalogos.FEC_INICIO_VIGENCIA BETWEEN a.fec_inicio_vigencia AND a.fec_termino_vigencia
                        AND    b.ind_nivel_aplica =  EO_Catalogos.IND_NIVEL_APLICA
                        AND    a.cod_prod_ofertado = b.cod_prod_ofertado
                        AND    b.cod_prod_ofertado = c.cod_prod_ofertado
                        AND    c.cod_plantarif = LV_cod_plantarif
                        AND    SYSDATE BETWEEN c.fec_inicio_vigencia AND NVL (c.fec_termino_vigencia, SYSDATE);

                END IF;--Fin IF

             ELSE

                IF LV_APLICA_PLAN_ADIC_OO = 'FALSE' THEN

                    LV_sSql := ' SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, c.tipo_relacion_pa tipo_plan_adic '
                            || ' FROM pf_catalogo_ofertado_td a, pf_productos_ofertados_td b, ps_plantarif_planadic_td c '
                            || ' WHERE a.cod_canal = '||EO_Catalogos.COD_CANAL
                            || ' AND '||EO_Catalogos.FEC_INICIO_VIGENCIA||' BETWEEN a.fec_inicio_vigencia AND a.fec_termino_vigencia '
                            || ' AND a.cod_prod_ofertado = b.cod_prod_ofertado '
                            || ' AND b.cod_prod_ofertado = c.cod_prod_ofertado '
                            || ' AND c.cod_plantarif = '||LV_cod_plantarif
                            || ' AND SYSDATE BETWEEN c.fec_inicio_vigencia AND NVL (c.fec_termino_vigencia, SYSDATE) ';

                    OPEN SO_Lista_Catalogos FOR
                        SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, c.tipo_relacion_pa tipo_plan_adic
                        FROM pf_catalogo_ofertado_td a, pf_productos_ofertados_td b, ps_plantarif_planadic_td c
                        WHERE a.cod_canal = EO_Catalogos.COD_CANAL
                        AND EO_Catalogos.FEC_INICIO_VIGENCIA BETWEEN a.fec_inicio_vigencia AND a.fec_termino_vigencia
                        AND a.cod_prod_ofertado = b.cod_prod_ofertado
                        AND b.cod_prod_ofertado = c.cod_prod_ofertado
                        AND c.cod_plantarif = LV_cod_plantarif
                        AND SYSDATE BETWEEN c.fec_inicio_vigencia AND NVL (c.fec_termino_vigencia, SYSDATE);

                ELSE

                    LV_sSql := ' SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, 1 tipo_plan_adic '
                            || ' FROM pf_catalogo_ofertado_td a, pf_productos_ofertados_td b '
                            || ' WHERE a.cod_canal = '||EO_Catalogos.COD_CANAL
                            || ' AND '||EO_Catalogos.FEC_INICIO_VIGENCIA||' >= a.fec_inicio_vigencia '
                            || ' AND a.fec_termino_vigencia >= TRUNC('||EO_Catalogos.FEC_TERMINO_VIGENCIA||') '
                            || ' AND a.cod_prod_ofertado = b.cod_prod_ofertado ';

                    OPEN SO_Lista_Catalogos FOR
                        SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, 1 tipo_plan_adic
                        FROM   pf_catalogo_ofertado_td a, pf_productos_ofertados_td b
                        WHERE  a.cod_canal = EO_Catalogos.COD_CANAL
                        AND    EO_Catalogos.FEC_INICIO_VIGENCIA >= a.fec_inicio_vigencia
                        AND    a.fec_termino_vigencia >= TRUNC(EO_Catalogos.FEC_TERMINO_VIGENCIA)
                        AND    a.cod_prod_ofertado = b.cod_prod_ofertado;

                END IF;--Fin IF

             END IF;--Fin   IF EO_Catalogos.IND_NIVEL_APLICA IS NOT NULL THEN

             --*********************** FIN ABONADO *************************************--

          ELSE

             ----------------------------- CLIENTE ---------------------------------------
             LV_sSql := ' SELECT COUNT(1)'
                     || ' FROM GA_EMPRESA'
                     || ' WHERE COD_CLIENTE = '||EO_Catalogos.COD_CLIENTE;

             SELECT COUNT(1)
             INTO LN_empresa
             FROM GA_EMPRESA
             WHERE COD_CLIENTE = EO_Catalogos.COD_CLIENTE;

             IF LN_empresa > 0 THEN

                LV_sSql := 'SELECT COD_PLANTARIF';
                LV_sSql := LV_sSql || ' FROM GA_EMPRESA';
                LV_sSql := LV_sSql || ' WHERE COD_CLIENTE = '||EO_Catalogos.COD_CLIENTE;

                SELECT COD_PLANTARIF
                INTO LV_cod_plantarif
                FROM GA_EMPRESA
                WHERE COD_CLIENTE = EO_Catalogos.COD_CLIENTE;

             END IF;


             IF EO_Catalogos.IND_NIVEL_APLICA IS NOT NULL THEN

                IF LV_APLICA_PLAN_ADIC_OO = 'FALSE' AND LN_empresa > 0 THEN

                    --Se obtienen los PA a nivel de cliente empresa
                    LV_sSql := ' SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, c.tipo_relacion_pa TIPO_PLAN_ADIC '
                            || ' FROM pf_catalogo_ofertado_td a, pf_productos_ofertados_td b, ps_plantarif_planadic_td c '
                            || ' WHERE a.cod_canal = '|| EO_Catalogos.COD_CANAL
                            || ' AND '||EO_Catalogos.FEC_INICIO_VIGENCIA||' BETWEEN a.fec_inicio_vigencia AND a.fec_termino_vigencia '
                            || ' AND b.ind_nivel_aplica = '||EO_Catalogos.IND_NIVEL_APLICA
                            || ' AND a.cod_prod_ofertado = b.cod_prod_ofertado '
                            || ' AND b.cod_prod_ofertado = c.cod_prod_ofertado '
                            || ' AND c.cod_plantarif = '||LV_cod_plantarif
                            || ' AND SYSDATE BETWEEN c.fecha_inicio AND c.fecha_fin';

                    OPEN SO_Lista_Catalogos FOR
                        SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, c.tipo_relacion_pa tipo_plan_adic
                        FROM   pf_catalogo_ofertado_td a, pf_productos_ofertados_td b, ps_plantarif_planadic_td c
                        WHERE  a.cod_canal = EO_Catalogos.COD_CANAL
                        AND    EO_Catalogos.FEC_INICIO_VIGENCIA BETWEEN a.fec_inicio_vigencia AND a.fec_termino_vigencia
                        AND    b.ind_nivel_aplica =  EO_Catalogos.IND_NIVEL_APLICA
                        AND    a.cod_prod_ofertado = b.cod_prod_ofertado
                        AND    b.cod_prod_ofertado = c.cod_prod_ofertado
                        AND    c.cod_plantarif = LV_cod_plantarif
                        AND    SYSDATE BETWEEN c.fec_inicio_vigencia AND NVL (c.fec_termino_vigencia, SYSDATE);

                ELSIF LV_APLICA_PLAN_ADIC_OO = 'FALSE' AND LN_empresa = 0 THEN

                    -- Se obtienen los PA a nivel de cliente individual
                    LV_sSql := ' SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, c.tipo_relacion_pa TIPO_PLAN_ADIC '
                            || ' FROM pf_catalogo_ofertado_td a, pf_productos_ofertados_td b, ps_plantarif_planadic_td c '
                            || ' WHERE a.cod_canal = '|| EO_Catalogos.COD_CANAL
                            || ' AND '||EO_Catalogos.FEC_INICIO_VIGENCIA||' BETWEEN a.fec_inicio_vigencia AND a.fec_termino_vigencia '
                            || ' AND b.ind_nivel_aplica = '||EO_Catalogos.IND_NIVEL_APLICA
                            || ' AND a.cod_prod_ofertado = b.cod_prod_ofertado '
                            || ' AND b.cod_prod_ofertado = c.cod_prod_ofertado '
                            || ' AND c.cod_plantarif = IN '
                            || ' (SELECT distinct cod_plantarif FROM ga_abocel '
                            || ' WHERE  cod_cliente = '||EO_Catalogos.COD_CLIENTE
                            || ' AND    cod_situacion <> ''BAA'' '
                            || ' UNION '
                            || ' SELECT distinct cod_plantarif FROM ga_aboamist '
                            || ' WHERE  cod_cliente = '|| EO_Catalogos.COD_CLIENTE
                            || ' AND    cod_situacion <> ''BAA'' ) '
                            || ' AND SYSDATE BETWEEN c.fecha_inicio AND c.fecha_fin';

                    OPEN SO_Lista_Catalogos FOR
                        SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, c.tipo_relacion_pa tipo_plan_adic
                        FROM   pf_catalogo_ofertado_td a, pf_productos_ofertados_td b, ps_plantarif_planadic_td c
                        WHERE  a.cod_canal = EO_Catalogos.COD_CANAL
                        AND    EO_Catalogos.FEC_INICIO_VIGENCIA BETWEEN a.fec_inicio_vigencia AND a.fec_termino_vigencia
                        AND    b.ind_nivel_aplica =  EO_Catalogos.IND_NIVEL_APLICA
                        AND    a.cod_prod_ofertado = b.cod_prod_ofertado
                        AND    b.cod_prod_ofertado = c.cod_prod_ofertado
                        AND    c.cod_plantarif IN (SELECT distinct cod_plantarif FROM ga_abocel
                                                   WHERE  cod_cliente = EO_Catalogos.COD_CLIENTE
                                                   AND    cod_situacion <> 'BAA'
                                                   UNION
                                                   SELECT distinct cod_plantarif FROM ga_aboamist
                                                   WHERE  cod_cliente = EO_Catalogos.COD_CLIENTE
                                                   AND    cod_situacion <> 'BAA')
                        AND    SYSDATE BETWEEN c.fec_inicio_vigencia AND NVL (c.fec_termino_vigencia, SYSDATE);

                ELSE

                    LV_sSql := ' SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, 1 tipo_plan_adic '
                            || ' FROM pf_catalogo_ofertado_td a, pf_productos_ofertados_td b '
                            || ' WHERE a.cod_canal = '||EO_Catalogos.COD_CANAL
                            || ' AND '||EO_Catalogos.FEC_INICIO_VIGENCIA||' >= a.fec_inicio_vigencia '
                            || ' AND a.fec_termino_vigencia >= TRUNC('||EO_Catalogos.FEC_TERMINO_VIGENCIA||') '
                            || ' AND    b.ind_nivel_aplica = '||EO_Catalogos.IND_NIVEL_APLICA
                            || ' AND a.cod_prod_ofertado = b.cod_prod_ofertado ';

                    OPEN SO_Lista_Catalogos FOR
                        SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, 1 tipo_plan_adic
                        FROM   pf_catalogo_ofertado_td a, pf_productos_ofertados_td b
                        WHERE  a.cod_canal = EO_Catalogos.COD_CANAL
                        AND    EO_Catalogos.FEC_INICIO_VIGENCIA >= a.fec_inicio_vigencia
                        AND    a.fec_termino_vigencia >= TRUNC(EO_Catalogos.FEC_TERMINO_VIGENCIA)
                        AND    b.ind_nivel_aplica =  EO_Catalogos.IND_NIVEL_APLICA
                        AND    a.cod_prod_ofertado = b.cod_prod_ofertado;

                END IF;--Fin  IF LV_APLICA_PLAN_ADIC_OO = 'TRUE' AND LV_empresa > 0

             ELSE

                IF LV_APLICA_PLAN_ADIC_OO = 'FALSE' AND LN_empresa > 0 THEN

                    LV_sSql := ' SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, c.tipo_relacion_pa TIPO_PLAN_ADIC '
                            || ' FROM pf_catalogo_ofertado_td a, pf_productos_ofertados_td b, ps_plantarif_planadic_td c '
                            || ' WHERE a.cod_canal = '|| EO_Catalogos.COD_CANAL
                            || ' AND '||EO_Catalogos.FEC_INICIO_VIGENCIA||' BETWEEN a.fec_inicio_vigencia AND a.fec_termino_vigencia '
                            || ' AND a.cod_prod_ofertado = b.cod_prod_ofertado '
                            || ' AND b.cod_prod_ofertado = c.cod_prod_ofertado '
                            || ' AND c.cod_plantarif = '||LV_cod_plantarif
                            || ' AND SYSDATE BETWEEN c.fecha_inicio AND c.fecha_fin';

                    OPEN SO_Lista_Catalogos FOR
                        SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, c.tipo_relacion_pa tipo_plan_adic
                        FROM   pf_catalogo_ofertado_td a, pf_productos_ofertados_td b, ps_plantarif_planadic_td c
                        WHERE  a.cod_canal = EO_Catalogos.COD_CANAL
                        AND    EO_Catalogos.FEC_INICIO_VIGENCIA BETWEEN a.fec_inicio_vigencia AND a.fec_termino_vigencia
                        AND    a.cod_prod_ofertado = b.cod_prod_ofertado
                        AND    b.cod_prod_ofertado = c.cod_prod_ofertado
                        AND    c.cod_plantarif = LV_cod_plantarif
                        AND    SYSDATE BETWEEN c.fec_inicio_vigencia AND NVL (c.fec_termino_vigencia, SYSDATE);

                ELSE

                    LV_sSql := ' SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, 1 tipo_plan_adic '
                            || ' FROM pf_catalogo_ofertado_td a, pf_productos_ofertados_td b '
                            || ' WHERE a.cod_canal = '||EO_Catalogos.COD_CANAL
                            || ' AND '||EO_Catalogos.FEC_INICIO_VIGENCIA||' >= a.fec_inicio_vigencia '
                            || ' AND a.fec_termino_vigencia >= TRUNC('||EO_Catalogos.FEC_TERMINO_VIGENCIA||') '
                            || ' AND    b.ind_nivel_aplica = '||EO_Catalogos.IND_NIVEL_APLICA
                            || ' AND a.cod_prod_ofertado = b.cod_prod_ofertado ';

                    OPEN SO_Lista_Catalogos FOR
                        SELECT DISTINCT a.cod_prod_ofertado, b.cod_categoria, b.tipo_plataforma, 1 tipo_plan_adic
                        FROM   pf_catalogo_ofertado_td a, pf_productos_ofertados_td b
                        WHERE  a.cod_canal = EO_Catalogos.COD_CANAL
                        AND    EO_Catalogos.FEC_INICIO_VIGENCIA >= a.fec_inicio_vigencia
                        AND    a.fec_termino_vigencia >= TRUNC(EO_Catalogos.FEC_TERMINO_VIGENCIA)
                        AND    a.cod_prod_ofertado = b.cod_prod_ofertado;

                END IF;--Fin IF

             END IF;--Fin IF EO_Catalogos.IND_NIVEL_APLICA IS NOT NULL

             --************************* FIN CLIENTE *************************************--

          END IF;--Fin IF EO_Catalogos.NUM_ABONADO <> 0

    END IF;--Fin IF EO_Catalogos IS NULL

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
          SN_cod_retorno := 98;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_CANAL_S_PA_PR(Lista Catalogos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_CANAL_S_PA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 1397;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_CANAL_S_PA_PR(Lista Catalogos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_CANAL_S_PA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_CANAL_S_PA_PR(Lista Catalogos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_CANAL_S_PA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PF_CANAL_S_PA_PR;
--*******************************************************************************************************************************************************************************************
PROCEDURE PF_PRODUCTO_S_PR(EO_Catalogos      IN          PF_CATAL_OFER_TD_LISTA_QT,
                          SO_Lista_Catalogos OUT NOCOPY    refCursor,
                          SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
                          SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
                          SN_num_evento       OUT NOCOPY    ge_errores_pg.evento)
    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PF_CANAL_S_PR"
          Lenguaje="PL/SQL"
          Fecha="20-07-2007"
          Versión="La del package"
          Diseñador="Andrés Osorio"
          Programador="Hilda Quezada"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción></Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
             </Entrada>
             <Salida>
                <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    v_contador           number(9);
    ERROR_PARAMETROS EXCEPTION;

        BEGIN
            SN_cod_retorno     := 0;
            SV_mens_retorno := ' ';
            SN_num_evento     := 0;

            IF EO_Catalogos IS NULL THEN
              RAISE ERROR_PARAMETROS;
            ELSE
                LV_sSql := 'SELECT A.COD_PROD_OFERTADO, A.COD_CANAL, A.Cod_cargo, ';
                LV_sSql := LV_sSql || 'A.Cod_concepto, A.FEC_INICIO_VIGENCIA, A.FEC_TERMINO_VIGENCIA ';
                LV_sSql := LV_sSql || 'FROM PF_CATALOGO_OFERTADO_TD a ';
                LV_sSql := LV_sSql || 'WHERE a.COD_CANAL IN (SELECT COD_CANAL FROM TABLE(EO_Catalogos)) ';
                LV_sSql := LV_sSql || 'AND A.COD_PROD_OFERTADO IN (SELECT COD_PROD_OFERTADO FROM TABLE(EO_Catalogos)) ';
                LV_sSql := LV_sSql || 'AND A.FEC_INICIO_VIGENCIA=  ' || SYSDATE;
                LV_sSql := LV_sSql || 'AND A.FEC_TERMINO_VIGENCIA IN (SELECT FEC_TERMINO_VIGENCIA FROM TABLE(EO_Catalogos))';

                OPEN SO_Lista_Catalogos FOR
                SELECT A.COD_PROD_OFERTADO,A.COD_CANAL,A.Cod_cargo,
                       A.Cod_concepto, A.FEC_INICIO_VIGENCIA, A.FEC_TERMINO_VIGENCIA
                FROM   PF_CATALOGO_OFERTADO_TD a
                WHERE a.COD_CANAL IN (SELECT COD_CANAL FROM TABLE(EO_Catalogos))
                AND   A.COD_PROD_OFERTADO IN (SELECT COD_PROD_OFERTADO FROM TABLE(EO_Catalogos))
                AND   A.FEC_INICIO_VIGENCIA = SYSDATE
                AND   A.FEC_TERMINO_VIGENCIA IN (SELECT FEC_TERMINO_VIGENCIA FROM TABLE(EO_Catalogos));

            END IF;

EXCEPTION
   WHEN ERROR_PARAMETROS THEN
          SN_cod_retorno := 98;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_PRODUCTO_S_PR(Lista Catalogos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_PRODUCTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 149;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_PRODUCTO_S_PR(Lista Catalogos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_PRODUCTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_PRODUCTO_S_PR(Lista Catalogos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_PRODUCTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PF_PRODUCTO_S_PR;
        ----------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PF_DETALLE_S_PR(EO_Catalogos      IN          PF_CATALOGO_OFER_TD_QT,
                                              SO_Lista_Catalogos OUT NOCOPY    refCursor,
                                              SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
                                               SV_mens_retorno    OUT NOCOPY    ge_errores_pg.msgerror,
                                              SN_num_evento     OUT NOCOPY    ge_errores_pg.evento)
    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PF_CANAL_S_PR"
          Lenguaje="PL/SQL"
          Fecha="20-07-2007"
          Versión="La del package"
          Diseñador="Andrés Osorio"
          Programador="Hilda Quezada"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción></Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
             </Entrada>
             <Salida>
                <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    v_contador           number(9);
    v_cod_operadora    VARCHAR2(3);
    ERROR_PARAMETROS EXCEPTION;
        BEGIN
            SN_cod_retorno     := 0;
            SV_mens_retorno := ' ';
            SN_num_evento     := 0;

            --v_cod_operadora:=SISCEL.GE_OBTIENE_OPERADORA_LOCAL_FN(v_cod_retorno,v_mens_retorno,v_num_evento);
            --IF v_cod_retorno <> 0 THEN
            --   NULL;
            --END IF;


           -- IF v_cod_operadora='TMG' THEN


                IF EO_Catalogos IS NULL THEN
                  RAISE ERROR_PARAMETROS;
                ELSE
                LV_sSql := 'SELECT  a.cod_prod_ofertado, ';
                LV_sSql := LV_sSql || ' a.cod_cargo, ';
                LV_sSql := LV_sSql || ' b.ID_CARGO, ';
                LV_sSql := LV_sSql || ' a.cod_concepto, ';
                LV_sSql := LV_sSql || ' f.des_concepto, ';
                LV_sSql := LV_sSql || ' b.monto_importe, ';
                LV_sSql := LV_sSql || ' b.cod_moneda, ';
                LV_sSql := LV_sSql || ' e.DES_MONEDA, ';
                LV_sSql := LV_sSql || ' c.ind_prorrateable, ';
                LV_sSql := LV_sSql || ' c.tipo_cargo ';
                LV_sSql := LV_sSql || ' ,c.tip_cobro)';
                LV_sSql := LV_sSql || ' FROM    pf_catalogo_ofertado_td a, ';
                LV_sSql := LV_sSql || ' pf_cargos_productos_td b, ';
                LV_sSql := LV_sSql || ' pf_conceptos_prod_td c, ';
                LV_sSql := LV_sSql || ' pf_productos_ofertados_td d, ';
                LV_sSql := LV_sSql || ' ge_monedas e, ';
                LV_sSql := LV_sSql || ' fa_conceptos f  ';
                LV_sSql := LV_sSql || ' WHERE a.cod_canal = '||EO_Catalogos.cod_canal;
                LV_sSql := LV_sSql || ' AND   '||EO_Catalogos.FEC_INICIO_VIGENCIA ||'>= a.fec_inicio_vigencia ';
                LV_sSql := LV_sSql || ' AND   TRUNC(a.fec_termino_vigencia) <= ' || EO_Catalogos.FEC_TERMINO_VIGENCIA;
                LV_sSql := LV_sSql || ' AND   a.cod_prod_ofertado = ' ||EO_Catalogos.cod_prod_ofertado;
                LV_sSql := LV_sSql || ' AND     a.COD_PROD_OFERTADO = d.cod_prod_ofertado ';
                LV_sSql := LV_sSql || ' AND     a.cod_cargo = b.cod_cargo ';
                LV_sSql := LV_sSql || ' AND     a.cod_concepto = c.cod_concepto ';
                LV_sSql := LV_sSql || ' AND     d.COD_PROD_OFERTADO = c.COD_PROD_OFERTADO ';
                LV_sSql := LV_sSql || ' AND     b.COD_MONEDA = e.COD_MONEDA ';
                LV_sSql := LV_sSql || ' AND     c.COD_CONCEPTO = f.COD_CONCEPTO';

                    OPEN SO_Lista_Catalogos FOR
                        SELECT  a.cod_prod_ofertado,
                                a.cod_cargo,
                                b.ID_CARGO,
                                a.cod_concepto,
                                f.des_concepto,
                                b.monto_importe,
                                b.cod_moneda,
                                e.DES_MONEDA,
                                c.ind_prorrateable,
                                c.tipo_cargo,
                                c.tip_cobro
                        FROM    pf_catalogo_ofertado_td a,
                                pf_cargos_productos_td b,
                                pf_conceptos_prod_td c,
                                pf_productos_ofertados_td d,
                                ge_monedas e,
                                fa_conceptos f
                        WHERE   a.cod_canal = EO_Catalogos.cod_canal
                        AND     EO_Catalogos.FEC_INICIO_VIGENCIA >= a.fec_inicio_vigencia
                        AND     TRUNC(a.fec_termino_vigencia) <=  TRUNC(EO_Catalogos.FEC_TERMINO_VIGENCIA)
                        AND     a.cod_prod_ofertado = EO_Catalogos.cod_prod_ofertado
                        AND        a.COD_PROD_OFERTADO = d.cod_prod_ofertado
                        AND        a.cod_cargo = b.cod_cargo
                        AND        a.cod_concepto = c.cod_concepto
                        AND        d.COD_PROD_OFERTADO = c.COD_PROD_OFERTADO
                        AND        b.COD_MONEDA = e.COD_MONEDA
                        AND        c.COD_CONCEPTO = f.COD_CONCEPTO;
                END IF;

--           ELSE
--                IF EO_Catalogos IS NULL THEN
--                  RAISE ERROR_PARAMETROS;
--                ELSE
--                LV_sSql := 'SELECT  a.cod_prod_ofertado, ';
--                LV_sSql := LV_sSql || ' a.cod_cargo, ';
--                LV_sSql := LV_sSql || ' b.ID_CARGO, ';
--                LV_sSql := LV_sSql || ' a.cod_concepto, ';
--                LV_sSql := LV_sSql || ' f.des_concepto, ';
--                LV_sSql := LV_sSql || ' b.monto_importe, ';
--                LV_sSql := LV_sSql || ' b.cod_moneda, ';
--                LV_sSql := LV_sSql || ' e.DES_MONEDA, ';
--                LV_sSql := LV_sSql || ' c.ind_prorrateable, ';
--                LV_sSql := LV_sSql || ' c.tipo_cargo ';
--                LV_sSql := LV_sSql || ' ,c.tip_cobro)';
--                LV_sSql := LV_sSql || ' FROM    pf_catalogo_ofertado_td a, ';
--                LV_sSql := LV_sSql || ' pf_cargos_productos_td b, ';
--                LV_sSql := LV_sSql || ' pf_conceptos_prod_td c, ';
--                LV_sSql := LV_sSql || ' pf_productos_ofertados_td d, ';
--                LV_sSql := LV_sSql || ' ge_monedas e, ';
--                LV_sSql := LV_sSql || ' fa_conceptos f  ';
--                LV_sSql := LV_sSql || ' WHERE a.cod_canal = '||EO_Catalogos.cod_canal;
--                LV_sSql := LV_sSql || ' AND   '||EO_Catalogos.FEC_INICIO_VIGENCIA ||'>= a.fec_inicio_vigencia ';
--                LV_sSql := LV_sSql || ' AND   a.fec_termino_vigencia <= ' || EO_Catalogos.FEC_TERMINO_VIGENCIA;
--                LV_sSql := LV_sSql || ' AND   a.cod_prod_ofertado = ' ||EO_Catalogos.cod_prod_ofertado;
--                LV_sSql := LV_sSql || ' AND     a.COD_PROD_OFERTADO = d.cod_prod_ofertado ';
--                LV_sSql := LV_sSql || ' AND     a.cod_cargo = b.cod_cargo ';
--                LV_sSql := LV_sSql || ' AND     a.cod_concepto = c.cod_concepto ';
--                LV_sSql := LV_sSql || ' AND     d.COD_PROD_OFERTADO = c.COD_PROD_OFERTADO ';
--                LV_sSql := LV_sSql || ' AND     b.COD_MONEDA = e.COD_MONEDA ';
--                LV_sSql := LV_sSql || ' AND     c.COD_CONCEPTO = f.COD_CONCEPTO';

--                    OPEN SO_Lista_Catalogos FOR
--                        SELECT  a.cod_prod_ofertado,
--                                a.cod_cargo,
--                                b.ID_CARGO,
--                                a.cod_concepto,
--                                f.des_concepto,
--                                b.monto_importe,
--                                b.cod_moneda,
--                                e.DES_MONEDA,
--                                c.ind_prorrateable,
--                                c.tipo_cargo,
--                                c.tip_cobro
--                        FROM    pf_catalogo_ofertado_td a,
--                                pf_cargos_productos_td b,
--                                pf_conceptos_prod_td c,
--                                pf_productos_ofertados_td d,
--                                ge_monedas e,
--                                fa_conceptos f
--                        WHERE   a.cod_canal = EO_Catalogos.cod_canal
--                        AND     EO_Catalogos.FEC_INICIO_VIGENCIA >= a.fec_inicio_vigencia
--                        AND     a.fec_termino_vigencia <=  EO_Catalogos.FEC_TERMINO_VIGENCIA
--                        AND     a.cod_prod_ofertado = EO_Catalogos.cod_prod_ofertado
--                        AND        a.COD_PROD_OFERTADO = d.cod_prod_ofertado
--                        AND        a.cod_cargo = b.cod_cargo
--                        AND        a.cod_concepto = c.cod_concepto
--                        AND        d.COD_PROD_OFERTADO = c.COD_PROD_OFERTADO
--                        AND        b.COD_MONEDA = e.COD_MONEDA
--                        AND        c.COD_CONCEPTO = f.COD_CONCEPTO;
--                END IF;
--           END IF;

EXCEPTION
     WHEN ERROR_PARAMETROS THEN
          SN_cod_retorno := 98;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_DETALLE_S_PR(Lista Catalogos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_DETALLE_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 149;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_DETALLE_S_PR(Lista Catalogos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_DETALLE_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_DETALLE_S_PR(Lista Catalogos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_DETALLE_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PF_DETALLE_S_PR;

 PROCEDURE PF_CANAL_PRESTACION_S_PR (EO_Catalogos            IN          PF_CATALOGO_OFER_TD_QT,
                                     EN_Num_Abonado         IN          GA_ABOCEL.num_abonado%type,
                                     SO_Lista_Catalogos  OUT NOCOPY    refCursor,
                                     SN_cod_retorno      OUT NOCOPY  ge_errores_pg.coderror,
                                     SV_mens_retorno     OUT NOCOPY  ge_errores_pg.msgerror,
                                     SN_num_evento       OUT NOCOPY    ge_errores_pg.evento)
    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PF_CANAL_PRESTACION_S_PR"
          Lenguaje="PL/SQL"
          Fecha="18-05-2010"
          Versión="La del package"
          Diseñador="Elizabeth Vera"
          Programador="Elizabeth Vera"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción>Obtiene lista productos con prestaciones asociadas</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
                <param nom="EN_Num_Abonado Tipo="NUMERICO">Código abonado/param>>
             </Entrada>
             <Salida>
                <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    v_cod_prestacion    VARCHAR2(5);
    ERROR_PARAMETROS EXCEPTION;

        BEGIN
            SN_cod_retorno     := 0;
            SV_mens_retorno := ' ';
            SN_num_evento     := 0;

    IF EO_Catalogos IS NULL THEN
             RAISE ERROR_PARAMETROS;
    ELSE

          IF EO_Catalogos.IND_NIVEL_APLICA IS NOT NULL THEN

                --obtiene cod_prestacion
                LV_sSql := 'SELECT COD_PRESTACION FROM GA_ABOCEL WHERE NUM_ABONADO = '||EN_Num_Abonado;

                SELECT COD_PRESTACION INTO v_cod_prestacion
                FROM GA_ABOCEL WHERE NUM_ABONADO = EN_Num_Abonado;


                LV_sSql := 'SELECT distinct A.COD_PROD_OFERTADO ';
                LV_sSql := LV_sSql || 'FROM PF_CATALOGO_OFERTADO_TD a, PF_PRODUCTOS_OFERTADOS_TD b, PS_ESPECPROD_PRESTACION_TD c  ';
                LV_sSql := LV_sSql || 'WHERE a.COD_CANAL = ' ||EO_Catalogos.COD_CANAL;
                LV_sSql := LV_sSql || 'AND '||EO_Catalogos.FEC_INICIO_VIGENCIA ||' >= A.FEC_INICIO_VIGENCIA ';
                LV_sSql := LV_sSql || 'AND A.FEC_TERMINO_VIGENCIA< = '|| trunc(EO_Catalogos.FEC_TERMINO_VIGENCIA);
                LV_sSql := LV_sSql || 'AND B.IND_NIVEL_APLICA =  ' ||EO_Catalogos.IND_NIVEL_APLICA;
                LV_sSql := LV_sSql || 'AND a.COD_PROD_OFERTADO = b.COD_PROD_OFERTADO ';
                LV_sSql := LV_sSql || 'AND b.COD_ESPEC_PROD = c.COD_ESPEC_PROD ';
                LV_sSql := LV_sSql || 'AND    c.COD_PRESTACION = '||v_cod_prestacion;

                OPEN SO_Lista_Catalogos FOR
                SELECT distinct A.COD_PROD_OFERTADO
                FROM   PF_CATALOGO_OFERTADO_TD a, PF_PRODUCTOS_OFERTADOS_TD b, PS_ESPECPROD_PRESTACION_TD c
                WHERE  a.COD_CANAL = EO_Catalogos.COD_CANAL
                AND    EO_Catalogos.FEC_INICIO_VIGENCIA >= A.FEC_INICIO_VIGENCIA
                AND    A.FEC_TERMINO_VIGENCIA >=  trunc(EO_Catalogos.FEC_TERMINO_VIGENCIA)
                AND    B.IND_NIVEL_APLICA = EO_Catalogos.IND_NIVEL_APLICA
                AND    a.COD_PROD_OFERTADO = b.COD_PROD_OFERTADO
                AND    b.COD_ESPEC_PROD = c.COD_ESPEC_PROD
                AND    c.COD_PRESTACION = v_cod_prestacion;

          END IF;
    END IF;

EXCEPTION
   WHEN ERROR_PARAMETROS THEN
          SN_cod_retorno := 98;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_CANAL_PRESTACION_S_PR(Lista Catalogos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_CANAL_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 1397;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_CANAL_PRESTACION_S_PR(Lista Catalogos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_CANAL_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_CANAL_PRESTACION_S_PR(Lista Catalogos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_CANAL_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PF_CANAL_PRESTACION_S_PR;


  PROCEDURE PF_ABONADOS_CLIENTE_S_PR (EN_Cod_Cliente     IN         GA_ABOCEL.cod_cliente%type,
                                     SO_Lista_Abonados   OUT NOCOPY    refCursor,
                                     SN_cod_retorno      OUT NOCOPY  ge_errores_pg.coderror,
                                     SV_mens_retorno     OUT NOCOPY  ge_errores_pg.msgerror,
                                     SN_num_evento       OUT NOCOPY    ge_errores_pg.evento)
  IS
      LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;

    BEGIN
        SN_cod_retorno     := 0;
           SV_mens_retorno := ' ';
           SN_num_evento     := 0;

                LV_sSql := 'SELECT NUM_ABONADO ';
                LV_sSql := LV_sSql || 'FROM GA_ABOCEL ';
                LV_sSql := LV_sSql || 'WHERE COD_CLIENTE = '||EN_Cod_Cliente||' ';
                LV_sSql := LV_sSql || 'AND COD_SITUACION NOT IN (BAA,BAP)';

                OPEN SO_Lista_Abonados FOR
                SELECT NUM_ABONADO
                    FROM GA_ABOCEL
                    WHERE COD_CLIENTE = EN_Cod_Cliente
                        AND COD_SITUACION NOT IN ('BAA','BAP');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 1397;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_ABONADOS_CLIENTE_S_PR(); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_CANAL_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_ABONADOS_CLIENTE_S_PR(); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CATALOGO_PG.PF_CANAL_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
  END PF_ABONADOS_CLIENTE_S_PR;


END PF_CATALOGO_PG;
/
SHOW ERRORS 