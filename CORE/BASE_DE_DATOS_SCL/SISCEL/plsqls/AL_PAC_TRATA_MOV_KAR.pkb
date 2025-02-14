CREATE OR REPLACE package body al_pac_trata_mov_kar
 IS
--
  PROCEDURE trata_datos(v_mov_kar IN OUT al_pdte_kardex%rowtype ,
                        v_imp_cargo IN OUT ge_cargos.imp_cargo%type,
                        v_err IN OUT number)
  IS
  v_cod_transaccion    al_movimientos.num_movimiento%type;
  v_count_transaccion  number;
  v_tip_docu           al_docu_kardex.tip_docu%type;
  v_cod_proveedor      al_kardex.cod_proveedor%type;
  v_count_tip_docu     number;
  v_count_cargos       number;
  v_count_histcargos   number;
  v_count_equiacc      number;
  v_count_movimiento   number;
  v_ind_equiacc        al_articulos.ind_equiacc%type;
  v_num_factura        ge_cargos.num_factura%type;
  v_num_transaccion    al_docu_kardex.num_docu%type;
  v_num_docu           al_docu_kardex.num_docu%type;
  v_cod_motivo         al_kardex.cod_motivo%type;
  v_cnt_motivo             number;

        BEGIN
            v_count_transaccion:=0;
            v_err:=0;
                        v_cnt_motivo:=0;
            -- tratamiento entrada
            select count(*) into v_count_transaccion
            from al_movimientos
            where num_movimiento = v_mov_kar.num_movimiento;
            if v_count_transaccion =0 then
               return;
            end if;
            select cod_transaccion,num_transaccion into v_cod_transaccion, v_num_transaccion
            from al_movimientos
            where num_movimiento = v_mov_kar.num_movimiento;


                        select count(1)
            into   v_cnt_motivo
                        from   al_motivos_tipmovimiento_td a,
                               al_tipos_movimientos b
                        where  a.tip_movimiento > 0
                        and        a.tip_movimiento = b.tip_movimiento
                        and    b.ind_entsal     = 'E'
                        and        b.tip_stock      is not null
                        and    a.tip_movimiento = v_mov_kar.tip_movimiento;

            --if v_mov_kar.tip_movimiento in (10,11,12,23,28) then
                        if (v_cnt_motivo > 0) then
               if v_cod_transaccion = 5 then
                  select count(*) into v_count_transaccion
                  from al_cab_es_extras
                  where num_extra = v_num_transaccion;
                  if v_count_transaccion > 0 then
                     select tip_docu,num_docu, cod_motivo into v_tip_docu,v_num_docu , v_cod_motivo
                     from al_cab_es_extras
                     where  num_extra = v_num_transaccion;
                     if v_tip_docu is not null then
                        insert into al_docu_kardex(num_movkardex,tip_docu,num_docu)
                        values (v_mov_kar.num_movkardex,v_tip_docu,v_num_docu);
                        v_mov_kar.cod_motivo:=v_cod_motivo;
                     end if;
                  end if;
               else
                   if v_cod_transaccion = 1 then
                      select count(*) into v_count_transaccion
                      from al_cabecera_ordenes1
                      where num_orden = v_num_transaccion;
                      if v_count_transaccion > 0 then
                         select cod_proveedor into v_cod_proveedor
                         from al_cabecera_ordenes1
                         where num_orden = v_num_transaccion;
                         v_mov_kar.cod_proveedor:=v_cod_proveedor;
                      else
                          v_cod_proveedor:=0;
                          v_mov_kar.cod_proveedor:=v_cod_proveedor;
                      end if;
                      select count(*) into v_count_tip_docu
                      from ged_codigos
                      where cod_modulo = 'AL' and
                      nom_tabla= 'AL_DOCU_KARDEX' and
                      nom_columna= 'TIP_DOCU';
                      if v_count_tip_docu  > 0 then
                         select cod_valor into v_tip_docu
                         from ged_codigos
                         where cod_modulo = 'AL' and
                         nom_tabla= 'AL_DOCU_KARDEX' and
                         nom_columna= 'TIP_DOCU';
                         insert into al_docu_kardex(num_movkardex,tip_docu,num_docu)
                         values (v_mov_kar.num_movkardex,v_tip_docu,v_num_transaccion);
                      end if;
                   end if;
               end if;
            end if;
            -- tratamiento salida
            if v_cod_transaccion = 5 and v_mov_kar.ind_entsal='S' then
                  select count(*) into v_count_transaccion
                  from al_cab_es_extras
                  where num_extra = v_num_transaccion;
                  if v_count_transaccion > 0 then
                     select tip_docu,num_docu, cod_motivo into v_tip_docu,v_num_docu , v_cod_motivo
                     from al_cab_es_extras
                     where  num_extra = v_num_transaccion;
                     if v_tip_docu is not null then
                        insert into al_docu_kardex(num_movkardex,tip_docu,num_docu)
                        values (v_mov_kar.num_movkardex,v_tip_docu,v_num_docu);
                        v_mov_kar.cod_motivo:=v_cod_motivo;
                     end if;
                  end if;
            end if;
            if v_cod_transaccion = 1 and v_mov_kar.ind_entsal='S' then
               if v_mov_kar.num_serie is not null then
                  select count(*) into v_count_cargos
                  from ge_cargos
                  where num_serie = v_mov_kar.num_serie;
                  if v_count_cargos = 0 then
                     select count(*) into v_count_histcargos
                     from fa_histcargos
                     where num_serie = v_mov_kar.num_serie;
                     if v_count_histcargos = 0 then
                         null;
                     else
                        select num_factura into v_num_factura
                        from fa_histcargos
                        where num_serie = v_mov_kar.num_serie;
                        if v_num_factura is null then
                           null;
                        else
                           insert into al_docu_kardex(num_movkardex,tip_docu,num_docu)
                           values (v_mov_kar.num_movkardex,1,v_num_factura);
                        end if;
                     end if;
                  else
                  -- nuevo control de errores
                     select count(*) into v_count_cargos
                     from ge_cargos
                     where num_serie = v_mov_kar.num_serie;
                     if v_count_cargos > 0 then
                           select num_factura into v_num_factura
                           from ge_cargos
                           where num_serie = v_mov_kar.num_serie;
                           insert into al_docu_kardex(num_movkardex,tip_docu,num_docu)
                           values (v_mov_kar.num_movkardex,1,v_num_factura);
                     else
                           v_err := 3;
                     end if;
                  end if;
               end if;
            end if;
            if v_cod_transaccion = 3 and v_mov_kar.ind_entsal='S' then
               if v_mov_kar.num_serie is not null then
                  select count(*) into v_count_cargos
                  from ge_cargos
                  where num_serie = v_mov_kar.num_serie;
                  if v_count_cargos = 0 then
                     select count(*) into v_count_histcargos
                     from fa_histcargos
                     where num_serie = v_mov_kar.num_serie
                                         and   num_venta = v_num_transaccion;
                     if v_count_histcargos = 0 then
                         --v_err :=3;
                                                 -- 24-05-2003 CCS.-
                                                 v_err :=0;
                     else
                        select count(*) into v_count_histcargos
                        from fa_histcargos
                        where num_serie = v_mov_kar.num_serie;
                        if v_count_histcargos = 1  then
                                select num_factura,imp_cargo into v_num_factura,v_imp_cargo
                                from fa_histcargos
                                where num_serie = v_mov_kar.num_serie;
                                insert into al_docu_kardex(num_movkardex,tip_docu,num_docu)
                                values (v_mov_kar.num_movkardex,1,v_num_factura);
                            else
                                                    -- modificacion para que vaya a busar datos a vista 21-10-2002
                                                    select count(*) into  v_count_histcargos
                                                        from ga_vventas_series
                                                        where num_serie = v_mov_kar.num_serie
                                                        and   num_venta = v_num_transaccion;
                                                        if v_count_histcargos <> 0 then
                                                           select num_factura,imp_cargo into v_num_factura,v_imp_cargo
                                                           from ga_vventas_series
                                                           where num_serie = v_mov_kar.num_serie
                                                           and   num_venta = v_num_transaccion;
                                   insert into al_docu_kardex(num_movkardex,tip_docu,num_docu)
                                   values (v_mov_kar.num_movkardex,1,v_num_factura);
                                                        else
                                    --v_err :=3;
                                                    -- 24-05-2003 CCS.-
                                                       v_err :=0;
                                                        end if;
                                                -- modificacion vista
                        end if;
                     end if;
                  else
                     select count(*) into v_count_cargos
                     from ge_cargos
                     where num_serie = v_mov_kar.num_serie
                                         and   num_venta = v_num_transaccion;
                     if v_count_cargos = 1  then
                         select num_factura,imp_cargo into v_num_factura,v_imp_cargo
                             from ge_cargos
                             where num_serie = v_mov_kar.num_serie
                                                 and   num_venta = v_num_transaccion;
                             insert into al_docu_kardex(num_movkardex,tip_docu,num_docu)
                             values (v_mov_kar.num_movkardex,1,v_num_factura);
                                 else
                                                    -- modificacion para que vaya a busar datos a vista 21-10-2002
                                                    select count(*) into  v_count_histcargos
                                                        from ga_vventas_series
                                                        where num_serie = v_mov_kar.num_serie
                                                        and   num_venta = v_num_transaccion;
                                                        if v_count_histcargos <> 0 then
                                                           select num_factura,imp_cargo into v_num_factura,v_imp_cargo
                                                           from ga_vventas_series
                                                           where num_serie = v_mov_kar.num_serie
                                                           and   num_venta = v_num_transaccion;
                                   insert into al_docu_kardex(num_movkardex,tip_docu,num_docu)
                                   values (v_mov_kar.num_movkardex,1,v_num_factura);
                                                        else
                                    --v_err :=3;
                                                        -- 24-05-2003 ccs.-
                                                        v_err :=0;
                                                        end if;
                                                -- modificacion vista
                                             end if;
                  end if;
               else
                   select count(*) into v_count_equiacc
                   from al_articulos
                   where cod_articulo=v_mov_kar.cod_articulo;
                   if v_count_equiacc > 0 then
                      select ind_equiacc into v_ind_equiacc
                      from al_articulos
                      where cod_articulo=v_mov_kar.cod_articulo;
                   else
                      return;
                   end if;
                   if v_ind_equiacc <> 'E' then
                      select count(*) into v_count_movimiento
                      from al_movimientos
                      where num_movimiento=v_mov_kar.num_movimiento;
                      if v_count_movimiento > 0 then
                         select num_transaccion into v_num_transaccion
                         from al_movimientos
                         where num_movimiento=v_mov_kar.num_movimiento;
                      else
                         return;
                      end if;
                      select count(*) into v_count_cargos
                      from ge_cargos
                      where num_venta = v_num_transaccion;
                      if v_count_cargos = 0 then
                         select count(*) into v_count_histcargos
                         from fa_histcargos
                         where num_venta = v_num_transaccion;
                         if v_count_histcargos = 0 then
                            v_err:=3;
                         else
                            select count(*) into v_count_histcargos
                            from fa_histcargos
                            where num_venta = v_num_transaccion;
                            if v_count_histcargos = 1 then
                                    select num_factura into v_num_factura
                                    from fa_histcargos
                                    where num_venta = v_num_transaccion;
                                    insert into al_docu_kardex(num_movkardex,tip_docu,num_docu)
                                    values (v_mov_kar.num_movkardex,1,v_num_factura);
                                                else
                                                    -- modificacion para que vaya a busar datos a vista 21-10-2002
                                                    select count(*) into  v_count_histcargos
                                                        from ga_vventas_series
                                                        where num_serie = v_mov_kar.num_serie
                                                        and   num_venta = v_num_transaccion;
                                                        if v_count_histcargos <> 0 then
                                                           select num_factura,imp_cargo into v_num_factura,v_imp_cargo
                                                           from ga_vventas_series
                                                           where num_serie = v_mov_kar.num_serie
                                                           and   num_venta = v_num_transaccion;
                                   insert into al_docu_kardex(num_movkardex,tip_docu,num_docu)
                                   values (v_mov_kar.num_movkardex,1,v_num_factura);
                                                        else
                                    v_err :=3;
                                                        end if;
                                                -- modificacion vista
                            end if;
                         end if;
                      else
                         select count(*) into v_count_cargos
                         from ge_cargos
                         where num_venta = v_num_transaccion;
                         if v_count_cargos = 1  then
                                 select num_factura into v_num_factura
                                 from ge_cargos
                                 where num_venta = v_num_transaccion;
                                 insert into al_docu_kardex(num_movkardex,tip_docu,num_docu)
                                 values (v_mov_kar.num_movkardex,1,v_num_factura);
                          else
                                                    -- modificacion para que vaya a busar datos a vista 21-10-2002
                                                    select count(*) into  v_count_histcargos
                                                        from ga_vventas_series
                                                        where num_serie = v_mov_kar.num_serie
                                                        and   num_venta = v_num_transaccion;
                                                        if v_count_histcargos <> 0 then
                                                           select num_factura,imp_cargo into v_num_factura,v_imp_cargo
                                                           from ga_vventas_series
                                                           where num_serie = v_mov_kar.num_serie
                                                           and   num_venta = v_num_transaccion;
                                   insert into al_docu_kardex(num_movkardex,tip_docu,num_docu)
                                   values (v_mov_kar.num_movkardex,1,v_num_factura);
                                                        else
                                    v_err :=3;
                                                        end if;
                                                -- modificacion vista
                         end if;
                      end if;
                   end if;
               end if;
             end if;
EXCEPTION
          when NO_DATA_FOUND THEN
               v_err:=1;
               raise_application_error (-20003,'TMError:' || 'SIN DATOS TABLA'  );
          when OTHERS then
               --ROLLBACK;
               v_err:=2;
               raise_application_error (-20002,'TMError:' || TO_CHAR(SQLCODE) || SQLERRM || ' ERROR GENERICO.'  );
END trata_datos;
END AL_PAC_TRATA_MOV_KAR;
/
SHOW ERRORS
