CREATE OR REPLACE PACKAGE ga_aboamist_u_PG IS

        /*
		<Documentaci�n TipoDoc = "ga_aboamist_u_PG
		<Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="28-06-2005" Versi�n="1.0.0" Dise�ador="Rayen Ceballos" Programador="Roberto P�rez" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripci�n> Encabezado de VE_GA_ABOAMIST_U_PG /Descripci�n>
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
