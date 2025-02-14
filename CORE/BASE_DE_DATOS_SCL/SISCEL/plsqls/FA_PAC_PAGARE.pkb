CREATE OR REPLACE PACKAGE BODY        fa_pac_pagare IS
  --
  -- Retrofitted
  PROCEDURE p_main_cuota(
  v_cod_concepto IN Fa_Conceptos.Cod_Concepto%TYPE ,
  v_cod_producto IN Ge_Productos.Cod_Producto%TYPE ,
  v_cod_moneda IN Ge_Monedas.Cod_Moneda%TYPE ,
  v_cod_cliente IN Ge_Clientes.Cod_Cliente%TYPE ,
  v_num_pagare IN Co_Pagare.Num_Pagare%TYPE ,
  v_num_cuotas IN Co_Pagare.num_Cuotas%TYPE ,
  v_prc_interes IN Co_Pagare.Factor_Ind%TYPE ,
  v_fecha IN varchar2 ,
  v_num_dias IN Co_Pagare.num_Dias%TYPE ,
  v_imp_concepto IN number )
  IS
    vcontador      number(3) := 0;
    v_fec_valor date;
    vreg_pagare    Co_Pagare%ROWTYPE;
    vreg_cuotas    Fa_Cuotas%ROWTYPE;
    vreg_cabcuotas Fa_CabCuotas%ROWTYPE;
    vimp_total     Fa_CabCuotas.Imp_total%TYPE;
    vseq_cuota     Fa_Cuotas.Seq_Cuotas%TYPE;
    vimp_cuota     number;
    vdiferencia    number;
    vsqlcode number;
    vsqlerrm varchar2(100);
    Begin
      Select count(*) Into vcontador
      From Fa_Cabcuotas
      Where num_pagare = v_num_pagare;
      if vcontador = 0 then
         v_fec_valor := to_date(v_fecha,'YYYYMMDD');
         dbms_output.put_line(v_fec_valor);
         fa_pac_pagare.p_seqcuota(vseq_cuota,vsqlcode,vsqlerrm);
         fa_pac_pagare.p_calcula(v_imp_concepto,vimp_cuota,v_num_cuotas,
                                 v_prc_interes,vdiferencia,vimp_total,
                                 vsqlcode,vsqlerrm);
         dbms_output.put_line('Diferencia ='||to_char(vdiferencia));
         fa_pac_pagare.p_gencuota (vseq_cuota,vimp_cuota,vreg_cuotas,
                                   vreg_cabcuotas,v_cod_concepto,v_cod_producto,
                                   v_cod_moneda,v_cod_cliente,v_num_cuotas,
                                   v_num_dias,v_num_pagare,v_fec_valor,
                                   vdiferencia,vimp_total);
         if vsqlcode = 0 then
            Commit;
         else
            Rollback;
            raise_application_error(-20529,vsqlerrm);
         end if;
      else
         raise_application_error(-20530,'Ya existen cuotas para el Pagare = '
                                        ||to_char(v_num_pagare));
      end if;
    exception
      when others then
           raise_application_error(-20529,sqlerrm);
    End p_main_cuota;
  --
  -- Retrofitted
  PROCEDURE p_gencuota(
  v_seq_cuota IN Fa_Cuotas.Seq_Cuotas%TYPE ,
  v_imp_cuota IN Fa_Cuotas.Imp_Cuota%TYPE ,
  v_reg_fa_cuotas IN OUT Fa_Cuotas%ROWTYPE ,
  v_reg_fa_cabcuotas IN OUT Fa_CabCuotas%ROWTYPE ,
  v_cod_concepto IN Fa_Conceptos.Cod_Concepto%TYPE ,
  v_cod_producto IN Ge_Productos.Cod_Producto%TYPE ,
  v_cod_moneda IN Ge_Monedas.Cod_Moneda%TYPE ,
  v_cod_cliente IN Ge_Clientes.Cod_Cliente%TYPE ,
  v_num_cuotas IN Fa_CabCuotas.Num_Cuotas%TYPE ,
  v_num_dias IN Co_Pagare.Num_Dias%TYPE ,
  v_num_pagare IN Co_Pagare.Num_Pagare%TYPE ,
  v_fec_valor IN Co_Pagare.Fec_Valor%TYPE ,
  v_diferencia IN number ,
  v_imp_total IN OUT Fa_CabCuotas.Imp_Total%TYPE )
  IS
    v_sqlcode number;
    v_sqlerrm varchar2(100);
    Begin
      v_reg_fa_cabcuotas.seq_cuotas      := v_seq_cuota;
      v_reg_fa_cabcuotas.cod_cliente     := v_cod_cliente;
      v_reg_fa_cabcuotas.cod_concepto    := v_cod_concepto;
      v_reg_fa_cabcuotas.cod_moneda      := v_cod_moneda;
      v_reg_fa_cabcuotas.cod_producto    := v_cod_producto;
      v_reg_fa_cabcuotas.num_cuotas      := v_num_cuotas;
      v_reg_fa_cabcuotas.imp_total       := v_imp_total;
      v_reg_fa_cabcuotas.ind_pagada      := 0;
      v_reg_fa_cabcuotas.num_abonado     := 0;
      v_reg_fa_cabcuotas.num_venta       := 0;
      v_reg_fa_cabcuotas.num_transaccion := 0;
      v_reg_fa_cabcuotas.cod_cuota       := 'WW';
      v_reg_fa_cabcuotas.num_pagare      := v_num_pagare;
      fa_pac_pagare.p_ins_cabcuota (v_reg_fa_cabcuotas,v_sqlcode,v_sqlerrm);
      --v_reg_fa_cuotas.fec_emision := v_fec_valor+v_num_dias;
      v_reg_fa_cuotas.fec_emision := v_fec_valor;
      if v_diferencia != 0 then
         v_reg_fa_cuotas.imp_cuota := v_imp_cuota-v_diferencia;
      else
         v_reg_fa_cuotas.imp_cuota := v_imp_cuota;
      end if;
      For i in 1..v_num_cuotas Loop
          v_reg_fa_cuotas.seq_cuotas := v_seq_cuota;
          v_reg_fa_cuotas.ord_cuota := i;
          if i > 1 then
             v_reg_fa_cuotas.fec_emision := v_reg_fa_cuotas.fec_emision +
                                            v_num_dias;
             v_reg_fa_cuotas.imp_cuota := v_imp_cuota;
          end if;
          v_reg_fa_cuotas.ind_facturado := 0;
          v_reg_fa_cuotas.ind_pagado := 0;
          fa_pac_pagare.p_ins_cuota (v_reg_fa_cuotas,v_sqlcode,v_sqlerrm);
      End Loop;
    End p_gencuota;
  --
  -- Retrofitted
  PROCEDURE p_calcula(
  v_imp_concepto IN number ,
  v_imp_cuota OUT Fa_Cuotas.Imp_Cuota%TYPE ,
  v_num_cuotas IN Fa_CabCuotas.Num_Cuotas%TYPE ,
  v_prc_interes IN Co_Pagare.Factor_Ind%TYPE ,
  v_diferencia OUT number ,
  v_imp_total IN OUT Fa_CabCuotas.Imp_Total%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    vtotal    number(8);
    vinteres  number(8);
    vaux      number;
    Begin
      if v_prc_interes != 0 then
         vinteres := (v_prc_interes * v_imp_concepto)/100;
         vinteres := round(vinteres);
         vtotal   := vinteres + v_imp_concepto;
      else
         vtotal := v_imp_concepto;
      end if;
      v_imp_total := vtotal;
      dbms_output.put_line('Interes+Importe ='||to_char(vtotal));
      vaux     := vtotal / v_num_cuotas;
      v_imp_cuota := round(vaux);
      dbms_output.put_line('Valor cuota ='||to_char(vaux));
      if vtotal != (round(vaux)*v_num_cuotas) then
         v_diferencia := (round(vaux)*v_num_cuotas)-vtotal;
      else
         v_diferencia := 0;
      end if;
      dbms_output.put_line('sumatoria Cuotas ='||
                            to_char((vaux*v_num_cuotas)));
      v_sqlcode :=  0;
    exception
      when others then
           v_sqlcode := sqlcode;
           v_sqlerrm := substr(sqlerrm,1,100);
    End p_calcula;
  --
  -- Retrofitted
  PROCEDURE p_ins_cuota(
  v_reg_fa_cuotas IN Fa_Cuotas%ROWTYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Begin
      Insert into Fa_Cuotas (seq_cuotas,ord_cuota,fec_emision,imp_cuota,
                             ind_facturado,ind_pagado)
      Values (v_reg_fa_cuotas.seq_cuotas,v_reg_fa_cuotas.ord_cuota,
              v_reg_fa_cuotas.fec_emision,v_reg_fa_cuotas.imp_cuota,
              v_reg_fa_cuotas.ind_facturado,v_reg_fa_cuotas.ind_pagado);
    exception
      when others then
           v_sqlcode := sqlcode;
           v_sqlerrm := substr(sqlerrm,1,100);
    End p_ins_cuota;
  --
  -- Retrofitted
  PROCEDURE p_ins_cabcuota(
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
  --
  -- Retrofitted
  PROCEDURE p_seqcuota(
  vseq_cuotas OUT Fa_Cuotas.Seq_Cuotas%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Begin
      Select fa_seq_cuotas.nextval Into vseq_cuotas
      From Dual;
      v_sqlcode := 0;
      v_sqlerrm := null;
    exception
      when others then
           v_sqlcode := SQLCODE;
           v_sqlerrm := substr(SQLERRM,1,100);
    End p_seqcuota;
END fa_pac_pagare;
/
SHOW ERRORS
