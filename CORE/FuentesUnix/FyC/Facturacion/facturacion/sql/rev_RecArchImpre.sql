--Recupera Archivos de Impresion por Ciclo y Tipo de Impresion
--  1 Facturas/Boletas
--  2 Detalle Pago/Resumen Consumo
--  3 Detalle de Llamadas
-----------------------------------------------------------------
set pages 0
set pause off
set veri off
set head off
set linesize 350
set feedback off
set termout on
set colsep "|"
--
select  c.nom_archivo
from    fad_ctlimpres c, 
	    fad_ctlinfheader a, 
        fad_ctlinfoparam b 
where b.cod_tipinforme = 4
and   a.cod_informe    = b.cod_informe
and   a.num_secuinfo   = &1
and   a.ind_activo	   = 1
and   a.cod_ciclfact   = &2
and   a.cod_informe    = c.cod_informe
and   a.num_secuinfo   = c.num_secuinfo
and   c.cod_tipimpres  = &3;
--
exit;
