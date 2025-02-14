CREATE OR REPLACE TRIGGER TOL_TRG_BEFIN_FRANHORA
BEFORE INSERT ON ta_franhora
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
-- AAF WHEN (NEW.cod_operador = 31809 AND NEW.cod_producto = 1 AND NEW.ind_largadis = 0)
 
WHEN (NEW.cod_producto = 1 AND NEW.ind_largadis = 0)
DECLARE
         query_str      varchar2(1000):='';
-- *************************************************************
-- * procedimiento      : TOL_TRG_BEFIN_FRANHORA
-- * Descripcin        : Inserta Registro en Tabla Tol_horadia
-- * Fecha de creacin  : Dic 2002
-- * Responsable        : vmb
-- *************************************************************
BEGIN

 query_str:='INSERT INTO TOL_HORADIA_TD (cod_tdia,cod_thor, hor_inic,hor_term, fec_ini_vig, fec_ter_vig)';
 query_str:=query_str || ' VALUES (:1,:2,:3,:4,:5,:6)';

 EXECUTE IMMEDIATE query_str USING :NEW.cod_tipdia,:NEW.cod_tipohorario,:NEW.hor_desde,:NEW.hor_hasta,
--  AAF                                  TO_DATE(:NEW.fec_ini_vig,'DD/MM/YYYY'), TO_DATE(:NEW.fec_ter_vig,'DD/MM/YYYY');
                                   :NEW.fec_ini_vig,:NEW.fec_ter_vig;

 EXCEPTION
   WHEN OTHERS THEN
   RAISE_APPLICATION_ERROR(-20999,'ERROR EN EL TRIGGER TOL_TRG_BEFIN_FRANHORA '|| to_char(SQLCODE));

END TOL_TRG_BEFIN_FRANHORA;
/
SHOW ERRORS
