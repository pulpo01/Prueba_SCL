CREATE OR REPLACE PROCEDURE        CE_P_PERIODO_FACTURACION(
  stipperiodo  IN VARCHAR2,
  stipperdia  IN VARCHAR2,
  shorario  IN VARCHAR2,
  isetdias IN NUMBER,
  sfec_ultmod IN VARCHAR2,
  snom_usuario IN VARCHAR2,
  sservicio IN VARCHAR2,
  sempresa IN VARCHAR2,
  scodtipuso IN VARCHAR2,
  resul IN OUT VARCHAR2,
  ind_gruposerv in NUMBER,
  sPerConciliacion IN VARCHAR2
  )
IS
  sfec_desde     VARCHAR2(25);
  sfec_hasta     VARCHAR2(25);
  scod_periodo   VARCHAR2(7);
  sdia           VARCHAR2(11);
  sfec_diafest   VARCHAR2(11);
  inum           number(10);
  inum1          number(10);
  sdia_cierre    VARCHAR2(3);
  smes           VARCHAR2(8);
  marca          NUMBER(4);
  sFECHA		 VARCHAR2(10);
/******************************************************************************
   NOMBRE:     CE_P_PERIODO_FACTURACION
   OBJETIVO:   GENERA UN NUEVO PERIODO EN CET_PERIODOSERV
   Ver        Fecha        Autor
   ---------  ----------  ---------------
   1.0        13/11/2000  MARITZA TAPIA A.
******************************************************************************/
ERROR_PROCESO EXCEPTION;
BEGIN
resul:='OK';
marca :=1;
SELECT TO_CHAR(TO_DATE(sPerConciliacion,'YYMMDD'),'DD-MM-YYYY')
INTO   sFECHA
FROM   DUAL;
IF ltrim(rtrim(stipperdia)) ='D' AND ltrim(rtrim(shorario)) ='N'  THEN
	   SELECT sFECHA ||' 00:00:00'
	   INTO   sfec_desde
	   FROM DUAL;
	   SELECT sFECHA ||' 23:59:59',
	   		  TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY'),'DDMMYY')
	   INTO   sfec_hasta,
              scod_periodo
	   FROM DUAL;
END IF;
IF ltrim(rtrim(stipperdia)) ='D' AND ltrim(rtrim(shorario)) ='F'  THEN
   		   marca :=52;
		   SELECT sFECHA||' 14:00:00'
	       INTO   sfec_desde
    	   FROM DUAL;
   		   marca :=58;
		   SELECT TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY'), 'DAY')
		   INTO sdia
    	   FROM DUAL;
           marca :=63;
		   IF ltrim(rtrim(sdia)) = 'FRIDAY' THEN
              inum:=3;
		      LOOP
                    marca :=66;
			        SELECT decode(count(FEC_DIAFEST),0,'salir')
			  		INTO sfec_diafest
					FROM TA_DIASFEST
					WHERE FEC_DIAFEST = TO_DATE(sFECHA ,'DD/MM/YYYY')+ inum;
					EXIT WHEN sfec_diafest = 'salir';
					inum := inum + 1;
			  END LOOP;
                     marca :=74;
	                 SELECT TO_CHAR(TO_DATE(sFECHA ,'DD-MM-YYYY')+ inum, 'DD-MM-YYYY')||' 13:59:59',
					 		TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY')+ inum ,'DDMMYY')
		        	 INTO  sfec_hasta,
					 	   scod_periodo
					 FROM  DUAL;
	       ELSE
		     marca :=80;
		     IF  ltrim(rtrim(sdia)) = 'MONDAY' OR ltrim(rtrim(sdia))= 'TUESDAY' OR ltrim(rtrim(sdia))='WEDNESDAY' OR ltrim(rtrim(sdia))='THURSDAY' THEN
              inum1:= 1;
	          	 LOOP
                    marca :=82;
			        SELECT decode(count(FEC_DIAFEST),0,'salir')
					INTO sfec_diafest
					FROM TA_DIASFEST
					WHERE FEC_DIAFEST = TO_DATE(sFECHA ,'DD/MM/YYYY')+ inum1;
					EXIT WHEN sfec_diafest = 'salir';
					inum1:= inum1 + 1;
    		     END LOOP;
                      marca :=92;
	                  SELECT TO_DATE(sFECHA ,'DD/MM/YYYY')+ inum1||' 13:59:59',
					 		 TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY')+ inum1 ,'DDMMYY')
					  INTO  sfec_hasta,
					  		scod_periodo
					  FROM  DUAL;
    	   END IF;
		 END IF;
END IF;
marca :=98;
IF stipperdia ='S' AND shorario ='N'  THEN
	 SELECT TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY'), 'DAY')
	 INTO sdia
     FROM DUAL;
	 IF ltrim(rtrim(sdia)) = 'MONDAY' THEN
	       marca :=105;
	    SELECT sFecha||' 00:00:00'
	    INTO   sfec_desde
	    FROM DUAL;

	       marca :=112;
      SELECT TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY'), 'DAY')
	  INTO sdia
      FROM DUAL;
	  ELSE
	   IF ltrim(rtrim(sdia))='SUNDAY' THEN
	       marca :=117;
	     SELECT TO_DATE(sFECHA ,'DD/MM/YYYY')+ 7||' 23:59:59',
				TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY')+ 7 ,'DDMMYY')
	     INTO   sfec_hasta,
                scod_periodo
	     FROM DUAL;
	  END IF;
	END IF;
END IF;
marca :=123;
IF stipperdia ='B' AND shorario ='F' THEN
           marca :=124;
	   	   SELECT sFECHA||' 14:00:00'
	       INTO   sfec_desde
    	   FROM DUAL;
		   marca :=130;
		   SELECT TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY'), 'DAY')
		   INTO sdia
    	   FROM DUAL;
		   IF ltrim(rtrim(sdia)) = 'FRIDAY' THEN
              inum:=4;
		      LOOP
    	            marca :=136;
			        SELECT decode(count(FEC_DIAFEST),0,'salir')
					INTO sfec_diafest
					FROM TA_DIASFEST
					WHERE FEC_DIAFEST = TO_DATE(sFECHA ,'DD/MM/YYYY')+ inum;
					EXIT WHEN sfec_diafest = 'salir';
					inum := inum + 1;
    		  END LOOP;
    	               marca :=145;
	                  SELECT TO_DATE(sFECHA ,'DD/MM/YYYY')+ inum||' 13:59:59',
					 		 TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY')+ inum ,'DDMMYY')
					  INTO  sfec_hasta,
                            scod_periodo
					  FROM  DUAL;
	       ELSE
		    IF ltrim(rtrim(sdia)) = 'MONDAY' OR ltrim(rtrim(sdia))= 'TUESDAY' OR ltrim(rtrim(sdia))='WEDNESDAY' OR ltrim(rtrim(sdia))='THURSDAY' THEN
              inum1:= 2;
	          	 LOOP
    		        marca :=153;
			        SELECT decode(count(FEC_DIAFEST),0,'salir')
					INTO sfec_diafest
					FROM TA_DIASFEST
					WHERE FEC_DIAFEST = TO_DATE(sFECHA ,'DD/MM/YYYY')+ inum1;
					EXIT WHEN sfec_diafest = 'salir';
					inum1 := inum1 + 1;
    		     END LOOP;
				      marca :=161;
					  SELECT TO_DATE(sFECHA ,'DD/MM/YYYY')+ inum1||' 13:59:59',
					 		 TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY')+ inum1 ,'DDMMYY')
					  INTO  sfec_hasta,
                            scod_periodo
					  FROM  DUAL;
    	    END IF;
		 END IF;
END IF;
marca :=170;
IF stipperdia ='B' AND shorario ='N' THEN
       marca :=169;
	   SELECT sFECHA ||' 00:00:00'
	   INTO   sfec_desde
	   FROM DUAL;
       marca :=175;
	   SELECT TO_DATE(sFECHA ,'DD/MM/YYYY')+ 2||' 13:59:59',
              TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY')+ 2 ,'DDMMYY')
	   INTO   sfec_hasta,
   	          scod_periodo
	   FROM DUAL;
END IF;
IF stipperdia ='M' AND shorario ='N' THEN
       marca :=180;
	   SELECT sFECHA||' 00:00:00',
	   		  TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY') +1,'DDMMYY')
	   INTO   sfec_desde,
	          scod_periodo
	   FROM DUAL;
       marca :=187;
       SELECT TO_CHAR(LAST_DAY(SYSDATE),'DD/MM/YYYY')||' 23:59:59'
	   INTO   sfec_hasta
	   FROM DUAL;
END IF;
marca :=195;
IF stipperdia ='C' AND shorario ='N' THEN
       marca :=193;
	   SELECT sFECHA||' 00:00:00',
              TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY'),'DDMMYY')
	   INTO   sfec_desde,
	          scod_periodo
	   FROM DUAL;
       marca :=198;
	   SELECT NUM_DIACIERRE
	   INTO sdia_cierre
   	   FROM CET_CIECONTAB
	   WHERE TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY'),'DD')<= NUM_DIACIERRE
	   AND NUM_SETDIAS = isetdias
	   AND ROWNUM = 1;
	   IF sdia_cierre IS NULL THEN
	          marca :=207;
	      	   SELECT NUM_DIACIERRE
			   INTO sdia_cierre
			   FROM CET_CIECONTAB
			   WHERE TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY'),'DD')> NUM_DIACIERRE
			   AND NUM_SETDIAS = isetdias
			   AND ROWNUM = 1;
			   marca :=214;
			   SELECT TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE,1)),'MM/YYYY')
			   INTO smes
			   FROM DUAL;
			   sfec_hasta := sdia_cierre||'/'||smes;
		ELSE
               marca :=220;
	           SELECT TO_CHAR(TO_DATE(sFECHA,'DD-MM-YYYY'),'MM/YYYY')
			   INTO smes
			   FROM DUAL;
			   sfec_hasta := sdia_cierre||'/'||smes;
		END IF;
END IF;
marca :=228;
INSERT INTO CET_PERIODOSERV
	   (COD_SERVICIO  ,
	    COD_PERIODO   ,
		COD_EMPRESA   ,
		COD_TIPPERIODO,
		COD_TIPUSO    ,
		FEC_DESDE     ,
		FEC_HASTA     ,
		COD_ESTADO    ,
		FEC_ULTMOD    ,
		NOM_USUARIO   ,
		IND_GRUPOSERV )
	    VALUES(
	   	sservicio     ,   --COD_SERVICIO    VARCHAR2(5)   NOT NULL,
	    scod_periodo  ,   --COD_PERIODO     VARCHAR2(6)   NOT NULL,
		sempresa      ,   --COD_EMPRESA     VARCHAR2(5)   NOT NULL,
		stipperiodo   ,   --COD_TIPPERIODO  VARCHAR2(5)   NOT NULL,
		scodtipuso    ,   --COD_TIPUSO      VARCHAR2(2)   NOT NULL,
		to_date(sfec_desde,'DD-MM-YYYY HH24:MI:SS'),   --FEC_DESDE       DATE          NOT NULL,
		to_date(sfec_hasta,'DD-MM-YYYY HH24:MI:SS'),   --FEC_HASTA       DATE          NOT NULL,
		'AB'           ,   --COD_ESTADO      VARCHAR2(2)   NOT NULL,
		to_date(sfec_ultmod,'DD-MM-YYYY'),   --FEC_ULTMOD      DATE          NOT NULL,
		snom_usuario,       --ind_gruposerv   NUMBER
		ind_gruposerv );      --NOM_USUARIO     VARCHAR2(30)  NOT NULL,
    marca :=250;

	EXCEPTION
	WHEN OTHERS THEN
   	    resul := SQLERRM ||'linea: '||marca;
	 	ROLLBACK;
END CE_P_PERIODO_FACTURACION;
/
SHOW ERRORS
