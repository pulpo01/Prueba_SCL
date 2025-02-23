CREATE OR REPLACE TYPE GA_SOL_DESCUENTO_QT AS OBJECT
(
  NUM_AUTORIZA NUMBER(8),
  LIN_AUTORIZA NUMBER(4),
  COD_ESTADO VARCHAR2(2),
  NOM_USUAAUTORIZAVENTA VARCHAR2(30),
  NUM_VENTA NUMBER(8),
  COD_OFICINA VARCHAR2(2),
  COD_VENDEDOR VARCHAR2(6),
  NUM_UNIDADES NUMBER(6),
  FEC_VENTA DATE,
  NOM_USUAR_VTA VARCHAR2(30),
  PRC_ORIGIN NUMBER(14,4),
  IND_TIPVENTA NUMBER(1),
  COD_CLIENTE NUMBER(8),
  COD_MODVENTA NUMBER(2),
  COD_CONCEPTO NUMBER(4),
  IMP_CARGO NUMBER(14,4),
  COD_MONEDA VARCHAR2(3),
  NUM_ABONADO VARCHAR2(8),
  NUM_SERIE VARCHAR2(25),
  COD_CONCEPTO_DTO NUMBER(4),
  VAL_DTO NUMBER(12,4),
  TIP_DTO NUMBER(1),
  ORIGEN VARCHAR2(2),
  IND_MODIFI NUMBER(1)
)
/
SHOW ERRORS
