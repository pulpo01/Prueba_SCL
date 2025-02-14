CREATE OR REPLACE PROCEDURE PV_SSGENERA_SCL_PR( pAbonado        IN NUMBER,
	   	  		  								pCelular		IN NUMBER,
	   	  		  								pPlanActual     IN VARCHAR2,
	   	  		  								pPlanNuevo      IN VARCHAR2,
	   	  		  								pCodCentral     IN NUMBER,
												pCodTecnologia  IN VARCHAR2,
												pTipTerminal    IN VARCHAR2,
												pNumSerie		IN VARCHAR2,
												pNumImei		IN VARCHAR2,
												pIndCentral		IN NUMBER,
												pFecCambio		IN DATE,
												pError         OUT NUMBER,
												pMsgError  	   OUT VARCHAR2
	   	  		  					  		  )
IS


  nCodServSuPl     GA_SERVSUPLABO.COD_SERVSUPL%TYPE;
  nCodNivel		   GA_SERVSUPLABO.COD_NIVEL%TYPE;
  sEstado		   VARCHAR2(1);
  sCodServicio	   GA_SERVSUPLABO.COD_SERVICIO%TYPE;

  a_nCodServSuPl   GA_SERVSUPLABO.COD_SERVSUPL%TYPE;
  a_nCodNivel	   GA_SERVSUPLABO.COD_NIVEL%TYPE;
  a_sEstado		   VARCHAR2(1);
  a_sCodServicio   GA_SERVSUPLABO.COD_SERVICIO%TYPE;


  sServicio		   GA_SERVSUPLABO.COD_SERVICIO%TYPE;
  sServIncom	   GA_SERVSUP_DEF.COD_SERVDEF%TYPE;
  sServTrans	   GA_SERVSUP_DEF.COD_SERVDEF%TYPE;

  sCodSistema      ICG_CENTRAL.COD_SISTEMA%TYPE;
  sCodActAbo	   GA_ACTABO.COD_ACTABO%TYPE;

  nNumMovimiento   ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
  nCodActuacion	   ICC_MOVIMIENTO.COD_ACTUACION%TYPE;
  sNumMin		   ICC_MOVIMIENTO.NUM_MIN%TYPE;
  v_IMSI		   ICC_MOVIMIENTO.IMSI%TYPE;
  v_IMEI           ICC_MOVIMIENTO.IMEI%TYPE;
  v_ICC			   ICC_MOVIMIENTO.ICC%TYPE;
  V_NUMERROR	   PV_ERRORES_OOSS_TO.NUM_ERROR%TYPE;

  sCodTecnologia   GED_PARAMETROS.VAL_PARAMETRO%TYPE;

  X				   NUMBER(3);
  i				   NUMBER(3);
  j				   NUMBER(3);
  j1 			   NUMBER(3);

  sGrupo1 		   VARCHAR2(2);
  sNivel1 		   VARCHAR2(4);

  sGrupo2 		   VARCHAR2(2);
  sNivel2		   VARCHAR2(4);

  sCadenaICC2 	   VARCHAR2(256);
  sw			   NUMBER(3);
  countgrup 	   NUMBER(5);

  sGrupo		   VARCHAR2(2);
  sNivel		   VARCHAR2(4);
  sCadenaICC	   VARCHAR2(256);


  ERROR_PROCESO EXCEPTION;

  nNumError		   NUMBER(2);
  sMsgError		   VARCHAR2(200);
  sNOM_TABLA	   GA_ERRORES.NOM_TABLA%TYPE;
  sNOM_PROC        GA_ERRORES.NOM_PROC%TYPE;
  sCOD_ACT         GA_ERRORES.COD_ACT%TYPE;
  sCOD_SQLCODE     VARCHAR2(30);
  sCOD_SQLERRM	   VARCHAR2(200);
  sERROR           VARCHAR2(2);

  F				   NUMBER(2);
  nEcontrado	   NUMBER(2);


  TYPE t_number  IS TABLE OF NUMBER(4) INDEX BY BINARY_INTEGER;
  TYPE t_varchar IS TABLE OF VARCHAR2(3) INDEX BY BINARY_INTEGER;

  -- SS ABONADOS
  a_cod_servsupl  t_number;
  a_cod_nivel 	  t_number;
  a_cod_servicio  t_varchar;

  -- SS DESACTIVA
  d_cod_servsupl  t_number;
  d_cod_nivel 	  t_number;
  d_estado    	  t_varchar;
  d_cod_servicio  t_varchar;

  -- SS ACTIVA
  c_cod_servsupl  t_number;
  c_cod_nivel 	  t_number;
  c_estado    	  t_varchar;
  c_cod_servicio  t_varchar;

  -- SS FINAL
  f_cod_servsupl  t_number;
  f_cod_nivel 	  t_number;
  f_estado    	  t_varchar;
  f_cod_servicio  t_varchar;



  CURSOR SSABONADOS IS
    SELECT COD_SERVSUPL, COD_NIVEL,COD_SERVICIO
      FROM GA_SERVSUPLABO
     WHERE NUM_ABONADO =  pAbonado
       AND IND_ESTADO < 3;

  CURSOR SSDESACTIVA IS
     SELECT A.COD_SERVSUPL,A.COD_NIVEL,'D' ESTADO,A.COD_SERVICIO
       FROM GA_SERVSUPL A,ICG_SERVICIOTERCEN B,GAD_SERVSUP_PLAN C
      WHERE C.COD_PRODUCTO = 1
        AND B.COD_PRODUCTO = A.COD_PRODUCTO
    	AND B.TIP_TERMINAL = pTipTerminal
    	AND B.COD_SISTEMA  = sCodSistema
    	AND B.COD_SERVICIO = A.COD_SERVSUPL
    	AND B.TIP_TECNOLOGIA = pCodTecnologia
    	AND A.COD_SERVICIO   = C.COD_SERVICIO
    	AND A.COD_PRODUCTO   = C.COD_PRODUCTO
    	AND C.COD_PLANTARIF  = pPlanActual
    	AND C.TIP_RELACION   = 3
    	AND SYSDATE BETWEEN C.FEC_DESDE AND C.FEC_HASTA;


  CURSOR SSACTIVAR IS
     SELECT A.COD_SERVSUPL,A.COD_NIVEL,'A' ESTADO,A.COD_SERVICIO
       FROM GA_SERVSUPL A,ICG_SERVICIOTERCEN B,GAD_SERVSUP_PLAN C
      WHERE C.COD_PRODUCTO = 1
        AND B.COD_PRODUCTO = A.COD_PRODUCTO
    	AND B.TIP_TERMINAL = pTipTerminal
    	AND B.COD_SISTEMA = sCodSistema
    	AND B.COD_SERVICIO = A.COD_SERVSUPL
    	AND B.TIP_TECNOLOGIA = pCodTecnologia
    	AND A.COD_SERVICIO = C.COD_SERVICIO
    	AND A.COD_PRODUCTO = C.COD_PRODUCTO
    	AND C.COD_PLANTARIF = pPlanNuevo
    	AND C.TIP_RELACION = 3
    	AND SYSDATE BETWEEN C.FEC_DESDE AND C.FEC_HASTA;


  CURSOR SSIMCOMPATIBLE IS
     SELECT A.COD_SERVDEF
	   FROM GA_SERVSUP_DEF A, GA_SERVSUPL B, ICG_SERVICIOTERCEN C
	  WHERE A.COD_SERVICIO = sServicio
	    AND A.TIP_RELACION = 3 --iINCOMPATIBILIDAD
		AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA
		AND A.COD_PRODUCTO = B.COD_PRODUCTO
		AND A.COD_SERVICIO = B.COD_SERVICIO
		AND B.COD_PRODUCTO = C.COD_PRODUCTO
		AND B.COD_SERVSUPL = C.COD_SERVICIO
		AND C.COD_SISTEMA = sCodSistema
		AND C.TIP_TERMINAL = pTipTerminal
		AND C.TIP_TECNOLOGIA = pCodTecnologia;

  CURSOR SSTRANSFERENCIA IS
     SELECT B.COD_SERVSUPL,B.COD_NIVEL,'A' ESTADO ,B.COD_SERVICIO
	   FROM GA_SERVSUP_DEF A, GA_SERVSUPL B, ICG_SERVICIOTERCEN C
	  WHERE A.COD_SERVICIO =  sServicio
	    AND A.TIP_RELACION = 2 --iTRANSFERENCIA
		AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA
		AND A.COD_SERVDEF = B.COD_SERVICIO
		AND B.COD_PRODUCTO = 1
		AND A.COD_PRODUCTO = B.COD_PRODUCTO
		AND B.COD_PRODUCTO = C.COD_PRODUCTO
		AND B.COD_SERVSUPL = C.COD_SERVICIO
		AND C.COD_SISTEMA = sCodSistema
		AND C.TIP_TERMINAL = pTipTerminal
		AND C.TIP_TECNOLOGIA = pCodTecnologia;


BEGIN
	-- pIndCentral -> Indicador de Central
	-- 1 va a Icc_Movimiento
	-- 0 NO va a Icc_Movimiento

	-- Inicializacion de Variables
	sCodActAbo:= 'SS';
	nNumError:=0;
	sMsgError:='Inicio Operacion';
	sNOM_PROC:='PV_SSGENERA_SCL_PR';

    -- CARGAMOS LOS SERVICIOS DEL ABONADO
	nNumError:=1;
	sMsgError:='Servicios Abonado';

	f := 1;
  	FOR C1 IN SSABONADOS LOOP
		a_cod_servsupl(f) := C1.COD_SERVSUPL;
		a_cod_nivel(f)    := C1.COD_NIVEL;
		a_cod_servicio(f) := C1.COD_SERVICIO;
		f := f + 1;
	END LOOP;

	-- BUSCAMOS LOS SS A DESACTIVAR
	nNumError:=2;
	sMsgError:='Servicios a Desactivar';
	SELECT COD_SISTEMA
	  INTO sCodSistema
      FROM ICG_CENTRAL
     WHERE COD_CENTRAL = pCodCentral;

    -- CARGAMOS LOS SERVICIOS A DESACTIVAR
	f := 1;
  	FOR C1 IN SSDESACTIVA LOOP
		d_cod_servsupl(f) := C1.COD_SERVSUPL;
		d_cod_nivel(f)    := C1.COD_NIVEL;
		d_estado(f)    	  := C1.ESTADO;
		d_cod_servicio(f) := C1.COD_SERVICIO;
		f := f + 1;
	END LOOP;


    -- CARGAMOS LOS SERVICIOS A ACTIVAR
	nNumError:=3;
	sMsgError:='Servicios a Activar';
	f := 1;
  	FOR C1 IN SSACTIVAR LOOP
		c_cod_servsupl(f) := C1.COD_SERVSUPL;
		c_cod_nivel(f)    := C1.COD_NIVEL;
		c_estado(f)    	  := C1.ESTADO;
		c_cod_servicio(f) := C1.COD_SERVICIO;
		f := f + 1;

	END LOOP;

	-- CARGAMOS LOS SS DE DESACTIVAR AL ARREGLO FINAL
	nNumError:=4;
	sMsgError:='Cargamos Final con Desactivar';
	f := 1;
	IF d_cod_servsupl.count > 0 THEN
		FOR i IN d_cod_servsupl.FIRST..d_cod_servsupl.LAST LOOP
			f_cod_servsupl(f) := d_cod_servsupl(i);
			f_cod_nivel(f)    := d_cod_nivel(i);
			f_estado(f)    	  := d_estado(i);
			f_cod_servicio(f) := d_cod_servicio(i);
			f := f + 1;
		END LOOP;
	END IF;

	-- CARGAMOS LOS SS DE ACTIVAR AL ARREGLO FINAL
	nNumError:=5;
	sMsgError:='Cargamos Final con Activar';
	IF c_cod_servsupl.count > 0 THEN
		FOR i IN c_cod_servsupl.FIRST..c_cod_servsupl.LAST LOOP
			f_cod_servsupl(f) := c_cod_servsupl(i);
			f_cod_nivel(f)    := c_cod_nivel(i);
			f_estado(f)    	  := c_estado(i);
			f_cod_servicio(f) := c_cod_servicio(i);
			f := f + 1;
		END LOOP;
	END IF;

    dbms_output.put_line('Se cargaron SS DEL ABONADO -> ' || to_char(a_cod_servsupl.count));
    dbms_output.put_line('Se cargaron SS ACTIVAR     -> ' || to_char(c_cod_servsupl.count));
    dbms_output.put_line('Se cargaron SS DESACTIVAR  -> ' || to_char(d_cod_servsupl.count));
    dbms_output.put_line('Se cargaron SS FINAL       -> ' || to_char(f_cod_servsupl.count));

	-- RECORREMOS EL ARREGLO CON LOS SS FINAL PARA EL GESTOR CORPORATIVO
	nNumError:=6;
	sMsgError:='Gestor Corporativo';
	IF f_cod_servsupl.count > 0 THEN
		FOR i IN f_cod_servsupl.FIRST..f_cod_servsupl.LAST LOOP
		  	nCodServSuPl := f_cod_servsupl(i);
		    nCodNivel	 := f_cod_nivel(i);
  			sEstado		 := f_estado(i);
  			sCodServicio := f_cod_servicio(i);
  			sServicio    := f_cod_servicio(i);

			IF LTRIM(RTRIM(sEstado)) = 'A' THEN
				nNumError:=7;
				sMsgError:='Activamos Incompatibilidad';
		       -- Buscamos si existe incompatibilidad
			  	FOR C1 IN SSIMCOMPATIBLE LOOP
				    sServIncom := C1.COD_SERVDEF;
					-- Lo buscamos si en los ss del abonado
					IF a_cod_servsupl.count > 0 THEN
						FOR l IN a_cod_servsupl.FIRST..a_cod_servsupl.LAST LOOP
							IF sServIncom = a_cod_servicio(l) THEN
							   -- Marcamos el SS a Activar como Eliminado
							   -- ya que como existe incompatibilidad con un servicio
							   -- que ya tiene el abonado
							   f_estado(i) := 'E';
							   EXIT;
							END IF;
						END LOOP;
					END IF;
				END LOOP;
			ELSIF LTRIM(RTRIM(sEstado)) = 'D' THEN
			   --Buscamos los servicios a tranferir por concepto de Desactivacion
				nNumError:=8;
				sMsgError:='Desactivamos Transferencia';
			  	FOR C1 IN SSTRANSFERENCIA LOOP
				    sServTrans := C1.COD_SERVICIO;
					sServicio  := C1.COD_SERVICIO;
					-- Los cargamos a los SS Final
					-- Siempre y cuando no exista Incompatibilidad
					nNumError:=9;
					sMsgError:='Desactivamos Incompatibilidad';
					nEcontrado := 0;
				  	FOR C2 IN SSIMCOMPATIBLE LOOP
					    sServIncom := C2.COD_SERVDEF;
						IF a_cod_servsupl.count > 0 THEN
							FOR l IN a_cod_servsupl.FIRST..a_cod_servsupl.LAST LOOP
								IF sServIncom = a_cod_servicio(l) THEN
								   -- Marcamos el SS a Activar como Eliminado
								   -- ya que como existe incompatibilidad con un servicio
								   -- que ya tiene el abonado
								   nEcontrado := 1;
								   EXIT;
								END IF;
							END LOOP;
						END IF;
					END LOOP;
					IF nEcontrado = 0 THEN -- Quiere decir que no existe incompatibilidad
					   f := f_cod_servsupl.count + 1;
					   f_cod_servsupl(f) := C1.COD_SERVSUPL;
					   f_cod_nivel(f)    := C1.COD_NIVEL;
					   f_estado(f)    	  :=C1.ESTADO;
					   f_cod_servicio(f) := C1.COD_SERVICIO;
					END IF;
				END LOOP;
			END IF;

		END LOOP;
	END IF;


	-- AHORA COMENZAMOS A ACTIVAR Y DESACTIVAR LOS SS
	nNumError:=10;
	sMsgError:='Comenzamos a Activar y Desactivar';
	IF f_cod_servsupl.count > 0 THEN
	   FOR i IN f_cod_servsupl.FIRST..f_cod_servsupl.LAST LOOP
		   nCodServSuPl := f_cod_servsupl(i);
		   nCodNivel	:= f_cod_nivel(i);
  		   sEstado		:= f_estado(i);
  		   sCodServicio := f_cod_servicio(i);
		   sServicio    := f_cod_servicio(i);
		   nEcontrado   := 0;
		   -- Buscamos el servicio en los del abonado
		   IF a_cod_servsupl.count > 0 THEN
		      FOR l IN a_cod_servsupl.FIRST..a_cod_servsupl.LAST LOOP
				  a_nCodServSuPl := a_cod_servsupl(l);
				  a_nCodNivel	  := a_cod_nivel(l);
		  		  a_sCodServicio := a_cod_servicio(l);
			      IF nCodServSuPl = a_cod_servsupl(l) THEN
		  		     nEcontrado   := 1;
					 exit;
		 		  END IF;
		   	  END LOOP;
		   END IF;
		   IF nEcontrado = 0 THEN --NO LO ENCONTRO
		      IF LTRIM(RTRIM(sEstado)) = 'A' THEN
			     --Activamos el SS
				 PV_ACTDES_SS_PR(pAbonado,pCelular,'A',sCodServicio,nCodServSupl,nCodNivel,pFecCambio,pIndCentral,
								  pError,pMsgError);

				 if pError <> 0 then
					nNumError:=10.1;
					sMsgError:='Activar No encontrado';
				    raise error_proceso;
				 end if;

	             sGrupo := LTRIM(RTRIM(TO_CHAR(nCodServSuPl,'00')));
	             sNivel := LTRIM(RTRIM(TO_CHAR(nCodNivel,'0000')));
	             sCadenaICC := sCadenaICC || sGrupo || sNivel;

			  END IF;
		   ELSE -- LO ENCONTRO
		      IF LTRIM(RTRIM(sEstado)) = 'D' THEN
			     --DesActivamos el SS
				 PV_ACTDES_SS_PR(pAbonado,pCelular,'D',sCodServicio,nCodServSupl,nCodNivel,pFecCambio,pIndCentral,
								  pError,pMsgError);

				 if pError <> 0 then
					nNumError:=10.2;
					sMsgError:='Desactivar Encontrado';
				    raise error_proceso;
				 end if;

	             sGrupo := LTRIM(RTRIM(TO_CHAR(nCodServSuPl,'00')));
	             sNivel := LTRIM(RTRIM(TO_CHAR(nCodNivel,'0000')));
	             sCadenaICC := sCadenaICC || sGrupo || sNivel;

		      ELSIF LTRIM(RTRIM(sEstado)) = 'A' THEN

			  	 IF nCodNivel <> a_nCodNivel THEN
				    sServicio  := a_sCodServicio;
				    --Buscamos los servicios a tranferir por concepto de Desactivacion
				  	FOR C1 IN SSTRANSFERENCIA LOOP
					    sServTrans := C1.COD_SERVICIO;
						sServicio  := C1.COD_SERVICIO;
						-- Los cargamos a los SS Final
						-- Siempre y cuando no exista Incompatibilidad
						nEcontrado := 0;
					  	FOR C2 IN SSIMCOMPATIBLE LOOP
						    sServIncom := C2.COD_SERVDEF;
							IF a_cod_servsupl.count > 0 THEN
								FOR m IN a_cod_servsupl.FIRST..a_cod_servsupl.LAST LOOP
									IF sServIncom = a_cod_servicio(m) THEN
									   -- Marcamos el SS a Activar como Eliminado
									   -- ya que como existe incompatibilidad con un servicio
									   -- que ya tiene el abonado
									   nEcontrado := 1;
									   EXIT;
									END IF;
								END LOOP;
							END IF;
						END LOOP;
						IF nEcontrado = 0 THEN -- Quiere decir que no existe incompatibilidad
						   f := f_cod_servsupl.count + 1;
						   f_cod_servsupl(f) := C1.COD_SERVSUPL;
						   f_cod_nivel(f)    := C1.COD_NIVEL;
						   f_estado(f)    	 := C1.ESTADO;
						   f_cod_servicio(f) := C1.COD_SERVICIO;
						END IF;
					END LOOP;

				     --DesActivamos el SS del Abonado
					 PV_ACTDES_SS_PR(pAbonado ,pCelular ,'D' ,a_sCodServicio ,a_nCodServSuPl ,a_nCodNivel ,pFecCambio,pIndCentral,
									 pError   ,pMsgError );

					 if pError <> 0 then
						nNumError:=10.2;
						sMsgError:='Desactivar Encontrado del Abonado';
					    raise error_proceso;
					 end if;

				     --Activamos el SS Final
					 PV_ACTDES_SS_PR(pAbonado ,pCelular ,'A' ,sCodServicio ,nCodServSupl ,nCodNivel ,pFecCambio,pIndCentral,
									 pError   ,pMsgError );

					 if pError <> 0 then
						nNumError:=10.3;
						sMsgError:='Activar Encontrado';
					    raise error_proceso;
					 end if;

		             sGrupo := LTRIM(RTRIM(TO_CHAR(nCodServSuPl,'00')));
		             sNivel := LTRIM(RTRIM(TO_CHAR(nCodNivel,'0000')));
		             sCadenaICC := sCadenaICC || sGrupo || sNivel;

			     END IF;

			  END IF;

		   END IF;
	   END LOOP;
	END IF;

	nNumError:=11;
	sMsgError:='Generacion de la Cadena para la ICC';


	IF (LTRIM(RTRIM(sCadenaICC)) <> ' ' OR sCadenaICC IS NOT NULL) and pIndCentral = 1 THEN

        i := 6;
        sCadenaICC2 := '';

        WHILE i <= 255 LOOP
          sGrupo1 := '';
          sNivel1 := '';
          sw := 0;
          j := i - 5;
          j1 := i - 3;

          sGrupo1 := substr(sCadenaICC, j, 2);
          sNivel1 := substr(sCadenaICC, j1, 4);
          X := 6;

          IF LTRIM(RTRIM(sGrupo1)) = '' OR sGrupo1 IS NULL THEN
             X := 256;
             i := 256;
          END IF;

          countgrup := 0;
          WHILE X <= 255 LOOP
              j := X - 5;
              j1 := X - 3;
              sGrupo2 := '';
              sNivel2 := '';
              sGrupo2 := substr(sCadenaICC, j, 2);
              sNivel2 := substr(sCadenaICC, j1, 4);

              IF (sGrupo2 = sGrupo1) THEN
                  countgrup := countgrup + 1;
              END IF;

              IF (sGrupo2 = sGrupo1 AND to_number(lTrim(rtrim(sNivel2))) > to_number(lTrim(rtrim(sNivel1)))) THEN
                 sw := 1;
                 X  := 256;
              END IF;
              X := X + 6;
          END LOOP;

          IF sw = 1 THEN
              sCadenaICC2 := sCadenaICC2 || sGrupo2 || sNivel2;
          ELSE
              IF countgrup = 1 THEN
                 sCadenaICC2 := sCadenaICC2 || sGrupo1 || sNivel1;
              END IF;
          END IF;
          i := i + 6;
        END LOOP;

		--insertamos el registro en la iccmovimiento.
		nNumError:=12;
		sMsgError:='Insertamos la Cadena en la ICC';

		SELECT ICC_SEQ_NUMMOV.NEXTVAL
		  INTO nNumMovimiento
		  FROM DUAL;

		nNumError:=13;
		sMsgError:='No existe una actuacion de centrales';

		SELECT FN_CODACTCEN (1,sCodActAbo,'GA',pCodTecnologia)
		  INTO nCodActuacion
		  FROM DUAL;

		nNumError:=14;
		sMsgError:='No Exite Prefijo de Numero';
		SELECT AL_FN_PREFIJO_NUMERO(pCelular)
		  INTO sNumMin
		  FROM DUAL;

		nNumError:=15;
		sMsgError:='Calcular IMSI';


		--Grupo GSM
		-- INI TMM_04026
 	    sCodTecnologia := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM');

		IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(pCodTecnologia) = sCodTecnologia  THEN
		-- FIN TMM_04026
		   SELECT FN_RECUPERA_IMSI(pNumSerie)
		     INTO v_IMSI
    		 FROM DUAL;
		   v_IMEI := pNumImei;
		   v_ICC	 := pNumSerie;
		ELSE
		  v_IMSI := NULL;
		  v_IMEI := NULL;
		  v_ICC	 := NULL;
		END IF;

      -- INI TMM_04026
		/*
		INSERT INTO ICC_MOVIMIENTO (NUM_MOVIMIENTO, NUM_ABONADO   , NUM_CELULAR, COD_ESTADO  , COD_MODULO,
			   					   	COD_ACTUACION , NOM_USUARORA  , FEC_INGRESO, COD_CENTRAL , NUM_SERIE ,
									COD_SERVICIOS , TIP_TERMINAL  , COD_ACTABO,
									NUM_MIN       , TIP_TECNOLOGIA, IMSI       , IMEI        ,ICC )
						 	VALUES (nNumMovimiento, pAbonado      , pCelular   , 1           , 'GA',
								    nCodActuacion , USER		  ,	pFecCambio , pCodCentral , ' ',
									sCadenaICC2   , pTipTerminal  , sCodActAbo ,
									sNumMin		  , pCodTecnologia, v_IMSI	   , v_IMEI		 ,v_ICC);

        */


		SELECT PV_ERRORES_SQ.NEXTVAL INTO V_NUMERROR FROM DUAL;
		GA_APROVISIONAR_CENTRAL_PG.GA_APROVISIONAR_PV_PR(nNumMovimiento,pAbonado,1,sCodActAbo,'GA',user,pFecCambio,pTipTerminal,
		                        pCodCentral,0,'',pCelular,'','','','',sCadenaICC2,sNumMin,'',pCodTecnologia,
								'',v_IMEI,'','','','','','','','',V_NUMERROR,1,0);
      -- FIN TMM_04026
	END IF;


	nNumError:=0;
	sMsgError:='Fin Operacion';
	sNOM_PROC:='PV_SSGENERA_SCL_PR';

  	RAISE ERROR_PROCESO;

EXCEPTION

    WHEN ERROR_PROCESO THEN

         pError:=nNumError;
         pMsgError:=sMsgError;

END;
/
SHOW ERRORS
