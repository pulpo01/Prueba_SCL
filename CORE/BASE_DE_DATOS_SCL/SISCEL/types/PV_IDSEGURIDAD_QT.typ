CREATE OR REPLACE TYPE PV_IDSEGURIDAD_QT AS OBJECT
(
  COD_USER VARCHAR2(20),
  ID_PROGRAMA VARCHAR2(20),
  ID_USER VARCHAR2(150),
  RESULTADO NUMBER(1)
) 
/
SHOW ERRORS