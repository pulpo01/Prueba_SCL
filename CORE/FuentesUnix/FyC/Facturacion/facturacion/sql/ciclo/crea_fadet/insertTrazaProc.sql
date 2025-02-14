spool $WORKDIR/insertTrazaProc.log
insert into fa_trazaproc
(cod_ciclfact,cod_proceso,cod_estaproc,fec_inicio,fec_termino,gls_proceso)
values(&1,&2,&3,sysdate,sysdate,'&4')
/
commit
/
spool off
exit;

