CREATE OR REPLACE PACKAGE PV_SERV_SUPLE_II_FS_PG
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "PV_SERV_SUPLE_II_FS_PG"
    Lenguaje="PL/SQL"
    Fecha="29-04-2005"
    Versión="1.0"
    Diseñador=""Fernando Garcia E."
    Programador="Jubitza Villanueva G."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package mascara servicios suplementarios</Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS
  CV_version	        	CONSTANT  VARCHAR2(10):='1.0';
  CV_error_no_clasif 		CONSTANT  VARCHAR2(30):='Error no clasificado';
  TYPE refcursor 	 		IS REF CURSOR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_ACTDES_SS_FS_PR      (EN_num_celular    IN  ga_abocel.num_celular%TYPE,
	                              EV_ss_activa       IN  VARCHAR2,
								  EV_ss_desactiva    IN  VARCHAR2,
								  SC_num_solicitudes OUT NOCOPY   refcursor,
								  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                           		  SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_SS_FS_PR          (EN_num_celular  IN  ga_abocel.num_celular%TYPE,
	                              SC_ss_activos      OUT NOCOPY   refcursor,
								  SC_ss_activables   OUT NOCOPY   refcursor,
								  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                            	  SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END PV_SERV_SUPLE_II_FS_PG;
/
SHOW ERRORS
