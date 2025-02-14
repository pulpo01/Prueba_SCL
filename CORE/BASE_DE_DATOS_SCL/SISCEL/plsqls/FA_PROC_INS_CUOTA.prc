CREATE OR REPLACE PROCEDURE        fa_proc_ins_cuota(v_reg_fa_cuotas in out Fa_Cuotas%ROWTYPE,
                              v_sqlcode in out number,
                              v_sqlerrm in out varchar2) is
  Begin
    Insert into Fa_Cuotas (seq_cuotas,ord_cuota,fec_emision,
                           imp_cuota,ind_facturado,ind_pagado)
    Values (v_reg_fa_cuotas.seq_cuotas,v_reg_fa_cuotas.ord_cuota,
            v_reg_fa_cuotas.fec_emision,v_reg_fa_cuotas.imp_cuota,
            v_reg_fa_cuotas.ind_facturado,v_reg_fa_cuotas.ind_pagado);
  exception
    when others then
         dbms_output.put_line('Error en cuotas= '||to_char(sqlcode));
         v_sqlcode := sqlcode;
         v_sqlerrm := substr(sqlerrm,1,100);
  End fa_proc_ins_cuota;
/
SHOW ERRORS
