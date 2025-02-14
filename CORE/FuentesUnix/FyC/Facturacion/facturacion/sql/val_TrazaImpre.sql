--Recupera Estado del Proceso de Impresion 
--  5000 Facturas/Boletas
--  5100 Detalle Pago/Resumen Consumo
--  5200 Detalle de Llamadas
-----------------------------------------------------------------
set pages 0
set pause off
set veri off
set head off
set linesize 350
set feedback off
set termout on
--
select  nvl(a.cod_estaproc,0) 
from    fa_trazaproc    a,
        fa_procfact     b
where   a.cod_proceso(+)    = b.cod_proceso
and     a.cod_ciclfact(+)   = &1
and     b.cod_proceso       = &2;
--
exit;
