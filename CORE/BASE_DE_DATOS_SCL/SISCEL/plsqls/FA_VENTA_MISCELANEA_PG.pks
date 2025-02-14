CREATE OR REPLACE PACKAGE FA_VENTA_MISCELANEA_PG IS

  /*
  <Documentación TipoDoc = "FA_VENTA_MISCELANEA_PG
  <Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="16-06-2005" Versión="1.0.0" Diseñador="Lidia Ponce" Programador="Roberto Pérez" Ambiente="BD">
  <Retorno>NA</Retorno>
  <Descripción> Encabezado de FA_VENTA_MISCELANEA_PG /Descripción>
  <Parámetros>
  <Entrada>
  <param nom="" Tipo="STRING">Descripción Parametro1</param>
  </Entrada>
  <Salida>
  <param nom="" Tipo="STRING">Descripción Parametro4</param>
  </Salida>
  </Parámetros>
  </Elemento>
  </Documentación>
  */

   TYPE vCursor IS REF CURSOR;


FUNCTION FA_RETORNA_VERSION_FN RETURN VARCHAR2;

FUNCTION FA_PREFACTURA_PR(EV_cursor   	    IN vCursor
   			 			  ,EN_cod_dealer	IN NUMBER
						  ,EN_num_proceso   IN NUMBER
						  ,EN_cod_producto  IN NUMBER
 						  ,EV_cod_moneda	IN fa_prefactura.cod_moneda%TYPE
						  ,EV_cod_region	IN ge_oficinas.cod_region%TYPE
						  ,EV_cod_provincia IN ge_oficinas.cod_provincia%TYPE
						  ,EV_cod_ciudad	IN ge_direcciones.cod_ciudad%TYPE
						  ,EV_cod_comuna    IN ge_oficinas.cod_comuna%TYPE
						  ,EV_cod_modulo	IN fa_prefactura.cod_modulo%TYPE
   			 			  ,SN_coderror     OUT NOCOPY NUMBER
   			              ,SV_error 	   OUT NOCOPY VARCHAR2) RETURN NUMBER;

PROCEDURE  FA_PROCESOS_PR (EN_num_proceso   IN NUMBER
   			 			 ,EN_cod_dealer	   IN NUMBER
						 ,EN_cod_tipdocum  IN fa_procesos.cod_tipdocum%TYPE
						 ,EN_cod_centremi  IN fa_procesos.cod_centremi%TYPE
						 ,EN_letraag	   IN fa_procesos.letraag%TYPE
   			 			 ,SN_coderror  	  OUT NOCOPY NUMBER
   			             ,SV_error 	   	  OUT NOCOPY VARCHAR2);

PROCEDURE FA_INTERFACT_PR   (EN_num_proceso       IN fa_interfact.num_proceso%TYPE
							,EN_num_venta         IN fa_interfact.num_venta%TYPE
							,EV_cod_modgener      IN fa_interfact.cod_modgener%TYPE
							,EN_cod_estadoc       IN fa_interfact.cod_estadoc%TYPE
							,EN_cod_estproc       IN fa_interfact.cod_estproc%TYPE
							,EN_cod_tipmovimien   IN fa_interfact.cod_tipmovimien%TYPE
							,EC_cod_catribut      IN fa_interfact.cod_catribut%TYPE
							,EV_cod_tipdocum      IN fa_interfact.cod_tipdocum%TYPE
							,ED_fec_vencimiento   IN fa_interfact.fec_vencimiento%TYPE
							,EV_pref_plaza        IN fa_interfact.pref_plaza%TYPE
							,EV_pref_plazarel     IN fa_interfact.pref_plazarel%TYPE
							,EV_tip_foliacion     IN fa_interfact.tip_foliacion%TYPE
   			 			    ,SN_coderror  	  	 OUT NOCOPY NUMBER
   			                ,SV_error 	   	  	 OUT NOCOPY VARCHAR2);


END FA_VENTA_MISCELANEA_PG;
/
SHOW ERRORS
