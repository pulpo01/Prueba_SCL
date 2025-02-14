set pages 0
set pause off
set veri off
set head off
set linesize 110
set feedback off
set termout off
spool ../tmp/conceptos_no_activos.txt
select cod_concepto, '|', substr(des_concepto, 1, 50), '|',
       decode(cod_tipconce, 2, 'Descuento', 3, 'Cargo'), '|',
       decode(cod_producto, 1, 'Celular', 2, 'Beeper', 3, 'Trunking'), '|',
       cod_modulo
from fa_conceptos
where cod_producto in (1, 2, 3)
and ind_activo = 0
order by cod_producto, cod_modulo, cod_tipconce;
spool off;
exit;
