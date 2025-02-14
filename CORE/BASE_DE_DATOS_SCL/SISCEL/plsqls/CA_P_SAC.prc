CREATE OR REPLACE PROCEDURE        ca_p_sac(
  v_usuario IN char )
IS
 v_datos           char(1);
 v_tipincidencia   ca_incidencias.tip_incidencia%type;
 v_incidencia      ca_incidencias.num_incidencia%type;
 v_tipinter        ca_incidencias.tip_inter%type;
 v_producto        ca_incidencias.cod_producto%type;
 v_interlocutor    ca_incidencias.cod_interlocutor%type;
 cursor c_interface is
  select num_incidencia,tip_datos
      from ca_interface
      where nom_usuario=v_usuario;
begin
 open c_interface;
 loop
   fetch c_interface into v_incidencia,v_datos;
   exit when c_interface%notfound;
   v_incidencia := to_number(v_incidencia);
   if v_datos = 'H' then
     select tip_incidencia,tip_inter,cod_producto,cod_interlocutor
     into v_tipincidencia,v_tipinter,v_producto, v_interlocutor
     from ca_hincidencias
     where num_incidencia = v_incidencia;
   else
     select tip_incidencia,tip_inter,cod_producto,cod_interlocutor
     into v_tipincidencia,v_tipinter,v_producto,v_interlocutor
     from ca_incidencias
     where num_incidencia = v_incidencia;
   end if;
   /* Ejecuta el package que controla las alarmas del S.A.C. */
   ca_pac_alarmas.ca_p_alarmas(v_tipincidencia);
   /* Ejecuta el package que controla las penalizaciones del S.A.C. */
   ca_p_penaliz(v_tipinter,v_interlocutor,v_tipincidencia);
   delete ca_interface where num_incidencia=v_incidencia;
     commit;
  end loop;
  close c_interface;
  ca_p_alarsol;
-- exception
--   when others then
--  raise_application_error(-20708,SQLERRM);
end ca_p_sac;
/
SHOW ERRORS
