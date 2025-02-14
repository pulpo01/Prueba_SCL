CREATE OR REPLACE PACKAGE BODY TO_servicios_tol_PG IS

        --------------------
        -- PROCEDIMIENTOS --
        --------------------

        PROCEDURE TO_getListLimiteConsumo_PR(EV_codPlanTarif  IN  tol_limite_plan_td.cod_plantarif%TYPE,
                                             EV_formatoFecha1 IN  VARCHAR2,
                                             EV_formatoFecha2 IN  VARCHAR2,
                                                                             SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                                                         SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                                     SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                     SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "TO_getListLimiteConsumo_PR"
                        Lenguaje="PL/SQL"
                        Fecha="22-05-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Retorna limites de consumo para el plan tarifario
                </Retorno>
                <Descripción>
                                  Retorna limites de consumo para el plan tarifario
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_codPlanTarif"  Tipo="STRING"> codigo plan tarifario </param>
                           <param nom="EV_formatoFecha1" Tipo="STRING"> formato de fecha (fecha) </param>
                           <param nom="EV_formatoFecha2" Tipo="STRING"> formato de fecha (hora) </param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor cuentas </param>
                           <param nom="SN_codRetorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"  Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
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

                LV_Sql:='SELECT a.cod_limcons, '
                        || '        a.descripcion, '
                        || '        a.imp_limite, '
                        || '        a.ind_unidades, '
                        || '        b.ind_default '
                        || '        TO_CHAR(a.fec_desde,' || EV_formatoFecha1 || EV_formatoFecha2 || '),'
                        || '        TO_CHAR(a.fec_hasta,' || EV_formatoFecha1 || EV_formatoFecha2 || '),'
                        || 'FROM tol_limite_td a,tol_limite_plan_td b '
                        || 'WHERE a.cod_limcons = b.cod_limcons '
                        || '  AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta,SYSDATE)'
                        || '  AND b.cod_plantarif = EV_codPlanTarif';

                LN_contador := 0;
                SELECT COUNT(1)
            INTO LN_contador
                FROM tol_limite_td a,tol_limite_plan_td b
                WHERE a.cod_limcons = b.cod_limcons
                  AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta,SYSDATE)
                  AND b.cod_plantarif = EV_codPlanTarif;

                OPEN SC_cursorDatos FOR
                SELECT a.cod_limcons,
                           a.descripcion,
                           a.imp_limite,
                           a.ind_unidades,
                           b.ind_default,
                           TO_CHAR(a.fec_desde,EV_formatoFecha1||EV_formatoFecha2),
                           TO_CHAR(a.fec_hasta,EV_formatoFecha1||EV_formatoFecha2)
                FROM tol_limite_td a,tol_limite_plan_td b
                WHERE a.cod_limcons = b.cod_limcons
                  AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta,SYSDATE)
                  AND b.cod_plantarif = EV_codPlanTarif;

                IF (LN_contador = 0) THEN
                        RAISE NO_DATA_FOUND_CURSOR;
                END IF;

        EXCEPTION
                        WHEN NO_DATA_FOUND_CURSOR THEN
                                 SN_codRetorno:=1;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                            SV_menRetorno := CV_ERRORNOCLASIF;
                         END IF;
                         LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:TO_servicios_tol_PG.TO_getListLimiteConsumo_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                         SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'TO_servicios_tol_PG.TO_getListLimiteConsumo_PR', LV_Sql, SN_codRetorno, LV_desError );
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_ERRORNOCLASIF;
                                END IF;
                                LV_desError  := 'OTHERS:TO_servicios_tol_PG.TO_getListLimiteConsumo_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'TO_servicios_tol_PG.TO_getListLimiteConsumo_PR', LV_Sql, SQLCODE, LV_desError );
        END TO_getListLimiteConsumo_PR;

END TO_servicios_tol_PG;


/
SHOW ERRORS
