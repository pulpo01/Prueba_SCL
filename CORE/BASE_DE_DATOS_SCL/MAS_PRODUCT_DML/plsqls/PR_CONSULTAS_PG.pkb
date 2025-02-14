CREATE OR REPLACE PACKAGE BODY PR_CONSULTAS_PG AS
PROCEDURE FA_SEL_FA_CONCEPTOS_PR
(
EN_COD_CONCEPTO	   IN NUMBER,
EV_TIP_CONCEPTO    IN VARCHAR2,
SO_Lista 		   OUT NOCOPY	 refCursor
)
IS
LV_des_error       ge_errores_pg.DesEvent;
LV_sSql            ge_errores_pg.vQuery;
EO_Fa_Conceptos	   FA_CONCEPTOS_SP_PG.TipRegconceptos;
SN_COD_RETORNO     NUMBER;
SV_MENS_RETORNO    VARCHAR2(200);
SN_NUM_EVENTO 	   NUMBER;
BEGIN
  SN_COD_RETORNO := NULL;
  SV_MENS_RETORNO := NULL;
  SN_NUM_EVENTO := NULL;

  EO_Fa_Conceptos.cod_concepto := EN_cod_concepto;
  EO_Fa_Conceptos.cod_tipconce := EV_tip_concepto;
  FA_CONCEPTOS_SP_PG.FA_SEL_FA_CONCEPTOS_PR ( EO_FA_CONCEPTOS, SO_LISTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );
END;

PROCEDURE VE_SEL_VE_VENDEALER_PR (
VALOR              IN NUMBER,
SO_Lista 		   OUT NOCOPY	 refCursor
)
IS
LV_des_error       ge_errores_pg.DesEvent;
LV_sSql            ge_errores_pg.vQuery;
EO_Fa_Conceptos	   FA_CONCEPTOS_SP_PG.TipRegconceptos;
SN_COD_RETORNO     NUMBER;
SV_MENS_RETORNO    VARCHAR2(200);
SN_NUM_EVENTO 	   NUMBER;
BEGIN
  SN_COD_RETORNO := NULL;
  SV_MENS_RETORNO := NULL;
  SN_NUM_EVENTO := NULL;
  VE_SELECCIONAR_TABLAS_PG.VE_SEL_VE_VENDEALER_PR (SO_LISTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );
END;

PROCEDURE VE_SEL_GE_MONEDAS_PR (
VALOR              IN NUMBER,
SO_Lista 		   OUT NOCOPY	 refCursor
)
IS
LV_des_error       ge_errores_pg.DesEvent;
LV_sSql            ge_errores_pg.vQuery;
EO_Fa_Conceptos	   FA_CONCEPTOS_SP_PG.TipRegconceptos;
SN_COD_RETORNO     NUMBER;
SV_MENS_RETORNO    VARCHAR2(200);
SN_NUM_EVENTO 	   NUMBER;
BEGIN
  SN_COD_RETORNO := NULL;
  SV_MENS_RETORNO := NULL;
  SN_NUM_EVENTO := NULL;
  VE_SELECCIONAR_TABLAS_PG.VE_SEL_GE_MONEDAS_PR (SO_LISTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );
END;
PROCEDURE GE_FECHA_HORA_PR
(
SD_FECHA_HORA    OUT NOCOPY      VARCHAR2,--DATE,
SN_COD_RETORNO   OUT NOCOPY  NUMBER,
SV_MENS_RETORNO  OUT NOCOPY  VARCHAR2,
SN_NUM_EVENTO    OUT NOCOPY  NUMBER
)
IS
LV_des_error       ge_errores_pg.DesEvent;
LV_sSql                    ge_errores_pg.vQuery;

BEGIN
  SN_COD_RETORNO := 0;
  SV_MENS_RETORNO := NULL;
  SN_NUM_EVENTO := 0;

  LV_sSql := 'SELECT TO_CHAR(SYSDATE,''YYYY-MM-DD HH24:MI:SS'') FROM DUAL';

  SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') INTO SD_FECHA_HORA FROM DUAL;

EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := 'No es Posible Clasificar el error';
              END IF;
                  LV_des_error   := 'Error al obtener fecha y hora - '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GE', SV_mens_retorno, '1', USER, 'GE_FECHA_HORA_PR_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END GE_FECHA_HORA_PR;

END PR_CONSULTAS_PG;
/
SHOW ERROR