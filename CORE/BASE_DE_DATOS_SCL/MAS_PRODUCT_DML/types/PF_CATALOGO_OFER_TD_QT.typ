CREATE OR REPLACE TYPE PF_CATALOGO_OFER_TD_QT AS OBJECT
(
  COD_PROD_OFERTADO NUMBER(8),
  COD_CANAL VARCHAR2(20),
  COD_CARGO NUMBER(8),
  FEC_INICIO_VIGENCIA DATE,
  FEC_TERMINO_VIGENCIA DATE,
  COD_CONCEPTO NUMBER(9),
  IND_NIVEL_APLICA VARCHAR2(1)
)
/
SHOW ERRORS
