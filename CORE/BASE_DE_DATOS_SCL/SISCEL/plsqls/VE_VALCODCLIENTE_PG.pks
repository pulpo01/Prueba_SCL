CREATE OR REPLACE PACKAGE VE_valcodcliente_PG IS

		/*
		<Documentación TipoDoc = "VE_valcodcliente_PG
		<Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="16-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripción> Encabezado de VE_valcodcliente_PG /Descripción>
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

		 PROCEDURE VE_valida_PR(EV_tipident IN ge_clientes.cod_tipident%TYPE, EV_numident IN ge_clientes.num_ident%TYPE,
		                       SN_coderror OUT NOCOPY NUMBER, SV_error OUT NOCOPY VARCHAR2);
END VE_valcodcliente_PG;
/
SHOW ERRORS
