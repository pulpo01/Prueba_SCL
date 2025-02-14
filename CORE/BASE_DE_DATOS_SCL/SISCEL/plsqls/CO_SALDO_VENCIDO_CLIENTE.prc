CREATE OR REPLACE PROCEDURE        CO_SALDO_VENCIDO_CLIENTE(
ind_entrada 	  IN VARCHAR2 ,
cod_entrada 	  IN VARCHAR2 ,
cod_cliente_out   OUT VARCHAR2,
num_folioctc_out  OUT VARCHAR2,
fec_vencimie_out  OUT VARCHAR2,
importe_debe_out  OUT VARCHAR2,
nombre_out		  OUT VARCHAR2,      -- Parametro agregado para rescatar cliente
resul 			  OUT VARCHAR2) is   -- Parametro agregado para controlar errores
cursor C   (ccod_cliente number) is
select num_folioctc,fec_vencimie
from co_cartera
where 1=1
and   cod_cliente = CCOD_CLIENTE
and	  cod_tipdocum not in (
                                        select  TO_NUMBER(COD_VALOR) COD_TIPDOCUM  from co_codigos
                                        where nom_tabla = 'CO_CARTERA'
                                        and    nom_columna='COD_TIPDOCUM'
										)
and   ind_facturado = 1
and   num_folioctc is not null
group by cod_tipdocum,num_folioctc,fec_vencimie
order by fec_vencimie desc;
aux_cod_cliente 	co_cartera.cod_cliente%type;
importe_debe  co_cartera.importe_debe%type;
begin
resul:='OK';
if ind_entrada = '1'
then
	select cod_cliente into aux_cod_cliente from ga_abocel
	where num_celular = to_number(cod_entrada)
	and    fec_baja is null;
else
   aux_cod_cliente :=to_number(cod_entrada);
end if;
--Agregue esta sentencia para rescatar el nombre del perico
-- ya que asi lo requiere redbanc.
BEGIN
   resul:='Recupero Nombre';
   select lpad(nom_cliente ||' '||nom_apeclien1||' '||nom_apeclien2,30,'0')
   into nombre_out
   from ge_clientes
   where cod_cliente=aux_cod_cliente;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
   	    nombre_out:=' ';
	   	WHEN OTHERS THEN
   	    resul := SQLERRM ||': ' || resul;
END;
--
for L in C (aux_cod_cliente)
loop
	   resul:='Rescato Valores';
       select sum(importe_debe-importe_haber)
       into importe_debe_out
       from siscel.co_cartera
       where cod_cliente=aux_cod_cliente
       and	  cod_tipdocum not in (
                                        select  TO_NUMBER(COD_VALOR) COD_TIPDOCUM  from co_codigos
                                        where nom_tabla = 'CO_CARTERA'
                                        and    nom_columna='COD_TIPDOCUM'
										)
and   ind_facturado = 1;
	fec_vencimie_out :=to_char(L.fec_vencimie,'YYYYMMDD');
	importe_debe_out :=lpad(importe_debe_out ,10 ,'0');
	cod_cliente_out  :=lpad(aux_cod_cliente  ,8 ,'0');
	num_folioctc_out :=lpad(L.num_folioctc   ,12,'0');
EXIT;
end loop;
if importe_debe_out is null or
   fec_vencimie_out is null or
   cod_cliente_out  is null or
   num_folioctc_out is null
   then
   resul:='NULL';
else
   resul:='OK';
end if;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
   	    resul:='NULL';
	   	WHEN OTHERS THEN
   	    resul := SQLERRM ||': ' || resul;
end;
/
SHOW ERRORS
