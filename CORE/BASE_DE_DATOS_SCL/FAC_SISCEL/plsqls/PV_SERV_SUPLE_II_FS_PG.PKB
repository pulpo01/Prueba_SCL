CREATE OR REPLACE PACKAGE BODY PV_SERV_SUPLE_II_FS_PG
IS

SN_cod_retornoau   ge_errores_pg.CodError;
SV_mens_retornoau  ge_errores_pg.MsgError;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_ACTDES_SS_FS_PR      (EN_num_celular    IN  ga_abocel.num_celular%TYPE,
	                              EV_ss_activa       IN  VARCHAR2,
								  EV_ss_desactiva    IN  VARCHAR2,
								  SC_num_solicitudes OUT NOCOPY   refcursor,
								  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                           		  SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError
								  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_ACTDES_SS_FS_PR"
      Lenguaje="PL/SQL"
      Fecha="30-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Mascara Activa-desactiva servicios ECU-050050</Descripción>
      <Parámetros>
         <Entrada>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EV_ss_activa" Tipo="CARACTER">Servicios a activar</param>
            <param nom="EV_ss_desactiva" Tipo="CARACTER">Servicios a desactivar</param>
         </Entrada>
         <Salida>
            <param nom="SC_num_solicitudes" Tipo="Cursor">Solicitudes generadas</param>
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
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'num_celular =' || EN_num_celular || ' -- ' , 'SAI', 'ECU_0001', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN

	     PV_SERV_SUPLE_II_PG.PV_ACTDES_SS_PR(EN_num_celular, EV_ss_activa, EV_ss_desactiva,SC_num_solicitudes,Sn_cod_retorno,SV_MENS_RETORNO, SN_NUM_EVENTO );

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
END PV_ACTDES_SS_FS_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_SS_FS_PR        (EN_num_celular      IN  ga_abocel.num_celular%TYPE,
	                              SC_ss_activos      OUT NOCOPY   refcursor,
								  SC_ss_activables   OUT NOCOPY   refcursor,
								  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                           		  SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_SS_FS_PR"
      Lenguaje="PL/SQL"
      Fecha="30-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Mascara Consulta de servicios contratados y contratables de un abonado ECU-050050</Descripción>
      <Parámetros>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SC_ss_activos" Tipo="CURSOR">Cursor de los servicios contratados</param>
            <param nom="SC_ss_activables" Tipo="CURSOR">Cursor de los servicios contratables</param>
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
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'num_celular =' || EN_num_celular || ' -- ' , 'SAI', 'ECU_0011', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
	   PV_SERV_SUPLE_II_PG.PV_CONS_SS_PR
	   				(EN_num_celular,
					 SC_ss_activos,
					 SC_ss_activables,
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

END PV_CONS_SS_FS_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END PV_SERV_SUPLE_II_FS_PG;
/
SHOW ERRORS
