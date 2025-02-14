CREATE OR REPLACE PROCEDURE        p_libera_numero(
  v_reutil IN OUT ga_celnum_reutil%rowtype )
IS
  v_error  number(1) :=0;
  v_dias   ga_datosgener.num_resnum%type;
BEGIN
  p_select_dias (v_dias,
                 v_error);
  if v_error = 0 then
     insert into ga_celnum_reutil (num_celular,
                                   cod_subalm,
                                   cod_producto,
                                   cod_central,
                                   cod_cat,
                                   cod_uso,
                                   fec_baja,
                                   ind_equipado)
                           values (v_reutil.num_celular,
                                   v_reutil.cod_subalm,
                                   v_reutil.cod_producto,
                                   v_reutil.cod_central,
                                   v_reutil.cod_cat,
                                   v_reutil.cod_uso,
                                   sysdate - v_dias,
                                   1);
  end if;
END p_libera_numero;
/
SHOW ERRORS
