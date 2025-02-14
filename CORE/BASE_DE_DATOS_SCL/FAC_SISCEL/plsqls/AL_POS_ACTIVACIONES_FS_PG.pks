CREATE OR REPLACE PACKAGE AL_POS_ACTIVACIONES_FS_PG is
-- Servicio de posactivación  - Logística - Guatemala.
-- Junio 2010 - Ulises Uribe.                          
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE P_ACTIVACION_PUNTUAL_FS_PR(EV_serie    IN   VARCHAR2,
                                     EN_cliente  IN   NUMBER,
                                     SN_numero   OUT  NOCOPY   NUMBER,
                                     SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE);


-----------------------------------------------------------------------------------------------------------------
END; 
/
SHOW ERRORS
