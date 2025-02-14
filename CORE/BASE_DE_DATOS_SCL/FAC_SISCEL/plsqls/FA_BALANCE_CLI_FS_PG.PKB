CREATE OR REPLACE PACKAGE BODY FA_BALANCE_CLI_FS_PG
IS

SN_cod_retornoau   ge_errores_pg.CodError;
SV_mens_retornoau  ge_errores_pg.MsgError;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE FA_BALANCE_CLI_FS_PR (EN_num_celular     IN   ga_abocel.num_celular%TYPE,
	                                 SN_folio      	     OUT NOCOPY   NUMBER,
								     SN_saldo   		 OUT NOCOPY   NUMBER,
	                                 SC_cargos_nuevos	 OUT NOCOPY   refcursor,
								     SV_fec_emision      OUT NOCOPY   VARCHAR2,
								     SV_fec_vcto		 OUT NOCOPY   VARCHAR2,
								     SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
									 SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError
								     )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "FA_BALANCE_CLI_FS_PR"
      Lenguaje="PL/SQL"
      Fecha="02-05-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Mascara consulta balance de la cuenta ECU-050050-ECU-050052</Descripción>
       <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_folio" Tipo="NUMERICO">Numero de la ultima factura</param>
            <param nom="SN_saldo" Tipo="NUMERICO">Monto total de la deuda</param>
            <param nom="SV_cargos_nuevos" Tipo="CARACTER">Cargo no ciclo del periodo actual de facturacion<param>
            <param nom="SV_fec_emision" Tipo="CARACTER"> Fecha de emision de la ultima factura<param>
            <param nom="SV_fec_vcto" Tipo="CARACTER"> Fecha vencimiento de la ultima factura<param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'num_celular =' || EN_num_celular || ' -- ' , 'SAI', 'ECU_0005', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
	     FA_BALANCE_CLI_PG.FA_BALANCE_CLI_PR
	   				(EN_num_celular,
	                 SN_folio,
					 SN_saldo,
	                 SC_cargos_nuevos,
					 SV_fec_emision,
					 SV_fec_vcto,
					 SN_cod_retorno,
					 SV_mens_retorno,
					 SN_num_evento);
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
END FA_BALANCE_CLI_FS_PR;
END FA_BALANCE_CLI_FS_PG;
/
SHOW ERRORS
