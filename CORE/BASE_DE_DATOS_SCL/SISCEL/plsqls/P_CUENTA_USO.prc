CREATE OR REPLACE PROCEDURE        p_cuenta_uso(
  v_subalm IN ge_subalms.cod_subalm%type ,
  v_producto IN ge_datosgener.prod_celular%type ,
  v_central IN icg_central.cod_central%type ,
  v_cat IN al_datos_generales.cod_cat%type ,
  v_uso IN al_usos.cod_uso%type ,
  v_nro_uso IN OUT number )
IS
BEGIN
   select nvl(sum(num_libres),0)
     into v_nro_uso
     from ga_celnum_uso
    where cod_subalm    = v_subalm
     and cod_producto  = v_producto
     and cod_central   = v_central
     and cod_cat       = v_cat
     and cod_uso       = v_uso
     and num_libres > 0;
EXCEPTION
   when OTHERS then
        v_nro_uso := 0;
END p_cuenta_uso;
/
SHOW ERRORS
