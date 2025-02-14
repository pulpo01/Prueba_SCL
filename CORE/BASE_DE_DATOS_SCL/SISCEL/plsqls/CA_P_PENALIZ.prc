CREATE OR REPLACE PROCEDURE        ca_p_penaliz(
  v_tip_inter IN number ,
  v_cod_inter IN number ,
  v_tip_incid IN number )
IS
    tip_cliente number(1) := 2;
    tip_celular number(1) := 3;
    tip_beeper number(1) := 4;
    tip_trek number(1) := 5;
    tip_trunk number(1) := 6;
    v_aux number(3) := 0;
    v_calcliente varchar2(2);
    v_codciclo number(2);
    v_valido number(1) := 0;
    v_prod_general number(1);
    v_prod_cel number(1);
    v_prod_beep number(1);
    v_prod_trek number(1);
    v_prod_trunk number(1);
    v_producto number(1);
    v_acumulado number(3);
    v_num_max number(3);
    v_dias number(3);
    v_num_penaliz ca_penalizaciones.num_penaliz%type;
    v_cod_cliente ge_clientes.cod_cliente%type;
    v_cod_moneda ca_incmaximas.cod_moneda%type;
    v_importe ca_incmaximas.importe%type;
    v_concepto ca_incmaximas.cod_concepto%type;
    v_num_abonado ga_abocel.num_abonado%type;
    v_tip_error number(2) := 0;
BEGIN
       if v_tip_inter in (2,3,4,5,6) then
          v_tip_error := 1;
          Select prod_general,prod_celular,prod_beeper,prod_trek,prod_trunk
          Into v_prod_general,v_prod_cel,v_prod_beep,v_prod_trek,v_prod_trunk
          From Ge_DatosGener;
          v_tip_error := 2;
          select tip_incidencia
          into v_aux
          from ca_incmaximas
          where tip_incidencia = v_tip_incid;
          -- Recuperamos el codigo de cliente, calidad y ciclo de facturacion
          if v_tip_inter = tip_cliente then
            v_producto := v_prod_general;
            v_num_abonado := null;
            -- Interlocutor (Cliente) (No lleva ciclo de facturacion)
            v_tip_error := 3;
            select cod_calclien
            into v_calcliente
            from ge_clientes
            where cod_cliente = v_cod_inter;
            v_cod_cliente := v_cod_inter;
          elsif v_tip_inter = tip_celular then
            v_producto := v_prod_cel;
            -- Interlocutor (Celular)
            v_tip_error := 4;
            select b.cod_calclien, a.cod_ciclo, b.cod_cliente
            into v_calcliente, v_codciclo, v_cod_cliente
            from ga_abocel a, ge_clientes b
            where a.num_celular = v_cod_inter
            and b.cod_cliente = a.cod_cliente;
          elsif v_tip_inter = tip_beeper then
            v_producto := v_prod_beep;
            -- Interlocutor (Beeper)
            v_tip_error := 5;
            select b.cod_calclien, a.cod_ciclo, b.cod_cliente
            into v_calcliente, v_codciclo, v_cod_cliente
            from ga_abobeep a, ge_clientes b
            where a.num_beeper = v_cod_inter
            and b.cod_cliente = a.cod_cliente;
          elsif v_tip_inter =  tip_trek then
            v_producto := v_prod_trek;
            -- Interlocutor (Trek)
            v_tip_error := 6;
            select b.cod_calclien, a.cod_ciclo, b.cod_cliente
            into v_calcliente, v_codciclo, v_cod_cliente
            from ga_abotrek a, ge_clientes b
            where a.num_man = v_cod_inter
            and b.cod_cliente = a.cod_cliente;
          elsif v_tip_inter = tip_trunk then
            v_producto := v_prod_trunk;
            -- Interlocutor (Trunking)
            v_tip_error := 7;
            select b.cod_calclien, a.cod_ciclo, b.cod_cliente
            into v_calcliente, v_codciclo, v_cod_cliente
            from ga_abotrunk a, ge_clientes b
            where a.num_radio = v_cod_inter
            and b.cod_cliente = a.cod_cliente;
          end if;
          v_tip_error := 8;
          select tip_incidencia,num_maximo,num_dias,
                 cod_moneda,importe,cod_concepto
          into v_aux,v_num_max,v_dias,v_cod_moneda,v_importe,v_concepto
          from ca_incmaximas
          where tip_incidencia = v_tip_incid
          and cod_calclien = v_calcliente;
          -- Existe una penalizacion definida
          v_tip_error := 9;
          update ca_acumpenales
          set num_acumulado = num_acumulado + 1
          where tip_inter = v_tip_inter
          and cod_producto = v_producto
          and cod_interlocutor = v_cod_inter;
          if SQL%NOTFOUND then
             v_tip_error := 10;
             v_acumulado := 1;
             Insert Into Ca_AcumPenales
               (tip_inter,cod_producto,cod_interlocutor,tip_incidencia,
                fec_primera,fec_ultima,num_acumulado)
             Values
               (v_tip_inter,v_producto,v_cod_inter,v_tip_incid,
               trunc(sysdate),trunc(sysdate) + v_dias,v_acumulado);
          end if;
          -- Recupera el num_acumulado de ca_acumpenales
          v_tip_error := 8;
          Select num_acumulado
          Into v_acumulado
          From Ca_AcumPenales
          Where tip_inter = v_tip_inter
          And cod_interlocutor = v_cod_inter
          And tip_incidencia = v_tip_incid
          And trunc(sysdate) between fec_primera And fec_ultima;
          if v_acumulado > v_num_max then
             -- Se genera penalizacion
             v_tip_error := 9;
             select ca_seq_penaliz.nextval into v_num_penaliz from dual;
             insert into ca_penalizaciones
             (num_penaliz, cod_cliente,tip_incidencia,fec_efectividad,
              cod_moneda,imp_penaliz,cod_concepto,cod_producto,
              cod_ciclfact,num_abonado)
             values
             (v_num_penaliz, v_cod_cliente,v_tip_incid,sysdate,
              v_cod_moneda,v_importe,v_concepto, v_producto,
              v_codciclo, v_num_abonado);
             -- Modifica FA_FACTCLI
             v_tip_error := 10;
             update fa_factcli
             set ind_penaliza = 1,
                 fec_ultpenaliza = sysdate
             where cod_cliente = v_cod_cliente;
             if SQL%NOTFOUND then
                v_tip_error := 11;
                insert into fa_factcli
                (cod_cliente,ind_penaliza,ind_pagare,ind_cargos,
                             fec_ultpagare,fec_ultpenaliza,fec_ultcargos)
                values
                (v_cod_cliente,1,0,0,sysdate,sysdate,sysdate);
             end if;
          end if;
       end if;
EXCEPTION
  when no_data_found then
     -- No se encontraron datos
     if v_tip_error = 1 then
      raise_application_error (-20705,'Error leyendo GE_DATOSGENER'||SQLERRM);
     elsif v_tip_error = 2 then
       null;
     elsif v_tip_error = 3 then
      raise_application_error (-20705,'Error leyendo GE_CLIENTES'||SQLERRM);
     elsif v_tip_error = 4 then
      raise_application_error (-20705,'Error leyendo GA_ABOCEL'||SQLERRM);
     elsif v_tip_error = 5 then
      raise_application_error (-20705,'Error leyendo GA_ABOBEEP'||SQLERRM);
     elsif v_tip_error = 6 then
      raise_application_error (-20705,'Error leyendo GA_ABOTREK'||SQLERRM);
     elsif v_tip_error = 7 then
      raise_application_error (-20705,'Error leyendo GA_ABOTRUNK'||SQLERRM);
     elsif v_tip_error = 8 then
       null;
     elsif v_tip_error = 9 then
      raise_application_error (-20705,'Error modif. CA_ACUMPENAL'||SQLERRM);
     elsif v_tip_error = 10 then
      raise_application_error (-20705,'Error modif. FA_FACTCLI'||SQLERRM);
     elsif v_tip_error = 11 then
      raise_application_error (-20705,'Error insert. FA_FACTCLI'||SQLERRM);
     end if;
end ca_p_penaliz;
/
SHOW ERRORS
