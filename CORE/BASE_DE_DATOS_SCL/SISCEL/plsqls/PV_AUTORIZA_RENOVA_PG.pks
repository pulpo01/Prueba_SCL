CREATE OR REPLACE PACKAGE PV_AUTORIZA_RENOVA_PG
IS
   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_cod_modulo_GE        CONSTANT VARCHAR2 (2)  := 'GE';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CV_gsFormato2           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL2';
   CV_gsFormato4           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL4';
   CV_gsFormato7           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL7';

   CV_estado_pd            CONSTANT VARCHAR2 (2)  := 'PD';

   CV_cod_aplic            CONSTANT VARCHAR2 (3)  := 'PVA';
   CN_producto             CONSTANT NUMBER        := 1;


   CN_0                    CONSTANT NUMBER (1)     :=  0;
   CV_0                    CONSTANT VARCHAR2 (1)   := '0';
   CV_1                    CONSTANT VARCHAR2 (1)   := '1';

------------------------------------------------------------------------------------------------------

        PROCEDURE PV_REGISTRA_AUTORIZA_PR(       EO_NUM_AUTORIZACION     IN GA_AUTORIZA_RENOVA_TO.NUM_AUTORIZA_RENOVA%type,
                                                 EO_NOM_USUARIO_AUTORIZA IN GA_AUTORIZA_RENOVA_TO.NOM_USUARIO_AUTORIZA%type,
                                                 EO_COD_VENDEDOR         IN GA_AUTORIZA_RENOVA_TO.COD_VENDEDOR%type,
                                                 EO_COD_OFICINA          IN GA_AUTORIZA_RENOVA_TO.COD_OFICINA%type,
                                                 EO_COD_CLIENTE          IN GA_AUTORIZA_RENOVA_TO.COD_CLIENTE%type,
                                                 EO_NUM_ABONADO          IN GA_AUTORIZA_RENOVA_TO.NUM_ABONADO%type,
                                                 SN_cod_retorno          OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                 SV_mens_retorno         OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                 SN_num_evento           OUT NOCOPY  ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------

        PROCEDURE PV_CONSESTADO_AUTORIZA_PR(    EO_AUTORIZA              IN GA_AUTORIZA_RENOVA_TO.NUM_AUTORIZA_RENOVA%type,
                                                SV_estado                OUT NOCOPY GA_AUTORIZA_RENOVA_TO.cod_estado%type,
                                                SN_cod_retorno           OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------


        PROCEDURE PV_LISTA_AUTORIZA_PR(         SO_Lista_Abonado         IN OUT NOCOPY         refCursor,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------

        PROCEDURE PV_ACTUALIZA_AUTORIZA_PR(     EO_NUM_AUTORIZACION      IN          GA_AUTORIZA_RENOVA_TO.NUM_AUTORIZA_RENOVA%type,
                                                EO_COD_ESTADO            IN          GA_AUTORIZA_RENOVA_TO.COD_ESTADO%type,
                                                EO_NOM_USUARIO_AUTORIZA  IN          GA_AUTORIZA_RENOVA_TO.NOM_USUARIO_AUTORIZA%type,
                                                SN_cod_retorno           OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY  ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------

        PROCEDURE PV_CONSESTADOABO_AUTORIZA_PR( EO_abonado               IN              GA_AUTORIZA_RENOVA_TO.NUM_ABONADO%type,
                                                SN_autoriza              OUT NOCOPY      GA_AUTORIZA_RENOVA_TO.NUM_AUTORIZA_RENOVA%type,
                                                SV_estado                OUT NOCOPY      GA_AUTORIZA_RENOVA_TO.cod_estado%type,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------

END PV_AUTORIZA_RENOVA_PG;
/
SHOW ERRORS