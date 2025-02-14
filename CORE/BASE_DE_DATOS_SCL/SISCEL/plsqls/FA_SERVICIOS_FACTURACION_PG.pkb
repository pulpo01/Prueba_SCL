CREATE OR REPLACE PACKAGE BODY FA_Servicios_Facturacion_PG IS

         PROCEDURE FA_con_presupuesto_PR(EN_num_proceso   IN  fa_presupuesto.num_proceso%TYPE,
                                                 SC_cursordatos   OUT NOCOPY refcursor,
                                                                     SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedimiento">
                        Elemento Nombre = "FA_con_presupuesto_PR"
                        Lenguaje="PL/SQL"
                        Fecha="05/06/2007"
                        Version="1.0.0"
                        Dise?ador="Hector Hermosilla"
                        Programador="Hector Hermosilla
                        Ambiente="BD"
                <Retorno>NA</Retorno>
                <Descripcion>
                        Obtiene el detalle del presupuesto
                </Descripcion>
                <Parametros>
                <Entrada>
                        <param nom="EN_num_proceso"    Tipo="NUMBER> número proceso de ejecución</param>
                </Entrada>
                <Salida>
                    <param nom="SC_cursordatos"    Tipo="CURSOR"> detalle presupuesto </param>
                        <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
                no_data_found_cursor      EXCEPTION;
            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
        BEGIN

                        SN_num_evento:= 0;
                        SN_cod_retorno:=0;
                        SV_mens_retorno:='';

                        LV_sSql := 'SELECT A.COD_CONCEPTO,'
                                         || ' F_CARGO_PRESUPUESTO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_BASE,'
                                         || ' F_IMPUESTOS_CARGO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_IMPUESTO,'
                                         || ' F_DCTO_IMPUESTOS(A.NUM_PROCESO,A.COLUMNA, A.COD_CONCEPTO) IMP_DTO,'
                                         || ' F_CARGO_PRESUPUESTO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) + F_DCTO_IMPUESTOS(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) + F_IMPUESTOS_CARGO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_TOTAL'
                                 || ' FROM'
                                         || ' FA_PRESUPUESTO A,'
                                         || ' FA_CONCEPTOS X'
                                         || ' WHERE'
                                 || ' A.COD_TIPCONCE = 3 AND'
                                 || ' A.IND_FACTUR = 1 AND'
                     || ' X.COD_CONCEPTO = A.COD_CONCEPTO AND'
                     || ' A.IND_CUOTA = 0 AND'
                     || ' X.COD_TIPCONCE = A.COD_TIPCONCE AND'
                                 || ' A.NUM_PROCESO =' || EN_num_proceso
                                         || ' UNION ALL'
                                 || ' SELECT a.COD_CONCEPTO,'
                     || ' a.MTO_GARANTIA IMP_BASE,0 IMP_IMPUESTO,0 IMP_DTO,a.MTO_GARANTIA IMP_TOTAL'
                     || ' FROM   GA_PRESUPUESTO_RECAUDACION a, GE_TIPDOCUMEN b, GED_PARAMETROS c'
                     || ' WHERE a.COD_CONCEPTO = b.COD_TIPDOCUM AND'
                     || ' c.NOM_PARAMETRO = ''' || 'COD_GARANTIA' || ''' AND'
                     || ' a.COD_CONCEPTO = TO_NUMBER(c.VAL_PARAMETRO) AND'
                     || ' c.COD_MODULO = ''' || 'RE' || '''  AND'
                     || ' a.NUM_PROCESO = ' || EN_num_proceso;

                        OPEN SC_cursordatos FOR

                        SELECT A.COD_CONCEPTO,
                          F_CARGO_PRESUPUESTO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_BASE,
                          F_IMPUESTOS_CARGO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_IMPUESTO,
                          F_DCTO_IMPUESTOS(A.NUM_PROCESO,A.COLUMNA, A.COD_CONCEPTO) IMP_DTO,
                          F_CARGO_PRESUPUESTO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) + F_DCTO_IMPUESTOS(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) + F_IMPUESTOS_CARGO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_TOTAL
                        FROM
                          FA_PRESUPUESTO A,
                          FA_CONCEPTOS X
                        WHERE
                          A.COD_TIPCONCE = 3 AND
                          A.IND_FACTUR = 1 AND
                          X.COD_CONCEPTO = A.COD_CONCEPTO AND
                          A.IND_CUOTA = 0 AND
                          X.COD_TIPCONCE = A.COD_TIPCONCE AND
                          A.NUM_PROCESO = EN_num_proceso
                        UNION ALL
                        SELECT a.COD_CONCEPTO,
                        a.MTO_GARANTIA IMP_BASE,0 IMP_IMPUESTO,0 IMP_DTO,a.MTO_GARANTIA IMP_TOTAL
                        FROM   GA_PRESUPUESTO_RECAUDACION a, GE_TIPDOCUMEN b, GED_PARAMETROS c
                        WHERE a.COD_CONCEPTO = b.COD_TIPDOCUM AND
                        c.NOM_PARAMETRO = 'COD_GARANTIA' AND
                        a.COD_CONCEPTO = TO_NUMBER(c.VAL_PARAMETRO) AND
                        c.COD_MODULO = 'RE' AND
                        a.NUM_PROCESO = EN_num_proceso;


                EXCEPTION
                        WHEN no_data_found_cursor THEN
                                SN_cod_retorno:=99;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasIF;
                                END IF;
                                LV_des_error := SUBSTR('no_data_found_cursor:FA_con_presupuesto_PR.VE_obtiene_abonados_venta_PR('|| EN_num_proceso ||'); - '|| SQLERRM,1,CN_largoerrtec);
                                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                                SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_FA,SV_mens_retorno, '1.0', USER,
                                'FA_con_presupuesto_PR.FA_con_presupuesto_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                        WHEN OTHERS THEN
                                SN_cod_retorno:=4;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasIF;
                                END IF;
                                LV_des_error := SUBSTR('OTHERS:FA_con_presupuesto_PR.FA_con_presupuesto_PR('|| EN_num_proceso ||'); - '|| SQLERRM,1,CN_largoerrtec);
                                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                                SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_FA,SV_mens_retorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_con_presupuesto_PR', LV_sSql, SN_cod_retorno, LV_des_error );

        END FA_con_presupuesto_PR;


    PROCEDURE FA_det_concepto_presup_PR(EN_num_proceso    IN  fa_presupuesto.num_proceso%TYPE,
                                            EN_cod_concepto   IN  fa_presupuesto.cod_concepto%TYPE,
                                                                            SC_cursordatos    OUT NOCOPY refcursor,
                                                    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedimiento">
                        Elemento Nombre = "FA_det_cargo_presup_PR"
                        Lenguaje="PL/SQL"
                        Fecha="05/06/2007"
                        Version="1.0.0"
                        Dise?ador="Hector Hermosilla"
                        Programador="Hector Hermosilla
                        Ambiente="BD"
                <Retorno>NA</Retorno>
                <Descripcion>
                        Obtiene presupuesto especifico asociado a un concepto facturable
                </Descripcion>
                <Parametros>
                <Entrada>
                        <param nom="EN_num_proceso"    Tipo="NUMBER> número proceso de ejecución</param>

                </Entrada>
                <Salida>
                <param nom="SC_cursordatos"    Tipo="CURSOR"> detalle presupuesto </param>
                        <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
                no_data_found_cursor      EXCEPTION;
            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
        BEGIN

                        SN_num_evento:= 0;
                        SN_cod_retorno:=0;
                        SV_mens_retorno:='';

                        LV_sSql := 'SELECT'
                                         || ' F_CARGO_PRESUPUESTO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_BASE,'
                                         || ' F_IMPUESTOS_CARGO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_IMPUESTO,'
                                         || ' F_DCTO_IMPUESTOS(A.NUM_PROCESO,A.COLUMNA, A.COD_CONCEPTO) IMP_DTO,'
                                         || ' F_CARGO_PRESUPUESTO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) + F_DCTO_IMPUESTOS(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) + F_IMPUESTOS_CARGO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_TOTAL'
                                 || ' FROM'
                                         || ' FA_PRESUPUESTO A,'
                                         || ' FA_CONCEPTOS X'
                                         || ' WHERE'
                                 || ' A.COD_TIPCONCE = 3 AND'
                                 || ' A.IND_FACTUR = 1 AND'
                     || ' X.COD_CONCEPTO = A.COD_CONCEPTO AND'
                     || ' A.IND_CUOTA = 0 AND'
                     || ' X.COD_TIPCONCE = A.COD_TIPCONCE AND'
                                 || ' A.NUM_PROCESO =' || EN_num_proceso
                                         || ' A.COD_CONCEPTO =' || EN_cod_concepto
                                         || ' UNION ALL'
                                 || ' SELECT'
                     || ' a.MTO_GARANTIA IMP_BASE,0 IMP_IMPUESTO,0 IMP_DTO,a.MTO_GARANTIA IMP_TOTAL'
                     || ' FROM   GA_PRESUPUESTO_RECAUDACION a, GE_TIPDOCUMEN b, GED_PARAMETROS c'
                     || ' WHERE a.COD_CONCEPTO = b.COD_TIPDOCUM AND'
                     || ' c.NOM_PARAMETRO = ''' || 'COD_GARANTIA' || ''' AND'
                     || ' a.COD_CONCEPTO = TO_NUMBER(c.VAL_PARAMETRO) AND'
                     || ' c.COD_MODULO = ''' || 'RE' || '''  AND'
                     || ' a.NUM_PROCESO = ' || EN_num_proceso
                                         || ' a.COD_CONCEPTO = ' || EN_cod_concepto;

                        OPEN SC_cursordatos FOR

                        SELECT F_CARGO_PRESUPUESTO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_BASE,
                          F_IMPUESTOS_CARGO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_IMPUESTO,
                          F_DCTO_IMPUESTOS(A.NUM_PROCESO,A.COLUMNA, A.COD_CONCEPTO) IMP_DTO,
                          F_CARGO_PRESUPUESTO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) + F_DCTO_IMPUESTOS(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) + F_IMPUESTOS_CARGO(A.NUM_PROCESO,A.COLUMNA,A.COD_CONCEPTO) IMP_TOTAL
                        FROM
                          FA_PRESUPUESTO A,
                          FA_CONCEPTOS X
                        WHERE
                          A.COD_TIPCONCE = 3 AND
                          A.IND_FACTUR = 1 AND
                          X.COD_CONCEPTO = A.COD_CONCEPTO AND
                          A.IND_CUOTA = 0 AND
                          X.COD_TIPCONCE = A.COD_TIPCONCE AND
                          A.NUM_PROCESO = EN_num_proceso AND
                          A.COD_CONCEPTO = EN_cod_concepto
                        UNION ALL
                        SELECT a.MTO_GARANTIA IMP_BASE,0 IMP_IMPUESTO,0 IMP_DTO,a.MTO_GARANTIA IMP_TOTAL
                        FROM   GA_PRESUPUESTO_RECAUDACION a, GE_TIPDOCUMEN b, GED_PARAMETROS c
                        WHERE a.COD_CONCEPTO = b.COD_TIPDOCUM AND
                        c.NOM_PARAMETRO = 'COD_GARANTIA' AND
                        a.COD_CONCEPTO = TO_NUMBER(c.VAL_PARAMETRO) AND
                        c.COD_MODULO = 'RE' AND
                        a.NUM_PROCESO = EN_num_proceso AND
                        a.COD_CONCEPTO = EN_cod_concepto;


                EXCEPTION
                        WHEN no_data_found_cursor THEN
                                SN_cod_retorno:=99;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasIF;
                                END IF;
                                LV_des_error := SUBSTR('no_data_found_cursor:FA_con_presupuesto_PR.VE_obtiene_abonados_venta_PR('|| EN_num_proceso ||'); - '|| SQLERRM,1,CN_largoerrtec);
                                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                                SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_FA,SV_mens_retorno, '1.0', USER,
                                'FA_con_presupuesto_PR.FA_con_presupuesto_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                        WHEN OTHERS THEN
                                SN_cod_retorno:=4;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasIF;
                                END IF;
                                LV_des_error := SUBSTR('OTHERS:FA_con_presupuesto_PR.FA_con_presupuesto_PR('|| EN_num_proceso ||'); - '|| SQLERRM,1,CN_largoerrtec);
                                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                                SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_FA,SV_mens_retorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_con_presupuesto_PR', LV_sSql, SN_cod_retorno, LV_des_error );

        END FA_det_concepto_presup_PR;

        PROCEDURE FA_getCodigoDespacho_PR(SV_codDespacho OUT NOCOPY fa_codespacho.cod_despacho%TYPE,
                                                                      SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                              SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_numEvento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "FA_getCodigoDespacho_PR"
                        Lenguaje="PL/SQL"
                        Fecha="23-05-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Retorna codigo despacho
                </Retorno>
                <Descripción>
                                  Retorna codigo despacho
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="SN_codDespacho" Tipo="STRING"> codigo despacho </param>
                         </Entrada>
                 <Salida>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                LV_Sql:= 'SELECT a.cod_despacho '
                      || 'FROM fa_codespacho a '
                          || 'WHERE a.ind_ventas = ''1';

                SELECT a.cod_despacho
                INTO SV_codDespacho
                FROM fa_codespacho a
                WHERE a.ind_ventas = '1';

        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_getCodigoDespacho_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getCodigoDespacho_PR', LV_Sql, SQLCODE, LV_desError );
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_getCodigoDespacho_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getCodigoDespacho_PR', LV_Sql, SQLCODE, LV_desError );
        END FA_getCodigoDespacho_PR;

        PROCEDURE FA_getCicloFacturacion_PR(EV_cod_ciclo        OUT NOCOPY VARCHAR2,
                                                EV_ano              OUT NOCOPY VARCHAR2,
                                                                                EV_cod_ciclfact     OUT NOCOPY VARCHAR2,
                                                                                EV_fec_vencimie     OUT NOCOPY VARCHAR2,
                                                                                EV_fec_emision      OUT NOCOPY VARCHAR2,
                                                                                EV_fec_caducida     OUT NOCOPY VARCHAR2,
                                                                                EV_fec_proxvenc     OUT NOCOPY VARCHAR2,
                                                                        EV_fec_desdellam    OUT NOCOPY VARCHAR2,
                                                                                EV_fec_hastallam    OUT NOCOPY VARCHAR2,
                                                                                EV_dia_periodo      OUT NOCOPY VARCHAR2,
                                                                                EV_fec_desdecfijos  OUT NOCOPY VARCHAR2,
                                                                                EV_fec_hastacfijos  OUT NOCOPY VARCHAR2,
                                                                        EV_fec_desdeocargos OUT NOCOPY VARCHAR2,
                                                                                EV_fec_hastaocargos OUT NOCOPY VARCHAR2,
                                                                                EV_fec_desderoa         OUT NOCOPY VARCHAR2,
                                                                                EV_fec_hastaroa         OUT NOCOPY VARCHAR2,
                                                                                EV_ind_facturacion      OUT NOCOPY VARCHAR2,
                                                                        EV_dir_logs             OUT NOCOPY VARCHAR2,
                                                                                EV_dir_spool            OUT NOCOPY VARCHAR2,
                                                                                EV_des_leyen1           OUT NOCOPY VARCHAR2,
                                                                                EV_des_leyen2           OUT NOCOPY VARCHAR2,
                                                                                EV_des_leyen3           OUT NOCOPY VARCHAR2,
                                                                                EV_des_leyen4           OUT NOCOPY VARCHAR2,
                                                                                EV_des_leyen5           OUT NOCOPY VARCHAR2,
                                                                                EV_ind_tasador          OUT NOCOPY VARCHAR2,
                                                                        SN_codRetorno           OUT NOCOPY ge_errores_pg.CodError,
                                                SV_menRetorno           OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_numEvento            OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "FA_getCicloFacturacion_PR"
                        Lenguaje="PL/SQL"
                        Fecha="14-06-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Retorna ciclo facturacion mas proximo
                </Retorno>
                <Descripción>
                                  Retorna ciclo facturacion mas proximo
                </Descripción>
                <Parámetros>
                 <Entrada>
                            <param nom="EV_cod_ciclo"        Tipo="STRING"> </param>
                                <param nom="EV_ano"              Tipo="STRING"> </param>
                                <param nom="EV_cod_ciclfact"     Tipo="STRING"> </param>
                                <param nom="EV_fec_vencimie"     Tipo="STRING"> </param>
                                <param nom="EV_fec_emision"      Tipo="STRING"> </param>
                                <param nom="EV_fec_caducida"     Tipo="STRING"> </param>
                                <param nom="EV_fec_proxvenc"     Tipo="STRING"> </param>
                                <param nom="EV_fec_desdellam"    Tipo="STRING"> </param>
                                <param nom="EV_fec_hastallam"    Tipo="STRING"> </param>
                                <param nom="EV_dia_periodo"      Tipo="STRING"> </param>
                                <param nom="EV_fec_desdecfijos"  Tipo="STRING"> </param>
                                <param nom="EV_fec_hastacfijos"  Tipo="STRING"> </param>
                                <param nom="EV_fec_desdeocargos" Tipo="STRING"> </param>
                                <param nom="EV_fec_hastaocargos" Tipo="STRING"> </param>
                                <param nom="EV_fec_desderoa"     Tipo="STRING"> </param>
                                <param nom="EV_fec_hastaroa"     Tipo="STRING"> </param>
                                <param nom="EV_ind_facturacion"  Tipo="STRING"> </param>
                                <param nom="EV_dir_logs"                 Tipo="STRING"> </param>
                                <param nom="EV_dir_spool"                Tipo="STRING"> </param>
                                <param nom="EV_des_leyen1"               Tipo="STRING"> </param>
                                <param nom="EV_des_leyen2"               Tipo="STRING"> </param>
                                <param nom="EV_des_leyen3"               Tipo="STRING"> </param>
                                <param nom="EV_des_leyen4"               Tipo="STRING"> </param>
                                <param nom="EV_des_leyen5"               Tipo="STRING"> </param>
                                <param nom="EV_ind_tasador"      Tipo="STRING"> </param>
                         </Entrada>
                         <Salida>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                LV_sql := 'SELECT cod_ciclo, ano, cod_ciclfact, fec_vencimie, fec_emision,fec_caducida, fec_proxvenc,';
                LV_sql := LV_sql||' fec_desdellam, fec_hastallam, dia_periodo, fec_desdecfijos, fec_hastacfijos,';
                LV_sql := LV_sql||' fec_desdeocargos, fec_hastaocargos, fec_desderoa, fec_hastaroa, ind_facturacion,';
                LV_sql := LV_sql||' dir_logs, dir_spool,des_leyen1, des_leyen2, des_leyen3,des_leyen4,des_leyen5, ind_tasador';
                LV_sql := LV_sql||' FROM fa_ciclfact a';
                LV_sql := LV_sql||' WHERE a.fec_desdellam = (SELECT min(b.fec_desdellam)';
                LV_sql := LV_sql||'                          FROM fa_ciclfact b ';
                LV_sql := LV_sql||'                          WHERE b.fec_desdellam >= sysdate AND';
                LV_sql := LV_sql||'                          b.cod_ciclo NOT IN (SELECT ged.cod_valor';
                LV_sql := LV_sql||'                                                                         FROM ged_codigos ged';
                LV_sql := LV_sql||'                                                                             WHERE ged.cod_modulo = GA';
                LV_sql := LV_sql||'                                                                     AND ged.nom_tabla = FA_CICLOS';
                LV_sql := LV_sql||'                                                   AND ged.nom_columna = COD_CICLO))';

                SELECT cod_ciclo,
                       ano,
                           cod_ciclfact,
                           fec_vencimie,
                           fec_emision,
                           fec_caducida,
                           fec_proxvenc,
                       fec_desdellam,
                           fec_hastallam,
                           dia_periodo,
                           fec_desdecfijos,
                           fec_hastacfijos,
                       fec_desdeocargos,
                           fec_hastaocargos,
                           fec_desderoa,
                           fec_hastaroa,
                           ind_facturacion,
                       dir_logs,
                           dir_spool,
                           des_leyen1,
                           des_leyen2,
                           des_leyen3,
                           des_leyen4,
                           des_leyen5,
                           ind_tasador
                INTO EV_cod_ciclo,
                     EV_ano,
                         EV_cod_ciclfact,
                         EV_fec_vencimie,
                         EV_fec_emision,
                         EV_fec_caducida,
                         EV_fec_proxvenc,
                     EV_fec_desdellam,
                         EV_fec_hastallam,
                         EV_dia_periodo,
                         EV_fec_desdecfijos,
                         EV_fec_hastacfijos,
                     EV_fec_desdeocargos,
                         EV_fec_hastaocargos,
                         EV_fec_desderoa,
                         EV_fec_hastaroa,
                         EV_ind_facturacion,
                     EV_dir_logs,
                         EV_dir_spool,
                         EV_des_leyen1,
                         EV_des_leyen2,
                         EV_des_leyen3,
                         EV_des_leyen4,
                         EV_des_leyen5,
                         EV_ind_tasador
                FROM fa_ciclfact a
                WHERE a.fec_desdellam = (SELECT min(b.fec_desdellam)
                                         FROM fa_ciclfact b
                                                                 WHERE b.fec_desdellam >= sysdate
                                                                   AND b.cod_ciclo NOT IN (SELECT ged.cod_valor
                                                                   FROM ged_codigos ged
                                                                                                                   WHERE ged.cod_modulo = CV_MODULO_GA
                                                                                                                     AND ged.nom_tabla = CV_TAB_FACICLOS
                                                                                                                         AND ged.nom_columna = CV_COL_FACICLOS));

        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_getCicloFacturacion_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getCicloFacturacion_PR', LV_Sql, SQLCODE, LV_desError );
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_getCicloFacturacion_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getCicloFacturacion_PR', LV_Sql, SQLCODE, LV_desError );
        END FA_getCicloFacturacion_PR;

        PROCEDURE FA_getListCiclosPostPago_PR(EN_CicloPrepago IN  fa_ciclos.cod_ciclo%TYPE,
                                              SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                                          SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "FA_getListCiclosPostPago_PR"
                        Lenguaje="PL/SQL"
                        Fecha="22-05-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Cursor
                </Retorno>
                <Descripción>
                                  Retorna lista de ciclos, excepto ciclo prepago
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EN_CicloPrepago" Tipo="NUMBER"> codigo ciclo prepago </param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor ciclos </param>
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

                LV_Sql:='SELECT a.cod_ciclo,a.des_ciclo '
                        || 'FROM fa_ciclos a '
                        || 'WHERE a.cod_ciclo <> ' || EN_CicloPrepago
                        || 'AND a.cod_ciclo NOT IN ('
                        || '                SELECT b.cod_valor '
                        || '                FROM ged_codigos b  '
                        || '                WHERE b.cod_modulo = ' || CV_MODULO_GA
                        || '                AND b.nom_tabla = ' || CV_TAB_FACICLOS
                        || '                AND b.nom_columna = '       || CV_COL_FACICLOS
                        || '                )';

                LN_contador := 0;
                SELECT COUNT(1)
                INTO LN_contador
                FROM fa_ciclos a
                WHERE a.cod_ciclo <> EN_CicloPrepago
                  AND a.cod_ciclo NOT IN (SELECT b.cod_valor
                                              FROM ged_codigos b
                                              WHERE b.cod_modulo = CV_MODULO_GA
                                                AND b.nom_tabla = CV_TAB_FACICLOS
                                                AND b.nom_columna = CV_COL_FACICLOS);

                OPEN SC_cursorDatos FOR
                SELECT a.cod_ciclo,UPPER(a.des_ciclo)
                FROM fa_ciclos a
                WHERE a.cod_ciclo <> EN_CicloPrepago
                  AND a.cod_ciclo NOT IN (SELECT b.cod_valor
                                              FROM ged_codigos b
                                              WHERE b.cod_modulo = CV_MODULO_GA
                                                AND b.nom_tabla = CV_TAB_FACICLOS
                                                AND b.nom_columna = CV_COL_FACICLOS)
                                                ORDER BY DES_CICLO;

                IF (LN_contador = 0) THEN
                        RAISE NO_DATA_FOUND_CURSOR;
                END IF;

        EXCEPTION
                        WHEN NO_DATA_FOUND_CURSOR THEN
                                 SN_codRetorno:=1;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                            SV_menRetorno := CV_error_no_clasif;
                         END IF;
                         LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:FA_Servicios_Facturacion_PG.FA_getListCiclosPostPago_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                         SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'FA_Servicios_Facturacion_PG.FA_getListCiclosPostPago_PR', LV_Sql, SN_codRetorno, LV_desError );
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_getListCiclosPostPago_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getListCiclosPostPago_PR', LV_Sql, SQLCODE, LV_desError );
        END FA_getListCiclosPostPago_PR;

        PROCEDURE FA_getDiasProrrateo_PR(EV_codCiclo      IN  VARCHAR2,
                                         EV_formatoFecha  IN  VARCHAR2,
                                                                         SV_diasProrrateo OUT NOCOPY VARCHAR2,
                                                                         SV_cantDias      OUT NOCOPY VARCHAR2,
                                                                     SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "FA_getDiasProrrateo_PR"
                        Lenguaje="PL/SQL"
                        Fecha="11-09-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Retorna numero de dias prorrateo para el abonado
                </Retorno>
                <Descripción>
                                  Retorna numero de dias prorrateo para el abonado
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_codCiclo"     Tipo="STRING"> codigo ciclo </param>
                           <param nom="EV_formatoFecha" Tipo="STRING"> formato fecha </param>
                         </Entrada>
                 <Salida>
                   <param nom="SV_diasProrrateo" Tipo="STRING"> numero dias prorrateo </param>
                           <param nom="SV_cantDias"      Tipo="STRING"> cantidad de dias</param>
                           <param nom="SN_codRetorno"    Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"    Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"     Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;
                SV_diasProrrateo := NULL;
                SV_cantDias := NULL;

                LV_Sql:= 'SELECT a.dia_periodo,'
                      || ' (TO_DATE(TO_CHAR(a.fec_hastallam,''' || EV_formatoFecha || ''')) - TO_DATE(TO_CHAR(SYSDATE,''' || EV_formatoFecha || '''))) + 1'
                      || ' FROM fa_ciclfact a'
                      || ' WHERE a.cod_ciclo =' || EV_codCiclo
                      || ' AND SYSDATE BETWEEN a.fec_desdellam AND a.fec_hastallam';


                SELECT a.dia_periodo,
            (TO_DATE(TO_CHAR(a.fec_hastallam,EV_formatoFecha)) - TO_DATE(TO_CHAR(SYSDATE,EV_formatoFecha))) + 1
            INTO SV_diasProrrateo, SV_cantDias
            FROM fa_ciclfact a
            WHERE a.cod_ciclo = EV_codCiclo
            AND SYSDATE BETWEEN a.fec_desdellam AND a.fec_hastallam;

        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_getDiasProrrateo_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getDiasProrrateo_PR', LV_Sql, SQLCODE, LV_desError );
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_getDiasProrrateo_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getDiasProrrateo_PR', LV_Sql, SQLCODE, LV_desError );
        END FA_getDiasProrrateo_PR;

        PROCEDURE FA_getImpuesto_PR(EV_codCliente IN  VARCHAR2,
                                    EV_codOficina IN  VARCHAR2,
                                    EN_importe    IN  NUMBER,
                                    EN_codConcepto IN FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                                    SN_imptotal   OUT NOCOPY NUMBER,
                                    SN_codRetorno OUT NOCOPY ge_errores_pg.CodError,
                                    SV_menRetorno OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_numEvento  OUT NOCOPY ge_errores_pg.Evento) AS PRAGMA AUTONOMOUS_TRANSACTION;
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "FA_getImpuesto_PR"
                        Lenguaje="PL/SQL"
                        Fecha="28-08-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Importe cargo basifo afecto impuesto
                </Retorno>
                <Descripción>
                                  Obtiene Impuesto
                </Descripción>
                <Parámetros>
                 <Entrada>
                   <param nom="EV_codCliente"      Tipo="STRING"> codigo del cliente </param>
                   <param nom="EV_codOficina"      Tipo="STRING"> codigo oficina </param>
                   <param nom="EN_importe"         Tipo="NUMBER"> importe </param>
                         </Entrada>
                 <Salida>
                           <param nom="SN_impuesto"     Tipo="NUMBER"> impuesto </param>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */

                LV_desError  ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;

                LN_codAbonocel NUMBER;
                LN_codCatImpos NUMBER;
                LN_codTipconce NUMBER;
                LN_numProceso  NUMBER;
                LN_impuesto    NUMBER;
                LN_descuento   NUMBER;
                LN_contador    NUMBER;
                LV_proc        VARCHAR2(50);
                LV_tabla           VARCHAR2(50);
            LV_act                 VARCHAR2(50);
            LV_sqlCode     VARCHAR2(50);
            LV_SQLERRM     VARCHAR2(50);
            LV_error       VARCHAR2(50);
        BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;
                SN_imptotal   := 0;
                LN_impuesto   := 0;
                LN_descuento  := 0;


                -- Numero de Proceso
                LV_Sql:='SELECT fas_presuptemp.NEXTVAL'
                      || ' FROM DUAL';

                SELECT fas_presuptemp.NEXTVAL
                INTO LN_numProceso
                FROM DUAL;

                -- Categoria impositiva del cliente
                LV_Sql:='SELECT cod_catimpos'
                          || ' FROM ge_catimpclientes'
                          || ' WHERE cod_cliente = ' || EV_codCliente
                          || ' AND SYSDATE BETWEEN fec_desde AND fec_hasta';

                SELECT cod_catimpos
                INTO LN_codCatImpos
                FROM ge_catimpclientes
                WHERE cod_cliente = EV_codCliente
                AND SYSDATE BETWEEN fec_desde AND fec_hasta;

                
                
                IF  EN_codConcepto = 0 THEN 
                
                
                    -- Codigo de concepto para el cargo basico
                    LV_Sql:='SELECT a.cod_abonocel'
                             || ' FROM fa_datosgener a';

                    SELECT a.cod_abonocel
                    INTO LN_codAbonocel
                    FROM fa_datosgener a;
                    
               ELSE 
                    LN_codAbonocel:=EN_codConcepto;
               END IF;          

                    -- Tipo de concepto
               LV_Sql:='SELECT a.cod_tipconce'
                       || ' FROM fa_conceptos a'
                       || ' WHERE a.cod_concepto = ' || LN_codAbonocel;

               SELECT a.cod_tipconce
               INTO LN_codTipconce
               FROM fa_conceptos a
               WHERE a.cod_concepto = LN_codAbonocel;
                    
                

                LV_Sql:='INSERT INTO fat_presuptemp (num_proceso,'
                          || ' cod_concepto,'
                          || ' columna,'
                          || ' cod_cliente,'
                          || ' fec_efectividad,'
                          || ' imp_concepto,'
                          || ' imp_facturable,'
                          || ' cod_tipconce)'
                      || ' VALUES (' || LN_numProceso || ','
                          || LN_codAbonocel || ',1,'
                          || EV_codCliente || ','
                          || SYSDATE || ','
                          || EN_importe || ','
                          || EN_importe || ','
                          || LN_codTipconce || ')';

                INSERT INTO fat_presuptemp (num_proceso,
                                            cod_concepto,
                                                                        columna,
                                                                        cod_cliente,
                                                                        fec_efectividad,
                                                                        imp_concepto,
                                                                        imp_facturable,
                                                                        cod_tipconce)
                VALUES (LN_numProceso,
                        LN_codAbonocel,
                                1,
                                EV_codCliente,
                                SYSDATE,
                                EN_importe,
                                EN_importe,
                                LN_codTipconce);

                LV_Sql:= 'fa_proc_imptos(' || LN_numProceso || ','
                         || LN_codCatImpos || ','
                                 || EV_codOficina || ','
                                 || LV_proc || ','
                                 || LV_tabla || ','
                                 || LV_act || ','
                                 || LV_sqlCode || ','
                                 || LV_SQLERRM || ','
                                 || LV_error || ')' ;

        fa_proc_imptos(LN_numProceso,
                         LN_codCatImpos,
                                 EV_codOficina,
                                 LV_proc,
                                 LV_tabla,
                                 LV_act,
                                 LV_sqlCode,
                                 LV_SQLERRM,
                                 LV_error);



                LV_Sql:= 'SELECT SUM(a.imp_facturable)'
                         || ' FROM fat_presuptemp a'
                                 || ' WHERE a.num_proceso = ' || LN_numProceso
                                 || ' AND a.cod_tipconce = 1'
                                 || ' GROUP BY a.cod_concerel';


                LN_contador := 0;

                SELECT COUNT(1)
            INTO LN_contador
                FROM fat_presuptemp a
                WHERE a.num_proceso = LN_numProceso
                AND a.cod_tipconce = 1;

                IF (LN_contador > 0) THEN
                  SELECT SUM(a.imp_facturable)
                  INTO LN_impuesto
                  FROM fat_presuptemp a
                  WHERE a.num_proceso = LN_numProceso
                  AND a.cod_tipconce = 1
                  GROUP BY a.cod_concerel;
                END IF;

                LV_Sql:= 'SELECT SUM(a.imp_facturable)'
                         || ' FROM fat_presuptemp a'
                                 || ' WHERE a.num_proceso = ' || LN_numProceso
                                 || ' AND a.cod_tipconce = 2'
                                 || ' AND a.cod_concerel IN'
                                 || ' (SELECT b.cod_concepto FROM fat_presuptemp b'
                                 || ' WHERE b.num_proceso = ' ||  LN_numProceso
                                 || ' AND b.cod_tipconce = 1)'
                                 || ' GROUP BY a.cod_concerel';


        LN_contador := 0;

        SELECT COUNT(1)
            INTO LN_contador
                FROM fat_presuptemp a
                WHERE a.num_proceso = LN_numProceso
        AND a.cod_tipconce = 2
                AND a.cod_concerel IN
                        (SELECT b.cod_concepto FROM fat_presuptemp b
                         WHERE b.num_proceso = LN_numProceso
                 AND b.cod_tipconce = 1);


            IF (LN_contador > 0) THEN
                   SELECT SUM(a.imp_facturable)
                   INTO LN_descuento
                   FROM fat_presuptemp a
                   WHERE a.num_proceso = LN_numProceso
           AND a.cod_tipconce = 2
                   AND a.cod_concerel IN
                           (SELECT b.cod_concepto FROM fat_presuptemp b
                           WHERE b.num_proceso = LN_numProceso
                   AND b.cod_tipconce = 1)
                           GROUP BY a.cod_concerel;
                END IF;
                
                
                COMMIT;

                SN_imptotal := EN_importe + LN_impuesto + LN_descuento;


        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_getImpuesto_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getImpuesto_PR', LV_Sql, SQLCODE, LV_desError );
                 WHEN OTHERS THEN
                            SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_getImpuesto_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getImpuesto_PR', LV_Sql, SQLCODE, LV_desError );
        END FA_getImpuesto_PR;

PROCEDURE FA_getFolios_PR(EV_codCliente  IN         GE_CLIENTES.COD_CLIENTE%TYPE,
                          EV_codOficina  IN         GE_OFICINAS.COD_OFICINA%TYPE,
                          SN_CodTipDocum OUT NOCOPY GE_TIPDOCUMEN.COD_TIPDOCUM%TYPE,
                          SV_DesTipDocum OUT NOCOPY GE_TIPDOCUMEN.DES_TIPDOCUM%TYPE,
                          SV_FOLIO       OUT NOCOPY VARCHAR2,   
                          SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                          SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                          SN_numEvento   OUT NOCOPY ge_errores_pg.Evento) IS

 LV_desError  ge_errores_pg.desevent;
 LV_sql           ge_errores_pg.vquery;
 LN_codAbonocel  NUMBER;
 LN_codCatImpos  NUMBER;
 LN_codTipconce  NUMBER;
 LN_numProceso   NUMBER;
 LN_impuesto     NUMBER;
 LN_descuento    NUMBER;
 LN_contador     NUMBER;
 LV_proc         VARCHAR2(50);
 LV_tabla        VARCHAR2(50);
 LV_act          VARCHAR2(50);
 LV_sqlCode      VARCHAR2(50);
 LV_SQLERRM      VARCHAR2(50);
 LV_error        VARCHAR2(50);
 LV_codCatribut  GA_CATRIBUTCLIE.COD_CATRIBUT%TYPE;
 LV_TipFolio     GE_TIPDOCUMEN.TIP_FOLIACION%TYPE;
 v_cod_operadora ge_parametros_sistema_vw.VALOR_TEXTO%TYPE;
 LV_CADENA      VARCHAR2(50);
 LA_arreglo VE_INTERMEDIARIO_PG.tipoArray := VE_INTERMEDIARIO_PG.tipoArray();
 LV_Ind_Consumo  VARCHAR2(1);
 
 LE_NOTIENEFOLIO  EXCEPTION;
 LE_MUCHOS_FOLIOS EXCEPTION;
 LE_AGENTE_COMERCIAL EXCEPTION;
 LE_IND_FACTURACION EXCEPTION;
 LE_GENERAL EXCEPTION;
 LV_CodEstadoFolio NUMBER(5);
 LV_prefijoFolio VARCHAR2(20);
 LN_CorrelativoFolio AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
 LV_Count Number(5);
 
 
 
        
        BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;
                
                
                --Obtener Operadora
                
                v_cod_operadora:=GE_OBTIENE_OPERADORA_LOCAL_FN(SN_codRetorno,SV_menRetorno,SN_numEvento);
                IF SN_codRetorno <> 0 THEN 
                   RAISE LE_GENERAL;   
                END IF;
                
                
                SELECT COUNT(1) 
                INTO LV_Count
                FROM   npt_usuario_cliente a
                WHERE  a.cod_cliente=EV_codcliente;
                
                
                IF LV_COUNT >0 THEN 
                    RAISE LE_AGENTE_COMERCIAL;
                END IF;
                
                
                --1.-Obtener Categoria Tributaria Cliente
                
                SELECT COD_CATRIBUT
                INTO LV_codCatribut 
                FROM GA_CATRIBUTCLIE 
                WHERE COD_CLIENTE=EV_codCliente
                AND SYSDATE BETWEEN fec_desde AND fec_hasta;
                
                
                
                --2.- Obtener Informacion de la Categoria Tributaria
                
                SELECT b.cod_tipdocum, b.des_tipdocum, b.tip_foliacion
                INTO SN_CodTipDocum,SV_DesTipDocum,LV_TipFolio
                FROM ge_catribdocum a, ge_tipdocumen b
                WHERE a.cod_catribut = LV_codCatribut
                AND SYSDATE BETWEEN a.fec_desde AND a.fec_hasta
                AND a.cod_tipdocum = b.cod_tipdocum
                AND ROWNUM=1;
                
                
                
                --3.- Llamar Procedimiento consulta Folios
                
                LV_Ind_Consumo := ge_fn_devvalparam('VE',1,'IND_FACTURACION'); -- Incidencia GUA 143389 -19-08-2010
                
                IF LV_Ind_Consumo = 'ERROR' THEN
                    RAISE LE_IND_FACTURACION;
                END IF;
                
                SELECT FA_FOLIACION_PG.FA_CONSULTA_FOLIO_FN(SN_CodTipDocum, NULL, EV_codOficina, v_cod_operadora ,NULL, NULL, NULL, 2,LV_Ind_Consumo) 
                INTO LV_CADENA
                FROM DUAL;
                
                LA_arreglo := VE_INTERMEDIARIO_PG.VE_descompone_cadena_FN(LV_cadena,';', SN_codretorno, SV_menRetorno, SN_numEvento);
                
                IF SN_codRetorno<> 0 THEN 
                   RAISE LE_GENERAL;
                END IF;
                
                
                --1)CodEstadoFolio
                --2)PrefijoFolio
                --3)CorrelativoFolio
                
                LV_CodEstadoFolio:=LA_arreglo(1);
                LV_prefijoFolio:=LA_arreglo(2);
                LN_CorrelativoFolio:=LA_arreglo(3);
                
                IF LV_CodEstadoFolio=4 THEN 
                   RAISE LE_NOTIENEFOLIO; 
                ELSIF LV_CodEstadoFolio=5 THEN 
                   RAISE LE_MUCHOS_FOLIOS; 
                ELSE
                   SV_FOLIO:=LV_prefijoFolio || LN_CorrelativoFolio;  
                END IF;
        
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_getImpuesto_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getImpuesto_PR', LV_Sql, SQLCODE, LV_desError );
                 WHEN LE_IND_FACTURACION THEN
                            SN_codRetorno := 156;
                            SV_menRetorno:='Error al recuperar parámetro Foliación Manual o Automática.';
                            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                               SV_menRetorno := CV_error_no_clasif;
                            END IF;
                            LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_getImpuesto_PR;- ' || SQLERRM;
                            SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                            'FA_Servicios_Facturacion_PG.FA_getImpuesto_PR', LV_Sql, SQLCODE, LV_desError );
                    
                 WHEN LE_GENERAL THEN
                            SN_codRetorno := 156;
                            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                               SV_menRetorno := CV_error_no_clasif;
                            END IF;
                            LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_getImpuesto_PR;- ' || SQLERRM;
                            SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                            'FA_Servicios_Facturacion_PG.FA_getImpuesto_PR', LV_Sql, SQLCODE, LV_desError );
                 WHEN LE_NOTIENEFOLIO THEN
                            SN_codRetorno := 156;
                            SV_menRetorno:='Vendedor no tiene folios disponibles para operadora del cliente. No se Puede continuar con la venta.';
                            LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_getImpuesto_PR;- ' || SQLERRM;
                            SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                            'FA_Servicios_Facturacion_PG.FA_getImpuesto_PR', LV_Sql, SQLCODE, LV_desError );
                 WHEN LE_MUCHOS_FOLIOS THEN
                            SN_codRetorno := 156;
                            SV_menRetorno:='Se encontro más de un rango de folios para el cliente seleccionado';
                            LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_getImpuesto_PR;- ' || SQLERRM;
                            SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                            'FA_Servicios_Facturacion_PG.FA_getImpuesto_PR', LV_Sql, SQLCODE, LV_desError );
                 WHEN LE_AGENTE_COMERCIAL THEN
                            SN_codRetorno := 156;
                            SV_menRetorno:='Cliente corresponde a un agente Comercial';
                            LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_getImpuesto_PR;- ' || SQLERRM;
                            SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                            'FA_Servicios_Facturacion_PG.FA_getImpuesto_PR', LV_Sql, SQLCODE, LV_desError );
                 
                 
                 WHEN OTHERS THEN
                            SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_getImpuesto_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getImpuesto_PR', LV_Sql, SQLCODE, LV_desError );
                 
                                
        END FA_getFolios_PR;
 PROCEDURE FA_getProrrateo_PR(EV_numAbonado  IN         GA_ABOCEL.NUM_ABONADO%TYPE,
                              EV_IMPORTE     IN         NUMBER,
                              SN_IMPORTE     OUT NOCOPY NUMBER, 
                              SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                              SN_numEvento   OUT NOCOPY ge_errores_pg.Evento) IS

 LV_desError  ge_errores_pg.desevent;
 LV_sql           ge_errores_pg.vquery;
 LN_codAbonocel  NUMBER;
 LN_codCatImpos  NUMBER;
 LN_codTipconce  NUMBER;
 LN_numProceso   NUMBER;
 LN_impuesto     NUMBER;
 LN_descuento    NUMBER;
 LN_contador     NUMBER;
 LV_proc         VARCHAR2(50);
 LV_tabla        VARCHAR2(50);
 LV_act          VARCHAR2(50);
 LV_sqlCode      VARCHAR2(50);
 LV_SQLERRM      VARCHAR2(50);
 LV_error        VARCHAR2(50);
 LV_numFac       GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        
 BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;
                
                SELECT VAL_PARAMETRO 
                INTO LV_numFac 
                FROM GED_PARAMETROS
                WHERE NOM_PARAMETRO='NUM_DECIMAL_FACT';
                
                
                
                
                LV_sql:='SELECT ROUND((' || EV_IMPORTE || '*(((A.FEC_HASTALLAM - TRUNC(SYSDATE)) )/A.DIA_PERIODO)),2)';
                LV_sql:= LV_sql || ' FROM FA_CICLFACT A, GA_ABOCEL B'; 
                LV_sql:= LV_sql || ' WHERE A.COD_CICLO = B.COD_CICLO'; 
                LV_sql:= LV_sql || ' AND SYSDATE BETWEEN A.FEC_DESDELLAM AND A.FEC_HASTALLAM'; 
                LV_sql:= LV_sql || ' AND B.NUM_ABONADO =' || EV_numAbonado;
                
                
                SELECT ROUND((EV_IMPORTE*(((A.FEC_HASTALLAM - TRUNC(SYSDATE)))/A.DIA_PERIODO)),LV_numFac)
                INTO SN_IMPORTE
                FROM FA_CICLFACT A, GA_ABOCEL B 
                WHERE A.COD_CICLO = B.COD_CICLO 
                AND SYSDATE BETWEEN A.FEC_DESDELLAM AND A.FEC_HASTALLAM 
                AND B.NUM_ABONADO = EV_numAbonado;
                
        
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_getProrrateo_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getProrrateo_PR', LV_Sql, SQLCODE, LV_desError );
                 
                 WHEN OTHERS THEN
                            SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_getProrrateo_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getProrrateo_PR', LV_Sql, SQLCODE, LV_desError );
                 
                                
 END FA_getProrrateo_PR;
  PROCEDURE FA_getProrrateoPA_PR(
                              EV_numAbonado  IN         GA_ABOCEL.NUM_ABONADO%TYPE,
                              EN_CARGO       IN         PF_CARGOS_PRODUCTOS_TD.COD_CARGO%TYPE,
                              SN_IMPORTE     OUT NOCOPY NUMBER, 
                              SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                              SN_numEvento   OUT NOCOPY ge_errores_pg.Evento) IS

 LV_desError  ge_errores_pg.desevent;
 LV_sql           ge_errores_pg.vquery;
 LN_codAbonocel  NUMBER;
 LN_codCatImpos  NUMBER;
 LN_codTipconce  NUMBER;
 LN_numProceso   NUMBER;
 LN_impuesto     NUMBER;
 LN_descuento    NUMBER;
 LN_contador     NUMBER;
 LV_proc         VARCHAR2(50);
 LV_tabla        VARCHAR2(50);
 LV_act          VARCHAR2(50);
 LV_sqlCode      VARCHAR2(50);
 LV_SQLERRM      VARCHAR2(50);
 LV_error        VARCHAR2(50);
 EV_IMPORTE      NUMBER(14,4);
 
        
 BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;
                
                SELECT MONTO_IMPORTE 
                INTO EV_IMPORTE 
                FROM PF_CARGOS_PRODUCTOS_TD
                WHERE COD_CARGO=EN_CARGO;
                
                
                LV_sql:='SELECT ROUND((' || EV_IMPORTE || '*(((A.FEC_HASTALLAM - TRUNC(SYSDATE)))/A.DIA_PERIODO)),2)';
                LV_sql:= LV_sql || ' FROM FA_CICLFACT A, GA_ABOCEL B'; 
                LV_sql:= LV_sql || ' WHERE A.COD_CICLO = B.COD_CICLO'; 
                LV_sql:= LV_sql || ' AND SYSDATE BETWEEN A.FEC_DESDELLAM AND A.FEC_HASTALLAM'; 
                LV_sql:= LV_sql || ' AND B.NUM_ABONADO =' || EV_numAbonado;
                
                
                SELECT ROUND((EV_IMPORTE*(((A.FEC_HASTALLAM - TRUNC(SYSDATE)))/A.DIA_PERIODO)),2)
                INTO SN_IMPORTE
                FROM FA_CICLFACT A, GA_ABOCEL B 
                WHERE A.COD_CICLO = B.COD_CICLO 
                AND SYSDATE BETWEEN A.FEC_DESDELLAM AND A.FEC_HASTALLAM 
                AND B.NUM_ABONADO = EV_numAbonado;
                
        
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_getProrrateo_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getProrrateo_PR', LV_Sql, SQLCODE, LV_desError );
                 
                 WHEN OTHERS THEN
                            SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_getProrrateo_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getProrrateo_PR', LV_Sql, SQLCODE, LV_desError );
                 
                                
 END FA_getProrrateoPA_PR;        
 FUNCTION FA_getImpuesto_FN (EN_codCliente IN GE_CLIENTES.COD_CLIENTE%TYPE,
                             EV_codOficina IN GE_OFICINAS.COD_OFICINA%TYPE, 
                             EN_IMPORTE IN NUMBER,
                             EN_CodConcepto IN FA_CONCEPTOS.COD_CONCEPTO%TYPE
                             ) RETURN NUMBER AS PRAGMA AUTONOMOUS_TRANSACTION;
           
           SN_IMPTOTAL NUMBER(14,4);
           SN_codRetorno ge_errores_pg.CodError;
           SV_menRetorno ge_errores_pg.MsgError;
           SN_numEvento  ge_errores_pg.Evento;
           
BEGIN
              
              IF EN_IMPORTE IS NULL THEN
                 RETURN 0; 
              END IF;
              
              FA_getImpuesto_PR(EN_codCliente,
                                EV_codOficina,
                                EN_importe,
                                EN_codConcepto,
                                SN_imptotal,
                                SN_codRetorno,
                                SV_menRetorno,
                                SN_numEvento);
           RETURN SN_imptotal;  
           
  COMMIT;
                  
END FA_getImpuesto_FN;
 PROCEDURE FA_ConsultaCobroAdelantado_PR(EN_numAbonado   IN       GA_ABOCEL.NUM_ABONADO%TYPE,
                                         EN_CodCiclfact  IN         FA_CICLFACT.COD_CICLFACT%TYPE,   
                                         EN_codConcepto  IN         FA_CONCEPTOS.COD_CONCEPTO%TYPE, 
                                         EN_EnvioH       IN         NUMBER, 
                                         SN_CantAbonados OUT NOCOPY NUMBER, 
                                         SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                         SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS

 LV_desError  ge_errores_pg.desevent;
 LV_sql           ge_errores_pg.vquery;
 LV_sqlCode      VARCHAR2(50);
 LV_SQLERRM      VARCHAR2(50);
 LV_error        VARCHAR2(50);
 LN_codCliente   GE_CLIENTES.COD_CLIENTE%TYPE;
        
 BEGIN
                SN_codRetorno   := 0;
                SV_menRetorno   := ' ';
                SN_numEvento    := 0;
                SN_CantAbonados := 0;                
                
                LV_sql:='SELECT COD_CLIENTE'
                       || ' FROM GA_ABOCEL'
                       || ' WHERE NUM_ABONADO='     || EN_numAbonado;
                       
                
                SELECT COD_CLIENTE 
                INTO LN_codCliente
                FROM GA_ABOCEL
                WHERE NUM_ABONADO=EN_numAbonado;                
                
                
                LV_sql:='SELECT COUNT(1)'
                       || ' FROM GA_COBROS_ADELANTADOS_TO'
                       || ' WHERE COD_CLIENTE=' || LN_codCliente
                       || ' AND NUM_ABONADO='     || EN_numAbonado
                       || ' COD_CICLFACT='      || EN_CodCiclfact               
                       || ' AND COD_CONCEPTO='  || EN_codConcepto; 
                
                SELECT COUNT(1) 
                INTO SN_CantAbonados
                FROM GA_COBROS_ADELANTADOS_TO
                WHERE COD_CLIENTE=LN_codCliente
                AND NUM_abonado=EN_numAbonado
                AND COD_CICLFACT=EN_CodCiclfact
                AND COD_CONCEPTO=EN_codConcepto;
                
                
                IF (EN_EnvioH>0 AND SN_CantAbonados > 0) THEN 
                   INSERT INTO GA_COBROS_ADELANTADOS_TH (NUM_COBRO,COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,COD_CONCEPTO,NUM_VENTA,FEC_COBRO,TIPO_SERVICIO,NUM_PROCESO)   
                   (SELECT NUM_COBRO,COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,COD_CONCEPTO,NUM_VENTA,FEC_COBRO,TIPO_SERVICIO,EN_EnvioH
                   FROM GA_COBROS_ADELANTADOS_TO
                   WHERE COD_CLIENTE=LN_codCliente
                   AND NUM_ABONADO=EN_numAbonado
                   AND COD_CICLFACT=EN_CodCiclfact
                   AND COD_CONCEPTO=EN_codConcepto
                   ); 
                   
                   DELETE 
                   FROM GA_COBROS_ADELANTADOS_TO
                   WHERE COD_CLIENTE=LN_codCliente
                   AND NUM_ABONADO=EN_numAbonado
                   AND COD_CICLFACT=EN_CodCiclfact
                   AND COD_CONCEPTO=EN_codConcepto;
                END IF;
                
                
        
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                SV_menRetorno:='OCURRIO UN ERROR AL CONSULTAR COBROS ADELANTADOS';
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR', LV_Sql, SQLCODE, LV_desError );
                 
                 WHEN OTHERS THEN
                            SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR', LV_Sql, SQLCODE, LV_desError );
                 
                                
 END FA_ConsultaCobroAdelantado_PR;
 PROCEDURE FA_ConsultaCobroAdelantadoH_PR(EV_codCliente  IN         GA_ABOCEL.COD_CLIENTE%TYPE,
                                          EN_numVenta    IN         GA_VENTAS.NUM_VENTA%TYPE,
                                          EN_CodCiclfact IN         FA_CICLFACT.COD_CICLFACT%TYPE,   
                                          EN_codConcepto IN         FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                                          SC_cursorDatos  OUT NOCOPY REFCURSOR, 
                                          SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_numEvento   OUT NOCOPY ge_errores_pg.Evento) IS

 LV_desError  ge_errores_pg.desevent;
 LV_sql           ge_errores_pg.vquery;
 LV_sqlCode      VARCHAR2(50);
 LV_SQLERRM      VARCHAR2(50);
 LV_error        VARCHAR2(50);
 
        
 BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;
                
                LV_sql:='SELECT NUM_COBRO,COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,COD_CONCEPTO'
                       || ' ,NUM_VENTA,FEC_COBRO,TIPO_SERVICIO,NUM_PROCESO'
                       || ' FROM GA_COBROS_ADELANTADOS_TH'
                       || ' WHERE COD_CLIENTE=' || EV_codCliente
                       || ' AND NUM_VENTA='     || EN_numVenta
                       || ' COD_CICLFACT='      || EN_CodCiclfact
                       || ' AND COD_CONCEPTO='  || EN_codConcepto;               
                
                
                OPEN SC_cursorDatos FOR 
                SELECT NUM_COBRO,COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,COD_CONCEPTO
                ,NUM_VENTA,FEC_COBRO,TIPO_SERVICIO,NUM_PROCESO 
                FROM GA_COBROS_ADELANTADOS_TO
                WHERE COD_CLIENTE=EV_codCliente
                AND NUM_VENTA=EN_numVenta
                AND COD_CICLFACT=EN_CodCiclfact
                AND COD_CONCEPTO=EN_codConcepto;
        
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantadoH_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantadoH_PR', LV_Sql, SQLCODE, LV_desError );
                 
                 WHEN OTHERS THEN
                            SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantadoH_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantadoH_PR', LV_Sql, SQLCODE, LV_desError );
                                
 END FA_ConsultaCobroAdelantadoH_PR;
 
  PROCEDURE FA_InsertaCobroAdelantadoUs_PR(EV_codCliente   IN  GA_ABOCEL.COD_CLIENTE%TYPE,
                                         EN_NumAbonado   IN  GA_ABOCEL.NUM_ABONADO%TYPE,  
                                         EN_numVenta     IN  GA_VENTAS.NUM_VENTA%TYPE,
                                         EN_CodCiclfact  IN  FA_CICLFACT.COD_CICLFACT%TYPE,   
                                         EN_codConcepto  IN  FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                                         EN_numProceso   IN  GA_COBROS_ADELANTADOS_TO.NUM_PROCESO%TYPE,
                                         EN_TipoConcepto IN  GA_COBROS_ADELANTADOS_TO.TIPO_SERVICIO%TYPE,
                                         EV_usuario      IN  GA_COBROS_ADELANTADOS_TO.NOM_USUARIO%TYPE,
                                         SN_NumCobro    OUT NOCOPY GA_COBROS_ADELANTADOS_TO.NUM_COBRO%TYPE,
                                         SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                         SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_numEvento   OUT NOCOPY ge_errores_pg.Evento) IS

 LV_desError  ge_errores_pg.desevent;
 LV_sql           ge_errores_pg.vquery;
 LV_sqlCode      VARCHAR2(50);
 LV_SQLERRM      VARCHAR2(50);
 LV_error        VARCHAR2(50);
 
        
 BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;
                
                
                SELECT GA_SEQ_COB_SQ.NEXTVAL 
                INTO SN_NumCobro
                FROM DUAL;
                
                
                LV_sql:='INSERT INTO GA_COBROS_ADELANTADOS_TO( '
                       || '  NUM_COBRO,COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,COD_CONCEPTO,NUM_VENTA'
                       || ' ,FEC_COBRO,TIPO_SERVICIO,NUM_PROCESO,NOM_USUARIO,FEC_ULTMOD)' 
                       || ' VALUES (' || SN_NumCobro || ',' || EV_codCliente || ',' 
                       ||   EN_NumAbonado || ',' || EN_CodCiclfact || ',' || EN_codConcepto || ',' ||  EN_numVenta
                       ||   ',SYSDATE,' || ',' || EN_TipoConcepto || ',' ||  EN_numProceso ||','|| EV_usuario || ',SYSDATE)';   
                                  
                INSERT INTO GA_COBROS_ADELANTADOS_TO
                (NUM_COBRO,COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,COD_CONCEPTO,NUM_VENTA,FEC_COBRO,TIPO_SERVICIO,NUM_PROCESO,NOM_USUARIO,FEC_ULTMOD)
                VALUES (SN_NumCobro,EV_codCliente,EN_NumAbonado,EN_CodCiclfact
                       ,EN_codConcepto,EN_numVenta,SYSDATE,EN_TipoConcepto,EN_numProceso,EV_usuario,SYSDATE);                
        
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getProrrateo_PR', LV_Sql, SQLCODE, LV_desError );
                 
                 WHEN OTHERS THEN
                            SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR', LV_Sql, SQLCODE, LV_desError );
                                
 END FA_InsertaCobroAdelantadoUs_PR;
 
  PROCEDURE FA_InsertaCobroAdelantado_PR(EV_codCliente   IN  GA_ABOCEL.COD_CLIENTE%TYPE,
                                         EN_NumAbonado   IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                         EN_numVenta     IN  GA_VENTAS.NUM_VENTA%TYPE,
                                         EN_CodCiclfact  IN  FA_CICLFACT.COD_CICLFACT%TYPE,
                                         EN_codConcepto  IN  FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                                         EN_numProceso   IN  GA_COBROS_ADELANTADOS_TO.NUM_PROCESO%TYPE,
                                         EN_TipoConcepto IN  GA_COBROS_ADELANTADOS_TO.TIPO_SERVICIO%TYPE,
                                         SN_NumCobro    OUT NOCOPY GA_COBROS_ADELANTADOS_TO.NUM_COBRO%TYPE,
                                         SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                         SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_numEvento   OUT NOCOPY ge_errores_pg.Evento) IS

 LV_desError  ge_errores_pg.desevent;
 LV_sql           ge_errores_pg.vquery;
 LV_sqlCode      VARCHAR2(50);
 LV_SQLERRM      VARCHAR2(50);
 LV_error        VARCHAR2(50);


 BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;


                SELECT GA_SEQ_COB_SQ.NEXTVAL
                INTO SN_NumCobro
                FROM DUAL;


                LV_sql:='INSERT INTO GA_COBROS_ADELANTADOS_TO( '
                       || '  NUM_COBRO,COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,COD_CONCEPTO,NUM_VENTA'
                       || ' ,FEC_COBRO,TIPO_SERVICIO,NUM_PROCESO)'
                       || ' VALUES (' || SN_NumCobro || ',' || EV_codCliente || ','
                       ||   EN_NumAbonado || ',' || EN_CodCiclfact || ',' || EN_codConcepto || ',' ||  EN_numVenta
                       ||   ',SYSDATE,' || ',' || EN_TipoConcepto || ',' ||  EN_numProceso || ', SYSDATE)';

                INSERT INTO GA_COBROS_ADELANTADOS_TO
                (NUM_COBRO,COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,COD_CONCEPTO,NUM_VENTA,FEC_COBRO,TIPO_SERVICIO,NUM_PROCESO,FEC_ULTMOD)
                VALUES (SN_NumCobro,EV_codCliente,EN_NumAbonado,EN_CodCiclfact
                       ,EN_codConcepto,EN_numVenta,SYSDATE,EN_TipoConcepto,EN_numProceso,SYSDATE);

        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getProrrateo_PR', LV_Sql, SQLCODE, LV_desError );

                 WHEN OTHERS THEN
                            SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR', LV_Sql, SQLCODE, LV_desError );

 END FA_InsertaCobroAdelantado_PR;
 
PROCEDURE FA_InsertaCobroAdelantadoH_PR (EV_codCliente   IN  GA_ABOCEL.COD_CLIENTE%TYPE,
                                         EN_numCobro     IN GA_COBROS_ADELANTADOS_TO.NUM_COBRO%TYPE, 
                                         EN_fec_alta     IN GA_COBROS_ADELANTADOS_TO.FEC_COBRO%TYPE,
                                         EN_NumAbonado   IN  GA_ABOCEL.NUM_ABONADO%TYPE,  
                                         EN_numVenta     IN  GA_VENTAS.NUM_VENTA%TYPE,
                                         EN_CodCiclfact  IN  FA_CICLFACT.COD_CICLFACT%TYPE,   
                                         EN_codConcepto  IN  FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                                         EN_numProceso   IN  GA_COBROS_ADELANTADOS_TO.NUM_PROCESO%TYPE,
                                         EN_TipoConcepto IN  GA_COBROS_ADELANTADOS_TO.TIPO_SERVICIO%TYPE,
                                         SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                         SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_numEvento   OUT NOCOPY ge_errores_pg.Evento) IS

 LV_desError  ge_errores_pg.desevent;
 LV_sql           ge_errores_pg.vquery;
 LV_sqlCode      VARCHAR2(50);
 LV_SQLERRM      VARCHAR2(50);
 LV_error        VARCHAR2(50);
 
        
 BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;
                
                
                LV_sql:='INSERT INTO GA_COBROS_ADELANTADOS_TH( '
                       || ' ,NUM_COBRO,COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,COD_CONCEPTO,NUM_VENTA'
                       || ' ,FEC_COBRO,TIPO_SERVICIO,NUM_PROCESO)' 
                       || ' VALUES (' || EN_numCobro || ', ' || EV_codCliente || ', ' 
                       ||   EN_NumAbonado || ',' || EN_CodCiclfact || ',' || EN_codConcepto || ',' ||  EN_numVenta
                       ||   ', ' || EN_fec_alta || ', ' || EN_TipoConcepto || ', ' ||  EN_numProceso || ')';   
                                  
                INSERT INTO GA_COBROS_ADELANTADOS_TH
                (NUM_COBRO,COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,COD_CONCEPTO,NUM_VENTA,FEC_COBRO,TIPO_SERVICIO,NUM_PROCESO)
                VALUES (EN_numCobro,EV_codCliente,EN_NumAbonado,EN_CodCiclfact
                       ,EN_codConcepto,EN_numVenta,EN_fec_alta,EN_TipoConcepto,EN_numProceso);                
        
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getProrrateo_PR', LV_Sql, SQLCODE, LV_desError );
                 
                 WHEN OTHERS THEN
                            SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR', LV_Sql, SQLCODE, LV_desError );
                                
 END FA_InsertaCobroAdelantadoH_PR;
   PROCEDURE FA_ObtieneCicloFact_PR     (EV_codCiclo      IN  FA_CICLOS.COD_CICLO%TYPE,
                                         SN_codCiclfact   OUT NOCOPY  FA_CICLFACT.COD_CICLFACT%TYPE,
                                         SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                         SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS

 LV_desError  ge_errores_pg.desevent;
 LV_sql           ge_errores_pg.vquery;
 LV_sqlCode      VARCHAR2(50);
 LV_SQLERRM      VARCHAR2(50);
 LV_error        VARCHAR2(50);
 
        
 BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;
                
                SELECT /*+ INDEX_DESC (FA_CICLFACT PK_FA_CICLFACT) */ 
                COD_CICLFACT 
                INTO SN_codCiclfact
                FROM FA_CICLFACT 
                WHERE COD_CICLO = EV_codCiclo
                AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM 
                AND ROWNUM = 1 
                ORDER BY  FEC_EMISION; 
                            
        
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                SV_menRetorno:='NO EXISTE CICLO DE FACTURACION PARA EL CLIENTE SELECCIONADO';
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_getProrrateo_PR', LV_Sql, SQLCODE, LV_desError );
                 
                 WHEN OTHERS THEN
                            SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_ConsultaCobroAdelantado_PR', LV_Sql, SQLCODE, LV_desError );
                                
 END FA_ObtieneCicloFact_PR;
 
 
    PROCEDURE FA_ActualizaInfaccel_PR     (EN_NumAbonado  IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                           EN_codCliente  IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                           EN_codCiclfact IN  FA_CICLFACT.COD_CICLFACT%TYPE, 
                                           SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS

 LV_desError  ge_errores_pg.desevent;
 LV_sql           ge_errores_pg.vquery;
 LV_sqlCode      VARCHAR2(50);
 LV_SQLERRM      VARCHAR2(50);
 LV_error        VARCHAR2(50);
 
        
 BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;
                
                 UPDATE GA_INFACCEL SET IND_CARGOS=1 
                 WHERE COD_CLIENTE =EN_codCliente
                 AND NUM_ABONADO=EN_NumAbonado
                 AND COD_CICLFACT=EN_codCiclfact;
        
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                SV_menRetorno:='NO EXISTE CICLO DE FACTURACION PARA EL CLIENTE SELECCIONADO';
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_ActualizaInfaccel_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_ActualizaInfaccel_PR', LV_Sql, SQLCODE, LV_desError );
                 
                 WHEN OTHERS THEN
                            SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_ActualizaInfaccel_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_ActualizaInfaccel_PR', LV_Sql, SQLCODE, LV_desError );
                                
END FA_ActualizaInfaccel_PR;
PROCEDURE FA_ActualizaIndFact_PR           (EN_NumVenta      IN  GA_ABOCEL.NUM_VENTA%TYPE,
                                           SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS

 LV_desError  ge_errores_pg.desevent;
 LV_sql           ge_errores_pg.vquery;
 LV_sqlCode      VARCHAR2(50);
 LV_SQLERRM      VARCHAR2(50);
 LV_error        VARCHAR2(50);
 
        
 BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;
                
                 Lv_sql:='UPDATE GE_CARGOS'
                 || ' SET IND_FACTUR=1'
                 || ' WHERE NUM_VENTA= ' || EN_NumVenta;                  
                 
                 UPDATE GE_CARGOS 
                 SET IND_FACTUR=1
                 WHERE NUM_VENTA=EN_NumVenta;
        
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                SV_menRetorno:='NO EXISTE CICLO DE FACTURACION PARA EL CLIENTE SELECCIONADO';
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_ActualizaInfaccel_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_ActualizaInfaccel_PR', LV_Sql, SQLCODE, LV_desError );
                 
                 WHEN OTHERS THEN
                            SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_ActualizaInfaccel_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_ActualizaInfaccel_PR', LV_Sql, SQLCODE, LV_desError );
                                
END FA_ActualizaIndFact_PR;
PROCEDURE FA_obtieneConcepto_PR           (EN_codConcepto   IN  FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                                           SV_DES_CONCEPTO  OUT NOCOPY  FA_CONCEPTOS.DES_CONCEPTO%TYPE,
                                           SN_COD_TIPCONCE  OUT NOCOPY FA_CONCEPTOS.COD_TIPCONCE%TYPE,
                                           SV_COD_MONEDA    OUT NOCOPY FA_CONCEPTOS.COD_MONEDA%TYPE, 
                                           SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS

 LV_desError  ge_errores_pg.desevent;
 LV_sql           ge_errores_pg.vquery;
 LV_sqlCode      VARCHAR2(50);
 LV_SQLERRM      VARCHAR2(50);
 LV_error        VARCHAR2(50);
 
        
 BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;
                
                SELECT DES_CONCEPTO,COD_TIPCONCE,COD_MONEDA
                INTO SV_DES_CONCEPTO,SN_COD_TIPCONCE,SV_COD_MONEDA
                FROM FA_CONCEPTOS 
                WHERE COD_CONCEPTO=EN_codConcepto;
                 
        
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                SV_menRetorno:='NO EXISTE CONCEPTO';
                                LV_desError  := 'NO_DATA_FOUND:FA_Servicios_Facturacion_PG.FA_obtieneConcepto_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_obtieneConcepto_PR', LV_Sql, SQLCODE, LV_desError );
                 
                 WHEN OTHERS THEN
                            SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:FA_Servicios_Facturacion_PG.FA_obtieneConcepto_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'FA_Servicios_Facturacion_PG.FA_obtieneConcepto_PR', LV_Sql, SQLCODE, LV_desError );
                                
END FA_obtieneConcepto_PR;


END FA_Servicios_Facturacion_PG;
/
SHOW ERRORS