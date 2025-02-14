CREATE OR REPLACE PACKAGE IC_RET_RESPUESTA_PG  IS
/*
<Documentaci�n
        TipoDoc = "Package">
        <Elemento
                Nombre = "IC_SECUENCIA_PROVISION_PG"
                Lenguaje="PL/SQL"
                Fecha creaci�n="02-2008"
                Creado por=""
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>N/A</Retorno>
                <Descripci�n>Funciones para permitir secuencialidad del masivo en IC</Descripci�n>
                <Par�metros>
                        <Entrada>N/A</Entrada>
                        <Salida>N/A</Salida>
                </Par�metros>
        </Elemento>
</Documentaci�n>
*/
  CV_NoData        CONSTANT VARCHAR2(2) := '0';
  CV_RETORNO       STRING(255) :='empty:SE POSTERGA EL ENVIO';
  CV_isOK          VARCHAR2(10) := 'OK';
  CV_Err_NoClasif  VARCHAR2(25) := 'Error no Clasificado';
  FUNCTION IC_RETRESP_SALDO_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_RETSS_ABONADO_FN(EN_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_RETSS_MOVIMIENTO_FN(EN_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_RETSS_ABO_FN(EN_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_SUSP_ABO_FN(EN_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;  
END IC_RET_RESPUESTA_PG;
/
SHOW ERRORS
