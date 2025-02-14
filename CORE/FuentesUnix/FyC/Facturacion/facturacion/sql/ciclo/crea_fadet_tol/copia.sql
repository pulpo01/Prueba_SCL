-- Programa : copia.sql
-- Author   : ACT
-- Date     : 23/9/99
-- Remarks  : Crea la fa_detcelular_<ciclo> a partir de la pf_toltarifica.
-- =======================================================================
set ver off
spool $WORKDIR/copia
create table siscel.fa_detcelular_&1 tablespace FACTURACION_LLAMADAS_HTAB
pctfree 0
pctused 99
storage (initial 250M next 50M pctincrease 0)
as select * from siscel.pf_toltarifica_&1;
spool off
exit;
