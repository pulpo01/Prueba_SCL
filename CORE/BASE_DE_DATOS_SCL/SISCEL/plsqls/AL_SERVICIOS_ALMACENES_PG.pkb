CREATE OR REPLACE PACKAGE BODY AL_Servicios_Almacenes_PG IS

        PROCEDURE AL_consulta_articulo_PR(EN_cod_articulo    IN  al_articulos.cod_articulo%TYPE,
                                                                      SN_tip_articulo    OUT NOCOPY al_articulos.tip_articulo%TYPE,
                                                                      SV_des_articulo    OUT NOCOPY al_articulos.des_articulo%TYPE,
                                                                          SN_cod_conceptoart OUT NOCOPY al_articulos.cod_conceptoart%TYPE,
                                                                      SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS


                        LV_Sql      ge_errores_pg.vQuery;
                        LV_des_error ge_errores_pg.DesEvent;

                        /*--
                        <Documentacion TipoDoc = "Procedimiento">
                                Elemento Nombre = "AL_consulta_articulo_PR"
                                Lenguaje="PL/SQL"
                                Fecha="05/07/2007"
                                Version="1.0.0"
                                Dise?ador="Hector Hermosilla"
                                Programador="Hector Hermosilla
                                Ambiente="BD"
                        <Retorno>NA</Retorno>
                        <Descripcion>
                                Consulta articulo
                        </Descripcion>
                        <Parametros>
                        <Entrada>
                                <param nom="EN_cod_articulo"    Tipo="NUMBER> código articulo</param>
                        </Entrada>
                        <Salida>
                            <param nom="SN_tip_articulo"    Tipo="NUMBER"> tipo articulo </param>
                                <param nom="SV_des_articulo"    Tipo="STRING"> descripcion articulo </param>
                                <param nom="SN_cod_conceptoart" Tipo="NUMBER"> código concepto artículo </param>
                                <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
                                <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
                                <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
                        </Salida>
                        </Parametros>
                        </Elemento>
                        </Documentacion>
                        --*/

                        BEGIN

                                SN_num_evento:= 0;
                                SN_cod_retorno:=0;
                                SV_mens_retorno:='';

                                LV_Sql:= 'SELECT articulo.tip_articulo, articulo.des_articulo,articulo.cod_conceptoart'
                                                 || ' FROM   al_articulos articulo'
                                                 || ' WHERE articulo.cod_articulo = ' || EN_cod_articulo;

                                SELECT articulo.tip_articulo, articulo.des_articulo, articulo.cod_conceptoart
                                INTO   SN_tip_articulo, SV_des_articulo, SN_cod_conceptoart
                                FROM   al_articulos articulo
                                WHERE  articulo.cod_articulo = EN_cod_articulo;


                                EXCEPTION
                                         WHEN NO_DATA_FOUND THEN
                                                  SN_cod_retorno:=1;
                                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                           SV_mens_retorno:=CV_error_no_clasif;
                                      END IF;
                                      LV_des_error:='NO_DATA_FOUND:AL_Servicios_Almacenes_PG.VE_consulta_articulo_PR(' || EN_cod_articulo || ');- ' || SQLERRM;
                                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                                                  'AL_Servicios_Almacenes_PG.VE_consulta_articulo_PR(' || EN_cod_articulo || ')', LV_Sql, SQLCODE, LV_des_error );
                                         WHEN OTHERS THEN
                                                  SN_cod_retorno:=156;
                                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                           SV_mens_retorno:=CV_error_no_clasif;
                                      END IF;
                                      LV_des_error:='OTHERS:AL_Servicios_Almacenes_PG.VE_consulta_articulo_PR(' || EN_cod_articulo || ');- ' || SQLERRM;
                                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                                                  'AL_Servicios_Almacenes_PG.VE_consulta_articulo_PR(' || EN_cod_articulo || ')', LV_Sql, SQLCODE, LV_des_error );

                END AL_consulta_articulo_PR;

                PROCEDURE AL_indicador_valorar_PR(EN_num_serie    IN  VARCHAR2,
                                                                  SN_ind_valorar  OUT NOCOPY NUMBER,
                                                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedimiento">
                Elemento Nombre = "AL_indicador_valorar_PR"
                Lenguaje="PL/SQL"
                Fecha="22/08/2007"
                Version="1.0.0"
                Dise?ador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
                <Retorno>NA</Retorno>
                <Descripcion>
                                          restorna el valor del indicador valorar
                </Descripcion>
                <Parametros>
                <Entrada>
                        <param nom="EN_num_serie"    Tipo="STRING> numero de serie </param>
                </Entrada>
                <Salida>
                        <param nom="SN_ind_valorar"  Tipo="NUMBER"> indicador valorar </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
                        CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(23) := 'AL_indicador_valorar_PR';

                        LV_Sql      ge_errores_pg.vQuery;
                        LV_des_error ge_errores_pg.DesEvent;
                BEGIN
                        SN_num_evento:= 0;
                        SN_cod_retorno:=0;
                        SV_mens_retorno:='';

                        LV_Sql:= 'SELECT b.ind_valorar'
                              || ' FROM al_series a, al_tipos_stock b'
                              || ' WHERE a.tip_stock = b.tip_stock'
                              || ' AND a.num_serie = ' || EN_num_serie;

                        SELECT b.ind_valorar
                        INTO SN_ind_valorar
                        FROM al_series a, al_tipos_stock b
                        WHERE a.tip_stock = b.tip_stock
                        AND a.num_serie = EN_num_serie;

                EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                  VE_intermediario_PG.VE_NotDataFound_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                         WHEN OTHERS THEN
                                  VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                END AL_indicador_valorar_PR;

                PROCEDURE AL_venta_mayorista_PR(EN_numSerie            IN VARCHAR2,
                                                SV_codigoUso           OUT NOCOPY VARCHAR2,
                                                                    SV_descripcionUso      OUT NOCOPY VARCHAR2,
                                                                                SV_codigoArticulo      OUT NOCOPY VARCHAR2,
                                                                                SV_descripcionArticulo OUT NOCOPY VARCHAR2,
                                                                                SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                                                                SV_mens_retorno            OUT NOCOPY ge_errores_pg.MsgError,
                                                                                SN_num_evento              OUT NOCOPY ge_errores_pg.Evento) IS
                        /*--
                        <Documentación TipoDoc = "Procedimiento">
                                Elemento Nombre = "AL_venta_mayorista_PR"
                                Lenguaje="PL/SQL"
                                Fecha="22-08-2007"
                                Versión="1.0.0"
                                Diseñador="wjrc"
                                Programador="wjrc"
                                Ambiente="BD"
                        <Retorno>
                                         Datos del articulo : descriocion y uso
                        </Retorno>
                        <Descripción>
                                Obtiene origen de la venta
                        </Descripción>
                        <Parámetros>
                        <Entrada>
                                <param nom="EV_numSerie" Tipo="STRING> numero de serie </param>
                        </Entrada>
                        <Salida>
                                <param nom="SV_codigoUso"           Tipo="STRING"> codigo uso </param>
                                <param nom="SV_descripcionUso"      Tipo="STRING"> descripcion uso </param>
                                <param nom="SV_codigoArticulo"      Tipo="STRING"> codigo articulo </param>
                                <param nom="SV_descripcionArticulo" Tipo="STRING"> descripcion articulo </param>
                                <param nom="SN_cod_retorno"         Tipo="NUMBER"> codigo retorno </param>
                                <param nom="SV_mens_retorno"        Tipo="STRING"> glosa mensaje error </param>
                                <param nom="SN_num_evento"          Tipo="NUMBER"> numero de evento </param>
                        </Salida>
                        </Parámetros>
                        </Elemento>
                        </Documentación>
                        */
                                CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(21) := 'AL_venta_mayorista_PR';
                                CN_TIPOPROCESO        CONSTANT NUMBER       := 1;

                                ERROR_PROCEDIMIENTO   EXCEPTION;

                                LV_des_error ge_errores_pg.desevent;
                                LV_sql           ge_errores_pg.vquery;
                        BEGIN
                                SN_cod_retorno  := 0;
                        SV_mens_retorno := '';
                        SN_num_evento   := 0;

                                -- llamar procedimiento : origen de la venta
                                LV_Sql := 'NP_TRANSACCIONES_WEB_PG.NP_ORIGENVENTA_PR('|| EN_numSerie ||','
                                                                      || CN_TIPOPROCESO ||','
                                                                                          || SV_codigoUso || ','
                                                                                          || SV_descripcionUso || ','
                                                                                          || SV_codigoArticulo || ','
                                                                                          || SV_descripcionArticulo || ','
                                                                                          || SV_mens_retorno ||')';
                                NP_TRANSACCIONES_WEB_PG.NP_ORIGENVENTA_PR(EN_numSerie,
                                                                          CN_TIPOPROCESO,
                                                                                                                  SV_codigoUso,
                                                                                                                  SV_descripcionUso,
                                                                                                                  SV_codigoArticulo,
                                                                                                                  SV_descripcionArticulo,
                                                                                                                  SV_mens_retorno);



                -- verificamos estado del llamado
                IF SV_codigoUso IS NOT NULL AND SV_descripcionUso IS NOT NULL AND SV_codigoArticulo IS NOT NULL AND SV_descripcionArticulo IS NOT NULL  THEN
                   SN_cod_retorno:=0;
                ELSE
                    SV_mens_retorno:='Serie No recepcionada por Nota Pedido Web';
                        RAISE ERROR_PROCEDIMIENTO;
                END IF;

                        EXCEPTION
                                        WHEN ERROR_PROCEDIMIENTO THEN
                                                VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                        WHEN OTHERS THEN
                                                VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END AL_venta_mayorista_PR;

    PROCEDURE AL_obtener_homenumerado_pr(EV_NumSerie        IN  al_series.num_serie%TYPE,
                                                                         EV_CodVendedor     IN  ve_vendedores.cod_vendedor%TYPE,
                                                                                 SN_Codsubalm       OUT al_series.cod_subalm%TYPE,
                                                                         SV_CodCentral      OUT al_series.COD_CENTRAL%TYPE,
                                                                             SV_CodHlr          OUT al_series.COD_HLR%TYPE,
                                                                         SV_CodCelda        OUT ge_celdas.COD_CELDA%TYPE,
                                                                                 SV_Region          OUT ge_direcciones.COD_REGION%TYPE,
                                                                                 SV_Provincia       OUT ge_direcciones.COD_PROVINCIA%TYPE,
                                                                                 SV_Ciudad          OUT ge_direcciones.COD_CIUDAD%TYPE,
                                                                                 SN_cod_retorno     OUT ge_errores_pg.CodError,
                                                 SV_mens_retorno    OUT ge_errores_pg.MsgError,
                                                 SN_num_evento      OUT ge_errores_pg.Evento) IS


                /*--
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "AL_obtener_homenumerado_pr"
                        Lenguaje="PL/SQL"
                        Fecha="10-09-2007"
                        Versión="1.0.0"
                        Diseñador="NRCA"
                        Programador="NRCA"
                        Ambiente="BD"
                <Retorno>
                                 SUBALM,CENTRAL,HLR,CELDA
                </Retorno>
                <Descripción>
                obtiene central,hlr,subalm,celda en caso que la serie sea numerada
                         en caso contrario solo devolvera el hlr.
                </Descripción>
                <Parámetros>
                <Entrada>
                        <param nom="EV_numSerie" Tipo="STRING> numero de serie </param>
                </Entrada>
                <Salida>
                        <param nom="SN_CodSubalm"           Tipo="NUMBER"> Codigo Subalm </param>
                        <param nom="SV_CodCentral"          Tipo="STRING"> Codigo Central</param>
                        <param nom="SV_CodHLR"              Tipo="STRING"> codigo HLR </param>
                        <param nom="SV_CodCelda"            Tipo="STRING"> Codigo Celda </param>
                        <param nom="SN_cod_retorno"         Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno"        Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"          Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */

                CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(30) := 'AL_obtener_homenumerado_pr';
                CN_TIPOPROCESO        CONSTANT NUMBER       := 1;
                LN_CodCelda           GE_CELDAS.COD_CELDA%TYPE;
                ERROR_PROCEDIMIENTO   EXCEPTION;

                LV_des_error ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
                LV_NumTelefono    AL_SERIES.NUM_TELEFONO%TYPE;
                BEGIN
                                SN_cod_retorno  := 0;
                        SV_mens_retorno := '';
                        SN_num_evento   := 0;


                /*      LV_sql:='SELECT NUM_TELEFONO FROM AL_SERIES WHERE NUM_TELEFONO = ' || EV_NumSerie;


                                SELECT NUM_TELEFONO
                                INTO LV_NumTelefono
                                FROM AL_SERIES
                                WHERE NUM_SERIE= EV_NumSerie; */


                                SELECT A.COD_SUBALM,A.COD_CENTRAL,A.COD_HLR, B.COD_CELDA
                INTO SN_Codsubalm,
                                SV_CodCentral,
                                SV_CodHlr,
                                SV_CodCelda
                                FROM AL_SERIES A , GE_CELDAS B
                WHERE A.COD_SUBALM=B.COD_SUBALM(+)
                                AND A.NUM_SERIE=EV_NumSerie;

                                SELECT B.COD_REGION, B.COD_PROVINCIA, B.COD_CIUDAD, C.COD_CELDA
                                INTO
                                SV_Region,
                                SV_Provincia,
                                SV_Ciudad,
                                LN_CodCelda
                                FROM VE_VENDEDORES A,
                                GE_DIRECCIONES B,
                                GE_CIUCELDAS_TD C
                                WHERE A.COD_DIRECCION=B.COD_DIRECCION
                                AND B.COD_REGION=C.COD_REGION
                                AND B.COD_PROVINCIA=C.COD_PROVINCIA
                                AND B.COD_CIUDAD=C.COD_CIUDAD
                                AND A.COD_VENDEDOR=EV_CodVendedor;

                IF SV_CodCelda <> LN_CodCelda THEN
                                   SV_mens_retorno:='SIMCARD NO PERTENECE AL HOME DEL VENDEDOR';
                                   SN_cod_retorno:=4;
                                   RAISE ERROR_PROCEDIMIENTO;
                                END IF;

                EXCEPTION
                                WHEN ERROR_PROCEDIMIENTO THEN
                                         VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                WHEN OTHERS THEN
                                         VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END AL_obtener_homenumerado_pr;

END AL_Servicios_Almacenes_Pg;


/
SHOW ERRORS
