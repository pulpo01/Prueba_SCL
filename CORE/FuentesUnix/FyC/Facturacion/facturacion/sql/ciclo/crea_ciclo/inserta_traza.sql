spool $WORKDIR/inserta_traza
insert into fa_trazaproc
(cod_ciclfact,cod_proceso,cod_estaproc,fec_inicio,fec_termino,gls_proceso)
values(&3,2500,&1,sysdate,sysdate,'&2')
/
commit
/
spool off
exit;

