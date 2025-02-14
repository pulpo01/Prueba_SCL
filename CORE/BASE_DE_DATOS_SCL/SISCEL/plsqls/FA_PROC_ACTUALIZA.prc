CREATE OR REPLACE PROCEDURE        fa_proc_actualiza(
  v_cod_cliente IN varchar2 ,
  v_ind_factur IN varchar2 )
IS
  v_num_abocel   Ge_Clientes.Num_Abocel%TYPE;
  v_num_abobeep  Ge_Clientes.Num_AboBeep%TYPE;
  v_num_abotrek  Ge_Clientes.Num_AboTrek%TYPE;
  v_num_abotrunk Ge_Clientes.Num_AboTrunk%TYPE;
  v_facturable   Ge_Clientes.Ind_Factur%TYPE;
  vind_factur    Ge_Clientes.Ind_Factur%TYPE;
  vcod_cliente   Ge_Clientes.Cod_Cliente%TYPE;
  vsqlcode       number;
  vsqlerrm       varchar2(100);
  Begin
    dbms_output.put_line('cliente char = '||v_cod_cliente);
    dbms_output.put_line('indfactur char = '||v_ind_factur);
    vcod_cliente := to_number(v_cod_cliente);
    dbms_output.put_line('cliente number = '||to_char(vcod_cliente));
    vind_factur  := to_number(v_ind_factur);
    dbms_output.put_line('indfactur number = '||to_char(vind_factur));
    Select num_abocel,num_abobeep,num_abotrek,num_abotrunk,ind_factur
    Into   v_num_abocel,v_num_abobeep,v_num_abotrek,v_num_abotrunk,
           v_facturable
    From Ge_Clientes
    Where cod_cliente = vcod_cliente;
    dbms_output.put_line('facturable number = '||to_char(v_facturable));
    If v_facturable = 1 and
       vind_factur  = 0 then
       Update Ge_Clientes set ind_factur = 0
       Where cod_cliente = vcod_cliente;
       if v_num_abocel > 0 then
          Update Ga_InfacCel set ind_factur = 0
          Where cod_cliente = vcod_cliente;
       end if;
       if v_num_abobeep > 0 then
          Update Ga_InfacBeep set ind_factur = 0
          Where cod_cliente = vcod_cliente;
       end if;
       if v_num_abotrek > 0 then
          Update Ga_InfacTrek set ind_factur = 0
          Where cod_cliente = vcod_cliente;
       end if;
       if v_num_abotrunk > 0 then
          Update Ga_InfacTrunk set ind_factur = 0
          Where cod_cliente = vcod_cliente;
       end if;
    else
       Update Ge_Clientes set ind_factur = 1
       Where cod_cliente = vcod_cliente;
    end if;
    Commit;
  exception
    when others then
         raise_application_error(-20547,SQLERRM);
  End fa_proc_actualiza;
/
SHOW ERRORS
