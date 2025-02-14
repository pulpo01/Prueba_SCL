CREATE OR REPLACE FUNCTION          "SP_FN_FORMATOFECHA" (sFormatoFecha varchar2) return varchar2 as

gsFormato_sel2    varchar2(15);
begin
  SELECT val_parametro
  INTO  gsFormato_sel2
  FROM ged_parametros
  WHERE nom_parametro = sFormatoFecha and cod_modulo='GE' and  cod_producto=1;

  return gsFormato_sel2;

end;
/
SHOW ERRORS
