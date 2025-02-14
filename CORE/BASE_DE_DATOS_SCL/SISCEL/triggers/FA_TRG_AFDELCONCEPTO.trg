CREATE OR REPLACE TRIGGER fa_trg_afdelconcepto
AFTER DELETE
ON FA_CONCEPTOS
FOR EACH ROW

DECLARE
Begin
    delete fa_noactivo where cod_concepto = :old.cod_concepto;
  exception
    when no_data_found then
         null;
  End fa_trg_afdelconcepto;
/
SHOW ERRORS
