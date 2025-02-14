CREATE OR REPLACE PROCEDURE        p_select_celular(
  v_producto IN OUT ge_datosgener.prod_celular%type ,
  v_error IN OUT number )
IS
BEGIN
    select prod_celular into v_producto
           from ge_datosgener;
EXCEPTION
    when OTHERS then
         v_error := 1;
END p_select_celular;
/
SHOW ERRORS
