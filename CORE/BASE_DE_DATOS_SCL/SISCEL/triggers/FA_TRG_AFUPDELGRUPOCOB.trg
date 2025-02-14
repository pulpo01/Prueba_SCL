CREATE OR REPLACE TRIGGER fa_trg_afupdelgrupocob
AFTER DELETE OR UPDATE
ON FA_GRUPOCOB
FOR EACH ROW

DECLARE
Begin
    Insert Into Fa_HistGrupoCob
          (cod_grupo,cod_producto,cod_concepto,cod_ciclo,tip_cobro,
           fec_desde,fec_hasta,tip_cobroant)
    Values (:old.cod_grupo,:old.cod_producto,:old.cod_concepto,:old.cod_ciclo,
            :old.tip_cobro,:old.fec_desde,:old.fec_hasta,:old.tip_cobroant);
End fa_trg_afupdelgrupocob;
/
SHOW ERRORS
