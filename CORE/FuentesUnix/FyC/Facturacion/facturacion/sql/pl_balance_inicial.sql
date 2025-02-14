set serveroutput on size 1000000
declare
	cursor clientes(p_ciclo integer) is select distinct
		cod_cliente     cliente
		from fa_ciclocli
		where cod_cliente > 0
		and cod_ciclo = p_ciclo
		and cod_producto = 1;
	v_ciclo			fa_ciclfact.cod_ciclo%type;
	v_ciclfact		fa_ciclfact.cod_ciclfact%type;
	v_bandera       number(1):=0;
	v_fechasta 		fa_ciclfact.fec_hastaocargos%type;
	v_saldo			fat_balance.imp_documento%type;
	v_clientes_t	number(8):=0;
	v_clientes_ok	number(8):=0;
	v_clientes_err	number(8):=0;
begin
	v_ciclfact := &1;
	begin
		select cod_ciclo, fec_emision
		into v_ciclo, v_fechasta
		from fa_ciclfact 
		where cod_ciclfact = v_ciclfact;
	exception
		when others then
			v_bandera := 1;
			dbms_output.put_line('Error en  select  cod_ciclfact:'||to_char(v_ciclfact));
			dbms_output.put_line('Error :'||sqlerrm);		
	end;
	if v_bandera = 0 then	
		for cc in clientes(v_ciclo) loop
			v_clientes_t := v_clientes_t + 1;
			v_bandera := 0;
			begin
				select nvl(sum(importe_debe - importe_haber),0)
				into v_saldo
				from co_cartera 
				where cod_cliente = cc.cliente
				and fec_efectividad <= v_fechasta;
			exception
				when no_data_found then
					v_saldo := 0;
				when others then
					v_bandera := 1;
					dbms_output.put_line('Error en co_cartera cliente :'||to_char(cc.cliente));
					dbms_output.put_line('Error :'||sqlerrm);		
					v_clientes_err := v_clientes_err + 1;
			end;
			if v_bandera = 0 then
				begin
					insert into fat_balance 
					(cod_cliente,cod_item,cod_tipdocum,cod_ciclfact,can_documento,imp_documento)
					values (cc.cliente,1,2,v_ciclfact,1,v_saldo);
					v_clientes_ok := v_clientes_ok + 1;
				exception
					when others then 
						dbms_output.put_line('Error en fat_balance cliente:'||to_char(cc.cliente));
						dbms_output.put_line('Error :'||sqlerrm);		
						v_clientes_err := v_clientes_err + 1;
				end;
			end if;
			if mod(v_clientes_t,1000) = 0 then
				dbms_output.put_line('Clientes: '||to_char(v_clientes_t));
			end if;
		end loop;
	end if;
	commit;
exception
	when others then
		rollback;
		dbms_output.put_line('Se cayo la caga....');
		dbms_output.put_line('Error :'||sqlerrm);	
end;
/
		