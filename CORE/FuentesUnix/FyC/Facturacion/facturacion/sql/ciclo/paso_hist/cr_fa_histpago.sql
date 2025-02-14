set echo off verify off

prompt Creando tabla  fa_histpago_&1

spool $WORKDIR/tab_fa_histpago_&1.log
create table siscel.fa_histpago_&1 
storage (initial 10M next 3M pctincrease 0)
tablespace FACTURACION_CICLOS_HTAB
as select * from co_ultpago_tt where cod_ciclfact = &1
/
spool off
exit;

