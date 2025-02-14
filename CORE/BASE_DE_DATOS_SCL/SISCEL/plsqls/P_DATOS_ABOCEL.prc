CREATE OR REPLACE PROCEDURE P_DATOS_ABOCEL (VP_ABONADO IN NUMBER,
                                            VP_CLIENTE IN OUT NUMBER,
                                            VP_PLEXSYS IN OUT NUMBER,
                                            VP_IMPLIMCONS IN OUT NUMBER,
                                            VP_CELDA IN OUT VARCHAR2,
                                            VP_TIPPLANTARIF IN OUT VARCHAR2,
                                            VP_PLANTARIF IN OUT VARCHAR2,
                                            VP_SERIE IN OUT VARCHAR2,
                                            VP_CELULAR IN OUT NUMBER,
                                            VP_CELULAR_PLEX IN OUT NUMBER,
                                            VP_CARGOBASICO IN OUT VARCHAR2,
                                            VP_CICLO IN OUT NUMBER,
                                            VP_PLANSERV IN OUT VARCHAR2,
                                            VP_GRPSERV IN OUT VARCHAR2,
                                            VP_EMPRESA IN OUT VARCHAR2,
                                            VP_HOLDING IN OUT VARCHAR2,
                                            VP_PORTADOR IN OUT NUMBER,
                                            VP_PROCALTA IN OUT VARCHAR2,
                                            VP_AGENTE IN OUT NUMBER,
                                            VP_SUPERTEL IN OUT NUMBER,
                                            VP_TELEFIJA IN OUT VARCHAR2,
                                            VP_FECALTA IN OUT DATE,
                                            VP_VENTA IN OUT NUMBER,
                                            VP_INDFACT IN OUT NUMBER,
                                            VP_FINCONTRA IN OUT DATE,
					    					VP_BAJACEN IN OUT DATE,
					    					VP_BAJA IN OUT DATE,
					    					VP_CREDMOR IN OUT VARCHAR2,
					    					VP_USUARIO IN OUT NUMBER,
					    					VP_OPREDFIJA IN OUT NUMBER,
					    					VP_PROC IN OUT VARCHAR2,
					    					VP_TABLA IN OUT VARCHAR2,
					    					VP_ACT IN OUT VARCHAR2,
					    					VP_SQLCODE IN OUT VARCHAR2,
					    					VP_SQLERRM IN OUT VARCHAR2,
                                            VP_ERROR IN OUT VARCHAR2) is
--
-- Procedimiento que recupera datos en la tabla de abonados celular
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
  V_LIMCONSUMO GA_ABOCEL.COD_LIMCONSUMO%TYPE;
  V_INDTOL GED_PARAMETROS.VAL_PARAMETRO%TYPE;
BEGIN

   VP_PROC := 'P_DATOS_ABOCEL';
   VP_TABLA := 'GED_PARAMETROS';
   SELECT VAL_PARAMETRO
   INTO  V_INDTOL
   FROM GED_PARAMETROS
   WHERE NOM_PARAMETRO = 'IND_TOL';


   VP_TABLA := 'GA_ABOCEL';
   VP_ACT := 'S';
   SELECT COD_CLIENTE,IND_PLEXSYS,COD_LIMCONSUMO,
          COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,
          NUM_SERIEHEX,NUM_CELULAR,NUM_CELULAR_PLEX,
          COD_CARGOBASICO,COD_CICLO,COD_PLANSERV,
          COD_GRPSERV,COD_EMPRESA,COD_HOLDING,
          COD_CARRIER,IND_PROCALTA,COD_VENDEDOR_AGENTE,
          IND_SUPERTEL,NUM_TELEFIJA,FEC_ACTCEN,
          NUM_VENTA,IND_FACTUR,FEC_FINCONTRA,
	      FEC_BAJACEN,FEC_BAJA,COD_CREDMOR,
	      COD_USUARIO,COD_OPREDFIJA
    INTO  VP_CLIENTE,VP_PLEXSYS,V_LIMCONSUMO,
          VP_CELDA,VP_TIPPLANTARIF,VP_PLANTARIF,
          VP_SERIE,VP_CELULAR,VP_CELULAR_PLEX,
          VP_CARGOBASICO,VP_CICLO,VP_PLANSERV,
          VP_GRPSERV,VP_EMPRESA,VP_HOLDING,
          VP_PORTADOR,VP_PROCALTA,VP_AGENTE,
          VP_SUPERTEL,VP_TELEFIJA,VP_FECALTA,
          VP_VENTA,VP_INDFACT,VP_FINCONTRA,
	      VP_BAJACEN,VP_BAJA,VP_CREDMOR,
	      VP_USUARIO,VP_OPREDFIJA
    FROM GA_ABOCEL
    WHERE NUM_ABONADO = VP_ABONADO;

	IF V_INDTOL = 'S' THEN
	   IF V_LIMCONSUMO <> '-1' THEN
	   	   VP_TABLA := 'TOL_LIMITE_TD';
		   SELECT IMP_LIMITE
		   INTO VP_IMPLIMCONS
		   FROM TOL_LIMITE_TD
		   WHERE COD_LIMCONS = V_LIMCONSUMO;
	   ELSE
		   VP_IMPLIMCONS := 0;
	   END IF;
	ELSE
		VP_TABLA := 'TA_LIMCONSUMO';
    	SELECT IMP_LIMCONSUMO
      	INTO VP_IMPLIMCONS
      	FROM TA_LIMCONSUMO
     	WHERE COD_PRODUCTO = 1
       	AND COD_LIMCONSUMO = V_LIMCONSUMO;
   	END IF;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
   BEGIN
      SELECT COD_CLIENTE,IND_PLEXSYS,COD_LIMCONSUMO,
          COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,
          NUM_SERIEHEX,NUM_CELULAR,NUM_CELULAR_PLEX,
          COD_CARGOBASICO,COD_CICLO,COD_PLANSERV,
          COD_GRPSERV,COD_EMPRESA,COD_HOLDING,
          COD_CARRIER,IND_PROCALTA,COD_VENDEDOR_AGENTE,
          IND_SUPERTEL,NUM_TELEFIJA,FEC_ACTCEN,
          NUM_VENTA,IND_FACTUR,FEC_FINCONTRA,
	  	  FEC_BAJACEN,FEC_BAJA,COD_CREDMOR,
	  	  COD_USUARIO,COD_OPREDFIJA
     INTO VP_CLIENTE,VP_PLEXSYS,V_LIMCONSUMO,
          VP_CELDA,VP_TIPPLANTARIF,VP_PLANTARIF,
          VP_SERIE,VP_CELULAR,VP_CELULAR_PLEX,
          VP_CARGOBASICO,VP_CICLO,VP_PLANSERV,
          VP_GRPSERV,VP_EMPRESA,VP_HOLDING,
          VP_PORTADOR,VP_PROCALTA,VP_AGENTE,
          VP_SUPERTEL,VP_TELEFIJA,VP_FECALTA,
          VP_VENTA,VP_INDFACT,VP_FINCONTRA,
	  	  VP_BAJACEN,VP_BAJA,VP_CREDMOR,
	  	  VP_USUARIO,VP_OPREDFIJA
     FROM GA_ABOAMIST
    WHERE NUM_ABONADO = VP_ABONADO;
   EXCEPTION
      WHEN OTHERS THEN
	  	   VP_SQLCODE := SQLCODE;
	  	   VP_SQLERRM := SQLERRM;
           VP_ERROR := '4';
   END;
   WHEN OTHERS THEN
	VP_SQLCODE := SQLCODE;
	VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
