CREATE OR REPLACE PROCEDURE CO_BAJAS_CELULAR(p_FECHA_DESDE in varchar2, p_FECHA_HASTA in VARCHAR2, SALIDA in varchar2 , ARCHIVO in varchar2) IS
        desde             date;
        hasta             date;
        pp                varchar2(50);
        arv               varchar2(50);
        puntero           utl_file.file_type;
        v_fila            varchar2(2000);
        v_trasa           varchar2(500);
        v_DesCategoria    ge_categorias.des_categoria%type;
        v_CodCatribut     varchar2(20);
		v_DesCiudad		  ge_ciudades.des_ciudad%type;
		v_TotFactura      fa_histdocu.tot_factura%type;--
		v_NumAboCli		  number(10);
		v_sucursal		  ge_oficinas.des_oficina%type;
		v_UsuBaja		  ci_orserv.usuario%type;
		v_Ofibaja		  ge_oficinas.des_oficina%type;
		v_IndFactur		  fa_histcargos.imp_cargo%type;--
		v_DesMoneda		  ge_monedas.des_moneda%type;
		v_NumRecla		  number(10);
		v_UltReclamo      re_reclamos.rec_descripcion%type;
		v_PenUltReclamo   re_reclamos.rec_descripcion%type;
		v_Cliente 		  ge_clientes.cod_cliente%type;
		v_cuenta		  number(10);
		v_DesCausaBaja    varchar2(30);
		v_DesUso		  varchar2(20);
		v_Impcargo		  Number(14,4);
		v_NomVendedor	  varchar2(40);
		v_desTipComis	  varchar2(30);
		v_Plantarif		  varchar2(30);
		v_Region		  varchar2(3);
		v_Oficina		  varchar2(40);
		v_Articulo		  varchar2(40);
		v_Fabricante	  varchar2(20);
		v_CodVendedor	  Number(6);
		v_UsuOrdSer		  varchar2(30);
		v_CodOrdSer 	  varchar2(5);
		v_IndSDes    	  Number(14,4);
		v_MonSdes         varchar2(20);
		v_TipContrato     varchar2(40);
		v_ClaPlantarif    co_codigos.des_valor%type;
		v_Fec_Max		  date;
		/*--------------------------------------------------------------------------------------*/
CURSOR ccp(v_desde date, v_hasta date) IS SELECT
	  A.NUM_CELULAR  	 		 	   	  Numcelular,
	  TO_CHAR(A.FEC_FINCONTRA,'DD-MM-YYYY')FecFinContra,
	  TO_CHAR(A.FEC_ALTA,'DD-MM-YYYY')    FecAlta,
	  A.IND_PROCEQUI    				  IndProceEqui,
	  A.COD_PLANTARIF   			 	  CodPlantarif,
	  A.NUM_CONTRATO     				  NumContrato,
	  TO_CHAR(A.FEC_ACEPVENTA,'DD-MM-YYYY')FecAcepVenta,
	  A.NUM_ABONADO   				      NumAbonado,
	  A.COD_CLIENTE   			 		  CodCliente,
	  A.TIP_PLANTARIF 			 		  TipPlanTarif,
	  TO_CHAR(A.FEC_BAJA,'DD-MM-YYYY')    FecBaja,
	  A.NUM_SERIE   					  NumSerie,
	  TO_CHAR(A.FEC_ACTCEN,'DD-MM-YYYY')  FecActCen,
	  A.COD_CAUSABAJA   				  CodCausabaja,
	  B.NUM_IDENT 						  RutCliente,
	  B.NOM_CLIENTE||' '||B.NOM_APECLIEN1||' '||B.NOM_APECLIEN2	  NomCliente,
	  A.NUM_VENTA						  NumVenta,
	  D.COD_ARTICULO					  CodArticulo,
	  D.FEC_ALTA						  FecAltaUlt
	FROM  GA_ABOCEL A, GE_CLIENTES B, GA_EQUIPABOSER D
    WHERE  A.COD_SITUACION IN ('BAA','BAP') AND TRUNC(A.FEC_BAJA) BETWEEN desde AND hasta
	AND A.COD_CLIENTE = B.COD_CLIENTE
    AND A.NUM_ABONADO = D.NUM_ABONADO
	AND A.NUM_SERIE = D.NUM_SERIE AND
    D.FEC_ALTA IN(SELECT MAX(FEC_ALTA) FROM GA_EQUIPABOSER Z WHERE Z.NUM_ABONADO = A.NUM_ABONADO);
/*----------------------------------------------------------------------------------------*/
BEGIN
    v_cuenta:=0;
    pp:=SALIDA;
    arv:=ARCHIVO;
    desde:=to_date(p_fecha_desde, 'dd-mm-yyyy');
    hasta:=to_date(p_fecha_hasta, 'dd-mm-yyyy');
	v_Cliente:= 1;
    puntero:=utl_file.fopen(pp,arv,'w');
    Utl_file.put_line(puntero,'Oficina'||'|'||'Usuario OOSS'||'|'||'Rut Cliente'||'|'||'Nom. Cliente'||'|'||'Causa Baja'||'|'||'Num. Celular'||'|'||'Uso'||'|'||'Fec. Fin Contrato'||'|'||'Nom. Vendedor'||'|'||'Tipo Comis.'||'|'||'Cod. OOSS.'||'|'||'Ind. Pr
o. Equi'||'|'||'Cod. Plan Tarifario'||'|'||'Plan Tarifario'||'|'||'Fecha Alta'||'|'||'Num. Contrato'||'|'||'Cod. Region'||'|'||'Articulo'||'|'||'Fabricante'||'|'||'Fec. Acep.Venta'||'|'||'Num. Abonado'||'|'||'Cod. Cliente'||'|'||'Tipo Plan Tarif.'||'|'||'
Fec. Baja'||'|'||'Num. Serie'||'|'||'Fec. Act.Cen.'||'|'||'Cod. Causa Baja'||'|'||'Cod. Vendedor'||'|'||'Tipo de Cliente'||'|'||'Categ. Tributaria'||'|'||'Ciudad'||'|'||'Facturacion promedio (s/iva)'||'|'||'Num. Abo x Cli'||'|'||'Sucursal Venta'||'|'||'Us
uario Baja'||'|'||'Oficina baja'||'|'||'Indemnizacion Factura (s/iva)'||'|'||'Moneda'||'|'||'Indemnizacion sin descuento'||'|'||'Moneda'||'|'||'Num. Reclamos'||'|'||'Ultimo Reclamo'||'|'||'Penultimo Reclamo'||'|'||'Tipo de Contrato'||'|'||'Fec.Act.Serie'||'|'||'Clase Plan Tarif.');
    for cc in ccp(desde,hasta) loop
	v_cuenta:=v_cuenta+1;
	      begin
--          Orden de servicio --
            v_trasa:='En ooss...';
			SELECT  USUARIO,COD_OS into v_UsuOrdSer, v_CodOrdSer
			FROM CI_ORSERV
            WHERE TIP_INTER = 1 AND
			COD_INTER = cc.NumAbonado AND
			COD_OS IN('10222','10220','10226','10228','10224','10223') AND
			TO_CHAR(FECHA,'DD-MM-YYYY') = cc.FecBaja and rownum <2;
                  	 begin
            --           Region y oficina --
                        v_trasa:='En Region y oficina...';
               		    select a.cod_region,a.des_oficina into v_Region, v_Oficina
            		    from ge_oficinas a,ge_seg_usuario b
            		    where b.nom_usuario = v_UsuOrdSer and
            		    a.cod_oficina = b.cod_oficina;
                     exception
                       when no_data_found then
            		   v_Region:='S/R';
            		   v_Oficina:='S/oficina';
                     end;
          exception
            when no_data_found then
			  v_UsuOrdSer:='';
			  v_CodOrdSer:='';
          end;
       	  begin
--          causa Baja --
            v_trasa:='En Causa baja...';
			select b.des_causabaja into v_DesCausaBaja
			from ga_abocel a, ga_causabaja b
			where b.cod_producto = 1 and
			a.cod_causabaja = b.cod_causabaja and
			num_abonado = cc.NumAbonado;
          exception
            when no_data_found then
              v_DesCausaBaja:='';
          end;
       	  begin
--          Des Uso  --
            v_trasa:='En Descripcion Uso...';
			select b.des_uso into v_DesUso
			from ga_abocel a, al_usos b
			where a.cod_uso = b.cod_uso and
			num_abonado = cc.NumAbonado;
          exception
            when no_data_found then
              v_DesUso:='';
          end;
/*       	  begin
--          Imp cargo  --
            v_trasa:='En imp. cargo...';
    	    select decode(b.imp_cargo,null,0,round(b.imp_cargo  - decode(b.tip_dto,0,b.val_dto,(b.imp_cargo * (b.val_dto/100))))  * 1.18) into v_ImpCargo
			from ga_abocel a, ge_cargos b
			where b.num_abonado = a.num_abonado and
			trunc(a.fec_baja) = trunc(b.fec_alta) and
			b.num_abonado = cc.NumAbonado and rownum <2;
--     		dbms_output.put_line('bien Modelo ' );
          exception
            when no_data_found then
              v_ImpCargo:='';
--     		dbms_output.put_line('error en Modelo');
          end;*/
       	  begin
--           Vendedor  --
             v_trasa:='En Vendedor...';
            select b.cod_vendedor ,b.Nom_vendedor, c.des_tipcomis into v_CodVendedor,v_NomVendedor, v_DesTipComis
			from ga_abocel a, ve_vendedores b,ve_tipcomis c
			where a.cod_vendedor = b.cod_vendedor and
			b.cod_tipcomis = c.cod_tipcomis and
     		a.num_abonado = cc.NumAbonado;
          exception
            when no_data_found then
			   v_NomVendedor:='';
			   v_DesTipComis:='';
			   v_CodVendedor:='';
          end;
       	  begin
--           Plan tarifario  --
             v_trasa:='En Plan tarifario...';
            select b.Des_plantarif into v_PlanTarif
			from ga_abocel a, ta_plantarif b
			where b.cod_producto =1 and
			a.cod_plantarif = b.cod_plantarif and
     		a.num_abonado = cc.NumAbonado;
          exception
            when no_data_found then
			   v_PlanTarif:='';
          end;
       	  begin
--           Articulo  y Fabricante --
             v_trasa:='En Articulo  y Fabricante...';
     		select a.des_articulo,b.des_fabricante into v_Articulo, v_Fabricante
			from al_articulos a,al_fabricantes b
			where a.cod_fabricante = b.cod_fabricante and
			cc.CodArticulo = a.cod_articulo;
          exception
            when no_data_found then
			   v_Articulo:='';
			   v_Fabricante:='';
          end;
	  -- aqui
/*     	  begin
--          Modelo --
            v_trasa:='En Modelo...';
			select b.des_articulo into v_Modelo
            from  ga_equipaboser a,al_articulos b
            where a.num_abonado = cc.NumAbonado  and
            a.fec_alta in(select max(fec_alta)
			              from  ga_equipaboser where num_abonado = cc.NumAbonado ) and
            a.cod_articulo = b.cod_articulo;
--     		dbms_output.put_line('bien Modelo ' );
          exception
            when no_data_found then
              v_Modelo:='';
--     		dbms_output.put_line('error en Modelo');
          end;*/
/*		  begin
--          plan tarifario --
            v_trasa:='En plan tarifario...';
			select cla_plantarif into v_codplantarif
			from ta_plantarif
			where cod_producto= 1 and
			cod_plantarif = cc.codplantarif;
--     		dbms_output.put_line('bien plan tarifario');
          exception
            when no_data_found then
              v_codplantarif:='';
--     		dbms_output.put_line('error en plan tarifario');
          end;*/
		  begin
--          sucursal de la venta-- ga_ventas
            v_trasa:='En sucursal de la venta...';
			select des_oficina into v_sucursal
			from ga_ventas a,ge_oficinas b
			where a.num_venta = cc.NumVenta
			and a. cod_oficina = b.cod_oficina;
          exception
            when no_data_found then
              v_sucursal:='';
          end;
		  begin
--          suario y oficina de baja --
			v_trasa:='En usuario y oficina de baja...';
            select a.usuario,c.des_oficina into v_UsuBaja,v_Ofibaja
            from ci_orserv a,ge_seg_usuario b, ge_oficinas c
            where a.usuario = b.nom_usuario and
            b.cod_oficina = c.cod_oficina and
            a.producto = 1 and
            a.tip_inter = 1 and
            a.cod_inter = cc.NumAbonado
            and a.fecha in  (select max(a.fecha) from ci_orserv a,ge_seg_usuario b, ge_oficinas c
				             where a.usuario = b.Nom_usuario and
							 b.cod_oficina = c.cod_oficina and
							 a.producto = 1 and
							 a.tip_inter = 1 and
							 a.cod_inter = cc.NumAbonado and
							 a.cod_os IN('10220','10222','10226','10228','10224','10223','10024','10027','10028'));
          exception
		    when no_data_found then
			    begin
					select a.usuario,c.des_oficina into v_UsuBaja,v_Ofibaja
					from ci_orserv a,ge_seg_usuario b, ge_oficinas c
					where a.usuario = b.nom_usuario
					and b.cod_oficina = c.cod_oficina
					and a.producto = 1
					and a.tip_inter = 8
					and a.cod_inter in(select cod_cliente from ga_abocel where num_abonado = cc.NumAbonado)
					and cod_os in('10220','10222','10226','10228','10224','10223','10024','10027','10028');
	            exception
				when no_data_found then
				  /*v_UsuBaja:='OPS$XPCOBROS';
				  v_Ofibaja:='OFICINA CENTRAL';*/
				  v_UsuBaja:='';
				  v_Ofibaja:='';
          		end;
		  end;
	      begin
             v_trasa:='En Tipo_contrato...';
             select des_tipcontrato into v_TipContrato
             from ga_abocel a,ga_tipcontrato c
             where a.num_abonado = cc.NumAbonado
             and a.cod_tipcontrato = c.cod_tipcontrato
             and c.cod_producto=1;
          exception
            when no_data_found then
              v_TipContrato:='';
          end;
		  begin
             v_trasa:='En clase de plan tarifario...';
           	select a.des_valor into v_ClaPlantarif
			from co_codigos a,ta_plantarif b
			where a.nom_tabla = 'TA_PLANTARIF'
			and a.nom_columna ='CLA_PLANTARIF'
			and a.cod_valor = b.cla_plantarif
			and b.cod_plantarif = cc.CodPlantarif
			and b.cod_producto = 1;
		  exception
            when no_data_found then
              v_ClaPlantarif:='';
          end;
--**************************************************************************************************************
   if v_Cliente <> cc.CodCliente then
          begin
--	    categoria--
            v_trasa:='En des_categoria...';
            select b.des_categoria into v_DesCategoria
            from ge_clientes a,ge_categorias b
            where a.cod_cliente = cc.CodCliente
            and a.cod_categoria = b.cod_categoria;
          exception
            when no_data_found then
              v_DesCategoria:='S/categoria';
          end;
       	  begin
--          indice de facturacion (boleta o factura)--
            v_trasa:='En indice de facturacion...';
            Select decode(cod_catribut,'B','BOLETA','F','FACTURA') into v_CodCatribut
            from ga_catributclie
            where cod_cliente = cc.CodCliente and rownum <2;
          exception
            when no_data_found then
              v_CodCatribut:='S/categoria tributaria';
          end;
		  begin
--           ciudad --
            v_trasa:='En ciudad...';
            select c.des_ciudad into v_DesCiudad
			from ga_direccli a,  ge_direcciones b , ge_ciudades c
            where a.cod_cliente = cc.CodCliente and
            a.cod_direccion = b.cod_direccion and
            a.cod_tipdireccion = 2 and b.cod_ciudad = c.cod_ciudad;
          exception
            when no_data_found then
              v_DesCiudad:='S/ciudad';
          end;
		  begin
--           Fecha maxima factura promedio de los ultimos 6 meses --
            v_trasa:='En Fecha maxima factura promedio de los ultimos 6 meses...';
			SELECT max(fec_emision) into v_Fec_Max
			from fa_histdocu
			where cod_cliente = cc.codcliente;
          exception
            when no_data_found then
              v_Fec_Max:=sysdate;
          end;
		  begin
--           factura promedio de los ultimos 6 meses --
            v_trasa:='En factura promedio de los ultimos 6 meses...';
			select round((sum(tot_factura)/6)/1.18) into v_TotFactura
			from fa_histdocu
			where cod_cliente = cc.codcliente and
            fec_emision between add_months(v_Fec_Max,-6) and v_Fec_Max order by fec_emision desc;
          exception
            when no_data_found then
              v_TotFactura:='S/TotFactura';
          end;
		  begin
--          Numero de abonados por cliente --
            v_trasa:='En Numero de abonados por cliente...';
            select count(*) into v_NumAboCli
			from ga_abocel
			where cod_cliente = cc.codcliente and
			cod_situacion in('BAA','BAP');
          exception
            when no_data_found then
              v_NumAboCli:='S/Abonados';
          end;
		  begin
--		   indemnizacion facturada --  ??????????????????????????????????????????????
    		v_trasa:='indemnizacion facturada...';
   		    select decode(a.imp_cargo,null,0,decode(a.val_dto,null,a.imp_cargo,round(a.imp_cargo  - decode(a.tip_dto,0,a.val_dto,(a.imp_cargo * (a.val_dto/100)))))),b.des_moneda INTO v_IndFactur,  v_DesMoneda
            from fa_histcargos a,ge_monedas b
            Where a.cod_cliente = cc.codcliente
            and a.cod_moneda = b.cod_moneda(+)
			and a.cod_concepto in (33,3392,5397)
            and a.num_cargo in (select max(num_cargo)
			                   from fa_histcargos
							   where cod_cliente =cc.codcliente
							   and a.cod_concepto in (33,3392,5397));
          exception
			when no_data_found then
     			v_IndFactur:=0;
        		v_DesMoneda:='0';
          end;
		  begin
--		   indemnizacion sin descuento   --
    		v_trasa:='indemnizacion sin descuento...';
     		select a.imp_cargo,b.des_moneda into v_IndSDes,	v_MonSdes
            from fa_histcargos a,ge_monedas b
            Where a.cod_cliente = cc.codcliente
            and a.cod_moneda = b.cod_moneda(+)
			and a.cod_concepto in (33,3392,5397)
            and a.num_cargo in (select max(num_cargo)
			                   from fa_histcargos
							   where cod_cliente =cc.codcliente
							   and a.cod_concepto in (33,3392,5397));
          exception
			when no_data_found then
     			v_IndSDes:=0;
        		v_MonSdes:='0';
          end;
  		  begin
--		   Numero de reclamos ultimos 4 meses --
    		v_trasa:='En Numero de reclamos ultimos 4 meses...';
            select count(*) into v_NumRecla
			from re_reclamos
			where  cod_cliente = cc.codcliente and
			fec_reclamo between add_months(sysdate,-4) and sysdate;
          exception
            when no_data_found then
			  v_NumRecla:='S/Reclamo';
          end;
  		  begin
--		   ULTIMO RECLAMO --
    		v_trasa:='En ULTIMO RECLAMO...';
            select rec_descripcion INTO v_UltReclamo
			from re_reclamos
			where  cod_cliente = cc.codcliente and
			fec_reclamo between add_months(sysdate,-4) and sysdate and
			fec_reclamo in(select max(fec_reclamo)
			               from re_reclamos
						   where  cod_cliente = cc.codcliente and
						   fec_reclamo between add_months(sysdate,-4) and sysdate);
            exception
             when no_data_found then
	         v_UltReclamo:='S/ultimo reclamo';
          end;
  		  begin
--		   AGREGUE PENULTIMO RECLAMO --
    		v_trasa:='En Agregue penultimo reclamo...';
            select rec_descripcion into v_PenUltReclamo
			from re_reclamos
			where  cod_cliente = cc.codcliente and
			fec_reclamo between add_months(sysdate,-4) and sysdate
            and fec_reclamo =(select max(fec_reclamo)
			                  from re_reclamos
							  where cod_cliente = cc.codcliente and
							  fec_reclamo between add_months(sysdate,-4) and sysdate
            and fec_reclamo <> (select max(fec_reclamo)
			                    from re_reclamos
								where cod_cliente= cc.codcliente and
								fec_reclamo between add_months(sysdate,-4) and sysdate));
          exception
            when no_data_found then
			  v_PenUltReclamo:='S/penultimo reclamo';
          end;
		  v_cliente := cc.CodCliente;
	end if;
/*----------------------------------------------------------------------------------------*/
				v_trasa:='configura fila...';
				v_fila:=v_Oficina||'|'||
					v_UsuOrdSer||'|'||
					cc.RutCliente||'|'||
					cc.NomCliente||'|'||
					v_DesCausaBaja||'|'||
					cc.NumCelular||'|'||
					v_DesUso||'|'||
					cc.FecFinContra||'|'||
					v_NomVendedor||'|'||
					v_DesTipComis||'|'||
					v_CodOrdSer||'|'||
					cc.IndProceEqui||'|'||
					cc.CodPlanTarif||'|'||
					v_PlanTarif||'|'||
					cc.FecAlta||'|'||
					cc.NumContrato||'|'||
					v_Region||'|'||
					v_Articulo||'|'||
					v_Fabricante||'|'||
					cc.FecAcepVenta||'|'||
					cc.NumAbonado||'|'||
					cc.CodCliente||'|'||
					cc.TipPlanTarif||'|'||
					cc.FecBaja||'|'||
					cc.NumSerie||'|'||
					cc.FecActCen||'|'||
					cc.CodCausaBaja||'|'||
					v_CodVendedor||'|'||
     				v_DesCategoria||'|'||
					v_CodCatribut||'|'||
					v_DesCiudad||'|'||
					v_TotFactura||'|'||
					v_NumAboCli||'|'||
					v_sucursal||'|'||
					v_UsuBaja||'|'||
					v_Ofibaja||'|'||
					v_IndFactur||'|'||
					v_DesMoneda||'|'||
					v_IndSDes||'|'||
             		v_MonSdes||'|'||
					v_NumRecla||'|'||
					v_UltReclamo||'|'||
					v_PenUltReclamo||'|'||
					v_TipContrato||'|'||
					cc.FecAltaUlt||'|'||
					v_ClaPlantarif;
				v_trasa:='En imprime archivo...';
               Utl_file.put_line(puntero,v_fila);
  END LOOP;
  Utl_file.fclose(puntero);
  dbms_output.put_line('Termino ok  '||v_cuenta);
exception
  when others then
     dbms_output.put_line('Error general abonado:'||v_cliente||' Trasa:='||v_trasa);
     dbms_output.put_line(sqlerrm);
END CO_BAJAS_CELULAR;
/
SHOW ERRORS
