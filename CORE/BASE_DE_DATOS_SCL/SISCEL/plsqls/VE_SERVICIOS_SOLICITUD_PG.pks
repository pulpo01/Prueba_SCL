CREATE OR REPLACE PACKAGE VE_SERVICIOS_SOLICITUD_PG IS

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
    TYPE cursorArticulos            IS REF CURSOR;
    TYPE ARRAY_PARAMETROS_    IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;


    PROCEDURE VE_obtiene_niveles_prest_PR(  EV_cod_prestacion  IN  GE_PRESTACIONES_TD.COD_PRESTACION%TYPE,
                                                EN_cod_nivel       IN GA_NIVELPRESTACION_TD.COD_NIVEL%TYPE,
                                                SC_cursordatos     OUT NOCOPY REFCURSOR,
                                                SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);


   PROCEDURE VE_inserta_niveles_abo_PR ( EN_numAbonado         IN GA_ABONIVEL_TO.NUM_ABONADO%TYPE,
                                         EN_codNivel1         IN GA_ABONIVEL_TO.COD_NIVEL1%TYPE,
                                         EN_codNivel2         IN GA_ABONIVEL_TO.COD_NIVEL2%TYPE,
                                         EN_codNivel3         IN GA_ABONIVEL_TO.COD_NIVEL3%TYPE,
                                         SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
      PROCEDURE VE_Consulta_Vta_abo_PR ( EN_codCliente        IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                         SN_COUNT            OUT NOCOPY NUMBER,
                                         SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_inserta_datosAdic_abo_PR ( EN_numAbonado       IN GA_DATABONADO_TO.NUM_ABONADO%TYPE,
                                        EN_indRenova        IN GA_DATABONADO_TO.IND_RENOVA%TYPE,
                                        EN_numFax           IN GA_DATABONADO_TO.NUM_FAX%TYPE,
                                        EV_codCalificacion  IN GA_DATABONADO_TO.COD_CALIFICACION%TYPE,
                                        SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
      PROCEDURE VE_Upd_datosAdic_abo_PR ( EN_numAbonado     IN GA_DATABONADO_TO.NUM_ABONADO%TYPE,
                                          EV_DIR_MAC        IN GA_DATABONADO_TO.MAC_ADDRESS%TYPE,
                                          SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
       PROCEDURE VE_Valida_FlitroImpresion_PR
                                        (EV_NomUsuario          IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                         EV_cod_Programa        IN GE_PROGRAMAS.COD_PROGRAMA%TYPE,
                                         EV_NomProceso          IN GAD_PROCESOS_PERFILES.NOM_PERFIL_PROCESO%TYPE,
                                         EV_codVersion          IN GE_PROGRAMAS.NUM_VERSION%TYPE,
                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
    PROCEDURE VE_obtiene_Detalle_PA_PR(     EV_numVenta        IN GA_ABOCEL.NUM_VENTA%TYPE,
                                            SC_cursordatos     OUT NOCOPY REFCURSOR,
                                            SC_cursordatosSeguro     OUT NOCOPY REFCURSOR,
                                            SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);


    PROCEDURE VE_inserta_numsms_PR(  EN_numAbonado        IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                     EN_numSMS            IN GA_NUMSMS_TO.NUM_TELSMS%TYPE,
                                     EV_usuario           IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                     SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);


    PROCEDURE VE_existe_numsms_PR(  EN_numSMS             IN GA_NUMSMS_TO.NUM_TELSMS%TYPE,
                                     SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);
     PROCEDURE VE_VALIDA_VENDEDORLN_PR ( EN_COD_VENDEDOR      IN VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);
        PROCEDURE VE_VALIDA_VENDEDOREXTLN_PR
                                     (EN_COD_VENDEALER      IN VE_VENDEALER.COD_VENDEALER%TYPE,
                                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);
   PROCEDURE VE_VALIDA_CLIENTELN_PR
                                     (EN_COD_CLIENTE       IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                      EV_NUM_IDENT         GE_CLIENTES.NUM_IDENT%TYPE,
                                      EV_COD_TIPIDENT      GE_CLIENTES.COD_TIPIDENT%TYPE,
                                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);
      PROCEDURE VE_VALIDA_SERIELN_PR
                                     (EN_NUM_SERIE         IN GA_ABOCEL.NUM_SERIE%TYPE,
                                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

  PROCEDURE VE_ACTUALIZA_MOVPREACTIVO_PR (EN_NUM_ABONADO       IN GA_ABOCEL.NUM_SERIE%TYPE,
         SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
         SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
         SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

 PROCEDURE VE_LIBERAR_SERIESYTELEFONO_PR (EN_NumAbonado   IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_obtiene_montoCargoRec_PR(EN_cod_cargo      IN PF_CARGOS_PRODUCTOS_TD.COD_CARGO%TYPE,
                                      SN_monto_importe  OUT NOCOPY PF_CARGOS_PRODUCTOS_TD.MONTO_IMPORTE%TYPE,
                                      SV_cod_moneda     OUT NOCOPY PF_CARGOS_PRODUCTOS_TD.COD_MONEDA%TYPE,
                                      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);


PROCEDURE ve_actualiza_movproductosol_pr (EN_NUM_VENTA       IN GA_ABOCEL.NUM_VENTA%TYPE,
                                          SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

   PROCEDURE VE_con_rango_descto_usuario_PR(EN_nom_usuario    IN  ve_usuperfil_td.nom_usuario%TYPE,
                                          SN_pnt_dto_inf     OUT NOCOPY ga_perfilcargos.pnt_dto_inf%TYPE,
                                          SN_pnt_dto_sup     OUT NOCOPY ga_perfilcargos.pnt_dto_sup%TYPE,
                                          SN_prc_dto_inf     OUT NOCOPY ga_perfilcargos.prc_dto_inf%TYPE,
                                          SN_prc_dto_sup     OUT NOCOPY ga_perfilcargos.prc_dto_sup%TYPE,
                                          SN_ind_moddtos     OUT NOCOPY ga_perfilcargos.ind_moddtos%TYPE,
                                          SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_GET_ABONADOS_ACTIVOS_PR( EV_NUM_IDENT         GE_CLIENTES.NUM_IDENT%TYPE,
                                      EV_COD_TIPIDENT      GE_CLIENTES.COD_TIPIDENT%TYPE,
                                      SC_cursordatos       OUT NOCOPY REFCURSOR,
                                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);										  
										  
END Ve_Servicios_Solicitud_Pg;
/
