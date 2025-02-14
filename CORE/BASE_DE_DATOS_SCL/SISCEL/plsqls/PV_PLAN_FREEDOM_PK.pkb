CREATE OR REPLACE package body pv_plan_freedom_pk as

function pv_verifica_plan_freedom_fn(p_vcod_cliente in number)
return varchar2
is
    cursor cr_abonados_cliente is
		   select num_abonado, cod_plantarif
		     from ga_abocel
			where cod_cliente = p_vcod_cliente
		   union all
		   select num_abonado, cod_plantarif
		     from ga_aboamist
			where cod_cliente = p_vcod_cliente;
	v_num_abonado   ga_abocel.num_abonado%type;
	v_cod_plantarif ga_abocel.cod_plantarif%type;
	v_ind_proporcs1  ta_plantarif.ind_proporcs%type;
	v_ind_proporcs2  ta_plantarif.ind_proporcs%type;
	v_vrespuesta    varchar2(2);
	v_auxiliar      ta_plantarif.cod_plantarif%type;
begin
    open cr_abonados_cliente;
	loop
        fetch cr_abonados_cliente into
		       v_num_abonado, v_cod_plantarif;
        exit when cr_abonados_cliente%notfound;

		select val_parametro
		  into v_ind_proporcs1
		  from ged_parametros
		 where nom_parametro = 'IND_PROPORCS1'
		   and cod_producto = 1
		   and cod_modulo = 'GA';

		select val_parametro
		  into v_ind_proporcs2
		  from ged_parametros
		 where nom_parametro = 'IND_PROPORCS2'
		   and cod_producto = 1
		   and cod_modulo = 'GA';

		begin
		    select cod_plantarif
			  into v_auxiliar
			  from ta_plantarif
			 where cod_plantarif = v_cod_plantarif
			   and (ind_proporcs = v_ind_proporcs1 or ind_proporcs = v_ind_proporcs2);

			select cod_plantarif
			  into v_auxiliar
			  from ta_planciclo_freedom
			 where cod_plantarif = v_cod_plantarif
			   and cod_producto = 1
			   and sysdate between fec_inicio and nvl(fec_termino,sysdate);

		    v_vrespuesta := 'SI';
			return v_vrespuesta;
		exception
		    when no_data_found then -- no es plan freedom
				 v_vrespuesta := 'NO';
		end;
    end loop;
	return v_vrespuesta;
end pv_verifica_plan_freedom_fn;


function pv_es_plan_freedom_fn(p_vcod_plantarif in varchar)
return varchar2
is
	v_ind_proporcs1  ta_plantarif.ind_proporcs%type;
	v_ind_proporcs2  ta_plantarif.ind_proporcs%type;
	v_vrespuesta    varchar2(2);
	v_auxiliar      ta_plantarif.cod_plantarif%type;
begin
		select val_parametro
		  into v_ind_proporcs1
		  from ged_parametros
		 where nom_parametro = 'IND_PROPORCS1'
		   and cod_producto = 1
		   and cod_modulo = 'GA';

		select val_parametro
		  into v_ind_proporcs2
		  from ged_parametros
		 where nom_parametro = 'IND_PROPORCS2'
		   and cod_producto = 1
		   and cod_modulo = 'GA';

		begin
		    select cod_plantarif
			  into v_auxiliar
			  from ta_plantarif
			 where cod_plantarif = p_vcod_plantarif
			   and (ind_proporcs = v_ind_proporcs1 or ind_proporcs = v_ind_proporcs2);

			select cod_plantarif
			  into v_auxiliar
			  from ta_planciclo_freedom
			 where cod_plantarif = p_vcod_plantarif
			   and cod_producto = 1
			   and sysdate between fec_inicio and nvl(fec_termino,sysdate);

		    v_vrespuesta := 'SI';
			return v_vrespuesta;
		exception
		    when no_data_found then -- no es plan freedom
				 v_vrespuesta := 'NO';
		end;
	return v_vrespuesta;
end pv_es_plan_freedom_fn;



end pv_plan_freedom_pk;
/
SHOW ERRORS
