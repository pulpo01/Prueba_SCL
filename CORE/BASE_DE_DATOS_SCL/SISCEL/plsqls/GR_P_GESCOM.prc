CREATE OR REPLACE PROCEDURE        GR_P_GESCOM
(numdesde in varchar2, numhasta in varchar2,nomarch in varchar2,
donde in varchar2) as
  cursor ventas is select
    a.ind_estventa              indestventa,
    a.cod_cliente               codcliente,
    a.imp_venta                 impventa,
        a.fec_venta                 fecventa,
    a.cod_vendedor              codvendedor,
    b.nom_vendedor              nomvendedor,
    c.des_oficina               desoficina,
    c.cod_region                codregion,
    d.num_celular               numcelular,
    d.num_abonado               numabonado,
    d.num_serie                 numserie,
    d.cod_plantarif             codplantarif,
    k.des_plantarif             desplantarif,
    a.nom_usuar_vta             nomusuarvta,
    a.nom_usuar_recdoc          nomusuarrecdoc,
    d.fec_recdocum              fecrecdocum,
    a.nom_usuar_acerec          nomusuaracerec,
    a.fec_aceprec               fecaceprec,
    a.nom_usuar_cumpl           nomusuarcumpl,
    d.fec_cumplimen             feccumplimen,
    a.num_venta                 numventa,
    d.cod_situacion             codsituacion,
    d.fec_alta                  fecalta,
    d.fec_fincontra             fecfincontra,
    a.obs_recprov               obsrecprov,
    a.num_dias                  numdias,
    o.des_tipcomis              destipcomis
    from ve_tipcomis o,ta_plantarif k,ge_oficinas c,    ve_vendedores b,
    ga_abocel d,    ga_ventas a
    where a.num_venta between to_number(numdesde) and to_number(numhasta) and
    a.ind_venta in ('V','v','C') and
    a.num_venta=d.num_venta and
    a.cod_tipcomis=o.cod_tipcomis and
    d.cod_situacion not like 'B%' and
    d.cod_producto=k.cod_producto and
    d.cod_plantarif=k.cod_plantarif and
    a.cod_vendedor=b.cod_vendedor and
    a.cod_oficina=c.cod_oficina
    union all
    select
    a.ind_estventa              estventa,
    a.cod_cliente               codcliente,
    a.imp_venta                 impventa,
    a.fec_venta                 fecventa,
    a.cod_vendedor              codvendedor,
    b.nom_vendedor              nomvendedor,
    c.des_oficina               desoficina,
    c.cod_region                codregion,
    d.num_celular               numcelular,
    d.num_abonado               numabonado,
    d.num_serie                 numserie,
    d.cod_plantarif             codplantarif,
    'PLAN AMISTAR'              desplantarif,
    a.nom_usuar_vta             usuarvta,
    a.nom_usuar_recdoc          usuarrecdoc,
    d.fec_recdocum              fecrecdocum,
    a.nom_usuar_acerec          usuaraceprec,
    a.fec_aceprec               fecaceprec,
    a.nom_usuar_cumpl           usuarcumpl,
    d.fec_cumplimen             feccumplimen,
    a.num_venta                 numventa,
    d.cod_situacion             codsituacion,
    d.fec_alta                  fecalta,
    d.fec_fincontra             fecfincotra,
    a.obs_recprov               obsrecprov,
    a.num_dias                  numdias,
    o.des_tipcomis              destipcomis
    from ve_tipcomis o,ta_plantarif k,ge_oficinas c,ve_vendedores b,
    ga_aboamist d,ga_ventas a
    where a.num_venta between numdesde and numhasta and
    a.ind_venta in ('V','v','C') and
    a.num_venta=d.num_venta and
    a.cod_tipcomis=o.cod_tipcomis and
    d.cod_situacion not like 'B%' and
    d.cod_producto=k.cod_producto and
    d.cod_plantarif=k.cod_plantarif and
    a.cod_vendedor=b.cod_vendedor and
    a.cod_oficina=c.cod_oficina;
    arch                        utl_file.file_type;
    arch_err                    utl_file.file_type;
    v_error                     varchar2(500);
    nom_err                     varchar2(100);
    nom_ok                      varchar2(100);
    v_linea                     varchar2(2000);
    v_bandera                   number(1);
    v_nomcalle                  ge_direcciones.nom_calle%type;
    v_numcalle                  ge_direcciones.num_calle%type;
    v_numpiso                   ge_direcciones.num_piso%type;
    v_obsdireccion              ge_direcciones.obs_direccion%type;
    v_descomuna                 ge_comunas.des_comuna%type;
    v_desciudad                 ge_ciudades.des_ciudad%type;
    v_nomcliente                ge_clientes.nom_cliente%type;
    v_nomapeclien1              ge_clientes.nom_apeclien1%type;
    v_nomapeclien2              ge_clientes.nom_apeclien2%type;
    v_numident                  ge_clientes.num_ident%type;
    v_tefcliente1               ge_clientes.tef_cliente1%type;
    v_descategoria              ge_categorias.des_categoria%type;
    v_supervisor                ve_vendedores.nom_vendedor%type;
    v_asesor                    ve_vendedores.nom_vendedor%type;
    v_numcontrato               ga_contcta.num_contrato%type;
    v_feccontrato               ga_contcta.fec_contrato%type;
    v_nummeses                  ga_contcta.num_meses%type;
    v_desplanserv               ga_planserv.des_planserv%type;
    v_desciclo                  fa_ciclos.des_ciclo%type;
    v_nomvendealer              ve_vendealer.nom_vendealer%type;
    v_indprocequi               ga_equipaboser.ind_procequi%type;
    v_desarticulo               al_articulos.des_articulo%type;
    v_desfabricante             al_fabricantes.des_fabricante%type;
    v_desstock                  al_tipos_stock.des_stock%type;
    v_desmodventa               ge_modventa.des_modventa%type;
    v_numcuotas                 ge_tipcuotas.num_cuotas%type;
    v_descausarec               ga_causarec.cod_causarec%type;
    v_nomoperador               ge_seg_usuario.nom_usuario%type;
    v_descausarep               ga_causarep.cod_causarep%type;
    v_desplancom                ve_cabplancom.des_plancom%type;
        v_catribut                  ga_catributclie.cod_catribut%type;
        sFormatoFecha            varchar2(12);
        sFormatoHora             varchar2(12);
begin
    nom_ok:=nomarch||'.txt';
    nom_err:=nomarch||'.err';

        SELECT SP_FN_FORMATOFECHA('FORMATO_SEL2') into sFormatoFecha FROM DUAL;
        SELECT SP_FN_FORMATOFECHA('FORMATO_SEL7') into sFormatoHora FROM DUAL;

    begin
       arch:=utl_file.fopen(donde,nom_ok,'a');
    exception
      when others then
         arch:=utl_file.fopen(donde,nom_ok,'w');
    end;
    arch_err:=utl_file.fopen(donde,nom_err,'w');
    v_linea:='EDO.VTA|N0 CONT|FEC CONT|COD CLIEN|MTO|FECHA PRE-ENG.|COD.VEND.|NOM. VEND.|SUCUR|';
    v_linea:=v_linea||'REGION|COMIS|CELULAR|SERIE|PLAN COM.|PLAN SERV.|MODELO|MARCA|NOMBRE|RUT|';
    v_linea:=v_linea||'DIREC. CORRESP.|CO MUNA|CIUDAD|TEL CONTACTO|CICLO|COD PLAN|PLAN TARIF.|';
    v_linea:=v_linea||'MESES|USUA.VTA|USUARIO RECEP. DOC.|FECHA RECEP. DOC.|USUARIO ACEP/RECH|';
    v_linea:=v_linea||'FECHA ACEP/RECH|US. CUMPL.|FEC. CUMPL.|PROC. EQ.|VEND. COMIS.|N0 VTA|';
    v_linea:=v_linea||'OBS DIREC|TIP. MERC.|MOD. VENTA|NUM. CUOTAS|SITUACION|FECHA ALTA|FECHA FIN CONTRATO|';
    v_linea:=v_linea||'CAUSA RECHAZO|USUAR.CUMPLEMENTACION|CAUSA RECHAZO PROV|OBS RECHAZO PROV|';
    v_linea:=v_linea||'DIAS RECHAZO PROVISORIO|CATEGORIA|SUPERVISOR|ASESOR|CAT. TRIB';
    utl_file.put_line(arch,v_linea);
    for cc in ventas loop
        v_bandera:=0;
        begin
          v_error:='Selecciona direccion';
          select di.nom_calle,di.num_calle,di.num_piso,di.obs_direccion,
          co.des_comuna,ci.des_ciudad
          into v_nomcalle,v_numcalle,v_numpiso,v_obsdireccion,v_descomuna,
          v_desciudad
          from ga_direccli dc,ge_direcciones di,ge_comunas co,ge_ciudades ci
          where dc.cod_cliente=cc.codcliente and
          dc.cod_tipdireccion=3 and
          dc.cod_direccion=di.cod_direccion and
          di.cod_comuna=co.cod_comuna and
          di.cod_ciudad=ci.cod_ciudad;
        exception
          when others then
            v_bandera:=1;
        end;
        if v_bandera=0 then
                begin
                        v_error:='Selecciona datos cliente';
                        select i.nom_cliente,i.nom_apeclien1,i.nom_apeclien2,
                        i.num_ident,i.tef_cliente1,categ.des_categoria,
                        super.nom_vendedor,asesor.nom_vendedor,cod_catribut
                        into v_nomcliente,v_nomapeclien1,v_nomapeclien2,v_numident,
                        v_tefcliente1,v_descategoria,v_supervisor,v_asesor,v_catribut
                        from ge_clientes i,ge_categorias categ,ve_vendedores super,
                        ve_vendedores asesor,ve_vendcliente vclien,ga_catributclie cattrib
                        where i.cod_cliente=cc.codcliente and
                                                cattrib.cod_cliente = i.cod_cliente and
                                                sysdate between cattrib.fec_desde and cattrib.fec_hasta and
                        i.cod_categoria=categ.cod_categoria(+) and
                        i.cod_supervisor=super.cod_vendedor(+) and
                        i.cod_cliente=vclien.cod_cliente(+) and
                        vclien.cod_vendedor=asesor.cod_vendedor(+);
                exception
                  when others then
                        v_bandera:=1;
                end;
        end if;
        if v_bandera=0 then
                begin
                        v_error:='Selecciona datos Contrato';
                        if cc.desplantarif!='PLAN AMISTAR' then
                          select l.num_contrato,l.fec_contrato,l.num_meses,
                          e.des_planserv,j.des_ciclo,dv.nom_vendealer
                          into v_numcontrato,v_feccontrato,v_nummeses,
                          v_desplanserv,v_desciclo,v_nomvendealer
                          from ga_abocel d,ga_contcta l,fa_ciclos j,
                          ga_planserv e,ve_vendealer dv
                          where d.num_abonado=cc.numabonado and
                          d.cod_ciclo=j.cod_ciclo and
                          d.cod_vendealer=dv.cod_vendealer(+) and
                          d.cod_cuenta=l.cod_cuenta and
                          d.cod_producto=l.cod_producto and
                          d.cod_tipcontrato=l.cod_tipcontrato and
                          d.num_contrato=l.num_contrato and
                          d.num_anexo=l.num_anexo and
                          d.cod_producto=e.cod_producto and
                          d.cod_planserv=e.cod_planserv;
                        else
                          select '','',0,e.des_planserv,'',dv.nom_vendealer
                          into v_numcontrato,v_feccontrato,v_nummeses,
                          v_desplanserv, v_desciclo,v_nomvendealer
                          from ga_aboamist d,ga_planserv e,ve_vendealer dv
                          where d.num_abonado=cc.numabonado and
                          d.cod_vendealer=dv.cod_vendealer(+) and
                          d.cod_producto=e.cod_producto and
                          d.cod_planserv=e.cod_planserv;
                        end if;
                exception
                  when others then
                    v_bandera:=1;
                end;
        end if;
        if v_bandera=0 then
                begin
                        v_error:='Selecciona datos equipo';
                        select f.ind_procequi,g.des_articulo,h.des_fabricante,tp.des_stock
                        into v_indprocequi,v_desarticulo,v_desfabricante,v_desstock
                        from al_fabricantes h,al_tipos_stock tp,al_articulos g,ga_equipaboser f
                        where f.num_abonado=cc.numabonado and
                        f.num_serie=cc.numserie and
                        f.fec_alta=(select max(fec_alta) from ga_equipaboser where
                                        num_abonado=cc.numabonado
                                        and num_serie=cc.numserie) and
                        f.cod_articulo=g.cod_articulo and
                        f.tip_stock=tp.tip_stock(+) and
                        g.cod_fabricante=h.cod_fabricante;
                exception
                  when others then
                    v_indprocequi:='';
                    v_desarticulo:='';
                    v_desfabricante:='';
                    v_desstock:='';
                end;
        end if;
        if v_bandera=0 then
                begin
                        v_error:='Selecciona modalidad de ventas';
                        select mv.des_modventa,tc.num_cuotas,cr.des_causarec,
                        usua.nom_operador,cp.des_causarep
                        into v_desmodventa,v_numcuotas,v_descausarec,
                        v_nomoperador,v_descausarep
                        from ga_causarep cp,ga_causarec cr,ge_seg_usuario usua,
                        ge_modventa mv,ge_tipcuotas tc,ga_ventas a
                        where a.num_venta=cc.numventa and
                        a.cod_cuota=tc.cod_cuota(+) and
                        a.cod_modventa=mv.cod_modventa(+) and
                        a.nom_usuar_cumpl=usua.nom_usuario(+) and
                        a.cod_causarec=cr.cod_causarec(+) and
                        a.cod_causarep=cp.cod_causarep(+) and
                        a.cod_producto=cp.cod_producto(+);
                exception
                  when others then
                    v_desmodventa:='';
                    v_numcuotas:=0;
                    v_descausarec:='';
                    v_nomoperador:='';
                    v_descausarep:='';
                end;
        end if;
        if v_bandera=0 then
                begin
                        v_error:='Selecciona datos de plan Comercia';
                        select n.des_plancom into v_desplancom
                        from ga_cliente_pcom m,ve_cabplancom n
                        where m.cod_cliente=cc.codcliente and
                        (m.fec_hasta is null or m.fec_hasta>=sysdate) and
                        m.cod_plancom=n.cod_plancom;
                exception
                  when others then
                    v_bandera:=1;
                end;
        end if;
        if v_bandera=0 then
          v_linea:= cc.indestventa||'|'||
                  v_numcontrato||'|'||
                  --to_char(v_feccontrato,'dd-mm-yyyy')||'|'||
                                  to_char(v_feccontrato, sFormatoFecha)||'|'||
                  cc.codcliente||'|'||
                  cc.impventa||'|'||
                  --to_char(cc.fecventa,  'dd-mm-yyyy hh24:mi:ss')||'|'||
                                  to_char(cc.fecventa,  sFormatoFecha || ' ' || sFormatoHora)||'|'||
                  cc.codvendedor||'|'||
                  cc.nomvendedor||'|'||
                  cc.desoficina||'|'||
                  cc.codregion||'|'||
                  cc.destipcomis||'|'||
                  cc.numcelular||'|'||
                  cc.numserie||'|'||
                  v_desplancom||'|'||
                  v_desplanserv||'|'||
                  v_desarticulo||'|'||
                  v_desfabricante||'|'||
                  v_nomcliente||'|'||
                  v_nomapeclien1||'|'||
                  v_nomapeclien2||'|'||
                  v_numident||'|'||
                  v_nomcalle||'|'||
                  v_numcalle||'|'||
                  v_numpiso||'|'||
                  v_descomuna||'|'||
                  v_desciudad||'|'||
                  v_tefcliente1||'|'||
                  v_desciclo||'|'||
                  cc.codplantarif||'|'||
                  cc.desplantarif||'|'||
                  v_nummeses||'|'||
                  cc.nomusuarvta||'|'||
                  cc.nomusuarrecdoc||'|'||
                  --to_char(cc.fecrecdocum,  'dd-mm-yyyy')||'|'||
                                  to_char(cc.fecrecdocum,  sFormatoFecha )||'|'||
                  cc.nomusuaracerec||'|'||
                  --to_char(cc.fecaceprec,  'dd-mm-yyyy hh24:mi:ss')||'|'||
                                  to_char(cc.fecaceprec,  sFormatoFecha || ' ' || sFormatoHora)||'|'||
                  cc.nomusuarcumpl||'|'||
                  --to_char(cc.feccumplimen,  'dd-mm-yyyy hh24:mi:ss')||'|'||
                                  to_char(cc.feccumplimen,  sFormatoFecha || ' ' || sFormatoHora)||'|'||
                  v_indprocequi||'|'||
                  v_nomvendealer||'|'||
                  cc.numventa||'|'||
                  v_obsdireccion||'|'||
                  v_desstock||'|'||
                  v_desmodventa||'|'||
                  v_numcuotas||'|'||
                  cc.codsituacion||'|'||
                  --to_char(cc.fecalta,  'dd-mm-yyyy')||'|'||
                                  to_char(cc.fecalta,  sFormatoFecha)||'|'||
                  --to_char(cc.fecfincontra ,  'dd-mm-yyyy')||'|'||
                                  to_char(cc.fecfincontra ,  sFormatoFecha)||'|'||
                  v_descausarec||'|'||
                  v_nomoperador||'|'||
                  v_descausarep||'|'||
                  cc.obsrecprov||'|'||
                  cc.numdias||'|'||
                  v_descategoria||'|'||
                  v_supervisor||'|'||
                  v_asesor||'|'||
                                  v_catribut||'|';
          utl_file.put_line(arch,v_linea);
        else
                utl_file.put_line(arch_err,v_error||' abonado:'||cc.numabonado);
        end if;
    end loop;
    utl_file.fclose(arch);
    utl_file.put_line(arch_err,'Termino ok');
    utl_file.fclose(arch_err);
end GR_P_GESCOM;
/
SHOW ERRORS
