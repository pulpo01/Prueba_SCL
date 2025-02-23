CREATE OR REPLACE TRIGGER AUD_COCAT_AFIN_TG
AFTER INSERT ON CO_CATEGORIAS_TD
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
        N_RESPUESTA NUMBER;
        ERROR_PROCESO EXCEPTION;
    V_ID_REGISTRO VARCHAR2(300);
    V_DETALLE VARCHAR2(2000);
BEGIN
V_ID_REGISTRO := :new.COD_CATEGORIA;
V_DETALLE :=  :new.COD_CATEGORIA||','||:new.DES_CATEGORIA||','|| :new.COD_TASA||','|| :new.NRO_DGRACIA;
N_RESPUESTA := AUD_AUDITORIA_PG.AUD_REGISTRA_AUDITORIA_FN ('SISCEL','CO_CATEGORIAS_TD','INSERT',V_ID_REGISTRO,V_DETALLE);
EXCEPTION
        WHEN ERROR_PROCESO THEN
           null;
END AUD_COCAT_AFIN_TR;
/
SHOW ERRORS
