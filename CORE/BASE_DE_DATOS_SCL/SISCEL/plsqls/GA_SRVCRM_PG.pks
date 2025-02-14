CREATE OR REPLACE PACKAGE GA_SRVCRM_PG AS

       CV_error_no_clasif      CONSTANT ge_errores_pg.msgerror := 'No es posible clasificar el error';
       CV_version              CONSTANT VARCHAR2(10) := '1.0';
       CV_ERROR_NO_DOCUMENTADO CONSTANT GE_ERRORES_PG.msgerror := 'No fue documentado detalle del error';
       TYPE refCursor IS REF CURSOR;
       SUBTYPE CodigoComercialSS IS ga_servsupl.cod_servicio%TYPE;
       SUBTYPE GrupoSS IS ga_servsupl.cod_servsupl%TYPE;
       SUBTYPE NivelSS IS ga_servsupl.cod_nivel%TYPE;

       PROCEDURE GA_CorreoUserPwd_PR (
                                      EV_plataforma   IN         VARCHAR2,
                                      SV_usuario      OUT NOCOPY VARCHAR2,
                                      SV_pwd          OUT NOCOPY VARCHAR2,
                                      SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.coderror,
                                      SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.msgerror,
                                      SV_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.evento
                                     );


       PROCEDURE GA_EstadoSrvCorreoData_PR (
                                            EN_NumAbonado       IN  ga_abocel.num_abonado%TYPE,
                                            EV_Descontratar     IN  varchar2,
                                            EV_GrupoSrvCorreo   OUT NOCOPY ga_servsupl.cod_servsupl%TYPE,
                                            EV_NivelSrvCorreo   OUT NOCOPY ga_servsupl.cod_nivel%TYPE,
                                            EV_Plataforma       OUT NOCOPY varchar2,
                                            SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.coderror,
                                            SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_PG.msgerror,
                                            SV_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.evento
                                           );

       PROCEDURE GA_ObtieneServPorDefecto_PR (
                                              EV_CodServicio  IN  GA_SERVSUP_DEF.COD_SERVICIO%TYPE,
                                              EN_TipRelacion  IN  GA_SERVSUP_DEF.TIP_RELACION%TYPE,
                                              SC_cursordatos  OUT NOCOPY  REFCURSOR,
                                              SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.coderror,
                                              SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.msgerror,
                                              SV_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.evento
                                             );

       PROCEDURE GA_RegDescontratacionCorreo_PR (
                                                  EN_NumAbonado       IN  ga_abocel.num_abonado%TYPE,
                                                  SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.coderror,
                                                  SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_PG.msgerror,
                                                  SV_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.evento
                                                 );

       PROCEDURE GA_GetSrvDatosBaja_PR (
                                        EN_NumAbonado   IN  ga_abocel.num_abonado%TYPE,
                                        SV_GrupoSrvDato OUT NOCOPY ga_servsupl.cod_servsupl%TYPE,
                                        SV_NivelSrvDato OUT NOCOPY ga_servsupl.cod_nivel%TYPE,
                                        SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.coderror,
                                        SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.msgerror,
                                        SV_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.evento
                                       );

       FUNCTION GA_IsPreRequisito_FN (
                                      EN_NumAbonado   IN  ga_abocel.num_abonado%TYPE,
                                      EV_GrupoSrvDato IN  ga_servsupl.cod_servsupl%TYPE,
                                      EV_NivelSrvDato IN  ga_servsupl.cod_nivel%TYPE,
                                      SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.coderror,
                                      SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.msgerror,
                                      SV_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.evento
                                     ) RETURN BOOLEAN;

      FUNCTION GA_IsPreRequisito_FN (
                                      EV_CodigoComercialCorreo IN ga_servsupl.cod_servicio%TYPE,
                                      EV_CodigoComercialDato IN ga_servsupl.cod_servicio%TYPE,
                                      SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.coderror,
                                      SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.msgerror,
                                      SV_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.evento
                                    )  RETURN BOOLEAN;

      FUNCTION GA_IsSrvDatos_FN (
                                 EV_GrupoSrvDato IN  ga_servsupl.cod_servsupl%TYPE,
                                 EV_NivelSrvDato IN  ga_servsupl.cod_nivel%TYPE,
                                 SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.coderror,
                                 SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.msgerror,
                                 SV_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.evento
                                ) RETURN BOOLEAN;

      FUNCTION GA_IsSrvCondicion_FN (
                                     EN_num_abonado  IN  ga_abocel.num_abonado%TYPE,
                                     EN_GrupoSrv     IN  ga_servsupl.cod_servsupl%TYPE,
                                     SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.coderror,
                                     SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.msgerror,
                                     SV_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.evento
                                    ) RETURN BOOLEAN;

      PROCEDURE GA_GetSrvDatosAboMailto_PR (
                                        EN_NumAbonado   IN  ga_abocel.num_abonado%TYPE,
                                        SC_cursordatos  OUT NOCOPY  REFCURSOR,
                                        SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.coderror,
                                        SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.msgerror,
                                        SV_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.evento
                                       );

      PROCEDURE GA_GetServicioCambioNivel_PR(
                                             EN_NumeroAbonado            IN ga_abocel.num_abonado%TYPE,
                                             EN_GrupoCadenaServicio      IN ga_servsupl.cod_servsupl%TYPE,
                                             SN_NivelServicio            OUT NOCOPY ga_servsupl.cod_nivel%TYPE,
                                             SV_CodigoComercialServicio  OUT NOCOPY ga_servsupl.cod_servicio%TYPE,
                                             SN_COD_RETORNO              OUT NOCOPY ge_errores_pg.coderror,
                                             SV_MENS_RETORNO             OUT NOCOPY ge_errores_pg.msgerror,
                                             SV_NUM_EVENTO               OUT NOCOPY ge_errores_pg.evento
                                             );

      PROCEDURE GA_CodigoComercialSS_PR (
                                        EN_GrupoServicio            IN ga_servsupl.cod_servsupl%TYPE,
                                        EN_NivelServicio            IN ga_servsupl.cod_nivel%TYPE,
                                        SV_CodigoComercialServicio  OUT NOCOPY ga_servsupl.cod_servicio%TYPE,
                                        SN_COD_RETORNO              OUT NOCOPY ge_errores_pg.coderror,
                                        SV_MENS_RETORNO             OUT NOCOPY ge_errores_pg.msgerror,
                                        SV_NUM_EVENTO               OUT NOCOPY ge_errores_pg.evento
                                       );


      FUNCTION GA_RetPlataforma_FN (
                                     EN_NUMABONADO  ga_abocel.num_abonado%TYPE
                                   ) RETURN VARCHAR2;

END GA_SRVCRM_PG;
/
SHOW ERRORS
