CREATE OR REPLACE PACKAGE FA_BALANCE_CLI_PG
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "FA_BALANCE_CLI_PG"
    Lenguaje="PL/SQL"
    Fecha="02-05-2005"
    Versión="1.0"
    Diseñador=""Fernando Garcia E."
    Programador="Jubitza Villanueva G."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package Capa de negocio Consulta de Balance de una cuenta</Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS
  CV_version	        	CONSTANT  VARCHAR2(10):='1.0';
  CV_error_no_clasif       	CONSTANT  VARCHAR2(30):='Error no clasificado';
  CV_separador          	CONSTANT  VARCHAR2(1):='|';
  TYPE refcursor 			IS REF CURSOR;
  CV_cod_modulo			    CONSTANT   ged_parametros.cod_modulo%TYPE:='GA';
  CV_actuacion			    CONSTANT   PV_ACTUAC_RESTRICCION.cod_actuacion%TYPE:='GG';
  CN_largoquery				CONSTANT   NUMBER:=3000;
  CN_largoerrtec			CONSTANT   NUMBER:=500;
  CN_largodesc				CONSTANT   NUMBER:=1000;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 PROCEDURE FA_BALANCE_CLI_PR     (EN_num_celular    IN   ga_abocel.num_celular%TYPE,
	                              SN_folio      	 OUT NOCOPY   NUMBER,
								  SN_saldo   		 OUT NOCOPY   NUMBER,
	                              SC_cargos_nuevos	 OUT NOCOPY   refcursor,
								  SV_fec_emision     OUT NOCOPY   VARCHAR2,
								  SV_fec_vcto		 OUT NOCOPY   VARCHAR2,
								  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                  SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                  SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END FA_BALANCE_CLI_PG;
/
SHOW ERRORS
