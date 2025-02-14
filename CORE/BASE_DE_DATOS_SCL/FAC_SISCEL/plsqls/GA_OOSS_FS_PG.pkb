CREATE OR REPLACE PACKAGE BODY ga_ooss_fs_pg
/*
<Documentación
   TipoDoc = "Package">
   <Elemento
       Nombre = "PV_OOSS_FS_PG"
       Lenguaje="PL/SQL"
       Fecha="03-11-2005"
       Versión="1.0"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripción>Package fachada para servicios Consulta de Extratriempo</Descripción>
       <Parámetros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Parámetros>
    </Elemento>
   </Documentación>
*/

IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_extratiempo_consulta_fs_pr (EN_NUM_CELULAR     IN  NUMBER,
                       			 EV_COD_PLAN        IN  VARCHAR2,
					 			 SN_MIN_COMPRADOS   OUT NOCOPY NUMBER,
					 			 SN_MIN_USADOS	    OUT NOCOPY NUMBER,
					 			 SN_MIN_DISPONIBLES OUT NOCOPY NUMBER,
                                 SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                			 	 SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_EXTRATIEMPO_CONSULTA_FS_PR"
      Lenguaje="PL/SQL"
      Fecha="03-11-2005"
      Versión="1.0"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Mascara que consulta los minutos de extratiempo y bolsa</Descripción>
      <Parámetros>
         <Entrada>
		 	<param nom="EN_NUM_CELULAR" Tipo= "NUMERICO">Número de Celular del cliente consiltando el extratiempo</param>
		 	<param nom="EV_COD_PLAN" Tipo= "VARCHAR2">Código del plan de extratiempo del que se desean conocer los saldos</param>
         </Entrada>
         <Salida>
            <param nom="SN_MIN_COMPRADOS"   Tipo="NUMERICO">Cantidad de Minutos Totales de extratiempo</param>
            <param nom="SN_MIN_USADOS"      Tipo="NUMERICO">Cantidad de Minutos Usados de extratiempo</param>
            <param nom="SN_MIN_DISPONIBLES" Tipo="NUMERICO">Cantidad de Minutos Disponibles de extratiempo</param>
	    <param nom="SN_COD_RETORNO"      Tipo="NUMERICO">Código de Retorno (descripción de error)</param>
       	    <param nom="SV_MENS_RETORNO"     Tipo="VARCHAR">Mensaje de Retorno (código de error)</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    LN_num_evento   ge_errores_pg.Evento;
    LN_cod_retorno  ge_errores_pg.CodError;
    LV_mens_retorno ge_errores_pg.MsgError;

	LN_usado_bolsa	NUMBER(11);
	LN_dispo_bolsa  NUMBER(11);
BEGIN
	SN_COD_RETORNO   := 0;
	SV_MENS_RETORNO  := NULL;

    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'ga_extratimepo_consulta_pr = ' ||EN_NUM_CELULAR||EV_COD_PLAN, 'SAI', 'COL_0017', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
       ga_extra_tiempo_pg.ga_extratiempo_consulta_pr(EN_NUM_CELULAR,EV_COD_PLAN,NULL,SN_MIN_COMPRADOS,SN_MIN_USADOS,SN_MIN_DISPONIBLES,LN_usado_bolsa,LN_dispo_bolsa,LN_cod_retorno,LV_mens_retorno,SN_num_eventoau);

       ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', LN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
       IF LN_cod_retorno != 0 THEN
            SN_COD_RETORNO  := LN_cod_retorno;
            SV_MENS_RETORNO := LV_mens_retorno;
       END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;
    EXCEPTION
        WHEN ERR_AGAUDITORIA THEN
            SN_COD_RETORNO  := SN_cod_retornoau;
            SV_MENS_RETORNO := SV_mens_retornoau;
        WHEN ERR_MOAUDITORIA  THEN
            SN_COD_RETORNO  := SN_cod_retornoau;
            SV_MENS_RETORNO := SV_mens_retornoau;
END ga_extratiempo_consulta_fs_pr;


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
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
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
END ga_ooss_fs_pg;
/
SHOW ERRORS
