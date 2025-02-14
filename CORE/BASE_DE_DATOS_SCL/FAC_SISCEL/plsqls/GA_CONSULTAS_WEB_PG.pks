CREATE OR REPLACE PACKAGE ga_consultas_web_pg
/*
<Documentación
   TipoDoc = "Package">
   <Elemento
       Nombre = "GA_CONSULTAS_WEB_PG"
       Lenguaje="PL/SQL"
       Fecha="18-06-2005"
       Versión="2.0"
       Diseñador="Carlos Navarro H. - Marcelo Godoy S."
       Programador="Marcelo Godoy S. - Carlos Navarro H."
       Ambiente Desarrollo="BD">
   	   Fecha de modificación="07-09-2005"
       Diseñador de modificación="Fernando Garcia"
       Programador de modificación="Jubitza Villanueva G."
	   Descripción de modificación="Se agrega funcionalidad ga_responsable_cuenta_pr"
       <Retorno>NA</Retorno>
       <Descripción>Package fachada para servicios WEB</Descripción>
       <Parámetros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Parámetros>
    </Elemento>
   </Documentación>
*/

IS
   CV_version           CONSTANT VARCHAR2(2) := '2';
   CV_subversion        CONSTANT VARCHAR2(2) := '0';
   TYPE refcursor 		IS 		 REF CURSOR;
----------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_numabonado_pr (
      en_num_celular    IN              NUMBER,
      sn_num_abonado    OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2
   );

----------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_responsable_pr (
      en_num_celular    IN              NUMBER,
      sv_responsable    OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2
   );

----------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_tipoplan_pr (
      en_num_celular     IN              NUMBER,
      sv_tip_plantarif   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      NUMBER,
      sv_mens_retorno    OUT NOCOPY      VARCHAR2
   );

--------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_factura_web_pr (
      en_num_celular    IN              NUMBER,
      sc_factura        OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE
   );

--------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_detfactura_web_pr (
      en_num_celular    IN              NUMBER,
      en_num_folio      IN              NUMBER,
      sc_detfactura     OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE
   );

-----------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_saldo_pr (
      en_num_celular    IN              NUMBER,
      sn_saldo          OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_responsable_cuenta_pr (
      EN_cod_cliente      IN         ga_segmentacion_pg.codcliente,
      SV_cod_tipident     OUT NOCOPY ga_segmentacion_pg.codtipident,
      SV_num_ident        OUT NOCOPY ga_segmentacion_pg.numident,
      SV_nom_responsable  OUT NOCOPY ga_segmentacion_pg.nomresponsable,
      SV_obs_direccion    OUT NOCOPY ga_segmentacion_pg.obsdireccion,
      SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_version_fn
      RETURN VARCHAR2;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END ga_consultas_web_pg;
/
SHOW ERRORS
