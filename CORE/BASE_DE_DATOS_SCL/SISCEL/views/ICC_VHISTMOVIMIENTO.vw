CREATE OR REPLACE FORCE VIEW ICC_VHISTMOVIMIENTO(
   COD_ACTABO
 , NUM_MOVIMIENTO
 , FEC_HISTORICO
 , NUM_ABONADO
 , COD_ACTUACION
 , NOM_USUARORA
 , COD_ESTADO
 , COD_MODULO
 , COD_CENTRAL_NUE
 , NUM_INTENTOS
 , FEC_INGRESO
 , COD_CENTRAL
 , DES_RESPUESTA
 , FEC_LECTURA
 , COD_ACT
 , NUM_MOVPOS
 , TIP_TERMINAL
 , FEC_EJECUCION
 , TIP_TERMINAL_NUE
 , NUM_CELULAR
 , NUM_SERIE
 , NUM_PERSONAL
 , NUM_CELULAR_NUE
 , NUM_SERIE_NUE
 , NUM_PERSONAL_NUE
 , NUM_MSNB
 , NUM_MSNB_NUE
 , COD_SUSPREHA
 , COD_SERVICIOS
 , NUM_MIN
 , NUM_MIN_NUE
 , STA
 , COD_MENSAJE
 , PARAM1_MENS
 , PARAM2_MENS
 , PARAM3_MENS
 , PLAN
 , CARGA
 , VALOR_PLAN
 , PIN
 , FEC_EXPIRA
 , COD_PIN
 , COD_IDIOMA
 , COD_ENRUTAMIENTO
 , TIP_ENRUTAMIENTO
 , DES_MENSAJE
 , DES_ORIGEN_PIN
 , NUM_LOTE_PIN
 , NUM_SERIE_PIN
 , TIP_TECNOLOGIA
 , IMSI
 , IMSI_NUE
 , IMEI
 , IMEI_NUE
 , ICC
 , ICC_NUE
 ) AS 
SELECT
        COD_ACTABO,
        NUM_MOVIMIENTO,
        FEC_HISTORICO,
        NUM_ABONADO,
        COD_ACTUACION,
        NOM_USUARORA,
        COD_ESTADO,
        COD_MODULO,
        COD_CENTRAL_NUE,
        NUM_INTENTOS,
        FEC_INGRESO,
        COD_CENTRAL,
        DES_RESPUESTA,
        FEC_LECTURA,
        COD_ACT,
        NUM_MOVPOS,
        TIP_TERMINAL,
        FEC_EJECUCION,
        TIP_TERMINAL_NUE,
        NUM_CELULAR,
        NUM_SERIE,
        NUM_PERSONAL,
        NUM_CELULAR_NUE,
        NUM_SERIE_NUE,
        NUM_PERSONAL_NUE,
        NUM_MSNB,
        NUM_MSNB_NUE,
        COD_SUSPREHA,
        COD_SERVICIOS,
        NUM_MIN,
        NUM_MIN_NUE,
        STA,
        COD_MENSAJE,
        PARAM1_MENS,
        PARAM2_MENS,
        PARAM3_MENS,
        PLAN,
        CARGA,
        VALOR_PLAN,
        PIN,
        FEC_EXPIRA,
        COD_PIN,
        COD_IDIOMA,
        COD_ENRUTAMIENTO,
        TIP_ENRUTAMIENTO,
        DES_MENSAJE,
        DES_ORIGEN_PIN,
        NUM_LOTE_PIN,
        NUM_SERIE_PIN,
        TIP_TECNOLOGIA,
        IMSI,
        IMSI_NUE,
        IMEI,
        IMEI_NUE,
        ICC,
        ICC_NUE
FROM SISCEL.ICC_HISTMOV042009
union all
SELECT
        COD_ACTABO,
        NUM_MOVIMIENTO,
        FEC_HISTORICO,
        NUM_ABONADO,
        COD_ACTUACION,
        NOM_USUARORA,
        COD_ESTADO,
        COD_MODULO,
        COD_CENTRAL_NUE,
        NUM_INTENTOS,
        FEC_INGRESO,
        COD_CENTRAL,
        DES_RESPUESTA,
        FEC_LECTURA,
        COD_ACT,
        NUM_MOVPOS,
        TIP_TERMINAL,
        FEC_EJECUCION,
        TIP_TERMINAL_NUE,
        NUM_CELULAR,
        NUM_SERIE,
        NUM_PERSONAL,
        NUM_CELULAR_NUE,
        NUM_SERIE_NUE,
        NUM_PERSONAL_NUE,
        NUM_MSNB,
        NUM_MSNB_NUE,
        COD_SUSPREHA,
        COD_SERVICIOS,
        NUM_MIN,
        NUM_MIN_NUE,
        STA,
        COD_MENSAJE,
        PARAM1_MENS,
        PARAM2_MENS,
        PARAM3_MENS,
        PLAN,
        CARGA,
        VALOR_PLAN,
        PIN,
        FEC_EXPIRA,
        COD_PIN,
        COD_IDIOMA,
        COD_ENRUTAMIENTO,
        TIP_ENRUTAMIENTO,
        DES_MENSAJE,
        DES_ORIGEN_PIN,
        NUM_LOTE_PIN,
        NUM_SERIE_PIN,
        TIP_TECNOLOGIA,
        IMSI,
        IMSI_NUE,
        IMEI,
        IMEI_NUE,
        ICC,
        ICC_NUE
FROM SISCEL.ICC_HISTMOV032009
union all
SELECT
        COD_ACTABO,
        NUM_MOVIMIENTO,
        FEC_HISTORICO,
        NUM_ABONADO,
        COD_ACTUACION,
        NOM_USUARORA,
        COD_ESTADO,
        COD_MODULO,
        COD_CENTRAL_NUE,
        NUM_INTENTOS,
        FEC_INGRESO,
        COD_CENTRAL,
        DES_RESPUESTA,
        FEC_LECTURA,
        COD_ACT,
        NUM_MOVPOS,
        TIP_TERMINAL,
        FEC_EJECUCION,
        TIP_TERMINAL_NUE,
        NUM_CELULAR,
        NUM_SERIE,
        NUM_PERSONAL,
        NUM_CELULAR_NUE,
        NUM_SERIE_NUE,
        NUM_PERSONAL_NUE,
        NUM_MSNB,
        NUM_MSNB_NUE,
        COD_SUSPREHA,
        COD_SERVICIOS,
        NUM_MIN,
        NUM_MIN_NUE,
        STA,
        COD_MENSAJE,
        PARAM1_MENS,
        PARAM2_MENS,
        PARAM3_MENS,
        PLAN,
        CARGA,
        VALOR_PLAN,
        PIN,
        FEC_EXPIRA,
        COD_PIN,
        COD_IDIOMA,
        COD_ENRUTAMIENTO,
        TIP_ENRUTAMIENTO,
        DES_MENSAJE,
        DES_ORIGEN_PIN,
        NUM_LOTE_PIN,
        NUM_SERIE_PIN,
        TIP_TECNOLOGIA,
        IMSI,
        IMSI_NUE,
        IMEI,
        IMEI_NUE,
        ICC,
        ICC_NUE
FROM SISCEL.ICC_HISTMOV022009
union all
SELECT
        COD_ACTABO,
        NUM_MOVIMIENTO,
        FEC_HISTORICO,
        NUM_ABONADO,
        COD_ACTUACION,
        NOM_USUARORA,
        COD_ESTADO,
        COD_MODULO,
        COD_CENTRAL_NUE,
        NUM_INTENTOS,
        FEC_INGRESO,
        COD_CENTRAL,
        DES_RESPUESTA,
        FEC_LECTURA,
        COD_ACT,
        NUM_MOVPOS,
        TIP_TERMINAL,
        FEC_EJECUCION,
        TIP_TERMINAL_NUE,
        NUM_CELULAR,
        NUM_SERIE,
        NUM_PERSONAL,
        NUM_CELULAR_NUE,
        NUM_SERIE_NUE,
        NUM_PERSONAL_NUE,
        NUM_MSNB,
        NUM_MSNB_NUE,
        COD_SUSPREHA,
        COD_SERVICIOS,
        NUM_MIN,
        NUM_MIN_NUE,
        STA,
        COD_MENSAJE,
        PARAM1_MENS,
        PARAM2_MENS,
        PARAM3_MENS,
        PLAN,
        CARGA,
        VALOR_PLAN,
        PIN,
        FEC_EXPIRA,
        COD_PIN,
        COD_IDIOMA,
        COD_ENRUTAMIENTO,
        TIP_ENRUTAMIENTO,
        DES_MENSAJE,
        DES_ORIGEN_PIN,
        NUM_LOTE_PIN,
        NUM_SERIE_PIN,
        TIP_TECNOLOGIA,
        IMSI,
        IMSI_NUE,
        IMEI,
        IMEI_NUE,
        ICC,
        ICC_NUE
FROM SISCEL.ICC_HISTMOV012009
union all
SELECT
        COD_ACTABO,
        NUM_MOVIMIENTO,
        FEC_HISTORICO,
        NUM_ABONADO,
        COD_ACTUACION,
        NOM_USUARORA,
        COD_ESTADO,
        COD_MODULO,
        COD_CENTRAL_NUE,
        NUM_INTENTOS,
        FEC_INGRESO,
        COD_CENTRAL,
        DES_RESPUESTA,
        FEC_LECTURA,
        COD_ACT,
        NUM_MOVPOS,
        TIP_TERMINAL,
        FEC_EJECUCION,
        TIP_TERMINAL_NUE,
        NUM_CELULAR,
        NUM_SERIE,
        NUM_PERSONAL,
        NUM_CELULAR_NUE,
        NUM_SERIE_NUE,
        NUM_PERSONAL_NUE,
        NUM_MSNB,
        NUM_MSNB_NUE,
        COD_SUSPREHA,
        COD_SERVICIOS,
        NUM_MIN,
        NUM_MIN_NUE,
        STA,
        COD_MENSAJE,
        PARAM1_MENS,
        PARAM2_MENS,
        PARAM3_MENS,
        PLAN,
        CARGA,
        VALOR_PLAN,
        PIN,
        FEC_EXPIRA,
        COD_PIN,
        COD_IDIOMA,
        COD_ENRUTAMIENTO,
        TIP_ENRUTAMIENTO,
        DES_MENSAJE,
        DES_ORIGEN_PIN,
        NUM_LOTE_PIN,
        NUM_SERIE_PIN,
        TIP_TECNOLOGIA,
        IMSI,
        IMSI_NUE,
        IMEI,
        IMEI_NUE,
        ICC,
        ICC_NUE
FROM SISCEL.ICC_HISTMOV122008
union all
SELECT
        COD_ACTABO,
        NUM_MOVIMIENTO,
        FEC_HISTORICO,
        NUM_ABONADO,
        COD_ACTUACION,
        NOM_USUARORA,
        COD_ESTADO,
        COD_MODULO,
        COD_CENTRAL_NUE,
        NUM_INTENTOS,
        FEC_INGRESO,
        COD_CENTRAL,
        DES_RESPUESTA,
        FEC_LECTURA,
        COD_ACT,
        NUM_MOVPOS,
        TIP_TERMINAL,
        FEC_EJECUCION,
        TIP_TERMINAL_NUE,
        NUM_CELULAR,
        NUM_SERIE,
        NUM_PERSONAL,
        NUM_CELULAR_NUE,
        NUM_SERIE_NUE,
        NUM_PERSONAL_NUE,
        NUM_MSNB,
        NUM_MSNB_NUE,
        COD_SUSPREHA,
        COD_SERVICIOS,
        NUM_MIN,
        NUM_MIN_NUE,
        STA,
        COD_MENSAJE,
        PARAM1_MENS,
        PARAM2_MENS,
        PARAM3_MENS,
        PLAN,
        CARGA,
        VALOR_PLAN,
        PIN,
        FEC_EXPIRA,
        COD_PIN,
        COD_IDIOMA,
        COD_ENRUTAMIENTO,
        TIP_ENRUTAMIENTO,
        DES_MENSAJE,
        DES_ORIGEN_PIN,
        NUM_LOTE_PIN,
        NUM_SERIE_PIN,
        TIP_TECNOLOGIA,
        IMSI,
        IMSI_NUE,
        IMEI,
        IMEI_NUE,
        ICC,
        ICC_NUE
FROM SISCEL.ICC_HISTMOV112008
/
SHOW ERRORS
