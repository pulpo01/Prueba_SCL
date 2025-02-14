CREATE OR REPLACE PACKAGE BODY        fa_pac_arreglo IS
  --
  -- Retrofitted
  PROCEDURE p_main_arreglo(
  v_seq_cuotas IN Fa_CabCuotas.Seq_Cuotas%TYPE ,
  v_regenera IN number )
  IS
    vreg_cuotas    Fa_Cuotas%ROWTYPE;
    vseq_cuotas    Fa_Cuotas.Seq_Cuotas%TYPE;
    vsqlcode       number;
    vsqlerrm       varchar2(100);
    Begin
      vseq_cuotas := v_seq_cuotas;
      fa_pac_arreglo.p_genera(vseq_cuotas,vreg_cuotas,v_regenera,
                              vsqlcode,vsqlerrm);
    /* if vsqlcode = 0 then
         Commit;
      else
         Rollback;
         raise_application_error(-20523,vsqlerrm);
      end if; */
    exception
      when others then
           raise_application_error(-20529,SQLERRM);
    End p_main_arreglo;
  --
  -- Retrofitted
  PROCEDURE p_genera(
  v_seq_cuotas IN OUT Fa_Cuotas.Seq_Cuotas%TYPE ,
  v_reg_fa_cuotas IN OUT Fa_Cuotas%ROWTYPE ,
  v_regenera IN number ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    vcontador      number(4);
    vencontrado    number(1) := 0;
    v_ord_cuota    Fa_Cuotas.Ord_Cuota%TYPE;
    v_ord_cuota2   Fa_Cuotas.Ord_Cuota%TYPE;
    v_fec_emision  Fa_Cuotas.Fec_Emision%TYPE;
    v_fec_emision2 Fa_Cuotas.Fec_Emision%TYPE;
    Cursor Cur_Cuotas is
           Select ord_cuota,fec_emision,ind_facturado,ind_pagado
           From Fa_Cuotas
           Where seq_cuotas  = v_seq_cuotas
           And ord_cuota    >= v_ord_cuota2
           Order by ord_cuota;
    Begin
      Select count(*) into vcontador
      From Fa_Cuotas
      Where seq_cuotas = v_seq_cuotas;
      If vcontador > 0 then
         Select max(ord_cuota) Into v_ord_cuota2
         From Fa_Cuotas
         Where seq_cuotas = v_seq_cuotas
         And ind_pagado   = 1;
         If v_ord_cuota2 != vcontador then
            Open Cur_Cuotas;
            Fetch Cur_Cuotas
            Into v_reg_fa_cuotas.ord_cuota,v_reg_fa_cuotas.fec_emision,
                 v_reg_fa_cuotas.ind_facturado,v_reg_fa_cuotas.ind_pagado;
            if v_reg_fa_cuotas.ind_facturado = 0 and
               v_reg_fa_cuotas.ind_pagado    = 1 and
               v_reg_fa_cuotas.ord_cuota     = v_ord_cuota2 then
               v_fec_emision2 := v_reg_fa_cuotas.fec_emision;
            end if;
            For i in 1..vcontador Loop
                Fetch Cur_Cuotas
                Into v_reg_fa_cuotas.ord_cuota,v_reg_fa_cuotas.fec_emision,
                     v_reg_fa_cuotas.ind_facturado,v_reg_fa_cuotas.ind_pagado;
                Exit When Cur_Cuotas%NOTFOUND;
                if v_reg_fa_cuotas.ind_facturado = 0 and
                   v_reg_fa_cuotas.ind_pagado    = 0 then
                   vencontrado   := 1;
                   v_fec_emision := v_reg_fa_cuotas.fec_emision;
                   v_ord_cuota   := v_reg_fa_cuotas.ord_cuota;
                end if;
                -- Si v_regenera = 0 no regenerar fechas de emision,
                -- Si v_regenera = 1 si se regeneran las fechas de emision
                if vencontrado = 1 and v_regenera = 1 then
                   fa_pac_arreglo.p_upd_cuota(v_fec_emision2,v_seq_cuotas,
                                              v_ord_cuota,v_sqlcode,v_sqlerrm);
                   v_fec_emision2 := v_fec_emision;
                   vencontrado := 0;
                end if;
            End Loop;
            Close Cur_Cuotas;
            v_sqlcode := 0;
         else
            v_sqlcode := 0;
         end if;
      else
         v_sqlcode := 1043;
         v_sqlerrm := 'No hay datos en FA_CUOTAS con Seq_Cuotas = '
                       ||to_char(v_seq_cuotas);
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
    End p_genera;
  --
  -- Retrofitted
  PROCEDURE p_upd_cuota(
  v_fec_emision IN Fa_Cuotas.Fec_Emision%TYPE ,
  v_seq_cuotas IN Fa_Cuotas.Seq_Cuotas%TYPE ,
  v_ord_cuota IN Fa_Cuotas.Ord_Cuota%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Begin
      dbms_output.put_line('Dentro de p_upd_cuota');
      dbms_output.put_line('Fec_Emision= '||to_char(v_fec_emision,'dd-mon-yyyy
  '));
      dbms_output.put_line('Seq_Cuotas  = '||to_char(v_seq_cuotas));
      dbms_output.put_line('OrdCuota  = '||to_char(v_ord_cuota));
      dbms_output.put_line('');
      Update Fa_Cuotas set fec_emision = v_fec_emision
      Where seq_cuotas = v_seq_cuotas
      And   ord_cuota  = v_ord_cuota;
    exception
      when others then
           v_sqlcode := sqlcode;
           v_sqlerrm := substr(sqlerrm,1,100);
    End p_upd_cuota;
END fa_pac_arreglo;
/
SHOW ERRORS
