CREATE OR REPLACE FORCE VIEW GE_PARAMETROS_SIMPLES_KNL_VW(
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
 , TIPO_PARAMETRO
 ) AS 
SELECT
  padre.cod_parametro
 ,hijo.cod_parametro
 ,padre.nom_parametro
 ,padre.des_parametro
 ,padre.cod_dominio_padre
 ,padre.tipo_valor
 ,padre.cod_modulo
 ,hijo.valor_numerico
 ,hijo.valor_texto
 ,hijo.valor_fecha
 ,hijo.vigencia_desde
 ,hijo.vigencia_hasta
 ,hijo.valor_dominio
 ,hijo.cod_dominio
 ,hijo.cod_operadora
 ,hijo.tipo_parametro
FROM ge_parametros_td hijo,ge_parametros_td padre
WHERE hijo.cod_parametro_padre = padre.cod_parametro
AND hijo.tipo_parametro ='MS'
AND padre.tipo_parametro = 'MS'
AND hijo.ind_hijos = 0
AND padre.ind_hijos = 1
WITH READ ONLY
/
SHOW ERRORS
