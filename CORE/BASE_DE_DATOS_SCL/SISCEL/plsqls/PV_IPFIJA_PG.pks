CREATE OR REPLACE PACKAGE PV_IPFIJA_PG

IS

GV_des_error 	          ge_errores_pg.DesEvent;
GV_sSql        	   		  ge_errores_pg.vQuery;
GV_version         		  CONSTANT VARCHAR2(5)  := '1.0';

CN_err_no_data_found      NUMBER(1)    := 1;
CN_err_param_entrada      NUMBER(2) 	:= 98;
CN_err_ejecutar_servicio  NUMBER(3) 	:= 302;
CN_err_serv_no_encontrado NUMBER(3) 	:= 403;
CN_err_no_encuentra_apn   NUMBER(6) 	:= 200008;
CN_err_peticion_ip		  NUMBER(6) 	:= 200609;
CN_err_cambio_estado	  NUMBER(6) 	:= 200610;

CN_alta_bd				  CONSTANT NUMBER(1) 	:= 1;
CN_alta_centrales		  CONSTANT NUMBER(1) 	:= 2;
CN_baja_bd				  CONSTANT NUMBER(1) 	:= 3;
CN_baja_centrales		  CONSTANT NUMBER(1) 	:= 4;
CN_baja_abonado			  CONSTANT NUMBER(1) 	:= 5;
CN_ip_fija				  CONSTANT NUMBER(1)	:= 1;

CN_largoerrtec	   		  CONSTANT NUMBER(3)	:= 500;
CN_largodesc       		  CONSTANT NUMBER(3)	:= 100;
CV_null			   		  CONSTANT VARCHAR2(4)  := NULL;
CV_error_no_clasif 		  CONSTANT VARCHAR2(30) := 'Error no clasificado';

CV_cod_modulo	   		  CONSTANT VARCHAR2(2)  := 'GA';
CN_cod_producto	   		  CONSTANT NUMBER(1)    := 1;

GN_octeto_1 	   		  aip_ip_to.octeto_1%TYPE;
GN_octeto_2		   		  aip_ip_to.octeto_2%TYPE;
GN_octeto_3		   		  aip_ip_to.octeto_3%TYPE;
GN_octeto_4		   		  aip_ip_to.octeto_4%TYPE;
CV_CODACT_FAC        CONSTANT VARCHAR2(2)  := 'FA';
CV_TIPSERVICIO_1     CONSTANT VARCHAR2(1)  := '1';
CV_TIPSERVICIO_2     CONSTANT VARCHAR2(1)  := '2';

----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_consultar_apn_pr
		  (
		  EV_cod_servicio   IN  ga_servsupl.cod_servicio%TYPE,
      	  SN_cod_apn        OUT NOCOPY aip_apn_to.cod_apn%TYPE,
	  	  SV_cod_tecnologia OUT NOCOPY aip_apn_to.cod_tecnologia%TYPE,
	  	  SN_cod_qos        OUT NOCOPY aip_qos_to.cod_qos%TYPE,
	  	  SN_cod_qos_id     OUT NOCOPY aip_qos_to.eqosid%TYPE,
   		  SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
   		  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
   		  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
		  );
----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_solicitar_ip_pr
		  (
		  EV_cod_tecnologia IN  al_tecnologia.cod_tecnologia%TYPE,
		  EN_cod_apn	    IN  pv_ipservsuplabo_to.cod_apn%TYPE,
		  EV_TipoIp         IN  GA_SERVSUPL.IND_IP%TYPE,
          EN_cod_qos         IN aip_apn_to.cod_qos%TYPE,
          SV_num_ip			OUT NOCOPY pv_ipservsuplabo_to.num_ip%TYPE,
   		  SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
   		  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
   		  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
		  );
----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cambiar_estado_ip_pr
		  (
		  EV_num_ip		   IN  pv_ipservsuplabo_to.num_ip%TYPE,
		  EV_num_celular   IN  VARCHAR2,
		  EV_nom_parametro IN  ged_parametros.nom_parametro%TYPE,
   		  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
   		  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
   		  SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
		  );
----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_modifica_ip_hib_pr
		  (EV_num_celular   IN  VARCHAR2,
           EN_num_abonado   IN  pv_ipservsuplabo_to.num_abonado%TYPE,
		   EV_cod_servicio  IN  pv_ipservsuplabo_to.cod_servicio%TYPE,
		   EV_fec_altabd	IN  pv_ipservsuplabo_to.fec_altabd%TYPE,
		   EN_cod_ss		IN  pv_ipservsuplabo_to.cod_servsupl%TYPE,
		   EN_cod_nivel	    IN  pv_ipservsuplabo_to.cod_nivel%TYPE,
   		   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
   		   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
   		   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
		  );
----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_generar_datos_ip_pr
		  (
		  EN_num_abonado   IN  pv_ipservsuplabo_to.num_abonado%TYPE,
		  EN_num_celular   IN  ga_abocel.num_celular%TYPE,
		  EN_cod_producto  IN  ga_servsupl.cod_producto%TYPE,
		  EV_cod_servicio  IN  ga_servsupl.cod_servicio%TYPE,
		  EV_fec_altabd	   IN  pv_ipservsuplabo_to.fec_altabd%TYPE,
		  EN_cod_ss		   IN  pv_ipservsuplabo_to.cod_servsupl%TYPE,
		  EN_cod_nivel	   IN  pv_ipservsuplabo_to.cod_nivel%TYPE,
		  EV_accion		   IN  VARCHAR2,
		  EN_estado_old	   IN  ga_servsuplabo.ind_estado%TYPE,
		  EN_estado_new	   IN  ga_servsuplabo.ind_estado%TYPE,
   		  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
   		  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
   		  SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
		  );
----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_activar_ip_ss_pr
          (
		  EN_num_abonado   IN  pv_ipservsuplabo_to.num_abonado%TYPE,
          EN_num_celular   IN  ga_abocel.num_celular%TYPE
		  );
----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_activar_ipPA_ss_pr
          (
		  EN_num_abonado           IN  pv_ipservsuplabo_to.num_abonado%TYPE,
		  EV_cod_prod_ofertado     IN  PR_PRODUCTOS_CONTRATADOS_TO.COD_PROD_OFERTADO%TYPE
          );
---------------------------------------------------------------------------------------------------------------
PROCEDURE pv_Desactivar_ipPA_ss_pr
          (
		  EN_num_abonado           IN  pv_ipservsuplabo_to.num_abonado%TYPE,
          EV_cod_prod_ofertado     IN  PR_PRODUCTOS_CONTRATADOS_TO.COD_PROD_OFERTADO%TYPE
          );

END;
/
SHOW ERROR