CREATE OR REPLACE PROCEDURE        p_cuenta_reutil(
  v_subalm IN ge_subalms.cod_subalm%type ,
  v_producto IN ge_datosgener.prod_celular%type ,
  v_central IN icg_central.cod_central%type ,
  v_cat IN al_datos_generales.cod_cat%type ,
  v_uso IN al_usos.cod_uso%type ,
  v_nro_reutil IN OUT number )
IS
v_dias   ga_datosgener.num_resnum%type;
v_error  number(1) := 0;
BEGIN
    p_select_dias (v_dias,
                   v_error);
    if v_error = 0 then
       select nvl(count(num_celular),0) into v_nro_reutil
              from ga_celnum_reutil
              where cod_subalm   = v_subalm
                and cod_producto = v_producto
                and cod_central  = v_central
                and cod_cat      = v_cat
                and cod_uso      = v_uso
                and fec_baja + v_dias <= sysdate
                and ind_equipado = 1;
    else
       v_nro_reutil := 0;
    end if;
EXCEPTION
   when OTHERS then
        v_nro_reutil := 0;
END p_cuenta_reutil;
/
SHOW ERRORS
