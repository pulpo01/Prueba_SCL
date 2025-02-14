CREATE OR REPLACE FUNCTION Ge_Fn_Operadora_Tmm
RETURN ge_operadora_scl.cod_operadora_scl%TYPE IS
        cod_operadora ge_operadora_scl.cod_operadora_scl%TYPE;
BEGIN
        SELECT GE_OPERADORATMM INTO cod_operadora
        FROM AL_DATOS_GENERALES;
        RETURN cod_operadora;
END;
/
SHOW ERRORS
