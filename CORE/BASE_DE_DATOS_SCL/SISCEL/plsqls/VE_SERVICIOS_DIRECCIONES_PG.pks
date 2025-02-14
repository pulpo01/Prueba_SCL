CREATE OR REPLACE PACKAGE VE_servicios_direcciones_PG IS

        -----------------------------
        -- DECLARACION DE CONSTANTES
        -----------------------------

        CV_MODULO_GA     CONSTANT VARCHAR2(2)  := 'GA';

        CV_ERRORNOCLASIF CONSTANT VARCHAR2(30) := 'Error no clasificado';
        CN_LARGOERRTEC   CONSTANT NUMBER       := 4000;
        CN_LARGODESC     CONSTANT NUMBER       := 2000;

        CN_REGION            CONSTANT NUMBER       := 0;
        CN_PROVINCIA     CONSTANT NUMBER           := 1;
        CN_CIUDAD            CONSTANT NUMBER       := 2;
        CN_COMUNA            CONSTANT NUMBER       := 3;
        CN_CALLE             CONSTANT NUMBER       := 4;
        CN_NUMERO            CONSTANT NUMBER       := 5;
        CN_PISO          CONSTANT NUMBER           := 6;
        CN_CASILLA           CONSTANT NUMBER       := 7;
        CN_OBSERVACION   CONSTANT NUMBER           := 8;
        CN_DES_DIREC1    CONSTANT NUMBER           := 9;
        CN_DES_DIREC2    CONSTANT NUMBER           := 10;
        CN_PUEBLO            CONSTANT NUMBER       := 11;
        CN_ESTADO            CONSTANT NUMBER       := 12;
        CN_ZIP           CONSTANT NUMBER           := 13;

        ------------------------
        -- DECLARACION DE TIPOS
        ------------------------
        TYPE refcursor IS REF CURSOR;

        ----------------------------
        -- DECLARACION DE VARIABLES
        ----------------------------

        ----------------------------
        -- DECLARACION DE FUNCIONES
        ----------------------------

        ---------------------------------
        -- DECLARACION DE PROCEDIMIENTOS
        ---------------------------------

        PROCEDURE VE_getDireccion_PR(EV_codSujeto      IN  VARCHAR2,
                                     EN_tipSujeto      IN  NUMBER,
                                     EN_tipDireccion   IN  NUMBER,
                                     EN_tipDisplay     IN  NUMBER,
                                                                 SV_cod_region     OUT NOCOPY VARCHAR2,
                                                                 SV_cod_provincia  OUT NOCOPY VARCHAR2,
                                                                 SV_cod_ciudad     OUT NOCOPY VARCHAR2,
                                                                 SV_cod_comuna     OUT NOCOPY VARCHAR2,
                                                                 SV_nom_calle      OUT NOCOPY VARCHAR2,
                                                                 SV_num_calle      OUT NOCOPY VARCHAR2,
                                                                 SV_num_piso       OUT NOCOPY VARCHAR2,
                                                                 SV_num_casilla    OUT NOCOPY VARCHAR2,
                                                                 SV_obs_direccion  OUT NOCOPY VARCHAR2,
                                                                 SV_des_direc1     OUT NOCOPY VARCHAR2,
                                                                 SV_des_direc2     OUT NOCOPY VARCHAR2,
                                                                 SV_cod_pueblo     OUT NOCOPY VARCHAR2,
                                                                 SV_cod_estado     OUT NOCOPY VARCHAR2,
                                                                 SV_zip                    OUT NOCOPY VARCHAR2,
                                                                 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getDireccionCodigo_PR(EN_cod_direccion IN  NUMBER,
                                       SV_cod_provincia OUT NOCOPY  VARCHAR2,
                                                                       SV_cod_region    OUT NOCOPY  VARCHAR2,
                                                                       SV_cod_ciudad    OUT NOCOPY  VARCHAR2,
                                                                       SV_cod_comuna    OUT NOCOPY  VARCHAR2,
                                                                       SV_nom_calle     OUT NOCOPY  VARCHAR2,
                                                                       SV_num_calle     OUT NOCOPY  VARCHAR2,
                                                                       SV_num_piso      OUT NOCOPY  VARCHAR2,
                                                                       SV_num_casilla   OUT NOCOPY  VARCHAR2,
                                                                           SV_obs_direccion OUT NOCOPY  VARCHAR2,
                                                                           SV_des_direc1    OUT NOCOPY  VARCHAR2,
                                                                           SV_des_direc2    OUT NOCOPY  VARCHAR2,
                                                                           SV_cod_pueblo    OUT NOCOPY  VARCHAR2,
                                                                           SV_cod_estado    OUT NOCOPY  VARCHAR2,
                                                                           SV_zip           OUT NOCOPY  VARCHAR2,
                                                                           SV_cod_tipo_calle  OUT NOCOPY  VARCHAR2,
                                                                   SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);

        --------------------------------------------------------------------------------------------
        --* CURSORES - LISTAS
        --------------------------------------------------------------------------------------------

        PROCEDURE VE_getListConfigDirecciones_PR(EV_codOperadora IN ge_paramdiroperad.cod_operad%TYPE,
                                                 SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                                         SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getListComunas_PR(EV_codRegion    IN  ge_ciucom.cod_region%TYPE,
                                       EV_codProvincia IN  ge_ciucom.cod_provincia%TYPE,
                                                                   EV_codCiudad    IN  ge_ciucom.cod_ciudad%TYPE,
                                       SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                               SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getListEstados_PR(EV_indOrden IN VARCHAR2,
                                       SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                               SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getListPueblos_PR(EV_codEstado    IN ge_pueblos.cod_estado%TYPE,
                                       EV_indOrden     IN VARCHAR2,
                                       SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                               SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getListZip_PR(EV_codZona      IN ge_zipcode_td.COD_ZONA%TYPE,
                                   SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                           SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_listadoregiones_PR(EV_indOrden      IN VARCHAR2,
                                        SC_cursordatos   OUT NOCOPY REFCURSOR,
                                    SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_listadoprovincias_PR(EV_codregion     IN  ge_regiones.cod_region%TYPE,
                                      EV_indOrden      IN VARCHAR2,
                                          SC_cursordatos   OUT NOCOPY REFCURSOR,
                                      SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_listadociudades_PR(EV_codregion     IN  ge_regiones.cod_region%TYPE,
                                    EV_codprovincia  IN  ge_provincias.cod_provincia%TYPE,
                                                                        EV_indOrden      IN VARCHAR2,
                                        SC_cursordatos   OUT NOCOPY REFCURSOR,
                                    SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getListTiposCalles_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                                   SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
        --------------------------------------------------------------------------------------------
        --* INSERTS y UPDATES
        --------------------------------------------------------------------------------------------

        PROCEDURE VE_updDireccion_PR(EN_cod_direccion IN  NUMBER,
                                 EV_cod_provincia IN  VARCHAR2,
                                                                 EV_cod_region    IN  VARCHAR2,
                                                                 EV_cod_ciudad    IN  VARCHAR2,
                                                                 EV_cod_comuna    IN  VARCHAR2,
                                                                 EV_nom_calle     IN  VARCHAR2,
                                                                 EV_num_calle     IN  VARCHAR2,
                                                                 EV_num_piso      IN  VARCHAR2,
                                                                 EV_num_casilla   IN  VARCHAR2,
                                                                 EV_obs_direccion IN  VARCHAR2,
                                                                 EV_des_direc1    IN  VARCHAR2,
                                                                 EV_des_direc2    IN  VARCHAR2,
                                                                 EV_cod_pueblo    IN  VARCHAR2,
                                                                 EV_cod_estado    IN  VARCHAR2,
                                                                 EV_zip           IN  VARCHAR2,
                                                                 EV_cod_tipo_calle  IN  VARCHAR2,
                                                             SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_inserta_direccion_PR(EN_cod_direccion IN  NUMBER,
                                      EV_cod_provincia IN  VARCHAR2,
                                                                      EV_cod_region    IN  VARCHAR2,
                                                                      EV_cod_ciudad    IN  VARCHAR2,
                                                                      EV_cod_comuna    IN  VARCHAR2,
                                                                      EV_nom_calle     IN  VARCHAR2,
                                                                      EV_num_calle     IN  VARCHAR2,
                                                                      EV_num_piso      IN  VARCHAR2,
                                                                      EV_num_casilla   IN  VARCHAR2,
                                                                      EV_obs_direccion IN  VARCHAR2,
                                                                      EV_des_direc1    IN  VARCHAR2,
                                                                      EV_des_direc2    IN  VARCHAR2,
                                                                      EV_cod_pueblo    IN  VARCHAR2,
                                                                      EV_cod_estado    IN  VARCHAR2,
                                                                      EV_zip           IN  VARCHAR2,
                                                                          EV_cod_tipo_calle  IN  VARCHAR2,
                                                                  SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                          SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);


        PROCEDURE VE_insDireccionUsuario_PR(EN_codDireccion    IN  NUMBER,
                                        EV_codUsuario      IN  VARCHAR2,
                                                                                EV_tipDireccion    IN  VARCHAR2,
                                                                    SN_codRetorno      OUT NOCOPY ge_errores_pg.CodError,
                                            SV_menRetorno      OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_numEvento       OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_delDireccion_PR(EN_cod_direccion IN  VARCHAR2,
                                                             SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_getCodDireccion_PR(EV_codSujeto      IN  VARCHAR2,
                                     EN_tipSujeto      IN  NUMBER,
                                     EN_tipDireccion   IN  NUMBER,
                                     SV_CodDireccion   OUT NOCOPY  GE_DIRECCIONES.COD_DIRECCION%TYPE,                                                              
                                     SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);                                     

END VE_servicios_direcciones_PG;
/
SHOW ERRORS