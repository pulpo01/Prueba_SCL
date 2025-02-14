CREATE OR REPLACE PACKAGE IC_PROGRAMACION_SP_PG
IS
/*
<Documentación
   TipoDoc = "PACKAGE">
   <Elemento
      Nombre = "IC_PROGRAMACION_SP_PG"
	  Lenguaje="PL/SQL"
	  Fecha creación="ENE-2008"
	  Creado por="Carlos Sellao H."
	  Fecha modificacion=""
	  Modificado por=""
	  Ambiente Desarrollo="BD">
	  <Retorno>N/A</Retorno>
	  <Descripción>Rutinas para tabla IC_PROGRAMACION_MOVIMIENTO_TO </Descripción>
	  <Parámetros>
	     <Entrada>N/A</Entrada>
		 <Salida>N/A</Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

        CV_error_no_clasif   CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
        CV_cod_modulo        CONSTANT VARCHAR2 (2)  := 'IC';
	    CV_version           CONSTANT VARCHAR2 (3)  := '1.0';
        CN_desbloqueado      CONSTANT NUMBER := 0;
        CN_EstPendActivacion CONSTANT NUMBER := 9;
		CV_DescEstado        CONSTANT VARCHAR2(16) := 'PENDIENTE';

------------------------------------------------------------
PROCEDURE IC_INSERTA_PROGRAMADO_PR ( EN_NUM_MOVIMIENTO IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE,
                                      EN_FEC_ACTIVACION IN DATE,
                                      SN_ERROR OUT NOCOPY NUMBER,
                                      SV_MENSAJE OUT NOCOPY VARCHAR2,
                                      SN_EVENTO OUT NOCOPY NUMBER );

------------------------------------------------------------
PROCEDURE IC_ACTIVA_MOVPROGRAMADO_PR (
                                    SN_LEIDOS OUT NOCOPY NUMBER,
                                    SN_ACTIVADOS OUT NOCOPY NUMBER,
									SN_ERROR OUT NOCOPY NUMBER,
                                    SV_MENSAJE OUT NOCOPY VARCHAR2,
                                    SN_EVENTO OUT NOCOPY NUMBER );

END IC_PROGRAMACION_SP_PG;
/
SHOW ERRORS
