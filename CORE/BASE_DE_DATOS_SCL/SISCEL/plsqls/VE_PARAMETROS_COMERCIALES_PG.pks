CREATE OR REPLACE PACKAGE VE_parametros_comerciales_PG IS
/*
<Documentación TipoDoc = "package"
 <Elemento Nombre = "VE_PARAMETROS_COMERCIALES_PG"
           Lenguaje="PL/SQL"
           Fecha="17-01-2007"
           Versión="1.0"
           Diseñador="Roberto Pérez Varas"
           Programador="Roberto Pérez Varas"
           Ambiente="DEIMOS_ECU">
  <Retorno>NA</Retorno>
   <Descripción> Encabezado de VE_PARAMETROS_COMERCIALES_PG</Descripción>>
    <Parámetros>
    </Parámetros>
 </Elemento>
</Documentación>
*/
  CV_MODULO_GA        CONSTANT VARCHAR2(2)  := 'GA';
  CN_LARGODESC        CONSTANT NUMBER := 2000;
  CV_cod_producto     CONSTANT VARCHAR2(1):='1';
  CN_LARGOERRTEC      CONSTANT NUMBER := 4000;
  CV_error_no_clasif  CONSTANT VARCHAR2(30):='Error no clasificado';
  CV_codamiciclo      CONSTANT VARCHAR2(30):='COD_AMI_CICLO';
  CV_codmodulo        CONSTANT VARCHAR2(2) :='GA';
  CV_codcomodato      CONSTANT VARCHAR2(30):='COD_PROC_COMODATO';
  CV_codconcons       CONSTANT VARCHAR2(30):='COD_CONCONS';
  CV_codmodpricta     CONSTANT VARCHAR2(30):='COD_MODPRICTA';
  CV_codmodventa      CONSTANT VARCHAR2(30):='COD_PROC_MODVENTA';
  CV_codcargocuenta   CONSTANT VARCHAR2(30):='COD_PROC_CARGOACUENTA';
  CV_parcausavta      CONSTANT VARCHAR2(30):='COD_CAUSA_VENTA';
  CV_TIPO_PREPAGO     CONSTANT VARCHAR2(1):='3';
  CV_parametrov       CONSTANT VARCHAR2(30):='V';
  TYPE refcursor       IS REF CURSOR;
  CN_COD_TIPLANPREP   CONSTANT NUMBER(1) :=1;


  PROCEDURE VE_planservicio_PR(EV_plantarif       IN ta_plantarif.cod_plantarif%TYPE,
                                 EV_codtecnologia   IN al_tecnologia.cod_tecnologia%TYPE,
                               SC_cursordatos      OUT NOCOPY REFCURSOR,
                               SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                               SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
  );

  PROCEDURE VE_campanavigente_PR(SC_cursordatos        OUT NOCOPY REFCURSOR,
                                 SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
  );

  PROCEDURE VE_planindemnizacion_PR(SC_cursordatos     OUT NOCOPY REFCURSOR,
                                    SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
  );

    PROCEDURE VE_causaldescuento_PR (EN_codUso       IN  AL_USOS.COD_USO%TYPE,
                                     SC_cursordatos  OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

  PROCEDURE VE_creditomorosidad_PR(EN_codcliente    IN  ge_clientes.cod_cliente%TYPE,
                                   SC_cursordatos    OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
  );

  PROCEDURE VE_grupocobroservicio_PR (EN_codproducto    IN  NUMBER,
                                        SV_CodGrupo     OUT ga_grpserv.cod_grupo%TYPE,
                                        SV_DesGrupo     OUT ga_grpserv.des_grupo%TYPE,
                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

  PROCEDURE VE_creditoconsumo_PR(EN_codcliente      IN  ge_clientes.COD_CLIENTE%TYPE,
                                 EN_codproducto   IN  NUMBER,
                                 SC_cursordatos      OUT NOCOPY REFCURSOR,
                                 SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
  );

  PROCEDURE VE_grupoafinidad_PR(EN_codcliente     IN  ge_clientes.COD_CLIENTE%TYPE,
                                SC_cursordatos     OUT NOCOPY REFCURSOR,
                                SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
  );

PROCEDURE VE_modalidadpago_PR (EV_codtipcontrato  IN  ga_tipcontrato.cod_tipcontrato%TYPE,
                                   EN_nromeses        IN  ga_percontrato.num_meses%TYPE,
                                   EN_codvendedor     IN  ve_vendedores.cod_vendedor%TYPE,
                                   EV_nomusuario      IN  ge_seg_usuario.nom_usuario%TYPE,
                                   EN_codproducto     IN  NUMBER,
                                   EV_codoperacion    IN  gad_modpago_catplan.cod_operacion%TYPE,
                                   EV_cod_programa    IN  ge_programas.cod_programa%TYPE,
                                   EV_Tipo_Cliente    IN  GE_CLIENTES.COD_TIPO%TYPE,
                                   SC_cursordatos     OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

  PROCEDURE VE_datosvendedor_PR(EN_codvendedor     IN  ve_vendedores.cod_vendedor%TYPE,
                                SV_nomvendedor     OUT NOCOPY ve_vendedores.nom_vendedor%TYPE,
                                SN_codcliente    OUT NOCOPY ve_vendedores.cod_cliente%TYPE,
                                  SN_codvende_raiz OUT NOCOPY ve_vendedores.cod_vende_raiz%TYPE,
                                SN_codvendealer     OUT NOCOPY ve_vendealer.cod_vendealer%TYPE,
                                SV_codregion     OUT NOCOPY ge_direcciones.cod_region%TYPE,
                                 SV_codprovincia  OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
                                SV_codciudad     OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
                                SV_codoficina    OUT NOCOPY ve_vendedores.cod_oficina%TYPE,
                                SV_codtipcomis   OUT NOCOPY ve_tipcomis.cod_tipcomis%TYPE,
                                SV_destipcomis   OUT NOCOPY ve_tipcomis.des_tipcomis%TYPE,
                                SN_indtipventa   OUT NOCOPY ve_vendedores.ind_tipventa%TYPE,
                                SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
  );

  PROCEDURE VE_tipocontrato_PR (EV_nomusuario    IN  ge_seg_usuario.nom_usuario%TYPE,
                                EN_codproducto   IN  NUMBER,
                                EV_indcontcel    IN  VARCHAR2,
                                EV_indcontseg    IN  VARCHAR2,
                                EV_cod_programa  IN  ge_programas.cod_programa%TYPE,
                                EN_num_version   IN  ge_programas.num_version%TYPE,
                                SC_cursordatos   OUT NOCOPY REFCURSOR,
                                SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
  );

  PROCEDURE VE_permisousuario_PR (EV_nom_usuario  IN  ge_seg_usuario.nom_usuario%TYPE,
                                  EV_nom_proceso  IN  gad_procesos_perfiles.cod_proceso%TYPE,
                                  EV_cod_programa IN  ge_programas.cod_programa%TYPE,
                                  EN_num_version  IN  ge_programas.num_version%TYPE,
                                  SN_codproceso   OUT NOCOPY ge_seg_perfiles.cod_proceso%TYPE,
                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
  );

  PROCEDURE VE_nromesescontrato_PR (EV_codtipcontrato  IN  ga_tipcontrato.cod_tipcontrato%TYPE,
                                    EN_codproducto     IN  NUMBER,
                                    SC_cursordatos     OUT NOCOPY REFCURSOR,
                                    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
  );

  PROCEDURE VE_nrocuotas_PR (EN_codmodventa     IN  ge_modventa.cod_modventa%TYPE,
                               EN_codvendedor        IN  ve_vendedores.cod_vendedor%TYPE,
                             EV_nomusuario      IN  ge_seg_usuario.nom_usuario%TYPE,
                             EN_codproducto     IN  NUMBER,
                             SC_cursordatos     OUT NOCOPY REFCURSOR,
                             SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                             SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                             SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
  );

  PROCEDURE VE_tipodocumento_PR(EN_cod_cliente     IN  ge_clientes.cod_cliente%TYPE,
                                EV_ind_agente    IN  ge_clientes.ind_agente%TYPE,
                                EV_ind_situacion IN  ge_clientes.ind_situacion%TYPE,
                                EN_cod_producto  IN  NUMBER,
                                EV_cod_amiciclo  IN  ged_parametros.nom_parametro%TYPE,
                                EV_cod_modulo    IN  VARCHAR2,
                                SC_cursordatos     OUT NOCOPY REFCURSOR,
                                SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
  );

 PROCEDURE VE_contratocliente_PR(EN_codcliente     IN  ge_clientes.cod_cliente%TYPE,
                                 EV_codtipcontrato  IN  ga_tipcontrato.cod_tipcontrato%TYPE,
                                 SC_cursordatos   OUT NOCOPY REFCURSOR,
                                 SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
  );


  PROCEDURE VE_obtienedatoscelda_PR (EV_codcelda        IN ge_celdas.cod_celda%TYPE,
                                     SV_codsubalm       OUT NOCOPY ge_celdas.cod_subalm%TYPE,
                                     SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
  );

  PROCEDURE VE_listadoceldas_PR(EV_codregion       IN  ge_regiones.cod_region%TYPE,
                                EV_codprovincia    IN  ge_provincias.cod_provincia%TYPE,
                                EV_codciudad       IN  ge_ciudades.cod_provincia%TYPE,
                                SC_cursordatos     OUT NOCOPY REFCURSOR,
                                SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
  );

    PROCEDURE VE_listadocentrales_PR(EV_codsubalm       IN  ta_subcentral.cod_subalm%TYPE,
                                     EN_codproducto     IN  NUMBER,
                                     EV_CodPrestacion   IN GE_PRESTACIONES_TD.COD_PRESTACION%TYPE,
                                     SC_cursordatos     OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

  PROCEDURE VE_plan_comercial_cliente_PR(EN_cod_cliente   IN  ga_cliente_pcom.cod_cliente%TYPE,
                                         SN_cod_plancom   OUT NOCOPY ga_cliente_pcom.cod_plancom%TYPE,
                                         SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
  );



  FUNCTION VE_validausuariovendedor_FN (EN_codvendedor    IN  ve_vendedores.cod_vendedor%TYPE,
                                                SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento


  ) RETURN BOOLEAN;

  FUNCTION VE_validapermisousuario_FN (EV_nomusuario   IN  ge_seg_usuario.nom_usuario%TYPE,
                                       EV_cod_proceso  IN  gad_procesos_perfiles.cod_proceso%TYPE,
                                       SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
  ) RETURN  BOOLEAN;

  FUNCTION VE_validapermisovendedor_FN (EN_codvendedor  IN  ve_vendedores.cod_vendedor%TYPE,
                                         EV_cod_proceso  IN  gad_procesos_perfiles.cod_proceso%TYPE,
                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
  ) RETURN  BOOLEAN;

  PROCEDURE VE_consulta_datos_usuario_PR (EV_nom_usuario     IN  VARCHAR2,
                                             SV_codigo_oficina  OUT NOCOPY ge_seg_usuario.cod_oficina%TYPE,
                                                 SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);




  PROCEDURE VE_CampanaVigenteDefault_PR(EV_CodPlantarif IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                       EV_TipEntidad   IN VARCHAR2,
                                       EV_IndDefault   IN VARCHAR2,
                                       EV_FormatoFecha IN VARCHAR2,
                                       EV_CodCampana   OUT BP_CAMPANAS_TD.COD_CAMPANA%TYPE,
                                       SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

  PROCEDURE VE_grupocobroservicio_PR (EN_codproducto  IN  NUMBER,
                                        SC_cursordatos  OUT NOCOPY REFCURSOR,
                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);


PROCEDURE VE_Obtiene_Bodegas_PR (EN_COD_VENDEDOR IN  VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                         SC_cursordatos   OUT NOCOPY REFCURSOR,
                                         SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_Obtiene_Articulos_PR (EV_COD_TECNOLOGIA IN  AL_TECNOLOGIA.COD_TECNOLOGIA%TYPE,
                                   EV_TIP_TERMINAL   IN  AL_ARTICULOS.TIP_TERMINAL%TYPE,
                                   EV_IND_EQUIPO     IN  VARCHAR2,--S: Simcard E:Equipo
                                   EV_COD_USO        IN  AL_USOS.COD_USO%TYPE,
                                   EV_COD_BODEGA     IN  AL_BODEGAS.COD_BODEGA%TYPE,--P-CSR-11002 JLGN 27-10-2011
                                   SC_cursordatos    OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_getListLimiteConsumo_PR(EV_codPlanTarif  IN  tol_limite_plan_td.cod_plantarif%TYPE,
                                         EV_formatoFecha1 IN  VARCHAR2,
                                         EV_formatoFecha2 IN  VARCHAR2,
                                         EN_COD_CLIENTE   IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                         SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                         SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_obtiene_indSeguroMod_PR
                                  (EN_COD_MODVENTA   IN  GE_MODVENTA.COD_MODVENTA%TYPE,
                                   SN_IND_MODVENTA   OUT NOCOPY GE_MODVENTA.IND_SEGURO%TYPE,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_Obtiene_Seguros_PR(SC_cursordatos    OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_Obtiene_Usos_PR      (EV_TIP_RED        IN  TA_PLANTARIF.TIP_RED%TYPE,--Movil o Fija
                                   EV_COD_TIPO       IN  VARCHAR2, --Codigo de tipo de cliente
                                   SC_cursordatos    OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_Obtiene_GruposPrest_PR(SC_cursordatos    OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
 PROCEDURE VE_Obtiene_TipoPrest_PR(EV_GRUPO_PREST    IN  GED_CODIGOS.COD_VALOR%TYPE,
                                   EV_TIPO_CLIENTE   IN  GED_CODIGOS.COD_VALOR%TYPE,
                                   SC_cursordatos    OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_Obtiene_DatosCentral_PR(EN_COD_CENTRAL  IN  ICG_CENTRAL.COD_CENTRAL%TYPE,
                                     SC_cursordatos  OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_Busca_Serie_PR(        EN_NUM_TELEFONO   IN  AL_SERIES.NUM_TELEFONO%TYPE,
                                     EN_NUM_SERIE      IN  AL_SERIES.NUM_SERIE%TYPE,
                                     EN_COD_CANAL      IN  GA_MODVENT_APLIC.COD_CANAL%TYPE,
                                     EN_COD_MODVENTA   IN  GE_MODVENTA.COD_MODVENTA%TYPE,
                                     EN_COD_VENDEDOR   IN  VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                     EV_IND_EQUIPO     IN  VARCHAR2,--S: Simcard E:Equipo
                                     EV_COD_TECNOLOGIA IN  AL_TECNOLOGIA.COD_TECNOLOGIA%TYPE,
                                     EV_TIP_TERMINAL   IN  AL_ARTICULOS.TIP_TERMINAL%TYPE,
                                     EV_COD_USO        IN  AL_USOS.COD_USO%TYPE,
                                     EN_COD_CENTRAL  IN  ICG_CENTRAL.COD_CENTRAL%TYPE,
                                     EV_COD_HLR      IN  ICG_CENTRAL.COD_HLR%TYPE,
                                     SC_cursordatos    OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

  PROCEDURE VE_getList_Series_PR(    EN_COD_BODEGA   IN  AL_SERIES.COD_BODEGA%TYPE,
                                     EN_COD_ARTICULO IN  AL_SERIES.COD_ARTICULO%TYPE,
                                     EV_COD_HLR      IN  ICG_CENTRAL.COD_HLR%TYPE,
                                     EN_COD_MODVENTA IN  GE_MODVENTA.COD_MODVENTA%TYPE,
                                     EN_COD_CANAL    IN  GA_MODVENT_APLIC.COD_CANAL%TYPE,
                                     EN_COD_VENDEDOR IN  VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                     EN_COD_CENTRAL  IN  ICG_CENTRAL.COD_CENTRAL%TYPE,
                                     EN_COD_USO      IN  AL_USOS.COD_USO%TYPE,
                                     EN_TIP_ARTICULO IN  VARCHAR2, --S Simcard A:Articulo
                                     SC_cursordatos  OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
 PROCEDURE VE_ObtieneDatos_Seguro_PR(
                                   EV_COD_SEGURO     IN  GA_TIPOSEGURO_TD.COD_SEGURO%TYPE,
                                   EV_PERIODO        IN  GA_PERCONTRATO.NUM_MESES%TYPE,
                                   SN_COD_CONCEPTO   OUT NOCOPY FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                                   SN_FECHA_FIN      OUT NOCOPY DATE,
                                   SN_COD_CARGO      OUT NOCOPY GA_TIPOSEGURO_TD.COD_CARGO%TYPE,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_GetList_TipoTerminal_PR(
                                   EV_COD_TECNOLOGIA IN  AL_TECNOLOGIA.COD_TECNOLOGIA%TYPE,
                                   SC_cursordatos  OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_getList_Monedas_PR      (SC_cursordatos  OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_obtiene_serieEquipoKit_PR (
                                     EV_NumKit           IN AL_COMPONENTE_KIT.NUM_KIT%TYPE,
                                     EV_CodTecnologia    IN AL_TECNOLOGIA.COD_TECNOLOGIA%TYPE,
                                     EN_COD_ARTICULO_S   OUT NOCOPY AL_ARTICULOS.COD_ARTICULO%TYPE,
                                     EV_NUM_SERIE_S      OUT NOCOPY AL_SERIES.NUM_SERIE%TYPE,
                                     EV_COD_BODEGA_S     OUT NOCOPY AL_BODEGAS.COD_BODEGA%TYPE,
                                     EV_TIP_STOCK_S      OUT NOCOPY AL_TIPOS_STOCK.TIP_STOCK%TYPE,
                                     EN_IND_TELEFONO_S   OUT NOCOPY AL_SERIES.IND_TELEFONO%TYPE,
                                     EN_NUM_TELEFONO_S   OUT NOCOPY AL_SERIES.NUM_TELEFONO%TYPE,
                                     EV_NUM_SERIE_MEC_S  OUT NOCOPY AL_SERIES.NUM_SERIEMEC%TYPE,
                                     EV_TIP_TERMINAL_S   OUT NOCOPY AL_TIPOS_TERMINALES.TIP_TERMINAL%TYPE,
                                     EN_COD_ARTICULO_E   OUT NOCOPY AL_ARTICULOS.COD_ARTICULO%TYPE,
                                     EV_NUM_SERIE_E      OUT NOCOPY AL_SERIES.NUM_SERIE%TYPE,
                                     EV_COD_BODEGA_E     OUT NOCOPY AL_BODEGAS.COD_BODEGA%TYPE,
                                     EV_TIP_STOCK_E      OUT NOCOPY AL_TIPOS_STOCK.TIP_STOCK%TYPE,
                                     EN_IND_TELEFONO_E   OUT NOCOPY AL_SERIES.IND_TELEFONO%TYPE,
                                     EN_NUM_TELEFONO_E   OUT NOCOPY AL_SERIES.NUM_TELEFONO%TYPE,
                                     EV_NUM_SERIE_MEC_E  OUT NOCOPY AL_SERIES.NUM_SERIEMEC%TYPE,
                                     EV_TIP_TERMINAL_E   OUT NOCOPY AL_TIPOS_TERMINALES.TIP_TERMINAL%TYPE,
                                     SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
 PROCEDURE VE_Busca_Vendedor_PR (
                                     EV_codVendedor      IN  VE_VENDEDORES.COD_VENDEDOR%TYPE, --Puede ser Dealer o Vendedor interno
                                     EV_filtro           IN  VARCHAR2,-- D-Directo I-Indirecto
                                     SN_codOficina       OUT NOCOPY GE_OFICINAS.COD_OFICINA%TYPE,
                                     SN_codTipcomis      OUT NOCOPY VE_TIPCOMIS.COD_TIPCOMIS%TYPE,
                                     SN_codVendedor      OUT NOCOPY VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                     SN_codVendealer     OUT NOCOPY VE_VENDEALER.COD_VENDEALER%TYPE,
                                     SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
 PROCEDURE VE_getList_TipSol_PR (    SC_cursordatos  OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
     PROCEDURE VE_getList_EstFinSol_PR ( EV_EstadoInicio     IN  GA_VENTAS.IND_ESTVENTA%TYPE,
                                     SC_cursordatos      OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
    PROCEDURE VE_reglas_valid_vig_ss_pr( EN_cod_central      IN  icg_central.cod_central%TYPE,
                                     EV_tip_terminal     IN  icg_serviciotercen.tip_terminal%TYPE,
                                     EV_cod_tecnologia   IN  icg_central.cod_tecnologia%TYPE,
                                     so_cursor           OUT NOCOPY     refcursor,
                                     sn_cod_retorno      OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                     sv_mens_retorno     OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                     sn_num_evento       OUT NOCOPY     ge_errores_pg.evento);

    PROCEDURE VE_list_campVigXCodTiplan_PR (
        EV_cod_tiplan         IN            bp_campanas_td.COD_TIPLAN%TYPE,
        SC_cursordatos           OUT NOCOPY     REFCURSOR,
        SN_cod_retorno         OUT NOCOPY     ge_errores_pg.CodError,
        SV_mens_retorno        OUT NOCOPY     ge_errores_pg.MsgError,
        SN_num_evento          OUT NOCOPY     ge_errores_pg.Evento
    );
--Inicio P-CSR-11002 JLGN 27-04-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_cambio_uso_series_pr (
      ev_num_serie         IN              al_series.num_serie%TYPE,
      ev_nom_usuario       IN              VARCHAR2,
      en_cod_uso           IN              al_movimientos.cod_uso%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   );
   --Inicio P-CSR-11002 JLGN 10-05-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_datos_direccion_pr (ev_cod_provincia  IN              ge_provincias.cod_provincia%TYPE,
                                    ev_cod_canton     IN              ge_regiones.cod_region%TYPE,
                                    ev_cod_distrito   IN              ge_ciudades.cod_ciudad%TYPE,
                                    sv_des_provincia  OUT NOCOPY      ge_provincias.des_provincia%TYPE,
                                    sv_des_canton     OUT NOCOPY      ge_regiones.des_region%TYPE,
                                    sv_des_distrito   OUT NOCOPY      ge_ciudades.des_ciudad%TYPE,
                                    sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                    sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                    sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);
--Inicio P-CSR-11002 JLGN 16-05-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_valida_codigos_pr (ev_cod_valor     IN          ged_codigos.COD_VALOR%TYPE,
                                  sn_existe        OUT NOCOPY  NUMBER,
                                  sn_cod_retorno   OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                  sv_mens_retorno  OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                  sn_num_evento    OUT NOCOPY  ge_errores_pg.evento);
--Inicio P-CSR-11002 JLGN 15-06-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_obtiene_comuna_pr (ev_cod_provincia  IN ge_provincias.cod_provincia%TYPE,
                                  ev_cod_canton     IN ge_regiones.cod_region%TYPE,
                                  ev_cod_distrito   IN ge_ciudades.cod_ciudad%TYPE,
                                  sv_cod_comuna     OUT NOCOPY  ge_ciucom.COD_COMUNA%TYPE,
                                  sn_cod_retorno    OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                  sv_mens_retorno   OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                  sn_num_evento     OUT NOCOPY  ge_errores_pg.evento);
--Inicio P-CSR-11002 JLGN 26-05-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_datos_venta_pr (en_num_venta    IN ga_ventas.NUM_VENTA%TYPE,
                               sv_fec_venta    OUT NOCOPY VARCHAR2,
                               sv_cod_oficina  OUT NOCOPY ga_ventas.COD_OFICINA%TYPE,
                               sv_des_oficina  OUT NOCOPY ge_oficinas.DES_OFICINA%TYPE,
                               sv_bancocc      OUT NOCOPY ge_bancos.DES_BANCO%TYPE,
                               sv_cuentacorr   OUT NOCOPY ga_ventas.NUM_CTACORR%TYPE,
                               sv_bancotarjeta OUT NOCOPY ge_bancos.DES_BANCO%TYPE,
                               sv_tip_tarjeta  OUT NOCOPY ge_tiptarjetas.DES_TIPTARJETA%TYPE,
                               sv_num_tarjeta  OUT NOCOPY ga_ventas.NUM_TARJETA%TYPE,
                               sv_moneda       OUT NOCOPY ge_monedas.DES_MONEDA%TYPE,
                               sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
--Inicio P-CSR-11002 JLGN 27-05-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_datos_linea_pr (en_num_abonado  IN ga_abocel.NUM_ABONADO%TYPE,
                               sv_num_serie    OUT NOCOPY ga_equipaboser.NUM_SERIE%TYPE,
                               sv_num_imei     OUT NOCOPY ga_equipaboser.NUM_IMEI%TYPE,
                               sv_plan_tarif   OUT NOCOPY ta_plantarif.DES_PLANTARIF%TYPE,
                               --sv_cargo_pt     OUT NOCOPY ta_cargosbasico.IMP_CARGOBASICO%TYPE, P-CSR-11002 30-09-2011 JLGN
                               sv_cargo_pt     OUT NOCOPY VARCHAR2,
                               sv_des_terminal OUT NOCOPY al_articulos.DES_ARTICULO%TYPE,
                               sv_modventa     OUT NOCOPY ga_ventas.COD_MODVENTA%TYPE,
                               sn_num_meses    OUT NOCOPY ga_tipcontrato.MESES_MINIMO%TYPE,
                               sv_procequi     OUT NOCOPY ga_equipaboser.IND_PROCEQUI%TYPE,
                               sv_codPT        OUT NOCOPY ta_plantarif.COD_PLANTARIF%TYPE,
                               sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
--Inicio P-CSR-11002 JLGN 06-06-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_celular_cliente_pr (en_num_venta    IN ga_ventas.NUM_VENTA%TYPE,
                                   SC_cursordatos  OUT NOCOPY REFCURSOR,
                                   sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
--Inicio P-CSR-11002 JLGN 06-06-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_pa_por_linea_pr (en_num_abonado  IN ga_abocel.NUM_ABONADO%TYPE,
                  ev_codPT        IN ta_plantarif.COD_PLANTARIF%TYPE,
                                SC_cursordatos  OUT NOCOPY REFCURSOR,
                                sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
--Inicio P-CSR-11002 JLGN 10-06-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_ss_por_linea_pr (en_num_abonado  IN ga_abocel.NUM_ABONADO%TYPE,
                                ev_codPT        IN ta_plantarif.COD_PLANTARIF%TYPE,
                                SC_cursordatos  OUT NOCOPY REFCURSOR,
                                sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
--Inicio P-CSR-11002 JLGN 01-07-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_sum_cargos_pt_pr(ev_numident     IN ge_clientes.NUM_IDENT%TYPE,
                                ev_tipident     IN ge_clientes.cod_tipident%TYPE,
                                sn_sumacargos   OUT NOCOPY NUMBER,
                                sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
--Inicio P-CSR-11002 JLGN 04-07-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_cargos_pt_pr(ev_plantarif    IN ta_plantarif.COD_PLANTARIF%TYPE,
                            sn_cargo        OUT NOCOPY ta_cargosbasico.IMP_CARGOBASICO%TYPE,
                            sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                            sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                            sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
--Inicio P-CSR-11002 JLGN 26-07-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_precio_terminal_pr(en_num_abonado     IN ga_abocel.NUM_ABONADO%TYPE,
                                  sn_precio_terminal OUT NOCOPY VARCHAR2,
                                  sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  sn_num_evento      OUT NOCOPY ge_errores_pg.evento);
--Inicio P-CSR-11002 JLGN 04-08-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_mensaje_error_pr(ev_modulo       IN  ged_codigos.COD_MODULO%TYPE,
                                ev_tabla        IN  ged_codigos.NOM_TABLA%TYPE,
                                ev_columna      IN  ged_codigos.NOM_COLUMNA%TYPE,
                                ev_valor        IN  VARCHAR2,
                                sv_mensaje      OUT NOCOPY VARCHAR2,
                                sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
--Inicio P-CSR-11002 JLGN 30-09-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_datos_linea_fija_pr (en_num_abonado  IN ga_abocel.NUM_ABONADO%TYPE,
                                    sv_plan_tarif   OUT NOCOPY ta_plantarif.DES_PLANTARIF%TYPE,
                                    sv_cargo_pt     OUT NOCOPY VARCHAR2,
                                    sv_modventa     OUT NOCOPY ga_ventas.COD_MODVENTA%TYPE,
                                    sn_num_meses    OUT NOCOPY ga_tipcontrato.MESES_MINIMO%TYPE,
                                    sv_codPT        OUT NOCOPY ta_plantarif.COD_PLANTARIF%TYPE,
                                    sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
--Inicio P-CSR-11002 JLGN 20-10-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_limite_consumo_linea_pr(en_num_abonado  IN ga_abocel.num_abonado%TYPE,
                                       sn_mto_limite   OUT NOCOPY VARCHAR2,
                                       sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                       sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                       sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
--Inicio P-CSR-11002 JLGN 29-10-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_nombre_factura_pr(en_num_venta    IN ga_ventas.num_venta%TYPE,
                                 sv_nom_fact     OUT NOCOPY fa_interimpresion_td.DIR_WEB%TYPE,
                                 sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
--Inicio Incidencia 179734 JLGN 01-01-2012
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_valida_error_pr(ev_modulo       IN  ged_codigos.COD_MODULO%TYPE,
                               ev_tabla        IN  ged_codigos.NOM_TABLA%TYPE,
                               ev_columna      IN  ged_codigos.NOM_COLUMNA%TYPE,
                               ev_valor        IN  VARCHAR2,
                               sv_contador     OUT NOCOPY NUMBER,
                               sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
--Inicio Incidencia 179734 JLGN 04-01-2012
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_valida_cliente_dda_pr(en_cod_cliente  IN ge_clientes.cod_cliente%TYPE,
                                     sn_resultado    OUT NOCOPY NUMBER,
                                     sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                     sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                     sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
--Inicio Incidencia 179734 JLGN 05-01-2012
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_lineas_activas_dda_pr(en_tip_ident    IN ge_clientes.cod_tipident%TYPE,
                                     en_num_ident    IN ge_clientes.num_ident%TYPE,
                                     sn_resultado    OUT NOCOPY NUMBER,
                                     sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                     sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                     sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END VE_parametros_comerciales_PG;
/
