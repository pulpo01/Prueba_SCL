CREATE OR REPLACE PACKAGE BP_servicios_benefpromo_PG IS

        -----------------------------
        -- DECLARACION DE CONSTANTES
        -----------------------------
        CV_ERRORNOCLASIF          CONSTANT VARCHAR2(30) := 'Error no clasificado';
        CN_LARGOERRTEC            CONSTANT NUMBER := 4000;
        CN_LARGODESC              CONSTANT NUMBER := 2000;
        CV_MODULO_GA              CONSTANT VARCHAR2(2)  := 'GA';

    CV_CODTIPPLANTARIFPREPAGO CONSTANT VARCHAR2(2) := '1';
        CV_FORMATOFECHA           CONSTANT VARCHAR2(8) := 'YYYYMMDD';

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

        PROCEDURE BP_getListCampVigPostpago_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                                           SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE BP_registra_campana_PR(EV_codCampana   IN VARCHAR2,
                                                                         EV_codCliente   IN ga_abocel.COD_CLIENTE%TYPE,
                                                                         EV_numAbonado   IN ga_abocel.NUM_CELULAR%TYPE,
                                                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                         SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                         SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getCampana_PR(EV_codCampana   IN VARCHAR2,
                                                           EV_indAplicaA   OUT NOCOPY VARCHAR2,
                                                           SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                           SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                           SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);



END BP_servicios_benefpromo_PG; 
/
SHOW ERRORS
