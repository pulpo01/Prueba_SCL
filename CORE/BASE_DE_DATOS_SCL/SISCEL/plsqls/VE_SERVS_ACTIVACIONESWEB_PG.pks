CREATE OR REPLACE PACKAGE Ve_Servs_ActivacionesWeb_Pg IS

   -- Constantes -------------------------------------------------------------------------------

        -- Nombre del package

        CV_NOMBRE_PACKAGE        CONSTANT VARCHAR2(27) := 'VE_Servs_ActivacionesWeb_PG';

        -- Parametros

        CN_ERROR_OTHERS          CONSTANT NUMBER       := 156;     -- No es posible ejecutar el servicio
        CN_ERROR_EJECUCION       CONSTANT NUMBER       := 237;     -- No es posible ejecutar el procedimiento
        CN_ERROR_PARAMETROS      CONSTANT NUMBER       := 98;      -- Parametros de entrada
        CV_MODULO_GA             CONSTANT VARCHAR2 (2) := 'GA';
        CV_MODULO_GE             CONSTANT VARCHAR2 (2) := 'GE';
        CV_ERROR_NOCLASIF        CONSTANT VARCHAR2(30) := 'Error no clasificado';
        CV_NOMPAR_CONCONS        CONSTANT VARCHAR2(11) := 'COD_CONCONS';
        CV_NOMPAR_MODPRICTA      CONSTANT VARCHAR2(13) := 'COD_MODPRICTA';
        CV_NOMPAR_VENTNOLEG      CONSTANT VARCHAR2(16) := 'CANT_VENT_NO_LEG';
        CV_NOMPAR_DIASLEGAL      CONSTANT VARCHAR2(17) := 'DIAS_LEGALIZACION';
        CV_NOMPAR_TIPOPREPAGO    CONSTANT VARCHAR2(11) := 'TIPOPREPAGO';
        CV_NOMPAR_TIPPLANSERV    CONSTANT VARCHAR2(18) := 'TIPO_PLAN_SERVICIO';
        CV_NOMPAR_USOPREPAGO     CONSTANT VARCHAR2(11) := 'USO_PREPAGO';
        CV_NOMPAR_VALCLASIFIC    CONSTANT VARCHAR2(20) := 'VALIDA_CLASIFICACION';
        CN_ERROR_VALIDAREGION    CONSTANT NUMBER       := 304;     -- Codigo region invalido
        CN_ERROR_VALIDAPROVINCIA CONSTANT NUMBER       := 305;     -- Codigo provincia invalido
        CN_ERROR_VALIDACIUDAD    CONSTANT NUMBER       := 306;     -- Codigo ciudad invalido
        CN_ERROR_VALIDACOMUNA    CONSTANT NUMBER       := 307;     -- Codigo comuna invalido
        CV_ERROR_REGPROCOMCIUFDA CONSTANT VARCHAR2(66) := 'Faltan datos para la combinacion region, provincia,comuna y ciudad';
        CV_ERROR_REGPROCOMCIUNOK CONSTANT VARCHAR2(61) := 'Combinacion region, provincia, comuna y ciudad no esta en SCL';
        CV_TEC_GSM               CONSTANT VARCHAR2(3)  := 'GSM';  -- Tecnologia GSM
        CV_INDALTA_V             CONSTANT VARCHAR2(1)  := 'V';  -- indicador alta venta
        CV_CANALDIRECTO          CONSTANT VARCHAR2(1)  := 'D';  -- canal vendedor : directo
        CV_CANALINDIRECTO        CONSTANT VARCHAR2(1)  := 'I';  -- canal vendedor : indirecto
        CV_ESTARCHFACTURA        CONSTANT VARCHAR2(1)  := '3';  -- estado archivo factura

        CV_VALOR_TRUE            CONSTANT VARCHAR2(4)  := 'TRUE';   -- valor TRUE
        CV_VALOR_FALSE           CONSTANT VARCHAR2(5)  := 'FALSE';  -- valor FALSE

        CN_INDACEPVENT           CONSTANT NUMBER       := 1;
        CN_CODACCION             CONSTANT NUMBER       := 0;     -- codigo accion facturacion !!!
        CN_INDDELAER             CONSTANT NUMBER       := 1;    -- indicador vendedor dealer

        CV_NOMTAB_GEDCODIGOS     CONSTANT VARCHAR2(12) := 'TA_PLANTARIF';
        CV_NOMCOL_GEDCODIGOS     CONSTANT VARCHAR2(10) := 'COD_TIPLAN';
        CV_NOMTAB_GEDCODIGOS2    CONSTANT VARCHAR2(9)  := 'FA_CICLOS';
        CV_NOMCOL_GEDCODIGOS2    CONSTANT VARCHAR2(9)  := 'COD_CICLO';
        CV_NOMTAB_COCODIGOS      CONSTANT VARCHAR2(17) := 'FA_TIPDOCDIREC_TD';
        CV_NOMCOL_COCODIGOS      CONSTANT VARCHAR2(13) := 'COD_DIRECCION';

        CV_SECUENCIADIRECCION    CONSTANT VARCHAR2(18) := 'GE_SEQ_DIRECCIONES';
        CV_error_no_clasif       CONSTANT VARCHAR2(30) := 'Error no clasificado';
        cn_largoerrtec           CONSTANT NUMBER        := 4000;
        cn_largodesc             CONSTANT NUMBER        := 2000;
        cv_cod_modulo            CONSTANT VARCHAR2 (2)  := 'VE';

   -- Tipos ------------------------------------------------------------------------------------

   TYPE refcursor IS REF CURSOR;

   TYPE T_CURSORGETVENTA IS RECORD (
                T_SECUENCIA     NUMBER(10),
                T_TIPO          VARCHAR2(9),
                TIPO_PRODUCTO   VARCHAR2(10),
                T_COD_VENDEDOR  NUMBER(6),
                T_NOM_VENDEDOR  VARCHAR2(40),
                T_NUM_VENTA     NUMBER(8),
                T_COD_CUENTA    NUMBER(8),
                T_NUM_ABONADO   NUMBER(8),
                T_NUM_CELULAR   NUMBER(15),
                T_COD_TIPIDENT  VARCHAR2(2),
                T_NUM_IDENT     VARCHAR2(20),
                T_NOM_CLIENTE   VARCHAR2(50),
                T_NOM_APECLIEN1 VARCHAR2(20),
                T_NOM_APECLIEN2 VARCHAR2(20),
                T_FEC_VENTA     DATE,
                T_FEC_ALTA      DATE,
                T_COD_PLANTARIF VARCHAR2(3),
                T_DES_PLANTARIF VARCHAR2(30),
                T_TOT_FACTURA   NUMBER(14,4),
                T_NUM_FOLIO     NUMBER(9),
                T_IND_IMPRESA   VARCHAR2(100),
                T_COD_CLIENTE  GE_CLIENTES.COD_CLIENTE%TYPE,
                T_NOM_USUARORA GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                T_IND_ESTVENTA GA_VENTAS.IND_ESTVENTA%TYPE,
                T_COD_SITUACION GA_ABOCEL.COD_SITUACION%TYPE,
                T_COD_CICLO     GA_ABOCEL.COD_CICLO%TYPE
                );

   TYPE T_CURSORSsoPCional IS RECORD (
                T_COD_SERVICIO        GA_SERVSUPL.COD_SERVICIO%TYPE,
                T_COD_SERVSUPL        GA_SERVSUPL.COD_SERVSUPL%TYPE,
                T_DES_SERVICIO        GA_SERVSUPL.DES_SERVICIO%TYPE,
                T_COD_NIVEL           GA_SERVSUPL. DES_SERVICIO%TYPE,
                T_IND_DEFAULT         VARCHAR2(30),
                T_IMP_TARIFA_CONEXION GA_TARIFAS.IMP_TARIFA%TYPE,
                T_DES_MONEDA_CONEXION GE_MONEDAS.DES_MONEDA%TYPE,
                T_IMP_TARIFA_MENSUAL  GA_TARIFAS.IMP_TARIFA%TYPE,
                T_DES_MONEDA_MENSUAL  GE_MONEDAS.DES_MONEDA%TYPE,
                T_IND_IP              GA_SERVSUPL.IND_IP%TYPE,
                T_TIP_COBRO           GA_SERVSUPL.TIP_COBRO%TYPE,
                T_TIP_RED             GA_SERVSUPL.TIP_RED%TYPE
                );

   TYPE TC_cursorDatosSS IS TABLE OF  T_CURSORSsoPCional
   INDEX BY BINARY_INTEGER;

   TYPE  TC_cursordatos IS TABLE OF T_CURSORGETVENTA
   INDEX BY BINARY_INTEGER;

   iCantRegistros       BINARY_INTEGER := 0;

  ---------------------------------------------------------------------------------
  -- Declaracion de Tipos
  ---------------------------------------------------------------------------------

        TYPE rUBICACION_DIR IS RECORD
        (COD_REGION     ge_regiones.COD_REGION%TYPE,
         COD_PROVINCIA  ge_provincias.COD_PROVINCIA%TYPE,
         COD_COMUNA     ge_comunas.COD_COMUNA%TYPE,
         COD_CIUDAD     ge_ciudades.COD_CIUDAD%TYPE
        );

   -- Datos -----------------------------------------------------------------------------------

   PROCEDURE VE_getDatosGenerales_PR(EV_columna      IN VARCHAR2,
                                     SN_valor        OUT NOCOPY VARCHAR2,
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getCliente_PR(EV_codCliente    IN VARCHAR2,
                                   EV_TipIdentif    IN VARCHAR2,
                                   EV_numIdentif    IN VARCHAR2,
                                   SV_codCliente    OUT NOCOPY VARCHAR2,
                                   SV_nomCliente    OUT NOCOPY VARCHAR2,
                                   SV_nomApell1     OUT NOCOPY VARCHAR2,
                                   SV_nomApell2     OUT NOCOPY VARCHAR2,
                                   SV_TipIdentif    OUT NOCOPY VARCHAR2,
                                   SV_numIdentif    OUT NOCOPY VARCHAR2,
                                   SV_numTelefono1  OUT NOCOPY VARCHAR2,
                                   SV_mail          OUT NOCOPY VARCHAR2,
                                   SV_fecNacimiento OUT NOCOPY VARCHAR2,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getVendedor_PR(EV_codVendedor     IN VARCHAR2,
                                    EV_codCanal        IN VARCHAR2,
                                    SV_nomVendedor     OUT NOCOPY VARCHAR2,
                                    SV_tipComisionista OUT NOCOPY VARCHAR2,
                                    SV_desComisionista OUT NOCOPY VARCHAR2,
                                    SV_codDireccion    OUT NOCOPY VARCHAR2,
                                    SV_codOficina      OUT NOCOPY VARCHAR2,
                                    SV_desOficina      OUT NOCOPY VARCHAR2,
                                    SV_codRegion       OUT NOCOPY VARCHAR2,
                                    SV_desRegion       OUT NOCOPY VARCHAR2,
                                    SV_codProvincia    OUT NOCOPY VARCHAR2,
                                    SV_desProvincia    OUT NOCOPY VARCHAR2,
                                    SV_codCiudad       OUT NOCOPY VARCHAR2,
                                    SV_desCiudad       OUT NOCOPY VARCHAR2,
                                    SV_desCalle        OUT NOCOPY VARCHAR2,
                                    SV_numCalle        OUT NOCOPY VARCHAR2,
                                    SV_ObsDireccion    OUT NOCOPY VARCHAR2,
                                    SV_nomVendealer    OUT NOCOPY VARCHAR2,
                                    SV_CodVendealer    OUT NOCOPY VARCHAR2,
                                    SV_CodVendedor     OUT NOCOPY VARCHAR2,
                                    SV_TipoCalle       OUT NOCOPY VARCHAR2,
                                    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getVentasNoLegal_PR(EV_codVendedor  IN VARCHAR2,
                                     EV_codVendealer IN VARCHAR2,
                                     EV_codCanal     IN VARCHAR2,
                                     SC_cursordatos  OUT NOCOPY TC_cursordatos,
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getVentas_PR(EV_codVendedor  IN VARCHAR2,
                              EV_codVendealer IN VARCHAR2,
                              EV_codCanal     IN VARCHAR2,
                              EV_fecDesde     IN VARCHAR2,
                              EV_fecHasta     IN VARCHAR2,
                              SC_cursordatos  OUT NOCOPY TC_cursordatos,
                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                              SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getNombrePDFFactura_PR(EN_numFolio     IN NUMBER,
                                        SV_nombre       OUT NOCOPY VARCHAR2,
                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getPathPDFFactura_PR(SV_path         OUT NOCOPY VARCHAR2,
                                      SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getCicloFactMasProx_PR(SV_cod_ciclo        OUT NOCOPY VARCHAR2,
                                            SV_ano              OUT NOCOPY VARCHAR2,
                                            SV_cod_ciclfact     OUT NOCOPY VARCHAR2,
                                            SV_fec_vencimie     OUT NOCOPY VARCHAR2,
                                            SV_fec_emision      OUT NOCOPY VARCHAR2,
                                            SV_fec_caducida     OUT NOCOPY VARCHAR2,
                                            SV_fec_proxvenc     OUT NOCOPY VARCHAR2,
                                            SV_fec_desdellam    OUT NOCOPY VARCHAR2,
                                            SV_fec_hastallam    OUT NOCOPY VARCHAR2,
                                            SV_dia_periodo      OUT NOCOPY VARCHAR2,
                                            SV_fec_desdecfijos  OUT NOCOPY VARCHAR2,
                                            SV_fec_hastacfijos  OUT NOCOPY VARCHAR2,
                                            SV_fec_desdeocargos OUT NOCOPY VARCHAR2,
                                            SV_fec_hastaocargos OUT NOCOPY VARCHAR2,
                                            SV_fec_desderoa     OUT NOCOPY VARCHAR2,
                                            SV_fec_hastaroa     OUT NOCOPY VARCHAR2,
                                            SV_ind_facturacion  OUT NOCOPY VARCHAR2,
                                            SV_dir_logs         OUT NOCOPY VARCHAR2,
                                            SV_dir_spool        OUT NOCOPY VARCHAR2,
                                            SV_des_leyen1       OUT NOCOPY VARCHAR2,
                                            SV_des_leyen2       OUT NOCOPY VARCHAR2,
                                            SV_des_leyen3       OUT NOCOPY VARCHAR2,
                                            SV_des_leyen4       OUT NOCOPY VARCHAR2,
                                            SV_des_leyen5       OUT NOCOPY VARCHAR2,
                                            SV_ind_tasador      OUT NOCOPY VARCHAR2,
                                            SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getDireccionUsuario_PR(EV_codUsuario   IN VARCHAR2,
                                            EV_TipDireccion IN VARCHAR2,
                                            SV_codDireccion OUT NOCOPY VARCHAR2,
                                            SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_RecepcionDocumentos_PR(EV_numVenta     IN VARCHAR2,
                                            EV_nomUsuario   IN VARCHAR2,
                                            SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_ComplementacionDatos_PR(EV_numVenta     IN VARCHAR2,
                                             EV_nomUsuario   IN VARCHAR2,
                                             SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_AceptacionVenta_PR(EV_numVenta     IN VARCHAR2,
                                        EV_nomUsuario   IN VARCHAR2,
                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_EjecutaOmitidos_PR(EV_numVenta    IN VARCHAR2,
                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_LegalizacionVenta_PR(EV_numVenta    IN VARCHAR2,
                                          EV_nomUsuario  IN VARCHAR2,
                                          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    -- Insert y Updates ------------------------------------------------------------------------

       PROCEDURE VE_updUsuario_PR(EV_numAbonado   IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                  EV_nomUsuario    IN GA_USUARIOS.NOM_USUARIO%TYPE,
                                  EV_nomApell1     IN GA_USUARIOS.NOM_APELLIDO1%TYPE,
                                  EV_nomApell2     IN GA_USUARIOS.NOM_APELLIDO2%TYPE,
                                  EV_tipIdentif    IN GA_USUARIOS.COD_TIPIDENT%TYPE,
                                  EV_numIdentif    IN GA_USUARIOS.NUM_IDENT%TYPE,
                                  EV_codProvincia  IN GE_DIRECCIONES.COD_PROVINCIA%TYPE,
                                  EV_codCiudad     IN GE_DIRECCIONES.COD_CIUDAD%TYPE,
                                  EV_Direccion     IN GE_DIRECCIONES.DES_DIREC1%TYPE,
                                  EV_Observacion   IN GE_DIRECCIONES.OBS_DIRECCION%TYPE,
                                  EV_fecNacimiento IN VARCHAR2,
                                  EV_Sexo          IN GA_USUARIOS.IND_SEXO%TYPE,
                                  EV_codEstrato    IN GA_USUARIOS.COD_ESTRATO%TYPE,
                                  EV_Mail          IN GA_USUARIOS.EMAIL%TYPE,
                                  EV_usuarora      IN GA_MODDIRUS.NOM_USUARORA%TYPE,
                                  EV_TIPDIRECCION  IN GA_DIRECUSUAR.COD_TIPDIRECCION%TYPE,
                                  EV_cod_region    IN GE_DIRECCIONES.COD_REGION%TYPE,
                                  EV_cod_comuna    IN GE_DIRECCIONES.COD_COMUNA%TYPE,
                                  EV_tipo_calle    IN GE_DIRECCIONES.COD_TIPOCALLE%TYPE,
                                  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

   -- Listas y/o Cursores ----------------------------------------------------------------------

        PROCEDURE VE_getListCuotas_PR(SC_cursordatos  OUT NOCOPY REFCURSOR,
                                      SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getListArticulos_PR(EV_CodFabricante IN AL_ARTICULOS.COD_FABRICANTE%TYPE,
                                         EV_CodTecnologia IN AL_TECNOARTICULO_TD.COD_TECNOLOGIA%TYPE,
                                         SC_cursordatos  OUT NOCOPY REFCURSOR,
                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getListServSupl_PR(EV_codPlanTarif   IN VARCHAR2,
        EV_indCompatible  IN VARCHAR2,
        EV_TECNOLOGIA     IN AL_TECNOLOGIA.COD_TECNOLOGIA%TYPE,
        EV_CodActabo      IN GA_ACTABO.COD_ACTABO%TYPE,
        SC_cursordatos    OUT NOCOPY REFCURSOR,
        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getListVentas_PR(EV_codVendedor  IN VARCHAR2,
                                      EV_codVendealer IN VARCHAR2,
                                      EV_codCanal     IN VARCHAR2,
                                      EV_fecDesde     IN VARCHAR2,
                                      EV_fecHasta     IN VARCHAR2,
                                      EN_filtro       IN NUMBER,
                                      SC_cursordatos  OUT NOCOPY REFCURSOR,
                                      SV_codVendedor  OUT VARCHAR2,
                                      SV_nomVendedor  OUT VARCHAR2,
                                      SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getListDirCliente_PR(EV_codCliente   IN VARCHAR2,
                                          SC_cursordatos  OUT NOCOPY REFCURSOR,
                                          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getListPlanTarif_PR(EV_tipoProducto IN VARCHAR2,
                                         EV_codClasific  IN VARCHAR2,
                                         EV_codDcifra    IN VARCHAR2,
                                         EV_limiteCons   IN VARCHAR2,
                                         EV_codCliente   IN VARCHAR2,
                                         SC_cursordatos  OUT NOCOPY REFCURSOR,
                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getListUsuario_PR(EV_numAbonado    IN VARCHAR2,
                                       SV_nomUsuario    OUT NOCOPY VARCHAR2,
                                       SV_nomApell1     OUT NOCOPY VARCHAR2,
                                       SV_nomApell2     OUT NOCOPY VARCHAR2,
                                       SV_tipIdentif    OUT NOCOPY VARCHAR2,
                                       SV_numIdentif    OUT NOCOPY VARCHAR2,
                                       SV_codProvincia  OUT NOCOPY VARCHAR2,
                                       SV_nomProvincia  OUT NOCOPY VARCHAR2,
                                       SV_codCiudad     OUT NOCOPY VARCHAR2,
                                       SV_nomCiudad     OUT NOCOPY VARCHAR2,
                                       SV_Direccion     OUT NOCOPY VARCHAR2,
                                       SV_Observacion   OUT NOCOPY VARCHAR2,
                                       SV_fecNacimiento OUT NOCOPY VARCHAR2,
                                       SV_Sexo          OUT NOCOPY VARCHAR2,
                                       SV_codEstrato    OUT NOCOPY VARCHAR2,
                                       SV_Mail          OUT NOCOPY VARCHAR2,
                                       SV_COD_REGION    OUT NOCOPY VARCHAR2,
                                       SV_DES_REGION    OUT NOCOPY VARCHAR2,
                                       SV_COD_COMUNA    OUT NOCOPY VARCHAR2,
                                       SV_DES_COMUNA    OUT NOCOPY VARCHAR2,
                                       SV_COD_TIPOCALLE OUT NOCOPY VARCHAR2,
                                       SV_DES_TIPOCALLE OUT NOCOPY VARCHAR2,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_getCliente2_PR(EV_codCliente   IN VARCHAR2,
                                   EV_TipIdentif    IN VARCHAR2,
                                   EV_numIdentif    IN VARCHAR2,
                                   EV_TipoCliente   IN VARCHAR2,
                                   EV_telefono      IN GE_CLIENTES.TEF_CLIENTE1%TYPE,
                                   EV_Nombre1       IN GE_CLIENTES.NOM_CLIENTE%TYPE,
                                   EV_Apellido1     IN GE_CLIENTES.NOM_APECLIEN1%TYPE,
                                   EV_Apellido2     IN GE_CLIENTES.NOM_APECLIEN2%TYPE,
                                   EV_nomEmpresa    IN GE_CLIENTES.NOM_EMPRESA%TYPE,
                                   SC_cursordatos   OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_getNumMesesTipContrato_PR(EV_tipContrato  IN VARCHAR2,
                                               SN_valor        OUT NOCOPY VARCHAR2,
                                               SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getTipContrato_PR(SC_cursordatos    OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_VALIDA_SERIE_GSM_PR(EV_NumSerie        IN AL_SERIES.NUM_SERIE%TYPE,
                                     SN_cod_retorno     OUT ge_errores_pg.CodError,
                                     SV_mens_retorno    OUT ge_errores_pg.MsgError,
                                     SN_num_evento      OUT ge_errores_pg.Evento);

   PROCEDURE VE_obtiene_SS_Tercen_PR(  EV_CodActabo    IN  GA_ACTABO.COD_ACTABO%TYPE,
                                    EV_CodPlanServ  IN  GA_PLANSERV.COD_PLANSERV%TYPE,
                                    EV_TECNOLOGIA   IN  AL_TECNOLOGIA.COD_TECNOLOGIA%TYPE,
                                    SC_cursordatos  OUT NOCOPY TC_cursorDatosSS,
                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

----------------------------
-- DECLARACION DE FUNCIONES
--------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ve_valida_existe_en_scl_fn (
      ev_tabla        IN              VARCHAR2,
      ev_columna      IN              VARCHAR2,
      ev_valor_str    IN              VARCHAR2,
      ev_valor_num    IN              LONG,
      sn_codretorno   OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY      ge_errores_pg.evento
   )
   RETURN BOOLEAN;

   FUNCTION VE_valida_existe_relacion_FN(ER_sector    IN rUBICACION_DIR,
                                         SN_cod_Retorno  OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
                                         RETURN BOOLEAN;

   FUNCTION VE_valida_tipo_calle_FN(EV_valor        IN  VARCHAR2,
                                    SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
                                    SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
                                    SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO)
                                    RETURN BOOLEAN;

--------------------------------------------------------------------------------------------------------------------------------------------

   --Declaracion Procedimiento que Valida Datos de Direcciones

   PROCEDURE VE_VALIDA_DIRECCION_PR (EV_CodRegion    IN  GE_REGIONES.COD_REGION%TYPE,       --Varchar2(3)
                                     EV_CodProvincia IN  GE_PROVINCIAS.COD_PROVINCIA%TYPE,  --Varchar2(5)
                                     EV_CodCiudad    IN  GE_CIUDADES.COD_CIUDAD%TYPE,       --Varchar2(3)
                                     EV_CodComuna    IN  GE_COMUNAS.COD_COMUNA%TYPE,        --VARCHAR2(3)
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);


PROCEDURE VE_OBTIENE_DATOS_PAGARE_PR (
                                       EN_NUMVENTA        IN  GA_VENTAS.NUM_VENTA%TYPE,
                                       --Valores Pagare Equipo
                                       SN_IMP_EQUIPO      OUT NOCOPY NUMBER,
                                       SV_DINERO_LETRAS_EQ   OUT NOCOPY VARCHAR2,
                                       SV_DECIMAL_LETRAS_EQ  OUT NOCOPY VARCHAR2,
                                       --Valores del Pagare Limite consumo
                                       SN_IMP_LIM      OUT NOCOPY NUMBER,
                                       SV_DINERO_LETRAS_LIM   OUT NOCOPY VARCHAR2,
                                       SV_DECIMAL_LETRAS_LIM  OUT NOCOPY VARCHAR2,
                                       --Valores unicos del reporte
                                       SV_NOM_CLIENTE     OUT NOCOPY VARCHAR2,
                                       SV_GLOSA_DIR       OUT NOCOPY VARCHAR2,
                                       SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_OBTIENE_DATOS_FICHA_PR (
                                       EN_NUM_ABONADO     IN GA_ABOAMIST.NUM_ABONADO%TYPE,
                                       --Salida
                                       SV_NOM_CLIENTE     OUT NOCOPY VARCHAR2,
                                       SD_FEC_NACIMIENTO   OUT NOCOPY GE_CLIENTES.FEC_NACIMIEN%TYPE,
                                       SV_PROFESION       OUT NOCOPY VARCHAR2,
                                       SV_TELEFONO        OUT NOCOPY GE_CLIENTES.TEF_CLIENTE1%TYPE,
                                       SV_GLOSA_DIR       OUT NOCOPY VARCHAR2,
                                       SV_GLOSA_IDENT     OUT NOCOPY VARCHAR2,
                                       SV_COD_VENDEALER   OUT NOCOPY VE_VENDEALER.COD_VENDEALER%TYPE,
                                       SV_NOM_VENDEALER   OUT NOCOPY VE_VENDEALER.NOM_VENDEALER%TYPE,
                                       SV_DES_OFICINA     OUT NOCOPY GE_OFICINAS.DES_OFICINA%TYPE,
                                       SV_NOM_VENDEDOR    OUT NOCOPY VE_VENDEDORES.NOM_VENDEDOR%TYPE,
                                       SV_DESC_TERMINAL   OUT NOCOPY AL_ARTICULOS.DES_ARTICULO%TYPE,
                                       SV_ICC             OUT NOCOPY GA_ABOAMIST.NUM_SERIE%TYPE,
                                       SV_IMEI            OUT NOCOPY GA_ABOAMIST.NUM_IMEI%TYPE,
                                       SV_NOM_USUARORA    OUT NOCOPY GA_ABOAMIST.NOM_USUARORA%TYPE,
                                       SN_NUM_CELULAR     OUT NOCOPY GA_ABOAMIST.NUM_CELULAR%TYPE,
                                       SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_OBTIENE_DATOS_SALBOD_PR (
                                       EN_NUM_VENTA       IN GA_VENTAS.NUM_VENTA%TYPE,
                                       SV_ESTADO_VENTA    OUT NOCOPY GA_VENTAS.IND_ESTVENTA%TYPE,
                                       SV_NOM_VENDEDOR        OUT NOCOPY VE_VENDEDORES.NOM_VENDEDOR%TYPE,
                                       SV_NOM_CLIENTE     OUT NOCOPY VARCHAR2,
                                       SV_NOM_USUARORA    OUT NOCOPY GA_VENTAS.NOM_USUAR_VTA%TYPE,
                                       SC_cursorDatos     OUT NOCOPY REFCURSOR,
                                       SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_OBTIENE_DATOS_CPST_PR (
                                       EN_NUM_VENTA       IN GA_VENTAS.NUM_VENTA%TYPE,
                                       SV_NOM_CLIENTE     OUT NOCOPY VARCHAR2,
                                       SV_TELEFONO        OUT NOCOPY GE_CLIENTES.TEF_CLIENTE1%TYPE,
                                       SV_PROFESION       OUT NOCOPY GE_ACTIVIDADES.DES_ACTIVIDAD%TYPE,
                                       SV_NUM_IDENT2      OUT NOCOPY GE_CLIENTES.NUM_IDENT2%TYPE,
                                       SV_GLOSA_DIR       OUT NOCOPY VARCHAR2,
                                       SV_NUM_IDENT       OUT NOCOPY GE_CLIENTES.NUM_IDENT%TYPE,
                                       SV_MODVENTA        OUT NOCOPY GE_MODVENTA.DES_MODVENTA%TYPE,
                                       SN_NUM_MESES       OUT NOCOPY GA_PERCONTRATO.NUM_MESES%TYPE,
                                       SV_REGISTRO_IVA    OUT NOCOPY FA_FACTDOCU_NOCICLO.NUM_FOLIO%TYPE,
                                       SC_cursorDatos     OUT NOCOPY REFCURSOR,
                                       SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
        PROCEDURE VE_getCuenta_PR (EV_codCuenta     IN GA_CUENTAS.COD_CUENTA%TYPE,
                                   EV_TipIdentif    IN GE_TIPIDENT.COD_TIPIDENT%TYPE,
                                   EV_numIdentif    IN GA_CUENTAS.NUM_IDENT%TYPE,
                                   EV_TipoCuenta    IN GA_CUENTAS.TIP_CUENTA%TYPE,
                                   EV_telefono      IN GA_CUENTAS.TEL_CONTACTO%TYPE,
                                   EV_NombreCuenta  IN GA_CUENTAS.DES_CUENTA%TYPE,
                                   EV_nombreResponsable GA_CUENTAS.NOM_RESPONSABLE%TYPE,
                                   SC_cursordatos   OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);
                                   
        PROCEDURE VE_existeAbonadoXSimcard_PR (
            en_num_serie        IN      GA_ABOCEL.NUM_SERIE%TYPE,
            en_existe           OUT     NOCOPY INTEGER,
            SN_cod_retorno      OUT     NOCOPY ge_errores_pg.CodError,
            SV_mens_retorno     OUT     NOCOPY ge_errores_pg.MsgError,
            SN_num_evento       OUT     NOCOPY ge_errores_pg.Evento
        );
        
        PROCEDURE VE_existeAbonadoXImei_PR (
            en_num_imei         IN      GA_ABOCEL.NUM_IMEI%TYPE,
            en_existe           OUT     NOCOPY INTEGER,
            SN_cod_retorno      OUT     NOCOPY ge_errores_pg.CodError,
            SV_mens_retorno     OUT     NOCOPY ge_errores_pg.MsgError,
            SN_num_evento       OUT     NOCOPY ge_errores_pg.Evento
        );

END Ve_Servs_ActivacionesWeb_Pg; 
/

SHOW ERRORS
