CREATE OR REPLACE PACKAGE GE_INTEGRACION_PG IS

	-----------------------------
	-- DECLARACION DE CONSTANTES
	-----------------------------

    TYPE refcursor          IS REF CURSOR;
    CV_modulo_ge            CONSTANT VARCHAR2(2) := 'GE';
    CV_errornoclasificado   CONSTANT VARCHAR2(150):= 'Error no clasificado, por favor contáctese con el administrador del sistema';
    CV_version              CONSTANT VARCHAR2(3) := '1.0';
    cn_largoerrtec          CONSTANT NUMBER      := 4000;
    cursorVacio_exception   EXCEPTION;
    cv_prod_celular         CONSTANT NUMBER   (2)  :=  1;

/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "GE_INTEGRACION_PG"
          Lenguaje="PL/SQL"
          Fecha="20-07-2009"
          Versión="1.0"
          Diseñador= "Joan Zamorano"
        Programador=""
          Ambiente Desarrollo="BD">
      <Descripción>Package servicios para la integración SCL - Operadora GTE</Descripción>
  </Elemento>
</Documentación>
*/


PROCEDURE GE_INS_AUDITORIA_PR(EV_nom_usuario        IN  ge_auditoria_int_to.nom_usuario%TYPE,
                              EV_cod_puntoacceso    IN  ge_puntoacceso_int_td.cod_puntoacceso%TYPE,
                              EV_cod_aplicacion     IN  ge_aplicacion_int_td.cod_aplicacion%TYPE,
                              EV_cod_servicio       IN  ge_servicio_int_td.cod_servicio%TYPE,
                              SN_cod_auditoria      OUT NOCOPY ge_auditoria_int_to.cod_auditoria%TYPE,
                              SN_codRetorno         OUT NOCOPY ge_errores_pg.CodError,
                              SV_menRetorno         OUT NOCOPY ge_errores_pg.MsgError,
                              SN_numEvento          OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE GE_INS_PARAM_SERV_PR(EV_nom_usuario       IN  ge_auditoria_int_to.nom_usuario%TYPE,
                               EN_cod_auditoria     IN  ge_auditoria_int_to.cod_auditoria%TYPE,
                               EV_nom_parametro     IN  ge_param_serv_int_to.nom_parametro%TYPE,
                               EV_val_parametro     IN  ge_param_serv_int_to.val_parametro%TYPE,
                               SN_codRetorno        OUT NOCOPY ge_errores_pg.CodError,
                               SV_menRetorno        OUT NOCOPY ge_errores_pg.MsgError,
                               SN_numEvento         OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE ge_consultar_pto_acceso_pr (EV_punto_Acceso     IN GE_PUNTOACCESO_INT_TD.COD_PUNTOACCESO%TYPE,
                                      SV_des_punto_acceso OUT NOCOPY GE_PUNTOACCESO_INT_TD.DES_PUNTOACCESO%TYPE,
                                      SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE ge_validar_aplicacion_pr (EV_aplicacion   IN GE_APLICACION_INT_TD.COD_APLICACION%TYPE,
                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE ge_validar_servicio_pr (EV_servicio     IN GE_SERVICIO_INT_TD.COD_SERVICIO%TYPE,
                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE ge_validar_usuario_pr  (EV_usuario      IN GE_AUDITORIA_INT_TO.NOM_USUARIO%TYPE,
                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE ge_val_num_hib_pr(
        EN_numTelefono       IN         ga_abocel.NUM_CELULAR%TYPE,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento);

PROCEDURE ge_cons_link_fact_pr (
        EN_num_proceso       IN         fa_interimpresion_td.num_proceso%TYPE,
        EN_cod_cliente       IN         fa_interimpresion_td.cod_cliente%TYPE,
        SV_rutafac          OUT NOCOPY  VARCHAR2,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.coderror,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.msgerror,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.evento);

PROCEDURE ge_cons_ciclo_fact_pr(
        EN_codCiclo         IN          ge_clientes.cod_ciclo%TYPE,
        SN_codCicloFact     OUT NOCOPY  fa_ciclfact.cod_ciclfact%TYPE,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento);

PROCEDURE ge_val_clie_facturable_pr(
        EN_codCliente       IN          ga_infaccel.cod_cliente%TYPE,
        EN_numAbonado       IN          ga_infaccel.num_abonado%TYPE,
        EN_codCicloFact     IN          ga_infaccel.cod_ciclfact%TYPE,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento);

PROCEDURE ge_obtener_saldo_clie_pr(
        EN_codCliente        IN         ge_clientes.cod_cliente%TYPE,
        SN_saldoCliente     OUT NOCOPY  CO_CARTERA.IMPORTE_DEBE%TYPE,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento);

PROCEDURE ge_cons_planes_disponibles_pr(
        EN_grpPrestacion    IN  VARCHAR2 ,
        EN_codPrestacion    IN  VARCHAR2 ,
        SC_cursor           OUT NOCOPY  refcursor,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento);

PROCEDURE ge_cons_planes_disponibles_pr(
        EN_grpPrestacion    IN  VARCHAR2 ,
        SC_cursor           OUT NOCOPY  refcursor,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento);

PROCEDURE ge_cons_planes_disponibles_pr(
        SC_cursor           OUT NOCOPY  refcursor,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento);

PROCEDURE ge_val_soporte_gprs_pr (
        EN_num_abonado      IN  ga_abocel.Num_abonado%TYPE,
        EV_cod_tecnologia   IN  ga_abocel.Cod_tecnologia%TYPE,
        EV_num_serie        IN  ga_abocel.Num_serie%TYPE,
        EV_num_imei         IN  ga_abocel.num_imei%TYPE,
        EV_cod_servicio     IN  gad_servsup_art.cod_servicio%TYPE,
        SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);


PROCEDURE GE_CONS_PLANTARIF_PR(
        EN_numero_celular    IN  GA_ABOCEL.NUM_CELULAR%TYPE,
        SV_cod_plantarif  OUT ta_plantarif.cod_plantarif%TYPE,
        SV_des_plantarif  OUT ta_plantarif.des_plantarif%TYPE,
        SN_codRetorno     OUT NOCOPY ge_errores_pg.CodError,
        SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	      SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE GE_CONS_FECALTA_PREPAGO_PR (
        EN_num_telefono    IN             ga_aboamist.num_celular%TYPE,
        SD_fecha_alta     OUT NOCOPY      ga_aboamist.fec_alta%TYPE,
        SN_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
        SV_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
        SN_num_evento     OUT NOCOPY      ge_errores_pg.evento);

PROCEDURE GE_REC_SERV_SUPL_ABONADO_PR (
        EN_num_abonado    IN              ga_abocel.num_abonado%TYPE,
        EN_tip_servicio   IN              NUMBER,
        SC_servsupl		  OUT               refcursor,
        SN_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
        SV_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
        SN_num_evento     OUT NOCOPY      ge_errores_pg.evento);

PROCEDURE GE_CONSULTARDIRECCLIENTE_PR (
       EN_direccliente          IN      	       ga_direccli.COD_CLIENTE%TYPE,
	     SC_direccliente		      OUT NOCOPY	  	 refcursor,
       SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		   ge_errores_pg.evento);

PROCEDURE GE_CONSULTARDIRECCLIENTE_PR (
       EN_direccliente IN       	   ga_direccli.COD_CLIENTE%TYPE,
       EN_direcctipo   IN       	   ga_direccli.COD_TIPDIRECCION%TYPE,
       SV_tipo_direcc  OUT NOCOPY    VARCHAR2,
       SN_cod_direcc   OUT NOCOPY    NUMBER,
       SN_cod_retorno  OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
       SN_num_evento   OUT NOCOPY    ge_errores_pg.evento);

PROCEDURE GE_consultarDireccion_PR (EN_cod_direccion         IN               NUMBER,
                                    EN_cod_tipdireccion      IN               VARCHAR2,
                                    SV_cod_tipocalle         OUT NOCOPY       VARCHAR2,
                                    SV_cod_tipdireccion      OUT NOCOPY       VARCHAR2,
                                    SV_des_tipdireccion      OUT NOCOPY       VARCHAR2,
                                    SV_cod_direccion         OUT NOCOPY       VARCHAR2,
                                    SV_cod_provincia         OUT NOCOPY       VARCHAR2,
                                    SV_des_provincia         OUT NOCOPY       VARCHAR2,
                                    SV_cod_region            OUT NOCOPY       VARCHAR2,
                                    SV_des_region            OUT NOCOPY       VARCHAR2,
                                    SV_cod_ciudad            OUT NOCOPY       VARCHAR2,
                                    SV_des_cuidad            OUT NOCOPY       VARCHAR2,
                                    SV_cod_comuna            OUT NOCOPY       VARCHAR2,
                                    SV_des_comuna            OUT NOCOPY       VARCHAR2,
                                    SV_nom_calle             OUT NOCOPY       VARCHAR2,
                                    SV_num_calle             OUT NOCOPY       VARCHAR2,
                                    SV_num_casilla           OUT NOCOPY       VARCHAR2,
                                    SV_obs_direccion         OUT NOCOPY       VARCHAR2,
                                    SV_zip                   OUT NOCOPY       VARCHAR2,
                                    SV_des_direc1            OUT NOCOPY       VARCHAR2,
                                    SV_des_direc2            OUT NOCOPY       VARCHAR2,
                                    SV_cod_pueblo            OUT NOCOPY       VARCHAR2,
                                    SV_cod_estado            OUT NOCOPY       VARCHAR2,
                                    SV_num_piso              OUT NOCOPY       VARCHAR2,
                                    SN_cod_retorno           OUT NOCOPY       ge_errores_pg.CodError,
                                    SV_mens_retorno          OUT NOCOPY       ge_errores_pg.MsgError,
                                    SN_num_evento            OUT NOCOPY       ge_errores_pg.evento);

PROCEDURE GE_consultarDescProv_PR (
       EN_provincia             IN             	ge_provincias.COD_PROVINCIA%TYPE,
       EN_cod_region            IN               ge_provincias.COD_REGION%TYPE,
       SV_descripcion           OUT              ge_provincias.DES_PROVINCIA%TYPE,
       SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		   ge_errores_pg.evento);


PROCEDURE GE_consultarDescRegion_PR (
       EN_cod_region        	   IN          	    ge_regiones.COD_REGION%TYPE,
       SV_descripcion           OUT              ge_regiones.DES_REGION%TYPE,
       SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		    ge_errores_pg.evento);

PROCEDURE GE_consultarDescCiudad_PR (
       EN_cod_region            IN         ge_ciudades.COD_REGION%TYPE,
       EN_cod_provincia         IN         ge_ciudades.COD_PROVINCIA%TYPE,
       EN_cod_ciudad            IN         ge_ciudades.COD_CIUDAD%TYPE,
       SV_descripcion           OUT        ge_ciudades.DES_CIUDAD%TYPE,
       SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		    ge_errores_pg.evento);


PROCEDURE GE_consultarDescComuna_PR (
       EN_cod_region             IN           ge_comunas.COD_REGION%TYPE,
       EN_cod_provincia          IN           ge_comunas.COD_PROVINCIA%TYPE,
       EN_cod_comuna             IN           ge_comunas.COD_COMUNA%TYPE,
       SV_descripcion            OUT          ge_comunas.DES_COMUNA% TYPE,
       SN_cod_retorno            OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno           OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
       SN_num_evento             OUT NOCOPY		ge_errores_pg.evento);

PROCEDURE GE_consultarDescPueblo_PR (
       EN_cod_pueblo        IN              ge_pueblos.COD_PUEBLO%TYPE,
       EN_cod_estado        IN              ge_pueblos.COD_ESTADO%TYPE,
       SV_decripcion        OUT             ge_pueblos.DES_PUEBLO%TYPE,
       SN_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
       SN_num_evento        OUT NOCOPY		  ge_errores_pg.evento);

PROCEDURE GE_consultarDescEstado_PR (
       EN_cod_estado          IN              ge_estados.COD_ESTADO%TYPE,
       SV_descripcion         OUT             ge_estados.DES_ESTADO%TYPE,
       SN_cod_retorno         OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno        OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
       SN_num_evento          OUT NOCOPY		   ge_errores_pg.evento);

PROCEDURE GE_consultarDescTipoDir_PR (
       EN_cod_tipdireccion      IN            ge_tipdireccion.COD_TIPDIRECCION%TYPE,
       SV_descripcion           OUT           ge_tipdireccion.DES_TIPDIRECCION%TYPE,
       SN_cod_retorno           OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		 ge_errores_pg.evento);

PROCEDURE GE_CONS_FACT_CLIE_PR (
                EN_cod_cliente           IN      	        NUMBER,
                EN_num_iteracion         IN               NUMBER,
                EN_num_opcion            IN               NUMBER,
                EV_fecha_desde           IN               VARCHAR2,
                EV_fecha_hasta           IN               VARCHAR2,
	              SC_faturas    		       OUT NOCOPY	  	  refcursor,
                SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento            OUT NOCOPY		    ge_errores_pg.evento);

PROCEDURE GE_CONS_FECH_REP_CON_PR (
       EN_cod_cliente           IN      	       NUMBER,
	     SC_fechas		            OUT NOCOPY	  	 refcursor,
       SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		   ge_errores_pg.evento);

PROCEDURE GE_CONS_TEL_BLOQ_POSP_PR (
       EN_cod_abonado           IN      	       NUMBER,
       SD_fec_suspbd            OUT NOCOPY       ga_susprehabo.fec_suspbd%TYPE,
       SN_num_terminal          OUT NOCOPY       VARCHAR2,
       SD_fec_suspcen           OUT NOCOPY       ga_susprehabo.fec_suspcen%TYPE,
       SN_cod_caususp           OUT NOCOPY       VARCHAR2,
       SV_des_caususp           OUT NOCOPY       VARCHAR2,
       SN_ind_fraude            OUT NOCOPY       NUMBER,
       SV_cod_tipfraude         OUT NOCOPY       VARCHAR2,
       SN_tip_suspencion        OUT NOCOPY       NUMBER,
       SV_des_valor             OUT NOCOPY       VARCHAR2,
       SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		   ge_errores_pg.evento);

PROCEDURE GE_CONS_TEL_BLOQ_PREP_PR (
       EN_cod_abonado           IN      	       NUMBER,
       SD_fec_suspbd            OUT NOCOPY       ga_susprehabo.fec_suspbd%TYPE,
       SN_num_terminal          OUT NOCOPY       VARCHAR2,
       SD_fec_suspcen           OUT NOCOPY       ga_susprehabo.fec_suspcen%TYPE,
       SN_cod_caususp           OUT NOCOPY       VARCHAR2,
       SV_des_caususp           OUT NOCOPY       VARCHAR2,
       SN_ind_fraude            OUT NOCOPY       NUMBER,
       SV_cod_tipfraude         OUT NOCOPY       VARCHAR2,
       SN_tip_suspencion        OUT NOCOPY       NUMBER,
       SV_des_valor             OUT NOCOPY       VARCHAR2,
       SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		   ge_errores_pg.evento);

PROCEDURE GE_VALIDA_FECHA_CICLO_PR (
       EN_cod_ciclfact          IN              NUMBER,
       EV_FEC_INI               IN              VARCHAR2,
       EV_FEC_TERM              IN              VARCHAR2,
       SV_fecha_ini             OUT NOCOPY      VARCHAR2,
       SV_fecha_term            OUT NOCOPY      VARCHAR2,
       SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		  ge_errores_pg.evento);

PROCEDURE ge_cons_abo_clie_telef_pr(EN_numCliente       IN NUMBER,
                                    EN_numCelular       IN NUMBER,
                                    SN_num_abonado      OUT NOCOPY ga_abocel.Num_abonado%TYPE,
                                    SN_cod_cuenta       OUT NOCOPY ga_abocel.Cod_cuenta%TYPE,
                                    SN_cod_uso          OUT NOCOPY ga_abocel.Cod_uso%TYPE,
                                    SV_cod_situacion    OUT NOCOPY ga_abocel.Cod_situacion%TYPE,
                                    SN_cod_vendedor     OUT NOCOPY ga_abocel.Cod_vendedor%TYPE,
                                    SV_tip_plantarif    OUT NOCOPY ga_abocel.Tip_plantarif%TYPE,
                                    SV_tip_terminal     OUT NOCOPY ga_abocel.Tip_terminal%TYPE,
                                    SV_cod_plantarif    OUT NOCOPY ga_abocel.Cod_plantarif%TYPE,
                                    SV_num_serie        OUT NOCOPY ga_abocel.Num_serie%TYPE,
                                    SD_fec_alta         OUT NOCOPY ga_abocel.fec_alta%TYPE,
                                    SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);


 PROCEDURE ge_cons_abo_tel_pr (   EN_numTelefono      IN NUMBER,
                                 SN_num_abonado      OUT NOCOPY   ga_abocel.Num_abonado%TYPE,
                                 SN_cod_cliente      OUT NOCOPY   ga_aboamist.Cod_cliente%TYPE,
                                 SV_tip_abonado      OUT NOCOPY   VARCHAR2,
                                 SV_cod_tecnologia   OUT NOCOPY   ga_abocel.Cod_tecnologia%TYPE,
                                 SV_num_serie        OUT NOCOPY   ga_abocel.num_serie%TYPE,
                                 SV_num_imei         OUT NOCOPY   ga_abocel.num_imei%TYPE,
                                 SV_cod_prestacion   OUT NOCOPY   ga_abocel.Cod_prestacion%TYPE,
                                 SN_cod_cuenta       OUT NOCOPY   ga_abocel.Cod_cuenta%TYPE,
                                 SV_cod_plantarif    OUT NOCOPY   ga_abocel.Cod_plantarif%TYPE,
                                 SV_des_prestacion   OUT NOCOPY   ge_prestaciones_td.des_prestacion%TYPE,
                                 SV_cod_tiplan       OUT NOCOPY   ta_plantarif.Cod_tiplan%TYPE,
                                 SV_cod_planserv     OUT NOCOPY   ga_abocel.cod_planserv%TYPE,
                                 SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                                 SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                                 SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento);


PROCEDURE ge_cons_num_sec_pr(EN_nomSecuencia     IN  VARCHAR2,
                             SN_numSecuencia     OUT NOCOPY   NUMBER,
                             SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                             SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                             SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento);


PROCEDURE ge_cons_datos_cli_cod_pr(EN_codCliente       IN  ge_clientes.cod_cliente%TYPE,
                                   SV_num_ident        OUT NOCOPY   ge_clientes.Num_ident%TYPE,
                                   SV_cod_tipident     OUT NOCOPY   ge_clientes.Cod_Tipident%TYPE,
                                   SN_cod_ciclo        OUT NOCOPY   ge_clientes.Cod_Ciclo%TYPE,
                                   SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                                   SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                                   SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento);

PROCEDURE ge_listar_cli_cuenta_pr(EN_codCuenta        IN  ge_clientes.cod_cuenta%TYPE,
                                  SC_cursor           OUT NOCOPY   refcursor,
                                  SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                                  SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                                  SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento);

PROCEDURE ge_listar_cli_nit_pr(EN_numIdent         IN  VARCHAR2,
                               EN_codTipIdent      IN  VARCHAR2,
                               SC_cursor           OUT NOCOPY   refcursor,
                               SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                               SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                               SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento);

PROCEDURE ge_cons_conc_factura_pr(EN_codCliente   IN NUMBER,
                                  EN_codTipDocum  IN NUMBER,
                                  EN_num_folio    IN NUMBER,
                                  SC_cursor       OUT NOCOPY refcursor,
                                  SN_cod_retorno  OUT NOCOPY   ge_errores_pg.CodError,
                                  SV_mens_retorno OUT NOCOPY   ge_errores_pg.MsgError,
                                  SN_num_evento   OUT NOCOPY   ge_errores_pg.Evento);

PROCEDURE ge_consultar_ss_vigentes_pr(EN_num_abonado      IN  ga_servsuplabo.num_abonado%TYPE,
                                     SC_cursor           OUT NOCOPY   refcursor,
                                     SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                                     SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                                     SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento);

PROCEDURE ge_consultar_ss_inactivos_pr(EN_num_abonado      IN  ga_servsuplabo.num_abonado%TYPE,
                                       SC_cursor           OUT NOCOPY   refcursor,
                                       SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                                       SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                                       SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento);

PROCEDURE ge_obtener_seg_cliente_pr(EN_cod_cliente       IN         ga_abocel.Cod_cliente%TYPE,
                                     SV_cod_segmento     OUT NOCOPY ge_clientes.Cod_segmento%TYPE,
                                     SV_des_segmento     OUT NOCOPY ge_segmentacion_clientes_td.Des_segmento%TYPE,
                                     SV_cod_tipo         OUT NOCOPY ge_clientes.Cod_tipo%TYPE,
                                     SV_des_tipo         OUT NOCOPY ged_codigos.Des_valor%TYPE,
                                     SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);


PROCEDURE ge_obtiene_fecha_corte_pr(EN_codCicloFact     IN  fa_ciclfact.cod_ciclfact%TYPE,
                                    SD_fecDesdellam     OUT NOCOPY fa_ciclfact.fec_desdellam%TYPE,
                                    SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

/* --------------------------------- */
/* CASO DE USO: CU-001 Consultar PUK */
/* --------------------------------- */

PROCEDURE GE_CONSGEDPARAMETRO_PR (EV_nom_parametro    IN         ged_parametros.nom_parametro%TYPE,
                                 EV_cod_modulo       IN         ged_parametros.cod_modulo%TYPE,
                                 EN_cod_producto     IN         ged_parametros.cod_producto%TYPE,
                                 SV_valor_parametro  OUT NOCOPY ged_parametros.val_parametro%TYPE,
                                 SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE GE_CONSPUK_PR (EN_num_celular     IN         ga_abocel.num_celular%TYPE,
                         SV_puk             OUT NOCOPY gsm_det_simcard_to.val_campo%TYPE,
                         SN_cod_error       OUT NOCOPY ge_errores_pg.CodError,
                         SV_mensaje_error   OUT NOCOPY ge_errores_pg.MsgError,
                         SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

/* --------------------------------------------- */
/* CASO DE USO: CU-006 Validar Número Telefónica */
/* --------------------------------------------- */

PROCEDURE GE_VALNUMTELEFONICA_PR (EN_num_celular     IN         ga_abocel.num_celular%TYPE,
                                  EN_cod_operador    IN         ta_numnacional.cod_operador%TYPE,
                                  SN_cod_error       OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mensaje_error   OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

/* ------------------------------------------------ */
/* CASO DE USO: CU-010 Consultar Aviso de Siniestro */
/* ------------------------------------------------ */

PROCEDURE GE_AVISOSIN_PR (EN_num_celular      IN ga_abocel.num_celular%TYPE,
                          EN_cod_estado       IN ga_siniestros.cod_estado%TYPE,
                          SC_cursor          OUT NOCOPY refcursor,
                          SN_cod_error       OUT NOCOPY ge_errores_pg.CodError,
                          SV_mensaje_error   OUT NOCOPY ge_errores_pg.MsgError,
                          SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

/* ----------------------------------------------------------- */
/* CASO DE USO: CU-016 Consultar datos generales de un cliente */
/* ----------------------------------------------------------- */

PROCEDURE GE_CONS_CLIE_POS_PR (     EN_num_celular      IN         ga_abocel.num_celular%TYPE,
                                    SD_fec_sistema      OUT NOCOPY ge_clientes.FEC_NACIMIEN%TYPE,
                                    SN_num_celular      OUT NOCOPY ga_abocel.NUM_CELULAR%TYPE,
                                    SN_cod_cliente      OUT NOCOPY ga_abocel.COD_CLIENTE%TYPE,
                                    SD_fec_alta         OUT NOCOPY ga_abocel.FEC_ALTA%TYPE,
                                    SD_fec_fincontra    OUT NOCOPY ga_abocel.FEC_FINCONTRA%TYPE,
                                    SV_nom_cliente      OUT NOCOPY ge_clientes.NOM_CLIENTE%TYPE,
                                    SV_nom_apeclien1    OUT NOCOPY ge_clientes.NOM_APECLIEN1%TYPE,
                                    SV_nom_apeclien2    OUT NOCOPY ge_clientes.NOM_APECLIEN2%TYPE,
                                    SV_num_ident        OUT NOCOPY ge_clientes.NUM_IDENT%TYPE,
                                    SV_cod_tipident     OUT NOCOPY ge_clientes.COD_TIPIDENT%TYPE,
                                    SV_des_nit          OUT NOCOPY ge_tipident.DES_TIPIDENT%TYPE,
                                    SV_num_ident2       OUT NOCOPY ge_clientes.NUM_IDENT2%TYPE,
                                    SV_cod_tipident2    OUT NOCOPY ge_clientes.COD_TIPIDENT2%TYPE,
                                    SV_num_identapor    OUT NOCOPY ge_clientes.NUM_IDENTAPOR%TYPE,
                                    SV_cod_tipidentapor OUT NOCOPY ge_clientes.COD_TIPIDENTAPOR%TYPE,
                                    SD_fec_nacimien     OUT NOCOPY ge_clientes.FEC_NACIMIEN%TYPE,
                                    SN_cod_profesion    OUT NOCOPY ge_clientes.COD_PROFESION%TYPE,
                                    SV_cod_ocupacion    OUT NOCOPY ge_clientes.COD_OCUPACION%TYPE,
                                    SV_nom_apoderado    OUT NOCOPY ge_clientes.NOM_APODERADO%TYPE,
                                    SV_ind_estcivil     OUT NOCOPY ge_clientes.IND_ESTCIVIL%TYPE,
                                    SV_estado_civil     OUT NOCOPY ged_codigos.DES_VALOR%TYPE,
                                    SV_cod_pais         OUT NOCOPY ge_clientes.COD_PAIS%TYPE,
                                    SV_des_pais         OUT NOCOPY ge_paises.DES_PAIS%TYPE,
                                    SV_cod_tecnologia   OUT NOCOPY ga_abocel.COD_TECNOLOGIA%TYPE,
                                    SV_num_serie        OUT NOCOPY ga_abocel.NUM_SERIE%TYPE,
                                    SV_num_imei         OUT NOCOPY ga_abocel.NUM_IMEI%TYPE,
                                    SV_cod_plantarif    OUT NOCOPY ga_abocel.COD_PLANTARIF%TYPE,
                                    SV_des_plantarif    OUT NOCOPY ta_plantarif.DES_PLANTARIF%TYPE,
                                    SV_cod_tipo         OUT NOCOPY ge_clientes.COD_TIPO%TYPE,
                                    SV_tip_cliente      OUT NOCOPY ged_codigos.DES_VALOR%TYPE,
                                    SV_tef_cliente1     OUT NOCOPY ge_clientes.TEF_CLIENTE1%TYPE,
                                    SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE GE_CONS_CLIE_PRE_PR (     EN_num_celular      IN         ga_abocel.num_celular%TYPE,
                                    SD_fec_sistema      OUT NOCOPY ge_clientes.FEC_NACIMIEN%TYPE,
                                    SN_num_celular      OUT NOCOPY ga_aboamist.NUM_CELULAR%TYPE,
                                    SN_cod_cliente      OUT NOCOPY ga_aboamist.COD_CLIENTE%TYPE,
                                    SV_nom_cliente      OUT NOCOPY ge_clientes.NOM_CLIENTE%TYPE,
                                    SV_nom_apeclien1    OUT NOCOPY ge_clientes.NOM_APECLIEN1%TYPE,
                                    SV_nom_apeclien2    OUT NOCOPY ge_clientes.NOM_APECLIEN2%TYPE,
                                    SV_num_ident        OUT NOCOPY ge_clientes.NUM_IDENT%TYPE,
                                    SV_cod_tipident     OUT NOCOPY ge_clientes.COD_TIPIDENT%TYPE,
                                    SV_des_nit          OUT NOCOPY ge_tipident.DES_TIPIDENT%TYPE,
                                    SV_num_ident2       OUT NOCOPY ge_clientes.NUM_IDENT2%TYPE,
                                    SV_cod_tipident2    OUT NOCOPY ge_clientes.COD_TIPIDENT2%TYPE,
                                    SD_fec_nacimien     OUT NOCOPY ge_clientes.FEC_NACIMIEN%TYPE,
                                    SV_cod_tecnologia   OUT NOCOPY ga_aboamist.COD_TECNOLOGIA%TYPE,
                                    SV_num_serie        OUT NOCOPY ga_aboamist.NUM_SERIE%TYPE,
                                    SV_num_imei         OUT NOCOPY ga_aboamist.NUM_IMEI%TYPE,
                                    SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE GE_CONS_CLIE_COD_PR (     EN_cod_cliente      IN         ge_clientes.COD_CLIENTE%TYPE,
                                    SD_fec_sistema      OUT NOCOPY ge_clientes.FEC_NACIMIEN%TYPE,
                                    SN_cod_cliente      OUT NOCOPY ge_clientes.COD_CLIENTE%TYPE,
                                    SV_nom_cliente      OUT NOCOPY ge_clientes.NOM_CLIENTE%TYPE,
                                    SV_nom_apeclien1    OUT NOCOPY ge_clientes.NOM_APECLIEN1%TYPE,
                                    SV_nom_apeclien2    OUT NOCOPY ge_clientes.NOM_APECLIEN2%TYPE,
                                    SV_num_ident        OUT NOCOPY ge_clientes.NUM_IDENT%TYPE,
                                    SV_cod_tipident     OUT NOCOPY ge_clientes.COD_TIPIDENT%TYPE,
                                    SV_des_nit          OUT NOCOPY ge_tipident.DES_TIPIDENT%TYPE,
                                    SV_num_ident2       OUT NOCOPY ge_clientes.NUM_IDENT2%TYPE,
                                    SV_cod_tipident2    OUT NOCOPY ge_clientes.COD_TIPIDENT2%TYPE,
                                    SV_num_identapor    OUT NOCOPY ge_clientes.NUM_IDENTAPOR%TYPE,
                                    SV_cod_tipidentapor OUT NOCOPY ge_clientes.COD_TIPIDENTAPOR%TYPE,
                                    SD_fec_nacimien     OUT NOCOPY ge_clientes.FEC_NACIMIEN%TYPE,
                                    SN_cod_profesion    OUT NOCOPY ge_clientes.COD_PROFESION%TYPE,
                                    SV_cod_ocupacion    OUT NOCOPY ge_clientes.COD_OCUPACION%TYPE,
                                    SV_nom_apoderado    OUT NOCOPY ge_clientes.NOM_APODERADO%TYPE,
                                    SV_ind_estcivil     OUT NOCOPY ge_clientes.IND_ESTCIVIL%TYPE,
                                    SV_estado_civil     OUT NOCOPY ged_codigos.DES_VALOR%TYPE,
                                    SV_cod_pais         OUT NOCOPY ge_clientes.COD_PAIS%TYPE,
                                    SV_des_pais         OUT NOCOPY ge_paises.DES_PAIS%TYPE,
                                    SV_cod_tipo         OUT NOCOPY ge_clientes.COD_TIPO%TYPE,
                                    SV_tip_cliente      OUT NOCOPY ged_codigos.DES_VALOR%TYPE,
                                    SV_tef_cliente1     OUT NOCOPY ge_clientes.TEF_CLIENTE1%TYPE,
                                    SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE GE_CONS_EQUIPO_PR (EV_num_serie        IN         ga_equipaboser.NUM_SERIE%TYPE,
                             EV_num_abonado      IN         ga_equipaboser.NUM_ABONADO%TYPE,
                             SV_des_equipo       OUT NOCOPY ga_equipaboser.DES_EQUIPO%TYPE,
                             SV_cod_articulo     OUT NOCOPY ga_equipaboser.COD_ARTICULO%TYPE,
                             SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                             SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                             SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE GE_CONS_PROFESION_PR (EN_cod_prof        IN         ge_actividades.COD_ACTIVIDAD%TYPE,
                                SV_des_actividad   OUT        ge_actividades.DES_ACTIVIDAD%TYPE,
                                SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE GE_CONS_OCUPACION_PR (EV_cod_ocup         IN         ge_ocupaciones.COD_OCUPACION%TYPE,
                                SV_des_ocupacion    OUT NOCOPY ge_ocupaciones.DES_OCUPACION%TYPE,
                                SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE GE_CONS_TIPOS_IDENT_PR (EV_cod_tipident    IN         ge_tipident.COD_TIPIDENT%TYPE,
                                  SV_des_tipident    OUT NOCOPY ge_tipident.des_tipident%TYPE,
                                  SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

/* --------------------------------------------------------- */
/* CASO DE USO: CU-024 Consultar Facturas Pendientes de Pago */
/* --------------------------------------------------------- */
/* NOTA: Este caso de uso llama a otros PL ----------------- */

/* --------------------------------------------- */
/* CASO DE USO: CU-029 Consultar tipo de cliente */
/* --------------------------------------------- */

PROCEDURE GE_CONS_TIPO_CLIENTE_PR ( EN_cod_cliente     IN         ge_clientes.COD_CLIENTE%TYPE,
                                    SN_cod_cliente     OUT NOCOPY ge_clientes.COD_CLIENTE%TYPE,
                                    SV_cod_tipo        OUT NOCOPY ge_clientes.COD_TIPO%TYPE,
                                    SV_tip_cliente     OUT NOCOPY ged_codigos.des_valor%TYPE,
                                    SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

/* ---------------------------------------------- */
/* CASO DE USO: CU-041 Consultar tipo de servicio */
/* ---------------------------------------------- */

PROCEDURE GE_CONSTIPSERV_PR (   EV_cod_prestacion   IN         ga_abocel.COD_PRESTACION%TYPE,
                                SV_des_prestacion   OUT NOCOPY ge_prestaciones_td.DES_PRESTACION%TYPE,
                                SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);


PROCEDURE GE_CONS_PAGOS_REALIZADO_PR (
       EN_cod_cliente           IN              NUMBER,
       SC_pagosRealizados       OUT NOCOPY	  	refcursor,
       SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		  ge_errores_pg.evento);

PROCEDURE GE_CONS_RECAUDADORA_PAGO_PR (
       EV_pref_plaza            IN             VARCHAR2,
       EN_cod_cliente           IN             NUMBER,
       EN_num_compago           IN             NUMBER,
       SV_recaudadora           OUT NOCOPY     VARCHAR2,
       SV_des_empresa           OUT NOCOPY     VARCHAR2,
       SN_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		 ge_errores_pg.evento);

PROCEDURE GE_CONS_BANCO_PR (
       EV_cod_banco             IN             VARCHAR2,
       SV_cod_banco             OUT NOCOPY     VARCHAR2,
       SV_des_banco             OUT NOCOPY     VARCHAR2,
       SN_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		 ge_errores_pg.evento);

PROCEDURE GE_CONS_OFICINA_PR (
       EN_num_compago           IN             NUMBER,
       EV_pref_plaza            IN             VARCHAR2,
       SV_cod_oficina           OUT NOCOPY     VARCHAR2,
       SV_des_oficina           OUT NOCOPY     VARCHAR2,
       SN_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		 ge_errores_pg.evento);

PROCEDURE GE_CONS_DISTRIBUIDOR_PR (
       EN_cod_distribuidor      IN             NUMBER,
       SN_cod_cliente           OUT NOCOPY     NUMBER,
       SN_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		 ge_errores_pg.evento);

PROCEDURE GE_CONS_SEGURO_PR (
       EN_cod_abonado             IN             NUMBER,
       SV_cod_seguro              OUT NOCOPY     VARCHAR2,
       SV_des_segur               OUT NOCOPY     VARCHAR2,
       SN_num_eventos             OUT NOCOPY     NUMBER,
       SD_importe_equipo          OUT NOCOPY     ga_seguroabonado_to.importe_equipo%TYPE,
       SN_fec_alta                OUT NOCOPY     DATE,
       SN_fec_fincontrato         OUT NOCOPY     DATE,
       SN_num_maxev               OUT NOCOPY     NUMBER,
       SN_tip_cobert              OUT NOCOPY     NUMBER,
       SV_des_valor               OUT NOCOPY     VARCHAR2,
       SD_deducible               OUT NOCOPY     ga_tiposeguro_td.deducible%TYPE,
       SD_imp_segur	              OUT NOCOPY     ga_tiposeguro_td.imp_segur%TYPE,
       SN_cod_retorno             OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno            OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
       SN_num_evento              OUT NOCOPY		 ge_errores_pg.evento);

PROCEDURE GE_CONS_ABO_PROD_PR ( EV_num_serie        IN         ga_abocel.num_serie%TYPE,
                                SV_tip_producto     OUT NOCOPY al_componente_kit.NUM_KIT%TYPE,
                                SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);


PROCEDURE ge_obtener_datos_distrib_pr (
        EN_cod_distribuidor IN  ve_vendedores.cod_vendedor%TYPE,
        SV_nom_vendedor     OUT NOCOPY ve_vendedores.nom_vendedor%TYPE,
        SV_cod_tipident     OUT NOCOPY ve_vendedores.cod_tipident%TYPE,
        SV_des_tipident     OUT NOCOPY ge_tipident.des_tipident%TYPE,
        SV_num_ident        OUT NOCOPY ve_vendedores.num_ident%TYPE,
        SN_cod_cliente      OUT NOCOPY ve_vendedores.cod_cliente%TYPE,
        SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE ge_obtener_bodegas_distrib_pr (
        EN_cod_distribuidor IN  ve_vendedores.cod_vendedor%TYPE,
        SC_cursor           OUT NOCOPY  refcursor,
        SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE ge_obtener_pedido_distrib_pr (
        EN_cod_cliente_distrib  IN  npt_pedido.cod_cliente%TYPE,
        EN_cod_pedido           IN  npt_pedido.cod_pedido%TYPE,
        SN_mto_neto_pedido      OUT NOCOPY npt_pedido.mto_neto_pedido%TYPE,
        SN_can_total_pedido     OUT NOCOPY npt_pedido.can_total_pedido%TYPE,
        SN_mto_total_pedido     OUT NOCOPY npt_pedido.mto_tot_pedido%TYPE,
        SN_cod_bodega           OUT NOCOPY npt_pedido.cod_bodega%TYPE,
        SV_des_bodega           OUT NOCOPY al_bodegas.des_bodega%TYPE,
        SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE ge_obtener_saldo_moroso_pr(
        EN_cod_cliente    IN co_morosos.cod_cliente%TYPE,
        SV_sSaldoVenc    OUT NOCOPY   NUMBER,
        SV_sSaldoNoVenc  OUT NOCOPY   NUMBER,
        SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
        SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
        SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento);

PROCEDURE ge_val_pospago_hib_pr(
        EN_numCelular       IN          ga_abocel.num_celular%TYPE,
        EN_tipo_abonado     IN          ged_codigos.des_valor%TYPE,
        SN_num_abonado      OUT NOCOPY  ga_abocel.num_abonado%TYPE,
        SN_cod_cliente      OUT NOCOPY  ga_abocel.cod_cliente%TYPE,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento);

PROCEDURE ge_update_cliente_pr(
        EN_cod_cliente      IN          ge_clientes.cod_cliente%TYPE,
        EV_num_tarjeta      IN          ge_clientes.num_tarjeta%TYPE,
        EV_ind_debito       IN          ge_clientes.ind_debito%TYPE,
        EV_cod_tiptarjeta   IN          ge_clientes.cod_tiptarjeta%TYPE,
        ED_fec_venc_tarj    IN          VARCHAR2,
        EV_cod_banco_tarj   IN          ge_clientes.cod_bancotarj%TYPE,
        EV_nom_titular_tarj IN          ge_clientes.nom_titulartarjeta%TYPE,
        EV_obs_pac          IN          ge_clientes.obs_pac%TYPE,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento);

 PROCEDURE GE_CONS_SERV_SUPLEMENTARIOS_PR (
        EN_num_abonado    IN              ga_abocel.num_abonado%TYPE,
        EV_cod_plantarif  IN              ga_abocel.Cod_plantarif%TYPE,
        EV_cod_planserv   IN              ga_abocel.cod_planserv%TYPE,
        EN_tip_servicio   IN              NUMBER,
        SC_servsupl		  OUT               refcursor,
        SN_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
        SV_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
        SN_num_evento     OUT NOCOPY      ge_errores_pg.evento);



-------------------------------------------------------------------------------------------------------
PROCEDURE GE_CONS_COD_CLASCLIE( EV_cod_cliente      IN         ge_clientes.cod_cliente%TYPE,
                                SV_cod_tipo         OUT NOCOPY ge_clientes.cod_tipo%TYPE,
                                SV_cod_segmento     OUT NOCOPY ge_clientes.cod_segmento%TYPE,
                                SV_cod_color        OUT NOCOPY ge_clientes.cod_color%TYPE,
                                SV_cod_calificacion OUT NOCOPY ge_clientes.cod_calificacion%TYPE,
                                SV_cod_categoria    OUT NOCOPY ge_clientes.cod_categoria%TYPE,
                                SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
-------------------------------------------------------------------------------------------------------
PROCEDURE GE_CONS_COD_SEGM(     EV_cod_segmento     IN ge_clientes.cod_segmento%TYPE,
                                EV_cod_tipo         IN ge_clientes.cod_tipo%TYPE,
                                SV_des_segmento     OUT NOCOPY ge_segmentacion_clientes_td.des_segmento%TYPE,
                                SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
-------------------------------------------------------------------------------------------------------
PROCEDURE GE_CONS_COLOR  (      EV_cod_color        IN ge_clientes.cod_color%TYPE,
                                SV_des_color        OUT NOCOPY ge_color_td .des_color%TYPE,
                                SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
-------------------------------------------------------------------------------------------------------
PROCEDURE GE_CONS_CALIFCLIE  (  EV_cod_calificacion IN ge_clientes.cod_calificacion%TYPE,
                                SV_des_calificacion OUT NOCOPY ge_calificacion_td.des_calificacion%TYPE,
                                SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
-------------------------------------------------------------------------------------------------------
PROCEDURE GE_CONS_CATEGCLIE  (  EV_cod_categoria    IN ge_clientes.cod_categoria%TYPE,
                                SV_des_categoria    OUT NOCOPY ge_categorias.des_categoria%TYPE,
                                SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
-------------------------------------------------------------------------------------------------------
PROCEDURE GE_CONS_BOLSA_PLANTARIF_PR(
           EV_cod_plan       IN  tol_bolsa_plan_td.cod_plan%TYPE,
           SV_cod_bolsa      OUT tol_bolsa_plan_td.cod_bolsa%TYPE,
           SV_ind_unidad     OUT tol_bolsa_td.ind_unidad%TYPE,
           SN_cnt_bolsa      OUT tol_bolsa_td.cnt_bolsa%TYPE,
           SD_fec_ini_vig    OUT tol_bolsa_plan_td.fec_ini_vig%TYPE,
           SD_fec_ter_vig    OUT tol_bolsa_plan_td.fec_ter_vig%TYPE,
           SV_des_unidad     OUT sch_codigos.gls_param%TYPE,
           SN_codRetorno     OUT NOCOPY ge_errores_pg.CodError,
           SV_menRetorno     OUT NOCOPY ge_errores_pg.MsgError,
           SN_numEvento      OUT NOCOPY ge_errores_pg.Evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE GE_CONS_ULT_OOSS_EJEC_PR(
           EV_cod_os         IN  ci_tiporserv.cod_os%TYPE,
           EN_num_abonado    IN  ga_abocel.num_abonado%TYPE,
           SN_num_os         OUT ci_orserv.num_os%TYPE,
           SD_fecha_os       OUT ci_orserv.fecha%TYPE,
           SN_codRetorno     OUT NOCOPY ge_errores_pg.CodError,
           SV_menRetorno     OUT NOCOPY ge_errores_pg.MsgError,
           SN_numEvento      OUT NOCOPY ge_errores_pg.Evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE GE_CONS_RENOVACION_PR(
           EV_cod_os         IN  ci_tiporserv.cod_os%TYPE,
           EN_num_os         IN  ci_orserv.num_os%TYPE,
           SN_ind_renova     OUT NUMBER,
           SN_codRetorno     OUT NOCOPY ge_errores_pg.CodError,
           SV_menRetorno     OUT NOCOPY ge_errores_pg.MsgError,
           SN_numEvento      OUT NOCOPY ge_errores_pg.Evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE GE_CONS_CAU_CAM_EQ_PR(
           EN_num_abonado    IN  ga_abocel.num_abonado%TYPE,
           SV_cod_caucaser   OUT ga_caucaser.cod_caucaser%TYPE,
           SV_des_caucaser   OUT ga_caucaser.des_caucaser%TYPE,
           SN_codRetorno     OUT NOCOPY ge_errores_pg.CodError,
           SV_menRetorno     OUT NOCOPY ge_errores_pg.MsgError,
           SN_numEvento      OUT NOCOPY ge_errores_pg.Evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE GE_insPagoAutomatico_PR(EN_codcliente   IN  co_unipac.cod_cliente%TYPE,
                                  EV_codbanco     IN  co_unipac.cod_banco%TYPE,
                                  EN_numtelefono  IN  co_unipac.num_telefono%TYPE,
                                  EV_codzona      IN  co_unipac.cod_zona%TYPE,
                                  EV_codcentral   IN  co_unipac.cod_central%TYPE,
                                  EN_codbcoi      IN  co_unipac.cod_bcoi%TYPE,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                  SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
-------------------------------------------------------------------------------------------------------
END GE_INTEGRACION_PG;
/
SHOW ERRORS