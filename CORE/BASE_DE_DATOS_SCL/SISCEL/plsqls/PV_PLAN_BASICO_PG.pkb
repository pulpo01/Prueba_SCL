CREATE OR REPLACE PACKAGE BODY PV_PLAN_BASICO_PG AS

--------------------------------------------------------------------------------------------------------
    PROCEDURE PV_SEL_PERIODO_CICLFACT_PR (Reg_fac_ciclfact       IN OUT NOCOPY    PV_TIPOS_PG.R_FA_CICLFACT,
                                                                              SN_cod_retorno            OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                              SV_mens_retorno           OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                              SN_num_evento             OUT NOCOPY        ge_errores_pg.evento)
    IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_SEL_PERIODO_CICLFACT_PR"
              Lenguaje="PL/SQL"
              Fecha="14-06-2007"
              Versión="La del package"
              Diseñador=
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>  Rescata ciclo de facturacion del cliente </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="Reg_fac_ciclfact" Tipo="Estructura Registro "></param>>
                 </Entrada>
                 <Salida>
                            <param nom="Reg_fac_ciclfact" Tipo="Estructura Registro "></param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;
    BEGIN
                        LV_sSql:='SELECT /*+ INDEX_DESC (FA_CICLFACT PK_FA_CICLFACT) */  ';
                                LV_sSql:= LV_sSql||' COD_CICLFACT FROM FA_CICLFACT ';
                                LV_sSql:= LV_sSql||' WHERE COD_CICLO    = '||Reg_fac_ciclfact(1).COD_CICLO;
                                LV_sSql:= LV_sSql||'   AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM';
                                LV_sSql:= LV_sSql||'   AND ROWNUM = '||CN_uno;
                                LV_sSql:= LV_sSql||' ORDER BY  FEC_EMISION';

                        FOR i IN Reg_fac_ciclfact.FIRST .. Reg_fac_ciclfact.LAST LOOP
                                SELECT /*+ INDEX_DESC (FA_CICLFACT PK_FA_CICLFACT) */
                                           COD_CICLFACT
                                INTO   Reg_fac_ciclfact(i).COD_CICLFACT
                                FROM FA_CICLFACT
                                WHERE COD_CICLO         = Reg_fac_ciclfact(i).COD_CICLO
                                AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM
                                AND ROWNUM                      = CN_uno
                                ORDER BY  FEC_EMISION;
             END LOOP;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
                 Reg_fac_ciclfact(1).COD_CICLFACT:=null;
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_SEL_PERIODO_CICLFACT_PR ('||to_char(Reg_fac_ciclfact(1).COD_CICLO)||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_SEL_PERIODO_CICLFACT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PV_SEL_PERIODO_CICLFACT_PR;

--------------------------------------------------------------------------------------------------------
    PROCEDURE PV_SEL_GA_HDTOSTARIF_PR (Reg_ga_hdtostarif        IN  OUT NOCOPY    PV_TIPOS_PG.R_GA_HDTOSTARIF,
                                                                           SN_cod_retorno               OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                           SV_mens_retorno              OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                           SN_num_evento                OUT NOCOPY        ge_errores_pg.evento)
    IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_SEL_GA_HDTOSTARIF_PR"
              Lenguaje="PL/SQL"
              Fecha="14-06-2007"
              Versión="La del package"
              Diseñador=
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>  Rescata Hist fact cliente </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="Reg_ga_hdtostarif" Tipo="Estructura Registro "></param>>
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
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;
    BEGIN

                        LV_sSql:= 'SELECT NUM_ABONADO, ';
                        LV_sSql:= LV_sSql||' COD_CICLFACT, NUM_MINUTOS, ';
                        LV_sSql:= LV_sSql||' TIP_PLANTARIF, COD_VENDEDOR, ';
                        LV_sSql:= LV_sSql||' NOM_USUARORA,  FEC_GRABACION, SYSDATE ';
                        LV_sSql:= LV_sSql||' FROM GA_DTOSTARIF ';
                        LV_sSql:= LV_sSql||' WHERE NUM_ABONADO = '||Reg_ga_hdtostarif(1).NUM_ABONADO;
                        LV_sSql:= LV_sSql||'   AND COD_CICLFACT <> '||Reg_ga_hdtostarif(1).COD_CICLFACT;

                        FOR i IN Reg_ga_hdtostarif.FIRST .. Reg_ga_hdtostarif.LAST LOOP
                        SELECT
                                NUM_ABONADO,
                                COD_CICLFACT,
                                NUM_MINUTOS,
                                TIP_PLANTARIF,
                                COD_VENDEDOR,
                                NOM_USUARORA,
                                FEC_GRABACION,
                                SYSDATE
                        INTO
                                Reg_ga_hdtostarif(i).NUM_ABONADO,
                                Reg_ga_hdtostarif(i).COD_CICLFACT,
                                Reg_ga_hdtostarif(i).NUM_MINUTOS,
                                Reg_ga_hdtostarif(i).TIP_PLANTARIF,
                                Reg_ga_hdtostarif(i).COD_VENDEDOR,
                                Reg_ga_hdtostarif(i).NOM_USUARORA,
                                Reg_ga_hdtostarif(i).FEC_GRABACION,
                                Reg_ga_hdtostarif(i).FEC_BAJA
                        FROM GA_DTOSTARIF
                        WHERE NUM_ABONADO = Reg_ga_hdtostarif(i).NUM_ABONADO
                        AND COD_CICLFACT <> Reg_ga_hdtostarif(i).COD_CICLFACT;
          END LOOP;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
                 Reg_ga_hdtostarif(1).FEC_BAJA:=null;
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_SEL_GA_HDTOSTARIF_PR ('||to_char(Reg_ga_hdtostarif(1).NUM_ABONADO)||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_SEL_GA_HDTOSTARIF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PV_SEL_GA_HDTOSTARIF_PR;

--------------------------------------------------------------------------------------------------------
    PROCEDURE PV_INS_GA_HDTOSTARIF_PR (Reg_ga_hdtostarif        IN                        PV_TIPOS_PG.R_GA_HDTOSTARIF,
                                                                           SN_cod_retorno               OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                           SV_mens_retorno              OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                           SN_num_evento                OUT NOCOPY        ge_errores_pg.evento)
    IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_INS_GA_HDTOSTARIF_PR"
              Lenguaje="PL/SQL"
              Fecha="14-06-2007"
              Versión="La del package"
              Diseñador=
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Paso historico de datos del plan tarifario</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="Reg_ga_dtostarif" Tipo="Estructura Registro "></param>>
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
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;

    BEGIN

                SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento       := 0;

                LV_sSql:= 'INSERT INTO ga_hdtostarif  ';
                LV_sSql:= LV_sSql||' VALUES '||Reg_ga_hdtostarif(1).NUM_ABONADO||',';
                LV_sSql:= LV_sSql|| Reg_ga_hdtostarif(1).COD_CICLFACT||',';
                LV_sSql:= LV_sSql|| Reg_ga_hdtostarif(1).NUM_MINUTOS||',';
                LV_sSql:= LV_sSql|| Reg_ga_hdtostarif(1).TIP_PLANTARIF||',';
                LV_sSql:= LV_sSql|| Reg_ga_hdtostarif(1).COD_VENDEDOR||',';
                LV_sSql:= LV_sSql|| Reg_ga_hdtostarif(1).NOM_USUARORA||',';
                LV_sSql:= LV_sSql|| Reg_ga_hdtostarif(1).FEC_GRABACION||',';
                LV_sSql:= LV_sSql|| Reg_ga_hdtostarif(1).FEC_BAJA;

                FORALL i IN Reg_ga_hdtostarif.FIRST .. Reg_ga_hdtostarif.LAST
                 INSERT INTO ga_hdtostarif  VALUES Reg_ga_hdtostarif(i);

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_INS_GA_HDTOSTARIF_PR ('||to_char(Reg_ga_hdtostarif(1).NUM_ABONADO)||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_INS_GA_HDTOSTARIF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PV_INS_GA_HDTOSTARIF_PR;

--------------------------------------------------------------------------------------------------------
    PROCEDURE PV_DEL_GA_DTOSTARIF_PR (Reg_ga_dtostarif  IN  OUT NOCOPY    PV_TIPOS_PG.R_GA_DTOSTARIF,
                                                                          SN_cod_retorno                OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                          SV_mens_retorno               OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                          SN_num_evento                 OUT NOCOPY        ge_errores_pg.evento)
    IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_DEL_GA_DTOSTARIF_PR"
              Lenguaje="PL/SQL"
              Fecha="14-06-2007"
              Versión="La del package"
              Diseñador=
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Paso historico de datos del plan tarifario</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="Reg_ga_dtostarif" Tipo="Estructura Registro "></param>>
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
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;

    BEGIN

                SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento       := 0;

                LV_sSql:= 'DELETE GA_DTOSTARIF  ';
                        LV_sSql:= LV_sSql||' WHERE NUM_ABONADO  = '||Reg_ga_dtostarif(1).NUM_ABONADO||',';
                        LV_sSql:= LV_sSql||'   AND COD_CICLFACT = '||Reg_ga_dtostarif(1).COD_CICLFACT;

                        FOR i IN Reg_ga_dtostarif.FIRST .. Reg_ga_dtostarif.LAST LOOP
                                DELETE GA_DTOSTARIF
                                WHERE NUM_ABONADO  = Reg_ga_dtostarif(i).NUM_ABONADO
                                      AND COD_CICLFACT = Reg_ga_dtostarif(i).COD_CICLFACT;
            END LOOP;

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_DEL_GA_DTOSTARIF_PR ('||to_char(Reg_ga_dtostarif(1).NUM_ABONADO)||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_DEL_GA_DTOSTARIF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PV_DEL_GA_DTOSTARIF_PR;

--------------------------------------------------------------------------------------------------------
        PROCEDURE PV_REGISTRO_HIST_PLAN_PR (EO_FA_CICLFACT          IN                   PV_FA_CICLFACT_QT,
                                                                                SN_cod_retorno          OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                                SV_mens_retorno         OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                                SN_num_evento       OUT NOCOPY   ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_REGISTRO_HIST_PLAN_PR"
              Lenguaje="PL/SQL"
              Fecha="14-06-2007"
              Versión="La del package"
              Diseñador=
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Paso historico de datos del plan tarifario</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_ABONADO" Tipo="estructura"></param>>
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
                LV_des_error                                      ge_errores_pg.DesEvent;
                LV_sSql                                                   ge_errores_pg.vQuery;
                ERROR_EJECUCION                           EXCEPTION;
                Reg_ga_hdtostarif                                 PV_TIPOS_PG.R_GA_HDTOSTARIF;
                Reg_ga_dtostarif                                  PV_TIPOS_PG.R_GA_DTOSTARIF;
                Reg_fac_ciclfact                                  PV_TIPOS_PG.R_FA_CICLFACT;

        BEGIN

                SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento       := 0;

                Reg_fac_ciclfact(1).COD_CICLFACT:= NULL;
                Reg_fac_ciclfact(1).COD_CICLO   := EO_FA_CICLFACT.COD_CICLO;
                LV_sSql:='PV_PLAN_BASICO_PG.PV_SEL_PERIODO_CICLFACT_PR ('||Reg_fac_ciclfact(1).COD_CICLO||','||Reg_fac_ciclfact(1).COD_CICLFACT||')';
                PV_PLAN_BASICO_PG.PV_SEL_PERIODO_CICLFACT_PR (Reg_fac_ciclfact,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno <> 0 THEN
                    RAISE ERROR_EJECUCION;
            END IF;

                IF  Reg_fac_ciclfact(1).COD_CICLFACT IS NOT NULL THEN
                        Reg_ga_hdtostarif(1).NUM_ABONADO := EO_FA_CICLFACT.NUM_ABONADO;
                        Reg_ga_hdtostarif(1).COD_CICLFACT:= Reg_fac_ciclfact(1).COD_CICLFACT;
                        Reg_ga_hdtostarif(1).FEC_BAJA    := NULL;
                        LV_sSql:='PV_PLAN_BASICO_PG.PV_SEL_GA_HDTOSTARIF_PR ('||Reg_ga_hdtostarif(1).NUM_ABONADO||','||Reg_ga_hdtostarif(1).COD_CICLFACT||')';
                        PV_PLAN_BASICO_PG.PV_SEL_GA_HDTOSTARIF_PR (Reg_ga_hdtostarif,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno <> 0 THEN
                       RAISE ERROR_EJECUCION;
                END IF;

                                IF Reg_ga_hdtostarif(1).FEC_BAJA IS NOT NULL  then
                                    LV_sSql:='PV_PLAN_BASICO_PG.PV_INS_GA_HDTOSTARIF_PR ('||Reg_ga_hdtostarif(1).NUM_ABONADO||','||Reg_ga_hdtostarif(1).COD_CICLFACT||','|| Reg_ga_hdtostarif(1).NUM_MINUTOS||','|| Reg_ga_hdtostarif(1).TIP_PLANTARIF||','||Reg_ga_hdtostarif(1).COD_VENDEDOR||','||Reg_ga_hdtostarif(1).NOM_USUARORA||','||Reg_ga_hdtostarif(1).FEC_GRABACION||','||Reg_ga_hdtostarif(1).FEC_BAJA||')';
                                        PV_PLAN_BASICO_PG.PV_INS_GA_HDTOSTARIF_PR (Reg_ga_hdtostarif,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                        IF SN_cod_retorno <> 0 THEN
                                   RAISE ERROR_EJECUCION;
                                END IF;

                                        Reg_ga_dtostarif(1).NUM_ABONADO  := EO_FA_CICLFACT.NUM_ABONADO;
                                        Reg_ga_dtostarif(1).COD_CICLFACT := Reg_fac_ciclfact(1).COD_CICLFACT;
                                        LV_sSql:='PV_PLAN_BASICO_PG.PV_DEL_GA_DTOSTARIF_PR ('||Reg_ga_dtostarif(1).NUM_ABONADO||','||Reg_ga_dtostarif(1).COD_CICLFACT||')';
                                        PV_PLAN_BASICO_PG.PV_DEL_GA_DTOSTARIF_PR (Reg_ga_dtostarif,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                        IF SN_cod_retorno <> 0 THEN
                                   RAISE ERROR_EJECUCION;
                                END IF;
                                END IF;
                        END IF;

        EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := ' PV_REGISTRO_HIST_PLAN_PR ('||EO_FA_CICLFACT.NUM_ABONADO||','||EO_FA_CICLFACT.COD_CICLO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_REGISTRO_HIST_PLAN_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_REGISTRO_HIST_PLAN_PR ('||EO_FA_CICLFACT.NUM_ABONADO||','||EO_FA_CICLFACT.COD_CICLO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_REGISTRO_HIST_PLAN_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_REGISTRO_HIST_PLAN_PR ('||EO_FA_CICLFACT.NUM_ABONADO||','||EO_FA_CICLFACT.COD_CICLO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_REGISTRO_HIST_PLAN_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_REGISTRO_HIST_PLAN_PR;

--------------------------------------------------------------------------------------------------------
FUNCTION PV_obtiene_unidades_tas_FN(EV_Plan_Tarifario  IN                     ta_plantarif.cod_plantarif%TYPE,
                                                                        SV_tip_unitas      OUT NOCOPY     ta_plantarif.tip_unitas%TYPE,
                                                                SN_cod_retorno     OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                                                SV_mens_retorno    OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                                                SN_num_evento      OUT NOCOPY     ge_errores_pg.evento)
        RETURN CHAR
        AS
        /*
        <Documentacion TipoDoc = "Funcion">
        <Elemento Nombre = "PV_obtiene_unidades_tas_FN"
         Lenguaje="PL/SQL" Fecha="12-04-2005"
         Versión"1.0.0" Diseñador"****"
         Programador="" Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripcion>Chequea si el Clientes es empresa</Descripcion>
        <Parametros>
        <Entrada>
                        <param nom="PV_Cliente_QT" Tipo="estructura">estructura de cliente</param>>
        </Entrada>
        <Salida>
           <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
           <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
           <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        */
        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql                    ge_errores_pg.vQuery;

        BEGIN

            SN_cod_retorno        := 0;
            SV_mens_retorno   := NULL;
            SN_num_evento         := 0;

                LV_sSql:='';
                LV_sSql:=LV_sSql||' SELECT TIP_UNITAS';
                LV_sSql:=LV_sSql||' INTO SV_tip_unitas';
                LV_sSql:=LV_sSql||' FROM TA_PLANTARIF ';
                LV_sSql:=LV_sSql||' WHERE COD_PLANTARIF = '||EV_Plan_Tarifario||'';
                LV_sSql:=LV_sSql||' AND COD_PRODUCTO    = '||to_char(CN_producto)||'; ';

                 SELECT TIP_UNITAS
                 INTO SV_tip_unitas
                 FROM TA_PLANTARIF
                 WHERE COD_PLANTARIF    = EV_Plan_Tarifario
                           AND COD_PRODUCTO = CN_producto;

                 RETURN SV_tip_unitas;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_obtiene_unidades_tas_FN('||EV_Plan_Tarifario||','||SV_tip_unitas||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_obtiene_unidades_tas_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN 0;
    WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_obtiene_unidades_tas_FN('||EV_Plan_Tarifario||','||SV_tip_unitas||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_obtiene_unidades_tas_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN 0;
END PV_obtiene_unidades_tas_FN;

--------------------------------------------------------------------------------------------------------
FUNCTION PV_obtiene_codproceso_FN(SN_cod_retorno     OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                                          SV_mens_retorno    OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                                          SN_num_evento      OUT NOCOPY         ge_errores_pg.evento)
        RETURN VARCHAR2
        AS
        /*
        <Documentacion TipoDoc = "Funcion">
        <Elemento Nombre = "PV_obtiene_codproceso_FN"
         Lenguaje="PL/SQL" Fecha="12-04-2005"
         Versión"1.0.0" Diseñador"****"
         Programador="" Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripcion>Chequea si el Clientes es empresa</Descripcion>
        <Parametros>
        <Entrada>
                        <param nom="PV_Cliente_QT" Tipo="estructura">estructura de cliente</param>>
        </Entrada>
        <Salida>
           <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
           <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
           <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        */
        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql                    ge_errores_pg.vQuery;
        LV_codProceso      gad_procesos_perfiles.cod_proceso%TYPE;
        BEGIN
            SN_cod_retorno        := 0;
            SV_mens_retorno   := NULL;
            SN_num_evento         := 0;
                LV_codProceso     := '';


                LV_sSql:=' SELECT COD_PROCESO   ';
                LV_sSql:=LV_sSql||' FROM GAD_PROCESOS_PERFILES ';
                LV_sSql:=LV_sSql||' WHERE NOM_PERFIL_PROCESO ='||CV_perfil_proceso;


                SELECT COD_PROCESO
                INTO LV_codProceso
                FROM GAD_PROCESOS_PERFILES
                WHERE NOM_PERFIL_PROCESO = CV_perfil_proceso ;

                RETURN LV_codProceso;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_obtiene_codproceso_FN('||LV_codProceso||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_obtiene_codproceso_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN LV_codProceso;
    WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_obtiene_codproceso_FN('||LV_codProceso||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_obtiene_codproceso_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN LV_codProceso;
END PV_obtiene_codproceso_FN;

--------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_PLANES_PREPAGO_PR(
      EO_PlanesTarifarios       IN               PV_PLANES_TARIFARIOS_QT,
          SO_Planes_Prepago             OUT NOCOPY       refCursor,
          SO_Planes_Hibrido             OUT NOCOPY       refCursor,
      SN_cod_retorno        OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno       OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento         OUT NOCOPY           ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_PLANES_PPEPAGO_PR"
              Lenguaje="PL/SQL"
              Fecha="04-06-2007"
              Versión="La del package"
              Diseñador="Matías Guajardo"
              Programador="Matías Guajardo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="" Tipo="estructura"></param>>
                 </Entrada>
                 <Salida>
                    <param nom="" Tipo=""></param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_des_error           ge_errores_pg.DesEvent;
        LV_sSql                        ge_errores_pg.vQuery;
        LV_cla_plantarif           ta_plantarif.CLA_PLANTARIF%TYPE;
        EO_GED_PARAMETROS          PV_GED_PARAMETROS_QT;
        ERROR_EJECUCION            EXCEPTION;
        LV_COD_PRESTACION      VARCHAR2(10);
        LV_COD_PRESTACION_DOS  VARCHAR2(10);
        BEGIN

                SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento       := 0;
            LV_COD_PRESTACION := '';
            LV_COD_PRESTACION_DOS := '';

            SELECT  COD_PRESTACION
            INTO LV_COD_PRESTACION
            FROM GA_aboamist
            WHERE NUM_ABONADO  =EO_PlanesTarifarios.NUM_ABONADO
            union
            SELECT  COD_PRESTACION
            FROM GA_abocel
            WHERE NUM_ABONADO  =EO_PlanesTarifarios.NUM_ABONADO;

            LV_COD_PRESTACION_DOS := LV_COD_PRESTACION;

        /*  ini  ADC 30-05-2011   170614
          
           IF LV_COD_PRESTACION = '01' THEN
                LV_COD_PRESTACION_DOS := '22';
            ELSIF LV_COD_PRESTACION = '04' THEN
                LV_COD_PRESTACION_DOS := '23';
            ELSIF LV_COD_PRESTACION = '05' THEN
                LV_COD_PRESTACION_DOS := '24';
            ELSIF LV_COD_PRESTACION = '22' THEN
                LV_COD_PRESTACION_DOS := '01';
            ELSIF LV_COD_PRESTACION = '23' THEN
                LV_COD_PRESTACION_DOS := '04';
            ELSIF LV_COD_PRESTACION = '24' THEN
                LV_COD_PRESTACION_DOS := '05';
            END IF;     */ 
            
             SELECT ASOCDESTINO INTO  LV_COD_PRESTACION_DOS
             FROM GE_ASOCPRESTACIONES_TD
             WHERE ASOCORIGEN = LV_COD_PRESTACION
             AND USO = CN_prepago ;
             
           --  fin  ADC 30-05-2011   170614
           
---dbms_output.put_line(LV_COD_PRESTACION);
                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                EO_GED_PARAMETROS.NOM_PARAMETRO:= 'TIPO_PLAN_SERVICIO';
                EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;

        LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR ('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                LV_cla_plantarif := EO_GED_PARAMETROS.VAL_PARAMETRO;
                IF SN_cod_retorno <> 0 THEN
                   RAISE ERROR_EJECUCION;
                END IF;

                LV_sSql:='';
                LV_sSql:=LV_sSql||' SELECT NULL cod_plantarif, NULL des_plantarif, NULL cod_limconsumo, NULL des_limconsumo, NULL cod_cargobasico, NULL des_cargobasico, NULL IMP_CARGOBASICO , null imp_final, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo , NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff';
                LV_sSql:=LV_sSql||' FROM DUAL              ';
                LV_sSql:=LV_sSql||' WHERE ROWNUM = 0;      ';
---dbms_output.put_line(LV_sSql);
                OPEN SO_Planes_Prepago FOR
                SELECT NULL cod_plantarif, NULL des_plantarif, NULL cod_limconsumo, NULL des_limconsumo, NULL cod_cargobasico, NULL des_cargobasico, NULL IMP_CARGOBASICO , null imp_final, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo, NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff
        FROM DUAL
        WHERE ROWNUM = 0;

                LV_sSql:='SELECT NULL cod_plantarif, NULL des_plantarif, NULL cod_limconsumo, NULL des_limconsumo, NULL cod_cargobasico, NULL des_cargobasico, NULL IMP_CARGOBASICO , null imp_final, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo, NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff ';
                LV_sSql:=LV_sSql||' FROM DUAL ';
                LV_sSql:=LV_sSql||' WHERE ROWNUM = 0; ';

                OPEN SO_Planes_Hibrido FOR
                SELECT NULL cod_plantarif, NULL des_plantarif, NULL cod_limconsumo, NULL des_limconsumo, NULL cod_cargobasico, NULL des_cargobasico, NULL IMP_CARGOBASICO , null imp_final, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo, NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff
        FROM DUAL
        WHERE ROWNUM = 0;

                LV_sSql:='SELECT pdplan.cod_plantarif,';
                LV_sSql:=LV_sSql||' pdplan.des_plantarif,';
                LV_sSql:=LV_sSql||' talimc.cod_limconsumo,';
                LV_sSql:=LV_sSql||' talimc.des_limconsumo,';
                LV_sSql:=LV_sSql||' taplan.cod_cargobasico,';
                LV_sSql:=LV_sSql||' tacarg.des_cargobasico,';
                LV_sSql:=LV_sSql||' tacarg.imp_cargobasico,';
                LV_sSql:=LV_sSql||' null imp_final,';
                LV_sSql:=LV_sSql||' taplan.NUM_DIAS,';
                LV_sSql:=LV_sSql||' taplan.TIP_PLANTARIF,';
                LV_sSql:=LV_sSql||' talimc.imp_limconsumo,';
                LV_sSql:=LV_sSql||' decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,';
                LV_sSql:=LV_sSql||' decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,';
                LV_sSql:=LV_sSql||' decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff';
                LV_sSql:=LV_sSql||' FROM';
                LV_sSql:=LV_sSql||' PPD_PLANES pdplan,';
                LV_sSql:=LV_sSql||' TA_PLANTARIF taplan,';
                LV_sSql:=LV_sSql||' TA_LIMCONSUMO talimc,';
                LV_sSql:=LV_sSql||' ta_cargosbasico tacarg,';
                LV_sSql:=LV_sSql||' GA_PLANTECPLSERV planServ,';
                LV_sSql:=LV_sSql||' ta_planes_frecuentes g';
                LV_sSql:=LV_sSql||' WHERE';
                LV_sSql:=LV_sSql||' taplan.cod_producto = '||CN_producto||' ';
                LV_sSql:=LV_sSql||' AND taplan.cod_plantarif = pdplan.cod_plantarif';
                LV_sSql:=LV_sSql||' AND taplan.cod_tiplan = '||CN_prepago;
                LV_sSql:=LV_sSql||' AND taplan.cod_PRESTACION IN ('||LV_COD_PRESTACION ||' ,' || LV_COD_PRESTACION_DOS ||')';
                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN taplan.fec_desde AND NVL(taplan.fec_hasta, SYSDATE)';
                LV_sSql:=LV_sSql||' AND taplan.cod_plantarif = planServ.cod_plantarif(+)';
                LV_sSql:=LV_sSql||' AND taplan.cod_producto = planServ.cod_producto(+)';
                LV_sSql:=LV_sSql||' AND planServ.cod_tecnologia = '||EO_PlanesTarifarios.COD_TECNOLOGIA;
                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN planServ.fec_desde AND NVL(planServ.fec_hasta,SYSDATE)';
                LV_sSql:=LV_sSql||' AND pdplan.cod_plantarif = planserv.cod_plantarif';
                LV_sSql:=LV_sSql||' AND pdplan.cod_plantarif <>'||CV_AMI||' ';
                LV_sSql:=LV_sSql||' AND pdplan.ind_comercial ='||CN_uno||' ';
                LV_sSql:=LV_sSql||' AND talimc.cod_limconsumo = taplan.cod_limconsumo';
                LV_sSql:=LV_sSql||' AND tacarg.cod_cargobasico = taplan.cod_cargobasico';
                LV_sSql:=LV_sSql||' AND taplan.cla_plantarif  <> '||LV_cla_plantarif||'';
                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN tacarg.fec_desde AND NVL(tacarg.fec_hasta, SYSDATE)';
                LV_sSql:=LV_sSql||' AND taplan.cod_producto = g.cod_producto(+)';
                LV_sSql:=LV_sSql||' AND taplan.cod_plantarif = g.cod_plantarif(+)';
                LV_sSql:=LV_sSql||' ORDER BY pdplan.cod_plantarif';

                        OPEN SO_Planes_Prepago FOR
                        SELECT  pdplan.cod_plantarif,
                                        pdplan.des_plantarif,
                                        talimc.cod_limconsumo,
                                        talimc.des_limconsumo,
                                        taplan.cod_cargobasico,
                                        tacarg.des_cargobasico,
                                        tacarg.imp_cargobasico,
                                        null imp_final,
                                        taplan.NUM_DIAS,
                                        taplan.TIP_PLANTARIF,
                                        talimc.imp_limconsumo,
                                        decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,
                                        decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,
                                        decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff
                        FROM
                                    PPD_PLANES     pdplan,
                                        TA_PLANTARIF   taplan,
                                        TA_LIMCONSUMO  talimc,
                                        ta_cargosbasico tacarg,
                                        GA_PLANTECPLSERV planServ,
                                        ta_planes_frecuentes g
                        WHERE
                                taplan.cod_producto  = CN_producto
                                AND     taplan.cod_plantarif = pdplan.cod_plantarif
                                AND taplan.cod_tiplan = CN_prepago
                                AND taplan.cod_PRESTACION in ( LV_COD_PRESTACION , LV_COD_PRESTACION_DOS)
                                AND SYSDATE BETWEEN taplan.fec_desde AND NVL(taplan.fec_hasta, SYSDATE)
                                AND taplan.cod_plantarif = planServ.cod_plantarif(+)
                                AND taplan.cod_producto = planServ.cod_producto(+)
                                AND planServ.cod_tecnologia = EO_PlanesTarifarios.COD_TECNOLOGIA
                                AND SYSDATE BETWEEN planServ.fec_desde AND NVL(planServ.fec_hasta,SYSDATE)
                                AND pdplan.cod_plantarif = planserv.cod_plantarif
                                AND pdplan.cod_plantarif <> CV_AMI
                                AND pdplan.ind_comercial = CN_uno
                                AND talimc.cod_limconsumo = taplan.cod_limconsumo
                                AND tacarg.cod_cargobasico = taplan.cod_cargobasico
                                AND taplan.cla_plantarif <> LV_cla_plantarif
                                AND SYSDATE BETWEEN tacarg.fec_desde AND NVL(tacarg.fec_hasta, SYSDATE)
                                AND taplan.cod_producto  = g.cod_producto(+)
                                AND taplan.cod_plantarif = g.cod_plantarif(+)
                        ORDER BY pdplan.cod_plantarif;

                LV_sSql:='SELECT a.cod_plantarif, a.des_plantarif,';
                LV_sSql:=LV_sSql||' a.cod_limconsumo, d.des_limconsumo,';
                LV_sSql:=LV_sSql||' a.cod_cargobasico, e.des_cargobasico,';
                LV_sSql:=LV_sSql||' e.imp_cargobasico, null imp_final,';
                LV_sSql:=LV_sSql||' a.num_dias,a.tip_plantarif,d.imp_limconsumo,';
                LV_sSql:=LV_sSql||' decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,';
                LV_sSql:=LV_sSql||' decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,';
                LV_sSql:=LV_sSql||' decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff';
                LV_sSql:=LV_sSql||' FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e ,GA_PLANTECPLSERV f, ta_planes_frecuentes g';
                LV_sSql:=LV_sSql||' WHERE a.cod_producto = '||CN_producto||' ';
                LV_sSql:=LV_sSql||' AND a.cod_plantarif <>  '||CV_AMI||' ';
                LV_sSql:=LV_sSql||' AND a.cod_tiplan = '||CN_hibrido||' ';
                LV_sSql:=LV_sSql||' AND   a.cod_PRESTACION IN ('||LV_COD_PRESTACION || ',' || LV_COD_PRESTACION_DOS ||')';
                LV_sSql:=LV_sSql||' AND a.cod_plantarif = f.cod_plantarif(+)';
                LV_sSql:=LV_sSql||' AND a.cod_producto = f.cod_producto(+)';
                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN f.fec_desde AND NVL(f.fec_hasta,SYSDATE)';
                LV_sSql:=LV_sSql||' AND F.COD_TECNOLOGIA = EO_PlanesTarifarios.COD_TECNOLOGIA';
                LV_sSql:=LV_sSql||' AND d.cod_limconsumo = a.cod_limconsumo';
                LV_sSql:=LV_sSql||' AND a.cod_cargobasico = e.cod_cargobasico';
                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)';
                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta, SYSDATE)';
                LV_sSql:=LV_sSql||' AND a.cod_producto  = g.cod_producto(+)';
                LV_sSql:=LV_sSql||' AND a.cod_plantarif = g.cod_plantarif(+)';
                LV_sSql:=LV_sSql||' ORDER BY a.cod_plantarif';
                ---dbms_output.put_line('>');
                ---dbms_output.put_line(LV_sSql);
                ---dbms_output.put_line('<');

                   OPEN SO_Planes_Hibrido FOR
           SELECT a.cod_plantarif, a.des_plantarif,
                                  a.cod_limconsumo, d.des_limconsumo,
                                  a.cod_cargobasico, e.des_cargobasico,
                                  e.imp_cargobasico, null imp_final,
                                  a.num_dias,a.tip_plantarif,d.imp_limconsumo,
                                  decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,
                                  decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,
                                  decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff
                        FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e ,GA_PLANTECPLSERV f, ta_planes_frecuentes g
                        WHERE a.cod_producto = CN_producto
                                AND a.cod_plantarif <> CV_AMI
                                AND a.cod_tiplan = CN_hibrido
                                AND   a.cod_PRESTACION in ( LV_COD_PRESTACION , LV_COD_PRESTACION_DOS )
                                AND a.cod_plantarif = f.cod_plantarif(+)
                                AND a.cod_producto = f.cod_producto(+)
                                AND SYSDATE BETWEEN f.fec_desde AND NVL(f.fec_hasta,SYSDATE)
                                AND F.COD_TECNOLOGIA = EO_PlanesTarifarios.COD_TECNOLOGIA
                                AND d.cod_limconsumo = a.cod_limconsumo
                                AND a.cod_cargobasico = e.cod_cargobasico
                                AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)
                                AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta, SYSDATE)
                                AND a.cod_producto  = g.cod_producto(+)
                                AND a.cod_plantarif = g.cod_plantarif(+)
                        ORDER BY a.cod_plantarif;

        EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_OBTIENE_PLANES_PREPAGO_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
                  SV_mens_retorno := 'PV_OBTIENE_PLANES_PREPAGO_PR Prepago='||SV_mens_retorno;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_PLANES_PREPAGO_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_PREPAGO', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_PLANES_PREPAGO_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_PREPAGO', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_PLANES_PREPAGO_PR;
--------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_PLANES_PREPAGO_PR_C(
      EO_PlanesTarifarios       IN           PV_PLANES_TARIFARIOS_QT,
      EV_Cod_Califica           IN           pv_calificacion_td.COD_CALIFICA%TYPE,
      SO_Planes_Prepago     OUT NOCOPY       refCursor,
      SO_Planes_Hibrido     OUT NOCOPY       refCursor,
      SN_cod_retorno        OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno       OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento         OUT NOCOPY       ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_PLANES_PPEPAGO_PR"
              Lenguaje="PL/SQL"
              Fecha="04-06-2007"
              Versión="La del package"
              Diseñador="Matías Guajardo"
              Programador="Matías Guajardo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="" Tipo="estructura"></param>>
                 </Entrada>
                 <Salida>
                    <param nom="" Tipo=""></param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_des_error           ge_errores_pg.DesEvent;
        LV_sSql                        ge_errores_pg.vQuery;
        LV_cla_plantarif           ta_plantarif.CLA_PLANTARIF%TYPE;
        EO_GED_PARAMETROS          PV_GED_PARAMETROS_QT;
        ERROR_EJECUCION            EXCEPTION;
        LV_COD_PRESTACION      VARCHAR2(10);
        LV_COD_PRESTACION_DOS  VARCHAR2(10);
        BEGIN

            SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento       := 0;
            LV_COD_PRESTACION := '';
            LV_COD_PRESTACION_DOS := '';

            SELECT  COD_PRESTACION
            INTO LV_COD_PRESTACION
            FROM GA_aboamist
            WHERE NUM_ABONADO  =EO_PlanesTarifarios.NUM_ABONADO
            union
            SELECT  COD_PRESTACION
            FROM GA_abocel
            WHERE NUM_ABONADO  =EO_PlanesTarifarios.NUM_ABONADO;

            LV_COD_PRESTACION_DOS := LV_COD_PRESTACION;


    /*    ini adc -30-05-2011 170614
       
            IF LV_COD_PRESTACION = '01' THEN
                LV_COD_PRESTACION_DOS := '22';
            ELSIF LV_COD_PRESTACION = '04' THEN
                LV_COD_PRESTACION_DOS := '23';
            ELSIF LV_COD_PRESTACION = '05' THEN
                LV_COD_PRESTACION_DOS := '24';
            ELSIF LV_COD_PRESTACION = '22' THEN
                LV_COD_PRESTACION_DOS := '01';
            ELSIF LV_COD_PRESTACION = '23' THEN
                LV_COD_PRESTACION_DOS := '04';
            ELSIF LV_COD_PRESTACION = '24' THEN
                LV_COD_PRESTACION_DOS := '05';
            END IF;   */
              
             SELECT ASOCDESTINO INTO  LV_COD_PRESTACION_DOS
             FROM GE_ASOCPRESTACIONES_TD
             WHERE ASOCORIGEN = LV_COD_PRESTACION
             AND USO = CN_prepago ;
             
         --  FIN adc -30-05-2011 170614
                        
---dbms_output.put_line(LV_COD_PRESTACION);
                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                EO_GED_PARAMETROS.NOM_PARAMETRO:= 'TIPO_PLAN_SERVICIO';
                EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;

        LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR ('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                LV_cla_plantarif := EO_GED_PARAMETROS.VAL_PARAMETRO;
                IF SN_cod_retorno <> 0 THEN
                   RAISE ERROR_EJECUCION;
                END IF;

                LV_sSql:='';
                LV_sSql:=LV_sSql||' SELECT NULL cod_plantarif, NULL des_plantarif, NULL cod_limconsumo, NULL des_limconsumo, NULL cod_cargobasico, NULL des_cargobasico, NULL IMP_CARGOBASICO , null imp_final, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo , NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff';
                LV_sSql:=LV_sSql||' FROM DUAL              ';
                LV_sSql:=LV_sSql||' WHERE ROWNUM = 0;      ';
---dbms_output.put_line(LV_sSql);
                OPEN SO_Planes_Prepago FOR
                SELECT NULL cod_plantarif, NULL des_plantarif, NULL cod_limconsumo, NULL des_limconsumo, NULL cod_cargobasico, NULL des_cargobasico, NULL IMP_CARGOBASICO , null imp_final, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo, NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff
                FROM DUAL
                WHERE ROWNUM = 0;

                LV_sSql:='SELECT NULL cod_plantarif, NULL des_plantarif, NULL cod_limconsumo, NULL des_limconsumo, NULL cod_cargobasico, NULL des_cargobasico, NULL IMP_CARGOBASICO , null imp_final, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo, NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff ';
                LV_sSql:=LV_sSql||' FROM DUAL ';
                LV_sSql:=LV_sSql||' WHERE ROWNUM = 0; ';

                OPEN SO_Planes_Hibrido FOR
                SELECT NULL cod_plantarif, NULL des_plantarif, NULL cod_limconsumo, NULL des_limconsumo, NULL cod_cargobasico, NULL des_cargobasico, NULL IMP_CARGOBASICO , null imp_final, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo, NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff
                FROM DUAL
                WHERE ROWNUM = 0;

                LV_sSql:='SELECT pdplan.cod_plantarif,';
                LV_sSql:=LV_sSql||' pdplan.des_plantarif,';
                LV_sSql:=LV_sSql||' talimc.cod_limconsumo,';
                LV_sSql:=LV_sSql||' talimc.des_limconsumo,';
                LV_sSql:=LV_sSql||' taplan.cod_cargobasico,';
                LV_sSql:=LV_sSql||' tacarg.des_cargobasico,';
                LV_sSql:=LV_sSql||' tacarg.imp_cargobasico,';
                LV_sSql:=LV_sSql||' null imp_final,';
                LV_sSql:=LV_sSql||' taplan.NUM_DIAS,';
                LV_sSql:=LV_sSql||' taplan.TIP_PLANTARIF,';
                LV_sSql:=LV_sSql||' talimc.imp_limconsumo,';
                LV_sSql:=LV_sSql||' decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,';
                LV_sSql:=LV_sSql||' decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,';
                LV_sSql:=LV_sSql||' decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff';
                LV_sSql:=LV_sSql||' FROM';
                LV_sSql:=LV_sSql||' PPD_PLANES pdplan,';
                LV_sSql:=LV_sSql||' TA_PLANTARIF taplan,';
                LV_sSql:=LV_sSql||' TA_LIMCONSUMO talimc,';
                LV_sSql:=LV_sSql||' ta_cargosbasico tacarg,';
                LV_sSql:=LV_sSql||' GA_PLANTECPLSERV planServ,';
                LV_sSql:=LV_sSql||' ta_planes_frecuentes g';
                LV_sSql:=LV_sSql||' WHERE';
                LV_sSql:=LV_sSql||' taplan.cod_producto = '||CN_producto||' ';
                LV_sSql:=LV_sSql||' AND taplan.cod_plantarif = pdplan.cod_plantarif';
                LV_sSql:=LV_sSql||' AND taplan.cod_tiplan = '||CN_prepago;
                LV_sSql:=LV_sSql||' AND taplan.cod_PRESTACION IN ('||LV_COD_PRESTACION ||' ,' || LV_COD_PRESTACION_DOS ||')';
                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN taplan.fec_desde AND NVL(taplan.fec_hasta, SYSDATE)';
                LV_sSql:=LV_sSql||' AND taplan.cod_plantarif = planServ.cod_plantarif(+)';
                LV_sSql:=LV_sSql||' AND taplan.cod_producto = planServ.cod_producto(+)';
                LV_sSql:=LV_sSql||' AND planServ.cod_tecnologia = '||EO_PlanesTarifarios.COD_TECNOLOGIA;
                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN planServ.fec_desde AND NVL(planServ.fec_hasta,SYSDATE)';
                LV_sSql:=LV_sSql||' AND pdplan.cod_plantarif = planserv.cod_plantarif';
                LV_sSql:=LV_sSql||' AND pdplan.cod_plantarif <>'||CV_AMI||' ';
                LV_sSql:=LV_sSql||' AND pdplan.ind_comercial ='||CN_uno||' ';
                LV_sSql:=LV_sSql||' AND talimc.cod_limconsumo = taplan.cod_limconsumo';
                LV_sSql:=LV_sSql||' AND tacarg.cod_cargobasico = taplan.cod_cargobasico';
                LV_sSql:=LV_sSql||' AND taplan.cla_plantarif  <> '||LV_cla_plantarif||'';
                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN tacarg.fec_desde AND NVL(tacarg.fec_hasta, SYSDATE)';
                LV_sSql:=LV_sSql||' AND taplan.cod_producto = g.cod_producto(+)';
                LV_sSql:=LV_sSql||' AND taplan.cod_plantarif = g.cod_plantarif(+)';
                LV_sSql:=LV_sSql||' ORDER BY pdplan.cod_plantarif';

                        OPEN SO_Planes_Prepago FOR
                        SELECT  pdplan.cod_plantarif,
                                        pdplan.des_plantarif,
                                        talimc.cod_limconsumo,
                                        talimc.des_limconsumo,
                                        taplan.cod_cargobasico,
                                        tacarg.des_cargobasico,
                                        tacarg.imp_cargobasico,
                                        null imp_final,
                                        taplan.NUM_DIAS,
                                        taplan.TIP_PLANTARIF,
                                        talimc.imp_limconsumo,
                                        decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,
                                        decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,
                                        decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff
                        FROM
                                    PPD_PLANES     pdplan,
                                        TA_PLANTARIF   taplan,
                                        TA_LIMCONSUMO  talimc,
                                        ta_cargosbasico tacarg,
                                        GA_PLANTECPLSERV planServ,
                                        ta_planes_frecuentes g
                        WHERE
                                taplan.cod_producto  = CN_producto
                                AND     taplan.cod_plantarif = pdplan.cod_plantarif
                                AND taplan.cod_tiplan = CN_prepago
                                AND taplan.cod_PRESTACION in ( LV_COD_PRESTACION , LV_COD_PRESTACION_DOS)
                                AND SYSDATE BETWEEN taplan.fec_desde AND NVL(taplan.fec_hasta, SYSDATE)
                                AND taplan.cod_plantarif = planServ.cod_plantarif(+)
                                AND taplan.cod_producto = planServ.cod_producto(+)
                                AND planServ.cod_tecnologia = EO_PlanesTarifarios.COD_TECNOLOGIA
                                AND SYSDATE BETWEEN planServ.fec_desde AND NVL(planServ.fec_hasta,SYSDATE)
                                AND pdplan.cod_plantarif = planserv.cod_plantarif
                                AND pdplan.cod_plantarif <> CV_AMI
                                AND pdplan.ind_comercial = CN_uno
                                AND talimc.cod_limconsumo = taplan.cod_limconsumo
                                AND tacarg.cod_cargobasico = taplan.cod_cargobasico
                                AND taplan.cla_plantarif <> LV_cla_plantarif
                                AND SYSDATE BETWEEN tacarg.fec_desde AND NVL(tacarg.fec_hasta, SYSDATE)
                                AND taplan.cod_producto  = g.cod_producto(+)
                                AND taplan.cod_plantarif = g.cod_plantarif(+)
                        ORDER BY pdplan.cod_plantarif;

                LV_sSql:='SELECT a.cod_plantarif, a.des_plantarif,';
                LV_sSql:=LV_sSql||' a.cod_limconsumo, d.des_limconsumo,';
                LV_sSql:=LV_sSql||' a.cod_cargobasico, e.des_cargobasico,';
                LV_sSql:=LV_sSql||' e.imp_cargobasico, null imp_final,';
                LV_sSql:=LV_sSql||' a.num_dias,a.tip_plantarif,d.imp_limconsumo,';
                LV_sSql:=LV_sSql||' decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,';
                LV_sSql:=LV_sSql||' decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,';
                LV_sSql:=LV_sSql||' decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff';
                LV_sSql:=LV_sSql||' FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e ,GA_PLANTECPLSERV f, ta_planes_frecuentes g';
                LV_sSql:=LV_sSql||' WHERE a.cod_producto = '||CN_producto||' ';
                LV_sSql:=LV_sSql||' AND a.cod_plantarif <>  '||CV_AMI||' ';
                LV_sSql:=LV_sSql||' AND a.cod_tiplan = '||CN_hibrido||' ';
                LV_sSql:=LV_sSql||' AND   a.cod_PRESTACION IN ('||LV_COD_PRESTACION || ',' || LV_COD_PRESTACION_DOS ||')';
                LV_sSql:=LV_sSql||' AND a.cod_plantarif = f.cod_plantarif(+)';
                LV_sSql:=LV_sSql||' AND a.cod_producto = f.cod_producto(+)';
                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN f.fec_desde AND NVL(f.fec_hasta,SYSDATE)';
                LV_sSql:=LV_sSql||' AND F.COD_TECNOLOGIA = EO_PlanesTarifarios.COD_TECNOLOGIA';
                LV_sSql:=LV_sSql||' AND d.cod_limconsumo = a.cod_limconsumo';
                LV_sSql:=LV_sSql||' AND a.cod_cargobasico = e.cod_cargobasico';
                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)';
                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta, SYSDATE)';
                LV_sSql:=LV_sSql||' AND a.cod_producto  = g.cod_producto(+)';
                LV_sSql:=LV_sSql||' AND a.cod_plantarif = g.cod_plantarif(+)';
                LV_sSql:=LV_sSql||' ORDER BY a.cod_plantarif';
                ---dbms_output.put_line('>');
                ---dbms_output.put_line(LV_sSql);
                ---dbms_output.put_line('<');

           OPEN SO_Planes_Hibrido FOR
           SELECT a.cod_plantarif, a.des_plantarif,
                                  a.cod_limconsumo, d.des_limconsumo,
                                  a.cod_cargobasico, e.des_cargobasico,
                                  e.imp_cargobasico, null imp_final,
                                  a.num_dias,a.tip_plantarif,d.imp_limconsumo,
                                  decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,
                                  decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,
                                  decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff
                        FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e ,GA_PLANTECPLSERV f, ta_planes_frecuentes g,
                        pv_califica_celular_to cc, pv_califica_plan_tarif_to cp, pv_calificacion_td c
                        WHERE a.cod_producto = CN_producto
                                AND a.cod_plantarif <> CV_AMI
                                AND a.cod_tiplan = CN_hibrido
                                AND   a.cod_PRESTACION in ( LV_COD_PRESTACION , LV_COD_PRESTACION_DOS )
                                AND a.cod_plantarif = f.cod_plantarif(+)
                                AND a.cod_producto = f.cod_producto(+)
                                AND SYSDATE BETWEEN f.fec_desde AND NVL(f.fec_hasta,SYSDATE)
                                AND F.COD_TECNOLOGIA = EO_PlanesTarifarios.COD_TECNOLOGIA
                                AND d.cod_limconsumo = a.cod_limconsumo
                                AND a.cod_cargobasico = e.cod_cargobasico
                                AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)
                                AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta, SYSDATE)
                                AND a.cod_producto  = g.cod_producto(+)
                                AND a.cod_plantarif = g.cod_plantarif(+)
                                AND a.cod_producto=1-- revisar, ya hay un AND a.cod_producto = e.cod_producto(+)
                                AND c.cod_califica=EV_Cod_Califica
                                AND c.cod_califica=cp.cod_califica
                                AND cc.cod_califica=cp.cod_califica
                                AND a.cod_plantarif=cp.cod_plantarif
                                AND cc.vigencia=1
                                AND cp.vigencia=1
                                AND cc.num_abonado =  EO_PlanesTarifarios.num_abonado
                        ORDER BY a.cod_plantarif;


        EXCEPTION
        WHEN ERROR_EJECUCION THEN
              LV_des_error   := 'PV_OBTIENE_PLANES_PREPAGO_PR_C(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
                  SV_mens_retorno := 'PV_OBTIENE_PLANES_PREPAGO_PR_C Prepago='||SV_mens_retorno;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_PLANES_PREPAGO_PR_C(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_PREPAGO_PR_C', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_PLANES_PREPAGO_PR_C(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_PREPAGO_PR_C', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_PLANES_PREPAGO_PR_C;
--------------------------------------------------------------------------------------------------------
FUNCTION PV_obtiene_permisos_FN(EV_usuario               IN                     ge_seg_grpusuario.nom_usuario%TYPE,
                                                    SN_cod_retorno   OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                                    SV_mens_retorno  OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                                    SN_num_evento    OUT NOCOPY         ge_errores_pg.evento)
        RETURN BOOLEAN
        AS
        /*
        <Documentacion TipoDoc = "Funcion">
        <Elemento Nombre = "PV_obtiene_permisos_FN"
         Lenguaje="PL/SQL" Fecha="12-04-2005"
         Versión"1.0.0" Diseñador"****"
         Programador="" Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripcion>Chequea si el Clientes es empresa</Descripcion>
        <Parametros>
        <Entrada>
                        <param nom="EV_usuario"    Tipo=" ge_seg_grpusuario.nom_usuario%TYPE "> </param>>
        </Entrada>
        <Salida>
           <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
           <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
           <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        */
        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql                    ge_errores_pg.vQuery;
        LV_SubVersion      ge_programas.num_subversion%TYPE;
        LN_numversion      ge_programas.num_version%TYPE;
        LV_cod_proceso     gad_procesos_perfiles.cod_proceso%TYPE;
        LV_proceso                 ge_seg_perfiles.cod_proceso%TYPE;
        ERROR_EJECUCION    EXCEPTION;

        BEGIN
            SN_cod_retorno := 0;
            SV_mens_retorno:= NULL;
            SN_num_evento  := 0;

                LV_cod_proceso := PV_obtiene_codproceso_FN(SN_cod_retorno, SV_mens_retorno, SN_num_evento);

        IF LV_cod_proceso Is Not Null THEN

                        LV_sSql:='';
                        LV_sSql:=LV_sSql||' PV_GENERALES_PG.PV_obtiene_version_FN('||to_char(LN_numVersion)||', '||to_char(LV_SubVersion)||','||SN_cod_retorno||', SV_mens_retorno, '||to_char(SN_num_evento)||') ';
                        IF PV_GENERALES_PG.PV_obtiene_version_FN(LN_numVersion,LV_SubVersion,SN_cod_retorno, SV_mens_retorno, SN_num_evento)=TRUE THEN
                            IF SN_cod_retorno>0 THEN
                                        RAISE ERROR_EJECUCION;
                                END IF;

                                LV_sSql:='';
                                LV_sSql:=LV_sSql||' SELECT A.COD_PROCESO                                 ';
                                LV_sSql:=LV_sSql||' INTO LV_proceso                                      ';
                                LV_sSql:=LV_sSql||' FROM GE_SEG_PERFILES A, GE_SEG_GRPUSUARIO B                  ';
                                LV_sSql:=LV_sSql||' WHERE A.COD_GRUPO  = B.COD_GRUPO                                     ';
                                LV_sSql:=LV_sSql||' AND B.NOM_USUARIO  = '||EV_usuario||'                                ';
                                LV_sSql:=LV_sSql||' AND A.COD_PROGRAMA = '||CV_programa||'               ';
                                LV_sSql:=LV_sSql||' AND A.NUM_VERSION  = '||to_char(LN_numVersion)||'    ';
                                LV_sSql:=LV_sSql||' AND A.COD_PROCESO  = '||LV_cod_proceso||'            ';
                                LV_sSql:=LV_sSql||' AND ROWNUM ='||to_char(CN_uno)||';                   ';


                                SELECT A.COD_PROCESO
                                INTO LV_proceso
                                 FROM GE_SEG_PERFILES A, GE_SEG_GRPUSUARIO B
                                  WHERE A.COD_GRUPO  = B.COD_GRUPO
                                                AND B.NOM_USUARIO  = EV_usuario             -- por parámetro
                                                AND A.COD_PROGRAMA = CV_programa                   --por parametro
                                                AND A.NUM_VERSION  = LN_numVersion      --se obtiene de una funcion previa
                                                AND A.COD_PROCESO  = LV_cod_proceso     --variable que se obtiene de la query anterior
                                                AND ROWNUM = CN_uno;

                                RETURN TRUE;
                    ELSE
                                RETURN FALSE;
                        END IF;
                ELSE
                        RAISE ERROR_EJECUCION;
                END IF;

    EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_obtiene_permisos_FN(('||EV_usuario||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_obtiene_permisos_FN(', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
        WHEN NO_DATA_FOUND THEN
                  RETURN FALSE;
    WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_obtiene_permisos_FN('||EV_usuario||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_obtiene_permisos_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;

END PV_obtiene_permisos_FN;

--------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_PLANES_POSPAGO_PR(EO_PlanesTarifarios          IN               PV_PLANES_TARIFARIOS_QT,
                                                                           SO_Planes_Pospago        OUT NOCOPY           refCursor,
                                                                           SO_Planes_Pospago_Rango  OUT NOCOPY           refCursor,
                                                                       SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                                                                       SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                                                                       SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_PLANES_POSPAGO_PR"
              Lenguaje="PL/SQL"
              Fecha="04-06-2007"
              Versión="La del package"
              Diseñador="Matías Guajardo"
              Programador="Matías Guajardo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="" Tipo="estructura"></param>>
                 </Entrada>
                 <Salida>
                    <param nom="" Tipo=""></param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_des_error           ge_errores_pg.DesEvent;
        LV_sSql                        ge_errores_pg.vQuery;
        ERROR_EJECUCION        EXCEPTION;
        LV_Tipo_PlanTarifario  ga_abocel.tip_plantarif%TYPE;
        LV_Plan_Tarifario      ta_plantarif.cod_plantarif%TYPE;
        LV_tip_unitas              ta_plantarif.tip_unitas%TYPE;
        LV_USUARORA                        ge_seg_grpusuario.nom_usuario%TYPE;
        LV_COD_USO                         al_usos.COD_USO%TYPE;
        LV_COD_PLANTARIF_EVAL  ert_solicitud_planes.cod_plantarif%TYPE;
        LN_Permisos                        NUMBER (09);
        LV_RestPlan                        VARCHAR2(07);
        LN_CambioPlan              NUMBER (1);
        LV_cla_plantarif           ta_plantarif.CLA_PLANTARIF%TYPE;
        EO_GED_PARAMETROS          PV_GED_PARAMETROS_QT;
        LV_COD_PRESTACION      VARCHAR2(10);
        LV_COD_PRESTACION_DOS  VARCHAR2(10);

        BEGIN

                SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento       := 0;

            LV_COD_PRESTACION := '';
            LV_COD_PRESTACION_DOS := '';

            SELECT  COD_PRESTACION
            INTO LV_COD_PRESTACION
            FROM GA_ABOCEL
            WHERE NUM_ABONADO  =EO_PlanesTarifarios.NUM_ABONADO
            UNION
            SELECT  COD_PRESTACION
            FROM GA_ABOAMIST
            WHERE NUM_ABONADO  =EO_PlanesTarifarios.NUM_ABONADO;

          LV_COD_PRESTACION_DOS := LV_COD_PRESTACION;

            /* ini 161341
            IF LV_COD_PRESTACION = '01' THEN
                LV_COD_PRESTACION_DOS := '22';
            ELSIF LV_COD_PRESTACION = '04' THEN
                LV_COD_PRESTACION_DOS := '23';
            ELSIF LV_COD_PRESTACION = '05' THEN
                LV_COD_PRESTACION_DOS := '24';
            ELSIF LV_COD_PRESTACION = '22' THEN
                LV_COD_PRESTACION_DOS := '01';
            ELSIF LV_COD_PRESTACION = '23' THEN
                LV_COD_PRESTACION_DOS := '04';
            ELSIF LV_COD_PRESTACION = '24' THEN
                LV_COD_PRESTACION_DOS := '05';
            END IF;*/
            
          /*   INI   ADC 30-05-2011  170614 
            
            IF LV_COD_PRESTACION = '05' THEN
            
                LV_COD_PRESTACION_DOS := '42';
                
            ELSIF LV_COD_PRESTACION = '30' THEN
            
                LV_COD_PRESTACION_DOS := '24';
                
            ELSIF LV_COD_PRESTACION = '31' THEN
            
                LV_COD_PRESTACION_DOS := '43';
                
            ELSIF LV_COD_PRESTACION = '04' THEN
            
                LV_COD_PRESTACION_DOS := '38';
                
            ELSIF LV_COD_PRESTACION = '01' THEN
            
                LV_COD_PRESTACION_DOS := '22';
                
            ELSIF LV_COD_PRESTACION = '22' THEN
            
                LV_COD_PRESTACION_DOS := '01';
                
            ELSIF LV_COD_PRESTACION = '38' THEN
            
                LV_COD_PRESTACION_DOS := '04';
                
            ELSIF LV_COD_PRESTACION = '43' THEN
            
                LV_COD_PRESTACION_DOS := '31';
                
            ELSIF LV_COD_PRESTACION = '24' THEN
            
                LV_COD_PRESTACION_DOS := '30';
                
            ELSIF LV_COD_PRESTACION = '42' THEN
            
                LV_COD_PRESTACION_DOS := '05';
                
            ELSIF LV_COD_PRESTACION = '37' THEN
            
                LV_COD_PRESTACION_DOS := '29';    
                
            ELSIF LV_COD_PRESTACION = '29' THEN
            
                LV_COD_PRESTACION_DOS := '37';    
                                
            END IF;
            --fin 161341 
            
            */
            
            SELECT ASOCDESTINO INTO  LV_COD_PRESTACION_DOS
             FROM GE_ASOCPRESTACIONES_TD
             WHERE ASOCORIGEN = LV_COD_PRESTACION
             AND USO = CN_pospago ;
      
        --  FIN INI   ADC 30-05-2011  170614   
            
            

                LV_Tipo_PlanTarifario := EO_PlanesTarifarios.tip_plantarif;

                LV_sSql:='SELECT NULL COD_PLANTARIF, NULL DES_PLANTARIF, NULL COD_LIMCONSUMO, NULL DES_LIMCONSUMO, NULL COD_CARGOBASICO, NULL DES_CARGOBASICO, NULL IMP_CARGOBASICO , null imp_final, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo , NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff';
                LV_sSql:=LV_sSql||'  FROM DUAL ';
                LV_sSql:=LV_sSql||'  WHERE ROWNUM = 0; ';

                OPEN SO_Planes_Pospago FOR
                SELECT NULL COD_PLANTARIF, NULL DES_PLANTARIF, NULL COD_LIMCONSUMO, NULL DES_LIMCONSUMO, NULL COD_CARGOBASICO, NULL DES_CARGOBASICO, NULL IMP_CARGOBASICO , null imp_final, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo, NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff
        FROM DUAL
        WHERE ROWNUM = 0;
                LV_sSql:='SELECT NULL COD_PLANTARIF, NULL DES_PLANTARIF, NULL cod_limconsumo, NULL des_limconsumo,NULL cargo_basico, NULL des_cargobasico, NULL IMP_INICIAL, NULL IMP_FINAL, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo, NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff ';
                LV_sSql:=LV_sSql||'  FROM DUAL ';
                LV_sSql:=LV_sSql||'  WHERE ROWNUM = 0; ';

                OPEN SO_Planes_Pospago_Rango FOR
                SELECT NULL COD_PLANTARIF, NULL DES_PLANTARIF, NULL cod_limconsumo, NULL des_limconsumo,NULL cargo_basico, NULL des_cargobasico, NULL IMP_INICIAL, NULL IMP_FINAL, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo, NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff
        FROM DUAL
        WHERE ROWNUM = 0;
                -- LN_Permisos:=0; -- INC 75083; AVC; 30-12-2008
                LN_Permisos:=1; -- INC 75083; AVC; 30-12-2008

                LV_sSql:='PV_obtiene_permisos_FN('||EO_PlanesTarifarios.NOM_USUARORA||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                IF PV_obtiene_permisos_FN(EO_PlanesTarifarios.NOM_USUARORA, SN_cod_retorno, SV_mens_retorno, SN_num_evento)  THEN
                    IF SN_cod_retorno>0 THEN
                                        RAISE ERROR_EJECUCION;
                        ELSE
                                -- LN_Permisos:=1; -- INC 75083; AVC; 30-12-2008
                                LN_Permisos:=0; -- INC 75083; AVC; 30-12-2008
                        END IF;
                END IF;
                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                EO_GED_PARAMETROS.NOM_PARAMETRO:= 'TIPO_PLAN_SERVICIO';
                EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;

        LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR ('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                LV_cla_plantarif := EO_GED_PARAMETROS.VAL_PARAMETRO;
                IF SN_cod_retorno <> 0 THEN
                   RAISE ERROR_EJECUCION;
                END IF;
                BEGIN
                        LV_sSql:='SELECT TIP_UNITAS INTO LV_tip_unitas FROM TA_PLANTARIF WHERE COD_PLANTARIF ='||EO_PlanesTarifarios.COD_PLANTARIF||'; ';
                        SELECT TIP_UNITAS INTO LV_tip_unitas
                        FROM TA_PLANTARIF
                        WHERE COD_PLANTARIF = EO_PlanesTarifarios.COD_PLANTARIF;

                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                         LV_tip_unitas := NULL;
                END;

                IF LV_Tipo_PlanTarifario ='E' THEN
                                LV_USUARORA := EO_PlanesTarifarios.NOM_USUARORA;

                                IF EO_PlanesTarifarios.CAMBIO_PLANFAMILIAR = 'TRUE' THEN
                                   LN_CambioPlan := 1;
                                ELSE
                                   LN_CambioPlan := 0;
                                END IF;

                                                LV_sSql:='SELECT  a.cod_plantarif, a.des_plantarif, a.cod_limconsumo, d.des_limconsumo, ';
                                                LV_sSql:=LV_sSql||' a.cod_cargobasico, e.des_cargobasico, e.imp_cargobasico , null imp_final,a.num_dias,a.tip_plantarif,d.imp_limconsumo ';
                                                LV_sSql:=LV_sSql||' FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e ,GA_PLANTECPLSERV f';
                                                LV_sSql:=LV_sSql||' WHERE a.COD_PRODUCTO = '||CN_producto||' ';
                                                LV_sSql:=LV_sSql||' AND a.TIP_PLANTARIF = '||LV_Tipo_PlanTarifario||' ';
                                                LV_sSql:=LV_sSql||' AND a.cod_tiplan = '||CN_pospago||' ';
                                                LV_sSql:=LV_sSql||' AND a.cod_PRESTACION IN  ('|| LV_COD_PRESTACION || ',' || LV_COD_PRESTACION_DOS ||')';
                                                LV_sSql:=LV_sSql||' AND a.cod_plantarif = f.cod_plantarif(+)';
                                                LV_sSql:=LV_sSql||' AND a.cod_producto = f.cod_producto(+)';
                                                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN f.fec_desde AND NVL(f.fec_hasta,SYSDATE)';
                                                LV_sSql:=LV_sSql||' AND f.cod_tecnologia = EO_PlanesTarifarios.cod_tecnologia';
                                                LV_sSql:=LV_sSql||' AND d.cod_limconsumo = a.cod_limconsumo';
                                                LV_sSql:=LV_sSql||' AND a.cod_cargobasico = e.cod_cargobasico';
                                                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN e.fec_desde     AND NVL(e.fec_hasta, SYSDATE)';
                                                LV_sSql:=LV_sSql||' AND a.cla_plantarif <> '||LV_cla_plantarif||'';
                                                LV_sSql:=LV_sSql||' AND ('||LN_CambioPlan||' = decode('||LN_CambioPlan||',1, ';
                                                LV_sSql:=LV_sSql||' (SELECT case a.IND_FAMILIAR WHEN 1 Then 1 else 0 End from dual WHERE a.IND_FAMILIAR=1),  ';
                                                LV_sSql:=LV_sSql||' (SELECT case a.IND_FAMILIAR WHEN 0 Then 0 else 1 End from dual WHERE a.IND_FAMILIAR=0)   ';
                                                LV_sSql:=LV_sSql||' ))  ';
                                                LV_sSql:=LV_sSql||' AND ('||LN_Permisos||' = decode('||LN_Permisos||',1,  ';
                                                LV_sSql:=LV_sSql||' (SELECT case sysdate  WHEN sysdate Then 1 else 0 End from dual WHERE SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA,SYSDATE)  ';
                                                LV_sSql:=LV_sSql||' AND  ('||LV_tip_unitas||' = decode('||LV_tip_unitas||',''S'',    ';
                                                LV_sSql:=LV_sSql||' (SELECT case ''S''  WHEN ''S'' Then ''S'' else  A.TIP_UNITAS End from dual WHERE A.TIP_UNITAS=''S''),   ';
                                                LV_sSql:=LV_sSql||' '||LV_tip_unitas|| ' ';
                                                LV_sSql:=LV_sSql||' ))), ';
                                                LV_sSql:=LV_sSql||' '||LN_Permisos||'))';
                                                LV_sSql:=LV_sSql||' ORDER BY a.cod_plantarif;  ';

                                                OPEN SO_Planes_Pospago FOR
                                                 SELECT  a.cod_plantarif,
                                                                 a.des_plantarif,
                                                                 a.cod_limconsumo,
                                                                 d.des_limconsumo,
                                                                 a.cod_cargobasico,
                                                                 e.des_cargobasico,
                                                                 e.imp_cargobasico,
                                                                 null imp_final,
                                                                 a.num_dias,a.tip_plantarif,d.imp_limconsumo,
                                                                 decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,
                                                                 decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,
                                                                 decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff
                                                        FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e ,GA_PLANTECPLSERV f, ta_planes_frecuentes g
                                                        WHERE a.cod_producto = CN_producto
                                                                AND a.tip_plantarif = LV_Tipo_PlanTarifario
                                                                AND a.cod_tiplan = CN_pospago
                                                                AND A.COD_PRESTACION in ( LV_COD_PRESTACION , LV_COD_PRESTACION_DOS )
                                                                AND a.cod_plantarif = f.cod_plantarif(+)
                                                                AND a.cod_producto = f.cod_producto(+)
                                                                AND SYSDATE BETWEEN f.fec_desde AND NVL(f.fec_hasta,SYSDATE)
                                                                AND f.cod_tecnologia = EO_PlanesTarifarios.cod_tecnologia
                                                                AND d.cod_limconsumo = a.cod_limconsumo
                                                                AND a.cod_cargobasico = e.cod_cargobasico
                                                                AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta, SYSDATE)
                                                                AND a.cla_plantarif <> LV_cla_plantarif
                                                                AND (LN_CambioPlan = decode(LN_CambioPlan,1,
                                                                        (SELECT case a.ind_familiar WHEN 1 Then 1 else 0 End from dual WHERE a.IND_FAMILIAR=1),
                                                                        (SELECT case a.ind_familiar WHEN 0 Then 0 else 1 End from dual WHERE a.IND_FAMILIAR=0)
                                                                                ))
                                                AND (LN_Permisos = decode(LN_Permisos,1,
                                                                   (SELECT case sysdate  WHEN sysdate Then 1 else 0 End from dual WHERE SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA,SYSDATE)
                                                                                                                  AND  (LV_tip_unitas = decode(LV_tip_unitas,'S',
                                                                                                           (SELECT case 'S'  WHEN 'S' Then 'S' else  A.TIP_UNITAS End from dual WHERE A.TIP_UNITAS='S'),
                                                                                                                           LV_tip_unitas
                                                                                                                ))),
                                                                                LN_Permisos))
                                                                AND a.cod_producto  = g.cod_producto(+)
                                                                AND a.cod_plantarif = g.cod_plantarif(+)
                                                        ORDER BY a.cod_plantarif;

                                LV_sSql:='';
                                LV_sSql:=LV_sSql||' SELECT distinct lpad(a.cod_plantarif,3) , a.des_plantarif' || ' { ' || 'b.imp_inicial' || ' - ';
                                LV_sSql:=LV_sSql||' d.cod_limconsumo,   ';
                                LV_sSql:=LV_sSql||' d.des_limconsumo,   ';
                                LV_sSql:=LV_sSql||' NULL cargo_basico,     ';
                                LV_sSql:=LV_sSql||' NULL des_cargobasico,  ';
                                LV_sSql:=LV_sSql||' b.imp_inicial, b.imp_final,a.num_dias,a.tip_plantarif,d.imp_limconsumo ';
                                LV_sSql:=LV_sSql||' FROM ta_plantarif a, ta_rango_planes_td b ,ta_limconsumo d, ta_cargosbasico c , GA_PLANTECPLSERV e';
                                LV_sSql:=LV_sSql||' WHERE a.cod_producto = b.cod_producto ';
                                LV_sSql:=LV_sSql||' AND a.cod_plantarif = b.cod_plantarif ';
                                LV_sSql:=LV_sSql||' AND a.cod_plantarif = e.cod_plantarif(+)';
                                LV_sSql:=LV_sSql||' AND a.cod_producto = e.cod_producto(+)';
                                LV_sSql:=LV_sSql||' AND   a.cod_tiplan = '||CN_pospago||' ';
                                LV_sSql:=LV_sSql||' AND   a.cod_PRESTACION IN ('||LV_COD_PRESTACION || ',' || LV_COD_PRESTACION_DOS ||')';
                                LV_sSql:=LV_sSql||' AND a.cla_plantarif <> '||LV_cla_plantarif||'';
                                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta,SYSDATE)';
                                LV_sSql:=LV_sSql||' AND c.cod_cargobasico = a.cod_cargobasico';
                                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN c.fec_desde     AND NVL(c.fec_hasta, SYSDATE) ';
                                LV_sSql:=LV_sSql||' AND a.tip_plantarif = '||LV_Tipo_PlanTarifario;
                                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)';
                                LV_sSql:=LV_sSql||' AND d.cod_limconsumo = a.cod_limconsumo ';
                                LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN b.fec_desde AND b.fec_hasta ';
                                LV_sSql:=LV_sSql||' ORDER BY b.imp_inicial;  ' ;


                           OPEN SO_Planes_Pospago_Rango FOR
                                SELECT distinct lpad(a.cod_plantarif,3) ,
                                         a.des_plantarif || ' { ' ||b.imp_inicial || ' - ' || b.imp_final || ' }',
                                         d.cod_limconsumo,
                                         d.des_limconsumo,
                                         c.cod_cargobasico,
                                                 c.des_cargobasico,
                                         b.imp_inicial,
                                         b.imp_final,
                                         a.num_dias,
                                         a.tip_plantarif,
                                         d.imp_limconsumo,
                                         decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,
                                         decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,
                                         decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff
                                FROM ta_plantarif a, ta_rango_planes_td b,ta_limconsumo d, ta_cargosbasico c , GA_PLANTECPLSERV e, ta_planes_frecuentes g
                                 WHERE a.cod_producto = b.cod_producto
                                           AND a.cod_plantarif  = b.cod_plantarif
                                           AND a.cod_plantarif = e.cod_plantarif(+)
                                           AND a.cod_producto = e.cod_producto(+)
                                           AND a.cod_tiplan = CN_pospago
                                           AND A.COD_PRESTACION in (LV_COD_PRESTACION , LV_COD_PRESTACION_DOS)
                                           AND a.cla_plantarif <> LV_cla_plantarif
                                           AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta,SYSDATE)
                                           AND c.cod_cargobasico = a.cod_cargobasico
                                           AND SYSDATE BETWEEN c.fec_desde      AND NVL(c.fec_hasta, SYSDATE)
                                           AND a.tip_plantarif  = LV_Tipo_PlanTarifario
                                           AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)
                                           AND d.cod_limconsumo = a.cod_limconsumo
                                           AND SYSDATE BETWEEN b.fec_desde AND b.fec_hasta
                                           AND a.cod_producto  = g.cod_producto(+)
                                           AND a.cod_plantarif = g.cod_plantarif(+)
                                  ORDER BY b.imp_inicial;

                ELSE IF LV_Tipo_PlanTarifario ='I'  THEN
                        Begin
                                        LV_sSql:='select CASE B.IND_RESTPLAN      ';
                                        LV_sSql:=LV_sSql||' WHEN 1     THEN '||chr(39)||'Cursor1'||chr(39)||'  ';
                                        LV_sSql:=LV_sSql||' WHEN 2     THEN '||chr(39)||'Cursor2'||chr(39)||'  ';
                                        LV_sSql:=LV_sSql||' ELSE '||chr(39)||'Cursor3'||chr(39)||'  ';
                                        LV_sSql:=LV_sSql||' END ,                           ';
                                        LV_sSql:=LV_sSql||' B.COD_USO                       ';
                                        LV_sSql:=LV_sSql||' FROM GA_ABOCEL A, AL_USOS   B   ';
                                        LV_sSql:=LV_sSql||' WHERE A.COD_USO     = B.COD_USO ';
                                        LV_sSql:=LV_sSql||' AND   A.NUM_ABONADO = '||EO_PlanesTarifarios.NUM_ABONADO||';';

                                        select CASE B.IND_RESTPLAN
                                                        WHEN 1     THEN 'Cursor1'
                                                        WHEN 2     THEN 'Cursor2'
                                                        ELSE 'Cursor2'
                                                        END ,
                                                B.COD_USO
                                        INTO LV_RestPlan,
                                                 LV_COD_USO
                                        FROM GA_ABOCEL A, AL_USOS   B
                                        WHERE A.COD_USO     = B.COD_USO
                                        AND   A.NUM_ABONADO = EO_PlanesTarifarios.NUM_ABONADO;  --  3888018;
                                EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                         LV_COD_USO  := NULL;
                                         LV_RestPlan := 'Cursor2';
                           END;

                                IF      LV_RestPlan='Cursor1'  THEN

                                        LV_sSql:='SELECT  a.cod_plantarif, a.des_plantarif,';
                    LV_sSql:= LV_sSql || ' a.cod_limconsumo, d.des_limconsumo,';
                    LV_sSql:= LV_sSql || ' a.cod_cargobasico, e.des_cargobasico,';
                    LV_sSql:= LV_sSql || ' e.imp_cargobasico , null imp_final,';
                    LV_sSql:= LV_sSql || ' a.num_dias,a.tip_plantarif,';
                    LV_sSql:= LV_sSql || ' d.imp_limconsumo,';
                    LV_sSql:= LV_sSql || ' decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,';
                    LV_sSql:= LV_sSql || ' decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,';
                    LV_sSql:= LV_sSql || ' decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff';
                    LV_sSql:= LV_sSql || ' FROM TA_PLANTARIF               a,';
                    LV_sSql:= LV_sSql || ' GA_PLANTECPLSERV       c,';
                    LV_sSql:= LV_sSql || ' GA_PLANUSO             b,';
                    LV_sSql:= LV_sSql || ' TA_LIMCONSUMO          d,';
                    LV_sSql:= LV_sSql || ' TA_CARGOSBASICO        e,';
                    LV_sSql:= LV_sSql || ' ta_planes_frecuentes g';
                    LV_sSql:= LV_sSql || ' WHERE';
                    LV_sSql:= LV_sSql || ' a.cod_plantarif = b.COD_PLANTARIF';
                    LV_sSql:= LV_sSql || ' AND   a.cod_producto  = b.COD_PRODUCTO';
                    LV_sSql:= LV_sSql || ' AND a.cod_tiplan = '||CN_pospago;
                    LV_sSql:= LV_sSql || ' AND A.COD_PRESTACION in  ('||LV_COD_PRESTACION || ',' || LV_COD_PRESTACION_DOS || ') ';
                    LV_sSql:= LV_sSql || ' AND   d.cod_limconsumo = a.cod_limconsumo';
                    LV_sSql:= LV_sSql || ' AND   a.cod_cargobasico = e.cod_cargobasico';
                    LV_sSql:= LV_sSql || ' AND   SYSDATE BETWEEN e.fec_desde       AND NVL(e.fec_hasta, SYSDATE)';
                    LV_sSql:= LV_sSql || ' AND   a.cod_producto  = '||CN_producto||' ';
                    LV_sSql:= LV_sSql || ' AND   a.TIP_PLANTARIF = '''||LV_Tipo_PlanTarifario||'''';
                    LV_sSql:= LV_sSql || ' AND   a.cod_plantarif  = c.cod_plantarif(+)';
                    LV_sSql:= LV_sSql || ' AND   a.cod_producto = c.cod_producto(+)';
                    LV_sSql:= LV_sSql || ' AND   SYSDATE BETWEEN c.FEC_DESDE AND NVL(c.FEC_HASTA,SYSDATE)';
                    LV_sSql:= LV_sSql || ' AND   c.cod_tecnologia = '''||EO_PlanesTarifarios.COD_TECNOLOGIA||'''';
                    LV_sSql:= LV_sSql || ' AND   a.cla_plantarif <> '||LV_cla_plantarif||' ';
                    LV_sSql:= LV_sSql || ' AND ('|| to_char(LN_Permisos) ||' = decode(' || to_char(LN_Permisos)||',1, ';
                    LV_sSql:= LV_sSql || ' (SELECT case sysdate  WHEN sysdate Then 1 else 0 End from dual';
                    LV_sSql:= LV_sSql || ' WHERE SYSDATE BETWEEN a.FEC_DESDE AND NVL(a.FEC_HASTA,SYSDATE)';
                    LV_sSql:= LV_sSql || ' AND  ('||LV_tip_unitas||' = decode('||LV_tip_unitas||', S ,';
                    LV_sSql:= LV_sSql || ' (SELECT case S  WHEN S Then S else N End from dual';
                    LV_sSql:= LV_sSql || ' WHERE a.TIP_UNITAS=S),';
                    LV_sSql:= LV_sSql||'  '||to_char(LV_tip_unitas)||')) ';
                    LV_sSql:= LV_sSql || ' ),';
                    LV_sSql:= LV_sSql ||'  '||to_char(LN_Permisos)||')) ';
                    LV_sSql:= LV_sSql || ' AND a.cod_producto  = g.cod_producto(+)';
                    LV_sSql:= LV_sSql || ' AND a.cod_plantarif = g.cod_plantarif(+)';
                    LV_sSql:= LV_sSql || ' ORDER BY  a.cod_plantarif';


                                                        OPEN SO_Planes_Pospago FOR
                                                        SELECT  a.cod_plantarif, a.des_plantarif,
                                                                a.cod_limconsumo, d.des_limconsumo,
                                                                        a.cod_cargobasico, e.des_cargobasico,
                                                                        e.imp_cargobasico , null imp_final,
                                                                        a.num_dias,a.tip_plantarif,
                                                                        d.imp_limconsumo,
                                                                        decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,
                                                                        decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,
                                                                        decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff
                                                        FROM TA_PLANTARIF               a,
                                                                 GA_PLANTECPLSERV       c,
                                                                 GA_PLANUSO             b,
                                                                 TA_LIMCONSUMO          d,
                                                                 TA_CARGOSBASICO        e,
                                                                 ta_planes_frecuentes g
                                                        WHERE
                                                                  a.cod_plantarif = b.COD_PLANTARIF
                                                        AND   a.cod_producto  = b.COD_PRODUCTO
                                                        --AND   b.cod_uso       = LV_COD_USO
                                                        AND a.cod_tiplan = CN_pospago
                                                        AND A.COD_PRESTACION in (LV_COD_PRESTACION, LV_COD_PRESTACION_DOS)
                                                        AND   d.cod_limconsumo = a.cod_limconsumo
                                                        AND   a.cod_cargobasico = e.cod_cargobasico
                                                        AND   SYSDATE BETWEEN e.fec_desde       AND NVL(e.fec_hasta, SYSDATE)
                                                        AND   a.cod_producto   = CN_producto
                                                        AND   a.TIP_PLANTARIF = LV_Tipo_PlanTarifario
                                                        AND   a.cod_plantarif  = c.cod_plantarif(+)
                                                        AND   a.cod_producto = c.cod_producto(+)
                                                        AND   SYSDATE BETWEEN c.FEC_DESDE AND NVL(c.FEC_HASTA,SYSDATE)
                                                        AND   c.cod_tecnologia = EO_PlanesTarifarios.COD_TECNOLOGIA
                                                        AND   a.cla_plantarif <> LV_cla_plantarif                       --<CLASE_PLAN>
                                                AND (LN_Permisos = decode(LN_Permisos,1,
                                                           (SELECT case sysdate  WHEN sysdate Then 1 else 0 End from dual
                                                                WHERE SYSDATE BETWEEN a.FEC_DESDE AND NVL(a.FEC_HASTA,SYSDATE)
                                                                AND  (LV_tip_unitas = decode(LV_tip_unitas,'S',
                                                                        (SELECT case 'S'  WHEN 'S' Then 'S' else 'N' End from dual
                                                                          WHERE a.TIP_UNITAS='S'),
                                                                          LV_tip_unitas))
                                                                ),
                                                                LN_Permisos))
                                                        AND a.cod_producto  = g.cod_producto(+)
                                                        AND a.cod_plantarif = g.cod_plantarif(+)
                                        ORDER BY  a.cod_plantarif;
                                END IF;
                                --
                                IF LV_RestPlan='Cursor2'  THEN

                    LV_sSql:=' SELECT a.cod_plantarif, a.des_plantarif,';
                    LV_sSql:= LV_sSql || ' a.cod_limconsumo, d.des_limconsumo,';
                    LV_sSql:= LV_sSql || ' a.cod_cargobasico, e.des_cargobasico,';
                    LV_sSql:= LV_sSql || ' e.imp_cargobasico, null imp_final,';
                    LV_sSql:= LV_sSql || ' a.num_dias,a.tip_plantarif,';
                    LV_sSql:= LV_sSql || ' d.imp_limconsumo,';
                    LV_sSql:= LV_sSql || ' decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,';
                    LV_sSql:= LV_sSql || ' decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,';
                    LV_sSql:= LV_sSql || ' decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff';
                    LV_sSql:= LV_sSql || ' FROM TA_PLANTARIF a,';
                    LV_sSql:= LV_sSql || ' GA_PLANTECPLSERV c,';
                    LV_sSql:= LV_sSql || ' TA_LIMCONSUMO d,';
                    LV_sSql:= LV_sSql || ' TA_CARGOSBASICO e,';
                    LV_sSql:= LV_sSql || ' ta_planes_frecuentes g';
                    LV_sSql:= LV_sSql || ' WHERE a.cod_producto = '||CN_producto||' ';
                    LV_sSql:= LV_sSql || ' AND a.TIP_PLANTARIF = '''||LV_Tipo_PlanTarifario||'''';
                    LV_sSql:= LV_sSql || ' AND A.COD_PRESTACION in ('||LV_COD_PRESTACION || ',' || LV_COD_PRESTACION_DOS ||')';
                    LV_sSql:= LV_sSql || ' AND a.cod_plantarif = c.cod_plantarif(+)';
                    LV_sSql:= LV_sSql || ' AND a.cod_producto = c.cod_producto(+)';
                    LV_sSql:= LV_sSql || ' AND c.cod_tecnologia = '||EO_PlanesTarifarios.COD_TECNOLOGIA||' ';
                    LV_sSql:= LV_sSql || ' AND d.cod_limconsumo = a.cod_limconsumo';
                    LV_sSql:= LV_sSql || ' AND a.cod_cargobasico = e.cod_cargobasico';
                    LV_sSql:= LV_sSql || ' AND a.cod_tiplan = '||CN_pospago||' ';
                    LV_sSql:= LV_sSql || ' AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta, SYSDATE)';
                    LV_sSql:= LV_sSql || ' AND SYSDATE BETWEEN c.fec_desde AND NVL(c.fec_hasta,SYSDATE)';
                    LV_sSql:= LV_sSql || ' AND a.cla_plantarif <> '||LV_cla_plantarif||'';
                    LV_sSql:= LV_sSql || ' AND ('||to_char(LN_Permisos)||' = decode('||to_char(LN_Permisos)||',1,';
                    LV_sSql:= LV_sSql || ' (SELECT case sysdate WHEN sysdate Then 1 else 0 End from dual';
                    LV_sSql:= LV_sSql || ' WHERE SYSDATE BETWEEN a.FEC_DESDE AND NVL(a.FEC_HASTA,SYSDATE)';
                    LV_sSql:= LV_sSql || ' AND ('||LV_tip_unitas||' = decode('||LV_tip_unitas||',S,';
                    LV_sSql:= LV_sSql || ' (SELECT case S WHEN S Then S else N End from dual';
                    LV_sSql:= LV_sSql || ' WHERE a.TIP_UNITAS = S),';
                    LV_sSql:= LV_sSql || ' '||to_char(LV_tip_unitas)||')) ';
                    LV_sSql:= LV_sSql || ' '||to_char(LN_Permisos)||')) ';
                    LV_sSql:= LV_sSql || ' AND a.cod_producto = g.cod_producto(+)';
                    LV_sSql:= LV_sSql || ' AND a.cod_plantarif = g.cod_plantarif(+)';
                    LV_sSql:= LV_sSql || ' ORDER BY a.cod_plantarif';

                   OPEN SO_Planes_Pospago FOR
                                                        SELECT  a.cod_plantarif, a.des_plantarif,
                                                                        a.cod_limconsumo, d.des_limconsumo,
                                                                        a.cod_cargobasico, e.des_cargobasico,
                                                                        e.imp_cargobasico, null imp_final,
                                                                        a.num_dias,a.tip_plantarif,
                                                                        d.imp_limconsumo,
                                                                        decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,
                                                                        decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,
                                                                        decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff
                                                        FROM TA_PLANTARIF                a,
                                                                 GA_PLANTECPLSERV        c,
                                                                 TA_LIMCONSUMO           d,
                                                                 TA_CARGOSBASICO         e,
                                                                 ta_planes_frecuentes g
                                                        WHERE
                                                                a.cod_producto   = CN_producto
                                                                AND   a.TIP_PLANTARIF = LV_Tipo_PlanTarifario
                                                                 AND A.COD_PRESTACION in (LV_COD_PRESTACION , LV_COD_PRESTACION_DOS)
                                                                AND   a.cod_plantarif  = c.cod_plantarif(+)
                                                                AND   a.cod_producto = c.cod_producto(+)
                                                                AND   c.cod_tecnologia = EO_PlanesTarifarios.COD_TECNOLOGIA      -- 'CDMA' <sCodTecnologia>
                                                                AND   d.cod_limconsumo = a.cod_limconsumo
                                                                AND   a.cod_cargobasico = e.cod_cargobasico
                                                                AND   a.cod_tiplan = CN_pospago
                                                                AND   SYSDATE BETWEEN e.fec_desde       AND NVL(e.fec_hasta, SYSDATE)
                                                                AND   SYSDATE BETWEEN c.fec_desde AND NVL(c.fec_hasta,SYSDATE)
                                                                AND   a.cla_plantarif <> LV_cla_plantarif       --<CLASE_PLAN>
                                                AND (LN_Permisos = decode(LN_Permisos,1,
                                                                                           (SELECT case sysdate  WHEN sysdate Then 1 else 0 End from dual
                                                                                                WHERE SYSDATE BETWEEN a.FEC_DESDE AND NVL(a.FEC_HASTA,SYSDATE)
                                                                                                AND  (LV_tip_unitas = decode(LV_tip_unitas,'S',
                                                                                                          (SELECT case 'S'  WHEN 'S' Then 'S' else 'N' End from dual
                                                                                                           WHERE a.TIP_UNITAS='S'),
                                                                                                           LV_tip_unitas))
                                                                                                ),
                                                                                                LN_Permisos))
                                                                AND a.cod_producto  = g.cod_producto(+)
                                                                AND a.cod_plantarif = g.cod_plantarif(+)
                                        ORDER BY  a.cod_plantarif;
                                END IF;
                        END IF;

                        ---dbms_output.put_line('>>>>>FIN?<<<<');

                END IF;


        EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_OBTIENE_PLANES_POSPAGO_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_PLANES_POSPAGO_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_POSPAGO', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_PLANES_POSPAGO_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_POSPAGO', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_PLANES_POSPAGO_PR;

--------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_PLANES_POSPAGO_PR_C(EO_PlanesTarifarios      IN PV_PLANES_TARIFARIOS_QT,
                                       EV_Cod_Califica          IN pv_calificacion_td.COD_CALIFICA%TYPE,
                                       SO_Planes_Pospago        OUT NOCOPY refCursor,
                                       SO_Planes_Pospago_Rango  OUT NOCOPY refCursor,
                                       SN_cod_retorno           OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                       SV_mens_retorno          OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                       SN_num_evento            OUT NOCOPY ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_PLANES_POSPAGO_PR"
              Lenguaje="PL/SQL"
              Fecha="04-06-2007"
              Versión="La del package"
              Diseñador="Matías Guajardo"
              Programador="Matías Guajardo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="" Tipo="estructura"></param>>
                 </Entrada>
                 <Salida>
                    <param nom="" Tipo=""></param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_des_error           ge_errores_pg.DesEvent;
        LV_sSql                ge_errores_pg.vQuery;
        ERROR_EJECUCION        EXCEPTION;
        LV_Tipo_PlanTarifario  ga_abocel.tip_plantarif%TYPE;
        LV_Plan_Tarifario      ta_plantarif.cod_plantarif%TYPE;
        LV_tip_unitas          ta_plantarif.tip_unitas%TYPE;
        LV_USUARORA            ge_seg_grpusuario.nom_usuario%TYPE;
        LV_COD_USO             al_usos.COD_USO%TYPE;
        LV_COD_PLANTARIF_EVAL  ert_solicitud_planes.cod_plantarif%TYPE;
        LN_Permisos            NUMBER (09);
        LV_RestPlan            VARCHAR2(07);
        LN_CambioPlan          NUMBER (1);
        LV_cla_plantarif       ta_plantarif.CLA_PLANTARIF%TYPE;
        EO_GED_PARAMETROS      PV_GED_PARAMETROS_QT;
        LV_COD_PRESTACION      VARCHAR2(10);
        LV_COD_PRESTACION_DOS  VARCHAR2(10);

        BEGIN

            SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento   := 0;

            LV_COD_PRESTACION := '';
            LV_COD_PRESTACION_DOS := '';

            SELECT  COD_PRESTACION
            INTO LV_COD_PRESTACION
            FROM GA_ABOCEL
            WHERE NUM_ABONADO  =EO_PlanesTarifarios.NUM_ABONADO
            UNION
            SELECT  COD_PRESTACION
            FROM GA_ABOAMIST
            WHERE NUM_ABONADO  =EO_PlanesTarifarios.NUM_ABONADO;

          LV_COD_PRESTACION_DOS := LV_COD_PRESTACION;

            /*     ini   ADC   30-05-2011          170614 
            
            IF LV_COD_PRESTACION = '01' THEN
                LV_COD_PRESTACION_DOS := '22';
            ELSIF LV_COD_PRESTACION = '04' THEN
                LV_COD_PRESTACION_DOS := '23';
            ELSIF LV_COD_PRESTACION = '05' THEN
                LV_COD_PRESTACION_DOS := '24';
            ELSIF LV_COD_PRESTACION = '22' THEN
                LV_COD_PRESTACION_DOS := '01';
            ELSIF LV_COD_PRESTACION = '23' THEN
                LV_COD_PRESTACION_DOS := '04';
            ELSIF LV_COD_PRESTACION = '24' THEN
                LV_COD_PRESTACION_DOS := '05';
            END IF;    */

            SELECT ASOCDESTINO INTO  LV_COD_PRESTACION_DOS
             FROM GE_ASOCPRESTACIONES_TD
             WHERE ASOCORIGEN = LV_COD_PRESTACION
             AND USO = CN_pospago ;
             
       --      fin ADC   30-05-2011          170614 
             
                LV_Tipo_PlanTarifario := EO_PlanesTarifarios.tip_plantarif;

                LV_sSql:='SELECT NULL COD_PLANTARIF, NULL DES_PLANTARIF, NULL COD_LIMCONSUMO, NULL DES_LIMCONSUMO, NULL COD_CARGOBASICO, NULL DES_CARGOBASICO, NULL IMP_CARGOBASICO , null imp_final, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo , NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff';
                LV_sSql:=LV_sSql||'  FROM DUAL ';
                LV_sSql:=LV_sSql||'  WHERE ROWNUM = 0; ';

                OPEN SO_Planes_Pospago FOR
                SELECT NULL COD_PLANTARIF, NULL DES_PLANTARIF, NULL COD_LIMCONSUMO, NULL DES_LIMCONSUMO, NULL COD_CARGOBASICO, NULL DES_CARGOBASICO, NULL IMP_CARGOBASICO , null imp_final, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo, NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff
        FROM DUAL
        WHERE ROWNUM = 0;
                LV_sSql:='SELECT NULL COD_PLANTARIF, NULL DES_PLANTARIF, NULL cod_limconsumo, NULL des_limconsumo,NULL cargo_basico, NULL des_cargobasico, NULL IMP_INICIAL, NULL IMP_FINAL, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo, NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff ';
                LV_sSql:=LV_sSql||'  FROM DUAL ';
                LV_sSql:=LV_sSql||'  WHERE ROWNUM = 0; ';

                OPEN SO_Planes_Pospago_Rango FOR
                SELECT NULL COD_PLANTARIF, NULL DES_PLANTARIF, NULL cod_limconsumo, NULL des_limconsumo,NULL cargo_basico, NULL des_cargobasico, NULL IMP_INICIAL, NULL IMP_FINAL, NULL num_dias, NULL tip_plantarif, NULL imp_limconsumo, NULL num_frec_fijos, NULL num_frec_movil, NULL ind_ff
        FROM DUAL
        WHERE ROWNUM = 0;
                -- LN_Permisos:=0; -- INC 75083; AVC; 30-12-2008
                LN_Permisos:=1; -- INC 75083; AVC; 30-12-2008

                LV_sSql:='PV_obtiene_permisos_FN('||EO_PlanesTarifarios.NOM_USUARORA||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                IF PV_obtiene_permisos_FN(EO_PlanesTarifarios.NOM_USUARORA, SN_cod_retorno, SV_mens_retorno, SN_num_evento)  THEN
                    IF SN_cod_retorno>0 THEN
                                        RAISE ERROR_EJECUCION;
                        ELSE
                                -- LN_Permisos:=1; -- INC 75083; AVC; 30-12-2008
                                LN_Permisos:=0; -- INC 75083; AVC; 30-12-2008
                        END IF;
                END IF;
                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                EO_GED_PARAMETROS.NOM_PARAMETRO:= 'TIPO_PLAN_SERVICIO';
                EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;

        LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR ('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                LV_cla_plantarif := EO_GED_PARAMETROS.VAL_PARAMETRO;
                IF SN_cod_retorno <> 0 THEN
                   RAISE ERROR_EJECUCION;
                END IF;
                BEGIN
                        LV_sSql:='SELECT TIP_UNITAS INTO LV_tip_unitas FROM TA_PLANTARIF WHERE COD_PLANTARIF ='||EO_PlanesTarifarios.COD_PLANTARIF||'; ';
                        SELECT TIP_UNITAS INTO LV_tip_unitas
                        FROM TA_PLANTARIF
                        WHERE COD_PLANTARIF = EO_PlanesTarifarios.COD_PLANTARIF;

                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                         LV_tip_unitas := NULL;
                END;

                IF LV_Tipo_PlanTarifario ='E' THEN
                   LV_USUARORA := EO_PlanesTarifarios.NOM_USUARORA;
                ELSE IF LV_Tipo_PlanTarifario ='I'  THEN
                        Begin
                                LV_sSql:='select CASE B.IND_RESTPLAN      ';
                                LV_sSql:=LV_sSql||' WHEN 1     THEN '||chr(39)||'Cursor1'||chr(39)||'  ';
                                LV_sSql:=LV_sSql||' WHEN 2     THEN '||chr(39)||'Cursor2'||chr(39)||'  ';
                                LV_sSql:=LV_sSql||' ELSE '||chr(39)||'Cursor3'||chr(39)||'  ';
                                LV_sSql:=LV_sSql||' END ,                           ';
                                LV_sSql:=LV_sSql||' B.COD_USO                       ';
                                LV_sSql:=LV_sSql||' FROM GA_ABOCEL A, AL_USOS   B   ';
                                LV_sSql:=LV_sSql||' WHERE A.COD_USO     = B.COD_USO ';
                                LV_sSql:=LV_sSql||' AND   A.NUM_ABONADO = '||EO_PlanesTarifarios.NUM_ABONADO||';';

                                select CASE B.IND_RESTPLAN
                                                WHEN 1     THEN 'Cursor1'
                                                WHEN 2     THEN 'Cursor2'
                                                ELSE 'Cursor2'
                                                END ,
                                        B.COD_USO
                                INTO LV_RestPlan,
                                         LV_COD_USO
                                FROM GA_ABOCEL A, AL_USOS   B
                                WHERE A.COD_USO     = B.COD_USO
                                AND   A.NUM_ABONADO = EO_PlanesTarifarios.NUM_ABONADO;  --  3888018;
                                EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                     LV_COD_USO  := NULL;
                                     LV_RestPlan := 'Cursor2';
                           END;

                           IF LV_RestPlan='Cursor1'  THEN
                                LV_sSql:='SELECT  a.cod_plantarif, a.des_plantarif,';
                                LV_sSql:= LV_sSql || ' a.cod_limconsumo, d.des_limconsumo,';
                                LV_sSql:= LV_sSql || ' a.cod_cargobasico, e.des_cargobasico,';
                                LV_sSql:= LV_sSql || ' e.imp_cargobasico , null imp_final,';
                                LV_sSql:= LV_sSql || ' a.num_dias,a.tip_plantarif,';
                                LV_sSql:= LV_sSql || ' d.imp_limconsumo,';
                                LV_sSql:= LV_sSql || ' decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,';
                                LV_sSql:= LV_sSql || ' decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,';
                                LV_sSql:= LV_sSql || ' decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff';
                                LV_sSql:= LV_sSql || ' FROM TA_PLANTARIF               a,';
                                LV_sSql:= LV_sSql || ' GA_PLANTECPLSERV       c,';
                                LV_sSql:= LV_sSql || ' GA_PLANUSO             b,';
                                LV_sSql:= LV_sSql || ' TA_LIMCONSUMO          d,';
                                LV_sSql:= LV_sSql || ' TA_CARGOSBASICO        e,';
                                LV_sSql:= LV_sSql || ' ta_planes_frecuentes g';
                                LV_sSql:= LV_sSql || ' WHERE';
                                LV_sSql:= LV_sSql || ' a.cod_plantarif = b.COD_PLANTARIF';
                                LV_sSql:= LV_sSql || ' AND   a.cod_producto  = b.COD_PRODUCTO';
                                LV_sSql:= LV_sSql || ' AND a.cod_tiplan = '||CN_pospago;
                                LV_sSql:= LV_sSql || ' AND A.COD_PRESTACION in  ('||LV_COD_PRESTACION || ',' || LV_COD_PRESTACION_DOS || ') ';
                                LV_sSql:= LV_sSql || ' AND   d.cod_limconsumo = a.cod_limconsumo';
                                LV_sSql:= LV_sSql || ' AND   a.cod_cargobasico = e.cod_cargobasico';
                                LV_sSql:= LV_sSql || ' AND   SYSDATE BETWEEN e.fec_desde       AND NVL(e.fec_hasta, SYSDATE)';
                                LV_sSql:= LV_sSql || ' AND   a.cod_producto  = '||CN_producto||' ';
                                LV_sSql:= LV_sSql || ' AND   a.TIP_PLANTARIF = '''||LV_Tipo_PlanTarifario||'''';
                                LV_sSql:= LV_sSql || ' AND   a.cod_plantarif  = c.cod_plantarif(+)';
                                LV_sSql:= LV_sSql || ' AND   a.cod_producto = c.cod_producto(+)';
                                LV_sSql:= LV_sSql || ' AND   SYSDATE BETWEEN c.FEC_DESDE AND NVL(c.FEC_HASTA,SYSDATE)';
                                LV_sSql:= LV_sSql || ' AND   c.cod_tecnologia = '''||EO_PlanesTarifarios.COD_TECNOLOGIA||'''';
                                LV_sSql:= LV_sSql || ' AND   a.cla_plantarif <> '||LV_cla_plantarif||' ';
                                LV_sSql:= LV_sSql || ' AND ('|| to_char(LN_Permisos) ||' = decode(' || to_char(LN_Permisos)||',1, ';
                                LV_sSql:= LV_sSql || ' (SELECT case sysdate  WHEN sysdate Then 1 else 0 End from dual';
                                LV_sSql:= LV_sSql || ' WHERE SYSDATE BETWEEN a.FEC_DESDE AND NVL(a.FEC_HASTA,SYSDATE)';
                                LV_sSql:= LV_sSql || ' AND  ('||LV_tip_unitas||' = decode('||LV_tip_unitas||', S ,';
                                LV_sSql:= LV_sSql || ' (SELECT case S  WHEN S Then S else N End from dual';
                                LV_sSql:= LV_sSql || ' WHERE a.TIP_UNITAS=S),';
                                LV_sSql:= LV_sSql||'  '||to_char(LV_tip_unitas)||')) ';
                                LV_sSql:= LV_sSql || ' ),';
                                LV_sSql:= LV_sSql ||'  '||to_char(LN_Permisos)||')) ';
                                LV_sSql:= LV_sSql || ' AND a.cod_producto  = g.cod_producto(+)';
                                LV_sSql:= LV_sSql || ' AND a.cod_plantarif = g.cod_plantarif(+)';
                                LV_sSql:= LV_sSql || ' AND a.cod_producto=1';
                                LV_sSql:= LV_sSql || ' AND c.cod_califica='||EV_Cod_Califica;
                                LV_sSql:= LV_sSql || ' AND c.cod_califica=cp.cod_califica';
                                LV_sSql:= LV_sSql || ' AND cc.cod_califica=cp.cod_califica';
                                LV_sSql:= LV_sSql || ' AND a.cod_plantarif=cp.cod_plantarif';
                                LV_sSql:= LV_sSql || ' AND cc.vigencia=1';
                                LV_sSql:= LV_sSql || ' AND cp.vigencia=1';
                                LV_sSql:= LV_sSql || ' AND cc.num_abonado =  '||EO_PlanesTarifarios.num_abonado;
                                LV_sSql:= LV_sSql || ' ORDER BY  a.cod_plantarif';


                                OPEN SO_Planes_Pospago FOR
                                SELECT  a.cod_plantarif, a.des_plantarif,
                                        a.cod_limconsumo, d.des_limconsumo,
                                        a.cod_cargobasico, e.des_cargobasico,
                                        e.imp_cargobasico , null imp_final,
                                        a.num_dias,a.tip_plantarif,
                                        d.imp_limconsumo,
                                        decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,
                                        decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,
                                        decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff
                                FROM TA_PLANTARIF           a,
                                     GA_PLANTECPLSERV       c,
                                     GA_PLANUSO             b,
                                     TA_LIMCONSUMO          d,
                                     TA_CARGOSBASICO        e,
                                     ta_planes_frecuentes g,
                                     pv_califica_celular_to cc, pv_califica_plan_tarif_to cp, pv_calificacion_td c
                                WHERE a.cod_plantarif = b.COD_PLANTARIF
                                AND   a.cod_producto  = b.COD_PRODUCTO
                                --AND   b.cod_uso       = LV_COD_USO
                                AND a.cod_tiplan = CN_pospago
                                AND A.COD_PRESTACION in (LV_COD_PRESTACION, LV_COD_PRESTACION_DOS)
                                AND   d.cod_limconsumo = a.cod_limconsumo
                                AND   a.cod_cargobasico = e.cod_cargobasico
                                AND   SYSDATE BETWEEN e.fec_desde       AND NVL(e.fec_hasta, SYSDATE)
                                AND   a.cod_producto   = CN_producto
                                AND   a.TIP_PLANTARIF = LV_Tipo_PlanTarifario
                                AND   a.cod_plantarif  = c.cod_plantarif(+)
                                AND   a.cod_producto = c.cod_producto(+)
                                AND   SYSDATE BETWEEN c.FEC_DESDE AND NVL(c.FEC_HASTA,SYSDATE)
                                AND   c.cod_tecnologia = EO_PlanesTarifarios.COD_TECNOLOGIA
                                AND   a.cla_plantarif <> LV_cla_plantarif                       --<CLASE_PLAN>
                                AND (LN_Permisos = decode(LN_Permisos,1,
                                           (SELECT case sysdate  WHEN sysdate Then 1 else 0 End from dual
                                                WHERE SYSDATE BETWEEN a.FEC_DESDE AND NVL(a.FEC_HASTA,SYSDATE)
                                                AND  (LV_tip_unitas = decode(LV_tip_unitas,'S',
                                                        (SELECT case 'S'  WHEN 'S' Then 'S' else 'N' End from dual
                                                          WHERE a.TIP_UNITAS='S'),
                                                          LV_tip_unitas))
                                                ),
                                                LN_Permisos))
                                AND a.cod_producto  = g.cod_producto(+)
                                AND a.cod_plantarif = g.cod_plantarif(+)
                                AND a.cod_producto=1-- revisar, ya hay un AND a.cod_producto = e.cod_producto(+)
                                AND c.cod_califica=EV_Cod_Califica
                                AND c.cod_califica=cp.cod_califica
                                AND cc.cod_califica=cp.cod_califica
                                AND a.cod_plantarif=cp.cod_plantarif
                                AND cc.vigencia=1
                                AND cp.vigencia=1
                                AND cc.num_abonado =  EO_PlanesTarifarios.num_abonado
                                ORDER BY  a.cod_plantarif;
                            END IF;
                            --
                            IF LV_RestPlan='Cursor2'  THEN

                                LV_sSql:=' SELECT a.cod_plantarif, a.des_plantarif,';
                                LV_sSql:= LV_sSql || ' a.cod_limconsumo, d.des_limconsumo,';
                                LV_sSql:= LV_sSql || ' a.cod_cargobasico, e.des_cargobasico,';
                                LV_sSql:= LV_sSql || ' e.imp_cargobasico, null imp_final,';
                                LV_sSql:= LV_sSql || ' a.num_dias,a.tip_plantarif,';
                                LV_sSql:= LV_sSql || ' d.imp_limconsumo,';
                                LV_sSql:= LV_sSql || ' decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,';
                                LV_sSql:= LV_sSql || ' decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,';
                                LV_sSql:= LV_sSql || ' decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff';
                                LV_sSql:= LV_sSql || ' FROM TA_PLANTARIF a,';
                                LV_sSql:= LV_sSql || ' GA_PLANTECPLSERV c,';
                                LV_sSql:= LV_sSql || ' TA_LIMCONSUMO d,';
                                LV_sSql:= LV_sSql || ' TA_CARGOSBASICO e,';
                                LV_sSql:= LV_sSql || ' ta_planes_frecuentes g';
                                LV_sSql:= LV_sSql || ' WHERE a.cod_producto = '||CN_producto||' ';
                                LV_sSql:= LV_sSql || ' AND a.TIP_PLANTARIF = '''||LV_Tipo_PlanTarifario||'''';
                                LV_sSql:= LV_sSql || ' AND A.COD_PRESTACION in ('||LV_COD_PRESTACION || ',' || LV_COD_PRESTACION_DOS ||')';
                                LV_sSql:= LV_sSql || ' AND a.cod_plantarif = c.cod_plantarif(+)';
                                LV_sSql:= LV_sSql || ' AND a.cod_producto = c.cod_producto(+)';
                                LV_sSql:= LV_sSql || ' AND c.cod_tecnologia = '||EO_PlanesTarifarios.COD_TECNOLOGIA||' ';
                                LV_sSql:= LV_sSql || ' AND d.cod_limconsumo = a.cod_limconsumo';
                                LV_sSql:= LV_sSql || ' AND a.cod_cargobasico = e.cod_cargobasico';
                                LV_sSql:= LV_sSql || ' AND a.cod_tiplan = '||CN_pospago||' ';
                                LV_sSql:= LV_sSql || ' AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta, SYSDATE)';
                                LV_sSql:= LV_sSql || ' AND SYSDATE BETWEEN c.fec_desde AND NVL(c.fec_hasta,SYSDATE)';
                                LV_sSql:= LV_sSql || ' AND a.cla_plantarif <> '||LV_cla_plantarif||'';
                                LV_sSql:= LV_sSql || ' AND ('||to_char(LN_Permisos)||' = decode('||to_char(LN_Permisos)||',1,';
                                LV_sSql:= LV_sSql || ' (SELECT case sysdate WHEN sysdate Then 1 else 0 End from dual';
                                LV_sSql:= LV_sSql || ' WHERE SYSDATE BETWEEN a.FEC_DESDE AND NVL(a.FEC_HASTA,SYSDATE)';
                                LV_sSql:= LV_sSql || ' AND ('||LV_tip_unitas||' = decode('||LV_tip_unitas||',S,';
                                LV_sSql:= LV_sSql || ' (SELECT case S WHEN S Then S else N End from dual';
                                LV_sSql:= LV_sSql || ' WHERE a.TIP_UNITAS = S),';
                                LV_sSql:= LV_sSql || ' '||to_char(LV_tip_unitas)||')) ';
                                LV_sSql:= LV_sSql || ' '||to_char(LN_Permisos)||')) ';
                                LV_sSql:= LV_sSql || ' AND a.cod_producto = g.cod_producto(+)';
                                LV_sSql:= LV_sSql || ' AND a.cod_plantarif = g.cod_plantarif(+)';
                                LV_sSql:= LV_sSql || ' AND a.cod_producto=1';
                                LV_sSql:= LV_sSql || ' AND c.cod_califica='||EV_Cod_Califica;
                                LV_sSql:= LV_sSql || ' AND c.cod_califica=cp.cod_califica';
                                LV_sSql:= LV_sSql || ' AND cc.cod_califica=cp.cod_califica';
                                LV_sSql:= LV_sSql || ' AND a.cod_plantarif=cp.cod_plantarif';
                                LV_sSql:= LV_sSql || ' AND cc.vigencia=1';
                                LV_sSql:= LV_sSql || ' AND cp.vigencia=1';
                                LV_sSql:= LV_sSql || ' AND cc.num_abonado =  '||EO_PlanesTarifarios.num_abonado;
                                LV_sSql:= LV_sSql || ' ORDER BY a.cod_plantarif';

                                OPEN SO_Planes_Pospago FOR
                                SELECT  a.cod_plantarif, a.des_plantarif,
                                        a.cod_limconsumo, d.des_limconsumo,
                                        a.cod_cargobasico, e.des_cargobasico,
                                        e.imp_cargobasico, null imp_final,
                                        a.num_dias,a.tip_plantarif,
                                        d.imp_limconsumo,
                                        decode(g.num_frec_fijos,NULL,0,g.num_frec_fijos) as num_frec_fijos,
                                        decode(g.num_frec_movil,NULL,0,g.num_frec_movil) as num_frec_movil,
                                        decode(g.ind_ff,NULL,0,g.ind_ff) as ind_ff
                                FROM TA_PLANTARIF                a,
                                     GA_PLANTECPLSERV        c,
                                     TA_LIMCONSUMO           d,
                                     TA_CARGOSBASICO         e,
                                     ta_planes_frecuentes g,
                                     pv_califica_celular_to cc, pv_califica_plan_tarif_to cp, pv_calificacion_td c
                                WHERE a.cod_producto   = CN_producto
                                AND   a.TIP_PLANTARIF = LV_Tipo_PlanTarifario
                                AND   a.COD_PRESTACION in (LV_COD_PRESTACION , LV_COD_PRESTACION_DOS)
                                AND   a.cod_plantarif  = c.cod_plantarif(+)
                                AND   a.cod_producto = c.cod_producto(+)
                                AND   c.cod_tecnologia = EO_PlanesTarifarios.COD_TECNOLOGIA      -- 'CDMA' <sCodTecnologia>
                                AND   d.cod_limconsumo = a.cod_limconsumo
                                AND   a.cod_cargobasico = e.cod_cargobasico
                                AND   a.cod_tiplan = CN_pospago
                                AND   SYSDATE BETWEEN e.fec_desde       AND NVL(e.fec_hasta, SYSDATE)
                                AND   SYSDATE BETWEEN c.fec_desde AND NVL(c.fec_hasta,SYSDATE)
                                AND   a.cla_plantarif <> LV_cla_plantarif       --<CLASE_PLAN>
                                AND (LN_Permisos = decode(LN_Permisos,1,
                                       (SELECT case sysdate  WHEN sysdate Then 1 else 0 End from dual
                                            WHERE SYSDATE BETWEEN a.FEC_DESDE AND NVL(a.FEC_HASTA,SYSDATE)
                                            AND  (LV_tip_unitas = decode(LV_tip_unitas,'S',
                                                      (SELECT case 'S'  WHEN 'S' Then 'S' else 'N' End from dual
                                                       WHERE a.TIP_UNITAS='S'),
                                                       LV_tip_unitas))
                                            ),
                                            LN_Permisos))
                                AND a.cod_producto  = g.cod_producto(+)
                                AND a.cod_plantarif = g.cod_plantarif(+)
                                AND a.cod_producto=1--  revisar, ya hay un AND a.cod_producto = e.cod_producto(+)
                                AND c.cod_califica=EV_Cod_Califica
                                AND c.cod_califica=cp.cod_califica
                                AND cc.cod_califica=cp.cod_califica
                                AND a.cod_plantarif=cp.cod_plantarif
                                AND cc.vigencia=1
                                AND cp.vigencia=1
                                AND cc.num_abonado =  EO_PlanesTarifarios.num_abonado
                                ORDER BY  a.cod_plantarif;
                                END IF;
                        END IF;

                        ---dbms_output.put_line('>>>>>FIN?<<<<');

                END IF;


        EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_OBTIENE_PLANES_POSPAGO_PR_C(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_PLANES_POSPAGO_PR_C(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_POSPAGO', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_PLANES_POSPAGO_PR_C(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_POSPAGO', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PV_OBTIENE_PLANES_POSPAGO_PR_C;

----------------------------------------------------------------------------------------------------------
--3.- Metodo obtenerPlanesTarifarios(TipoPlanDestino) (Reg)   (PL-Nuevo)
PROCEDURE PV_OBTIENE_PLANES_PR (EO_PlanesTarifarios      IN              PV_PLANES_TARIFARIOS_QT,
                                                            SO_Planes_Prepago        OUT  NOCOPY         refCursor,
                                                            SO_Planes_Pospago        OUT  NOCOPY         refCursor,
                                                            SO_Planes_Hibrido        OUT  NOCOPY         refCursor,
                                                            SO_Planes_Pospago_Rango  OUT  NOCOPY         refCursor,
                                                            SN_cod_retorno           OUT  NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                                        SV_mens_retorno          OUT  NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                                        SN_num_evento            OUT  NOCOPY     ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_PLANES_PR"
              Lenguaje="PL/SQL"
              Fecha="04-06-2007"
              Versión="La del package"
              Diseñador="Matías Guajardo"
              Programador="Matías Guajardo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="" Tipo="estructura"></param>>
                 </Entrada>
                 <Salida>
                    <param nom="" Tipo=""></param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql                    ge_errores_pg.vQuery;
        ERROR_EJECUCION    EXCEPTION;
        BEGIN
                sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;
---dbms_output.put_line('1');
                BEGIN
                        LV_sSql:=' PV_OBTIENE_PLANES_PREPAGO_PR(SO_Planes_Prepago, SO_Planes_Hibrido,'|| SN_cod_retorno||',SV_mens_retorno,'||SN_num_evento||');';
                        PV_OBTIENE_PLANES_PREPAGO_PR(EO_PlanesTarifarios, SO_Planes_Prepago, SO_Planes_Hibrido, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                EXCEPTION
                   WHEN OTHERS THEN RAISE ERROR_EJECUCION;
                END;
---dbms_output.put_line('2');
                BEGIN
                        LV_sSql:='PV_OBTIENE_PLANES_POSPAGO_PR(SO_Planes_Pospago, SO_Planes_Hibrido,'|| SN_cod_retorno||',SV_mens_retorno,'||SN_num_evento||');';
                        PV_OBTIENE_PLANES_POSPAGO_PR(EO_PlanesTarifarios, SO_Planes_Pospago, SO_Planes_Pospago_Rango, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                EXCEPTION
                   WHEN OTHERS THEN RAISE ERROR_EJECUCION;
                END;
---dbms_output.put_line('3');
        EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_OBTIENE_PLANES_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_PLANES_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_PLANES_PR;

--3.- Metodo obtenerPlanesTarifarios(TipoPlanDestino) (Reg)   (PL-Nuevo)
PROCEDURE PV_OBTIENE_PLANES_PR (EO_PlanesTarifarios      IN              PV_PLANES_TARIFARIOS_QT,
                                EV_Cod_Califica          IN              pv_calificacion_td.COD_CALIFICA%TYPE,
                                                            SO_Planes_Prepago        OUT  NOCOPY         refCursor,
                                                            SO_Planes_Pospago        OUT  NOCOPY         refCursor,
                                                            SO_Planes_Hibrido        OUT  NOCOPY         refCursor,
                                                            SO_Planes_Pospago_Rango  OUT  NOCOPY         refCursor,
                                                            SN_cod_retorno           OUT  NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                                        SV_mens_retorno          OUT  NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                                        SN_num_evento            OUT  NOCOPY     ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_PLANES_PR"
              Lenguaje="PL/SQL"
              Fecha="04-06-2007"
              Versión="La del package"
              Diseñador="Matías Guajardo"
              Programador="Matías Guajardo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="" Tipo="estructura"></param>>
                 </Entrada>
                 <Salida>
                    <param nom="" Tipo=""></param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql                    ge_errores_pg.vQuery;
        ERROR_EJECUCION    EXCEPTION;
        BEGIN
                sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;
---dbms_output.put_line('2');
                BEGIN
                        IF EV_Cod_Califica IS NULL OR EV_Cod_Califica = '' THEN
                            LV_sSql:=' PV_OBTIENE_PLANES_PREPAGO_PR(SO_Planes_Prepago, SO_Planes_Hibrido,'|| SN_cod_retorno||',SV_mens_retorno,'||SN_num_evento||');';
                            PV_OBTIENE_PLANES_PREPAGO_PR(EO_PlanesTarifarios, SO_Planes_Prepago, SO_Planes_Hibrido, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                            LV_sSql:='PV_OBTIENE_PLANES_POSPAGO_PR(SO_Planes_Pospago, SO_Planes_Hibrido,'|| SN_cod_retorno||',SV_mens_retorno,'||SN_num_evento||');';
                            PV_OBTIENE_PLANES_POSPAGO_PR(EO_PlanesTarifarios, SO_Planes_Pospago, SO_Planes_Pospago_Rango, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                        ELSE
                            LV_sSql:=' PV_OBTIENE_PLANES_PREPAGO_PR(SO_Planes_Prepago, SO_Planes_Hibrido,'|| SN_cod_retorno||',SV_mens_retorno,'||SN_num_evento||');';
                            PV_OBTIENE_PLANES_PREPAGO_PR_C(EO_PlanesTarifarios, EV_Cod_Califica, SO_Planes_Prepago, SO_Planes_Hibrido, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                            LV_sSql:='PV_OBTIENE_PLANES_POSPAGO_PR_C( EV_Cod_Califica, SO_Planes_Pospago, SO_Planes_Hibrido,'|| SN_cod_retorno||',SV_mens_retorno,'||SN_num_evento||');';
                            PV_OBTIENE_PLANES_POSPAGO_PR_C(EO_PlanesTarifarios, EV_Cod_Califica, SO_Planes_Pospago, SO_Planes_Pospago_Rango, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                        END IF;
                EXCEPTION
                   WHEN OTHERS THEN RAISE ERROR_EJECUCION;
                END;
---dbms_output.put_line('3');
        EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_OBTIENE_PLANES_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_PLANES_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_PLANES_PR;

--------------------------------------------------------------------------------------------------------
        PROCEDURE PV_VALIDA_FREEDOM_PR(EO_CLIENTE                           IN OUT NOCOPY                        PV_CLIENTE_QT,
                                                                      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                                                                      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                                                                      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)
        IS
         /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_VALIDA_FREEDOM_PR"
              Lenguaje="PL/SQL"
              Fecha="06-07-2007"
              Versión="La del package"
              Diseñador="Juan Gonzalez C."
              Programador="Juan Gonzalez C."
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_CLIENTE" Tipo="estructura">estructura para datos del cliente</param>>
                 </Entrada>
                 <Salida>
                    <param nom="" Tipo=""></param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error                            ge_errores_pg.DesEvent;
                LV_sSql                                         ge_errores_pg.vQuery;
                LV_ret_freedom              VARCHAR2(2);
                Reg_ge_clientes                         PV_TIPOS_PG.R_GE_CLIENTES;

        BEGIN
                 SN_cod_retorno         := 0;
             SV_mens_retorno := NULL;
             SN_num_evento      := 0;

                Reg_ge_clientes(1).cod_cliente  := EO_CLIENTE.COD_CLIENTE;

                        LV_sSql := 'LV_ret_freedom := PV_PLAN_FREEDOM_PK. PV_VERIFICA_PLAN_FREEDOM_FN ('||Reg_ge_clientes(1).cod_cliente||')';

            LV_ret_freedom := PV_PLAN_FREEDOM_PK.PV_VERIFICA_PLAN_FREEDOM_FN (Reg_ge_clientes(1).cod_cliente);

            IF LV_ret_freedom = 'SI' THEN
                                EO_CLIENTE.PLAN_FREEDOM := 'TRUE';
                    --Cliente posee un Plan Freedom.
            ELSE
                                EO_CLIENTE.PLAN_FREEDOM := 'FALSE';
                    --Cliente no posee un Plan Freedom.
            END IF;


        EXCEPTION
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_VALIDA_FREEDOM_PR('||EO_CLIENTE.COD_CLIENTE||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_VALIDA_FREEDOM_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_VALIDA_FREEDOM_PR;

--------------------------------------------------------------------------------------------------------
    PROCEDURE PV_SEL_ICG_CENTRAL_PR (Reg_icg_central     IN OUT NOCOPY    PV_TIPOS_PG.R_ICG_CENTRAL,
                                                                     SN_cod_retorno             OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                     SV_mens_retorno            OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                     SN_num_evento              OUT NOCOPY        ge_errores_pg.evento)
    IS
/*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = " PV_SEL_ICG_CENTRAL_PR"
              Lenguaje="PL/SQL"
              Fecha="13-06-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Metodo  :  Centrales</Descripción>>
              <Parámetros>
                     <Entrada>
                    <param nom="Reg_icg_central" Tipo="Estructura Registro "></param>>
                     </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno"                                         Tipo="NUMERICO">Codigo de Retorno                  </param>>
                    <param nom="SV_mens_retorno"                                        Tipo="CARACTER">Mensaje de Retorno                 </param>>
                    <param nom="SN_num_evento"                      Tipo="NUMERICO">Numero de Evento               </param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;
    BEGIN
                        FOR i IN Reg_icg_central.FIRST .. Reg_icg_central.LAST LOOP
                        SELECT COD_SISTEMA
                        INTO   Reg_icg_central(i).COD_SISTEMA
                        FROM   ICG_CENTRAL
                        WHERE
                                  COD_CENTRAL  = Reg_icg_central(i).COD_CENTRAL
                        AND   COD_PRODUCTO = Reg_icg_central(i).COD_PRODUCTO;
          END LOOP;
        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_SEL_ICG_CENTRAL_PR ('||to_char(Reg_icg_central(1).COD_CENTRAL)||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_SEL_ICG_CENTRAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PV_SEL_ICG_CENTRAL_PR;

--------------------------------------------------------------------------------------------------------
        PROCEDURE PV_OBTENE_SERVDEFAULT_PLAN_PR (EO_SERVDEFAULT_PLAN   IN                       PV_SERVDEFAULT_PLAN_QT,
                                                                                         SC_CurDesact          OUT NOCOPY       refCursor,
                                                                                         SC_CurActi            OUT NOCOPY       refCursor,
                                                                                     SN_cod_retorno        OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                                     SV_mens_retorno       OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                                     SN_num_evento         OUT NOCOPY   ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTENE_SERVDEFAULT_PLAN_PR"
              Lenguaje="PL/SQL"
              Fecha="05-07-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_SERVDEFAULT_PLAN.COD_CENTRAL         " Tipo="estructura">estructura de datos cod central      </param>>
                    <param nom="EO_SERVDEFAULT_PLAN.COD_PRODUCTO        " Tipo="estructura">estructura de datos cod producto     </param>>
                    <param nom="EO_SERVDEFAULT_PLAN.TIP_TERMINAL        " Tipo="estructura">estructura de datos tipo terminal    </param>>
                    <param nom="EO_SERVDEFAULT_PLAN.TIP_TECNOLOGIA          " Tipo="estructura">estructura de datos tipo tecnologia  </param>>
                    <param nom="EO_SERVDEFAULT_PLAN.COD_PLANTARIF_ACTUA " Tipo="estructura">estructura de datos plantarif actual </param>>
                    <param nom="EO_SERVDEFAULT_PLAN.COD_PLANTARIF_NUEVO " Tipo="estructura">estructura de datos plantarif nuevo  </param>>
                    <param nom="EO_SERVDEFAULT_PLAN.NUM_ABONADO             " Tipo="estructura">estructura de datos Numero Abonado   </param>>
                    <param nom="EO_SERVDEFAULT_PLAN.COD_ACTABO              " Tipo="estructura">estructura de datos codigo actabo    </param>>
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
                LV_des_error                            ge_errores_pg.DesEvent;
                LV_sSql                                         ge_errores_pg.vQuery;
                ERROR_EJECUCION                 EXCEPTION;
                Reg_icg_central                         PV_TIPOS_PG.R_ICG_CENTRAL;
        BEGIN
                sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;

                LV_sSql:='PV_PLAN_BASICO_PG.PV_SEL_ICG_CENTRAL_PR ('||EO_SERVDEFAULT_PLAN.COD_CENTRAL||','||EO_SERVDEFAULT_PLAN.COD_PRODUCTO||')';
                Reg_icg_central(1).COD_CENTRAL := EO_SERVDEFAULT_PLAN.COD_CENTRAL;
                Reg_icg_central(1).COD_PRODUCTO:= EO_SERVDEFAULT_PLAN.COD_PRODUCTO;
                PV_PLAN_BASICO_PG.PV_SEL_ICG_CENTRAL_PR (Reg_icg_central,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno <> 0 THEN
                    RAISE ERROR_EJECUCION;
            END IF;

                IF EO_SERVDEFAULT_PLAN.COD_ACTABO IS NULL THEN
                                OPEN SC_CurDesact FOR
                                                        SELECT A.COD_SERVSUPL,
                                                                   A.COD_NIVEL,
                                                                   'D',
                                                                   A.COD_SERVICIO
                                                        FROM   GA_SERVSUPL                       A,
                                                                   ICG_SERVICIOTERCEN    B,
                                                                   GAD_SERVSUP_PLAN      C
                                                        WHERE C.COD_PRODUCTO   = EO_SERVDEFAULT_PLAN.COD_PRODUCTO
                                                        AND   B.COD_PRODUCTO   = A.COD_PRODUCTO
                                                        AND   B.TIP_TERMINAL   = EO_SERVDEFAULT_PLAN.TIP_TERMINAL
                                                        AND   B.COD_SISTEMA    = Reg_icg_central(1).COD_SISTEMA
                                                        AND   B.COD_SERVICIO   = A.COD_SERVSUPL
                                                        AND   B.TIP_TECNOLOGIA = EO_SERVDEFAULT_PLAN.TIP_TECNOLOGIA
                                                        AND   A.COD_SERVICIO   = C.COD_SERVICIO
                                                        AND   A.COD_PRODUCTO   = C.COD_PRODUCTO
                                                        AND   C.COD_PLANTARIF  = EO_SERVDEFAULT_PLAN.COD_PLANTARIF_ACTUA
                                                        AND   C.TIP_RELACION   = CN_tip_relacion
                                                        AND   SYSDATE BETWEEN C.FEC_DESDE AND C.FEC_HASTA;
                    ELSE
                                        OPEN SC_CurDesact FOR
                                                                SELECT  A.COD_SERVSUPL,
                                                                                A.COD_NIVEL,
                                                                                'D',
                                                                                A.COD_SERVICIO
                                                                FROM GA_SERVSUPLABO                     D,
                                                                         GA_SERVSUPL                            A,
                                                                         ICG_SERVICIOTERCEN             B,
                                                                         GAD_SERVSUP_PLAN                       C
                                                                WHERE C.COD_PRODUCTO = EO_SERVDEFAULT_PLAN.COD_PRODUCTO
                                                                AND B.COD_PRODUCTO       = A.COD_PRODUCTO
                                                                AND B.TIP_TERMINAL       = EO_SERVDEFAULT_PLAN.TIP_TERMINAL
                                                                AND B.COD_SISTEMA        = Reg_icg_central(1).COD_SISTEMA
                                                                AND B.COD_SERVICIO       = A.COD_SERVSUPL
                                                                AND B.TIP_TECNOLOGIA = EO_SERVDEFAULT_PLAN.TIP_TECNOLOGIA
                                                                AND A.COD_SERVICIO       = C.COD_SERVICIO
                                                                AND A.COD_PRODUCTO       = C.COD_PRODUCTO
                                                                AND C.COD_PLANTARIF  = EO_SERVDEFAULT_PLAN.COD_PLANTARIF_ACTUA
                                                                AND C.TIP_RELACION       = CN_tip_relacion
                                                                AND A.COD_SERVICIO       = D.COD_SERVICIO
                                                                AND D.NUM_ABONADO        = EO_SERVDEFAULT_PLAN.NUM_ABONADO
                                                                AND D.IND_ESTADO         < CN_ind_estado
                                                                AND SYSDATE BETWEEN C.FEC_DESDE AND C.FEC_HASTA;
                                END IF;

                                OPEN SC_CurActi FOR
                                                SELECT  A.COD_SERVSUPL,
                                                                A.COD_NIVEL,
                                                                'A',
                                                                A.COD_SERVICIO
                                                FROM GA_SERVSUPL                        A,
                                                         ICG_SERVICIOTERCEN     B,
                                                         GAD_SERVSUP_PLAN               C
                                                WHERE
                                                          C.COD_PRODUCTO        = EO_SERVDEFAULT_PLAN.COD_PRODUCTO
                                                AND   B.COD_PRODUCTO    = A.COD_PRODUCTO
                                                AND   B.TIP_TERMINAL    = EO_SERVDEFAULT_PLAN.TIP_TERMINAL
                                                AND   B.COD_SISTEMA     = Reg_icg_central(1).COD_SISTEMA
                                                AND   B.COD_SERVICIO    = A.COD_SERVSUPL
                                                AND   B.TIP_TECNOLOGIA  = EO_SERVDEFAULT_PLAN.TIP_TECNOLOGIA
                                                AND   A.COD_SERVICIO    = C.COD_SERVICIO
                                                AND   A.COD_PRODUCTO    = C.COD_PRODUCTO
                                                AND   C.COD_PLANTARIF   = EO_SERVDEFAULT_PLAN.COD_PLANTARIF_ACTUA
                                                AND   C.TIP_RELACION    = CN_tip_relacion
                                                AND   A.COD_NIVEL               > CN_cod_nivel
                                                AND   SYSDATE BETWEEN C.FEC_DESDE AND C.FEC_HASTA;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTENE_SERVDEFAULT_PLAN_PR('||to_char(EO_SERVDEFAULT_PLAN.NUM_ABONADO)||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTENE_SERVDEFAULT_PLAN_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTENE_SERVDEFAULT_PLAN_PR('||to_char(EO_SERVDEFAULT_PLAN.NUM_ABONADO)||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTENE_SERVDEFAULT_PLAN_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_OBTENE_SERVDEFAULT_PLAN_PR;

--------------------------------------------------------------------------------------------------------
        PROCEDURE PV_OBTENER_CICLO_FREEDOM_PR(SO_GA_ABONADO   IN OUT NOCOPY       GA_ABONADO_QT,
                                                                                      SN_cod_retorno     OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                                      SV_mens_retorno    OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                                      SN_num_evento      OUT NOCOPY       ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBT_CICLO_FREEDOM_PRasoc_PR"
              Lenguaje="PL/SQL"
              Fecha="05-07-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom=" SO_GA_ABONADO.COD_PLANTARIF " Tipo="estructura">estructura de datos  Type       </param>>
                 </Entrada>
                 <Salida>
                    <param nom=" SO_GA_ABONADO.COD_CICLO "         Tipo="estructura">estructura de datos  Type       </param>>
                    <param nom="SN_cod_retorno"                            Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno"                           Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento"                             Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error                            ge_errores_pg.DesEvent;
                LV_sSql                                         ge_errores_pg.vQuery;
        BEGIN
                sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;
            SO_GA_ABONADO.COD_CICLO:=NULL;

                LV_sSql:='SELECT cod_ciclo INTO SO_GA_ABONADO.COD_CICLO FROM TA_PLANCICLO_FREEDOM ';
                LV_sSql:=LV_sSql||' WHERE  cod_plantarif ='||SO_GA_ABONADO.COD_PLANTARIF;
                LV_sSql:=LV_sSql||' AND    cod_producto  ='||CN_producto;
                LV_sSql:=LV_sSql||' AND SYSDATE between fec_inicio AND nvl(fec_termino,SYSDATE); ';

                SELECT cod_ciclo
                 INTO SO_GA_ABONADO.COD_CICLO
                  FROM TA_PLANCICLO_FREEDOM
                   WHERE  cod_plantarif = SO_GA_ABONADO.COD_PLANTARIF
                                  AND cod_producto  = CN_producto
                                  AND SYSDATE BETWEEN fec_inicio AND nvl(fec_termino,SYSDATE);

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
                 SO_GA_ABONADO.COD_CICLO:=null;
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTENER_CICLO_FREEDOM_PR('||SO_GA_ABONADO.COD_PLANTARIF||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTENER_CICLO_FREEDOM_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_OBTENER_CICLO_FREEDOM_PR;

----------------------------------------------------------------------------------------------------------
--7- Metodo obtenerCategPlan(Plan) (Reg)   (PL-Nuevo)
          PROCEDURE PV_OBTENER_CATEG_PLAN_PR (EO_PlanesTarifarios        IN  OUT  NOCOPY     PV_PLANES_TARIFARIOS_QT,
                                                                            SN_cod_retorno           OUT  NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                                                        SV_mens_retorno          OUT  NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                                                        SN_num_evento            OUT  NOCOPY     ge_errores_pg.evento)
    IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTENER_CATEG_PLAN"
              Lenguaje="PL/SQL"
              Fecha="16/-06-2007"
              Versión="La del package"
              Diseñador=
              Programador="Elizabeth Vera
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>  Rescata codigo categoria plan</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="planTarifario Tipo="Estructura Registro "></param>>
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
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;
    BEGIN

                LV_sSql:=' SELECT cod_categoria ';
                LV_sSql:=LV_sSql||' FROM VE_CATPLANTARIF';
                LV_sSql:=LV_sSql||' WHERE cod_producto = '||CN_producto;
                LV_sSql:=LV_sSql||'  AND cod_plantarif = '||EO_PlanesTarifarios.COD_PLANTARIF;

       SELECT cod_categoria
            INTO EO_PlanesTarifarios.COD_CATEGORIA
             FROM VE_CATPLANTARIF
                   WHERE cod_producto = CN_producto
                           AND cod_plantarif = EO_PlanesTarifarios.COD_PLANTARIF
                                   AND SYSDATE BETWEEN FEC_EFECTIVIDAD AND FEC_FINEFECTIVIDAD;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
                 EO_PlanesTarifarios.COD_CATEGORIA := NULL;
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTENER_CATEG_PLAN ('||EO_PlanesTarifarios.COD_PLANTARIF||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTENER_CATEG_PLAN', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PV_OBTENER_CATEG_PLAN_PR;


----------------------------------------------------------------------------------------------------------
--8- Metodo obtenerPlanComercial(Cliente)
PROCEDURE PV_OBTENER_PLAN_COMERCIAL_PR( SO_CLIENTE                      IN  OUT  NOCOPY     PV_CLIENTE_QT,
                                                                                SN_cod_retorno           OUT  NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                                                        SV_mens_retorno          OUT  NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                                                        SN_num_evento            OUT  NOCOPY     ge_errores_pg.evento)
    IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTENER_PLAN_COMERCIAL_PR"
              Lenguaje="PL/SQL"
              Fecha="17-08-2007"
              Versión="La del package"
              Diseñador=
              Programador="Elizabeth Vera
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>  Rescata codigo plan comercial/Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_CLIENTE" Tipo="Estructura Registro "></param>>
                 </Entrada>
                 <Salida>
                    <param nom="SO_CLIENTE" Tipo="Estructura Registro "></param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error       ge_errores_pg.DesEvent;
                LV_sSql                    ge_errores_pg.vQuery;
    BEGIN

             LV_sSql:= 'VE_PARAMETROS_COMERCIALES_PG.VE_plan_comercial_cliente_PR('||SO_CLIENTE.COD_CLIENTE||','||SO_CLIENTE.COD_PLANCOM||')';
                 VE_PARAMETROS_COMERCIALES_PG.VE_plan_comercial_cliente_PR(SO_CLIENTE.COD_CLIENTE ,
                                           SO_CLIENTE.COD_PLANCOM,
                                                                           SN_cod_retorno,
                                           SV_mens_retorno,
                                           SN_num_evento);
        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTENER_PLAN_COMERCIAL_PR ('||SO_CLIENTE.COD_CLIENTE||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTENER_PLAN_COMERCIAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTENER_PLAN_COMERCIAL_PR;

----------------------------------------------------------------------------------------------------------
--2.- Metodo  :  AnulaCargoBolsaDinamica
        PROCEDURE PV_ANU_CARGO_BOLSDINAMICA_PR (EO_BOLSAS_DINAMICAS  IN OUT              PV_BOLSAS_DINAMICAS_QT,
                                                                                    SN_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                                                    SV_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                                                    SN_num_evento        OUT NOCOPY              ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_ANU_CARGO_BOLSDINAMICA_PR "
              Lenguaje="PL/SQL"
              Fecha="13-06-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Metodo  :  AnulaCargoBolsaDinamica </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_BOLSAS_DINAMICAS"                            Tipo="estructura">estructura Type de Datos </param>>
                    <param nom="EO_BOLSAS_DINAMICAS.SECUENCIA"          Tipo="estructura">Numero de Secuencia      </param>>
                    <param nom="EO_BOLSAS_DINAMICAS.COD_CLIENTE"        Tipo="estructura">Codigo del Cliente       </param>>
                    <param nom="EO_BOLSAS_DINAMICAS.COD_CICLO"          Tipo="estructura">Codigo del Ciclo         </param>>
                    <param nom="EO_BOLSAS_DINAMICAS.COD_PLANTARIF1" Tipo="estructura">Codigo Plantarifario actual </param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno"                                         Tipo="NUMERICO">Codigo de Retorno                  </param>>
                    <param nom="SV_mens_retorno"                                        Tipo="CARACTER">Mensaje de Retorno                 </param>>
                    <param nom="SN_num_evento"                      Tipo="NUMERICO">Numero de Evento               </param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error                            ge_errores_pg.DesEvent;
                LV_sSql                                         ge_errores_pg.vQuery;
                ERROR_EJECUCION                 EXCEPTION;

                EN_num_transaccion                      ga_transacabo.num_transaccion%TYPE;
                EN_cod_cliente                          ge_clientes.cod_cliente%TYPE;
                EN_cod_ciclo                            fa_ciclfact.cod_ciclo%TYPE;
                EV_cod_plantarif1                       ta_plantarif.cod_plantarif%TYPE;

        BEGIN
                sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;

                        LV_sSql:= ' PV_BOLSAS_DINAMICAS_PG.PV_ODBC_ANULCBLSDNMCCAMPLAN_PR ('||EN_num_transaccion||',';
                        LV_sSql:= LV_sSql || ' '||EN_cod_cliente||', ';
                        LV_sSql:= LV_sSql || ' '||EN_cod_ciclo||', ';
                        LV_sSql:= LV_sSql || ' '||EV_cod_plantarif1||')';

                        EN_num_transaccion              := EO_BOLSAS_DINAMICAS.SECUENCIA;
                        EN_cod_cliente                  := EO_BOLSAS_DINAMICAS.COD_CLIENTE;
                        EN_cod_ciclo                    := EO_BOLSAS_DINAMICAS.COD_CICLO;
                        EV_cod_plantarif1               := EO_BOLSAS_DINAMICAS.COD_PLANTARIF1;

                PV_BOLSAS_DINAMICAS_PG.PV_ODBC_ANULCBLSDNMCCAMPLAN_PR (EN_num_transaccion,EN_cod_cliente,EN_cod_ciclo,EV_cod_plantarif1);
                        -- Rescata codigo y mensaje de error producido en la ejecucion del package
                        SELECT  COD_RETORNO,DES_CADENA INTO  SN_cod_retorno,SV_mens_retorno
                        FROM ga_transacabo WHERE num_transaccion = EN_num_transaccion;
                        IF      SN_cod_retorno <> 0 THEN
                                        RAISE ERROR_EJECUCION;
                        END IF;

        EXCEPTION
    WHEN ERROR_EJECUCION THEN
          LV_des_error   := 'PV_ANU_CARGO_BOLSDINAMICA_PR('||to_char(EN_num_transaccion)||', '||to_char(EN_cod_cliente)||EN_cod_ciclo||EV_cod_plantarif1||');  '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_ANU_CARGO_BOLSDINAMICA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_ANU_CARGO_BOLSDINAMICA_PR('||to_char(EN_num_transaccion)||', '||to_char(EN_cod_cliente)||EN_cod_ciclo||EV_cod_plantarif1||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_ANU_CARGO_BOLSDINAMICA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_ANU_CARGO_BOLSDINAMICA_PR('||to_char(EN_num_transaccion)||', '||to_char(EN_cod_cliente)||EN_cod_ciclo||EV_cod_plantarif1||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_ANU_CARGO_BOLSDINAMICA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_ANU_CARGO_BOLSDINAMICA_PR;
----------------------------------------------------------------------------------------------------------
--Metodo :  obtenerPlanTarifario(plan)
        PROCEDURE PV_OBTIENE_PLANTARIF_PR(
          EO_PLANTARIF                     IN OUT NOCOPY    PV_PLANTARIF_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_PLANTARIF_PR"
              Lenguaje="PL/SQL"
              Fecha="31-01-2008"
              Versión="La del package"
              Diseñador=""
              Programador="Elizabeth Vera"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Metodo  :  obtenerPlanTarifario </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_PLANTARIF"                           Tipo="estructura">estructura Type de Datos </param>>
                    <param nom="EO_PLANTARIF.COD_PLANTARIF1" Tipo="estructura">Codigo Plantarifario </param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno"                                         Tipo="NUMERICO">Codigo de Retorno                  </param>>
                    <param nom="SV_mens_retorno"                                        Tipo="CARACTER">Mensaje de Retorno                 </param>>
                    <param nom="SN_num_evento"                      Tipo="NUMERICO">Numero de Evento               </param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error                            ge_errores_pg.DesEvent;
                LV_sSql                                         ge_errores_pg.vQuery;

        BEGIN
                sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;

                LV_sSql:= ' SELECT  a.cod_plantarif,a.des_plantarif,a.cod_limconsumo,d.des_limconsumo,a.cod_cargobasico,e.des_cargobasico,e.imp_cargobasico,a.num_dias,a.tip_plantarif,d.imp_limconsumo,nvl(a.num_abonados,0),nvl(p.NUM_FREC_FIJOS,0),nvl(p.NUM_FREC_MOVIL,0),nvl(p.IND_FF,0)';
                LV_sSql:= LV_sSql || ' FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e, ta_planes_frecuentes p';
                LV_sSql:= LV_sSql || ' WHERE a.cod_producto = '||CN_producto||' AND a.cod_plantarif = '||EO_PLANTARIF.COD_PLANTARIF||' ' ;
                LV_sSql:= LV_sSql || ' AND d.cod_limconsumo = a.cod_limconsumo AND a.cod_cargobasico = e.cod_cargobasico AND a.cod_producto = p.cod_producto(+) AND a.COD_PLANTARIF = p.COD_PLANTARIF(+)';
                LV_sSql:= LV_sSql || ' AND SYSDATE >= p.fec_desde(+) AND SYSDATE <= NVL(p.fec_hasta(+), SYSDATE) AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta, SYSDATE);';


           SELECT  a.cod_plantarif,
                a.des_plantarif,
                a.cod_limconsumo,
                d.des_limconsumo,
                a.cod_cargobasico,
                e.des_cargobasico,
                e.imp_cargobasico,
                a.num_dias,
                                a.tip_plantarif,
                                d.imp_limconsumo,
                                nvl(a.num_abonados,0),
                                nvl(p.NUM_FREC_FIJOS,0),
                                nvl(p.NUM_FREC_MOVIL,0),
                                nvl(p.IND_FF,0)
                INTO
                                EO_PLANTARIF.COD_PLANTARIF,
                                EO_PLANTARIF.DES_PLANTARIF,
                                EO_PLANTARIF.COD_LIMCONSUMO,
                                EO_PLANTARIF.DES_LIMCONSUMO,
                                EO_PLANTARIF.COD_CARGOBASICO,
                                EO_PLANTARIF.DES_CARGOBASICO,
                                EO_PLANTARIF.IMP_CARGOBASICO,
                                EO_PLANTARIF.NUM_DIAS,
                                EO_PLANTARIF.TIP_PLANTARIF,
                                EO_PLANTARIF.IMP_LIMCONSUMO,
                                EO_PLANTARIF.CANTIDAD_ABONADOS,
                                EO_PLANTARIF.NUM_FRECFIJOS,
                                EO_PLANTARIF.NUM_FRECMOVIL,
                                EO_PLANTARIF.IND_FF
         FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e, ta_planes_frecuentes p
         WHERE a.cod_producto = CN_producto
         AND a.cod_plantarif = EO_PLANTARIF.COD_PLANTARIF
         AND d.cod_limconsumo = a.cod_limconsumo
         AND a.cod_cargobasico = e.cod_cargobasico
                 AND a.cod_producto = p.cod_producto(+)
                 AND a.COD_PLANTARIF = p.COD_PLANTARIF(+)
                 AND SYSDATE >= p.fec_desde(+)
                 AND SYSDATE <= NVL(p.fec_hasta(+), SYSDATE)
                 AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta, SYSDATE);


                 LV_sSql:= '  select count(1) from   ga_numespabo a, ga_abocel b  where  a.num_abonado = b.num_abonado ';
                 LV_sSql:= LV_sSql || ' where  a.num_abonado = b.num_abonado and    b.cod_cliente = '||EO_PLANTARIF.COD_CLIENTE||' ';
                 LV_sSql:= LV_sSql || ' and ( ('||EO_PLANTARIF.IND_FF||' =0)  or ( ('||EO_PLANTARIF.IND_FF||' =1) and';
                 LV_sSql:= LV_sSql || '  a.num_telefesp not in (select to_char(num_celular) from   ga_abocel c where cod_cliente = '||EO_PLANTARIF.COD_CLIENTE||')))';

                 select count(1)
                 INTO EO_PLANTARIF.NUM_FRECING
                 from   ga_numespabo a, ga_abocel b
                 where  a.num_abonado = b.num_abonado
                 and    b.cod_cliente = EO_PLANTARIF.COD_CLIENTE
                 and ( (EO_PLANTARIF.IND_FF =0)
                           or
                           ( (EO_PLANTARIF.IND_FF =1)
                              and
                          a.num_telefesp not in (select to_char(num_celular) from   ga_abocel c where cod_cliente = EO_PLANTARIF.COD_CLIENTE)
                                )
                         );


        EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_PLANTARIF_PR('||EO_PLANTARIF.COD_PLANTARIF||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANTARIF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_PLANTARIF_PR('||EO_PLANTARIF.COD_PLANTARIF||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_OBTIENE_PLANTARIF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_OBTIENE_PLANTARIF_PR;


END PV_PLAN_BASICO_PG; 
/
SHOW ERRORS
