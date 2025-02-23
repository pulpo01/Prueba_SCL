-- Programa : indice.sql
-- Author   : ACT
-- Date     : 23/9/99
-- Remarks  : Crea indice para la nueva fa_detcelular del ciclo.
-- =============================================================
set ver off
spool $WORKDIR/indice
create index siscel.ak_fa_detcelular_&1 on siscel.fa_detcelular_&1 
(cod_cliente,num_abon)
pctfree 0 initrans 8 maxtrans 255 
tablespace FACTURACION_LLAMADAS_HIND
storage (initial 100k next 50k pctincrease 0);
spool off
exit;
