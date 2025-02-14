CREATE OR REPLACE PACKAGE BODY Ve_Validacion_Linea_Pg IS

       FUNCTION VE_convertir_FN (EB_valor IN BOOLEAN) RETURN PLS_INTEGER IS
           BEGIN
                IF EB_valor = TRUE THEN
                           RETURN CI_TRUE;
                        ELSE
                           RETURN CI_FALSE;
            END IF;
           END;

           PROCEDURE VE_existeserieabonado_PR(EV_seriesimcard    IN  ga_abocel.num_serie%TYPE,
                                                                                  SB_resultado      OUT NOCOPY BOOLEAN,
                                                                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

                                LV_esta           VARCHAR2(1);
                                LV_Sql      ge_errores_pg.vQuery;
                                LV_des_error ge_errores_pg.DesEvent;

                                BEGIN

                                        SN_num_evento:= 0;
                                        SN_cod_retorno:=0;
                                        SV_mens_retorno:='';

                                        LV_Sql:='SELECT 1 '
                                                        || 'FROM ga_abocel a '
                                                        || 'WHERE a.num_serie=' || EV_seriesimcard
                                                        || 'UNION SELECT 1 '
                                                        || 'FROM ga_aboamist b '
                                                        || 'WHERE b.num_serie=' || EV_seriesimcard;

                                        SELECT '1'
                                        INTO   LV_esta
                                        FROM   ga_abocel a
                                        WHERE  a.num_serie=EV_seriesimcard
                                        AND    a.cod_situacion <> CV_baja_abonado --Inc. 63120 Rodrigo Araneda 17-03-2008
                                        UNION
                                        SELECT '1'
                                        FROM   ga_aboamist b
                                        WHERE  b.num_serie=EV_seriesimcard
                                        AND    b.cod_situacion <> CV_baja_abonado; --Inc. 63120 Rodrigo Araneda 17-03-2008

                                        SB_resultado := TRUE;

                                        EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          SB_resultado := FALSE;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_existeserieabonado_FN(' || EV_seriesimcard || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_existeserieabonado_FN(' || EV_seriesimcard || ')', LV_Sql, SQLCODE, LV_des_error );

                                                          SB_resultado := FALSE;


                END VE_existeserieabonado_PR;

            PROCEDURE VE_existeserieabonado_PR(EV_seriesimcard IN  ga_abocel.num_serie%TYPE,
                                                                                   SN_resultado      OUT NOCOPY PLS_INTEGER,
                                                                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                        LB_aux BOOLEAN;
            BEGIN
                        VE_existeserieabonado_PR(EV_seriesimcard,LB_aux,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        SN_resultado := VE_convertir_FN(LB_aux);
                END VE_existeserieabonado_PR;

            PROCEDURE VE_serieterminalenabonado_PR(EV_serieterminal IN  ga_abocel.num_serie%TYPE,
                                                                                       SB_resultado      OUT NOCOPY BOOLEAN,
                                                                               SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                       SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                       SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

                                LV_esta           VARCHAR2(1);
                                LV_Sql      ge_errores_pg.vQuery;
                                LV_des_error ge_errores_pg.DesEvent;

                                BEGIN

                                        SN_num_evento:= 0;
                                        SN_cod_retorno:=0;
                                        SV_mens_retorno:='';

                                        LV_Sql:='SELECT 1 '
                                                        || 'FROM ga_abocel a '
                                                        || 'WHERE a.num_serie=' || EV_serieterminal
                                                        || '  AND a.cod_situacion =' || CV_baja_abonado
                                                        || 'UNION SELECT 1 '
                                                        || 'FROM ga_aboamist b '
                                                        || 'WHERE b.num_serie=' || EV_serieterminal
                                                        || '  AND b.cod_situacion =' || CV_baja_abonado;

                                        SELECT '1'
                                        INTO   LV_esta
                                        FROM   ga_abocel a
                                        WHERE  a.num_serie=EV_serieterminal
                                          AND  a.cod_situacion =CV_baja_abonado
                                        UNION
                                        SELECT '1'
                                        FROM   ga_aboamist b
                                        WHERE  b.num_serie=EV_serieterminal
                                          AND  b.cod_situacion =CV_baja_abonado;


                                        SB_resultado := TRUE;

                                        EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          SB_resultado := FALSE;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_serieterminalenabonado_PR(' || EV_serieterminal || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_serieterminalenabonado_PR(' || EV_serieterminal || ')', LV_Sql, SQLCODE, LV_des_error );

                                                          SB_resultado := FALSE;


                END VE_serieterminalenabonado_PR;


        PROCEDURE VE_existeimeienabonado_PR    (EV_serieterminal IN  ga_abocel.num_imei%TYPE,
                                                                                    SB_resultado      OUT NOCOPY BOOLEAN,
                                                                            SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

                                LV_esta           VARCHAR2(1);
                                LV_Sql      ge_errores_pg.vQuery;
                                LV_des_error ge_errores_pg.DesEvent;
                                EV_SITUACION VARCHAR2(3);

                                BEGIN
                                    EV_situacion:='BAA';
                                        SN_num_evento:= 0;
                                        SN_cod_retorno:=0;
                                        SV_mens_retorno:='';

                                        LV_Sql:='SELECT 1 '
                                                        || 'FROM ga_abocel a '
                                                        || 'WHERE a.num_imei=' || EV_serieterminal
                                                        || '  AND a.cod_situacion <>' || EV_situacion
                                                        || 'UNION SELECT 1 '
                                                        || 'FROM ga_aboamist b '
                                                        || 'WHERE b.num_imei=' || EV_serieterminal
                                                        || '  AND b.cod_situacion <>' || EV_situacion;

                                        SELECT '1'
                                        INTO   LV_esta
                                        FROM   ga_abocel a
                                        WHERE  a.num_imei=EV_serieterminal
                                          AND  a.cod_situacion <> EV_situacion
                                        UNION
                                        SELECT '1'
                                        FROM   ga_aboamist b
                                        WHERE  b.num_imei=EV_serieterminal
                                          AND  b.cod_situacion <> EV_situacion;


                                        SB_resultado := TRUE;

                                        EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          SB_resultado := FALSE;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_existeiccenabonado_PR(' || EV_serieterminal || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_existeiccenabonado_PR(' || EV_serieterminal || ')', LV_Sql, SQLCODE, LV_des_error );

                                                          SB_resultado := FALSE;


                END VE_existeimeienabonado_PR;


                PROCEDURE VE_existeimeienabonado_PR(EV_serieterminal IN  ga_abocel.num_imei%TYPE,
                                                                                    SN_resultado      OUT NOCOPY PLS_INTEGER,
                                                                            SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                        LB_aux BOOLEAN;
            BEGIN
                        VE_existeimeienabonado_PR(EV_serieterminal,LB_aux,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        SN_resultado := VE_convertir_FN(LB_aux);
                END VE_existeimeienabonado_PR;

                PROCEDURE VE_serieterminalenabonado_PR(EV_serieterminal  IN  ga_abocel.num_serie%TYPE,
                                                                                       SN_resultado      OUT NOCOPY PLS_INTEGER,
                                                                               SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                       SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                       SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                        LB_aux BOOLEAN;
            BEGIN
                        VE_serieterminalenabonado_PR(EV_serieterminal,LB_aux,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        SN_resultado := VE_convertir_FN(LB_aux);
                END VE_serieterminalenabonado_PR;

                PROCEDURE VE_existeseriebodega_PR(EV_serie              IN  al_series.num_serie%TYPE,
                                                                                  SB_resultado      OUT NOCOPY BOOLEAN,
                                                                                  SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

                        LV_Sql      ge_errores_pg.vQuery;
                        LV_des_error ge_errores_pg.DesEvent;
                        LV_resultado  VARCHAR2(1);

                        BEGIN

                                SN_num_evento:= 0;
                                SN_cod_retorno:=0;
                                SV_mens_retorno:='';

                                SB_resultado := FALSE;
                                LV_resultado:= '0';


                                LV_Sql:= 'SELECT 1'
                                                 || ' FROM   al_series series, al_articulos articulos'
                                                 || ' WHERE series.num_serie=' || EV_serie
                                                 || ' AND series.cod_articulo = articulos.cod_articulo';

                                SELECT '1'
                                INTO   LV_resultado
                                FROM   al_series series, al_articulos articulos
                                WHERE  series.num_serie = EV_serie
                                AND    series.cod_articulo = articulos.cod_articulo;

                        SB_resultado := TRUE;


                                EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          SN_cod_retorno:=1;
                                                          SB_resultado := FALSE;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                                          SB_resultado := FALSE;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_existeseriebodega_PR(' || EV_serie || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_existeseriebodega_PR(' || EV_serie || ')', LV_Sql, SQLCODE, LV_des_error );
                                                          SB_resultado := FALSE;

                END VE_existeseriebodega_PR;

                PROCEDURE VE_existeseriebodega_PR(EV_serie               IN  al_series.num_serie%TYPE,
                                                                                  SN_resultado       OUT NOCOPY PLS_INTEGER,
                                                                                  SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
                LB_aux BOOLEAN;
            BEGIN
                        VE_existeseriebodega_PR(EV_serie,LB_aux,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        SN_resultado := VE_convertir_FN(LB_aux);

                END VE_existeseriebodega_PR;


            PROCEDURE VE_vendedorbodega_PR(EV_codvendedor       IN  ve_vendedores.cod_vendedor%TYPE,
                                                                           EV_codbodega         IN  al_series.cod_bodega%TYPE,
                                                                   SB_resultado     OUT NOCOPY BOOLEAN,
                                                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS

                        LV_Sql      ge_errores_pg.vQuery;
                        LV_des_error ge_errores_pg.DesEvent;
                        LV_esta           VARCHAR2(1);

                        BEGIN

                                SN_num_evento:= 0;
                                SN_cod_retorno:=0;
                                SV_mens_retorno:='';

                                LV_Sql:='SELECT 1 FROM ve_vendalmac '
                                                || 'WHERE cod_vendedor=' || EV_codvendedor
                                                || ' AND cod_bodega=' || EV_codbodega
                                                || ' AND SYSDATE BETWEEN fec_asignacion AND nvl(fec_desasignac, SYSDATE)';


                                SELECT '1' INTO LV_esta
                                FROM   ve_vendalmac
                                WHERE  cod_vendedor=EV_codvendedor
                                           AND cod_bodega=EV_codbodega
                                           AND SYSDATE BETWEEN fec_asignacion
                                           AND NVL(fec_desasignac, SYSDATE);

                                SB_resultado := TRUE;

                                EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          SB_resultado := FALSE;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_vendedorbodega_FN(' || EV_codvendedor || ',' || EV_codbodega || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_vendedorbodega_FN(' || EV_codvendedor || ',' || EV_codbodega || ')', LV_Sql, SQLCODE, LV_des_error );

                                                          SB_resultado := FALSE;

                END VE_vendedorbodega_PR;

            PROCEDURE VE_vendedorbodega_PR(EV_codvendedor          IN  ve_vendedores.cod_vendedor%TYPE,
                                                                           EV_codbodega            IN  al_series.cod_bodega%TYPE,
                                                                   SN_resultado        OUT NOCOPY PLS_INTEGER,
                                                                       SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) IS
                        LB_aux BOOLEAN;
            BEGIN
                        VE_vendedorbodega_PR(EV_codvendedor,EV_codbodega,LB_aux,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        SN_resultado := VE_convertir_FN(LB_aux);
                END VE_vendedorbodega_PR;

            PROCEDURE VE_terminallistanegra_PR(EV_serieterminal  IN  ga_abocel.num_serie%TYPE,
                                                                                  SB_resultado      OUT NOCOPY BOOLEAN,
                                                                                  SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

                        LV_Sql      ge_errores_pg.vQuery;
                        LV_des_error ge_errores_pg.DesEvent;
                        LV_esta           VARCHAR2(1);

                        BEGIN

                                SN_num_evento:= 0;
                                SN_cod_retorno:=0;
                                SV_mens_retorno:='';

                                 LV_sql:='SELECT 1 FROM ga_lncelu a '
                                                 || 'WHERE      a.num_serie=' || EV_serieterminal;

                                 SELECT '1' INTO LV_esta
                                 FROM ga_lncelu a
                                 WHERE  a.num_serie=EV_serieterminal;

                                 SB_resultado := TRUE;

                                 EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          SB_resultado := FALSE;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_terminallistanegra_FN(' || EV_serieterminal || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_terminallistanegra_FN(' || EV_serieterminal || ')', LV_Sql, SQLCODE, LV_des_error );

                                                          SB_resultado := FALSE;


                END VE_terminallistanegra_PR;

            PROCEDURE VE_terminallistanegra_PR(EV_serieterminal  IN  ga_abocel.num_serie%TYPE,
                                                                                  SN_resultado      OUT NOCOPY PLS_INTEGER,
                                                                                  SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                        LB_aux BOOLEAN;
            BEGIN
                        VE_terminallistanegra_PR(EV_serieterminal,LB_aux,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        SN_resultado := VE_convertir_FN(LB_aux);
                END VE_terminallistanegra_PR;

                PROCEDURE VE_existe_plan_tarifario_PR(EV_plantarif      IN ta_plantarif.cod_plantarif%TYPE,
                                                      EN_codproducto    IN ga_modvent_aplic.cod_producto%TYPE,
                                                                                          EV_tecnologia     IN al_tecnologia.cod_tecnologia%TYPE,
                                                                                          SB_resultado      OUT NOCOPY BOOLEAN,
                                                                                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

                LV_Sql      ge_errores_pg.vQuery;
                LV_des_error ge_errores_pg.DesEvent;
        LV_resultado  VARCHAR2(1);

                BEGIN


                         SN_num_evento:= 0;
                         SN_cod_retorno:=0;
                         SV_mens_retorno:='';

                         LV_sql:= 'SELECT decode(max(cargosbasicos.FEC_DESDE),NULL,0,1)'
                                  || ' FROM ta_plantarif plantarifario, ta_cargosbasico cargosbasicos'
                                          || ' WHERE plantarifario.cod_plantarif= ' || EV_plantarif
                                          || ' AND SYSDATE BETWEEN plantarifario.fec_desde '
                                          || ' AND NVL(plantarifario.fec_hasta, SYSDATE)'
                                          || ' AND plantarifario.cod_cargobasico= cargosbasicos.cod_cargobasico '
                                          || ' AND plantarifario.cod_producto =' || EN_codproducto
                                          || ' AND SYSDATE BETWEEN cargosbasicos.fec_desde '
                                          || ' AND NVL(cargosbasicos.fec_hasta, SYSDATE)'
                                          || ' AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif'
                                          || ' AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto'
                                          || ' AND relserviciotecnoplantarif.cod_tecnologia =' || EV_tecnologia;

                         SELECT decode(max(cargosbasicos.FEC_DESDE),NULL,'0','1')
                         INTO   LV_resultado
                         FROM   ta_plantarif plantarifario, ta_cargosbasico cargosbasicos,
                                ga_plantecplserv relserviciotecnoplantarif
                         WHERE  plantarifario.cod_plantarif= EV_plantarif
                                        AND SYSDATE BETWEEN plantarifario.fec_desde
                                        AND NVL(plantarifario.fec_hasta, SYSDATE)
                                        AND plantarifario.cod_cargobasico= cargosbasicos.cod_cargobasico
                                        AND plantarifario.cod_producto = EN_codproducto
                                        AND SYSDATE BETWEEN cargosbasicos.fec_desde
                                        AND NVL(cargosbasicos.fec_hasta, SYSDATE)
                                        AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif
                                        AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto
                                        AND relserviciotecnoplantarif.cod_tecnologia = EV_tecnologia;

                         IF (LV_resultado = '1') THEN
                                SB_resultado:= TRUE;
                         ELSE
                                SB_resultado:= FALSE;
                         END IF;

                         EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          SB_resultado:= FALSE;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validaarchivo_PR.VE_existe_plan_tarifario_FN(' ||EV_plantarif||','||EN_codproducto||','||EV_tecnologia|| ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_existe_plan_tarifario_PR(' || EV_plantarif || ')', LV_Sql, SQLCODE, LV_des_error );

                                                          SB_resultado:= FALSE;


                END VE_existe_plan_tarifario_PR;

                PROCEDURE VE_existe_plan_tarifario_PR(EV_plantarif      IN ta_plantarif.cod_plantarif%TYPE,
                                                  EN_codproducto        IN ga_modvent_aplic.cod_producto%TYPE,
                                                                                          EV_tecnologia     IN al_tecnologia.cod_tecnologia%TYPE,
                                                                                          SN_resultado      OUT NOCOPY PLS_INTEGER,
                                                                                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                        LB_aux BOOLEAN;
            BEGIN
                        VE_existe_plan_tarifario_PR(EV_plantarif, EN_codproducto, EV_tecnologia, LB_aux,
                        SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                        SN_resultado := VE_convertir_FN(LB_aux);
                END VE_existe_plan_tarifario_PR;

----------------------------------------------------------------------------------------

PROCEDURE VE_existe_plan_tarifario_PR(EV_plantarif      IN ta_plantarif.cod_plantarif%TYPE,
                                      EN_codproducto	IN ga_modvent_aplic.cod_producto%TYPE,
                                      EV_tecnologia     IN al_tecnologia.cod_tecnologia%TYPE,
                                      EN_CodCliente     IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                      SB_resultado      OUT NOCOPY BOOLEAN,
                                      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
/*--
<Documentacion TipoDoc = "Procedimiento">
   Elemento Nombre = "VE_existe_plan_tarifario_PR" 
   Lenguaje="PL/SQL"
   Fecha="20-05-2008"
   Version="1.0.0"
   Dise?ador="Nicolas Contreras/wjrc" 
   Programador="Nicolas Contreras/wjrc"  
   Ambiente="BD" 
<Retorno>NA</Retorno> 
<Descripcion>
   Consulta datos de una serie especifica 
</Descripcion>
<Parametros>
<Entrada>
   <param nom="EV_plantarif"   Tipo="STRING"> codigo plan tarifario a consultar</param>
   <param nom="EN_codproducto" Tipo="NUMBER"> codigo producto</param>
   <param nom="EV_tecnologia"  Tipo="STRING"> codigo tecnologia</param>
   <param nom="EN_CodCliente"  Tipo="NUMBER"> codigo del cliente</param>
</Entrada>
<Salida>
        <param nom="SB_resultado"    Tipo="BOOLEAN"> resultado de la operacion</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
</Salida>
</Parametros>
</Elemento>
</Documentacion>
--*/
    LV_Sql            ge_errores_pg.vQuery;
    LV_des_error      ge_errores_pg.DesEvent;
    LV_resultado      VARCHAR2(1);
    LV_CodTipident    GE_TIPIDENT.COD_TIPIDENT%TYPE;  
    LV_NumIdent       GE_CLIENTES.NUM_IDENT%TYPE;
    LV_CodRestriccion ERD_EXCEPCION.COD_RESTRIC%TYPE; 
BEGIN
    SN_num_evento   := 0;
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
             
    SELECT COD_TIPIDENT,NUM_IDENT
    INTO   LV_CodTipident,LV_NumIdent 
    FROM GE_CLIENTES 
    WHERE COD_CLIENTE = EN_CodCliente;
             
    SELECT NVL(COD_RESTRIC,5) 
    INTO LV_CodRestriccion 
    FROM ERD_EXCEPCION 
    WHERE COD_TIPIDENT = LV_CodTipident
    AND NUM_IDENT = LV_NumIdent
    AND SYSDATE BETWEEN FEC_DESDE_H AND FEC_HASTA_H;

dbms_output.put_line('RESTRICCION : ' || LV_codRestriccion);
             
    IF LV_codRestriccion IS NOT NULL THEN 
        
       IF LV_CodRestriccion= 0 THEN 
       -- Planes comercializables y no comercializables 
	           
          LV_sql := 'SELECT decode(max(cargosbasicos.FEC_DESDE),NULL,0,1)'
                 || ' FROM ta_plantarif plantarifario, ta_cargosbasico cargosbasicos'
                 || ' WHERE plantarifario.cod_plantarif= ' || EV_plantarif
                 || ' AND plantarifario.cod_cargobasico= cargosbasicos.cod_cargobasico '
                 || ' AND plantarifario.cod_producto =' || EN_codproducto
                 || ' AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif'
                 || ' AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto'
                 || ' AND relserviciotecnoplantarif.cod_tecnologia =' || EV_tecnologia;
               
          SELECT decode(max(cargosbasicos.FEC_DESDE),NULL,'0','1')
          INTO   LV_resultado
          FROM   ta_plantarif plantarifario, ta_cargosbasico cargosbasicos,
                 ga_plantecplserv relserviciotecnoplantarif
          WHERE plantarifario.cod_plantarif= EV_plantarif
            AND plantarifario.cod_cargobasico= cargosbasicos.cod_cargobasico
            AND plantarifario.cod_producto = EN_codproducto
            AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif
            AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto
            AND relserviciotecnoplantarif.cod_tecnologia = EV_tecnologia;
               
          IF (LV_resultado = '1') THEN
              SB_resultado:= TRUE;
          ELSE
             SB_resultado:= FALSE;
          END IF;
               
       ELSIF LV_CodRestriccion = 1 or LV_CodRestriccion = 5  THEN 
       -- Planes comercializables 
	                    
             LV_sql := 'SELECT decode(max(cargosbasicos.FEC_DESDE),NULL,0,1)'
                    || ' FROM ta_plantarif plantarifario, ta_cargosbasico cargosbasicos'
                    || ' WHERE plantarifario.cod_plantarif= ' || EV_plantarif
                    || ' AND SYSDATE BETWEEN plantarifario.fec_desde '
                    || ' AND NVL(plantarifario.fec_hasta, SYSDATE)'
                    || ' AND plantarifario.cod_cargobasico= cargosbasicos.cod_cargobasico '
                    || ' AND plantarifario.cod_producto =' || EN_codproducto
                    || ' AND SYSDATE BETWEEN cargosbasicos.fec_desde '
                    || ' AND NVL(cargosbasicos.fec_hasta, SYSDATE)'
                    || ' AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif'
                    || ' AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto'
                    || ' AND relserviciotecnoplantarif.cod_tecnologia =' || EV_tecnologia;

             SELECT decode(max(cargosbasicos.FEC_DESDE),NULL,'0','1')
             INTO 	LV_resultado
             FROM   ta_plantarif plantarifario, ta_cargosbasico cargosbasicos,
                    ga_plantecplserv relserviciotecnoplantarif
             WHERE	plantarifario.cod_plantarif= EV_plantarif
               AND SYSDATE BETWEEN plantarifario.fec_desde
               AND NVL(plantarifario.fec_hasta, SYSDATE) 
               AND plantarifario.cod_cargobasico= cargosbasicos.cod_cargobasico
               AND plantarifario.cod_producto = EN_codproducto
               AND SYSDATE BETWEEN cargosbasicos.fec_desde
               AND NVL(cargosbasicos.fec_hasta, SYSDATE)
               AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif
               AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto
               AND relserviciotecnoplantarif.cod_tecnologia = EV_tecnologia; 
                                 
             IF (LV_resultado = '1') THEN
                 SB_resultado:= TRUE;
             ELSE
                 SB_resultado:= FALSE;
             END IF;
           
       ELSIF LV_CodRestriccion = 2 THEN 
       -- Planes no comercializables 
	             
             LV_sql := 'SELECT decode(max(cargosbasicos.FEC_DESDE),NULL,0,1)'
                    || ' FROM ta_plantarif plantarifario, ta_cargosbasico cargosbasicos'
                    || ' WHERE plantarifario.cod_plantarif= ' || EV_plantarif
                    || ' AND NOT (SYSDATE BETWEEN plantarifario.fec_desde '
                    || ' AND NVL(plantarifario.fec_hasta, SYSDATE))'
                    || ' AND plantarifario.cod_cargobasico= cargosbasicos.cod_cargobasico '
                    || ' AND plantarifario.cod_producto =' || EN_codproducto
                    || ' AND NOT (SYSDATE BETWEEN cargosbasicos.fec_desde '
                    || ' AND NVL(cargosbasicos.fec_hasta, SYSDATE))'
                    || ' AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif'
                    || ' AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto'
                    || ' AND relserviciotecnoplantarif.cod_tecnologia =' || EV_tecnologia;

             SELECT decode(max(cargosbasicos.FEC_DESDE),NULL,'0','1')
             INTO 	LV_resultado
             FROM   ta_plantarif plantarifario, 
			        ta_cargosbasico cargosbasicos,
                    ga_plantecplserv relserviciotecnoplantarif
             WHERE	plantarifario.cod_plantarif= EV_plantarif
               AND NOT (SYSDATE BETWEEN plantarifario.fec_desde AND NVL(plantarifario.fec_hasta, SYSDATE))
               AND plantarifario.cod_cargobasico= cargosbasicos.cod_cargobasico
               AND plantarifario.cod_producto = EN_codproducto
               AND NOT (SYSDATE BETWEEN cargosbasicos.fec_desde AND NVL(cargosbasicos.fec_hasta, SYSDATE))
               AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif
               AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto
               AND relserviciotecnoplantarif.cod_tecnologia = EV_tecnologia; 


             IF (LV_resultado = '1') THEN
                 SB_resultado:= TRUE; 
             ELSE
                 SB_resultado:= FALSE;
             END IF; 
                         
       END IF;
        
    END IF;

dbms_output.put_line(substr(LV_sql,1,250));
dbms_output.put_line(substr(LV_sql,251,250));
dbms_output.put_line(substr(LV_sql,752,250));
dbms_output.put_line(substr(LV_sql,1003,250));
dbms_output.put_line(substr(LV_sql,1254,250));
dbms_output.put_line(substr(LV_sql,1505,250));
             
EXCEPTION
     WHEN NO_DATA_FOUND THEN
          SB_resultado:= FALSE;
          LV_des_error:='NO_DATA_FOUND:VE_validaarchivo_PR.VE_existe_plan_tarifario_FN(' ||EV_plantarif||','||EN_codproducto||','||EV_tecnologia|| ');- ' || SQLERRM;
          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
          'VE_validacion_linea_PG.VE_existe_plan_tarifario_PR(' || EV_plantarif || ')', LV_Sql, SQLCODE, LV_des_error );
     WHEN OTHERS THEN
          SN_cod_retorno:=156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno:=CV_error_no_clasif;
          END IF;
          LV_des_error:='OTHERS:VE_validaarchivo_PR.VE_existe_plan_tarifario_FN(' ||EV_plantarif||','||EN_codproducto||','||EV_tecnologia|| ');- ' || SQLERRM;
          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
          'VE_validacion_linea_PG.VE_existe_plan_tarifario_PR(' || EV_plantarif || ')', LV_Sql, SQLCODE, LV_des_error );
          SB_resultado:= FALSE;
END VE_existe_plan_tarifario_PR;

----------------------------------------------------------------------------------------

PROCEDURE VE_existe_plan_tarifario_PR(EV_plantarif      IN ta_plantarif.cod_plantarif%TYPE,
                                      EN_codproducto    IN ga_modvent_aplic.cod_producto%TYPE,
                                      EV_tecnologia     IN al_tecnologia.cod_tecnologia%TYPE,
                                      EN_CodCliente     IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                      SN_resultado      OUT NOCOPY PLS_INTEGER,
                                      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
/*--
<Documentacion TipoDoc = "Procedimiento">
   Elemento Nombre = "VE_existe_plan_tarifario_PR" 
   Lenguaje="PL/SQL" 
   Fecha="20-05-2008" 
   Version="1.0.0"
   Diseñador="Nicolas Contreras/wjrc" 
   Programador="Nicolas Contreras/wjrc"  
   Ambiente="BD"
<Retorno>NA</Retorno>
<Descripcion>
   Convierte la salida boolean a integer
</Descripcion>
<Parametros>
<Entrada>
   <param nom="EV_plantarif"   Tipo="STRING"> codigo plan tarifario a consultar</param>
   <param nom="EN_codproducto" Tipo="NUMBER"> codigo producto</param>
   <param nom="EV_tecnologia"  Tipo="STRING"> codigo tecnologia</param>
   <param nom="EN_CodCliente"  Tipo="NUMBER"> codigo del cliente</param>
</Entrada>
<Salida>
   <param nom="SN_resultado"    Tipo="NUMBER"> resultado de la operacion</param>
   <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
   <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
   <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
</Salida>
</Parametros>
</Elemento>
</Documentacion>
--*/
    LB_aux BOOLEAN;
BEGIN
    VE_existe_plan_tarifario_PR(EV_plantarif, 
	                            EN_codproducto, 
								EV_tecnologia,
								EN_CodCliente,
								LB_aux,
								SN_cod_retorno, 
								SV_mens_retorno, 
								SN_num_evento);
    SN_resultado := VE_convertir_FN(LB_aux);
END VE_existe_plan_tarifario_PR;
				
----------------------------------------------------------------------------------------

                FUNCTION VE_existe_vendedor_FN(EV_cod_vendedor  IN ve_vendedores.cod_vendedor%TYPE,
                                                                           EV_ind_interno       OUT NOCOPY ve_vendedores.ind_interno%TYPE,
                                                                           SV_cod_cliente       OUT NOCOPY ve_vendedores.cod_cliente%TYPE,
                                                                           SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) RETURN BOOLEAN IS
                LV_Sql      ge_errores_pg.vQuery;
                LV_des_error ge_errores_pg.DesEvent;

                BEGIN

                         SN_num_evento:= 0;
                         SN_cod_retorno:=0;
                         SV_mens_retorno:='';

                         LV_Sql:='SELECT a.ind_interno, a.cod_cliente '
                                         || 'FROM       ve_vendedores a'
                                         || 'WHERE  a.cod_vendedor=' || EV_cod_vendedor
                                         ||     'AND SYSDATE BETWEEN a.fec_contrato '
                                         ||     'AND NVL(a.fec_fincontrato, SYSDATE)';

                         SELECT a.ind_interno, a.cod_cliente
                         INTO   EV_ind_interno, SV_cod_cliente
                         FROM   ve_vendedores a
                         WHERE  a.cod_vendedor=EV_cod_vendedor
                                        AND SYSDATE BETWEEN a.fec_contrato
                                        AND NVL(a.fec_fincontrato, SYSDATE);

                         RETURN TRUE;

                         EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          RETURN FALSE;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_existe_vendedor_FN(' || EV_cod_vendedor || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_existe_vendedor_FN(' || EV_cod_vendedor || ')', LV_Sql, SQLCODE, LV_des_error );

                                                          RETURN FALSE;


                END VE_existe_vendedor_FN;

                PROCEDURE VE_existe_evaluacion_riesgo_PR(EV_numident        IN ge_clientes.num_ident%TYPE,
                                                                                                 EV_tipident            IN ge_clientes.cod_tipident%TYPE,
                                                                                                 EN_tipo_solicitud      IN ERT_SOLICITUD.ind_tipo_solicitud%TYPE,
                                                                                                 EN_ind_evento          IN ERT_SOLICITUD.ind_evento%TYPE,
                                                                                                 EV_cod_estado          IN VARCHAR2,
                                                                                                 EV_tipocliente     IN VARCHAR2,
                                                                                                 SB_resultado       OUT NOCOPY BOOLEAN,
                                                                                                 SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento          OUT NOCOPY ge_errores_pg.Evento) IS
        LV_Parametros   ARRAY_PARAMETROS_;
                LV_Sql      ge_errores_pg.vQuery;
                LV_des_error ge_errores_pg.DesEvent;
                LV_esta         VARCHAR2(1);
                LV_valparametro ged_parametros.val_parametro%TYPE;
                BEGIN

                        SN_num_evento:= 0;
                        SN_cod_retorno:=0;
                        SV_mens_retorno:='';
                        IF EV_tipocliente = 'I' THEN
                            Ve_Intermediario_Pg.VE_obtiene_valor_parametro_PR('VIGENCIA_DAT_EXTERNA',CV_codmodulo,CV_codproducto,LV_valparametro,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                            LV_Sql:='SELECT 1'
                                        || ' FROM ert_solicitud a, ert_datos_consulta_to datos_evaluacion'
                                            || ' WHERE  a.num_ident_cliente = :EV_numident '
                                            || ' AND a.cod_tipident = :EV_tipident '
                                            || ' AND a.ind_tipo_solicitud = :EV_tipo_solicitud'
                                            || ' AND a.ind_evento = :EV_ind_evento'
                                            || ' AND a.cod_estado IN(:par1,:par2)'
                        || ' AND a.num_ident_cliente =  datos_evaluacion.num_ident'
                        || ' AND a.ind_tipo_solicitud =  datos_evaluacion.ind_tipo_solicitud'
                        || ' AND SYSDATE <  datos_evaluacion.fecha_actualizacion + :LV_valparametro';


                        LV_Parametros(1):= SUBSTR(EV_cod_estado,2,1);
                        LV_Parametros(2):= SUBSTR(EV_cod_estado,6,1);
                        EXECUTE IMMEDIATE LV_Sql INTO LV_esta USING IN EV_numident, EV_tipident, EN_tipo_solicitud, EN_ind_evento,LV_Parametros(1),LV_Parametros(2),LV_valparametro;
                        ELSE
                            LV_Sql:='SELECT 1'
                                        || ' FROM ert_solicitud a'
                                            || ' WHERE  a.num_ident_cliente = :EV_numident '
                                            || ' AND a.cod_tipident = :EV_tipident '
                                            || ' AND a.ind_tipo_solicitud = :EV_tipo_solicitud'
                                            || ' AND a.ind_evento = :EV_ind_evento'
                                            || ' AND a.cod_estado IN(:par1,:par2)';
                        LV_Parametros(1):= SUBSTR(EV_cod_estado,2,1);
                        LV_Parametros(2):= SUBSTR(EV_cod_estado,6,1);
                        EXECUTE IMMEDIATE LV_Sql INTO LV_esta USING IN EV_numident, EV_tipident, EN_tipo_solicitud, EN_ind_evento,LV_Parametros(1),LV_Parametros(2);
                        END IF;
                        SB_resultado:= TRUE;


                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                    SB_resultado:= FALSE;
                                WHEN OTHERS THEN
                                    SN_cod_retorno:=156;
                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                           SV_mens_retorno:=CV_error_no_clasif;
                                    END IF;
                                    LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_existe_evaluacion_riesgo_PR(' ||EV_numident||','
                                  ||EV_tipident||','||EN_tipo_solicitud||','||EN_ind_evento||','
                                                                  ||EV_cod_estado||','||EV_tipocliente || ');- ' || SQLERRM;
                                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                    'VE_validacion_linea_PG.VE_existe_evaluacion_riesgo_PR(' || EV_numident || ',' || EN_tipo_solicitud || ',' || EV_cod_estado || ')', LV_Sql, SQLCODE, LV_des_error );
                                        SB_resultado:= FALSE;
                                        SV_mens_retorno:=LV_Sql;


                END VE_existe_evaluacion_riesgo_PR;

                PROCEDURE VE_existe_evaluacion_riesgo_PR(EV_numident            IN ge_clientes.num_ident%TYPE,
                                                                                                 EV_tipident                    IN ge_clientes.cod_tipident%TYPE,
                                                                                                 EN_tipo_solicitud              IN ERT_SOLICITUD.ind_tipo_solicitud%TYPE,
                                                                                                 EN_ind_evento                  IN ERT_SOLICITUD.ind_evento%TYPE,
                                                                                                 EV_cod_estado                  IN VARCHAR2,
                                                                                                 EV_tipocliente         IN VARCHAR2,
                                                                                                 SN_resultado           OUT NOCOPY PLS_INTEGER,
                                                                                                 SN_cod_retorno                 OUT NOCOPY ge_errores_pg.CodError,
                                                                 SV_mens_retorno                OUT NOCOPY ge_errores_pg.MsgError,
                                                                 SN_num_evento                  OUT NOCOPY ge_errores_pg.Evento) IS

                    LB_aux BOOLEAN;
            BEGIN
                        VE_existe_evaluacion_riesgo_PR(EV_numident,EV_tipident,EN_tipo_solicitud,EN_ind_evento,EV_cod_estado, EV_tipocliente, LB_aux, SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        SN_resultado := VE_convertir_FN(LB_aux);
                END VE_existe_evaluacion_riesgo_PR;


                PROCEDURE VE_existe_eriesgo_ptarif_PR(EV_numident               IN ge_clientes.num_ident%TYPE,
                                                                                          EV_tipident                   IN ge_clientes.cod_tipident%TYPE,
                                                                                          EN_tipo_solicitud         IN ERT_SOLICITUD.ind_tipo_solicitud%TYPE,
                                                                                          EN_ind_evento             IN ERT_SOLICITUD.ind_evento%TYPE,
                                                                                          EV_cod_estado             IN VARCHAR2,
                                                                                          EV_plantarif              IN ert_solicitud_planes.cod_plantarif%TYPE,
                                                                                          SB_resultado          OUT NOCOPY BOOLEAN,
                                                                                          SN_cod_retorno        OUT NOCOPY ge_errores_pg.CodError,
                                                          SV_mens_retorno           OUT NOCOPY ge_errores_pg.MsgError,
                                                          SN_num_evento             OUT NOCOPY ge_errores_pg.Evento) IS
            LV_Parametros ARRAY_PARAMETROS_;
                        LV_Sql      ge_errores_pg.vQuery;
                        LV_des_error ge_errores_pg.DesEvent;
                        LV_estado     VARCHAR2(1);

                BEGIN

                        SN_num_evento:= 0;
                        SN_cod_retorno:=0;
                        SV_mens_retorno:='';
                        LV_Sql:='SELECT  1'
                                        || ' FROM       ert_solicitud_planes b,ert_solicitud a'
                                        || ' WHERE      a.num_ident_cliente = :EV_numident'
                                        || ' AND a.cod_tipident = :EV_tipident'
                                        || ' AND a.num_solicitud = b.num_solicitud'
                                        || ' AND a.ind_tipo_solicitud = :EN_tipo_solicitud'
                                        || ' AND a.ind_evento =:EN_ind_evento'
                                        || ' AND a.cod_estado IN(:par1,:par2)'
                                        || ' AND b.cod_plantarif = :EV_plantarif';

                        LV_Parametros(1):= SUBSTR(EV_cod_estado,2,1);
                        LV_Parametros(2):= SUBSTR(EV_cod_estado,6,1);
                        EXECUTE IMMEDIATE LV_Sql INTO LV_estado USING IN EV_numident, EV_tipident, EN_tipo_solicitud, EN_ind_evento,LV_Parametros(1),LV_Parametros(2),EV_plantarif;
                        SB_resultado:= TRUE;

                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                    SB_resultado:= FALSE;
                                WHEN OTHERS THEN
                                    SN_cod_retorno:=156;
                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                           SV_mens_retorno:=CV_error_no_clasif;
                                    END IF;
                                    LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_existe_eriesgo_ptarif_PR(' ||EV_numident||','
                                  ||EV_tipident||','||EN_tipo_solicitud||','||EN_ind_evento||','
                                                                  ||EV_cod_estado||','||EV_plantarif|| ')- ' || SQLERRM;
                                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                    'VE_validacion_linea_PG.VE_existe_eriesgo_ptarif_PR(' || EV_numident || ',' || EN_tipo_solicitud || ',' || EV_cod_estado || ')', LV_Sql, SQLCODE, LV_des_error );
                                        SB_resultado:= FALSE;


                END VE_existe_eriesgo_ptarif_PR;

                PROCEDURE VE_existe_eriesgo_ptarif_PR(EV_numident               IN ge_clientes.num_ident%TYPE,
                                                                                          EV_tipident                   IN ge_clientes.cod_tipident%TYPE,
                                                                                      EN_tipo_solicitud         IN ERT_SOLICITUD.ind_tipo_solicitud%TYPE,
                                                                                          EN_ind_evento                 IN ERT_SOLICITUD.ind_evento%TYPE,
                                                                                          EV_cod_estado                 IN VARCHAR2,
                                                                                          EV_plantarif                  IN ert_solicitud_planes.cod_plantarif%TYPE,
                                                                                          SN_resultado          OUT NOCOPY PLS_INTEGER,
                                                                                          SN_cod_retorno        OUT NOCOPY ge_errores_pg.CodError,
                                                          SV_mens_retorno               OUT NOCOPY ge_errores_pg.MsgError,
                                                          SN_num_evento                 OUT NOCOPY ge_errores_pg.Evento) IS
                    LB_aux BOOLEAN;
            BEGIN
                        VE_existe_eriesgo_ptarif_PR(EV_numident,EV_tipident,EN_tipo_solicitud,EN_ind_evento,EV_cod_estado,EV_plantarif,LB_aux, SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        SN_resultado := VE_convertir_FN(LB_aux);
                END VE_existe_eriesgo_ptarif_PR;

                PROCEDURE VE_agente_comercial_PR(EV_codcliente        IN ge_clientes.cod_cliente%TYPE,
                                            SB_resultado         OUT NOCOPY BOOLEAN,
                                                                            SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS

                LV_Sql      ge_errores_pg.vQuery;
                LV_des_error ge_errores_pg.DesEvent;
                LV_existe         VARCHAR2(1);

                BEGIN

                         SN_num_evento:= 0;
                         SN_cod_retorno:=0;
                         SV_mens_retorno:='';

                         LV_Sql:='SELECT 1 FROM npt_usuario_cliente a '
                                         || 'WHERE  a.cod_cliente=' || EV_codcliente;

                         SELECT '1' INTO LV_existe
                         FROM   npt_usuario_cliente a
                         WHERE  a.cod_cliente=EV_codcliente;

                         SB_resultado := TRUE;

                         EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          SB_resultado := FALSE;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_agente_comercial_FN(' || EV_codcliente || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_agente_comercial_FN(' || EV_codcliente || ')', LV_Sql, SQLCODE, LV_des_error );

                                                          SB_resultado := FALSE;

                END     VE_agente_comercial_PR;

            PROCEDURE VE_agente_comercial_PR(EV_codcliente        IN ge_clientes.cod_cliente%TYPE,
                                             SN_resultado         OUT NOCOPY PLS_INTEGER,
                                                                             SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
                        LB_aux BOOLEAN;
            BEGIN
                        VE_agente_comercial_PR(EV_codcliente,LB_aux,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        SN_resultado := VE_convertir_FN(LB_aux);
                END VE_agente_comercial_PR;


                PROCEDURE VE_existe_cliente_PR(EV_codcliente    IN ge_clientes.cod_cliente%TYPE,
                                                                           SB_resultado     OUT NOCOPY BOOLEAN,
                                                                           SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS

                LV_Sql      ge_errores_pg.vQuery;
                LV_des_error ge_errores_pg.DesEvent;
                LV_esta       VARCHAR2(1);

                BEGIN

                         SN_num_evento:= 0;
                         SN_cod_retorno:=0;
                         SV_mens_retorno:='';

                         LV_Sql:= 'SELECT ''' || '1' || ''''
                                          || 'FROM      ge_clientes cliente,'
                                          || 'ge_direcciones direccion, ga_direccli direccioncliente,'
                                          || 'ge_ciudades ciudad'
                                          || 'WHERE     cliente.cod_cliente = ' || EV_codcliente
                                          || 'AND direccioncliente.cod_cliente = cliente.cod_cliente'
                                          || 'AND direccioncliente.cod_tipdireccion = ' || CV_tipodireccion
                                          || 'AND direccion.cod_direccion = direccioncliente.cod_direccion'
                                          || 'AND ciudad.cod_ciudad = direccion.cod_ciudad'
                                          || 'AND ciudad.cod_provincia = direccion.cod_provincia'
                                          || 'AND ciudad.cod_region = direccion.cod_region'
                                          || 'AND cliente.fec_baja IS NULL';


                         SELECT '1'
                         INTO   LV_esta
                         FROM   ge_clientes cliente,
                                        ge_direcciones direccion, ga_direccli direccioncliente,
                                        ge_ciudades ciudad
                         WHERE  cliente.cod_cliente = EV_codcliente
                                        AND direccioncliente.cod_cliente = cliente.cod_cliente
                                        AND direccioncliente.cod_tipdireccion = CV_tipodireccion
                                        AND direccion.cod_direccion = direccioncliente.cod_direccion
                                        AND ciudad.cod_ciudad = direccion.cod_ciudad
                                        AND ciudad.cod_provincia = direccion.cod_provincia
                                        AND ciudad.cod_region = direccion.cod_region
                                        AND cliente.fec_baja IS NULL;


                         SB_resultado := TRUE;

                         EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          SB_resultado := FALSE;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_existe_cliente_PR(' || EV_codcliente || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_existe_cliente_PR(' || EV_codcliente || ')', LV_Sql, SQLCODE, LV_des_error );

                                                          SB_resultado := FALSE;

                END VE_existe_cliente_PR;

        PROCEDURE VE_existe_cliente_PR(EV_codcliente    IN ge_clientes.cod_cliente%TYPE,
                                                                           SN_resultado     OUT NOCOPY PLS_INTEGER,
                                                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
                        LB_aux BOOLEAN;
            BEGIN
                        VE_existe_cliente_PR(EV_codcliente, LB_aux, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                        SN_resultado := VE_convertir_FN(LB_aux);
                END VE_existe_cliente_PR;


                PROCEDURE VE_existe_cliente_empresa_PR(EV_codcliente    IN ge_clientes.cod_cliente%TYPE,
                                                                                   SB_resultado     OUT NOCOPY BOOLEAN,
                                                                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                       SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS

                         LV_Sql      ge_errores_pg.vQuery;
                         LV_des_error ge_errores_pg.DesEvent;
                 LV_esta       VARCHAR2(1);

                BEGIN

                         SN_num_evento:= 0;
                         SN_cod_retorno:=0;
                         SV_mens_retorno:='';

                         LV_Sql:= 'SELECT ''' || '1' || ''''
                                          || 'FROM      ge_clientes a, ga_empresa b,'
                                          || 'ge_direcciones c, ga_direccli d,'
                                          || 'ge_ciudades e'
                                          || 'WHERE     cliente.cod_cliente = ' || EV_codcliente
                                          || 'AND cliente.cod_cliente = empresa.cod_cliente(+)'
                                          || 'AND direccioncliente.cod_cliente = cliente.cod_cliente'
                                          || 'AND direccioncliente.cod_tipdireccion = ' || CV_tipodireccion
                                          || 'AND direccion.cod_direccion = direccioncliente.cod_direccion'
                                          || 'AND ciudad.cod_ciudad = direccion.cod_ciudad'
                                          || 'AND ciudad.cod_provincia = direccion.cod_provincia'
                                          || 'AND ciudad.cod_region = direccion.cod_region';



                         SELECT '1'
                         INTO   LV_esta
                         FROM   ge_clientes cliente, ga_empresa empresa,
                                        ge_direcciones direccion, ga_direccli direccioncliente,
                                        ge_ciudades ciudad
                         WHERE  cliente.cod_cliente = EV_codcliente
                                        AND cliente.cod_cliente = empresa.cod_cliente(+)
                                        AND direccioncliente.cod_cliente = cliente.cod_cliente
                                        AND direccioncliente.cod_tipdireccion = CV_tipodireccion
                                        AND direccion.cod_direccion = direccioncliente.cod_direccion
                                        AND ciudad.cod_ciudad = direccion.cod_ciudad
                                        AND ciudad.cod_provincia = direccion.cod_provincia
                                        AND ciudad.cod_region = direccion.cod_region;




                         SB_resultado := TRUE;

                         EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          SB_resultado := FALSE;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_existe_cliente_empresa_PR(' || EV_codcliente || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_existe_cliente_empresa_PR(' || EV_codcliente || ')', LV_Sql, SQLCODE, LV_des_error );

                                                          SB_resultado := FALSE;

                END VE_existe_cliente_empresa_PR;

        PROCEDURE VE_existe_cliente_empresa_PR(EV_codcliente    IN ge_clientes.cod_cliente%TYPE,
                                                                                   SN_resultado     OUT NOCOPY PLS_INTEGER,
                                                                           SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                       SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
                        LB_aux BOOLEAN;
            BEGIN
                        VE_existe_cliente_empresa_PR(EV_codcliente, LB_aux, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                        SN_resultado := VE_convertir_FN(LB_aux);
                END VE_existe_cliente_empresa_PR;





                PROCEDURE VE_existe_contrato_PR(EV_numcontrato    IN ga_contcta.num_contrato%TYPE,
                                        SB_resultado      OUT NOCOPY BOOLEAN,
                                                                            SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

                LV_Sql      ge_errores_pg.vQuery;
                LV_des_error ge_errores_pg.DesEvent;
                LV_esta           VARCHAR2(1);


                BEGIN

                         SN_num_evento:= 0;
                         SN_cod_retorno:=0;
                         SV_mens_retorno:='';

                         LV_Sql:= 'SELECT 1 FROM ga_contcta ga '
                                          || 'WHERE ga.num_contrato = ' || EV_numcontrato;

                         SELECT '1'
                         INTO   LV_esta
                         FROM   ga_contcta ga
                         WHERE  ga.num_contrato = EV_numcontrato;

                         SB_resultado:= TRUE;

                         EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          SB_resultado:= FALSE;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_existe_contrato_PR(' || EV_numcontrato || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_existe_contrato_PR(' || EV_numcontrato || ')', LV_Sql, SQLCODE, LV_des_error );

                                                          SB_resultado:= FALSE;


                END VE_existe_contrato_PR;

                PROCEDURE VE_existe_contrato_PR(EV_numcontrato    IN ga_contcta.num_contrato%TYPE,
                                        SN_resultado      OUT NOCOPY PLS_INTEGER,
                                                                            SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                        LB_aux BOOLEAN;
            BEGIN
                        VE_existe_contrato_PR(EV_numcontrato,LB_aux,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        SN_resultado := VE_convertir_FN(LB_aux);
                END VE_existe_contrato_PR;


                PROCEDURE VE_vendedor_numero_PR(EV_numcelular     IN  ga_abocel.num_celular%TYPE,
                                                                                EV_codcliente     IN  ge_clientes.cod_cliente%TYPE,
                                                                            SV_codvendedor        OUT NOCOPY ve_vendedores.cod_vendedor%TYPE,
                                                                            SV_coduso             OUT NOCOPY al_usos.cod_uso%TYPE,
                                                                            SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

                LV_Sql      ge_errores_pg.vQuery;
                LV_des_error ge_errores_pg.DesEvent;

        BEGIN

                         SN_num_evento:= 0;
                         SN_cod_retorno:=0;
                         SV_mens_retorno:='';

                         LV_Sql:='SELECT a.cod_vendedor, a.cod_uso '
                                         || 'FROM       ga_reserva a '
                                         || 'WHERE      a.num_celular=' || EV_numcelular
                                         || 'AND a.cod_cliente=' || EV_codcliente;


                         SELECT a.cod_vendedor, a.cod_uso
                         INTO   SV_codvendedor, SV_coduso
                         FROM   GA_RESERVA a
                         WHERE  a.num_celular=EV_numcelular
                                        AND a.cod_cliente=EV_codcliente;

                         EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          NULL;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_vendedor_numero_PR(' || EV_numcelular || ',' || EV_codcliente || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_vendedor_numero_PR(' || EV_numcelular || ',' || EV_codcliente || ')', LV_Sql, SQLCODE, LV_des_error );

                END VE_vendedor_numero_PR;

                PROCEDURE VE_actualiza_eriesgo_PR(EV_numsolicitud   IN ERT_SOLICITUD.num_solicitud%TYPE,
                                                                                  EV_cod_estado     IN ERT_SOLICITUD.cod_estado%TYPE,
                                                                                  SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

                LV_Sql      ge_errores_pg.vQuery;
                LV_des_error ge_errores_pg.DesEvent;

                BEGIN

                        SN_num_evento:= 0;
                        SN_cod_retorno:=0;
                        SV_mens_retorno:='';

                        LV_Sql:='UPDATE ert_solicitud set cod_estado=' || EV_cod_estado
                                        || 'WHERE  num_solicitud=' || EV_numsolicitud;

                        UPDATE ERT_SOLICITUD SET cod_estado= EV_cod_estado
                        WHERE  num_solicitud=EV_numsolicitud;

                        EXCEPTION
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_actualiza_eriesgo_PR(' || EV_numsolicitud || ',' || EV_cod_estado || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_actualiza_eriesgo_PR(' || EV_numsolicitud || ',' || EV_cod_estado || ')', LV_Sql, SQLCODE, LV_des_error );

                END VE_actualiza_eriesgo_PR;

                PROCEDURE VE_tipostock_valido_PR(EV_tipstock       IN al_series.tip_stock%TYPE,
                                                                                 EV_modventa       IN ga_modvent_aplic.cod_modventa%TYPE,
                                                                                 EV_codproducto    IN ga_modvent_aplic.cod_producto%TYPE,
                                                                                 EV_codcanal       IN ga_modvent_aplic.cod_canal%TYPE,
                                                                                 SB_resultado      OUT NOCOPY BOOLEAN,
                                                                                 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

                        LV_Sql      ge_errores_pg.vQuery;
                        LV_des_error ge_errores_pg.DesEvent;
                    LV_resultado  VARCHAR2(1);

                BEGIN

                         SN_num_evento:= 0;
                         SN_cod_retorno:=0;
                         SV_mens_retorno:='';

                         SB_resultado:= FALSE;

                         LV_Sql:='SELECT UNIQUE 1 '
                                         || 'FROM ga_modvent_aplic c '
                                         || 'WHERE  c.cod_producto = ' || EV_codproducto
                                         || ' AND c.cod_modventa = ' || EV_modventa
                                         || ' AND c.cod_canal = ' || EV_codcanal
                                         || ' AND c.cod_aplic is null'
                                         || ' AND c.cod_modventa IN (SELECT cod_modventa_nue '
                                         || 'FROM   ga_modvent_aplic d '
                                         || 'WHERE  c.cod_modventa=d.cod_modventa) '
                                         || 'AND c.tip_stock IN (' || EV_tipstock || ')';

                         SELECT UNIQUE '1'
                         INTO LV_resultado
                         FROM   ga_modvent_aplic c
                         WHERE  c.cod_producto = EV_codproducto
                                        AND c.cod_modventa = EV_modventa
                                        and c.cod_canal=EV_codcanal
                                        and c.cod_aplic is null
                                        AND c.cod_modventa IN (SELECT cod_modventa_nue
                                                                               FROM   ga_modvent_aplic d
                                                                                   WHERE  c.cod_modventa=d.cod_modventa)
                                        AND c.tip_stock IN (EV_tipstock);

                         IF LV_resultado = 1 THEN
                                SB_resultado:= TRUE;
                         END IF;

                         EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          SB_resultado:= FALSE;
                                                          SN_cod_retorno:=1;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                                          SB_resultado:= FALSE;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_tipostock_valido_PR(' || EV_tipstock || ',' || EV_modventa || ',' || EV_codproducto || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_tipostock_valido_PR(' || EV_tipstock || ',' || EV_modventa || ',' || EV_codproducto || ')', LV_Sql, SQLCODE, LV_des_error );

                END VE_tipostock_valido_PR;


                PROCEDURE VE_tipostock_valido_PR(EV_tipstock       IN al_series.tip_stock%TYPE,
                                                                                 EV_modventa       IN ga_modvent_aplic.cod_modventa%TYPE,
                                                                                 EV_codproducto    IN ga_modvent_aplic.cod_producto%TYPE,
                                                                                 EV_codcanal       IN ga_modvent_aplic.cod_canal%TYPE,
                                                                                 SN_resultado      OUT NOCOPY PLS_INTEGER,
                                                                                 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
            LB_aux BOOLEAN;
            BEGIN
                        VE_tipostock_valido_PR(EV_tipstock,EV_modventa,EV_codproducto,EV_codcanal,LB_aux,SN_cod_retorno,
                        SV_mens_retorno,SN_num_evento);
                        SN_resultado := VE_convertir_FN(LB_aux);
                END VE_tipostock_valido_PR;




                PROCEDURE VE_obtiene_valor_parametro_PR(EV_nomparametro   IN ged_parametros.nom_parametro%TYPE,
                                                                                                EV_codmodulo      IN ged_parametros.cod_modulo%TYPE,
                                                                                                EV_codproducto    IN ged_parametros.cod_producto%TYPE,
                                                                                                SV_valparametro   OUT NOCOPY ged_parametros.val_parametro%TYPE,
                                                                                                SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

                LV_Sql      ge_errores_pg.vQuery;
                LV_des_error ge_errores_pg.DesEvent;

                BEGIN

                         SN_num_evento:= 0;
                         SN_cod_retorno:=0;
                         SV_mens_retorno:='';

                         LV_Sql:='SELECT a.val_parametro '
                                         || 'FROM       ged_parametros a '
                                         || 'WHERE      a.nom_parametro=' || EV_nomparametro
                                         || ' AND a.cod_modulo=' || EV_codmodulo
                                         || ' AND a.cod_producto=' || EV_codproducto;

                         SELECT a.val_parametro INTO SV_valparametro
                         FROM   ged_parametros a
                         WHERE  a.nom_parametro=EV_nomparametro
                                        AND a.cod_modulo=EV_codmodulo
                                        AND a.cod_producto=EV_codproducto;


                         EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          NULL;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_obtiene_valor_parametro_PR(' || EV_nomparametro || ',' || EV_codmodulo || ',' || EV_codproducto || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_obtiene_valor_parametro_PR(' || EV_nomparametro || ',' || EV_codmodulo || ',' || EV_codproducto || ')', LV_Sql, SQLCODE, LV_des_error );

                END VE_obtiene_valor_parametro_PR;


       PROCEDURE VE_existe_cuenta_PR(EV_codcuenta         IN  ga_cuentas.cod_cuenta%TYPE,
                                                                         SB_resultado         OUT NOCOPY BOOLEAN,
                                                                         SV_descuenta             OUT NOCOPY ga_cuentas.des_cuenta%TYPE,
                                                                         SV_codcategoria          OUT NOCOPY ga_cuentas.cod_categoria%TYPE,
                                                                         SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
                                /*--
                                <Documentacion TipoDoc = "Procedure">
                                <Elemento Nombre = "VE_existe_cuenta_PR"
                                          Lenguaje="PL/SQL"
                                                  Fecha="05-03-2007"
                                                  Version="1.0.0"
                                                  Dise?ador="wjrc"
                                                  Programador="wjrc"
                                                  Ambiente="BD">
                                <Retorno> PLS_INTEGER </Retorno>
                                <Descripcion> obtiene datos de la cuenta </Descripcion>
                                <Parametros>
                                <Entrada>
                                                  <param nom="EV_codcuenta" Tipo="NUMBER"> codigo de la cuenta </param>
                                </Entrada>
                                <Salida>
                                                <param nom="SB_resultado" Tipo="BOOLEAN"> resultado de la busqueda </param>
                                                <param nom="SV_descuenta" Tipo="STRING"> descripcion de la cuenta </param>
                                                <param nom="SV_codcategoria" Tipo="NUMBER"> codigo de la categoria </param>
                                </Salida>
                                </Parametros>
                                </Elemento>
                                </Documentacion>
                                --*/
                                LV_Sql      ge_errores_pg.vQuery;
                                LV_des_error ge_errores_pg.DesEvent;
                                BEGIN
                                        SN_num_evento:= 0;
                                        SN_cod_retorno:=0;
                                        SV_mens_retorno:='';

                                        LV_Sql:='SELECT a.des_cuenta, a.cod_categoria '
                                                         || 'FROM       ga_cuentas a '
                                                         || 'WHERE  a.cod_cuenta = ' || EV_codcuenta;

                                        SELECT a.des_cuenta, a.cod_categoria
                                        INTO    SV_descuenta, SV_codcategoria
                                        FROM    ga_cuentas a
                                        WHERE  a.cod_cuenta = EV_codcuenta;

                                        SB_resultado := TRUE;

                                        EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          SB_resultado := FALSE;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_existe_cuenta_PR(' || EV_codcuenta || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_existe_cuenta_PR(' || EV_codcuenta || ')', LV_Sql, SQLCODE, LV_des_error );

                                                          SB_resultado := FALSE;
           END VE_existe_cuenta_PR;

       PROCEDURE VE_existe_cuenta_PR(EV_codcuenta         IN  ga_cuentas.cod_cuenta%TYPE,
                                                                         SN_resultado         OUT NOCOPY PLS_INTEGER,
                                                                         SV_descuenta             OUT NOCOPY ga_cuentas.des_cuenta%TYPE,
                                                                         SV_codcategoria          OUT NOCOPY ga_cuentas.cod_categoria%TYPE,
                                                                         SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)IS
                /*--
                <Documentacion TipoDoc = "Procedure">
                <Elemento Nombre = "VE_existe_cuenta_PR"
                          Lenguaje="PL/SQL"
                                  Fecha="05-03-2007"
                                  Version="1.0.0"
                                  Dise?ador="wjrc"
                                  Programador="wjrc"
                                  Ambiente="BD">
                <Retorno> PLS_INTEGER </Retorno>
                <Descripcion> convierte la salida boolean en entero </Descripcion>
                <Parametros>
                <Entrada>
                                  <param nom="EV_codcuenta" Tipo="NUMBER"> codigo de la cuenta </param>
                </Entrada>
                <Salida>
                                <param nom="SN_resultado" Tipo="PLS_INTEGER"> resultado de la conversion </param>
                                <param nom="SV_descuenta" Tipo="STRING"> descripcion de la cuenta </param>
                                <param nom="SV_codcategoria" Tipo="NUMBER"> codigo de la categoria </param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
                LB_aux BOOLEAN;
           BEGIN
                                         VE_existe_cuenta_PR(EV_codcuenta,LB_aux,SV_descuenta,SV_codcategoria,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                         SN_resultado := VE_convertir_FN(LB_aux);
           END VE_existe_cuenta_PR;



           PROCEDURE VE_existe_subcuenta_PR(EV_codcuenta         IN  ga_cuentas.cod_cuenta%TYPE,
                                                                         SB_resultado         OUT NOCOPY BOOLEAN,
                                                                         SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
                                /*--
                                <Documentacion TipoDoc = "Procedure">
                                <Elemento Nombre = "VE_existe_cuenta_PR"
                                          Lenguaje="PL/SQL"
                                                  Fecha="05-03-2007"
                                                  Version="1.0.0"
                                                  Dise?ador="wjrc"
                                                  Programador="wjrc"
                                                  Ambiente="BD">
                                <Retorno> PLS_INTEGER </Retorno>
                                <Descripcion> obtiene datos de la cuenta </Descripcion>
                                <Parametros>
                                <Entrada>
                                                  <param nom="EV_codcuenta" Tipo="NUMBER"> codigo de la cuenta </param>
                                </Entrada>
                                <Salida>
                                                <param nom="SB_resultado" Tipo="BOOLEAN"> resultado de la busqueda </param>
                                                <param nom="SV_descuenta" Tipo="STRING"> descripcion de la cuenta </param>
                                                <param nom="SV_codcategoria" Tipo="NUMBER"> codigo de la categoria </param>
                                </Salida>
                                </Parametros>
                                </Elemento>
                                </Documentacion>
                                --*/
                                LV_Sql      ge_errores_pg.vQuery;
                                LV_des_error ge_errores_pg.DesEvent;
                                lv_codSubcuenta GA_SUBCUENTAS.COD_SUBCUENTA%TYPE;
                                BEGIN
                                        SN_num_evento:= 0;
                                        SN_cod_retorno:=0;
                                        SV_mens_retorno:='';

                                        LV_Sql:='SELECT a.cod_subcuenta '
                                                         || 'FROM       ga_subcuentas a '
                                                         || 'WHERE  a.cod_cuenta = ' || EV_codcuenta
                                                         || ' AND ROWNUM=1';


                                        SELECT a.cod_subcuenta
                                        INTO    lv_codSubcuenta
                                        FROM    ga_subcuentas a
                                        WHERE  a.cod_cuenta = EV_codcuenta
                                        and ROWNUM=1;

                                        SB_resultado := TRUE;

                                        EXCEPTION
                                                 WHEN NO_DATA_FOUND THEN
                                                          SB_resultado := FALSE;
                                                 WHEN OTHERS THEN
                                                          SN_cod_retorno:=156;
                                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                   SV_mens_retorno:=CV_error_no_clasif;
                                              END IF;
                                              LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_existe_cuenta_PR(' || EV_codcuenta || ');- ' || SQLERRM;
                                              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                          'VE_validacion_linea_PG.VE_existe_cuenta_PR(' || EV_codcuenta || ')', LV_Sql, SQLCODE, LV_des_error );

                                                          SB_resultado := FALSE;
           END VE_existe_subcuenta_PR;

       PROCEDURE VE_existe_subcuenta_PR(EV_codcuenta         IN  ga_cuentas.cod_cuenta%TYPE,
                                                                         SN_resultado         OUT NOCOPY PLS_INTEGER,
                                                                         SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)IS
                /*--
                <Documentacion TipoDoc = "Procedure">
                <Elemento Nombre = "VE_existe_cuenta_PR"
                          Lenguaje="PL/SQL"
                                  Fecha="05-03-2007"
                                  Version="1.0.0"
                                  Dise?ador="wjrc"
                                  Programador="wjrc"
                                  Ambiente="BD">
                <Retorno> PLS_INTEGER </Retorno>
                <Descripcion> convierte la salida boolean en entero </Descripcion>
                <Parametros>
                <Entrada>
                                  <param nom="EV_codcuenta" Tipo="NUMBER"> codigo de la cuenta </param>
                </Entrada>
                <Salida>
                                <param nom="SN_resultado" Tipo="PLS_INTEGER"> resultado de la conversion </param>
                                <param nom="SV_descuenta" Tipo="STRING"> descripcion de la cuenta </param>
                                <param nom="SV_codcategoria" Tipo="NUMBER"> codigo de la categoria </param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
                LB_aux BOOLEAN;
           BEGIN
                                         VE_existe_subcuenta_PR(EV_codcuenta,LB_aux,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                         SN_resultado := VE_convertir_FN(LB_aux);
           END VE_existe_subcuenta_PR;







           PROCEDURE VE_verifica_rechazo_serie_PR (EV_num_serie_equipo IN ga_det_preliq.num_serie_orig%TYPE,
                                                                                           SN_resultado           OUT NOCOPY PLS_INTEGER,
                                                                                           SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                                               SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                               SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_verifica_rechazo_serie_PR"
                        Lenguaje="PL/SQL"
                        Fecha="01-05-2007"
                        Version="1.0.0"
                        Dise?ador=" Mario Tigua"
                        Programador=" Mario Tigua"
                        Ambiente="BD"
                <Retorno> NA </Retorno>
                <Descripcion>
                         Restorna 1 si la serie del equipo se encuentra en estado rechazada y sin una nota de credito,0 de lo contrario
                </Descripcion>
                <Parametros>
                <Entrada>
                                <param nom="EV_num_serie_equipo" Tipo="VARCHAR"> Numero de serie del equipo </param>
                </Entrada>
                <Salida>
                            <param nom="SN_resultado Tipo="NUMBER"> Resultado de la validacion </param>
                                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/

                LV_Sql      ge_errores_pg.vQuery;
                LV_des_error ge_errores_pg.DesEvent;

                BEGIN
                         SN_num_evento:= 0;
                         SN_cod_retorno:=0;
                         SV_mens_retorno:='';

                        LV_Sql:='SELECT 1 '
                                         || 'FROM       ga_preliquidacion a, ga_det_preliq b'
                                         || ' WHERE  a.num_venta = b.num_venta'
                                         || '  AND b.num_serie_orig = '|| EV_num_serie_equipo
                                         || '  AND a.ind_estventa = '||CV_VENTA_RECHAZADA
                                         || '  AND a.nota_credito IS NULL';

                        SELECT 1
                        INTO SN_resultado
                        FROM ga_preliquidacion a, ga_det_preliq b
                        WHERE a.num_venta = b.num_venta
                        AND b.num_serie_orig = EV_num_serie_equipo
                        AND a.ind_estventa = CV_VENTA_RECHAZADA
                        AND a.nota_credito IS NULL;

                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                SN_resultado:= 0;
                                SN_cod_retorno:=4;
                                SV_mens_retorno:='NO_DATA_FOUND:VE_servicios_venta_PG.VE_verifica_rechazo_serie_PR;- ' || SQLERRM;
                        WHEN OTHERS THEN
                                SN_resultado:= 0;
                                SN_cod_retorno:=4;
                                --SV_mens_retorno:='OTHERS:VE_servicios_venta_PG.VE_verifica_rechazo_serie_PR;- ' || SQLERRM;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_validacion_linea_PG.VE_verifica_rechazo_serie_PR(' || EV_num_serie_equipo || ');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                            'VE_validacion_linea_PG.VE_verifica_rechazo_serie_PR (' || EV_num_serie_equipo || ')', LV_Sql, SQLCODE, LV_des_error );

                END VE_verifica_rechazo_serie_PR;

            PROCEDURE VE_numeroreservadoOK_PR(EN_numcelular     IN  GA_RESERVA.num_celular%TYPE,
                                                      EN_codcliente     IN  GA_RESERVA.cod_cliente%TYPE,
                                                                                  EN_codvendedor    IN  GA_RESERVA.cod_vendedor%TYPE,
                                                                                  SB_resultado      OUT NOCOPY BOOLEAN,
                                                                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedure">
                <Elemento Nombre = "VE_numeroreservadoOK_PR"
                          Lenguaje="PL/SQL"
                                  Fecha="03-05-2007"
                                  Version="1.0.0"
                                  Dise?ador="wjrc"
                                  Programador="wjrc"
                                  Ambiente="BD">
                <Retorno> PLS_INTEGER </Retorno>
                <Descripcion>
                                          Verifica si el numero de celular esta reservado para el cliente y/o vendedor
                </Descripcion>
                <Parametros>
                <Entrada>
                                  <param nom="EN_numcelular"  Tipo="NUMBER"> numero de celular</param>
                                  <param nom="EN_codcliente"  Tipo="NUMBER"> codigo cliente</param>
                                  <param nom="EN_codvendedor" Tipo="NUMBER"> codigo vendedor</param>
                </Entrada>
                <Salida>
                                <param nom="SN_resultado"    Tipo="BOOLEAN"> resultado boolean</param>
                                <param nom="SN_cod_retorno   Tipo="NUMBER"> codigo error</param>
                                <param nom="SV_mens_retorno" Tipo="STRING"> descripcion error</param>
                                <param nom="SN_num_evento"   Tipo="NUMBER"> numero evento</param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
                        LN_esta  NUMBER;
                        LV_sSql      ge_errores_pg.vQuery;
                        LV_des_error ge_errores_pg.DesEvent;
                BEGIN

                        SB_resultado := FALSE;
                        SN_num_evento:= 0;
                        SN_cod_retorno:=0;
                        SV_mens_retorno:='';

                        LV_sSql := 'SELECT 1'
                                           ||' FROM   GA_RESERVA r'
                                           ||' WHERE  r.num_celular = '||EN_numcelular
                                           ||' AND ((r.cod_cliente = '||EN_codcliente||' AND r.cod_vendedor ='|| EN_codvendedor||')'
                                           ||' OR (r.cod_cliente IS NULL AND r.cod_vendedor = '||EN_codvendedor||'))';

                        SELECT 1
                        INTO   LN_esta
                        FROM   GA_RESERVA r
                        WHERE  r.num_celular = EN_numcelular
                          AND ((r.cod_cliente = EN_codcliente AND r.cod_vendedor = EN_codvendedor)
                                   OR (r.cod_cliente IS NULL AND r.cod_vendedor = EN_codvendedor));

                        SB_resultado := TRUE;

                EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                    SN_cod_retorno:=4;
                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                               SV_mens_retorno := CV_error_no_clasIF;
                            END IF;
                            LV_des_error := SUBSTR('NO_DATA_FOUND:VE_validacion_linea_PG.VE_numeroreservadoOK_PR; - '|| SQLERRM,1,CN_largoerrtec);
                            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                        'VE_validacion_linea_PG.VE_numeroreservadoOK_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                         WHEN OTHERS THEN
                                    SN_cod_retorno:=4;
                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                               SV_mens_retorno := CV_error_no_clasIF;
                            END IF;
                            LV_des_error := SUBSTR('OTHERS:VE_validacion_linea_PG.VE_numeroreservadoOK_PR; - '|| SQLERRM,1,CN_largoerrtec);
                            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                        'VE_validacion_linea_PG.VE_numeroreservadoOK_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                END VE_numeroreservadoOK_PR;

            PROCEDURE VE_numeroreservadoOK_PR(EN_numcelular     IN  GA_RESERVA.num_celular%TYPE,
                                                      EN_codcliente     IN  GA_RESERVA.cod_cliente%TYPE,
                                                                                  EN_codvendedor    IN  GA_RESERVA.cod_vendedor%TYPE,
                                                                                  SN_resultado      OUT NOCOPY PLS_INTEGER,
                                                                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedure">
                <Elemento Nombre = "VE_numeroreservadoOK_PR"
                          Lenguaje="PL/SQL"
                                  Fecha="03-05-2007"
                                  Version="1.0.0"
                                  Dise?ador="wjrc"
                                  Programador="wjrc"
                                  Ambiente="BD">
                <Retorno> PLS_INTEGER </Retorno>
                <Descripcion> convierte la salida boolean en entero </Descripcion>
                <Parametros>
                <Entrada>
                                  <param nom="EN_numcelular"  Tipo="NUMBER"> numero de celular</param>
                                  <param nom="EN_codcliente"  Tipo="NUMBER"> codigo cliente</param>
                                  <param nom="EN_codvendedor" Tipo="NUMBER"> codigo vendedor</param>
                </Entrada>
                <Salida>
                                <param nom="SN_resultado"    Tipo="PLS_INTEGER"> resultado de la conversion</param>
                                <param nom="SN_cod_retorno   Tipo="NUMBER"> codigo error</param>
                                <param nom="SV_mens_retorno" Tipo="STRING"> descripcion error</param>
                                <param nom="SN_num_evento"   Tipo="NUMBER"> numero evento</param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
                        LB_aux BOOLEAN;
            BEGIN
                        VE_numeroreservadoOK_PR(EN_numcelular,EN_codcliente,EN_codvendedor,LB_aux,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        SN_resultado := VE_convertir_FN(LB_aux);
                END VE_numeroreservadoOK_PR;

            PROCEDURE VE_RESTRINGESTOCK_PR(EN_CANAL             IN  VARCHAR,
                                                   EN_NUM_SERIE         IN  AL_SERIES.NUM_SERIE%TYPE,
                                                                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedure">
                <Elemento Nombre = "VE_RESTRINGESTOCK_PR"
                          Lenguaje="PL/SQL"
                                  Fecha="23-08-2007"
                                  Version="1.0.0"
                                  Dise?ador="nrca"
                                  Programador="nrca"
                                  Ambiente="BD">
                <Retorno> PLS_INTEGER </Retorno>
                <Descripcion>
                                  Restringe los tipos de stock a usar segun canal de vendedor
                </Descripcion>
                <Parametros>
                <Entrada>
                                  <param nom="EN_CANAL"  Tipo="VARCHAR"> numero de celular</param>
                                  <param nom="EN_NUM_SERIE"  Tipo="NUMBER"> codigo cliente</param>
                </Entrada>
                <Salida>
                                <param nom="SN_cod_retorno   Tipo="NUMBER"> codigo error</param>
                                <param nom="SV_mens_retorno" Tipo="STRING"> descripcion error</param>
                                <param nom="SN_num_evento"   Tipo="NUMBER"> numero evento</param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/


                        LV_sSql      ge_errores_pg.vQuery;
                        LV_des_error ge_errores_pg.DesEvent;
                        LV_tipstock  al_series.tip_stock%TYPE;
                        ERROR_SERIE   EXCEPTION;
                BEGIN

                        SN_num_evento:= 0;
                        SN_cod_retorno:=0;
                        SV_mens_retorno:='';

                        LV_sSql := 'SELECT TIP_STOCK FROM AL_SERIES  WHERE  NUM_SERIE = '|| EN_NUM_SERIE;


                        SELECT TIP_STOCK
                        INTO LV_tipstock
                        FROM AL_SERIES
                        WHERE NUM_SERIE=EN_NUM_SERIE;

                        IF (LV_tipstock <> 2) and UPPER(EN_CANAL)='D' THEN
                           SV_mens_retorno:='Vendedor Directo no puede Vender articulos con Stock distinto a Mercaderia';
                           SN_cod_retorno:=4;
                           RAISE ERROR_SERIE;
                        END IF;

                        IF (LV_tipstock <> 10 AND LV_tipstock <> 4) AND UPPER(EN_CANAL)='I'  THEN
                           SV_mens_retorno:='Vendedor Indirecto no puede Vender articulos con Stock distinto a Mercaderia Dealer o Consignación';
                           SN_cod_retorno:=4;
               RAISE ERROR_SERIE;
                        END IF;


                EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                    SN_cod_retorno:=4;
                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                               SV_mens_retorno := CV_error_no_clasIF;
                            END IF;
                            LV_des_error := SUBSTR('NO_DATA_FOUND:VE_validacion_linea_PG.VE_RESTRINGESTOCK_PR; - '|| SQLERRM,1,CN_largoerrtec);
                            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                        'VE_validacion_linea_PG.VE_RESTRINGESTOCK_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                         WHEN ERROR_SERIE THEN
                                SN_cod_retorno:=4;
                                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                               SV_mens_retorno := CV_error_no_clasIF;
                            END IF;
                            LV_des_error := SUBSTR('TIPO_STOCK NO CORRESPONDE A VENDEDOR:VE_validacion_linea_PG.VE_RESTRINGESTOCK_PR; - '|| SQLERRM,1,CN_largoerrtec);
                            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                        'VE_validacion_linea_PG.VE_RESTRINGESTOCK_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                         WHEN OTHERS THEN
                                    SN_cod_retorno:=4;
                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                               SV_mens_retorno := CV_error_no_clasIF;
                            END IF;
                            LV_des_error := SUBSTR('OTHERS:VE_validacion_linea_PG.VE_RESTRINGESTOCK_PR; - '|| SQLERRM,1,CN_largoerrtec);
                            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                        'VE_validacion_linea_PG.VE_RESTRINGESTOCK_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                END VE_RESTRINGESTOCK_PR;

END Ve_Validacion_Linea_Pg; 
/
SHOW ERRORS
