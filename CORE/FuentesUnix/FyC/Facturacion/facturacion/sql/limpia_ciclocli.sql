set veri off
UPDATE fa_ciclocli a
SET a.num_proceso = -99, a.ind_mascara = 0 
WHERE EXISTS (SELECT 1 FROM ga_abocel b
			  WHERE b.cod_ciclo = &1
			  AND b.fec_baja    < SYSDATE -90
			  AND b.cod_cliente = a.cod_cliente
			  AND b.num_abonado = a.num_abonado)
AND a.cod_ciclo = &1
AND a.cod_producto = 1;

update fa_ciclocli  
SET num_proceso = 0, ind_mascara = 0
WHERE cod_ciclo = &1
AND (cod_cliente, num_abonado, cod_ciclo) IN (SELECT cod_cliente, num_abonado, cod_ciclo
FROM ga_abocel
WHERE cod_ciclo = &1
AND (fec_baja    >= SYSDATE -90
OR 	fec_baja    IS NULL))
and num_proceso<>-99;

update fa_ciclocli a  
SET a.num_proceso = 0, a.ind_mascara = 0
where exists (select 1 from ga_intarcel b
	  		 	where b.cod_ciclo=&1
				and b.cod_cliente=a.cod_cliente
				and (b.fec_hasta > sysdate -90
				or b.fec_hasta>=sysdate)) 
and a.cod_ciclo=&1
and a.num_abonado=0
and a.cod_producto=1
and a.num_proceso<>-99;

/* Clientes traspasados que deben quedar con num_proceso -99 y ind_mascara=0  que se encuentran de baja */
update fa_ciclocli a
SET a.num_proceso = -99, a.ind_mascara = 0 
where exists (select 1 from ga_traspabo b
                    where b.cod_cuentanue<>b.cod_cuentaant
                    and a.num_terminal=b.num_terminal
                    and a.cod_cliente=b.cod_clienant
                    and a.num_abonado=b.num_abonadoant
                    and b.fec_modifica< SYSDATE -90)
and a.cod_ciclo=&1
AND a.cod_producto = 1;

commit;
exit;