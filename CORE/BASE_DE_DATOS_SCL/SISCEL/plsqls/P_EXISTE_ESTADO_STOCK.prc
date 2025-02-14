CREATE OR REPLACE PROCEDURE        p_existe_estado_stock(
  v_estado IN al_stock.cod_estado%type ,
  v_error IN OUT number )
IS
BEGIN
   select 1 into v_error
          from al_stock
          where cod_estado = v_estado;
EXCEPTION
   when TOO_MANY_ROWS then
        v_error := 1;
   when OTHERS then
        v_error := 0;
END p_existe_estado_stock;
/
SHOW ERRORS
