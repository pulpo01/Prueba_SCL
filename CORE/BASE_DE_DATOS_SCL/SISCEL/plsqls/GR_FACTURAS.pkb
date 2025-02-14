CREATE OR REPLACE PACKAGE BODY        GR_FACTURAS
  AS
  type registro is record (
        titulo            varchar2(50),
        abonados          number(10),
        mto_cf            number(16,4),
        segs_cf           number(16,4),
        mto_ad            number(16,4),
        segs_ad           number(16,4),
        mto_cpp           number(16,4),
        segs_cpp          number(16,4),
        mto_ot            number(16,4));
/* --------------------------------------------------------------- */
   PROCEDURE pivote_empresa(arch_ok  in out utl_file.file_type,
                            arch_err in out utl_file.file_type) AS
  cursor paso is select
    cliente          cliente,
    count(*)         cuenta
    from gr_exp_detalle_temp
    group by cliente;
    v_error        varchar2(100);
    v_bandera      number(1);
    v_empresa      number(8);
    v_linea        varchar2(30);
begin
   for cc in paso loop
     v_bandera:=0;
     v_empresa:=0;
     begin
       select cod_empresa
       into v_empresa
       from ga_empresa
       where cod_cliente=cc.cliente;
     exception
       when others then
         v_empresa:=0;
         v_bandera:=1;
     end;
     if v_bandera=0 then
       v_linea:=cc.cliente||'|'||v_empresa||'|';
       utl_file.put_line(arch_ok,v_linea);
     end if;
   end loop;
   utl_file.put_line(arch_err,'salio todo ok..');
exception
  when others then
     utl_file.put_line(arch_err,'Se cayo en alguna parte...:'||sqlerrm);
end;
/* --------------------------------------------------------------- */
   PROCEDURE pivote_individual(arch_ok  in out utl_file.file_type,
                               arch_err in out utl_file.file_type) AS
      cursor paso is select
        cliente          cliente,
        abonado          abonado,
        count(*)         cuenta
        from gr_exp_detalle_temp
        group by cliente,abonado;
        v_error        varchar2(100);
        v_bandera      number(1);
        v_empresa      number(8);
        v_linea        varchar2(30);
   begin
      for cc in paso loop
        v_bandera:=0;
        v_empresa:=0;
        if cc.abonado=0 then
          v_bandera:=1;
        end if;
        if v_bandera=0 then
          begin
            select cod_empresa
            into v_empresa
            from ga_empresa
            where cod_cliente=cc.cliente;
            v_bandera:=1;
          exception
            when others then
              v_empresa:=0;
              v_bandera:=0;
          end;
        end if;
        if v_bandera=0 then
          v_linea:=cc.cliente||'|'||cc.abonado||'|';
          utl_file.put_line(arch_ok,v_linea);
        end if;
      end loop;
      utl_file.put_line(arch_err,'salio todo ok..');
   exception
     when others then
        utl_file.put_line(arch_err,'Se cayo en alguna parte...:'||sqlerrm);
   end pivote_individual;
/* --------------------------------------------------------------- */
   PROCEDURE extrae (p_desde   in     number,
                     p_hasta   in     number,
                     p_ciclo   in     number,
                     p_tabla   in     varchar2,
                     arch_err  in out utl_file.file_type) AS
     v_sql      varchar2(3000);
     v_resul    integer;
     v_cursor   integer;
     v_error    varchar2(200);
     v_correl   number(12);
     v_cliente  number(8);
     v_abonado  number(8);
     v_ciclo    number(8);
     v_tipdocu  number(2);
     v_concepto number(4);
     v_minutos  number(12);
     v_monto    number(12);
     v_bandera  number(1);
     p_rut      number(10);
     v_rut      varchar2(20);
     v_tipo     varchar2(2);
   begin
     v_cursor := DBMS_SQL.OPEN_CURSOR;
     v_sql:='select ';
     v_sql:=v_sql||'a.ind_ordentotal,a.cod_cliente,b.num_abonado,';
     v_sql:=v_sql||'a.cod_ciclfact,a.cod_tipdocum,b.cod_concepto, ';
     v_sql:=v_sql||'sum(b.seg_consumido),sum(b.imp_facturable)  ';
     v_sql:=v_sql||'from fa_histdocu a,'||p_tabla||' b,fa_conceptos c  ';
     v_sql:=v_sql||'where a.ind_ordentotal>='||p_desde||' ';
     v_sql:=v_sql||'and a.ind_ordentotal<='||p_hasta||' ';
     v_sql:=v_sql||'and a.cod_tipdocum in (2,69,40,73)  ';
     v_sql:=v_sql||'and a.cod_ciclfact='||p_ciclo||' ';
     v_sql:=v_sql||'and a.ind_ordentotal=b.ind_ordentotal  ';
     v_sql:=v_sql||'and b.cod_concepto=c.cod_concepto  ';
     v_sql:=v_sql||'and b.cod_producto in (1,5)  ';
     v_sql:=v_sql||'and c.cod_tipconce!=1  ';
     v_sql:=v_sql||'group by a.ind_ordentotal,a.cod_cliente,  ';
     v_sql:=v_sql||'b.num_abonado,a.cod_ciclfact,a.cod_tipdocum,b.cod_concepto ';
     DBMS_SQL.PARSE(v_cursor,v_sql, DBMS_SQL.V7);
     DBMS_SQL.DEFINE_COLUMN(v_cursor,1,v_correl);
     DBMS_SQL.DEFINE_COLUMN(v_cursor,2,v_cliente);
     DBMS_SQL.DEFINE_COLUMN(v_cursor,3,v_abonado);
     DBMS_SQL.DEFINE_COLUMN(v_cursor,4,v_ciclo);
     DBMS_SQL.DEFINE_COLUMN(v_cursor,5,v_tipdocu);
     DBMS_SQL.DEFINE_COLUMN(v_cursor,6,v_concepto);
     DBMS_SQL.DEFINE_COLUMN(v_cursor,7,v_minutos);
     DBMS_SQL.DEFINE_COLUMN(v_cursor,8,v_monto);
     v_resul:=DBMS_SQL.EXECUTE(v_cursor);
     loop
       if DBMS_SQL.FETCH_ROWS(v_cursor)>0 THEN
         DBMS_SQL.COLUMN_VALUE(v_cursor,1,v_correl);
         DBMS_SQL.COLUMN_VALUE(v_cursor,2,v_cliente);
         DBMS_SQL.COLUMN_VALUE(v_cursor,3,v_abonado);
         DBMS_SQL.COLUMN_VALUE(v_cursor,4,v_ciclo);
         DBMS_SQL.COLUMN_VALUE(v_cursor,5,v_tipdocu);
         DBMS_SQL.COLUMN_VALUE(v_cursor,6,v_concepto);
         DBMS_SQL.COLUMN_VALUE(v_cursor,7,v_minutos);
         DBMS_SQL.COLUMN_VALUE(v_cursor,8,v_monto);
         v_bandera:=0;
         begin
           select num_ident,cod_tipident
           into v_rut,v_tipo
           from ge_clientes
           where cod_cliente=v_cliente;
           if v_tipo!='01' then
             v_bandera:=1;
           end if;
         exception
           when others then
            v_bandera:=1;
         end;
         if v_bandera=0 then
           p_rut:=to_number(substr(v_rut,1,instr(v_rut,'-',1,1)-1));
           if p_rut<50000000 then
             v_bandera:=1;
           end if;
         end if;
         if v_bandera=0 then
           begin
           insert into gr_exp_detalle_temp
           (correl,cliente,abonado,ciclo,tipdocu,concepto,minutos,
           cargo) values (v_correl,v_cliente,v_abonado,v_ciclo,
           v_tipdocu,v_concepto,v_minutos,v_monto);
           commit;
           exception
             when others then
               v_error:='Error en insercion registro:'||v_correl;
               utl_file.put_line(arch_err,v_error||' '||sqlerrm);
           end;
         end if;
       end if;
     end loop;
     DBMS_SQL.CLOSE_CURSOR(v_cursor);
     v_error:='Finaliza ejecucion de extrae ciclo:'||p_ciclo;
     utl_file.put_line(arch_err,v_error);
   exception
    when others then
      v_error:='Termino el extrae ciclo:'||p_ciclo;
      utl_file.put_line(arch_err,v_error);
   end extrae;
/* --------------------------------------------------------------- */
   PROCEDURE proc_individual(v_parametro in     varchar2,
                             arch_err    in out utl_file.file_type,
                             arch_in     in out utl_file.file_type) AS
     cursor cliente_ind(p_cliente number,p_abonado number) is select
       ciclo              ciclo,
       concepto           concepto,
       sum(minutos)       minutos,
       sum(cargo)         cargo
       from gr_exp_detalle_temp
       where cliente=p_cliente
       and abonado=p_abonado
       group by ciclo,concepto;
     arch_ind             utl_file.file_type;
     v_bandera            number(1);
     v_error              varchar2(100);
     v_linea              varchar2(600);
     donde                varchar2(30);
     v_contador           number(8):=0;
     v_estado             number(1):=0;
     v_reg_individual     registro;
     v_cliente            number(8);
     v_abonado            number(8);
     v_nombre             varchar2(100);
     v_rut                varchar2(20);
     v_mto_cf             number(14,4);
     v_min_cf             number(14,4);
     v_mto_ad             number(14,4);
     v_min_ad             number(14,4);
     v_mto_ot             number(14,4);
     v_mto_cpp            number(14,4);
     v_min_cpp            number(14,4);
     v_cuenta             number(4);
     v_plan               varchar2(3);
     v_fini               date;
     v_ffin               date;
   begin
     v_fini:=to_date(v_parametro,'mmyyyy');
     v_ffin:=add_months(v_fini,1);
     v_reg_individual.titulo:='Abonados Individual';
     v_reg_individual.abonados :=0;
     v_reg_individual.mto_cf   :=0;
     v_reg_individual.segs_cf  :=0;
     v_reg_individual.mto_ad   :=0;
     v_reg_individual.segs_ad  :=0;
     v_reg_individual.mto_cpp  :=0;
     v_reg_individual.segs_cpp :=0;
     v_reg_individual.mto_ot   :=0;
     donde:='/samba/ready';
     arch_ind:=utl_file.fopen(donde,'rpimentel_individual.txt','w');
     select to_char(sysdate,'dd-mon-yyyy hh24:mi:ss') into v_error from dual;
     v_error:='Inicio a las '||v_error;
     utl_file.put_line(arch_err,v_error);
     v_linea:='Rut|Nombre/Razon Social|Cliente|Abonado|Plan|$ CF| Segs. CF|';
     v_linea:=v_linea||'$ Adic.|Segs. Adic.|$ Otros|$ CPP|Segs. CPP';
     utl_file.put_line(arch_ind,v_linea);
     v_error:='fecha_ini:='||to_char(v_fini,'dd-mon-yy');
     utl_file.put_line(arch_err,v_error);
     v_error:='fecha_fin:='||to_char(v_ffin,'dd-mon-yy');
     utl_file.put_line(arch_err,v_error);
     while v_estado=0 loop
       v_bandera:=0;
       declare
          v_pipe1    number(4);
          v_pipe2    number(4);
       begin
         utl_file.get_line(arch_in,v_linea);
         v_pipe1:=instr(v_linea,'|',1,1);
         v_pipe2:=instr(v_linea,'|',1,2);
         v_cliente:=to_number(substr(v_linea,1,v_pipe1-1));
         v_abonado:=to_number(substr(v_linea,v_pipe1+1,v_pipe2-1-v_pipe1));
         v_contador:=v_contador + 1;
         if mod(v_contador,500)=0 then
           v_error:='Van :'||v_contador||' Clientes....';
           utl_file.put_line(arch_err,v_error);
         end if;
       exception
         when others then
           v_estado:=1;
           v_bandera:=1;
       end;
       -- comienza la extraccion de datos
       if v_bandera=0 then
         begin
           select nom_cliente||' '||nom_apeclien1||' '||nom_apeclien2,num_ident
           into v_nombre,v_rut
           from ge_clientes
           where cod_cliente=v_cliente;
         exception
           when others then
             v_error:='Error en nombre de cliente:'||v_cliente;
             utl_file.put_line(arch_err,v_error);
             utl_file.put_line(arch_err,sqlerrm);
             v_bandera:=1;
         end;
       end if;
       v_mto_cf:=0;
       v_min_cf:=0;
       v_mto_ad:=0;
       v_min_ad:=0;
       v_mto_ot:=0;
       v_mto_cpp:=0;
       v_min_cpp:=0;
       if v_bandera=0 then
            begin
              select cod_plantarif
              into v_plan
              from ga_abocel
              where num_abonado=v_abonado;
            exception
              when no_data_found then
                begin
                  select cod_plantarif
                  into v_plan
                  from ga_habocel
                  where num_abonado=v_abonado;
                exception
                  when others then
                    v_bandera:=1;
                    v_error:='Error en plan habocel abonado:'||v_abonado;
                    utl_file.put_line(arch_err,v_error);
                    utl_file.put_line(arch_err,sqlerrm);
                end;
              when others then
                v_bandera:=1;
                v_error:='Error en plan abocel abonado:'||v_abonado;
                utl_file.put_line(arch_err,v_error);
                utl_file.put_line(arch_err,sqlerrm);
            end;
       end if;
       if v_bandera=0 then
              for cc in cliente_ind(v_cliente,v_abonado) loop
                if cc.concepto=25 then
                  v_mto_cf:=v_mto_cf + cc.cargo;
                  begin
                    select sum(seg_gratuitos)
                    into v_min_cf
                    from ta_acumaire
                    where num_abonado=v_abonado
                    and cod_ciclfact=cc.ciclo
                    and cod_plantarif=v_plan;
                  exception
                    when no_data_found then
                      begin
                        select sum(seg_gratuitos)
                        into v_min_cf
                        from ta_acumaire
                        where num_abonado=v_abonado
                        and cod_ciclfact=cc.ciclo;
                      exception
                        when others then
                          v_min_cf:=0;
                      end;
                    when others then
                      v_min_cf:=0;
                  end;
                elsif cc.concepto in (1,2,3,4) then
                  v_min_ad:=v_min_ad + cc.minutos;
                  v_mto_ad:=v_mto_ad + cc.cargo;
                else
                  v_mto_ot:=v_mto_ot + cc.cargo;
                end if;
              end loop;
       end if;
       if v_bandera=0 then
              begin
                select sum(segs_traf),sum(monto_intercon)
                into v_min_cpp,v_mto_cpp
                from ga_abocel a,ta_trafico_celular_mes b
                where a.num_abonado=v_abonado
                and a.num_celular=b.num_celular
                and b.fecha_traf >=v_fini
                and b.fecha_traf < v_ffin
                and b.ind_entsal =1;
              exception
                when others then
                  v_min_cpp:=0;
                  v_mto_cpp:=0;
              end;
       end if;
       v_min_cpp:=nvl(v_min_cpp,0);
       v_min_cf:=nvl(v_min_cf,0);
       v_min_ad:=nvl(v_min_ad,0);
       v_mto_ad:=nvl(v_mto_ad,0);
       v_mto_cf:=nvl(v_mto_cf,0);
       v_mto_ot:=nvl(v_mto_ot,0);
       v_mto_cpp:=nvl(v_mto_cpp,0);
       if v_bandera=0 then
              v_reg_individual.abonados:=v_reg_individual.abonados + 1;
              v_reg_individual.mto_cf   :=v_reg_individual.mto_cf + v_mto_cf;
              v_reg_individual.segs_cf  :=v_reg_individual.segs_cf + v_min_cf;
              v_reg_individual.mto_ad   :=v_reg_individual.mto_ad + v_mto_ad;
              v_reg_individual.segs_ad  :=v_reg_individual.segs_ad + v_min_ad;
              v_reg_individual.mto_cpp  :=v_reg_individual.mto_cpp + v_mto_cpp;
              v_reg_individual.segs_cpp :=v_reg_individual.segs_cpp + v_min_cpp;
       end if;
       if v_bandera=0 then
             v_linea:=v_rut||'|'||
                      v_nombre||'|'||
                      v_cliente||'|'||
                      v_abonado||'|'||
                      v_plan||'|'||
                      v_mto_cf||'|'||
                      v_min_cf||'|'||
                      v_mto_ad||'|'||
                      v_min_ad||'|'||
                      v_mto_ot||'|'||
                      trunc(v_mto_cpp+0.5)||'|'||
                      v_min_cpp||'|';
              utl_file.put_line(arch_ind,v_linea);
       end if;
     end loop;
     v_linea:=v_reg_individual.titulo||'|'||
              v_reg_individual.abonados||'|'||
              v_reg_individual.mto_cf  ||'|'||
              v_reg_individual.segs_cf ||'|'||
              v_reg_individual.mto_ad  ||'|'||
              v_reg_individual.segs_ad ||'|'||
              v_reg_individual.mto_cpp ||'|'||
              v_reg_individual.segs_cpp||'|';
     utl_file.put_line(arch_err,v_linea);
     v_error:='Proceso termino OK...';
     utl_file.put_line(arch_err,v_error);
     select to_char(sysdate,'dd-mon-yyyy hh24:mi:ss') into v_error from dual;
     v_error:='Termino  a las '||v_error;
     utl_file.put_line(arch_err,v_error);
     utl_file.fclose(arch_ind);
   exception
     when others then
        v_error:='El proceso se cancelo ....';
        utl_file.put_line(arch_err,v_error);
        utl_file.put_line(arch_err,sqlerrm);
        utl_file.fclose(arch_ind);
   end proc_individual;
/* --------------------------------------------------------------- */
   PROCEDURE proc_empresa(v_parametro in     varchar2,
                          arch_err    in out utl_file.file_type,
                          arch_in     in out utl_file.file_type) AS
     cursor cliente_emp(p_cliente number) is select
        ciclo           ciclo,
        concepto        concepto,
        sum(cargo)      cargo,
        sum(minutos)    minutos
        from gr_exp_detalle_temp
        where cliente=p_cliente
        group by ciclo,concepto;
     arch_emp             utl_file.file_type;
     v_bandera            number(1);
     v_error              varchar2(100);
     v_linea              varchar2(600);
     donde                varchar2(30);
     v_contador           number(8):=0;
     v_estado             number(1):=0;
     v_reg_empresa        registro;
     v_cliente            number(8);
     v_empresa            number(8);
     v_nombre             varchar2(100);
     v_rut                varchar2(20);
     v_mto_cf             number(14,4);
     v_min_cf             number(14,4);
     v_mto_ad             number(14,4);
     v_min_ad             number(14,4);
     v_mto_ot             number(14,4);
     v_mto_cpp            number(14,4);
     v_min_cpp            number(14,4);
     v_cuenta             number(4);
     v_plan               varchar2(3);
     v_fini               date;
     v_ffin               date;
   begin
     v_fini:=to_date(v_parametro,'mmyyyy');
     v_ffin:=add_months(v_fini,1);
     v_reg_empresa.titulo:='Abonados Empresa';
     v_reg_empresa.abonados :=0;
     v_reg_empresa.mto_cf   :=0;
     v_reg_empresa.segs_cf  :=0;
     v_reg_empresa.mto_ad   :=0;
     v_reg_empresa.segs_ad  :=0;
     v_reg_empresa.mto_cpp  :=0;
     v_reg_empresa.segs_cpp :=0;
     v_reg_empresa.mto_ot   :=0;
     donde:='/samba/ready';
     arch_emp:=utl_file.fopen(donde,'rpimentel_empresa.txt','w');
     select to_char(sysdate,'dd-mon-yyyy hh24:mi:ss') into v_error from dual;
     v_error:='Inicio a las '||v_error;
     utl_file.put_line(arch_err,v_error);
     v_linea:='Rut|Nombre/Razon Social|Cliente|# Abonados|Plan|$ CF| Segs. CF|';
     v_linea:=v_linea||'$ Adic.|Segs. Adic.|$ Otros|$ CPP|Segs. CPP';
     utl_file.put_line(arch_emp,v_linea);
     v_error:='fecha_ini:='||to_char(v_fini,'dd-mon-yy');
     utl_file.put_line(arch_err,v_error);
     v_error:='fecha_fin:='||to_char(v_ffin,'dd-mon-yy');
     utl_file.put_line(arch_err,v_error);
     while v_estado=0 loop
       v_bandera:=0;
       declare
          v_pipe1    number(4);
          v_pipe2    number(4);
       begin
         utl_file.get_line(arch_in,v_linea);
         v_pipe1:=instr(v_linea,'|',1,1);
         v_pipe2:=instr(v_linea,'|',1,2);
         v_cliente:=to_number(substr(v_linea,1,v_pipe1-1));
         v_empresa:=to_number(substr(v_linea,v_pipe1+1,v_pipe2-1-v_pipe1));
         v_contador:=v_contador + 1;
         if mod(v_contador,500)=0 then
           v_error:='Van :'||v_contador||' Clientes....';
           utl_file.put_line(arch_err,v_error);
         end if;
       exception
         when others then
           v_estado:=1;
           v_bandera:=1;
       end;
       -- comienza la extraccion de datos generales....
       if v_bandera=0 then
         begin
           select nom_cliente||' '||nom_apeclien1||' '||nom_apeclien2,num_ident
           into v_nombre,v_rut
           from ge_clientes
           where cod_cliente=v_cliente;
         exception
           when others then
             v_error:='Error en nombre de cliente:'||v_cliente;
             utl_file.put_line(arch_err,v_error);
             utl_file.put_line(arch_err,sqlerrm);
             v_bandera:=1;
         end;
       end if;
       v_mto_cf:=0;
       v_min_cf:=0;
       v_mto_ad:=0;
       v_min_ad:=0;
       v_mto_ot:=0;
       v_mto_cpp:=0;
       v_min_cpp:=0;
       if v_bandera=0 then
          begin
            select cod_plantarif into v_plan
            from ga_empresa
            where cod_empresa=v_empresa;
          exception
            when others then
              v_bandera:=1;
              v_error:='Error en plan empresa cliente:'||v_cliente;
              utl_file.put_line(arch_err,v_error);
              utl_file.put_line(arch_err,sqlerrm);
          end;
          if v_bandera=0 then
            begin
              select sum(segs_traf),sum(monto_intercon)
              into v_min_cpp,v_mto_cpp
              from ta_trafico_celular_mes b,ga_abocel a
              where a.cod_cliente=v_cliente
              and a.num_celular=b.num_celular
              and b.fecha_traf >=v_fini
              and b.fecha_traf < v_ffin
              and b.ind_entsal =1;
            exception
              when others then
                 v_min_cpp:=0;
                 v_mto_cpp:=0;
            end;
          end if;
          if v_bandera=0 then
            for cc in cliente_emp(v_cliente) loop
              if cc.concepto = 25 then
                v_mto_cf:=v_mto_cf + cc.cargo;
                begin
                  select sum(seg_consumido) into v_min_cf
                  from ta_acumaireemp
                  where cod_empresa=v_empresa
                  and cod_ciclfact=cc.ciclo
                  and cod_plantarif=v_plan;
                exception
                  when no_data_found then
                    begin
                      select sum(seg_consumido) into v_min_cf
                      from ta_acumaireemp
                      where cod_empresa=v_empresa
                      and cod_ciclfact=cc.ciclo;
                    exception
                      when others then
                        v_min_cf:=0;
                    end;
                  when others then
                    v_min_cf:=0;
                end;
              elsif cc.concepto in (1,2,3,4) then
                v_mto_ad:=v_mto_ad + cc.cargo;
                v_min_ad:=v_min_ad + cc.minutos;
              else
                v_mto_ot:=v_mto_ot + cc.cargo;
              end if;
            end loop;
          end if;
          begin
            select count(distinct abonado)
            into v_cuenta
            from gr_exp_detalle_temp
            where cliente=v_cliente
            and abonado!=0;
          exception
           when others then
             v_cuenta:=0;
          end;
          if v_bandera=0 then
            v_min_cpp:=nvl(v_min_cpp,0);
            v_min_cf:=nvl(v_min_cf,0);
            v_min_ad:=nvl(v_min_ad,0);
            v_mto_ad:=nvl(v_mto_ad,0);
            v_mto_cf:=nvl(v_mto_cf,0);
            v_mto_ot:=nvl(v_mto_ot,0);
            v_mto_cpp:=nvl(v_mto_cpp,0);
            v_cuenta:=nvl(v_cuenta,0);
            v_reg_empresa.abonados:=v_reg_empresa.abonados + v_cuenta;
            v_reg_empresa.mto_cf   :=v_reg_empresa.mto_cf + v_mto_cf;
            v_reg_empresa.segs_cf  :=v_reg_empresa.segs_cf + v_min_cf;
            v_reg_empresa.mto_ad   :=v_reg_empresa.mto_ad + v_mto_ad;
            v_reg_empresa.segs_ad  :=v_reg_empresa.segs_ad + v_min_ad;
            v_reg_empresa.mto_cpp  :=v_reg_empresa.mto_cpp + v_mto_cpp;
            v_reg_empresa.segs_cpp :=v_reg_empresa.segs_cpp + v_min_cpp;
          end if;
          if v_bandera=0 then
            v_linea:=v_rut||'|'||
                     v_nombre||'|'||
                     v_cliente||'|'||
                     v_cuenta||'|'||
                     v_plan||'|'||
                     v_mto_cf||'|'||
                     v_min_cf||'|'||
                     v_mto_ad||'|'||
                     v_min_ad||'|'||
                     v_mto_ot||'|'||
                     trunc(v_mto_cpp+0.5)||'|'||
                     v_min_cpp||'|';
            utl_file.put_line(arch_emp,v_linea);
          end if;
       end if;
     end loop;
     v_linea:=v_reg_empresa.titulo||'|'||
              v_reg_empresa.abonados||'|'||
              v_reg_empresa.mto_cf  ||'|'||
              v_reg_empresa.segs_cf ||'|'||
              v_reg_empresa.mto_ad  ||'|'||
              v_reg_empresa.segs_ad ||'|'||
              v_reg_empresa.mto_cpp ||'|'||
              v_reg_empresa.segs_cpp||'|';
     utl_file.put_line(arch_err,v_linea);
     v_error:='El proceso termino OK ...';
     utl_file.put_line(arch_err,v_error);
     select to_char(sysdate,'dd-mon-yyyy hh24:mi:ss') into v_error from dual;
     v_error:='Termino a las '||v_error;
     utl_file.put_line(arch_err,v_error);
     utl_file.fclose(arch_emp);
   exception
     when others then
        v_error:='El proceso se cancelo ....';
        utl_file.put_line(arch_err,v_error);
        utl_file.put_line(arch_err,sqlerrm);
        utl_file.fclose(arch_emp);
   end proc_empresa;
end gr_facturas;
/
SHOW ERRORS
