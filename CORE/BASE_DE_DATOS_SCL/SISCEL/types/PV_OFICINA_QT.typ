CREATE OR REPLACE TYPE PV_OFICINA_QT AS OBJECT
(
  COD_OFICINA VARCHAR2(2),
  DES_OFICINA VARCHAR2(50),
  COD_COMUNA VARCHAR2(5),
  DES_COMUNA VARCHAR2(40),
  CONSTRUCTOR FUNCTION PV_OFICINA_QT RETURN SELF AS RESULT
)
/
SHOW ERRORS
CREATE OR REPLACE TYPE BODY PV_OFICINA_QT IS
  CONSTRUCTOR FUNCTION PV_OFICINA_QT RETURN SELF AS RESULT AS
  BEGIN
    COD_OFICINA    := NULL;
    DES_OFICINA    := NULL;
    COD_COMUNA     := NULL;
  DES_COMUNA     := NULL;
    RETURN;
  END;
END;
/
SHOW ERRORS
