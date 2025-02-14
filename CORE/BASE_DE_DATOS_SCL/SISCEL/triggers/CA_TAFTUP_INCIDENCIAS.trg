CREATE OR REPLACE TRIGGER ca_taftup_incidencias
AFTER UPDATE
ON CA_INCIDENCIAS

DECLARE
begin
    ca_pac_historico.ca_p_delete_valincidencias;
    ca_pac_historico.ca_p_delete_incisectores;
    ca_pac_historico.ca_p_delete_incicomentarios;
    ca_pac_historico.ca_p_delete_incidencias;
end;
/
SHOW ERRORS
