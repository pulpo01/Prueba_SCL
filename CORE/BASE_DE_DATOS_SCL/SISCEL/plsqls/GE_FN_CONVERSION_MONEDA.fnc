CREATE OR REPLACE FUNCTION        ge_fn_conversion_moneda(p_valor number,p_cod_moneda_valor  varchar2, p_cod_moneda_conv varchar2, p_fecha_conv date) return number
is
v_cambio_valor    ge_conversion.cambio%type;
v_cambio_conv     ge_conversion.cambio%type;
v_num_decimal     ge_monedas.NUM_DECIMAL%type;
v_valor_formato   number;

begin


--Obtine cambio sobre moneda valor
   SELECT cambio
   INTO v_cambio_valor
   FROM ge_conversion
   WHERE cod_moneda = p_cod_moneda_valor
   AND sysdate between fec_desde and fec_hasta;



--Obtine cambio sobre moneda salida  moneda conversion
   SELECT a.cambio, b.num_decimal
   INTO v_cambio_conv, v_num_decimal
   FROM ge_conversion a, ge_monedas b
   WHERE a.cod_moneda = p_cod_moneda_conv
   AND a.cod_moneda=b.cod_moneda
   AND p_fecha_conv between fec_desde and fec_hasta;

--valor salida
  v_valor_formato := ROUND(((p_valor * v_cambio_valor) * v_cambio_conv),v_num_decimal);

   RETURN v_valor_formato;

EXCEPTION
  when OTHERS then
       raise_application_error(-20147,'Error Conversion Moneda');


end;
/
SHOW ERRORS
