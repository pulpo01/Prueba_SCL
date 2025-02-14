set time on feedback off
--
prompt Desmarca Facturas  -8
--
update  fa_factdocu_nociclo
set     ind_pasocobro = 0
where   num_secuenci > 0
and     cod_tipdocum = 1
and     num_folio > 0
and     ind_pasocobro = -8;
commit;                     
--
prompt Desmarca Facturas  -3
--
update  fa_factdocu_nociclo
set     ind_pasocobro = 0
where   num_secuenci > 0
and     cod_tipdocum = 1
and     num_folio > 0
and     ind_pasocobro = -3;
commit;                     
--
prompt Desmarca Facturas  -5
--
update  fa_factdocu_nociclo
set     ind_pasocobro = 0
where   num_secuenci > 0
and     cod_tipdocum = 1
and     num_folio > 0
and     ind_pasocobro = -5;
commit;
--
prompt Crea Tabla Contado_No_Venta
--
drop table contado_no_venta;
--
create table contado_no_venta
pctfree 20 pctused 80
tablespace ITS_TAB
storage ( initial 800 K next 100 K )
as
select	ind_ordentotal,
	num_venta,
	cod_cliente,
	num_transaccion,
	'N' flg_ga_ventas,
	'N' flg_co_carteventa,
	'N' flg_co_pagosconc,
	0 ind_pasocob,
	99 cod_modventa
from	fa_factdocu_nociclo
where	num_secuenci > 0
and	cod_tipdocum = 1
and	cod_vendedor_agente > 0
and	letra = 'I'
and	num_folio > 0
and	ind_pasocobro = 0                   
and ind_supertel = 0;
--
prompt Crea Indice Contado_No_Venta Num_Venta
--
create unique index contado_no_venta_idx1
on contado_no_venta (num_venta)
tablespace ITS_idx;
--
prompt Marca Facturas con Ga_Ventas
--
declare
cursor K is
	select  c.rowid tid,
                g.ind_pasocob,
                g.cod_modventa
        from    ga_ventas g,
                contado_no_venta c
        where   c.num_venta = g.num_venta;
begin
	for L in K loop
		update	contado_no_venta
		set	flg_ga_ventas = 'S',
			ind_pasocob = L.ind_pasocob,
			cod_modventa = L.cod_modventa
		where	rowid = L.tid;
	end loop;
	commit;
end;
/
--
prompt Crea Indice Contado_No_Venta Num_Transaccion,Cod_Cliente
--
create unique index contado_no_venta_idx2
on contado_no_venta (num_transaccion,cod_cliente)
tablespace ITS_idx;
--
prompt Marca Contado_No_Venta con Co_Carteventa
--
declare
cursor K is
	select	c.rowid tid
	from	co_carteventa g ,
	        contado_no_venta c
	where	c.num_transaccion = g.num_transaccion;
begin
	for L in K loop
		update	contado_no_venta
		set	flg_co_carteventa = 'S'
		where	rowid = L.tid;
	end loop;
	commit;
end;
/ 
--
prompt Marca Facturas con Co_pagos Co_PagosConc
--
declare
cursor K is
select  c.rowid tid
from
        co_pagosconc a,
        co_pagos b,
        contado_no_venta c
where   c.num_transaccion = a.num_transaccion
and     b.num_secuenci = a.num_secuenci
and     b.cod_tipdocum = a.cod_tipdocum
and     b.cod_centremi = a.cod_centremi
and     b.cod_vendedor_agente = a.cod_vendedor_agente
and     c.cod_cliente = b.cod_cliente;
begin
	for L in K loop
		update	contado_no_venta
		set	flg_co_pagosconc = 'S'
		where	rowid = L.tid;
	end loop;
	commit;
end;
/
--
prompt Crea PK a Contado_No_Venta
--
alter table contado_no_venta 
add constraint pk_contado_no_venta
primary key (flg_ga_ventas, ind_ordentotal, flg_co_carteventa, flg_co_pagosconc)
using index tablespace ITS_idx;
--
prompt Marca Facturas Sin Ga_Ventas
--
declare 
cursor K is
        select  h.rowid tid
        from    fa_factdocu_nociclo h ,
                contado_no_venta c
        where   c.flg_ga_ventas = 'N'
	and	c.ind_ordentotal = h.ind_ordentotal
	and	h.ind_pasocobro = 0;
begin
        for L in K loop
                update  fa_factdocu_nociclo
                set     ind_pasocobro = -8
                where   rowid = L.tid;
        end loop;
        commit;
end;
/
--
prompt Marca Facturas Con Co_Carteventa y Sin Co_PagosConc
--
declare 
cursor K is
        select  h.rowid tid
        from    fa_factdocu_nociclo h ,
                contado_no_venta c
        where   c.flg_ga_ventas = 'S'
	and	c.ind_ordentotal = h.ind_ordentotal
	and	c.flg_co_carteventa = 'S'
	and	c.flg_co_pagosconc = 'N'
	and	h.ind_pasocobro = 0;
begin
        for L in K loop
                update  fa_factdocu_nociclo
                set     ind_pasocobro = -3
                where   rowid = L.tid;
        end loop;
        commit;
end;
/
--
prompt Marca Facturas Con Con Co_Carteventa y Cod_Modventa != 5
--
declare 
cursor K is
        select  h.rowid tid
        from    fa_factdocu_nociclo h ,
                contado_no_venta c
        where   c.flg_ga_ventas = 'S'
	and	c.ind_ordentotal = h.ind_ordentotal
	and	c.flg_co_carteventa = 'N'
	and	c.ind_pasocob = 1
	and	h.ind_pasocobro = 0
	and	c.cod_modventa != 5;
begin
        for L in K loop
                update  fa_factdocu_nociclo
                set     ind_pasocobro = -5
                where   rowid = L.tid;
        end loop;
        commit;
end;
/
exit;
