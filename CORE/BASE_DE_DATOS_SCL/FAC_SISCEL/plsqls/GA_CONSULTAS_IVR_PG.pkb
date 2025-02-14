CREATE OR REPLACE PACKAGE BODY              "GA_CONSULTAS_IVR_PG" IS

SN_cod_retornoau   ge_errores_pg.CodError;
SV_mens_retornoau  ge_errores_pg.MsgError;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
LV_param           VARCHAR2(4000);

ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_trama_pr (EV_cadena_entrada   IN  VARCHAR2,
                       SV_cadena_salida    OUT NOCOPY  VARCHAR2 )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ga_trama_pr"
      Lenguaje="PL/SQL"
      Fecha="16-06-2005"
      Versión="1.0"
      Diseñador=""
      Programador=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Mascara que consulta para IVR dependiendo del codigo de transaccion</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cadena_entrada" Tipo="CARACTER">Trama de datos de entrada</param>
         </Entrada>
         <Salida>
            <param nom="SV_cadena_salida" Tipo="CARACTER">Trama de datos de salida</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    LN_num_evento   ge_errores_pg.Evento;
    LN_num_celular  ga_abocel.num_celular%TYPE;
	  LN_cod_retorno  ge_errores_pg.CodError;
    LV_mens_retorno ge_errores_pg.MsgError;
BEGIN
    /*ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'Trama = ' || EV_cadena_entrada, 'SAI', 'COL_0001', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
    */
       ga_trama_pg.ga_trama_pr(EV_cadena_entrada, SV_cadena_salida, LN_cod_retorno, LV_mens_retorno,LN_num_evento);
       /*ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', LN_num_evento, LN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;
    */

    EXCEPTION

        WHEN ERR_AGAUDITORIA THEN
            LN_cod_retorno  := SN_cod_retornoau;
            LV_mens_retorno := SV_mens_retornoau;

        WHEN ERR_MOAUDITORIA  THEN
            LN_cod_retorno  := SN_cod_retornoau;
            LV_mens_retorno := SV_mens_retornoau;
END ga_trama_pr;

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

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END ga_consultas_ivr_pg;
/
SHOW ERRORS
