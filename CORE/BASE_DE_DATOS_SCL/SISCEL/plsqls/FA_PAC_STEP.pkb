CREATE OR REPLACE PACKAGE BODY        fa_pac_step IS
  --
  -- Retrofitted
  PROCEDURE p_main(
  v_proceso IN Fa_Procesos.Num_Proceso%TYPE ,
  v_tipdocum IN Ge_TipDocumen.Cod_TipDocum%TYPE ,
  v_cliente IN Ge_Clientes.Cod_Cliente%TYPE ,
  v_step IN varchar2 )
  IS
    rec_ge_datosgener   Ge_DatosGener%ROWTYPE;
    rec_fa_datosgener   Fa_DatosGener%ROWTYPE;
    vsqlcode            number := 0;
    vsqlerrm            varchar2(100) := null;
    vproceso            Fa_Procesos.Num_Proceso%TYPE;
    Begin
      vproceso := v_proceso;
      fa_pac_step.p_getgedatosgener(rec_ge_datosgener);
      fa_pack_traspaso.p_getfadatosgener(rec_fa_datosgener);
      if v_tipdocum = rec_fa_datosgener.cod_contado then
         dbms_output.put_line('Factura de Contado');
         fa_pac_step.p_step_contado(vproceso,v_step,vsqlcode,vsqlerrm);
      elsif v_tipdocum = rec_fa_datosgener.cod_notacre or
            v_tipdocum = rec_fa_datosgener.cod_notadeb then
            fa_pac_step.p_step_notas(vproceso,v_step,vsqlcode,vsqlerrm);
      elsif v_tipdocum = rec_fa_datosgener.cod_baja then
            fa_pac_step.p_step_baja(vproceso,v_step,vsqlcode,vsqlerrm);
      elsif v_tipdocum = rec_fa_datosgener.cod_liquidacion then
            fa_pac_step.p_step_liquidacion(vproceso,v_step,vsqlcode,vsqlerrm);
      elsif v_tipdocum = rec_fa_datosgener.cod_rentaphone then
            fa_pac_step.p_step_rentaphone(vproceso,v_step,vsqlcode,vsqlerrm);
      elsif v_tipdocum = rec_fa_datosgener.cod_ciclo then
            fa_pac_step.p_step_ciclo(vproceso,v_cliente,v_step,rec_ge_datosgener
  ,
                                     vsqlcode,vsqlerrm);
      end if;
      dbms_output.put_line('Main al final, sqlcode = '||to_char(vsqlcode));
      if vsqlcode != 0 then
         dbms_output.put_line('Rollback en Main');
         Rollback;
      else
         dbms_output.put_line('Commit en Main');
         Commit;
      end if;
    End p_main;
  --
  -- Retrofitted
  PROCEDURE p_getgedatosgener(
  v_ge_datosgener OUT Ge_DatosGener%ROWTYPE )
  IS
    Begin
      Select *
      Into   v_ge_datosgener
      From Ge_DatosGener;
    exception
      when no_data_found then
           raise_application_error (-20518,'no existen datos en GE_DATOSGENER');
      when too_many_rows then
           raise_application_error (-20518, 'Demasiadas filas en GE_DATOSGENER
  ');
      when others then
           raise_application_error (-20518,SQLERRM);
    End p_getgedatosgener;
  --
  -- Retrofitted
  PROCEDURE p_step_contado(
  v_proceso IN OUT Fa_Procesos.Num_Proceso%TYPE ,
  v_step IN varchar2 ,
  v_sqlcode IN OUT number ,
  v_sqlerrm IN OUT varchar2 )
  IS
    rec_histcargos Fa_HistCargos%ROWTYPE;
    vnum_venta     Ga_Ventas.Num_Venta%TYPE;
    vnum_transacc  Ga_Transcontado.Num_Transaccion%TYPE;
    Begin
      dbms_output.put_line('STEP_CONTADO');
      dbms_output.put_line('Valor de Sqlcode = '||to_char(v_sqlcode));
      dbms_output.put_line('Valor de Step = '||v_step);
      if upper(v_step) = 'S' then
         fa_pac_step.p_step_getcargos(rec_histcargos,v_proceso,v_sqlcode,
                                      v_sqlerrm);
        dbms_output.put_line('Sqlcode despues de getcargos = '||
                                                 to_char(v_sqlcode));
         if v_sqlcode = 0 then
            dbms_output.put_line('Debe borrar Ge_Cargos,comentado');
           -- Delete Ge_Cargos where num_factura=v_proceso;
            Delete Fa_Presupuesto Where num_proceso = v_proceso;
            Delete Fa_Procesos    Where num_proceso = v_proceso;
         end if;
      elsif upper(v_step) = 'N' then
            dbms_output.put_line('Valor de Step en elsif = '||v_step);
            Select num_venta,num_transaccion Into vnum_venta,vnum_transacc
            From Ge_Cargos
            Where num_factura = v_proceso
            And   rownum      = 1;
            if vnum_venta = 0 then
               Update Ga_Transcontado set imp_venta  = null,
                                          cod_moneda = null
               Where num_transaccion = vnum_transacc;
            else
               Update Ga_Ventas set imp_venta  = null,
                                    cod_moneda = null
               Where num_venta = vnum_venta;
            end if;
            Update Ge_Cargos set num_factura = 0
            Where num_factura = v_proceso;
            Delete Fa_Presupuesto Where num_proceso = v_proceso;
            Delete Fa_Procesos    Where num_proceso = v_proceso;
            Delete Fa_Histdocu    where num_proceso = v_proceso;
      end if;
      dbms_output.put_line('Final de Step_Contado.Sqlcode =
  '||to_char(sqlcode));
      if sqlcode != 0 then
         v_sqlerrm := substr(sqlerrm,1,100);
      end if;
      v_sqlcode := sqlcode;
    End p_step_contado;
  --
  -- Retrofitted
  PROCEDURE p_step_notas(
  v_proceso IN OUT Fa_Procesos.Num_Proceso%TYPE ,
  v_step IN varchar2 ,
  v_sqlcode IN OUT number ,
  v_sqlerrm IN OUT varchar2 )
  IS
    Begin
      dbms_output.put_line('STEP_NOTAS');
      dbms_output.put_line('Valor de Sqlcode = '||to_char(v_sqlcode));
      dbms_output.put_line('Valor de Step = '||v_step);
      if upper(v_step) = 'S' then
            Delete Fa_Prefactura Where num_proceso = v_proceso;
            Delete Fa_Procesos   Where num_proceso = v_proceso;
      elsif upper(v_step) = 'N' then
            dbms_output.put_line('Valor de Step en elsif = '||v_step);
            Delete Fa_Prefactura Where num_proceso = v_proceso;
            Delete Fa_Procesos   Where num_proceso = v_proceso;
            Delete Fa_Histdocu   where num_proceso = v_proceso;
      end if;
      dbms_output.put_line('Final de Step_Notas.Sqlcode = '||to_char(sqlcode));
      if sqlcode != 0 then
         v_sqlerrm := substr(sqlerrm,1,100);
         v_sqlcode := sqlcode;
      end if;
    End p_step_notas;
  --
  -- Retrofitted
  PROCEDURE p_step_baja(
  v_proceso OUT Fa_Procesos.Num_Proceso%TYPE ,
  v_step IN varchar2 ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Begin
     null;
    End p_step_baja;
  --
  -- Retrofitted
  PROCEDURE p_step_liquidacion(
  v_proceso OUT Fa_Procesos.Num_Proceso%TYPE ,
  v_step IN varchar2 ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Begin
     null;
    End p_step_liquidacion;
  --
  -- Retrofitted
  PROCEDURE p_step_rentaphone(
  v_proceso OUT Fa_Procesos.Num_Proceso%TYPE ,
  v_step IN varchar2 ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Begin
     null;
    End p_step_rentaphone;
  --
  -- Retrofitted
  PROCEDURE p_step_getcargos(
  rec_histcargos IN OUT Fa_HistCargos%ROWTYPE ,
  v_proceso IN Fa_Procesos.Num_Proceso%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Cursor Cur_Cargos is
       Select num_cargo,cod_cliente,cod_producto,cod_concepto,fec_alta,imp_cargo,
              cod_moneda,cod_plancom,num_unidades,ind_factur,num_transaccion,
              num_venta,num_paquete,num_abonado,num_terminal,cod_ciclfact,
              num_serie,num_seriemec,cap_code,mes_garantia,num_preguia,num_guia,
              num_factura,cod_concepto_dto,val_dto,tip_dto,ind_cuota,ind_supertel
       From Ge_Cargos
       Where num_factura = v_proceso;
    v_contador number;
    Begin
      dbms_output.put_line('GETCARGOS');
      Open Cur_Cargos;
      Loop
         Fetch Cur_Cargos
         Into rec_histcargos.num_cargo,rec_histcargos.cod_cliente,
                  rec_histcargos.cod_producto,rec_histcargos.cod_concepto,
                  rec_histcargos.fec_alta,rec_histcargos.imp_cargo,
                  rec_histcargos.cod_moneda,rec_histcargos.cod_plancom,
                  rec_histcargos.num_unidades,rec_histcargos.ind_factur,
                  rec_histcargos.num_transaccion,rec_histcargos.num_venta,
                  rec_histcargos.num_paquete,rec_histcargos.num_abonado,
                  rec_histcargos.num_terminal,rec_histcargos.cod_ciclfact,
                  rec_histcargos.num_serie,rec_histcargos.num_seriemec,
                  rec_histcargos.cap_code,rec_histcargos.mes_garantia,
                  rec_histcargos.num_preguia,rec_histcargos.num_guia,
                  rec_histcargos.num_proceso,rec_histcargos.cod_concepto_dto,
                  rec_histcargos.val_dto,rec_histcargos.tip_dto,
                  rec_histcargos.ind_cuota,rec_histcargos.ind_supertel;
         Exit when Cur_Cargos%NOTFOUND;
         fa_pac_step.p_step_inscargos(rec_histcargos,v_sqlcode,v_sqlerrm);
      End Loop;
      dbms_output.put_line('GetCargos, Sqlcode = '||to_char(sqlcode));
      v_sqlcode := sqlcode;
      Close Cur_Cargos;
    exception
      when others then
           v_sqlcode := sqlcode;
           v_sqlerrm := substr(sqlerrm,1,100);
    End p_step_getcargos;
  --
  -- Retrofitted
  PROCEDURE p_step_inscargos(
  rec_histcargos IN Fa_HistCargos%ROWTYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Begin
      dbms_output.put_line('INSCARGOS');
      Insert into Fa_HistCargos
            (num_cargo,cod_cliente,cod_concepto,cod_producto,fec_alta,
             imp_cargo,cod_moneda,cod_plancom,num_unidades,ind_factur,
             num_transaccion,num_proceso,num_venta,cod_ciclfact,num_abonado,
             num_seriemec,num_serie,cap_code,mes_garantia,num_preguia,num_guia,
             cod_concepto_dto,val_dto,tip_dto,ind_cuota,ind_supertel,num_paquete
  ,
             num_terminal)
      Values (rec_histcargos.num_cargo,rec_histcargos.cod_cliente,
             rec_histcargos.cod_concepto,rec_histcargos.cod_producto,
             rec_histcargos.fec_alta,rec_histcargos.imp_cargo,
             rec_histcargos.cod_moneda,rec_histcargos.cod_plancom,
             rec_histcargos.num_unidades,rec_histcargos.ind_factur,
             rec_histcargos.num_transaccion,rec_histcargos.num_proceso,
             rec_histcargos.num_venta,rec_histcargos.cod_ciclfact,
             rec_histcargos.num_abonado,rec_histcargos.num_seriemec,
             rec_histcargos.num_serie,rec_histcargos.cap_code,
             rec_histcargos.mes_garantia,rec_histcargos.num_preguia,
             rec_histcargos.num_guia,rec_histcargos.cod_concepto_dto,
             rec_histcargos.val_dto,rec_histcargos.tip_dto,
             rec_histcargos.ind_cuota,rec_histcargos.ind_supertel,
             rec_histcargos.num_paquete,rec_histcargos.num_terminal);
      dbms_output.put_line('Insert, Sqlcode = '||to_char(sqlcode));
      v_sqlcode := sqlcode;
    End p_step_inscargos;
  --
  -- Retrofitted
  PROCEDURE p_step_ciclo(
  v_proceso IN OUT Fa_Procesos.Num_Proceso%TYPE ,
  v_cliente IN Ge_Clientes.Cod_Cliente%TYPE ,
  v_step IN varchar2 ,
  v_rec_ge_datosgener IN Ge_DatosGener%ROWTYPE ,
  v_sqlcode IN OUT number ,
  v_sqlerrm IN OUT varchar2 )
  IS
    Type Tipo_Rec_Ciclo is Record
        (cod_ciclo    Fa_CicloCli.Cod_Ciclo%TYPE,
         cod_producto Fa_CicloCli.Cod_Producto%TYPE,
         num_abonado  Fa_CicloCli.Num_Abonado%TYPE,
         ind_cambio   Fa_CicloCli.Ind_Cambio%TYPE,
         cod_ciclonue Fa_CicloCli.Cod_CicloNue%TYPE,
         cod_ciclfact Fa_CiclFact.Cod_CiclFact%TYPE);
    rec_ciclo Tipo_Rec_Ciclo;
      Cursor Cur_CicloCli is
         Select a.cod_ciclo,a.cod_producto,a.num_abonado,a.ind_cambio,
                a.cod_ciclonue,b.cod_ciclfact
         From Fa_CicloCli a, Fa_Procesos b
         Where a.cod_cliente = v_cliente
         And   a.num_proceso = v_proceso
         And   a.num_proceso = b.num_proceso;
    Begin
      dbms_output.put_line('STEP_CICLO');
      dbms_output.put_line('Valor de Sqlcode = '||to_char(v_sqlcode));
      dbms_output.put_line('Valor de Step = '||v_step);
      Open Cur_CicloCli;
      Loop
        Fetch Cur_CicloCli
        Into rec_ciclo;
        Exit when Cur_CicloCli%NOTFOUND;
        if upper(v_step) = 'S' then
           if rec_ciclo.cod_producto = v_rec_ge_datosgener.prod_celular then
              Update Ga_InfacCel
              Set ind_cuotas = 0,
                  ind_arriendo = 0,
                  ind_cargos = 0,
                  ind_penaliza = 0
              Where cod_cliente = v_cliente
              And   num_abonado = rec_ciclo.num_abonado
              And   cod_ciclfact = rec_ciclo.cod_ciclfact;
           elsif rec_ciclo.cod_producto = v_rec_ge_datosgener.prod_beeper then
                 Update Ga_InfacBeep
                 Set ind_cuotas = 0,
                     ind_arriendo = 0,
                     ind_cargos = 0,
                     ind_penaliza = 0
                 Where cod_cliente = v_cliente
                 And   num_abonado = rec_ciclo.num_abonado
                 And   cod_ciclfact = rec_ciclo.cod_ciclfact;
           elsif rec_ciclo.cod_producto = v_rec_ge_datosgener.prod_trek then
                 Update Ga_InfacTrek
                 Set ind_cuotas = 0,
                     ind_arriendo = 0,
                     ind_cargos = 0,
                     ind_penaliza = 0
                 Where cod_cliente = v_cliente
                 And   num_abonado = rec_ciclo.num_abonado
                 And   cod_ciclfact = rec_ciclo.cod_ciclfact;
           elsif rec_ciclo.cod_producto = v_rec_ge_datosgener.prod_trunk then
                 Update Ga_InfacTrunk
                 Set ind_cuotas = 0,
                     ind_arriendo = 0,
                     ind_cargos = 0,
                     ind_penaliza = 0
                 Where cod_cliente = v_cliente
                 And   num_abonado = rec_ciclo.num_abonado
                 And   cod_ciclfact = rec_ciclo.cod_ciclfact;
           end if;
           if v_sqlcode = 0 then
              dbms_output.put_line('Debe borrar Ge_Cargos,comentado');
           -- Delete Ge_Cargos where num_factura=v_proceso;
              Delete Fa_Presupuesto Where num_proceso = v_proceso;
              Delete Fa_Procesos    Where num_proceso = v_proceso;
           end if;
        elsif upper(v_step) = 'N' then
              dbms_output.put_line('Valor de Step en elsif = '||v_step);
              Update Ge_Cargos set num_factura = 0
              Where num_factura = v_proceso;
              Delete Fa_Presupuesto Where num_proceso = v_proceso;
              Delete Fa_Procesos    Where num_proceso = v_proceso;
              Delete Fa_Histdocu    where num_proceso = v_proceso;
        end if;
        dbms_output.put_line('Final de Step_Ciclo.Sqlcode = '||
                              to_char(sqlcode));
        if sqlcode != 0 then
           v_sqlerrm := substr(sqlerrm,1,100);
        end if;
        v_sqlcode := sqlcode;
      End Loop;
      Close Cur_CicloCli;
    End p_step_ciclo;
  --
  -- Retrofitted
  PROCEDURE p_step_update(
  v_cliente IN OUT Fa_CicloCli.Cod_Cliente%TYPE ,
  v_num_abonado IN OUT Fa_CicloCli.Num_Abonado%TYPE ,
  v_cod_producto IN OUT Fa_CicloCli.Cod_Producto%TYPE ,
  v_ind_cuotas IN OUT Ga_InfacCel.Ind_Cuotas%TYPE ,
  v_ind_arriendo IN OUT Ga_InfacCel.Ind_Cuotas%TYPE ,
  v_cod_ciclfact IN OUT Fa_CiclFact.Cod_CiclFact%TYPE )
  IS
    v_ciclonue    Fa_CicloCli.Cod_CicloNue%TYPE;
    v_ind_cambio  Fa_CicloCli.Ind_Cambio%TYPE;
    v_ind_pagada1 Fa_CabCuotas.Ind_Pagada%TYPE := 0;
    v_fecdesde    varchar2(17) := null;
    v_fechasta    varchar2(17) := null;
    v_fechoy      varchar2(17) := to_char(sysdate,'yyyymmdd hh24:mi:ss');
    Cursor Cuotas_Cli is
       Select ind_pagada
       From Fa_Cabcuotas
       Where cod_cliente = v_cliente
       And cod_producto  = v_cod_producto
       And num_abonado   = v_num_abonado;
    Cursor Arriendo_Cli is
       Select to_char(fec_desde,'yyyymmdd hh24:mi:ss'),
              to_char(fec_hasta,'yyyymmdd hh24:mi:ss')
       From Fa_Arriendo
       Where cod_cliente = v_cliente
       And cod_producto  = v_cod_producto
       And num_abonado   = v_num_abonado;
    Begin
      dbms_output.put_line('Step_Update INICIO');
      dbms_output.put_line('Parametros de Entrada');
      dbms_output.put_line('Cliente = '||to_char(v_cliente));
      dbms_output.put_line('Producto = '||to_char(v_cod_producto));
      dbms_output.put_line('Abonado = '||to_char(v_num_abonado));
      dbms_output.put_line('IndArriendo = '||to_char(v_ind_arriendo));
      dbms_output.put_line('IndCuotas = '||to_char(v_ind_cuotas));
      dbms_output.put_line('CodCiclfact');
    -- Comprobamos si el abonado se ha cambiodo de ciclo.
      Select cod_ciclonue,ind_cambio
      Into v_ciclonue,v_ind_cambio
      From Fa_CicloCli
      Where cod_cliente  = v_cliente
      And   cod_producto = v_cod_producto
      And   num_abonado  = v_num_abonado;
      if v_ind_cambio = 1 then
         Update Fa_CicloCli
         Set cod_ciclo = v_ciclonue,
             ind_cambio = 0,
             cod_ciclonue = null
         Where cod_cliente = v_cliente
         And cod_producto  = v_cod_producto
         And num_abonado   = v_num_abonado;
      -- Busca el nuevo Cod_CiclFact para Cod_CicloNue.
         Select cod_ciclfact
         Into v_cod_ciclfact
         From Fa_CiclFact
         Where cod_ciclo = v_ciclonue
         And to_char(fec_hastallam,'yyyymmdd hh24:mi:ss') > v_fechoy
         And rownum = 1;
      end if;
    -- Comprobamos si el cliente abonado/producto ha cancelado todas sus cuotas.
      Open Cuotas_Cli;
      Loop
        Fetch Cuotas_Cli
        Into v_ind_pagada1;
        Exit when Cuotas_Cli%NOTFOUND;
        if v_ind_pagada1 != 0 then
           v_ind_cuotas := v_ind_pagada1;
           exit;
        end if;
      End Loop;
      Close Cuotas_Cli;
    -- Comprobamos si el cliente abonado/producto tiene periodos de arriendo
    -- vigentes.
      Open Arriendo_Cli;
      Loop
        Fetch Arriendo_Cli
        Into v_fecdesde,v_fechasta;
        Exit when Arriendo_Cli%NOTFOUND;
        If v_fecdesde <= v_fechoy and v_fechasta >= v_fechoy then
           v_ind_arriendo := 1;
           exit;
        else
           v_ind_arriendo := 0;
        end if;
      End Loop;
      Close Arriendo_Cli;
      dbms_output.put_line('Step_Update Fin');
      dbms_output.put_line('Parametros de Salida');
      dbms_output.put_line('Cliente = '||to_char(v_cliente));
      dbms_output.put_line('Producto = '||to_char(v_cod_producto));
      dbms_output.put_line('Abonado = '||to_char(v_num_abonado));
      dbms_output.put_line('IndArriendo = '||to_char(v_ind_arriendo));
      dbms_output.put_line('IndCuotas = '||to_char(v_ind_cuotas));
      dbms_output.put_line('CodCiclfact = '||to_char(v_cod_ciclfact));
    End p_step_update;
END fa_pac_step;
/
SHOW ERRORS
