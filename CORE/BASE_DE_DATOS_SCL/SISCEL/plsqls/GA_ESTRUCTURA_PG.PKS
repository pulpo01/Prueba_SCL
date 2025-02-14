CREATE OR REPLACE PACKAGE GA_ESTRUCTURA_PG
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "GA_ESTRUCTURA_PG"
    Lenguaje="PL/SQL"
    Fecha="28-04-2005"
    Versión="1.0"
    Diseñador=""Fernando Garcia E."
    Programador="Jubitza Villanueva G."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package para la creacion de la estructura de abonados de prepago</Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS
 CV_version	        	  CONSTANT  VARCHAR2(10):='1.0';
 CV_error_no_clasif       CONSTANT  VARCHAR2(30):='Error no clasificado';
 CV_postpago              CONSTANT  VARCHAR2(10):='POSTPAGO';
 CV_prepago               CONSTANT  VARCHAR2(10):='PREPAGO';
 CV_cod_modulo			  CONSTANT  ged_parametros.cod_modulo%TYPE:='GA';
 CV_cod_producto_post	  CONSTANT  ged_parametros.cod_producto%TYPE:=1;
 CV_cod_os				  CONSTANT  ci_tiporserv.cod_os%TYPE:=10105;
 CN_largoquery			  CONSTANT  NUMBER:=3000;
 CN_largoerrtec			  CONSTANT  NUMBER:=500;
 CN_largodesc			  CONSTANT  NUMBER:=1000;
 CV_fec_limite			  CONSTANT  VARCHAR2(10):=NULL;
 CV_fec_limite_cat		  CONSTANT  VARCHAR2(10):='01-01-3000';
 CV_ind_estado			  CONSTANT	ga_usuamist.ind_estado%TYPE:='C';
 CV_nom_tabla	          CONSTANT  ged_codigos.nom_tabla%TYPE:='GA_DIRECCION_OBLIGATORIA_TO';
 CV_nom_columna        	  CONSTANT  ged_codigos.nom_columna%TYPE:='TIP_DIRECCION';
 CV_modulo        	      CONSTANT  ged_codigos.cod_modulo%TYPE:='GE';
 CV_cod_abc				  CONSTANT  ged_parametros.nom_parametro%TYPE:='COD_ABC';
 CV_cod_123				  CONSTANT  ged_parametros.nom_parametro%TYPE:='COD_123';
 CV_cod_calclien 		  CONSTANT  ged_parametros.nom_parametro%TYPE:='COD_CALCLIEN';
 CV_agente_desbloqueo	  CONSTANT  ged_parametros.nom_parametro%TYPE:='AGENTE_DESBLOQUEO';
 CV_cod_plancom			  CONSTANT  ged_parametros.nom_parametro%TYPE:='PLAN_COMERCIAL';
 CV_ind_acepta_vta		  CONSTANT  ged_parametros.nom_parametro%TYPE:='ACEPTA_VTA_DESBLOQ';
 CV_formato_fecha		  CONSTANT  ged_parametros.nom_parametro%TYPE:='FORMATO_SEL2';
 CV_cod_pais			  CONSTANT  ged_parametros.nom_parametro%TYPE:='COD_PAIS';
 CV_param_usuario         CONSTANT   ged_parametros.nom_parametro%TYPE:='USUARIO_SERV_PL_SQL';
 CV_param_cliente         CONSTANT   ged_parametros.nom_parametro%TYPE:='CLIENTE_PREPAGO';
 TYPE refcursor 		  IS REF CURSOR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CREA_CUENTA_PR(EN_cod_cuenta                 IN GA_CUENTAS.COD_CUENTA%TYPE,
		  					EV_cod_tipident			      IN GE_CLIENTES.COD_TIPIDENT%TYPE,
 		  					EV_num_ident				  IN GE_CLIENTES.NUM_IDENT%TYPE,
   							EV_nom_cliente 			      IN GE_CLIENTES.NOM_CLIENTE%TYPE,
   							EV_nom_apeclien1			  IN GE_CLIENTES.NOM_APECLIEN1%TYPE,
   							EV_nom_apeclien2			  IN GE_CLIENTES.NOM_APECLIEN2%TYPE,
							EV_cod_provincia 			  IN GE_DIRECCIONES.COD_PROVINCIA%TYPE,
							EV_cod_region 				  IN GE_DIRECCIONES.COD_REGION%TYPE,
							EV_cod_ciudad				  IN GE_DIRECCIONES.COD_CIUDAD%TYPE,
                            EV_cod_comuna     IN    ge_direcciones.cod_comuna%TYPE,
                            EV_nom_calle      IN    ge_direcciones.nom_calle%TYPE,
                            EV_num_calle      IN    ge_direcciones.num_calle%TYPE,
                            EV_num_piso       IN    ge_direcciones.num_piso%TYPE,
                            EV_num_casilla    IN    ge_direcciones.num_casilla%TYPE,
   						    EV_tip_cuenta	   IN	 ga_cuentas.tip_cuenta%TYPE,
  						    EV_cod_catribut   IN	 ga_cuentas.cod_catribut%TYPE,
							SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                            SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                            SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
						   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CREA_USUAMIST_PR(EN_cod_usuario    IN GA_USUARIOS.COD_USUARIO%TYPE,
			    			 EN_num_abonado     IN GA_ABOAMIST.NUM_ABONADO%TYPE,
	   						 EV_cod_tipident	IN GE_CLIENTES.COD_TIPIDENT%TYPE,
 		  					 EV_num_ident		IN GE_CLIENTES.NUM_IDENT%TYPE,
   							 EV_nom_cliente 	IN GE_CLIENTES.NOM_CLIENTE%TYPE,
   							 EV_nom_apeclien1	IN GE_CLIENTES.NOM_APECLIEN1%TYPE,
   							 EV_nom_apeclien2	IN GE_CLIENTES.NOM_APECLIEN2%TYPE,
							 EV_ind_estado		IN VARCHAR2,
 							 SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                             SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                             SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
						   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MOD_USUAMIST_PR(EN_cod_usuario     IN GA_USUARIOS.COD_USUARIO%TYPE,
	   						 EV_cod_tipident	IN GE_CLIENTES.COD_TIPIDENT%TYPE,
 		  					 EV_num_ident		IN GE_CLIENTES.NUM_IDENT%TYPE,
   							 EV_nom_cliente 	IN GE_CLIENTES.NOM_CLIENTE%TYPE,
   							 EV_nom_apeclien1	IN GE_CLIENTES.NOM_APECLIEN1%TYPE,
   							 EV_nom_apeclien2	IN GE_CLIENTES.NOM_APECLIEN2%TYPE,
							 EV_ind_estado		IN VARCHAR2,
 							 SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                             SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                             SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
						   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CREA_CLIENTE_PR (EN_cod_cliente IN ge_clientes.cod_cliente%TYPE,
 			   				  EN_cod_cuenta                 IN GA_CUENTAS.COD_CUENTA%TYPE,
	   						  EV_cod_tipident			      IN GE_CLIENTES.COD_TIPIDENT%TYPE,
 		  					  EV_num_ident				  IN GE_CLIENTES.NUM_IDENT%TYPE,
							  EV_nom_cliente    IN    ge_clientes.nom_cliente%TYPE,
							  EV_nom_apeclien1  IN    ge_clientes.nom_apeclien1%TYPE,
							  EV_nom_apeclien2  IN    ge_clientes.nom_apeclien2%TYPE,
                              EV_cod_provincia  IN    ge_direcciones.cod_provincia%TYPE,
				 			  EV_cod_region     IN    ge_direcciones.cod_region%TYPE,
                              EV_cod_ciudad     IN    ge_direcciones.cod_ciudad%TYPE,
                              EV_cod_comuna     IN    ge_direcciones.cod_comuna%TYPE,
                              EV_nom_calle      IN    ge_direcciones.nom_calle%TYPE,
                              EV_num_calle      IN    ge_direcciones.num_calle%TYPE,
                              EV_num_piso       IN    ge_direcciones.num_piso%TYPE,
                              EV_num_casilla    IN    ge_direcciones.num_casilla%TYPE,
							  EN_cod_categoria  IN    ge_clientes.cod_categoria%TYPE,
				 			  EV_cod_catribut   IN	 ga_cuentas.cod_catribut%TYPE,
				 			  EN_cod_ciclo	   IN    ga_abocel.cod_ciclo%TYPE,
				 			  EV_nom_usuario	   IN GE_CLIENTES.NOM_USUARORA%TYPE,
							  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                              SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                              SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                              );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CREA_ESTRUCTURA_ABONADO_PR (EN_num_abonado IN ga_abocel.num_abonado%TYPE,
                                 EV_cod_provincia  IN    ge_direcciones.cod_provincia%TYPE,
 		  						 EV_cod_region     IN    ge_direcciones.cod_region%TYPE,
                                 EV_cod_ciudad     IN    ge_direcciones.cod_ciudad%TYPE,
                                 EV_cod_comuna     IN    ge_direcciones.cod_comuna%TYPE,
                                 EV_nom_calle      IN    ge_direcciones.nom_calle%TYPE,
                                 EV_num_calle      IN    ge_direcciones.num_calle%TYPE,
                                 EV_num_piso       IN    ge_direcciones.num_piso%TYPE,
                                 EV_num_casilla    IN    ge_direcciones.num_casilla%TYPE,
                                 EV_obs_direccion  IN    ge_direcciones.obs_direccion%TYPE,
                                 EV_des_direc1     IN    ge_direcciones.des_direc1%TYPE,
                                 EV_des_direc2     IN    ge_direcciones.des_direc2%TYPE,
                                 EV_cod_pueblo     IN    ge_direcciones.cod_pueblo%TYPE,
                                 EV_cod_estado     IN    ge_direcciones.cod_estado%TYPE,
 								 EV_cod_tipident   IN    ge_clientes.cod_tipident%TYPE,
								 EV_num_ident      IN    ge_clientes.num_ident%TYPE,
								 EV_nom_cliente    IN    ge_clientes.nom_cliente%TYPE,
								 EV_nom_apeclien1  IN    ge_clientes.nom_apeclien1%TYPE,
								 EV_nom_apeclien2  IN    ge_clientes.nom_apeclien2%TYPE,
								 EN_cod_categoria  IN    ge_clientes.cod_categoria%TYPE,
								 EV_tip_cuenta	   IN	 ga_cuentas.tip_cuenta%TYPE,
								 EN_cod_ciclo	   IN    ga_abocel.cod_ciclo%TYPE,
								 EV_cod_catribut   IN	 ga_cuentas.cod_catribut%TYPE,
		  				         EN_ant_cod_cliente IN   ge_clientes.cod_cliente%TYPE,
							     SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                 SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                 SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                );

END GA_ESTRUCTURA_PG;
/
SHOW ERRORS
