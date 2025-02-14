CREATE OR REPLACE FORCE VIEW SC_PARAMETROS_MULTIPLES_VW(
   COD_PARAMETRO_PADRE
 , COD_PARAMETRO_HIJO
 , NOM_PARAMETRO
 , DES_PARAMETRO
 , COD_DOMINIO_PADRE
 , TIPO_VALOR
 , COD_MODULO
 , VALOR_NUMERICO
 , VALOR_TEXTO
 , VALOR_FECHA
 , VIGENCIA_DESDE
 , VIGENCIA_HASTA
 , VALOR_DOMINIO
 , COD_DOMINIO
 , COD_OPERADORA
 ) AS 
SELECT
  para.cod_parametro_padre
,para.cod_parametro_hijo
,para.nom_parametro
,para.des_parametro
,para.cod_dominio_padre
,para.tipo_valor
,para.cod_modulo
,para.valor_numerico
,para.valor_texto
,para.valor_fecha
,para.vigencia_desde
,para.vigencia_hasta
,para.valor_dominio
,para.cod_dominio
,para.cod_operadora
FROM ge_parametros_multiples_knl_vw para
WHERE para.cod_modulo = 'SC'
WITH READ ONLY
/
SHOW ERRORS
