CREATE OR REPLACE FUNCTION        GE_FN_IDIOMA_CLIENTE (v_cod_cliente IN number) RETURN VARCHAR2
IS
-- Fecha 11-03-2002
-- Autor : Doris Soto A.
-- Proposito : Obtener el codigo de idioma del Cliente
   v_cod_idioma VARCHAR2(5);
BEGIN
   SELECT cod_idioma INTO v_cod_idioma
   FROM ge_clientes
   WHERE cod_cliente = v_cod_cliente;
   RETURN v_cod_idioma;
--
   EXCEPTION
   WHEN OTHERS THEN
   RETURN '0';
END;
/
SHOW ERRORS
