set echo off verify off
prompt Creando tabla fa_histconc_&1
spool $WORKDIR/tab_fa_histconc_&1.log
create table siscel.fa_histconc_&1 
storage(initial 80M next 20M pctincrease 0)
tablespace FACTURACION_CICLOS_HTAB
as select * from fa_factconc_&1
/
spool off
exit;

