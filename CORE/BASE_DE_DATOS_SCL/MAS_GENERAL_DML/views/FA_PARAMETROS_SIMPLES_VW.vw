CREATE OR REPLACE FORCE VIEW FA_PARAMETROS_SIMPLES_VW(
   COD_PARAMETRO_PADRE
 , COD_PARAMETRO_HIJO
 , NOM_PARAMETRO
 , DES_PARAMETRO
 , COD_MODULO
 , VALOR_NUMERICO
 , VALOR_TEXTO
 , VALOR_FECHA
 , TIPO_VALOR
 , VIGENCIA_DESDE
 , VIGENCIA_HASTA
 , VALOR_DOMINIO
 , COD_DOMINIO
 , COD_OPERADORA
 , COD_DOMINIO_PADRE
 ) AS 
SELECT
  cod_parametro_padre
 , cod_parametro_hijo
 ,nom_parametro
 ,des_parametro
 ,cod_modulo
 ,valor_numerico
 ,valor_texto
 ,valor_fecha
 ,tipo_valor
 ,vigencia_desde
 ,vigencia_hasta
 ,valor_dominio
 ,cod_dominio
 ,cod_operadora
 ,cod_dominio_padre
FROM ge_parametros_simples_knl_vw
WHERE
  cod_modulo ='FA'
WITH READ ONLY
/
SHOW ERRORS
