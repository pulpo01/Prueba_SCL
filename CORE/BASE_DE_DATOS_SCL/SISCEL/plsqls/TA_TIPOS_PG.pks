CREATE OR REPLACE PACKAGE TA_tipos_PG
IS
  TYPE  TIP_TA_PLANTARIF_QT IS TABLE OF TA_PLANTARIF_QT INDEX BY BINARY_INTEGER;
  TYPE  TIP_TA_PLANTARIF    IS TABLE OF TA_PLANTARIF%ROWTYPE INDEX BY BINARY_INTEGER;
  TYPE  TIP_TA_CARGOSBASICO IS TABLE OF TA_CARGOSBASICO%ROWTYPE INDEX BY BINARY_INTEGER;
------------------------------------------------------------------------------------------------------------
	FUNCTION TA_INICIA_PLANTARIF_QT_FN
	RETURN TA_PLANTARIF_QT;
------------------------------------------------------------------------------------------------------------

END;
/
SHOW ERRORS
