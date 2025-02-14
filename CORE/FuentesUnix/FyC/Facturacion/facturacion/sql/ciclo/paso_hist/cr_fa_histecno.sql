set echo off verify off
prompt Creando tabla  FA_HISTECNO_TH_&1
spool $WORKDIR/tab_fa_histecno_th_&1.log
create table siscel.fa_histecno_th_&1 
storage(initial 10M next 3M pctincrease 0)
tablespace FACTURACION_CICLOS_HTAB
as select * from fa_factecno_to_&1
/
spool off
exit;

