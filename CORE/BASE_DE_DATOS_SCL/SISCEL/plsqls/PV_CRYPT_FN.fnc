CREATE OR REPLACE FUNCTION          "PV_CRYPT_FN" (pvParametro IN VARCHAR2)
RETURN VARCHAR2
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Funcion            : PV_CRYPT_FN
-- * Salida             : VARCHAR2
-- * Descripcion        : Devuelve el valor del parametro encriptado
-- * Fecha de creacion  : 09-01-2003 18:11
-- * Responsable        : Area Postventa
-- *************************************************************
        j NUMBER(3);
        vSalida VARCHAR2(100);
        operadora GE_OPERADORA_SCL_LOCAL.COD_OPERADORA_SCL%type;
BEGIN
        vSalida := '';
        SELECT COD_OPERADORA_SCL INTO operadora FROM GE_OPERADORA_SCL_LOCAL;
        FOR j IN 1..LENGTH(pvParametro) LOOP
                vSalida := vSalida || CHR(ASCII(SUBSTR(operadora,j,1)) ) ||CHR(ASCII(SUBSTR(pvParametro,j,1)) + j)||CHR(ASCII(SUBSTR(pvParametro, j, 1)) - j);
        END LOOP;
        return vSalida;
END;
/
SHOW ERRORS
