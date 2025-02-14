set serveroutput on size 1000000
set echo on
declare
	cursor ciclos is
		select cod_cliente 	cliente,
			   num_abonado	abonado
	    from fa_ciclocli
	    where cod_ciclo = 24
	    and ind_mascara = 1;

	v_abonado  fa_ciclocli.num_abonado%type;
	v_cliente  fa_ciclocli.cod_cliente%type;
	v_cont_ss  number(8):=0;
	v_cont_ge  number(8):=0;
	v_cont_sa  number(8):=0;
	v_no_ss    number(8):=0;
	v_no_ge    number(8):=0;
	v_no_sa    number(8):=0;
	
begin
	for cc in ciclos loop
		v_abonado := cc.abonado;
		v_cliente := cc.cliente;
		
		begin
			UPDATE GE_CARGOS A
			SET A.NUM_FACTURA = 99
			WHERE A.NUM_ABONADO        = v_abonado
			  AND  A.NUM_FACTURA       = 0
			  AND  A.NUM_TRANSACCION   = 0
         	  AND  A.IMP_CARGO        != 0
         	  AND  A.COD_CICLFACT IN (SELECT B.COD_CICLFACT 
                                 FROM   FA_CICLFACT B
                                 WHERE  B.COD_CICLO = 24
                                 AND B.COD_CICLFACT = A.COD_CICLFACT
                                 AND B.IND_FACTURACION IN (1,2) );  
			v_cont_ge := v_cont_ge + 1;
			dbms_output.put_line('Abonado: '||to_char(v_abonado)||' posee cargos en ge_cargos.');
		exception
			when others then
    			v_no_ge := v_no_ge + 1;
		end;
		begin
			UPDATE GA_SERVSUPLABO A
			SET COD_CONCEPTO = NULL
			WHERE   A.NUM_ABONADO        = v_abonado
			  AND   A.IND_ESTADO IN (1,2,5)
			  AND   A.COD_CONCEPTO != 307
			  AND   A.COD_SERVICIO IN (SELECT B.COD_SERVICIO
			                 FROM GA_TARIFAS B
			                 WHERE A.COD_SERVICIO = B.COD_SERVICIO
			                   AND A.COD_PRODUCTO = B.COD_PRODUCTO
			                   AND B.COD_ACTABO ='FA'); 
			dbms_output.put_line('Abonado: '||to_char(v_abonado)||' posee SERVICIOS SUPLEMENTARIOS.');
			  v_cont_ss := v_cont_ss + 1;
		exception
			when others then
    			v_no_ss := v_no_ss + 1;
		end;
		begin
			UPDATE GA_SERVSUPL SET IND_PRO = 0
			WHERE COD_PRODUCTO = 1
			AND COD_SERVICIO IN (
				SELECT COD_SERVICIO
				FROM GA_SERVSUPLABO A
				WHERE   A.NUM_ABONADO        = v_abonado
				  AND   A.IND_ESTADO IN (1,2,5)
				  AND   A.COD_CONCEPTO = 307
				  AND   A.COD_SERVICIO IN (SELECT B.COD_SERVICIO
				        FROM GA_TARIFAS B
				        WHERE A.COD_SERVICIO = B.COD_SERVICIO
				          AND A.COD_PRODUCTO = B.COD_PRODUCTO
				          AND B.COD_ACTABO ='FA')); 
			dbms_output.put_line('Abonado: '||to_char(v_abonado)||' posee SERVICIOS SUPLEMENTARIOS.');
			  v_cont_sa := v_cont_ss + 1;
		exception
			when others then
    			v_no_sa := v_no_ss + 1;
			
		end;		
	end loop;
	if (v_cont_ss + v_no_ss) = (v_cont_ge + v_no_ge) then
	    dbms_output.put_line('El proceso termino satisfactoriamente.');
	    dbms_output.put_line('Abonados con Cargos :'||to_char(v_cont_ge));
	    dbms_output.put_line('Abonados sin Cargos :'||to_char(v_no_ge));
	    dbms_output.put_line('Abonados con Serv.Supl. (excepto seguro) :'||to_char(v_cont_ss));
	    dbms_output.put_line('Abonados sin Serv.Supl. (excepto seguro) :'||to_char(v_no_ss));
	    dbms_output.put_line('Abonados que modifican ServSupl. (seguro telefono) :'||to_char(v_cont_sa));
	    dbms_output.put_line('Abonados que modifican ServSupl. (seguro telefono) :'||to_char(v_nn_sa));
    else
        dbms_output.put_line('El proceso NO termino satisfactoriamente.');
    end if;
exception
    when others then
        dbms_output.put_line('El proceso se cayo');
        dbms_output.put_line(sqlerrm);
end;
/
