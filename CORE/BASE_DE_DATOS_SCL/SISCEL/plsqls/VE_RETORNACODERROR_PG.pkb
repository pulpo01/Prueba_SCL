CREATE OR REPLACE PACKAGE BODY VE_retornacoderror_PG IS

			FUNCTION VE_retornacoderror_FN(EV_coderrorin IN VARCHAR2, SV_deserror OUT NOCOPY ged_codigos.des_valor%TYPE) RETURN VARCHAR2 IS

					/* <Documentación TipoDoc = "Función">
					   <Elemento Nombre = "VE_retornacoderror_FN Lenguaje="PL/SQL" Fecha="15-06-2005" Versión="1.0" Diseñador="Rayen Ceballos" Programador="Roberto Perez" Ambiente="BD">
					   <Retorno>VARCHAR</Retorno>
					   <Descripción>Función que retorna codigo de error parametrico</Descripción>
					   <Parámetros>
					   <Entrada>
					   <param nom="EV_coderrorin" Tipo="STRING">Codigo de errror interno</param>
					   </Entrada>
					   <Salida>
					   <param nom="SV_deserror" Tipo="STRING">Dscripcion Error</param>
					   </Salida>
					   </Parámetros>
					   </Elemento>
					   </Documentación> */

				    -- Inicio modificacion by SAQL/Soporte 29/09/2005 - XO-200509260738
				    -- LV_coderrorout VARCHAR2(3);
				    LV_coderrorout GED_CODIGOS.COD_VALOR%TYPE;
				    -- Fin modificacion by SAQL/Soporte 29/09/2005 - XO-200509260738
			BEGIN

			        SELECT e.cod_valor, e.des_valor
					INTO   LV_coderrorout, SV_deserror
				    FROM   ged_codigos e
			        WHERE  e.cod_modulo='GA'
			               AND e.nom_tabla='DESBLOQUEO_PREPAGO'
			               AND e.nom_columna=EV_coderrorin;

					RETURN(LV_coderrorout);

					EXCEPTION
					    WHEN NO_DATA_FOUND THEN
						   RETURN('-1');
						WHEN TOO_MANY_ROWS THEN
						   RETURN('-1');

			END VE_retornacoderror_FN;

END VE_retornacoderror_PG;
/
SHOW ERRORS
