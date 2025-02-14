CREATE OR REPLACE PROCEDURE        p_hay_numeros(
  v_subalm IN ge_subalms.cod_subalm%type ,
  v_central IN icg_central.cod_central%type ,
  v_uso IN al_usos.cod_uso%type ,
  v_can IN al_lineas_ordenes1.can_orden%type ,
  v_nro_reutil IN OUT number ,
  v_nro_uso IN OUT number ,
  v_cat IN ga_catnumer.cod_cat%type ,
  v_error IN OUT number )
IS
v_producto   ge_datosgener.prod_celular%type;
BEGIN
  p_select_celular (v_producto,
                    v_error);
  if v_error = 0 then
     p_cuenta_reutil (v_subalm,
                      v_producto,
                      v_central,
                      v_cat,
                      v_uso,
                      v_nro_reutil);
     p_cuenta_uso (v_subalm,
                   v_producto,
                   v_central,
                   v_cat,
                   v_uso,
                   v_nro_uso);
     if v_nro_uso + v_nro_reutil < v_can then
        v_error := 1;
     end if;
  end if;
END p_hay_numeros;
/
SHOW ERRORS
