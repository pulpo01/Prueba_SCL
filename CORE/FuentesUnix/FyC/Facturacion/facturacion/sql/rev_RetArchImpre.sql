set pages 0
set pause off
set veri off
set head off
set line 300
set feedback off
set termout on
select  
    b.COD_INFORME   ||'|'||
    b.NUM_SECUINFO  ||'|'||
    b.COD_TIPIMPRES ||'|'||
    b.COD_TIPDOCUM  ||'|'||
    b.COD_DESPACHO  ||'|'||
    b.NOM_ARCHIVO   ||'|'||
    b.NUM_CLIENTES  ||'|'||
    b.TOT_FACTURAS  ||'|'||
    b.TOT_CUOTAS    ||'|'||
    b.TOT_PAGAR     ||'|'||
    b.TOT_SALDOANT  ||'|'||
    b.TOT_LOCALES   ||'|'||
    b.TOT_INTERZONA ||'|'||
    b.TOT_ESPECIALES||'|'||
    b.TOT_CARRIER   ||'|'||
    b.TOT_ROAMING   ||'|'||   
    b.COD_ESTADO    ||'|'   
from    
    fad_ctlimpres b, 
    fad_ctlinfheader a
where 
      a.num_secuinfo   = &1
and   a.ind_activo	   = 1
and   a.cod_informe    = '&2'	
and   a.cod_ciclfact   = &3
and   a.cod_informe    = b.cod_informe
and   a.num_secuinfo   = b.num_secuinfo
and   b.cod_tipimpres  = &4;

exit;

