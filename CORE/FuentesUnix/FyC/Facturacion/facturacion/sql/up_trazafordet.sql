set veri off
set feedback off
update fa_trazafordet
set cod_estado = 'FAC'
where cod_ciclfact = &1;
commit;
exit;
