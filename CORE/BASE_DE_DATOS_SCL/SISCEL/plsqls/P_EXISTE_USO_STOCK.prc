CREATE OR REPLACE PROCEDURE        p_existe_uso_stock(
  v_uso IN al_stock.cod_uso%type ,
  v_error IN OUT number )
IS
BEGIN
   select 1 into v_error
          from al_stock
          where cod_uso = v_uso;
EXCEPTION
   when TOO_MANY_ROWS then
        v_error := 1;
   when OTHERS then
        v_error := 0;
END p_existe_uso_stock;
/
SHOW ERRORS
