CREATE OR REPLACE PROCEDURE        p_obtiene_cambio(
  v_moneda IN ge_conversion.cod_moneda%type ,
  v_cambio IN OUT ge_conversion.cambio%type ,
  v_fec_cambio IN date )
IS
BEGIN
   select cambio into v_cambio
          from ge_conversion
          where cod_moneda = v_moneda
            and v_fec_cambio between fec_desde and fec_hasta;
EXCEPTION
   when OTHERS then
        raise_application_error (-20186,'<ALMACEN> Error Lectura cambio '
                                 || to_char(SQLCODE));
END p_obtiene_cambio;
/
SHOW ERRORS
