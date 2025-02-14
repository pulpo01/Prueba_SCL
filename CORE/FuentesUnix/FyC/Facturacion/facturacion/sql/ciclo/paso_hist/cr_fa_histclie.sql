set echo off verify off
prompt Creando tabla  fa_histclie_&1
spool $WORKDIR/tab_fa_histclie_&1.log
create table siscel.fa_histclie_&1 
storage (initial 10M next 3M pctincrease 0)
tablespace FACTURACION_CICLOS_HTAB
as select * from fa_factclie_&1
/
spool off
exit;

