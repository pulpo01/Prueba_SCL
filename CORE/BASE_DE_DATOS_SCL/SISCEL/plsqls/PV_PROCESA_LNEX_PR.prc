CREATE OR REPLACE PROCEDURE PV_PROCESA_LNEX_PR(pAccion     IN varchar2,
			   	  		  					   pOperadora  IN number,
											   pFecIngLn   IN number,
											   pMarca	   IN varchar2,
											   pModelo	   IN varchar2,
											   pTecnologia IN varchar2,
											   pTipAbonado IN varchar2,
											   pNumSerie   IN varchar2,
											   pFecConsPol IN number,
											   pNumConsPol IN varchar2,
											   pCausa	   IN number,
											   pError	  OUT number,
											   pMsgError  OUT varchar2
	   	  		  					   )
IS

  nAbonado		   ga_abocel.num_abonado%type;
  v_proceso        VARCHAR2(25);

  sMensaje		   varchar2(150);
  nTraza		   NUMBER(2);
  sMsgTraza		   VARCHAR2(100);
  dFecIngreso	   DATE;
  dFecConsPol	   DATE;
  sFecIngreso	   varchar2(10);
  sFecConsPol	   varchar2(10);
  sTipoAbonado	   varchar2(20);
  v_Formato_Sel2   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  v_Formato_Sel9   GED_PARAMETROS.VAL_PARAMETRO%TYPE;

  ErrorProceso	   exception;

--	 Autor     : Christian Estay M. (Posventa)
--   Fecha     : 10/11/2003
--	 Comentario; Realiza la Inscripcion en la lista Negra de la Serie Informada por
--	 			 Otras Operadoras(EXTERNAS).

BEGIN


	 nTraza := 0;
	 sMsgTraza := 'Formato de Fecha Invalido';

 	 v_Formato_Sel2 :=GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL2');
	 v_Formato_Sel9 :=GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL9');

	 dbms_output.put_line('Antes del formato ');

  	 sFecIngreso := to_char(pFecIngLn);
     dfecingreso := to_date(sfecingreso,v_Formato_Sel9);
     dfecingreso := to_date(to_char(dfecingreso,v_Formato_Sel2),v_Formato_Sel2);

  	 sFecConsPol := to_char(pFecConsPol);
     dFecConsPol := to_date(sFecConsPol,v_Formato_Sel9);
     dFecConsPol := to_date(to_char(dFecConsPol,v_Formato_Sel2),v_Formato_Sel2);


     dbms_output.put_line('Fecha Ingreso  DATE -> ' || to_char(dfecingreso,v_Formato_Sel2));
     dbms_output.put_line('Fecha Policial DATE -> ' || to_char(dFecConsPol,v_Formato_Sel2));
 	 dbms_output.put_line('Despues del formato ');

	 BEGIN

		 --Validar Consistencia de  Registro
		 nTraza    := 1;
		 sMsgTraza := 'Revisando Operadora Valida';

		 SELECT COD_OPERADOR
		   INTO v_proceso
	 	   FROM TA_OPERADORES
		  WHERE COD_OPERADOR = pOperadora;

     EXCEPTION
	     WHEN NO_DATA_FOUND THEN
		 	  RAISE ErrorProceso;

	 END;


	 IF pTipAbonado NOT IN ('C','P') THEN
		nTraza    := 11;
		sMsgTraza := 'No se Identifico Tipo de Abonado';
 	    RAISE ErrorProceso;
	 END IF;

	 IF pAccion = 'I' THEN
	 	 -- INSERTAMOS EL REGISTRO
		 IF LTRIM(RTRIM(pTecnologia)) = 'GSM' THEN
		    -- GSM INSERTAMOS DIRECTO A LN
			nAbonado  := 0;
			nTraza    := 4;
			sMsgTraza := 'Error al Insertar Serie en GA_LNCELU';
			BEGIN
			    INSERT INTO GA_LNCELU(NUM_SERIE, IND_PROCEQUI, COD_OPERADOR, COD_FABRICANTE, COD_ARTICULO,
					   				  FEC_ALTA , FEC_CONSTPOL, NUM_CONSTPOL, TIP_ABONADO, COD_CAUSA)
							   VALUES(pNumSerie,'E',pOperadora, 8, 62,
			 				   		  dFecIngreso,	dFecConsPol, pNumConsPol ,pTipAbonado, pCausa);
            EXCEPTION
			    WHEN DUP_VAL_ON_INDEX THEN
					 nTraza    := 41;
					 sMsgTraza := 'Serie ya existe en GA_LNCELU';
					 dbms_output.put_line('Error -> ' || sMsgTraza);
			  		 RAISE ErrorProceso;
				WHEN OTHERS THEN
			 	     RAISE ErrorProceso;
			END;
	 	 ELSIF LTRIM(RTRIM(pTecnologia)) = 'TDMA' THEN
		    -- TDMA VALIDAMOS SI LA SERIE EXISTE
		  	nAbonado := null;
			BEGIN
			   sTipoAbonado := 'CONTRATO';
			   SELECT NUM_ABONADO
			     INTO nAbonado
			     FROM GA_ABOCEL
				WHERE NUM_SERIE = pNumSerie
				  AND COD_SITUACION <> 'BAA';

	     	EXCEPTION
			    WHEN NO_DATA_FOUND THEN
		  		  	 nAbonado := null;
			         sTipoAbonado := 'PREPAGO';
					 BEGIN
						   SELECT NUM_ABONADO
						     INTO nAbonado
						     FROM GA_ABOAMIST
							WHERE NUM_SERIE = pNumSerie
							  AND COD_SITUACION <> 'BAA';
				     EXCEPTION
						    WHEN NO_DATA_FOUND THEN
					  		  	 v_proceso := null;
					 END;
			END;

			IF nAbonado IS NOT NULL THEN
			   nTraza    := 4;
			   sMsgTraza := 'Existe Serie en SCL en ' || ltrim(rtrim(sTipoAbonado));
		  	   RAISE ErrorProceso;
			ELSE
			    -- INGRESAMOS LA SERIE A LISTA NEGRA.
				nAbonado  := 0;
				nTraza    := 5;
				sMsgTraza := 'Error al Insertar Serie en GA_LNCELU';
				BEGIN

				    INSERT INTO GA_LNCELU(NUM_SERIE, IND_PROCEQUI, COD_OPERADOR, COD_FABRICANTE, COD_ARTICULO,
						   				  FEC_ALTA , FEC_CONSTPOL, NUM_CONSTPOL, TIP_ABONADO, COD_CAUSA)
							   VALUES(pNumSerie,'E',pOperadora, 8, 62,
			 				   		  dFecIngreso,	dFecConsPol, pNumConsPol ,pTipAbonado, pCausa);
	            EXCEPTION
				    WHEN DUP_VAL_ON_INDEX THEN
						 nTraza    := 51;
						 sMsgTraza := 'Serie ya existe en GA_LNCELU';
				  		 RAISE ErrorProceso;
					WHEN OTHERS THEN
				 	     RAISE ErrorProceso;
				END;
			END IF;
		 ELSE
		     nAbonado  := 0;
			 nTraza    := 3;
			 sMsgTraza := 'Falta Identificar Tecnologia';
			 RAISE ErrorProceso;
		 END IF;

	 ELSIF pAccion = 'E' THEN
	 	 -- ELIMINAMOS LA SERIE DE LA LN
		   DELETE FROM GA_LNCELU
		    WHERE NUM_SERIE = pNumSerie;

			IF SQL%ROWCOUNT = 0 THEN
			     nAbonado  := 0;
				 nTraza    := 31;
				 sMsgTraza := 'Serie No existe en SCL para Eliminar';
				 RAISE ErrorProceso;
		    END IF;

	 ELSE
		 nTraza    := 2;
		 sMsgTraza := 'Falta Identificar Accion';
		 RAISE ErrorProceso;
	 END IF;

	 nTraza    := 0;
	 sMsgTraza := 'Proceso Exitoso';
	 RAISE ErrorProceso;


EXCEPTION
	WHEN ErrorProceso THEN
		 IF nTraza > 0 THEN
			-- INSERTAMOS EL REGISTRO EN LA TABLA DE GESTION DE ERRORES Y DE GENERACION DE LISTADO
			-- PARA PROCESAR AVISOS DE SINIESTROS ADMINISTRATIVAMENTE.
			dbms_output.put_line('Error ' || sMsgTraza);

			sMensaje := pAccion || '|' || to_char(pOperadora,'00000') || '|' || to_char(pFecIngLn) || '|' || pMarca    || '|' ||
					    pModelo	|| '|' || pTecnologia                 || '|' || pTipAbonado        || '|' || pNumSerie || '|' ||
						to_char(pFecConsPol) || '|' || pNumConsPol || '|' || to_char(pCausa);

			    BEGIN

					INSERT INTO PV_SERIELN_ERROR_TO(NUM_ABONADO, FEC_INGRESO, COD_TECNOLOGIA, TIP_ABONADO, NUM_SERIE,
						   							COD_TRAZA,DES_TRAZA,MENSAJE)
										     VALUES(nAbonado,dFecIngreso,pTecnologia,pTipAbonado,pNumSerie,
											 		nTraza,sMsgTraza,sMensaje);
	            EXCEPTION
				    WHEN DUP_VAL_ON_INDEX THEN
					     NULL;
					WHEN OTHERS THEN
						 NULL;
				END;

		 END IF;

	     pError := 0;
		 pMsgError := sMsgTraza;

    WHEN OTHERS THEN
         pError := 4;
		 pMsgError := 'Error Inesperado ->' || ltrim(rtrim(sMsgTraza));

END;
/
SHOW ERRORS
