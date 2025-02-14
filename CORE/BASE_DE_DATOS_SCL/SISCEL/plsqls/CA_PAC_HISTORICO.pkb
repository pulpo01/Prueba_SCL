CREATE OR REPLACE PACKAGE BODY        ca_pac_historico IS
  --
  -- Retrofitted
  PROCEDURE ca_p_historico_incidencias(
  v_record IN ca_incidencias%rowtype )
  IS
  begin
     ca_p_inserta_hincidencias (v_record);
     ca_p_inserta_hincicomentarios (v_record.num_incidencia);
     ca_p_inserta_hincisectores (v_record.num_incidencia);
     ca_p_inserta_hvalincidencias (v_record.num_incidencia);
  end;
  --
  -- Retrofitted
  PROCEDURE ca_p_inserta_hincidencias(
  v_record IN ca_incidencias%rowtype )
  IS
  begin
     insert into ca_hincidencias (num_incidencia,fec_historico,tip_inter,
    per_contacto,tip_incidencia,ind_urgente,
    num_llamada,usu_creador,fec_creacion,
    fec_estimada,
    cod_estado,cod_interlocutor,fec_real,
    usu_solucion,fec_comunica,usu_comunica)
        values (v_record.num_incidencia,trunc(sysdate),v_record.tip_inter,
       v_record.per_contacto,v_record.tip_incidencia,
       v_record.ind_urgente,v_record.num_llamada,
       v_record.usu_creador,v_record.fec_creacion,
       v_record.fec_estimada, v_record.cod_estado,
       v_record.cod_interlocutor, v_record.fec_real,
       v_record.usu_solucion,v_record.fec_comunica,
       v_record.usu_comunica);
  exception
     when others then
   raise_application_error (-20700,' <CA_HINCIDENCIAS> - ' || SQLERRM);
  end;
  --
  -- Retrofitted
  PROCEDURE ca_p_inserta_hincicomentarios(
  v_incidencia IN number )
  IS
  begin
   insert into ca_hincicomentarios (num_incidencia,fec_historico,
      fec_comentario,comentario,
      usu_comentario,cod_sector)
             select num_incidencia,trunc(sysdate),fec_comentario,comentario,
        usu_comentario,cod_sector
        from ca_incicomentarios
        where num_incidencia = v_incidencia;
  exception
     when others then
    raise_application_error (-20701,' <CA_HINCICOMENTARIOS> - '
    || to_char(v_incidencia) || ' - ' || SQLERRM);
  end;
  --
  -- Retrofitted
  PROCEDURE ca_p_inserta_hincisectores(
  v_incidencia IN number )
  IS
  begin
   insert into ca_hincisectores (num_incidencia,fec_historico,
   fec_derIvacion,
          cod_sector,nom_responsable,usu_receptor,
     cod_estado,fec_salida)
             select num_incidencia,trunc(sysdate),fec_derivacion,cod_sector,
      nom_responsable,usu_receptor,cod_estado,fec_salida
        from ca_incisectores
        where num_incidencia = v_incidencia;
  exception
    when others then
      raise_application_error (-20702,'<CA_HINCISECTORES> - '
    || to_char(v_incidencia) || ' - ' || SQLERRM);
  end;
  --
  -- Retrofitted
  PROCEDURE ca_p_inserta_hvalincidencias(
  v_incidencia IN number )
  IS
  begin
   insert into ca_hvalincidencias (num_incidencia,fec_historico,cod_campo,
       val_alfa,val_numer,val_fecha)
             select num_incidencia,trunc(sysdate),cod_campo,val_alfa,val_numer,
        val_fecha
        from ca_valincidencias
        where num_incidencia = v_incidencia;
  exception
     when others then
    raise_application_error (-20703,'<CA_HVALINCIDENCIAS> - '
    || to_char(v_incidencia) || ' - ' || SQLERRM);
  end;
  --
  -- Retrofitted
  PROCEDURE ca_p_delete_incidencias
  IS
  begin
     delete ca_incidencias
      where cod_estado = 'TH';
  exception
     when others then
    raise_application_error (-20704,'<CA_INCIDENCIAS> - ' || SQLERRM);
  end;
  --
  -- Retrofitted
  PROCEDURE ca_p_delete_incisectores
  IS
  begin
   delete ca_incisectores
       where num_incidencia in
       (select num_incidencia from ca_incidencias
         where cod_estado = 'TH');
  exception
     when others then
   raise_application_error (-20705,'<CA_INCISECTORES> - ' || SQLERRM);
  end;
  --
  -- Retrofitted
  PROCEDURE ca_p_delete_incicomentarios
  IS
  begin
   delete ca_incicomentarios
       where num_incidencia in
       (select num_incidencia from ca_incidencias
         where cod_estado = 'TH');
  exception
     when others then
   raise_application_error (-20706,'<CA_INCICOMENTARIOS> - ' || SQLERRM);
  end;
  --
  -- Retrofitted
  PROCEDURE ca_p_delete_valincidencias
  IS
  begin
     delete ca_valincidencias
      where num_incidencia in
      (select num_incidencia from ca_incidencias
        where cod_estado = 'TH');
  exception
     when others then
   raise_application_error (-20707,'<CA_VALINCIDENCIAS> - ' || SQLERRM);
  end;
END ca_pac_historico;
/
SHOW ERRORS
