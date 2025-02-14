CREATE OR REPLACE FUNCTION PV_REC_PLAN_ANTIGUO_FN (VP_ABONADO IN NUMBER) RETURN VARCHAR2
IS


	V_TABLA				   VARCHAR2(30);
	V_ACT				   VARCHAR2(1);
	sCOD_SQLERRM	 	   VARCHAR2(60);
	V_COD_PLAN			   GA_ABOAMIST.COD_PLANTARIF%TYPE;

	ERROR_PROCESO EXCEPTION;
/******************************************************************************
   Nombre        :     PV_REC_PLAN_ANTIGUO_FN
   AREA          :     Desarrollo Post-Venta POSTVENTA
   Creado		 :     22 Diciembre 2003  Proyecto
   				 	   Patrcica Castro R.
   Comentarios	 :     Integracion Sixbell ,
   			recupera plan antiguo del abonado


MODIFCIACIONES
   Fecha		  	   	Comentarios

******************************************************************************/

BEGIN
	 V_TABLA:='GA_ABOAMIST';
	 V_ACT:='S' ;

	 SELECT COD_PLANTARIF
	 INTO V_COD_PLAN
 	 FROM GA_ABOAMIST
	 WHERE NUM_ABONADO = VP_ABONADO
	 AND COD_SITUACION = 'CPP'; --Cambio de plan en Proceso

	 RETURN V_COD_PLAN;

	 EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 RETURN 'FALSE';
END;
/
SHOW ERRORS
