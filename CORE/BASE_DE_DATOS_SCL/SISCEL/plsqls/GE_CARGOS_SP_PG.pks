CREATE OR REPLACE PACKAGE GE_CARGOS_SP_PG
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "GE_CARGOS_SP_PG"
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


   	cv_error_no_clasif      VARCHAR2 (50) := 'No es posible clasificar el error';
   	cv_cod_modulo           VARCHAR2 (2)  := 'FA';
   	cv_version              VARCHAR2 (2)  := '1';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GE_CARGOS_I_PR (	REGISTRO 		IN GE_CARGOS_QT,
		                 	SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
		                 	SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
		                 	SN_num_evento   OUT NOCOPY ge_errores_pg.evento);


PROCEDURE GE_CARGOS_U_PR (REGISTRO 		 IN GE_CARGOS_QT,
	                     SN_Cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                     SV_Mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                     SN_Num_evento   OUT NOCOPY ge_errores_pg.evento);


PROCEDURE GE_CARGOS_S_PR (REGISTRO 	  IN OUT NOCOPY GE_CARGOS_QT,
						 SR_Row_Id		 OUT NOCOPY ROWID,
	 					 SN_Cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                     SV_Mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                     SN_num_evento   OUT NOCOPY ge_errores_pg.evento);

PROCEDURE GE_CARGOS_D_PR(REGISTRO	    IN GE_CARGOS_QT,
				  		SN_Cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	              		SV_Mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	              		SN_Num_evento   OUT NOCOPY ge_errores_pg.evento);

END GE_CARGOS_SP_PG;
/
SHOW ERRORS
