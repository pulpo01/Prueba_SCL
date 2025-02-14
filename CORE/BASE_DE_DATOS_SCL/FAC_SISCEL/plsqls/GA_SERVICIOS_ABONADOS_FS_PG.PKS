CREATE OR REPLACE PACKAGE GA_SERVICIOS_ABONADOS_FS_PG
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "GA_CRM_FS_PG"
    Lenguaje="PL/SQL"
    Fecha="26-04-2005"
    Versión="1.0"
    Diseñador=""Fernando Garcia E."
    Programador="Jubitza Villanueva G."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package que agrupa un conjunto de servicios para la mascara ECU-050050</Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS
  CV_version	        	CONSTANT  VARCHAR2(10):='1.0';
  CV_error_no_clasif        CONSTANT  VARCHAR2(30):='Error no clasificado';
  TYPE refcursor            IS REF CURSOR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_VALIDA_CLAVE_WEB_FS_PR (EN_num_celular   IN          ga_abocel.num_celular%TYPE,
                                    EV_clave          IN          ga_abocel.cod_password%TYPE,
                                    SN_validacion     OUT NOCOPY  NUMBER,
								    SN_cod_retorno    OUT NOCOPY  ge_errores_pg.CodError,
								    SV_mens_retorno   OUT NOCOPY  ge_errores_pg.MsgError
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MODIFICA_CLAVE_WEB_FS_PR (EN_num_celular IN          ga_abocel.num_celular%TYPE,
		  						  EV_clave            IN          ga_abocel.cod_password%TYPE,
								  SN_numos            OUT NOCOPY  ci_orserv.num_os%TYPE,
								  SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
								  SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError
								  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DEFAULT_CLAVE_WEB_FS_PR (EN_num_celular    IN          ga_abocel.num_celular%TYPE,
								     SN_cod_retorno     OUT NOCOPY  ge_errores_pg.CodError,
									 SV_mens_retorno    OUT NOCOPY  ge_errores_pg.MsgError
								  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MODIFICA_DIRECCION_FS_PR (EN_num_celular    IN  ga_abocel.num_celular%TYPE,
                                     EV_cod_region       IN  ge_direcciones.cod_region%TYPE,
                                     EV_cod_provincia    IN  ge_direcciones.cod_provincia%TYPE,
                                     EV_cod_ciudad       IN  ge_direcciones.cod_ciudad%TYPE,
                                     EV_cod_comuna       IN  ge_direcciones.cod_comuna%TYPE,
                                     EV_nom_calle        IN  ge_direcciones.nom_calle%TYPE,
                                     EV_num_calle        IN  ge_direcciones.num_calle%TYPE,
                                     EV_num_piso         IN  ge_direcciones.num_piso%TYPE,
                                     EV_cod_postal       IN  ge_direcciones.zip%TYPE,
                                     EV_observacion      IN  ge_direcciones.obs_direccion%TYPE,
                                     EV_desdir1          IN  ge_direcciones.des_direc1%TYPE,
                                     EV_desdir2          IN  ge_direcciones.des_direc2%TYPE,
                                     EV_cod_tipdireccion IN  ge_tipdireccion.cod_tipdireccion%TYPE,
 									 SN_numos		     OUT NOCOPY   ci_orserv.num_os%TYPE,
								     SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
									 SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError
                                     );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONS_DATOS_ABO_FS_PR (EN_num_celular  IN          ga_abocel.num_celular%TYPE,
								  SN_num_abonado   OUT NOCOPY  ga_abocel.num_abonado%TYPE,
 								  SV_tip_plantarif OUT NOCOPY  ga_abocel.tip_plantarif%TYPE,
								  SN_cod_categoria OUT NOCOPY  ge_clientes.cod_categoria%TYPE,
								  SV_tip_terminal  OUT NOCOPY  ga_abocel.tip_terminal%TYPE,
 								  SV_cod_plantarif OUT NOCOPY  ga_abocel.cod_plantarif%TYPE,
 								  SV_cod_valor     OUT NOCOPY  ge_valores_cli.cod_valor%TYPE,
 								  SV_des_valor     OUT NOCOPY  ge_valores_cli.des_valor%TYPE,
								  SV_cod_tiplan    OUT NOCOPY  ga_servicios_abonados_pg.codvalor,
								  SV_des_tiplan    OUT NOCOPY  ga_servicios_abonados_pg.desvalor,
								  SN_cod_retorno   OUT NOCOPY  ge_errores_pg.CodError,
								  SV_mens_retorno  OUT NOCOPY  ge_errores_pg.MsgError
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION GA_VALIDA_SITUACION_ABO_FS_FN (EN_num_celular  IN         ga_abocel.num_celular%TYPE,
   		 						  EV_cod_situacion      IN         ga_abocel.cod_situacion%TYPE,
								  SN_cod_retorno        OUT NOCOPY ge_errores_pg.CodError,
								  SV_mens_retorno       OUT NOCOPY ge_errores_pg.MsgError
								  ) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONS_DAT_TERMINAL_ABO_FS_PR (EN_num_celular IN          ga_abocel.num_celular%TYPE,
								  SV_num_min             OUT NOCOPY  ga_abocel.num_min%TYPE,
								  SV_esn 			  	 OUT NOCOPY  ga_abocel.num_serie%TYPE,
								  SV_imsi             	 OUT NOCOPY  ga_abocel.num_imei%TYPE,
								  SV_des_tipident     	 OUT NOCOPY  ge_tipident.des_tipident%TYPE,
								  SV_num_ident        	 OUT NOCOPY  ge_clientes.num_ident%TYPE,
 								  SV_cod_tipident     	 OUT NOCOPY  ge_clientes.cod_tipident%TYPE,
								  SN_cod_retorno         OUT NOCOPY  ge_errores_pg.CodError,
								  SV_mens_retorno        OUT NOCOPY  ge_errores_pg.MsgError
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_ACTIVA_PREPAGO_FS_PR (EN_num_celular  IN    ga_abocel.num_celular%TYPE,
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
								 EV_num_ident      IN OUT    ge_clientes.num_ident%TYPE,
								 EV_nom_cliente    IN    ge_clientes.nom_cliente%TYPE,
								 EV_nom_apeclien1  IN    ge_clientes.nom_apeclien1%TYPE,
								 EV_nom_apeclien2  IN    ge_clientes.nom_apeclien2%TYPE,
								 SC_numos		   OUT NOCOPY refcursor,
								 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
								 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END GA_SERVICIOS_ABONADOS_FS_PG;
/
SHOW ERRORS