CREATE OR REPLACE PACKAGE VE_ALTA_CLIENTE_QUIOSCO_PG IS

-----------------------------
-- DECLARACION DE CONSTANTES
-----------------------------
   cv_producto             CONSTANT VARCHAR2 (1)  := '1';
   cv_modulo_ga            CONSTANT VARCHAR2 (2)  := 'GA';
   cv_modulo_ge            CONSTANT VARCHAR2 (2)  := 'GE';
   cv_errornoclasif        CONSTANT VARCHAR2 (30) := 'Error no clasificado';
   cv_subcatimpos          CONSTANT VARCHAR2 (8)  := 'SUCATIMP';
   cv_formatofecha         CONSTANT VARCHAR2 (10) := 'DD/MM/YYYY';
   cv_formatofecmax        CONSTANT VARCHAR2 (21) := 'DD-MM-YYYY HH24:MI:SS';
   cn_largoerrtec          CONSTANT NUMBER        := 4000;
   cn_largodesc            CONSTANT NUMBER        := 2000;
   -- para busqueda de los idiomas en SCL
   cv_tab_gecliente        CONSTANT VARCHAR2 (11) := 'GE_CLIENTES';
   cv_col_gecliente        CONSTANT VARCHAR2 (10) := 'COD_IDIOMA';
   -- para busqueda de las categorias tributarias
   cv_tab_gecatribdocum    CONSTANT VARCHAR2 (14) := 'GE_CATRIBDOCUM';
   cv_col_gecatribdocum    CONSTANT VARCHAR2 (12) := 'COD_TIPDOCUM';
   -- nombre de parametros
   cv_nompar_formatosel2   CONSTANT VARCHAR2 (12) := 'FORMATO_SEL2';
   cv_nompar_formatosel7   CONSTANT VARCHAR2 (12) := 'FORMATO_SEL7';
   cv_nompar_fechamaxima   CONSTANT VARCHAR2 (12) := 'FECHA_MAXIMA';

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
   PROCEDURE ve_getfecha_pr (
      ev_fecha                       VARCHAR2,
      ev_formatofecha                VARCHAR2,
      ev_formatohora                 VARCHAR2,
      sd_fecha          OUT NOCOPY   DATE,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento);

--    PROCEDURE VE_getValorParametro_PR(EV_nomParametro IN ged_parametros.nom_parametro%TYPE,
--                                EV_codModulo    IN ged_parametros.cod_modulo%TYPE,
--                              EV_codProducto  IN ged_parametros.cod_producto%TYPE,
--                              SV_valParametro OUT NOCOPY ged_parametros.val_parametro%TYPE,
--                              SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
--                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
--                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
   PROCEDURE ve_getplancomercial_pr (
      ev_codcalifcte   IN              ve_plan_calcli.cod_calclien%TYPE,
      sn_codplancom    OUT NOCOPY      ve_cabplancom.cod_plancom%TYPE,
      sv_desplancom    OUT NOCOPY      ve_cabplancom.des_plancom%TYPE,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getcodigonuevocliente_pr (
      sn_codcliente   OUT NOCOPY   ge_clientes.cod_cliente%TYPE,
      sn_codretorno   OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE ve_getprospectocliente_pr (
      ev_codtipident     IN              ve_prospectos.cod_tipident%TYPE,
      ev_numident        IN              ve_prospectos.num_ident%TYPE,
      sv_nomnombre       OUT NOCOPY      ve_prospectos.nom_nombre%TYPE,
      sv_nomapellido1    OUT NOCOPY      ve_prospectos.nom_apellido1%TYPE,
      sv_nomapellido2    OUT NOCOPY      ve_prospectos.nom_apellido2%TYPE,
      sv_numtelef1       OUT NOCOPY      ve_prospectos.num_telef1%TYPE,
      sv_numtelef2       OUT NOCOPY      ve_prospectos.num_telef2%TYPE,
      sv_numfax          OUT NOCOPY      ve_prospectos.num_fax%TYPE,
      sv_nomreprlegal    OUT NOCOPY      ve_prospectos.nom_reprlegal%TYPE,
      sv_codtipidrepr    OUT NOCOPY      ve_prospectos.cod_tipidrepr%TYPE,
      sv_numidrepr       OUT NOCOPY      ve_prospectos.num_idrepr%TYPE,
      sn_codrubro        OUT NOCOPY      ve_prospectos.cod_rubro%TYPE,
      sv_codbanco        OUT NOCOPY      ve_prospectos.cod_banco%TYPE,
      sv_numcuenta       OUT NOCOPY      ve_prospectos.num_cuenta%TYPE,
      sv_codtiptarjeta   OUT NOCOPY      ve_prospectos.cod_tiptarjeta%TYPE,
      sv_numtarjeta      OUT NOCOPY      ve_prospectos.num_tarjeta%TYPE,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getprospectodireccion_pr (
      en_codprospecto   IN              ve_prodireccion.cod_prospecto%TYPE,
      ev_tipdireccion   IN              ve_prodireccion.cod_tipdireccion%TYPE,
      sn_coddireccion   OUT NOCOPY      ve_prodireccion.cod_direccion%TYPE,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getclientevendedor_pr (
      ev_codtipident     IN              ge_clientes.cod_tipident%TYPE,
      ev_numident        IN              ge_clientes.num_ident%TYPE,
      sn_codcategoria    OUT NOCOPY      ge_clientes.cod_categoria%TYPE,
      sn_codsector       OUT NOCOPY      ge_clientes.cod_sector%TYPE,
      sn_codsupervisor   OUT NOCOPY      ge_clientes.cod_supervisor%TYPE,
      sn_codvendedor     OUT NOCOPY      ve_vendcliente.cod_vendedor%TYPE,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getcodigonuevaempresa_pr (
      sn_codempresa   OUT          ga_empresa.cod_empresa%TYPE,
      sn_codretorno   OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY   ge_errores_pg.evento);

   --------------------------------------------------------------------------------------------
--* CURSORES - LISTAS
--------------------------------------------------------------------------------------------
   PROCEDURE ve_getlistgedcodigos_pr (
      ev_modulo        IN              VARCHAR2,
      ev_tabla         IN              VARCHAR2,
      ev_columna       IN              VARCHAR2,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getlisttiposidentif_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE ve_getlistcategorias_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE ve_getlistcategimpositivas_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE ve_getlisttipcomisionistas_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento);

   --Inicio Incidencia 109225 [ACP Soporte Ventas 08-10-2009]
   --PROCEDURE ve_getlistmodalidadpago2_pr (
   PROCEDURE ve_getlistmodalidadpago_pr (
      --Fin Incidencia 109225 [ACP Soporte Ventas 08-10-2009]
      en_indmanual     IN              ge_sispago.ind_manual%TYPE,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getlistmodalidadpago_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE ve_getlistbancospac_pr (
      en_indpac        IN              ge_bancos.ind_pac%TYPE,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getlistsucursalesbanco_pr (
      ev_codbanco      IN              ge_sucursales.cod_banco%TYPE,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getlisttarjetas_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE ve_getlistoficinasscl_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE ve_getlistplancomcalcte_pr (
      ev_codcalifcte   IN              ve_plan_calcli.cod_calclien%TYPE,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getlistsubcategimpos_pr (
      ev_codcategimp   IN              al_tipo_codigo.tip_codigo%TYPE,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getlistactividades_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE ve_getlistpaises_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento);


--------------------------------------------------------------------------------------------
--* INSERTS y UPDATES
--------------------------------------------------------------------------------------------
   PROCEDURE ve_inssecdespachocliente_pr (
      en_codcliente   IN              ga_secdespclie.cod_cliente%TYPE,
      ev_usuario      IN              VARCHAR2,
      sn_codretorno   OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_inscategoriatributaria_pr (
      en_codcliente   IN              ga_catributclie.cod_cliente%TYPE,
      ev_codcattrib   IN              ga_catributclie.cod_catribut%TYPE,
      sn_codretorno   OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_insempresa_pr (
      ev_desempresa     IN              ga_empresa.des_empresa%TYPE,
      en_codproducto    IN              ga_empresa.cod_producto%TYPE,
      ev_codplantarif   IN              ga_empresa.cod_plantarif%TYPE,
      en_codciclo       IN              ga_empresa.cod_ciclo%TYPE,
      en_codcliente     IN              ga_empresa.cod_cliente%TYPE,
      en_numabonados    IN              ga_empresa.num_abonados%TYPE,
      ev_usuario        IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_inscliente_pr (
      ev_cod_cliente          IN              VARCHAR2,
      ev_nom_cliente          IN              VARCHAR2,
      ev_cod_tipident         IN              VARCHAR2,
      ev_num_ident            IN              VARCHAR2,
      ev_cod_calclien         IN              VARCHAR2,
      ev_ind_situacion        IN              VARCHAR2,
      ev_ind_factur           IN              VARCHAR2,
      ev_ind_traspaso         IN              VARCHAR2,
      ev_ind_agente           IN              VARCHAR2,
      ev_num_fax              IN              VARCHAR2,
      ev_ind_mandato          IN              VARCHAR2,
      ev_nom_usuarora         IN              VARCHAR2,
      ev_ind_alta             IN              VARCHAR2,
      ev_cod_cuenta           IN              VARCHAR2,
      ev_ind_acepvent         IN              VARCHAR2,
      ev_cod_abc              IN              VARCHAR2,
      ev_cod_123              IN              VARCHAR2,
      ev_cod_actividad        IN              VARCHAR2,
      ev_cod_pais             IN              VARCHAR2,
      ev_tef_cliente1         IN              VARCHAR2,
      ev_num_abocel           IN              VARCHAR2,
      ev_tef_cliente2         IN              VARCHAR2,
      ev_num_abobeep          IN              VARCHAR2,
      ev_ind_debito           IN              VARCHAR2,
      ev_num_abotrunk         IN              VARCHAR2,
      ev_cod_prospecto        IN              VARCHAR2,
      ev_num_abotrek          IN              VARCHAR2,
      ev_cod_sispago          IN              VARCHAR2,
      ev_nom_apeclien1        IN              VARCHAR2,
      ev_nom_email            IN              VARCHAR2,
      ev_num_aborent          IN              VARCHAR2,
      ev_nom_apeclien2        IN              VARCHAR2,
      ev_num_aboroaming       IN              VARCHAR2,
      ev_fec_acepvent         IN              VARCHAR2,
      ev_imp_stopdebit        IN              VARCHAR2,
      ev_cod_banco            IN              VARCHAR2,
      ev_cod_sucursal         IN              VARCHAR2,
      ev_ind_tipcuenta        IN              VARCHAR2,
      ev_cod_tiptarjeta       IN              VARCHAR2,
      ev_num_ctacorr          IN              VARCHAR2,
      ev_num_tarjeta          IN              VARCHAR2,
      ev_fec_vencitarj        IN              VARCHAR2,
      ev_cod_bancotarj        IN              VARCHAR2,
      ev_cod_tipidtrib        IN              VARCHAR2,
      ev_num_identtrib        IN              VARCHAR2,
      ev_cod_tipidentapor     IN              VARCHAR2,
      ev_num_identapor        IN              VARCHAR2,
      ev_nom_apoderado        IN              VARCHAR2,
      ev_cod_oficina          IN              VARCHAR2,
      ev_fec_baja             IN              VARCHAR2,
      ev_cod_cobrador         IN              VARCHAR2,
      ev_cod_pincli           IN              VARCHAR2,
      ev_cod_ciclo            IN              VARCHAR2,
      ev_num_celular          IN              VARCHAR2,
      ev_ind_tippersona       IN              VARCHAR2,
      ev_cod_ciclonue         IN              VARCHAR2,
      ev_cod_categoria        IN              VARCHAR2,
      ev_cod_sector           IN              VARCHAR2,
      ev_cod_supervisor       IN              VARCHAR2,
      ev_ind_estcivil         IN              VARCHAR2,
      ev_fec_nacimien         IN              VARCHAR2,
      ev_ind_sexo             IN              VARCHAR2,
      ev_num_int_grup_fam     IN              VARCHAR2,
      ev_cod_npi              IN              VARCHAR2,
      ev_cod_subcategoria     IN              VARCHAR2,
      ev_cod_uso              IN              VARCHAR2,
      ev_cod_idioma           IN              VARCHAR2,
      ev_cod_tipident2        IN              VARCHAR2,
      ev_num_ident2           IN              VARCHAR2,
      ev_nom_usuario_asesor   IN              VARCHAR2,
      ev_cod_operadora        IN              VARCHAR2,
      ev_id_segmento          IN              VARCHAR2,
      ev_cod_crediticia       IN              VARCHAR2, --CSR-11002
      sn_codretorno           OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno           OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento            OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_insmodcliente_pr (
      ev_cod_cliente        IN              VARCHAR2,
      ev_cod_tipmodi        IN              VARCHAR2,
      ev_fec_modifica       IN              VARCHAR2,
      ev_nom_usuarora       IN              VARCHAR2,
      ev_nom_cliente        IN              VARCHAR2,
      ev_cod_tipident       IN              VARCHAR2,
      ev_num_ident          IN              VARCHAR2,
      ev_cod_calclien       IN              VARCHAR2,
      ev_cod_plancom        IN              VARCHAR2,
      ev_ind_factur         IN              VARCHAR2,
      ev_ind_traspaso       IN              VARCHAR2,
      ev_cod_actividad      IN              VARCHAR2,
      ev_cod_pais           IN              VARCHAR2,
      ev_tef_cliente1       IN              VARCHAR2,
      ev_tef_cliente2       IN              VARCHAR2,
      ev_num_fax            IN              VARCHAR2,
      ev_ind_debito         IN              VARCHAR2,
      ev_cod_sispago        IN              VARCHAR2,
      ev_nom_apeclien1      IN              VARCHAR2,
      ev_nom_apeclien2      IN              VARCHAR2,
      ev_imp_stopdebit      IN              VARCHAR2,
      ev_cod_banco          IN              VARCHAR2,
      ev_cod_sucursal       IN              VARCHAR2,
      ev_ind_tipcuenta      IN              VARCHAR2,
      ev_cod_tiptarjeta     IN              VARCHAR2,
      ev_num_ctacorr        IN              VARCHAR2,
      ev_num_tarjeta        IN              VARCHAR2,
      ev_fec_vencitarj      IN              VARCHAR2,
      ev_cod_bancotarj      IN              VARCHAR2,
      ev_cod_tipidtrib      IN              VARCHAR2,
      ev_num_identtrib      IN              VARCHAR2,
      ev_cod_tipidentapor   IN              VARCHAR2,
      ev_num_identapor      IN              VARCHAR2,
      ev_nom_apoderado      IN              VARCHAR2,
      ev_cod_oficina        IN              VARCHAR2,
      ev_cod_pincli         IN              VARCHAR2,
      ev_nom_email          IN              VARCHAR2,
      ev_cod_ciclo          IN              VARCHAR2,
      ev_cod_categoria      IN              VARCHAR2,
      ev_cod_sector         IN              VARCHAR2,
      ev_cod_supervisor     IN              VARCHAR2,
      ev_cod_npi            IN              VARCHAR2,
      ev_cod_empresa        IN              VARCHAR2,
      ev_tip_plantarif      IN              VARCHAR2,
      ev_cod_plantarif      IN              VARCHAR2,
      ev_cod_cargobasico    IN              VARCHAR2,
      ev_num_os             IN              VARCHAR2,
      ev_num_ciclos         IN              VARCHAR2,
      ev_num_minutos        IN              VARCHAR2,
      ev_cod_idioma         IN              VARCHAR2,
      ev_cod_tipident2      IN              VARCHAR2,
      ev_num_ident2         IN              VARCHAR2,
      ev_cod_plaza          IN              VARCHAR2,
      ev_des_refdoc         IN              VARCHAR2,
      ev_cod_limconsumo     IN              VARCHAR2,
      ev_cod_subcategoria   IN              VARCHAR2,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_insplancomcliente_pr (
      ev_cod_cliente    IN              VARCHAR2,
      ev_cod_plancom    IN              VARCHAR2,
      ev_nom_usuarora   IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_insrespcliente_pr (
      ev_cod_cliente       IN              VARCHAR2,
      ev_num_orden         IN              VARCHAR2,
      ev_cod_tipident      IN              VARCHAR2,
      ev_num_ident         IN              VARCHAR2,
      ev_nom_responsable   IN              VARCHAR2,
      sn_codretorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno        OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento         OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_insdireccioncliente_pr (
      ev_cod_cliente        IN              VARCHAR2,
      ev_cod_tipdireccion   IN              VARCHAR2,
      ev_cod_direccion      IN              VARCHAR2,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_inscatimposcliente_pr (
      ev_cod_cliente    IN              VARCHAR2,
      ev_cod_catimpos   IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_insvendcliente_pr (
      ev_cod_vendedor   IN              VARCHAR2,
      ev_cod_cliente    IN              VARCHAR2,
      ev_nom_usuario    IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_updcategcliente_pr (
      ev_cod_cliente     IN              VARCHAR2,
      ev_cod_categoria   IN              VARCHAR2,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_updcodigousocliente_pr (
      ev_codcuenta    IN              VARCHAR2,
      ev_coduso       IN              VARCHAR2,
      sn_codretorno   OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_updcategclientecta_pr (
      ev_codcuenta      IN              VARCHAR2,
      ev_codcategoria   IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_updsubcategcliente_pr (
      ev_codcliente    IN              VARCHAR2,
      ev_codsubcateg   IN              VARCHAR2,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getlistbancospac_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE ve_updempresa_pr (
      en_cod_empresa   IN              ga_empresa.cod_empresa%TYPE,
      en_numabonados   IN              ga_empresa.num_abonados%TYPE,
      ev_usuario       IN              VARCHAR2,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_selempresa_pr (
      en_cod_cliente     IN              ga_empresa.num_abonados%TYPE,
      sn_cod_empresa     OUT NOCOPY      ga_empresa.cod_empresa%TYPE,
      sv_des_empresa     OUT NOCOPY      ga_empresa.des_empresa%TYPE,
      sn_cod_producto    OUT NOCOPY      ga_empresa.cod_producto%TYPE,
      sv_cod_plantarif   OUT NOCOPY      ga_empresa.cod_plantarif%TYPE,
      sd_fec_alta        OUT NOCOPY      ga_empresa.fec_alta%TYPE,
      sv_nom_usuarora    OUT NOCOPY      ga_empresa.nom_usuarora%TYPE,
      sn_cod_ciclo       OUT NOCOPY      ga_empresa.cod_ciclo%TYPE,
      sn_cod_cliente     OUT NOCOPY      ga_empresa.cod_cliente%TYPE,
      sv_tip_terminal    OUT NOCOPY      ga_empresa.tip_terminal%TYPE,
      sn_num_abonados    OUT NOCOPY      ga_empresa.num_abonados%TYPE,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getcliente_pr (
      ev_cod_cliente          IN              VARCHAR,
      sv_cod_cliente          OUT             VARCHAR2,
      sv_nom_cliente          OUT             VARCHAR2,
      sv_cod_tipident         OUT             VARCHAR2,
      sv_num_ident            OUT             VARCHAR2,
      sv_cod_calclien         OUT             VARCHAR2,
      sv_ind_situacion        OUT             VARCHAR2,
      sv_fec_alta             OUT             VARCHAR2,
      sv_ind_factur           OUT             VARCHAR2,
      sv_ind_traspaso         OUT             VARCHAR2,
      sv_ind_agente           OUT             VARCHAR2,
      sv_fec_ultmod           OUT             VARCHAR2,
      sv_num_fax              OUT             VARCHAR2,
      sv_ind_mandato          OUT             VARCHAR2,
      sv_nom_usuarora         OUT             VARCHAR2,
      sv_ind_alta             OUT             VARCHAR2,
      sv_cod_cuenta           OUT             VARCHAR2,
      sv_ind_acepvent         OUT             VARCHAR2,
      sv_cod_abc              OUT             VARCHAR2,
      sv_cod_123              OUT             VARCHAR2,
      sv_cod_actividad        OUT             VARCHAR2,
      sv_cod_pais             OUT             VARCHAR2,
      sv_tef_cliente1         OUT             VARCHAR2,
      sv_num_abocel           OUT             VARCHAR2,
      sv_tef_cliente2         OUT             VARCHAR2,
      sv_num_abobeep          OUT             VARCHAR2,
      sv_ind_debito           OUT             VARCHAR2,
      sv_num_abotrunk         OUT             VARCHAR2,
      sv_cod_prospecto        OUT             VARCHAR2,
      sv_num_abotrek          OUT             VARCHAR2,
      sv_cod_sispago          OUT             VARCHAR2,
      sv_nom_apeclien1        OUT             VARCHAR2,
      sv_nom_email            OUT             VARCHAR2,
      sv_num_aborent          OUT             VARCHAR2,
      sv_nom_apeclien2        OUT             VARCHAR2,
      sv_num_aboroaming       OUT             VARCHAR2,
      sv_fec_acepvent         OUT             VARCHAR2,
      sv_imp_stopdebit        OUT             VARCHAR2,
      sv_cod_banco            OUT             VARCHAR2,
      sv_cod_sucursal         OUT             VARCHAR2,
      sv_ind_tipcuenta        OUT             VARCHAR2,
      sv_cod_tiptarjeta       OUT             VARCHAR2,
      sv_num_ctacorr          OUT             VARCHAR2,
      sv_num_tarjeta          OUT             VARCHAR2,
      sv_fec_vencitarj        OUT             VARCHAR2,
      sv_cod_bancotarj        OUT             VARCHAR2,
      sv_cod_tipidtrib        OUT             VARCHAR2,
      sv_num_identtrib        OUT             VARCHAR2,
      sv_cod_tipidentapor     OUT             VARCHAR2,
      sv_num_identapor        OUT             VARCHAR2,
      sv_nom_apoderado        OUT             VARCHAR2,
      sv_cod_oficina          OUT             VARCHAR2,
      sv_fec_baja             OUT             VARCHAR2,
      sv_cod_cobrador         OUT             VARCHAR2,
      sv_cod_pincli           OUT             VARCHAR2,
      sv_cod_ciclo            OUT             VARCHAR2,
      sv_num_celular          OUT             VARCHAR2,
      sv_ind_tippersona       OUT             VARCHAR2,
      sv_cod_ciclonue         OUT             VARCHAR2,
      sv_cod_categoria        OUT             VARCHAR2,
      sv_cod_sector           OUT             VARCHAR2,
      sv_cod_supervisor       OUT             VARCHAR2,
      sv_ind_estcivil         OUT             VARCHAR2,
      sv_fec_nacimien         OUT             VARCHAR2,
      sv_ind_sexo             OUT             VARCHAR2,
      sv_num_int_grup_fam     OUT             VARCHAR2,
      sv_cod_npi              OUT             VARCHAR2,
      sv_cod_subcategoria     OUT             VARCHAR2,
      sv_cod_uso              OUT             VARCHAR2,
      sv_cod_idioma           OUT             VARCHAR2,
      sv_cod_tipident2        OUT             VARCHAR2,
      sv_num_ident2           OUT             VARCHAR2,
      sv_nom_usuario_asesor   OUT             VARCHAR2,
      sv_cod_operadora        OUT             VARCHAR2,
      sv_id_segmento          OUT             VARCHAR2,
      sv_cod_tecnologia       OUT             VARCHAR2,
      sv_cod_empresa          OUT             VARCHAR2,
      sv_cod_plantarif        OUT             VARCHAR2,
      sv_des_empresa          OUT             VARCHAR2,
      sv_num_abonados         OUT             VARCHAR2,
      sv_num_abonados_plan    OUT             VARCHAR2,
      sn_codretorno           OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno           OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento            OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ga_update_estado_venta_pr (
      so_ventas       IN OUT NOCOPY   ve_tipos_pg.tip_ga_ventas,
      sn_codretorno   OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getcentral_pr (
      ev_cod_hlr                    VARCHAR2,
      ev_cod_celda                  VARCHAR2,
      sv_cod_central   OUT NOCOPY   icg_central.cod_central%TYPE,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento);

END VE_ALTA_CLIENTE_QUIOSCO_PG;
/

SHOW ERRORS
