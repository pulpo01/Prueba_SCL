CREATE OR REPLACE PACKAGE GA_usuamist_u_PG IS

         /*
		<Documentaci�n TipoDoc = "GA_usuamist_u_PG
		<Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="28-06-2005" Versi�n="1.0.0" Dise�ador="Rayen Ceballos" Programador="Roberto P�rez" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripci�n> Encabezado de GA_usuamist_u_PG /Descripci�n>
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

PROCEDURE GA_modificar_PR(EV_numident IN ga_usuamist.num_ident%TYPE,
                          EV_tipident IN ga_usuamist.cod_tipident%TYPE,
					      EV_nomusuario IN ga_usuamist.nom_usuario%TYPE,
					      EN_numabonado IN ga_usuamist.num_abonado%TYPE,
                          SV_error OUT NOCOPY VARCHAR2
					     );
END GA_usuamist_u_PG;
/
SHOW ERRORS
