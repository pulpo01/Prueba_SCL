variable Fecha_Inicio       varchar2(8);
variable Fecha_Termino      varchar2(8);
variable Concepto_Carrier   number;
begin
:Concepto_Carrier   :=4;
:Fecha_Inicio       :='&1';
:Fecha_Termino      :='&2';
end;
/
set pause off;
set lines 120;
set pages 66;
set underline '=';
set verify on;
DEFINE TITULO_REPORTE = 'INFORME FACTURACION CARRIER ';
DEFINE NOMBRE_REPORTE = 'FACILIDAD COBRANZAS';
column today new_value _date ;
column hora  new_value _time ;
break on today;
break on hora;
select to_char(sysdate,'dd/mm/yyyy') today from dual; 
select to_char(sysdate,'HH24:MI:SS') hora from dual; 
ttitle left "TELEFONICA MOVIL " center titulo_reporte right 'Pag.  :   ' format 999,999 sql.pno skip 1 - 
left nombre_reporte center center  sql.user  right  'Fecha : '_date skip 1 -
right                         'Hora  :   ' _time skip 1 -
center 'Recaudaciones Periordo desde ' &1  ' al ' &2  skip 3;

clear breaks;
break on report;

/* Formato de salida */
set underline '=';
set recsepchar '=';
column MONTO_CARRIER format $999,999,999,999,999;
compute sum LABEL 'TOTAL' of MONTO_CARRIER on report;

set timing on;
spool &3;
SELECT  /*+ INDEX ( AK_CO_PAGOS_FEC_EFECTIVIDAD CO_PAGOS) */
        A.DES_CONCEPTO                      OPERADOR_CARRIER    ,
        COUNT(DISTINCT B.NUM_FOLIOCTC)      NUMERO_FACTURAS     ,
        SUM(B.IMP_CONCEPTO)                 MONTO_CARRIER       
FROM    CO_CONCEPTOS   A    ,
        CO_PAGOSCONC   B    ,
        CO_PAGOS       C    
WHERE   C.FEC_EFECTIVIDAD >= TO_DATE(:Fecha_Inicio ,'DDMMYYYY')
AND     C.FEC_EFECTIVIDAD <  TO_DATE(:Fecha_Termino,'DDMMYYYY')
AND     C.COD_TIPDOCUM      != 20
AND     C.NUM_SECUENCI        =  B.NUM_SECUENCI        
AND     C.COD_TIPDOCUM        =  B.COD_TIPDOCUM        
AND     C.COD_VENDEDOR_AGENTE =  B.COD_VENDEDOR_AGENTE 
AND     C.COD_CENTREMI        =  B.COD_CENTREMI        
AND     B.COD_CONCEPTO        =  A.COD_CONCEPTO
AND     A.COD_TIPCONCE        = :Concepto_Carrier
GROUP BY 
        A.DES_CONCEPTO;
exit;
