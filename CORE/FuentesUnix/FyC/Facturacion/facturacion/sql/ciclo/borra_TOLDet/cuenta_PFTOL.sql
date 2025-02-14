-- Programa : cuenta_PFTOL.sql
-- Author   : Carlos Ortiz H.
-- Date     : 11/05/2007
-- Remarks  : Cuenta los registros existentes en la tabla 
--			  PF_TOLTARIFICA_%ciclo
--            que han sido procesados por el ciclo dado.
-- Params   : &1 --> Ciclo de Facturacion
--            &2 --> Modulo de cliente.
-- ==================================================================
set ver off;
set feedback off;
set echo off;
set pagesize 0;
--
spool $WORKDIR/cuenta_PFTOL.dat;
--
select lpad(to_char(count(1)),8,'0') from PF_TOLTARIFICA_&1  where COD_CICLFACT=&1 and substr(NUM_CLIE,length(NUM_CLIE),1) = &2 ; 
--
spool off;
exit;
