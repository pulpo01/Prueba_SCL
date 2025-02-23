CREATE OR REPLACE FORCE VIEW GE_CENTRO_COSTOS_DSCTO_VW
(COD_DOMINIO, VALOR, DESCRIPCION_VALOR, IND_ESTADO, 
 FEC_CREACION, USU_CREACION, FEC_MODIFICACION, USU_MODIFICACION)
AS 
SELECT 
  COD_DOMINIO, 
  VALOR, 
  DESCRIPCION_VALOR, 
  IND_ESTADO, 
  FEC_CREACION, 
  USU_CREACION, 
  FEC_MODIFICACION, 
  USU_MODIFICACION 
FROM 
  GE_VALORES_DOMINIOS_KNL_VW 
WHERE 
  COD_DOMINIO ='CENTRO_COSTOS_DSCTO' 
WITH READ ONLY
/
SHOW ERRORS
