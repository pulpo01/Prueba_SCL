set time on feedback off timing on
--
prompt Desmarca Facturas  -2
--
update  fa_factdocu_nociclo
set     ind_pasocobro = 0
where   num_folio > 0
and     ind_pasocobro = -2
;
--
prompt Crea Tabla No_Ge_Clientes
--
drop table no_ge_clientes
;
create table no_ge_clientes
pctfree 20 pctused 80
tablespace ITS_TAB
storage ( initial 900 K next 100 K )
as
select	ind_ordentotal,
	cod_cliente,
	'N' flg_ge_clientes
from	fa_factdocu_nociclo
where	num_folio > 0
and	ind_pasocobro = 0
;
--
prompt Crea Indice No_Ge_Clientes Cod_Cliente
--
create index no_ge_clientes_idx1
on no_ge_clientes (cod_cliente)
tablespace ITS_idx
/
--
prompt Marca No_Ge_Clientes Con Ge_Clientes
--
declare
cursor K is
	select	c.rowid tid
    from	ge_clientes g   ,
            no_ge_clientes c
	where	c.cod_cliente = g.cod_cliente;
begin
	for L in K loop
		update	no_ge_clientes
		set	flg_ge_clientes = 'S'
		where	rowid = L.tid;
	end loop;
	commit;
end;
/
--
prompt Crea Indice a No_Ge_Clientes 
--
create unique index no_ge_clientes_idx2
on no_ge_clientes (flg_ge_clientes, ind_ordentotal)
tablespace ITS_idx
/
--
prompt Marca Facturas Crea desde No_Ge_Clientes 
--
declare 
cursor K is
        select  h.rowid tid
        from    fa_factdocu_nociclo h ,
                no_ge_clientes c
        where   c.flg_ge_clientes = 'N'
	and	c.ind_ordentotal = h.ind_ordentotal;
begin
        for L in K loop
                update  fa_factdocu_nociclo
                set     ind_pasocobro = -2
                where   rowid = L.tid;
        end loop;
        commit;
end;
/
exit;
