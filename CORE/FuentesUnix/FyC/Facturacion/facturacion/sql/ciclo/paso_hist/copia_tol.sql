-- Programa : copia_tol.sql
-- Author   : SAAM
-- Date     : 07/01/2003
-- Remarks  : Crea la fa_detcelular_<ciclo> a partir de la pf_toltarifica.
-- =======================================================================
set ver off
spool $WORKDIR/copia
create table siscel.fa_detcelular_&1 tablespace FACTURACION_LLAMADAS_HTAB
pctfree 0
pctused 99
storage (initial 200M next 200M pctincrease 0)
as select * from siscel.pf_toltarifica;
spool off
exit;
