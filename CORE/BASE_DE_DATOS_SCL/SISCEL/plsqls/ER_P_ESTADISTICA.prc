CREATE OR REPLACE PROCEDURE        ER_P_ESTADISTICA
(pfec_desde in varchar2
,pfec_hasta in varchar2
,SALIDA in varchar2
,ARCHIVO in varchar2
)IS
v_num_abonado       ga_abocel.num_abonado%type;
v_num_celular       ga_abocel.num_celular%type;
v_cod_producto      ga_abocel.cod_producto%type;
v_cod_cliente       ga_abocel.cod_cliente%type;
v_cod_situacion     ga_abocel.cod_situacion%type;
v_cod_plantarif     ga_abocel.cod_plantarif%type;
v_fec_alta          varchar2(9);
v_num_contrato      ga_abocel.num_contrato%type;
v_fec_baja          varchar2(9);
v_cod_tip_contrato  ga_abocel.cod_tipcontrato%type;
v_cod_causabaja     ga_abocel.cod_causabaja%type;
v_cod_causarec      ga_ventas.cod_causarec%type;
v_cod_vende_raiz    ve_vendedores.cod_vende_raiz%type;
v_cod_vendedor      ga_ventas.cod_vendedor%type;
v_cod_vendealer     ve_vendealer.cod_vendealer%type;
v_cod_region        ga_ventas.cod_region%type;
v_cod_ciudad        ga_ventas.cod_ciudad%type;
v_cod_comuna        ge_oficinas.cod_comuna%type;
v_imp_venta         ga_ventas.imp_venta%type;
v_ind_estventa      ga_ventas.ind_estventa%type;
v_num_venta         ga_ventas.num_venta%type;
v_fec_aceprec       varchar2(9);
v_fec_proceso       varchar2(9);
v_cod_articulo      ga_equipaboser.cod_articulo%type;
v_titulo varchar2(500);
v_file UTL_FILE.FILE_TYPE;
arch varchar2(50);
arv varchar2(50);
file varchar2(50);
CURSOR c1 IS
SELECT
       d.num_abonado, d.num_celular, d.cod_producto, d.cod_cliente, d.cod_situacion,
       d.cod_plantarif, substr(to_char(d.fec_alta,'yyyymmdd'),1,8) fec_alta, d.num_contrato,
       substr(to_char(d.fec_baja,'yyyymmdd'),1,8)  fec_baja, d.cod_tipcontrato, d.cod_causabaja,
       a.cod_causarec, b.cod_vende_raiz, a.cod_vendedor, dv.cod_vendealer, a.cod_region,
       a.cod_ciudad, c.cod_comuna, a.imp_venta, a.ind_estventa, a.num_venta,
       substr(to_char(a.fec_aceprec,'yyyymmdd'),1,8) fec_aceprec,
       substr(to_char(sysdate,'yyyymmdd'),1,8) fec_proceso, f.cod_articulo
FROM
       al_tipos_stock tp, ve_vendealer dv, ge_ciudades ci, ge_comunas co, ge_direcciones di,
       ga_direccli dc, ve_vendedores b, ge_oficinas c, ga_abocel d, ga_planserv e,
       ga_equipaboser f, al_articulos g, al_fabricantes h, ge_clientes i, fa_ciclos j,
       ta_plantarif k, ga_contcta l, ga_cliente_pcom m, ve_cabplancom n, ve_tipcomis o,
       ga_ventas a ,ge_modventa mv , ge_tipcuotas tc, ge_tipdocumen gt, GA_CAUSAREC cr
WHERE
       a.num_venta=d.num_venta and a.cod_cuota=tc.cod_cuota(+) and a.cod_modventa=mv.cod_modventa(+)
       and a.cod_cliente=d.cod_cliente and a.cod_docdealer=gt.cod_tipdocum(+)
       and a.cod_causarec=cr.cod_causarec(+) and d.cod_vendealer=dv.cod_vendealer(+)
       and a.ind_venta in ('V','v','C') and d.num_abonado=f.num_abonado
       and d.num_serie=f.num_serie
       and f.fec_alta = (select max(fec_alta)
                         from ga_equipaboser  hhr
			 where  d.num_abonado=hhr.num_abonado
                         and d.num_serie=hhr.num_serie)
       and d.cod_ciclo=j.cod_ciclo and d.cod_producto=k.cod_producto
       and d.cod_plantarif=k.cod_plantarif and k.cod_producto=1 and f.cod_articulo=g.cod_articulo
       and f.tip_stock=tp.tip_stock(+) and g.cod_fabricante=h.cod_fabricante
       and a.cod_cliente=i.cod_cliente and d.cod_cuenta=l.cod_cuenta
       and d.cod_producto=l.cod_producto and d.cod_tipcontrato=l.cod_tipcontrato
       and d.num_contrato=l.num_contrato and d.num_anexo=l.num_anexo
       and d.num_venta=l.num_venta and d.cod_producto=e.cod_producto
       and d.cod_planserv=e.cod_planserv and a.cod_vendedor=b.cod_vendedor
       and a.cod_oficina=c.cod_oficina and (m.fec_hasta is null or m.fec_hasta>=sysdate)
       and a.cod_cliente=m.cod_cliente and m.cod_plancom=n.cod_plancom
       and a.cod_tipcomis=o.cod_tipcomis and i.cod_cliente=dc.cod_cliente
       and dc.cod_tipdireccion=3 and dc.cod_direccion=di.cod_direccion
       and di.cod_region=co.cod_region and di.cod_provincia=co.cod_provincia
       and di.cod_comuna=co.cod_comuna and di.cod_region=ci.cod_region
       and di.cod_provincia=ci.cod_provincia and di.cod_ciudad=ci.cod_ciudad
       and ind_vta_externa=1 and trunc(a.fec_venta)>=to_date(pfec_desde,'dd-mm-yyyy')
       and trunc(a.fec_venta)<to_date(pfec_hasta,'dd-mm-yyyy')
UNION
SELECT
       d.num_abonado, d.num_celular, d.cod_producto, d.cod_cliente, d.cod_situacion,
       d.cod_plantarif, substr(to_char(d.fec_alta,'yyyymmdd'),1,8) fec_alta,
       d.num_contrato, substr(to_char(d.fec_baja,'yyyymmdd'),1,8)  fec_baja,
       d.cod_tipcontrato, d.cod_causabaja, a.cod_causarec, b.cod_vende_raiz,
       a.cod_vendedor, dv.cod_vendealer, a.cod_region, a.cod_ciudad, c.cod_comuna,
       a.imp_venta, a.ind_estventa, a.num_venta,
       substr(to_char(a.fec_aceprec,'yyyymmdd'),1,8) fec_aceprec,
       substr(to_char(sysdate,'yyyymmdd'),1,8) fec_proceso, f.cod_articulo
FROM
       al_tipos_stock tp, ve_vendealer dv, ge_ciudades ci, ge_comunas co,
       ge_direcciones di , ga_direccli dc, ve_vendedores b, ge_oficinas c,
       ga_habocel d, ga_planserv e,ga_hequipaboser f, al_articulos g,
       al_fabricantes h, ge_clientes i, fa_ciclos j, ta_plantarif k,
       ga_contcta l, ga_cliente_pcom m, ve_cabplancom n, ve_tipcomis o,
       ga_ventas a, ge_modventa mv, ge_tipcuotas tc, ge_tipdocumen gt,
       GA_CAUSAREC cr
WHERE  a.num_venta=d.num_venta and a.cod_cuota=tc.cod_cuota(+)
       and a.cod_modventa=mv.cod_modventa(+)
       and a.cod_cliente=d.cod_cliente and a.cod_docdealer=gt.cod_tipdocum(+)
       and a.cod_causarec=cr.cod_causarec(+)
       and a.cod_vendealer=dv.cod_vendealer(+) and a.ind_venta in ('V','v','C')
       and d.num_abonado=f.num_abonado and d.num_serie=f.num_serie
       and d.cod_ciclo=j.cod_ciclo and d.cod_producto=k.cod_producto
       and d.cod_plantarif=k.cod_plantarif and k.cod_producto=1
       and f.cod_articulo=g.cod_articulo and f.tip_stock=tp.tip_stock(+)
       and g.cod_fabricante=h.cod_fabricante and a.cod_cliente=i.cod_cliente
       and d.cod_cuenta=l.cod_cuenta and d.cod_producto=l.cod_producto
       and d.cod_tipcontrato=l.cod_tipcontrato
       and d.num_contrato=l.num_contrato and d.num_anexo=l.num_anexo
       and d.num_venta=l.num_venta and d.cod_producto=e.cod_producto
       and d.cod_planserv=e.cod_planserv and a.cod_vendedor=b.cod_vendedor
       and a.cod_oficina=c.cod_oficina
       and (m.fec_hasta is null or m.fec_hasta>=sysdate)
       and a.cod_cliente=m.cod_cliente and m.cod_plancom=n.cod_plancom
       and a.cod_tipcomis=o.cod_tipcomis and i.cod_cliente=dc.cod_cliente
       and dc.cod_tipdireccion=3 and dc.cod_direccion=di.cod_direccion
       and di.cod_region=co.cod_region and di.cod_provincia=co.cod_provincia
       and di.cod_comuna=co.cod_comuna and di.cod_region=ci.cod_region
       and di.cod_provincia=ci.cod_provincia and di.cod_ciudad=ci.cod_ciudad
       and ind_vta_externa = 1 and trunc(a.fec_venta)>=to_date(pfec_desde,'dd-mm-yyyy')
       and trunc(a.fec_venta)<to_date(pfec_hasta,'dd-mm-yyyy');
 begin
   file:=archivo;
   arv:=salida;
   arch:=file;
   v_titulo:='num_abonado|' || 'num_celular|' || 'cod_producto|' || 'cod_cliente|' || 'cod_situacion|' || 'cod_plantarif|' ||
             'fec_alta|' || 'num_contrato|' || 'fec_baja|' || 'cod_tipcontrato|' || 'cod_causabaja|' || 'cod_causarec|' ||
             'cod_vende_raiz|' || 'cod_vendedor|' || 'cod_vendealer|' || 'cod_region|' || 'cod_ciudad|' || 'cod_comuna|' ||
             'imp_venta|' || 'ind_estventa|' || 'num_venta|' || 'fec_aceprec|' || 'fec_sistema|' || 'cod_articulo';
   v_file:=UTL_FILE.FOPEN(arv,arch,'w');
   UTL_FILE.PUT_LINE(v_file, v_titulo);
   UTL_FILE.FCLOSE(v_file);
   v_file:=UTL_FILE.FOPEN(arv,arch,'a');
   OPEN c1;
   LOOP
      begin
        fetch c1 into v_num_abonado, v_num_celular, v_cod_producto, v_cod_cliente, v_cod_situacion,
                      v_cod_plantarif, v_fec_alta, v_num_contrato, v_fec_baja, v_cod_tip_contrato,
                      v_cod_causabaja, v_cod_causarec, v_cod_vende_raiz, v_cod_vendedor, v_cod_vendealer,
                      v_cod_region, v_cod_ciudad, v_cod_comuna, v_imp_venta, v_ind_estventa, v_num_venta,
                      v_fec_aceprec, v_fec_proceso, v_cod_articulo;
       exit when c1%notfound;
       Utl_file.put_line(v_file,v_num_abonado || '|' || v_num_celular || '|' || v_cod_producto || '|' ||
                         v_cod_cliente || '|' || v_cod_situacion || '|' || v_cod_plantarif || '|' ||
                         v_fec_alta || '|' || v_num_contrato || '|' || v_fec_baja || '|' ||
                         v_cod_tip_contrato || '|' || v_cod_causabaja || '|' || v_cod_causarec || '|' ||
                         v_cod_vende_raiz || '|' || v_cod_vendedor || '|' || v_cod_vendealer || '|' ||
                         v_cod_region || '|' || v_cod_ciudad || '|' || v_cod_comuna || '|' ||
                         v_imp_venta || '|' || v_ind_estventa || '|' || v_num_venta || '|' ||
                         v_fec_aceprec || '|' || v_fec_proceso || '|' || v_cod_articulo);
       EXCEPTION
       when no_data_found then
       null;
      end;
   end LOOP;
   CLOSE c1;
   UTL_FILE.FCLOSE(v_file);
 END ER_P_ESTADISTICA;
/
SHOW ERRORS
