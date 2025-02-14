CREATE OR REPLACE TRIGGER TOL_TRG_BEFUP_FRANHORA
BEFORE UPDATE ON ta_franhora
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
--WHEN (NEW.cod_operador = 31809 AND NEW.cod_producto = 1 AND NEW.ind_largadis = 0)

DECLARE
         query_str      varchar2(1000):='';
-- *************************************************************
-- * procedimiento      : TOL_TRG_BEFUP_FRANHORA
-- * Descripcin        : Inserta en tabla tol_franhora
-- * Fecha de creacin  : Dic 2002
-- * Responsable        : vmb
-- *************************************************************
BEGIN

 query_str:='UPDATE TOL_HORADIA_TD SET cod_tdia =:1,cod_thor =:2,hor_inic =:3, hor_term =:4,';
 query_str:= query_str || ' fec_ini_vig = :5, fec_ter_vig = :6 ';
 query_str:= query_str || ' WHERE cod_tdia = :7 ';
 query_str:= query_str || ' AND   cod_thor = :8 ';
 query_str:= query_str || ' AND   hor_inic = :9 ';
 query_str:= query_str || ' AND   hor_term = :10 ';
 query_str:= query_str || ' AND   fec_ini_vig = :11 ';
 query_str:= query_str || ' AND   fec_ter_vig = :12 ';

 EXECUTE IMMEDIATE query_str USING :NEW.cod_tipdia,:NEW.cod_tipohorario,
                                   :NEW.hor_desde,:NEW.hor_hasta,:NEW.fec_ini_vig, :NEW.fec_ter_vig,
                                                                   :OLD.cod_tipdia,:OLD.cod_tipohorario,:OLD.hor_desde,:OLD.hor_hasta,
                                                                   :OLD.fec_ini_vig, :OLD.fec_ter_vig;

 EXCEPTION
   WHEN OTHERS THEN
   RAISE_APPLICATION_ERROR(-20999,'ERROR EN EL TRIGGER TOL_TRG_BEFIN_FRANHORA '|| to_char(SQLCODE));
   NULL;
END TOL_TRG_BEFUP_FRANHORA;
/
SHOW ERRORS
