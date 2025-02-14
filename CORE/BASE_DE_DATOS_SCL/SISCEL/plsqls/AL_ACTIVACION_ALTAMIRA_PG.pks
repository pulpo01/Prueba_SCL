CREATE OR REPLACE PACKAGE AL_ACTIVACION_ALTAMIRA_PG AS
    CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
    CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'AL';
    CV_version              CONSTANT VARCHAR2 (2)  := '1';
    CV_cod_modulo_GA        CONSTANT VARCHAR2 (2)  := 'GA';
    CV_cod_producto         CONSTANT NUMBER(1)     := 1;
    
    PROCEDURE AL_ASIGNA_SERIE_PR(SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 SN_num_evento   OUT NOCOPY ge_errores_pg.evento);
END;
/
SHOW ERRORS