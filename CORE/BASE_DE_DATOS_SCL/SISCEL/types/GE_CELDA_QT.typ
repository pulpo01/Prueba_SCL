CREATE OR REPLACE TYPE GE_CELDA_QT AS OBJECT
(
  COD_CELDA    VARCHAR2(7),
  COD_SUBALM   VARCHAR2(5),
  DES_CELDA    VARCHAR2(50),
  COD_SUBALM2  VARCHAR2(5),
  CONSTRUCTOR FUNCTION GE_CELDA_QT RETURN self AS result

)
/
SHOW ERRORS
CREATE OR REPLACE TYPE BODY GE_CELDA_QT IS
  CONSTRUCTOR FUNCTION GE_CELDA_QT RETURN self AS result AS

  BEGIN
    COD_CELDA   :=NULL;
    COD_SUBALM  :=NULL;
    DES_CELDA   :=NULL;
    COD_SUBALM2 :=NULL;
    RETURN;
  END;
END;
/
SHOW ERRORS
