CREATE OR REPLACE PROCEDURE        p_convertir_precio(
  v_moneda_in IN OUT al_movimientos.cod_moneda%type ,
  v_moneda_out IN OUT al_datos_generales.cod_moneda_val%type ,
  v_precio_in IN number ,
  v_precio_out IN OUT number ,
  v_fec_cambio IN date )
IS
  v_cambio_in    ge_conversion.cambio%type;
  v_cambio_out   ge_conversion.cambio%type;
  v_decim        ge_monedas.num_decimal%type;
BEGIN
  p_decimales (v_moneda_out,
               v_decim);
  p_obtiene_cambio (v_moneda_in,
                    v_cambio_in,
                    v_fec_cambio);
  p_obtiene_cambio (v_moneda_out,
                    v_cambio_out,
                    v_fec_cambio);
  v_precio_out := ROUND(((v_precio_in * v_cambio_in) * v_cambio_out),v_decim);
EXCEPTION
  when OTHERS then
       raise_application_error(-20147,'Error Conversion Precio');
END p_convertir_precio;
/
SHOW ERRORS
