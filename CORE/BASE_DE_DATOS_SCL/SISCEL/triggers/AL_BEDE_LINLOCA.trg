CREATE OR REPLACE TRIGGER SISCEL.AL_BEDE_LINLOCA
BEFORE  DELETE
ON SISCEL.AL_LIN_MOVI_LOCA
FOR EACH ROW

DECLARE
v_cod AL_LIN_MOVI_LOCA%rowtype;
begin
	 v_cod.num_movi :=  :old.num_movi;
 	 v_cod.num_linea :=  :old.num_linea;
     delete al_ser_movi_loca
	 where num_movi = v_cod.num_movi and
	       num_linea =v_cod.num_linea;

end;
/
SHOW ERRORS
