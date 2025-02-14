CREATE OR REPLACE TRIGGER SISCEL.al_beup_datgen
BEFORE UPDATE
ON SISCEL.AL_DATOS_GENERALES
FOR EACH ROW
 
WHEN (
OLD.COD_ESTADO_RES <> NEW.COD_ESTADO_RES OR       OLD.COD_ESTADO_TEM  <> NEW.COD_ESTADO_TEM OR       OLD.COD_ESTADO_TRA <>  NEW.COD_ESTADO_TRA OR       OLD.COD_ESTADO_RVT <> NEW.COD_ESTADO_RVT  OR       OLD.COD_ESTADO_NTIM <> NEW.COD_ESTADO_NTIM OR  OLD.COD_ESTADO_TIM <> NEW.COD_ESTADO_TIM OR       OLD.COD_USO_DOC <>  NEW.COD_USO_DOC
      )
DECLARE
   v_error number(1) := 0;
   v_estado   al_estados.cod_estado%type;
   v_uso      al_usos.cod_uso%type;
begin
   if :old.cod_estado_res <> :new.cod_estado_res then
      v_estado := :old.cod_estado_res;
   end if;
   if :old.cod_estado_tem <> :new.cod_estado_tem then
      v_estado := :old.cod_estado_tem;
   end if;
   if :old.cod_estado_tra <> :new.cod_estado_tra then
      v_estado := :old.cod_estado_tem;
   end if;
   if :old.cod_estado_rvt <> :new.cod_estado_rvt then
      v_estado := :old.cod_estado_rvt;
   end if;
   if :old.cod_estado_ntim <> :new.cod_estado_ntim then
      v_estado := :old.cod_estado_ntim;
   end if;
   if :old.cod_estado_tim <> :new.cod_estado_tim then
      v_estado := :old.cod_estado_tim;
   end if;
   if :old.cod_estado_res <> :new.cod_estado_res or
      :old.cod_estado_tem <> :new.cod_estado_tem or
      :old.cod_estado_tra <> :new.cod_estado_tra or
      :old.cod_estado_rvt <> :new.cod_estado_rvt or
      :old.cod_estado_ntim <> :new.cod_estado_ntim or
      :old.cod_estado_tim <> :new.cod_estado_tim then
      al_pac_validaciones.p_existe_estado_stock (v_estado,v_error);
      if v_error = 1 then
         raise_application_error (-20175,'');
         v_error := 0;
      end if;
   end if;
   if :old.cod_uso_doc <> :new.cod_uso_doc then
      v_uso := :old.cod_uso_doc;
      al_pac_validaciones.p_existe_uso_stock (v_uso,v_error);
      if v_error = 1 then
         raise_application_error (-20176,'');
         v_error := 0;
      end if;
   end if;
end;
/
SHOW ERRORS
