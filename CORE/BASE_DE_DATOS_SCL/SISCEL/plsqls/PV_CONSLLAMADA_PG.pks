create or replace
PACKAGE PV_CONSLLAMADA_PG AS
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
   
 PROCEDURE PV_DETALLE_FACTURADO_PR(EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                   EO_COD_CICLFACT          IN              FA_HISTDOCU.COD_CICLFACT%TYPE,
                                   EO_NUM_FOLIO             IN              FA_HISTDOCU.NUM_FOLIO%TYPE,
                                   EO_FEC_INI               IN              DATE,
                                   EO_FEC_TERM              IN              DATE,
                                   EO_USUARIO               IN              GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                   EO_CAMPO                 IN              VARCHAR2:=NULL,
                                   EO_TIPO_ORDEN            IN              VARCHAR2:=NULL,
                                   SO_Lista_Abonado         OUT NOCOPY      refCursor,
                                   SN_COD_RETORNO           OUT NOCOPY      ge_errores_pg.CodError,
                                   SV_MENS_RETORNO          OUT NOCOPY      ge_errores_pg.MsgError,
                                   SN_NUM_EVENTO            OUT NOCOPY      ge_errores_pg.Evento);
  PROCEDURE PV_DETALLE_FACTURADO_PR(EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                  EO_COD_CICLFACT          IN              FA_HISTDOCU.COD_CICLFACT%TYPE,
                                  EO_NUM_FOLIO             IN              FA_HISTDOCU.NUM_FOLIO%TYPE,
                                  EO_FEC_INI               IN              varchar2,
                                  EO_FEC_TERM              IN              varchar2,
                                  EO_USUARIO               IN              GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                  EO_CAMPO                 IN              VARCHAR2:=NULL,
                                  EO_TIPO_ORDEN            IN              VARCHAR2:=NULL,
                                  SO_Lista_Abonado         OUT NOCOPY      refCursor);
 PROCEDURE PV_RESUMEN_FACTURADO_PR(EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                   EO_COD_CICLFACT          IN              FA_HISTDOCU.COD_CICLFACT%TYPE,
                                   EO_NUM_FOLIO             IN              FA_HISTDOCU.NUM_FOLIO%TYPE,
                                   EO_FEC_INI               IN              varchar2,
                                   EO_FEC_TERM              IN              varchar2,
                                   EO_USUARIO               IN              GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                   SO_Lista_Abonado         OUT NOCOPY      refCursor);
PROCEDURE PV_CONVERSOR_MONEDA_PR(               EO_MONE_ORI              IN              GE_MONEDAS.COD_MONEDA%TYPE,
                                                EO_MONE_DES              IN              GE_MONEDAS.COD_MONEDA%TYPE,
                                                EO_MONTO                 IN              NUMBER,
                                                SO_VALOR_CALC            OUT NOCOPY      NUMBER,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento);
PROCEDURE PV_CONS_FACTURACLI_PR(EO_COD_CLIENTE             IN            GA_ABOCEL.COD_CLIENTE%TYPE,
                                EN_num_opcion             IN             NUMBER,
                                SO_Lista_Abonado         OUT NOCOPY      refCursor);
 PROCEDURE PV_DETALLE_FACT_PR(EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                  EO_COD_CICLFACT          IN              FA_HISTDOCU.COD_CICLFACT%TYPE,
                                  EO_NUM_FOLIO             IN              FA_HISTDOCU.NUM_FOLIO%TYPE,
                                  EO_FEC_INI               IN              varchar2,
                                  EO_FEC_TERM              IN              varchar2,
                                  EO_USUARIO               IN              GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                  SO_Lista_Abonado         OUT NOCOPY      refCursor);
PROCEDURE PV_IMPUESTO_PR(                       EO_COD_CLIENTE           IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                                                EO_USUARIO               IN              GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                                SO_VALOR_CALC            OUT NOCOPY      NUMBER,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento);
END PV_CONSLLAMADA_PG; 
/
SHOW ERRORS