CREATE OR REPLACE FORCE VIEW TA_TARIFICADAS(
   NUM_ROWID
 , COD_TIPCENTRAL
 , COD_CENTRAL
 , NUM_BLOQUE
 , FEC_INITASA
 , COD_CLIENTE
 , NUM_ABONADO
 , IND_ALQUILER
 , IND_LIMFRA
 , COD_PERIODO
 , NUM_MOVIL1
 , NUM_MOVIL2
 , COD_ALM
 , TIE_INILLAM
 , TIE_INISEND
 , TIE_INIANSW
 , TIE_DURSEND
 , TIE_DURANSW
 , FEC_FINLLAM
 , COD_RUTAA
 , COD_RUTAOPE
 , COD_RUTAALM
 , COD_RUTACELDA
 , COD_RUTATOPE
 , IND_RUTA
 , COD_RUTAB
 , COD_RUTBOPE
 , COD_RUTBALM
 , COD_RUTBCELDA
 , COD_RUTBTOPE
 , IND_RUTB
 , NUM_MSNB1
 , NUM_NSE1
 , COD_AREA1
 , IND_TIPABO1
 , IND_TIPLLA1
 , IND_TIPTAR1
 , IND_ENTSAL1
 , IND_OPERLD1
 , IND_LOCAL1
 , IND_LARGA1
 , COD_TARLOC1
 , COD_REDLOC1
 , IMP_LOCAL1
 , DUR_LOCAL1
 , NUM_PULSOS1
 , COD_TARLD1
 , COD_REDLD1
 , IMP_LARGA2
 , DUR_LARGA2
 , NUM_PULSOS2
 , COD_AREA2
 , DES_MOVIL2
 , COD_FRANHORASOC
 , LRNORIGEN
 , LRNDESTINO
 ) AS 
SELECT
       ROWID
     , COD_TIPCENTRAL
     , COD_CENTRAL
     , NUM_BLOQUE
     , FEC_INITASA
     , COD_CLIENTE
     , NUM_ABONADO
     , IND_ALQUILER
     , IND_LIMFRA
     , COD_PERIODO
     , NUM_MOVIL1
     , NUM_MOVIL2
     , COD_ALM
     , TIE_INILLAM
     , TIE_INISEND
     , TIE_INIANSW
     , TIE_DURSEND
     , TIE_DURANSW
     , FEC_FINLLAM
     , COD_RUTAA
     , COD_RUTAOPE
     , COD_RUTAALM
     , COD_RUTACELDA
     , COD_RUTATOPE
     , IND_RUTA
     , COD_RUTAB
     , COD_RUTBOPE
     , COD_RUTBALM
     , COD_RUTBCELDA
     , COD_RUTBTOPE
     , IND_RUTB
     , NUM_MSNB1
     , NUM_NSE1
     , COD_AREA1
     , IND_TIPABO1
     , IND_TIPLLA1
     , IND_TIPTAR1
     , IND_ENTSAL1
     , IND_OPERLD1
     , IND_LOCAL1
     , IND_LARGA1
     , COD_TARLOC1
     , COD_REDLOC1
     , IMP_LOCAL1
     , DUR_LOCAL1
     , NUM_PULSOS1
     , COD_TARLD1
     , COD_REDLD1
     , IMP_LARGA2
     , DUR_LARGA2
     , NUM_PULSOS2
     , COD_AREA2
     , DES_MOVIL2
     , COD_FRANHORASOC
     , LRORIGEN
     , LRNDESTINO
 FROM TA_TARIFICADAS0
  UNION ALL
   SELECT
        ROWID,
        COD_TIPCENTRAL,      COD_CENTRAL,         NUM_BLOQUE,
        FEC_INITASA,         COD_CLIENTE,         NUM_ABONADO,
        IND_ALQUILER,        IND_LIMFRA,          COD_PERIODO,
        NUM_MOVIL1,          NUM_MOVIL2,          COD_ALM,
        TIE_INILLAM,         TIE_INISEND,         TIE_INIANSW,
        TIE_DURSEND,         TIE_DURANSW,         FEC_FINLLAM,
        COD_RUTAA,           COD_RUTAOPE,         COD_RUTAALM,
        COD_RUTACELDA,       COD_RUTATOPE,        IND_RUTA,
        COD_RUTAB,           COD_RUTBOPE,        COD_RUTBALM,
        COD_RUTBCELDA,       COD_RUTBTOPE,        IND_RUTB,
        NUM_MSNB1,           NUM_NSE1,            COD_AREA1,
        IND_TIPABO1,         IND_TIPLLA1,
        IND_TIPTAR1,         IND_ENTSAL1,         IND_OPERLD1,
        IND_LOCAL1,          IND_LARGA1,
        COD_TARLOC1,         COD_REDLOC1,         IMP_LOCAL1,
        DUR_LOCAL1,          NUM_PULSOS1,         COD_TARLD1,
        COD_REDLD1,          IMP_LARGA2,          DUR_LARGA2,
        NUM_PULSOS2,         COD_AREA2,           DES_MOVIL2,
        COD_FRANHORASOC,     LRORIGEN,            LRNDESTINO
   FROM TA_TARIFICADAS1
  UNION ALL
   SELECT
        ROWID,
        COD_TIPCENTRAL,      COD_CENTRAL,         NUM_BLOQUE,
        FEC_INITASA,         COD_CLIENTE,         NUM_ABONADO,
        IND_ALQUILER,        IND_LIMFRA,          COD_PERIODO,
        NUM_MOVIL1,          NUM_MOVIL2,          COD_ALM,
        TIE_INILLAM,         TIE_INISEND,         TIE_INIANSW,
        TIE_DURSEND,         TIE_DURANSW,         FEC_FINLLAM,
        COD_RUTAA,           COD_RUTAOPE,         COD_RUTAALM,
        COD_RUTACELDA,       COD_RUTATOPE,        IND_RUTA,
        COD_RUTAB,           COD_RUTBOPE,        COD_RUTBALM,
        COD_RUTBCELDA,       COD_RUTBTOPE,        IND_RUTB,
        NUM_MSNB1,           NUM_NSE1,            COD_AREA1,
        IND_TIPABO1,         IND_TIPLLA1,
        IND_TIPTAR1,         IND_ENTSAL1,         IND_OPERLD1,
        IND_LOCAL1,          IND_LARGA1,
        COD_TARLOC1,         COD_REDLOC1,         IMP_LOCAL1,
        DUR_LOCAL1,          NUM_PULSOS1,         COD_TARLD1,
        COD_REDLD1,          IMP_LARGA2,          DUR_LARGA2,
        NUM_PULSOS2,         COD_AREA2,           DES_MOVIL2,
        COD_FRANHORASOC,     LRORIGEN,           LRNDESTINO
   FROM TA_TARIFICADAS2
  UNION ALL
   SELECT
        ROWID,
        COD_TIPCENTRAL,      COD_CENTRAL,         NUM_BLOQUE,
        FEC_INITASA,         COD_CLIENTE,         NUM_ABONADO,
        IND_ALQUILER,        IND_LIMFRA,          COD_PERIODO,
        NUM_MOVIL1,          NUM_MOVIL2,          COD_ALM,
        TIE_INILLAM,         TIE_INISEND,         TIE_INIANSW,
        TIE_DURSEND,         TIE_DURANSW,         FEC_FINLLAM,
        COD_RUTAA,           COD_RUTAOPE,         COD_RUTAALM,
        COD_RUTACELDA,       COD_RUTATOPE,        IND_RUTA,
        COD_RUTAB,           COD_RUTBOPE,        COD_RUTBALM,
        COD_RUTBCELDA,       COD_RUTBTOPE,        IND_RUTB,
        NUM_MSNB1,           NUM_NSE1,            COD_AREA1,
        IND_TIPABO1,         IND_TIPLLA1,
        IND_TIPTAR1,         IND_ENTSAL1,         IND_OPERLD1,
        IND_LOCAL1,          IND_LARGA1,
        COD_TARLOC1,         COD_REDLOC1,         IMP_LOCAL1,
        DUR_LOCAL1,          NUM_PULSOS1,         COD_TARLD1,
        COD_REDLD1,          IMP_LARGA2,          DUR_LARGA2,
        NUM_PULSOS2,         COD_AREA2,           DES_MOVIL2,
        COD_FRANHORASOC,     LRORIGEN,           LRNDESTINO
   FROM TA_TARIFICADAS3
  UNION ALL
   SELECT
        ROWID,
        COD_TIPCENTRAL,      COD_CENTRAL,         NUM_BLOQUE,
        FEC_INITASA,         COD_CLIENTE,         NUM_ABONADO,
        IND_ALQUILER,        IND_LIMFRA,          COD_PERIODO,
        NUM_MOVIL1,          NUM_MOVIL2,          COD_ALM,
        TIE_INILLAM,         TIE_INISEND,         TIE_INIANSW,
        TIE_DURSEND,         TIE_DURANSW,         FEC_FINLLAM,
        COD_RUTAA,           COD_RUTAOPE,         COD_RUTAALM,
        COD_RUTACELDA,       COD_RUTATOPE,        IND_RUTA,
        COD_RUTAB,           COD_RUTBOPE,        COD_RUTBALM,
        COD_RUTBCELDA,       COD_RUTBTOPE,        IND_RUTB,
        NUM_MSNB1,           NUM_NSE1,            COD_AREA1,
        IND_TIPABO1,         IND_TIPLLA1,
        IND_TIPTAR1,         IND_ENTSAL1,         IND_OPERLD1,
        IND_LOCAL1,          IND_LARGA1,
        COD_TARLOC1,         COD_REDLOC1,         IMP_LOCAL1,
        DUR_LOCAL1,          NUM_PULSOS1,         COD_TARLD1,
        COD_REDLD1,          IMP_LARGA2,          DUR_LARGA2,
        NUM_PULSOS2,         COD_AREA2,           DES_MOVIL2,
        COD_FRANHORASOC,     LRORIGEN,           LRNDESTINO
   FROM TA_TARIFICADAS4
  UNION ALL
   SELECT
        ROWID,
        COD_TIPCENTRAL,      COD_CENTRAL,         NUM_BLOQUE,
        FEC_INITASA,         COD_CLIENTE,         NUM_ABONADO,
        IND_ALQUILER,        IND_LIMFRA,          COD_PERIODO,
        NUM_MOVIL1,          NUM_MOVIL2,          COD_ALM,
        TIE_INILLAM,         TIE_INISEND,         TIE_INIANSW,
        TIE_DURSEND,         TIE_DURANSW,         FEC_FINLLAM,
        COD_RUTAA,           COD_RUTAOPE,         COD_RUTAALM,
        COD_RUTACELDA,       COD_RUTATOPE,        IND_RUTA,
        COD_RUTAB,           COD_RUTBOPE,        COD_RUTBALM,
        COD_RUTBCELDA,       COD_RUTBTOPE,        IND_RUTB,
        NUM_MSNB1,           NUM_NSE1,            COD_AREA1,
        IND_TIPABO1,         IND_TIPLLA1,
        IND_TIPTAR1,         IND_ENTSAL1,         IND_OPERLD1,
        IND_LOCAL1,          IND_LARGA1,
        COD_TARLOC1,         COD_REDLOC1,         IMP_LOCAL1,
        DUR_LOCAL1,          NUM_PULSOS1,         COD_TARLD1,
        COD_REDLD1,          IMP_LARGA2,          DUR_LARGA2,
        NUM_PULSOS2,         COD_AREA2,           DES_MOVIL2,
        COD_FRANHORASOC,     LRORIGEN,           LRNDESTINO
   FROM TA_TARIFICADAS5
  UNION ALL
   SELECT
        ROWID,
        COD_TIPCENTRAL,      COD_CENTRAL,         NUM_BLOQUE,
        FEC_INITASA,         COD_CLIENTE,         NUM_ABONADO,
        IND_ALQUILER,        IND_LIMFRA,          COD_PERIODO,
        NUM_MOVIL1,          NUM_MOVIL2,          COD_ALM,
        TIE_INILLAM,         TIE_INISEND,         TIE_INIANSW,
        TIE_DURSEND,         TIE_DURANSW,         FEC_FINLLAM,
        COD_RUTAA,           COD_RUTAOPE,         COD_RUTAALM,
        COD_RUTACELDA,       COD_RUTATOPE,        IND_RUTA,
        COD_RUTAB,           COD_RUTBOPE,        COD_RUTBALM,
        COD_RUTBCELDA,       COD_RUTBTOPE,        IND_RUTB,
        NUM_MSNB1,           NUM_NSE1,            COD_AREA1,
        IND_TIPABO1,         IND_TIPLLA1,
        IND_TIPTAR1,         IND_ENTSAL1,         IND_OPERLD1,
        IND_LOCAL1,          IND_LARGA1,
        COD_TARLOC1,         COD_REDLOC1,         IMP_LOCAL1,
        DUR_LOCAL1,          NUM_PULSOS1,         COD_TARLD1,
        COD_REDLD1,          IMP_LARGA2,          DUR_LARGA2,
        NUM_PULSOS2,         COD_AREA2,           DES_MOVIL2,
        COD_FRANHORASOC,     LRORIGEN,           LRNDESTINO
   FROM TA_TARIFICADAS6
  UNION ALL
   SELECT
        ROWID,
        COD_TIPCENTRAL,      COD_CENTRAL,         NUM_BLOQUE,
        FEC_INITASA,         COD_CLIENTE,         NUM_ABONADO,
        IND_ALQUILER,        IND_LIMFRA,          COD_PERIODO,
        NUM_MOVIL1,          NUM_MOVIL2,          COD_ALM,
        TIE_INILLAM,         TIE_INISEND,         TIE_INIANSW,
        TIE_DURSEND,         TIE_DURANSW,         FEC_FINLLAM,
        COD_RUTAA,           COD_RUTAOPE,         COD_RUTAALM,
        COD_RUTACELDA,       COD_RUTATOPE,        IND_RUTA,
        COD_RUTAB,           COD_RUTBOPE,        COD_RUTBALM,
        COD_RUTBCELDA,       COD_RUTBTOPE,        IND_RUTB,
        NUM_MSNB1,           NUM_NSE1,            COD_AREA1,
        IND_TIPABO1,         IND_TIPLLA1,
        IND_TIPTAR1,         IND_ENTSAL1,         IND_OPERLD1,
        IND_LOCAL1,          IND_LARGA1,
        COD_TARLOC1,         COD_REDLOC1,         IMP_LOCAL1,
        DUR_LOCAL1,          NUM_PULSOS1,         COD_TARLD1,
        COD_REDLD1,          IMP_LARGA2,          DUR_LARGA2,
        NUM_PULSOS2,         COD_AREA2,           DES_MOVIL2,
        COD_FRANHORASOC,     LRORIGEN,           LRNDESTINO
   FROM TA_TARIFICADAS7
  UNION ALL
   SELECT
        ROWID,
        COD_TIPCENTRAL,      COD_CENTRAL,         NUM_BLOQUE,
        FEC_INITASA,         COD_CLIENTE,         NUM_ABONADO,
        IND_ALQUILER,        IND_LIMFRA,          COD_PERIODO,
        NUM_MOVIL1,          NUM_MOVIL2,          COD_ALM,
        TIE_INILLAM,         TIE_INISEND,         TIE_INIANSW,
        TIE_DURSEND,         TIE_DURANSW,         FEC_FINLLAM,
        COD_RUTAA,           COD_RUTAOPE,         COD_RUTAALM,
        COD_RUTACELDA,       COD_RUTATOPE,        IND_RUTA,
        COD_RUTAB,           COD_RUTBOPE,        COD_RUTBALM,
        COD_RUTBCELDA,       COD_RUTBTOPE,        IND_RUTB,
        NUM_MSNB1,           NUM_NSE1,            COD_AREA1,
        IND_TIPABO1,         IND_TIPLLA1,
        IND_TIPTAR1,         IND_ENTSAL1,         IND_OPERLD1,
        IND_LOCAL1,          IND_LARGA1,
        COD_TARLOC1,         COD_REDLOC1,         IMP_LOCAL1,
        DUR_LOCAL1,          NUM_PULSOS1,         COD_TARLD1,
        COD_REDLD1,          IMP_LARGA2,          DUR_LARGA2,
        NUM_PULSOS2,         COD_AREA2,           DES_MOVIL2,
        COD_FRANHORASOC,     LRORIGEN,           LRNDESTINO
   FROM TA_TARIFICADAS8
  UNION ALL
   SELECT
        ROWID,
        COD_TIPCENTRAL,      COD_CENTRAL,         NUM_BLOQUE,
        FEC_INITASA,         COD_CLIENTE,         NUM_ABONADO,
        IND_ALQUILER,        IND_LIMFRA,          COD_PERIODO,
        NUM_MOVIL1,          NUM_MOVIL2,          COD_ALM,
        TIE_INILLAM,         TIE_INISEND,         TIE_INIANSW,
        TIE_DURSEND,         TIE_DURANSW,         FEC_FINLLAM,
        COD_RUTAA,           COD_RUTAOPE,         COD_RUTAALM,
        COD_RUTACELDA,       COD_RUTATOPE,        IND_RUTA,
        COD_RUTAB,           COD_RUTBOPE,        COD_RUTBALM,
        COD_RUTBCELDA,       COD_RUTBTOPE,        IND_RUTB,
        NUM_MSNB1,           NUM_NSE1,            COD_AREA1,
        IND_TIPABO1,         IND_TIPLLA1,
        IND_TIPTAR1,         IND_ENTSAL1,         IND_OPERLD1,
        IND_LOCAL1,          IND_LARGA1,
        COD_TARLOC1,         COD_REDLOC1,         IMP_LOCAL1,
        DUR_LOCAL1,          NUM_PULSOS1,         COD_TARLD1,
        COD_REDLD1,          IMP_LARGA2,          DUR_LARGA2,
        NUM_PULSOS2,         COD_AREA2,           DES_MOVIL2,
        COD_FRANHORASOC,     LRORIGEN,           LRNDESTINO
   FROM TA_TARIFICADAS9
/
SHOW ERRORS
