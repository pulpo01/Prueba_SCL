CREATE OR REPLACE TRIGGER ca_taftup_cobros
AFTER UPDATE
ON CO_INCIDENCIAS
FOR EACH ROW

DECLARE
        v_nom_usu co_incidencias.usu_solucion%type;
        v_ind_comu ca_tipincidencias.ind_comunica%type;
        v_comunica number(1) := 1;
        v_estado varchar2(2);
  begin
  if :new.usu_solucion is not null then
    -- Recupera el tipo de incidencia (comunica o no comunica)
    select b.ind_comunica
    into v_ind_comu
    from Ca_incidencias a, ca_tipincidencias b
    where a.num_incidencia = :new.num_incidencia
    and b.tip_incidencia = a.tip_incidencia;
    if v_ind_comu = v_comunica then
       -- El tipo de incidencia es del tipo 'Comunica el SAC'
       v_estado := 'PC';
    else
       v_estado := 'CE';
    end if;
    -- Modifica la tabla ca incidencias
    update Ca_incidencias
    set usu_solucion = :new.usu_solucion,
        fec_real = sysdate, cod_estado = v_estado
    where num_incidencia = :new.num_incidencia;
--    commit;
    -- Elimina el registro de CO_INCIDENCIAS
--    delete co_incidencias
--    where num_incidencia = :new.num_incidencia;
  end if;
end;
/
SHOW ERRORS
