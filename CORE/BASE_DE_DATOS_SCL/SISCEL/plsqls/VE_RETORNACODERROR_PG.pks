CREATE OR REPLACE PACKAGE VE_retornacoderror_PG IS
        /*
		<Documentación TipoDoc = "VE_retornacoderror_PG
		<Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="28-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripción> Encabezado de VE_retornacoderror_PG/Descripción>
		<Parámetros>
		<Entrada>
		<param nom="" Tipo="STRING">Descripción Parametro1</param>
		</Entrada>
		<Salida>
		<param nom="" Tipo="STRING">Descripción Parametro4</param>
		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/

        FUNCTION VE_retornacoderror_FN(EV_coderrorin IN VARCHAR2, SV_deserror OUT NOCOPY ged_codigos.des_valor%TYPE) RETURN VARCHAR2;
END VE_retornacoderror_PG;
/
SHOW ERRORS
