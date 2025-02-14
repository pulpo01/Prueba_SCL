whenever sqlerror exit sql.sqlcode;
set transaction read only;
set tab off;
set lines 132;
set pages 100;
set pause off;
set timing on;

/* DEFINE NOMBRE DE ARCHIVO DE SALIDA */
define nombre_archivo = "facpretrafic_&1";

/* VARIABLES */

variable COD_CICLFACT 		number;

begin 
:COD_CICLFACT  :=&1;
end;
/
/* ENCABEZADO DEL REPORTE */

DEFINE TITULO_REPORTE = 'INFORME DE TRAFICO PRE-FACTURACION';
DEFINE NOMBRE_REPORTE = 'facpretrafic';
column today         new_value _date ;
column hora          new_value _time ;
column fec_llamadas new_value _fec_llamadas;

break on today;
break on hora;
break on fec_llamadas
select to_char(sysdate,'dd/mm/yyyy') today from dual; 
select to_char(sysdate,'HH24:MI:SS') hora from dual; 
select to_char(max(fec_llamadas),'dd/mm/yyyy') fec_llamadas from ta_estadisticas;
ttitle left "CTC STARTEL " center titulo_reporte right 'Pag.  :   ' format 999,999 sql.pno skip 1 - 
left nombre_reporte center center  sql.user  right  'Fecha : '_date skip 1 -
right                         'Hora  :   ' _time skip 1 -
center "CICLO DE FACTURACION "&1 skip 2 -
center "FECHA DE TASACION REFERENCIAL " _FEC_LLAMADAS skip 2;


clear breaks;

 
/* ENCABEZADO Y FORMATOS DE COLUMNAS */

column Cant format 999999;
column minutos format 9999,999,999;
column imp_consumido    format $9,999,999,999 heading Monto;
column des_concepto format A40 truncated;

/* TOTALIZADORES */

break on cod_ciclfact on report ;
compute sum label 'TOTAL' of imp_consumido minutos on cod_ciclfact report;
 
spool &&nombre_archivo;

        select b.cod_ciclfact,c.cod_concepto cod,nvl(c.des_concepto,'No Existe en Fa_Conceptos ') des_concepto,
	       sum(seg_consumido/60)  minutos,sum(imp_consumido)  imp_consumido
	from ta_acumairefrasoc b, ( select  /*+ index (ga_infaccel PK_GA_INFACCEL) */
			 a.num_abonado,a.cod_cliente
			 from ga_infaccel a , fa_ciclocli b , fa_ciclfact c
			 where c.cod_ciclfact = :COD_CICLFACT
			 and   c.cod_ciclo    = b.cod_ciclo
			 and   b.num_abonado  = a.num_abonado
			 and   b.cod_cliente  = a.cod_cliente
			 and   a.cod_ciclfact = :COD_CICLFACT
			 and   a.ind_factur   = 1
		      )  a, fa_conceptos c , ta_concepfact d
	where  b.num_abonado (+)      = a.num_abonado
	and    b.cod_cliente     = a.cod_cliente
	and    b.cod_ciclfact <= :COD_CICLFACT
	and    b.num_proceso     = 0
	and    b.ind_entsal      = d.ind_entsal
	and    b.cod_franhorasoc = d.cod_tarificacion
	and    d.cod_facturacion = c.cod_concepto
     	group by b.cod_ciclfact,c.cod_concepto,des_concepto
union all
       select /*+  ta_acumoper PK_TA_ACUMOPER */ 
	       b.cod_ciclfact,c.cod_concepto cod,nvl(c.des_concepto,'No Existe en Fa_Conceptos ') des_concepto,
	       sum(seg_consumido/60)  minutos,sum(imp_consumido)  imp_cargo
	from ta_acumoper b , ( select  /*+ index (ga_infaccel PK_GA_INFACCEL) */
			 a.num_abonado,a.cod_cliente
			 from ga_infaccel a , fa_ciclocli b , fa_ciclfact c
			 Where c.cod_ciclfact = :COD_CICLFACT
			 and   c.cod_ciclo    = b.cod_ciclo
			 and   b.num_abonado  = a.num_abonado
			 and   b.cod_cliente  = a.cod_cliente
			 and   a.cod_ciclfact = :COD_CICLFACT
			 and   a.ind_factur   = 1
		      ) a , fa_conceptos c , ta_concepfact d
	where  b.num_abonado (+)  = a.num_abonado
	and    b.cod_cliente  = a.cod_cliente
	and    b.cod_ciclfact <= :COD_CICLFACT
	and    b.num_proceso  = 0
	and    b.cod_operador  = d.cod_tarificacion
	and    d.cod_facturacion = c.cod_concepto
	and    imp_consumido > 0
	group by b.cod_ciclfact,b.cod_operador,c.cod_concepto,des_concepto
union all
       select /*+ index (TA_ACUMROAMING PK_TA_ACUMROAMING) */
	       b.cod_ciclfact,c.cod_concepto cod,nvl(c.des_concepto,'No Existe en Fa_Conceptos ') des_concepto,
	       sum(seg_consumido/60)  minutos,sum(imp_consumido * nvl(e.cambio,1))  imp_cargo
	from ta_acumllamadasroa  b , ( select  /*+ index (ga_infaccel PK_GA_INFACCEL) */
			 a.num_abonado,a.cod_cliente,c.fec_emision
			 from ga_infaccel a , fa_ciclocli b , fa_ciclfact c
			 Where c.cod_ciclfact = :COD_CICLFACT
			 and   c.cod_ciclo    = b.cod_ciclo
			 and   b.num_abonado  = a.num_abonado
			 and   b.cod_cliente  = a.cod_cliente
			 and   a.cod_ciclfact = :COD_CICLFACT
			 and   a.ind_factur   = 1
		      ) a , fa_conceptos c , ta_concepfact d , ge_conversion e
	where  b.num_abonado (+)  = a.num_abonado
	and    b.num_proceso  = 0
        and    b.cod_ciclfact <= :COD_CICLFACT
	and    a.fec_emision between e.fec_desde and e.fec_hasta (+)
	and    e.cod_moneda = '002'
	and    b.cod_operador  = d.cod_tarificacion
	and    d.cod_facturacion = c.cod_concepto
	group by  b.cod_ciclfact,b.cod_operador,c.cod_concepto,des_concepto
union all
        select b.cod_periodo cod_ciclfact,c.cod_concepto cod,nvl(c.des_concepto,'No Existe en Fa_Conceptos ') des_concepto,
	       sum(seg_consumido/60)  minutos,sum(imp_consumido)  imp_consumido
	from fa_acumfortas b , ( select  /*+ index (ga_infaccel PK_GA_INFACCEL) */
			 a.num_abonado,a.cod_cliente
			 from ga_infaccel a , fa_ciclocli b , fa_ciclfact c
			 where c.cod_ciclfact = :COD_CICLFACT
			 and   c.cod_ciclo    = b.cod_ciclo
			 and   b.num_abonado  = a.num_abonado
			 and   b.cod_cliente  = a.cod_cliente
			 and   a.cod_ciclfact = :COD_CICLFACT
			 and   a.ind_factur   = 1
			) a, fa_conceptos c, FA_FACTCARRIERS d
	where  b.num_abonado (+) = a.num_abonado
	and    b.cod_cliente = a.cod_cliente
	and    b.ind_alquiler = 0
	and    b.cod_periodo <= :COD_CICLFACT
	and    b.num_proceso  = 0
	and    b.cod_operador = d.cod_conccarrier
	and    d.COD_CONCFACT = c.cod_concepto 
	and    b.cod_tipconce = 4
	and    b.cod_tipconce = c.COD_TIPCONCE
	group by b.cod_periodo,b.cod_operador,c.cod_concepto,des_concepto;
exit;
