CREATE OR REPLACE PACKAGE IC_CONS_SERVCM_PG
IS
/*
<Documentaci�n
   TipoDoc = "PACKAGE">
   <Elemento
      Nombre = "IC_CONS_SERVCM_PG"
	  Lenguaje="PL/SQL"
	  Fecha creaci�n="10-09-2007"
	  Creado por="Juan Gonzalez C."
	  Fecha modificacion=""
	  Modificado por=""
	  Ambiente Desarrollo="BD">
	  <Retorno>N/A</Retorno>
	  <Descripci�n> Rutinas para validar servicios de IC</Descripci�n>
	  <Par�metros>
	     <Entrada>N/A</Entrada>
		 <Salida>N/A</Salida>
      </Par�metros>
   </Elemento>
</Documentaci�n>
*/
    CV_Cod_Modulo CONSTANT VARCHAR2 (2)  := 'IC';
    CV_Version CONSTANT VARCHAR2 (3)  := '1.0';
    CV_Tab_Blackberry CONSTANT VARCHAR2 (14)  := 'SRV_BLACKBERRY';
    CV_Tab_CorreoMov CONSTANT VARCHAR2 (14)  := 'SRV_CORREO_MOV';
FUNCTION IC_CONS_BLACKBERRY_FN (V_Num_Movimiento  IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2;

FUNCTION IC_CONS_CORREOMOVIL_FN (V_Num_Movimiento  IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2;

END IC_CONS_SERVCM_PG;
/
SHOW ERRORS
