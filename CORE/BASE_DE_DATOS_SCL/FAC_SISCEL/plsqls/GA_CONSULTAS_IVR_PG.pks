CREATE OR REPLACE PACKAGE ga_consultas_ivr_pg
/*
<Documentación
   TipoDoc = "Package">
   <Elemento
       Nombre = "ga_consultas_ivr_pg"
       Lenguaje="PL/SQL"
       Fecha="18-06-2005"
       Versión="1.0"
       Diseñador="Carlos Navarro H. - Marcelo Godoy S."
       Programador="Marcelo Godoy S. - Carlos Navarro H."
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripción>Package fachada para servicios IVR</Descripción>
       <Parámetros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Parámetros>
    </Elemento>
   </Documentación>
*/

IS
   cv_version           CONSTANT VARCHAR2 (10) := '1.0';
   cv_error_no_clasif   CONSTANT VARCHAR2 (30) := 'Error no clasificado';

   TYPE refcursor IS REF CURSOR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ga_trama_pr (
      ev_cadena_entrada   IN              VARCHAR2,
      sv_cadena_salida    OUT NOCOPY      VARCHAR2
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ga_version_fn
      RETURN VARCHAR2;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ga_consultas_ivr_pg;
/
SHOW ERRORS
