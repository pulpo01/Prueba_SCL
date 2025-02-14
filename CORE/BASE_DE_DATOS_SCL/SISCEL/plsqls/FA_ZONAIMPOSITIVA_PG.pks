CREATE OR REPLACE PACKAGE FA_ZONAIMPOSITIVA_PG IS
---------------------------------------------PROCEDIMIENTOS--------------------------------------------------
    PROCEDURE FA_RESPALDO_PR(
        EV_cod_ciclfact   IN NUMBER,
        EV_host_id        IN VARCHAR2);
-------------------------------------------------------------------------------------------------------------
    PROCEDURE FA_AGRUPACION_PR(
        EV_fec_emision    IN DATE,
        EV_cod_ciclfact   IN NUMBER,
        EN_ExisteRango    IN NUMBER,
        EN_ClienteInicial IN NUMBER,
        EN_ClienteFinal   IN NUMBER);
-------------------------------------------------------------------------------------------------------------
END;
/
SHOW ERRORS
