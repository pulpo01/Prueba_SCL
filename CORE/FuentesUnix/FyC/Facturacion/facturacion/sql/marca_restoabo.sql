set feed off
set veri off
update fa_ciclocli
set num_proceso = &1
where cod_cliente = &2
and cod_ciclo = &3
and fec_alta <= to_date('&4', 'yyyymmdd')
and num_proceso = 0;
commit;
exit;
