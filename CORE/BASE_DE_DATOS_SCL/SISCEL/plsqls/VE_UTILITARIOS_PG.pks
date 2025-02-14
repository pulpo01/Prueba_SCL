CREATE OR REPLACE PACKAGE VE_Utilitarios_PG IS

        CV_ERROR_NO_CLASIF    CONSTANT VARCHAR2(30) := 'Error no clasificado';
        CN_LARGOERRTEC        CONSTANT NUMBER       := 4000;
        CN_LARGODESC          CONSTANT NUMBER       := 2000;
        CN_PRODUCTO           CONSTANT NUMBER       := 1;
        CV_MODULO_GA          CONSTANT VARCHAR2(2)  := 'GA'; -- gestion abonados
        CV_MODULO_GE          CONSTANT VARCHAR2(2)  := 'GE'; -- generales
        CV_MODULO_FA          CONSTANT VARCHAR2(2)  := 'FA'; -- facturacion
        CV_MODULO_TA          CONSTANT VARCHAR2(2)  := 'TA'; -- tarificacion
        CV_CATTRIBFACTURA     CONSTANT VARCHAR2(1)  := 'F';  -- categoria tributaria factura
        CV_FORMATOFECHA       CONSTANT VARCHAR2(10) := 'DD/MM/YYYY';

        CN_INDICADORWEB       CONSTANT NUMBER       := 1;    -- indicador planes web
        CN_TIPODIRFACTURACION CONSTANT NUMBER       := 1;    -- tipo direccion : facturacion
        CN_CODCICLO25         CONSTANT NUMBER       := 25;       -- codigo ciclo 25

        CN_TIPPLAN_PREPAGO    CONSTANT NUMBER       := 1;        -- tipo plan : prepago
        CN_TIPPLAN_POSTPAGO   CONSTANT NUMBER       := 2;        -- tipo plan : postpago
        CN_TIPPLAN_HIBRIDO    CONSTANT NUMBER       := 3;        -- tipo plan : hibrido

        CN_USOPOSTPAGO        CONSTANT NUMBER       := 2;        -- uso postpago
        CN_USOPREPAGO         CONSTANT NUMBER       := 3;        -- uso prepago
        CN_USOAHORRO          CONSTANT NUMBER       := 10;       -- uso ahorro  o hibrido

        CN_TIPPRODPOSTPAGO    CONSTANT NUMBER       := 0;        -- tipo producto postpago
        CN_TIPPRODPREPAGO     CONSTANT NUMBER       := 1;        -- tipo producto prepago
        CN_TIPPRODHIBRIDO     CONSTANT NUMBER       := 2;        -- tipo producto hibrido

        CV_ESTVENTA_PD        CONSTANT VARCHAR2(2)  := 'PD'; -- pendiente documentar
        CV_ESTVENTA_PC        CONSTANT VARCHAR2(2)  := 'PC'; -- pendiente cumplimentar
        CV_ESTVENTA_PA        CONSTANT VARCHAR2(2)  := 'PA'; -- pendiente aceptacion
        CV_ESTVENTA_AC        CONSTANT VARCHAR2(2)  := 'AC'; -- aceptacion de la venta

        CV_ACTABO_AV          CONSTANT VARCHAR2(2)  := 'AV'; -- aceptacion de la venta

        -- fin ---------------------------------------------------------------------------------------------

        CI_TRUE             CONSTANT PLS_INTEGER  := 1;
        CI_FALSE            CONSTANT PLS_INTEGER  := 0;
        CV_FORMATO_FECHA    CONSTANT VARCHAR2(12) := 'FORMATO_SEL2';
        CV_PROCNUMERO       CONSTANT VARCHAR2(1)  := 'R';                                 -- Indicativo de Procedencia del número : (R)eutilizable

PROCEDURE VE_RegistroDefault_Error_PR(EV_nomPackage   IN  VARCHAR2,
                                       EV_nomProcedure IN  VARCHAR2,
                                       EV_sql          IN  VARCHAR2,
                                       EN_CodRetorno   IN  NUMBER,
                                       EV_LabelError   IN  VARCHAR2,
                                       SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
END VE_Utilitarios_PG;


/
SHOW ERRORS
