CREATE OR REPLACE PACKAGE VE_PARAMETROS_SIMPLES_I_PG
IS

 FUNCTION VE_AGREGAR_PADRE_FN
               (EN_codigo IN ge_parametros_td.cod_parametro%TYPE
                ,EV_nombre IN ge_parametros_td.nom_parametro%TYPE
                                ,EV_descripcion IN ge_parametros_td.des_parametro%TYPE
                                ,EV_cod_dominio IN ge_parametros_td.cod_dominio%TYPE
                                ,EV_tipo_valor IN ge_parametros_td.tipo_valor%TYPE
               )
 RETURN NUMBER;

 FUNCTION VE_AGREGAR_HIJO_FN
               (EN_codigo_padre IN ge_parametros_td.cod_parametro_padre%TYPE
                ,EN_codigo_hijo IN ge_parametros_td.cod_parametro%TYPE
                ,EN_valor_numerico IN ge_parametros_td.valor_numerico%TYPE
                ,EV_valor_texto IN ge_parametros_td.valor_texto%TYPE
                ,ED_valor_fecha IN ge_parametros_td.valor_fecha%TYPE
                ,EV_tipo_valor IN ge_parametros_td.tipo_valor%TYPE
                ,ED_vigencia_desde IN ge_parametros_td.vigencia_desde%TYPE
                ,ED_vigencia_hasta IN ge_parametros_td.vigencia_hasta%TYPE
                ,EV_valor_dominio IN ge_parametros_td.valor_dominio%TYPE
                ,EV_cod_dominio IN ge_parametros_td.cod_dominio%TYPE
                ,EV_cod_operadora IN ge_parametros_td.cod_operadora%TYPE
               )
      RETURN NUMBER;

END VE_PARAMETROS_SIMPLES_I_PG;
/
SHOW ERRORS
