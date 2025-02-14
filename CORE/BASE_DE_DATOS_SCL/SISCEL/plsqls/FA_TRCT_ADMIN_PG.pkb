CREATE OR REPLACE PACKAGE BODY FA_TRCT_ADMIN_PG IS
        PROCEDURE FA_TRUNC_OPER_RESP_CICL_TH_PR

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "FA_TRUNC_ACUMOPER_RESP_CICL_TH_PR"
      Lenguaje="PL/SQL"
      Fecha="22-06-2005"
      Versión="1.0"
      Diseñador="Claudio Gonzalez"
      Programador="Claudio Gonzalez"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Procedimiento para truncar tablas de Facturacion</Descripción>
      <Parámetros>
         <Entrada>

         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

strQuery             VARCHAR2(5000) := '';
GV_nom_tabla         VARCHAR2(30):='';

------------
-- Inicio --
------------
BEGIN

	strQuery := '';
	strQuery := 'TRUNCATE TABLE FA_ACUMOPER_RESP_CICL_TH REUSE STORAGE';

	BEGIN
			EXECUTE IMMEDIATE strQuery;


    		EXCEPTION
     			WHEN OTHERS THEN
				RAISE_APPLICATION_ERROR (-20003, SQLERRM );
	END;

	strQuery := '';

END FA_TRUNC_OPER_RESP_CICL_TH_PR;


PROCEDURE FA_TRUNC_ACUMOPER_RESP_TH_PR

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "FA_TRUNCATE_ACUMOPER_RESP_TH_PR"
      Lenguaje="PL/SQL"
      Fecha="22-06-2005"
      Versión="1.0"
      Diseñador="Claudio Gonzalez"
      Programador="Claudio Gonzalez"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Procedimiento para truncar tablas de Facturacion</Descripción>
      <Parámetros>
         <Entrada>

         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

strQuery             VARCHAR2(5000) := '';
GV_nom_tabla         VARCHAR2(30):='';

------------
-- Inicio --
------------
BEGIN

	strQuery := '';
	strQuery := 'TRUNCATE TABLE FA_ACUMOPER_RESP_TH REUSE STORAGE';

	BEGIN
			EXECUTE IMMEDIATE strQuery;


    		EXCEPTION
     			WHEN OTHERS THEN
				RAISE_APPLICATION_ERROR (-20003, SQLERRM );
	END;

	strQuery := '';

END FA_TRUNC_ACUMOPER_RESP_TH_PR;


PROCEDURE FA_TRUNC_FA_AGRZONAIMP_TO_PR

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "FA_AGRZONAIMP_TO_PR"
      Lenguaje="PL/SQL"
      Fecha="22-06-2005"
      Versión="1.0"
      Diseñador="Claudio Gonzalez"
      Programador="Claudio Gonzalez"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Procedimiento para truncar tablas de Facturacion</Descripción>
      <Parámetros>
         <Entrada>

         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

strQuery             VARCHAR2(5000) := '';
GV_nom_tabla         VARCHAR2(30):='';

------------
-- Inicio --
------------
BEGIN

	strQuery := '';
	strQuery := 'TRUNCATE TABLE FA_AGRZONAIMP_TO REUSE STORAGE';

	BEGIN
			EXECUTE IMMEDIATE strQuery;


    		EXCEPTION
     			WHEN OTHERS THEN
				RAISE_APPLICATION_ERROR (-20003, SQLERRM );
	END;

	strQuery := '';

END FA_TRUNC_FA_AGRZONAIMP_TO_PR;
END FA_TRCT_ADMIN_PG;
/
SHOW ERRORS
