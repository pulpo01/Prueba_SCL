CREATE OR REPLACE PACKAGE BODY GA_usuamist_u_PG IS

PROCEDURE GA_modificar_PR(EV_numident IN ga_usuamist.num_ident%TYPE,
                          EV_tipident IN ga_usuamist.cod_tipident%TYPE,
					      EV_nomusuario IN ga_usuamist.nom_usuario%TYPE,
					      EN_numabonado IN ga_usuamist.num_abonado%TYPE,
                          SV_error OUT NOCOPY VARCHAR2) IS
/*
		<Documentación TipoDoc = GA_Modificar_PR>
		<Elemento Nombre = "PROCEDURE" Lenguaje="PL/SQL" Fecha="28-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD>
		<Retorno>NA</Retorno>
		<Descripción> Modifica GA_USUAMIST</Descripción>
		<Parámetros>
		<Entrada>
		<param nom="EV_numident" Tipo="STRING">Num. Identidad</param>
		<param nom="EV_tipident" Tipo="STRING">Tipo Identidad</param>
		<param nom="EV_numabonado" Tipo="STRING">Num. Abonado</param>
		<param nom="EV_nomusuario" Tipo="STRING">nombre usuario</param>
		</Entrada>
		<Salida>
		<param nom="SV_error" Tipo="STRING">Descripcion de un eventual error en la ejecucion del procedimiento</param>
		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/
BEGIN
		   UPDATE ga_usuamist
		   SET    num_ident=EV_numident,
		   		  cod_tipident=EV_tipident,
				  fec_alta=SYSDATE,
				  nom_usuario=EV_nomusuario
		   WHERE  num_abonado=EN_numabonado;

		   EXCEPTION
		      WHEN OTHERS THEN
			      SV_error:='GA_USUAMIST_U_PG.GA_MODIFICAR_PR ERROR AL ACTUALIZAR GA_USUAMIST ' || TO_CHAR(SQLCODE) ||' ' || SQLERRM;
END GA_modificar_PR;

END GA_usuamist_u_PG;
/
SHOW ERRORS
