CREATE OR REPLACE FORCE VIEW fa_parametros_multiples_vw (cod_parametro_padre,
                                                             cod_parametro_hijo,
                                                             nom_parametro,
                                                             des_parametro,
                                                             cod_modulo,
                                                             valor_numerico,
                                                             valor_texto,
                                                             valor_fecha,
                                                             tipo_valor,
                                                             vigencia_desde,
                                                             vigencia_hasta,
                                                             valor_dominio,
                                                             cod_dominio,
                                                             cod_operadora,
                                                             cod_dominio_padre
                                                            )
AS
SELECT cod_parametro_padre, cod_parametro_hijo, nom_parametro,
  des_parametro, cod_modulo, valor_numerico, valor_texto, valor_fecha,
  tipo_valor, vigencia_desde, vigencia_hasta, valor_dominio,
  cod_dominio, cod_operadora, cod_dominio_padre
FROM ge_parametros_multiples_knl_vw
WHERE cod_modulo = 'FA'
WITH READ ONLY
/
SHOW ERRORS