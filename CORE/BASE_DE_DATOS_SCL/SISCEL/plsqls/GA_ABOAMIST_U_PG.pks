CREATE OR REPLACE PACKAGE ga_aboamist_u_PG IS

        /*
		<Documentación TipoDoc = "ga_aboamist_u_PG
		<Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="28-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripción> Encabezado de VE_GA_ABOAMIST_U_PG /Descripción>
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

PROCEDURE GA_modificar_PR(EV_codcliente IN ge_clientes.cod_cliente%TYPE,
					      EV_codcuenta IN ga_cuentas.cod_cuenta%TYPE,
					      EV_codvendedor IN ga_aboamist.cod_vendedor%TYPE,
					      EV_numventa IN ga_aboamist.num_venta%TYPE,
					      EV_numabonado IN ga_aboamist.num_abonado%TYPE,
					      EV_codusuario IN ga_aboamist.cod_usuario%TYPE,
					      SV_error OUT NOCOPY VARCHAR2
                         );
END ga_aboamist_u_PG;
/
SHOW ERRORS
