set veri off
declare
cursor c1 is
select b.ind_ordentotal orden, b.num_abonado abonado, a.num_beeper numero
from ga_abobeep a, fa_factabobeep b
where (b.ind_ordentotal between &1 and &2)
and b.num_abonado = a.num_abonado
and b.cod_cliente = a.cod_cliente
and b.num_beeper is null ;
begin
   for r in c1 loop
     update fa_factabobeep
     set num_beeper = r.numero
     where ind_ordentotal = r.orden
     and num_abonado = r.abonado
     and num_abonado != 0;
   end loop;
end;
/

declare
cursor c1 is
select b.ind_ordentotal orden, b.num_abonado abonado, a.num_celular numero
from ga_abocel a, fa_factabocelu b
where (b.ind_ordentotal between &1 and &2)
and b.num_abonado = a.num_abonado
and b.cod_cliente = a.cod_cliente
and b.num_celular is null ;
begin
   for r in c1 loop
   update fa_factabocelu
   set num_celular = r.numero
   where ind_ordentotal = r.orden
   and num_abonado = r.abonado
   and num_abonado != 0;
end loop;
end;
/

update fa_factabocelu
set num_celular = 0
where (ind_ordentotal between &1 and &2)
and num_abonado = 0
and num_celular is null
/
commit;
exit;
