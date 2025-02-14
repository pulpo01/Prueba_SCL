CREATE OR REPLACE TRIGGER SISCEL.AL_BEDE_CABMOVI
BEFORE  DELETE
ON SISCEL.AL_CAB_MOVI_LOCA
FOR EACH ROW

DECLARE
v_cod AL_CAB_MOVI_LOCA%rowtype;
begin
	 v_cod.num_movi :=  :old.num_movi;
     delete al_lin_movi_loca where num_movi = v_cod.num_movi;
---	 pl_al_elimna (v_cod);
end;
/
SHOW ERRORS
