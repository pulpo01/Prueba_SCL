CREATE OR REPLACE PACKAGE BODY BP_servicios_benefpromo_PG IS

        --------------------
        -- PROCEDIMIENTOS --
        --------------------

        PROCEDURE BP_getListCampVigPostpago_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                                           SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "BP_getListCampVigPostpago_PR"
                        Lenguaje="PL/SQL"
                        Fecha="05-06-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Cursor
                </Retorno>
                <Descripción>
                                  Retorna lista campañas vigentes postpago
                </Descripción>
                <Parámetros>
                 <Entrada> N/A </Entrada>
                 <Salida>
                           <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor campañas </param>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                NO_DATA_FOUND_CURSOR EXCEPTION;
                LV_desError  ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
                LN_contador  NUMBER;
         BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                LV_Sql:='SELECT a.cod_campana, a.des_campana, a.tip_entidad  '
                        || 'FROM bp_campanas_td a '
                        || 'WHERE TO_DATE(TO_CHAR(a.fec_termino,' || CV_FORMATOFECHA || '),' || CV_FORMATOFECHA || ') >= TO_DATE(TO_CHAR(SYSDATE,' || CV_FORMATOFECHA || '),' || CV_FORMATOFECHA || ')'
                        || 'AND a.cod_tiplan <> ' || CV_CODTIPPLANTARIFPREPAGO
                        || 'ORDER BY a.ind_default DESC';

                LN_contador := 0;
                SELECT COUNT(1)
                INTO LN_contador
                FROM bp_campanas_td a
                WHERE TO_DATE(TO_CHAR(a.fec_termino,CV_FORMATOFECHA),CV_FORMATOFECHA) >= TO_DATE(TO_CHAR(SYSDATE,CV_FORMATOFECHA),CV_FORMATOFECHA)
                AND a.cod_tiplan <> CV_CODTIPPLANTARIFPREPAGO;

                OPEN SC_cursorDatos FOR
                SELECT a.cod_campana, a.des_campana, a.tip_entidad
                FROM bp_campanas_td a
                WHERE TO_DATE(TO_CHAR(a.fec_termino,CV_FORMATOFECHA),CV_FORMATOFECHA) >= TO_DATE(TO_CHAR(SYSDATE,CV_FORMATOFECHA),CV_FORMATOFECHA)
                AND a.cod_tiplan <> CV_CODTIPPLANTARIFPREPAGO
                ORDER BY a.ind_default DESC;

                IF (LN_contador = 0) THEN
                        RAISE NO_DATA_FOUND_CURSOR;
                END IF;

        EXCEPTION
                        WHEN NO_DATA_FOUND_CURSOR THEN
                                 SN_codRetorno:=1;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                            SV_menRetorno := CV_ERRORNOCLASIF;
                         END IF;
                         LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:BP_servicios_benefpromo_PG.BP_getListCampVigPostpago_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                         SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'BP_servicios_benefpromo_PG.BP_getListCampVigPostpago_PR', LV_Sql, SN_codRetorno, LV_desError );
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_ERRORNOCLASIF;
                                END IF;
                                LV_desError  := 'OTHERS:BP_servicios_benefpromo_PG.BP_getListCampVigPostpago_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'BP_servicios_benefpromo_PG.BP_getListCampVigPostpago_PR', LV_Sql, SQLCODE, LV_desError );
        END BP_getListCampVigPostpago_PR;

        PROCEDURE BP_registra_campana_PR(EV_codCampana   IN VARCHAR2,
                                                                         EV_codCliente   IN ga_abocel.COD_CLIENTE%TYPE,
                                                                         EV_numAbonado   IN ga_abocel.NUM_CELULAR%TYPE,
                                                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                         SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                         SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "BP_registra_campana_PR"
                Lenguaje="PL/SQL"
                Fecha="05-06-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                Registra campaña para el cliente
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_codcampana" Tipo="STRING> codigo campaña </param>
                <param nom="EN_codcliente" Tipo="NUMBER"> codigo cliente </param>
        </Entrada>
        <Salida>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LN_num_transaccion NUMBER;
        LV_des_error ge_errores_pg.desevent;
        LV_sql           ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                -- llamar procedimiento
                LV_Sql := 'BP_PROMOCIONES_PG.BP_REGISTRA_CAMPANA_PR(' || EV_codcampana || ',' || EV_codcliente || ',' || EV_numAbonado || ',''A' || ')';
                BP_PROMOCIONES_PG.BP_REGISTRA_CAMPANA_PR(EV_codcampana,EV_codcliente,EV_numAbonado,'A');

        EXCEPTION
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_ERRORNOCLASIF;
                END IF;
                LV_des_error:='OTHERS:BP_servicios_benefpromo_PG.BP_registra_campana_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'BP_servicios_benefpromo_PG.BP_registra_campana_PR', LV_Sql, SQLCODE, LV_des_error );
        END BP_registra_campana_PR;

    PROCEDURE VE_getCampana_PR(EV_codCampana   IN VARCHAR2,
                                                           EV_indAplicaA   OUT NOCOPY VARCHAR2,
                                                           SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                           SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                           SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentacion
          TipoDoc = "PROCEDURE">
           <Elemento
              Nombre = "VE_getCampana_PR"
              Lenguaje="PL/SQL"
              Fecha="21-07-2007"
              Version="1.0"
              Dise?ador="wjrc"
              Programador="wjrc"
              Ambiente Desarrollo="BD">
              <Retorno>NA</Retorno>
              <Descripcion>
                                           Obtiene indicador de campaña aplica a : [A] abonado [C] cliente
                  </Descripcion>
              <Parametros>
                 <Entrada>
                    <param nom="SV_codCampana" Tipo="VARCHAR2" Descripcion = "Codigo campaña" </param>
                         /Entrada>
                 <Salida>
                 <param nom="SV_indAplicaA"   Tipo="VARCHAR2" Indicador apliaca a abonado (A) cliente (C)" </param>
                                 <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                 <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                 <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                 </Salida>
              </Parametros>
           </Elemento>
        </Documentacion>
        */
                LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
        BEGIN
                SN_num_evento:= 0;
                SN_cod_retorno:=0;
                SV_mens_retorno:='';

                LV_sSql := 'SELECT a.tip_entidad ';
            LV_sSql := LV_sSql||' FROM bp_campanas_td a';
                LV_sSql := LV_sSql||' WHERE a.cod_campana = ' || EV_codCampana;

                SELECT a.tip_entidad
                INTO EV_indAplicaA
                FROM bp_campanas_td a
                WHERE a.COD_CAMPANA = EV_codCampana;

                SN_cod_retorno := NULL;

        EXCEPTION
              WHEN NO_DATA_FOUND THEN
                           SN_cod_retorno:=4;
                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                      SV_mens_retorno := CV_ERRORNOCLASIF;
                   END IF;
                   LV_des_error := SUBSTR('NO_DATA_FOUND:BP_servicios_benefpromo_PG.VE_getCampana_PR; - '|| SQLERRM,1,CN_largoerrtec);
                   SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                   SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                           'BP_servicios_benefpromo_PG.VE_getCampana_PR', LV_sSql, SN_cod_retorno, LV_des_error );
              WHEN OTHERS THEN
                           SN_cod_retorno:=4;
                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                      SV_mens_retorno := CV_ERRORNOCLASIF;
                   END IF;
                   LV_des_error := SUBSTR('OTHERS:BP_servicios_benefpromo_PG.VE_getCampana_PR; - '|| SQLERRM,1,CN_largoerrtec);
                   SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                   SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                           'BP_servicios_benefpromo_PG.VE_getCampana_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        END VE_getCampana_PR;

END BP_servicios_benefpromo_PG; 
/
SHOW ERRORS
