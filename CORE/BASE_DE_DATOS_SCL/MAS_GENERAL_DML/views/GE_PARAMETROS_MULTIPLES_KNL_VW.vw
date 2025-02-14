CREATE OR REPLACE FORCE VIEW GE_PARAMETROS_MULTIPLES_KNL_VW(
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
select
tab.cod_parametro_padre
,tab.cod_parametro_hijo
,tab.nom_parametro
,tab.des_parametro
,tab.cod_dominio_padre
,tab.tipo_valor
,tab.cod_modulo
,tab.valor_numerico
,tab.valor_texto
,tab.valor_fecha
,tab.vigencia_desde
,tab.vigencia_hasta
,tab.valor_dominio
,tab.cod_dominio
,tab.cod_operadora
from
(SELECT
padre.cod_parametro cod_parametro_padre
,hijo.cod_parametro cod_parametro_hijo
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
FROM ge_parametros_td hijo,ge_parametros_td padre
WHERE hijo.cod_parametro_padre(+) = padre.cod_parametro
AND hijo.tipo_parametro(+) = 'MM'
AND padre.tipo_parametro = 'MM'
AND hijo.ind_hijos(+) = 0
AND padre.ind_hijos = 1
ORDER BY hijo.cod_parametro
) tab
WITH READ ONLY
/
SHOW ERRORS
