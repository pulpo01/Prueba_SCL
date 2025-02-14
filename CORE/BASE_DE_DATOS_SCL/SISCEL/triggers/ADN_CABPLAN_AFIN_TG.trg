CREATE OR REPLACE TRIGGER SISCEL.ADN_CABPLAN_AFIN_TG
 AFTER INSERT ON SISCEL.ADN_CAB_PLAN_STATUS_TO  FOR EACH ROW
DECLARE
        v_cod_estado  adn_cab_plan_status_to.cod_estado%TYPE;
		v_cod_activacion fa_intqueueproc.cod_activacion%TYPE;
BEGIN
	v_cod_estado := :NEW.cod_estado;
    IF v_cod_estado=0 THEN
	  SELECT cod_activacion
	  INTO  v_cod_activacion
	  FROM fa_intqueueproc
	  WHERE cod_aplic='ADN'
	  AND   cod_modgener='LYP'
	  AND   cod_proceso=100
	  ;
	  IF v_cod_activacion='D' THEN
	    UPDATE fa_intqueueproc
		SET cod_activacion='A',
		    pid_proceso=null,
			fec_estado=sysdate
		WHERE cod_aplic='ADN'
	    AND   cod_modgener='LYP'
	    AND   cod_proceso=100
		;
	  END IF;
	END IF;
END ADN_CABPLAN_AFIN_TG; 
/
SHOW ERRORS
