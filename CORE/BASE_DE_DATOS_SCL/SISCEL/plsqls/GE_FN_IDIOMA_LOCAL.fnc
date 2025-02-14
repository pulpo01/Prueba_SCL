CREATE OR REPLACE FUNCTION        GE_FN_IDIOMA_LOCAL RETURN VARCHAR2
IS
-- Fecha : 11-03-2002
-- Autor : Doris Soto A.
-- Proposito : Seleccionar el idioma local de la operadora en donde estamos ejecutando SISCEL
v_cod_idioma VARCHAR2(5);
BEGIN
   SELECT val_parametro INTO v_cod_idioma
   FROM ged_parametros
   WHERE nom_parametro = 'IDIOMA_LOCAL'
     AND cod_modulo = 'GE'
     AND cod_producto = 1;
   RETURN v_cod_idioma;
END;
/
SHOW ERRORS
