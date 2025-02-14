CREATE OR REPLACE PROCEDURE        CE_P_CALCULA_PERIODOS(
  stipperiodo  IN VARCHAR2,
  resul IN OUT VARCHAR2,
  sIndNuevo IN VARCHAR2,
  scod_periodo IN OUT VARCHAR2,
  sfec_desde IN OUT VARCHAR2,
  sfec_hasta IN OUT VARCHAR2
  )
 IS
/******************************************************************************
   NOMBRE:       CE_P_GENERA_PERIODOS
   PROPOSITO:    CALCULA EL PERIODOS SEGUN EL TIPO.


   PARAMETROS:

******************************************************************************/
sNumDias   CED_TIPPERCONT.NUM_SETDIAS%TYPE;
stipperdia CED_TIPPERCONT.COD_TIPPERDIA%TYPE;
shorario   CED_TIPPERCONT.COD_HORARIO%TYPE;

sFECHA	 	   VARCHAR2(10);

szscod_periodo VARCHAR2(25);
szsfec_desde   VARCHAR2(25);
szsfec_hasta   VARCHAR2(25);



sCodPerConci   VARCHAR2(6);
sdia           VARCHAR2(11);
sDia_Actual    VARCHAR2(11);
iDia_Festivo   NUMBER := 1;
BEGIN
sCodPerConci := scod_periodo;
resul:='OK';

	 	 	SELECT TO_CHAR(TO_DATE(sCodPerConci,'DDMMYY'),'DD-MM-YYYY')
			INTO   sFECHA
			FROM   DUAL;

	  		SELECT NUM_SETDIAS,
				   COD_TIPPERDIA,
				   COD_HORARIO
			INTO   sNumDias,
				   stipperdia,
				   shorario
			FROM   CED_TIPPERCONT
			WHERE  COD_TIPPERIODO  = ltrim(rtrim(stipperiodo));

IF sIndNuevo = 'S' THEN -- Si Periodo es Nuevo

    IF shorario='N' THEN
	   SELECT TO_CHAR(TO_DATE(sFECHA ,'DD/MM/YYYY'),'DD-MM-YYYY') ||' 00:00:00',
	     	  TO_CHAR(TO_DATE(sFECHA ,'DD/MM/YYYY') + sNumDias -1,'DD-MM-YYYY') ||' 23:59:59',
			  TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY'),'DDMMYY')
	   INTO   sfec_desde,
	   	   	  sfec_hasta,
              scod_periodo
	   FROM DUAL;
    END IF;

    IF shorario='F' THEN
            SELECT TO_CHAR(TO_DATE(sCodPerConci,'DDMMYY'),'DAY')
            INTO   sDia_Actual
            FROM   DUAL;
           IF ltrim(rtrim(sDia_Actual)) = 'MONDAY' THEN
               BEGIN
               sNumDias := sNumDias + 2;
               END;
            END IF;

	   LOOP
	       EXIT WHEN iDia_Festivo = 0;

	   	   SELECT TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY') + sNumDias, 'DAY')
	   	   INTO sdia
       	   FROM DUAL;

		   IF ltrim(rtrim(sdia)) = 'SATURDAY' OR ltrim(rtrim(sdia)) = 'SUNDAY' THEN
		   	   sNumDias := sNumDias + 1;
		   ELSE
		   	   SELECT count(*)
		   	   INTO iDia_Festivo
	 	   	   FROM TA_DIASFEST
		   	   WHERE FEC_DIAFEST = TO_DATE(sFECHA,'DD/MM/YYYY') - sNumDias;

				IF iDia_Festivo>0 THEN
                   sNumDias := sNumDias + 1;
				END IF;
		   END IF;
	   END LOOP;
	   SELECT TO_CHAR((TO_DATE(sFECHA ,'DD-MM-YYYY') - sNumDias) ,'DD-MM-YYYY') ||' 14:00:00',
  	   		  TO_CHAR(TO_DATE(sFECHA ,'DD-MM-YYYY'),'DD-MM-YYYY') ||' 13:59:59',
	   		  TO_CHAR(TO_DATE(sFECHA ,'DD-MM-YYYY'),'DDMMYY')
			  INTO   sfec_desde ,
	   		  		 sfec_hasta  ,
	   		  		 scod_periodo
	   FROM DUAL;

	END IF;
ELSE  -- Si no es periodo nuevo

	IF shorario='N' THEN
	   SELECT TO_CHAR(TO_DATE(sFECHA ,'DD/MM/YYYY')+ sNumDias,'DD-MM-YYYY') ||' 00:00:00',
	     	  TO_CHAR(TO_DATE(sFECHA ,'DD/MM/YYYY')+ (sNumDias*2) - 1,'DD-MM-YYYY')  ||' 23:59:59', -- Genialidad dd Mmolinal
			  TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY') + sNumDias,'DDMMYY')
	   INTO   sfec_desde,
	   	   	  sfec_hasta,
              scod_periodo
	   FROM DUAL;
	END IF;


	IF shorario='F' THEN
	   SELECT TO_CHAR(TO_DATE(sFECHA ,'DD-MM-YYYY'),'DD-MM-YYYY') ||' 14:00:00'
	   INTO   sfec_desde
	   FROM DUAL;

	   LOOP
	       EXIT WHEN iDia_Festivo = 0;

	   	   SELECT TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY') + sNumDias, 'DAY')
	   	   INTO sdia
       	   FROM DUAL;

		   IF ltrim(rtrim(sdia)) = 'SATURDAY' OR ltrim(rtrim(sdia)) = 'SUNDAY' THEN
		   	   sNumDias := sNumDias + 1;
		   ELSE
		   	   SELECT count(*)
		   	   INTO iDia_Festivo
	 	   	   FROM TA_DIASFEST
		   	   WHERE FEC_DIAFEST = TO_DATE(sFECHA,'DD/MM/YYYY') + sNumDias;
				IF iDia_Festivo>0 THEN
                   sNumDias := sNumDias + 1;
				END IF;
		   END IF;
	   END LOOP;

	   SELECT TO_CHAR(TO_DATE(sFECHA ,'DD-MM-YYYY') + sNumDias ,'DD-MM-YYYY') ||' 13:59:59',
	   		  TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY') + sNumDias,'DDMMYY')
	   INTO   sfec_hasta,
	   		  scod_periodo
	   FROM DUAL;

		 END IF;
END IF;

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
   	    resul := SQLERRM ||'linea: ';
	 	ROLLBACK;
     WHEN OTHERS THEN
   	    resul := SQLERRM ||'linea: ';
	 	ROLLBACK;
END CE_P_CALCULA_PERIODOS;
/
SHOW ERRORS
