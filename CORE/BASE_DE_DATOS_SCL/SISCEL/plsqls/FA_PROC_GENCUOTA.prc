CREATE OR REPLACE PROCEDURE        fa_proc_gencuota (v_seq_cuotas  in Fa_Cuotas.Seq_Cuotas%TYPE,
                              v_imp_cuota   in Fa_Cuotas.Imp_Cuota%TYPE,
                              v_num_cuotas  in Fa_CabCuotas.Num_Cuotas%TYPE,
                              v_dia_periodo in number,
                              v_diferencia  in number,
                              v_reg_cuotas  in out Fa_Cuotas%ROWTYPE,
                              v_sqlcode in out number,
                              v_sqlerrm in out varchar2) is
  v_contador  number(3) := 0;
  Begin
    Select count(*) into v_contador
    From Fa_Cuotas
    Where seq_cuotas = v_seq_cuotas;
    if v_contador !=0 then
       Delete Fa_Cuotas Where seq_cuotas = v_seq_cuotas;
    end if;
    v_reg_cuotas.fec_emision := sysdate;
    if v_diferencia != 0 then
       v_reg_cuotas.imp_cuota := v_imp_cuota-v_diferencia;
    else
       v_reg_cuotas.imp_cuota := v_imp_cuota;
    end if;
    For i in 1..v_num_cuotas Loop
        v_reg_cuotas.seq_cuotas := v_seq_cuotas;
        v_reg_cuotas.ord_cuota  := i;
        if i > 1 then
           v_reg_cuotas.fec_emision := v_reg_cuotas.fec_emision +
                                       v_dia_periodo;
           v_reg_cuotas.imp_cuota   := v_imp_cuota;
        end if;
        v_reg_cuotas.ind_facturado  := 0;
        v_reg_cuotas.ind_pagado     := 0;
        fa_proc_ins_cuota (v_reg_cuotas,v_sqlcode,v_sqlerrm);
        if v_sqlcode != 0 then
           exit;
        end if;
    End Loop;
  End fa_proc_gencuota;
/
SHOW ERRORS
