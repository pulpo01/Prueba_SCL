update fa_conceptos
set ind_activo = 1
where cod_producto in (1, 2, 3)
and ind_activo = 0;
commit;
exit;
