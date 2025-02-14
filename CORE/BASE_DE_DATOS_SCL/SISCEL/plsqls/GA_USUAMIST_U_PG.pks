CREATE OR REPLACE PACKAGE GA_usuamist_u_PG IS

         /*
		<Documentación TipoDoc = "GA_usuamist_u_PG
		<Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="28-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripción> Encabezado de GA_usuamist_u_PG /Descripción>
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

PROCEDURE GA_modificar_PR(EV_numident IN ga_usuamist.num_ident%TYPE,
                          EV_tipident IN ga_usuamist.cod_tipident%TYPE,
					      EV_nomusuario IN ga_usuamist.nom_usuario%TYPE,
					      EN_numabonado IN ga_usuamist.num_abonado%TYPE,
                          SV_error OUT NOCOPY VARCHAR2
					     );
END GA_usuamist_u_PG;
/
SHOW ERRORS
