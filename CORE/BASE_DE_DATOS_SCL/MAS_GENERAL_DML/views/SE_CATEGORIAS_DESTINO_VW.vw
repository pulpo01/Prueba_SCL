CREATE OR REPLACE FORCE VIEW SE_CATEGORIAS_DESTINO_VW(
   COD_DOMINIO
 , VALOR
 , DESCRIPCION_VALOR
 , IND_ESTADO
 , FEC_CREACION
 , USU_CREACION
 , FEC_MODIFICACION
 , USU_MODIFICACION
 ) AS 
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
  COD_DOMINIO = 'CATEGORIAS_DESTINO'
WITH READ ONLY
/
SHOW ERRORS
