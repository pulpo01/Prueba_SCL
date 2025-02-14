CREATE OR REPLACE PACKAGE BODY              "GA_CONS_ATLANTIDA_FS_PG" AS

SN_cod_retornoau   ge_errores_td.cod_msgerror%TYPE;
SV_mens_retornoau  ge_errores_td.det_msgerror%TYPE;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ga_cons_atlantida_abonado_pr (
      en_num_celular    IN              ga_cons_atlantida_pg.ga_num_celular,
      sv_servicio       OUT NOCOPY      VARCHAR2,
      sv_cod_servicio   OUT NOCOPY      ga_cons_atlantida_pg.ga_cod_servicio,
      sv_des_servicio   OUT NOCOPY      ga_cons_atlantida_pg.ga_des_servicio,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "GA_CONS_ATLANTIDA_ABONADO_PR"
      Fecha modificacion=" "
      Fecha creacion="02-06-2006"
      Programador="Carlos Navarro"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Valida si un Abonado tiene Servicios de la Plataforma Atlantida</Descripcion>
      <Parametros>
         <Entrada>
                                     <param nom="en_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
             <param nom="sv_servicio" Tipo="CARACTER">Indica si el abonado tiene servios de Atlántida Activos (SI-NO)</param>
             <param nom="sv_cod_servicio" Tipo="CARACTER">Código de Servicio</param>
             <param nom="sv_des_servicio" Tipo="CARACTER">Descripción del Servicio</param>
             <param nom="sn_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
             <param nom="sv_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="sn_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
AS

BEGIN

    SN_cod_retorno := '0';
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

    /*ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'en_num_celular = '||en_num_celular, 'ATLANTIDA', 'COL_A_001', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
    */
        ga_cons_atlantida_pg.ga_cons_atlantida_abonado_pr (en_num_celular, sv_servicio, sv_cod_servicio, sv_des_servicio, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
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

END ga_cons_atlantida_abonado_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ga_cons_atlantida_cliente_pr (
      en_cod_cliente    IN              ga_cons_atlantida_pg.ga_cod_cliente,
      sv_servicio       OUT NOCOPY      VARCHAR2,
      sv_cod_servicio   OUT NOCOPY      ga_cons_atlantida_pg.ga_cod_servicio,
      sv_des_servicio   OUT NOCOPY      ga_cons_atlantida_pg.ga_des_servicio,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "GA_CONS_ATLANTIDA_CLIENTE_PR"
      Fecha modificacion=" "
      Fecha creacion="02-06-2006"
      Programador="Carlos Navarro"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Valida si un Cliente tiene Servicios de la Plataforma Atlantida</Descripcion>
      <Parametros>
         <Entrada>
                                     <param nom="en_cod_cliente" Tipo="NUMERICO">Codigo de Cliente</param>
         </Entrada>
         <Salida>
             <param nom="sv_servicio" Tipo="CARACTER">Indica si el abonado tiene servios de Atlántida Activos (SI-NO)</param>
             <param nom="sv_cod_servicio" Tipo="CARACTER">Código de Servicio</param>
             <param nom="sv_des_servicio" Tipo="CARACTER">Descripción del Servicio</param>
             <param nom="sn_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
             <param nom="sv_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="sn_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
AS

BEGIN

    SN_cod_retorno := '0';
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

    /*ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'en_cod_cliente = '||en_cod_cliente, 'ATLANTIDA', 'COL_A_002', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
    */
        ga_cons_atlantida_pg.ga_cons_atlantida_cliente_pr (en_cod_cliente, sv_servicio, sv_cod_servicio, sv_des_servicio, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
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

END ga_cons_atlantida_cliente_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END ga_cons_atlantida_fs_pg;
/
SHOW ERRORS
