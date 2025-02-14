CREATE OR REPLACE PACKAGE IC_PLATHLRNOKIA_PG IS

/*
<Documentación TipoDoc = "CABECERA">
  <Elemento Nombre = "IC_PLATHLRNOKIA_PG" Lenguaje = "PL/SQL" Fecha = "29-07-2005"
    Versión = "1.0.0" Diseñador = "Carlos Sellao" Programador = "Juan Gonzalez" Ambiente = "Oracle 9i">
    <Descripción> Funciones paramétricas orientadas a la plataforma HLR Nokia </Descripción>
    <Propietarios>
      <Prop>Interfaz con Centrales</Prop>
    </Propietarios>
  </Elemento>
</Documentación>
*/

----------------------------------------------------------------------------------
-- Funciones.
----------------------------------------------------------------------------------
  FUNCTION IC_SERIALNUMBER_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_MSISDN_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;

END IC_PLATHLRNOKIA_PG;
/
SHOW ERRORS
