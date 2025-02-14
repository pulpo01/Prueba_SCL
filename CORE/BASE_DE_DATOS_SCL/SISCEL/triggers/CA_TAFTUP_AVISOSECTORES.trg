CREATE OR REPLACE TRIGGER ca_taftup_avisosectores
AFTER UPDATE
ON CA_AVISOSECTORES

DECLARE
begin
   delete ca_avisosectores where
    cod_estado = 'E';
end;
/
SHOW ERRORS
