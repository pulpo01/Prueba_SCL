CREATE OR REPLACE PACKAGE BODY              "GA_CONSULTAS_WEB_PG" IS
SN_cod_retornoau   ge_errores_td.cod_msgerror%TYPE;
SV_mens_retornoau  ge_errores_td.det_msgerror%TYPE;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;

----------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_numabonado_pr (
    EN_num_celular	     IN NUMBER,
    SN_num_abonado		OUT NOCOPY NUMBER,
    SN_cod_retorno		OUT NOCOPY NUMBER,
    SV_mens_retorno		OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_NUMABONADO_PR".
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar número de abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SN_num_abonado"   Tipo="NUMERICO>Secuencia nro del abonado</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    /*ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'EN_num_celular = ' || EN_num_celular, 'SAI', 'COL_0010', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
    */
        ga_segmentacion_pg.ga_consulta_numabonado_pr(EN_num_celular,SN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        /*ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;
    */

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END ga_consulta_numabonado_pr;

----------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_responsable_pr(
    EN_num_celular	     IN NUMBER,
    SV_responsable		OUT NOCOPY VARCHAR2,
    SN_cod_retorno		OUT NOCOPY NUMBER,
    SV_mens_retorno		OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_RESPONSABLE_PR".
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar responsable del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SV_responsable"     Tipo="CARACTER>Nombre del responsable<</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    /*ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'EN_num_celular = ' || EN_num_celular, 'SAI', 'COL_0011', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
    */
        ga_segmentacion_pg.ga_consulta_responsable_pr(EN_num_celular,SV_responsable,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        /*ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;
    */

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END ga_consulta_responsable_pr;

----------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_tipoplan_pr (
    EN_num_celular	    IN NUMBER,
    SV_tip_plantarif	OUT NOCOPY VARCHAR2,
    SN_cod_retorno		OUT NOCOPY NUMBER,
    SV_mens_retorno		OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_TIPOPLAN_PR".
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar tipo de plan del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SV_tip_plantarif"   Tipo="CARACTER>Tipo de plan tarifario<</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    /*ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'EN_num_celular = ' || EN_num_celular, 'SAI', 'COL_0012', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
    */
        ga_segmentacion_pg.ga_consulta_tipoplan_pr(EN_num_celular,SV_tip_plantarif,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        /*ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;
    */

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END ga_consulta_tipoplan_pr;

--------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_factura_web_pr (
    EN_num_celular     IN              NUMBER,
    SC_factura         OUT NOCOPY      refcursor,
    SN_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_FACTURA_WEB_PR"
      Lenguaje="PL/SQL"
      Fecha="10-06-2005"
      Versión="1.0"
      Diseñador="Karem Fernandez Ayala""
      Programador="Karem Fernandez Ayala
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Consulta detalle Factura, dependiendo de un número celular y el número de la factura</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SC_factura" Tipo="GURSOR" >Cursor de las facturas</param>
			<param nom="SN_cod_retorno"  Tipo="NUMERICO" >Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    /*ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'EN_num_celular = ' || EN_num_celular, 'SAI', 'COL_0013', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
    */
        ga_facturas_pg.ga_consulta_factura_web_pr(EN_num_celular,SC_factura,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        /*ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;
    */

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END ga_consulta_factura_web_pr;
--------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_detfactura_web_pr (
    EN_num_celular     IN              NUMBER,
    EN_num_folio       IN              NUMBER,
    SC_detfactura      OUT NOCOPY      refcursor,
    SN_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_DETFACTURA_WEB_PR"
      Lenguaje="PL/SQL"
      Fecha="10-06-2005"
      Versión="1.0"
      Diseñador=""Karem Fernandez Ayala"
      Programador="Oscar Jorquera"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Consulta detalle Factura, dependiendo de un número celular y el número de la factura</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
			<param nom="EN_num_folio" Tipo="NUMERICO>Número Factura</param>
         </Entrada>
         <Salida>
			<param nom="SC_detfactura" Tipo="GURSOR" >Cursor con el detalle de la factura</param>
			<param nom="SN_cod_retorno"  Tipo="NUMERICO" >Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    /*ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'EN_num_celular = ' || EN_num_celular || ', EN_num_folio = ' || EN_num_folio, 'SAI', 'COL_0014', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
    */
        ga_facturas_pg.ga_consulta_detfactura_web_pr(EN_num_celular,EN_num_folio,SC_detfactura,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        /*ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;
    */

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END ga_consulta_detfactura_web_pr;

-----------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_saldo_pr(
    EN_num_celular      IN  NUMBER,
    SN_saldo		   OUT NOCOPY NUMBER,
    SN_cod_retorno     OUT NOCOPY NUMBER,
    SV_mens_retorno    OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_SALDO_PR".
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar validez de Numero celular del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
		    <param nom="SN_saldo"           Tipo="NUMERICO">Saldo de deuda</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    /*ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'EN_num_celular = ' || EN_num_celular, 'SAI', 'COL_0015', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
    */
        ga_consumo_pg.ga_consulta_saldo_pr(EN_num_celular,SN_saldo,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        /*ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;
    */

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END ga_consulta_saldo_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_responsable_cuenta_pr (
    EN_cod_cliente      IN         ga_segmentacion_pg.codcliente,
    SV_cod_tipident     OUT NOCOPY ga_segmentacion_pg.codtipident,
    SV_num_ident        OUT NOCOPY ga_segmentacion_pg.numident,
    SV_nom_responsable  OUT NOCOPY ga_segmentacion_pg.nomresponsable,
    SV_obs_direccion    OUT NOCOPY ga_segmentacion_pg.obsdireccion,
    SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ga_responsable_cuenta_pr"
      Lenguaje="PL/SQL"
      Fecha="07-09-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Máscara Consulta web del responsable de la cuenta del cliente</Descripción>
       <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Código del cliente</param>
         </Entrada>
         <Salida>
            <param nom="SV_cod_tipident" Tipo="CARACTER">Tipo de identificación</param>
            <param nom="SV_num_ident" Tipo="CARACTER">Nro de identificación</param>
            <param nom="SV_nom_responsable" Tipo="CARACTER">Nombre del responsable</param>
            <param nom="SV_obs_direccion Tipo="CARACTER">Observación de dirección del responsable</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
AS
    SN_num_evento  			 ge_errores_pg.Evento;
BEGIN
    /*ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'cod_cliente =' || EN_cod_cliente || ' -- ' ,'SAI', 'COL_0016', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
    */
	     ga_segmentacion_pg.ga_responsable_cuenta_pr
	   				(EN_cod_cliente,
	                 SV_cod_tipident,
                     SV_num_ident,
	                 SV_nom_responsable,
					 SV_obs_direccion,
					 SN_cod_retorno,
					 SV_mens_retorno,
					 SN_num_evento);
	    /*ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;
    */

    EXCEPTION

        WHEN ERR_AGAUDITORIA THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;

        WHEN ERR_MOAUDITORIA  THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;
END ga_responsable_cuenta_pr;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_version_fn RETURN VARCHAR2
/*
<Documentación
  TipoDoc = "Función>
   <Elemento
      Nombre = "GA_VERSION_FN"
      Lenguaje="PL/SQL"
      Fecha="26-12-2004"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>Versión y subversión del package</Retorno>
      <Descripción>Mostrar versión y subversión del package</Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
BEGIN
   RETURN('Version : '||CV_version||' <--> SubVersion : '||CV_subversion);
END;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END ga_consultas_web_pg;
/
SHOW ERRORS
