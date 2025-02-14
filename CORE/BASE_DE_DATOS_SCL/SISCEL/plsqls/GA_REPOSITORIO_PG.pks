CREATE OR REPLACE PACKAGE GA_REPOSITORIO_PG IS

    CV_error_no_clasif   CONSTANT VARCHAR2(30) := 'Error no clasificado';
    cn_largoerrtec       CONSTANT NUMBER        := 4000;
    cn_largodesc         CONSTANT NUMBER        := 2000;
    cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'VE';
    CV_PRODUCTO          CONSTANT VARCHAR(1)   := '1';
    CV_tipodireccion     CONSTANT VARCHAR2(1)  := '1';
    CV_MODULO_GA         CONSTANT VARCHAR2(2)  := 'GA';
    CV_MODULO_GE         CONSTANT VARCHAR2(2)  := 'GE';
    CV_MODULO_AL         CONSTANT VARCHAR2(2)  := 'AL';
    CV_CODACT_VEN         CONSTANT VARCHAR2(2)  := 'VO';               -- codigo actuacion : venta oficina
    CV_FORMATO_FECHA     CONSTANT VARCHAR2(12) := 'FORMATO_SEL2';
    CV_FORMATO_FECHA_SIS CONSTANT VARCHAR2(17)  := 'DDMMYYYY HH24MISS';
    CV_NOMPAR_MONEDAPESO CONSTANT VARCHAR2(15) := 'COD_MONEDA_PESO';
    CV_NOMPAR_SERVHABILI CONSTANT VARCHAR2(18) := 'COD_SERVICIO_HABIL';
    CV_NOMPAR_INDTELOUT  CONSTANT VARCHAR2(11) := 'IND_TEL_OUT';

    CV_SERVOCASIONAL     CONSTANT VARCHAR(1)   := '1';
    CV_SERVSUPLEMENTARIO CONSTANT VARCHAR2(1)  := '2';
    CN_INDBLOQUEO         CONSTANT NUMBER       := 1;
    CN_ESTADO              CONSTANT NUMBER       := 0;
    CI_TRUE              CONSTANT PLS_INTEGER  := 1;
    CI_FALSE             CONSTANT PLS_INTEGER  := 0;
    CV_IND_VENTA_EXTERNA CONSTANT NUMBER       := 1;
    CV_IND_TIPO_VENTA    CONSTANT VARCHAR2(1)  := 'V' ;
    CV_TIP_VENTA_OFICINA CONSTANT VARCHAR2(1)  := 'O' ;
    CV_FORM_PRESU_VTA      CONSTANT VARCHAR2(15)  := 'FrmPresuVenta';
    CV_BAJA_ABONADO      CONSTANT VARCHAR2(3)  := 'BAA';
    CV_BAJA_ABONADOPDTE  CONSTANT VARCHAR2(3)  := 'BAP';
    CV_RECHAZADA         CONSTANT VARCHAR2(2)  := 'RE';
    CV_INDALTA           CONSTANT VARCHAR2(1)  := 'M';  --INC 45391
    CN_ESTADO_DOC         CONSTANT NUMBER       := 900;
    CN_ESTADO_PROC         CONSTANT NUMBER       := 3;
    CV_REPONE_CELULAR    CONSTANT VARCHAR(1)   := 'R';  --Indica reposición de numero celular
    CV_REPONE_CEL_RES    CONSTANT VARCHAR(1)   := 'S';  --Indica reposición de num celular reservado
    CV_CAUSA_ELIMIN      CONSTANT VARCHAR2(5)  := '00003';
    CN_CERO              CONSTANT NUMBER(1)    := 0;

    TYPE refcursor                  IS REF CURSOR;
    TYPE ARRAY_PARAMETROS_    IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;

    PROCEDURE VE_getList_TiposDocumentos_PR (SC_cursordatos      OUT NOCOPY REFCURSOR,
                                            SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
        PROCEDURE VE_getList_DocDigitalizados_PR (EN_numventa        IN GA_VENTAS.NUM_VENTA%TYPE,
                                              EN_NUM_CORRELATIVO     IN GA_DOC_DIGITALIZADOS_TO.NUM_CORRELATIVO%TYPE,
                                              EN_codTipdocumento     IN GA_TIPDOC_DIGITALIZADOS_TD.COD_TIPO_DOC%TYPE,
                                              SC_cursordatos       OUT NOCOPY REFCURSOR,
                                              SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);
                                              
    PROCEDURE VE_Ins_DocDigitalizados_PR (
        EN_numventa             IN          GA_VENTAS.NUM_VENTA%TYPE,
        EN_codTipdocumento      IN          GA_TIPDOC_DIGITALIZADOS_TD.COD_TIPO_DOC%TYPE,
        EV_OBSERVACION          IN          GA_DOC_DIGITALIZADOS_TO.OBSERVACION%TYPE,
        EV_NOM_USUARORA         IN          GA_DOC_DIGITALIZADOS_TO.NOM_USUARORA%TYPE,
        EV_VALOR_CONTENT_TYPE   IN          GA_DOC_DIGITALIZADOS_TO.VALOR_CONTENT_TYPE%TYPE,
        EV_NOMBRE_ARCHIVO       IN          GA_DOC_DIGITALIZADOS_TO.NOMBRE_ARCHIVO%TYPE,
        EV_BIN_ARCHIVO          IN          GA_DOC_DIGITALIZADOS_TO.BIN_ARCHIVO%TYPE,
        SN_Secuencia            OUT NOCOPY  GA_DOC_DIGITALIZADOS_TO.NUM_CORRELATIVO%TYPE,
        SN_cod_retorno          OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno         OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento           OUT NOCOPY  ge_errores_pg.Evento);
        
  PROCEDURE VE_Del_DocDigitalizados_PR       (EN_CORRELATIVO       IN GA_DOC_DIGITALIZADOS_TO.NUM_CORRELATIVO%TYPE,
                                              SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);


    PROCEDURE VE_INSERTA_DOCDIG_SCORING_PR (
           EV_NUM_SOLSCORING       IN              GA_DOC_DIGITALIZADOS_TO.NUM_SOLSCORING%TYPE,
           EV_OBSERVACION          IN              GA_DOC_DIGITALIZADOS_TO.OBSERVACION%TYPE,
           EV_NOM_USUARORA         IN              GA_DOC_DIGITALIZADOS_TO.NOM_USUARORA%TYPE,
           EV_VALOR_CONTENT_TYPE   IN              GA_DOC_DIGITALIZADOS_TO.VALOR_CONTENT_TYPE%TYPE,
           EV_COD_DOCSCORING       IN              GA_DOC_DIGITALIZADOS_TO.COD_DOCSCORING%TYPE,
           EV_DES_DOCSCORING       IN              GA_DOC_DIGITALIZADOS_TO.DES_DOCSCORING%TYPE,
           EV_REQUERIDO_SCORING    IN              GA_DOC_DIGITALIZADOS_TO.REQUERIDO_SCORING%TYPE,
           EV_NOMBRE_ARCHIVO       IN              GA_DOC_DIGITALIZADOS_TO.NOMBRE_ARCHIVO%TYPE,
           SN_NUM_CORRELATIVO      OUT NOCOPY      GA_DOC_DIGITALIZADOS_TO.NUM_CORRELATIVO%TYPE,
           SN_cod_retorno          OUT NOCOPY      ge_errores_pg.coderror,
           SV_mens_retorno         OUT NOCOPY      ge_errores_pg.msgerror,
           SN_num_evento           OUT NOCOPY      ge_errores_pg.evento );

      PROCEDURE VE_INSERTA_DOCDIG_SCORING_PR (
           EV_NUM_SOLSCORING       IN              GA_DOC_DIGITALIZADOS_TO.NUM_SOLSCORING%TYPE,
           EV_COD_DOCSCORING       IN              GA_DOC_DIGITALIZADOS_TO.COD_DOCSCORING%TYPE,
           EV_DES_DOCSCORING       IN              GA_DOC_DIGITALIZADOS_TO.DES_DOCSCORING%TYPE,
           EV_REQUERIDO_SCORING    IN              GA_DOC_DIGITALIZADOS_TO.REQUERIDO_SCORING%TYPE,
           SN_NUM_CORRELATIVO      OUT NOCOPY      GA_DOC_DIGITALIZADOS_TO.NUM_CORRELATIVO%TYPE,
           SN_cod_retorno          OUT NOCOPY      ge_errores_pg.coderror,
           SV_mens_retorno         OUT NOCOPY      ge_errores_pg.msgerror,
           SN_num_evento           OUT NOCOPY      ge_errores_pg.evento );

    PROCEDURE VE_listar_DocDigScoring_PR (
        EV_NUM_CORRELATIVO      IN          GA_DOC_DIGITALIZADOS_TO.NUM_CORRELATIVO%TYPE,
        EN_NUM_SOLSCORING       IN          GA_DOC_DIGITALIZADOS_TO.NUM_SOLSCORING%TYPE,
        SC_cursordatos          OUT NOCOPY  REFCURSOR,
        SN_cod_retorno          OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno         OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento           OUT NOCOPY  ge_errores_pg.Evento);

    PROCEDURE VE_UPDATE_DOCDIGITALIZADO_PR (
        EV_NUM_CORRELATIVO      IN          GA_DOC_DIGITALIZADOS_TO.NUM_CORRELATIVO%TYPE,
        EV_NOM_USUARORA         IN          GA_DOC_DIGITALIZADOS_TO.NOM_USUARORA%TYPE,
        EV_NOMBRE_ARCHIVO       IN          GA_DOC_DIGITALIZADOS_TO.NOMBRE_ARCHIVO%TYPE,
        EV_OBSERVACION          IN          GA_DOC_DIGITALIZADOS_TO.OBSERVACION%TYPE,
        EV_VALOR_CONTENT_TYPE   IN          GA_DOC_DIGITALIZADOS_TO.VALOR_CONTENT_TYPE%TYPE,
        EV_BIN_ARCHIVO          IN          GA_DOC_DIGITALIZADOS_TO.BIN_ARCHIVO%TYPE,
        SN_cod_retorno          OUT NOCOPY  ge_errores_pg.coderror,
        SV_mens_retorno         OUT NOCOPY  ge_errores_pg.msgerror,
        SN_num_evento           OUT NOCOPY  ge_errores_pg.evento);

END GA_REPOSITORIO_PG; 
/

SHOW ERRORS
