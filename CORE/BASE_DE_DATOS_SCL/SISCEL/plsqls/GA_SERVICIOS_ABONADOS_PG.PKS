CREATE OR REPLACE PACKAGE GA_SERVICIOS_ABONADOS_PG
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "GA_SERVICIOS_ABONADOS_PG"
    Lenguaje="PL/SQL"
    Fecha="26-04-2005"
    Versión="1.0"
    Diseñador=""Fernando Garcia E."
    Programador="Jubitza Villanueva G."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package que agrupa un conjunto de servicios para la capa de negocio ECU-050050</Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS
 SUBTYPE codvalor 	      IS ged_codigos.cod_valor%TYPE;
 SUBTYPE desvalor 	      IS ged_codigos.des_valor%TYPE;
 TYPE refcursor 		  IS REF CURSOR;
 TYPE TA_numos            IS TABLE OF CI_ORSERV.NUM_OS%TYPE  INDEX BY BINARY_INTEGER;
 CV_version	           	  CONSTANT   VARCHAR2(10):='1.0';
 CV_error_no_clasif       CONSTANT   VARCHAR2(30):='Error no clasificado';
 CV_postpago              CONSTANT   VARCHAR2(10):='POSTPAGO';
 CV_prepago               CONSTANT   VARCHAR2(10):='PREPAGO';
 CV_param_grupo_tdma      CONSTANT   ged_parametros.nom_parametro%TYPE:='GRUPO_TEC_DMA';
 CV_param_grupo_gsm       CONSTANT   ged_parametros.nom_parametro%TYPE:='GRUPO_TEC_GSM';
 CV_comentario            CONSTANT   ged_parametros.nom_parametro%TYPE:='COM_OOSS';
 CV_cod_modulo			  CONSTANT   ged_parametros.cod_modulo%TYPE:='GA';
 CV_cod_modulo_pv		  CONSTANT   ged_parametros.cod_modulo%TYPE:='PV';
 CV_actuacion			  CONSTANT   PV_ACTUAC_RESTRICCION.cod_actuacion%TYPE:='GG';
 CV_cod_producto_post	  CONSTANT   ged_parametros.cod_producto%TYPE:=1;
 CV_cod_os_10105		  CONSTANT   ci_tiporserv.cod_os%TYPE:='10105';
 CV_cod_os_10003		  CONSTANT   ci_tiporserv.cod_os%TYPE:='10003';
 CV_cod_os_10009		  CONSTANT   ci_tiporserv.cod_os%TYPE:='10009';
 CV_cod_serv1			  CONSTANT   ga_servsuplabo.cod_servicio%TYPE:='110';
 CV_cod_serv2		  	  CONSTANT   ga_servsuplabo.cod_servicio%TYPE:='74';
 CV_cod_serv3		  	  CONSTANT   ga_servsuplabo.cod_servicio%TYPE:='126';
 CV_ERROR				  CONSTANT   VARCHAR2(10):='ERROR';
 CV_cod_actabo			  CONSTANT   GA_ACTABO.COD_ACTABO%TYPE:='CP';
 CV_CICLO_AMI			  CONSTANT   ged_parametros.nom_parametro%TYPE:='COD_AMI_CICLO';
 CV_causa_desbloqueo      CONSTANT   ged_parametros.nom_parametro%TYPE:='CAUSA_DESBLOQUEO';
 CV_param_len_pin         CONSTANT   ged_parametros.nom_parametro%TYPE:='LARGO_CLAVE_WEB';
 CV_param_valida_np       CONSTANT   ged_parametros.nom_parametro%TYPE:='VALIDA_NP';
 CV_si_ejecuta            CONSTANT   VARCHAR2(2):='SI';
 CN_largoquery			  CONSTANT   NUMBER:=3000;
 CN_largoerrtec			  CONSTANT   NUMBER:=500;
 CN_largodesc			  CONSTANT   NUMBER:=1000;
 CV_ind_estado			  CONSTANT	 ga_usuamist.ind_estado%TYPE:='C';
 CV_comentario_10003	  CONSTANT   ci_orserv.comentario%TYPE:='Desbloqueo por Registro de Datos';
 CV_comentario_10009	  CONSTANT   ci_orserv.comentario%TYPE:='Modificación Datos generales Clientes';
 CV_tip_inter      		  CONSTANT	 ci_orserv.tip_inter%TYPE:=1;
 CV_num_cargo			  CONSTANT	 ci_orserv.num_cargo%TYPE:=0;
 CV_tip_cuenta			  CONSTANT	 ga_cuentas.tip_cuenta%TYPE:='P';
 -- Inicio modificacion by SAQL/Soporte 29/09/2005 - XO-200509290760
 -- CV_cod_catribut		  CONSTANT   ga_cuentas.cod_catribut%TYPE:='B';
 -- Fin modificacion by SAQL/Soporte 29/09/2005 - XO-200509290760
 CV_param_cliente         CONSTANT   ged_parametros.nom_parametro%TYPE:='CLIENTE_PREPAGO';
 CV_param_actabo_np		  CONSTANT   ged_parametros.nom_parametro%TYPE:='ACTABO_PLAN_ARTI';
 CV_MODULO_GE             CONSTANT   GE_MODULOS.COD_MODULO%TYPE:='GE';
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MODIFICA_DIRECCION_PR (EN_num_celular       IN     ga_abocel.num_celular%TYPE,
                                     EV_cod_region       IN     ge_direcciones.cod_region%TYPE,
                                     EV_cod_provincia    IN     ge_direcciones.cod_provincia%TYPE,
                                     EV_cod_ciudad       IN     ge_direcciones.cod_ciudad%TYPE,
                                     EV_cod_comuna       IN     ge_direcciones.cod_comuna%TYPE,
                                     EV_nom_calle        IN     ge_direcciones.nom_calle%TYPE,
                                     EV_num_calle        IN     ge_direcciones.num_calle%TYPE,
                                     EV_num_piso         IN     ge_direcciones.num_piso%TYPE,
                                     EV_cod_postal       IN     ge_direcciones.zip%TYPE,
                                     EV_observacion      IN     ge_direcciones.obs_direccion%TYPE,
                                     EV_desdir1          IN     ge_direcciones.des_direc1%TYPE,
                                     EV_desdir2          IN     ge_direcciones.des_direc2%TYPE,
                                     EV_cod_tipdireccion IN     ge_tipdireccion.cod_tipdireccion%TYPE,
									 SN_numos		     OUT NOCOPY   ci_orserv.num_os%TYPE,
							         SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                                     SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                                     SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento
                                     );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONS_CLAVE_WEB_PR (EN_num_celular   IN          ga_abocel.num_celular%TYPE,
                                SV_clave         OUT NOCOPY  ga_abocel.cod_password%TYPE,
							    SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
                                SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
                                SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_VALIDA_CLAVE_WEB_PR (EN_num_celular   IN           ga_abocel.num_celular%TYPE,
                                  EV_clave         IN           ga_abocel.cod_password%TYPE,
                                  SN_validacion    OUT NOCOPY   NUMBER,
							      SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
                                  SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
                                  SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MODIFICA_ABONADO_PR (EV_clave         IN     ga_abocel.cod_password%TYPE,
								  EN_num_abonado   IN     ga_abocel.num_abonado%TYPE,
								  EV_cod_tipmodi   IN     ga_modabocel.cod_tipmodi%TYPE,
								  EV_tip_terminal  IN     ga_abocel.tip_terminal%TYPE,
   								  EV_serie         IN     ga_abocel.num_serie%TYPE,
								  EV_numseriehex   IN     ga_abocel.num_seriehex%TYPE,
								  EV_seriemec      IN 	  ga_abocel.num_seriemec%TYPE,
		  						  EV_tipo_abonado  IN     VARCHAR2,
							 	  SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
                              	  SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
                              	  SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MODIFICA_CLAVE_WEB_PR (EN_num_celular IN          ga_abocel.num_celular%TYPE,
		  						  EV_clave_p       IN          ga_abocel.cod_password%TYPE,
								  SN_numos         OUT NOCOPY  ci_orserv.num_os%TYPE,
							  	  SN_cod_retorno   OUT NOCOPY  ge_errores_pg.CodError,
                              	  SV_mens_retorno  OUT NOCOPY  ge_errores_pg.MsgError,
                              	  SN_num_evento    OUT NOCOPY  ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DEFAULT_CLAVE_WEB_PR (EN_num_celular  IN     ga_abocel.num_celular%TYPE,
							  	  SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
                              	  SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
                              	  SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONS_DATOS_ABO_PR   (EN_num_celular   IN          ga_abocel.num_celular%TYPE,
								  SN_num_abonado   OUT NOCOPY  ga_abocel.num_abonado%TYPE,
 								  SV_tip_plantarif OUT NOCOPY  ga_abocel.tip_plantarif%TYPE,
								  SN_cod_categoria OUT NOCOPY  ge_clientes.cod_categoria%TYPE,
								  SV_tip_terminal  OUT NOCOPY  ga_abocel.tip_terminal%TYPE,
 								  SV_cod_plantarif OUT NOCOPY  ga_abocel.cod_plantarif%TYPE,
 								  SV_cod_valor     OUT NOCOPY  ge_valores_cli.cod_valor%TYPE,
 								  SV_des_valor     OUT NOCOPY  ge_valores_cli.des_valor%TYPE,
								  SV_cod_tiplan    OUT NOCOPY  ged_codigos.cod_valor%TYPE,
								  SV_des_tiplan    OUT NOCOPY  ged_codigos.des_valor%TYPE,
							 	  SN_cod_retorno   OUT NOCOPY  ge_errores_pg.CodError,
                             	  SV_mens_retorno  OUT NOCOPY  ge_errores_pg.MsgError,
                              	  SN_num_evento    OUT NOCOPY  ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONS_DAT_TERMINAL_ABO_PR (EN_num_celular IN          ga_abocel.num_celular%TYPE,
								  SV_num_min          OUT NOCOPY  ga_abocel.num_min%TYPE,
								  SV_esn 			  OUT NOCOPY  ga_abocel.num_serie%TYPE,
								  SV_imsi             OUT NOCOPY  ga_abocel.num_imei%TYPE,
								  SV_des_tipident     OUT NOCOPY  ge_tipident.des_tipident%TYPE,
								  SV_num_ident        OUT NOCOPY  ge_clientes.num_ident%TYPE,
 								  SV_cod_tipident     OUT NOCOPY  ge_clientes.cod_tipident%TYPE,
							 	  SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
                              	  SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
                              	  SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_ACTIVA_PREPAGO_PR (EN_num_celular      IN       ga_abocel.num_celular%TYPE,
                                 EV_cod_provincia   IN       ge_direcciones.cod_provincia%TYPE,
 		  						 EV_cod_region      IN       ge_direcciones.cod_region%TYPE,
                                 EV_cod_ciudad      IN       ge_direcciones.cod_ciudad%TYPE,
                                 EV_cod_comuna      IN       ge_direcciones.cod_comuna%TYPE,
                                 EV_nom_calle       IN       ge_direcciones.nom_calle%TYPE,
                                 EV_num_calle       IN       ge_direcciones.num_calle%TYPE,
                                 EV_num_piso        IN       ge_direcciones.num_piso%TYPE,
                                 EV_num_casilla     IN       ge_direcciones.num_casilla%TYPE,
                                 EV_obs_direccion   IN       ge_direcciones.obs_direccion%TYPE,
                                 EV_des_direc1      IN       ge_direcciones.des_direc1%TYPE,
                                 EV_des_direc2      IN       ge_direcciones.des_direc2%TYPE,
                                 EV_cod_pueblo      IN       ge_direcciones.cod_pueblo%TYPE,
                                 EV_cod_estado      IN       ge_direcciones.cod_estado%TYPE,
 								 EV_cod_tipident    IN       ge_clientes.cod_tipident%TYPE,
								 EV_num_ident       IN OUT   ge_clientes.num_ident%TYPE,
								 EV_nom_cliente     IN       ge_clientes.nom_cliente%TYPE,
								 EV_nom_apeclien1   IN       ge_clientes.nom_apeclien1%TYPE,
								 EV_nom_apeclien2   IN       ge_clientes.nom_apeclien2%TYPE,
								 SC_numos		    OUT NOCOPY   REFCURSOR,
							  	 SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                              	 SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                              	 SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_ASOCIA_CLI_PR (EN_cod_cliente     IN         ge_clientes.cod_cliente%TYPE,
		  				    EN_ant_cod_cliente IN         ge_clientes.cod_cliente%TYPE,
							EN_num_abonado     IN         ga_abocel.num_abonado%TYPE,
							EN_cod_usuario     IN 	      ga_abocel.cod_usuario%TYPE,
							EN_cod_cuenta      IN         ge_clientes.cod_cuenta%TYPE,
							SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                            SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                            SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
                            );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END GA_SERVICIOS_ABONADOS_PG;
/
SHOW ERRORS