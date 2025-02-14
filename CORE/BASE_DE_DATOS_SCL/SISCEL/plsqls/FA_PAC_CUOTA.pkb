CREATE OR REPLACE PACKAGE BODY        fa_pac_cuota IS
  --
  -- Retrofitted
  PROCEDURE p_main_cuota(
  v_num_cargo IN Ge_Cargos.Num_Cargo%TYPE ,
  v_cod_cuota IN Ge_TipCuotas.Cod_Cuota%TYPE ,
  v_prc_impuesto IN Fa_Presupuesto.Prc_Impuesto%TYPE ,
  v_cod_concepto IN Fa_Conceptos.Cod_Concepto%TYPE )
  IS
    vreg_tipcuotas Ge_TipCuotas%ROWTYPE;
    vreg_cuotas    Fa_Cuotas%ROWTYPE;
    vreg_ventas    Ga_Ventas%ROWTYPE;
    vreg_cargos    Ge_Cargos%ROWTYPE;
    vseq_cuota     Fa_Cuotas.Seq_Cuotas%TYPE;
    vprc_impues    Fa_Presupuesto.Prc_Impuesto%TYPE;
    vsqlcode       number;
    vsqlerrm       varchar2(100);
    Begin
      vreg_tipcuotas.cod_cuota := v_cod_cuota;
      fa_pac_cuota.p_getcuota(vreg_tipcuotas,vsqlcode,vsqlerrm);
      if vsqlcode = 0 then
         fa_pac_cuota.p_seqcuota(vseq_cuota,vsqlcode,vsqlerrm);
      end if;
      if vsqlcode = 0 then
         vreg_cargos.num_cargo    := v_num_cargo   ;
         vreg_cargos.cod_concepto := v_cod_concepto;
         vprc_impues              := v_prc_impuesto;
         fa_pac_cuota.p_getconcepto (vreg_cargos,vreg_tipcuotas,vseq_cuota,
                                     vprc_impues,vsqlcode,vsqlerrm);
      end if;
      if vsqlcode = 0 then
         Commit;
      else
         Rollback;
         raise_application_error(-20523,vsqlerrm);
      end if;
    exception
      when others then
           raise_application_error(-20529,SQLERRM);
    End p_main_cuota;
  --
  -- Retrofitted
  PROCEDURE p_main_cuota2(
  v_num_ventas IN Ge_Cargos.Num_Venta%TYPE ,
  v_cod_cuota IN Ge_TipCuotas.Cod_Cuota%TYPE ,
  v_prc_impuesto IN Fa_Presupuesto.Prc_Impuesto%TYPE ,
  v_cod_concepto IN Fa_Conceptos.Cod_Concepto%TYPE )
  IS
    vreg_tipcuotas Ge_TipCuotas%ROWTYPE;
    vreg_cargos    Ge_Cargos%ROWTYPE;
    vseq_cuota     Fa_Cuotas.Seq_Cuotas%TYPE;
    vprc_impues    Fa_Presupuesto.Prc_Impuesto%TYPE;
    vsqlcode       number;
    vsqlerrm       varchar2(100);
    Begin
      dbms_output.put_line('INICIO P_MAIN_CUOTA2');
      dbms_output.put_line('Cod_Cuota = '||v_cod_cuota);
      dbms_output.put_line('Antes de llamar a P_GETCUOTA');
      vreg_tipcuotas.cod_cuota := v_cod_cuota;
      fa_pac_cuota.p_getcuota(vreg_tipcuotas,vsqlcode,vsqlerrm);
      dbms_output.put_line('Despues de llamar a P_GETCUOTA');
      dbms_output.put_line('VSQLCODE = '||to_char(vsqlcode));
      if vsqlcode = 0 then
         dbms_output.put_line('Antes de P_SEQCUOTA');
         fa_pac_cuota.p_seqcuota(vseq_cuota,vsqlcode,vsqlerrm);
         dbms_output.put_line('Despues de P_SEQCUOTA,seq_cuota = '||
                               to_char(vseq_cuota));
      end if;
      if vsqlcode = 0 then
         vreg_cargos.num_venta    := v_num_ventas;
         vreg_cargos.cod_concepto := v_cod_concepto;
         vprc_impues              := v_prc_impuesto;
         dbms_output.put_line('Antes de llamar a P_GETCONCEPTO2');
         dbms_output.put_line('Cod_Concepto = '||to_char(v_cod_concepto));
         dbms_output.put_line('Num_Venta = '||to_char(v_num_ventas));
         dbms_output.put_line('Prc_Impuesto = '||to_char(v_prc_impuesto));
         fa_pac_cuota.p_getconcepto2(vreg_cargos,vreg_tipcuotas,vseq_cuota,
                                     vprc_impues,vsqlcode,vsqlerrm);
      end if;
      dbms_output.put_line('Despues de llamar a P_GETCONCEPTO2');
      dbms_output.put_line('VSQLCODE = '||to_char(vsqlcode));
      if vsqlcode = 0 then
         dbms_output.put_line('Antes de Realizar COMMIT');
         Commit;
      else
         Rollback;
         raise_application_error(-20523,vsqlerrm);
      end if;
    exception
      when others then
           raise_application_error(-20529,SQLERRM);
    End p_main_cuota2;
  --
  -- Retrofitted
  PROCEDURE p_getconcepto(
  v_reg_ge_cargos IN OUT Ge_Cargos%ROWTYPE ,
  v_reg_ge_tipcuotas IN OUT Ge_TipCuotas%ROWTYPE ,
  v_seq_cuota IN OUT Fa_Cuotas.Seq_Cuotas%TYPE ,
  v_prc_impuesto IN OUT Fa_Presupuesto.Prc_Impuesto%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    contador         number(4) := 0;
    v_diferencia     number(4);
    v_reg_fa_cuotas  Fa_Cuotas%ROWTYPE;
    v_imp_cuota      Fa_Cuotas.Imp_Cuota%TYPE;
    vnum_abonado     Ge_Cargos.Num_Abonado%TYPE;
    v_imp_total      Fa_CabCuotas.Imp_Total%TYPE;
    vcod_modventa    Ge_ModVenta.Cod_ModVenta%TYPE := 0;
    vleasing         Ga_DatosGener.Cod_Leasing%TYPE := 0;
    vnum_venta       Ga_Ventas.Num_Venta%TYPE;
    Begin
         select * into v_reg_ge_cargos
         from   ge_cargos
         where num_cargo    = v_reg_ge_cargos.num_cargo
           and cod_concepto = v_reg_ge_cargos.cod_concepto
           and ind_cuota    = 1;
         vnum_abonado := v_reg_ge_cargos.num_abonado;
         fa_pac_cuota.p_calcula(v_imp_cuota,v_reg_ge_tipcuotas,v_reg_ge_cargos,
                                v_prc_impuesto,v_diferencia,v_imp_total,
                                v_sqlcode,v_sqlerrm);
         vnum_venta := v_reg_ge_cargos.num_venta;
         fa_pac_cuota.p_getmodventa (vnum_venta,vcod_modventa,vleasing,
                                     v_sqlcode,v_sqlerrm);
         dbms_output.put_line('VENTA AFTER GETMODVENTA = '||
                               to_char(v_reg_ge_cargos.num_venta));
         dbms_output.put_line('Cod_ModVenta ='||to_char(vcod_modventa));
         fa_pac_cuota.p_gencuota (v_reg_ge_cargos,v_reg_ge_tipcuotas,
                                  v_seq_cuota,v_imp_cuota,v_diferencia,
                                  v_imp_total,v_reg_fa_cuotas,vcod_modventa,
                                  vleasing);
         if vnum_abonado != v_reg_ge_cargos.num_abonado then
                fa_pac_cuota.p_seqcuota(v_seq_cuota,v_sqlcode,v_sqlerrm);
         end if;
         v_sqlcode := 0;
    exception
      when no_data_found then
           v_sqlcode := SQLCODE;
           v_sqlerrm := 'Sin datos GE_CARGOS con NumVenta = '
                       ||v_reg_ge_cargos.num_venta||' ,trans ='
                       ||v_reg_ge_cargos.num_transaccion||' y conc = '
                       ||v_reg_ge_cargos.cod_concepto;
           v_sqlerrm := substr(sqlerrm,1,100);
      when too_many_rows then
           v_sqlcode := SQLCODE;
           v_sqlerrm := substr(sqlerrm,1,100);
      when others then
           v_sqlcode := SQLCODE;
           v_sqlerrm := substr(SQLERRM,1,100);
    End p_getconcepto;
  --
  -- Retrofitted
  PROCEDURE p_getconcepto2(
  v_reg_ge_cargos IN OUT Ge_Cargos%ROWTYPE ,
  v_reg_ge_tipcuotas IN OUT Ge_TipCuotas%ROWTYPE ,
  v_seq_cuota IN OUT Fa_Cuotas.Seq_Cuotas%TYPE ,
  v_prc_impuesto IN OUT Fa_Presupuesto.Prc_Impuesto%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    contador         number(4) := 0;
    v_diferencia     number(4);
    v_reg_fa_cuotas  Fa_Cuotas%ROWTYPE;
    v_imp_cuota      Fa_Cuotas.Imp_Cuota%TYPE;
    vnum_abonado     Ge_Cargos.Num_Abonado%TYPE;
    v_imp_total      Fa_CabCuotas.Imp_Total%TYPE;
    vcod_modventa    Ge_ModVenta.Cod_ModVenta%TYPE := 0;
    vleasing         Ga_DatosGener.Cod_Leasing%TYPE := 0;
    vnum_venta       Ga_Ventas.Num_Venta%TYPE;
    Cursor Cur_Cargos2 is
           Select *
           From Ge_Cargos
           Where num_venta     = v_reg_ge_cargos.num_venta
           And cod_concepto    = v_reg_ge_cargos.cod_concepto
           And ind_cuota       = 1;
    Begin
      dbms_output.put_line('INICIO P_GETCONCEPTO2');
      dbms_output.put_line('Num_Venta de Cargos = '||
                            to_char(v_reg_ge_cargos.num_venta));
      dbms_output.put_line('Cod_Concepto de Cargos = '||
                            to_char(v_reg_ge_cargos.cod_concepto));
      Select count(*) into contador
      From Ge_Cargos
      Where num_venta       = v_reg_ge_cargos.num_venta
      And   cod_concepto    = v_reg_ge_cargos.cod_concepto
      And   ind_cuota       = 1;
      If contador > 0 then
         Open Cur_Cargos2;
         Fetch Cur_Cargos2 into v_reg_ge_cargos;
         vnum_abonado := v_reg_ge_cargos.num_abonado;
         fa_pac_cuota.p_calcula(v_imp_cuota,v_reg_ge_tipcuotas,v_reg_ge_cargos,
                                v_prc_impuesto,v_diferencia,v_imp_total,
                                v_sqlcode,v_sqlerrm);
         vnum_venta := v_reg_ge_cargos.num_venta;
         fa_pac_cuota.p_getmodventa (vnum_venta,vcod_modventa,vleasing,
                                     v_sqlcode,v_sqlerrm);
         dbms_output.put_line('VENTA AFTER GETMODVENTA = '||
                               to_char(v_reg_ge_cargos.num_venta));
         dbms_output.put_line('Cod_ModVenta ='||to_char(vcod_modventa));
         For i in 1..contador Loop
             dbms_output.put_line('Diferencia ='||to_char(v_diferencia));
             fa_pac_cuota.p_gencuota (v_reg_ge_cargos,v_reg_ge_tipcuotas,
                                      v_seq_cuota,v_imp_cuota,v_diferencia,
                                      v_imp_total,v_reg_fa_cuotas,vcod_modventa,
                                      vleasing);
             Fetch Cur_Cargos2 into v_reg_ge_cargos;
             Exit When Cur_Cargos2%NOTFOUND;
             if vnum_abonado != v_reg_ge_cargos.num_abonado then
                fa_pac_cuota.p_seqcuota(v_seq_cuota,v_sqlcode,v_sqlerrm);
             end if;
         End Loop;
         Close Cur_Cargos2;
         v_sqlcode := 0;
      else
         v_sqlcode := 1043;
         v_sqlerrm := 'Sin datos GE_CARGOS con NumVenta = '
                       ||v_reg_ge_cargos.num_venta||' ,trans ='
                       ||v_reg_ge_cargos.num_transaccion||' y conc = '
                       ||v_reg_ge_cargos.cod_concepto;
      End if;
    exception
      when no_data_found then
           v_sqlcode := SQLCODE;
           v_sqlerrm := substr(sqlerrm,1,100);
      when too_many_rows then
           v_sqlcode := SQLCODE;
           v_sqlerrm := substr(sqlerrm,1,100);
      when others then
           v_sqlcode := SQLCODE;
           v_sqlerrm := substr(SQLERRM,1,100);
    End p_getconcepto2;
  --
  -- Retrofitted
  PROCEDURE p_gencuota(
  v_reg_ge_cargos IN Ge_Cargos%ROWTYPE ,
  v_reg_ge_tipcuotas IN Ge_TipCuotas%ROWTYPE ,
  v_seq_cuota IN Fa_Cuotas.Seq_Cuotas%TYPE ,
  v_imp_cuota IN Fa_Cuotas.Imp_Cuota%TYPE ,
  v_diferencia IN number ,
  v_imp_total IN OUT Fa_CabCuotas.Imp_Total%TYPE ,
  v_reg_fa_cuotas IN OUT Fa_Cuotas%ROWTYPE ,
  v_modventa IN Ge_ModVenta.Cod_ModVenta%TYPE ,
  v_leasing IN Ga_DatosGener.Cod_Leasing%TYPE )
  IS
    v_sqlcode number;
    v_sqlerrm varchar2(100);
    v_num_abonado Ge_Cargos.Num_Abonado%TYPE := 0;
    v_reg_fa_cabcuotas Fa_CabCuotas%ROWTYPE;
    Begin
      dbms_output.put_line('GENCUOTA =');
      dbms_output.put_line('En GENBCUOTA Cod_ModVenta ='||to_char(v_modventa));
      if v_num_abonado = 0 then
         v_num_abonado := v_reg_ge_cargos.num_abonado;
         v_reg_fa_cabcuotas.cod_cliente  := v_reg_ge_cargos.cod_cliente;
         v_reg_fa_cabcuotas.seq_cuotas   := v_seq_cuota;
         v_reg_fa_cabcuotas.cod_concepto := v_reg_ge_cargos.cod_concepto;
         v_reg_fa_cabcuotas.cod_moneda   := v_reg_ge_cargos.cod_moneda;
         v_reg_fa_cabcuotas.cod_producto := v_reg_ge_cargos.cod_producto;
         if v_leasing = v_modventa then
            v_reg_fa_cabcuotas.num_cuotas := v_reg_ge_tipcuotas.num_cuotas+1;
         else
            v_reg_fa_cabcuotas.num_cuotas   := v_reg_ge_tipcuotas.num_cuotas;
         end if;
         v_reg_fa_cabcuotas.imp_total    := v_imp_total;
         v_reg_fa_cabcuotas.ind_pagada   := 0;
         v_reg_fa_cabcuotas.num_abonado  := v_reg_ge_cargos.num_abonado;
         v_reg_fa_cabcuotas.num_venta    := nvl(v_reg_ge_cargos.num_venta,0);
         v_reg_fa_cabcuotas.num_transaccion  :=
                            nvl(v_reg_ge_cargos.num_transaccion,0);
         v_reg_fa_cabcuotas.cod_cuota    := v_reg_ge_tipcuotas.cod_cuota;
         v_reg_fa_cabcuotas.num_pagare   := 0;
         v_reg_fa_cabcuotas.cod_modventa := v_modventa;
         v_reg_fa_cabcuotas.num_seriele  := v_reg_ge_cargos.num_serie;
         fa_pac_cuota.p_gencabcuotas (v_reg_fa_cabcuotas,v_sqlcode,v_sqlerrm);
      elsif v_num_abonado != v_reg_ge_cargos.num_abonado then
            v_num_abonado := v_reg_ge_cargos.num_abonado;
            v_reg_fa_cabcuotas.cod_cliente  := v_reg_ge_cargos.cod_cliente;
            v_reg_fa_cabcuotas.seq_cuotas   := v_seq_cuota;
            v_reg_fa_cabcuotas.cod_concepto := v_reg_ge_cargos.cod_concepto;
            v_reg_fa_cabcuotas.cod_moneda   := v_reg_ge_cargos.cod_moneda;
            v_reg_fa_cabcuotas.cod_producto := v_reg_ge_cargos.cod_producto;
            if v_leasing = v_modventa then
               v_reg_fa_cabcuotas.num_cuotas := v_reg_ge_tipcuotas.num_cuotas+1;
            else
               v_reg_fa_cabcuotas.num_cuotas := v_reg_ge_tipcuotas.num_cuotas;
            end if;
            v_reg_fa_cabcuotas.imp_total    := v_imp_total;
            v_reg_fa_cabcuotas.ind_pagada   := 0;
            v_reg_fa_cabcuotas.num_abonado  := v_reg_ge_cargos.num_abonado;
            v_reg_fa_cabcuotas.cod_cuota    := v_reg_ge_tipcuotas.cod_cuota;
            v_reg_fa_cabcuotas.num_pagare   := 0;
            v_reg_fa_cabcuotas.cod_modventa := v_modventa;
            v_reg_fa_cabcuotas.num_seriele  := v_reg_ge_cargos.num_serie;
            fa_pac_cuota.p_gencabcuotas (v_reg_fa_cabcuotas,v_sqlcode
  ,v_sqlerrm);
      end if;
     -- v_reg_fa_cuotas.fec_emision := sysdate+v_reg_ge_tipcuotas.num_dias;
      v_reg_fa_cuotas.fec_emision := v_reg_ge_cargos.fec_alta;
      if v_diferencia != 0 then
         v_reg_fa_cuotas.imp_cuota := v_imp_cuota-v_diferencia;
      else
         v_reg_fa_cuotas.imp_cuota := v_imp_cuota;
      end if;
      For i in 1..v_reg_ge_tipcuotas.num_cuotas Loop
          v_reg_fa_cuotas.seq_cuotas := v_seq_cuota;
          v_reg_fa_cuotas.ord_cuota := i;
          if i > 1 then
             v_reg_fa_cuotas.fec_emision := v_reg_fa_cuotas.fec_emision +
                                            v_reg_ge_tipcuotas.num_dias;
             v_reg_fa_cuotas.imp_cuota := v_imp_cuota;
          end if;
          v_reg_fa_cuotas.ind_facturado := 0;
          v_reg_fa_cuotas.ind_pagado := 0;
          fa_pac_cuota.p_ins_cuota (v_reg_fa_cuotas,v_sqlcode,v_sqlerrm);
      End Loop;
      if v_modventa = v_leasing then
          v_reg_fa_cuotas.seq_cuotas  := v_seq_cuota;
          v_reg_fa_cuotas.ord_cuota   := v_reg_ge_tipcuotas.num_cuotas+1;
          v_reg_fa_cuotas.fec_emision := v_reg_fa_cuotas.fec_emision +
                                         v_reg_ge_tipcuotas.num_dias;
          v_reg_fa_cuotas.imp_cuota := 0;
          v_reg_fa_cuotas.ind_facturado := 0;
          v_reg_fa_cuotas.ind_pagado := 0;
          fa_pac_cuota.p_ins_cuota (v_reg_fa_cuotas,v_sqlcode,v_sqlerrm);
      end if;
    End p_gencuota;
  --
  -- Retrofitted
  PROCEDURE p_calcula(
  v_imp_cuota OUT Fa_Cuotas.Imp_cuota%TYPE ,
  v_reg_ge_tipcuotas IN OUT Ge_tipCuotas%ROWTYPE ,
  v_reg_ge_cargos IN OUT Ge_Cargos%ROWTYPE ,
  v_prc_impuesto IN Fa_Presupuesto.Prc_Impuesto%TYPE ,
  v_diferencia OUT number ,
  v_imp_total IN OUT Fa_CabCuotas.Imp_Total%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    vtotal          number;
    vcargo_interes  number;
    vcargo          number;
    vaux            number;
    vimpues_cargo   number := 0;
    vmonefact       Fa_DatosGener.Cod_MoneFact%TYPE;
    vimp_facturable Fa_HistConcCelu.Imp_Facturable%TYPE;
    Begin
         Select cod_monefact Into vmonefact
         From Fa_DatosGener;
         if vmonefact = v_reg_ge_cargos.cod_moneda then
            if v_reg_ge_cargos.num_unidades > 0 then
               vcargo := v_reg_ge_cargos.num_unidades *
                         round(v_reg_ge_cargos.imp_cargo);
            else
               vcargo := v_reg_ge_cargos.imp_cargo;
            end if;
            if v_reg_ge_tipcuotas.por_interes > 0 then
               vcargo_interes := vcargo+(
                                (vcargo*v_reg_ge_tipcuotas.por_interes)/100);
            else
               vcargo_interes := vcargo;
            end if;
            dbms_output.put_line('Valor del Cargo+Interes = '||
                                  to_char(vcargo_interes));
            if v_prc_impuesto != 0 then
               vimpues_cargo := (v_prc_impuesto * vcargo_interes)/100;
               vtotal        := vimpues_cargo + vcargo_interes;
            else
               vtotal := vcargo_interes;
            end if;
         else
            fa_pac_cuota.p_getcambio(v_reg_ge_cargos.fec_alta,
                                          v_reg_ge_cargos.cod_moneda,vmonefact,
                                          v_reg_ge_cargos.imp_cargo,
                                          v_reg_ge_cargos.num_unidades,
                                          vimp_facturable);
            if v_reg_ge_tipcuotas.por_interes > 0 then
               vcargo_interes := vimp_facturable+(
                                (vimp_facturable*v_reg_ge_tipcuotas.por_interes)
                                /100);
            else
               vcargo_interes := vimp_facturable;
            end if;
            dbms_output.put_line('Valor del Cargo+Interes = '||
                                  to_char(vcargo_interes));
            if v_prc_impuesto != 0 then
               vimpues_cargo := (v_prc_impuesto * vcargo_interes)/100;
               vtotal := vimpues_cargo + vcargo_interes;
            else
               vtotal := vcargo_interes;
            end if;
            v_reg_ge_cargos.cod_moneda := vmonefact;
         end if;
         dbms_output.put_line('Valor del vtotal = '||to_char(vtotal));
         v_imp_total := vtotal;
         vaux := vtotal / v_reg_ge_tipcuotas.num_cuotas;
         v_imp_cuota := round(vaux);
         if vtotal != (round(vaux)*v_reg_ge_tipcuotas.num_cuotas) then
            v_diferencia := (round(vaux)*v_reg_ge_tipcuotas.num_cuotas
  ) - vtotal;
         else
            v_diferencia := 0;
         end if;
         dbms_output.put_line('Porcentaje  ='||to_char(v_prc_impuesto));
         dbms_output.put_line('Valor de cuotas ='||to_char(vaux));
         dbms_output.put_line('Sumatoria de cuotas ='||
                             to_char((vaux*v_reg_ge_tipcuotas.num_cuotas)));
    exception
      when others then
           v_sqlcode := sqlcode;
           v_sqlerrm := substr(sqlerrm,1,100);
    End p_calcula;
  --
  -- Retrofitted
  PROCEDURE p_ins_cuota(
  v_reg_fa_cuotas IN OUT Fa_Cuotas%ROWTYPE ,
  v_sqlcode IN OUT number ,
  v_sqlerrm IN OUT varchar2 )
  IS
    Begin
      dbms_output.put_line('ORd_Cuota = '||to_char(v_reg_fa_cuotas.ord_cuota));
      dbms_output.put_line('Fec_Emision = '||
                           to_char(v_reg_fa_cuotas.fec_emision,'dd-mm-yyyy'));
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
    End p_ins_cuota;
  --
  -- Retrofitted
  PROCEDURE p_getcuota(
  v_reg_ge_tipcuotas IN OUT Ge_TipCuotas%ROWTYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Begin
      Select num_cuotas,por_interes,num_dias,ind_forminteres
      Into v_reg_ge_tipcuotas.num_cuotas,v_reg_ge_tipcuotas.por_interes,
           v_reg_ge_tipcuotas.num_dias,v_reg_ge_tipcuotas.ind_forminteres
      From Ge_TipCuotas
      Where cod_cuota = v_reg_ge_tipcuotas.cod_cuota;
      v_sqlcode := 0;
      v_sqlerrm := '';
    exception
      when no_data_found then
           v_sqlcode := SQLCODE;
           v_sqlerrm := 'No hay dato en GE_TIPCUOTAS, cod_cuota: '||
                         v_reg_ge_tipcuotas.cod_cuota;
      when too_many_rows then
           v_sqlcode := SQLCODE;
           v_sqlerrm := 'Demasiadas filas en GE_TIPCUOTAS, cod_cuota '||
                         v_reg_ge_tipcuotas.cod_cuota;
      when others then
           v_sqlcode := SQLCODE;
           v_sqlerrm := substr(SQLERRM,1,100);
    End p_getcuota;
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
      v_sqlerrm := '';
    exception
      when others then
           v_sqlcode := SQLCODE;
           v_sqlerrm := substr(SQLERRM,1,100);
    End p_seqcuota;
  --
  -- Retrofitted
  PROCEDURE p_gencabcuotas(
  v_reg_fa_cabcuotas IN Fa_CabCuotas%ROWTYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Begin
      dbms_output.put_line('INSERTANDO EN FA_CABCUOTAS ARRRRJJJJJ');
      Insert Into Fa_CabCuotas
            (cod_cliente,seq_cuotas,cod_concepto,cod_moneda,cod_producto,
             num_cuotas,imp_total,ind_pagada,num_abonado,num_venta,
             num_transaccion,cod_cuota,num_pagare,cod_modventa,num_seriele)
      Values (v_reg_fa_cabcuotas.cod_cliente,v_reg_fa_cabcuotas.seq_cuotas,
              v_reg_fa_cabcuotas.cod_concepto,v_reg_fa_cabcuotas.cod_moneda,
              v_reg_fa_cabcuotas.cod_producto,v_reg_fa_cabcuotas.num_cuotas,
              v_reg_fa_cabcuotas.imp_total,v_reg_fa_cabcuotas.ind_pagada,
              v_reg_fa_cabcuotas.num_abonado,v_reg_fa_cabcuotas.num_venta,
              v_reg_fa_cabcuotas.num_transaccion,v_reg_fa_cabcuotas.cod_cuota,
              v_reg_fa_cabcuotas.num_pagare,v_reg_fa_cabcuotas.cod_modventa,
              v_reg_fa_cabcuotas.num_seriele);
      dbms_output.put_line('FIN EN FA_CABCUOTAS ARRRRJJJJJ');
    exception
      when others then
           dbms_output.put_line('Error en cabecera = '||to_char(sqlcode));
           v_sqlcode := SQLCODE;
           v_sqlerrm := substr(SQLERRM,1,100);
    End p_gencabcuotas;
  --
  -- Retrofitted
  PROCEDURE p_getmodventa(
  v_num_venta IN Ga_Ventas.Num_Venta%TYPE ,
  v_modventa OUT Ge_ModVenta.Cod_ModVenta%TYPE ,
  v_leasing OUT Ga_DatosGener.Cod_Leasing%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Begin
      Select cod_modventa Into v_modventa
      From Ga_Ventas
      Where num_venta = v_num_venta;
      Select cod_leasing Into v_leasing
      From Ga_DatosGener;
    exception
      when others then
           v_sqlcode := SQLCODE;
           v_sqlerrm := substr(SQLERRM,1,100);
    End p_getmodventa;
  --
  -- Retrofitted
  PROCEDURE p_getcambio(
  v_fec_valor IN Fa_HistConcCelu.fec_valor%TYPE ,
  v_cod_monedaorig IN Fa_HistConcCelu.Cod_Moneda%TYPE ,
  v_cod_monedadest IN Fa_DatosGener.Cod_MoneFact%TYPE ,
  v_imp_concepto IN Fa_HistConcCelu.Imp_Concepto%TYPE ,
  v_num_unidades IN Fa_HistConcCelu.Num_Unidades%TYPE ,
  v_imp_facturable OUT Fa_HistConcCelu.Imp_Facturable%TYPE )
  IS
    v_cambiorig   Ge_Conversion.Cambio%TYPE;
    v_cambiodes   Ge_Conversion.Cambio%TYPE;
    Begin
      Select cambio Into v_cambiorig
      From Ge_Conversion
      Where fec_desde <= v_fec_valor
      And   fec_hasta >= v_fec_valor
      And   cod_moneda = v_cod_monedaorig;
      Select cambio Into v_cambiodes
      From Ge_Conversion
      Where fec_desde <= v_fec_valor
      And   fec_hasta >= v_fec_valor
      And   cod_moneda = v_cod_monedadest;
      if v_num_unidades > 0 then
         v_imp_facturable := v_num_unidades *
                            (round(v_imp_concepto
  ,2) * (v_cambiorig/v_cambiodes));
      else
         v_imp_facturable := round(v_imp_concepto
  ,2) * (v_cambiorig/v_cambiodes);
      end if;
    exception
      when no_data_found then
           raise_application_error (-20521,'no existen datos en GE_CONVERSION');
      when too_many_rows then
           raise_application_error (-20521, 'Demasiadas filas en GE_CONVERSION
  ');
      when others then
           raise_application_error (-20521,SQLERRM);
    End p_getcambio;
END fa_pac_cuota;
/
SHOW ERRORS
