CREATE OR REPLACE PACKAGE IC_PLATHLRNOKIA_PG IS

/*
<Documentaci�n TipoDoc = "CABECERA">
  <Elemento Nombre = "IC_PLATHLRNOKIA_PG" Lenguaje = "PL/SQL" Fecha = "29-07-2005"
    Versi�n = "1.0.0" Dise�ador = "Carlos Sellao" Programador = "Juan Gonzalez" Ambiente = "Oracle 9i">
    <Descripci�n> Funciones param�tricas orientadas a la plataforma HLR Nokia </Descripci�n>
    <Propietarios>
      <Prop>Interfaz con Centrales</Prop>
    </Propietarios>
  </Elemento>
</Documentaci�n>
*/

----------------------------------------------------------------------------------
-- Funciones.
----------------------------------------------------------------------------------
  FUNCTION IC_SERIALNUMBER_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_MSISDN_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;

END IC_PLATHLRNOKIA_PG;
/
SHOW ERRORS
