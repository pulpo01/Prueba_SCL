CREATE OR REPLACE PROCEDURE        p_select_dias(
  v_dias IN OUT ga_datosgener.num_resnum%type ,
  v_error IN OUT number )
IS
BEGIN
    select num_resnum into v_dias
           from ga_datosgener;
EXCEPTION
    WHEN OTHERS THEN
         v_error := 1;
END p_select_dias;
/
SHOW ERRORS
