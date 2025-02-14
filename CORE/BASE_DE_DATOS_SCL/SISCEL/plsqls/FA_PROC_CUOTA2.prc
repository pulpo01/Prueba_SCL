CREATE OR REPLACE PROCEDURE        fa_proc_cuota2(v_num_venta in varchar2,v_cod_cuota in varchar2,
                           v_prc_impue in varchar2,v_cod_concepto in varchar2)
                          is
  vnum_venta     Ga_Ventas.Num_Venta%TYPE;
  vprc_impue     Ge_Impuestos.Prc_Impuesto%TYPE;
  vcod_cuota     Ge_TipCuotas.Cod_Cuota%TYPE;
  vcod_concepto  Fa_Conceptos.Cod_Concepto%TYPE;
  vsqlcode       number := 0;
  vsqlerrm       varchar2(100);
  Begin
    vnum_venta    := to_number(v_num_venta);
    vcod_concepto := to_number(v_cod_concepto);
    vcod_cuota    := v_cod_cuota;
    vprc_impue    := to_number(v_prc_impue);
    dbms_output.put_line('FA_PROC_CUOTA2');
    dbms_output.put_line('Num_Venta = '||to_char(vnum_venta));
    dbms_output.put_line('Cod_Concepto = '||to_char(vcod_concepto));
    dbms_output.put_line('Cod_Cuota = '||vcod_cuota);
    dbms_output.put_line('Por_Impuesto = '||to_char(vprc_impue));
    fa_pac_cuota.p_main_cuota2(vnum_venta,vcod_cuota,vprc_impue,vcod_concepto);
    dbms_output.put_line('Despues de llamar a P_MAIN_CUOTA2');
    if vsqlcode = 0 then
       Commit;
    else
       Rollback;
    end if;
  exception
    when others then
         raise_application_error(-20548,SQLERRM);
  End fa_proc_cuota2;
/
SHOW ERRORS
