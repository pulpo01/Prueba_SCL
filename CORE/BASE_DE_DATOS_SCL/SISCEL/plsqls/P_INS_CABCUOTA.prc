CREATE OR REPLACE PROCEDURE        p_ins_cabcuota(
  v_reg_fa_cabcuotas IN Fa_CabCuotas%ROWTYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
IS
  Begin
    Insert into Fa_CabCuotas
          (seq_cuotas,cod_cliente,cod_concepto,cod_moneda,cod_producto,
           num_cuotas,imp_total,ind_pagada,num_abonado,num_venta,
           num_transaccion,cod_cuota,num_pagare,cod_modventa,num_seriele)
    Values (v_reg_fa_cabcuotas.seq_cuotas,v_reg_fa_cabcuotas.cod_cliente,
            v_reg_fa_cabcuotas.cod_concepto,v_reg_fa_cabcuotas.cod_moneda,
            v_reg_fa_cabcuotas.cod_producto,v_reg_fa_cabcuotas.num_cuotas,
            v_reg_fa_cabcuotas.imp_total,v_reg_fa_cabcuotas.ind_pagada,
            v_reg_fa_cabcuotas.num_abonado,v_reg_fa_cabcuotas.num_venta,
            v_reg_fa_cabcuotas.num_transaccion,v_reg_fa_cabcuotas.cod_cuota,
            v_reg_fa_cabcuotas.num_pagare,null,null);
  exception
    when others then
         v_sqlcode := sqlcode;
         v_sqlerrm := substr(sqlerrm,1,100);
  End p_ins_cabcuota;
/
SHOW ERRORS
