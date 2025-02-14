Set feedback off;
set pause off;
set lines 130;
set pages 66;
set underline '=';

/* PARAMETROS */

variable NUM_SECUENCI 		number;
variable COD_TIPDOCUM 		number;
variable COD_CICLFACT 		number;
variable COD_VENDEDOR_AGENTE 	number;
variable COD_CICLFACT		number;
variable IND_ANULADA 		number;
variable IND_PASOCOBRO		number;
variable NUM_FOLIO 		number;

execute :NUM_SECUENCI :=0;
execute :COD_VENDEDOR_AGENTE :=0;
execute :IND_ANULADA :=0;	
execute :IND_PASOCOBRO :=1;	
execute :NUM_FOLIO 	:=0;

/* ENCABEZADO DEL REPORTE */

DEFINE TITULO_REPORTE = 'MOVIMIENTOS DE FACTURACION - PENDIENTES O POSTERIORES A PASA COBRO';
DEFINE NOMBRE_REPORTE = 'Facturacion';
column today         new_value _date ;
column hora          new_value _time ;

break on today;
break on hora;
select to_char(sysdate,'dd/mm/yyyy') today from dual; 
select to_char(sysdate,'HH24:MI:SS') hora from dual; 
ttitle left "TELEFONICA MOVIL " center titulo_reporte right 'Pag.  :   ' format 999,999 sql.pno skip 1 - 
left nombre_reporte center center  sql.user  right  'Fecha : '_date skip 1 -
right                         'Hora  :   ' _time skip 1 -
center &1 skip 2; 

clear breaks;

 
/* ENCABEZADO Y FORMATOS DE COLUMNAS */

column registros format 999,999,999;
column facturado format $999,999,999,999.00;
column documento format A28 truncated; 
column estado    format A12 truncated; 
column proceso   format A6 truncated; 
column cod       format 99 ;
column ciclo     format 99999999;
column cobro     format 99;
column INTERFAZ  format a9;

set timing on;
set termout off;

/* ASIGNACION DE ARCHIVO */

spool &1;

SELECT  B.COD_TIPDOCUM                          COD ,
        B.DES_TIPDOCUM                          DOCUMENTO ,
        E.DES_ESTADOC                           ESTADO,
        DECODE(C.COD_ESTPROC, 0, 'Ingresada', 1, 'Ingresada', 2, 'Error', 3, 'Ok', 'Error')  PROCESO,
        A.COD_CICLFACT                          CICLO,
        DECODE(C.NUM_PROCESO,NULL,'NO','SI')    INTERFAZ,
        A.IND_PASOCOBRO                         COBRO,
        COUNT(A.NUM_PROCESO)                    REGISTROS,
        SUM(A.TOT_FACTURA)                      FACTURADO
FROM    GE_TIPDOCUMEN       B,
        FA_INTESTADOC       E,
        FA_INTERFACT        C,
        FA_FACTDOCU_NOCICLO A
WHERE   A.NUM_PROCESO       = C.NUM_PROCESO(+)
AND     A.COD_TIPDOCUM      =  B.COD_TIPDOCUM (+)
AND     C.COD_ESTADOC = E.COD_ESTADOC
AND    (    C.COD_ESTADOC < 500
        OR  (C.COD_ESTADOC = 500 AND C.COD_ESTPROC < 3)
        OR  C.COD_ESTADOC > 600
        OR  (C.COD_ESTADOC = 600 AND C.COD_ESTPROC = 3)
        OR  C.COD_ESTADOC IS NULL)
GROUP BY B.COD_TIPDOCUM,
        B.DES_TIPDOCUM,
        E.DES_ESTADOC,
        DECODE(C.COD_ESTPROC, 0, 'Ingresada', 1, 'Ingresada', 2, 'Error', 3, 'Ok', 'Error'),
        A.COD_CICLFACT,
        DECODE(C.NUM_PROCESO,NULL,'NO','SI'),
        A.IND_PASOCOBRO;

exit;



