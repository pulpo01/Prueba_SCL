CREATE OR REPLACE PROCEDURE        CO_DIAS_HABILES(vp_IndTipo   IN  VARCHAR2, vp_Periodo OUT VARCHAR2  , vp_Fec_Desde OUT VARCHAR2 ,
	   	  		  							 vp_Fec_Hasta OUT VARCHAR2, vp_bOutRetorno OUT BOOLEAN) IS
vp_error        NUMBER(5);
vp_gls_error    VARCHAR2(255);
sNom_proceso    VARCHAR2(50);
sDesc_Sql       VARCHAR2(150);
bOutRetorno     BOOLEAN:=TRUE;
sDia_Actual     VARCHAR2(11);
sFecha_Actual 	VARCHAR2(25);
sFecha_Cierre 	VARCHAR2(25);
sFecha_Desde  	VARCHAR2(25);
sFecha_Hasta  	VARCHAR2(25);
sPeriodo      	VARCHAR2(11);
iDia_Festivo  	NUMBER := 1;
iNum_Dias	  	NUMBER := 1;
BEGIN
	sNom_proceso:='CO_DIAS_HABILES';
	IF vp_IndTipo = 'DIA_N' THEN
		sDesc_Sql :='TO_CHAR(SYSDATE,DD-MM-YYYY)|| 00:00:00';
		SELECT TO_CHAR(SYSDATE,'DD-MM-YYYY')||' 00:00:00', TO_CHAR(SYSDATE+iNum_Dias,'DD-MM-YYYY')||' 23:59:59',
			   TO_CHAR(SYSDATE+iNum_Dias,'DDMMYY')
		INTO   sFecha_Desde , sFecha_Hasta , sPeriodo
		FROM   DUAL;
	END IF;
	IF vp_IndTipo = 'DIA_F' THEN
		sDesc_Sql :='SELECT TO_CHAR(SYSDATE,DAY)';
		SELECT TO_CHAR(SYSDATE,'DAY')
		INTO   sDia_Actual
		FROM   DUAL;
		IF ltrim(rtrim(sDia_Actual)) = 'FRIDAY' THEN
		   BEGIN
		   iNum_Dias := iNum_Dias + 2;
		   END;
		END IF;
		LOOP
			EXIT WHEN iDia_Festivo = 0;
			sDesc_Sql :='SELECT TO_CHAR(SYSDATE+iNum_Dias,DD-MM-YYYY)';
			SELECT TO_CHAR(SYSDATE+iNum_Dias,'DD-MM-YYYY') 			   ,
				   TO_CHAR(SYSDATE,'DD-MM-YYYY')||' 14:00:00'		   ,
				   TO_CHAR(SYSDATE+iNum_Dias,'DD-MM-YYYY')||' 13:59:59',
				   TO_CHAR(SYSDATE+iNum_Dias,'DDMMYY')
			INTO   sFecha_Cierre, sFecha_Desde ,
				   sFecha_Hasta , sPeriodo
			FROM   DUAL;
			sDesc_Sql :='SELECT COUNT(*) FROM TA_DIASFEST';
			SELECT COUNT(*)
			INTO   iDia_Festivo
			FROM   TA_DIASFEST
			WHERE  FEC_DIAFEST = TO_DATE(sFecha_Cierre,'DD-MM-YYYY');
			iNum_Dias := iNum_Dias + 1;
		END LOOP;
	END IF;
    vp_Periodo   := sPeriodo;
    vp_Fec_Desde := sFecha_Desde;
    vp_Fec_Hasta := sFecha_Hasta;
    vp_bOutRetorno := bOutRetorno;
    EXCEPTION
       WHEN OTHERS THEN
			vp_bOutRetorno := FALSE;
			vp_gls_error := 'Otros Errores - ' || SQLERRM;
			vp_error := SQLCODE;
			INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO, DESC_SQL , DESC_CADENA)
			VALUES (sNom_proceso, vp_error, SYSDATE, sDesc_Sql, vp_gls_error);
END CO_DIAS_HABILES;
/
SHOW ERRORS
