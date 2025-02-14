CREATE OR REPLACE FUNCTION fRecuperSIMCARD_FN (pNUM_SIMCARD in GSM_det_SIMCARD_TO.NUM_SIMCARD%TYPE, pCAMPO in GSM_CAMPOS_TO.COD_CAMPO%TYPE) Return varchar2
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Funcion            : fRecuperSIMCARD_FN
-- * Salida             : Valor del Campo entregado por parametro
-- * Descripcion        : Funcion que retorna el valor del codigo de
-- *                      campo al cual pertenece el ICC
-- * Fecha de creacion  : Noviembre 2002
-- * Responsable        : Jorge Luis Ruz ITS
-- *************************************************************
v_Return GSM_DET_SIMCARD_TO.VAL_CAMPO%type;
v_Usuario GSM_USUARIO_CAMPOS_TO.NOM_USUARIO%type;
v_Operadora GE_OPERADORA_SCL_LOCAL.COD_OPERADORA_SCL%Type;
Err_salida  exception;
BEGIN
     --  JRUZ    21.04.2003   Se Recupera la operadora Local
     --  JRUZ    21.04.2003   Para que el mensaje de Error de retorno dependa de la operadora

    IF NOT (pCAMPO = 'IMSI' ) THEN
		SELECT NOM_USUARIO INTO v_Usuario
		FROM   GSM_USUARIO_CAMPOS_TO
		WHERE  NOM_USUARIO = USER  AND COD_CAMPO = pCAMPO;
    END IF;


	SELECT VAL_CAMPO INTO v_Return
	FROM   GSM_DET_SIMCARD_TO
	WHERE  NUM_SIMCARD=pNUM_SIMCARD AND COD_CAMPO = pCAMPO;

    RETURN v_Return;
EXCEPTION
     WHEN NO_DATA_FOUND   THEN
          RETURN '*';
     WHEN OTHERS THEN
	 	  RETURN '*';
END fRecuperSIMCARD_FN;
/
SHOW ERRORS
