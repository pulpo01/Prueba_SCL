CREATE OR REPLACE TRIGGER SISCEL.AL_BEIN_COMPSERIES
BEFORE INSERT
ON SISCEL.AL_COMPSERIES
FOR EACH ROW

DECLARE
   v_num_serie  al_compseries.num_serie%type;
   v_nom_form   al_compseries.nom_form%type;
BEGIN
   v_num_serie := :new.num_serie;
   v_nom_form  := :new.nom_form;
   p_al_compseries(v_num_serie,v_nom_form);
END;
/
SHOW ERRORS
