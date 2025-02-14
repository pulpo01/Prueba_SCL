CREATE OR REPLACE PROCEDURE P_AL_INTERFAZ_OBSOLESCENCIA IS
    CURSOR obsoles (fecha date)  is
    select b.cod_grpconcepto cod_grpconcepto
         , sum(round(a.pmp_obs))  vobsol
      from al_pmp_mercaderia a, al_articulos b
     where a.fec_ejercicio = fecha
       and a.pmp_obs > 0
       and a.pct_obs < 100
       and a.cod_articulo = b.cod_articulo
       and b.cod_producto = 1
       and b.ind_equiacc = 'E'
	   group by b.cod_grpconcepto;

    CURSOR obsoles_tecn (fecha date)  is
     select c.cod_tecnologia cod_tecnologia,
	 		b.cod_grpconcepto,
            sum(round(a.pmp_obs))  vobsol
      from al_pmp_mercaderia a, al_articulos b, al_tecnoarticulo_td c
     where a.fec_ejercicio = fecha
       and a.pmp_obs > 0
       and a.pct_obs < 100
       and b.cod_producto = 1
       and b.ind_equiacc = 'E'
	   and c.ind_defecto = 1
	   and a.cod_articulo = b.cod_articulo
	   and b.cod_articulo = c.cod_articulo

	   group by c.cod_tecnologia, b.cod_grpconcepto;

	   v_fec_inicio      al_cierres_alma.fec_inicio%type;
	   v_cod_operadora	 al_cierres_alma.cod_operadora_scl%type;
	   v_id_lote         sc_ent_cab_lote.id_lote%type;
	   v_per_contable    sc_ent_cab_lote.per_contable%type;
	   v_cod_evento      sc_evento.cod_evento%type;
	   v_concepto		 sc_ent_lote.cod_concepto%type;
   	   v_aper_tecnologia sc_indapertura_td.aper_tecnologia%type;
	   v_tecnologia		 ged_parametros.VAL_PARAMETRO%type;
	   v_glosa VARCHAR2(100);

BEGIN
	  v_glosa:='ERROR AL RECUPERAR TECNOLOGIA';
	  SELECT aper_tecnologia
	  INTO v_aper_tecnologia
	  FROM sc_indapertura_td
	  WHERE cod_modulo = 'AL';

    	v_id_lote := 'AL20-'||to_char(sysdate,'yymmdd');
		v_cod_evento := 20;

	    select to_char(add_months(sysdate,-1),'yyyymm')
	    into v_per_contable
	    from dual;

		v_glosa:='ERROR AL RECUPERAR FECHA INICIO';
	    select fec_inicio,COD_OPERADORA_SCL
	    into v_fec_inicio,v_cod_operadora
	    from al_cierres_alma
	    where ind_cerrado = 0;
	    if v_aper_tecnologia = 'N' then
	 	   v_glosa:='ERROR AL INSERTAR EN LA TABLA SC_ENT_CAB_LOTE';
		   insert into sc_ent_cab_lote
	                  (cod_evento
	                  ,id_lote
	                  ,per_contable
	                  ,nom_usuario_lote
	                  ,fec_lote
					  ,COD_OPERADORA_SCL)
	           values (v_cod_evento
	                  ,v_id_lote
	                  ,v_per_contable
	                  ,user
	                  ,sysdate
					  ,v_cod_operadora);
			v_glosa:='ERROR AL INSERTAR EN LA TABLA SC_ENT_LOTE';
	       for v_obsoles in obsoles (v_fec_inicio) loop
		   	   v_concepto := SC_CONCEPTOGRP_FN(v_cod_evento,'AL_ARTICULOS',v_obsoles.cod_grpconcepto);
	           insert into sc_ent_lote
	                       (cod_evento
	                       ,id_lote
	                       ,cod_concepto
	                       ,imp_movimiento
						   ,COD_OPERADORA_SCL)
	                values (v_cod_evento
	                       ,v_id_lote
	                       ,v_concepto
	                       ,v_obsoles.vobsol
						   ,v_cod_operadora);
	       end loop;
	       Commit;
		   v_glosa:='ERROR EN LA FUNCION SC_P_INGRESA_LOTE';
	       SC_P_INGRESA_LOTE(to_char(v_cod_evento),v_id_lote,v_cod_operadora);
	   else
			   v_glosa:='ERROR AL RECUPERAR VALOR TECNOLOGIA';
	  		   select val_parametro
			   into v_tecnologia
			   from ged_parametros
			   where nom_parametro = 'ID_LOTE_TECNO'
			   and cod_modulo = 'AL'
			   and cod_producto = 1;

			   v_id_lote := 'AL20-'|| v_tecnologia || '-' || to_char(sysdate,'yymmdd');
		 v_glosa:='ERROR AL INSERTAR EN LA TABLA SC_ENT_CAB_LOTE';
	     insert into sc_ent_cab_lote
                 (cod_evento
                  ,id_lote
                  ,per_contable
                  ,nom_usuario_lote
                  ,fec_lote
				  ,COD_OPERADORA_SCL)
           values (v_cod_evento
                  ,v_id_lote
                  ,v_per_contable
                  ,user
                  ,sysdate
				  ,v_cod_operadora);
			v_glosa:='ERROR AL INSERTAR EN LA TABLA SC_ENT_LOTE';

	       for v_obsoles_tecn in obsoles_tecn (v_fec_inicio) loop
		   	   v_concepto := SC_CONCEPTOGRP_FN(v_cod_evento,'AL_ARTICULOS',v_obsoles_tecn.cod_grpconcepto,'AL_TECNOLOGIA',v_obsoles_tecn.cod_tecnologia);
	           insert into sc_ent_lote
	                       (cod_evento
	                       ,id_lote
	                       ,cod_concepto
	                       ,imp_movimiento
						   ,COD_OPERADORA_SCL)
	                values (v_cod_evento
	                       ,v_id_lote
	                       ,v_concepto
	                       ,v_obsoles_tecn.vobsol
						   ,v_cod_operadora);
	       end loop;
	       Commit;
		   v_glosa:='ERROR EN LA FUNCION SC_P_INGRESA_LOTE';
		   SC_P_INGRESA_LOTE(to_char(v_cod_evento),v_id_lote,v_cod_operadora);
	   end if;
          exception
              when no_data_found then
                  raise_application_error (-20167, v_glosa );
              when others then
                  raise_application_error (-20167, v_glosa || to_char(SQLCODE));
END P_AL_INTERFAZ_OBSOLESCENCIA;
/
SHOW ERRORS
