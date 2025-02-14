set veri off
set head off
set feed off
select &1, rango_ini, cod_producto, rango_fin, nom_tabla
from fa_rango_tabla
where cod_ciclfact = 130599
/
set veri off
set feed off
delete from fa_rango_tabla
where cod_ciclfact = &1
/
commit
/
set feed on
insert into fa_rango_tabla
select &1, rango_ini, cod_producto, rango_fin, nom_tabla
from fa_rango_tabla
where cod_ciclfact = 130599;
commit;
exit;
