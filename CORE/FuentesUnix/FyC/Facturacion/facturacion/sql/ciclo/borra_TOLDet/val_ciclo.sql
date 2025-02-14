-- Programa : val_ciclo.sql
-- Author   : Carlos Ortiz H.
-- Date     : 11/05/2007
-- Remarks  : Valida el ciclo ingresado como parametro
-- Params   : &1 --> Ciclo de Facturacion
-- ==================================================================
set ver off;
set feedback off;
set echo off;
set pagesize 0;
--
spool $WORKDIR/val_ciclo.dat;
--
select rpad(to_char(COD_CICLO),8,' ') from FA_CICLFACT where COD_CICLFACT=&1 and IND_FACTURACION=1;
--
spool off;
exit;
