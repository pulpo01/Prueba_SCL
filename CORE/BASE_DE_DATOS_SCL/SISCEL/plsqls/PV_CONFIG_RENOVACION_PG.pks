CREATE OR REPLACE PACKAGE PV_CONFIG_RENOVACION_PG
IS
   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_cod_modulo_GE        CONSTANT VARCHAR2 (2)  := 'GE';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CV_gsFormato2           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL2';
   CV_gsFormato4           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL4';
   CV_gsFormato7           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL7';
   CV_gsFormato11          CONSTANT VARCHAR2 (20) := 'FORMATO_SEL11';
   CN_LARGOERRTEC          CONSTANT NUMBER       := 4000;
   CN_LARGODESC            CONSTANT NUMBER       := 2000;
   CV_cod_aplic            CONSTANT VARCHAR2 (3)  := 'PVA';
   CN_producto             CONSTANT NUMBER        := 1;


   CN_0                    CONSTANT NUMBER (1)     :=   0;
   CV_0                    CONSTANT VARCHAR2 (1)   := '0';
   CV_1                    CONSTANT VARCHAR2 (1)   := '1';

   GV_formato_sel2    ged_parametros.val_parametro%type;
   GV_formato_sel7    ged_parametros.val_parametro%type;
------------------------------------------------------------------------------------------------------

       PROCEDURE PV_REGISRENOVA_PR(              EO_NUM_OS_RENOVA       IN PV_REGISTRA_RENOVACION_OS_TO.NUM_OS_RENOVA%TYPE,
                                                 EO_NUM_ABONADO         IN PV_REGISTRA_RENOVACION_OS_TO.NUM_ABONADO%TYPE,
                                                 EO_COD_OS              IN PV_REGISTRA_RENOVACION_OS_TO.COD_OS%TYPE,
                                                 EO_NOM_USUARIO         IN PV_REGISTRA_RENOVACION_OS_TO.NOM_USUARIO%TYPE,
                                                 EO_IND_CARGO           IN PV_REGISTRA_RENOVACION_OS_TO.IND_CARGO%TYPE,
                                                 SN_cod_retorno         OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                 SV_mens_retorno        OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                 SN_num_evento          OUT NOCOPY  ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------
       PROCEDURE PV_ACTUARENOVA_ODBC_PR(         EO_NUM_TRANSACCION     IN GA_TRANSACABO.NUM_TRANSACCION%TYPE,
                                                 EO_NUM_OS_RENOVA       IN PV_REGISTRA_RENOVACION_OS_TO.NUM_OS_RENOVA%TYPE,
                                                 EO_NUM_OS              IN PV_REGISTRA_RENOVACION_OS_TO.NUM_OS%TYPE,
                                                 EO_NUM_ABONADO         IN PV_REGISTRA_RENOVACION_OS_TO.NUM_ABONADO%TYPE,
                                                 EO_COD_OS              IN PV_REGISTRA_RENOVACION_OS_TO.COD_OS%TYPE
                                                 );
------------------------------------------------------------------------------------------------------

       PROCEDURE PV_ACTUARENOVA_PR(              EO_NUM_OS_RENOVA       IN PV_REGISTRA_RENOVACION_OS_TO.NUM_OS_RENOVA%TYPE,
                                                 EO_NUM_OS              IN PV_REGISTRA_RENOVACION_OS_TO.NUM_OS%TYPE,
                                                 EO_NUM_ABONADO         IN PV_REGISTRA_RENOVACION_OS_TO.NUM_ABONADO%TYPE,
                                                 EO_COD_OS              IN PV_REGISTRA_RENOVACION_OS_TO.COD_OS%TYPE,
                                                 SN_cod_retorno         OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                 SV_mens_retorno        OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                 SN_num_evento          OUT NOCOPY  ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------

PROCEDURE PV_CARGATIPOPROD_PR(SO_Lista_Abonado         IN OUT NOCOPY   refCursor,
                              SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                              SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                              SN_num_evento            OUT NOCOPY      ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------


        -------------------------------------------------------------------------------
PROCEDURE PV_CARGATIPOABO_PR( SO_Lista_Abonado         IN OUT NOCOPY   refCursor,
                              SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                              SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                              SN_num_evento            OUT NOCOPY      ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------

        PROCEDURE PV_CARGAACCOMER_PR(           EO_TIPO_ABONADO          IN              TA_PLANTARIF.COD_TIPLAN%TYPE,
                                                EO_TIPO_PRODUCTO         IN              GED_CODIGOS.COD_VALOR%TYPE,
                                                SO_Lista_Abonado         OUT NOCOPY      refCursor/*,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento*/);

-------------------------------------------------------------------------------------------------------

       PROCEDURE PV_CONSULTARENOVA_PR(          SO_Lista_Abonado         IN OUT NOCOPY   refCursor,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------


        PROCEDURE PV_CARGAACCOMERABO_PR(        EO_TIPO_ABONADO          IN              TA_PLANTARIF.COD_TIPLAN%TYPE,
                                                EO_TIPO_PRODUCTO         IN              GED_CODIGOS.COD_VALOR%TYPE,
                                                SO_Lista_Abonado         OUT NOCOPY      refCursor

                                                );

-------------------------------------------------------------------------------------------------------

        PROCEDURE PV_ELIMINA_CONFIG_PR(         EO_TIPO_ABONADO          IN              TA_PLANTARIF.COD_TIPLAN%TYPE,
                                                EO_TIPO_PRODUCTO         IN              GED_CODIGOS.COD_VALOR%TYPE,
                                                EO_ACCI_COMMER           IN              CI_TIPORSERV.COD_OS%TYPE,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento);


-------------------------------------------------------------------------------------------------------

        PROCEDURE PV_REGISTRA_CONFIG_PR(        EO_TIPO_ABONADO          IN              TA_PLANTARIF.COD_TIPLAN%TYPE,
                                                EO_TIPO_PRODUCTO         IN              GED_CODIGOS.COD_VALOR%TYPE,
                                                EO_ACCI_COMMER           IN              CI_TIPORSERV.COD_OS%TYPE,
                                                EO_IND_CARGO             IN              PV_RENOVACIONES_TD.IND_CARGO%TYPE,
                                                EO_NOM_USUARIO           IN              PV_RENOVACIONES_TD.NOM_USUARIO%TYPE,
                                                EO_FEC_INI               IN              VARCHAR2,
                                                EO_FEC_TER               IN              VARCHAR2,
                                                EO_IND_PRIO              IN              PV_RENOVACIONES_TD.IND_PRIO%TYPE,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento);



------------------------------------------------------------------------------------------------------

        PROCEDURE PV_VERIFICA_RENOVACION_PR(    EO_NUM_OS                IN PV_REGISTRA_RENOVACION_OS_TO.NUM_OS%TYPE,
                                                EO_COD_OS                IN PV_REGISTRA_RENOVACION_OS_TO.COD_OS%TYPE,
                                                SN_IND_CARGO             OUT NOCOPY      PV_RENOVACIONES_TD.IND_CARGO%TYPE,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------

        PROCEDURE PV_RENOVAWEB_PR (
              eo_iorserv        IN              pv_iorserv_qt,
              sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
              sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
              sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
           );


       procedure pv_carga_prestacion_pr   (     SO_Lista         OUT NOCOPY      refCursor,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento) ;

END PV_CONFIG_RENOVACION_PG;
/
SHOW ERROR