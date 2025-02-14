set pages 0
set pause off
set veri off
set head off
set linesize 50
set feedback off
set termout on
select ind_facturacion from fa_ciclfact where cod_ciclfact = &1;
exit;
