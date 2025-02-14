set veri off
set feedback off
update fa_ciclfact
set ind_facturacion = 1
where cod_ciclfact = &1;
commit;
exit;
