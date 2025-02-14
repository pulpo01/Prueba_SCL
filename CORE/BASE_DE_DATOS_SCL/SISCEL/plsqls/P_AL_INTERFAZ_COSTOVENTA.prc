CREATE OR REPLACE PROCEDURE P_AL_INTERFAZ_COSTOVENTA IS
    CURSOR costo (fecha date, v_operadora varchar2)  IS
      select b.cod_grpconcepto   cod_grpconcepto,
             sum(a.can_salida * a.prc_pmp) precio,
             a.cod_operadora_scl operadora
      from  al_pmp_mercaderia a,
            al_articulos b,
            ge_direcciones f,
            ge_ciudades g,
            al_bodegas d,
            ge_operadora_scl c
      where  can_salida > 0
           and a.fec_ejercicio = fecha
           and a.cod_articulo = b.cod_articulo
           and b.cod_producto = 1
           and b.ind_equiacc = 'E'
           and a.cod_operadora_scl = v_operadora
           and a.cod_operadora_scl= c.cod_operadora_scl
           and c.cod_bodeganodo =d.cod_bodega
           and d.cod_direccion = f.cod_direccion
           and f.cod_region = g.cod_region
           and f.cod_provincia = g.cod_provincia
           and f.cod_ciudad  = g.cod_ciudad
		   group by a.cod_operadora_scl,b.cod_grpconcepto;

	 CURSOR costo_tecn (fecha date, v_operadora varchar2)  IS
	  select h.cod_tecnologia  cod_tecnologia,
	  		 b.cod_grpconcepto  cod_grpconcepto,
             sum(a.can_salida * a.prc_pmp)       precio,
             a.cod_operadora_scl                 operadora
      from  al_pmp_mercaderia a,
            al_articulos b,
			al_tecnoarticulo_td h,
            ge_direcciones f,
            ge_ciudades g,
            al_bodegas d,
            ge_operadora_scl c
      where  can_salida > 0
           AND a.fec_ejercicio = fecha
           and a.cod_articulo = b.cod_articulo
   	       and b.cod_articulo = h.cod_articulo
		   and h.ind_defecto = 1
           and b.cod_producto = 1
           and b.ind_equiacc = 'E'
           and a.cod_operadora_scl = c.cod_operadora_scl
           and c.cod_bodeganodo    = d.cod_bodega
           and d.cod_direccion     = f.cod_direccion
           and f.cod_region        = g.cod_region
           and f.cod_provincia     = g.cod_provincia
           and f.cod_ciudad        = g.cod_ciudad
		   group by a.cod_operadora_scl,h.cod_tecnologia,b.cod_grpconcepto;

        CURSOR operadoras IS
            select UNIQUE A.COD_OPERADORA_SCL
	        from al_pmp_mercaderia a, al_articulos b
	        where  can_salida > 0
	        and a.cod_articulo = b.cod_articulo
	        and b.cod_producto = 1
	        and b.ind_equiacc = 'E';
	   v_fec_inicio      al_cierres_alma.fec_inicio%type;
	   v_id_lote         sc_ent_cab_lote.id_lote%type;
	   v_per_contable    sc_ent_cab_lote.per_contable%type;
	   v_cod_evento      sc_evento.cod_evento%type;
	   v_operadora       ge_operadora_scl.cod_operadora_scl%type;
	   v_concepto		 sc_ent_lote.cod_concepto%type;
   	   v_aper_tecnologia sc_indapertura_td.aper_tecnologia%type;
	   v_tecnologia		 ged_parametros.VAL_PARAMETRO%type;
	   v_glosa VARCHAR2(100);
BEGIN
	 v_glosa:='ERROR AL RECUPERAR APERTURA';
	  SELECT aper_tecnologia
	  INTO v_aper_tecnologia
	  FROM sc_indapertura_td
	  WHERE cod_modulo = 'AL';

 for cc in operadoras loop
    v_operadora :=cc.cod_operadora_scl;
    v_cod_evento := 19;
     v_id_lote := 'AL19' || '-' ||to_char(sysdate,'yymmdd')||v_operadora;

    select to_char(add_months(sysdate,-1),'yyyymm')
      into v_per_contable
      from dual;

	v_glosa:='ERROR AL RECUPERAR FECHA INICIO CIERRE';
	select fec_inicio
      into v_fec_inicio
      from al_cierres_alma
      where ind_cerrado = 0
      and cod_operadora_scl= v_operadora;

	v_glosa:='ERROR AL INSERTAR SC_ENT_CAB_LOTE';
	if v_aper_tecnologia = 'N' then
		 insert into sc_ent_cab_lote
	                 (cod_evento
	                  ,id_lote
	                  ,per_contable
	                  ,nom_usuario_lote
	                  ,fec_lote
	                  ,cod_operadora_scl)
	           values (v_cod_evento
	                  ,v_id_lote
	                  ,v_per_contable
	                  ,user
	                  ,sysdate
	                  ,v_operadora);

		  for v_costo in costo (v_fec_inicio, v_operadora) loop
		  	  v_glosa:='ERRO AL LLAMAR LA FUNCION SC_CONCEPTOGRP_FN';
		   	   v_concepto := SC_CONCEPTOGRP_FN(v_cod_evento,'AL_ARTICULOS',v_costo.cod_grpconcepto);
	    	   if v_concepto is NULL then
				   v_concepto := 'E'||v_costo.cod_grpconcepto;
				end if;
			   v_glosa:='ERROR AL INSERTAR EN LA TABLA SC_ENT_LOTE';
		       insert into sc_ent_lote
	                       (cod_evento
	                       ,id_lote
	                       ,cod_concepto
	                       ,imp_movimiento
						   ,cod_operadora_scl )
	                values (v_cod_evento
	                       ,v_id_lote
	                       ,v_concepto
	                       ,v_costo.precio
						   ,v_costo.operadora);
	       end loop;

	else
		   	  	v_glosa:='ERROR AL RECUPERAR VALOR TECNOLOGIA';
		  		   select val_parametro
				   into v_tecnologia
				   from ged_parametros
				   where nom_parametro = 'ID_LOTE_TECNO'
				   and cod_modulo = 'AL'
				   and cod_producto = 1;

				   v_id_lote := 'AL19-'|| v_tecnologia || '-' ||to_char(sysdate,'yymmdd')||v_operadora;

			v_glosa:='ERROR AL INSERTAR EN LA TABLA SC_ENT_CAB_LOTE';
		     insert into sc_ent_cab_lote
		                 (cod_evento
		                  ,id_lote
		                  ,per_contable
		                  ,nom_usuario_lote
		                  ,fec_lote
		                  ,cod_operadora_scl)
		           values (v_cod_evento
		                  ,v_id_lote
		                  ,v_per_contable
		                  ,user
		                  ,sysdate
		                  ,v_operadora);

			  for v_costo_tecn in costo_tecn (v_fec_inicio, v_operadora) loop
			  	  v_glosa:='ERRO AL LLAMAR LA FUNCION SC_CONCEPTOGRP_FN';
			   	  v_concepto := SC_CONCEPTOGRP_FN(v_cod_evento,'AL_ARTICULOS',v_costo_tecn.cod_grpconcepto,'AL_TECNOLOGIA',v_costo_tecn.cod_tecnologia);
				  if v_concepto is NULL then
			    	 v_concepto := 'E'||v_costo_tecn.cod_tecnologia;
	       		  end if;
				  v_glosa:='ERROR AL INSERTAR EN LA TABLA SC_ENT_LOTE';
		          insert into sc_ent_lote
		                       (cod_evento
		                       ,id_lote
		                       ,cod_concepto
		                       ,imp_movimiento
				       ,cod_operadora_scl )
		                values (v_cod_evento
		                       ,v_id_lote
		                       ,v_concepto
		                       ,v_costo_tecn.precio
				       ,v_costo_tecn.operadora);
		      end loop;
	end if;
 end loop;
 -- INICIO XO-200509010554
    IF NOT v_operadora IS NULL THEN
       Commit;
       SC_P_INGRESA_LOTE(to_char(v_cod_evento),v_id_lote,v_operadora);
    END IF;
 -- FIN XO-200509010554
          exception
              when no_data_found then
                  raise_application_error (-20167, v_glosa || ' - ' || v_operadora);
              when others then
                  raise_application_error (-20167, v_glosa || ' - ' || to_char(SQLCODE));
END P_AL_INTERFAZ_COSTOVENTA;
/
SHOW ERRORS
