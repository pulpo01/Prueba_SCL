CREATE OR REPLACE PACKAGE IC_DETALLEMOVIMIENTO_TO_SP_PG
IS
/*
<Documentaci�n
   TipoDoc = "PACKAGE">
   <Elemento
      Nombre = "IC_DETALLEMOVIMIENTO_TO_SP_PG"
	  Lenguaje="PL/SQL"
	  Fecha creaci�n="20-09-2007"
	  Creado por="Juan Gonzalez C."
	  Fecha modificacion=""
	  Modificado por=""
	  Ambiente Desarrollo="BD">
	  <Retorno>N/A</Retorno>
	  <Descripci�n>Rutinas para tabla IC_DETALLEMOVIMIENTO_TO </Descripci�n>
	  <Par�metros>
	     <Entrada>N/A</Entrada>
		 <Salida>N/A</Salida>
      </Par�metros>
   </Elemento>
</Documentaci�n>
*/
    CV_error_no_clasif CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
    CV_cod_modulo CONSTANT VARCHAR2 (2)  := 'SE';
    CV_version CONSTANT VARCHAR2 (3)  := '1.0';

PROCEDURE IC_INSERTA_DETMOV_PR ( EO_DETMOVTO IN OUT NOCOPY IC_DETALLEMOV_TO_QT,
                                                          SN_ERROR OUT NOCOPY NUMBER,
                                                          SV_MENSAJE OUT NOCOPY VARCHAR2,
                                                          SN_EVENTO OUT NOCOPY NUMBER );

END IC_DETALLEMOVIMIENTO_TO_SP_PG;
/
SHOW ERRORS
