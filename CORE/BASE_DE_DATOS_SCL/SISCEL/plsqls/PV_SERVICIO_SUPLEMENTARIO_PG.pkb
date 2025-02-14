CREATE OR REPLACE PACKAGE BODY SISCEL.Pv_Servicio_Suplementario_Pg IS

-- PV_SERVICIO_SUPLEMENTARIO_PG v2.3 -- COL-71848|10-11-2008|GEZ
-- PV_SERVICIO_SUPLEMENTARIO_PG v2.4 -- COL 71848|04-12-2008|SAQL
-- PV_SERVICIO_SUPLEMENTARIO_PG v2.5 -- COL 75438|12-01-2009|EFR
-- PV_SERVICIO_SUPLEMENTARIO_PG v2.6 -- COL 78338|11-02-2009|JJR

FUNCTION retorna_version
RETURN VARCHAR2
IS
   v_salida_version VARCHAR2(200);
BEGIN

   v_salida_version:='VERSION = '||SUBSTR(CV_version,1,INSTR(CV_version,'.')-1)||'; '||' SUBVERSION = '||SUBSTR(CV_version,INSTR(CV_version,'.')+1,LENGTH(CV_version));

RETURN v_salida_version;

EXCEPTION

WHEN OTHERS THEN
RAISE_APPLICATION_ERROR (-20120,' Error en la version');

END;

PROCEDURE PV_REC_SS_DISPONIBLES_PR(EN_num_celular   IN NUMBER,
                                                                   EV_usuario           IN VARCHAR2,
                                                                   tss_diponibles   OUT refCursor,
                                                                   SV_mensaje           OUT VARCHAR2,
                                                                   SV_error             OUT VARCHAR2
)
/*
<DOC>
<NOMBRE>      PV_REC_SS_DISPONIBLES_PR                            </NOMBRE>
<FECHACREA>   12/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Recupera Servicios Suplementarios Disponibles para </DESCRIPCION>
<DESCRIPCION> el celular.                                                                                </DESCRIPCION>
<FECHAMOD>                                                               </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>   EN_num_celular: Numero de Celular                                  </ParamEntr>
<ParamEntr>   EV_usuario : Usuario                                                               </ParamEntr>
<ParamSal>    tss_diponibles: Cursos de Servicios Suplem. Disponibles </ParamSal>
<ParamSal>    SV_mensaje: Mensaje de Respuesta                   </ParamSal>
<ParamSal>    SV_error: Codigo Error Controlado                  </ParamSal>


</DOC>
*/
IS

        EN_num_abonado          GA_ABOCEL.NUM_ABONADO%TYPE;
--      EV_cod_plantarif        GA_ABOCEL.COD_PLANTARIF%TYPE;
        EV_cod_planserv         GA_ABOCEL.COD_PLANSERV%TYPE;

        EN_cod_cliente          GA_ABOCEL.COD_CLIENTE%TYPE;
        EN_cod_cuenta           GA_ABOCEL.COD_CUENTA%TYPE;
        EV_num_serie            GA_ABOCEL.NUM_SERIE%TYPE;
        EV_num_seriehex         GA_ABOCEL.NUM_SERIEHEX%TYPE;
        EN_cod_central          GA_ABOCEL.COD_CENTRAL%TYPE;
        EV_tip_terminal         GA_ABOCEL.TIP_TERMINAL%TYPE;
        EN_cod_uso                      GA_ABOCEL.COD_USO%TYPE;
        SN_cod_sistema          ICG_CENTRAL.COD_SISTEMA%TYPE;

        GV_implimcons           NUMBER(14,4);
        B_Ret                           BOOLEAN;
        ERROR_PROCESO           EXCEPTION;

        SV_proc                     VARCHAR2(50);
        SV_tabla                    VARCHAR2(50);
        SV_act                          VARCHAR2(2);
        SV_sqlcode                      VARCHAR2(50);
        SV_sqlerrm                      VARCHAR2(250);

        BEGIN

                SV_error:='0';
                SV_proc := 'PV_REC_SS_DISPONIBLES_PR';

            IF NOT Pv_General_Ooss_Pg.PV_VALIDA_USUARIO_FN(EV_usuario,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm) THEN
                    -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    --  SV_mensaje := 'Usuario no válido ';
                        SV_mensaje := 'Usuario No Válido ';
                    -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    RAISE ERROR_PROCESO;
            END IF;

                IF NOT Pv_General_Ooss_Pg.PV_VAL_LARGO_CELULAR_FN(EN_num_celular, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
                    -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    --  SV_mensaje :=  'Celular No Cumple Con Largo Definido Por Operadora';
                        SV_mensaje :=  'Número Tel. No Válido';
                    -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    RAISE ERROR_PROCESO;
                END IF;

                Pv_General_Ooss_Pg.PV_DATOS_ABONADO_PR (EN_num_celular, GV_implimcons, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error);
                IF SV_error = 4 THEN
                        -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        --      SV_mensaje :=  'Celular no existe o Situación no es Válida';
                                SV_mensaje :=  'Número Tel. Invalido/No Registrado';
                        -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        RAISE ERROR_PROCESO;
                ELSE
                        EN_num_abonado    := Pv_General_Ooss_Pg.VP_NUM_ABONADO;
                        EV_cod_planserv   := Pv_General_Ooss_Pg.VP_COD_PLANSERV;
                        EN_cod_cliente    := Pv_General_Ooss_Pg.VP_COD_CLIENTE;
                        EN_cod_cuenta     := Pv_General_Ooss_Pg.VP_COD_CUENTA;
                        EV_num_serie      := Pv_General_Ooss_Pg.VP_NUM_SERIE;
                        EV_num_seriehex   := Pv_General_Ooss_Pg.VP_NUM_SERIEHEX;
                        EN_cod_central    := Pv_General_Ooss_Pg.VP_COD_CENTRAL;
                        EV_tip_terminal   := Pv_General_Ooss_Pg.VP_TIP_TERMINAL;
                        EN_cod_uso                := Pv_General_Ooss_Pg.VP_COD_USO;
                END IF;

                ----RECUPERAR PARAMETROS NECESARIOS
                PV_REC_PARAM_SS_DIS_PR(EN_cod_central, SN_cod_sistema, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm);
                IF SV_error = 4 THEN
                    -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    -- SV_mensaje := 'Error Recuperando Parametros';
                       SV_mensaje := 'Transacción No Exitosa - Datos';
                    -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        RAISE ERROR_PROCESO;
                END IF;

                --- RECUPERAR SERVICIOS DISPONIBLES
                PV_RECUPERA_SS_DIS_PR(EN_num_celular, SN_cod_sistema, tss_diponibles, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm);
                IF SV_error = 4 THEN
                    -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    -- SV_mensaje := 'Error Recuperando Servicios Suplementarios Disponibles';
                       SV_mensaje := 'Transacción No Exitosa - Servicios';
                    -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        RAISE ERROR_PROCESO;
                END IF;
                IF      SV_error = 3 THEN
                    -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    -- SV_mensaje := 'Celular Sin Servicios Suplementarios Disponibles';
                       SV_mensaje := 'Número Tel. Sin Servicios Disponibles';
                    -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        RAISE ERROR_PROCESO;
                END IF;

        EXCEPTION
                WHEN ERROR_PROCESO THEN
                        SV_sqlcode := SUBSTR(SQLCODE,1,15);
                        SV_sqlerrm := SUBSTR(SQLERRM,1,60);
                        IF EN_num_abonado = '' OR LTRIM(RTRIM(EN_num_abonado)) IS NULL THEN
                            EN_num_abonado := -1;
                        END IF;
                        B_Ret:= Pv_General_Ooss_Pg.PV_GA_ERRORES_FN(EN_num_abonado,Pv_General_Ooss_Pg.CV_cod_actabo,Pv_General_Ooss_Pg.CN_cod_producto,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm, SV_sqlcode,SV_sqlerrm);
                        SV_error := 4;

                WHEN OTHERS THEN
                        SV_sqlcode := SUBSTR(SQLCODE,1,15);
                        SV_sqlerrm := SUBSTR(SQLERRM,1,60);
                        SV_mensaje := 'Error en Ejecucion ';
                        IF EN_num_abonado = '' OR LTRIM(RTRIM(EN_num_abonado)) IS NULL THEN
                            EN_num_abonado := -1;
                        END IF;
                        B_Ret:= Pv_General_Ooss_Pg.PV_GA_ERRORES_FN(EN_num_abonado,Pv_General_Ooss_Pg.CV_cod_actabo,Pv_General_Ooss_Pg.CN_cod_producto,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm, SV_sqlcode,SV_sqlerrm);
                        SV_error := 4;

END PV_REC_SS_DISPONIBLES_PR;

----------------------------------------------------------------------

PROCEDURE PV_RECUPERA_SS_DIS_PR(EN_num_celular    IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                 EN_cod_sistema   IN ICG_CENTRAL.COD_SISTEMA%TYPE,
                                                                 tSS_disponibles  OUT refCursor,
                                                                 SV_error                 OUT VARCHAR2,
                                                                 SV_proc                  OUT VARCHAR2,
                                                                 SV_tabla                 OUT VARCHAR2,
                                                                 SV_act                   OUT VARCHAR2,
                                                                 SV_sqlcode               OUT VARCHAR2,
                                                                 SV_sqlerrm               OUT VARCHAR2
)
/*
<DOC>
<NOMBRE>      PV_RECUPERA_SS_DIS_PR                             </NOMBRE>
<FECHACREA>   12/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Carga Cursor con Servicios Suplem. Disponibles     </DESCRIPCION>
<FECHAMOD>                                                               </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>   EN_num_celular: Numero de Celular                                  </ParamEntr>
<ParamEntr>   EN_cod_sistema: Codigo de Sistema                                  </ParamEntr>
<ParamSal>    tSS_disponibles: Cursor de Tipos de Siniestros     </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                           </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                           </ParamSal>
</DOC>
*/
IS

        LV_cod_servicio         GA_SERVSUPLABO.COD_SERVICIO%TYPE;
        LN_cod_nivel            GA_SERVSUPLABO.COD_NIVEL%TYPE;
        LN_cod_servsupl         GA_SERVSUPLABO.COD_SERVSUPL%TYPE;

        EN_num_abonado          GA_ABOCEL.NUM_ABONADO%TYPE;
        EV_num_serie            GA_ABOCEL.NUM_SERIE%TYPE;
        EV_cod_tecnologia   GA_ABOCEL.COD_TECNOLOGIA%TYPE;
        EV_tip_terminal         GA_ABOCEL.TIP_TERMINAL%TYPE;
        EN_cod_uso                      GA_ABOCEL.COD_USO%TYPE;
        EV_cod_plantarif        GA_ABOCEL.COD_PLANTARIF%TYPE;
        EV_cod_planserv         GA_ABOCEL.COD_PLANSERV%TYPE;

        GV_implimcons           NUMBER(14,4);
        LN_cod_articulo         GA_EQUIPABOSER.COD_ARTICULO%TYPE;

        LV_tip_servicio         GED_CODIGOS.COD_VALOR%TYPE;

        LV_ss_metromovil        VARCHAR2(20);
        LV_tip_relacion2        VARCHAR2(20);

        LV_cod_proceso          GAD_PROCESOS_PERFILES.COD_PROCESO%TYPE;

        LN_count                        NUMBER(2);
        v_sentencia                     VARCHAR2(10000);
        LB_metromovil           BOOLEAN;

        ERROR_PROCESO           EXCEPTION;

        BEGIN

                SV_error   := '0';
                SV_proc    := 'PV_RECUPERA_SS_ACT_PR';


                -- No se valida existencia de celular, fue validado en procedimiento que llama a este.--
                Pv_General_Ooss_Pg.PV_DATOS_ABONADO_PR (EN_num_celular,GV_implimcons,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
            EN_num_abonado        := Pv_General_Ooss_Pg.VP_NUM_ABONADO;
            EV_num_serie          := Pv_General_Ooss_Pg.VP_NUM_SERIE;
            EV_tip_terminal       := Pv_General_Ooss_Pg.VP_TIP_TERMINAL;
            EV_cod_plantarif  := Pv_General_Ooss_Pg.VP_COD_PLANTARIF;
            EV_cod_planserv       := Pv_General_Ooss_Pg.VP_COD_PLANSERV;
            EN_cod_uso            := Pv_General_Ooss_Pg.VP_COD_USO;
            EV_cod_tecnologia := Pv_General_Ooss_Pg.VP_COD_TECNOLOGIA;

                SV_tabla := 'GA_EQUIPABOSER';
                SV_act   := 'S';
                BEGIN
                        SELECT cod_articulo
                        INTO   LN_cod_articulo
                        FROM   GA_EQUIPABOSER
                        WHERE  num_abonado = EN_num_abonado
                        AND    num_serie   = EV_num_serie
                        AND    fec_alta    = (SELECT MAX(fec_alta)
                                                                  FROM   GA_EQUIPABOSER
                                                                 WHERE   num_abonado = EN_num_abonado
                                                                   AND   num_serie   = EV_num_serie);
                EXCEPTION
                    /*WHEN NO_DATA_FOUND THEN
                                 LN_cod_articulo := '';*/
                    WHEN OTHERS THEN
                                 LN_cod_articulo := '';
                END;

                SV_tabla := 'GED_CODIGOS';
                SV_act   := 'S';
                SELECT COD_VALOR
                INTO   LV_tip_servicio
                FROM   GED_CODIGOS
                WHERE  COD_MODULO = 'GA'
                AND    NOM_TABLA = 'GA_SERVSUPL'
                AND    NOM_COLUMNA = 'TIP_SERVICIO'
                AND    DES_VALOR  = 'NORMAL';

                LV_ss_metromovil := Ge_Fn_Devvalparam('GA',1,'SERV_SUP_METROMOVIL');

                LV_tip_relacion2 := Ge_Fn_Devvalparam('GA',1,'TIP_RELACION2');

                LB_metromovil := PV_CHEQUEA_ANT_EQUIPO_FN(EN_num_abonado, EV_tip_terminal, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm);
                IF SV_error = 4 THEN
                   RAISE ERROR_PROCESO;
                END IF;

                SV_tabla := 'ANTES DE RESCATAR SERVICIOS DISPONIBLES'; --string largo max. de 50 char.
                SV_act   := 'S';
                v_sentencia := 'SELECT COUNT(1) ';
                v_sentencia := v_sentencia ||' FROM GA_SERVSUPL A, GA_ACTUASERV B, GA_TARIFAS C, ';
                v_sentencia := v_sentencia ||' GE_MONEDAS D, GA_ACTUASERV E, GA_TARIFAS F,';
                v_sentencia := v_sentencia ||'     GE_MONEDAS G, ICG_SERVICIOTERCEN H, GA_SERVUSO I, GAD_SERVSUP_PLAN J ';
                v_sentencia := v_sentencia ||' WHERE A.COD_PRODUCTO = 1';
                v_sentencia := v_sentencia ||' AND A.COD_PRODUCTO = B.COD_PRODUCTO(+) ';
                v_sentencia := v_sentencia ||' AND A.COD_SERVICIO = B.COD_SERVICIO(+) ';
                v_sentencia := v_sentencia ||' AND A.IND_COMERC   = 1 ';
                IF EN_cod_uso = Ge_Fn_Devvalparam('GA',1,'USO_PREPAGO') THEN

                        --XO-200510110847: German Espinoza Z; 02/11/2005
                    --v_sentencia := v_sentencia ||' AND A.COD_APLIC LIKE ''%P%''';
                        v_sentencia := v_sentencia ||' AND (A.COD_APLIC LIKE ''%P%'' OR A.COD_APLIC LIKE ''%I%'')';
                        --FIN/XO-200510110847: German Espinoza Z; 02/11/2005

                    IF NOT LB_metromovil THEN
                           v_sentencia := v_sentencia ||' AND A.COD_SERVSUPL <> ''' || LV_ss_metromovil ||'''';
                    END IF;
                ELSE
                        v_sentencia := v_sentencia ||' AND (( A.COD_APLIC IS NULL) OR (COD_APLIC LIKE ''%C%'')) ';
                END IF;
                v_sentencia := v_sentencia ||' AND A.COD_NIVEL > 0 ';
                v_sentencia := v_sentencia ||' AND A.TIP_SERVICIO = ''' || LV_tip_servicio || '''';
                v_sentencia := v_sentencia ||' AND B.COD_ACTABO(+) = ''SS''';
                v_sentencia := v_sentencia ||' AND B.COD_TIPSERV(+) = ''2''';
                v_sentencia := v_sentencia ||' AND B.COD_PRODUCTO = C.COD_PRODUCTO(+) ';
                v_sentencia := v_sentencia ||' AND B.COD_ACTABO = C.COD_ACTABO(+) ';
                v_sentencia := v_sentencia ||' AND B.COD_TIPSERV = C.COD_TIPSERV(+) ';
                v_sentencia := v_sentencia ||' AND B.COD_SERVICIO = C.COD_SERVICIO(+) ';
                v_sentencia := v_sentencia ||' AND C.COD_PLANSERV(+) = ''' || EV_cod_planserv || '''';
                v_sentencia := v_sentencia ||' AND SYSDATE BETWEEN C.FEC_DESDE(+) AND NVL(C.FEC_HASTA(+), SYSDATE) ';
                v_sentencia := v_sentencia ||' AND C.COD_MONEDA = D.COD_MONEDA(+) ';
                v_sentencia := v_sentencia ||' AND A.COD_PRODUCTO = E.COD_PRODUCTO(+) ';
                v_sentencia := v_sentencia ||' AND A.COD_SERVICIO = E.COD_SERVICIO(+) ';
                v_sentencia := v_sentencia ||' AND E.COD_ACTABO(+) = ''FA''';
                v_sentencia := v_sentencia ||' AND E.COD_TIPSERV(+) = ''2''';
                v_sentencia := v_sentencia ||' AND E.COD_PRODUCTO = F.COD_PRODUCTO(+) ';
                v_sentencia := v_sentencia ||' AND E.COD_ACTABO = F.COD_ACTABO(+) ';
                v_sentencia := v_sentencia ||' AND E.COD_TIPSERV = F.COD_TIPSERV(+) ';
                v_sentencia := v_sentencia ||' AND E.COD_SERVICIO = F.COD_SERVICIO(+) ';
                v_sentencia := v_sentencia ||' AND F.COD_PLANSERV(+) = ''' || EV_cod_planserv || '''';
                v_sentencia := v_sentencia ||' AND SYSDATE BETWEEN F.FEC_DESDE(+) AND NVL(F.FEC_HASTA(+), SYSDATE) ';
                v_sentencia := v_sentencia ||' AND F.COD_MONEDA = G.COD_MONEDA(+) ';
                v_sentencia := v_sentencia ||' AND H.COD_PRODUCTO = A.COD_PRODUCTO ';
                v_sentencia := v_sentencia ||' AND H.TIP_TERMINAL = ''' || EV_tip_terminal || '''';
                v_sentencia := v_sentencia ||' AND H.COD_SISTEMA =  ' || EN_cod_sistema ;
                v_sentencia := v_sentencia ||' AND H.COD_SERVICIO = A.COD_SERVSUPL ';
                v_sentencia := v_sentencia ||' AND H.TIP_TECNOLOGIA= ''' || EV_cod_tecnologia || '''';
                v_sentencia := v_sentencia ||' AND I.COD_PRODUCTO = A.COD_PRODUCTO ';
                v_sentencia := v_sentencia ||' AND I.COD_SERVICIO = A.COD_SERVICIO  ';
                v_sentencia := v_sentencia ||' AND I.COD_USO = ' || EN_cod_uso ;
                v_sentencia := v_sentencia ||' AND J.COD_PRODUCTO = A.COD_PRODUCTO ';
                v_sentencia := v_sentencia ||' AND J.COD_SERVICIO = A.COD_SERVICIO ';
                v_sentencia := v_sentencia ||' AND J.COD_PLANTARIF = ''' || EV_cod_plantarif || '''';
                v_sentencia := v_sentencia ||' AND SYSDATE BETWEEN J.FEC_DESDE AND NVL(J.FEC_HASTA, SYSDATE) ';
                v_sentencia := v_sentencia ||' AND J.TIP_RELACION = ''' || LV_tip_relacion2 || '''';
                IF LN_cod_articulo <> '' THEN
                   v_sentencia := v_sentencia ||' AND A.COD_SERVICIO NOT IN (SELECT DISTINCT(COD_SERVICIO) ';
                   v_sentencia := v_sentencia ||' FROM GA_SERV_ATRIBUTOS A, AL_ATRIBUTOS_ARTICULOS B ';
                   v_sentencia := v_sentencia ||' WHERE a.COD_ATRIBUTO = B.COD_ATRIBUTO AND B.Cod_Articulo <> ' || LN_cod_articulo || ' AND B.TIP_ARTICULO = 1 ';
                   v_sentencia := v_sentencia ||' AND COD_SERVICIO NOT IN (SELECT DISTINCT(COD_SERVICIO) ';
                   v_sentencia := v_sentencia ||' FROM GA_SERV_ATRIBUTOS A, AL_ATRIBUTOS_ARTICULOS B ';
                   v_sentencia := v_sentencia ||' WHERE A.COD_ATRIBUTO = B.COD_ATRIBUTO  AND B.COD_ARTICULO = ' || LN_cod_articulo || ' AND B.TIP_ARTICULO = 1 ';
                END IF;
                v_sentencia := v_sentencia ||' AND NVL(A.COD_SERVICIO, '' '') NOT IN (SELECT NVL(COD_SERVICIO, '' '') ';
                v_sentencia := v_sentencia ||' FROM GA_TIPOSEGURO ';
                v_sentencia := v_sentencia ||' WHERE COD_PRODUCTO = A.COD_PRODUCTO) ';
                v_sentencia := v_sentencia ||' AND NVL(A.COD_SERVICIO, '' '') NOT IN (SELECT NVL(COD_SERVICIODES,'' '') ';
                v_sentencia := v_sentencia ||' FROM GA_TIPOSEGURO WHERE COD_PRODUCTO = A.COD_PRODUCTO) ';
                v_sentencia := v_sentencia ||' ORDER BY A.IND_PRIORIDAD,A.DES_SERVICIO  ';
                EXECUTE IMMEDIATE v_sentencia
                INTO LN_count;

                SV_tabla := 'RESCATA SERVICIOS DISPONIBLES';
                SV_act   := 'S';
                v_sentencia := '';
                v_sentencia := 'SELECT A.COD_SERVICIO ';
                v_sentencia := v_sentencia || ', A.DES_SERVICIO';
                v_sentencia := v_sentencia || ', A.COD_SERVSUPL';
                v_sentencia := v_sentencia || ', A.COD_NIVEL';
                --Inicio Alejandro Hott - 29-11-2004 - Soporte - TM-200411151097
                /* v_sentencia := v_sentencia || ', C.IMP_TARIFA';
                v_sentencia := v_sentencia || ', D.DES_MONEDA';
                v_sentencia := v_sentencia || ', B.COD_CONCEPTO'; */
                --Fin Alejandro Hott - 29-11-2004 - Soporte - TM-200411151097
/* Inicio Inc. 78338|COL|11/02/2009|JJR.- */
--                v_sentencia := v_sentencia || ', F.IMP_TARIFA';
--                v_sentencia := v_sentencia || ', G.DES_MONEDA';
--                v_sentencia := v_sentencia || ', E.COD_CONCEPTO';
                  v_sentencia := v_sentencia || ', C.IMP_TARIFA';
                  v_sentencia := v_sentencia || ', D.DES_MONEDA';
                  v_sentencia := v_sentencia || ', B.COD_CONCEPTO';
/* Fin Inc. 78338|COL|11/02/2009|JJR.- */
                v_sentencia := v_sentencia || ' FROM GA_SERVSUPL A, GA_ACTUASERV B, GA_TARIFAS C,';
                v_sentencia := v_sentencia || ' GE_MONEDAS D, GA_ACTUASERV E, GA_TARIFAS F,';
                v_sentencia := v_sentencia || ' GE_MONEDAS G, ICG_SERVICIOTERCEN H, GA_SERVUSO I';
                IF LN_count > 0 THEN
                   v_sentencia := v_sentencia || ', GAD_SERVSUP_PLAN J';
                END IF;
        v_sentencia := v_sentencia || ' WHERE A.COD_PRODUCTO = 1 ';
        v_sentencia := v_sentencia || ' AND A.COD_PRODUCTO = B.COD_PRODUCTO(+)';
        v_sentencia := v_sentencia || ' AND A.COD_SERVICIO = B.COD_SERVICIO(+)';
                v_sentencia := v_sentencia || ' AND A.IND_COMERC   = 1 ';
                IF EN_cod_uso = Ge_Fn_Devvalparam('GA',1,'USO_PREPAGO') THEN

                   --XO-200510110847: German Espinoza Z; 02/11/2005
                    --v_sentencia := v_sentencia ||' AND A.COD_APLIC LIKE ''%P%''';
                        v_sentencia := v_sentencia ||' AND (A.COD_APLIC LIKE ''%P%'' OR A.COD_APLIC LIKE ''%I%'')';
                        --FIN/XO-200510110847: German Espinoza Z; 02/11/2005

                   IF NOT LB_metromovil THEN
                           v_sentencia := v_sentencia ||' AND A.COD_SERVSUPL <> '''|| LV_ss_metromovil || '''';
                   END IF;
                ELSE
                   v_sentencia := v_sentencia ||' AND (( A.COD_APLIC IS NULL) OR (COD_APLIC LIKE ''%C%'')) ';
                END IF;
                v_sentencia := v_sentencia ||' AND A.COD_NIVEL > 0 ';
                v_sentencia := v_sentencia ||' AND A.TIP_SERVICIO = ''' || LV_tip_servicio || '''';
                v_sentencia := v_sentencia ||' AND B.COD_ACTABO(+) = ''SS''';
                v_sentencia := v_sentencia ||' AND B.COD_TIPSERV(+) = ''2''';
                v_sentencia := v_sentencia ||' AND B.COD_PRODUCTO = C.COD_PRODUCTO(+) ';
                v_sentencia := v_sentencia ||' AND B.COD_ACTABO = C.COD_ACTABO(+) ';
                v_sentencia := v_sentencia ||' AND B.COD_TIPSERV = C.COD_TIPSERV(+) ';
                v_sentencia := v_sentencia ||' AND B.COD_SERVICIO = C.COD_SERVICIO(+) ';
                v_sentencia := v_sentencia ||' AND C.COD_PLANSERV(+) = ''' || EV_cod_planserv || '''';
                v_sentencia := v_sentencia ||' AND SYSDATE BETWEEN C.FEC_DESDE(+) AND NVL(C.FEC_HASTA(+), SYSDATE) ';
                v_sentencia := v_sentencia ||' AND C.COD_MONEDA = D.COD_MONEDA(+) ';
                v_sentencia := v_sentencia ||' AND A.COD_PRODUCTO = E.COD_PRODUCTO(+) ';
                v_sentencia := v_sentencia ||' AND A.COD_SERVICIO = E.COD_SERVICIO(+) ';
                v_sentencia := v_sentencia ||' AND E.COD_ACTABO(+) = ''FA''';
                v_sentencia := v_sentencia ||' AND E.COD_TIPSERV(+) = ''2''';
                v_sentencia := v_sentencia ||' AND E.COD_PRODUCTO = F.COD_PRODUCTO(+) ';
                v_sentencia := v_sentencia ||' AND E.COD_ACTABO = F.COD_ACTABO(+) ';
                v_sentencia := v_sentencia ||' AND E.COD_TIPSERV = F.COD_TIPSERV(+) ';
                v_sentencia := v_sentencia ||' AND E.COD_SERVICIO = F.COD_SERVICIO(+) ';
                v_sentencia := v_sentencia ||' AND F.COD_PLANSERV(+) = ''' || EV_cod_planserv || '''';
                v_sentencia := v_sentencia ||' AND SYSDATE BETWEEN F.FEC_DESDE(+) AND NVL(F.FEC_HASTA(+), SYSDATE) ';
                v_sentencia := v_sentencia ||' AND F.COD_MONEDA = G.COD_MONEDA(+) ';
                v_sentencia := v_sentencia ||' AND H.COD_PRODUCTO = A.COD_PRODUCTO ';
                v_sentencia := v_sentencia ||' AND H.TIP_TERMINAL = ''' || EV_tip_terminal || '''';
                v_sentencia := v_sentencia ||' AND H.COD_SISTEMA = ' || EN_cod_sistema ;
                v_sentencia := v_sentencia ||' AND H.COD_SERVICIO = A.COD_SERVSUPL ';
                v_sentencia := v_sentencia ||' AND H.TIP_TECNOLOGIA= ''' || EV_cod_tecnologia || '''';
                v_sentencia := v_sentencia ||' AND I.COD_PRODUCTO = A.COD_PRODUCTO ';
                v_sentencia := v_sentencia ||' AND I.COD_SERVICIO = A.COD_SERVICIO  ';
                v_sentencia := v_sentencia ||' AND I.COD_USO = ' || EN_cod_uso ;
                IF LN_count > 0 THEN
                        v_sentencia := v_sentencia ||' AND J.COD_PRODUCTO = A.COD_PRODUCTO ';
                        v_sentencia := v_sentencia ||' AND J.COD_SERVICIO = A.COD_SERVICIO ';
                        v_sentencia := v_sentencia ||' AND J.COD_PLANTARIF = ''' || EV_cod_plantarif || '''';
                        v_sentencia := v_sentencia ||' AND SYSDATE BETWEEN J.FEC_DESDE AND NVL(J.FEC_HASTA, SYSDATE) ';
                        v_sentencia := v_sentencia ||' AND J.TIP_RELACION = '''|| LV_tip_relacion2 || '''';
                END IF;
                IF LN_cod_articulo <> '' THEN
                   v_sentencia := v_sentencia ||' AND A.COD_SERVICIO NOT IN (SELECT DISTINCT(COD_SERVICIO) ';
                   v_sentencia := v_sentencia ||' FROM GA_SERV_ATRIBUTOS A, AL_ATRIBUTOS_ARTICULOS B ';
                   v_sentencia := v_sentencia ||' WHERE a.COD_ATRIBUTO = B.COD_ATRIBUTO AND B.Cod_Articulo <> ' || LN_cod_articulo || ' AND B.TIP_ARTICULO = 1 ';
                   v_sentencia := v_sentencia ||' AND COD_SERVICIO NOT IN (SELECT DISTINCT(COD_SERVICIO) ';
                   v_sentencia := v_sentencia ||' FROM GA_SERV_ATRIBUTOS A, AL_ATRIBUTOS_ARTICULOS B ';
                   v_sentencia := v_sentencia ||' WHERE A.COD_ATRIBUTO = B.COD_ATRIBUTO  AND B.COD_ARTICULO = ' || LN_cod_articulo || ' AND B.TIP_ARTICULO = 1 ';
                END IF;
                v_sentencia := v_sentencia ||' AND NVL(A.COD_SERVICIO, '' '') NOT IN (SELECT NVL(COD_SERVICIO, '' '') ';
                v_sentencia := v_sentencia ||' FROM GA_TIPOSEGURO ';
                v_sentencia := v_sentencia ||' WHERE COD_PRODUCTO = A.COD_PRODUCTO) ';
                v_sentencia := v_sentencia ||' AND NVL(A.COD_SERVICIO, '' '') NOT IN (SELECT NVL(COD_SERVICIODES,'' '') ';
                v_sentencia := v_sentencia ||' FROM GA_TIPOSEGURO WHERE COD_PRODUCTO = A.COD_PRODUCTO) ';

                v_sentencia := v_sentencia ||' AND  A.COD_SERVICIO NOT IN   ';
                v_sentencia := v_sentencia ||' (SELECT a.cod_servicio ';
                v_sentencia := v_sentencia ||' FROM GA_SERVSUPL a, GA_ACTUASERV b, GA_TARIFAS c ';
                v_sentencia := v_sentencia ||'      , GE_MONEDAS d, GA_ACTUASERV e, GA_TARIFAS f, GE_MONEDAS g, GA_SERVSUPLABO h ';
                v_sentencia := v_sentencia ||' WHERE a.cod_producto = 1 ';
                v_sentencia := v_sentencia ||' AND a.cod_nivel =  h.cod_nivel ';
                v_sentencia := v_sentencia ||' AND a.cod_servicio = h.cod_servicio ';
                v_sentencia := v_sentencia ||' AND h.num_abonado  = ' || EN_num_abonado ;
                v_sentencia := v_sentencia ||' AND h.ind_estado < 3 ' ;
                v_sentencia := v_sentencia ||' AND a.ind_comerc = 1 ';
                v_sentencia := v_sentencia ||' AND a.tip_servicio = ''' || LV_tip_servicio || '''';
                v_sentencia := v_sentencia ||' AND a.cod_producto = b.cod_producto(+) ';
                v_sentencia := v_sentencia ||' AND a.cod_servicio = b.cod_servicio(+) ';
                v_sentencia := v_sentencia ||' AND b.cod_actabo(+) = ''SS''';
                v_sentencia := v_sentencia ||' AND b.cod_producto = c.cod_producto(+) ';
                v_sentencia := v_sentencia ||' AND b.cod_actabo = c.cod_actabo(+) ';
                v_sentencia := v_sentencia ||' AND b.cod_tipserv = c.cod_tipserv(+) ';
                v_sentencia := v_sentencia ||' AND b.cod_servicio = c.cod_servicio(+) ';
                v_sentencia := v_sentencia ||' AND c.cod_planserv(+) = ''' || EV_cod_planserv || '''';
                v_sentencia := v_sentencia ||' AND SYSDATE BETWEEN c.fec_desde(+) AND NVL(c.fec_hasta(+), SYSDATE) ';
                v_sentencia := v_sentencia ||' AND c.cod_moneda = d.cod_moneda(+) ';
                v_sentencia := v_sentencia ||' AND a.cod_producto = e.cod_producto(+) ';
                v_sentencia := v_sentencia ||' AND a.cod_servicio = e.cod_servicio(+) ';
                v_sentencia := v_sentencia ||' AND e.cod_actabo(+) = ''FA''' ;
                v_sentencia := v_sentencia ||' AND e.cod_tipserv(+) = ''2''' ;
                v_sentencia := v_sentencia ||' AND e.cod_producto = f.cod_producto(+) ';
                v_sentencia := v_sentencia ||' AND e.cod_actabo = f.cod_actabo(+) ';
                v_sentencia := v_sentencia ||' AND e.cod_tipserv = f.cod_tipserv(+) ';
                v_sentencia := v_sentencia ||' AND e.cod_servicio = f.cod_servicio(+) ';
                v_sentencia := v_sentencia ||' AND f.cod_planserv(+) = ''' || EV_cod_planserv || '''';
                v_sentencia := v_sentencia ||' AND SYSDATE BETWEEN f.fec_desde(+) AND NVL(f.fec_hasta(+), SYSDATE) ';
                v_sentencia := v_sentencia ||' AND f.cod_moneda = g.cod_moneda(+)) ';
                v_sentencia := v_sentencia ||' ORDER BY A.IND_PRIORIDAD,A.DES_SERVICIO  ';

                OPEN tSS_disponibles FOR v_sentencia; --El resultado de la query lo deja en cursor.

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        SV_error := 3;
                        SV_sqlcode := SQLCODE;
                        SV_sqlerrm := SQLERRM;
                WHEN OTHERS THEN
                        SV_error := 4;
                        SV_sqlcode := SQLCODE;
                        SV_sqlerrm := SQLERRM;

END PV_RECUPERA_SS_DIS_PR;

-----------------------------------------------------------------------

FUNCTION PV_CHEQUEA_ANT_EQUIPO_FN(EN_num_abonado  IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                        EV_tip_terminal IN GA_ABOCEL.TIP_TERMINAL%TYPE,
                                                                        SV_error                   OUT VARCHAR2,
                                                                        SV_proc                    OUT VARCHAR2,
                                                                        SV_tabla                   OUT VARCHAR2,
                                                                        SV_act                     OUT VARCHAR2,
                                                                        SV_sqlcode                 OUT VARCHAR2,
                                                                        SV_sqlerrm                 OUT VARCHAR2
)RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_CHEQUEA_ANT_EQUIPO_FN                         </NOMBRE>
<FECHACREA>   13/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Chequea antiguedad                                                                 </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>   EN_num_abonado: Numero de Abonado                                  </ParamEntr>
<ParamEntr>   EV_tip_terminal: Tipo de Terminal                                  </ParamEntr>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                           </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                           </ParamSal>
</DOC>
*/
IS
    LD_fecha_alta DATE;
        LV_procedencia     GA_ABOCEL.IND_PROCEQUI%TYPE;

        BEGIN

                SV_error:='0';
                SV_proc := 'PV_CHEQUEA_ANT_EQUIPO_FN';

                SV_act := 'S';
                SV_tabla := 'GA_EQUIPABOSER';

                SELECT ADD_MONTHS(FEC_ALTA, 6), IND_PROCEQUI
                  INTO LD_fecha_alta, LV_procedencia
                  FROM GA_EQUIPABOSER
                 WHERE num_abonado = EN_num_abonado
                   AND fec_alta = (SELECT MIN(fec_alta)
                                                   FROM GA_EQUIPABOSER
                                                   WHERE  num_abonado = EN_num_abonado
                                                   AND TIP_TERMINAL = EV_tip_terminal)-- COL 75438|12-01-2009|EFR
                   AND TIP_TERMINAL = EV_tip_terminal;
                   --AND SYSDATE  >  DECODE('I',ind_procequi,SYSDATE - 1 ,ADD_MONTHS(fec_alta,6));

                IF LV_procedencia = 'I' THEN
                   RETURN TRUE;
                END IF;

                IF LD_fecha_alta > SYSDATE THEN
                    RETURN FALSE;
                ELSE
                        RETURN TRUE;
                END IF;

        EXCEPTION
                WHEN OTHERS THEN
                         SV_error := 4;
                         SV_sqlcode := SQLCODE;
                         SV_sqlerrm := SQLERRM;
                         RETURN FALSE;
END PV_CHEQUEA_ANT_EQUIPO_FN;

-----------------------------------------------------------------------

PROCEDURE PV_REC_SS_ACTIVOS_PR(EN_num_celular   IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                                           EV_usuario           IN GA_ABOCEL.NOM_USUARORA%TYPE,
                                                           tss_activos      OUT refCursor,
                                                           SV_mensaje           OUT VARCHAR2,
                                                           SV_error             OUT VARCHAR2
)
/*
<DOC>
<NOMBRE>      PV_REC_SS_ACTIVOS_PR                              </NOMBRE>
<FECHACREA>   26/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Ejecuta procesos para determinar Servicios                 </DESCRIPCION>
<DESCRIPCION> suplementarios activos del abonado                 </DESCRIPCION>
<FECHAMOD>                                                               </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>   EN_num_celular: Numero de Celular                                  </ParamEntr>
<ParamEntr>   EV_usuario : Usuario                                                               </ParamEntr>
<ParamSal>    tss_diponibles: Cursos de Servicios Suplem. Disponibles </ParamSal>
<ParamSal>    SV_mensaje: Mensaje de Respuesta                   </ParamSal>
<ParamSal>    SV_error: Codigo Error Controlado                  </ParamSal>
</DOC>
*/
IS

        EN_num_abonado          GA_ABOCEL.NUM_ABONADO%TYPE;
        EV_cod_planserv         GA_ABOCEL.COD_PLANSERV%TYPE;
        GV_implimcons           NUMBER(14,4);
        B_Ret                           BOOLEAN;
        SV_proc                     VARCHAR2(50);
        SV_tabla                    VARCHAR2(50);
        SV_act                          VARCHAR2(2);
        SV_sqlcode                      VARCHAR2(50);
        SV_sqlerrm                      VARCHAR2(250);

        ERROR_PROCESO           EXCEPTION;

        BEGIN

                SV_error:='0';
                SV_proc := 'PV_TIPOS_SINIESTRO_PR';

            IF NOT Pv_General_Ooss_Pg.PV_VALIDA_USUARIO_FN(EV_usuario,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm) THEN
                    -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    --  SV_mensaje := 'Usuario no válido ';
                        SV_mensaje := 'Usuario No Válido ';
                    -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    RAISE ERROR_PROCESO;
            END IF;

                IF NOT Pv_General_Ooss_Pg.PV_VAL_LARGO_CELULAR_FN(EN_num_celular, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
                    -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    --  SV_mensaje :=  'Celular No Cumple Con Largo Definido Por Operadora';
                        SV_mensaje :=  'Número Tel. No Válido';
                    -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    RAISE ERROR_PROCESO;
                END IF;

                Pv_General_Ooss_Pg.PV_DATOS_ABONADO_PR (EN_num_celular,GV_implimcons,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
                EN_num_abonado    := Pv_General_Ooss_Pg.VP_NUM_ABONADO;
                EV_cod_planserv   := Pv_General_Ooss_Pg.VP_COD_PLANSERV;
                IF SV_ERROR = 4 THEN
                        -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        --      SV_mensaje :=  'Celular no existe o Situación no es Válida';
                                SV_mensaje :=  'Número Tel. Invalido/No Registrado';
                        -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        RAISE ERROR_PROCESO;
                END IF;

                PV_RECUPERA_SS_ACT_PR(EN_num_abonado
                                                        , EV_cod_planserv
                                                        , tss_activos
                                                        , SV_mensaje
                                                        , SV_error
                                                        , SV_proc
                                                        , SV_tabla
                                                        , SV_act
                                                        , SV_sqlcode
                                                        , SV_sqlerrm);
                IF      SV_error = 4 THEN
                        -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        --      SV_mensaje := 'No se logro obtener Servicios Suplementarios Contratados';
                                SV_mensaje := 'Transacción No Exitosa - Activos';
                        -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        RAISE ERROR_PROCESO;
                END IF;
                IF      SV_error = 3 THEN
                        -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        --      SV_mensaje := 'Celular Sin Servicios Suplementarios Activos';
                                SV_mensaje := 'Número Tel. Sin Servicios Activos';
                        -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-

                        RAISE ERROR_PROCESO;
                END IF;



        EXCEPTION
                WHEN ERROR_PROCESO THEN
                        SV_sqlcode := SQLCODE;
                        SV_sqlerrm := SQLERRM;
                        IF EN_num_abonado = '' OR LTRIM(RTRIM(EN_num_abonado)) IS NULL THEN
                            EN_num_abonado := -1;
                        END IF;
                        B_Ret:= Pv_General_Ooss_Pg.PV_GA_ERRORES_FN(EN_num_abonado,Pv_General_Ooss_Pg.CV_cod_actabo,Pv_General_Ooss_Pg.CN_cod_producto,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm, SV_sqlcode,SV_sqlerrm);
                        SV_error := 4;

                WHEN OTHERS THEN
                        SV_sqlcode := SQLCODE;
                        SV_sqlerrm := SQLERRM;
                        SV_mensaje := 'Error en Ejecucion ';
                        IF EN_num_abonado = '' OR LTRIM(RTRIM(EN_num_abonado)) IS NULL THEN
                            EN_num_abonado := -1;
                        END IF;
                        B_Ret:= Pv_General_Ooss_Pg.PV_GA_ERRORES_FN(EN_num_abonado,Pv_General_Ooss_Pg.CV_cod_actabo,Pv_General_Ooss_Pg.CN_cod_producto,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm, SV_sqlcode,SV_sqlerrm);
                        SV_error := 4;

END PV_REC_SS_ACTIVOS_PR;

-------------------------------------------------------------------------

PROCEDURE PV_ACTIVA_SS_PR(EN_num_celular   IN NUMBER,
                                                 EV_servsupl        IN VARCHAR2,
                                                 EV_cadena_servicio     IN VARCHAR2,
                                                 EV_usuario                     IN VARCHAR2,
                                                 SN_num_solicitud   OUT NUMBER,
                                                 SV_mensaje                     OUT VARCHAR2,
                                                 SV_error                       OUT VARCHAR2
)
/*
<DOC>
<NOMBRE>      PV_ACTIVA_SS_PR                                            </NOMBRE>
<FECHACREA>   12/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Activa Servicios Suplementarios                                    </DESCRIPCION>
<FECHAMOD>                                                               </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>   EN_num_celular: Numero de Celular                                  </ParamEntr>
<ParamEntr>   EV_servsupl: Cadena de grupo y nivel a activar     </ParamEntr>
<ParamEntr>   Ej.."|sersupl1|nivel|servsupl2|nivel2|"                    </ParamEntr>
<ParamEntr>   EV_cadena_servicio: Cadena de servicios a cativar  </ParamEntr>
<ParamEntr>   EV_usuario: Tecnologia del Abonado          </ParamEntr>
<ParamEntr>   Ej.."|servicio1|servicio2|"                                                </ParamEntr>
<ParamSal>    SN_num_solicitud: Numero de OOSS generada          </ParamSal>
<ParamSal>    SV_mensaje: Mensaje de Respuesta de la activacion  </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
</DOC>
*/
IS
    EN_cod_tecnologia     GA_ABOCEL.COD_TECNOLOGIA%TYPE;
        EN_num_abonado            GA_ABOCEL.NUM_ABONADO%TYPE;
        EN_cod_cliente            GA_ABOCEL.COD_CLIENTE%TYPE;
        EN_cod_ciclo              GA_ABOCEL.COD_CICLO%TYPE;
        EV_num_serie              GA_ABOCEL.NUM_SERIE%TYPE;
        EV_ind_procedencia        GA_ABOCEL.IND_PROCEQUI%TYPE;
        EN_cod_uso                        GA_ABOCEL.COD_USO%TYPE;
        EV_cod_planserv           GA_ABOCEL.COD_PLANSERV%TYPE;

        SV_descripcion            CI_TIPORSERV.DESCRIPCION%TYPE;
        SN_tip_procesa            CI_TIPORSERV.TIP_PROCESA%TYPE;
        SN_modgener                       CI_TIPORSERV.COD_MODGENER%TYPE;
        SV_des_estadoc            FA_INTESTADOC.DES_ESTADOC%TYPE;

        LV_val_autenticaion       GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        vFormato2                 GED_PARAMETROS.VAL_PARAMETRO%TYPE;

        LN_seq_transacabo         GA_TRANSACABO.NUM_TRANSACCION%TYPE;

        LN_codciclofact           FA_CICLFACT.COD_CICLFACT%TYPE;

        SN_imp_total              PV_MOVIMIENTOS.CARGA%TYPE;
        LV_servsupl_activar       VARCHAR2(250);
        LV_sysdate                        VARCHAR2(12);
        GV_implimcons             NUMBER(14,4);
        GV_parametros             VARCHAR2(500);
        B_Ret                             BOOLEAN;
        GV_bdatos                         VARCHAR2(9);
        LN_secuencia              NUMBER(10);
        LN_ciclo                          NUMBER;
        LN_total_serv             NUMBER;
        SV_proc                       VARCHAR2(50);
        SV_tabla                      VARCHAR2(50);
        SV_act                            VARCHAR2(2);
        SV_sqlcode                        VARCHAR2(50);
        SV_sqlerrm                        VARCHAR2(250);
        SV_sqlcode_aux            VARCHAR2(50);
        SV_sqlerrm_aux            VARCHAR2(250);

        LV_arr_servicio                 SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        LV_arr_Grupo                    SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        LV_arr_Nivel                    SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

        ERROR_PROCESO             EXCEPTION;

        SV_val_parametro    GED_PARAMETROS.VAL_PARAMETRO%TYPE; --04/05/2005 ECU05002...
        SN_num_evento           ge_errores_pg.Evento;                      --04/05/2005 ECU05002...
    SV_DESERROR         ge_errores_pg.MsgError;                    --04/05/2005 ECU05002...
        SN_CODERROR             ge_errores_pg.CodError;                    --04/05/2005 ECU05002...
        BEGIN

                SV_error:='0';
                SV_proc := 'PV_ACTIVA_SS_PR';

            IF NOT Pv_General_Ooss_Pg.PV_VALIDA_USUARIO_FN(EV_usuario,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm) THEN
                    -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    --  SV_mensaje := 'Usuario no válido ';
                        SV_mensaje := 'Usuario No Válido ';
                    -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    RAISE ERROR_PROCESO;
            END IF;

                IF NOT Pv_General_Ooss_Pg.PV_VAL_LARGO_CELULAR_FN(EN_num_celular, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
                    -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    --  SV_mensaje :=  'Celular No Cumple Con Largo Definido Por Operadora';
                        SV_mensaje :=  'Número Tel. No Válido';
                    -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    RAISE ERROR_PROCESO;
                END IF;

                Pv_General_Ooss_Pg.PV_DATOS_ABONADO_PR (EN_num_celular, GV_implimcons, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error);
                IF SV_error = 4 THEN
                    -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        --      SV_mensaje :=  'Celular no existe o Situación no es Válida';
                                SV_mensaje :=  'Número Tel. Invalido/No Registrado';
                        -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        RAISE ERROR_PROCESO;
                ELSE
                        EN_num_abonado    := Pv_General_Ooss_Pg.VP_NUM_ABONADO;
                        EN_cod_cliente    := Pv_General_Ooss_Pg.VP_COD_CLIENTE;
                        EN_cod_ciclo      := Pv_General_Ooss_Pg.VP_COD_CICLO;
                        EV_num_serie      := Pv_General_Ooss_Pg.VP_NUM_SERIE;
                        EV_ind_procedencia        := Pv_General_Ooss_Pg.VP_IND_PROCEQUI;
                        EN_cod_uso                        := Pv_General_Ooss_Pg.VP_COD_USO;
                        EV_cod_planserv   := Pv_General_Ooss_Pg.VP_COD_PLANSERV;
                END IF;

                -- vFormato2 := GE_FN_DEVVALPARAM('GA', 1, 'FORMATO_SEL2'); -- COL|36787|07/03/2007|SAQL
      vFormato2 := Ge_Fn_Devvalparam('GE', 1, 'FORMATO_SEL2');

                SELECT TO_CHAR(SYSDATE, vFormato2)
                INTO   LV_sysdate
                FROM DUAL;

      -- INI COL|70065|02-10-2008|SAQL
      SELECT COD_VENDEDOR INTO NCOD_VENDEDOR
      FROM GE_SEG_USUARIO
      WHERE NOM_USUARIO = EV_usuario;

                -- GV_parametros := '||||' || CV_cod_actabo_ss ||'|' || TO_CHAR(EN_num_abonado)         || '|' || TO_CHAR(EN_cod_cliente) ||'|||' || CN_cod_ooss_ss || '||||||||||' || EN_cod_ciclo || '|' || LV_sysdate || '|';
      GV_parametros := '||||' || CV_cod_actabo_ss ||'|' || TO_CHAR(EN_num_abonado)         || '|' || TO_CHAR(EN_cod_cliente) ||'|||' || CN_cod_ooss_ss || '|' || NCOD_VENDEDOR || '|||||||||' || EN_cod_ciclo || '|' || LV_sysdate || '|';
      -- FIN COL|70065|02-10-2008|SAQL
                IF NOT Pv_General_Ooss_Pg.PV_EJEC_RESTRICCION_FN(Pv_General_Ooss_Pg.CV_cod_modulo,Pv_General_Ooss_Pg.CN_cod_producto,CV_cod_actabo_ss,CV_evento,GV_parametros, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error) THEN
                   SV_mensaje := SV_sqlerrm;
                   RAISE ERROR_PROCESO;
                END IF;

                IF EN_cod_ciclo <> Pv_General_Ooss_Pg.CN_cod_ciclo THEN
                   LN_codciclofact:= Pv_General_Ooss_Pg.PV_RECUPERA_CICLO_FACT_FN( EN_cod_cliente, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error );
                   IF NOT Pv_General_Ooss_Pg.PV_VALIDA_CICLO_VIG_FN(EN_cod_cliente, EN_num_abonado, LN_codciclofact, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error ) THEN
                             -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                             -- SV_mensaje := 'Abonado no posee ciclo de facturación vigente.';
                                SV_mensaje := 'Num Tel. sin periodo de Facturación';
                             -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                                 RAISE ERROR_PROCESO;
                   END IF;
                END IF;

                SV_tabla := 'GED_PARAMETROS [OPER_AUTENTICACION]';
                SV_act   := 'S';
                SELECT VAL_PARAMETRO
                INTO   LV_val_autenticaion
                FROM   GED_PARAMETROS
                WHERE  NOM_PARAMETRO = 'OPER_AUTENTICACION'
                AND    COD_MODULO = 'GA'
                AND    COD_PRODUCTO = 1;

                IF LV_val_autenticaion = 1 THEN
                        Pv_Valida_Autenticacion_Pr (LN_seq_transacabo, EV_num_serie, EV_ind_procedencia, EN_cod_uso);
                END IF;

                IF Pv_General_Ooss_Pg.PV_REC_SERV_FN(EV_cadena_servicio, LV_arr_servicio, LN_total_serv, SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm) THEN
                        IF SV_error = 4 THEN
                             -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                             -- SV_mensaje := 'Parámetros de Servicios Suplementarios Ingresados no válidos';
                                SV_mensaje := 'Transacción No Exitosa - Datos';
                             -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                           RAISE ERROR_PROCESO;
                        END IF;
                        LV_servsupl_activar := Pv_General_Ooss_Pg.PV_CLASE_SERV_FN(EV_servsupl,LV_arr_Grupo,LV_arr_Nivel, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error);
                        IF SV_error = 4 THEN
                             -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                             -- SV_mensaje := 'Parámetros de Servicios Suplementarios Ingresados no válidos';
                                SV_mensaje := 'Transacción No Exitosa - Datos';
                             -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-

                           RAISE ERROR_PROCESO;
                        END IF;
                        FOR LN_ciclo IN 1..LN_total_serv LOOP
                                IF NOT Pv_General_Ooss_Pg.PV_VALIDA_SERVICIO_FN(LV_arr_servicio(LN_ciclo),LV_arr_grupo(LN_ciclo),LV_arr_nivel(LN_ciclo), SV_error,SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm ) THEN
                                   -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                                   --   SV_mensaje := 'Parámetros de Servicios Suplementarios Ingresados no válidos';
                                        SV_mensaje := 'Transacción No Exitosa - Datos';
                                   -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                                   RAISE ERROR_PROCESO;
                                END IF;
                        END LOOP;
            END IF;

                Pv_General_Ooss_Pg.PV_PARAMETROS_OOSS_PR(CN_cod_ooss_ss,SV_descripcion, SN_tip_procesa, SN_modgener, SV_des_estadoc, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm);
                IF SV_error = 4 THEN
                    -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    -- SV_mensaje := 'Error Recuperando Parametros';
                       SV_mensaje := 'Transacción No Exitosa - Datos';
                    -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                   RAISE ERROR_PROCESO;
                END IF;

                ---LLAMAR CARGOS
        IF NOT PV_ASIGNA_CARGOS_FN(EN_cod_cliente, EV_cod_planserv, EN_num_abonado, EN_num_celular, SYSDATE, EV_usuario, EV_cadena_servicio, SN_imp_total, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
                   SV_mensaje := SV_sqlerrm;
                   RAISE ERROR_PROCESO;
                END IF;

                -- OBTIENE BASE DE DATOS --
                SV_tabla := 'V$DATABASE';
                SV_act := 'S';
                SELECT NAME
                INTO GV_bdatos
                FROM V$DATABASE;


                SV_tabla := 'SECUENCIA (GA_SEQ_TRANSACABO)';
                SV_act := 'S';
                SELECT CI_SEQ_NUMOS.NEXTVAL
                INTO LN_secuencia
                FROM DUAL;


                -- Inscribir OOSS --
                 Pv_General_Ooss_Pg.PV_INSCRIBE_OOSS_PR(EN_num_celular
                                                                                                , CN_cod_ooss_ss
                                                                                                , EV_usuario
                                                                                                , LN_secuencia
                                                                                                , SN_modgener
                                                                                                , CV_cod_actabo_ss
                                                                                                , EN_num_abonado
                                                                                                , Pv_General_Ooss_Pg.CN_cod_producto
                                                                                                , NULL--GN_ind_central_ss
                                                                                                , NULL
                                                                                                , NULL--GV_tip_susp_avsinie
                                                                                                , NULL
                                                                                                , NULL
                                                                                                , NULL
                                                                                                , NULL
                                                                                                , NULL
                                                                                                , 0
                                                                                                , NULL
                                                                                                , NULL
                                                                                                , 0
                                                                                                , NULL
                                                                                                , NULL
                                                                                                , LV_servsupl_activar
                                                                                                , NULL
                                                                                                , 0
                                                                                                , NULL
                                                                                                , 0
                                                                                                , SV_descripcion
                                                                                                , SN_tip_procesa
                                                                                                , SN_modgener
                                                                                                , SV_des_estadoc
                                                                                                , 1
                                                                                                , SN_imp_total
                                                                                                , SV_error
                                                                                                , SV_proc
                                                                                                , SV_tabla
                                                                                                , SV_act
                                                                                                , SV_sqlcode
                                                                                                , SV_sqlerrm
                                                                                                );

                 IF SV_error = 4 THEN
                             -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                             -- SV_mensaje := 'Error Durante inscripcion de Orden de Servico';
                                SV_mensaje := 'Transacción No Exitosa';
                             -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        RAISE ERROR_PROCESO;
                 END IF;


             --- Insertar Carta --
             IF NOT Pv_General_Ooss_Pg.PV_REG_CARTA_FN(LN_secuencia, CN_cod_ooss_ss, EN_cod_cliente, EN_num_celular, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error) THEN
                    RAISE ERROR_PROCESO;
             END IF;

                 -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                 --     SV_mensaje := 'ORDEN DE SERVICIO GENERADA ';
                        SV_mensaje := 'Transacción Exitosa';
                 -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                 SN_num_solicitud := LN_secuencia;


  --Inicio 04-05-2005...ECU05002....
  -- Obtener datos desde GED_parametros para parametro EJECUTA_COMMIT y verificar si debe o no ejecutar el commit..
   SV_val_parametro:=NULL;
   SN_CODERROR:=0;
   IF NOT Ge_Validaciones_Pg.ge_obtiene_gedparametros_fn(CV_ejecuta_commit,CV_cod_modulo,
                                                  CV_cod_producto_post,SV_val_parametro,
                                  SN_CODERROR,SV_DESERROR,SN_num_evento) THEN
                 RAISE  ERROR_PROCESO;
   END IF;

   IF SN_CODERROR<>0 THEN
          RAISE ERROR_PROCESO;
   ELSE
     IF SV_val_parametro=CV_si_ejecuta_commit THEN
        COMMIT;  --esto era lo que existía sin buscar en la ged_parametros ECU05002...
     END IF;
   END IF;
  --Fin  04-05-2005...ECU05002....



        EXCEPTION
                WHEN ERROR_PROCESO THEN
                        ROLLBACK;
                        SV_sqlcode_aux := SUBSTR(SV_sqlcode,1,15);--SQLCODE;
                        SV_sqlerrm_aux := SUBSTR(SV_sqlerrm,1,60);--SQLERRM;
                        IF EN_num_abonado = '' OR LTRIM(RTRIM(EN_num_abonado)) IS NULL THEN
                            EN_num_abonado := -1;
                        END IF;
                        B_Ret:= Pv_General_Ooss_Pg.PV_GA_ERRORES_FN(EN_num_abonado,CV_cod_actabo_ss,Pv_General_Ooss_Pg.CN_cod_producto, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode_aux, SV_sqlerrm_aux, SV_sqlcode, SV_sqlerrm);
                        SV_error := 4;
                        COMMIT;
                WHEN OTHERS THEN
                        ROLLBACK;
                        SV_sqlcode_aux := SUBSTR(SQLCODE,1,15);
                        SV_sqlerrm_aux := SUBSTR(SQLERRM,1,60);
                        -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        -- SV_mensaje := 'Error en Ejecucion ';
                           SV_mensaje := 'Transacción No Exitosa';
                        -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        IF EN_num_abonado = '' OR LTRIM(RTRIM(EN_num_abonado)) IS NULL THEN
                            EN_num_abonado := -1;
                        END IF;
                        B_Ret:= Pv_General_Ooss_Pg.PV_GA_ERRORES_FN(EN_num_abonado,CV_cod_actabo_ss,Pv_General_Ooss_Pg.CN_cod_producto, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode_aux, SV_sqlerrm_aux, SV_sqlcode, SV_sqlerrm);
                        SV_error := 4;
                        COMMIT;
END PV_ACTIVA_SS_PR;

-------------------------------------------------------------------------
PROCEDURE PV_DESACTIVA_SS_PR(EN_num_celular      IN NUMBER,
                                                     EV_servsupl             IN VARCHAR2,
                                                         EV_cadena_servicio      IN VARCHAR2,
                                                         EV_usuario                      IN VARCHAR2,
                                                         SN_num_solicitud   OUT NUMBER,
                                                         SV_mensaje                     OUT VARCHAR2,
                                                         SV_error                       OUT VARCHAR2
)
/*
<DOC>
<NOMBRE>      PV_DESACTIVA_SS_PR                              </NOMBRE>
<FECHACREA>   12/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Desactiva Servicios Suplemtarios                           </DESCRIPCION>
<FECHAMOD>                                                               </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>   EN_num_celular: Numero de Celular                                  </ParamEntr>
<ParamEntr>   EV_servsupl: Cadena de grupo y nivel a activar     </ParamEntr>
<ParamEntr>   Ej.."|sersupl1|nivel|servsupl2|nivel2|"                    </ParamEntr>
<ParamEntr>   EV_cadena_servicio: Cadena de servicios a cativar  </ParamEntr>
<ParamEntr>   EV_usuario: Tecnologia del Abonado          </ParamEntr>
<ParamEntr>   Ej.."|servicio1|servicio2|"                                                </ParamEntr>
<ParamSal>    SN_num_solicitud: Numero de OOSS generada          </ParamSal>
<ParamSal>    SV_mensaje: Mensaje de Respuesta de la activacion  </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
</DOC>
*/
IS
    EN_cod_tecnologia       GA_ABOCEL.COD_TECNOLOGIA%TYPE;
        EN_num_abonado                  GA_ABOCEL.NUM_ABONADO%TYPE;
        EN_cod_cliente                  GA_ABOCEL.COD_CLIENTE%TYPE;
        EN_cod_producto                 GA_ABOCEL.COD_PRODUCTO%TYPE;
        EN_cod_ciclo                    GA_ABOCEL.COD_CICLO%TYPE;
        EV_num_serie                    GA_ABOCEL.NUM_SERIE%TYPE;
        EV_ind_procedencia              GA_ABOCEL.IND_PROCEQUI%TYPE;
        EN_cod_uso                              GA_ABOCEL.COD_USO%TYPE;
        EV_cod_planserv                 GA_ABOCEL.COD_PLANSERV%TYPE;
        EN_cod_central                  GA_ABOCEL.COD_CENTRAL%TYPE;
        EV_tip_terminal                 GA_ABOCEL.TIP_TERMINAL%TYPE;

        SV_descripcion                  CI_TIPORSERV.DESCRIPCION%TYPE;
        SN_tip_procesa                  CI_TIPORSERV.TIP_PROCESA%TYPE;
        SN_modgener                             CI_TIPORSERV.COD_MODGENER%TYPE;
        SV_des_estadoc                  FA_INTESTADOC.DES_ESTADOC%TYPE;
        vFormato2                   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LV_sysdate                          VARCHAR2(12);
        LV_val_autenticacion    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        SN_imp_total                    PV_MOVIMIENTOS.CARGA%TYPE;
        LV_servsupl_desactivar  VARCHAR2(250);
        GV_parametros                   VARCHAR2(500);
        GV_bdatos                               VARCHAR2(9);
        GV_implimcons                   NUMBER(14,4);
        LN_secuencia                    NUMBER(10);
        B_Ret                                   BOOLEAN;

        SV_proc                         VARCHAR2(250);
        SV_tabla                        VARCHAR2(250);
        SV_act                                  VARCHAR2(250);
        SV_sqlcode                              VARCHAR2(250);
        SV_sqlerrm                              VARCHAR2(250);

        LN_ciclo                                NUMBER;
        LN_ciclo_sp                             NUMBER;
        LN_ciclo_aux                    NUMBER;
    LN_total_serv                       NUMBER;
    LN_total_ss                         NUMBER;
        LV_des_ss                               VARCHAR2(255);
        LB_ind                                  BOOLEAN;
        LB_ind_err                              BOOLEAN;
        LN_codciclofact                 FA_CICLFACT.COD_CICLFACT%TYPE;
        LN_seq_transacabo               GA_TRANSACABO.NUM_TRANSACCION%TYPE;
        LV_arr_servicio                 SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        LV_arr_des_ss                   SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        LV_arr_cod_ss_act               SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        LV_arr_Grupo                    SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        LV_arr_Nivel                    SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        ERROR_PROCESO                   EXCEPTION;

        SV_val_parametro    GED_PARAMETROS.VAL_PARAMETRO%TYPE; --04/05/2005 ECU05002...
        SN_num_evento           ge_errores_pg.Evento;                      --04/05/2005 ECU05002...
    SV_DESERROR         ge_errores_pg.MsgError;                    --04/05/2005 ECU05002...
        SN_CODERROR             ge_errores_pg.CodError;                    --04/05/2005 ECU05002...


        BEGIN

                SV_error:='0';
                SV_proc := 'PV_DESACTIVA_SS_PR';

                SN_imp_total := 0;

            IF NOT Pv_General_Ooss_Pg.PV_VALIDA_USUARIO_FN(EV_usuario,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm) THEN
                   -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    --  SV_mensaje := 'Usuario no válido ';
                        SV_mensaje := 'Usuario No Válido ';
                    -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    RAISE ERROR_PROCESO;
            END IF;

                IF NOT Pv_General_Ooss_Pg.PV_VAL_LARGO_CELULAR_FN(EN_num_celular, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
                    -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    --  SV_mensaje :=  'Celular No Cumple Con Largo Definido Por Operadora';
                        SV_mensaje :=  'Número Tel. No Válido';
                    -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    RAISE ERROR_PROCESO;
                END IF;

                EN_num_abonado := -1;


                Pv_General_Ooss_Pg.PV_DATOS_ABONADO_PR (EN_num_celular, GV_implimcons, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error);
                IF SV_error = 4 THEN
                        -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        --      SV_mensaje :=  'Celular no existe o Situación no es Válida';
                                SV_mensaje :=  'Número Tel. Invalido/No Registrado';
                        -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    RAISE ERROR_PROCESO;
                ELSE
                        EN_num_abonado     := Pv_General_Ooss_Pg.VP_NUM_ABONADO;
                        EN_cod_cliente     := Pv_General_Ooss_Pg.VP_COD_CLIENTE;
                        EN_cod_producto    := Pv_General_Ooss_Pg.VP_COD_PRODUCTO;
                        EN_cod_ciclo       := Pv_General_Ooss_Pg.VP_COD_CICLO;
                        EV_num_serie       := Pv_General_Ooss_Pg.VP_NUM_SERIE;
                        EV_ind_procedencia := Pv_General_Ooss_Pg.VP_IND_PROCEQUI;
                        EN_cod_uso                 := Pv_General_Ooss_Pg.VP_COD_USO;
                        EV_cod_planserv    := Pv_General_Ooss_Pg.VP_COD_PLANSERV;
                        EN_cod_central     := Pv_General_Ooss_Pg.VP_COD_CENTRAL;
                        EV_tip_terminal    := Pv_General_Ooss_Pg.VP_TIP_TERMINAL;
                        EN_cod_tecnologia  := Pv_General_Ooss_Pg.VP_COD_TECNOLOGIA;
                END IF;

                IF EN_cod_ciclo <> Pv_General_Ooss_Pg.CN_cod_ciclo THEN
                   LN_codciclofact:= Pv_General_Ooss_Pg.PV_RECUPERA_CICLO_FACT_FN( EN_cod_cliente, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error );
                   IF NOT Pv_General_Ooss_Pg.PV_VALIDA_CICLO_VIG_FN(EN_cod_cliente, EN_num_abonado, LN_codciclofact, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error ) THEN
                             SV_mensaje := 'Abonado no posee ciclo de facturación vigente.';
                                 RAISE ERROR_PROCESO;
                   END IF;
                END IF;



                IF Pv_General_Ooss_Pg.PV_REC_SERV_FN(EV_cadena_servicio, LV_arr_servicio, LN_total_serv, SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm) THEN
                   FOR LN_ciclo IN 1..LN_total_serv LOOP
                           IF NOT PV_PRE_REQUISITO_SS_FN (EN_cod_producto,LV_arr_servicio(LN_ciclo),EN_cod_central,EV_tip_terminal,EN_cod_tecnologia,LV_arr_des_ss,LV_arr_cod_ss_act,LN_total_ss,SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm,SV_error) THEN
                                           LV_des_ss  := PV_DES_SS_FN(LV_arr_servicio(LN_ciclo),EN_cod_producto,SV_error,SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm);
                                           SV_mensaje := 'Servicio Suplementario ' || LV_des_ss || ' Debe Desactivarse Junto con el(los) Siguiente(s) SS : ';
                                           LB_ind_err := FALSE;
                                           FOR LN_ciclo_ss IN 1..LN_total_ss LOOP
                                                   LB_ind := FALSE;
                                                   FOR LN_ciclo_aux IN 1..LN_total_serv LOOP
                                                           IF LV_arr_servicio(LN_ciclo_aux) = LV_arr_des_ss(LN_ciclo_ss) THEN
                                                                  LB_ind := TRUE;
                                                                  EXIT;
                                                           END IF;
                                                   END LOOP;
                                                   IF NOT LB_ind THEN
                                                   SV_mensaje := SV_mensaje || LV_arr_des_ss(LN_ciclo_ss) || ' , ';
                                                           LB_ind_err := TRUE;
                                                   END IF;
                                           END LOOP;
                                           IF LB_ind_err THEN
                                                  RAISE ERROR_PROCESO;
                                           END IF;
                           END IF;
                   END LOOP;
                END IF;

                LV_servsupl_desactivar := Pv_General_Ooss_Pg.PV_CLASE_SERV_FN(EV_servsupl,LV_arr_Grupo,LV_arr_Nivel ,SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error);
                IF SV_error = 4 THEN
                   SV_mensaje := 'Parámetros de Servicios Suplementarios Ingresados no válidos';
                   RAISE ERROR_PROCESO;
                END IF;

                FOR LN_ciclo IN 1..LN_total_serv LOOP
                        IF NOT Pv_General_Ooss_Pg.PV_VALIDA_SERVICIO_FN(LV_arr_servicio(LN_ciclo),LV_arr_grupo(LN_ciclo),LV_arr_nivel(LN_ciclo), SV_error,SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm ) THEN
                           SV_mensaje := 'Parámetros de Servicios Suplementarios Ingresados no válidos';
                           RAISE ERROR_PROCESO;
                        END IF;
                END LOOP;


                Pv_General_Ooss_Pg.PV_PARAMETROS_OOSS_PR(CN_cod_ooss_ss,SV_descripcion, SN_tip_procesa, SN_modgener, SV_des_estadoc, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm);
                IF SV_error = 4 THEN
                    -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    -- SV_mensaje := 'Error Recuperando Parametros';
                       SV_mensaje := 'Transacción No Exitosa - Datos';
                    -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                   RAISE ERROR_PROCESO;
                END IF;

                -- vFormato2 := GE_FN_DEVVALPARAM('GA', 1, 'FORMATO_SEL2'); -- COL|36787|07/03/2007|SAQL
      vFormato2 := Ge_Fn_Devvalparam('GE', 1, 'FORMATO_SEL2');

                SELECT TO_CHAR(SYSDATE, vFormato2)
                INTO   LV_sysdate
                FROM DUAL;

      -- INI COL|70065|02-10-2008|SAQL
      SELECT COD_VENDEDOR INTO NCOD_VENDEDOR
      FROM GE_SEG_USUARIO
      WHERE NOM_USUARIO = EV_usuario;

                --GV_parametros := '||||' || CV_cod_actabo_ss ||'|' || TO_CHAR(EN_num_abonado)         || '|' || TO_CHAR(EN_cod_cliente) ||'|||' || CN_cod_ooss_ss || '||||||||||' || EN_cod_ciclo || '|' || LV_sysdate || '|';
      GV_parametros := '||||' || CV_cod_actabo_ss ||'|' || TO_CHAR(EN_num_abonado)         || '|' || TO_CHAR(EN_cod_cliente) ||'|||' || CN_cod_ooss_ss || '|' || NCOD_VENDEDOR || '|||||||||' || EN_cod_ciclo || '|' || LV_sysdate || '|';
      -- FIN COL|70065|02-10-2008|SAQL

                IF NOT Pv_General_Ooss_Pg.PV_EJEC_RESTRICCION_FN(Pv_General_Ooss_Pg.CV_cod_modulo,Pv_General_Ooss_Pg.CN_cod_producto,CV_cod_actabo_ss,CV_evento,GV_parametros, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error) THEN
                   SV_mensaje := SV_sqlerrm;
                   RAISE ERROR_PROCESO;
                END IF;




                SV_tabla := 'GED_PARAMETROS [OPER_AUTENTICACION]';
                SV_act   := 'S';

                LV_val_autenticacion := Ge_Fn_Devvalparam('GA',1,'OPER_AUTENTICACION');

                IF LV_val_autenticacion = 1 THEN
                        Pv_Valida_Autenticacion_Pr (LN_seq_transacabo, EV_num_serie, EV_ind_procedencia, EN_cod_uso);
                END IF;

      /* INI COL|70065|07-10-2008|SAQL */
      /*
        IF NOT PV_ASIGNA_CARGOS_FN(EN_cod_cliente, EV_cod_planserv, EN_num_abonado, EN_num_celular, SYSDATE, EV_usuario, EV_cadena_servicio, SN_imp_total, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
                   SV_mensaje := SV_sqlerrm;
                   RAISE ERROR_PROCESO;
                END IF;
      */
      SN_imp_total := 0; -- NO SE DEBE REALIZAR COBRO EN LAS DESACTIVACIONES
      /* FIN COL|70065|07-10-2008|SAQL */

                SV_tabla := 'V$DATABASE';
                SV_act := 'S';
                SELECT NAME     INTO GV_bdatos FROM V$DATABASE;


                SV_tabla := 'SECUENCIA (GA_SEQ_TRANSACABO)';
                SV_act := 'S';
                SELECT CI_SEQ_NUMOS.NEXTVAL     INTO LN_secuencia  FROM DUAL;


                -- Inscribir OOSS --
                 Pv_General_Ooss_Pg.PV_INSCRIBE_OOSS_PR(EN_num_celular
                                                                                                , CN_cod_ooss_ss
                                                                                                , EV_usuario
                                                                                                , LN_secuencia
                                                                                                , SN_modgener
                                                                                                , CV_cod_actabo_ss
                                                                                                , EN_num_abonado
                                                                                                , Pv_General_Ooss_Pg.CN_cod_producto
                                                                                                , NULL--GN_ind_central_ss
                                                                                                , NULL
                                                                                                , NULL--GV_tip_susp_avsinie
                                                                                                , NULL
                                                                                                , NULL
                                                                                                , NULL
                                                                                                , NULL
                                                                                                , NULL
                                                                                                , 0
                                                                                                , NULL
                                                                                                , NULL
                                                                                                , 0
                                                                                                , NULL
                                                                                                , NULL
                                                                                                , NULL
                                                                                                , LV_servsupl_desactivar
                                                                                                , 0
                                                                                                , NULL
                                                                                                , 0
                                                                                                , SV_descripcion
                                                                                                , SN_tip_procesa
                                                                                                , SN_modgener
                                                                                                , SV_des_estadoc
                                                                                                , 1
                                                                                                , SN_imp_total
                                                                                                , SV_error
                                                                                                , SV_proc
                                                                                                , SV_tabla
                                                                                                , SV_act
                                                                                                , SV_sqlcode
                                                                                                , SV_sqlerrm
                                                                                                );


                 IF SV_error = 4 THEN
                        -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        --      SV_mensaje := 'Error Durante inscripcion de Orden de Servico';
                                SV_mensaje := 'Transacción No Exitosa';
                        -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        RAISE ERROR_PROCESO;
                 END IF;


             --- Insertar Carta --
             IF NOT Pv_General_Ooss_Pg.PV_REG_CARTA_FN(LN_secuencia, CN_cod_ooss_ss, EN_cod_cliente, EN_num_celular, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error) THEN
                        SV_mensaje := 'Error Durante generación de Carta';
                    RAISE ERROR_PROCESO;
             END IF;

                 SN_num_solicitud := LN_secuencia;
                 -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                 --     SV_mensaje := 'ORDEN DE SERVICIO GENERADA ';
                        SV_mensaje := 'Transacción Exitosa';
                 -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-

  --Inicio 04-05-2005...ECU05002....
  -- Obtener datos desde GED_parametros para parametro EJECUTA_COMMIT y verificar si debe o no ejecutar el commit..
   SV_val_parametro:=NULL;
   SN_CODERROR:=0;
   IF NOT Ge_Validaciones_Pg.ge_obtiene_gedparametros_fn(CV_ejecuta_commit,CV_cod_modulo,
                                                  CV_cod_producto_post,SV_val_parametro,
                                  SN_CODERROR,SV_DESERROR,SN_num_evento) THEN
                 RAISE  ERROR_PROCESO;
   END IF;

   IF SN_CODERROR<>0 THEN
          RAISE ERROR_PROCESO;
   ELSE
     IF SV_val_parametro=CV_si_ejecuta_commit THEN
        COMMIT;  --esto era lo que existía sin buscar en la ged_parametros ECU05002...
     END IF;
   END IF;
  --Fin  04-05-2005...ECU05002....



        EXCEPTION
                WHEN ERROR_PROCESO THEN
                         BEGIN
                                SV_error := 4;
                                SV_sqlcode := '-3000';
                                SV_sqlerrm := SUBSTR(SV_mensaje,1,60);
                                ROLLBACK;
                            B_Ret:= Pv_General_Ooss_Pg.PV_GA_ERRORES_FN(EN_num_abonado,CV_cod_actabo_ss,Pv_General_Ooss_Pg.CN_cod_producto, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_sqlcode, SV_sqlerrm);
                                IF B_Ret  THEN
                                   SV_ERROR          := 4;
                                   SV_sqlcode    := '-3000';
                                   SV_sqlerrm  := SV_mensaje;
                                   COMMIT;
                                END IF;
                                EXCEPTION
                                WHEN OTHERS THEN
                                     SV_ERROR      := 4;
                                         SV_sqlcode    := SQLCODE;
                                         SV_mensaje    := SQLERRM;
                         END;

                WHEN OTHERS THEN
                         BEGIN
                                SV_error := 4;
                                SV_sqlcode := SUBSTR(SQLCODE,1,15);
                                SV_sqlerrm := SUBSTR(SQLERRM,1,60);
                                -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                                -- SV_mensaje := 'Error en Ejecucion ';
                                   SV_mensaje :=  'Transacción No Exitosa';
                                -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                                ROLLBACK;
                                B_Ret:= Pv_General_Ooss_Pg.PV_GA_ERRORES_FN(EN_num_abonado,CV_cod_actabo_ss,Pv_General_Ooss_Pg.CN_cod_producto, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_sqlcode, SV_sqlerrm);
                                IF B_Ret  THEN
                                   SV_ERROR          := 4;
                                   SV_sqlcode    := '-3000';
                                   SV_sqlerrm  := SV_mensaje;
                                   COMMIT;
                                END IF;
                                EXCEPTION
                                WHEN OTHERS THEN
                                     SV_ERROR      := 4;
                                         SV_sqlcode    := SQLCODE;
                                         SV_mensaje    := SQLERRM;
                         END;

END PV_DESACTIVA_SS_PR;

-------------------------------------------------------------------------

FUNCTION PV_ASIGNA_CARGOS_FN       ( EN_cod_cliente              IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                                                         EV_cod_planserv         IN GA_ABOCEL.COD_PLANSERV%TYPE,
                                                                         EN_num_abonado          IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                         EN_num_terminal         IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                                                         ED_fec_alta             IN GA_ABOCEL.FEC_ALTA%TYPE,
                                                                         EV_usuario              IN GE_CARGOS.NOM_USUARORA%TYPE,
                                                                         EV_cadena_servicio      IN VARCHAR2,
                                                                         SN_imp_total           OUT PV_MOVIMIENTOS.CARGA%TYPE,
                                                                         SV_error           OUT VARCHAR2,
                                                                         SV_proc            OUT VARCHAR2,
                                                                 SV_tabla           OUT VARCHAR2,
                                                                 SV_act             OUT VARCHAR2,
                                                                 SV_sqlcode         OUT VARCHAR2,
                                                                 SV_sqlerrm         OUT VARCHAR2
                                                                 ) RETURN BOOLEAN


/*
<DOC>
<NOMBRE>      PV_ASIGNA_CARGOS_PR                           </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>   EN_cod_cliente : Codigo de Cliente                         </ParamEntr>
<ParamEntr>   EV_cod_planserv : Codigo Plan de servicio          </ParamEntr>
<ParamEntr>   EN_num_abonado : Numero de Abonado                         </ParamEntr>
<ParamEntr>   EN_num_terminal : Numero de Celular                        </ParamEntr>
<ParamEntr>   ED_fec_alta : Sysdate                                                      </ParamEntr>
<ParamEntr>   EV_usuario : Usuario                                                       </ParamEntr>
<ParamEntr>   EV_cadena_servicio : Cadena de Servicios a Activar/Desac  </ParamEntr>
<ParamSal>    SN_imp_total                                                                       </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS
  GB_ret                  BOOLEAN;
  GN_codciclfact  FA_CICLFACT.COD_CICLFACT%TYPE;
  GV_codplancom   GA_CLIENTE_PCOM.COD_PLANCOM%TYPE;
  SV_codconcepto  GA_ACTUASERV.COD_CONCEPTO%TYPE;
  SV_codmoneda    GA_TARIFAS.COD_MONEDA%TYPE;
  SN_imptarifa    GA_TARIFAS.IMP_TARIFA%TYPE;
  SN_imptarifa2   GA_TARIFAS.IMP_TARIFA%TYPE;
  EV_cod_servicio GA_ACTUASERV.COD_SERVICIO%TYPE;
  vn_CodActuacion VARCHAR2(2) := 'FO';
  v_Cursor                refCursor;

  LV_arr_servicio  SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  LN_total_serv    NUMBER;

  LD_fec_fincontrato  GA_SEGURABO.FEC_FINCONTRATO%TYPE;
  LN_cod_tipseguro        GA_SEGURABO.COD_TIPSEGU%TYPE;

  LN_cod_penaliza         GA_PERCONTRATO.COD_PENALIZA%TYPE;

  ERROR_PROCESO           EXCEPTION;

  OK BOOLEAN;


BEGIN
           SV_error   := '0';
           SV_proc        := 'PV_ASIGNA_CARGOS_PR';
           SV_act         := '';
           SV_tabla   := '';

           SN_imp_total := 0;
           OK := Pv_General_Ooss_Pg.PV_REC_SERV_FN(EV_cadena_servicio, LV_arr_servicio, LN_total_serv, SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm);


           GN_codciclfact := Pv_General_Ooss_Pg.PV_RECUPERA_CICLO_FACT_FN(EN_cod_cliente, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm,SV_error);
           GV_codplancom  := Pv_General_Ooss_Pg.PV_RECUPERA_PLAN_COMERCIAL_FN(EN_cod_cliente, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm,SV_error);

                GB_ret:= Pv_General_Ooss_Pg.PV_CARGOS_FN(Pv_General_Ooss_Pg.CN_cod_producto, CV_cod_actabo_SS, EV_cod_planserv, SV_codconcepto,  SV_codmoneda, SN_imptarifa,  SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error);

                IF SV_error <> 4 THEN
                    IF SN_imptarifa > 0 THEN
                                GB_ret:= Pv_General_Ooss_Pg.PV_INSERTA_CARGOS_FN(EN_cod_cliente,Pv_General_Ooss_Pg.CN_cod_producto,EN_num_abonado,EN_num_terminal,GV_codplancom,ED_fec_alta,GN_codciclfact,SV_codconcepto,
                                                                                   SN_imptarifa,SV_codmoneda,EV_usuario, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm,SV_error);
                                SN_imp_total := SN_imp_total + SN_imptarifa;
                        END IF;
                ELSE
                        RAISE ERROR_PROCESO;
                END IF;

                SN_imptarifa2 := 0;
                FOR LN_ciclo IN 1..LN_total_serv LOOP
                        GB_ret:= Pv_General_Ooss_Pg.PV_CARGOS_SS_FN(Pv_General_Ooss_Pg.CN_cod_producto, CV_cod_actabo_SS, EV_cod_planserv, LV_arr_servicio(LN_ciclo), SV_codconcepto, SV_codmoneda, SN_imptarifa2,  SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error);
                    IF SV_error <> 4 THEN
                                IF SN_imptarifa2 > 0 THEN
                                   GB_ret:= Pv_General_Ooss_Pg.PV_INSERTA_CARGOS_FN(EN_cod_cliente,Pv_General_Ooss_Pg.CN_cod_producto,EN_num_abonado,EN_num_terminal,GV_codplancom,ED_fec_alta,GN_codciclfact,SV_codconcepto,
                                                                                           SN_imptarifa2,SV_codmoneda,EV_usuario, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm,SV_error);
                                   SN_imp_total := SN_imp_total + SN_imptarifa2;
                                END IF;
                        ELSE
                                RAISE ERROR_PROCESO;
                        END IF;
            END LOOP;

                BEGIN
                        SV_act    := 'S';
                        SV_tabla  := 'GA_SEGURABO';
                        SELECT a.fec_fincontrato
                                   , a.cod_tipsegu
                        INTO   LD_fec_fincontrato
                           , LN_cod_tipseguro
                        FROM GA_SEGURABO a
                        WHERE a.num_abonado = EN_num_abonado
                        AND a.fec_fincontrato >= SYSDATE;
            EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                           LD_fec_fincontrato := '';
                           LN_cod_tipseguro := '';
                    WHEN OTHERS THEN
                           RAISE ERROR_PROCESO;
            END;
            BEGIN
                        SV_act    := 'S';
                        SV_tabla  := 'GA_PERCONTRATO/GA_TIPOSEGURO';
                    SELECT d.cod_penaliza
                        INTO     LN_cod_penaliza
                        FROM     GA_PERCONTRATO d , GA_TIPOSEGURO c
                        WHERE  d.cod_producto = c.cod_producto
                        AND      c.cod_tipsegu = LN_cod_tipseguro
                        AND      d.cod_tipcontrato = c.cod_tipcontrato;
            EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                           LN_cod_penaliza := '';
                    WHEN OTHERS THEN
                           NULL;
            END;
                SN_imptarifa2 := 0;
                GB_ret:= Pv_General_Ooss_Pg.PV_CARGOS_PENAL_FN(Pv_General_Ooss_Pg.CN_cod_producto,LN_cod_penaliza, SV_codconcepto, SV_codmoneda, SN_imptarifa2, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error);
                IF  SV_error <> 4 THEN
                        IF SN_imptarifa2 > 0 THEN
                                GB_ret:= Pv_General_Ooss_Pg.PV_INSERTA_CARGOS_FN(EN_cod_cliente,Pv_General_Ooss_Pg.CN_cod_producto,EN_num_abonado,EN_num_terminal,GV_codplancom,ED_fec_alta,GN_codciclfact,SV_codconcepto,
                                                                                   SN_imptarifa2,SV_codmoneda,EV_usuario, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm,SV_error);
                                SN_imp_total := SN_imp_total + SN_imptarifa2;
                        END IF;
                END IF;


                GB_ret:= Pv_General_Ooss_Pg.PV_UPD_CARGOS_FN(EN_cod_cliente,EN_num_abonado,GN_codciclfact, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm,SV_error);
                IF SV_error = 4 THEN
                   RAISE ERROR_PROCESO;
                END IF;

       RETURN TRUE;
EXCEPTION
           WHEN ERROR_PROCESO THEN
                   RETURN FALSE;
           WHEN OTHERS THEN
                   SV_error := 4;
                   SV_sqlcode := SQLCODE;
                   SV_sqlerrm := SQLERRM;
                   RETURN FALSE;

END PV_ASIGNA_CARGOS_FN;


PROCEDURE PV_REC_PARAM_SS_ACT_PR(EN_num_celular   IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                                                 EN_cod_central   IN GA_ABOCEL.COD_CENTRAL%TYPE,
                                                                 SN_cod_sistema   OUT ICG_CENTRAL.COD_SISTEMA%TYPE,
                                                                 SN_cod_plancom   OUT VE_PLANCOM.COD_PLANCOM%TYPE,
                                                                 SV_mensaje               OUT VARCHAR2,
                                                                 SV_error                 OUT VARCHAR2,
                                                                 SV_proc                  OUT VARCHAR2,
                                                                 SV_tabla                 OUT VARCHAR2,
                                                                 SV_act                   OUT VARCHAR2,
                                                                 SV_sqlcode               OUT VARCHAR2,
                                                                 SV_sqlerrm               OUT VARCHAR2
)
/*
<DOC>
<NOMBRE>      PV_REC_PARAM_SS_ACT_PR                              </NOMBRE>
<FECHACREA>   12/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Obtiene parametros necesarios para recuperar       </DESCRIPCION>
<DESCRIPCION> SS activos.                                                            </DESCRIPCION>
<FECHAMOD>                                                               </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>   EV_cod_tecnologia: Tecnologia del Abonado          </ParamEntr>
<ParamSal>    tTip_Siniesto: Cursor de Tipos de Siniestros       </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                           </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                           </ParamSal>
</DOC>
*/
IS

        BEGIN

                SV_mensaje := '';
                SV_error:='0';
                SV_proc := 'PV_TIPOS_SINIESTRO_PR';

                SV_tabla := 'ICG_CENTRAL';
                SV_act   := 'S';
                SELECT cod_sistema
                INTO   SN_cod_sistema
                FROM   ICG_CENTRAL
                WHERE  cod_producto = Pv_General_Ooss_Pg.CN_cod_producto
                AND    cod_central = EN_cod_central;

                SV_tabla := 'ICG_CENTRAL';
                SV_act   := 'S';
                SELECT cod_plancom
                INTO SN_cod_plancom
                FROM VE_PLANCOM
                WHERE cod_producto = Pv_General_Ooss_Pg.CN_cod_producto;

        EXCEPTION

                WHEN NO_DATA_FOUND THEN
                        -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        --      SV_mensaje := 'Error en la Busqueda de Datos';
                                SV_mensaje := 'Transacción No Exitosa - Datos';
                        -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                        SV_error := 4;
                        SV_sqlcode := SQLCODE;
                        SV_sqlerrm := SQLERRM;
                WHEN OTHERS THEN
                        SV_error := 4;
                        SV_sqlcode := SQLCODE;
                        SV_sqlerrm := SQLERRM;

END PV_REC_PARAM_SS_ACT_PR;

------------------------------------------------------------------------

PROCEDURE PV_RECUPERA_SS_ACT_PR(EN_num_abonado    IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                 EV_cod_planserv  IN GA_ABOCEL.COD_PLANSERV%TYPE,
                                                                 tSS_contratados  OUT refCursor,
                                                                 SV_mensaje               OUT VARCHAR2,
                                                                 SV_error                 OUT VARCHAR2,
                                                                 SV_proc                  OUT VARCHAR2,
                                                                 SV_tabla                 OUT VARCHAR2,
                                                                 SV_act                   OUT VARCHAR2,
                                                                 SV_sqlcode               OUT VARCHAR2,
                                                                 SV_sqlerrm               OUT VARCHAR2
)
/*
<DOC>
<NOMBRE>      PV_RECUPERA_SS_ACT_PR                              </NOMBRE>
<FECHACREA>   12/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Carga Cursor con Servicios Suplem. Activos         </DESCRIPCION>
<FECHAMOD>                                                               </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>   EN_num_celular: Numero de Celular                                  </ParamEntr>
<ParamEntr>   EV_cod_planserv: Codigo Plan de Servicio                   </ParamEntr>
<ParamSal>    tSS_contratados: Cursor de Servicios Sup. Activos  </ParamSal>
<ParamSal>    SV_mensaje: Mensaje de Salida                                              </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                           </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                           </ParamSal>
</DOC>
*/
IS

    LV_tip_servicio             GED_CODIGOS.COD_VALOR%TYPE;
        LV_cod_servicio         GA_SERVSUPLABO.COD_SERVICIO%TYPE;
        LN_cod_nivel            GA_SERVSUPLABO.COD_NIVEL%TYPE;
        LN_cod_servsupl         GA_SERVSUPLABO.COD_SERVSUPL%TYPE;

        BEGIN

                SV_mensaje := '';
                SV_error:='0';
                SV_proc := 'PV_RECUPERA_SS_ACT_PR';

                SV_tabla := 'GED_CODIGOS';
                SV_act   := 'S';
                SELECT COD_VALOR
                INTO LV_tip_servicio
                FROM GED_CODIGOS
                WHERE COD_MODULO = 'GA'
                AND   NOM_TABLA = 'GA_SERVSUPL'
                AND   NOM_COLUMNA = 'TIP_SERVICIO'
                AND   DES_VALOR  = 'NORMAL';

                SV_tabla := 'Cursor tSS_contratados';
                SV_act   := 'S';
                OPEN tSS_contratados FOR
                SELECT a.cod_servicio
                     , a.des_servicio
                         , a.cod_servsupl
                         , a.cod_nivel
                         --Inicio - Alejandro Hott - Soporte - 29-11-2004 - TM-200411151097
                         /*, c.imp_tarifa
                         , d.des_moneda
                         , b.cod_concepto */
                         --Fin - Alejandro Hott - Soporte - 29-11-2004 - TM-200411151097
                         , f.imp_tarifa
                         , g.des_moneda
                         , e.cod_concepto
                FROM GA_SERVSUPL a, GA_ACTUASERV b, GA_TARIFAS c
                   , GE_MONEDAS d, GA_ACTUASERV e, GA_TARIFAS f, GE_MONEDAS g, GA_SERVSUPLABO h
                WHERE a.cod_producto = 1
                AND a.cod_nivel =  h.cod_nivel
                AND a.cod_servicio = h.cod_servicio
                AND h.num_abonado  = EN_num_abonado
                AND h.ind_estado < 3
                AND a.ind_comerc = 1
                AND a.tip_servicio = LV_tip_servicio
                AND a.cod_producto = b.cod_producto(+)
                AND a.cod_servicio = b.cod_servicio(+)
                AND b.cod_actabo(+) = 'SS'
                AND b.cod_tipserv(+) = '2'
                AND b.cod_producto = c.cod_producto(+)
                AND b.cod_actabo = c.cod_actabo(+)
                AND b.cod_tipserv = c.cod_tipserv(+)
                AND b.cod_servicio = c.cod_servicio(+)
                AND c.cod_planserv(+) = EV_cod_planserv
                AND SYSDATE BETWEEN c.fec_desde(+) AND NVL(c.fec_hasta(+), SYSDATE)
                AND c.cod_moneda = d.cod_moneda(+)
                AND a.cod_producto = e.cod_producto(+)
                AND a.cod_servicio = e.cod_servicio(+)
                AND e.cod_actabo(+) = 'FA'
                AND e.cod_tipserv(+) = '2'
                AND e.cod_producto = f.cod_producto(+)
                AND e.cod_actabo = f.cod_actabo(+)
                AND e.cod_tipserv = f.cod_tipserv(+)
                AND e.cod_servicio = f.cod_servicio(+)
                AND f.cod_planserv(+) = EV_cod_planserv
                AND SYSDATE BETWEEN f.fec_desde(+) AND NVL(f.fec_hasta(+), SYSDATE)
                AND f.cod_moneda = g.cod_moneda(+)
                ORDER BY 2;

        EXCEPTION

                WHEN NO_DATA_FOUND THEN
                        SV_error := 3;
                        SV_sqlcode := SQLCODE;
                        SV_sqlerrm := SQLERRM;
                WHEN OTHERS THEN
                        SV_error := 4;
                        SV_sqlcode := SQLCODE;
                        SV_sqlerrm := SQLERRM;

END PV_RECUPERA_SS_ACT_PR;

---------------------------------------------------------------------

PROCEDURE PV_REC_PARAM_SS_DIS_PR(EN_cod_central   IN GA_ABOCEL.COD_CENTRAL%TYPE,
                                                           SN_cod_sistema          OUT ICG_CENTRAL.COD_SISTEMA%TYPE,
                                                           SV_error                OUT VARCHAR2,
                                                           SV_proc                 OUT VARCHAR2,
                                                           SV_tabla                OUT VARCHAR2,
                                                           SV_act                          OUT VARCHAR2,
                                                           SV_sqlcode              OUT VARCHAR2,
                                                           SV_sqlerrm              OUT VARCHAR2
)
/*
<DOC>
<NOMBRE>      PV_REC_PARAM_SS_DIS_PR                            </NOMBRE>
<FECHACREA>   12/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Obtiene parametros necesarios para recuperar       </DESCRIPCION>
<DESCRIPCION> SS Disponibles                                                 </DESCRIPCION>
<FECHAMOD>                                                               </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>   EN_cod_central: Codifo de Central                  </ParamEntr>
<ParamSal>    SN_cod_sistema: Codigo de Sistema                  </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                           </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                           </ParamSal>
</DOC>
*/
IS

        BEGIN

                SV_error:='0';
                SV_proc := 'PV_REC_PARAM_SS_DIS_PR';

                SV_tabla := 'ICG_CENTRAL';
                SELECT cod_sistema
                INTO   SN_cod_sistema
                FROM   ICG_CENTRAL
                WHERE  cod_producto = Pv_General_Ooss_Pg.CN_cod_producto
                AND    cod_central = EN_cod_central;



        EXCEPTION
                WHEN OTHERS THEN
                        SV_error := 4;
                        SV_sqlcode := SQLCODE;
                        SV_sqlerrm := SQLERRM;

END PV_REC_PARAM_SS_DIS_PR;


------------------------------------------------------------------------




----------------------------------------------------------------------

PROCEDURE PV_ESTADO_TRANSACCION_SS_PR(EN_num_celular      IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                                                   EN_num_ooss        IN PV_CAMCOM.NUM_OS%TYPE,
                                                                   EV_usuario             IN VARCHAR2,
                                                                   SV_mensaje             OUT VARCHAR2,
                                                                   SV_resp_estado     OUT VARCHAR2,
                                                                   SV_error               OUT VARCHAR2
)
/*
<DOC>
<NOMBRE>      PV_ESTADO_TRANSACCION_PR                          </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Recupera estado de OOSS                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>   EN_num_celular : Numero de Celular                         </ParamEntr>
<ParamEntr>   EN_num_ooss : Numero de OOSS a consultar                   </ParamEntr>
<ParamEntr>   EV_usuario : Usuario que solicita servicio                 </ParamEntr>
<ParamSal>    SV_mensaje : Mensaje de Salida                                     </ParamSal>
<ParamSal>    SV_resp_estado : Estado de OOSS a consultar        </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
</DOC>
*/
IS
    EN_num_abonado       GA_ABOCEL.NUM_ABONADO%TYPE;
        SN_cod_estado    PV_IORSERV.COD_ESTADO%TYPE;
        SV_des_estado    PV_ERECORRIDO.DESCRIPCION%TYPE;

        SV_proc                  VARCHAR2(50);
        SV_tabla                 VARCHAR2(50);
        SV_act                   VARCHAR2(2);
        SV_sqlcode               VARCHAR2(50);
        SV_sqlerrm               VARCHAR2(250);
        GV_implimcons    NUMBER(14,4);
        B_existe_celular BOOLEAN;
        B_valida_largo   BOOLEAN;
        B_valida_user    BOOLEAN;
        B_Ret                    BOOLEAN;

        ERROR_PROCESO    EXCEPTION;
        BEGIN

                SV_error:='0';
                SV_proc := 'PV_ESTADO_TRANSACCION_SS_PR';
                SV_act := 'S';
                SV_tabla := 'GA_SINIESTROS';

                B_valida_user := TRUE;
            IF NOT Pv_General_Ooss_Pg.PV_VALIDA_USUARIO_FN(EV_usuario,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm) THEN
                   B_valida_user := FALSE;
                   RAISE ERROR_PROCESO;
            END IF;

                IF NOT Pv_General_Ooss_Pg.PV_VAL_LARGO_CELULAR_FN(EN_num_celular, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
                    B_valida_largo := FALSE;
                    RAISE ERROR_PROCESO;
                END IF;

                B_existe_celular := TRUE;
                Pv_General_Ooss_Pg.PV_DATOS_ABONADO_PR (EN_num_celular,GV_implimcons,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
            IF SV_ERROR = 4 THEN
                    B_existe_celular := FALSE;
                    RAISE ERROR_PROCESO;
                ELSE
                        EN_num_abonado  := Pv_General_Ooss_Pg.VP_NUM_ABONADO;
                END IF;

            IF PV_VALIDA_OOSS_FN(EN_num_celular, EN_num_ooss, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
                   IF PV_RECUPERA_ESTADO_OOSS_FN(EN_num_ooss, SV_des_estado, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
                          SV_error:='0';
                   END IF;
                END IF;
                IF SV_error = 4 THEN
                    SV_mensaje := SV_sqlerrm;
                    SV_resp_estado := '';
                        RAISE ERROR_PROCESO;
                ELSE
                    SV_resp_estado := SV_des_estado;
                END IF;

        EXCEPTION
                WHEN ERROR_PROCESO THEN
                         IF NOT B_existe_celular THEN
                                -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                                --      SV_mensaje :=  'Celular no existe o Situación no es Válida';
                                        SV_mensaje :=  'Número Tel. Invalido/No Registrado';
                                -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                         END IF;
                         IF NOT B_valida_user THEN
                            -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                            --  SV_mensaje := 'Usuario no válido ';
                                SV_mensaje := 'Usuario No Válido ';
                            -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                         END IF;
                         IF NOT B_valida_largo THEN
                                -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                                --      SV_mensaje :=  'Celular No Cumple Con Largo Definido Por Operadora';
                                        SV_mensaje :=  'Número Tel. No Válido';
                                -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                         END IF;

                         IF EN_num_abonado = '' OR LTRIM(RTRIM(EN_num_abonado)) IS NULL THEN
                             EN_num_abonado := -1;
                         END IF;
                         B_Ret:= Pv_General_Ooss_Pg.PV_GA_ERRORES_FN(EN_num_abonado,CV_cod_actabo_ss,Pv_General_Ooss_Pg.CN_cod_producto,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm, SV_sqlcode,SV_sqlerrm);

                WHEN OTHERS THEN

                         SV_error := 4;
                         SV_sqlcode := SQLCODE;
                         SV_sqlerrm := SQLERRM;
                         IF EN_num_abonado = '' OR LTRIM(RTRIM(EN_num_abonado)) IS NULL THEN
                             EN_num_abonado := -1;
                         END IF;
                         B_Ret:= Pv_General_Ooss_Pg.PV_GA_ERRORES_FN(EN_num_abonado,CV_cod_actabo_ss,Pv_General_Ooss_Pg.CN_cod_producto,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm, SV_sqlcode,SV_sqlerrm);


END PV_ESTADO_TRANSACCION_SS_PR;

FUNCTION PV_VALIDA_OOSS_FN(EN_num_celular    IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                       EN_num_ooss       IN PV_CAMCOM.NUM_OS%TYPE,
                                                   SV_error                OUT VARCHAR2,
                                                   SV_proc                 OUT VARCHAR2,
                                                   SV_tabla                OUT VARCHAR2,
                                                   SV_act                          OUT VARCHAR2,
                                                   SV_sqlcode              OUT VARCHAR2,
                                                   SV_sqlerrm              OUT VARCHAR2
)RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_VALIDA_OOSS_FN                                          </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Valida OOSS                                                                                </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<<ParamEntr>   EN_num_celular : Numero de Celular                        </ParamEntr>
<ParamEntr>   EN_num_ooss : Numero de OOSS a validar                     </ParamEntr>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                           </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                           </ParamSal>
</DOC>
*/
IS
    VG_count1 NUMBER;
        VG_count2 NUMBER;
        VN_num_abonado NUMBER(8);
        VN_num_os          NUMBER(10);
        ERROR_PROCESO  EXCEPTION;
        BEGIN

                SV_error :='0';
                SV_proc  := 'PV_VALIDA_OOSS_FN';
                SV_act   := 'S';
                SV_tabla := 'GA_ABOCEL/GA_ABOAMIST';


                BEGIN
                        SELECT COUNT(1)
                        INTO VN_num_abonado
                        FROM GA_ABOAMIST
                        WHERE NUM_CELULAR = EN_num_celular
                        AND   COD_SITUACION IN ('AAA');
                        IF VN_num_abonado = 0 THEN
                                SELECT COUNT(1)
                                INTO VN_num_abonado
                                FROM GA_ABOCEL
                                WHERE NUM_CELULAR = EN_num_celular
                                AND   COD_SITUACION IN ('AAA');
                        END IF;

                        IF VN_num_abonado = 0 THEN
                            RETURN FALSE;
                        END IF;
                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                SV_sqlerrm := 'Celular Inexistente';
                                RETURN FALSE;
                END;


                BEGIN
                        SV_tabla := 'PV_CAMCOM/PVH_CAMCOM';

                        SELECT num_os
                        INTO VN_num_os
                        FROM PV_CAMCOM
                        WHERE NUM_OS = EN_num_ooss
                        AND   NUM_CELULAR = EN_num_celular
                        UNION
                        SELECT num_os
                        FROM PVH_CAMCOM
                        WHERE NUM_OS = EN_num_ooss
                        AND   NUM_CELULAR = EN_num_celular;
                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                 SV_error := 4;
                                 -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                                 -- SV_sqlerrm := 'Número de Solicitud no Existe ';
                                    SV_sqlerrm := 'No Existe Número de Orden de Servicio ';
                                 -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-

                                 RETURN FALSE;
                        WHEN OTHERS THEN
                                 SV_error := 4;
                                 SV_sqlcode := SQLCODE;
                                 SV_sqlerrm := SQLERRM;
                                 RETURN FALSE;
                END;

                RETURN TRUE; -- Existe ooss

        EXCEPTION
                WHEN OTHERS THEN
                         SV_error := 4;
                         SV_sqlcode := SQLCODE;
                         SV_sqlerrm := SQLERRM;
                         RETURN FALSE;
END PV_VALIDA_OOSS_FN;

FUNCTION PV_RECUPERA_ESTADO_OOSS_FN(EN_num_ooss  IN NUMBER,
                                                                        SV_estado_ooss     OUT VARCHAR2,
                                                                        SV_error                   OUT VARCHAR2,
                                                                        SV_proc                    OUT VARCHAR2,
                                                                        SV_tabla                   OUT VARCHAR2,
                                                                        SV_act                     OUT VARCHAR2,
                                                                        SV_sqlcode                 OUT VARCHAR2,
                                                                        SV_sqlerrm                 OUT VARCHAR2
)RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_RECUPERA_ESTADO_OOSS_FN                         </NOMBRE>
<FECHACREA>   13/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>     Recupera estado de OOSS                                                    </DESCMOD>
<ParamEntr>   EN_num_ooss ; Numero de OOSS a consultar           </ParamEntr>
<ParamSal>    SV_estado_ooss: Estado de OOSS                     </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS
        GN_cod_estado  PV_IORSERV.COD_ESTADO%TYPE;
        GN_tip_estado  PV_ERECORRIDO.TIP_ESTADO%TYPE;

        BEGIN
                SV_error:='0';
                SV_proc := 'PV_RECUPERA_ESTADO_OOSS_FN';

                SV_act := 'S';
                SV_tabla := 'PV_IORSERV/PV_ERECORRIDO';

                --Inicio - Alejandro Hott - Soporte - 29-11-2004 - TM-200411151097
                BEGIN
                        SELECT a.cod_estado,b.tip_estado
                                INTO   GN_cod_estado,GN_tip_estado
                                FROM   PV_IORSERV a, PV_ERECORRIDO b
                                WHERE  a.num_os = b.num_os
                                AND    a.cod_estado = b.cod_estado
                                --AND    (a.num_ospadre IS NOT NULL or a.num_os = a.num_ospadre)
                                AND    a.cod_modgener = 'ACF'
                                AND    a.cod_os       = CN_cod_ooss_SS
                                AND    a.num_os = EN_num_ooss;
                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                SELECT a.cod_estado,b.tip_estado
                                        INTO   GN_cod_estado,GN_tip_estado
                                        FROM   PVh_IORSERV a, PVh_ERECORRIDO b
                                        WHERE  a.num_os = b.num_os
                                        AND    a.cod_estado = b.cod_estado
                                        --AND    (a.num_ospadre IS NOT NULL or a.num_os = a.num_ospadre)
                                        AND    a.cod_modgener = 'ACF'
                                        AND    a.cod_os       = CN_cod_ooss_SS
                                        AND    a.num_os = EN_num_ooss;
                END;
                --Fin - Alejandro Hott - Soporte - 29-11-2004 - TM-200411151097

                IF GN_cod_estado = 10 THEN
                    -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
                    -- SV_estado_ooss := 'ORDEN DE SERVICIO PENDIENTE';
                       SV_estado_ooss := 'Servicio en proceso';
                    -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
                ELSE
                    IF GN_cod_estado >= 15 AND GN_cod_estado <= 950 THEN
                            IF GN_tip_estado = 4 THEN
                                   SV_estado_ooss := 'EN PROCESO / ERROR';
                            ELSE
                                       SV_estado_ooss := 'EN PROCESO';
                            END IF;
                        ELSE
                            IF GN_cod_estado >= 950 AND GN_cod_estado <= 999 THEN
                                   SV_estado_ooss := 'ORDEN DE SERVICIO FINALIZADA';
                                END IF;
                        END IF;
                END IF;
                RETURN TRUE;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                         SV_error := 4;
                         SV_sqlcode := SQLCODE;
                         SV_sqlerrm := 'NO SE LOGRO RECUPERAR ESTADO DE OOSS';
                         RETURN FALSE;
                WHEN OTHERS THEN
                         SV_error := 4;
                         SV_sqlcode := SQLCODE;
                         SV_sqlerrm := SQLERRM;
                         RETURN FALSE;
END PV_RECUPERA_ESTADO_OOSS_FN;

FUNCTION PV_PRE_REQUISITO_SS_FN (EN_COD_PRODUCTO         IN GA_ABOCEL.COD_PRODUCTO%TYPE,
                                                                 EN_COD_OS                       IN GA_SERVSUP_DEF.COD_SERVDEF%TYPE,
                                                                 EN_COD_CENTRAL          IN ICG_CENTRAL.COD_CENTRAL%TYPE,
                                                                 EV_TIP_TERMINAL         IN ICG_SERVICIOTERCEN.TIP_TERMINAL%TYPE,
                                                                 EV_TIP_TECNOLOGIA       IN ICG_SERVICIOTERCEN.TIP_TECNOLOGIA%TYPE,
                                                                 SV_DES_SS                       IN OUT SISCEL.GE_TABTYPE_VCH2ARRAY,
                                                                 SV_COD_SS                       IN OUT SISCEL.GE_TABTYPE_VCH2ARRAY,
                                                                 SN_TOTAL_SS            OUT NUMBER,
                                                                 SV_PROC            OUT VARCHAR2,
                                                         SV_TABLA           OUT VARCHAR2,
                                                         SV_ACT             OUT VARCHAR2,
                                                         SV_SQLCODE         OUT VARCHAR2,
                                                         SV_SQLERRM         OUT VARCHAR2,
                                                         SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_PRE_REQUISITO_SS_FN                                       </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Valida prerequisito de SS a desactivar                     </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>   EN_COD_PRODUCTO : Codigo de Producto                               </ParamEntr>
<ParamEntr>   EN_COD_OS : Codigo de OOSS                                                 </ParamEntr>
<ParamEntr>   EN_COD_CENTRAL : Codigo de Central                                 </ParamEntr>
<ParamEntr>   EV_TIP_TERMINAL : Tipo de Terminal                                 </ParamEntr>
<ParamEntr>   EV_TIP_TECNOLOGIA : Tipo de Tecnologia                     </ParamEntr>
<ParamEntr>   SV_DES_SS : Servicio Supl. a desactivar                    </ParamEntr>
<ParamEntr>   SV_COD_SS : Codigo de Serv. Supl.                                  </ParamEntr>
<ParamSal>    SN_TOTAL_SS                                                                                                </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>

</DOC>
*/
IS

  CURSOR cursor_serv IS
                SELECT   B.COD_SERVICIO, B.DES_SERVICIO
                  FROM   GA_SERVSUP_DEF A,  GA_SERVSUPL B,  ICG_SERVICIOTERCEN C
                 WHERE   A.COD_PRODUCTO  = EN_COD_PRODUCTO
                   AND   A.COD_SERVDEF   = EN_COD_OS
                   AND   SYSDATE BETWEEN A.FEC_DESDE AND  NVL(A.FEC_HASTA, SYSDATE)
                   AND   A.COD_SERVDEF   = B.COD_SERVICIO
                   AND   B.COD_PRODUCTO  = A.COD_PRODUCTO
                   AND   A.COD_PRODUCTO  = B.COD_PRODUCTO
                   AND   B.COD_PRODUCTO  = C.COD_PRODUCTO
                   AND   B.COD_SERVSUPL  = C.COD_SERVICIO
                   AND   C.COD_SISTEMA   = (SELECT COD_SISTEMA
                                                                    FROM   ICG_CENTRAL
                                                                    WHERE  COD_PRODUCTO = B.COD_PRODUCTO
                                                                    AND    COD_CENTRAL  = EN_COD_CENTRAL)
                   AND  C.TIP_TERMINAL   = EV_TIP_TERMINAL
                   AND  C.TIP_TECNOLOGIA = EV_TIP_TECNOLOGIA;


  vn_CodServicio          GA_SERVSUPL.COD_SERVICIO%TYPE;
  vn_DesServicio          GA_SERVSUPL.DES_SERVICIO%TYPE;
  vn_Ciclo                        NUMBER;
BEGIN

           SV_error   := '0';
           SV_proc        := 'PV_PRE_REQUISITO_SS_FN';
           SV_act         := 'S';
           SV_tabla   := '';


                vn_Ciclo := 1;
                OPEN cursor_serv;
                LOOP
                        FETCH cursor_serv INTO  vn_CodServicio,vn_DesServicio;
                        IF cursor_serv%FOUND THEN
                                SV_DES_SS(vn_Ciclo) := vn_DesServicio;
                                SV_COD_SS(vn_Ciclo) := vn_CodServicio;
                                vn_Ciclo := vn_Ciclo + 1;
                        ELSE
                                 EXIT;
                        END IF;
            END LOOP;

                SN_TOTAL_SS :=  vn_Ciclo - 1;

                RETURN TRUE;

           EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                         RETURN FALSE;
                                WHEN OTHERS THEN
                                         SV_ERROR := 4;
                                         SV_SQLCODE := SQLCODE;
                                         SV_SQLERRM := SQLERRM;
                                         RETURN FALSE;
END PV_PRE_REQUISITO_SS_FN;


FUNCTION PV_DES_SS_FN  (EV_COD_SERVICIO     IN GA_SERVSUPL.COD_SERVICIO%TYPE,
                                            EN_COD_PRODUCTO             IN GA_SERVSUPL.COD_PRODUCTO%TYPE,
                                                SV_ERROR           OUT VARCHAR2,
                                                SV_PROC            OUT VARCHAR2,
                                    SV_TABLA           OUT VARCHAR2,
                                        SV_ACT                 OUT VARCHAR2,
                                    SV_SQLCODE         OUT VARCHAR2,
                                    SV_SQLERRM         OUT VARCHAR2) RETURN GA_SERVSUPL.DES_SERVICIO%TYPE
/*
<DOC>
<NOMBRE>      PV_DES_SS_FN                         </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>    Retorna Descripcion del Servicio Supl.             </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>   EV_COD_SERVICIO : Codigo de Servicio                               </ParamEntr>
<ParamSal>    EN_COD_PRODUCTO : Codigo de Producto                               </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS
  vv_CodServicio   GA_SERVSUPL.DES_SERVICIO%TYPE;
BEGIN
           SV_error   := '0';
           SV_proc        := 'PV_DES_SS_FN';
           SV_act         := 'S';
           SV_tabla   := 'GA_SERVSUPL';

                SELECT DES_SERVICIO
                INTO   vv_CodServicio
                FROM   GA_SERVSUPL
                WHERE  COD_SERVICIO = EV_COD_SERVICIO
                  AND  COD_PRODUCTO = EN_COD_PRODUCTO;

                RETURN vv_CodServicio;

           EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;
                                         RETURN '';
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;
                                         RETURN '';


END PV_DES_SS_FN;

--INI COL-71848|10-11-2008|GEZ
FUNCTION PV_CADENASS_ACTDES_ABO_FN(EN_NumAbonado         IN                      ga_abocel.num_abonado%TYPE,
                                                               EV_AccionAct              IN                              VARCHAR2,
                                                                   EV_AccionDes          IN                              VARCHAR2,
                                                                   EV_FormatoDes         IN                              VARCHAR2,
                                                                   EV_Central            IN                              VARCHAR2,
                                                                   SVEstado                      OUT NOCOPY      VARCHAR2,
                                                                   SVProc                        OUT NOCOPY      VARCHAR2,
                                                                   SNCodMsg                      OUT NOCOPY      NUMBER,
                                                                   SNEvento                      OUT NOCOPY      NUMBER,
                                                                   SVTabla                       OUT NOCOPY      VARCHAR2,
                                                                   SVAct                         OUT NOCOPY      VARCHAR2,
                                                                   SVCode                        OUT NOCOPY      VARCHAR2,
                                                                   SVErrm                        OUT NOCOPY      VARCHAR2)RETURN VARCHAR2 IS

/*
<Documentación TipoDoc    = "Función">
        <Elemento Nombre      = "PV_CADENASS_ACTDES_FN"
                          Lenguaje    = "PL/SQL"
                          Fecha       = "10-11-2008"
                          Versión     = "1.0.0"
                          Diseñador   = "German Espinoza Zuñiga"
                          Programador = "German Espinoza Zuñiga" Ambiente="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>devuelve la cadena de Servicios suplementarios del abonado se la peticion en formato grupo-nivel</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_NumAbonado" Tipo="NUMBER"  >Numero del abonado a buscar servicios</param>
                                <param nom="EV_AccionAct"  Tipo="VARCHAR2">Tipo de servicios de alta a buscar
                                                                                                                   0: no concatena servicios a activar
                                                                                                                   1: solo los pendientes de activar en centrales
                                                                                                                   2: solo los activos en centrales
                                                                                                                   3: todos los servicios activos o en proceso
                                </param>
                                <param nom="EV_AccionDes"  Tipo="VARCHAR2">Tipo de servicios de baja a buscar
                                                                                                                   0: no concatena servicio de baja
                                                                                                                   1: solo los pendientes de desactivar en centrales
                                                                                                                   2: solo los de baja en centrales
                                                                                                                   3: todos los servicios de baja o en proceso
                                                                                                                   4: solo los de baja en proceso, pero si existe uno de alta en proceso no se muestra el servicios de baja,  se muestran con nivel 0
                                </param>
                                <param nom="EV_FormatoDes"  Tipo="VARCHAR2">formato de los servicios a desactivar
                                                                                                                   0: se envian en formato grupo nivel cero
                                                                                                                   1: se envian en formato grupo nivel correspondiente
                                </param>
                                <param nom="EV_Central"    Tipo="VARCHAR2">para todos los servicios a mostrar si se consideran los solo provisionables o no
                                                                                                                   0: considera los servicios no provisionales
                                                                                                                   1: considera solo los servicios provisionables
                                                                                                                   2: considera todos los servicios
                                </param>
                        </Entrada>
                        <Salida>
                                <param nom="SVEstado" Tipo="VARCHAR2">Estado de la ejecucion del procedimiento 3: OK-4:ERROR</param>
                                <param nom="SVProc"   Tipo="VARCHAR2">Nombre del procedo en donde ocurre un evento</param>
                                <param nom="SNCodMsg" Tipo="NUMBER">Codigo de Mensaje del evento ocurrido</param>
                                <param nom="SNEvento" Tipo="NUMBER">numero de evento</param>
                                <param nom="SVTabla"  Tipo="VARCHAR2">Nombre de la tabla en donde ocurrio el evento</param>
                                <param nom="SVAct"        Tipo="VARCHAR2">accion sobre la table en donde ocurre el evento</param>
                                <param nom="SVCode"   Tipo="VARCHAR2">codigo del error oracle</param>
                                <param nom="SVErrm"   Tipo="VARCHAR2">Descripcion del Error Oracle</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/

        LV_DesError                     VARCHAR2(1000);
        LV_Sql                          VARCHAR2(2000);
        LV_MensajeError         VARCHAR2(2000);

        LV_CadenaAct            VARCHAR2(2000);
        LV_CadenaDes            VARCHAR2(2000);

        CURSOR CadenaSSActTodos IS
        SELECT LPAD(a.cod_servsupl,2,'0')||LPAD(a.cod_nivel,4,'0') servact
        FROM   ga_servsuplabo a, ga_servsupl b
        WHERE  a.num_abonado=EN_NumAbonado
        AND    a.ind_estado<3
        AND    b.cod_servicio=a.cod_servicio
        AND    b.cod_producto=a.cod_producto
        AND        DECODE(EV_Central,'2',2,b.ind_central)=DECODE(EV_Central,'0',0,'1',1,'2',2)
        ORDER BY a.cod_servsupl;

        CURSOR CadenaSSActProc IS
        SELECT LPAD(a.cod_servsupl,2,'0')||LPAD(a.cod_nivel,4,'0') servact
        FROM   ga_servsuplabo a, ga_servsupl b
        WHERE  a.num_abonado=EN_NumAbonado
        AND    a.ind_estado=1
        AND    b.cod_servicio=a.cod_servicio
        AND    b.cod_producto=a.cod_producto
        AND        DECODE(EV_Central,'2',2,b.ind_central)=DECODE(EV_Central,'0',0,'1',1,'2',2)
        ORDER BY a.cod_servsupl;

        CURSOR CadenaSSActAct IS
        SELECT LPAD(a.cod_servsupl,2,'0')||LPAD(a.cod_nivel,4,'0') servact
        FROM   ga_servsuplabo a, ga_servsupl b
        WHERE  a.num_abonado=EN_NumAbonado
        AND    a.ind_estado=2
        AND    b.cod_servicio=a.cod_servicio
        AND    b.cod_producto=a.cod_producto
        AND        DECODE(EV_Central,'2',2,b.ind_central)=DECODE(EV_Central,'0',0,'1',1,'2',2)
        ORDER BY a.cod_servsupl;

        CURSOR CadenaSSDesTodos IS
        SELECT LPAD(a.cod_servsupl,2,'0')||LPAD(DECODE(EV_FormatoDes,'0',0,'1',a.cod_nivel),4,'0') servdes
        FROM   ga_servsuplabo a, ga_servsupl b
        WHERE  a.num_abonado=EN_NumAbonado
        AND    a.ind_estado IN (3,4)
        AND    b.cod_servicio=a.cod_servicio
        AND    b.cod_producto=a.cod_producto
        AND        DECODE(EV_Central,'2',2,b.ind_central)=DECODE(EV_Central,'0',0,'1',1,'2',2)
        ORDER BY a.cod_servsupl;

        CURSOR CadenaSSDesProc IS
        SELECT LPAD(a.cod_servsupl,2,'0')||LPAD(DECODE(EV_FormatoDes,'0',0,'1',a.cod_nivel),4,'0') servdes
        FROM   ga_servsuplabo a, ga_servsupl b
        WHERE  a.num_abonado=EN_NumAbonado
        AND    a.ind_estado =3
        AND    b.cod_servicio=a.cod_servicio
        AND    b.cod_producto=a.cod_producto
        AND        DECODE(EV_Central,'2',2,b.ind_central)=DECODE(EV_Central,'0',0,'1',1,'2',2)
        ORDER BY a.cod_servsupl;

        CURSOR CadenaSSDesDes IS
        SELECT LPAD(a.cod_servsupl,2,'0')||LPAD(DECODE(EV_FormatoDes,'0',0,'1',a.cod_nivel),4,'0') servdes
        FROM   ga_servsuplabo a, ga_servsupl b
        WHERE  a.num_abonado=EN_NumAbonado
        AND    a.ind_estado=4
        AND    b.cod_servicio=a.cod_servicio
        AND    b.cod_producto=a.cod_producto
        AND        DECODE(EV_Central,'2',2,b.ind_central)=DECODE(EV_Central,'0',0,'1',1,'2',2)
        ORDER BY a.cod_servsupl;

        CURSOR CadenaSSDesExcAct IS
        SELECT LPAD(a.cod_servsupl,2,'0')||'0000' servdes
        FROM   ga_servsuplabo a, ga_servsupl b
        WHERE  a.num_abonado=EN_NumAbonado
        AND    a.ind_estado = 3
        AND    b.cod_servicio=a.cod_servicio
        AND    b.cod_producto=a.cod_producto
        AND    NOT EXISTS (SELECT 1 FROM ga_servsuplabo
                                   WHERE num_abonado=a.num_abonado AND cod_servsupl=a.cod_servsupl AND ind_estado=1)
        AND        DECODE(EV_Central,'2',2,b.ind_central)=DECODE(EV_Central,'0',0,'1',1,'2',2)
        ORDER BY a.cod_servsupl;

BEGIN
        --Servicios activos
        LV_CadenaAct:=NULL;

        IF EV_AccionAct='0' THEN
           SVTabla              :='SINCURSOR';
           SVAct                :='C';

           LV_CadenaAct :=NULL;
        ELSIF EV_AccionAct='1' THEN
           SVTabla              :='CadenaSSActProc';
           SVAct                :='C';

           FOR reg IN CadenaSSActProc LOOP
                   LV_CadenaAct:=LV_CadenaAct||reg.servact;
           END LOOP;
        ELSIF EV_AccionAct='2' THEN
           SVTabla              :='CadenaSSActAct';
           SVAct                :='C';

           FOR reg IN CadenaSSActAct LOOP
                   LV_CadenaAct:=LV_CadenaAct||reg.servact;
           END LOOP;
        ELSIF EV_AccionAct='3' THEN

           SVTabla              :='CadenaSSActTodos';
           SVAct                :='C';

           FOR reg IN CadenaSSActTodos LOOP
                   LV_CadenaAct:=LV_CadenaAct||reg.servact;
           END LOOP;
        END IF;

        --Servicios desactivos
        LV_CadenaDes:=NULL;

        IF EV_AccionDes='0' THEN

           SVTabla              :='SINCURSOR';
           SVAct                :='C';

           LV_CadenaDes:=NULL;
        ELSIF EV_AccionDes='1' THEN

           SVTabla              :='CadenaSSDesProc';
           SVAct                :='C';

           FOR reg IN CadenaSSDesProc LOOP
                   LV_CadenaDes:=LV_CadenaDes||reg.servdes;
           END LOOP;
        ELSIF EV_AccionDes='2' THEN

           SVTabla              :='CadenaSSDesDes';
           SVAct                :='C';

           FOR reg IN CadenaSSDesDes LOOP
                   LV_CadenaDes:=LV_CadenaDes||reg.servdes;
           END LOOP;
        ELSIF EV_AccionDes='3' THEN

           SVTabla              :='CadenaSSDesTodos';
           SVAct                :='C';

           FOR reg IN CadenaSSDesTodos LOOP
                   LV_CadenaDes:=LV_CadenaDes||reg.servdes;
           END LOOP;
        ELSIF EV_AccionDes='4' THEN

           SVTabla              :='CadenaSSDesExcAct';
           SVAct                :='C';

           FOR reg IN CadenaSSDesExcAct LOOP
                   LV_CadenaDes:=LV_CadenaDes||reg.servdes;
           END LOOP;
        END IF;

        SVEstado        :='3';
        SVProc          :='PV_CADENASS_ACTDES_FN';
        SNCodMsg        :=0;
        SNEvento        :=0;
        SVCode          :='0';
        SVErrm          :='0';

        RETURN LV_CadenaDes||LV_CadenaAct;

EXCEPTION
        WHEN OTHERS THEN
                SVEstado        :='4';
                SVCode          :=SQLCODE;
                SVErrm          :=SQLERRM;

                SNCodMsg := 2117;

                IF NOT ge_errores_pg.mensajeerror(SNCodMsg, LV_MensajeError) THEN
                   LV_MensajeError := 'Error No Clasificado';
                END IF;

                LV_DesError := 'pv_cadenass_actdes_abo_fn('||EN_NumAbonado||','||EV_AccionAct||','||EV_AccionDes||','||EV_FormatoDes||','||EV_Central||')';
                LV_DesError :=LV_DesError ||'-T:'||SVTabla;
                LV_DesError :=LV_DesError ||'('||SVAct||')';
                LV_DesError :=LV_DesError ||'-'|| SVErrm;

                SNEvento :=
                ge_errores_pg.GRABARPL( SNEvento,
                                                                'PV',
                                                        LV_MensajeError,
                                                                '1.0',
                                                        USER,
                                                                'pv_cadenass_actdes_abo_fn',
                                                                LV_Sql,
                                                                SNCodMsg,
                                                                LV_DesError);

END;
--FIN COL-71848|10-11-2008|GEZ

-- INI COL|71848|04-12-2008|SAQL
PROCEDURE PV_CADENASS_ACTDES_ABO_PR(
   EN_NumAbonado  IN          ga_abocel.num_abonado%TYPE,
   EV_AccionAct   IN          VARCHAR2,
   EV_AccionDes   IN          VARCHAR2,
   EV_FormatoDes  IN          VARCHAR2,
   EV_Central     IN          VARCHAR2,
   SVCadena       OUT NOCOPY  VARCHAR2,
   SVEstado       OUT NOCOPY  VARCHAR2,
   SVProc         OUT NOCOPY  VARCHAR2,
   SNCodMsg       OUT NOCOPY  NUMBER,
   SNEvento       OUT NOCOPY  NUMBER,
   SVTabla        OUT NOCOPY  VARCHAR2,
   SVAct          OUT NOCOPY  VARCHAR2,
   SVCode         OUT NOCOPY  VARCHAR2,
   SVErrm         OUT NOCOPY  VARCHAR2
) IS
/*
   <Documentación TipoDoc = "PROCEDIMIENTO">
      <Elemento Nombre = "PV_CADENASS_ACTDES_ABO_PR"
         Lenguaje = "PL/SQL"
         Fecha = "04-12-2008"
         Versión = "1.0.0"
         Diseñador   = "Sebastian Quevedo L."
         Programador = "Sebastian Quevedo L."
         Ambiente="BD">
      <Retorno></Retorno>
      <Descripción>Procedimiento para ejecutar la funcion PV_CADENASS_ACTDES_ABO_FN</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_NumAbonado" Tipo="NUMBER"  >Numero del abonado a buscar servicios</param>
            <param nom="EV_AccionAct"  Tipo="VARCHAR2">Tipo de servicios de alta a buscar</param>
            <param nom="EV_AccionDes"  Tipo="VARCHAR2">Tipo de servicios de baja a buscar</param>
            <param nom="EV_FormatoDes"  Tipo="VARCHAR2">formato de los servicios a desactivar</param>
            <param nom="EV_Central"    Tipo="VARCHAR2">para todos los servicios a mostrar si se consideran los solo provisionables o no</param>
         </Entrada>
         <Salida>
            <param nom="SVCadena" Tipo="VARCHAR2">Cadena de salida</param>
                                <param nom="SVEstado" Tipo="VARCHAR2">Estado de la ejecucion del procedimiento 3: OK-4:ERROR</param>
                                <param nom="SVProc"   Tipo="VARCHAR2">Nombre del procedo en donde ocurre un evento</param>
                                <param nom="SNCodMsg" Tipo="NUMBER">Codigo de Mensaje del evento ocurrido</param>
                                <param nom="SNEvento" Tipo="NUMBER">numero de evento</param>
                                <param nom="SVTabla"  Tipo="VARCHAR2">Nombre de la tabla en donde ocurrio el evento</param>
                                <param nom="SVAct"        Tipo="VARCHAR2">accion sobre la table en donde ocurre el evento</param>
                                <param nom="SVCode"   Tipo="VARCHAR2">codigo del error oracle</param>
                                <param nom="SVErrm"   Tipo="VARCHAR2">Descripcion del Error Oracle</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/

        LV_DesError       VARCHAR2(1000);
        LV_Sql            VARCHAR2(2000);
        LV_MensajeError   VARCHAR2(2000);

BEGIN
   LV_Sql := 'PV_CADENASS_ACTDES_ABO_FN';
   SVCadena := PV_CADENASS_ACTDES_ABO_FN(EN_NumAbonado, EV_AccionAct, EV_AccionDes, EV_FormatoDes, EV_Central,
               SVEstado, SVProc, SNCodMsg, SNEvento, SVTabla, SVAct, SVCode, SVErrm);

EXCEPTION
   WHEN OTHERS THEN
      SVEstado := '4';
      SVCode := SQLCODE;
      SVErrm := SQLERRM;
      SNCodMsg := 2117;
      IF NOT ge_errores_pg.mensajeerror(SNCodMsg, LV_MensajeError) THEN
         LV_MensajeError := 'Error No Clasificado';
      END IF;
                LV_DesError := 'pv_cadenass_actdes_abo_fn('||EN_NumAbonado||','||EV_AccionAct||','||EV_AccionDes||','||EV_FormatoDes||','||EV_Central||')';
                LV_DesError :=LV_DesError ||'-T:'||SVTabla;
                LV_DesError :=LV_DesError ||'('||SVAct||')';
                LV_DesError :=LV_DesError ||'-'|| SVErrm;
                SNEvento :=  ge_errores_pg.GRABARPL(SNEvento, 'PV', LV_MensajeError, '2.4', USER,'PV_CADENASS_ACTDES_ABO_PR',LV_Sql,SNCodMsg,LV_DesError);
END PV_CADENASS_ACTDES_ABO_PR;
-- FIN COL|71848|04-12-2008|SAQL

END PV_SERVICIO_SUPLEMENTARIO_PG;
/
SHOW ERRORS
