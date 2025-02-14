CREATE OR REPLACE PACKAGE VE_valcodcliente_PG IS

		/*
		<Documentaci�n TipoDoc = "VE_valcodcliente_PG
		<Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="16-06-2005" Versi�n="1.0.0" Dise�ador="Rayen Ceballos" Programador="Roberto P�rez" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripci�n> Encabezado de VE_valcodcliente_PG /Descripci�n>
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

		 PROCEDURE VE_valida_PR(EV_tipident IN ge_clientes.cod_tipident%TYPE, EV_numident IN ge_clientes.num_ident%TYPE,
		                       SN_coderror OUT NOCOPY NUMBER, SV_error OUT NOCOPY VARCHAR2);
END VE_valcodcliente_PG;
/
SHOW ERRORS
