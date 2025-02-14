-- Programa : cuenta_TOLDet.sql
-- Author   : Carlos Ortiz H.
-- Date     : 11/05/2007
-- Remarks  : Cuenta la cantidad de registros de la tabla 
--            TOL_DETFACTURA_0%modulo%
-- Params   : &1 --> Ciclo de Facturacion
--            &2 --> Modulo de cliente.
-- ==================================================================
set ver off;
set feedback off;
set echo off;
set pagesize 0;
--
spool $WORKDIR/cuenta_TOLDet.dat;
--
select lpad(to_char(count(1)),8,'0') from TOL_DETFACTURA_0&2 TOL where (TOL.NUM_CLIE, TOL.NUM_ABON ) IN (SELECT CLI.COD_CLIENTE ,CLI.NUM_ABONADO
FROM FA_CICLOCLI CLI 
WHERE CLI.COD_CLIENTE = TOL.NUM_CLIE 
AND CLI.NUM_ABONADO = TOL.NUM_ABON 
AND CLI.COD_CICLO = &3
AND CLI.NUM_PROCESO > 0
AND CLI.COD_PRODUCTO = 1)
AND TOL.COD_CICLFACT=&1;
--
spool off;
exit;
