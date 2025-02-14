CREATE OR REPLACE PACKAGE BODY VE_estado_proceso_PG AS

    PROCEDURE VE_recuperaprogreso_PR(EV_cod_proceso       IN ve_estadoproceso_to.cod_proceso%TYPE,
                                     SN_num_progactual    OUT NOCOPY ve_estadoproceso_to.num_progresoactual%TYPE,
                                     SN_num_subprocactual OUT NOCOPY ve_estadoproceso_to.num_subprocactual%TYPE,
                                     SN_num_totalsubproc  OUT NOCOPY ve_estadoproceso_to.num_totalsubproc%TYPE,
                                     SN_cod_error         OUT NOCOPY ve_estadoproceso_to.cod_error%TYPE,
                                     SV_des_error         OUT NOCOPY ve_estadoproceso_to.des_error%TYPE,
                                                                 SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)


    IS
                /*
                <Documentación
                  TipoDoc = "Procedimiento">
                   <Elemento
                      Nombre = "VE_recuperaprogreso_PR"
                      Lenguaje="PL/SQL"
                      Fecha creación="08-01-2007"
                      Creado por="HHB"
                      Fecha modificacion=""
                      Modificado por=""
                      Ambiente Desarrollo="BD">
                      <Retorno>Consulta valores de progreso</Retorno>
                      <Descripción>Consulta valores de progreso</Descripción>
                      <Parámetros>
                         <Entrada>
                                   <param nom="ev_cod_proceso" Tipo="VARCHAR2">Codigo del proceso</param>
                                 </Entrada>
                         <Salida>
                                   <param nom="Sn_num_progactual" Tipo="NUMBER">numero de programa actual</param>
                                   <param nom="Sn_num_subprocactual" Tipo="NUMBER">numero de subprograma actual</param>
                                   <param nom="Sn_num_totalsubproc" Tipo="NUMBER">total subproceso</param>
                                   <param nom="Sn_cod_error" Tipo="NUMBER">codigo de error para registrar</param>
                                   <param nom="Sv_des_error" Tipo="VARCHAR2">descripcion de error para registrar</param>
                                   <param nom="SN_cod_retorno" Tipo="NUMBER">codigo de retorno del procedimiento</param>
                           <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
                           <param nom="SN_num_evento" Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
                                 </Salida>
                      </Parámetros>
                   </Elemento>
                </Documentación>
                */
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
    BEGIN

                    sn_cod_retorno      := 0;
                    sv_mens_retorno := NULL;
                    sn_num_evento       := 0;
            LV_Sql:= 'SELECT progreso.num_progresoactual, progreso.num_subprocactual,progreso.num_totalsubproc, '
                     || 'progreso.cod_error, progreso.des_error '
                     || 'FROM   ve_estadoproceso_to progreso '
                     || 'WHERE  progreso.cod_proceso = ' || EV_cod_proceso;


                    SELECT progreso.num_progresoactual, progreso.num_subprocactual,progreso.num_totalsubproc,
                   progreso.cod_error, progreso.des_error
                INTO   SN_num_progactual, SN_num_subprocactual, SN_num_totalsubproc,
                   SN_cod_error, SV_des_error
                        FROM   ve_estadoproceso_to progreso
                        WHERE  progreso.cod_proceso = EV_cod_proceso;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    SN_cod_retorno := 778;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                    END IF;
                    LV_des_error := 'NO_DATA_FOUND:VE_estado_proceso_PG.VE_recuperaprogreso_PR;- ' || SQLERRM;
                    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                    'VE_estado_proceso_PG.VE_recuperaprogreso_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                    SN_cod_retorno := 156;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error := 'OTHERS:VE_estado_proceso_PG.VE_recuperaprogreso_PR;- ' || SQLERRM;
                    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                    'VE_estado_proceso_PG.VE_recuperaprogreso_PR', LV_Sql, SQLCODE, LV_des_error );


    END VE_recuperaprogreso_PR;

    PROCEDURE VE_insertaproceso_PR(EV_cod_proceso       IN ve_estadoproceso_to.cod_proceso%TYPE,
                                   EN_num_progactual    IN ve_estadoproceso_to.num_progresoactual%TYPE,
                                   EN_num_subprocactual IN ve_estadoproceso_to.num_subprocactual%TYPE,
                                   EN_num_totalsubproc  IN ve_estadoproceso_to.num_totalsubproc%TYPE,
                                                               SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)


                /*
                <Documentación
                  TipoDoc = "Procedimiento">
                   <Elemento
                      Nombre = "VE_insertaproceso_PR"
                      Lenguaje="PL/SQL"
                      Fecha creación="11-04-2007"
                      Creado por="HHB"
                      Fecha modificacion=""
                      Modificado por=""
                      Ambiente Desarrollo="BD">
                      <Retorno>Inserta valores proceso</Retorno>
                      <Descripción>Inserta valores proceso</Descripción>
                      <Parámetros>
                         <Entrada>
                                   <param nom="ev_cod_proceso" Tipo="VARCHAR2">Codigo del proceso</param>
                                   <param nom="en_num_progactual" Tipo="NUMBER">numero de programa actual</param>
                                   <param nom="en_num_subprocactual" Tipo="NUMBER">numero de subprograma actual</param>
                                   <param nom="en_num_totalsubproc" Tipo="NUMBER">total subproceso</param>
                                 </Entrada>
                         <Salida>
                                   <param nom="SN_cod_retorno" Tipo="NUMBER">codigo de retorno del procedimiento</param>
                           <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
                           <param nom="SN_num_evento" Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
                                 </Salida>
                      </Parámetros>
                   </Elemento>
                </Documentación>
                */
        IS
            PRAGMA AUTONOMOUS_TRANSACTION;
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
    BEGIN
                sn_cod_retorno  := 0;
                sv_mens_retorno := NULL;
                sn_num_evento   := 0;

        LV_Sql:= 'INSERT INTO ve_estadoproceso_to ('
                 || 'cod_proceso, num_progresoactual, num_subprocactual,'
                 || 'num_totalsubproc, cod_error, des_error)'
                 || 'VALUES ( ' || EV_cod_proceso ||', ' || EN_num_progactual ||', '
                 || EN_num_subprocactual || ', ' || EN_num_totalsubproc || ', NULL, NULL)';


       INSERT INTO ve_estadoproceso_to
                  ( cod_proceso, num_progresoactual, num_subprocactual,
                num_totalsubproc, cod_error, des_error)
       VALUES ( EV_cod_proceso, EN_num_progactual, EN_num_subprocactual,
                        EN_num_totalsubproc, NULL, NULL);
       COMMIT;

       EXCEPTION
            WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_estado_proceso_PG.VE_insertaproceso_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_estado_proceso_PG.VE_insertaproceso_PR', LV_Sql, SQLCODE, LV_des_error );
    END VE_insertaproceso_PR;

    PROCEDURE VE_modificaproceso_PR(EV_cod_proceso       IN ve_estadoproceso_to.cod_proceso%TYPE,
                                    EN_num_progactual    IN ve_estadoproceso_to.num_progresoactual%TYPE,
                                    EN_num_subprocactual IN ve_estadoproceso_to.num_subprocactual%TYPE,
                                    EN_num_totalsubproc  IN ve_estadoproceso_to.num_totalsubproc%TYPE,
                                    EN_cod_error         IN ve_estadoproceso_to.cod_error%TYPE,
                                    EV_des_error         IN ve_estadoproceso_to.des_error%TYPE,
                                    SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)
    IS
                /*
                <Documentación
                  TipoDoc = "Procedimiento">
                   <Elemento
                      Nombre = "VE_modificaproceso_PR"
                      Lenguaje="PL/SQL"
                      Fecha creación="11-04-2007"
                      Creado por="HHB"
                      Fecha modificacion=""
                      Modificado por=""
                      Ambiente Desarrollo="BD">
                      <Retorno>Modifica valores proceso</Retorno>
                      <Descripción>Modifica valores proceso</Descripción>
                      <Parámetros>
                         <Entrada>
                                   <param nom="ev_cod_proceso" Tipo="VARCHAR2">Codigo del proceso</param>
                                   <param nom="en_num_progactual" Tipo="NUMBER">numero de programa actual</param>
                                   <param nom="en_num_subprocactual" Tipo="NUMBER">numero de subprograma actual</param>
                                   <param nom="en_num_totalsubproc" Tipo="NUMBER">total subproceso</param>
                                   <param nom="en_cod_error" Tipo="NUMBER">codigo de error para registrar</param>
                                   <param nom="ev_des_error" Tipo="VARCHAR2">descripcion de error para registrar</param>
                                 </Entrada>
                         <Salida>
                                   <param nom="SN_cod_retorno" Tipo="NUMBER">codigo de retorno del procedimiento</param>
                           <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
                           <param nom="SN_num_evento" Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
                                 </Salida>
                      </Parámetros>
                   </Elemento>
                </Documentación>
                */
        PRAGMA AUTONOMOUS_TRANSACTION;
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
    BEGIN
                sn_cod_retorno  := 0;
                sv_mens_retorno := NULL;
                sn_num_evento   := 0;

        LV_Sql:= 'UPDATE ve_estadoproceso_to'
                || ' SET num_progresoactual = ' || EN_num_progactual
                || ' ,num_subprocactual = ' || EN_num_subprocactual
                || ' ,num_totalsubproc = ' || EN_num_totalsubproc
                || ' ,cod_error = ' || EN_cod_error
                || ' ,des_error = ' || EV_des_error
                || ' WHERE cod_proceso = ' || EV_cod_proceso;

       UPDATE ve_estadoproceso_to
           SET    num_progresoactual = EN_num_progactual,
                  num_subprocactual = EN_num_subprocactual,
                          num_totalsubproc = EN_num_totalsubproc,
                          cod_error = EN_cod_error,
                          des_error = EV_des_error
       WHERE  cod_proceso = EV_cod_proceso;
       COMMIT;

       EXCEPTION
            WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'OTHERS:VE_estado_proceso_PG.VE_modificaproceso_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_estado_proceso_PG.VE_modificaproceso_PR', LV_Sql, SQLCODE, LV_des_error );
    END VE_modificaproceso_PR;

    PROCEDURE VE_EliminaProceso_PR(EV_cod_proceso       IN  ve_estadoproceso_to.cod_proceso%TYPE,
                                       SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación
          TipoDoc = "Procedimiento">
           <Elemento
              Nombre = "VE_EliminaProceso_PR"
              Lenguaje="PL/SQL"
              Fecha creación="20-06-2007"
              Creado por="wjrc"
              Ambiente Desarrollo="BD">
              <Retorno> N/A </Retorno>
              <Descripción>
                                           Limipa tabla estado de proceso
                  </Descripción>
              <Parámetros>
                 <Entrada>
                         <param nom="EV_cod_proceso"  Tipo="STRING">codigo proceso</param>
                         </Entrada>
                 <Salida>
                           <param nom="SN_cod_retorno"  Tipo="NUMBER">codigo de retorno del procedimiento</param>
                   <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
                   <param nom="SN_num_evento"   Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
                         </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
    BEGIN
                sn_cod_retorno  := 0;
                sv_mens_retorno := NULL;
                sn_num_evento   := 0;

        LV_Sql:= 'DELETE ve_estadoproceso_to WHERE cod_proceso = ''' || EV_cod_proceso || '''';

        DELETE ve_estadoproceso_to WHERE cod_proceso = EV_cod_proceso;

                EXCEPTION
            WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_estado_proceso_PG.VE_EliminaProceso_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_estado_proceso_PG.VE_EliminaProceso_PR', LV_Sql, SQLCODE, LV_des_error );
    END VE_EliminaProceso_PR;


END VE_estado_proceso_PG;


/
SHOW ERRORS
