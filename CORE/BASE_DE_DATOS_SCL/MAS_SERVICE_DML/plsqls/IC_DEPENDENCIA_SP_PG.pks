CREATE OR REPLACE PACKAGE IC_DEPENDENCIA_SP_PG
IS
/*
<Documentación
   TipoDoc = "PACKAGE">
   <Elemento
      Nombre = "IC_DEPENDENCIA_SP_PG"
	  Lenguaje="PL/SQL"
	  Fecha creación="ENE-2008"
	  Creado por="Carlos Sellao H."
	  Fecha modificacion=""
	  Modificado por=""
	  Ambiente Desarrollo="BD">
	  <Retorno>N/A</Retorno>
	  <Descripción>Rutinas para tabla IC_MOVIMIENTO_DEPENDIENTE_TO </Descripción>
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
        CN_Err_Abo           CONSTANT NUMBER(3) := 203;

------------------------------------------------------------
PROCEDURE IC_INSERTA_DEPENDENCIA_PR ( EN_NUM_MOVIMIENTO IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE,
                                      EN_NUM_MOVANT IN ICC_MOVIMIENTO.NUM_MOVANT%TYPE,
                                      SN_ERROR OUT NOCOPY NUMBER,
                                      SV_MENSAJE OUT NOCOPY VARCHAR2,
                                      SN_EVENTO OUT NOCOPY NUMBER );

------------------------------------------------------------
PROCEDURE IC_ACTIVA_DEPENDIENTE_PR (
                                    SN_LEIDOS OUT NOCOPY NUMBER,
                                    SN_ACTIVADOS OUT NOCOPY NUMBER,
									SN_ERROR OUT NOCOPY NUMBER,
                                    SV_MENSAJE OUT NOCOPY VARCHAR2,
                                    SN_EVENTO OUT NOCOPY NUMBER );

------------------------------------------------------------
FUNCTION IC_VALIDA_DEPENDENCIA_FN(
        EN_num_movant IN icc_movimiento.num_movant%TYPE
		) RETURN STRING;

END IC_DEPENDENCIA_SP_PG;
/
SHOW ERRORS
