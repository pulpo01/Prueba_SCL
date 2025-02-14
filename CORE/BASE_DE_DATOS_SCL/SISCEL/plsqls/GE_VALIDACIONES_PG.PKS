CREATE OR REPLACE PACKAGE GE_VALIDACIONES_PG
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "GE_VALIDACIONES_PG"
    Lenguaje="PL/SQL"
    Fecha="26-04-2005"
    Versión="1.0"
    Diseñador=""Fernando Garcia E."
    Programador="Jubitza Villanueva G."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package que agrupa validaciones generales ECU-050050</Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS
  CV_version	        	CONSTANT  VARCHAR2(10):='1.0';
  CV_error_no_clasif 	    CONSTANT  VARCHAR2(30):='Error no clasificado';
  CV_cod_modulo			    CONSTANT   ged_parametros.cod_modulo%TYPE:='GA';
  CV_actuacion			    CONSTANT   PV_ACTUAC_RESTRICCION.cod_actuacion%TYPE:='GG';
  CN_largoquery				CONSTANT   NUMBER:=3000;
  CN_largoerrtec			CONSTANT   NUMBER:=500;
  CN_largodesc				CONSTANT   NUMBER:=1000;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Inicio modificacion by SAQL/Soporte 11/11/2005 - RA-200511010012
FUNCTION GE_VALIDA_SITUACION_CELULAR_FN (
   EN_num_celular  in ga_aboamist.num_celular%type,
   SN_cod_retorno  OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento   OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-- Fin modificacion by SAQL/Soporte 11/11/2005 - RA-200511010012
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_num_celular_fn  (
   EN_num_celular     IN   		   ga_abocel.num_celular%TYPE,
   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_ciclo_fn (
   EN_num_celular   IN           ga_abocel.num_celular%TYPE,
   EN_cod_cliente   IN           ga_abocel.cod_cliente%TYPE,
   EN_num_abonado   IN           ga_abocel.num_abonado%TYPE,
   EN_cod_ciclo     IN           ga_abocel.cod_ciclo%TYPE,
   SN_cod_ciclfact  OUT NOCOPY   fa_ciclfact.cod_ciclfact%TYPE,
   SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_situacion_abo_fn (
   EN_num_celular    IN           ga_abocel.num_celular%TYPE,
   EV_cod_situacion  IN           ga_abocel.cod_situacion%TYPE,
   SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_obtiene_gedparametros_fn (
   EV_nom_parametro  IN           ged_parametros.nom_parametro%TYPE,
   EV_nom_modulo     IN           ged_parametros.cod_modulo%TYPE,
   EN_cod_producto   IN           ged_parametros.cod_producto%TYPE,
   SV_val_parametro  OUT NOCOPY   ged_parametros.val_parametro%TYPE,
   SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_desbloqueo_fn (
   EN_num_celular   IN           ga_abocel.num_celular%TYPE,
   SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_existe_cliente_fn (
   EN_cod_cliente   IN           ge_clientes.cod_cliente%TYPE,
   SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_cons_ss_mensajeria_fn (
   EN_num_abonado   IN           ga_abocel.num_abonado%TYPE,
   EV_cod_servicio  IN           ga_servsuplabo.cod_servicio%TYPE,
   SN_cod_servsupl  OUT NOCOPY   ga_servsuplabo.cod_servsupl%TYPE,
   SN_cod_nivel     OUT NOCOPY   ga_servsuplabo.cod_nivel%TYPE,
   SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_recupera_tiporserv_fn (
   EV_cod_os 		  IN           ci_tiporserv.cod_os%TYPE,
   SV_descripcion 	  OUT NOCOPY   ci_tiporserv.descripcion%TYPE,
   SV_cod_tipmodi 	  OUT NOCOPY   ci_tiporserv.cod_tipmodi%TYPE,
   SV_grupo 	   	  OUT NOCOPY   ci_tiporserv.grupo%TYPE,
   SV_nom_exe 	   	  OUT NOCOPY   ci_tiporserv.nom_exe%TYPE,
   SV_menu    	   	  OUT NOCOPY   ci_tiporserv.menu%TYPE,
   SV_cod_aplic   	  OUT NOCOPY   ci_tiporserv.cod_aplic%TYPE,
   SN_tip_ooss        OUT NOCOPY   ci_tiporserv.tip_ooss%TYPE,
   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_registra_ooss_fn(EN_cod_os         IN  ci_orserv.cod_os%TYPE,
                             EV_producto       IN  ci_orserv.producto%TYPE,
                             EN_tip_inter      IN  ci_orserv.tip_inter%TYPE,
                             EN_cod_inter      IN  ci_orserv.cod_inter%TYPE,
                             EV_usuario        IN  ci_orserv.usuario%TYPE,
                             EV_comentario     IN  ci_orserv.comentario%TYPE,
                             EN_num_cargo      IN  ci_orserv.num_cargo%TYPE,
                             EV_cod_modulo     IN  ci_orserv.cod_modulo%TYPE,
                             EN_id_gestor      IN  ci_orserv.id_gestor%TYPE,
                             EN_num_movimiento IN  ci_orserv.num_movimiento%TYPE,
                             EN_cod_estado     IN  ci_orserv.cod_estado%TYPE,
	   	  		  			 SN_numooss        OUT NOCOPY ci_orserv.num_os%TYPE,
							 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
   							 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
   							 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
							) RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_regprovciucom_fn (
   EV_cod_region     IN           ge_regiones.cod_region%TYPE,
   EV_cod_provincia  IN           ge_provincias.cod_provincia%TYPE,
   EV_cod_ciudad     IN           ge_ciudades.cod_ciudad%TYPE,
   EV_cod_comuna     IN           ge_comunas.cod_comuna%TYPE,
   SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_region_fn (
   EV_cod_region     IN           ge_regiones.cod_region%TYPE,
   SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_provincia_fn (
   EV_cod_provincia  IN           ge_provincias.cod_provincia%TYPE,
   SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_comuna_fn (
   EV_cod_comuna    IN          ge_comunas.cod_comuna%TYPE,
   SN_cod_retorno   OUT NOCOPY  ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY  ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY  ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_ciudad_fn (
   EV_cod_ciudad    IN           ge_ciudades.cod_ciudad%TYPE,
   SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_ident_cuenta_fn (
   EV_cod_tipident     IN  		   ge_clientes.cod_tipident%TYPE,
   EV_num_ident        IN  		   ge_clientes.num_ident%TYPE,
   SN_cod_cuenta	  OUT NOCOPY   GA_CUENTAS.cod_cuenta%TYPE,
   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_obtiene_ciclofact_fn (EN_cod_ciclo     IN         ga_abocel.cod_ciclo%TYPE,
		 					      SN_cod_ciclfact  OUT NOCOPY fa_ciclfact.cod_ciclfact%TYPE,
							      SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
   							      SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
   							      SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_obtiene_codcen_fn (
   EN_num_abonado     IN           ga_abocel.num_abonado%TYPE,
   SN_cod_central	  OUT NOCOPY   ga_abocel.cod_central%TYPE,
   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_tipdir_fn (
   EV_cod_tipdir      IN  ge_tipdireccion.cod_tipdireccion%TYPE,
   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_icc_pend_celular_fn (
   EN_num_celular    IN           ga_abocel.num_celular%TYPE,
   SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_existe_usuamist_fn (
   EN_num_abonado    IN           ga_abocel.num_abonado%TYPE,
   SN_cod_usuario    OUT NOCOPY   ga_usuamist.cod_usuario%TYPE,
   SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END GE_VALIDACIONES_PG;
/
SHOW ERRORS
