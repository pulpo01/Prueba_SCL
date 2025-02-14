CREATE OR REPLACE PACKAGE Ve_Alta_Cliente_Pg IS

    -----------------------------
    -- DECLARACION DE CONSTANTES
    -----------------------------
    -- RECOMPILACION

    CV_PRODUCTO      CONSTANT VARCHAR2(1)  := '1';
    CV_MODULO_GA     CONSTANT VARCHAR2(2)  := 'GA';
    CV_MODULO_GE     CONSTANT VARCHAR2(2)  := 'GE';
    CV_ERRORNOCLASIF CONSTANT VARCHAR2(30) := 'Error no clasificado';
    CV_SUBCATIMPOS   CONSTANT VARCHAR2(8)  := 'SUCATIMP';
    CV_FORMATOFECHA  CONSTANT VARCHAR2(10) := 'DD/MM/YYYY';
    CV_FORMATOFECMAX CONSTANT VARCHAR2(21) := 'DD-MM-YYYY HH24:MI:SS';

    CN_LARGOERRTEC   CONSTANT NUMBER := 4000;
    CN_LARGODESC     CONSTANT NUMBER := 2000;

    -- para busqueda de los idiomas en SCL
    CV_TAB_GECLIENTE  CONSTANT VARCHAR2(11) := 'GE_CLIENTES';
    CV_COL_GECLIENTE  CONSTANT VARCHAR2(10) := 'COD_IDIOMA';

    -- para busqueda de las categorias tributarias
    CV_TAB_GECATRIBDOCUM CONSTANT VARCHAR2(14) := 'GE_CATRIBDOCUM';
    CV_COL_GECATRIBDOCUM CONSTANT VARCHAR2(12) := 'COD_TIPDOCUM';

    -- nombre de parametros
    CV_NOMPAR_FORMATOSEL2 CONSTANT VARCHAR2(12) := 'FORMATO_SEL2';
    CV_NOMPAR_FORMATOSEL7 CONSTANT VARCHAR2(12) := 'FORMATO_SEL7';
    CV_NOMPAR_FECHAMAXIMA CONSTANT VARCHAR2(12) := 'FECHA_MAXIMA';

    ------------------------
    -- DECLARACION DE TIPOS
    ------------------------
    TYPE refcursor IS REF CURSOR;

    ----------------------------
    -- DECLARACION DE VARIABLES
    ----------------------------

    ----------------------------
    -- DECLARACION DE FUNCIONES
    ----------------------------

    ---------------------------------
    -- DECLARACION DE PROCEDIMIENTOS
    ---------------------------------

    PROCEDURE VE_getFecha_PR(EV_fecha          VARCHAR2,
                             EV_formatofecha   VARCHAR2,
                             EV_formatohora    VARCHAR2,
                             SD_fecha          OUT NOCOPY DATE,
                              SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                               SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                               SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

--     PROCEDURE VE_getValorParametro_PR(EV_nomParametro IN ged_parametros.nom_parametro%TYPE,
--                                         EV_codModulo      IN ged_parametros.cod_modulo%TYPE,
--                                       EV_codProducto  IN ged_parametros.cod_producto%TYPE,
--                                       SV_valParametro OUT NOCOPY ged_parametros.val_parametro%TYPE,
--                                        SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
--                                          SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
--                                          SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getPlanComercial_PR(EV_codCalifCte  IN  ve_plan_calcli.cod_calclien%TYPE,
                                     SN_codPlanCom   OUT NOCOPY ve_cabplancom.cod_plancom%TYPE,
                                     SV_desPlanCom   OUT NOCOPY ve_cabplancom.des_plancom%TYPE,
                                      SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                        SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getCodigoNuevoCliente_PR(SN_codCliente OUT NOCOPY ge_clientes.cod_cliente%TYPE,
                                          SN_codRetorno OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento  OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getProspectoCliente_PR(EV_codTipIdent   IN  ve_prospectos.cod_tipident%TYPE,
                                        EV_numIdent      IN  ve_prospectos.num_ident%TYPE,
                                         SV_nomNombre     OUT NOCOPY ve_prospectos.nom_nombre%TYPE,
                                          SV_nomApellido1  OUT NOCOPY ve_prospectos.nom_apellido1%TYPE,
                                          SV_nomApellido2  OUT NOCOPY ve_prospectos.nom_apellido2%TYPE,
                                          SV_numTelef1     OUT NOCOPY ve_prospectos.num_telef1%TYPE,
                                          SV_numTelef2     OUT NOCOPY ve_prospectos.num_telef2%TYPE,
                                          SV_numFax        OUT NOCOPY ve_prospectos.num_fax%TYPE,
                                          SV_nomReprlegal  OUT NOCOPY ve_prospectos.nom_reprlegal%TYPE,
                                          SV_codTipidrepr  OUT NOCOPY ve_prospectos.cod_tipidrepr%TYPE,
                                             SV_numIdrepr     OUT NOCOPY ve_prospectos.num_idrepr%TYPE,
                                          SN_codRubro      OUT NOCOPY ve_prospectos.cod_rubro%TYPE,
                                          SV_codBanco      OUT NOCOPY ve_prospectos.cod_banco%TYPE,
                                          SV_numCuenta     OUT NOCOPY ve_prospectos.num_cuentA%TYPE,
                                          SV_codTiptarjeta OUT NOCOPY ve_prospectos.cod_tiptarjeta%TYPE,
                                          SV_numTarjeta    OUT NOCOPY ve_prospectos.num_tarjeta%TYPE,
                                         SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                            SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getProspectoDireccion_PR(EN_codProspecto IN  ve_prodireccion.cod_prospecto%TYPE,
                                            EV_tipDireccion IN  ve_prodireccion.cod_tipdireccion%TYPE,
                                          SN_codDireccion OUT NOCOPY ve_prodireccion.cod_direccion%TYPE,
                                           SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getClienteVendedor_PR(EV_codTipIdent   IN  ge_clientes.cod_tipident%TYPE,
                                       EV_numIdent      IN  ge_clientes.num_ident%TYPE,
                                        SN_codCategoria  OUT NOCOPY ge_clientes.cod_categoria%TYPE,
                                         SN_codSector     OUT NOCOPY ge_clientes.cod_sector%TYPE,
                                         SN_codSupervisor OUT NOCOPY ge_clientes.cod_supervisor%TYPE,
                                         SN_codVendedor   OUT NOCOPY ve_vendcliente.cod_vendedor%TYPE,
                                        SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getCodigoNuevaEmpresa_PR(SN_codempresa OUT ga_empresa.cod_empresa%TYPE,
                                          SN_codRetorno OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento  OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_esCicloFreedom_PR(EV_codCiclo     IN  VARCHAR2,
                                      SB_resultado    OUT NOCOPY BOOLEAN,
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_esCicloFreedom_PR(EV_codCiclo     IN  VARCHAR2,
                                     SN_resultado    OUT NOCOPY PLS_INTEGER,
                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE Ve_getOperadoraCliente_pr(SV_codOperadora OUT NOCOPY VARCHAR2,
                                        SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
    --------------------------------------------------------------------------------------------
    --* CURSORES - LISTAS
    --------------------------------------------------------------------------------------------

    PROCEDURE VE_getListGedCodigos_PR(EV_modulo       IN VARCHAR2,
                                      EV_tabla        IN VARCHAR2,
                                      EV_columna      IN VARCHAR2,
                                      SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                      SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                         SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getListTiposIdentif_PR(SC_cursorDatos OUT NOCOPY REFCURSOR,
                                         SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getListCategorias_PR(SC_cursorDatos OUT NOCOPY REFCURSOR,
                                      SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                         SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_numEvento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getListCategImpositivas_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getListTipComisionistas_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getListModalidadPago_PR(EN_indManual    IN ge_sispago.ind_manual%TYPE,
                                         SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                         SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                            SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getListBancosPAC_PR(EN_indPAC       IN ge_bancos.ind_pac%TYPE,
                                     SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                     SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                        SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getListSucursalesBanco_PR(EV_codBanco     IN ge_sucursales.cod_banco%TYPE,
                                           SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                           SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                              SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getListTarjetas_PR(SC_cursorDatos     OUT NOCOPY REFCURSOR,
                                       SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getListOficinasSCL_PR(EV_nom_usuario  IN ge_seg_usuario.NOM_USUARIO%TYPE,
                                       SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                       SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getListPlanComCalCte_PR(EV_codCalifCte  IN ve_plan_calcli.cod_calclien%TYPE,
                                         SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                         SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                            SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getListSubCategImpos_PR(EV_codCategImp  IN  al_tipo_codigo.tip_codigo%TYPE,
                                         SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                          SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                            SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getListActividades_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                       SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getListPaises_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    --------------------------------------------------------------------------------------------
    --* INSERTS y UPDATES
    --------------------------------------------------------------------------------------------

    PROCEDURE VE_insSecDespachoCliente_PR(EN_codcliente     IN ga_secdespclie.cod_cliente%TYPE,
                                          EV_usuario        IN VARCHAR2,
                                           SN_codRetorno     OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno     OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento      OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_insCategoriaTributaria_PR(EN_codcliente   IN  ga_catributclie.cod_cliente%TYPE,
                                             EV_codcattrib   IN  ga_catributclie.cod_catribut%TYPE,
                                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                              SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_insEmpresa_PR(EV_desempresa   IN  ga_empresa.des_empresa%TYPE,
                                 EN_codproducto  IN  ga_empresa.cod_producto%TYPE,
                                 EV_codplantarif IN  ga_empresa.cod_plantarif%TYPE,
                               EN_codciclo     IN  ga_empresa.cod_ciclo%TYPE,
                                 EN_codcliente   IN  ga_empresa.cod_cliente%TYPE,
                               EN_numabonados  IN  ga_empresa.num_abonados%TYPE,
                               EV_usuario      IN  VARCHAR2,
                               EV_razon_social IN  GA_EMPRESA.RAZON_SOCIAL%TYPE,
                               EV_num_patente  IN  GA_EMPRESA.NUM_PATENTE%TYPE,
                               SN_codempresa   OUT NOCOPY ga_empresa.COD_EMPRESA%TYPE,
                               SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                  SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                               SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_insCliente_PR(EV_cod_cliente        IN VARCHAR2,
                               EV_nom_cliente          IN VARCHAR2,
                               EV_cod_tipident          IN VARCHAR2,
                               EV_num_ident          IN VARCHAR2,
                               EV_cod_calclien          IN VARCHAR2,
                               EV_ind_situacion      IN VARCHAR2,
                               EV_ind_factur          IN VARCHAR2,
                               EV_ind_traspaso          IN VARCHAR2,
                               EV_ind_agente          IN VARCHAR2,
                               EV_num_fax              IN VARCHAR2,
                               EV_ind_mandato          IN VARCHAR2,
                               EV_nom_usuarora          IN VARCHAR2,
                               EV_ind_alta              IN VARCHAR2,
                               EV_cod_cuenta          IN VARCHAR2,
                               EV_ind_acepvent          IN VARCHAR2,
                               EV_cod_abc              IN VARCHAR2,
                               EV_cod_123              IN VARCHAR2,
                               EV_cod_actividad      IN VARCHAR2,
                               EV_cod_pais              IN VARCHAR2,
                               EV_tef_cliente1          IN VARCHAR2,
                               EV_num_abocel          IN VARCHAR2,
                               EV_tef_cliente2          IN VARCHAR2,
                               EV_num_abobeep          IN VARCHAR2,
                               EV_ind_debito          IN VARCHAR2,
                               EV_num_abotrunk          IN VARCHAR2,
                               EV_cod_prospecto      IN VARCHAR2,
                               EV_num_abotrek          IN VARCHAR2,
                               EV_cod_sispago          IN VARCHAR2,
                               EV_nom_apeclien1      IN VARCHAR2,
                               EV_nom_email          IN VARCHAR2,
                               EV_num_aborent          IN VARCHAR2,
                               EV_nom_apeclien2      IN VARCHAR2,
                               EV_num_aboroaming      IN VARCHAR2,
                               EV_fec_acepvent          IN VARCHAR2,
                               EV_imp_stopdebit      IN VARCHAR2,
                               EV_cod_banco          IN VARCHAR2,
                               EV_cod_sucursal          IN VARCHAR2,
                               EV_ind_tipcuenta      IN VARCHAR2,
                               EV_cod_tiptarjeta      IN VARCHAR2,
                               EV_num_ctacorr          IN VARCHAR2,
                               EV_num_tarjeta          IN VARCHAR2,
                               EV_fec_vencitarj      IN VARCHAR2,
                               EV_cod_bancotarj      IN VARCHAR2,
                               EV_cod_tipidtrib      IN VARCHAR2,
                               EV_num_identtrib      IN VARCHAR2,
                               EV_cod_tipidentapor      IN VARCHAR2,
                               EV_num_identapor         IN VARCHAR2,
                               EV_nom_apoderado        IN VARCHAR2,
                               EV_cod_oficina           IN VARCHAR2,
                               EV_fec_baja              IN VARCHAR2,
                               EV_cod_cobrador          IN VARCHAR2,
                               EV_cod_pincli            IN VARCHAR2,
                               EV_cod_ciclo             IN VARCHAR2,
                               EV_num_celular           IN VARCHAR2,
                               EV_ind_tippersona        IN VARCHAR2,
                               EV_cod_ciclonue          IN VARCHAR2,
                               EV_cod_categoria         IN VARCHAR2,
                               EV_cod_sector            IN VARCHAR2,
                               EV_cod_supervisor        IN VARCHAR2,
                               EV_ind_estcivil          IN VARCHAR2,
                               EV_fec_nacimien          IN VARCHAR2,
                               EV_ind_sexo              IN VARCHAR2,
                               EV_num_int_grup_fam      IN VARCHAR2,
                               EV_cod_npi               IN VARCHAR2,
                               EV_cod_subcategoria      IN VARCHAR2,
                               EV_cod_uso               IN VARCHAR2,
                               EV_cod_idioma             IN VARCHAR2,
                               EV_cod_tipident2         IN VARCHAR2,
                               EV_num_ident2          IN VARCHAR2,
                               EV_nom_usuario_asesor IN VARCHAR2,
                               EV_cod_operadora      IN VARCHAR2,
                               EV_id_segmento          IN VARCHAR2,
                               EV_nom_conyuge        IN GE_CLIENTES.NOM_CONYUGE%TYPE,
                               EV_cod_operador       IN GE_CLIENTES.COD_OPERADOR%TYPE,
                               EV_mens_promo         IN GE_CLIENTES.MENS_PROMO%TYPE,
                               EN_cod_profesion      IN GE_CLIENTES.COD_ACTIVIDAD%TYPE,
                               EV_nom_empresa        IN GE_CLIENTES.NOM_EMPRESA%TYPE,
                               EV_tef_oficina        IN GE_CLIENTES.TEF_OFICINA%TYPE,
                               EN_cod_ocupacion      IN GE_CLIENTES.COD_OCUPACION%TYPE,
                               EN_imp_ingresos       IN GE_CLIENTES.IMP_INGRESOS%TYPE,
                               EV_nom_jefe           IN GE_CLIENTES.NOM_JEFE%TYPE,
                               EV_cant_antlabor      IN GE_CLIENTES.CANT_ANLABOR%TYPE,
                               EV_nom_refer1         IN GE_CLIENTES.NOM_REFER1%TYPE,
                               EV_tef_refer1         IN GE_CLIENTES.TEF_REFER1%TYPE,
                               EV_nom_refer2         IN GE_CLIENTES.NOM_REFER2%TYPE,
                               EV_tef_refer2         IN GE_CLIENTES.TEF_REFER2%TYPE,
                               EV_tip_cliente        IN GE_CLIENTES.COD_TIPO%TYPE,
                               EV_cod_color          IN GE_CLIENTES.COD_COLOR%TYPE,
                               EV_cod_crediticia     IN GE_CLIENTES.COD_CREDITICIA%TYPE,
                               EV_cod_segmento       IN GE_CLIENTES.COD_SEGMENTO%TYPE,
                               EV_cod_calificacion   IN GE_CLIENTES.COD_CALIFICACION%TYPE,
                               EV_nom_tit_tarjeta    IN GE_CLIENTES.NOM_TITULARTARJETA%TYPE,
                               EV_obs_pac            IN GE_CLIENTES.OBS_PAC%TYPE,
                               EN_FACTURA_ELECTR     IN GE_CLIENTES.IND_FACTURAELECTRONICA%TYPE,
                               SN_codRetorno            OUT NOCOPY ge_errores_pg.CodError,
                                  SV_menRetorno            OUT NOCOPY ge_errores_pg.MsgError,
                               SN_numEvento             OUT NOCOPY ge_errores_pg.Evento);

    -- Ini. MA 72269 3-11-2008
    PROCEDURE VE_insSegmentacion_PR(EV_cod_cliente        IN VARCHAR2,
                    EV_TipPlanDes     IN VARCHAR2,
                    SN_codRetorno     OUT NOCOPY ge_errores_pg.CodError,
                    SV_menRetorno     OUT NOCOPY ge_errores_pg.MsgError,
                    SN_numEvento      OUT NOCOPY ge_errores_pg.Evento);
    -- Fin MA 72269 3-11-2008

    PROCEDURE VE_insModCliente_PR(EV_cod_cliente       IN VARCHAR2,
                                  EV_cod_tipmodi        IN VARCHAR2,
                                    EV_fec_modifica        IN VARCHAR2,
                                    EV_nom_usuarora        IN VARCHAR2,
                                    EV_nom_cliente        IN VARCHAR2,
                                    EV_cod_tipident        IN VARCHAR2,
                                    EV_num_ident            IN VARCHAR2,
                                    EV_cod_calclien        IN VARCHAR2,
                                    EV_cod_plancom        IN VARCHAR2,
                                    EV_ind_factur        IN VARCHAR2,
                                    EV_ind_traspaso        IN VARCHAR2,
                                    EV_cod_actividad        IN VARCHAR2,
                                    EV_cod_pais            IN VARCHAR2,
                                    EV_tef_cliente1        IN VARCHAR2,
                                    EV_tef_cliente2        IN VARCHAR2,
                                    EV_num_fax            IN VARCHAR2,
                                    EV_ind_debito        IN VARCHAR2,
                                    EV_cod_sispago        IN VARCHAR2,
                                    EV_nom_apeclien1        IN VARCHAR2,
                                    EV_nom_apeclien2        IN VARCHAR2,
                                    EV_imp_stopdebit        IN VARCHAR2,
                                    EV_cod_banco            IN VARCHAR2,
                                    EV_cod_sucursal        IN VARCHAR2,
                                    EV_ind_tipcuenta        IN VARCHAR2,
                                    EV_cod_tiptarjeta    IN VARCHAR2,
                                    EV_num_ctacorr        IN VARCHAR2,
                                    EV_num_tarjeta        IN VARCHAR2,
                                    EV_fec_vencitarj        IN VARCHAR2,
                                    EV_cod_bancotarj        IN VARCHAR2,
                                    EV_cod_tipidtrib        IN VARCHAR2,
                                    EV_num_identtrib        IN VARCHAR2,
                                    EV_cod_tipidentapor  IN VARCHAR2,
                                    EV_num_identapor        IN VARCHAR2,
                                    EV_nom_apoderado        IN VARCHAR2,
                                    EV_cod_oficina        IN VARCHAR2,
                                    EV_cod_pincli        IN VARCHAR2,
                                    EV_nom_email            IN VARCHAR2,
                                    EV_cod_ciclo            IN VARCHAR2,
                                    EV_cod_categoria        IN VARCHAR2,
                                    EV_cod_sector        IN VARCHAR2,
                                    EV_cod_supervisor    IN VARCHAR2,
                                    EV_cod_npi            IN VARCHAR2,
                                    EV_cod_empresa        IN VARCHAR2,
                                    EV_tip_plantarif        IN VARCHAR2,
                                    EV_cod_plantarif        IN VARCHAR2,
                                    EV_cod_cargobasico   IN VARCHAR2,
                                    EV_num_os            IN VARCHAR2,
                                    EV_num_ciclos        IN VARCHAR2,
                                    EV_num_minutos        IN VARCHAR2,
                                    EV_cod_idioma        IN VARCHAR2,
                                    EV_cod_tipident2        IN VARCHAR2,
                                    EV_num_ident2        IN VARCHAR2,
                                    EV_cod_plaza            IN VARCHAR2,
                                    EV_des_refdoc        IN VARCHAR2,
                                    EV_cod_limconsumo    IN VARCHAR2,
                                    EV_cod_subcategoria  IN VARCHAR2,
                                  SN_codRetorno          OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno          OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_numEvento           OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_insPlanComCliente_PR(EV_cod_cliente  IN  VARCHAR2,
                                      EV_cod_plancom  IN  VARCHAR2,
                                        EV_nom_usuarora IN  VARCHAR2,
                                      SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                         SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_insRespCliente_PR(EV_cod_cliente     IN  VARCHAR2,
                                   EV_num_orden       IN  VARCHAR2,
                                     EV_cod_tipident    IN  VARCHAR2,
                                     EV_num_ident       IN  VARCHAR2,
                                     EV_nom_responsable IN  VARCHAR2,
                                   EV_apellido1        IN  GA_RESPCLIENTES.APELLIDO1%TYPE,
                                   EV_apellido2        IN  GA_RESPCLIENTES.APELLIDO2%TYPE,
                                   EV_tipo_responsable IN  GA_RESPCLIENTES.TIPO_RESPONSABLE%TYPE,
                                   SN_codRetorno      OUT NOCOPY ge_errores_pg.CodError,
                                      SV_menRetorno      OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento       OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_insDireccionCliente_PR(EV_cod_cliente      IN  VARCHAR2,
                                        EV_cod_tipdireccion IN  VARCHAR2,
                                          EV_cod_direccion    IN  VARCHAR2,
                                        SN_codRetorno       OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno       OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_numEvento        OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_insCatImposCliente_PR(EV_cod_cliente  IN  VARCHAR2,
                                       EV_cod_catimpos IN  VARCHAR2,
                                       SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_insVendCliente_PR(EV_cod_vendedor IN  VARCHAR2,
                                   EV_cod_cliente  IN  VARCHAR2,
                                     EV_nom_usuario  IN  VARCHAR2,
                                   SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                      SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_updCategCliente_PR(EV_cod_cliente   IN  VARCHAR2,
                                    EV_cod_categoria IN  VARCHAR2,
                                    SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                       SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_updCodigoUsoCliente_PR(EV_codCuenta  IN  VARCHAR2,
                                        EV_codUso     IN  VARCHAR2,
                                        SN_codRetorno OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_numEvento  OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_updCategClienteCta_PR(EV_codCuenta    IN  VARCHAR2,
                                       EV_codCategoria IN  VARCHAR2,
                                       SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_updSubCategCliente_PR(EV_codCliente  IN  VARCHAR2,
                                       EV_codSubCateg IN  VARCHAR2,
                                       SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_numEvento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getCicloPorDefecto_PR(SV_CodCiclo             OUT NOCOPY VARCHAR2,
                       SN_codRetorno           OUT NOCOPY ge_errores_pg.CodError,
                          SV_menRetorno           OUT NOCOPY ge_errores_pg.MsgError,
                       SN_numEvento              OUT NOCOPY ge_errores_pg.Evento);


    PROCEDURE VE_insdatclifactura_PR(
                    EV_cod_cliente      IN GE_CLIENTES.COD_CLIENTE%TYPE,
                    EV_cod_tipident     IN GE_DATCLIFACTURA_TO.COD_TIPIDENT%TYPE,
                    EV_num_ident        IN GE_DATCLIFACTURA_TO.NUM_IDENT%TYPE,
                    EV_nombre_cliente   IN GE_DATCLIFACTURA_TO.NOMBRE%TYPE,
                    EV_Apellido1        IN GE_DATCLIFACTURA_TO.NOM_APELLIDO1%TYPE,
                    EV_Apellido2        IN GE_DATCLIFACTURA_TO.NOM_APELLIDO2%TYPE,
                    EV_Tipo_Factura     IN GE_DATCLIFACTURA_TO.TIPO_FACTURA%TYPE,
                    EV_Cod_tipdocum     IN GE_DATCLIFACTURA_TO.COD_TIPDOCUM%TYPE,
                    EV_num_venta        IN GE_DATCLIFACTURA_TO.NUM_VENTA%TYPE,
                    EV_Nom_usuarora     IN GE_DATCLIFACTURA_TO.NOM_USUARORA%TYPE,
                    SN_codRetorno           OUT NOCOPY ge_errores_pg.CodError,
                       SV_menRetorno           OUT NOCOPY ge_errores_pg.MsgError,
                    SN_numEvento              OUT NOCOPY ge_errores_pg.Evento
                    );
PROCEDURE VE_insMontoPreautorizado_PR(EN_cod_cliente   IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                   EN_mto_preaut       IN  GE_MTOPREAUTOCLI_TO.MTO_PREAUTO%TYPE,
                                   EV_nom_usuarora     IN  GE_MTOPREAUTOCLI_TO.NOM_USUARORA%TYPE,
                                   SN_codRetorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_menRetorno       OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento        OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_getListTipoCliente_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_getListCodigos_PR(
                                  EV_nom_columna   IN  GED_CODIGOS.NOM_COLUMNA%TYPE,
                                  SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_getListCalificacion_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_getListoperadoras_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_getListCargosLaborales_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_getListProfesiones_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_getListsegmentos_PR(
                                  EV_tipo_cliente IN  GE_CLIENTES.COD_TIPO%TYPE,
                                  SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
        PROCEDURE VE_insRefCliente_PR
                                  (EV_cod_cliente      IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                   EV_num_referencia   IN  GA_REFERCLI_TO.NUM_REFERENCIA%TYPE,
                                     EV_nomCliente       IN  GA_REFERCLI_TO.NOMBRE%TYPE,
                                     EV_Apellido1        IN  GA_REFERCLI_TO.APELLIDO1%TYPE,
                                     EV_Apellido2        IN  GA_REFERCLI_TO.APELLIDO2%TYPE,
                                   EV_TelefonoMovil    IN  GA_REFERCLI_TO.NUM_TELMOVIL%TYPE,
                                   EV_TelefonoFijo     IN  GA_REFERCLI_TO.NUM_TELFIJO%TYPE,
                                   EV_NomUsuarora      IN  GA_REFERCLI_TO.NOM_USUARORA%TYPE,
                                   SN_codRetorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_menRetorno       OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento        OUT NOCOPY ge_errores_pg.Evento);
    PROCEDURE VE_getListColores_PR         (SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
        PROCEDURE VE_getListCrediticia_PR  (SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
            PROCEDURE VE_getListCalificacion1_PR
                                           (SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
    PROCEDURE VE_getListClasificaciones_PR (SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
    PROCEDURE VE_getListCategoriaCambio_PR (SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                        SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                        SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);


    PROCEDURE VE_insCategCambioCliente_PR
                                  (EN_cod_cliente     IN  GE_CLIENTE_TASA_TO.COD_CLIENTE%TYPE,
                                   EN_cod_categoria   IN  GE_CLIENTE_TASA_TO.COD_CATEGORIA_CAMBIO%TYPE,
                                   EV_NomUsuario      IN  GE_CLIENTE_TASA_TO.NOM_USUARIO%TYPE,
                                   SN_codRetorno       OUT NOCOPY ge_errores_pg.CodError,
                                   SV_menRetorno       OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento        OUT NOCOPY ge_errores_pg.Evento) ;

   PROCEDURE VE_updIngresosMensuales_PR(EN_codCliente IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                        EN_impIngresos IN  GE_CLIENTES.IMP_INGRESOS%TYPE,
                                        SN_codRetorno OUT NOCOPY ge_errores_pg.CodError,
                                        SV_menRetorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_numEvento  OUT NOCOPY ge_errores_pg.Evento);
--Inicio P-CSR-11002 JLGN 26-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
   PROCEDURE VE_insRedSocial_PR(EN_cod_cliente     IN  VE_RED_SOCIAL_TO.COD_CLIENTE%TYPE,
                                EV_des_facebook    IN  VE_RED_SOCIAL_TO.DES_CUENTA_FACEBOOK%TYPE,
                                EV_des_twitter     IN  VE_RED_SOCIAL_TO.DES_CUENTA_TWITTER%TYPE,
                                SN_codRetorno      OUT NOCOPY ge_errores_pg.CodError,
                                SV_menRetorno      OUT NOCOPY ge_errores_pg.MsgError,
                                SN_numEvento       OUT NOCOPY ge_errores_pg.Evento);
   PROCEDURE VE_insEnvFacturFisi_PR(EN_cod_cliente     IN  GA_VALOR_CLI.COD_CLIENTE%TYPE,
                                    SN_codRetorno      OUT NOCOPY ge_errores_pg.CodError,
                                    SV_menRetorno      OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_numEvento       OUT NOCOPY ge_errores_pg.Evento,
        --INICIO INC 185493
                                    EN_Cod_valor       IN  GA_VALOR_CLI.COD_VALOR%TYPE DEFAULT NULL
        --FIN INC 185493                                    
                                    
                                    );
   PROCEDURE VE_getListDirecPre_PR(EN_codDireccion IN GE_DIRECCIONES.COD_DIRECCION%TYPE,
                                   SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                   SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
--Fin P-CSR-11002 JLGN 26-04-2011
--Inicio P-CSR-11002 JLGN 05-05-2011
PROCEDURE VE_insClienteBuro_PR( EV_keyRef                  IN VE_CLIENTE_BURO_TO.COD_REFERENCIA%TYPE,
                                EV_nombre                  IN VE_CLIENTE_BURO_TO.NOMBRE_CLIENTE%TYPE,
                                EV_apellido1               IN VE_CLIENTE_BURO_TO.APELLIDO_PATERNO_CLIENTE%TYPE,
                                EV_apellido2               IN VE_CLIENTE_BURO_TO.APELLIDO_PATERNO_CLIENTE%TYPE,
                                EV_numeroCedula            IN VE_CLIENTE_BURO_TO.NUM_CEDULA_CLIENTE%TYPE,
                                EV_fallecido               IN VE_CLIENTE_BURO_TO.FALLECIDO%TYPE,
                                EV_codFallecido            IN VE_CLIENTE_BURO_TO.COD_FALLECIDO%TYPE,
                                EV_esPEP                   IN VE_CLIENTE_BURO_TO.COD_PEP%TYPE,
                                EV_institucionPEP          IN VE_CLIENTE_BURO_TO.INSTITUCION_PEP%TYPE,
                                EV_cargoPEP                IN VE_CLIENTE_BURO_TO.CARGO_PEP%TYPE,
                                EV_periodoPEP              IN VE_CLIENTE_BURO_TO.PERIODO_PEP%TYPE,
                                EV_fechaVencimientoCedula  IN VE_CLIENTE_BURO_TO.FEC_VENCIMIENTO_CEDULA%TYPE,
                                EV_sexo                    IN VE_CLIENTE_BURO_TO.SEXO%TYPE,
                                EV_fechaNacimiento         IN VE_CLIENTE_BURO_TO.FEC_NACIMIENTO%TYPE,
                                EV_paisNacimiento          IN VE_CLIENTE_BURO_TO.PAIS_NACIMIENTO%TYPE,
                                EV_codPaisNacimiento       IN VE_CLIENTE_BURO_TO.COD_PAIS_NACIMIENTO%TYPE,
                                EV_ciudadNacimiento        IN VE_CLIENTE_BURO_TO.CIUDAD_NACIMIENTO%TYPE,
                                EV_codCiudadNacimiento     IN VE_CLIENTE_BURO_TO.COD_CIUDAD_NACIMIENTO%TYPE,
                                EV_edad                    IN VE_CLIENTE_BURO_TO.EDAD%TYPE,
                                EV_estadoCivil             IN VE_CLIENTE_BURO_TO.ESTADO_CIVIL%TYPE,
                                EV_codEstadoCivil          IN VE_CLIENTE_BURO_TO.COD_ESTADO_CIVIL%TYPE,
                                EV_cantidadEventos         IN VE_CLIENTE_BURO_TO.CANTIDAD_EVENTOS%TYPE,
                                EV_codProvincia            IN VE_CLIENTE_BURO_TO.COD_PROVINCIA%TYPE,
                                EV_codCanton               IN VE_CLIENTE_BURO_TO.COD_CANTON%TYPE,
                                EV_codDistrito             IN VE_CLIENTE_BURO_TO.COD_DISTRITO%TYPE,
                                EV_bloqueo                 IN VE_CLIENTE_BURO_TO.BLOQUEO%TYPE,
                                EV_codigoBloqueo           IN VE_CLIENTE_BURO_TO.COD_BLOQUEO%TYPE,
                                EV_desDireccion            IN VE_CLIENTE_BURO_TO.DES_DIRECCION%TYPE,
                                EV_fechaVencimiento        IN VE_CLIENTE_BURO_TO.FEC_VENCIMIENTO_EMPRESA%TYPE,
                                EV_tomo                    IN VE_CLIENTE_BURO_TO.TOMO%TYPE,
                                EV_folio                   IN VE_CLIENTE_BURO_TO.FOLIO%TYPE,
                                EV_asiento                 IN VE_CLIENTE_BURO_TO.ASIENTO%TYPE,
                                EV_clasificacion           IN VE_CLIENTE_BURO_TO.CLASIFICACION_EMPRESA%TYPE,
                                EV_actividad               IN VE_CLIENTE_BURO_TO.ACTIVIDAD_EMPRESA%TYPE,
                                EV_telefono                IN VE_CLIENTE_BURO_TO.NUM_TELEFONO%TYPE,
                                EV_personeriaSociedad      IN VE_CLIENTE_BURO_TO.PERSONERIA_SOCIEDAD%TYPE,
                                EV_domicilio               IN VE_CLIENTE_BURO_TO.DOMICILIO%TYPE,
                                EV_representacion          IN VE_CLIENTE_BURO_TO.REPRESENTACION%TYPE,
                                EV_celular               IN VE_CLIENTE_BURO_TO.NUM_CELULAR%TYPE,
                                EV_tipProducto             IN VE_CLIENTE_BURO_TO.TIP_PRODUCTO%TYPE,
                                EV_tipSegmento             IN VE_CLIENTE_BURO_TO.TIP_SEGMENTO%TYPE,
                                EV_datosGenerales          IN VE_CLIENTE_BURO_TO.DATOS_GENERALES%TYPE,
                                EV_laboral                 IN VE_CLIENTE_BURO_TO.LABORAL%TYPE,
                                EV_histConsulta            IN VE_CLIENTE_BURO_TO.HIST_CONSULTA%TYPE,
                                EV_RefCredito              IN VE_CLIENTE_BURO_TO.REF_CREDITO%TYPE,
                                EV_libEntradaHistorico     IN VE_CLIENTE_BURO_TO.LIB_ENTRADA_HIST%TYPE,
                                EV_libEntradaActivo        IN VE_CLIENTE_BURO_TO.LIB_ENTRADA_ACT%TYPE,
                                EV_resulCalificacion       IN VE_CLIENTE_BURO_TO.RESUL_CALIFICACION%TYPE,
                                EV_codInterno              IN VE_CLIENTE_BURO_TO.COD_INTERNO%TYPE,
                                EV_nombreTrabajo           IN VE_CLIENTE_BURO_TO.NOMBRE_TRABAJO%TYPE,
                                EV_nombreComercial         IN VE_CLIENTE_BURO_TO.NOMBRE_COMERCIAL%TYPE,
                                EV_provinciaPatrono        IN VE_CLIENTE_BURO_TO.PROVINCIA_PATRONO%TYPE,
                                EV_cantonPatrono           IN VE_CLIENTE_BURO_TO.CANTON_PATRONO%TYPE,
                                EV_distritoPatrono         IN VE_CLIENTE_BURO_TO.DISTRITO_PATRONO%TYPE,
                                EV_codTipPatrono           IN VE_CLIENTE_BURO_TO.COD_TIP_PATRONO%TYPE,
                                EV_cedulaTrabajo           IN VE_CLIENTE_BURO_TO.CEDULA_TRABAJO%TYPE,
                                EV_finesTrabajo            IN VE_CLIENTE_BURO_TO.FINES_TRABAJO%TYPE,
                                EV_ocupacion               IN VE_CLIENTE_BURO_TO.OCUPACION%TYPE,
                                EV_codOcupacion            IN VE_CLIENTE_BURO_TO.COD_OCUPACION%TYPE,
                                EV_salario                 IN VE_CLIENTE_BURO_TO.SALARIO%TYPE,
                                EV_prom3Meses              IN VE_CLIENTE_BURO_TO.SALAR_PROM_TRES_MESES%TYPE,
                                EV_prom6Meses              IN VE_CLIENTE_BURO_TO.SALAR_PROM_SEIS_MESES%TYPE,
                                EV_prom12Meses             IN VE_CLIENTE_BURO_TO.SALAR_PROM_DOCE_MESES%TYPE,
                                EV_fechaRegistro           IN VE_CLIENTE_BURO_TO.FEC_REGISTRO%TYPE,
                                EV_tiempoLaboral           IN VE_CLIENTE_BURO_TO.TIEMPO_LABORAL%TYPE,
                                EV_mesesLaboral            IN VE_CLIENTE_BURO_TO.MESES_LABORAL%TYPE,
                                EV_montoDeuda              IN VE_CLIENTE_BURO_TO.MONTO_DEUDA%TYPE,
                                EV_numCuotas               IN VE_CLIENTE_BURO_TO.NUM_CUOTAS%TYPE,
                                EV_desDirecTrabajo         IN VE_CLIENTE_BURO_TO.DES_DIREC_TRABAJO%TYPE,
                                EV_centralTelefonica       IN VE_CLIENTE_BURO_TO.CENTRAL_TELEFONICA%TYPE,
                                EV_nombreConyuge           IN VE_CLIENTE_BURO_TO.NOMBRE_CONYUGE%TYPE,
                                EV_apellido1Conyuge        IN VE_CLIENTE_BURO_TO.APELLIDO_PATERNO_CONYUGE%TYPE,
                                EV_apellido2Conyuge        IN VE_CLIENTE_BURO_TO.APELLIDO_MATERNO_CONYUGE%TYPE,
                                EV_nombreCompletoConyuge   IN VE_CLIENTE_BURO_TO.NOMBRE_COMPLETO_CONYUGE%TYPE,
                                EV_fallecidoConyuge        IN VE_CLIENTE_BURO_TO.FALLECIDO_CONYUGE%TYPE,
                                EV_codFallecidoConyuge     IN VE_CLIENTE_BURO_TO.COD_FALLECIDO_CONYUGE%TYPE,
                                EV_cedulaConyuge           IN VE_CLIENTE_BURO_TO.NUM_CEDULA_CONYUGE%TYPE,
                                EV_nomRelacion             IN VE_CLIENTE_BURO_TO.NOM_RELACION%TYPE,
                                EV_codRelacion             IN VE_CLIENTE_BURO_TO.COD_RELACION%TYPE,
                                EV_laboraConyuge           IN VE_CLIENTE_BURO_TO.LABORA_CONYUGE%TYPE,
                                EV_nombreMadre             IN VE_CLIENTE_BURO_TO.NOMBRE_MADRE%TYPE,
                                EV_codParentescoMadre      IN VE_CLIENTE_BURO_TO.COD_PARENTESCO_MADRE%TYPE,
                                EV_fallecidaMadre          IN VE_CLIENTE_BURO_TO.FALLECIDA_MADRE%TYPE,
                                EV_codFallecidaMadre       IN VE_CLIENTE_BURO_TO.COD_FALLECIDA_MADRE%TYPE,
                                EV_cedulaMadre             IN VE_CLIENTE_BURO_TO.NUM_CEDULA_MADRE%TYPE,
                                EV_nombrePadre             IN VE_CLIENTE_BURO_TO.NOMBRE_PADRE%TYPE,
                                EV_codParentescoPadre      IN VE_CLIENTE_BURO_TO.COD_PARENTESCO_PADRE%TYPE,
                                EV_fallecidaPadre          IN VE_CLIENTE_BURO_TO.FALLECIDO_PADRE%TYPE,
                                EV_codFallecidaPadre       IN VE_CLIENTE_BURO_TO.COD_FALLECIDO_PADRE%TYPE,
                                EV_cedulaPadre               IN VE_CLIENTE_BURO_TO.NUM_CEDULA_PADRE%TYPE,
                                EV_nombreSociedad          IN VE_CLIENTE_BURO_TO.NOMBRE_SOCIEDAD%TYPE,
                                EV_cedulaSociedad          IN VE_CLIENTE_BURO_TO.NUM_CEDULA_SOCIEDAD%TYPE,
                                EV_puestoSociedad          IN VE_CLIENTE_BURO_TO.PUESTO_SOCIEDAD%TYPE,
                                EV_fechaConsultadaSociedad IN VE_CLIENTE_BURO_TO.FECHA_CONSULTADA_SOCIEDAD%TYPE,
                                EV_limiteConsumo           IN VE_CLIENTE_BURO_TO.LIMITE_CONSUMO%TYPE,
                                EV_razonSocial             IN VE_CLIENTE_BURO_TO.RAZON_SOCIAL%TYPE,
                                EV_usuario                 IN VE_CLIENTE_BURO_TO.NOM_USUARIO%TYPE, 
                                SN_codRetorno              OUT NOCOPY ge_errores_pg.CodError,
                                SV_menRetorno              OUT NOCOPY ge_errores_pg.MsgError,
                                SN_numEvento               OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_insNombramientoBuro_PR(EV_keyRef                   IN VE_NOMBRAMIENTO_BURO_TO.COD_REFERENCIA%TYPE,
                                    EV_tipNombramiento          IN VE_NOMBRAMIENTO_BURO_TO.TIP_NOMBRAMIENTO%TYPE,
                                    EV_nombreNombramiento       IN VE_NOMBRAMIENTO_BURO_TO.NOMBRE_NOMBRAMIENTO%TYPE,
                                    EV_apellido1Nombramiento    IN VE_NOMBRAMIENTO_BURO_TO.APELLIDO_PATERNO_NOMBRAMIENTO%TYPE,
                                    EV_apellido2Nombramiento    IN VE_NOMBRAMIENTO_BURO_TO.APELLIDO_MATERNO_NOMBRAMIENTO%TYPE,
                                    EV_tipIdentNombramiento     IN VE_NOMBRAMIENTO_BURO_TO.TIP_IDENT%TYPE,
                                    EV_numidentNombramiento     IN VE_NOMBRAMIENTO_BURO_TO.NUM_IDENT%TYPE,
                                    EV_nacionalidadNombramiento IN VE_NOMBRAMIENTO_BURO_TO.NACIONALIDAD%TYPE,
                                    EV_estadoCivilNombramiento  IN VE_NOMBRAMIENTO_BURO_TO.ESTADO_CIVIL%TYPE,
                                    EV_ocupacionNombramiento    IN VE_NOMBRAMIENTO_BURO_TO.OCUPACION%TYPE,
                                    EV_domicilioNombramiento    IN VE_NOMBRAMIENTO_BURO_TO.DOMICILIO%TYPE,
                                    EV_direccionOficina         IN VE_NOMBRAMIENTO_BURO_TO.DIRECCION_OFICINA%TYPE,
                                    SN_codRetorno               OUT NOCOPY ge_errores_pg.CodError,
                                    SV_menRetorno               OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_numEvento                OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_histLabBuro_PR(EV_keyRef             IN VE_HISTORICO_LABORAL_BURO_TO.COD_REFERENCIA%TYPE,
                            EV_cedulaHist         IN VE_HISTORICO_LABORAL_BURO_TO.CEDULA%TYPE,
                            EV_codTipPatronoHist  IN VE_HISTORICO_LABORAL_BURO_TO.COD_TIP_PATRONO%TYPE,
                            EV_nombreHist         IN VE_HISTORICO_LABORAL_BURO_TO.NOMBRE_PATRONO%TYPE,
                            EV_fecInicioHist      IN VE_HISTORICO_LABORAL_BURO_TO.FEC_INICIO%TYPE,
                            EV_fecCompInicioHist  IN VE_HISTORICO_LABORAL_BURO_TO.FEC_COMPLETA_INICIO%TYPE,
                            EV_fecFinHist         IN VE_HISTORICO_LABORAL_BURO_TO.FEC_FIN%TYPE,
                            EV_fecCompFinHist     IN VE_HISTORICO_LABORAL_BURO_TO.FEC_COMPLETA_FIN%TYPE,
                            EV_mesesLaboradosHist IN VE_HISTORICO_LABORAL_BURO_TO.MESES_LABORADOS%TYPE,
                            SN_codRetorno         OUT NOCOPY ge_errores_pg.CodError,
                            SV_menRetorno         OUT NOCOPY ge_errores_pg.MsgError,
                            SN_numEvento          OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_hijosClienteBuro_PR(EV_keyRef             IN VE_HIJOS_CLIENTE_BURO_TO.COD_REFERENCIA%TYPE,
                                 EV_nombreHijo         IN VE_HIJOS_CLIENTE_BURO_TO.NOMBRE_HIJO%TYPE,
                                 EV_nombreCompletoHijo IN VE_HIJOS_CLIENTE_BURO_TO.NOMBRE_COMPLETO_HIJO%TYPE,
                                 EV_apellido1Hijo      IN VE_HIJOS_CLIENTE_BURO_TO.APELLIDO_PATERNO%TYPE,
                                 EV_apellido2Hijo      IN VE_HIJOS_CLIENTE_BURO_TO.APELLIDO_MATERNO%TYPE,
                                 EV_codParentesco      IN VE_HIJOS_CLIENTE_BURO_TO.COD_PARENTESCO%TYPE,
                                 EV_cedulaHijo         IN VE_HIJOS_CLIENTE_BURO_TO.NUM_CEDULA_HIJO%TYPE,
                                 EV_fallecidoHijo      IN VE_HIJOS_CLIENTE_BURO_TO.FALLECIDO%TYPE,
                                 EV_codFallecidoHijo   IN VE_HIJOS_CLIENTE_BURO_TO.COD_FALLECIDO%TYPE,
                                 EV_edadHijo           IN VE_HIJOS_CLIENTE_BURO_TO.EDAD_HIJO%TYPE,
                                 EV_fecNacimientoHijo  IN VE_HIJOS_CLIENTE_BURO_TO.FECHA_NACIMIENTO%TYPE,
                                 EV_sexoHijo           IN VE_HIJOS_CLIENTE_BURO_TO.SEXO_HIJO%TYPE,
                                 SN_codRetorno         OUT NOCOPY ge_errores_pg.CodError,
                                 SV_menRetorno         OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_numEvento          OUT NOCOPY ge_errores_pg.Evento);
--Fin P-CSR-11002 JLGN 05-05-2011
--Inicio P-CSR-11002 JLGN 17-05-2011
 PROCEDURE VE_excepcionCalificacion_PR(EN_codCliente         IN ve_excepcion_calificacion_td.COD_CLIENTE%TYPE,
                                       EV_codplantarif       IN ve_excepcion_calificacion_td.COD_PLANTARIF%TYPE,
                                       EV_nomuser            IN ve_excepcion_calificacion_td.NOM_USUARIO%TYPE,
                                       EV_codPass            IN ve_excepcion_calificacion_td.COD_PASSWORD%TYPE,
                                       EV_limiteCredito      IN ve_excepcion_calificacion_td.LIMITE_CREDITO%TYPE,
                                       SN_codRetorno         OUT NOCOPY ge_errores_pg.CodError,
                                       SV_menRetorno         OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_numEvento          OUT NOCOPY ge_errores_pg.Evento);
--Inicio P-CSR-11002 JLGN 26-05-2011
 PROCEDURE VE_datos_cliente_PR(EN_num_venta     IN ga_ventas.NUM_VENTA%TYPE,
                               SV_num_ident     OUT NOCOPY ge_clientes.NUM_IDENT%TYPE,
                               SV_categoria     OUT NOCOPY ge_clientes.COD_CATEGORIA%TYPE,
                               SV_nom_cliente   OUT NOCOPY ge_clientes.NOM_CLIENTE%TYPE,
                               SV_ape_cliente   OUT NOCOPY VARCHAR2,
                               SV_domicilio     OUT NOCOPY VARCHAR2,
                               SV_des_provincia OUT NOCOPY ge_provincias.DES_PROVINCIA%TYPE,
                               SV_des_canton    OUT NOCOPY ge_ciudades.DES_CIUDAD%TYPE,
                               SV_mail          OUT NOCOPY ge_clientes.NOM_EMAIL%TYPE,
                               SV_nom_represen  OUT NOCOPY ge_clientes.NOM_APODERADO%TYPE,
                               SV_num_ident_re  OUT NOCOPY ge_clientes.NUM_IDENTAPOR%TYPE,
                               SV_mens_promo    OUT NOCOPY ge_clientes.MENS_PROMO%TYPE,
                               SV_des_tipident  OUT NOCOPY ge_tipident.DES_TIPIDENT%TYPE,
                               SV_num_ctacorr   OUT NOCOPY ge_clientes.NUM_CTACORR%TYPE,
                               SV_banco         OUT NOCOPY ge_bancos.DES_BANCO%TYPE,
                               SV_banco_tarj    OUT NOCOPY ge_bancos.DES_BANCO%TYPE,
                               SV_num_tarjeta   OUT NOCOPY ge_clientes.NUM_TARJETA%TYPE,
                               SV_des_tarjeta   OUT NOCOPY ge_tiptarjetas.DES_TIPTARJETA%TYPE,
                               SV_limiteconsumo OUT NOCOPY VARCHAR2,
                               SV_tipo_cliente  OUT NOCOPY ge_clientes.COD_TIPO%TYPE,
                               SV_des_tipide_re OUT NOCOPY ge_tipident.DES_TIPIDENT%TYPE,
                               SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                               SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                               SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);

 --Inicio P-CSR-11002 JLGN 14-06-2011
 PROCEDURE VE_direcPerso_PR(EN_codCliente         IN ga_direccli.COD_CLIENTE%TYPE,
                            EV_direcPerso         OUT NOCOPY ga_direccli.COD_DIRECCION%TYPE,
                            SN_codRetorno         OUT NOCOPY ge_errores_pg.CodError,
                            SV_menRetorno         OUT NOCOPY ge_errores_pg.MsgError,
                            SN_numEvento          OUT NOCOPY ge_errores_pg.Evento);
--Inicio P-CSR-11002 JLGN 05-08-2011
 PROCEDURE VE_mens_promo_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                            SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                            SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
END Ve_Alta_Cliente_Pg;
/
SHOW ERRORS