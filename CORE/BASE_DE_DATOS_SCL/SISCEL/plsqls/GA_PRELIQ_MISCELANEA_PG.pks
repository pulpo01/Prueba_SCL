CREATE OR REPLACE PACKAGE        GA_PRELIQ_MISCELANEA_PG IS
  /*
  <Documentaci�n TipoDoc = "GA_PRELIQ_MISCELANEA_PG
  <Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="16-06-2005" Versi�n="1.0.0" Dise�ador="Lidia Ponce" Programador="Roberto P�rez" Ambiente="BD">
  <Retorno>NA</Retorno>
  <Descripci�n> Encabezado de GA_PRELIQ_MISCELANEA_PG /Descripci�n>
  <Par�metros>
  <Entrada>
  <param nom="" Tipo="STRING">Descripci�n Parametro1</param>
  </Entrada>
  <Salida>
  <param nom="" Tipo="STRING">Descripci�n Parametro4</param>
  </Salida>
  </Par�metros>
  </Elemento>
  </Documentaci�n>
  */

  --Incidencia RA-200601030480 [PAAA 06-01-2006] versi�n 1.1

   TYPE vCursor IS REF CURSOR;

  --Incidencia XO-200511291016 [Desarrollo 29-12-2005]
   CN_cod_proceso CONSTANT NUMBER:= 980;
  --Fin XO-200511291016

 --Incidencia RA-200601030480 [PAAA 06-01-2006]
   --CN_estado_ok	  CONSTANT NUMBER:= 1;
   --CN_estado_nok  CONSTANT NUMBER:= 3;
   CN_estado_ini CONSTANT NUMBER:= 1;
   CN_estado_nok CONSTANT NUMBER:= 2;
   CN_estado_ok  CONSTANT NUMBER:= 3;
  --Fin RA-200601030480

   FUNCTION GA_RETORNA_VERSION_FN RETURN VARCHAR2;

   PROCEDURE GA_PRELIQ_MISCELANEA_PR(SN_coderror OUT NOCOPY NUMBER
   			                        ,SV_error OUT NOCOPY VARCHAR2);

   FUNCTION GA_ACTUALIZA_TRAZA_FN(EN_cod_proceso  IN fa_trazaproc.cod_proceso%TYPE
   								 ,EN_cod_estaproc IN fa_trazaproc.cod_estaproc%TYPE
   								 ,SN_coderror OUT NOCOPY NUMBER
		                         ,SV_error 	  OUT NOCOPY VARCHAR2) RETURN BOOLEAN;
END GA_PRELIQ_MISCELANEA_PG;
/
SHOW ERRORS
