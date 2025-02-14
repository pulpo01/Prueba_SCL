CREATE OR REPLACE PACKAGE BODY ve_validaciones_clientes_fs_pg IS



PROCEDURE ve_valida_cliente_moroso_pr(EV_tipident      IN  ge_clientes.cod_tipident%TYPE,
                                      EV_numident      IN  ge_clientes.num_ident%TYPE,
                                      SN_total         OUT  NOCOPY NUMBER,
                                                                  SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
 <Elemento Nombre = "VE_validaCliente_pr"
           Lenguaje="PL/SQL"
           Fecha="31-08-2005"
           Versión="1.0.0"
           Diseñador="NRCA"
           Programador="NRCA"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA/Retorno>
   <Descripción> Validacion cliente moroso-vetado /Descripción>
    <Parámetros>
     <Entrada>
      <param nom="EV_tipident" Tipo="STRING">Tipo identidad del cliente a verificar</param>
      <param nom="EV_numident" Tipo="STRING">Numero de identidad del cliente a verificar</param>
     </Entrada>
     <Salida>
      <param nom="SN_total" Tipo="NUMBER">Monto deuda Cliente</param>
      <param nom="SN_cod_retorno" Tipo="NUMBER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno" Tipo="STRING">Mensaje de Retorno</param>
     </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/
    ERR_AGAUDITORIA    EXCEPTION;
    ERR_MOAUDITORIA    EXCEPTION;
    nsNEvento          ge_errores_pg.Evento;
    SN_cod_retornoau   ge_errores_pg.coderror;
    SV_mens_retornoau  ge_errores_pg.msgerror;
    SN_num_eventoau    ge_errores_pg.Evento;
    SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
BEGIN

    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL,'Tip_ident =' || EV_tipident || ' Num_ident =' || EV_numident , 'WEB', 'ECUCOL_002', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

        SN_TOTAL:=0;

    IF SN_cod_retornoau IS NULL THEN
       ve_validaciones_clientes_pg.ve_valida_cliente_moroso_pr(EV_tipident,EV_numident,SN_total,SN_cod_retorno, SV_mens_retorno, nsNEvento);
       ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', nsNEvento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

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

END ve_valida_cliente_moroso_pr;


PROCEDURE ve_valida_imei_pr     (EV_num_imei         IN   ga_aboamist.num_serie%TYPE,
                                 EN_cod_vendedor     IN   ve_vendealer.cod_vendealer%TYPE,
                                 EV_cod_canal        IN   VARCHAR2,
                                 EV_cod_procediencia IN   CHAR,
                                 SN_cod_retorno      OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_mens_retorno     OUT  NOCOPY ge_errores_td.det_msgerror%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
 <Elemento Nombre = "VE_validaEquipoIMEI_pr"
           Lenguaje="PL/SQL"
           Fecha="31-08-2005"
           Versión="1.0.0"
           Diseñador="NRCA"
           Programador="NRCA"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA/Retorno>
   <Descripción> Validacion equipo IMEI /Descripción>
    <Parámetros>
     <Entrada>
            <param nom="EV_num_imei        " Tipo="CARACTER">numero del imei</param>
            <param nom="EN_cod_vendedor    " Tipo="NUMERICO">Código del vendedor</param
            <param nom="EV_cod_canal       " Tipo="CARACTER">Canal del vendedor</param>
            <param nom="EV_cod_procediencia" Tipo="CARACTER">procedencia equipo</param>
     </Entrada>
     <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMBER">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="STRING">Mensaje de Retorno</param>
     </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/
    ERR_AGAUDITORIA    EXCEPTION;
    ERR_MOAUDITORIA    EXCEPTION;
    nsNEvento          ge_errores_pg.Evento;
    SN_cod_retornoau   ge_errores_pg.coderror;
    SV_mens_retornoau  ge_errores_pg.msgerror;
    SN_num_eventoau    ge_errores_pg.Evento;
    SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
BEGIN

    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL,'num_imei ='|| EV_num_imei ||',cod_vendedor ='|| EN_cod_vendedor ||',cod_canal =' || EV_cod_canal || ',cod_procediencia ='|| EV_cod_procediencia, 'WEB', 'ECUCOL_004', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

    IF SN_cod_retornoau IS NULL THEN
       ve_validaciones_clientes_pg.ve_valida_imei_pr(EV_num_imei,EN_cod_vendedor,EV_cod_canal,EV_cod_procediencia,SN_cod_retorno, SV_mens_retorno, nsNEvento);
       ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', nsNEvento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

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

END ve_valida_imei_pr;

END ve_validaciones_clientes_fs_pg;
/
SHOW ERRORS
