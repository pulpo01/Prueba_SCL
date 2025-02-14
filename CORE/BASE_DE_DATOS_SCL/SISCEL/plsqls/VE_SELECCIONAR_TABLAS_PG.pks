CREATE OR REPLACE PACKAGE VE_SELECCIONAR_TABLAS_PG
/*
<Documentaci�n TipoDoc = "Package">
   <Elemento Nombre = "FA_CONCEPTOS_SP_PG"
          Lenguaje="PL/SQL"
          Fecha="30-07-2007"
          Versi�n="1.0"
          Dise�ador=""
          Programador="rao"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripci�n></Descripci�n>
      <Par�metros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Par�metros>
</Elemento>
</Documentaci�n>
*/
IS
	TYPE refCursor IS REF CURSOR;
	cv_error_no_clasif      VARCHAR2 (50) := 'No es posible clasificar el error';
   	cv_cod_modulo           VARCHAR2 (2)  := 'FA';
   	cv_version              VARCHAR2 (2)  := '1';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE VE_SEL_VE_VENDEALER_PR ( SO_Lista_Conceptos OUT NOCOPY	 refCursor,
	   			 					  SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                                  SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                                  SN_Num_evento      OUT NOCOPY ge_errores_pg.evento);

   PROCEDURE VE_SEL_GE_MONEDAS_PR ( SO_Lista_Conceptos OUT NOCOPY	 refCursor,
	   			 					  SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                                  SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                                  SN_Num_evento      OUT NOCOPY ge_errores_pg.evento);



END VE_SELECCIONAR_TABLAS_PG;
/
SHOW ERRORS
