set pages 0
set pause off
set veri off
set head off
set linesize 110
set feedback off
set termout on
select cod_cliente, num_abonado from ga_infaccel
where cod_ciclfact = &1
and (ind_cuencontrolada is null or ind_cargopro is null)
group by cod_cliente, num_abonado;
exit;
