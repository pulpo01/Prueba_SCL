CREATE OR REPLACE PACKAGE GA_INT_LISTAS_NEGRAS_PG
IS
   TYPE refCursor IS REF CURSOR;
   TYPE TIP_GA_LNCELU IS TABLE OF GA_LNCELU%ROWTYPE INDEX BY PLS_INTEGER;
   TYPE TIP_ga_series_ln_oop_to IS TABLE OF ga_series_ln_oop_to%ROWTYPE INDEX BY PLS_INTEGER;
   TYPE TIP_ICC_MOVIMIENTO IS TABLE OF  ICC_MOVIMIENTO%ROWTYPE            INDEX BY PLS_INTEGER;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GE';
   CV_version              CONSTANT VARCHAR2 (3)  := '1.0';
   CN_accion_ingreso       CONSTANT NUMBER        := 1;
   CN_accion_egreso        CONSTANT NUMBER        := 0;
   CN_estado_valido        CONSTANT NUMBER        := 0;
   CN_error_registro       CONSTANT NUMBER        := 1;
   CN_error_duplicado      CONSTANT NUMBER        := 2;
   CN_error_ingreso        CONSTANT NUMBER        := 3;
   CN_error_egreso         CONSTANT NUMBER        := 4;
   CN_error_vacio          CONSTANT NUMBER        := 5;
   CN_error_exscl          CONSTANT NUMBER        := 6;
   CV_error_ingreso        CONSTANT VARCHAR2(100) := 'Serie ya existe en listas negras, no es posible aplicar Ingreso.';
   CV_error_egreso         CONSTANT VARCHAR2(100) := 'Serie no existe en listas negras, no es posible aplicar Egreso.';
   CV_error_registro       CONSTANT VARCHAR2(100) := 'Formato de registro inválido';
   CV_error_duplicado      CONSTANT VARCHAR2(100) := 'Registro duplicado';
   CV_error_vacio          CONSTANT VARCHAR2(100) := 'Registro vacío';
   CV_situa_baa            CONSTANT VARCHAR2(3)   := 'BAA';
   CV_tip_abocont          CONSTANT VARCHAR2(1)   := 'C';
   CN_cero                 CONSTANT NUMBER        := 0;
   CN_cod_operador         CONSTANT NUMBER        := 0;
   CV_error_exscl          CONSTANT VARCHAR2(100) := 'Registro no existe en SCL';
   CV_pendiente            CONSTANT VARCHAR2(10)  := 'PENDIENTE';
   CV_modulo_li            CONSTANT VARCHAR2(2)   := 'LI';
   CV_modulo_le            CONSTANT VARCHAR2(2)   := 'LE';

   CV_tip_listaB           CONSTANT VARCHAR2(1)   := 'B';

----------------------------------------------------------------------------------
FUNCTION GA_REC_SERIE_ING_FN   (EM_TABLA              OUT NOCOPY TIP_ICC_MOVIMIENTO,
                                EN_NUM_SERIE          IN  ga_lncelu.num_serie%TYPE,
                                ED_FEC_ALTA           IN  DATE,
                                SN_COD_ERROR          OUT NOCOPY NUMBER,
                                SV_MENS_RETORNO       OUT NOCOPY VARCHAR2,
                                SV_SQL                OUT NOCOPY VARCHAR2
) RETURN BOOLEAN;


FUNCTION GA_REG_MOVIMIENTO_FN (EM_TABLA         IN  TIP_ICC_MOVIMIENTO,
                               SN_COD_ERROR       OUT NOCOPY NUMBER,
                               SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
                               SV_SQL                 OUT NOCOPY VARCHAR2
) RETURN BOOLEAN;

PROCEDURE GA_VAL_EXISTS_SCL_LN_PR(EN_COD_PROCESO  IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                  sn_cod_retorno  OUT NOCOPY      ge_errores_pg.CodError,
                                  sv_mens_retorno OUT NOCOPY      ge_errores_pg.MsgError,
                                  sn_num_evento   OUT NOCOPY      ge_errores_pg.Evento);

PROCEDURE GA_VAL_EXISTS_SERIE_LN_PR(EN_COD_PROCESO  IN  ga_series_ln_oop_to.cod_proceso%TYPE,
                                SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento );

PROCEDURE GA_VAL_DUPLIC_SERIE_LN_PR(EN_COD_PROCESO  IN  ga_series_ln_oop_to.cod_proceso%TYPE,
                                SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento );

FUNCTION GA_REC_SECUENCIA_FN (EV_NOM_SECUENCIA IN VARCHAR2) RETURN NUMBER;

FUNCTION GA_CONTADOR_VAL_FN (EV_NOM_SECUENCIA IN VARCHAR2) RETURN NUMBER;

FUNCTION GA_CONTADOR_INV_FN (EV_NOM_SECUENCIA IN VARCHAR2) RETURN NUMBER;

PROCEDURE GA_INS_SERIE_LN_TEMP_PR(EN_COD_PROCESO    IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                EN_CAMPO_1          IN              ga_series_ln_oop_to.campo_1%TYPE,
                                EN_CAMPO_2          IN              ga_series_ln_oop_to.campo_2%TYPE,
                                EN_CAMPO_3          IN              ga_series_ln_oop_to.campo_3%TYPE,
                                EN_CAMPO_4          IN              ga_series_ln_oop_to.campo_4%TYPE,
                                EN_CAMPO_5          IN              ga_series_ln_oop_to.campo_5%TYPE,
                                EN_CAMPO_6          IN              ga_series_ln_oop_to.campo_6%TYPE,
                                EN_CAMPO_7          IN              ga_series_ln_oop_to.campo_7%TYPE,
                                EN_CAMPO_8          IN              ga_series_ln_oop_to.campo_8%TYPE,
                                EN_CAMPO_9          IN              ga_series_ln_oop_to.campo_9%TYPE,
                                EN_COD_ESTADO       IN              ga_series_ln_oop_to.cod_estado%TYPE,
                                EN_DES_ERROR        IN              ga_series_ln_oop_to.des_error%TYPE,
                                EN_INDICE           IN              ga_series_ln_oop_to.indice%TYPE,
                                SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento );

PROCEDURE GA_BUSCAR_LN_VALIDAS_PR(EN_COD_PROCESO    IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                SC_DATOS_SERIES_LN  OUT NOCOPY      refCursor);

PROCEDURE GA_BUSCAR_LN_NOVALIDAS_PR(EN_COD_PROCESO  IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                SC_DATOS_SERIES_LN  OUT NOCOPY      refCursor);

PROCEDURE GA_DEL_SERIES_LN_TMP_PR(EN_COD_PROCESO    IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento );

PROCEDURE GA_EJECUTA_SERIES_LN_PR(EN_COD_PROCESO    IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                  EV_COD_CAUSA        IN              GA_CAUSAEIR_TO.COD_CAUSA%TYPE,
                                  EV_COD_TIPOLISTA    IN              GA_CAUSAEIR_TO.COD_TIPOLISTA%TYPE,
                                  EV_COD_OS           IN              GA_CAUSAEIR_TO.COD_OS%TYPE,
                                  EV_COD_ORIGEN       IN              GA_CAUSAEIR_TO.ORIG_TRANS%TYPE,
                                  SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                  SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                  SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento );

FUNCTION GA_DEL_SERIES_EG_FN(EN_COD_PROCESO      IN   ga_series_ln_oop_to.cod_proceso%TYPE,
                            SN_COD_ERROR         OUT ge_errores_pg.CodError,
                            SV_MENS_RETORNO      OUT ge_errores_pg.MsgError,
                            SV_SQL               OUT ge_errores_pg.vQuery
) RETURN BOOLEAN;

PROCEDURE GA_BUSCAR_LN_VAL_MISMA_PR(EN_COD_PROCESO           IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                    SC_DATOS_MISMASERIES_LN  OUT NOCOPY      refCursor);

PROCEDURE GA_EJECUTA_SERIES_LN_SCL_PR(EN_COD_PROCESO      IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                      EV_TIPO             IN              ga_lncelu.tip_lista%TYPE,
                                      EV_COD_OPERADORA    IN              ga_lncelu.cod_operador%TYPE,
                                      EV_COD_CAUSA        IN              GA_CAUSAEIR_TO.COD_CAUSA%TYPE,
                                      EV_COD_TIPOLISTA    IN              GA_CAUSAEIR_TO.COD_TIPOLISTA%TYPE,
                                      EV_COD_OS           IN              GA_CAUSAEIR_TO.COD_OS%TYPE,
                                      EV_COD_ORIGEN       IN              GA_CAUSAEIR_TO.ORIG_TRANS%TYPE,
                                      SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                      SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                      SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento );

PROCEDURE GA_INSCRIBE_MOV_LN_PR(EN_NUM_SERIE             IN              ga_lncelu.num_serie%TYPE,
                                ED_FEC_ALTA              IN              DATE,
                                SV_MENS_RETORNO          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO            OUT NOCOPY      ge_errores_pg.evento);

PROCEDURE GA_INSCRIBE_CAUSALISTA_PR(       EN_COD_PROCESO           IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                           EV_COD_CAUSA             IN              GA_CAUSAEIR_TO.COD_CAUSA%TYPE,
                                           EV_COD_TIPOLISTA         IN              GA_CAUSAEIR_TO.COD_TIPOLISTA%TYPE,
                                           EV_COD_OS                IN              GA_CAUSAEIR_TO.COD_OS%TYPE,
                                           EN_ORIGEN                IN              GA_CAUSAEIR_TO.ORIG_TRANS%TYPE,
                                           EN_COD_ESTADO        IN              GA_CAUSAEIR_TO.COD_ESTADO%TYPE,
                                           SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                           SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                           SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento);


PROCEDURE GA_HISTORICO_CAUSALISTA_PR(      EN_COD_PROCESO           IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                           EV_COD_CAUSA             IN              GA_CAUSAEIR_TO.COD_CAUSA%TYPE,
                                           EV_COD_TIPOLISTA         IN              GA_CAUSAEIR_TO.COD_TIPOLISTA%TYPE,
                                           EV_COD_OS                IN              GA_CAUSAEIR_TO.COD_OS%TYPE,
                                           EN_ORIGEN                IN              GA_CAUSAEIR_TO.ORIG_TRANS%TYPE,
                                           EN_COD_ESTADO        IN              GA_CAUSAEIR_TO.COD_ESTADO%TYPE,
                                           SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                           SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                           SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento);

PROCEDURE GA_VALIDA_LUHN_PR(               EN_NUM_SECUENCIA            IN      GA_TRANSACABO.NUM_TRANSACCION%TYPE,
                                           EV_NUM_IMEI                 IN      GA_LNCELU.NUM_SERIE%TYPE,
                                           SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                           SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                           SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento);
FUNCTION GA_VALIDA_EXIST_ICC_FN (EV_COD_ACTABO        IN  icc_movimiento.COD_ACTABO%type,
                                EN_ABONADO            IN  icc_movimiento.NUM_ABONADO%type,
                                EV_IMEI               IN  icc_movimiento.IMEI%type,
                                SN_COD_ERROR          OUT NOCOPY ge_errores_pg.CodError,
                                SV_MENS_RETORNO       OUT NOCOPY ge_errores_pg.MsgError,
                                SV_SQL                OUT NOCOPY VARCHAR2
) RETURN BOOLEAN;

FUNCTION GA_VAL_INDRESTRIC_FN (EV_IMEI               IN  icc_movimiento.IMEI%type,
                               SN_COD_ERROR       OUT NOCOPY NUMBER,
                               SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
                               SV_SQL                 OUT NOCOPY VARCHAR2)RETURN INTEGER;

END GA_INT_LISTAS_NEGRAS_PG;
/
SHOW ERRORS