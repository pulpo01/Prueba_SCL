CREATE OR REPLACE PROCEDURE        GA_P_CUENTA_PEX (SALIDA in varchar2,ARCHIVO in varchar2,ARCHIVO2 in varchar2,ARCHIVO3 in varchar2, vcListaDePlanes  in varchar2) AS
  cursor clientes is
    select distinct
    cod_cliente   cliente
    from ga_abocel
    where cod_cliente>0
    and cod_situacion not like 'B%'
	and instrb(vcListaDePlanes, chr(9)||cod_plantarif||chr(9)) > 0
    union select distinct
    a.cod_cliente   cliente
    from ga_abocel a,gat_plandesclie b
    where a.cod_situacion not like 'B%'
	and instrb(vcListaDePlanes, chr(9)||a.cod_plantarif||chr(9)) = 0
    and a.cod_cliente=b.cod_cliente
    and b.cod_plandesc='PDPEX'
    and b.fec_hasta>=sysdate;
    cursor plan_desc(p_cliente number) is select
    c.num_ident       rut,
    c.nom_cliente     nombre,
    c.nom_apeclien1   ape1,
    c.nom_apeclien2   ape2
    from  ta_plantarif t,gat_plandesclie d,ge_clientes c, ga_abocel a
    where a.cod_cliente=p_cliente
    and a.cod_situacion not in('BAP','BAA')
    and a.cod_cliente=c.cod_cliente
    and a.cod_cliente=d.cod_cliente(+)
    and d.cod_plandesc='PDPEX'
    and d.fec_hasta(+)>=sysdate
    and a.cod_plantarif=t.cod_plantarif
    and t.cod_producto=1
	group by
	c.num_ident,
    c.nom_cliente,
    c.nom_apeclien1,
    c.nom_apeclien2;
	cursor solo_plandesc (p_cliente number,p_rut ge_clientes.num_ident%type) is select
    c.num_ident      rut,
    c.nom_cliente    nombre,
    c.nom_apeclien1  ape1,
    c.nom_apeclien2  ape2,
	c.cod_ciclo      ciclo,
    d.cod_plandesc   plandesc,
    a.cod_plantarif  cplan,
    t.des_plantarif  dplan,
    a.num_celular    celular,
    a.cod_situacion  situac,
	v.nom_vendedor vend
    from  ta_plantarif t,gat_plandesclie d,ge_clientes c, ga_abocel a,
	ve_vendcliente e, ve_vendedores v
    where a.cod_cliente=p_cliente
	and c.num_ident = p_rut
    and a.cod_situacion not in('BAP','BAA')
    and a.cod_cliente=c.cod_cliente
    and a.cod_cliente=d.cod_cliente(+)
    and d.cod_plandesc='PDPEX'
    and d.fec_hasta(+)>=sysdate
    and a.cod_plantarif=t.cod_plantarif
    and t.cod_producto=1
	and a.cod_cliente =e.cod_cliente(+)
	and e.cod_vendedor = v.cod_vendedor(+);
    cursor pex_y_otros(p_cliente number) is select
    c.num_ident          rut,
    c.nom_cliente        nombre,
    c.nom_apeclien1      ape1,
    c.nom_apeclien2      ape2
    from  ve_vendedores  v ,ve_vendcliente e ,ta_plantarif t,
    gat_plandesclie d,ge_clientes c, ga_abocel a
    where a.cod_cliente=p_cliente
	and instrb(vcListaDePlanes, chr(9)||a.cod_plantarif||chr(9)) > 0
    and a.cod_situacion not like 'B%'
    and a.cod_cliente=c.cod_cliente
    and a.cod_cliente=d.cod_cliente(+)
    and d.fec_hasta(+)>=sysdate
    and a.cod_plantarif=t.cod_plantarif
    and t.cod_producto=1
    and a.cod_cliente=e.cod_cliente(+)
    and e.cod_vendedor=v.cod_vendedor(+)
	group by
	c.num_ident,
    c.nom_cliente,
    c.nom_apeclien1,
    c.nom_apeclien2;
    cursor solo_pexeeotros (p_cliente number,p_rut ge_clientes.num_ident%type) is select
    c.num_ident      rut,
    c.nom_cliente    nombre,
    c.nom_apeclien1  ape1,
    c.nom_apeclien2  ape2,
    c.cod_ciclo      ciclo,
    d.cod_plandesc   plandesc,
    a.cod_plantarif  cplan,
    t.des_plantarif  dplan,
    a.num_celular    celular,
    a.cod_situacion  situac,
    v.nom_vendedor   vend
    from  ve_vendedores  v ,ve_vendcliente e ,ta_plantarif t,
    gat_plandesclie d,ge_clientes c, ga_abocel a
    where a.cod_cliente=p_cliente
	and   c.num_ident = p_rut
	and instrb(vcListaDePlanes, chr(9)||a.cod_plantarif||chr(9)) > 0
    and a.cod_situacion not like 'B%'
    and a.cod_cliente=c.cod_cliente
    and a.cod_cliente=d.cod_cliente(+)
    and d.fec_hasta(+)>=sysdate
    and a.cod_plantarif=t.cod_plantarif
    and t.cod_producto=1
    and a.cod_cliente=e.cod_cliente(+)
    and e.cod_vendedor=v.cod_vendedor(+);
	cursor solo_pex(p_cliente number) is select
    c.num_ident      rut,
    c.nom_cliente    nombre,
    c.nom_apeclien1  ape1,
    c.nom_apeclien2  ape2
    from ve_vendedores v,ve_vendcliente e,gat_plandesclie d,ge_clientes c
    where c.cod_cliente=p_cliente
    and c.cod_cliente=d.cod_cliente(+)
    and d.fec_hasta(+)>=sysdate
    and c.cod_cliente=e.cod_cliente(+)
    and e.cod_vendedor=v.cod_vendedor(+)
	group by
	c.num_ident,
    c.nom_cliente,
    c.nom_apeclien1,
    c.nom_apeclien2;
  cursor solo_pexee(p_cliente number,p_rut ge_clientes.num_ident%type) is select
    c.num_ident      rut,
    c.nom_cliente    nombre,
    c.nom_apeclien1  ape1,
    c.nom_apeclien2  ape2,
    c.cod_ciclo      ciclo,
    d.cod_plandesc   plandesc,
    v.nom_vendedor   vendedor
    from ve_vendedores v,ve_vendcliente e,gat_plandesclie d,ge_clientes c
    where c.cod_cliente=p_cliente
	and c.num_ident = p_rut
    and c.cod_cliente=d.cod_cliente(+)
    and d.fec_hasta(+)>=sysdate
    and c.cod_cliente=e.cod_cliente(+)
    and e.cod_vendedor=v.cod_vendedor(+);
  arch            utl_file.file_type;
  v_salida        varchar2(100);
  v_archivo       varchar2(100);
  v_archivo2      varchar2(100);
  v_archivo3      varchar2(100);
  v_titulo        varchar2(300);
  v_linea         varchar2(500);
  v_bandera       number(1):=0;
  v_cuenta_pex    number(4);
  v_cuenta_total  number(4);
  v_otros         number(4);
begin
  v_salida:=SALIDA;
  v_archivo:=ARCHIVO||'.txt';
  v_archivo2:=ARCHIVO2||'.txt';
  v_archivo3:=ARCHIVO3||'.txt';
  arch:=utl_file.fopen(v_salida,v_archivo,'w');
  v_titulo:='RUT CLIENTE|CODIGO CLIENTE|NOMBRE CLIENTE|';
  v_titulo:=v_titulo||'CICLO|CANT. ABONADOS PEX|PLAN DCTO.|';
  v_titulo:=v_titulo||'EJEC. ASOCIADO';
  utl_file.put_line(arch,v_titulo);
  utl_file.fclose(arch);
  arch:=utl_file.fopen(v_salida,v_archivo2,'w');
  v_titulo:='RUT CLIENTE|CODIGO CLIENTE|NOMBRE CLIENTE|';
  v_titulo:=v_titulo||'CICLO|CANT. ABONADOS DISTINTOS PEX|';
  v_titulo:=v_titulo||'PLAN DCTO.|CODIGO PLAN TARIF.|DESCRIP. PLAN TARIF.';
  v_titulo:=v_titulo||'|NUMERO CEL.|SITUACION|EJEC. ASOCIADO';
  utl_file.put_line(arch,v_titulo);
  utl_file.fclose(arch);
  arch:=utl_file.fopen(v_salida,v_archivo3,'w');
  v_titulo:='RUT CLIENTE|CODIGO CLIENTE|NOMBRE CLIENTE|';
  v_titulo:=v_titulo||'CICLO|CANT. ABONADOS DISTINTOS PEX|';
  v_titulo:=v_titulo||'PLAN DCTO.|CODIGO PLAN TARIF.|DESCRIP. PLAN TARIF.';
  v_titulo:=v_titulo||'|NUMERO CEL.|SITUACION|EJEC. ASOCIADO';
  utl_file.put_line(arch,v_titulo);
  utl_file.fclose(arch);
  for cc in clientes loop
    v_bandera:=0;
    v_cuenta_pex:=0;
    v_cuenta_total:=0;
    v_otros:=0;
    -- cuenta abonado pex...
    begin
      select count(*) into v_cuenta_pex from ga_abocel
      where cod_cliente=cc.cliente
      and cod_situacion not in ('BAA','BAP')
	  and instrb(vcListaDePlanes, chr(9)||cod_plantarif||chr(9)) > 0;
    exception
      when others then
	v_bandera:=1;
    end;
    -- cuenta total abonados activos...
    if v_bandera=0 then
      begin
	select count(*) into v_cuenta_total from ga_abocel
	where cod_cliente=cc.cliente
	and cod_situacion not in ('BAA','BAP');
      exception
	when others then
	  v_bandera:=1;
      end;
    end if;
    v_otros:=v_cuenta_total-v_cuenta_pex;
    if v_otros = 0 and v_cuenta_total>0 then     -- solo pex
      arch:=utl_file.fopen(v_salida,v_archivo,'a');
      for dd in solo_pex(cc.cliente) loop
	     v_linea:=dd.rut||'|'||
		          cc.cliente||'|'||
		         dd.nombre|| ' ' || dd.ape1 || ' ' || dd.ape2;
	     utl_file.put_line(arch,v_linea);
	     for ee in solo_pexee(cc.cliente,dd.rut) loop
		       	v_linea:='' ||'|'||
		                 '' ||'|'||
		                 '' ||'|'||
		                 ee.ciclo||'|'||
		                 v_cuenta_pex||'|'||
		                 ee.plandesc||'|'||
		                 ee.vendedor;
		   	     utl_file.put_line(arch,v_linea);
		 end loop;
      end loop;
      utl_file.fclose(arch);
    elsif v_otros > 0 and v_otros < v_cuenta_total then    -- pex y otros
      arch:=utl_file.fopen(v_salida,v_archivo2,'a');
      for dd in pex_y_otros(cc.cliente) loop
	  	  v_linea:=dd.rut||'|'||
		  		cc.cliente||'|'||
		        dd.nombre|| ' ' || dd.ape1 || ' ' || dd.ape2;
				utl_file.put_line(arch,v_linea);
		   for ee in solo_pexeeotros (cc.cliente,dd.rut) loop
				v_linea:='' ||'|'||
		                 '' ||'|'||
		                 '' ||'|'||
		        		 ee.ciclo||'|'||
		        		 v_otros||'|'||
		        		 ee.plandesc||'|'||
		        		 ee.cplan||'|'||
		        		 ee.dplan||'|'||
		        		 ee.celular||'|'||
		        		 ee.situac||'|'||
		        		 ee.vend;
	 			utl_file.put_line(arch,v_linea);
			end loop;
      end loop;
      utl_file.fclose(arch);
    elsif v_otros > 0 and v_otros = v_cuenta_total then    -- solo otros
      arch:=utl_file.fopen(v_salida,v_archivo3,'a');
      for dd in plan_desc(cc.cliente) loop
	      v_linea:=dd.rut||'|'||
		  cc.cliente||'|'||
		  dd.nombre|| ' ' || dd.ape1 || ' ' || dd.ape2;
		  utl_file.put_line(arch,v_linea);
		  for ee in solo_plandesc (cc.cliente,dd.rut) loop
	  				v_linea:='' ||'|'||
                             '' ||'|'||
		                     '' ||'|'||
		    	   			 ee.ciclo||'|'||
		  					 v_otros||'|'||
		  					 ee.plandesc||'|'||
		  					 ee.cplan||'|'||
		  					 ee.dplan||'|'||
		  					 ee.celular||'|'||
		  					 ee.situac||'|'||
							 ee.vend;
	 						 utl_file.put_line(arch,v_linea);
			end loop;
      end loop;
      utl_file.fclose(arch);
    end if;
  end loop;
end GA_P_CUENTA_PEX;
/
SHOW ERRORS
