CREATE OR REPLACE PROCEDURE        fa_proc_traspaso(
  v_num_transaccion IN varchar2 ,
  v_cod_cliente IN varchar2 ,
  v_num_abonado IN varchar2 )
IS
  vcod_cliente      Ge_Cargos.Cod_Cliente%TYPE;
  vnum_abonado      Ge_Cargos.Num_Abonado%TYPE;
  vnum_transaccion  number;
  vsqlcode       number := 0;
  vsqlerrm       varchar2(100) := '';
  Begin
    vnum_transaccion := to_number(v_num_transaccion);
    vcod_cliente     := to_number(v_cod_cliente);
    vnum_abonado     := to_number(v_num_abonado);
    fa_pack_traspaso.p_main(vcod_cliente,vnum_abonado,
                            vnum_transaccion,vsqlcode,vsqlerrm);
  exception
    when others then
         raise_application_error(-20544,SQLERRM);
  End fa_proc_traspaso;
/
SHOW ERRORS
