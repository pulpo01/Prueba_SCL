CREATE OR REPLACE TYPE GE_PROCESOS_QT AS OBJECT
(
  CODIGO VARCHAR2(50),
  USUARIO VARCHAR2(50),
  AREA VARCHAR2(50),
  COD_OFICINA VARCHAR(2),
  COD_TIPCOMIS VARCHAR(2)
)
/
SHOW ERRORS
