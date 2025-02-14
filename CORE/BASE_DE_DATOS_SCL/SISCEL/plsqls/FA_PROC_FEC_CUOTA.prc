CREATE OR REPLACE PROCEDURE        fa_proc_fec_cuota(v_seq_cuotas    in varchar2,
                              v_ord_cuota     in varchar2,
                              v_fec_emision   in varchar2,
                              v_dia_periodo   in varchar2) is
  vreg_cuotas    Fa_Cuotas%ROWTYPE;
  vseq_cuotas    Fa_Cuotas.Seq_Cuotas%TYPE;
  vord_cuota     Fa_Cuotas.ORd_Cuota%TYPE;
  vfec_emision   Fa_Cuotas.Fec_Emision%TYPE;
  vdia_periodo   number(3) := 0;
  vsqlcode       number := 0;
  vsqlerrm       varchar2(100);
  Begin
    vseq_cuotas  := to_number(v_seq_cuotas);
    vord_cuota   := to_number(v_ord_cuota);
    vfec_emision := to_date(v_fec_emision,'dd-mm-yyyy');
    vdia_periodo := to_number(v_dia_periodo);
    fa_proc_genfec(vseq_cuotas,vord_cuota,vfec_emision,
                   vdia_periodo,vsqlcode,vsqlerrm);
    if vsqlcode = 0 then
       Commit;
    else
       Rollback;
    end if;
  exception
    when others then
         raise_application_error(-20549,SQLERRM);
  End fa_proc_fec_cuota;
/
SHOW ERRORS
