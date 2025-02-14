set feed off
set veri off
update fa_ciclocli
set ind_mascara = 1
where cod_ciclo = &1
and num_proceso not in (-95, -99)
and ind_mascara = 0;
commit;
exit;
