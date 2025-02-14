CREATE OR REPLACE PROCEDURE        p_concepto(
  v_concepto IN OUT number ,
  v_error IN OUT char )
IS
Begin
  select cod_concepto into v_concepto
   from fa_conceptos
   where cod_modulo = 'AC';
     v_error := '0';
 exception
  when no_data_found then
    v_error := '1';
End;
/
SHOW ERRORS
