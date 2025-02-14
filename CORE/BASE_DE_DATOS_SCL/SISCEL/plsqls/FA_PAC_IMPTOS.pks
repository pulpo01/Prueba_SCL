CREATE OR REPLACE PACKAGE Fa_Pac_Imptos AS

TYPE TipTab_FA_PRESUPUESTO IS TABLE OF FA_PRESUPUESTO%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE TipRegImpuestos IS RECORD (COD_CONCIMPTO FA_PRESUPUESTO.COD_CONCEPTO%TYPE,
PRC_IMPUESTO FA_PRESUPUESTO.PRC_IMPUESTO%TYPE,
TIP_MONTO GE_TIPIMPUES.TIP_MONTO%TYPE,
IMP_UMBRAL GE_TIPIMPUES.IMP_UMBRAL%TYPE,
IMP_MAXIMO GE_TIPIMPUES.IMP_MAXIMO%TYPE);

TYPE TipTab_Impuestos IS TABLE OF TipRegImpuestos INDEX BY BINARY_INTEGER;
/* Registro para almacenar los totales por impuesto para el ajsute */


PROCEDURE CargaImptos (TAB_FA_PRESUPUESTO IN OUT NOCOPY  TipTab_FA_PRESUPUESTO
                      ,CODZONAIMPO        IN GE_ZONACIUDAD.COD_ZONAIMPO%TYPE
                      ,CODCATIMPOS        IN GE_DATOSGENER.COD_CATIMPOS%TYPE
                      ,VP_PROC            IN OUT NOCOPY VARCHAR2    /* En que parte del proceso estoy*/
                      ,VP_TABLA           IN OUT NOCOPY VARCHAR2    /* En que tabla estoy trabajando*/
                      ,VP_ACT             IN OUT NOCOPY VARCHAR2    /* Que accion estoy ejecutando*/
                      ,VP_SQLCODE         IN OUT NOCOPY VARCHAR2    /* sqlcode*/
                      ,VP_SQLERRM         IN OUT NOCOPY VARCHAR2    /* sqlerrm*/
                      ,VP_ERROR           IN OUT NOCOPY VARCHAR2    /* Error enviando por nosotros u otro.*/
);

END Fa_Pac_Imptos;
/
SHOW ERRORS
