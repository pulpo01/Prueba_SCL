CREATE OR REPLACE PACKAGE BODY Co_Servicios_Cobranza_Fs_Pg AS

SN_cod_retornoau   ge_errores_td.cod_msgerror%TYPE;
SV_mens_retornoau  ge_errores_td.det_msgerror%TYPE;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE co_interfaz_web_fs_pr (
      EN_codcliente     IN         NUMBER,
      EN_importepago    IN         NUMBER,
      EN_fecpago        IN         VARCHAR2,
      EN_codbanco       IN         VARCHAR2,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "CO_INTERFAZ_WEB_FS_PR"
      Fecha modificacion=" "
      Fecha creacion="14-06-2006"
      Programador="Soporte RyC"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Valida si un Abonado tiene Servicios de la Plataforma Atlantida para insertar Pago en tabla CO_INTERFAZ_PAGOS</Descripcion>
      <Parametros>
         <Entrada>
                                <param nom="EN_codcliente"   Tipo="NUMERICO">Código del Cliente que realiza el Pago </param>
                                <param nom="EN_importepago"  Tipo="NUMERICO">Monto pagado </param>
                                <param nom="EN_fecpago"      Tipo="CARACTER">Fecha del pago </param>
                                <param nom="EN_codbanco"     Tipo="CARACTER">Codigo del banco </param>
         </Entrada>
         <Salida>
                <param nom="sn_cod_retorno"  Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="sv_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="sn_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion
    14.06.2006 Se crea por incidencia CO-200606070176 >
*/
AS

BEGIN

    SN_cod_retorno := '0';
    SN_num_evento  := 0  ;
    SV_mens_retorno:= '0';

    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'EN_codcliente = '||EN_codcliente, 'ATLANTIDA', 'COL_I_001', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
        Co_Servicios_Cobranza_Pg.co_interfaz_web_pr (EN_codcliente, EN_importepago, EN_fecpago, EN_codbanco , sn_cod_retorno, sv_mens_retorno, sn_num_evento);
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

END co_interfaz_web_fs_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END Co_Servicios_Cobranza_Fs_Pg;
/
SHOW ERRORS
