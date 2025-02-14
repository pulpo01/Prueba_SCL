CREATE OR REPLACE PROCEDURE        p_manual_reutil(
  v_subalm IN ge_subalms.cod_subalm%type ,
  v_central IN icg_central.cod_central%type ,
  v_celular IN al_series.num_telefono%type ,
  v_producto IN al_series.cod_producto%type ,
  v_categoria IN al_series.cod_cat%type ,
  v_uso IN al_usos.cod_uso%type ,
  v_dias IN ga_datosgener.num_resnum%type ,
  v_error IN OUT number )
IS
   v_rowid      rowid;
BEGIN
   select rowid into v_rowid
          from ga_celnum_reutil
          where num_celular = v_celular
            and cod_subalm  = v_subalm
            and cod_central = v_central
            and cod_cat     = v_categoria
            and cod_uso     = v_uso
            and ind_equipado = 1
            and fec_baja + v_dias <= sysdate
            for update of num_celular nowait;
    delete ga_celnum_reutil
           where rowid = v_rowid;
EXCEPTION
   when NO_DATA_FOUND then
        v_error := 1;
   when OTHERS then
        v_error := 2;
END p_manual_reutil;
/
SHOW ERRORS
