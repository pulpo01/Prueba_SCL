CREATE OR REPLACE PROCEDURE        p_manual_uso(
  v_subalm IN ge_subalms.cod_subalm%type ,
  v_central IN icg_central.cod_central%type ,
  v_celular IN al_series.num_telefono%type ,
  v_producto IN al_series.cod_producto%type ,
  v_categoria IN al_series.cod_cat%type ,
  v_uso IN al_usos.cod_uso%type ,
  v_error IN OUT number )
IS
  v_num_des   ga_celnum_uso.num_desde%type;
  v_num_has   ga_celnum_uso.num_hasta%type;
  v_num_sig   ga_celnum_uso.num_siguiente%type;
  v_rowid     rowid;
BEGIN
  select num_desde,num_hasta,num_siguiente,rowid
    into v_num_des,v_num_has,v_num_sig,v_rowid
    from ga_celnum_uso
   where cod_subalm  = v_subalm
     and cod_central = v_central
     and cod_cat     = v_categoria
     and cod_uso     = v_uso
     and num_libres  > 0
     and v_celular between num_siguiente and num_hasta
     for update of num_siguiente nowait;
  if v_celular = v_num_sig then
     if v_celular = v_num_has then
        update ga_celnum_uso
           set num_libres    = num_libres - 1
         where rowid = v_rowid;
     else
        update ga_celnum_uso
           set num_siguiente = num_siguiente + 1,
               num_libres    = num_libres - 1
         where rowid = v_rowid;
     end if;
  elsif v_celular = v_num_has then
     update ga_celnum_uso
        set num_hasta  = num_hasta - 1,
            num_libres = num_libres - 1
      where rowid = v_rowid;
     insert into ga_celnum_uso
            (num_desde,num_hasta,
             cod_subalm,cod_producto,
             cod_central,cod_cat,
             cod_uso,num_libres,
             num_siguiente)
     values (v_celular,v_celular,
             v_subalm,1,
             v_central,v_categoria,
             v_uso,0,v_celular);
  else
     update ga_celnum_uso
        set num_hasta = v_celular - 1,
            num_libres = ((v_celular - 1) - num_siguiente) + 1
      where rowid = v_rowid;
     insert into ga_celnum_uso
            (num_desde,num_hasta,
             cod_subalm,cod_producto,
             cod_central,cod_cat,
             cod_uso,num_libres,
             num_siguiente)
     values (v_celular,v_celular,
             v_subalm,1,
             v_central,v_categoria,
             v_uso,0,v_celular);
     insert into ga_celnum_uso
            (num_desde,num_hasta,
             cod_subalm,cod_producto,
             cod_central,cod_cat,
             cod_uso,num_libres,
             num_siguiente)
     values (v_celular + 1,v_num_has,
             v_subalm,1,
             v_central,v_categoria,
             v_uso,(v_num_has - (v_celular + 1)) + 1,
             v_celular + 1);
  end if;
EXCEPTION
  when NO_DATA_FOUND then
       v_error := 1;
  when OTHERS then
       v_error := 2;
END p_manual_uso;
/
SHOW ERRORS
