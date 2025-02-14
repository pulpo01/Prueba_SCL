CREATE OR REPLACE PROCEDURE P_AL_INTERFAZ_RECEPCION IS
    cursor compras is
    select sum(can_orden * a.cambio * ( b.prc_unidad + nvl(b.prc_ff,0) + nvl(b.prc_adic,0))) cantidad,
                   b.cod_grpconcepto grupo_articulo,
                   c.num_orden_ref orden_ref,
                   c.cod_proveedor proveedor,
                   c.num_orden orden_ing,
                   sum(can_orden) can_ing,
                   f.cod_operadora_scl operadora,
                   h.cod_plaza  cod_plaza
      from al_lineas_ordenes2 b,
           al_cabecera_ordenes2 c,
           ge_direcciones g,
           ge_ciudades h,
           al_articulos d,
           al_bodegas i,
           ge_conversion a,
           al_bodeganodo e,
           ge_operadora_scl f
     where b.cod_causa is null
           and b.cod_articulo = d.cod_articulo
           and c.num_orden = b.num_orden
           and c.cod_bodega = i.cod_bodega
           and c.cod_bodega = e.cod_bodega
           and c.fec_creacion between a.fec_desde and a.fec_hasta
     	   and g.cod_direccion > -1
           and g.cod_region = h.cod_region
           and g.cod_provincia = h.cod_provincia
           and g.cod_ciudad  = h.cod_ciudad
           and d.cod_producto = 1
           and d.ind_equiacc = 'E'
           and i.cod_direccion = g.cod_direccion
           and a.cod_moneda = c.cod_moneda
           and e.cod_bodeganodo = f.cod_bodeganodo
		   and c.cod_estado = 'CE'
     group by c.num_orden_ref, b.cod_grpconcepto, c.cod_proveedor,  c.num_orden,f.cod_operadora_scl, h.cod_plaza
     union
    select  sum(can_orden * (a.cambio * b.prc_unidad) + (a.cambio * nvl(prc_ff,0)) + (a.cambio * nvl(prc_adic,0))) cantidad,
            		b.cod_grpconcepto grupo_articulo,
                    c.num_orden_ref orden_ref,
                    c.cod_proveedor proveedor,
                    c.num_orden,
                    sum(can_orden),
                    f.cod_operadora_scl operadora,
                    h.cod_plaza  cod_plaza
        from al_hlineas_ordenes2 b,
             al_hcabecera_ordenes2 c,
             ge_direcciones g,
             ge_ciudades h,
             al_articulos d,
             al_bodegas i,
             ge_conversion a,
             al_bodeganodo e,
             ge_operadora_scl f
     where b.cod_causa is null
     	   and b.cod_articulo = d.cod_articulo
     	   and c.num_orden = b.num_orden
     	   and c.cod_bodega = i.cod_bodega
     	   and c.cod_bodega = e.cod_bodega
     	   and c.fec_creacion between a.fec_desde and a.fec_hasta
     	   and g.cod_region = h.cod_region
           and g.cod_provincia = h.cod_provincia
           and g.cod_ciudad  = h.cod_ciudad
     	   and d.cod_producto = 1
           and d.ind_equiacc = 'E'
           and i.cod_direccion = g.cod_direccion
           and a.cod_moneda = c.cod_moneda
           and e.cod_bodeganodo = f.cod_bodeganodo
     group by c.num_orden_ref, b.cod_grpconcepto, c.cod_proveedor, c.num_orden,f.cod_operadora_scl, h.cod_plaza;


    cursor compras_ofic is
    select sum(can_orden * a.cambio * ( b.prc_unidad + nvl(b.prc_ff,0) + nvl(b.prc_adic,0))) cantidad,
           		   b.cod_grpconcepto grupo_articulo,
                   c.num_orden_ref orden_ref,
                   c.cod_proveedor proveedor,
                   c.num_orden orden_ing,
                   sum(can_orden) can_ing,
                   f.cod_operadora_scl operadora,
				   c.cod_grpconcepto grupo_bodega
      from  al_lineas_ordenes2 b,
      	    al_cabecera_ordenes2 c,
      	    ge_direcciones g,
            ge_ciudades h,
            al_articulos d,
            al_bodegas i,
            ge_conversion a,
            al_bodeganodo e,
            ge_operadora_scl f
     where  b.cod_causa is null
     	   and b.cod_articulo = d.cod_articulo
     	   and c.num_orden = b.num_orden
     	   and c.cod_bodega = i.cod_bodega
     	   and c.cod_bodega = e.cod_bodega
     	   and c.fec_creacion between a.fec_desde and a.fec_hasta
     	   and g.cod_direccion > -1
           and g.cod_region = h.cod_region
           and g.cod_provincia = h.cod_provincia
           and g.cod_ciudad  = h.cod_ciudad
           and d.cod_producto = 1
           and d.ind_equiacc = 'E'
           and i.cod_direccion = g.cod_direccion
           and a.cod_moneda = c.cod_moneda
           and e.cod_bodeganodo = f.cod_bodeganodo
		   and c.cod_estado = 'CE'
     group by c.num_orden_ref, b.cod_grpconcepto, c.cod_proveedor,  c.num_orden,f.cod_operadora_scl,c.cod_grpconcepto
     union
    select  sum(can_orden * (a.cambio * b.prc_unidad) + (a.cambio * nvl(prc_ff,0)) + (a.cambio * nvl(prc_adic,0))) cantidad,
			        b.cod_grpconcepto grupo_articulo,
                    c.num_orden_ref orden_ref,
                    c.cod_proveedor proveedor,
                    c.num_orden,
                    sum(can_orden),
                    f.cod_operadora_scl operadora,
					c.cod_grpconcepto grupo_bodega
        from  al_hlineas_ordenes2 b,
            al_hcabecera_ordenes2 c,
            ge_direcciones g,
            ge_ciudades h,
            al_articulos d,
            al_bodegas i,
            ge_conversion a,
            al_bodeganodo e,
            ge_operadora_scl f
     where b.cod_causa is null
           and b.cod_articulo = d.cod_articulo
           and c.num_orden = b.num_orden
           and c.cod_bodega = i.cod_bodega
           and c.cod_bodega = e.cod_bodega
           and c.fec_creacion between a.fec_desde and a.fec_hasta
           and g.cod_region = h.cod_region
           and g.cod_provincia = h.cod_provincia
           and g.cod_ciudad  = h.cod_ciudad
           and d.ind_equiacc = 'E'
           and d.cod_producto = 1
           and i.cod_direccion = g.cod_direccion
           and a.cod_moneda = c.cod_moneda
           and e.cod_bodeganodo = f.cod_bodeganodo
     group by c.num_orden_ref, b.cod_grpconcepto, c.cod_proveedor, c.num_orden,f.cod_operadora_scl,c.cod_grpconcepto;
         -- fin cursor
	 cursor compras_Tecno is
    select sum(can_orden * a.cambio * ( b.prc_unidad + nvl(b.prc_ff,0) + nvl(b.prc_adic,0))) cantidad,
           b.cod_grpconcepto grupo_articulo,
                   c.num_orden_ref orden_ref,
                   c.cod_proveedor proveedor,
                   c.num_orden orden_ing,
                   sum(can_orden) can_ing,
                   f.cod_operadora_scl operadora,
				   g.cod_tecnologia cod_tecnologia
      from  ge_direcciones g,
            ge_ciudades h,
            al_bodegas i,
            ge_conversion a,
            al_lineas_ordenes2 b,
            al_cabecera_ordenes2 c,
            al_articulos d,
            al_bodeganodo e,
            ge_operadora_scl f,
			al_tecnoarticulo_td g
     where  g.cod_direccion > -1
           and d.cod_producto = 1
           and d.ind_equiacc = 'E'
           and b.cod_causa is null
           and c.num_orden     = b.num_orden
           and b.cod_articulo  = d.cod_articulo
           and c.cod_bodega    = i.cod_bodega
           and i.cod_direccion = g.cod_direccion
           and g.cod_region = h.cod_region
           and g.cod_provincia = h.cod_provincia
           and g.cod_ciudad  = h.cod_ciudad
           and c.cod_bodega = e.cod_bodega
           and e.cod_bodeganodo = f.cod_bodeganodo
           and a.cod_moneda = c.cod_moneda
		   and d.cod_articulo = g.cod_articulo
		   and g.ind_defecto = 1
           and c.fec_creacion between a.fec_desde and a.fec_hasta
		   and c.cod_estado = 'CE'
     group by c.num_orden_ref, b.cod_grpconcepto, c.cod_proveedor,  c.num_orden,f.cod_operadora_scl,g.cod_tecnologia
     union
    select  sum(can_orden * (a.cambio * b.prc_unidad) + (a.cambio * nvl(prc_ff,0)) + (a.cambio * nvl(prc_adic,0))) cantidad,
            b.cod_grpconcepto grupo_articulo,
                    c.num_orden_ref orden_ref,
                    c.cod_proveedor proveedor,
                    c.num_orden,
                    sum(can_orden),
                    f.cod_operadora_scl operadora,
					g.cod_tecnologia cod_tecnologia
     from  ge_direcciones g,
            ge_ciudades h,
            al_bodegas i,
            ge_conversion a,
            al_hlineas_ordenes2 b,
            al_hcabecera_ordenes2 c,
            al_articulos d,
            al_bodeganodo e,
            ge_operadora_scl f,
			al_tecnoarticulo_td g
     where d.cod_producto = 1
           and d.ind_equiacc = 'E'
           and b.cod_causa is null
           and c.num_orden = b.num_orden
           and b.cod_articulo = d.cod_articulo
           and a.cod_moneda = c.cod_moneda
           and c.cod_bodega    = i.cod_bodega
           and i.cod_direccion = g.cod_direccion
           and g.cod_region = h.cod_region
           and g.cod_provincia = h.cod_provincia
           and g.cod_ciudad  = h.cod_ciudad
           and c.cod_bodega = e.cod_bodega
           and e.cod_bodeganodo = f.cod_bodeganodo
           and a.cod_moneda = c.cod_moneda
		   and d.cod_articulo = g.cod_articulo
		   and g.ind_defecto =1
           and c.fec_creacion between a.fec_desde and a.fec_hasta
     group by c.num_orden_ref, b.cod_grpconcepto, c.cod_proveedor, c.num_orden,f.cod_operadora_scl,g.cod_tecnologia;
         -- fin cursor
cursor compras_Oficina_Tecno is
    select sum(can_orden * a.cambio * ( b.prc_unidad + nvl(b.prc_ff,0) + nvl(b.prc_adic,0))) cantidad,
           b.cod_grpconcepto grupo_articulo,
                   c.num_orden_ref orden_ref,
                   c.cod_proveedor proveedor,
                   c.num_orden orden_ing,
                   sum(can_orden) can_ing,
                   f.cod_operadora_scl operadora,
				   c.cod_grpconcepto grupo_bodega,
				   g.cod_tecnologia cod_tecnologia
      from  ge_direcciones g,
            ge_ciudades h,
            al_bodegas i,
            ge_conversion a,
            al_lineas_ordenes2 b,
            al_cabecera_ordenes2 c,
            al_articulos d,
            al_bodeganodo e,
            ge_operadora_scl f,
			al_tecnoarticulo_td g
     where  g.cod_direccion > -1
           and d.cod_producto = 1
           and d.ind_equiacc = 'E'
           and b.cod_causa is null
           and c.num_orden     = b.num_orden
           and b.cod_articulo  = d.cod_articulo
           and c.cod_bodega    = i.cod_bodega
           and i.cod_direccion = g.cod_direccion
           and g.cod_region = h.cod_region
           and g.cod_provincia = h.cod_provincia
           and g.cod_ciudad  = h.cod_ciudad
           and c.cod_bodega = e.cod_bodega
           and e.cod_bodeganodo = f.cod_bodeganodo
           and a.cod_moneda = c.cod_moneda
		   and d.cod_articulo = g.cod_articulo
		   and g.ind_defecto  =1
           and c.fec_creacion between a.fec_desde and a.fec_hasta
		   and c.cod_estado = 'CE'
     group by c.num_orden_ref, b.cod_grpconcepto, c.cod_proveedor,  c.num_orden,f.cod_operadora_scl,c.cod_grpconcepto, g.cod_tecnologia
     union
    select  sum(can_orden * (a.cambio * b.prc_unidad) + (a.cambio * nvl(prc_ff,0)) + (a.cambio * nvl(prc_adic,0))) cantidad,
            b.cod_grpconcepto grupo_articulo,
                    c.num_orden_ref orden_ref,
                    c.cod_proveedor proveedor,
                    c.num_orden,
                    sum(can_orden),
                    f.cod_operadora_scl operadora,
					c.cod_grpconcepto grupo_bodega,
					g.cod_tecnologia cod_tecnologia
        from  ge_direcciones g,
            ge_ciudades h,
            al_bodegas i,
            ge_conversion a,
            al_hlineas_ordenes2 b,
            al_hcabecera_ordenes2 c,
            al_articulos d,
            al_bodeganodo e,
            ge_operadora_scl f,
			al_tecnoarticulo_td g
     where d.cod_producto = 1
           and d.ind_equiacc = 'E'
           and b.cod_causa is null
           and c.num_orden = b.num_orden
           and b.cod_articulo = d.cod_articulo
           and a.cod_moneda = c.cod_moneda
           and c.cod_bodega    = i.cod_bodega
           and i.cod_direccion = g.cod_direccion
           and g.cod_region = h.cod_region
           and g.cod_provincia = h.cod_provincia
           and g.cod_ciudad  = h.cod_ciudad
           and c.cod_bodega = e.cod_bodega
           and e.cod_bodeganodo = f.cod_bodeganodo
           and a.cod_moneda = c.cod_moneda
		   and d.cod_articulo = g.cod_articulo
		   and g.ind_defecto = 1
           and c.fec_creacion between a.fec_desde and a.fec_hasta
     group by c.num_orden_ref, b.cod_grpconcepto, c.cod_proveedor, c.num_orden,f.cod_operadora_scl,c.cod_grpconcepto,g.cod_tecnologia;
         -- fin cursor

   v_id_lote         sc_ent_cab_lote.id_lote%type;
   v_per_contable    sc_ent_cab_lote.per_contable%type;
   v_hay_traspaso    number(4) := 0;
   v_cod_evento      sc_evento.cod_evento%type;
   lote_ingresado    sc_ent_cab_lote%rowtype;
   v_concepto            sc_ent_lote.cod_concepto%type;
   v_operadora       ge_operadora_scl.cod_operadora_scl%type;
   v_operadoratmm    ge_operadora_scl.cod_operadora_scl%type;
   v_vtipoapertura   ged_parametros.val_parametro%type;
   v_aper_tecnologia sc_indapertura_td.aper_tecnologia%type;
   v_aper_oficina    sc_indapertura_td.aper_oficina%type;
--   v_aper_operadora  sc_indapertura_td.aper_operadora%type;
   v_SI char(1) := 'S';
   v_NO char(1) := 'N';
   bRet   boolean:=FALSE;
   v_glosa_error     varchar2(50);

cursor lote_ingresados is
    select * from sc_ent_cab_lote where cod_evento = v_cod_evento;

BEGIN
	v_glosa_error := 'Error al recuperar la operadora : ';
    select ge_fn_operadora_scl
        into v_operadora
        from dual;
    select ge_operadoratmm
        into    v_operadoratmm
        from al_datos_generales;
    v_cod_evento := 18;
	v_glosa_error := 'Error al recuperar la cantidad de traspasos : ';
    select sum(x.canti)
      into v_hay_traspaso
     from
   ( select count(1) canti
      from al_lineas_ordenes2 a,
           al_articulos b
     where a.cod_articulo = b.cod_articulo
       and a.cod_causa is null
       and b.ind_equiacc = 'E'
    union
    select count(1) canti
      from al_hlineas_ordenes2 a,
           al_articulos b
     where a.cod_articulo = b.cod_articulo
       and a.cod_causa is null
       and b.ind_equiacc = 'E' ) x;
	 v_glosa_error := 'Error al recuperar el tipo de apertura : ';
   		  select aper_bodega, aper_tecnologia
		  into v_aper_oficina, v_aper_tecnologia
		  from sc_indapertura_td
		  where cod_modulo = 'AL';
    if v_hay_traspaso > 0 then
           select to_char(sysdate - 1,'yyyymm')
           into v_per_contable from dual;

    IF v_aper_oficina = v_NO and v_aper_tecnologia = v_NO then

    --  SOLO  Apertura por articulo , la original
		for v_compras in compras  loop
                 v_id_lote := to_char(v_compras.orden_ref)||'/'||to_char(v_compras.can_ing)||'/'||v_compras.grupo_articulo||'/'
				 		      ||to_char(v_compras.proveedor)||'/'||to_char(v_compras.orden_ing)||'/';
				 v_glosa_error := 'Error al Insertar en sc_ent_cab_lote : ';
                 insert into sc_ent_cab_lote
                  (cod_evento
                  ,id_lote
                  ,per_contable
                  ,nom_usuario_lote
                  ,fec_lote
                  ,cod_operadora_scl )
                values (v_cod_evento
                  ,v_id_lote
                  ,v_per_contable
                  ,user
                  ,sysdate
                  ,v_compras.operadora);
            v_concepto := SC_CONCEPTOGRP_FN(v_cod_evento,'AL_ARTICULOS',v_compras.grupo_articulo);
			if v_concepto is NULL then
			   v_concepto := 'E'||v_compras.grupo_articulo;
			end if;
			v_glosa_error := 'Error al insertar en sc_ent_lote : ';
            insert into sc_ent_lote
                       (cod_evento
                       ,id_lote
                       ,cod_concepto
                       ,imp_movimiento
					   ,cod_operadora_scl)
                values (v_cod_evento
                       ,v_id_lote
                       ,v_concepto
                       ,decode(v_operadora,v_operadoratmm,v_compras.cantidad,round(v_compras.cantidad))
					   ,v_compras.operadora );
			bRet := true;
       end loop;
	ELSE

		IF v_aper_oficina = v_SI and v_aper_tecnologia = v_SI THEN

		   -- apertura por todo, articulo, bodega, tecnologia
		    		for v_compras in compras_Oficina_Tecno  loop

	                v_id_lote := to_char(v_compras.orden_ref)||'/'||to_char(v_compras.can_ing)||'/'||v_compras.grupo_articulo||'/'
							      ||to_char(v_compras.proveedor)||'/'||to_char(v_compras.orden_ing)||'/'||v_compras.grupo_bodega||'/'||v_compras.cod_tecnologia||'/';

					v_glosa_error := 'Error al Insertar en sc_ent_cab_lote ofia-tecn: ';
                 insert into sc_ent_cab_lote
                  (cod_evento
                  ,id_lote
                  ,per_contable
                  ,nom_usuario_lote
                  ,fec_lote
                  ,cod_operadora_scl )
                values (v_cod_evento
                  ,v_id_lote
                  ,v_per_contable
                  ,user
                  ,sysdate
                  ,v_compras.operadora);

		            v_concepto := SC_CONCEPTOGRP_FN(v_cod_evento,'AL_ARTICULOS',v_compras.grupo_articulo,'AL_BODEGAS',v_compras.grupo_bodega,'AL_TECNOLOGIA',v_compras.cod_tecnologia);
					if v_concepto is NULL then
					   v_concepto := 'E'||v_compras.grupo_articulo;
			end if;
			v_glosa_error := 'Error al insertar en sc_ent_lote : ';
            insert into sc_ent_lote
                       (cod_evento
                       ,id_lote
                       ,cod_concepto
                       ,imp_movimiento
					   ,cod_operadora_scl)
                values (v_cod_evento
                       ,v_id_lote
                       ,v_concepto
                       ,decode(v_operadora,v_operadoratmm,v_compras.cantidad,round(v_compras.cantidad))
					   ,v_compras.operadora );
					bRet := true;
		       		end loop;
		ELSE
			IF v_aper_tecnologia = v_SI THEN
				-- articulo, tecnologia
					for v_compras in compras_Tecno  loop
	                 v_id_lote := to_char(v_compras.orden_ref)||'/'||to_char(v_compras.can_ing)||'/'||v_compras.grupo_articulo||'/'
					 		      ||to_char(v_compras.proveedor)||'/'||to_char(v_compras.orden_ing)||'/'||v_compras.cod_tecnologia||'/';
					 v_glosa_error := 'Error al Insertar en sc_ent_cab_lote apertura tecno: ';
	                 insert into sc_ent_cab_lote
	                  (cod_evento
	                  ,id_lote
	                  ,per_contable
	                  ,nom_usuario_lote
	                  ,fec_lote
	                  ,cod_operadora_scl )
	                values (v_cod_evento
	                  ,v_id_lote
	                  ,v_per_contable
	                  ,user
	                  ,sysdate
	                  ,v_compras.operadora);
		            v_concepto := SC_CONCEPTOGRP_FN(v_cod_evento,'AL_ARTICULOS',v_compras.grupo_articulo,'AL_TECNOLOGIA',v_compras.cod_tecnologia);
					if v_concepto is NULL then
					   v_concepto := 'E'||v_compras.grupo_articulo;
					end if;
				   v_glosa_error := 'Error al insertar en sc_ent_lote : ';
	               insert into sc_ent_lote
	                       (cod_evento
	                       ,id_lote
	                       ,cod_concepto
	                       ,imp_movimiento
						   ,cod_operadora_scl)
	                values (v_cod_evento
	                       ,v_id_lote
	                       ,v_concepto
	                       ,decode(v_operadora,v_operadoratmm,v_compras.cantidad,round(v_compras.cantidad))
						   ,v_compras.operadora );
					bRet := true;
		       		end loop;
			ELSE
				-- articulo, oficina
				for v_compras in compras_ofic  loop
                   v_id_lote := to_char(v_compras.orden_ref)||'/'||to_char(v_compras.can_ing)||'/'||v_compras.grupo_articulo||'/'
				 		      ||to_char(v_compras.proveedor)||'/'||to_char(v_compras.orden_ing)||'/'||v_compras.grupo_bodega||'/';
				   v_glosa_error := 'Error al Insertar en sc_ent_cab_lote : ';
                   insert into sc_ent_cab_lote
                    (cod_evento
                    ,id_lote
                    ,per_contable
                    ,nom_usuario_lote
                    ,fec_lote
                    ,cod_operadora_scl )
                  values (v_cod_evento
                    ,v_id_lote
                    ,v_per_contable
                    ,user
                    ,sysdate
                    ,v_compras.operadora);
		            v_concepto := SC_CONCEPTOGRP_FN(v_cod_evento,'AL_ARTICULOS',v_compras.grupo_articulo,'AL_BODEGAS',v_compras.grupo_bodega);
					if v_concepto is NULL then
					   v_concepto := 'E'||v_compras.grupo_articulo;
					end if;
					v_glosa_error := 'Error al insertar en sc_ent_lote : ';
		            insert into sc_ent_lote
		                       (cod_evento
		                       ,id_lote
		                       ,cod_concepto
		                       ,imp_movimiento
							   ,cod_operadora_scl)
		                values (v_cod_evento
		                       ,v_id_lote
		                       ,v_concepto
		                       ,decode(v_operadora,v_operadoratmm,v_compras.cantidad,round(v_compras.cantidad))
							   ,v_compras.operadora );
					bRet := true;
				end loop;
			END IF;
		END IF;
	END IF;

	if bRet then
	    --
		update al_lineas_ordenes2
		set cod_causa = 1
		where cod_causa is null;
		--
		update al_hlineas_ordenes2
		set cod_causa = 1
		where cod_causa is null;
		--
	end if;
       Commit;
	    v_glosa_error := 'Error en la funcion SC_P_INGRESA_LOTE : ';
        for lote_ingresado in lote_ingresados loop
                 SC_P_INGRESA_LOTE(to_char(v_cod_evento),lote_ingresado.id_lote,lote_ingresado.cod_operadora_scl);
        end loop;
     end if;

    EXCEPTION
		 WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR (-20100,v_glosa_error || TO_CHAR(SQLCODE) ||' ' || SQLERRM);
END P_AL_INTERFAZ_RECEPCION;
/
SHOW ERRORS
