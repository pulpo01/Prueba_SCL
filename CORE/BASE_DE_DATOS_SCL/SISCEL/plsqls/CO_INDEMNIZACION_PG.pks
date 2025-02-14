CREATE OR REPLACE PACKAGE Co_Indemnizacion_Pg IS

FUNCTION CO_RETORNA_VERSION_GENERAL_FN RETURN VARCHAR2;

PROCEDURE CO_INDEMNIZACION_PR (
        EN_cod_cliente    IN NUMBER,
        EN_num_abonado    IN NUMBER,
        EV_cod_modulo    IN VARCHAR2,
        EN_cod_producto    IN NUMBER,
        EN_cod_retorno    IN OUT NOCOPY NUMBER,
        EN_des_retorno    IN OUT NOCOPY VARCHAR2
);

END Co_Indemnizacion_Pg;
/
SHOW ERRORS
