CREATE OR REPLACE PROCEDURE PV_PR_MENSAJES(
    nNUM_ABONADO  	IN NUMBER,		-- Numero de Abonado
	nNUM_OOSS 		IN NUMBER,  	-- Numero de OOSS
	nCOD_OS			IN NUMBER,		-- Codigo de OOSS
	vNOM_USUARORA  	IN VARCHAR2,	-- Usuario Responsable
    sPARAM1			IN VARCHAR2,    -- Primer Parametro Mensaje
    sPARAM2			IN VARCHAR2,    -- Segundo Parametro Mensaje
	sPARAM3			IN VARCHAR2,    -- Tercer Parametro Mensaje
	nCOD_ERROR		OUT NUMBER,		-- Codigo de Error
	sMEN_ERROR		OUT VARCHAR2	-- Mensaje de Error
)
IS

	nNumError			NUMBER (2);   -- numero de error
	sMsgError			varchar(55);  -- mensaje de error

	nNumCelular			GA_ABOCEL.NUM_CELULAR%TYPE;
	vNumSerie			GA_ABOCEL.NUM_SERIEHEX%TYPE;
	nCodProducto		GA_ABOCEL.COD_PRODUCTO%TYPE;
	vFecSys				DATE;
	vCodModulo			GED_PARAMETROS.COD_MODULO%TYPE;
	nNumMin				GA_ABOCEL.NUM_MIN%TYPE;
	nCodCentral			ICG_MENSAJE.COD_CENTRAL%TYPE;
	vTipTerminal		GA_ABOCEL.TIP_TERMINAL%TYPE;
	nCodMensaje			ICG_MENSAJE.COD_MENSAJE%TYPE;
	vNomParametro		GED_PARAMETROS.NOM_PARAMETRO%TYPE;
	vValParametro		GED_PARAMETROS.VAL_PARAMETRO%TYPE;
	nCodActcen			GA_ACTABO.COD_ACTCEN%TYPE;
	nCodCliente			GA_ABOCEL.COD_CLIENTE%TYPE;
	vIdioma				VARCHAR2(5);
	vMensaje		    GE_MULTIIDIOMA.DES_CONCEPTO%TYPE;
	nEncontro           NUMBER(5);

	ERROR_PROCESO EXCEPTION;


	sNOM_TABLA 	 GA_ERRORES.NOM_TABLA%TYPE;
	sNOM_PROC	 GA_ERRORES.NOM_PROC%TYPE;
	sCOD_ACT	 GA_ERRORES.COD_ACT%TYPE;
	sCOD_SQLCODE GA_ERRORES.COD_SQLCODE%TYPE;
	sCOD_SQLERRM GA_ERRORES.COD_SQLERRM%TYPE;
	sERROR		 VARCHAR2(2);

BEGIN

	 -- Inicializacion de Variables
	 nNumError:=0;
	 sMsgError:='Operacion Exitosa';
	 vFecSys:=SYSDATE;
	 sNOM_PROC:='PV_PR_MENSAJES';
	 vCodModulo:='GA';


	 	  BEGIN
 	  	   	   -- Seleccion de Datos del Abonado Suspendido
   	  	   	   nNumError := 1;
	  	   	   sMsgError := 'Error, al seleccionar desde GA_ABOCEL';
	  	   	   sNOM_TABLA:='GA_ABOCEL';
	  	   	   sCOD_ACT:='S';

	  	   	   SELECT NUM_CELULAR,NUM_MIN,NUM_SERIEHEX,COD_PRODUCTO,
					  TIP_TERMINAL,COD_CLIENTE
		   	   INTO nNumCelular,nNumMin,vNumSerie,nCodProducto,vTipTerminal,nCodCliente
	  	   	   FROM GA_ABOCEL
		   	   WHERE NUM_ABONADO =nNUM_ABONADO;


		   EXCEPTION
		   			WHEN NO_DATA_FOUND THEN
					BEGIN

 	  	   	   			 -- Seleccion de Datos del Abonado Suspendido
   	  	   	   			 	nNumError := 1;
	  	   	   				sMsgError := 'Error, al seleccionar desde GA_ABOAMIST';
	  	   	   				sNOM_TABLA:='GA_ABOAMIST';
	  	   	   				sCOD_ACT:='S';

	  	   	   				SELECT NUM_CELULAR,NUM_MIN,NUM_SERIEHEX,COD_PRODUCTO,
					  		TIP_TERMINAL,COD_CLIENTE
		   	   				INTO nNumCelular,nNumMin,vNumSerie,nCodProducto,vTipTerminal,nCodCliente
	  	   	   				FROM GA_ABOAMIST
		   	   				WHERE NUM_ABONADO =nNUM_ABONADO;

					EXCEPTION
							 WHEN OTHERS THEN
							 	  RAISE ERROR_PROCESO;
		            END;
		  END;

		  IF vTipTerminal='D' THEN
		  BEGIN

		   		-- Seleccion de Datos del Abonado Suspendido
	 	  	   	   		nNumError := 2;
	 	   	   		sMsgError := 'Error, al seleccionar Mensaje desde CI_TIPORSERV';
	 	   	   		sNOM_TABLA:='CI_TIPORSERV';
	 	   	   		sCOD_ACT:='S';

		  	   	SELECT COD_MENSAJE
			    INTO nCodMensaje
			    FROM CI_TIPORSERV
			    WHERE COD_OS= nCOD_OS;


 	  	   	   -- Seleccion de Datos del Abonado Suspendido
   	  	   	   nNumError := 3;
	  	   	   sMsgError := 'Error, al ejecutar PL: PV_PR_DEVALMACEN';
	  	   	   sNOM_TABLA:='PV_PR_DEVALMACEN';
	  	   	   sCOD_ACT:='E';

			   vNomParametro:='MENSAJE_PV';

 	  	   	   PV_PR_DEVVALPARAM('GA',nCodProducto,vNomParametro,vValParametro);

 	  	   	   -- Seleccion de Datos del Abonado Suspendido
   	  	   	   nNumError := 4;
	  	   	   sMsgError := 'Error, al seleccionar desde GA_ACTABO';
	  	   	   sNOM_TABLA:='GA_ACTABO';
	  	   	   sCOD_ACT:='S';

			IF nCodMensaje <> NULL THEN
			   BEGIN

					   SELECT COD_ACTCEN
					   INTO nCodActcen
					   FROM GA_ACTABO
					   WHERE COD_PRODUCTO=nCodProducto
					   AND COD_ACTABO=vValParametro;

		 	  	   	   -- Seleccion de Central asociada al mensaje
		   	  	   	   nNumError := 5;
			  	   	   sMsgError := 'Error, al seleccionar desde ICG_CENTRAL';
			  	   	   sNOM_TABLA:='ICG_MENSAJE';
			  	   	   sCOD_ACT:='S';

					   SELECT COD_CENTRAL
					   INTO nCodCentral
					   FROM ICG_MENSAJE
					   WHERE COD_PRODUCTO=nCodProducto
					   AND COD_MENSAJE=nCodMensaje;


		 	  	   	   -- Seleccion de Datos del Abonado Suspendido
		   	  	   	   nNumError := 6;
			  	   	   sMsgError := 'Error, al insertar en ICC_MOVIMIENTO';
			  	   	   sNOM_TABLA:='ICC_MOVIMIENTO';
			  	   	   sCOD_ACT:='I';

		  		  	   -- Obtenemos el Idioma del Cliente
		   	  	   	   nNumError := 7;
			  	   	   sMsgError := 'Error, al Recuperar Idioma';
			  	   	   sNOM_TABLA:='ge_fn_idioma_cliente';

					   SELECT ge_fn_idioma_cliente(nCodCliente)
					     INTO vIdioma
					     FROM DUAL;

					   -- Obtenemos texto del Mensaje
		   	  	   	   nNumError := 8;
			  	   	   sMsgError := 'Error, al Obtener Texto del Mensaje';
			  	   	   sNOM_TABLA:='GE_MULTIIDIOMA';

					   SELECT a.DES_CONCEPTO
					     INTO vMensaje
						 FROM GE_MULTIIDIOMA A, ICG_MENSAJE B
						WHERE a.nom_tabla = 'ICG_MENSAJE'
						  AND a.nom_campo = 'COD_MENSAJE'
						  AND a.cod_producto = 1
						  AND a.cod_concepto = nCodMensaje
						  AND a.cod_idioma = vIdioma
						  AND b.cod_producto = a.cod_producto
						  AND b.COD_MENSAJE = a.cod_concepto;

					   -- Construimos el Mensaje
		    	  	   	  nNumError := 9;
			    	   	  sMsgError := 'Error, al Construir el Mensaje';
			    	   	  sNOM_TABLA:= 'GE_MULTIIDIOMA';


					   	dbms_output.put_line ('Mensaje : ' || vMensaje);

						select instr(vMensaje,'<p1>')
						  into nEncontro
						  From Dual;

		  			     -- dbms_output.put_line ('Encontro Parametro 1 : ' || nEncontro);

						 IF nEncontro > 0 and sParam1 is not null THEN

							vMensaje := SUBSTR(vMensaje,1,nEncontro-1) || sParam1 || SUBSTR(vMensaje,nEncontro + 4);

						 END IF;

						 select instr(vMensaje,'<p2>')
						   into nEncontro
						  From Dual;

					     --	 dbms_output.put_line ('Encontro Parametro 2 : ' || nEncontro);

						 IF nEncontro > 0 and sParam2 is not null THEN

							vMensaje := SUBSTR(vMensaje,1,nEncontro-1) || sParam2 || SUBSTR(vMensaje,nEncontro + 4);

						 END IF;

						 select instr(vMensaje,'<p3>')
						   into nEncontro
						  From Dual;

					--	 dbms_output.put_line ('Encontro Parametro 3 : ' || nEncontro);

						 IF nEncontro > 0 and sParam3 is not null THEN

							vMensaje := SUBSTR(vMensaje,1,nEncontro-1) || sParam3 || SUBSTR(vMensaje,nEncontro + 4);

						 END IF;

		 --  			   dbms_output.put_line ('Mensaje : ' || vMensaje);


			  	   	   INSERT INTO ICC_MOVIMIENTO (NUM_MOVIMIENTO,NUM_ABONADO,COD_ESTADO,COD_MODULO,NOM_USUARORA,
					   COD_CENTRAL,NUM_CELULAR,COD_ACTUACION,FEC_INGRESO,NUM_SERIE,COD_SERVICIOS,TIP_TERMINAL,
					   COD_ACTABO,NUM_MIN, COD_MENSAJE,DES_MENSAJE, PARAM1_MENS, PARAM2_MENS, PARAM3_MENS)
					   VALUES(ICC_SEQ_NUMMOV.NEXTVAL,nNUM_ABONADO,1,vCodModulo,vNOM_USUARORA,nCodCentral,nNumCelular,
					   nCodActcen,vFecSys,vNumSerie,NULL,vTipTerminal,vValParametro,nNumMin,nCodMensaje,vMensaje,sParam1,
					   sParam2,sParam3);


				  	   EXCEPTION
				  	   WHEN OTHERS THEN
					   		RAISE ERROR_PROCESO;

					nCOD_ERROR:=0;
					sMEN_ERROR:='Operacion Exitosa';
				END;
				ELSE
				BEGIN
				      nNumError := 10;
	 	   	   		  sMsgError := 'No existe Mensaje desde CI_TIPORSERV';
	 	   	   		  sNOM_TABLA:='CI_TIPORSERV';
	 	   	   		  sCOD_ACT:='S';
					  RAISE ERROR_PROCESO;

				END;

				END IF;
		  END;
		  END IF;



EXCEPTION


	WHEN ERROR_PROCESO THEN


		  sCOD_SQLCODE:=SQLCODE;
		  sCOD_SQLERRM:=SQLERRM;

  	 	  --ROLLBACK;

	   	  INSERT INTO GA_ERRORES(COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,NOM_PROC,
		  NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
		  VALUES(vValParametro,nNUM_ABONADO,vFecSys,1,sNOM_PROC,sNOM_TABLA,sCOD_ACT,
		  sCOD_SQLCODE,sCOD_SQLERRM);

		  --COMMIT;

		  nCOD_ERROR:=nNumError;
		  sMEN_ERROR:=sMsgError;




END;
/
SHOW ERRORS
