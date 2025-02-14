CREATE OR REPLACE PROCEDURE        ca_p_alarsol
IS
 v_datos           char(1);
 v_num_incidencia ca_incidencias.num_incidencia%type;
 cursor c_incidencias is
                select num_incidencia
                           from ca_incidencias
                           where cod_estado = 'PS'
                           and ind_mosalar = 1
                           and fec_alarma < sysdate;
begin
 open c_incidencias;
    loop
       fetch c_incidencias into v_num_incidencia;
       exit when c_incidencias%notfound;
       insert into ca_alarmas_sol (num_incidencia) values (v_num_incidencia);
       update ca_incidencias
       set ind_mosalar = 0
       where num_incidencia = v_num_incidencia;
    end loop;
 close c_incidencias;
end ca_p_alarsol;
/
SHOW ERRORS
