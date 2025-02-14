CREATE OR REPLACE PACKAGE TO_servicios_tol_PG IS

        -----------------------------
        -- DECLARACION DE CONSTANTES
        -----------------------------

        CV_MODULO_GA     CONSTANT VARCHAR2(2)  := 'GA';
        CV_ERRORNOCLASIF CONSTANT VARCHAR2(30) := 'Error no clasificado';

        CN_LARGOERRTEC   CONSTANT NUMBER := 4000;
        CN_LARGODESC     CONSTANT NUMBER := 2000;

        ------------------------
        -- DECLARACION DE TIPOS
        ------------------------
        TYPE refcursor IS REF CURSOR;

        --------------------------------------------------------------------------------------------
        --* CURSORES - LISTAS
        --------------------------------------------------------------------------------------------

        PROCEDURE TO_getListLimiteConsumo_PR(EV_codPlanTarif  IN  tol_limite_plan_td.cod_plantarif%TYPE,
                                             EV_formatoFecha1 IN  VARCHAR2,
                                             EV_formatoFecha2 IN  VARCHAR2,
                                                                             SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                                                         SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                                     SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                     SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);

END TO_servicios_tol_PG;


/
SHOW ERRORS
