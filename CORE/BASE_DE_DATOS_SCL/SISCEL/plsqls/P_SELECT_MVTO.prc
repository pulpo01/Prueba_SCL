CREATE OR REPLACE PROCEDURE        p_select_mvto(
  v_mvto IN OUT al_movimientos.num_movimiento%type )
IS
BEGIN
   select al_seq_mvto.nextval
     into v_mvto
     from dual;
EXCEPTION
   when OTHERS then
        raise_application_error (-20192,'Error obtencio No. Movimiento '
                                 || to_char(SQLCODE));
END p_select_mvto;
/
SHOW ERRORS
