CREATE OR REPLACE PACKAGE FA_CONCEPTOS_SP_PG
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "FA_CONCEPTOS_SP_PG"
          Lenguaje="PL/SQL"
          Fecha="30-07-2007"
          Versión="1.0"
          Diseñador=""
          Programador="rao"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción></Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
</Elemento>
</Documentación>
*/
IS
	TYPE refCursor IS REF CURSOR;

	TYPE TipRegconceptos IS RECORD (
          COD_CONCEPTO     NUMBER(9)	,
		  COD_PRODUCTO     NUMBER(1)	,
		  DES_CONCEPTO     VARCHAR2(60)	,
		  COD_TIPCONCE     NUMBER(2)	,
		  COD_MODULO       VARCHAR2(2)	,
		  IND_ACTIVO       NUMBER(1)  	,
		  COD_MONEDA       VARCHAR2(3)	,
		  COD_CONCORIG     NUMBER(9)	,
		  COD_TIPDESCU     VARCHAR2(1)	,
		  NOM_USUARIO      VARCHAR2(30)	,
		  FEC_ULTMOD       DATE			,
		  COD_PRODSERVTFN  NUMBER(8)	,
		  IND_RECURRENTE   NUMBER(1)	,
		  COD_SUBCONCEPTO  VARCHAR2(2)	,
		  IND_TECNOLOGIA   NUMBER(1)  	,
		  DEF_TECNOLOGIA   VARCHAR2(7)	,
		  COD_GRPCONCEPTO  NUMBER(4)  	);

   	cv_error_no_clasif      VARCHAR2 (50) := 'No es posible clasificar el error';
   	cv_cod_modulo           VARCHAR2 (2)  := 'FA';
   	cv_version              VARCHAR2 (2)  := '1';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE FA_SEL_FA_CONCEPTOS_PR ( EO_Fa_Conceptos	 IN OUT NOCOPY TipRegconceptos,
									  SO_Lista_Conceptos OUT NOCOPY	 refCursor,
	   			 					  SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                                  SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                                  SN_Num_evento      OUT NOCOPY ge_errores_pg.evento);

END FA_CONCEPTOS_SP_PG;
/
SHOW ERRORS
