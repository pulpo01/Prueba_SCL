CREATE OR REPLACE TRIGGER fa_trg_afupdconcepto
AFTER UPDATE
OF IND_ACTIVO
ON FA_CONCEPTOS
FOR EACH ROW

DECLARE
Begin
    if :new.ind_activo = 1 then
       delete fa_noactivo where cod_concepto = :new.cod_concepto;
    end if;
  exception
    when no_data_found then
         null;
End fa_trg_afupdconcepto;
/
SHOW ERRORS
