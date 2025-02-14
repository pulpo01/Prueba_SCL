CREATE OR REPLACE PROCEDURE        fa_proc_genfec (v_seq_cuotas  in Fa_Cuotas.Seq_Cuotas%TYPE,
                            v_ord_cuota   in Fa_Cuotas.Ord_Cuota%TYPE,
                            v_fec_emision in Fa_Cuotas.Fec_Emision%TYPE,
                            v_dia_periodo in number,
                            v_sqlcode in out number,
                            v_sqlerrm in out varchar2) is
  vcontador     number(3) := 0;
  vord_cuota    Fa_Cuotas.Ord_Cuota%TYPE;
  vfec_emision1 Fa_Cuotas.Fec_Emision%TYPE;
  vfec_emision2 Fa_Cuotas.Fec_Emision%TYPE;
  Begin
    Select count(*) Into vcontador
    From   Fa_Cuotas
    Where  seq_cuotas = v_seq_cuotas
    And    ord_cuota  > v_ord_cuota;
    if vcontador > 0 then
       vord_cuota := v_ord_cuota +1;
       For i in 1..vcontador Loop
           if i = 1 then
              vfec_emision1 := v_fec_emision + v_dia_periodo;
           else
              vfec_emision1 := vfec_emision2 + v_dia_periodo;
           end if;
           vfec_emision2 := vfec_emision1;
           Update Fa_Cuotas set fec_emision = vfec_emision1
           Where  seq_cuotas = v_seq_cuotas
           And    ord_cuota  = vord_cuota;
           vord_cuota := vord_cuota +1;
       End Loop;
    end if;
  exception
    when others then
         v_sqlcode := sqlcode;
         v_sqlerrm := substr(sqlerrm,1,100);
  End fa_proc_genfec;
/
SHOW ERRORS
