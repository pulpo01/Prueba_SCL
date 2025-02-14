CREATE OR REPLACE PACKAGE BODY        ca_pac_alarmas IS
  --
  -- Retrofitted
  PROCEDURE ca_p_alarmas(
  v_tipincidencia IN number )
  IS
   v_maximo   ca_ctlalarmas.num_maximo%type;
   v_dias     ca_ctlalarmas.num_dias%type;
   v_mensaje  ca_ctlalarmas.des_mensaje%type;
   v_acumulado ca_acumalarmas.num_acumulado%type;
   v_error     char(1) := '0';
  begin
    ca_pac_alarmas.ca_p_ctlalarmas (v_tipincidencia,v_maximo,v_dias,v_mensaje,
                                 v_error);
    if v_error = '0' then
       v_acumulado := 0;
       ca_pac_alarmas.ca_p_existe_acumalarmas (v_tipincidencia,v_acumulado
  ,v_error);
       v_acumulado := v_acumulado + 1;
       if v_error = '0' then
          ca_pac_alarmas.ca_p_update_acumalarmas(v_tipincidencia,v_acumulado);
       else
          ca_pac_alarmas.ca_p_insert_acumalarmas(v_tipincidencia,v_dias);
       end if;
       if v_maximo < v_acumulado then
          ca_pac_alarmas.ca_p_insert_alarmas (v_tipincidencia,v_mensaje);
       end if;
    end if;
  end;
  --
  -- Retrofitted
  PROCEDURE ca_p_ctlalarmas(
  v_tipincidencia IN number ,
  v_maximo IN OUT number ,
  v_dias IN OUT number ,
  v_mensaje IN OUT char ,
  v_error IN OUT char )
  IS
  begin
       select num_maximo,num_dias,des_mensaje into v_maximo,v_dias,v_mensaje
     from ca_ctlalarmas
     where tip_incidencia = v_tipincidencia;
       v_error := '0';
  exception
    when no_data_found then
      v_error := '1';
  end;
  --
  -- Retrofitted
  PROCEDURE ca_p_existe_acumalarmas(
  v_tipincidencia IN number ,
  v_acumulado IN OUT number ,
  v_error IN OUT char )
  IS
  begin
    select num_acumulado into v_acumulado
       from ca_acumalarmas
       where tip_incidencia = v_tipincidencia and
       trunc(sysdate) between fec_primera and fec_ultima;
       v_error := '0';
  exception
    when no_data_found then
      v_error := '1';
      v_acumulado := 0;
  end;
  --
  -- Retrofitted
  PROCEDURE ca_p_insert_acumalarmas(
  v_tipincidencia IN number ,
  v_dias IN number )
  IS
  begin
    insert into ca_acumalarmas (tip_incidencia,fec_primera,fec_ultima,
        num_acumulado)
              values (v_tipincidencia,trunc(sysdate),trunc(sysdate) + v_dias
  , 1);
  exception
    when others then
            raise_application_error (-20710,'<CA_ACUMALARMAS> - ' || SQLERRM);
  end;
  --
  -- Retrofitted
  PROCEDURE ca_p_insert_alarmas(
  v_tipincidencia IN number ,
  v_mensaje IN char )
  IS
   v_alarma   ca_alarmas_tinci.num_alarma%type;
  begin
    select ca_seq_alarma.nextval into v_alarma from dual;
    insert into ca_alarmas_tinci (num_alarma,des_mensaje)
              values (v_alarma,v_mensaje);
  exception
    when others then
            raise_application_error (-20711,'<CA_ALARMAS> - ' || SQLERRM);
  end;
  --
  -- Retrofitted
  PROCEDURE ca_p_update_acumalarmas(
  v_tipincidencia IN number ,
  v_acumulado IN number )
  IS
  begin
    update ca_acumalarmas set num_acumulado = v_acumulado
       where tip_incidencia = v_tipincidencia and
       trunc(sysdate) between fec_primera and fec_ultima;
  exception
    when others then
            raise_application_error (-20709,'<CA_ACUMALARMAS - ' || SQLERRM);
  end;
END ca_pac_alarmas;
/
SHOW ERRORS
