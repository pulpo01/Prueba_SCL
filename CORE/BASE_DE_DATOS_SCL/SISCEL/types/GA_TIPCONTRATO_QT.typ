CREATE OR REPLACE TYPE GA_TIPCONTRATO_QT AS OBJECT
(
  COD_PRODUCTO NUMBER(1),
  COD_TIPCONTRATO VARCHAR2(3),
  DES_TIPCONTRATO VARCHAR2(30),
  FEC_DESDE DATE,
  FEC_HASTA DATE,
  IND_CONTSEG VARCHAR2(3),
  IND_CONTCEL VARCHAR2(1),
  IND_COMODATO NUMBER(1),
  CANAL_VTA NUMBER(1),
  MESES_MINIMO NUMBER(2),
  IND_PROCEQUI VARCHAR2(1),
  IND_PRECIOLISTA VARCHAR2(1),
  IND_GMC VARCHAR2(3),
  CONSTRUCTOR FUNCTION GA_TIPCONTRATO_QT RETURN self AS result
)
/
SHOW ERRORS
CREATE OR REPLACE TYPE BODY GA_TIPCONTRATO_QT IS

  CONSTRUCTOR FUNCTION GA_TIPCONTRATO_QT RETURN self AS result AS
  BEGIN
    COD_PRODUCTO := NULL;
    COD_TIPCONTRATO := NULL;
    DES_TIPCONTRATO := NULL;
    FEC_DESDE := NULL;
    FEC_HASTA := NULL;
    IND_CONTSEG := NULL;
    IND_CONTCEL := NULL;
    IND_COMODATO := NULL;
    CANAL_VTA := NULL;
    MESES_MINIMO := NULL;
    IND_PROCEQUI := NULL;
    IND_PRECIOLISTA := NULL;
    IND_GMC := NULL;
    RETURN;
  END;
END;
/
SHOW ERRORS
