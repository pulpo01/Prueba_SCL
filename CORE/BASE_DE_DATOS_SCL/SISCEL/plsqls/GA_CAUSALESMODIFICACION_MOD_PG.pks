CREATE OR REPLACE PACKAGE GA_CAUSALESMODIFICACION_MOD_PG AS
  PROCEDURE GA_EXISTE_PR (EN_cod_causa IN NUMBER, LD_fecha IN  DATE, SN_cantidad OUT NOCOPY NUMBER, SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
  ;

END;
/
SHOW ERRORS
