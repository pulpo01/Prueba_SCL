spool $WORKDIR/updateTrazaProc.log
update siscel.fa_trazaproc 
set cod_estaproc = 3, fec_termino = sysdate 
where cod_ciclfact = &1 and cod_proceso = &2
/
commit
/
spool off
exit;

