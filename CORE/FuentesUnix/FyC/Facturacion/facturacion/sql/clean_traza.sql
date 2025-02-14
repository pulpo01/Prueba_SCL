set veri off
set feedback off
delete from fa_trazaproc
where cod_ciclfact = &1
and cod_proceso = &2;
commit;
exit;
