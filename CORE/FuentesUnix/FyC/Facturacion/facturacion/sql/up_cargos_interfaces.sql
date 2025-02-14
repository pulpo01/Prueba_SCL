set veri off
declare
cursor c1 is
select cod_cliente, num_abonado
from ge_cargos
where cod_ciclfact in
      (select cod_ciclfact from fa_ciclfact
       where ind_facturacion in (1,2))
and imp_cargo > 0
and num_factura = 0
and num_transaccion = 0;
begin
   for r in c1 loop
     update ga_infaccel
     set ind_cargos = 1
     where cod_cliente = r.cod_cliente
     and num_abonado = r.num_abonado
     and cod_ciclfact = &1
     and ind_cargos != 1;
   end loop;
   for r in c1 loop
     update ga_infacbeep
     set ind_cargos = 1
     where cod_cliente = r.cod_cliente
     and num_abonado = r.num_abonado
     and cod_ciclfact = &&1
     and ind_cargos != 1;
   end loop;
end;
/

commit;
exit;
