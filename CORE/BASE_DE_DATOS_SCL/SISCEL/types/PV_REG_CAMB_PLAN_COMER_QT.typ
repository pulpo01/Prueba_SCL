CREATE OR REPLACE TYPE PV_REG_CAMB_PLAN_COMER_QT AS OBJECT
(
NUM_TRANSACCION                 NUMBER  (9),
COD_ACTABO                      VARCHAR2(2),
COD_PRODUCTO                    NUMBER  (1),
NUM_ABONADO                     NUMBER  (8),
TIP_PLANTARIF                   VARCHAR2(1),
COD_PLANTARIF_NUEVO             VARCHAR2(3),
COD_HOLDING                     VARCHAR2(8),
COD_OS                          VARCHAR2(6),
COD_CLIENTE_DES                 NUMBER  (9),
COD_CLIENTE_ORIG                NUMBER  (9)
)
/
SHOW ERRORS
