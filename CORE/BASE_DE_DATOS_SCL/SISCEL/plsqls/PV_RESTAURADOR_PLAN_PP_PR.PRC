CREATE OR REPLACE PROCEDURE PV_RESTAURADOR_PLAN_PP_PR(pNumAbonado  IN VARCHAR2,
	   	  		  								   	  vp_NumError OUT NUMBER,
												      vp_MenError OUT VARCHAR2)

IS

  vCelular	        GA_ABOAMIST.NUM_CELULAR%TYPE;
  vPlanAntiguo      VARCHAR2(3);
  vPlanNuevo		VARCHAR2(3);
  vPlanServAnt      VARCHAR2(3);
  vFecCambio		VARCHAR2(20);
  pNumError			NUMBER(9);
  pMenError			VARCHAR2(255);
  pError     		NUMBER(9);
  pMsgError  		VARCHAR2(255);
  v_Formato_Sel19    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  v_Formato_Sel7    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  ERROR_PROCESO     EXCEPTION;

BEGIN

	 v_Formato_Sel19 := GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL19');
	 v_Formato_Sel7 := GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL7');


	 SELECT to_char(sysdate,v_Formato_Sel19 || ' ' || v_Formato_Sel7)
	   INTO vFecCambio
	   FROM dual;

	 pNumError := 1;
	 pMenError := 'Seleccionando GA_MODABOCEL';

	 SELECT COD_PLANTARIF
	   INTO vPlanAntiguo
	   FROM GA_MODABOCEL A
	  WHERE A.NUM_ABONADO = pNumAbonado
		AND A.COD_TIPMODI = 'C7'
		AND A.FEC_MODIFICA IN (SELECT MAX(D.FEC_MODIFICA)
		  	   				     FROM GA_MODABOCEL D
							    WHERE D.NUM_ABONADO=A.NUM_ABONADO
							      AND D.COD_TIPMODI = 'C7');
	 pNumError := 2;
	 pMenError := 'Seleccionando GA_ABOAMIST';

 	 UPDATE GA_ABOAMIST
	 	SET COD_SITUACION = 'AAA'
	  WHERE NUM_ABONADO = pNumAbonado;

	 SELECT NUM_CELULAR,COD_PLANTARIF
	   INTO vCelular,vPlanNuevo
	   FROM GA_ABOAMIST
	  WHERE NUM_ABONADO = pNumAbonado;

	 pNumError := 3;
	 pMenError := 'Antes del PL';

	 PV_CAMBIOPLAN_SCL_PR(vCelular,vPlanNuevo,vPlanAntiguo,vFecCambio,0,0,pError,pMsgError);

	 IF pError > 0 THEN
	 	pNumError := 4;
	 	pMenError := pMsgError;
		RAISE ERROR_PROCESO;
	 END IF;

	 pNumError := 0;
	 pMenError := 'Proceso Exitoso';

	 RAISE ERROR_PROCESO;

EXCEPTION
    WHEN ERROR_PROCESO THEN
		 IF pNumError > 0 THEN
 	 	 	DBMS_OUTPUT.PUT_LINE('ERROR FATAL 1....' || SQLERRM);
		 END IF;
	     vp_NumError := pNumError ;
         vp_MenError := pMenError ;

    WHEN OTHERS THEN
         vp_NumError := SQLCODE;
         vp_MenError := substr(SQLERRM,1,250);

END;
/
SHOW ERRORS
