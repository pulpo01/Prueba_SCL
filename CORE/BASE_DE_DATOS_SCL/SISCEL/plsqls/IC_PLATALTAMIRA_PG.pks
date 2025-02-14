CREATE OR REPLACE PACKAGE IC_PLATALTAMIRA_PG IS

/*
<Documentacion TipoDoc = "CABECERA">
  <Elemento Nombre = "IC_PLATALTAMIRA_PG" Lenguaje = "PL/SQL" Fecha = "07-03-2005"
    Version = "1.0.0" Dise?ador = "Carlos Sellao" Programador = "Stuver Ca?ete" Ambiente = "Oracle 8i">
    <Descripcion> Funciones parametricas orientadas a la plataforma de prepago AltamirA </Descripcion>
    <Propietarios>
      <Prop>Interfaz con Centrales</Prop>
    </Propietarios>
  </Elemento>
</Documentacion>
*/

----------------------------------------------------------------------------------
-- Variables Globales --
----------------------------------------------------------------------------------

        CN_Err_Cliente CONSTANT NUMBER(3) := 145;
        CN_Err_Ciudad CONSTANT NUMBER(3) := 271;
        CV_Err_NoClasif CONSTANT VARCHAR2(20) := 'Error no Clasificado';
        
----------------------------------------------------------------------------------
-- Funciones.
----------------------------------------------------------------------------------

  FUNCTION IC_UMBRALCADUC_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_MECCONSULTA_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_CAUSANOTIF_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_PERVALIDEZ_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_ORIGENREC_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_PROMOREC_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_IDIOMA_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_CAUSAIDIOMA_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_CBPLAN_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_MercadoContable_FN(EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
END IC_PLATALTAMIRA_PG;
/
SHOW ERRORS
