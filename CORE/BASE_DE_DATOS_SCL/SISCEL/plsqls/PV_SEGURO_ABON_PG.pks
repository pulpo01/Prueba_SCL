CREATE OR REPLACE PACKAGE PV_SEGURO_ABON_PG AS
   TYPE refCursor IS REF CURSOR;
   CV_ERROR_NO_CLASIF      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_COD_MODULO           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_COD_MODULO_GE        CONSTANT VARCHAR2 (2)  := 'GE';
   CV_VERSION              CONSTANT VARCHAR2 (2)  := '1';
   CV_GSFORMATO7           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL7';
   CV_GSFORMATO2           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL2';
   CV_GSFORMATO19          CONSTANT VARCHAR2 (20) := 'FORMATO_SEL19';
   CV_COD_APLIC            CONSTANT VARCHAR2 (3)  := 'PVA';
   CN_PRODUCTO             CONSTANT NUMBER        := 1;
   CN_0                    CONSTANT NUMBER (1)     :=   0;
   CV_0                    CONSTANT VARCHAR2 (1)   := '0';
   CV_1                    CONSTANT VARCHAR2 (1)   := '1';

  PROCEDURE PV_CARGA_SEGURO_PR(EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                               SO_Lista_Abonado         OUT NOCOPY      refCursor);

  PROCEDURE PV_CARGO_RECSEGURO_PR(EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                               EO_COD_CLIENTE           IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                               EO_COD_PROD_CONTRA       IN              PR_PRODUCTOS_CONTRATADOS_TO.COD_PROD_CONTRATADO%TYPE,
                               EO_COD_CARGO_PROD_CONTRA IN              FA_CARGOS_REC_TO.COD_CARGO_CONTRATADO%TYPE,
                               EO_NUM_ABONADO_PAGO      IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                               EO_COD_CLIENTE_PAGO      IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                               EO_COD_PLANSERV          IN              GA_ABOCEL.COD_PLANSERV%TYPE,
                               EO_IND_COBPRORRATEA      IN              NUMBER,
                               EO_COD_CONCEPTO          IN              FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                               EO_FECHA_ALTA            IN              DATE,
                               EO_FECHA_BAJA            IN              DATE,
                               EO_USUARIO               IN              GA_ABOCEL.NOM_USUARORA%TYPE,
                               sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                               sn_num_evento            OUT NOCOPY      ge_errores_pg.evento);

  PROCEDURE PV_ACTIVA_SEGURO_PR(EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                EO_COD_SEGURO            IN              VARCHAR2,
                                EO_NUM_EVENTO               IN              NUMBER,
                                EO_PRC_LISTA                IN              NUMBER,
                                EO_USUARIO               IN              GA_ABOCEL.NOM_USUARORA%TYPE,
                                sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento            OUT NOCOPY      ge_errores_pg.evento);

 PROCEDURE PV_DESACTIVA_SEGURO_PR(EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                  EO_COD_SEGURO            IN              VARCHAR2,
                                  EO_USUARIO               IN              GA_ABOCEL.NOM_USUARORA%TYPE,
                                  sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                  sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                  sn_num_evento            OUT NOCOPY      ge_errores_pg.evento);
 PROCEDURE PV_BAJA_CARGREC_PR   ( EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                  EO_COD_SEGURO            IN              VARCHAR2,
                                  EO_USUARIO               IN              GA_ABOCEL.NOM_USUARORA%TYPE,
                                  EN_CLIENTE_ORIGEN        IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                                  sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                  sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                  sn_num_evento            OUT NOCOPY      ge_errores_pg.evento);
PROCEDURE PV_DESACTIVA_SEGURO_SEG_PR(EO_NUM_ABONADO          IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                     EO_COD_SEGURO            IN              VARCHAR2,
                                     EO_USUARIO               IN              GA_ABOCEL.NOM_USUARORA%TYPE,
                                     sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                     sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                     sn_num_evento            OUT NOCOPY      ge_errores_pg.evento);


END PV_SEGURO_ABON_PG;
/
SHOW ERROR