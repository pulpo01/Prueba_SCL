CREATE OR REPLACE PROCEDURE        fa_proc_cuota(v_seq_cuotas  in varchar2,
                          v_num_cuotas  in varchar2,
                          v_imp_total   in varchar2,
                          v_dia_periodo in varchar2) is
  vreg_cuotas    Fa_Cuotas%ROWTYPE;
  vseq_cuotas    Fa_Cuotas.Seq_Cuotas%TYPE;
  vnum_cuotas    Fa_CabCuotas.Num_Cuotas%TYPE;
  vimp_total     Fa_CabCuotas.Imp_Total%TYPE;
  vimp_cuota     Fa_Cuotas.Imp_Cuota%TYPE;
  vdia_periodo   number(3) := 0;
  vdiferencia    number;
  vsqlcode       number := 0;
  vsqlerrm       varchar2(100);
  Begin
    vseq_cuotas  := to_number(v_seq_cuotas);
    vnum_cuotas  := to_number(v_num_cuotas);
    vimp_total   := to_number(v_imp_total);
    vdia_periodo := to_number(v_dia_periodo);
    fa_proc_calcula (vnum_cuotas,vimp_total,vdiferencia,
                     vimp_cuota,vsqlcode,vsqlerrm);
    if vsqlcode = 0 then
       fa_proc_gencuota(vseq_cuotas,vimp_cuota,vnum_cuotas,
                        vdia_periodo,vdiferencia,vreg_cuotas,
                        vsqlcode,vsqlerrm);
       if vsqlcode = 0 then
          Commit;
       else
          Rollback;
       end if;
    end if;
  exception
    when others then
         raise_application_error(-20547,SQLERRM);
  End fa_proc_cuota;
/
SHOW ERRORS
