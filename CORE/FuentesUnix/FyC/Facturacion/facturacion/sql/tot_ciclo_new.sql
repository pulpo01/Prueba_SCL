set feedback off;
set pause off;
set lines 80;
set pages 66;
set underline '=';

/* PARAMETROS */

variable NUM_SECUENCI       number;
variable COD_TIPDOCUM       number;
variable COD_CICLFACT       number;
variable COD_VENDEDOR_AGENTE    number;
variable COD_CICLFACT       number;
variable IND_ANULADA        number;
variable IND_PASOCOBRO      number;
variable NUM_FOLIO      number;

execute :NUM_SECUENCI :=0;
execute :COD_VENDEDOR_AGENTE :=0;
execute :IND_ANULADA :=0;   
execute :IND_PASOCOBRO :=1; 
execute :NUM_FOLIO  :=0;

/* ENCABEZADO DEL REPORTE */

DEFINE TITULO_REPORTE = 'MOVIMIENTO DE FACTURACION';
DEFINE NOMBRE_REPORTE = 'Facturacion';
column today         new_value _date ;
column hora          new_value _time ;

break on today;
break on hora;
select to_char(sysdate,'dd/mm/yyyy') today from dual; 
select to_char(sysdate,'HH24:MI:SS') hora from dual; 
ttitle left "CTC STARTEL " center titulo_reporte right 'Pag.  :   ' format 999,999 sql.pno skip 1 - 
left nombre_reporte center center  sql.user  right  'Fecha : '_date skip 1 -
right                         'Hora  :   ' _time skip 1 -
center &1 skip 2; 

clear breaks;

 
/* ENCABEZADO Y FORMATOS DE COLUMNAS */

column registros format 999,999,999;
column facturado format $999,999,999,999.00;
column documento format A28 truncated; 
column cod       format 99 ;
column ciclo     format 999999;
column cobro     format 99;

set timing on;
set termout off;

/* ASIGNACION DE ARCHIVO */

spool &1;

SELECT  B.COD_TIPDOCUM  COD ,
        B.DES_TIPDOCUM  DOCUMENTO ,
        COD_CICLFACT    CICLO,
        IND_PASOCOBRO   COBRO, 
        COUNT(*)        REGISTROS,
        SUM(A.TOT_FACTURA)   FACTURADO
FROM    FA_FACTDOCU_&2  A, 
        GE_TIPDOCUMEN B
WHERE   NUM_SECUENCI        > :NUM_SECUENCI
AND     A.COD_TIPDOCUM      =  B.COD_TIPDOCUM (+) 
AND     COD_VENDEDOR_AGENTE > :COD_VENDEDOR_AGENTE
AND     IND_ANULADA         = :IND_ANULADA
AND     IND_PASOCOBRO       != :IND_PASOCOBRO
AND     NUM_FOLIO           > :NUM_FOLIO
GROUP BY B.COD_TIPDOCUM,B.DES_TIPDOCUM,COD_CICLFACT,IND_PASOCOBRO;

exit;
