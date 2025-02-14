set transaction read only;
set tab off;
set lines 100;
set pages 100;
set pause off;
/* DEFINE NOMBRE DE ARCHIVO DE SALIDA */
define nombre_archivo = "facprecargos_&1";

/* VARIABLES */

variable COD_CICLFACT 		number;

begin 
:COD_CICLFACT  :=&1;
end;
/
/* ENCABEZADO DEL REPORTE */

DEFINE TITULO_REPORTE = 'INFORME DE CARGOS PRE-FACTURACION';
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
center "CICLO DE FACTURACION "&1 skip 2; 
clear breaks;

 
/* ENCABEZADO Y FORMATOS DE COLUMNAS */

column Unidades format 999999;
column des_concepto format A35 truncated;
column des_producto format A15 truncated;
column imp_cargo    format $999,999,999,999 heading Monto;

/* TOTALIZADORES */

break on des_producto on report;
compute sum label TOTAL of cant imp_cargo on report;

set timing on ;
spool &&nombre_archivo;

select  des_producto,
        cod_concepto,
        des_concepto,
        Cant Unidades,
        imp_cargo
from (
        select  /*  index (ge_cargos AK_GE_CARGOS_CODCLIENTE ) */
	            count(*) Cant ,
	            d.des_producto,
	            b.cod_concepto,
                nvl(c.des_concepto,'No Existe en Fa_Conceptos ') des_concepto,
                b.cod_moneda,
                sum(b.imp_cargo) imp_cargo
	    from    ge_cargos b ,
	            (   select  /* index  (ga_infaccel PK_GA_INFACCEL) */
                            a.cod_cliente,
				            a.num_abonado,
				            a.cod_ciclfact,
				            a.fec_alta,
				            a.fec_baja,
				            a.ind_actuac,
				            c.fec_desdeocargos,
				            c.fec_hastaocargos
                    from    ga_infaccel a , 
                            fa_ciclocli b , 
                            fa_ciclfact c
				    where   c.cod_ciclfact = :COD_CICLFACT
				    and     c.cod_ciclo    = b.cod_ciclo
				    and     b.cod_cliente  = a.cod_cliente
				    and     a.cod_ciclfact = :COD_CICLFACT
				    and     b.num_abonado  = a.num_abonado
				    and     a.ind_actuac   = 1
				            with read only) a,
	            fa_conceptos c,
	            ge_productos d
	    where   a.cod_cliente = b.cod_cliente 
	    and     a.num_abonado = b.num_abonado
	    and     b.cod_concepto= c.cod_concepto (+)
	    and     c.cod_producto = d.cod_producto
	    and     b.imp_cargo   > 0
	    and     b.num_factura = 0
	    and     b.num_transaccion = 0
	    and     b.COD_CICLFACT in (     select cod_ciclfact from fa_ciclfact 
				                        where  (cod_ciclfact = :COD_CICLFACT) or 
				                        (ind_facturacion = 1))
	    -- and   b.fec_alta    between a.fec_desdeocargos and a.fec_hastaocargos
	    group by d.des_producto,b.cod_concepto,c.des_concepto,b.cod_moneda 
    union all
        select  /*  index (ge_cargos AK_GE_CARGOS_CODCLIENTE ) */
	            count(*) Cant ,
	            d.des_producto,
	            b.cod_concepto_dto,
                nvl(c.des_concepto,'No Existe en Fa_Conceptos ') des_concepto,
                b.cod_moneda,
                sum(((IMP_CARGO*VAL_DTO)/100)*-1) imp_cargo
	    from    ge_cargos b , 
	            (   select  /* index  (ga_infaccel PK_GA_INFACCEL) */
				            a.cod_cliente,
				            a.num_abonado,
				            a.cod_ciclfact,
				            a.fec_alta,
				            a.fec_baja,
				            a.ind_actuac,
				            c.fec_desdeocargos,
				            c.fec_hastaocargos
				    from    ga_infaccel a , 
				            fa_ciclocli b , 
				            fa_ciclfact c
				    where   c.cod_ciclfact = :COD_CICLFACT
				    and     c.cod_ciclo    = b.cod_ciclo
				    and     b.cod_cliente  = a.cod_cliente
				    and     a.cod_ciclfact = :COD_CICLFACT
				    and     b.num_abonado  = a.num_abonado
				    and     a.ind_actuac   = 1
				            with read only) a,
                fa_conceptos c,
                ge_productos d
	    where   a.cod_cliente = b.cod_cliente 
	    and     a.num_abonado = b.num_abonado
	    and     b.cod_concepto_dto  is not null
	    and     b.cod_concepto_dto = c.cod_concepto (+)
	    and     c.cod_producto = d.cod_producto
	    and     b.imp_cargo   > 0
	    and     b.num_factura = 0
	    and     b.num_transaccion = 0
	    and     b.COD_CICLFACT in ( select cod_ciclfact from fa_ciclfact 
				                    where  (cod_ciclfact = :COD_CICLFACT) or 
				                    (ind_facturacion = 1))
	    -- and   b.fec_alta    between a.fec_desdeocargos and a.fec_hastaocargos
	    group by d.des_producto,b.cod_concepto_dto,c.des_concepto,b.cod_moneda 
	    with read only)
order by des_producto,cod_concepto;
exit;
