CREATE OR REPLACE PACKAGE BODY ga_consultas_touch_pg
IS
SN_cod_retornoau   ge_errores_td.cod_msgerror%TYPE;
SV_mens_retornoau  ge_errores_td.det_msgerror%TYPE;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_consumo_6meses_pr (
   EN_num_celular    IN    ga_abocel.num_celular%TYPE,
   SC_cur_consumo    OUT   NOCOPY refcursor,
   SN_cod_retorno    OUT   NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT   NOCOPY ge_errores_td.det_msgerror%TYPE
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_CONSUMO_6MESES_PR"
      Lenguaje="PL/SQL"
      Fecha="17-06-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H - MArcelo Godoy S"
      Programador="Carlos Navarro H - MArcelo Godoy S"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Recupera el consumo de los ultimos 6 meses</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="CARACTER">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SC_cur_consumo"	Tipo="CARACTER">Cursor de Salida</param>
			<param nom="SN_cod_retorno" Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'EN_num_celular = ' || EN_num_celular, 'SAI', 'COL_0002', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
        ga_consumo_pg.ga_consulta_consumo_6meses_pr(EN_num_celular,SC_cur_consumo,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END ga_consulta_consumo_6meses_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_nomcliente_pr (
    EN_num_celular	    IN  NUMBER,
    SV_nom_cliente		OUT NOCOPY VARCHAR2,
    SN_cod_retorno		OUT NOCOPY NUMBER,
    SV_mens_retorno		OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_NOMCLIENTE_PR".
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar Nombre del Cliente del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SV_nom_cliente"     Tipo="CARACTER>Nombre completo del cliente</param>
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
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'EN_num_celular = ' || EN_num_celular, 'SAI', 'COL_0003', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
        ga_segmentacion_pg.ga_consulta_nomcliente_pr(EN_num_celular,SV_nom_cliente,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END ga_consulta_nomcliente_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_direcfact_pr(
    EN_num_celular     IN  ga_abocel.num_celular%TYPE,
    SV_des_tipdir      OUT NOCOPY ge_tipdireccion.des_tipdireccion%TYPE,
    SV_nom_calle       OUT NOCOPY ge_direcciones.nom_calle%TYPE,
    SV_num_calle       OUT NOCOPY ge_direcciones.num_calle%TYPE,
    SV_num_piso        OUT NOCOPY ge_direcciones.num_piso%TYPE,
    SV_cod_region      OUT NOCOPY ge_direcciones.cod_region%TYPE,
    SV_des_region      OUT NOCOPY ge_regiones.des_region%TYPE,
    SV_cod_provincia   OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
    SV_des_provincia   OUT NOCOPY ge_provincias.des_provincia%TYPE,
    SV_cod_ciudad      OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
    SV_des_ciudad      OUT NOCOPY ge_ciudades.des_ciudad%TYPE,
    SV_cod_comuna      OUT NOCOPY ge_direcciones.cod_comuna%TYPE,
    SV_des_comuna      OUT NOCOPY ge_comunas.des_comuna%TYPE,
    SV_cod_postal      OUT NOCOPY ge_direcciones.zip%TYPE,
    SV_observacion     OUT NOCOPY ge_direcciones.obs_direccion%TYPE,
    SV_des_dir1        OUT NOCOPY ge_direcciones.des_direc1%TYPE,
    SV_des_dir2        OUT NOCOPY ge_direcciones.des_direc2%TYPE,
    SN_cod_cliente     OUT NOCOPY ge_clientes.cod_cliente%TYPE,
    SV_nom_cliente     OUT NOCOPY VARCHAR2,
    SV_cod_tecnologia  OUT NOCOPY ga_abocel.cod_tecnologia%TYPE,
    SD_fec_activ       OUT NOCOPY ga_abocel.fec_activacion%TYPE,
    SN_cod_retorno     OUT NOCOPY  ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY  ge_errores_pg.MsgError
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_DIRECFACT_PR"
      Lenguaje="PL/SQL"
      Fecha="06-06-2005"
      Versión="1.0"
      Diseñador=""Oscar Jorquera"
      Programador="Oscar Jorquera"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripción>Capa de negocio Consulta la dirección dependiendo de un número celular y el código tipo de dirección</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SV_des_tipdir" Tipo="Varchar">descripción del tipo de dirección</param>
            <param nom="SV_nom_calle" Tipo="Varchar">nombre de la calle</param>
            <param nom="SV_num_calle" Tipo="NUMERICO">Número de la calle</param>
            <param nom="SV_num_piso" Tipo="NUMERICO">Número de Piso</param>
            <param nom="SV_cod_region" Tipo="Varchar">Código de región</param>
            <param nom="SV_des_region"  Tipo="VARCHAR">descripción de la región</param>
            <param nom="SV_cod_provincia" Tipo="VARCHAR">Código de la Provincia</param>
            <param nom="SV_des_provincia" Tipo="VARCHAR">Descripción de la Provincia</param>
            <param nom="SV_cod_ciudad"  Tipo="VARCHAR">Código de Ciudad</param>
            <param nom="SV_des_ciudad" Tipo="VARCHAR">Descripción de la ciudad</param>
            <param nom="SV_cod_comuna" Tipo="VARCHAR">Codigo de Comuna</param>
            <param nom="SV_des_comuna"  Tipo="VARCHAR" >Descripción de la Comuna</param>
            <param nom="SV_cod_postal"  Tipo="VARCHAR" >Código Postal</param>
            <param nom="SV_observacion"  Tipo="VARCHAR" >Observación</param>
            <param nom="SV_des_dir1"  Tipo="VARCHAR" >Descripción Dirección 1</param>
            <param nom="SV_des_dir2"  Tipo="VARCHAR" >Descripción Dirección 2</param>
            <param nom="SN_cod_cliente"  Tipo="NUMERICO" >Código Cliente</param>
            <param nom="SV_nom_cliente"  Tipo="VARCHAR" >Nombre Cliente</param>
            <param nom="SV_cod_tecnologia"  Tipo="VARCHAR" >Código de Tecnología</param>
            <param nom="SV_cod_tecnologia"  Tipo="VARCHAR" >Código de Tecnología</param>
            <param nom="SD_fec_activ"  Tipo="DATE" >Fecha de Activación</param>
            <param nom="SN_cod_retorno"  Tipo="VARCHAR" >Código de Retorno (descripción de error)</param>
            <param nom="sv_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
       </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'EN_num_celular = ' || EN_num_celular, 'SAI', 'COL_0004', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
        ga_consulta_direccion_pg.ga_consulta_direcfact_pr(EN_num_celular,SV_des_tipdir,SV_nom_calle,SV_num_calle,SV_num_piso,SV_cod_region,SV_des_region,SV_cod_provincia,SV_des_provincia,SV_cod_ciudad,
		                                                  SV_des_ciudad,SV_cod_comuna,SV_des_comuna,SV_cod_postal,SV_observacion,SV_des_dir1,SV_des_dir2,SN_cod_cliente,SV_nom_cliente,SV_cod_tecnologia,
														  SD_fec_activ,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END ga_consulta_direcfact_pr;

----------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_numcelular_pr(
    EN_num_celular	    IN  NUMBER,
    SN_cod_retorno		OUT NOCOPY NUMBER,
    SV_mens_retorno		OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_NUMCELULAR_PR".
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
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'EN_num_celular = ' || EN_num_celular, 'SAI', 'COL_0005', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
        ga_segmentacion_pg.ga_consulta_numcelular_pr(EN_num_celular,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END ga_consulta_numcelular_pr;

----------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_fonocontacto_pr (
    EN_num_celular	    IN  NUMBER,
    SV_fono_contacto	OUT NOCOPY VARCHAR2,
    SN_cod_retorno		OUT NOCOPY NUMBER,
    SV_mens_retorno		OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_FONOCONTACTO_PR".
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar fono de contacto del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SV_fono_contacto"   Tipo="CARACTER>Teléfono de contacto</param>
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
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'EN_num_celular = ' || EN_num_celular, 'SAI', 'COL_0006', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
        ga_segmentacion_pg.ga_consulta_fonocontacto_pr(EN_num_celular,SV_fono_contacto,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END ga_consulta_fonocontacto_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_inserta_reg_atencion_pr (
    EN_num_celular      IN       ga_abocel.num_celular%TYPE,
    EN_cod_atencion     IN       ci_reg_atencion_clientes.cod_atencion%TYPE,
    EV_obs_atencion     IN       ci_reg_atencion_clientes.obs_atencion%TYPE,
    EV_nom_usuario      IN       ci_reg_atencion_clientes.nom_usuarora%TYPE,
    EV_cod_oficina      IN       ci_reg_atencion_clientes.cod_oficina%TYPE,
    SN_cod_retorno      OUT      ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno     OUT      ge_errores_td.det_msgerror%TYPE
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_INSERTA_REG_ATENCION_PG"
      Lenguaje="PL/SQL"
      Fecha creacion="31-03-2005"
      Creado por="Maritza Tapia"
      Fecha modificacion=""
      Modificado por=""
      <Retorno>NA</Retorno>
      <Descripción>Inserta un registro a la tabla CI_REG_ATENCION_CLIENTE</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de celular</param>
            <param nom="EN_cod_atencion" Tipo="NUMERICO">Codigo de atencion al cliente</param>
            <param nom="EV_obs_atencion" Tipo="CARACTER">Observacion optativa de la atencion</param>
            <param nom="EV_nom_usuario" Tipo="CARACTER">Nombre del usuario Oracle</param>
            <param nom="EV_cod_oficina" Tipo="CARACTER">Codigo de oficina</param>
         </Entrada>
         <Salida>
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
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'EN_num_celular = ' || EN_num_celular || ', EN_cod_atencion = ' || EN_cod_atencion || ', EV_obs_atencion = ' || EV_obs_atencion || ', EV_nom_usuario = ' || EV_nom_usuario || ', EV_cod_oficina = '|| EV_cod_oficina, 'SAI', 'COL_0007', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
        ga_reg_atencion_cliente_ng_pg.ga_inserta_reg_atencion_pr(EN_num_celular,EN_cod_atencion,EV_obs_atencion,EV_nom_usuario,EV_cod_oficina,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END ga_inserta_reg_atencion_pr;

--------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_factura_touch_pr (
    EN_num_celular    IN    NUMBER,
	SV_fec_ini  	 OUT    NOCOPY VARCHAR2,
    SV_fec_fin		 OUT    NOCOPY VARCHAR2,
	SV_fec_emision 	 OUT    NOCOPY VARCHAR2,
    SV_fec_vencimie	 OUT    NOCOPY VARCHAR2,
	SV_fec_susp 	 OUT    NOCOPY VARCHAR2,
    SN_saldo_ant	 OUT    NOCOPY NUMBER,
	SN_saldo_act	 OUT    NOCOPY NUMBER,
	SN_ult_pago		 OUT    NOCOPY NUMBER,
    SN_tot_iptos	 OUT    NOCOPY NUMBER,
    SN_tot_dctos	 OUT    NOCOPY NUMBER,
    SN_tot_cargos	 OUT    NOCOPY NUMBER,
    SN_tot_cargosme  OUT    NOCOPY NUMBER,
    SN_tot_cuotas	 OUT    NOCOPY NUMBER,
    SN_tot_pagar	 OUT    NOCOPY NUMBER,
	SN_cod_retorno   OUT    NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno  OUT    NOCOPY ge_errores_td.det_msgerror%TYPE
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_FACTURA_TOUCH_PR"
      Lenguaje="PL/SQL"
      Fecha="15-06-2005"
      Versión="1.0"
      Diseñador="Carlos Navarro H."
      Programador="Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera informacion de la ültima factura de un cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SV_fec_ini" Tipo="CARACTER">Fecha de Inicio de Llamadas</param>
			<param nom="SV_fec_fin" Tipo="CARACTER">Fecha de Fin de Llamadas</param>
			<param nom="SV_fec_emision" Tipo="CARACTER">Fecha de Emision del Documento</param>
			<param nom="SV_fec_vencimie" Tipo="CARACTER">Fecha de Vencimiento del Documento</param>
			<param nom="SV_fec_susp " Tipo="CARACTER">Fecha de Suspension</param>
			<param nom="SN_saldo_ant" Tipo="NUMERICO">Saldo Anterior</param>
			<param nom="SN_saldo_act" Tipo="NUMERICO">Saldo Actual</param>
			<param nom="SN_ult_pago" Tipo="NUMERICO">Ultimo Pago</param>
			<param nom="SN_tot_iptos" Tipo="NUMERICO">Total de Impuesto</param>
			<param nom="SN_tot_dctos" Tipo="NUMERICO">Total de Descuentos</param>
			<param nom="SN_tot_cargos" Tipo="NUMERICO">Total de Cargos</param>
			<param nom="SN_tot_cargosme" Tipo="NUMERICO">Total Cargos del Mes</param>
			<param nom="SN_tot_cuotas" Tipo="NUMERICO">Total Cuotas</param>
			<param nom="SN_tot_pagar" Tipo="NUMERICO">Total a Pagar</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'EN_num_celular = ' || EN_num_celular, 'SAI', 'COL_0008', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
        ga_facturas_pg.ga_consulta_factura_touch_pr(EN_num_celular,SV_fec_ini,SV_fec_fin,SV_fec_emision,SV_fec_vencimie,SV_fec_susp,SN_saldo_ant,SN_saldo_act,SN_ult_pago,SN_tot_iptos,SN_tot_dctos,
		                                            SN_tot_cargos,SN_tot_cargosme,SN_tot_cuotas,SN_tot_pagar,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END ga_consulta_factura_touch_pr;

----------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_producto_pr(
    EN_num_celular	    IN  NUMBER,
    SV_des_producto		OUT NOCOPY VARCHAR2,
    SN_cod_retorno		OUT NOCOPY NUMBER,
    SV_mens_retorno		OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_PRODUCTO_PR".
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar Descripción del producto del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SV_des_producto"    Tipo="CARACTER>Descripción del Producto; Pospago - Prepago - Hibrido<</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'EN_num_celular = ' || EN_num_celular, 'SAI', 'COL_0009', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
        ga_segmentacion_pg.ga_consulta_producto_pr(EN_num_celular,SV_des_producto,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END ga_consulta_producto_pr;

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
   vlversion    CONSTANT VARCHAR2(3) := '01';
   vlsubversion CONSTANT VARCHAR2(3) := '01';
BEGIN
   RETURN('Version : '||vlversion||' <--> SubVersion : '||vlsubversion);
END;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END ga_consultas_touch_pg;
/
SHOW ERRORS
