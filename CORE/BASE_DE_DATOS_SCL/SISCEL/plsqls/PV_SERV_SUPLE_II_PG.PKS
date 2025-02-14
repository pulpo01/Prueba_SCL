CREATE OR REPLACE PACKAGE PV_SERV_SUPLE_II_PG
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "PV_SERVICIO_SUPLEMENTARIO_II_PG"
    Lenguaje="PL/SQL"
    Fecha="29-04-2005"
    Versión="1.0"
    Diseñador=""Fernando Garcia E."
    Programador="Jubitza Villanueva G."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package Capa de servicio activacion-desactivacion de SS</Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS
  -- CV_version	        	CONSTANT   VARCHAR2(10):='1.0'; -- COL 77556|06-02-2009|SAQL
  CV_version	        	CONSTANT   VARCHAR2(10):='1.1'; -- COL 77556|06-02-2009|SAQL
  CV_error_no_clasif       	CONSTANT   VARCHAR2(30):='Error no clasificado';
  CV_separador          	CONSTANT   VARCHAR2(1):='|';
  CV_si_ejecuta_commit      CONSTANT   ged_parametros.nom_parametro%TYPE:='SI';
  CV_ejecuta_commit         CONSTANT   ged_parametros.nom_parametro%TYPE:='EJECUTA_COMMIT';
  CV_cod_modulo             CONSTANT   ged_parametros.cod_modulo%TYPE:='GA';
  CV_cod_producto_post      CONSTANT   ged_parametros.cod_producto%TYPE:=1;
  CV_param_usuario          CONSTANT   ged_parametros.nom_parametro%TYPE:='USUARIO_SERV_PL_SQL';
  TYPE TA_num_solicitudes   IS         TABLE OF CI_ORSERV.NUM_OS%TYPE  INDEX BY BINARY_INTEGER;
  TYPE refcursor 			IS         REF CURSOR;
  CV_actuacion			    CONSTANT   PV_ACTUAC_RESTRICCION.cod_actuacion%TYPE:='GG';
  CN_largoquery				CONSTANT   NUMBER:=3000;
  CN_largoerrtec			CONSTANT   NUMBER:=500;
  CN_largodesc				CONSTANT   NUMBER:=1000;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_ACTDES_SS_PR        (EN_num_celular     IN           ga_abocel.num_celular%TYPE,
	                              EV_ss_activa       IN           VARCHAR2,
								  EV_ss_desactiva    IN           VARCHAR2,
								  SC_num_solicitudes OUT NOCOPY   refcursor,
								  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                  SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                  SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_SS_PR          (EN_num_celular     IN           ga_abocel.num_celular%TYPE,
	                              SC_ss_activos      OUT NOCOPY   refcursor,
								  SC_ss_activables   OUT NOCOPY   refcursor,
								  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                  SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                  SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END PV_SERV_SUPLE_II_PG;
/
SHOW ERRORS
