CREATE OR REPLACE TYPE PS_DET_ESPEC_PROD_QT AS OBJECT
(
  COD_ESP_PROD NUMBER(8),
  COD_SER_BASE VARCHAR2(10),
  TIP_SERVICIO VARCHAR2(10),
  COD_PROV_SERV NUMBER(8),
  COD_PERFIL_LISTA NUMBER(8)
)
/
SHOW ERRORS
