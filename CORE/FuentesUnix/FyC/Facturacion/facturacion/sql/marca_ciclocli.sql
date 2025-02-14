set feed off
set veri off
update fa_ciclocli
set num_proceso = &1
where cod_cliente = &2
and num_abonado = &3
and cod_ciclo = &4
and num_proceso = 0;
commit;
exit;
