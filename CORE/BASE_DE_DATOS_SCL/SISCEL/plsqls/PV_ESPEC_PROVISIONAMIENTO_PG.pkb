CREATE OR REPLACE PACKAGE BODY PV_ESPEC_PROVISIONAMIENTO_PG AS

--PV_ESPEC_PROVISIONAMIENTO_PG v1.0 //CREACION PROYECTO CPU
--PV_ESPEC_PROVISIONAMIENTO_PG v1.1 //COL-72899|17-12-2008|GEZ
--PV_ESPEC_PROVISIONAMIENTO_PG v1.2 //COL-72899|23-12-2008|SAQL-EV-PMY
--PV_ESPEC_PROVISIONAMIENTO_PG v1.3 //COL-77303|05-03-2009|RRG

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_BODEGAS_PR(EO_Param_Venta  IN                         GA_VENTA_QT,
                                                                                              SO_Lista_Bodegas  OUT NOCOPY       refCursor,
                                                                                                                  SN_cod_retorno        OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                                                                                                  SV_mens_retorno   OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                                                                                                  SN_num_evento    OUT NOCOPY   ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_BODEGAS_PR "
              Lenguaje="PL/SQL"
              Fecha="13-06-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Alejandro Díaz"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_Param_Venta " Tipo="estructura">estructura de Type  </param>>
                 </Entrada>
                 <Salida>
                    <param nom="SO_Lista_Bodegas" Tipo="Cursor">Listado Bodegas</param>>
                                 <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error                                    ge_errores_pg.DesEvent;
                LV_sSql                                                 ge_errores_pg.vQuery;

        BEGIN
                sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;

                    LV_sSql:='SELECT  A.COD_BODEGA, B.DES_BODEGA';
                        LV_sSql:=LV_sSql||' FROM VE_VENDALMAC A,AL_BODEGAS B,AL_BODEGANODO C, GE_OPERADORA_SCL D';
                        LV_sSql:=LV_sSql||'     WHERE A.COD_VENDEDOR =' || EO_Param_Venta.COD_VENDEDOR;
                        LV_sSql:=LV_sSql||'     AND   SYSDATE BETWEEN A.FEC_ASIGNACION AND NVL(A.FEC_DESASIGNAC,SYSDATE)';
                        LV_sSql:=LV_sSql||'     AND   A.COD_BODEGA = B.COD_BODEGA';
                        LV_sSql:=LV_sSql||'     AND   B.COD_BODEGA = C.COD_BODEGA';
                        LV_sSql:=LV_sSql||'     AND   C.COD_BODEGANODO = D.COD_BODEGANODO';
                        LV_sSql:=LV_sSql||'     AND   D.COD_OPERADORA_SCL =' || EO_Param_Venta.COD_OPERADORA;
                        LV_sSql:=LV_sSql||'      ORDER BY B.DES_BODEGA';


                OPEN SO_Lista_Bodegas FOR

                SELECT  A.COD_BODEGA, B.DES_BODEGA
        FROM VE_VENDALMAC A,AL_BODEGAS B,AL_BODEGANODO C, GE_OPERADORA_SCL D
        WHERE A.COD_VENDEDOR = EO_Param_Venta.COD_VENDEDOR
            AND   SYSDATE BETWEEN A.FEC_ASIGNACION AND NVL(A.FEC_DESASIGNAC,SYSDATE)
            AND   A.COD_BODEGA = B.COD_BODEGA
                AND   B.COD_BODEGA = C.COD_BODEGA
                AND   C.COD_BODEGANODO = D.COD_BODEGANODO
                AND   D.COD_OPERADORA_SCL IN (SELECT GE_FN_OPERADORA_SCL  FROM DUAL)
                ORDER BY B.DES_BODEGA;


        EXCEPTION
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_BODEGAS_PR('||EO_Param_Venta.COD_VENDEDOR||','||EO_Param_Venta.COD_OPERADORA||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_BODEGAS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_OBTIENE_BODEGAS_PR;
------------------------------------------------------------------------------------------------------
        PROCEDURE PV_VALIDA_GESTOR_CORP_PR(EO_GESTOR_BCORP                              IN                         PV_GESTOR_BCORP_QT,
                                                                           SV_genera_comand_out                 OUT NOCOPY     VARCHAR2,
                                                                           SV_abonado_gestor_out                OUT NOCOPY     VARCHAR2,
                                                                           SV_abonado_gestor_def_out    OUT NOCOPY     VARCHAR2,
                                                                       SN_cod_retorno                           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                                                       SV_mens_retorno                          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                                                       SN_num_evento                            OUT NOCOPY         ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_VALIDA_GESTOR_CORP_PR "
              Lenguaje="PL/SQL"
              Fecha="13-06-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_GESTOR_BCORP " Tipo="estructura">estructura de Type  </param>>
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
                LV_des_error                                    ge_errores_pg.DesEvent;
                LV_sSql                                                 ge_errores_pg.vQuery;
                ERROR_EJECUCION                         EXCEPTION;

                LV_cod_valor_out                                VARCHAR2(02);
                LV_ErrorAplic_out                       VARCHAR2(06);
                LV_Trace_out                                    VARCHAR2(01);
        BEGIN
                sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;

                LV_sSql:='';
                LV_sSql:=LV_sSql||'PV_GESTOR_CORP_PG.PV_BCORPORATIVO('||EO_GESTOR_BCORP.N_NUM_ABONADO||', ';
                LV_sSql:=LV_sSql||''||EO_GESTOR_BCORP.V_COD_ACTABO_GESTOR||', ';
                LV_sSql:=LV_sSql||''||EO_GESTOR_BCORP.V_NOM_USUARORA||', ';
                LV_sSql:=LV_sSql||''||EO_GESTOR_BCORP.V_COD_PLANTARIF_ACTUA||', ';
                LV_sSql:=LV_sSql||''||EO_GESTOR_BCORP.V_COD_PLANTARIF_NUEVO||', ';
                LV_sSql:=LV_sSql||''||EO_GESTOR_BCORP.V_TIP_MOVIMIENTO||', ';
                LV_sSql:=LV_sSql||''||EO_GESTOR_BCORP.V_COD_ACTABO_OOSS||', ';
                LV_sSql:=LV_sSql||''||EO_GESTOR_BCORP.V_ABONADO_GESTOR||', ';
                LV_sSql:=LV_sSql||''||EO_GESTOR_BCORP.V_ABONADO_GESTOR_DEF||', ';
                LV_sSql:=LV_sSql||''||EO_GESTOR_BCORP.N_SEQ_TRANS_ACABO||', ';
                LV_sSql:=LV_sSql||''||SV_genera_comand_out||', ';
                LV_sSql:=LV_sSql||''||SV_abonado_gestor_out||', ';
                LV_sSql:=LV_sSql||''||SV_abonado_gestor_def_out||', ';
                LV_sSql:=LV_sSql||''||LV_cod_valor_out||', ';
                LV_sSql:=LV_sSql||''||LV_ErrorAplic_out||', ';
                LV_sSql:=LV_sSql||''||LV_des_error||', ';
                LV_sSql:=LV_sSql||''||SN_cod_retorno||', ';
                LV_sSql:=LV_sSql||''||SV_mens_retorno||', ';
                LV_sSql:=LV_sSql||''||LV_Trace_out||'); ';

                PV_GESTOR_CORP_PG.PV_BCORPORATIVO(EO_GESTOR_BCORP.N_NUM_ABONADO,
                                                                                  EO_GESTOR_BCORP.V_COD_ACTABO_GESTOR,
                                                                                  EO_GESTOR_BCORP.V_NOM_USUARORA,
                                                                                  EO_GESTOR_BCORP.V_COD_PLANTARIF_ACTUA,
                                                                                  EO_GESTOR_BCORP.V_COD_PLANTARIF_NUEVO,
                                                                                  EO_GESTOR_BCORP.V_TIP_MOVIMIENTO,
                                                                                  EO_GESTOR_BCORP.V_COD_ACTABO_OOSS,
                                                                                  EO_GESTOR_BCORP.V_ABONADO_GESTOR,
                                                                                  EO_GESTOR_BCORP.V_ABONADO_GESTOR_DEF,
                                                                                  EO_GESTOR_BCORP.N_SEQ_TRANS_ACABO,
                                                                                  SV_genera_comand_out,
                                                                                  SV_abonado_gestor_out,
                                                                                  SV_abonado_gestor_def_out,
                                                                                  LV_cod_valor_out,
                                                                                  LV_ErrorAplic_out,
                                                                                  LV_des_error,
                                                                                  SN_cod_retorno,
                                                                                  SV_mens_retorno,
                                                                                  LV_Trace_out);
                IF SN_cod_retorno>0 THEN
                                        RAISE ERROR_EJECUCION;
                END IF;

        EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_VALIDA_GESTOR_CORP_PR('||EO_GESTOR_BCORP.N_NUM_ABONADO||','||EO_GESTOR_BCORP.V_COD_ACTABO_GESTOR||'); '||LV_ErrorAplic_out||' '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_VALIDA_GESTOR_CORP_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_VALIDA_GESTOR_CORP_PR('||EO_GESTOR_BCORP.N_NUM_ABONADO||','||EO_GESTOR_BCORP.V_COD_ACTABO_GESTOR||'); '||LV_ErrorAplic_out||' '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_VALIDA_GESTOR_CORP_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_VALIDA_GESTOR_CORP_PR;

------------------------------------------------------------------------------------------------------
FUNCTION PV_ValNroCELULAR_FN (LV_NUM_CELULAR              IN               ga_abocel.num_celular%TYPE,
                                                          SV_AL_FN_PREFIJO_NUMERO OUT NOCOPY   ged_parametros.val_parametro%TYPE,
                                                          SN_cod_retorno          OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                  SV_mens_retorno         OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                  SN_num_evento           OUT NOCOPY   ge_errores_pg.evento)
        RETURN BOOLEAN
        IS
        /*
        <Documentacion TipoDoc = "Funcion">
        <Elemento Nombre = " PV_Valida_NroCELULAR_FN  "
         Lenguaje="PL/SQL" Fecha="18-07-2007"
         Versión"1.0.0" Diseñador"****"
         Programador="" Ambiente="BD ORACLE">
        <Retorno>NA</Retorno>
        <Descripcion>   FUNCION BOOLEAN PV_Valida_NroCELULAR_FN    </Descripcion>
        <Parametros>
        <Entrada>
                        <param NUM_CELULAR =" codigo Actabo              " Tipo = "ga_abocel.num_celular%type"  </param>>
        </Entrada>
        <Salida>
           <param SN_cod_retorno     ="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno         </param>>
           <param SV_mens_retorno    ="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno       </param>>
           <param SN_num_evento      ="SN_num_evento" Tipo="NUMERICO">Numero de Evento           </param>>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        */
        LV_des_error                            ge_errores_pg.DesEvent;
        LV_sSql                                         ge_errores_pg.vQuery;
        ERROR_GENERICO                          EXCEPTION;

        BEGIN
                sn_cod_retorno   := 0;
            sv_mens_retorno  := NULL;
            sn_num_evento        := 0;

                        IF LV_NUM_CELULAR IS NULL THEN
                           SN_cod_retorno:= 303;
                           RAISE ERROR_GENERICO;
                        ELSE

                                LV_sSql:= '     SELECT AL_FN_PREFIJO_NUMERO('||LV_NUM_CELULAR||')';
                                LV_sSql:= LV_sSql || '  FROM DUAL';

                                SELECT AL_FN_PREFIJO_NUMERO(LV_NUM_CELULAR)
                                 INTO   SV_AL_FN_PREFIJO_NUMERO
                                 FROM DUAL;

                                RETURN TRUE;
                        END IF;

    EXCEPTION
        WHEN ERROR_GENERICO THEN
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_ValNroCELULAR_FN('||'SELECT AL_FN_PREFIJO_NUMERO('||LV_NUM_CELULAR||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_ValNroCELULAR_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 1367;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_ValNroCELULAR_FN(('||'SELECT AL_FN_PREFIJO_NUMERO('||LV_NUM_CELULAR||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_ValNroCELULAR_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
    WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_ValNroCELULAR_FN(('||'SELECT AL_FN_PREFIJO_NUMERO('||LV_NUM_CELULAR||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_ValNroCELULAR_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;

END  PV_ValNroCELULAR_FN;

------------------------------------------------------------------------------------------------------
FUNCTION PV_OBTIENE_COD_ACTABO_FN (EO_ACTABO_TIPLAN     IN OUT NOCOPY   PV_ACTABO_TIPLAN_QT,
                                                       SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                       SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                       SN_num_evento       OUT NOCOPY   ge_errores_pg.evento)
        RETURN BOOLEAN
        AS
        /*
        <Documentacion TipoDoc = "Funcion">
        <Elemento Nombre = " PV_OBTIENE_COD_ACTABO_FN "
         Lenguaje="PL/SQL" Fecha="18-07-2007"
         Versión"1.0.0" Diseñador"****"
         Programador="" Ambiente="BD ORACLE">
        <Retorno>NA</Retorno>
        <Descripcion>   FUNCION BOOLEAN PV_OBTIENE_COD_ACTABO_FN   </Descripcion>
        <Parametros>
        <Entrada>
                        <param EO_ACTABO_TIPLAN.COD_ACTABO  =" codigo Actabo              " Tipo = "VARCHAR(02)" </param>>
                        <param EO_ACTABO_TIPLAN.COD_TIPLAN  =" Codigo Tipo Plantarifario " Tipo = "VARCHAR(02)" </param>>
        </Entrada>
        <Salida>
           <param SN_cod_retorno     ="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno         </param>>
           <param SV_mens_retorno    ="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno       </param>>
           <param SN_num_evento      ="SN_num_evento" Tipo="NUMERICO">Numero de Evento           </param>>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        */
        LV_des_error                    ge_errores_pg.DesEvent;
        LV_sSql                                 ge_errores_pg.vQuery;

        BEGIN
                sn_cod_retorno   := 0;
            sv_mens_retorno  := NULL;
            sn_num_evento        := 0;

                BEGIN
                    LV_sSql:= 'SELECT COD_ACTABO ';
                        LV_sSql:= LV_sSql || ' FROM PV_ACTABO_TIPLAN';
                        LV_sSql:= LV_sSql || ' WHERE  COD_TIPMODI = '||EO_ACTABO_TIPLAN.COD_TIPMODI;
                        LV_sSql:= LV_sSql || '    AND COD_TIPLAN  = '||EO_ACTABO_TIPLAN.COD_TIPLAN;

                        SELECT COD_ACTABO
                         INTO EO_ACTABO_TIPLAN.COD_ACTABO
                          FROM PV_ACTABO_TIPLAN
                          WHERE    COD_TIPMODI = EO_ACTABO_TIPLAN.COD_TIPMODI
                              AND  COD_TIPLAN  = EO_ACTABO_TIPLAN.COD_TIPLAN;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                            EO_ACTABO_TIPLAN.COD_ACTABO:= EO_ACTABO_TIPLAN.COD_TIPMODI;
                                RETURN TRUE;
                END;

                IF EO_ACTABO_TIPLAN.COD_ACTABO IS NOT NULL  THEN
                                RETURN TRUE;
                ELSE
                                EO_ACTABO_TIPLAN.COD_ACTABO:= EO_ACTABO_TIPLAN.COD_TIPMODI;
                                RETURN TRUE;
                END IF;

    EXCEPTION
    WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_COD_ACTABO_FN('||EO_ACTABO_TIPLAN.COD_TIPMODI||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_COD_ACTABO_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;

END  PV_OBTIENE_COD_ACTABO_FN;

------------------------------------------------------------------------------------------------------
        PROCEDURE PV_APROVISIONAR_CENTRAL_PR(EO_APROVISIONAR     IN                             GA_APROVISIONAR_QT,
                                                                             SN_cod_retorno      OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                                                             SV_mens_retorno     OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                                                             SN_num_evento       OUT NOCOPY             ge_errores_pg.evento)
        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_APROVISIONAR_CENTRAL_PR"
              Lenguaje="PL/SQL"
              Fecha="13-06-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_APROVISIONAR IN      GA_APROVISIONAR_QT" Tipo="estructura">estructura de los datos de un abonado</param>>
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
                LV_des_error                             ge_errores_pg.DesEvent;
                LV_sSql                                          ge_errores_pg.vQuery;
                LV_NUM_CELULAR                                   ga_abocel.num_celular%TYPE;
                LV_AL_FN_PREFIJO_NUMERO                  ged_parametros.val_parametro%TYPE;
                LV_gsm                                           ged_parametros.val_parametro%TYPE;
                LV_ObtCODGRUPO_AL_TECNOLOGIA     ged_parametros.val_parametro%TYPE;
                LV_sImsi                                                 VARCHAR2(50);

                ERROR_EJECUCION                                  EXCEPTION;
                ERROR_GENERICO                                   EXCEPTION;
                EO_SECUENCIA                             PV_SECUENCIA_QT;
                EO_GED_PARAMETROS                                PV_GED_PARAMETROS_QT;


                LV_NUMSECUENCIA         NUMBER(09);
                LV_NUMABONADO           GA_ABOCEL.NUM_ABONADO%TYPE;
                LV_CODESTADO            VARCHAR2(03);
                LV_CODACTABO            GA_ACTABO.COD_ACTABO%TYPE;
                LV_CODMODULO            VARCHAR2(02);
                LV_USUARIO                      VARCHAR2(30);
                LV_FECINGRE                     DATE;
                LV_TIPTERMINAL          VARCHAR2(01);
                LV_CODCENTRAL           GA_ABOCEL.COD_CENTRAL%TYPE;
                LV_INDBLOQUEO           NUMBER(1);
                LV_TIPTERMINAL_NUE      VARCHAR2(01);
                LV_NUMCELULAR           GA_ABOCEL.NUM_CELULAR%TYPE;
                LV_NUMSERIE                     GA_ABOCEL.NUM_SERIE%TYPE;
                LV_NUMCELULAR_NUE       GA_ABOCEL.NUM_CELULAR%TYPE;
                LV_NUMSERIE_NUE         GA_ABOCEL.NUM_SERIE%TYPE;
                LV_CODSUSPREHA          VARCHAR2(03);
                LV_CODSERVICIOS         VARCHAR2(255);
                LV_NUMMIN                       GA_ABOCEL.NUM_MIN%TYPE;
                LV_NUMMIN_NUE           GA_ABOCEL.NUM_MIN%TYPE;
                LV_TIPTECNOLOGIA        ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE;
                LV_IMSI_NUE                     ICC_MOVIMIENTO.IMSI%TYPE;
                LV_IMEI                         ICC_MOVIMIENTO.IMEI%TYPE;
                LV_IMEI_NUE                     ICC_MOVIMIENTO.IMEI%TYPE;
                LV_ICC                          ICC_MOVIMIENTO.ICC%TYPE;
                LV_ICC_NUE                      ICC_MOVIMIENTO.ICC%TYPE;
                LN_CARGA_VAL_OOSS       ICC_MOVIMIENTO.CARGA%TYPE;
                LV_CENTRAL_NUE          ICC_MOVIMIENTO.COD_CENTRAL_NUE%TYPE;
                LV_PLANTARIF_NUEVO      ICC_MOVIMIENTO.PLAN%TYPE;
                LV_VALORPLAN            ICC_MOVIMIENTO.VALOR_PLAN%TYPE;
                LV_NUMMSNB                      ICC_MOVIMIENTO.NUM_MSNB%TYPE;
                LV_NUMERROR                     NUMBER(15);
                LV_NUMOOSS                      NUMBER(10);
                LV_DESERROR                     VARCHAR2(5);
                LV_NUMMOVANT            ICC_MOVIMIENTO.NUM_MOVANT%TYPE;
                LV_CODTIPLAN            TA_PLANTARIF.COD_TIPLAN%TYPE;

        BEGIN
                sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;
                --
                LV_NUMSECUENCIA    := EO_APROVISIONAR.SEQ_NUMMOV;
                LV_CODESTADO       := CV_codEstado;
                LV_CODMODULO       := CV_cod_modulo;
                LV_FECINGRE            := TO_DATE(TO_CHAR(SYSDATE,'DD-MM-YYYY'),'DD-MM-YYYY');
                LV_INDBLOQUEO      := CV_IndBloqueo;
                LV_TIPTERMINAL_NUE := NULL;
                LV_NUMCELULAR_NUE  := NULL;
                LV_NUMSERIE_NUE    := NULL;
                LV_CODSUSPREHA     := NULL;
                LV_CODSERVICIOS    := EO_APROVISIONAR.COD_SERVICIOS;
                LN_CARGA_VAL_OOSS  := NULL;
                LV_PLANTARIF_NUEVO := NULL;

                IF EO_APROVISIONAR.NUM_MOVANT > 0 THEN
                        LV_NUMMOVANT := EO_APROVISIONAR.NUM_MOVANT;
                ELSE
                        LV_NUMMOVANT := NULL;
                END IF;

                   LV_sSql:='PV_ValNroCELULAR_FN ('||EO_APROVISIONAR.NUM_CELULAR||','||LV_AL_FN_PREFIJO_NUMERO||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||') ';
                        IF PV_ValNroCELULAR_FN (EO_APROVISIONAR.NUM_CELULAR     , LV_AL_FN_PREFIJO_NUMERO, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                                LV_NUMMIN:=LV_AL_FN_PREFIJO_NUMERO;
                        ELSE
                                RAISE ERROR_EJECUCION;
                        END IF;

                LV_NUMMIN_NUE      := NULL;
                LV_IMSI_NUE            := NULL;
                LV_IMEI_NUE            := NULL;
                LV_ObtCODGRUPO_AL_TECNOLOGIA:=NULL;
                LV_sSql:= ' GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN('||EO_APROVISIONAR.TIP_TECNOLOGIA||')';
                LV_ObtCODGRUPO_AL_TECNOLOGIA:=GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(EO_APROVISIONAR.TIP_TECNOLOGIA);
                IF LV_ObtCODGRUPO_AL_TECNOLOGIA = 'ERROR' THEN
                        SN_cod_retorno := 1363;
                    RAISE ERROR_GENERICO;
                END IF;

                IF LV_ObtCODGRUPO_AL_TECNOLOGIA IS NOT NULL THEN
                                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_GrupoTecGsm;
                                EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;

                                LV_sSql:= 'EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN; ';
                                LV_sSql:= LV_sSql||'EO_GED_PARAMETROS.NOM_PARAMETRO:='||CV_GrupoTecGsm||'; ';
                                LV_sSql:= LV_sSql||'EO_GED_PARAMETROS.COD_MODULO   :='||CV_cod_modulo ||'; ';
                                LV_sSql:= LV_sSql||'EO_GED_PARAMETROS.COD_PRODUCTO :='||CN_producto   ||'; ';
                                LV_sSql:= LV_sSql||'PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,'||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                                PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                                LV_gsm := EO_GED_PARAMETROS.VAL_PARAMETRO;
                                IF SN_cod_retorno <> 0 THEN
                           RAISE ERROR_EJECUCION;
                        END IF;

                        IF  (LV_ObtCODGRUPO_AL_TECNOLOGIA = LV_gsm) THEN
                                        LV_sSql:= 'FN_RECUPERA_IMSI('||EO_APROVISIONAR.NUM_SERIE||')';

                                LV_sImsi:=FN_RECUPERA_IMSI(EO_APROVISIONAR.NUM_SERIE);
                                IF Trim(LV_sImsi) IS NULL THEN
                                                SN_cod_retorno  := 1366;
                                                RAISE ERROR_GENERICO;
                                END IF;
                        END IF;

                END IF;
                LV_ICC_NUE             := NULL;
                LV_CENTRAL_NUE     := NULL;
                LV_VALORPLAN       := EO_APROVISIONAR.VALOR_PLAN;

                EO_SECUENCIA:=PV_INICIA_ESTRUCTURAS_PG.PV_SECUENCIA_QT_FN;
                EO_SECUENCIA.NOM_SECUENCIA:= 'PV_ERRORES_SQ';
                EO_SECUENCIA.NUM_SECUENCIA:= NULL;

                LV_sSql:= 'EO_SECUENCIA:=PV_INICIA_ESTRUCTURAS_PG.PV_SECUENCIA_QT_FN; ';
                LV_sSql:= LV_sSql||'EO_SECUENCIA.NOM_SECUENCIA:='|| 'PV_ERRORES_SQ'||'; ';
                LV_sSql:= LV_sSql||'PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR (EO_SECUENCIA,'||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR (EO_SECUENCIA, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                IF SN_cod_retorno <> 0 THEN
               RAISE ERROR_EJECUCION;
        END IF;

                LV_NUMERROR            := EO_SECUENCIA.NUM_SECUENCIA;
                LV_NUMMSNB             := NULL;

                                LV_NUMABONADO      := EO_APROVISIONAR.NUM_ABONADO;
                                LV_CODACTABO       := EO_APROVISIONAR.COD_ACTABO;
                                LV_USUARIO             := EO_APROVISIONAR.NOM_USUARORA;
                                LV_TIPTERMINAL     := EO_APROVISIONAR.TIP_TERMINAL;
                                LV_CODCENTRAL      := EO_APROVISIONAR.COD_CENTRAL;
                                LV_NUMCELULAR      := EO_APROVISIONAR.NUM_CELULAR;
                                LV_NUMSERIE            := EO_APROVISIONAR.NUM_SERIE;
                                LV_ICC                     := EO_APROVISIONAR.NUM_SERIE;
                                LV_TIPTECNOLOGIA   := EO_APROVISIONAR.TIP_TECNOLOGIA;
                                LV_IMEI                := EO_APROVISIONAR.IMEI;

                                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_TipoPrepago;
                                EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;

                                LV_sSql:= 'PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR('||CV_TipoPrepago||','||CV_cod_modulo||','||CN_producto||')';
                                PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                                IF SN_cod_retorno <> 0 THEN
                               RAISE ERROR_EJECUCION;
                        END IF;

                                LV_CODTIPLAN:= EO_GED_PARAMETROS.VAL_PARAMETRO;

                            LN_CARGA_VAL_OOSS := EO_APROVISIONAR.VAL_OOSS;

                            LV_PLANTARIF_NUEVO := EO_APROVISIONAR.COD_PLANTARIF_NUEVO;
                                LV_NUMOOSS             := EO_APROVISIONAR.NUN_OOSS;
                                LV_DESERROR            := EO_APROVISIONAR.COD_OOSS;

                                LV_sSql:= ' GA_APROVISIONAR_CENTRAL_PG.GA_APROVISIONAR_PV_PR('||LV_NUMSECUENCIA||',';
                                LV_sSql:= LV_sSql || LV_NUMABONADO||',';
                                LV_sSql:= LV_sSql || LV_CODESTADO||',';
                                LV_sSql:= LV_sSql || LV_CODACTABO||',';
                                LV_sSql:= LV_sSql || LV_CODMODULO||',';
                                LV_sSql:= LV_sSql || LV_USUARIO||',';
                                LV_sSql:= LV_sSql || TO_CHAR(LV_FECINGRE,'DD-MM-YYYY')||',';
                                LV_sSql:= LV_sSql || LV_TIPTERMINAL||',';
                                LV_sSql:= LV_sSql || LV_CODCENTRAL||',';
                                LV_sSql:= LV_sSql || LV_INDBLOQUEO||',';
                                LV_sSql:= LV_sSql || LV_TIPTERMINAL_NUE||',';
                                LV_sSql:= LV_sSql || LV_NUMCELULAR||',';
                                LV_sSql:= LV_sSql || LV_NUMSERIE||',';
                                LV_sSql:= LV_sSql || LV_NUMCELULAR_NUE||',';
                                LV_sSql:= LV_sSql || LV_NUMSERIE_NUE||',';
                                LV_sSql:= LV_sSql || LV_CODSUSPREHA||',';
                                LV_sSql:= LV_sSql || LV_CODSERVICIOS||',';
                                LV_sSql:= LV_sSql || LV_NUMMIN||',';
                                LV_sSql:= LV_sSql || LV_NUMMIN_NUE||',';
                                LV_sSql:= LV_sSql || LV_TIPTECNOLOGIA||',';
                                LV_sSql:= LV_sSql || LV_IMSI_NUE||',';
                                LV_sSql:= LV_sSql || LV_IMEI||',';
                                LV_sSql:= LV_sSql || LV_IMEI_NUE||',';
                                LV_sSql:= LV_sSql || LV_ICC||',';
                                LV_sSql:= LV_sSql || LV_ICC_NUE||',';
                                LV_sSql:= LV_sSql || LN_CARGA_VAL_OOSS||',';
                                LV_sSql:= LV_sSql || LV_CENTRAL_NUE||',';
                                LV_sSql:= LV_sSql || LV_PLANTARIF_NUEVO||',';
                                LV_sSql:= LV_sSql || LV_VALORPLAN||',';
                                LV_sSql:= LV_sSql || LV_NUMMSNB||',';
                                LV_sSql:= LV_sSql || LV_NUMERROR||',';
                                LV_sSql:= LV_sSql || LV_NUMOOSS||',';
                                LV_sSql:= LV_sSql || LV_DESERROR||',';
                                LV_sSql:= LV_sSql || LV_NUMMOVANT||',';

                                GA_APROVISIONAR_CENTRAL_PG.GA_APROVISIONAR_PV_PR(LV_NUMSECUENCIA,
                                                                                                                   LV_NUMABONADO,
                                                                                                                   LV_CODESTADO,
                                                                                                                   LV_CODACTABO,
                                                                                                                   LV_CODMODULO,
                                                                                                                   LV_USUARIO,
                                                                                                                   TO_CHAR(LV_FECINGRE,'DD-MM-YYYY'),
                                                                                                                   LV_TIPTERMINAL,
                                                                                                                   LV_CODCENTRAL,
                                                                                                                   LV_INDBLOQUEO,
                                                                                                                   LV_TIPTERMINAL_NUE,
                                                                                                                   LV_NUMCELULAR,
                                                                                                                   LV_NUMSERIE,
                                                                                                                   LV_NUMCELULAR_NUE,
                                                                                                                   LV_NUMSERIE_NUE,
                                                                                                                   LV_CODSUSPREHA,
                                                                                                                   LV_CODSERVICIOS,
                                                                                                                   LV_NUMMIN,
                                                                                                                   LV_NUMMIN_NUE,
                                                                                                                   LV_TIPTECNOLOGIA,
                                                                                                                   LV_IMSI_NUE,
                                                                                                                   LV_IMEI,
                                                                                                                   LV_IMEI_NUE,
                                                                                                                   LV_ICC,
                                                                                                                   LV_ICC_NUE,
                                                                                                                   LN_CARGA_VAL_OOSS,
                                                                                                                   LV_CENTRAL_NUE,
                                                                                                                   LV_PLANTARIF_NUEVO,
                                                                                                                   LV_VALORPLAN,
                                                                                                                   LV_NUMMSNB,
                                                                                                                   LV_NUMERROR,
                                                                                                                   LV_NUMOOSS,
                                                                                                                   LV_DESERROR,
                                                                                                                   LV_NUMMOVANT);
                        LV_sSql:= LV_sSql || ' ';
                        LV_sSql:= LV_sSql || '  SELECT COD_ERROR, GLS_ERROR';
                        LV_sSql:= LV_sSql || '  FROM PV_ERRORES_OOSS_TO ';
                        LV_sSql:= LV_sSql || ' WHERE NUM_ERROR = '||LV_NUMERROR;
                        LV_sSql:= LV_sSql || ' AND NUM_OS = '||LV_NUMOOSS;

                        SELECT COD_ERROR, GLS_ERROR
                         INTO SN_cod_retorno, SV_mens_retorno
                         FROM PV_ERRORES_OOSS_TO
                        WHERE NUM_ERROR = LV_NUMERROR
                                  AND NUM_OS = LV_NUMOOSS;

                        IF SN_cod_retorno > 0 THEN
                           RAISE ERROR_EJECUCION;
                        END IF;


        EXCEPTION
        WHEN ERROR_GENERICO THEN
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_APROVISIONAR_CENTRAL_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_APROVISIONAR_CENTRAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_APROVISIONAR_CENTRAL_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_APROVISIONAR_CENTRAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_APROVISIONAR_CENTRAL_PR(); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_APROVISIONAR_CENTRAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_APROVISIONAR_CENTRAL_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_ACTUALIZA_LIMITE_CONSUMO_PR(EO_LIMITE_CONSUMO        IN                    PV_LIMITE_CONSUMO_QT,
                                                                                     SN_cod_retorno       OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                                     SV_mens_retorno      OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                                     SN_num_evento        OUT NOCOPY    ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_ACTUALIZA_LIMITE_CONSUMO_PR"
              Lenguaje="PL/SQL"
              Fecha="13-06-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_LIMITE_CONSUMO" Tipo="estructura">estructura de los datos </param>>
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
                EO_GED_PARAMETROS                       PV_GED_PARAMETROS_QT;
                ERROR_EJECUCION                 EXCEPTION;
                LN_Sujeto                                       NUMBER;
                LV_TipSujeto                            VARCHAR2(20);
                LD_FecDesde                                     VARCHAR2(20);
                LD_FecHasta                                     VARCHAR2(20);
                LV_CodActabo                            VARCHAR2(20);
                LV_CodPlantarif                         VARCHAR2(20);
                LV_TipMovimiento                        VARCHAR2(2);
        LV_CodValor                             VARCHAR2(20);
        LV_ErrorAplic                           VARCHAR2(2000);
        LV_ErrorGlosa                           VARCHAR2(2000);
        LV_ErrorOra                             VARCHAR2(2000);
        LV_ErrorOraGlosa                        VARCHAR2(2000);
        LV_Trace                                        VARCHAR2(2000);

		--INI COL-72899|16-12-2008|GEZ
		LN_ClienteActual			  		ga_abocel.cod_cliente%TYPE;
		LN_ClienteNuevo			  		   ga_abocel.cod_cliente%TYPE;
		LV_PlanActual					     ga_abocel.cod_plantarif%TYPE;
		LV_PlanNuevo					    ga_abocel.cod_plantarif%TYPE;
		LV_TipPlanActual				   ga_abocel.cod_plantarif%TYPE;
		LV_TipPlanNuevo					  ga_abocel.cod_plantarif%TYPE;
		LV_CodTipPlanActual 			ga_abocel.cod_plantarif%TYPE;
		LV_CodTipPlanNuevo			   ga_abocel.cod_plantarif%TYPE;

		LV_CodPlanAct				      ga_abocel.cod_plantarif%TYPE;
		LV_UsoPlanDest				      ga_abocel.cod_uso%TYPE;
		LV_UsoPrepago				     ga_abocel.cod_uso%TYPE;

		LV_TiplanPostpago			    ta_plantarif.cod_tiplan%TYPE;
		LV_TiplanPrepago			    ta_plantarif.cod_tiplan%TYPE;
		LV_TiplanHibrido			      ta_plantarif.cod_tiplan%TYPE;

		LV_Estado					        VARCHAR2(1);
		LV_Proc					  			 VARCHAR2(50);
		LV_Tabla						    VARCHAR2(50);
		LV_Act								  VARCHAR2(1);
		LV_CodLimCons						  tol_limite_plan_td.cod_limcons%TYPE; --EV

		LD_FecDesdeVig                   DATE;
        
        LV_subsegmento              ge_clientes.cod_segmento%type;
        LV_prioridad                ge_clientes.cod_color%type;
         

		ERROR_LIMITE        		EXCEPTION;

		--FIN COL-72899|16-12-2008|GEZ

        BEGIN
                sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;

                                EO_GED_PARAMETROS:=PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                EO_GED_PARAMETROS.NOM_PARAMETRO := 'IND_TOL';
                                EO_GED_PARAMETROS.COD_MODULO    := 'GE';
                                EO_GED_PARAMETROS.COD_PRODUCTO  := EO_LIMITE_CONSUMO.COD_PRODUCTO;

                                LV_sSql:='';
                                LV_sSql:=LV_sSql||'EO_GED_PARAMETROS:=PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN; ';
                                LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.NOM_PARAMETRO :='||'IND_TOL'    ||'; ';
                                LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.COD_MODULO    :='||CV_cod_modulo||'; ';
                                LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.COD_PRODUCTO  :='||EO_LIMITE_CONSUMO.COD_PRODUCTO||'; ';
                                LV_sSql:=LV_sSql||'PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR (EO_GED_PARAMETROS,'||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                                PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR (EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno>0 THEN
                                RAISE ERROR_EJECUCION;
                        END IF;

                        IF EO_GED_PARAMETROS.VAL_PARAMETRO='S' THEN
                                LN_Sujeto:=EO_LIMITE_CONSUMO.SUJETO;
                                LV_TipSujeto:=EO_LIMITE_CONSUMO.TIP_SUJETO;
                                LD_FecDesde:=EO_LIMITE_CONSUMO.FEC_DES;
                                LD_FecHasta:=EO_LIMITE_CONSUMO.FEC_HAS;
                                LV_CodActabo:=EO_LIMITE_CONSUMO.COD_ACTABO;
                                LV_CodPlantarif:=EO_LIMITE_CONSUMO.COD_PLANTARIF_NUEVO;
                                LV_TipMovimiento:=EO_LIMITE_CONSUMO.TIPO_MOVIMIENTO;


								IF LV_TipSujeto<>'A' THEN
										LV_sSql:='PV_LIMITE_CONSUMO_PG.PV_OPERA_LIMITE_PR('||LN_Sujeto||','||LV_TipSujeto||','||LD_FecDesde||','||LD_FecHasta||','||LV_CodActabo||','||LV_CodPlantarif||','||LV_TipMovimiento||','||LV_CodValor||','||LV_ErrorAplic||','||LV_ErrorGlosa||','||LV_ErrorOra||','||LV_ErrorOraGlosa||','||LV_Trace||'); ';
		                                PV_LIMITE_CONSUMO_PG.PV_OPERA_LIMITE_PR(LN_Sujeto,LV_TipSujeto,LD_FecDesde,LD_FecHasta,LV_CodActabo,LV_CodPlantarif,LV_TipMovimiento,LV_CodValor,LV_ErrorAplic,LV_ErrorGlosa,LV_ErrorOra,LV_ErrorOraGlosa,LV_Trace);

										IF LV_ErrorAplic <>'0' THEN
		                                    SN_cod_retorno := TO_NUMBER(LV_ErrorAplic);
		                                        SV_mens_retorno := LV_ErrorGlosa||'-'||LV_Trace;
		                                        RAISE ERROR_EJECUCION;
		                                END IF;
								ELSE

									    IF LD_FecDesde='*' THEN
    							   			LD_FecDesdeVig:=SYSDATE;
										ELSE
											LD_FecDesdeVig := TO_DATE(LD_FecDesde,'DD-MM-YYYY HH24:MI.SS');
										END IF;

									   --PARAMETROS GENERALES
									   LV_TiplanPostpago	 := GE_FN_DEVVALPARAM('GA', 1, 'TIPOPOSTPAGO');
									   LV_TiplanPrepago	     := GE_FN_DEVVALPARAM('GA', 1, 'TIPOPREPAGO');
									   LV_TiplanHibrido        := GE_FN_DEVVALPARAM('GA', 1, 'TIPOHIBRIDO');

									   --Cliente Nuevo
									   LV_Tabla		:='GA_ABOCELA';
									   LV_Act		 :='S';

									   LV_sSQL:=' SELECT cod_cliente ';
									   LV_sSQL:=LV_sSQL || ' FROM   ga_abocel';
									   LV_sSQL:=LV_sSQL || ' WHERE num_abonado='||LN_Sujeto;

									   EXECUTE IMMEDIATE LV_sSQL INTO  LN_ClienteNuevo;

                                       --Cliente Actual
									   IF LV_CodActabo NOT IN ('A2') THEN
									           LN_ClienteActual:=LN_ClienteNuevo;
									   ELSE
											   LV_Tabla		:='GA_TRASPABOA';
									   		   LV_Act		 :='S';

											   LV_sSQL:=' SELECT cod_clienant ';
		                                       LV_sSQL:=LV_sSQL || ' FROM  ga_traspabo';
		                                       LV_sSQL:=LV_sSQL || ' WHERE num_abonado ='|| LN_Sujeto;
		                                       LV_sSQL:=LV_sSQL || ' AND     cod_cliennue ='|| LN_ClienteNuevo;
		                                       LV_sSQL:=LV_sSQL || ' AND     fec_modifica = (SELECT max(fec_modifica)';
		                                       LV_sSQL:=LV_sSQL || '                     		        FROM ga_traspabo';
		                                       LV_sSQL:=LV_sSQL || '                                    WHERE num_abonado ='|| LN_Sujeto;
		                                       LV_sSQL:=LV_sSQL || '                                    AND cod_cliennue = '||LN_ClienteNuevo;
											   LV_sSQL:=LV_sSQL || '                                    AND TRUNC(fec_modifica)=TRUNC(SYSDATE))';

									   BEGIN
									   			EXECUTE IMMEDIATE LV_sSQL INTO  LN_ClienteActual;
									   EXCEPTION
											 WHEN NO_DATA_FOUND THEN
											 	   LN_ClienteActual:=LN_ClienteNuevo;
								      END;
									  END IF;

									  --Plan Nuevo
									  LV_PlanNuevo:=LV_CodPlantarif;

									  --Plan Actual
									  IF LV_CodActabo NOT IN ('A2') THEN
									  	 		  LV_Tabla		:='GA_ABOCELB';
									   			  LV_Act		 :='S';

												  LV_sSQL:=' SELECT cod_plantarif ';
												  LV_sSQL:=LV_sSQL || ' FROM   ga_abocel ';
												  LV_sSQL:=LV_sSQL || ' WHERE num_abonado='||LN_Sujeto;
												  LV_sSQL:=LV_sSQL || ' AND cod_cliente='||LN_ClienteActual;

									  ELSE

									   			  LV_Tabla		:='GA_INTARCELA';
									   			  LV_Act		 :='S';

												  LV_sSQL:=' SELECT cod_plantarif ';
												  LV_sSQL:=LV_sSQL || ' FROM   ga_intarcel ';
												  LV_sSQL:=LV_sSQL || ' WHERE num_abonado='||LN_Sujeto;
												  LV_sSQL:=LV_sSQL || ' AND cod_cliente='||LN_ClienteActual;
												  LV_sSQL:=LV_sSQL || ' AND fec_desde=(SELECT MAX(fec_desde)';
												  LV_sSQL:=LV_sSQL || ' 	  					 FROM   ga_intarcel ';
												  LV_sSQL:=LV_sSQL || '                          WHERE num_abonado='||LN_Sujeto;
												  LV_sSQL:=LV_sSQL || ' 				   	  	 AND cod_cliente='||LN_ClienteActual;
						   						  LV_sSQL:=LV_sSQL || '		   	  	             AND sysdate between fec_desde and fec_hasta';/* Inicio - COL - Incd 72899 - PMY */
												  LV_sSQL:=LV_sSQL || ' 						  )';
									  END IF;

									  EXECUTE IMMEDIATE LV_sSQL INTO LV_PlanActual;

									  --TIP_PLANTARIF-COD_TIPLAN NUEVO
									   LV_Tabla		:='TA_PLANTARIFA';
									   LV_Act		 :='S';

									  LV_sSQL:=' SELECT tip_plantarif,cod_tiplan ';
									  LV_sSQL:=LV_sSQL || ' FROM   ta_plantarif';
									  LV_sSQL:=LV_sSQL || ' WHERE cod_plantarif='''||LV_PlanNuevo||'''';

									  EXECUTE IMMEDIATE LV_sSQL INTO LV_TipPlanNuevo,LV_CodTipPlanNuevo;

									  --TIP_PLANTARIF-COD_TIPLAN ACTUAL
									   LV_Tabla		:='TA_PLANTARIFB';
									   LV_Act		 :='S';

									  LV_sSQL:=' SELECT tip_plantarif,cod_tiplan ';
									  LV_sSQL:=LV_sSQL || ' FROM   ta_plantarif';
									  LV_sSQL:=LV_sSQL || ' WHERE cod_plantarif='''||LV_PlanActual||'''';

									  EXECUTE IMMEDIATE LV_sSQL INTO LV_TipPlanActual,LV_CodTipPlanActual;

									  --VALIACION DE LIMITE DE CONSUMO
									  --PLAN ACTUAL
									  IF LV_TipPlanActual='I' THEN --PLAN ACTUAL INDIVIDUAL

									  	 		IF LV_CodTipPlanActual=LV_TiplanPostpago THEN --ACTUAL POSPAGO

														IF TRIM(LD_FecHasta) = '*' THEN --OOSS ON LINE

														   			  pv_limite_consumo_pg.pv_cerrarlim_linea_ind_pr(LN_Sujeto,LN_ClienteActual,LV_PlanActual, LD_FecDesdeVig,
																	   																	  LV_Estado,LV_Proc,SN_cod_retorno,SN_num_evento,LV_Tabla,LV_Act,LV_ErrorOra,LV_ErrorOraGlosa) ;

																	  IF LV_Estado<>'3' THEN
																	  	    RAISE ERROR_LIMITE;
																	  END IF;
														ELSE --OOSS AL CORTE DE CICLO
																	 pv_limite_consumo_pg.pv_cerrarlim_aciclo_ind_pr(LN_Sujeto,LN_ClienteActual,LV_PlanActual,
																	   																	  LV_Estado,LV_Proc,SN_cod_retorno,SN_num_evento,LV_Tabla,LV_Act,LV_ErrorOra,LV_ErrorOraGlosa) ;

																	  IF LV_Estado<>'3' THEN
																	  	    RAISE ERROR_LIMITE;
																	  END IF;
														END IF;

														pv_limite_consumo_pg.pv_eliminarlim_aciclo_ind_pr(LN_Sujeto,LN_ClienteActual,LV_PlanActual,
																	   														   LV_Estado,LV_Proc,SN_cod_retorno,SN_num_evento,LV_Tabla,LV_Act,LV_ErrorOra,LV_ErrorOraGlosa) ;

														IF LV_Estado<>'3' THEN
															   	RAISE ERROR_LIMITE;
														END IF;

									            END IF;
								      ELSIF LV_TipPlanActual='E' THEN --PLAN ACTUAL EMPRESA

									  		    IF TRIM(LD_FecHasta) = '*' THEN --OOSS ON LINE
														   	pv_limite_consumo_pg.pv_cerrarlim_linea_emp_pr(LN_Sujeto,LN_ClienteActual,LV_PlanActual, LD_FecDesdeVig,
																	   														   LV_Estado,LV_Proc,SN_cod_retorno,SN_num_evento,LV_Tabla,LV_Act,LV_ErrorOra,LV_ErrorOraGlosa) ;

															IF LV_Estado<>'3' THEN
															   		RAISE ERROR_LIMITE;
															END IF;

												ELSE --OOSS AL CORTE DE CICLO
													        pv_limite_consumo_pg.pv_cerrarlim_aciclo_emp_pr(LN_Sujeto,LN_ClienteActual,LV_PlanActual,
																	   															LV_Estado,LV_Proc,SN_cod_retorno,SN_num_evento,LV_Tabla,LV_Act,LV_ErrorOra,LV_ErrorOraGlosa) ;

															IF LV_Estado<>'3' THEN
															   			RAISE ERROR_LIMITE;
															END IF;
												END IF;
									  END IF; --FIN PLAN ACTUAL

									   IF LV_TipPlanNuevo='I' THEN --PLAN NUEVO INDIVIDUAL

									  	 		IF LV_CodTipPlanNuevo=LV_TiplanPostpago THEN --NUEVO POSPAGO

														IF TRIM(LD_FecHasta) = '*' THEN --OOSS ON LINE
														   			  pv_limite_consumo_pg.pv_crealim_linea_ind_pr(LN_Sujeto,LN_ClienteNuevo,LV_PlanNuevo, LD_FecDesdeVig,
																	   																	  LV_Estado,LV_Proc,SN_cod_retorno,SN_num_evento,LV_Tabla,LV_Act,LV_ErrorOra,LV_ErrorOraGlosa) ;

																	  IF LV_Estado<>'3' THEN
																	  	    RAISE ERROR_LIMITE;
																	  END IF;
														ELSE --OOSS AL CORTE DE CICLO
																	 pv_limite_consumo_pg.pv_crealim_aciclo_ind_pr(LN_Sujeto,LN_ClienteNuevo,LV_PlanNuevo,
																	   																	  LV_Estado,LV_Proc,SN_cod_retorno,SN_num_evento,LV_Tabla,LV_Act,LV_ErrorOra,LV_ErrorOraGlosa) ;

																	  IF LV_Estado<>'3' THEN
																	  	    RAISE ERROR_LIMITE;
																	  END IF;
														END IF;
									            END IF;
								      ELSIF LV_TipPlanNuevo='E' THEN --PLAN NUEVO EMPRESA

									  		    IF TRIM(LD_FecHasta) = '*' THEN --OOSS ON LINE
														   	pv_limite_consumo_pg.pv_crealim_linea_emp_pr(LN_Sujeto,LN_ClienteNuevo,LV_PlanNuevo,
																	   														     LV_Estado,LV_Proc,SN_cod_retorno,SN_num_evento,LV_Tabla,LV_Act,LV_ErrorOra,LV_ErrorOraGlosa) ;

															IF LV_Estado<>'3' THEN
															   		RAISE ERROR_LIMITE;
															END IF;
												ELSE --OOSS AL CORTE DE CICLO
													        pv_limite_consumo_pg.pv_crealim_aciclo_emp_pr(LN_Sujeto,LN_ClienteNuevo,LV_PlanNuevo,
																	   															  LV_Estado,LV_Proc,SN_cod_retorno,SN_num_evento,LV_Tabla,LV_Act,LV_ErrorOra,LV_ErrorOraGlosa) ;

															IF LV_Estado<>'3' THEN
															   			RAISE ERROR_LIMITE;
															END IF;
												END IF;
									  END IF;

									  IF TRUNC(LD_FecDesdeVig)=TRUNC(SYSDATE) THEN
                                            
                                            select cod_segmento, cod_color
                                            into   LV_subsegmento, LV_prioridad
                                            from ge_clientes
                                            where cod_cliente = LN_ClienteActual;
                                                      
										  	BEGIN
                                                 
                                                 SELECT cod_limcons into LV_CodLimCons
                                                 FROM  tol_limite_plan_td
                                                 WHERE cod_plantarif  = LV_PlanNuevo
                                                 And   id_subsegmento = LV_subsegmento
                                                 And   ind_prioridad >= LV_prioridad
                                                 AND   SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)
                                                 AND   ROWNUM <=1
                                                 ORDER BY COD_LIMCONS ASC;                                                 
											EXCEPTION
											 	 WHEN NO_DATA_FOUND THEN
												 	  LV_CodLimCons := '-1';
											END;

											UPDATE GA_ABOCEL
											SET COD_LIMCONSUMO=LV_CodLimCons
											WHERE NUM_ABONADO = LN_Sujeto;

									  END IF;

								END IF;

                        END IF;

EXCEPTION

        --INI COL-72899|09-12-2008|GEZ
        WHEN ERROR_LIMITE THEN

			 LV_ErrorOra:='E:'||SN_num_evento||'-'||LV_ErrorOraGlosa;
			 P_INSERTA_ERRORES(1,'LP',TO_NUMBER(LN_Sujeto),SYSDATE,SUBSTR(LV_Proc,1,50),SUBSTR(LV_Tabla,1,50),LV_Act,SUBSTR(LV_ErrorOra,1,15),LV_ErrorOraGlosa);
			 ROLLBACK;

	--FIN COL-72899|09-12-2008|GEZ

        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := ' PV_ACTUALIZA_LIMITE_CONSUMO_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_ACTUALIZA_LIMITE_CONSUMO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;

              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;

                  LV_des_error   := 'PV_ACTUALIZA_LIMITE_CONSUMO_PR('||EO_LIMITE_CONSUMO.SUJETO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_ACTUALIZA_LIMITE_CONSUMO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
               SN_cod_retorno := 156;

			   IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
               END IF;

			   LV_des_error   := 'PV_ACTUALIZA_LIMITE_CONSUMO_PR('||EO_LIMITE_CONSUMO.SUJETO||'); '||SQLERRM;

			   SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_ACTUALIZA_LIMITE_CONSUMO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_ACTUALIZA_LIMITE_CONSUMO_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_ATLANTIDA_PR(EO_GE_CLIENTES           IN                           GE_CLIENTES_QT,
                                                                      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                                                                      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                                                                      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_ATLANTIDA_PR"
              Lenguaje="PL/SQL"
              Fecha="13-06-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_GE_CLIENTES" Tipo="estructura">estructura de los datos de un cliente</param>>
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
                SV_COD_CLIENTE                          NUMBER (8);
        BEGIN

                sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;

                BEGIN
                         SV_COD_CLIENTE:=EO_GE_CLIENTES.COD_CLIENTE;
--       pendiente de especificaciones  :
                         --PV_OBTIENEINFO_ATLANTIDA_PG.PV_CLIENTEESATLANTIDA_FN (SV_COD_CLIENTE);
                EXCEPTION
                  WHEN OTHERS THEN
                                RAISE ERROR_EJECUCION;
                END;
        EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := ' PV_OBTIENE_ATLANTIDA_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_ATLANTIDA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_ATLANTIDA_PR('||to_char(EO_GE_CLIENTES.COD_CLIENTE)||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_ATLANTIDA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_ATLANTIDA_PR('||to_char(EO_GE_CLIENTES.COD_CLIENTE)||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_ATLANTIDA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_OBTIENE_ATLANTIDA_PR;

------------------------------------------------------------------------------------------------
        PROCEDURE PV_VALIDA_BAJA_ATLANTIDA_PR(EO_VAL_BAJA_ATLANTIDA        IN OUT NOCOPY        PV_VAL_BAJA_ATLANTIDA_QT,
                                                                              SN_cod_retorno              OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                              SV_mens_retorno             OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                              SN_num_evento               OUT NOCOPY    ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_VALIDA_BAJA_ATLANTIDA_PR"
              Lenguaje="PL/SQL"
              Fecha="09-07-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_VAL_BAJA_ATLANTIDA" Tipo="estructura">estructura de datos</param>>
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
                SN_COD_CLIENTE                          NUMBER(08);
                SN_EXISTE                                       NUMBER(01);

                LN_EN_NUM_MOVIMIENTO                ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
                LN_EN_NUM_ABONADO                   ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
                LN_EN_COD_ESTADO                    ICC_MOVIMIENTO.COD_ESTADO%TYPE;
                LV_EV_COD_ACTABO                    ICC_MOVIMIENTO.COD_ACTABO%TYPE;
                LV_EV_COD_MODULO                    ICC_MOVIMIENTO.COD_MODULO%TYPE;
                LN_EN_NUM_INTENTOS                  ICC_MOVIMIENTO.NUM_INTENTOS%TYPE;
                LV_EN_COD_CENTRAL_NUE               ICC_MOVIMIENTO.COD_CENTRAL_NUE%TYPE;
                LV_EV_DES_RESPUESTA             ICC_MOVIMIENTO.DES_RESPUESTA%TYPE;
                LV_EN_COD_ACTUACION             ICC_MOVIMIENTO.COD_ACTUACION%TYPE;
                LV_EV_NOM_USUARORA              ICC_MOVIMIENTO.NOM_USUARORA%TYPE;
                LD_EV_FEC_INGRESO                           ICC_MOVIMIENTO.FEC_INGRESO%TYPE;
                LV_EV_TIP_TERMINAL                          ICC_MOVIMIENTO.TIP_TERMINAL%TYPE;
                LV_EN_COD_CENTRAL                           ICC_MOVIMIENTO.COD_CENTRAL%TYPE;
                LD_EV_FEC_LECTURA                           ICC_MOVIMIENTO.FEC_LECTURA%TYPE;
                LN_EN_IND_BLOQUEO                           ICC_MOVIMIENTO.IND_BLOQUEO%TYPE;
                LD_EV_FEC_EJECUCION                 ICC_MOVIMIENTO.FEC_EJECUCION%TYPE;
                LV_EV_TIP_TERMINAL_NUE              ICC_MOVIMIENTO.TIP_TERMINAL_NUE%TYPE;
                LN_EN_NUM_MOVANT                            ICC_MOVIMIENTO.NUM_MOVANT%TYPE;
                LN_EN_NUM_CELULAR                           ICC_MOVIMIENTO.NUM_CELULAR%TYPE;
                LN_EN_NUM_MOVPOS                            ICC_MOVIMIENTO.NUM_MOVPOS%TYPE;
                LN_EV_NUM_SERIE                             ICC_MOVIMIENTO.NUM_SERIE%TYPE;
                LN_EV_NUM_PERSONAL                          ICC_MOVIMIENTO.NUM_PERSONAL%TYPE;
                LN_EN_NUM_CELULAR_NUE               ICC_MOVIMIENTO.NUM_CELULAR_NUE%TYPE;
                LN_EV_NUM_SERIE_NUE                         ICC_MOVIMIENTO.NUM_SERIE_NUE%TYPE;
                LN_EV_NUM_PERSONAL_NUE              ICC_MOVIMIENTO.NUM_PERSONAL_NUE%TYPE;
                LN_EV_NUM_MSNB                              ICC_MOVIMIENTO.NUM_MSNB%TYPE;
                LN_EV_NUM_MSNB_NUE                          ICC_MOVIMIENTO.NUM_MSNB_NUE%TYPE;
                LV_EV_COD_SUSPREHA                          ICC_MOVIMIENTO.COD_SUSPREHA%TYPE;
                LV_EV_COD_SERVICIOS                         ICC_MOVIMIENTO.COD_SERVICIOS%TYPE;
                LV_EV_NUM_MIN                               ICC_MOVIMIENTO.NUM_MIN%TYPE;
                LV_EV_NUM_MIN_NUE                           ICC_MOVIMIENTO.NUM_MIN%TYPE;
                LV_EV_STA                                           ICC_MOVIMIENTO.STA%TYPE;
                LV_EN_COD_MENSAJE                           ICC_MOVIMIENTO.COD_MENSAJE%TYPE;
                LV_EV_PARAM1_MENS                           ICC_MOVIMIENTO.PARAM1_MENS%TYPE;
                LV_EV_PARAM2_MENS                           ICC_MOVIMIENTO.PARAM2_MENS%TYPE;
                LV_EV_PARAM3_MENS                           ICC_MOVIMIENTO.PARAM3_MENS%TYPE;
                LV_EV_PLAN                                          ICC_MOVIMIENTO.PLAN%TYPE;
                LN_EN_CARGA                                         ICC_MOVIMIENTO.CARGA%TYPE;
                LN_EN_VALOR_PLAN                            ICC_MOVIMIENTO.VALOR_PLAN%TYPE;
                LV_EV_PIN                                           ICC_MOVIMIENTO.PIN%TYPE;
                LD_EV_FEC_EXPIRA                            ICC_MOVIMIENTO.FEC_EXPIRA%TYPE;
                LV_EV_DES_MENSAJE                           ICC_MOVIMIENTO.DES_MENSAJE%TYPE;
                LV_EV_COD_PIN                               ICC_MOVIMIENTO.COD_PIN%TYPE;
                LN_EV_COD_IDIOMA                            ICC_MOVIMIENTO.COD_IDIOMA%TYPE;
                LN_EN_COD_ENRUTAMIENTO              ICC_MOVIMIENTO.COD_ENRUTAMIENTO%TYPE;
                LN_EN_TIP_ENRUTAMIENTO              ICC_MOVIMIENTO.TIP_ENRUTAMIENTO%TYPE;
                LV_EV_DES_ORIGEN_PIN                ICC_MOVIMIENTO.DES_ORIGEN_PIN%TYPE;
                LN_EN_NUM_LOTE_PIN                          ICC_MOVIMIENTO.NUM_LOTE_PIN%TYPE;
                LN_EV_NUM_SERIE_PIN                         ICC_MOVIMIENTO.NUM_SERIE_PIN%TYPE;
                LV_EV_TIP_TECNOLOGIA                ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE;
                LV_EV_IMSI                                          ICC_MOVIMIENTO.IMSI%TYPE;
                LV_EV_IMSI_NUE                              ICC_MOVIMIENTO.IMSI_NUE%TYPE;
                LV_EV_IMEI                                          ICC_MOVIMIENTO.IMEI%TYPE;
                LV_EV_IMEI_NUE                              ICC_MOVIMIENTO.IMEI_NUE%TYPE;
                LV_EV_ICC                                           ICC_MOVIMIENTO.ICC%TYPE;
                LV_EV_ICC_NUE                               ICC_MOVIMIENTO.ICC_NUE%TYPE;
                ln_atlantatida          NUMBER;
                ln_existe               NUMBER;
                LV_COD_PLANTARIF        GA_INTARCEL.COD_PLANTARIF%TYPE;
                LV_FEC_HASTA            GA_INTARCEL.FEC_HASTA%TYPE;
        BEGIN
                sn_cod_retorno  := 0;
                sv_mens_retorno := NULL;
                sn_num_evento       := 0;

                LV_sSql:='num_abonado'||EO_VAL_BAJA_ATLANTIDA.NUM_ABONADO;

                                LN_EN_NUM_MOVIMIENTO                                    :=EO_VAL_BAJA_ATLANTIDA.NUM_MOVIMIENTO;
                                LN_EN_NUM_ABONADO                                       :=EO_VAL_BAJA_ATLANTIDA.NUM_ABONADO;
                                LN_EN_COD_ESTADO                                        :=EO_VAL_BAJA_ATLANTIDA.COD_ESTADO;
                                LV_EV_COD_ACTABO                                        :=EO_VAL_BAJA_ATLANTIDA.COD_ACTABO;
                                LV_EV_COD_MODULO                                        :=EO_VAL_BAJA_ATLANTIDA.COD_MODULO;
                                LN_EN_NUM_INTENTOS                                      :=EO_VAL_BAJA_ATLANTIDA.NUM_INTENTOS;
                                LV_EN_COD_CENTRAL_NUE                                   :=EO_VAL_BAJA_ATLANTIDA.COD_CENTRAL_NUE;
                                LV_EV_DES_RESPUESTA                                     :=EO_VAL_BAJA_ATLANTIDA.DES_RESPUESTA;
                                LV_EN_COD_ACTUACION                                     :=EO_VAL_BAJA_ATLANTIDA.COD_ACTUACION;
                                LV_EV_TIP_TERMINAL_NUE                                  :=EO_VAL_BAJA_ATLANTIDA.TIP_TERMINAL_NUE;
                                LN_EN_NUM_MOVANT                                        :=EO_VAL_BAJA_ATLANTIDA.NUM_MOVANT;
                                LN_EN_NUM_CELULAR                                       :=EO_VAL_BAJA_ATLANTIDA.NUM_CELULAR;
                                LN_EN_NUM_MOVPOS                                        :=EO_VAL_BAJA_ATLANTIDA.NUM_MOVPOS;
                                LN_EV_NUM_SERIE                                         :=EO_VAL_BAJA_ATLANTIDA.NUM_SERIE;
                                LN_EV_NUM_PERSONAL                                      :=EO_VAL_BAJA_ATLANTIDA.NUM_PERSONAL;
                                LN_EN_NUM_CELULAR_NUE                                   :=EO_VAL_BAJA_ATLANTIDA.NUM_CELULAR_NUE;
                                LN_EV_NUM_SERIE_NUE                                     :=EO_VAL_BAJA_ATLANTIDA.NUM_SERIE_NUE;
                                LN_EV_NUM_PERSONAL_NUE                                  :=EO_VAL_BAJA_ATLANTIDA.NUM_PERSONAL_NUE;
                                LN_EV_NUM_MSNB                                          :=EO_VAL_BAJA_ATLANTIDA.NUM_MSNB;
                                LN_EV_NUM_MSNB_NUE                                      :=EO_VAL_BAJA_ATLANTIDA.NUM_MSNB_NUE;
                                LV_EV_COD_SUSPREHA                                      :=EO_VAL_BAJA_ATLANTIDA.COD_SUSPREHA;
                                LV_EV_COD_SERVICIOS                                     :=EO_VAL_BAJA_ATLANTIDA.COD_SERVICIOS;
                                LV_EV_NUM_MIN                                           :=EO_VAL_BAJA_ATLANTIDA.NUM_MIN;
                                LV_EV_NUM_MIN_NUE                                       :=EO_VAL_BAJA_ATLANTIDA.NUM_MIN_NUE;
                                LV_EV_STA                                               :=EO_VAL_BAJA_ATLANTIDA.STA;
                                LV_EN_COD_MENSAJE                                       :=EO_VAL_BAJA_ATLANTIDA.COD_MENSAJE;

								-- INICIO RRG 05-03-2009 COL 77303
                                --SN_COD_CLIENTE                                          :=LN_EN_NUM_CELULAR_NUE;
								-- lo de arriba es ridiculo - proyecto CPU
								select cod_cliente
								into SN_COD_CLIENTE
								from ga_abocel
								where num_abonado = LN_EN_NUM_ABONADO;


								LV_sSql:= LV_sSql || ' cod_cliente:' || SN_COD_CLIENTE;

								-- FIN RRG 05-03-2009 COL 77303

                                ln_existe:=0;

                                BEGIN

                                SELECT COUNT(1) INTO LN_EXISTE
                                FROM GA_ABOCEL A
                                WHERE  A.COD_CLIENTE = SN_COD_CLIENTE
                                AND COD_SITUACION NOT IN ('BAA','BAP', 'TAP' );

                                EXCEPTION
                                    WHEN  no_data_found then
                                            ln_existe:=0;
                                END;


                                SELECT  MAX(FEC_HASTA)
                                INTO LV_FEC_HASTA FROM GA_INTARCEL
                                WHERE COD_CLIENTE  = SN_COD_CLIENTE;

                                SELECT  COD_PLANTARIF
                                INTO LV_COD_PLANTARIF FROM GA_INTARCEL
                                WHERE COD_CLIENTE  = SN_COD_CLIENTE
                                AND FEC_HASTA =LV_FEC_HASTA
                                AND ROWNUM=1;


                                ln_atlantatida:=0;

                                SELECT count(1) into ln_atlantatida FROM gad_servsup_plan b
                                WHERE b.cod_plantarif = LV_COD_PLANTARIF
                                AND cod_servicio in  (SELECT c.COD_VALOR
                                                      FROM   ged_codigos c
                                                      WHERE  cod_modulo = 'GA'
                                                      AND  nom_tabla = 'GAD_SERVSUP_PLAN'
                                                      AND  nom_columna = 'COD_SERVICIO');


                                if (ln_atlantatida> 0 and Ln_existe= 0) then
                                       SN_EXISTE:=1;
                                else
                                       RAISE ERROR_EJECUCION;
                                end if;


                                /*
                                LV_sSql:='PV_OBTIENEINFO_ATLANTIDA_PG.PV_CLIENTEESATLANTIDA_FN(SN_COD_CLIENTE); ';
                                SN_EXISTE:=PV_OBTIENEINFO_ATLANTIDA_PG.PV_CLIENTEESATLANTIDA_FN(SN_COD_CLIENTE);
                                IF SN_EXISTE=0 THEN
                                   RAISE ERROR_EJECUCION;
                                END IF;
                                */


                                EO_VAL_BAJA_ATLANTIDA.PARAM1_MENS:=to_char(SN_EXISTE);


                                LV_EV_NOM_USUARORA                                      :=EO_VAL_BAJA_ATLANTIDA.NOM_USUARORA;
                                LD_EV_FEC_INGRESO                                       :=EO_VAL_BAJA_ATLANTIDA.FEC_INGRESO;
                                LV_EV_TIP_TERMINAL                                      :=EO_VAL_BAJA_ATLANTIDA.TIP_TERMINAL;
                                LV_EN_COD_CENTRAL                                       :=EO_VAL_BAJA_ATLANTIDA.COD_CENTRAL;
                                LD_EV_FEC_LECTURA                                       :=EO_VAL_BAJA_ATLANTIDA.FEC_LECTURA;
                                LN_EN_IND_BLOQUEO                                       :=EO_VAL_BAJA_ATLANTIDA.IND_BLOQUEO;
                                LD_EV_FEC_EJECUCION                                     :=EO_VAL_BAJA_ATLANTIDA.FEC_EJECUCION;
                                LV_EV_PARAM1_MENS                                       :=SN_EXISTE;
                                LV_EV_PARAM2_MENS                                       :=EO_VAL_BAJA_ATLANTIDA.PARAM2_MENS;
                                LV_EV_PARAM3_MENS                                       :=EO_VAL_BAJA_ATLANTIDA.PARAM3_MENS;
                                LV_EV_PLAN                                                      :=EO_VAL_BAJA_ATLANTIDA.COD_PLAN_ACTUAL;
                                LN_EN_CARGA                                                     :=EO_VAL_BAJA_ATLANTIDA.CARGA;
                                LN_EN_VALOR_PLAN                                        :=EO_VAL_BAJA_ATLANTIDA.VALOR_PLAN;
                                LV_EV_PIN                                                       :=EO_VAL_BAJA_ATLANTIDA.PIN;
                                LD_EV_FEC_EXPIRA                                        :=EO_VAL_BAJA_ATLANTIDA.FEC_EXPIRA;
                                LV_EV_DES_MENSAJE                                       :=EO_VAL_BAJA_ATLANTIDA.DES_MENSAJE;
                                LV_EV_COD_PIN                                           :=EO_VAL_BAJA_ATLANTIDA.COD_PIN;
                                LN_EV_COD_IDIOMA                                        :=EO_VAL_BAJA_ATLANTIDA.COD_IDIOMA;
                                LN_EN_COD_ENRUTAMIENTO                          :=EO_VAL_BAJA_ATLANTIDA.COD_ENRUTAMIENTO;
                                LN_EN_TIP_ENRUTAMIENTO                          :=EO_VAL_BAJA_ATLANTIDA.TIP_ENRUTAMIENTO;
                                LV_EV_DES_ORIGEN_PIN                            :=EO_VAL_BAJA_ATLANTIDA.DES_ORIGEN_PIN;
                                LN_EN_NUM_LOTE_PIN                                      :=EO_VAL_BAJA_ATLANTIDA.NUM_LOTE_PIN;
                                LN_EV_NUM_SERIE_PIN                                     :=EO_VAL_BAJA_ATLANTIDA.NUM_SERIE_PIN;
                                LV_EV_TIP_TECNOLOGIA                            :=EO_VAL_BAJA_ATLANTIDA.TIP_TECNOLOGIA;
                                LV_EV_IMSI                                                      :=EO_VAL_BAJA_ATLANTIDA.IMSI;
                                LV_EV_IMSI_NUE                                          :=EO_VAL_BAJA_ATLANTIDA.IMSI_NUE;
                                LV_EV_IMEI                                                      :=EO_VAL_BAJA_ATLANTIDA.IMEI;
                                LV_EV_IMEI_NUE                                          :=EO_VAL_BAJA_ATLANTIDA.IMEI_NUE;
                                LV_EV_ICC                                                       :=EO_VAL_BAJA_ATLANTIDA.ICC;
                                LV_EV_ICC_NUE                                           :=EO_VAL_BAJA_ATLANTIDA.ICC_NUE;

                                PV_FACHADA_ACTRESPUESTA_PG.PV_FACHADA_VB_PR (LN_EN_NUM_MOVIMIENTO,
                                                                                                        LN_EN_NUM_ABONADO,
                                                                                                        LN_EN_COD_ESTADO,
                                                                                                        LV_EV_COD_ACTABO,
                                                                                                        LV_EV_COD_MODULO,
                                                                                                        LN_EN_NUM_INTENTOS,
                                                                                                        LV_EN_COD_CENTRAL_NUE,
                                                                                                        LV_EV_DES_RESPUESTA,
                                                                                                        LV_EN_COD_ACTUACION,
                                                                                                        LV_EV_NOM_USUARORA,
                                                                                                        LD_EV_FEC_INGRESO,
                                                                                                        LV_EV_TIP_TERMINAL,
                                                                                                        LV_EN_COD_CENTRAL,
                                                                                                        LD_EV_FEC_LECTURA,
                                                                                                        LN_EN_IND_BLOQUEO,
                                                                                                        LD_EV_FEC_EJECUCION,
                                                                                                        LV_EV_TIP_TERMINAL_NUE,
                                                                                                        LN_EN_NUM_MOVANT,
                                                                                                        LN_EN_NUM_CELULAR,
                                                                                                        LN_EN_NUM_MOVPOS,
                                                                                                        LN_EV_NUM_SERIE,
                                                                                                        LN_EV_NUM_PERSONAL,
                                                                                                        LN_EN_NUM_CELULAR_NUE,
                                                                                                        LN_EV_NUM_SERIE_NUE,
                                                                                                        LN_EV_NUM_PERSONAL_NUE,
                                                                                                        LN_EV_NUM_MSNB,
                                                                                                        LN_EV_NUM_MSNB_NUE,
                                                                                                        LV_EV_COD_SUSPREHA,
                                                                                                        LV_EV_COD_SERVICIOS,
                                                                                                        LV_EV_NUM_MIN,
                                                                                                        LV_EV_NUM_MIN_NUE,
                                                                                                        LV_EV_STA,
                                                                                                        LV_EN_COD_MENSAJE,
                                                                                                        LV_EV_PARAM1_MENS,
                                                                                                        LV_EV_PARAM2_MENS,
                                                                                                        LV_EV_PARAM3_MENS,
                                                                                                        LV_EV_PLAN,
                                                                                                        LN_EN_CARGA,
                                                                                                        LN_EN_VALOR_PLAN,
                                                                                                        LV_EV_PIN,
                                                                                                        LD_EV_FEC_EXPIRA,
                                                                                                        LV_EV_DES_MENSAJE,
                                                                                                        LV_EV_COD_PIN,
                                                                                                        LN_EV_COD_IDIOMA,
                                                                                                        LN_EN_COD_ENRUTAMIENTO,
                                                                                                        LN_EN_TIP_ENRUTAMIENTO,
                                                                                                        LV_EV_DES_ORIGEN_PIN,
                                                                                                        LN_EN_NUM_LOTE_PIN,
                                                                                                        LN_EV_NUM_SERIE_PIN,
                                                                                                        LV_EV_TIP_TECNOLOGIA,
                                                                                                        LV_EV_IMSI,
                                                                                                        LV_EV_IMSI_NUE,
                                                                                                        LV_EV_IMEI,
                                                                                                        LV_EV_IMEI_NUE,
                                                                                                        LV_EV_ICC,
                                                                                                        LV_EV_ICC_NUE);

        EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := ' PV_VALIDA_BAJA_ATLANTIDA_PR(1); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_VALIDA_BAJA_ATLANTIDA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_VALIDA_BAJA_ATLANTIDA_PR(2); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_VALIDA_BAJA_ATLANTIDA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_VALIDA_BAJA_ATLANTIDA_PR(3); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_VALIDA_BAJA_ATLANTIDA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_VALIDA_BAJA_ATLANTIDA_PR;

------------------------------------------------------------------------------------------------------
FUNCTION PV_OBTIENE_CODTIPLAN_PLAN_FN(EO_CONS_PREPAGOS    IN                PV_CONS_PREPAGOS_QT,
                                                              SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                              SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                              SN_num_evento      OUT NOCOPY        ge_errores_pg.evento)
        RETURN BOOLEAN
        AS
/*
        <Documentacion TipoDoc = "Funcion">
        <Elemento Nombre = " PV_OBTIENE_CODTIPLAN_PLAN_FN "
         Lenguaje="PL/SQL" Fecha="13-07-2007"
         Versión"1.0.0" Diseñador"****"
         Programador="" Ambiente="BD ORACLE">
        <Retorno>NA</Retorno>
        <Descripcion>   FUNCION BOOLEAN QUE VALIDA SI EXISTE EL CODIGO TIPO DE PLAN  </Descripcion>
        <Parametros>
        <Entrada>
                        <param nom="ta_plantarif.COD_TIPLAN " Tipo="VARCHAR(5)" </param>>
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
        LV_des_error                    ge_errores_pg.DesEvent;
        LV_sSql                                 ge_errores_pg.vQuery;
        ERROR_EJECUCION                 EXCEPTION;
        EO_GED_PARAMETROS               PV_GED_PARAMETROS_QT;
        SV_COD_TIPPLAN                  ta_plantarif.COD_TIPLAN%TYPE;

        BEGIN
                sn_cod_retorno   := 0;
            sv_mens_retorno  := NULL;
            sn_num_evento        := 0;
                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;

        EO_GED_PARAMETROS.NOM_PARAMETRO:=CV_TipPlanPrepago;
                EO_GED_PARAMETROS.COD_MODULO   :=CV_cod_modulo;
                EO_GED_PARAMETROS.COD_PRODUCTO :=CN_producto;
                EO_GED_PARAMETROS.VAL_PARAMETRO:= NULL;
                PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR (EO_GED_PARAMETROS,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                IF SN_cod_retorno <> 0 THEN
                   RAISE ERROR_EJECUCION;
                END IF;

                        LV_sSql:= '     SELECT COD_TIPLAN';
                        LV_sSql:= LV_sSql || '  FROM TA_PLANTARIF';
                        LV_sSql:= LV_sSql || '  WHERE COD_PLANTARIF = '||EO_CONS_PREPAGOS.COD_PLANTARIF_ACTUAL;

                        SELECT COD_TIPLAN
                        INTO SV_COD_TIPPLAN
                        FROM TA_PLANTARIF
                        WHERE COD_PLANTARIF = EO_CONS_PREPAGOS.COD_PLANTARIF_ACTUAL;

                IF SV_COD_TIPPLAN = EO_GED_PARAMETROS.VAL_PARAMETRO Then
                        RETURN TRUE;
                ELSE
                    RETURN FALSE;
                END IF;

    EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_OBTIENE_CODTIPLAN_PLAN_FN('||EO_CONS_PREPAGOS.COD_PLANTARIF_ACTUAL||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_CODTIPLAN_PLAN_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 282;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_CODTIPLAN_PLAN_FN('||EO_CONS_PREPAGOS.COD_PLANTARIF_ACTUAL||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_CODTIPLAN_PLAN_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
    WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_CODTIPLAN_PLAN_FN('||EO_CONS_PREPAGOS.COD_PLANTARIF_ACTUAL||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_CODTIPLAN_PLAN_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;

END PV_OBTIENE_CODTIPLAN_PLAN_FN;

------------------------------------------------------------------------------------------------------
FUNCTION PV_bOBTIENE_IMPTARIFA_PLA_FN(EO_CONS_PREPAGOS  IN                      PV_CONS_PREPAGOS_QT,
                                                                         SN_ObtIMP_TARIFA   OUT NOCOPY  ga_tarifas.imp_tarifa%TYPE,
                                                                 SN_cod_retorno     OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                                 SV_mens_retorno    OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                                 SN_num_evento      OUT NOCOPY  ge_errores_pg.evento)
        RETURN BOOLEAN
        IS
        /*
        <Documentacion TipoDoc = "Funcion">
        <Elemento Nombre = " PV_bOBTIENE_IMPTARIFA_PLA_FN  "
         Lenguaje="PL/SQL" Fecha="13-07-2007"
         Versión"1.0.0" Diseñador Maricel "****"
         Programador="" Ambiente="BD ORACLE">
        <Retorno>NA</Retorno>
        <Descripcion>   FUNCION BOOLEAN QUE VALIDA SI EXISTE PV_bOBTIENE_IMPTARIFA_PLA_FN   </Descripcion>
        <Parametros>
        <Entrada>
                        <param nom="ta_plantarif.COD_TIPLAN " Tipo="VARCHAR(5)" </param>>
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
        LV_des_error                    ge_errores_pg.DesEvent;
        LV_sSql                                 ge_errores_pg.vQuery;
        LN_imp_tarifa                   ga_tarifas.imp_tarifa%TYPE;
        ERROR_EJECUCION                 EXCEPTION;

        BEGIN
                sn_cod_retorno   := 0;
            sv_mens_retorno  := NULL;
            sn_num_evento        := 0;

                LV_sSql:='';
                LV_sSql:=LV_sSql||' SELECT  b.imp_tarifa                 ';
                LV_sSql:=LV_sSql||' INTO         SN_ObtIMP_TARIFA        ';
                LV_sSql:=LV_sSql||' FROM         ga_actuaserv     a, ';
                LV_sSql:=LV_sSql||'              ga_tarifas       b, ';
                LV_sSql:=LV_sSql||'              ga_servicios     c, ';
                LV_sSql:=LV_sSql||'              ge_monedas       d  ';
                LV_sSql:=LV_sSql||'     WHERE   ';
                LV_sSql:=LV_sSql||'                a.cod_producto = '||CN_producto||' ';
                LV_sSql:=LV_sSql||'                AND   a.cod_actabo   = '||EO_CONS_PREPAGOS.COD_ACTABO||' ';
                LV_sSql:=LV_sSql||'                AND   a.cod_tipserv  = '||CV_codTipServ||' ';
                LV_sSql:=LV_sSql||'                AND   a.cod_servicio = '||'16'||' ';
                LV_sSql:=LV_sSql||'                AND   b.cod_producto = a.cod_producto  ';
                LV_sSql:=LV_sSql||'                AND   b.cod_actabo   = a.cod_actabo    ';
                LV_sSql:=LV_sSql||'                AND   b.cod_tipserv  = a.cod_tipserv   ';
                LV_sSql:=LV_sSql||'                AND   b.cod_servicio = a.cod_servicio  ';
                LV_sSql:=LV_sSql||'                AND   b.cod_planserv = '||EO_CONS_PREPAGOS.COD_PLANSERV||' ';
                LV_sSql:=LV_sSql||'                AND   SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)  ';
                LV_sSql:=LV_sSql||'                AND   c.cod_producto = a.cod_producto ';
                LV_sSql:=LV_sSql||'                AND   c.cod_servicio = a.cod_servicio ';
                LV_sSql:=LV_sSql||'                AND   d.cod_moneda   = b.cod_moneda;  ';

                  SELECT  b.imp_tarifa
                   INTO          SN_ObtIMP_TARIFA
                    FROM         ga_actuaserv     a,
                                         ga_tarifas       b,
                                         ga_servicios     c,
                                         ge_monedas       d
                    WHERE
                                   a.cod_producto = CN_producto                                                  --  CN_producto   =  1
                           AND   a.cod_actabo   = EO_CONS_PREPAGOS.COD_ACTABO                    --  VARCHAR2(2)   =  CE   o   SS
                           AND   a.cod_tipserv  = CV_codTipServ                                          --  CV_codTipServ = '1'
                                   AND   a.cod_servicio = '16'       -- PENDIENTE OJO   VER CON MARICEL    2007-07-17  MARTES
                           AND   b.cod_producto = a.cod_producto
                           AND   b.cod_actabo   = a.cod_actabo
                           AND   b.cod_tipserv  = a.cod_tipserv
                           AND   b.cod_servicio = a.cod_servicio
                           AND   b.cod_planserv = EO_CONS_PREPAGOS.COD_PLANSERV   --VARCHAR2(3)   =  01  O  02
                           AND   SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)
                           AND   c.cod_producto = a.cod_producto
                           AND   c.cod_servicio = a.cod_servicio
                           AND   d.cod_moneda   = b.cod_moneda;

                RETURN TRUE;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
                  RETURN FALSE;
    WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_bOBTIENE_IMPTARIFA_PLA_FN('||EO_CONS_PREPAGOS.COD_ACTABO||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_bOBTIENE_IMPTARIFA_PLA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;

END  PV_bOBTIENE_IMPTARIFA_PLA_FN;

------------------------------------------------------------------------------------------------------
FUNCTION PV_OBTIENE_IMPTO_FN (EO_CONS_PREPAGOS  IN                      PV_CONS_PREPAGOS_QT,
                                                  SN_cod_retorno     OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                  SV_mens_retorno    OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                  SN_num_evento      OUT NOCOPY ge_errores_pg.evento)
        RETURN NUMBER
        IS
        /*
        <Documentacion TipoDoc = "Funcion">
        <Elemento Nombre = " PV_OBTIENE_IMPTO_FN   "
         Lenguaje="PL/SQL" Fecha="13-07-2007"
         Versión"1.0.0" Diseñador Maricel "****"
         Programador="" Ambiente="BD ORACLE">
        <Retorno>NA</Retorno>
        <Descripcion>   FUNCION BOOLEAN     </Descripcion>
        <Parametros>
        <Entrada>
                        <param nom=" EO_CONS_PREPAGOS.NUM_ABONADO   " Tipo="NUMBER(8)  " </param>>
                        <param nom=" EO_CONS_PREPAGOS.COD_ACTABO    " Tipo="VARCHAR2(3)" </param>>
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
        LV_des_error                                       ge_errores_pg.DesEvent;
        LV_sSql                                                    ge_errores_pg.vQuery;
        LN_imp_tarifa                                      ga_tarifas.imp_tarifa%TYPE;
        LV_ObtCODGRUPO_AL_TECNOLOGIA       al_tecnologia.COD_GRUPO%Type;        --  varchar2(07)
        LV_cdma                                                    VARCHAR2(20);
        LV_gsm                                                     VARCHAR2(20);
        LV_Aplicaimpto                                     VARCHAR2(20);
        ValorImpto                                                 NUMBER (14,4);
        LV_ValorImpto                                      VARCHAR2(16);
        ERROR_EJECUCION                                    EXCEPTION;
        ERROR_GENERICO                                     EXCEPTION;
        EO_GED_PARAMETROS                                  PV_GED_PARAMETROS_QT;

        BEGIN

                sn_cod_retorno   := 0;
            sv_mens_retorno  := NULL;
            sn_num_evento        := 0;

                LV_ObtCODGRUPO_AL_TECNOLOGIA:=NULL;
                LV_ObtCODGRUPO_AL_TECNOLOGIA:=GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(EO_CONS_PREPAGOS.COD_TECNOLOGIA);
                IF LV_ObtCODGRUPO_AL_TECNOLOGIA = 'ERROR' THEN
                        SN_cod_retorno := 1363;
                    RAISE ERROR_GENERICO;
                END IF;

                IF LV_ObtCODGRUPO_AL_TECNOLOGIA IS NOT NULL THEN
                                        EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                        EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_GrupoTecGsm;
                                        EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                        EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                                        PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                                        LV_gsm := EO_GED_PARAMETROS.VAL_PARAMETRO;
                                        IF SN_cod_retorno <> 0 THEN
                                   RAISE ERROR_EJECUCION;
                                END IF;

                                        EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                        EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_GrupoTecDma;
                                        EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                        EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                                        PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                                        LV_cdma := EO_GED_PARAMETROS.VAL_PARAMETRO;
                                        IF SN_cod_retorno <> 0 THEN
                                   RAISE ERROR_EJECUCION;
                                END IF;

                        IF  (LV_ObtCODGRUPO_AL_TECNOLOGIA = LV_gsm) THEN
                                                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                                EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_AplicaimptoGsm;
                        ELSE
                           IF  (LV_ObtCODGRUPO_AL_TECNOLOGIA = LV_cdma) THEN
                                                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                                EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_AplicaimptoTdma;
                           END IF;
                        END IF;


                        EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                        EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                        PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                        IF SN_cod_retorno <> 0 THEN
                           RAISE ERROR_EJECUCION;
                END IF;
                        IF EO_GED_PARAMETROS.VAL_PARAMETRO IS NOT NULL Then
                                   IF EO_GED_PARAMETROS.VAL_PARAMETRO = '1' Then
                                                --  llama a Funcion   PV_MTONBPORC_FN   existente

                                        LV_ValorImpto := PV_MTONBPORC_FN (null, null, null, null, EO_CONS_PREPAGOS.NUM_ABONADO);
                                                -- esto reemplaza el  (If IsNumeric(ValorImpto) Then )
                                                ValorImpto:=0;
                                                SELECT to_number(decode(instr(translate(LV_ValorImpto,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ','XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),'X'),0,LV_ValorImpto,'0'))
                                                INTO ValorImpto
                                                FROM DUAL;

                                                RETURN ValorImpto;

                                    ELSE
                                                IF EO_GED_PARAMETROS.VAL_PARAMETRO = '0' THEN
                                               RETURN 0;
                                            END IF;
                                        END IF;
                        END IF;
                END IF;

    EXCEPTION
        WHEN ERROR_GENERICO THEN
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_IMPTO_FN('||EO_CONS_PREPAGOS.COD_TECNOLOGIA||','||EO_CONS_PREPAGOS.NUM_ABONADO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_ValNroCELULAR_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN 0;
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_OBTIENE_IMPTO_FN('||EO_CONS_PREPAGOS.COD_TECNOLOGIA||','||EO_CONS_PREPAGOS.NUM_ABONADO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_IMPTO_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN 0;
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_IMPTO_FN('||EO_CONS_PREPAGOS.COD_TECNOLOGIA||','||EO_CONS_PREPAGOS.NUM_ABONADO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_IMPTO_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN 0;
    WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_IMPTO_FN('||EO_CONS_PREPAGOS.COD_TECNOLOGIA||','||EO_CONS_PREPAGOS.NUM_ABONADO||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_IMPTO_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN 0;
END  PV_OBTIENE_IMPTO_FN;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONSULTA_PREPAGOS_PR (EO_CONS_PREPAGOS     IN OUT  NOCOPY   PV_CONS_PREPAGOS_QT,
                                                                   SN_cod_retorno          OUT  NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                               SV_mens_retorno         OUT  NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                               SN_num_evento           OUT  NOCOPY       ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_CONSULTA_PREPAGOS_PR"
              Lenguaje="PL/SQL"
              Fecha="13-07-2007"
              Versión="La del package"
              Diseñador="Maricel"
              Programador="CEC"
              Ambiente Desarrollo="BD oracle ">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param EO_CONS_PREPAGOS ="" Tipo="estructura"></param>>
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
        LV_des_error                                       ge_errores_pg.DesEvent;
        LV_sSql                                                    ge_errores_pg.vQuery;
        LV_cod_tiplan                                      ga_tarifas.imp_tarifa%Type;                  -- number (14,4)
    LN_ObtIMP_TARIFA                               ga_tarifas.imp_tarifa%Type;              -- number (14,4)
        LV_ObtCODGRUPO_AL_TECNOLOGIA       al_tecnologia.COD_GRUPO%Type;        --  varchar2(07)
        LV_SALDO_CALCULADO                                 ga_tarifas.imp_tarifa%Type;                  -- number (14,4)
        LV_Obt_IMPTO                                       ga_tarifas.imp_tarifa%Type;                  -- number (14,4)
        LV_IndConSaldoPlan                                 VARCHAR2(20);
        lb_IndImpTarifa                                    BOOLEAN;
        LB_CODTIPLAN_PLAN                                  BOOLEAN;
        ERROR_EJECUCION                                    EXCEPTION;
        ERROR_GENERICO                                     EXCEPTION;
        EO_GED_PARAMETROS                                  PV_GED_PARAMETROS_QT;
        LV_cdma                                                    VARCHAR2(20);
        LV_gsm                                                     VARCHAR2(20);


        BEGIN
                sn_cod_retorno   := 0;
            sv_mens_retorno  := NULL;
            sn_num_evento        := 0;
                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;

                LB_CODTIPLAN_PLAN:=PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_CODTIPLAN_PLAN_FN(EO_CONS_PREPAGOS, SN_cod_retorno, SV_mens_retorno,SN_num_evento);
                IF LB_CODTIPLAN_PLAN = TRUE THEN
                                EO_GED_PARAMETROS := PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                EO_GED_PARAMETROS.VAL_PARAMETRO:= NULL;
                                EO_GED_PARAMETROS.DES_PARAMETRO:= NULL;
                                EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_IndConSaldoPp;
                                EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                                PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                                IF SN_cod_retorno <> 0 THEN
                           RAISE ERROR_EJECUCION;
                        END IF;


                                IF EO_GED_PARAMETROS.VAL_PARAMETRO  = 'TRUE' then
                                     IF PV_bOBTIENE_IMPTARIFA_PLA_FN(EO_CONS_PREPAGOS, LN_ObtIMP_TARIFA, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                                                                LV_ObtCODGRUPO_AL_TECNOLOGIA:=NULL;
                                                                LV_ObtCODGRUPO_AL_TECNOLOGIA:= GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(EO_CONS_PREPAGOS.COD_TECNOLOGIA);
                                                                IF LV_ObtCODGRUPO_AL_TECNOLOGIA = 'ERROR' THEN
                                                                        SN_cod_retorno := 1363;
                                                                    RAISE ERROR_GENERICO;
                                                                END IF;

                                                                IF LV_ObtCODGRUPO_AL_TECNOLOGIA IS NOT NULL Then
                                                                                        EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                                                                        EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_GrupoTecGsm;
                                                                                        EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                                                                        EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                                                                                        PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                                                                                    LV_gsm := EO_GED_PARAMETROS.VAL_PARAMETRO;
                                                                                        IF SN_cod_retorno <> 0 THEN
                                                                                   RAISE ERROR_EJECUCION;
                                                                                END IF;

                                                                                        EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                                                                        EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_GrupoTecDma;
                                                                                        EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                                                                        EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                                                                                        PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                                                                                        LV_cdma := EO_GED_PARAMETROS.VAL_PARAMETRO;
                                                                                        IF SN_cod_retorno <> 0 THEN
                                                                                   RAISE ERROR_EJECUCION;
                                                                                END IF;

                                                                        IF  (LV_ObtCODGRUPO_AL_TECNOLOGIA = LV_gsm) THEN
                                                                                        EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                                                                        EO_GED_PARAMETROS.VAL_PARAMETRO:= NULL;
                                                                                        EO_GED_PARAMETROS.DES_PARAMETRO:= NULL;
                                                                                        EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_ConsSaldoGsm;
                                                                                        EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                                                                        EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                                                                                        PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                                                                                        IF SN_cod_retorno <> 0 THEN
                                                                                   RAISE ERROR_EJECUCION;
                                                                                END IF;
                                                                        ELSE
                                                                           IF  (LV_ObtCODGRUPO_AL_TECNOLOGIA = LV_cdma) THEN
                                                                                        EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                                                                        EO_GED_PARAMETROS.VAL_PARAMETRO:= NULL;
                                                                                        EO_GED_PARAMETROS.DES_PARAMETRO:= NULL;
                                                                                        EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_ConsSaldoTdma;
                                                                                        EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                                                                        EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                                                                                        PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                                                                                        IF SN_cod_retorno <> 0 THEN
                                                                                   RAISE ERROR_EJECUCION;
                                                                                END IF;
                                                                           END IF;
                                                                    END IF;

                                                                IF EO_GED_PARAMETROS.VAL_PARAMETRO = 'TRUE' THEN
                                                                            IF EO_CONS_PREPAGOS.VN_SALDO > 0 THEN
                                                                                LV_Obt_IMPTO := PV_OBTIENE_IMPTO_FN(EO_CONS_PREPAGOS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);   /* es una función */
                                                                                LV_SALDO_CALCULADO:= EO_CONS_PREPAGOS.VN_SALDO * ((LV_Obt_IMPTO / 100) + 1);
                                                                                            IF  LN_ObtIMP_TARIFA > LV_SALDO_CALCULADO THEN
                                                                                                         SN_cod_retorno := 9998;
                                                                                                         RAISE ERROR_GENERICO;
                                                                                        END IF;
                                                                            END IF;
                                                                        END IF;
                                                    END IF;
                            END IF;
                        END IF;
                END IF;

        EXCEPTION
        WHEN ERROR_GENERICO THEN
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_CONSULTA_PREPAGOS_PR('||EO_CONS_PREPAGOS.VN_SALDO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_CONSULTA_PREPAGOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_CONSULTA_PREPAGOS_PR('||EO_CONS_PREPAGOS.VN_SALDO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_CONSULTA_PREPAGOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_CONSULTA_PREPAGOS_PR('||EO_CONS_PREPAGOS.VN_SALDO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_CONSULTA_PREPAGOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CONSULTA_PREPAGOS_PR;

-----------------------------------------------------------------------------------------------------
FUNCTION PV_OBTIENE_CODINTERNO_PLAN_FN (SV_COD_PLATAFORMA       IN                              al_codigo_externo.COD_PLATAFORMA%TYPE,
                                                                                SV_TIP_CODIGO           IN                              al_codigo_externo.TIP_CODIGO%TYPE,
                                                                                SV_CODIGO_EXTERNO       IN                              al_codigo_externo.CODIGO_EXTERNO%TYPE,
                                                                                SV_CODIGO_INTERNO   IN OUT NOCOPY       al_codigo_externo.CODIGO_INTERNO%TYPE,
                                                                    SN_cod_retorno         OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                    SV_mens_retorno        OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                    SN_num_evento          OUT NOCOPY   ge_errores_pg.evento)
        RETURN BOOLEAN
        AS
        /*
        <Documentacion TipoDoc = "Funcion">
        <Elemento Nombre = " PV_OBTIENE_CODINTERNO_PLAN_FN "
         Lenguaje="PL/SQL" Fecha="13-07-2007"
         Versión"1.0.0" Diseñador"****"
         Programador="" Ambiente="BD ORACLE">
        <Retorno>NA</Retorno>
        <Descripcion>   FUNCION BOOLEAN FUNCION  QUE RESCATA CODIGO INTERNO DEL PLANTARIFARIO   </Descripcion>
        <Parametros>
        <Entrada>
                        <param SV_COD_PLATAFORMA =" al_codigo_externo.COD_PLATAFORMA  " Tipo = "VARCHAR(20)" </param>>
                        <param SV_TIP_CODIGO     =" al_codigo_externo.TIP_CODIGO      " Tipo = "VARCHAR(05)" </param>>
                        <param SV_CODIGO_EXTERNO =" al_codigo_externo.CODIGO_EXTERNO  " Tipo = "VARCHAR(20)" </param>>
                        <param SV_CODIGO_INTERNO =" al_codigo_externo.CODIGO_INTERNO  " Tipo = "VARCHAR(20)" </param>>
        </Entrada>
        <Salida>
                        <param SV_CODIGO_INTERNO =" al_codigo_externo.CODIGO_INTERNO  " Tipo = "VARCHAR(20)" </param>>
           <param SN_cod_retorno     ="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno         </param>>
           <param SV_mens_retorno    ="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno       </param>>
           <param SN_num_evento      ="SN_num_evento" Tipo="NUMERICO">Numero de Evento           </param>>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        */
        LV_des_error                    ge_errores_pg.DesEvent;
        LV_sSql                                 ge_errores_pg.vQuery;

        BEGIN
                sn_cod_retorno   := 0;
            sv_mens_retorno  := NULL;
            sn_num_evento        := 0;

                BEGIN

                        SELECT CODIGO_INTERNO
                        into SV_CODIGO_INTERNO
                        FROM AL_CODIGO_EXTERNO
                        WHERE
                                  CODIGO_EXTERNO =  SV_CODIGO_EXTERNO
                        AND   TIP_CODIGO         =  SV_TIP_CODIGO
                        AND   COD_PLATAFORMA =  SV_COD_PLATAFORMA;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                                SV_CODIGO_INTERNO:=SV_CODIGO_EXTERNO;
                END;
                IF SV_CODIGO_INTERNO IS NOT NULL  THEN
                                RETURN TRUE;
                ELSE
                                SV_CODIGO_INTERNO:= SV_CODIGO_EXTERNO;
                                RETURN TRUE;
                END IF;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_CODINTERNO_PLAN_FN('||SV_CODIGO_EXTERNO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_CODINTERNO_PLAN_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;
    WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_OBTIENE_CODINTERNO_PLAN_FN('||SV_CODIGO_EXTERNO||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_CODINTERNO_PLAN_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN FALSE;

END  PV_OBTIENE_CODINTERNO_PLAN_FN;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONSULTA_PREPAGOS_CelSer_PR (EO_CONS_PREPAGOS      IN OUT  NOCOPY   PV_CONS_PREPAGOS_QT,
                                                                                  SN_cod_retorno       OUT  NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                          SV_mens_retorno      OUT  NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                          SN_num_evento        OUT  NOCOPY       ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_CONSULTA_PREPAGOS_CelSer_PR"
              Lenguaje="PL/SQL"
              Fecha="13-07-2007"
              Versión="La del package"
              Diseñador="Maricel"
              Programador="CEC"
              Ambiente Desarrollo="BD oracle ">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param EO_CONS_PREPAGOS_CELSER ="" Tipo="estructura"></param>>
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
        LV_des_error                                       ge_errores_pg.DesEvent;
        LV_sSql                                                    ge_errores_pg.vQuery;

        LV_cod_tiplan                                      ta_plantarif.COD_TIPLAN%Type;
    LN_ObtIMP_TARIFA                               ga_tarifas.imp_tarifa%Type;
        LV_ObtCODGRUPO_AL_TECNOLOGIA       al_tecnologia.COD_GRUPO%Type;
        LV_Obt_IMPTO                                       ga_tarifas.imp_tarifa%Type;
        ERROR_EJECUCION                                    EXCEPTION;
        LB_CODIGO_INTERNO                                  BOOLEAN;
        EO_GED_PARAMETROS                                  PV_GED_PARAMETROS_QT;
        LV_gsm                                                     VARCHAR2(20);
        LV_cdma                                                    VARCHAR2(20);
        LV_CODIGO_EXTERNO                                  VARCHAR2(20);
        LV_CODIGO_INTERNO                                  VARCHAR2(20);
        LV_COD_PLATAFORMA                                  VARCHAR2(20);
        LV_TIP_CODIGO                                      VARCHAR2(20);
        LV_COD_PLANTARIF                           VARCHAR2(03);
    LV_DES_PLANTARIF                               VARCHAR2(30);

        BEGIN
                sn_cod_retorno   := 0;
            sv_mens_retorno  := NULL;
            sn_num_evento        := 0;

                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                EO_GED_PARAMETROS.VAL_PARAMETRO:= null;
                EO_GED_PARAMETROS.DES_PARAMETRO:= null;
                EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_Homologar;
                EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;

                LV_sSql:='';
                LV_sSql:=LV_sSql||'EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN; ';
                LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.NOM_PARAMETRO:= '||CV_Homologar ||'; ';
                LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.COD_MODULO   := '||CV_cod_modulo||'; ';
                LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.COD_PRODUCTO := '||CN_producto  ||'; ';
                LV_sSql:=LV_sSql||'PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,'||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                IF SN_cod_retorno>0 THEN
                                RAISE ERROR_EJECUCION;
                END IF;

                if EO_GED_PARAMETROS.VAL_PARAMETRO='FALSE'      THEN
                                        LV_ObtCODGRUPO_AL_TECNOLOGIA:=null;
                                        LV_sSql:='GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN('||EO_CONS_PREPAGOS.COD_TECNOLOGIA||');  ';
                                        LV_ObtCODGRUPO_AL_TECNOLOGIA:=GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(EO_CONS_PREPAGOS.COD_TECNOLOGIA);
                                        IF LV_ObtCODGRUPO_AL_TECNOLOGIA='ERROR' THEN
                                                RAISE ERROR_EJECUCION;
                                        END IF;

                                        EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                        EO_GED_PARAMETROS.VAL_PARAMETRO:= null;
                                        EO_GED_PARAMETROS.DES_PARAMETRO:= null;
                                        EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_GrupoTecGsm;
                                        EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                        EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;

                                        LV_sSql:='';
                                        LV_sSql:=LV_sSql||'EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN; ';
                                        LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.NOM_PARAMETRO:= '||CV_GrupoTecGsm||'; ';
                                        LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.COD_MODULO   := '||CV_cod_modulo ||'; ';
                                        LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.COD_PRODUCTO := '||CN_producto   ||'; ';
                                        LV_sSql:=LV_sSql||'PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,'||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                                        PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                                        IF SN_cod_retorno>0 THEN
                                           RAISE ERROR_EJECUCION;
                                        END IF;
                                        LV_gsm:=EO_GED_PARAMETROS.VAL_PARAMETRO;

                                        EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                        EO_GED_PARAMETROS.VAL_PARAMETRO:= null;
                                        EO_GED_PARAMETROS.DES_PARAMETRO:= null;
                                        EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_GrupoTecDma;
                                        EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                        EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;

                                        LV_sSql:='';
                                        LV_sSql:=LV_sSql||'EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN; ';
                                        LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.NOM_PARAMETRO:='|| CV_GrupoTecDma||'; ';
                                        LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.COD_MODULO   :='|| CV_cod_modulo ||'; ';
                                        LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.COD_PRODUCTO :='|| CN_producto   ||'; ';
                                        LV_sSql:=LV_sSql||'PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,'||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                                        PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                                        IF SN_cod_retorno>0 THEN
                                                                RAISE ERROR_EJECUCION;
                                        END IF;
                                        LV_cdma:=EO_GED_PARAMETROS.VAL_PARAMETRO;

                                        EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                        EO_GED_PARAMETROS.VAL_PARAMETRO:= null;
                                        EO_GED_PARAMETROS.DES_PARAMETRO:= null;
                                        EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                        EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                                        if  LV_ObtCODGRUPO_AL_TECNOLOGIA=LV_gsm Then
                                                        EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_PlatGsm;
                                                        LV_sSql:='';
                                                        LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.NOM_PARAMETRO:='||CV_PlatGsm||'; ';
                                                        LV_sSql:=LV_sSql||'PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,'||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                                                        PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                                                        IF SN_cod_retorno>0 THEN
                                                                        RAISE ERROR_EJECUCION;
                                                        END IF;
                                                        LV_COD_PLATAFORMA:=EO_GED_PARAMETROS.VAL_PARAMETRO;
                                        else
                                          if  LV_ObtCODGRUPO_AL_TECNOLOGIA=LV_cdma Then
                                                        EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_PlatCdma;
                                                        LV_sSql:='';
                                                        LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.NOM_PARAMETRO:='||CV_PlatCdma||'; ';
                                                        LV_sSql:=LV_sSql||'PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,'||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                                                        PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                                                        IF SN_cod_retorno>0 THEN
                                                                        RAISE ERROR_EJECUCION;
                                                        END IF;
                                                        LV_COD_PLATAFORMA:=EO_GED_PARAMETROS.VAL_PARAMETRO;
                                          end if;
                                        end if;

                                        IF LV_COD_PLATAFORMA Is Not Null THEN
                                                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                                EO_GED_PARAMETROS.VAL_PARAMETRO:= null;
                                                EO_GED_PARAMETROS.DES_PARAMETRO:= null;
                                                EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_TipCodigo;
                                                EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                                EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                                                LV_sSql:='';
                                                LV_sSql:=LV_sSql||'EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN; ';
                                                LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.NOM_PARAMETRO:='|| CV_TipCodigo||';';
                                                LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.COD_MODULO   :='|| CV_cod_modulo||';';
                                                LV_sSql:=LV_sSql||'EO_GED_PARAMETROS.COD_PRODUCTO :='|| CN_producto||';';
                                                LV_sSql:=LV_sSql||'PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,'||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||');';
                                                PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                                                LV_TIP_CODIGO:=EO_GED_PARAMETROS.VAL_PARAMETRO;
                                                IF SN_cod_retorno>0 THEN
                                                                RAISE ERROR_EJECUCION;
                                                END IF;

                                                IF EO_GED_PARAMETROS.VAL_PARAMETRO IS NOT NULL THEN


                                                        LV_CODIGO_INTERNO:=NULL;
                                                        LV_CODIGO_EXTERNO:=EO_CONS_PREPAGOS.COD_PLANTARIF_ACTUAL;
                                                        LB_CODIGO_INTERNO:=PV_OBTIENE_CODINTERNO_PLAN_FN (LV_COD_PLATAFORMA, LV_TIP_CODIGO, LV_CODIGO_EXTERNO, LV_CODIGO_INTERNO, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                                                        IF SN_cod_retorno>0 THEN
                                                                RAISE ERROR_EJECUCION;
                                                    END IF;
                                                        IF LB_CODIGO_INTERNO=TRUE OR  EO_CONS_PREPAGOS.COD_PLANTARIF_ACTUAL<>LV_CODIGO_INTERNO THEN
                                                                            SELECT COD_PLANTARIF,DES_PLANTARIF
                                                                                        INTO  LV_COD_PLANTARIF,LV_DES_PLANTARIF
                                                                            FROM PPD_PLANES
                                                                            WHERE COD_PLANTARIF = LV_CODIGO_EXTERNO
                                                                            AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
                                                   END IF;
                                       END IF;
                                END IF;
        End If;

        EXCEPTION
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_CONSULTA_PREPAGOS_CelSer_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_CONSULTA_PREPAGOS_CelSer_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_CONSULTA_PREPAGOS_CelSer_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_CONSULTA_PREPAGOS_CelSer_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_CONSULTA_PREPAGOS_CelSer_PR(''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_CONSULTA_PREPAGOS_CelSer_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CONSULTA_PREPAGOS_CelSer_PR;

------------------------------------------------------------------------------------------------------
        PROCEDURE PV_CONSULTA_LISTAACTIVAS_PR(EO_CONSALDO_ABONADO IN                    PV_CONSALDO_ABONADO_QT,
                                                                                  Cursor_GedCodigos              OUT NOCOPY     refCursor,
                                                                                  SN_cod_retorno         OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                                                                  SV_mens_retorno        OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                                                                  SN_num_evento          OUT NOCOPY             ge_errores_pg.evento)
        IS
         /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_CONSULTA_LISTAACTIVAS_PR "
              Lenguaje="PL/SQL"
              Fecha="26-07-2007"
              Versión="La del package"
              Diseñador=" Maricel "
              Programador=" CEC  "
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>  Metodo Consulta Lista Activa  </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_CONSALDO_ABONADO.COD_TECNOLOGIA" Tipo="estructura">estructura para datos  codigo tecnologia </param>>
                    <param nom="EO_CONSALDO_ABONADO.NUM_CELULAR"   Tipo="estructura">estructura para datos  Numero de Celular </param>>
                 </Entrada>
                 <Salida>
                    <param Cursor="Cursor_GedCodigos" Tipo="CURSOR">Retorno Cursor     </param>>
                    <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error                                        ge_errores_pg.DesEvent;
                LV_sSql                                                         ge_errores_pg.vQuery;
        BEGIN
                SN_cod_retorno  := 0;
                SV_mens_retorno := NULL;
                SN_num_evento   := 0;

                LV_sSql:='';
                LV_sSql:=LV_sSql||'OPEN Cursor_GedCodigos FOR SELECT cod_valor, des_valor FROM GED_CODIGOS ';
                LV_sSql:=LV_sSql||'WHERE NOM_TABLA   = '||'PPT_NUMEROFRECUENTE'||'  ';
                LV_sSql:=LV_sSql||'AND   NOM_COLUMNA = '||'IND_LISTA'||'; ';

                OPEN Cursor_GedCodigos FOR
                SELECT cod_valor, des_valor
                FROM GED_CODIGOS
                WHERE
                          NOM_TABLA   = 'PPT_NUMEROFRECUENTE'
                AND   NOM_COLUMNA = 'IND_LISTA';

        EXCEPTION
    WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_CONSULTA_LISTAACTIVAS_PR('||EO_CONSALDO_ABONADO.COD_TECNOLOGIA||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_CONSULTA_LISTAACTIVAS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_CONSULTA_LISTAACTIVAS_PR('||EO_CONSALDO_ABONADO.COD_TECNOLOGIA ||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_CONSULTA_LISTAACTIVAS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_CONSULTA_LISTAACTIVAS_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_INSERTA_MOVATL_PR (SO_ABONADO           IN OUT NOCOPY   GA_ABONADO_QT,
                                                            SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                            SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                            SN_num_evento       OUT NOCOPY   ge_errores_pg.evento)
IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_INSERTA_MOVATL_PR   "
              Lenguaje="PL/SQL"
              Fecha="08-08-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Metodo  :  Insertar  INSERTA_MOVATL   </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_ABONADO "                    Tipo="Estructura de Type ">   Datos de Estructura Type   </param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno"                         Tipo="NUMERICO">Codigo de Retorno                  </param>>
                    <param nom="SV_mens_retorno"                        Tipo="CARACTER">Mensaje de Retorno                 </param>>
                    <param nom="SN_num_evento"                          Tipo="NUMERICO">Numero de Evento                   </param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_des_error                            ge_errores_pg.DesEvent;
        LV_sSql                                         ge_errores_pg.vQuery;
        ERROR_EJECUCION                 EXCEPTION;
        LN_Num_abonado                          GA_ABOCEL.num_abonado%TYPE;
        LV_Codplan_destino                      GA_ABOCEL.cod_plantarif%TYPE;
        LN_cod_cliente                          GA_ABOCEL.cod_cliente%TYPE;
        LN_TipoParametro                        VARCHAR2(50);
        LN_insertook                            NUMBER(9);
 BEGIN
                sn_cod_retorno  := 0;
                sv_mens_retorno := NULL;
                sn_num_evento   := 0;

                LN_Num_abonado     := SO_ABONADO.NUM_ABONADO;
                LV_Codplan_destino := SO_ABONADO.COD_PLANTARIF;
                LN_cod_cliente     := SO_ABONADO.COD_CLIENTE;
                LN_TipoParametro   := SO_ABONADO.TIPOPARAM;
                LN_insertook       := SO_ABONADO.INSERTOOK;

                LV_sSql:='PV_OBTIENEINFO_ATLANTIDA_PG.PV_INSERTAMOV_ATL_PR('||LN_Num_abonado||','||LV_Codplan_destino||','||LN_cod_cliente||','||LN_TipoParametro||','||LN_insertook||'); ';
                PV_OBTIENEINFO_ATLANTIDA_PG.PV_INSERTAMOV_ATL_PR(LN_Num_abonado,LV_Codplan_destino,LN_cod_cliente,LN_TipoParametro,LN_insertook,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                sn_cod_retorno  := 0;

                IF LN_insertook > 0 AND SN_num_evento > 0 THEN
                        sn_cod_retorno  := LN_insertook;
                        RAISE ERROR_EJECUCION;
                END IF;

                SO_ABONADO.INSERTOOK := LN_insertook;

        EXCEPTION
    WHEN ERROR_EJECUCION THEN
          LV_des_error   := 'PV_INSERTA_MOVATL_PR('||LN_Num_abonado||','||LV_Codplan_destino||','||LN_cod_cliente||'); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_INSERTA_MOVATL_PR', LV_sSQL, SN_cod_retorno, LV_des_error);
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_INSERTA_MOVATL_PR ('||LN_Num_abonado||','||LV_Codplan_destino||','||LN_cod_cliente||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_INSERTA_MOVATL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_INSERTA_MOVATL_PR;

----------------------------------------------------------------------------------------------
FUNCTION PV_OBTENER_PLANATLANTIDA_FN (SO_ABONADO        IN OUT NOCOPY  GA_ABONADO_QT,
                                                                          SN_cod_retorno   OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                                          SV_mens_retorno  OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                                          SN_num_evento    OUT NOCOPY  ge_errores_pg.evento)
        RETURN VARCHAR2
        AS
/*
        <Documentacion TipoDoc = "Funcion">
        <Elemento Nombre = "PV_OBTENER_PLANATLANTIDA_FN "
         Lenguaje="PL/SQL" Fecha="8-08-2007"
         Versión"1.0.0" Diseñador"****"
         Programador="" Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripcion>   Funcion que valida y entrega un true o false segun la variable  Servicio  </Descripcion>
        <Parametros>
        <Entrada>
              <param nom="SO_ABONADO "   Tipo="Estructura Type GA_ABONADO_QT"> Datos de Estructura Input  SO_ABONADO.COD_PLANTARIF:='EED'  </param>>
        </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno"                         Tipo="NUMERICO">Codigo de Retorno                  </param>>
                    <param nom="SV_mens_retorno"                        Tipo="CARACTER">Mensaje de Retorno                 </param>>
                    <param nom="SN_num_evento"                          Tipo="NUMERICO">Numero de Evento                   </param>>
                 </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        */
        LV_des_error                            ge_errores_pg.DesEvent;
        LV_sSql                                         ge_errores_pg.vQuery;
        ERROR_EJECUCION                 EXCEPTION;
        LV_CODPLAN_ACTUAL                       VARCHAR2(200);
        LV_SERVICIO                             VARCHAR2(200);

 BEGIN
                sn_cod_retorno  := 0;
                sv_mens_retorno := NULL;
                sn_num_evento   := 0;

                LV_CODPLAN_ACTUAL:=SO_ABONADO.COD_PLANTARIF;
                LV_SERVICIO      :=SO_ABONADO.SERVICIO;

                LV_sSql:='PV_OBTIENEINFO_ATLANTIDA_PG.PV_OBTIENESERVICIO_ATL_PR('||LV_CODPLAN_ACTUAL||','||LV_SERVICIO||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
                PV_OBTIENEINFO_ATLANTIDA_PG.PV_OBTIENESERVICIO_ATL_PR(LV_CODPLAN_ACTUAL,LV_SERVICIO,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno>0 THEN
                        RAISE ERROR_EJECUCION;
                END IF;

                IF (LV_SERVICIO IS NULL) Or (LV_SERVICIO = '') THEN
                    RETURN 'FALSE';
                ELSE
                    SO_ABONADO.CLASE_SERVICIO := LV_SERVICIO;
                        RETURN 'TRUE';
                END IF;

        EXCEPTION
    WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_OBTENER_PLANATLANTIDA_FN ('||LV_CODPLAN_ACTUAL||','||LV_SERVICIO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTENER_PLANATLANTIDA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTENER_PLANATLANTIDA_FN ('||LV_CODPLAN_ACTUAL||','||LV_SERVICIO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTENER_PLANATLANTIDA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                  RETURN 'FALSE';
END PV_OBTENER_PLANATLANTIDA_FN;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_REGISTRAR_SERV_CONTRATO_PR (SO_GA_ABOCEL   IN OUT NOCOPY   PV_GA_ABOCEL_QT,
                                                            SN_cod_retorno         OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                            SV_mens_retorno        OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                            SN_num_evento          OUT NOCOPY   ge_errores_pg.evento)
IS
/*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_REGISTRAR_SERV_CONTRATO_PR   "
              Lenguaje="PL/SQL"
              Fecha="14-08-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Metodo  :  Insertar datos de Niveles y Grupos  en la entidad GA_SERVSUPLABO </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_GA_ABOCEL "                  Tipo="Estructura de Type ">   Datos de Estructura Type   </param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno"                         Tipo="NUMERICO">Codigo de Retorno                  </param>>
                    <param nom="SV_mens_retorno"                        Tipo="CARACTER">Mensaje de Retorno                 </param>>
                    <param nom="SN_num_evento"                          Tipo="NUMERICO">Numero de Evento                   </param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
                LV_des_error                            ge_errores_pg.DesEvent;
                LV_sSql                                         ge_errores_pg.vQuery;
                LN_largo                                        NUMBER(9);
                i                                                       NUMBER(9);
                j                                                       NUMBER(9);
                LN_concepto                                     ga_actuaserv.cod_concepto%TYPE;    --  number(4)
                LN_cod_servsupl                         ga_servsupl.cod_servsupl%TYPE;     --  number(2)
                LN_nivel                                        ga_servsupl.cod_nivel%TYPE;                --  number(4)
                LV_codServicio              ga_servsupl.cod_servicio%TYPE;         --  varchar2(3)
                LV_clase_servicio           ga_abocel.clase_servicio%TYPE;         --  varchar2(255)
 BEGIN
                sn_cod_retorno  := 0;
                sv_mens_retorno := NULL;
                sn_num_evento   := 0;

                        /*LV_sSql:='SELECT COD_CONCEPTO  INTO LN_concepto ';
                        LV_sSql:=LV_sSql||'FROM GA_ACTUASERV ';
                        LV_sSql:=LV_sSql||'WHERE COD_PRODUCTO='||CN_producto   ||' ';
                        LV_sSql:=LV_sSql||'AND COD_ACTABO    ='||CV_cod_actabo_F ||' ';
                        LV_sSql:=LV_sSql||'AND COD_TIPSERV   ='||CV_cod_tipserv||' ';

                        SELECT COD_CONCEPTO  INTO LN_concepto
                        FROM GA_ACTUASERV
                        WHERE COD_PRODUCTO = CN_producto
                        AND COD_ACTABO     = CV_cod_actabo_F
                        AND COD_TIPSERV    = CV_cod_tipserv;
                        */

                    LV_clase_servicio:=SO_GA_ABOCEL.CLASE_SERVICIO;
                        LV_sSql:='SELECT LENGTH('||LV_clase_servicio||') INTO LN_largo FROM DUAL; ';
                        SELECT LENGTH(LV_clase_servicio) INTO LN_largo FROM DUAL;

                i:=1;
                j:=2;
                WHILE i<LN_largo loop
                                LV_sSql:='SELECT NVL(SUBSTR('||LV_clase_servicio||','||i||','||j||'),0),NVL(SUBSTR('||LV_clase_servicio||',('||j||'+'||i||'),4),0) INTO LN_cod_servsupl,LN_nivel FROM DUAL; ';
                            SELECT NVL(SUBSTR(LV_clase_servicio,i,j),0),NVL(SUBSTR(LV_clase_servicio,(j+i),4),0) INTO LN_cod_servsupl,LN_nivel FROM DUAL;

                                LV_sSql:='SELECT  COD_SERVICIO INTO LV_codServicio ';
                                LV_sSql:=LV_sSql||'FROM GA_SERVSUPL ';
                                LV_sSql:=LV_sSql||'WHERE  COD_PRODUCTO ='||CN_producto ||' ';
                                LV_sSql:=LV_sSql||'AND COD_SERVSUPL    ='||LN_cod_servsupl||' ';
                                LV_sSql:=LV_sSql||'AND COD_NIVEL       ='||LN_nivel||'; ';

                                SELECT  COD_SERVICIO INTO LV_codServicio
                                FROM GA_SERVSUPL
                                WHERE  COD_PRODUCTO = CN_producto
                                AND COD_SERVSUPL    = LN_cod_servsupl
                                AND COD_NIVEL       = LN_nivel;

                                LV_sSql:='INSERT INTO GA_SERVSUPLABO(NUM_ABONADO,COD_SERVICIO,FEC_ALTABD,COD_SERVSUPL,COD_NIVEL,COD_PRODUCTO,NUM_TERMINAL,NOM_USUARORA,IND_ESTADO,FEC_ALTACEN,FEC_BAJABD,FEC_BAJACEN,COD_CONCEPTO,NUM_DIASNUM) ';
                                LV_sSql:=LV_sSql||'VALUES ('||SO_GA_ABOCEL.NUM_ABONADO||',';
                                LV_sSql:=LV_sSql||LV_codServicio||',';
                                LV_sSql:=LV_sSql||SYSDATE||',';
                                LV_sSql:=LV_sSql||LN_cod_servsupl||',';
                                LV_sSql:=LV_sSql||LN_nivel||',';
                                LV_sSql:=LV_sSql||CN_producto||',';
                                LV_sSql:=LV_sSql||To_char(SO_GA_ABOCEL.NUM_CELULAR)||',';
                                LV_sSql:=LV_sSql||SO_GA_ABOCEL.NOM_USUARORA||',';
                                LV_sSql:=LV_sSql||'1,';
                                LV_sSql:=LV_sSql||'null,';
                                LV_sSql:=LV_sSql||'null,';
                                LV_sSql:=LV_sSql||'null,';
                                --LV_sSql:=LV_sSql||LN_concepto||',';
                                LV_sSql:=LV_sSql||'null,';
                                LV_sSql:=LV_sSql||'null); ';

                                INSERT INTO GA_SERVSUPLABO (NUM_ABONADO,COD_SERVICIO,FEC_ALTABD,COD_SERVSUPL,COD_NIVEL,COD_PRODUCTO,NUM_TERMINAL,NOM_USUARORA,IND_ESTADO,FEC_ALTACEN,FEC_BAJABD,FEC_BAJACEN,COD_CONCEPTO,NUM_DIASNUM)
                                VALUES (SO_GA_ABOCEL.NUM_ABONADO,
                                            LV_codServicio,
                                                SYSDATE,
                                                LN_cod_servsupl,
                                                LN_nivel,
                                                CN_producto,
                                                To_char(SO_GA_ABOCEL.NUM_CELULAR),
                                                SO_GA_ABOCEL.NOM_USUARORA,
                                                1,
                                                null,
                                                null,
                                                null,
                                                NULL,--LN_concepto,
                                                null);
                        i:=i+6;
                        End Loop;

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_REGISTRAR_SERV_CONTRATO_PR ('||SO_GA_ABOCEL.NUM_ABONADO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_REGISTRAR_SERV_CONTRATO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_REGISTRAR_SERV_CONTRATO_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTENER_SERV_CONTRATO_PR (SO_ABONADO            IN OUT NOCOPY   GA_ABONADO_QT,
                                                                           SN_cod_retorno       OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                           SV_mens_retorno      OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                           SN_num_evento        OUT NOCOPY   ge_errores_pg.evento)
IS
/*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTENER_SERV_CONTRATO_PR     "
              Lenguaje="PL/SQL"
              Fecha="08-08-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Metodo  :   Rescata Servicios Contratados   </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_ABONADO "                    Tipo="Estructura de Type ">   Datos de Estructura Type   </param>>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno"                         Tipo="NUMERICO">Codigo de Retorno                  </param>>
                    <param nom="SV_mens_retorno"                        Tipo="CARACTER">Mensaje de Retorno                 </param>>
                    <param nom="SN_num_evento"                          Tipo="NUMERICO">Numero de Evento                   </param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_des_error                            ge_errores_pg.DesEvent;
        LV_sSql                                         ge_errores_pg.vQuery;
    SO_CursorAux                                refCursor;
        LV_serviciosAux                         VARCHAR2(6);
        LN_cod_actcen               ga_actabo.cod_actcen%TYPE;
        LV_Cod_Sistema                      icg_central.cod_sistema%TYPE;
        LV_cod_servicios                        icg_actuaciontercen.cod_servicios%TYPE;
        LV_serviciosAuxDefaultPlan      icg_actuaciontercen.cod_servicios%TYPE;
        LV_cod_serviciosTotal           icg_actuaciontercen.cod_servicios%TYPE;

        LN_I        NUMBER(3);
    LN_I2           NUMBER(3);
    LV_VAR_AUX  VARCHAR2(6);
    LV_VAR_AUX2 VARCHAR2(6);
    LV_VAR_AUX3 VARCHAR2(255);
    LV_VAR_AUX4 VARCHAR2(6);

 BEGIN
                sn_cod_retorno  := 0;
                sv_mens_retorno := NULL;
                sn_num_evento   := 0;

                LV_sSql:='SELECT COD_ACTCEN INTO  LN_cod_actcen ';
                LV_sSql:=LV_sSql||'FROM GA_ACTABO ';
                LV_sSql:=LV_sSql||'WHERE COD_PRODUCTO ='||CN_producto||' ';
                LV_sSql:=LV_sSql||'AND COD_ACTABO     ='||SO_ABONADO.COD_ACTABO||' ';
                LV_sSql:=LV_sSql||'AND COD_TECNOLOGIA ='||SO_ABONADO.COD_TECNOLOGIA||' ';
                LV_sSql:=LV_sSql||'AND COD_MODULO     ='||CV_cod_modulo||'; ';

                SELECT COD_ACTCEN
                INTO  LN_cod_actcen
                FROM GA_ACTABO
                WHERE COD_PRODUCTO = CN_producto
                AND COD_ACTABO     = SO_ABONADO.COD_ACTABO
                AND COD_TECNOLOGIA = SO_ABONADO.COD_TECNOLOGIA
                AND COD_MODULO     = CV_cod_modulo;

                LV_sSql:='SELECT COD_SISTEMA INTO LV_Cod_Sistema ';
                LV_sSql:=LV_sSql||'FROM ICG_CENTRAL ';
                LV_sSql:=LV_sSql||'WHERE COD_PRODUCTO ='||CN_producto||' ';
                LV_sSql:=LV_sSql||'AND   COD_CENTRAL  ='||SO_ABONADO.COD_CENTRAL||'; ';

                SELECT COD_SISTEMA
                INTO LV_Cod_Sistema
                FROM ICG_CENTRAL
                WHERE COD_PRODUCTO = CN_producto
                AND   COD_CENTRAL  = SO_ABONADO.COD_CENTRAL;

                BEGIN
                        LV_sSql:='SELECT COD_SERVICIOS INTO  LV_cod_servicios ';
                        LV_sSql:=LV_sSql||'FROM  ICG_ACTUACIONTERCEN ';
                        LV_sSql:=LV_sSql||'WHERE COD_PRODUCTO = '||CN_producto||' ';
                        LV_sSql:=LV_sSql||'AND COD_ACTUACION  = '||LN_cod_actcen||' ';
                        LV_sSql:=LV_sSql||'AND TIP_TERMINAL   = '||SO_ABONADO.TIP_TERMINAL||' ';
                        LV_sSql:=LV_sSql||'AND COD_SISTEMA    = '||LV_Cod_Sistema||'; ';

                        SELECT COD_SERVICIOS
                        INTO  LV_cod_servicios
                        FROM  ICG_ACTUACIONTERCEN
                        WHERE COD_PRODUCTO = CN_producto
                        AND COD_ACTUACION  = LN_cod_actcen
                        AND TIP_TERMINAL   = SO_ABONADO.TIP_TERMINAL
                        AND COD_SISTEMA    = LV_Cod_Sistema;
                EXCEPTION
            WHEN NO_DATA_FOUND THEN
                         LV_cod_servicios:=null;
                END;

                IF LV_cod_servicios is null THEN
                        LV_sSql:='SELECT COD_SERVICIO INTO LV_cod_servicios ';
                        LV_sSql:=LV_sSql||'FROM  ICG_ACTUACION ';
                        LV_sSql:=LV_sSql||'WHERE COD_ACTUACION ='||LN_cod_actcen||' ';
                        LV_sSql:=LV_sSql||'AND COD_PRODUCTO    ='||CN_producto||' ';
                        LV_sSql:=LV_sSql||'AND COD_MODULO      ='||CV_cod_modulo||';';

                        SELECT COD_SERVICIO
                        INTO LV_cod_servicios
                        FROM  ICG_ACTUACION
                        WHERE COD_ACTUACION = LN_cod_actcen
                        AND COD_PRODUCTO    = CN_producto
                        AND COD_MODULO      = CV_cod_modulo;
                END IF;

                BEGIN
                        LV_sSql:='SELECT  DISTINCT  TO_CHAR(A.COD_SERVSUPL,'||chr(39)||'09'||chr(39)||'),TO_CHAR(A.COD_NIVEL,'||chr(39)||'0999'||chr(39)||') ';
                        LV_sSql:=LV_sSql||'INTO LV_serviciosAuxDefaultPlan ';
                        LV_sSql:=LV_sSql||'FROM GA_SERVSUPL  A,';
                        LV_sSql:=LV_sSql||'GA_ACTUASERV          B,';
                        LV_sSql:=LV_sSql||'GAD_SERVSUP_PLAN  X ';
                        LV_sSql:=LV_sSql||'WHERE  ';
                        LV_sSql:=LV_sSql||' A.IND_COMERC='||CN_Ind_Comerc||' ';
                        LV_sSql:=LV_sSql||'AND A.TIP_SERVICIO='||CV_tip_servicio_1||' ';
                        LV_sSql:=LV_sSql||'AND A.COD_PRODUCTO='||CN_producto||' ';
                        LV_sSql:=LV_sSql||'AND A.COD_PRODUCTO= X.COD_PRODUCTO ';
                        LV_sSql:=LV_sSql||'AND A.COD_SERVICIO= X.COD_SERVICIO ';
                        LV_sSql:=LV_sSql||'AND X.COD_PLANTARIF='||SO_ABONADO.COD_PLANTARIF||' ';
                        LV_sSql:=LV_sSql||'AND X.TIP_RELACION='||CV_tip_relacion||' ';
                        LV_sSql:=LV_sSql||'AND SYSDATE BETWEEN X.FEC_DESDE AND X.FEC_HASTA ';
                        LV_sSql:=LV_sSql||'AND A.COD_PRODUCTO= B.COD_PRODUCTO(+) ';
                        LV_sSql:=LV_sSql||'AND A.COD_SERVICIO= B.COD_SERVICIO(+) ';
                        LV_sSql:=LV_sSql||'AND B.COD_ACTABO(+) ='||SO_ABONADO.COD_ACTABO||' ';
                        LV_sSql:=LV_sSql||'AND B.COD_TIPSERV(+)='||CV_cod_tipserv||'; ';

                   OPEN SO_CursorAux FOR
                   SELECT  DISTINCT ltrim(to_char(A.COD_SERVSUPL,'09')||ltrim(to_char(A.COD_NIVEL,'0999')))
                   FROM GA_SERVSUPL      A,
                                GA_ACTUASERV     B,
                                GAD_SERVSUP_PLAN X
                   WHERE
                       A.IND_COMERC     = CN_Ind_Comerc
                   AND A.TIP_SERVICIO   = CV_tip_servicio_1
                   AND A.COD_PRODUCTO   = CN_producto
                   AND A.COD_PRODUCTO   = X.COD_PRODUCTO
                   AND A.COD_SERVICIO   = X.COD_SERVICIO
                   AND X.COD_PLANTARIF  = SO_ABONADO.COD_PLANTARIF
                   AND X.TIP_RELACION   = CV_tip_relacion
                   AND SYSDATE BETWEEN X.FEC_DESDE AND X.FEC_HASTA
                   AND A.COD_PRODUCTO   = B.COD_PRODUCTO(+)
                   AND A.COD_SERVICIO   = B.COD_SERVICIO(+)
                   AND B.COD_ACTABO(+)  = SO_ABONADO.COD_ACTABO
                   AND B.COD_TIPSERV(+) = CV_cod_tipserv;
                        LV_serviciosAuxDefaultPlan:=null;
                        Fetch SO_CursorAux Into LV_serviciosAux;
                        WHILE not(SO_CursorAux%NOTFOUND) loop
                                  LV_serviciosAuxDefaultPlan:=ltrim(LV_serviciosAuxDefaultPlan||ltrim(LV_serviciosAux));
                              Fetch SO_CursorAux Into LV_serviciosAux;
                        End Loop;
                EXCEPTION
                WHEN OTHERS THEN
                         LV_serviciosAuxDefaultPlan:=null;
                END;

       IF LV_serviciosAuxDefaultPlan is null THEN
                   LV_cod_serviciosTotal:= LV_cod_servicios;
           ELSE

           LN_I := 1;
           LN_I2:=1;
           WHILE LN_I <= 255 LOOP
           LV_VAR_AUX:=SUBSTR(LV_serviciosAuxDefaultPlan,LN_I,6);
           LN_I2:=1;
           IF TRIM(LV_VAR_AUX) <> ' ' OR LV_VAR_AUX IS NOT NULL THEN
              WHILE LN_I2 <= 255 LOOP
                        LV_VAR_AUX4:=SUBSTR(LV_cod_servicios,LN_I2,6);
                        IF   TRIM(LV_VAR_AUX4) <> ' ' THEN
                                 select  replace (LV_VAR_AUX,LV_VAR_AUX4,'') INTO  LV_VAR_AUX2 from  dual;
                                 IF TRIM(LV_VAR_AUX2) =' ' OR  LV_VAR_AUX2 IS NULL THEN
                                        select  replace (LV_cod_servicios, LV_VAR_AUX,'') INTO LV_cod_servicios from  dual;
                                 END IF;
                        ELSE
                                LN_I2:= 255;
                        END IF;
                        LN_I2:= LN_I2 + 6;
                END LOOP;
           ELSE
                LN_I:= 255;
           END IF;
           LN_I:= LN_I + 6;
           END LOOP;

                   LV_cod_serviciosTotal:= ltrim(LV_cod_servicios||ltrim(LV_serviciosAuxDefaultPlan));
           END IF;

                LV_sSql:='UPDATE GA_ABOCEL SET CLASE_SERVICIO ='||LV_cod_serviciosTotal;
                --LV_sSql:=LV_sSql||'PERFIL_ABONADO = '||LV_cod_serviciosTotal           ||' ';OCB
                LV_sSql:=LV_sSql||'WHERE NUM_ABONADO ='||SO_ABONADO.NUM_ABONADO        ||';';

                UPDATE GA_ABOCEL SET CLASE_SERVICIO =  LV_cod_serviciosTotal
        --                                       PERFIL_ABONADO =  LV_cod_serviciosTotal OCB
                WHERE NUM_ABONADO = SO_ABONADO.NUM_ABONADO;

        SO_ABONADO.CLASE_SERVICIO := LV_cod_serviciosTotal;

        EXCEPTION
    WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTENER_SERV_CONTRATO_PR('||SO_ABONADO.NUM_ABONADO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTENER_SERV_CONTRATO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTENER_SERV_CONTRATO_PR ('||SO_ABONADO.NUM_ABONADO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTENER_SERV_CONTRATO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
                  SO_ABONADO.CLASE_SERVICIO := null;

END PV_OBTENER_SERV_CONTRATO_PR;


------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTENER_PLANACTUAL_PR (EO_APROVISIONAR         IN           GA_APROVISIONAR_QT,
                                                                        SO_ABONADO              OUT NOCOPY   GA_ABONADO_QT,
                                                                    SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                    SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                    SN_num_evento       OUT NOCOPY   ge_errores_pg.evento)
IS
/*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTENER_PLANACTUAL_PR"
              Lenguaje="PL/SQL"
              Fecha="08-08-2007"
              Versión="La del package"
              Diseñador=""
              Programador="Carlos Elizondo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Metodo  : Validaciones del plan actual del abonado  </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_APROVISIONAR" Tipo="Estructura de Type">Datos de Estructura Type </param>
                                <param nom="SO_ABONADO"          Tipo="Estructura de Type">Datos de Estructura Type </param>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo de Retorno</param>
                    <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje de Retorno</param>
                    <param nom="SN_num_evento"          Tipo="NUMERICO">Numero de Evento</param>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_des_error                                ge_errores_pg.DesEvent;
        LV_sSql                                                 ge_errores_pg.vQuery;
        ERROR_EJECUCION                     EXCEPTION;
        ERROR_GENERICO                                  EXCEPTION;
        LV_ObtCODGRUPO_AL_TECNOLOGIA    al_tecnologia.COD_GRUPO%Type;
        EO_GED_PARAMETROS                               PV_GED_PARAMETROS_QT;
        LV_ConsPlanPlat                                 VARCHAR2(20);
        LV_cdma                                                 VARCHAR2(20);
        LV_gsm                                                  VARCHAR2(20);
        LV_Plataforma                                   VARCHAR2(20);
        LV_tip_codigo                                   VARCHAR2(20);
        LV_CodigoInterno                                VARCHAR2(20);
        LV_PlanTarifPlataf                              ta_plantarif.COD_PLANTARIF%TYPE;
        LV_PlanTarifActual                              ta_plantarif.COD_PLANTARIF%TYPE;
        LV_cod_plantarif                                PPD_PLANES.COD_PLANTARIF%TYPE;
        LV_des_plantarif                                PPD_PLANES.DES_PLANTARIF%TYPE;

 BEGIN
                SN_cod_retorno  := 0;
                SV_mens_retorno := '';
                SN_num_evento   := 0;

                LV_PlanTarifPlataf := EO_APROVISIONAR.COD_PLANTARIF_NUEVO;
                LV_PlanTarifActual := EO_APROVISIONAR.COD_PLANTARIF;

                LV_ObtCODGRUPO_AL_TECNOLOGIA:=NULL;
                LV_sSql:='GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN('||EO_APROVISIONAR.TIP_TECNOLOGIA||')';
                LV_ObtCODGRUPO_AL_TECNOLOGIA:=GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(EO_APROVISIONAR.TIP_TECNOLOGIA);
                IF LV_ObtCODGRUPO_AL_TECNOLOGIA = 'ERROR' THEN
                        SN_cod_retorno := 1363;
                    RAISE ERROR_GENERICO;
                END IF;

                IF LV_ObtCODGRUPO_AL_TECNOLOGIA IS NOT NULL THEN
                        EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                        EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_GrupoTecGsm;
                        EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                        EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                        LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||')';
                        PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                        LV_gsm := EO_GED_PARAMETROS.VAL_PARAMETRO;
                        IF SN_cod_retorno <> 0 THEN
                       RAISE ERROR_EJECUCION;
                END IF;

                        EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                        EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_GrupoTecDma;
                        EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                        EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                        LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||')';
                        PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                        LV_cdma := EO_GED_PARAMETROS.VAL_PARAMETRO;
                        IF SN_cod_retorno <> 0 THEN
                       RAISE ERROR_EJECUCION;
                END IF;

                        IF  (LV_ObtCODGRUPO_AL_TECNOLOGIA = LV_gsm) THEN
                                                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                                EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_ConsPlanGsm;
                        ELSE
                           IF  (LV_ObtCODGRUPO_AL_TECNOLOGIA = LV_cdma) THEN
                                                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                                EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_ConsPlanTdma;
                           END IF;
                        END IF;

                        EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                        EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                        LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||')';
                        PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                        IF SN_cod_retorno <> 0 THEN
                           RAISE ERROR_EJECUCION;
                END IF;
                        IF EO_GED_PARAMETROS.VAL_PARAMETRO IS NOT NULL THEN
                                   IF EO_GED_PARAMETROS.VAL_PARAMETRO = 'TRUE' THEN

                                                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                                EO_GED_PARAMETROS.VAL_PARAMETRO:= null;
                                                EO_GED_PARAMETROS.DES_PARAMETRO:= null;
                                                EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_Homologar;
                                                EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                                EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;

                                                LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||')';
                                                PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                                                IF SN_cod_retorno > 0 THEN
                                                                RAISE ERROR_EJECUCION;
                                                END IF;

                                                IF EO_GED_PARAMETROS.VAL_PARAMETRO = 'TRUE' THEN
                                                    LV_ObtCODGRUPO_AL_TECNOLOGIA:=NULL;
                                                        LV_sSql:='GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN('||EO_APROVISIONAR.TIP_TECNOLOGIA||')';
                                                        LV_ObtCODGRUPO_AL_TECNOLOGIA:=GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(EO_APROVISIONAR.TIP_TECNOLOGIA);
                                                        IF LV_ObtCODGRUPO_AL_TECNOLOGIA = 'ERROR' THEN
                                                                SN_cod_retorno := 1363;
                                                            RAISE ERROR_GENERICO;
                                                        END IF;

                                                        IF LV_ObtCODGRUPO_AL_TECNOLOGIA IS NOT NULL THEN
                                                                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                                                EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_GrupoTecGsm;
                                                                EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                                                EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                                                                LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||')';
                                                                PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                                                                LV_gsm := EO_GED_PARAMETROS.VAL_PARAMETRO;
                                                                IF SN_cod_retorno <> 0 THEN
                                                               RAISE ERROR_EJECUCION;
                                                        END IF;

                                                                EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                                                EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_GrupoTecDma;
                                                                EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                                                EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                                                                LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||')';
                                                                PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                                                                LV_cdma := EO_GED_PARAMETROS.VAL_PARAMETRO;
                                                                IF SN_cod_retorno <> 0 THEN
                                                               RAISE ERROR_EJECUCION;
                                                        END IF;

                                                                IF  (LV_ObtCODGRUPO_AL_TECNOLOGIA = LV_gsm) THEN
                                                                                        EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                                                                        EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_PlatGsm;
                                                                ELSE
                                                                   IF  (LV_ObtCODGRUPO_AL_TECNOLOGIA = LV_cdma) THEN
                                                                                        EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                                                                        EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_PlatCdma;
                                                                   END IF;
                                                                END IF;

                                                                EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                                                EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
                                                                LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||')';
                                                                PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                                                                LV_Plataforma := EO_GED_PARAMETROS.VAL_PARAMETRO;
                                                                IF SN_cod_retorno <> 0 THEN
                                                                   RAISE ERROR_EJECUCION;
                                                        END IF;

                                                                IF LV_Plataforma IS NOT NULL THEN
                                                                    EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
                                                                        EO_GED_PARAMETROS.VAL_PARAMETRO:= null;
                                                                        EO_GED_PARAMETROS.DES_PARAMETRO:= null;
                                                                        EO_GED_PARAMETROS.NOM_PARAMETRO:= CV_TipCodigo;
                                                                        EO_GED_PARAMETROS.COD_MODULO   := CV_cod_modulo;
                                                                        EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;

                                                                        LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||')';
                                                                        PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR(EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                                                                        LV_TIP_CODIGO:=EO_GED_PARAMETROS.VAL_PARAMETRO;
                                                                        IF SN_cod_retorno>0 THEN
                                                                                        RAISE ERROR_EJECUCION;
                                                                        END IF;

                                                                        IF LV_tip_codigo IS NOT NULL THEN

                                                                            BEGIN

                                                                                    LV_sSql:= 'SELECT CODIGO_INTERNO ';
                                                                                        LV_sSql:=LV_sSql||' FROM AL_CODIGO_EXTERNO ';
                                                                                        LV_sSql:=LV_sSql||' WHERE COD_PLATAFORMA = '||LV_Plataforma;
                                                                                        LV_sSql:=LV_sSql||'  AND TIP_CODIGO = '||LV_tip_codigo;
                                                                                        LV_sSql:=LV_sSql||'  AND CODIGO_EXTERNO= '||LV_PlanTarifPlataf;

                                                                                        SELECT CODIGO_INTERNO
                                                                                        INTO LV_CodigoInterno
                                                                                         FROM AL_CODIGO_EXTERNO
                                                                                          WHERE COD_PLATAFORMA = LV_Plataforma
                                                                                                 AND TIP_CODIGO = LV_tip_codigo
                                                                                                 AND CODIGO_EXTERNO= LV_PlanTarifPlataf;

                                                                                        IF LV_CodigoInterno IS NOT NULL THEN
                                                                                                   LV_PlanTarifPlataf := LV_CodigoInterno;
                                                                                        END IF;

                                                                                EXCEPTION
                                                                                  WHEN NO_DATA_FOUND THEN
                                                                                                LV_PlanTarifPlataf := LV_PlanTarifActual;
                                                                                END;

                                                                        END IF;
                                                                END IF;
                                                        END IF;
                                                END IF;

                                                IF LV_PlanTarifPlataf <> LV_PlanTarifActual THEN

                                                   BEGIN
                                                           LV_sSql:= 'SELECT COD_PLANTARIF, DES_PLANTARIF ';
                                                           LV_sSql:=LV_sSql||' FROM PPD_PLANES ';
                                                           LV_sSql:=LV_sSql||' WHERE COD_PLANTARIF = '||LV_PlanTarifPlataf;
                                                           LV_sSql:=LV_sSql||'  AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA';

                                                           SELECT COD_PLANTARIF, DES_PLANTARIF
                                                           INTO LV_cod_plantarif, LV_des_plantarif
                                                            FROM PPD_PLANES
                                                             WHERE COD_PLANTARIF = LV_PlanTarifPlataf
                                                                   AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

                                                           SO_ABONADO.COD_PLANTARIF := LV_cod_plantarif;
                                                           SO_ABONADO.DES_PLANTARIF := LV_des_plantarif;

                                                   EXCEPTION
                                                          WHEN NO_DATA_FOUND THEN
                                                                SN_cod_retorno := 1545;
                                                        RAISE ERROR_GENERICO;
                                                   END;
                                                END IF;

                                   END IF;
                        END IF;
                END IF;

        EXCEPTION
        WHEN ERROR_GENERICO THEN
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTENER_PLANACTUAL_PR('||EO_APROVISIONAR.COD_PLANTARIF_NUEVO||','||EO_APROVISIONAR.TIP_TECNOLOGIA||','||EO_APROVISIONAR.COD_PLANTARIF||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTENER_PLANACTUAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN ERROR_EJECUCION THEN
                  LV_des_error   := 'PV_OBTENER_PLANACTUAL_PR('||EO_APROVISIONAR.COD_PLANTARIF_NUEVO||','||EO_APROVISIONAR.TIP_TECNOLOGIA||','||EO_APROVISIONAR.COD_PLANTARIF||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTENER_PLANACTUAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTENER_PLANACTUAL_PR('||EO_APROVISIONAR.COD_PLANTARIF_NUEVO||','||EO_APROVISIONAR.TIP_TECNOLOGIA||','||EO_APROVISIONAR.COD_PLANTARIF||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTENER_PLANACTUAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTENER_PLANACTUAL_PR('||EO_APROVISIONAR.COD_PLANTARIF_NUEVO||','||EO_APROVISIONAR.TIP_TECNOLOGIA||','||EO_APROVISIONAR.COD_PLANTARIF||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTENER_PLANACTUAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_OBTENER_PLANACTUAL_PR;

------------------------------------------------------------------------------------------------------

PROCEDURE PV_VALIDA_ELIM_CONTACTOS911_PR (EN_NUM_ABONADO      IN  ga_abocel.NUM_ABONADO%TYPE,
                                    EV_USER             IN  VARCHAR2,
                                    SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento       OUT NOCOPY   ge_errores_pg.evento)
        IS
        /*
        <Documentacion TipoDoc = "Procedure">
        <Elemento Nombre = " PV_VALIDA_ELIM_CONTACTOS911_PR
         Lenguaje="PL/SQL" Fecha="17-02-2010"
         Versión"1.0.0" Diseñador"ELIZABETH VERA"
         Programador="ELIZABETH VERA" Ambiente="BD ORACLE">
        <Retorno>NA</Retorno>
        <Descripcion>   VALIDA SI EL ABONADO TIENE SS 911 Y REALIZA ACCIONES ASOCIADAS A LA BAJA  </Descripcion>
        <Parametros>
        <Entrada>
            <param EN_NUM_ABONADO ="EN_NUM_ABONADO" Tipo = "NUMBER">numero de abonado</param>>
            <param EV_USER        ="EV_USER"        Tipo = "VARCHAR">usuario de conexion</param>>
        </Entrada>
        <Salida>
           <param SN_cod_retorno     ="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno        </param>>
           <param SV_mens_retorno    ="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno       </param>>
           <param SN_num_evento      ="SN_num_evento" Tipo="NUMERICO">Numero de Evento           </param>>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        */
        LV_des_error                    ge_errores_pg.DesEvent;
        LV_sSql                         ge_errores_pg.vQuery;
        LV_SS_ASISTENCIA_911            ged_parametros.val_parametro%TYPE;
  
        LN_EXISTE_SS_911    NUMBER;

        BEGIN
            sn_cod_retorno   := 0;
            sv_mens_retorno  := NULL;
            sn_num_evento        := 0;

  
            BEGIN
            
                LV_sSql:='SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO ='|| CV_PARAM_SS911;
                
                SELECT VAL_PARAMETRO 
                    INTO LV_SS_ASISTENCIA_911 
                FROM GED_PARAMETROS 
                WHERE NOM_PARAMETRO = CV_PARAM_SS911;
                
                SELECT count(*) 
                    INTO LN_EXISTE_SS_911
                FROM GA_SERVSUPLABO 
                WHERE NUM_ABONADO = EN_NUM_ABONADO
                AND COD_SERVSUPL = LV_SS_ASISTENCIA_911;
                                
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 LV_SS_ASISTENCIA_911 := 0;                             
            END;
                        
            IF (LN_EXISTE_SS_911 > 0) THEN
            
                LV_sSql:='SELECT NUM_ABONADO, COD_SERVICIO, NUM_CONTACTO, NOMBRE_CONTACTO, APELLIDO1_CONTACTO,';
                LV_sSql:= LV_sSql || ' APELLIDO2_CONTACTO, COD_PARENTESCO, COD_DIRECCION, PLACA_VEHICULAR, COLOR_VEHICULO,';
                LV_sSql:= LV_sSql || ' ANIO_VEHICULO, OBSERVACION, IND_VIGENTE, FEC_MODIFICACION, NOM_USUAORA, SYSDATE, EV_USER';
                LV_sSql:= LV_sSql || ' FROM ga_contacto_abonado_to';
                LV_sSql:= LV_sSql || ' WHERE NUM_ABONADO ='|| TO_CHAR(EN_NUM_ABONADO);
                
                --pasar a historicos
                INSERT INTO GA_CONTACTO_ABONADO_TH
                    (NUM_ABONADO, COD_SERVICIO, NUM_CONTACTO, NOMBRE_CONTACTO, APELLIDO1_CONTACTO,
                     APELLIDO2_CONTACTO, COD_PARENTESCO, COD_DIRECCION, PLACA_VEHICULAR, COLOR_VEHICULO,
                     ANIO_VEHICULO, OBSERVACION, IND_VIGENTE, FEC_MODIFICACION, NOM_USUAORA, FEC_PASOHIST,USU_PASOHIST)
                SELECT NUM_ABONADO, COD_SERVICIO, NUM_CONTACTO, NOMBRE_CONTACTO, APELLIDO1_CONTACTO,
                    APELLIDO2_CONTACTO, COD_PARENTESCO, COD_DIRECCION, PLACA_VEHICULAR, COLOR_VEHICULO,
                    ANIO_VEHICULO, OBSERVACION, IND_VIGENTE, FEC_MODIFICACION, NOM_USUAORA, SYSDATE, EV_USER
                FROM ga_contacto_abonado_to
                WHERE NUM_ABONADO=EN_NUM_ABONADO;

                LV_sSql:='DELETE FROM GA_CONTACTO_ABONADO_TO WHERE NUM_ABONADO ='|| TO_CHAR(EN_NUM_ABONADO);
                
                DELETE FROM GA_CONTACTO_ABONADO_TO WHERE NUM_ABONADO=EN_NUM_ABONADO;
                
            END IF;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_VALIDA_ELIM_CONTACTOS911_PR('||EN_NUM_ABONADO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_CODINTERNO_PLAN_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_VALIDA_ELIM_CONTACTOS911_PR('||EN_NUM_ABONADO||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_CODINTERNO_PLAN_FN', LV_sSQL, SN_cod_retorno, LV_des_error );

END  PV_VALIDA_ELIM_CONTACTOS911_PR;

--------------------------------------------------------------------------------

END PV_ESPEC_PROVISIONAMIENTO_PG;
/
SHOW ERRORS