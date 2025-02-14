CREATE OR REPLACE PROCEDURE        p_decimales(
  v_moneda IN ge_monedas.cod_moneda%type ,
  v_decim IN OUT ge_monedas.num_decimal%type )
IS
BEGIN
   select num_decimal into v_decim
          from ge_monedas
          where cod_moneda = v_moneda;
EXCEPTION
   when OTHERS then
        raise_application_error(-20185,'Error Obtencion decimales'
                                || to_char(SQLCODE));
END p_decimales;
/
SHOW ERRORS
