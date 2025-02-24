CREATE OR REPLACE FUNCTION CO_OBTIENE_CELULAR_CLIENTE_FN(EN_codcliente GE_CLIENTES.COD_CLIENTE%TYPE) RETURN GA_ABOCEL.NUM_CELULAR%TYPE  IS
LN_numcelular GA_ABOCEL.NUM_CELULAR%TYPE;

BEGIN

    SELECT NVL(min(NUM_CELULAR),0) 
    INTO LN_numcelular
    FROM GA_ABOCEL
    WHERE COD_CLIENTE = EN_codcliente
    AND COD_SITUACION != 'BAA';
    
    RETURN LN_numcelular;
    
    EXCEPTION
    WHEN OTHERS THEN
       RETURN 0;
    END;
/
SHOW ERRORS