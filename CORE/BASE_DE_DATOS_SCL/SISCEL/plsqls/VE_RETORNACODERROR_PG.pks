CREATE OR REPLACE PACKAGE VE_retornacoderror_PG IS
        /*
		<Documentaci�n TipoDoc = "VE_retornacoderror_PG
		<Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="28-06-2005" Versi�n="1.0.0" Dise�ador="Rayen Ceballos" Programador="Roberto P�rez" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripci�n> Encabezado de VE_retornacoderror_PG/Descripci�n>
		<Par�metros>
		<Entrada>
		<param nom="" Tipo="STRING">Descripci�n Parametro1</param>
		</Entrada>
		<Salida>
		<param nom="" Tipo="STRING">Descripci�n Parametro4</param>
		</Salida>
		</Par�metros>
		</Elemento>
		</Documentaci�n>
		*/

        FUNCTION VE_retornacoderror_FN(EV_coderrorin IN VARCHAR2, SV_deserror OUT NOCOPY ged_codigos.des_valor%TYPE) RETURN VARCHAR2;
END VE_retornacoderror_PG;
/
SHOW ERRORS
