set pages 0
set pause off
set veri off
set head off
set linesize 110
set feedback off
set termout on
select cod_cliente, num_abonado from ga_infacbeep
where cod_ciclfact = &1
and ((ind_cargopro = 0) or (ind_cargopro is null)) 
group by cod_cliente, num_abonado;
exit;
