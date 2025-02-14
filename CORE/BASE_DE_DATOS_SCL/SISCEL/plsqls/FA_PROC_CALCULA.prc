CREATE OR REPLACE PROCEDURE        fa_proc_calcula (v_num_cuotas in Fa_CabCuotas.Num_Cuotas%TYPE,
                             v_imp_total in Fa_CabCuotas.Imp_Total%TYPE,
                             v_diferencia out number,
                             v_imp_cuota out Fa_Cuotas.Imp_Cuota%TYPE,
                             v_sqlcode out number,v_sqlerrm out varchar2) is
  vtotal    number;
  vinteres  number;
  vcargo    number;
  vaux      number;
  Begin
    vtotal      := v_imp_total;
    vaux        := v_imp_total / v_num_cuotas;
    v_imp_cuota := round(vaux);
    if vtotal != (round(vaux)*v_num_cuotas) then
       v_diferencia := (round(vaux)*v_num_cuotas) - vtotal;
    else
       v_diferencia := 0;
    end if;
    v_sqlcode := 0;
  exception
    when others then
         v_sqlcode := sqlcode;
         v_sqlerrm := substr(sqlerrm,1,100);
  End fa_proc_calcula;
/
SHOW ERRORS
