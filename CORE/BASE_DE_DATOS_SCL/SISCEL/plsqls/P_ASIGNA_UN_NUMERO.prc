CREATE OR REPLACE PROCEDURE        p_asigna_un_numero(
  v_subalm IN al_series.cod_subalm%type ,
  v_central IN al_series.cod_central%type ,
  v_uso IN al_series.cod_uso%type ,
  v_cat IN al_series.cod_cat%type ,
  v_numero IN OUT al_series.num_telefono%type )
IS
v_producto   ge_datosgener.prod_celular%type;
v_dias       ga_datosgener.num_resnum%type;
v_rowid      rowid;
v_nro_uso    number := 0;
v_nro_reutil number := 0;
v_hasta      ga_celnum_uso.num_hasta%type;
v_error      number(1) := 0;
BEGIN
  p_select_celular (v_producto,
                    v_error);
  if v_error = 0 then
     p_cuenta_reutil (v_subalm,
                      v_producto,
                      v_central,
                      v_cat,
                      v_uso,
                      v_nro_reutil);
     if v_nro_reutil > 0 then
    p_select_dias (v_dias,
                     v_error);
    if v_error = 0 then
          select num_celular,rowid into v_numero,v_rowid
                from ga_celnum_reutil
                where cod_subalm    = v_subalm
                  and cod_producto  = v_producto
                  and cod_central   = v_central
                  and cod_cat       = v_cat
                  and cod_uso       = v_uso
                  and fec_baja + v_dias <= sysdate
        and ind_equipado = 1
                  and rownum = 1
                  order by fec_baja
                  for update of fec_baja nowait;
          delete ga_celnum_reutil
                  where rowid = v_rowid;
   else
           raise_application_error (-20120,'' || to_char(SQLCODE));
   end if;
     else
        p_cuenta_uso (v_subalm,
                      v_producto,
                      v_central,
                      v_cat,
                      v_uso,
                      v_nro_uso);
        if v_nro_uso > 0 then
           select num_siguiente,rowid,num_hasta
             into v_numero,v_rowid,v_hasta
             from ga_celnum_uso
            where cod_subalm    = v_subalm
              and cod_producto  = v_producto
              and cod_central   = v_central
              and cod_cat       = v_cat
              and cod_uso       = v_uso
              and num_libres > 0
              and rownum < 2
            order by num_desde
            for update of num_siguiente nowait;
            if v_hasta = v_numero then
               update ga_celnum_uso
                      set num_libres = 0
                      where rowid = v_rowid;
            else
               update ga_celnum_uso
                      set num_siguiente = num_siguiente +1,
                          num_libres = num_libres -1
                    where rowid = v_rowid;
            end if;
        else
           raise_application_error (-20120,'' || to_char(SQLCODE));
--
-- Error Controlado en VB (NO HAY NUMERACION)
--
        end if;
      end if;
     end if;
EXCEPTION
    when OTHERS then
         if SQLCODE <> -20120 then
            raise_application_error (-20123,'');
         else
            raise_application_error (-20123,'');
         end if;
--
-- Error Controlado en VB (ERROR ASIGNACION NUMERACION)
--
END p_asigna_un_numero;
/
SHOW ERRORS
