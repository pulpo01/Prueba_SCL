CREATE OR REPLACE TRIGGER ca_taftin_cobros
AFTER INSERT
ON CA_INCIDENCIAS
FOR EACH ROW

DECLARE
 v_tipincimoros ca_datosgener.tip_incimoros%type;
        v_tipincilimcred ca_datosgener.tip_incilimcre%type;
        v_prod_celular ge_datosgener.prod_celular%type;
        v_prod_beeper ge_datosgener.prod_beeper%type;
        v_prod_trek ge_datosgener.prod_trek%type;
        v_prod_trunk ge_datosgener.prod_trunk%type;
        v_cod_cliente ge_clientes.cod_cliente%type;
        v_num_abonado number(8);
        v_valido number(1) := 0;
        v_valor number(1);
 v_error number(1) := 0;
  Begin
    Select tip_incimoros, tip_incilimcre
    into v_tipincimoros, v_tipincilimcred
    From ca_datosgener;
    if v_tipincimoros = :new.tip_incidencia then
       v_valido := 1;
       v_valor := 0;
    end if;
    if v_tipincilimcred = :new.tip_incidencia then
       v_valido := 1;
       v_valor := 1;
    end if;
    if v_valido = 1 then
       v_error := 1;
       select prod_celular, prod_beeper, prod_trek, prod_trunk
       into v_prod_celular, v_prod_beeper, v_prod_trek, v_prod_trunk
       from ge_datosgener;
       -- INCIDENCIA POR MOROSIDAD
       -- ========================
       -- Recupera el codigo de cliente
       if :new.cod_producto = v_prod_celular then
          -- Celular --
   v_error := 2;
          select num_abonado, cod_cliente
   into v_num_abonado, v_cod_cliente
          from ga_abocel
          where num_celular = :new.cod_interlocutor;
       elsif :new.cod_producto = v_prod_beeper then
          -- Beeper --
   v_error := 2;
          select num_abonado, cod_cliente
          into v_num_abonado, v_cod_cliente
          from ga_abobeep
          where num_beeper = :new.cod_interlocutor;
       end if;
       if v_cod_cliente is not null and v_num_abonado is not null then
          Insert into co_incidencias
             (tip_suspension,num_incidencia,cod_producto,num_abonado,
              cod_cliente)
          Values
             (v_valor,:new.num_incidencia,:new.cod_producto,
              v_num_abonado, v_cod_cliente);
       end if;
    end if;
  exception
    when no_data_found then
      if v_error = 0 then
  -- No hay datos en ca_datosgener
  null;
      elsif v_error = 1 then
  -- No hay datos en ge_datosgener
         raise_application_error(-20516,'NO EXISTEN DATOS EN GE_DATOSGENER');
      elsif v_error = 2 then
         -- Datos de interlocutor erroneos
  raise_application_error(-20517,
'DETECTADA INCIDENCIA INTERFACE CON COBROS SIN INTERLOCUTOR DEFINIDO');
      end if;
    when others then
         raise_application_error(-20515,'ERROR'||substr(SQLERRM,1,80));
  End;
/
SHOW ERRORS
