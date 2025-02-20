CREATE OR REPLACE FORCE VIEW GE_DOMINIOS_KNL_VW(
   COD_DOMINIO
 , TIPO
 , NOMBRE
 , FEC_CREACION
 , USU_CREACION
 , FEC_MODIFICACION
 , USU_MODIFICACION
 ) AS 
SELECT
  COD_DOMINIO,
  TIPO,
  NOMBRE,
  FEC_CREACION,
  USU_CREACION,
  FEC_MODIFICACION,
  USU_MODIFICACION
FROM
  GE_DOMINIOS_TD
WITH READ ONLY
/
SHOW ERRORS
