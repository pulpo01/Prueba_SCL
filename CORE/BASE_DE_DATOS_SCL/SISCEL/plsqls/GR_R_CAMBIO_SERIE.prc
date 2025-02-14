CREATE OR REPLACE PROCEDURE        GR_R_CAMBIO_SERIE(p_FECHA_DESDE in varchar2, p_FECHA_HASTA in VARCHAR2, SALIDA in varchar2 , ARCHIVO in varchar2) IS
        v_fec_fincontra         ga_abocel.fec_fincontra%type;
        v_num_celular           ga_abocel.num_celular%type;
        v_fec_alta                  ga_abocel.fec_alta%type;
        v_des_oficina           ge_oficinas.des_oficina%type;
        v_des_equipo            ga_equipaboser.des_equipo%type;
        v_des_procequi          varchar2(20);
        v_imp_cargo             ge_cargos.imp_cargo%type;
        v_des_uso               al_usos.des_uso%type;
        v_val_dto               ge_cargos.val_dto%type;
        v_des_dto               varchar2(20);
        desde                   date;
        hasta                   date;
        pp                      varchar2(250);
        arv                     varchar2(250);
        puntero                 utl_file.file_type;
        v_bandera               number(1);
        v_num_venta             ge_cargos.num_venta%type;
        v_des_modventa          ge_modventa.des_modventa%TYPE;
        v_fila                  varchar2(500);
        v_abonado               number(8);
        v_trasa                 varchar2(500);
                v_cod_cliente           ga_abocel.cod_cliente%type;
                v_imp_cargo1            fa_histcargos.imp_cargo%type;
                v_des_concepto              fa_conceptos.des_concepto%type;
                v_val_dto1                          fa_histcargos.val_dto%type;
                v_tip_dto1                          varchar2(16);
                v_num_serie             varchar2(14);
                num_reg                 number(5);
                rec_cur                 number(5);
        no_datos                        number(1);
                sFormatoFecha           varchar2(12);

    CURSOR ccp(v_desde date, v_hasta date) IS select
        num_os             numos,
        tip_inter            tinter,
        cod_os             codos,
        usuario           usuario,
        fecha             fecha,
        cod_inter            cinter,
        num_cargo          numcargo,
                replace(serie_nue,' ','')  v_num_serie,
                serie_ant                 v_serie_antigua
        from grt_ordserv
        where cod_os in ('10270','10450','10070')
        and fecha between v_desde and (v_hasta + 1);
    CURSOR cc_cargos(v_fecha date,v_inter number,v_cliente number) IS    select
      e.imp_cargo          imp_cargo,
      f.des_concepto       des_concep,
      val_dto              val_dto,
      decode(tip_dto,'0','PESOS','PORCENTAJE')    tip_dto
      from      fa_conceptos f, fa_histcargos e, ga_ventas b, fa_histdocu a
      where  trunc(a.fec_emision) = trunc(v_fecha)
      and    a.num_venta = b.num_venta
      and    b.num_venta = e.num_venta
      and    e.cod_concepto_dto = f.cod_concepto
      and    b.cod_cliente = v_cliente
      and    e.num_abonado =v_inter;
BEGIN
    pp:=SALIDA;
    arv:=ARCHIVO;
        num_reg:=0;
        rec_cur:=0;

        SELECT SP_FN_FORMATOFECHA('FORMATO_SEL2') into sFormatoFecha FROM DUAL;

    --desde:=to_date(p_FECHA_DESDE, 'dd-mm-yyyy');
        desde:=to_date(p_FECHA_DESDE, sFormatoFecha);
    --hasta:=to_date(p_FECHA_HASTA, 'dd-mm-yyyy');
    hasta:=to_date(p_FECHA_HASTA, sFormatoFecha);

    no_datos:=0;
        /******************************************************************************************************/
        Delete grt_ordserv;
        Insert into grt_ordserv
        (num_os,cod_os,tip_inter,cod_inter,usuario,fecha,num_cargo,serie_ant,serie_nue)
        select
        num_os             numos,
        cod_os             codos,
        tip_inter          tinter,
        cod_inter          cinter,
        usuario            usuario,
        fecha              fecha,
        num_cargo          numcargo,'',''
        from ci_orserv
        where cod_os in ('10270','10450','10070')
        and fecha between desde and hasta;
        update grt_ordserv a
        set serie_nue = (select num_serie from ga_abocel b
                                         where a.cod_inter = b.num_abonado)
        where cod_inter in (select num_abonado from ga_abocel b
                                     where a.cod_inter = b.num_abonado)
        and    a.fecha in (select max(fecha) from grt_ordserv c
                                           where a.cod_inter = c.cod_inter);
        update grt_ordserv  a
        set serie_nue = (select num_serie from ga_aboamist b
                                         where a.cod_inter = b.num_abonado)
        where cod_inter in (select num_abonado from ga_aboamist b
                                         where a.cod_inter = b.num_abonado)
        and a.fecha in (select max(fecha) from grt_ordserv c
                                        where a.cod_inter = c.cod_inter);
        update grt_ordserv  a
        set serie_ant = (select b.num_serie from ga_modabocel b
                         where  a.cod_inter = b.num_abonado
                         and    a.fecha between (b.fec_modifica) and (b.fec_modifica + 0.5)
                                        and    a.fecha in (select min(fecha) from grt_ordserv c
                                                           where a.cod_inter = c.cod_inter
                                                           and   c.fecha > b.fec_modifica)
                                        and    b.fec_modifica in (select max(fec_modifica) from ga_modabocel c
                                                              where b.num_abonado = c.num_abonado
                                                              and   a.fecha > c.fec_modifica));
        update grt_ordserv  a
        set serie_nue = (select b.serie_ant
              from grt_ordserv b
              where  a.cod_inter = b.cod_inter
              and    a.fecha < b.fecha
              and    b.fecha in (select min(fecha)
                                 from grt_ordserv c
                                 where a.cod_inter = c.cod_inter
                                 and c.fecha > a.fecha))
                  where a.fecha not in (select max(fecha)
                                 from grt_ordserv c
                                 where a.cod_inter = c.cod_inter);
        commit;
        /******************************************************************************************************/
    puntero:=utl_file.fopen(pp,arv,'w');
    Utl_file.put_line(puntero,'OOSS'||','||'Num. Os'||','||'Tipo Inter'||','||'Abonado'||','||'Usuario'||','||'Oficina'||','||'Celular'||','||'Uso'||','||'Modelo'||','||'Serie Nueva'||','||'Serie Antigua'||','||'Fecha'||','||'Valor'||','||'Descuento'||','||'Tipo Descuento'||','||'Procedencia Equipo'||','||'Fecha Alta'||','||'Fecha Fin Contrato'||','||'Modalidad Venta'||','||'Valor Equipo'||','||'Descuento Equipo'||','||'Tipo Descuento'||','||'Concepto');
    for cc in ccp(desde,hasta) loop
        v_abonado:=cc.cinter;
        v_bandera:=0;
                rec_cur:=rec_cur + 1 ;
        begin
                 v_trasa:='En Ga_abocel...';
                 select a.num_celular,decode(a.ind_procequi,'I','INTERNO','E','EXTERNO','S','SUBSIDIADO','DESCONOCIDO'),
                 a.fec_alta,a.fec_fincontra,b.des_uso,cod_cliente
                 into v_num_celular,v_des_procequi,v_fec_alta,v_fec_fincontra,v_des_uso,v_cod_cliente
                 from ga_abocel a,al_usos b
                 where num_abonado=cc.cinter
                 and a.cod_uso=b.cod_uso(+);
            exception
          when no_data_found then
            begin
              v_trasa:='En Ga_aboamist...';
              select a.num_celular,a.ind_procequi,a.fec_alta,a.fec_fincontra,b.des_uso
              into v_num_celular,v_des_procequi,v_fec_alta,v_fec_fincontra,v_des_uso
              from ga_aboamist a,al_usos b
              where num_abonado=cc.cinter
              and a.cod_uso=b.cod_uso(+);
            end;
       end;
          begin
            v_trasa:='En Des_equipo...';
            Select b.des_articulo into v_des_equipo
            from ga_equipaboser a, al_articulos b
            where a.num_abonado=cc.cinter
            and a.num_serie = cc.v_num_serie
            and fec_alta=(select max(x.fec_alta) from ga_equipaboser x
                          where x.num_abonado=cc.cinter
                          and   x.num_serie=cc.v_num_serie)
                        and a.cod_articulo=b.cod_articulo;
              exception
            when no_data_found then
               v_des_equipo:='';
          end;
          begin
            v_trasa:='En Ga_oficina...';
            select b.des_oficina into v_des_oficina
                from ge_seg_usuario a,ge_oficinas b
                where a.nom_usuario=cc.usuario
                and a.cod_oficina=b.cod_oficina;
          exception
            when no_data_found then
              v_des_oficina:='';
          end;
          begin
            v_trasa:='En imp_cargo:ge_cargos...';
            select imp_cargo, num_venta, val_dto,
            decode(tip_dto,'0','PESOS','PROCENTAJE')
            into v_imp_cargo, v_num_venta, v_val_dto, v_des_dto
            from ge_cargos
            where num_cargo=cc.numcargo;
          exception
            when no_data_found then
                begin
                  v_trasa:='En imp_cargo:fa_histcargos...';
                  select imp_cargo, num_venta, val_dto,
                  decode(tip_dto,'0','PESOS','PROCENTAJE')
                  into v_imp_cargo, v_num_venta, v_val_dto, v_des_dto
                  from fa_histcargos
                  where num_cargo=cc.numcargo;
                exception
                  when no_data_found then
                    v_imp_cargo:=0;
                    v_val_dto:=0;
                    v_des_dto:='';
                    v_num_venta:=-1;
                end;
          end;
          begin
          v_trasa:='En Tipo_contrato...';
                  select des_tipcontrato into v_des_modventa
          from ga_abocel a,ga_tipcontrato c
          where a.num_abonado = cc.cinter
          and a.cod_tipcontrato = c.cod_tipcontrato
          and c.cod_producto=1;
          exception
            when others then
              v_des_modventa:='';
          end;
                   v_trasa:='En Nuevo...';
             no_datos:=0;
                 for v_cargos in cc_cargos(cc.fecha,cc.cinter,v_cod_cliente) loop
                no_datos:=1;
                                v_imp_cargo1:=v_cargos.imp_cargo;
                                v_des_concepto:=v_cargos.des_concep;
                                v_val_dto1:=v_cargos.val_dto;
                                v_tip_dto1:=v_cargos.tip_dto;
                                num_reg:=num_reg + 1 ;
                v_trasa:='En imprime archivo...';
                v_fila:=cc.codos||','||
                    cc.numos||','||
                    cc.tinter||','||
                    cc.cinter||','||
                    cc.usuario||','||
                    v_des_oficina||','||
                    v_num_celular||','||
                    v_des_uso||','||
                    v_des_equipo||','||
                    cc.v_num_serie||','||
                    cc.v_serie_antigua||','||
                    --to_char(cc.fecha, 'dd-mm-yyyy')||','||
                                        to_char(cc.fecha, sFormatoFecha)||','||
                    round(v_imp_cargo*1.18)||','||
                    v_val_dto||','||
                    v_des_dto||','||
                    v_des_procequi||','||
                    --to_char(v_fec_alta, 'dd-mm-yyyy')||','||
                                        to_char(v_fec_alta, sFormatoFecha)||','||
                    --to_char(v_fec_fincontra, 'dd-mm-yyyy')||','||
                                        to_char(v_fec_fincontra, sFormatoFecha)||','||
                    v_des_modventa||','||
                            v_imp_cargo1||','||
                            v_val_dto1||','||
                            v_tip_dto1||','||
                            v_des_concepto;
                    Utl_file.put_line(puntero,v_fila);
                end loop;
        if no_datos=0 then
                      no_datos:=0;
                                v_imp_cargo1:=0;
                                v_des_concepto:= '';
                                v_val_dto1:=0;
                                v_tip_dto1:='';
                                num_reg:=num_reg + 1 ;
                v_trasa:='En imprime archivo...';
                v_fila:=cc.codos||','||
                    cc.numos||','||
                    cc.tinter||','||
                    cc.cinter||','||
                    cc.usuario||','||
                    v_des_oficina||','||
                    v_num_celular||','||
                    v_des_uso||','||
                    v_des_equipo||','||
                    cc.v_num_serie||','||
                    cc.v_serie_antigua||','||
                    --to_char(cc.fecha, 'dd-mm-yyyy')||','||
                                        to_char(cc.fecha, sFormatoFecha)||','||
                    round(v_imp_cargo*1.18)||','||
                    v_val_dto||','||
                    v_des_dto||','||
                    v_des_procequi||','||
                    --to_char(v_fec_alta, 'dd-mm-yyyy')||','||
                                        to_char(v_fec_alta, sFormatoFecha)||','||
                    --to_char(v_fec_fincontra, 'dd-mm-yyyy')||','||
                                        to_char(v_fec_fincontra, sFormatoFecha)||','||
                    v_des_modventa||','||
                            v_imp_cargo1||','||
                            v_val_dto1||','||
                            v_tip_dto1||','||
                            v_des_concepto;
                    Utl_file.put_line(puntero,v_fila);
         end if;
  END LOOP;
  Utl_file.fclose(puntero);
  dbms_output.put_line('Series Termino Ok'||' - '||to_char(num_reg)||' Registros (Recorre Cursor '||to_char(rec_cur)||' veces)  ');
exception
  when others then
     rollback;
     dbms_output.put_line('Error general abonado:'||to_char(v_abonado)||' Trasa:='||v_trasa);
     dbms_output.put_line(sqlerrm);
END GR_R_CAMBIO_SERIE;
/
SHOW ERRORS
