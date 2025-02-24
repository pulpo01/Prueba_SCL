CREATE OR REPLACE TYPE PF_DESC_CONCEPTOS_TD_QT AS OBJECT
(
  COD_CONCEPTO NUMBER(8),
  COD_CONCEPTO_DESCTO NUMBER(9),
  COD_CANAL VARCHAR2(20),
  TIPO_VENDEDOR VARCHAR2(5),
  COD_VENDEDOR NUMBER(8),
  FEC_INICIO_VIGENCIA DATE,
  FEC_TERMINO_VIGENCIA DATE,
  TIPO_DESCUENTO VARCHAR2(5),
  VALOR_DESCUENTO NUMBER(14,4),
  COD_MONEDA VARCHAR2(10),
  COD_DESCUENTO  NUMBER(20)
)
/
SHOW ERRORS
