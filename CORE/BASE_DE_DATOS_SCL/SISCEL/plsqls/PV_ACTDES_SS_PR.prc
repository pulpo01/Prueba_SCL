CREATE OR REPLACE PROCEDURE PV_ACTDES_SS_PR(pAbonado     IN NUMBER,
	   	  		  				  pCelular	   IN NUMBER,
	   	  		  				  pOperacion   IN VARCHAR2,
								  pCodServicio IN VARCHAR2,
								  pServSupl    IN NUMBER,
								  pCodNivel    IN NUMBER,
								  pFecCambio   IN DATE,
								  pIndCentral  IN NUMBER,
								  pError      OUT NUMBER,
								  pMsgError   OUT VARCHAR2
	   	  		  				  )

IS


  sGrupo		   VARCHAR2(2);
  sNivel		   VARCHAR2(4);
  sCadCambios	   VARCHAR2(255);
  sCadServicios	   GA_ABOAMIST.CLASE_SERVICIO%TYPE;
  sCodConcepto	   GA_ACTUASERV.COD_CONCEPTO%TYPE;

  sTmpS			   VARCHAR2(255);
  sTmpN			   VARCHAR2(255);
  sTmpS2		   VARCHAR2(255);
  sTmpN2		   VARCHAR2(255);
  sCadTmp		   VARCHAR2(255);
  nIndCambio 	   NUMBER(1);
  dFecCentral	   DATE;


  ERROR_PROCESO EXCEPTION;

  nNumError		   NUMBER(2);
  sMsgError		   VARCHAR2(200);
  sNOM_TABLA	   GA_ERRORES.NOM_TABLA%TYPE;
  sNOM_PROC        GA_ERRORES.NOM_PROC%TYPE;
  sCOD_ACT         GA_ERRORES.COD_ACT%TYPE;
  sCOD_SQLCODE     VARCHAR2(30);
  sCOD_SQLERRM	   VARCHAR2(200);
  sERROR           VARCHAR2(2);


BEGIN

	nNumError:=0;
	sMsgError:='Comienzo Operacion';
	sNOM_PROC:='PV_ACTDES_SS_PR';


	IF pIndCentral = 0 THEN
	   dFecCentral := pFecCambio;
	END IF;


	IF pOperacion = 'D' THEN

	   nNumError:=1;
	   sMsgError:='Desactivando SS';


       UPDATE GA_SERVSUPLABO
          SET FEC_BAJABD = pFecCambio, --SYSDATE,
		      IND_ESTADO = 3
    	WHERE NUM_ABONADO = pAbonado
    	  AND COD_SERVSUPL = pServSupl
    	  AND COD_NIVEL = pCodNivel;


	    sGrupo := LTRIM(RTRIM(TO_CHAR(pServSupl,'00')));
	    sNivel := '0000';
	    sCadCambios := sCadCambios || sGrupo || sNivel;

	ELSE

	    nNumError:=1;
	    sMsgError:='Activando SS';


	    SELECT COD_CONCEPTO
		  INTO sCodConcepto
	      FROM GA_ACTUASERV
	     WHERE COD_PRODUCTO=1
	       AND COD_TIPSERV=2
	       AND COD_SERVICIO=pCodServicio
	       AND COD_ACTABO='FA';

	    nNumError:=2;
	    sMsgError:='Activando SS - Insertando GA_SERVSUPLABO';


	    INSERT INTO GA_SERVSUPLABO
	    	   		(NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, FEC_ALTACEN,COD_SERVSUPL, COD_NIVEL, NUM_TERMINAL,
	    			 COD_PRODUCTO, NOM_USUARORA, IND_ESTADO, COD_CONCEPTO)
	         VALUES (pAbonado,pCodServicio,pFecCambio,dFecCentral,pServSupl,pCodNivel,pCelular,
			 		 1,user,1 ,sCodConcepto);


	    sGrupo := ltrim(rtrim(TO_CHAR(pServSupl,'00')));
	    sNivel := ltrim(rtrim(TO_CHAR(pCodNivel,'0000')));
	    sCadCambios := sCadCambios || sGrupo || sNivel;

	END IF;


    nNumError:=3;
	sMsgError:='Recuperando CLASE_SERVICIO';

	SELECT CLASE_SERVICIO
	  INTO sCadServicios
	  FROM GA_ABOAMIST
	 WHERE NUM_ABONADO=pAbonado;


	--Componemos la nueva cadena de clase_abonado
	IF sCadServicios IS NOT NULL THEN
		FOR i IN 0..((length(sCadCambios) / 6) - 1) LOOP
		   sTmpS2 := substr(sCadCambios, i * 6 + 1, 2);
		   sTmpN2 := substr(sCadCambios, i * 6 + 3, 4);
		   nIndCambio :=0;
		   FOR j IN 0..((length(sCadServicios) / 6) - 1) LOOP
		       sTmpS := substr(sCadServicios, j * 6 + 1, 2);
		       sTmpN := substr(sCadServicios, j * 6 + 3, 4);
		       If sTmpS = sTmpS2 Then
		          --Ha habido un cambio de nivel en un servicio
		          sCadTmp := substr(sCadServicios, 1, j * 6);
		          IF sTmpN2 <> '0000' THEN
		             sCadTmp := sCadTmp || TO_CHAR(TO_NUMBER(sTmpS2),'00') || to_char(TO_NUMBER(sTmpN2),'0000');
		          END IF;
		          sCadTmp := sCadTmp || substr(sCadServicios, j * 6 + 7);
		          sCadServicios := sCadTmp;
		          nIndCambio:=1;
		          EXIT;
		       END IF;
		   END LOOP;
		   IF nIndCambio = 0 THEN
		      sCadServicios := sCadServicios || ltrim(rtrim(to_char(TO_NUMBER(sTmpS2),'00'))) || ltrim(rtrim(to_char(TO_NUMBER(sTmpN2), '0000')));
		   END IF;
		END LOOP;
	ELSE
	    sCadServicios := sCadCambios;
	END IF;
    nNumError:=5;
	sMsgError:='Actualizando CLASE_SERVICIO';

	UPDATE GA_ABOAMIST SET
		   CLASE_SERVICIO = sCadServicios
	 WHERE NUM_ABONADO = pAbonado;


	nNumError:=0;
	sMsgError:='Fin Operacion';

  	RAISE ERROR_PROCESO;

EXCEPTION

    WHEN ERROR_PROCESO THEN

         pError:=nNumError;
         pMsgError:=sMsgError;


END;
/
SHOW ERRORS
