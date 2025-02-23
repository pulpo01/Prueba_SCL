CREATE OR REPLACE TYPE PV_MOVIMIENTOS_QT AS OBJECT
(
  NUM_OS NUMBER(10),
  F_EJECUCION DATE,
  ORD_COMANDO NUMBER(5),
  COD_ACTABO VARCHAR2(30),
  COD_SERVICIO VARCHAR2(255),
  IND_ESTADO NUMBER(3),
  FEC_EXPIRA DATE,
  RESP_CENTRAL VARCHAR2(30),
  NUM_MOVIMIENTO NUMBER(9),
  CARGA NUMBER(14,4),
  COD_ESTADO NUMBER(1)
)
/
SHOW ERRORS
