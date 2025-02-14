set veri off
update fa_ciclocli
set num_proceso = 0
where cod_ciclo = &1;
commit;
exit;
