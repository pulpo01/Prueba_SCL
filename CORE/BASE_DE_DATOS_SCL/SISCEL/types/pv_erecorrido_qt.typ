CREATE OR REPLACE TYPE PV_ERECORRIDO_QT AS OBJECT
(
  NUM_OS         NUMBER(10),
  COD_ESTADO     NUMBER(3),
  DESCRIPCION    VARCHAR2(30),
  TIP_ESTADO     NUMBER(2),
  FEC_INGESTADO  DATE,
  MSG_ERROR      VARCHAR2(30),
  CONSTRUCTOR FUNCTION PV_ERECORRIDO_QT RETURN self AS result
)NOT FINAL
/
SHOW ERRORS
CREATE OR REPLACE TYPE BODY PV_ERECORRIDO_QT IS
  CONSTRUCTOR FUNCTION PV_ERECORRIDO_QT RETURN self AS result AS
  BEGIN
    RETURN;
  END;
END;
/
SHOW ERRORS
