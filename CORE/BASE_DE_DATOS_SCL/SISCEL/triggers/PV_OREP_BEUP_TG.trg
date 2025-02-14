CREATE OR REPLACE TRIGGER PV_OREP_BEUP_TG
BEFORE UPDATE ON SP_ORDENES_REPARACION
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
/*
<Documentación TipoDoc = "Trigger">
<Elemento Nombre = "PV_OREP_BEUP_TG Lenguaje="PL/SQL" Fecha="25-05-2005" Versión="1.0" Programador="Yury Alvarez Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Actualiza los valores tipo y Monto de Descuento.</Descripción>
</Elemento>
</Documentación>
*/

TV_SERIEREM       SP_ORDENES_REPARACION.NUM_SERIE_REEM%TYPE;
TV_SERIE          SP_ORDENES_REPARACION.NUM_SERIE%TYPE;
TN_ABONADO        SP_ORDENES_REPARACION.NUM_ABONADO%TYPE;
TN_CODESTAD       SP_ORDENES_REPARACION.COD_ESTADO_ORDEN%TYPE;

CV_NOMPARAMIND	  CONSTANT GA_PARAMETROS_SISTEMA_VW.NOM_PARAMETRO%TYPE:='EQUIPO_INTERNO';
CV_MODULO         CONSTANT GED_PARAMETROS.COD_MODULO%TYPE    :='GA';
CV_NOMPARAM       CONSTANT GED_PARAMETROS.NOM_PARAMETRO%TYPE :='COD_SIMCARD_GSM';
CN_PRODUCTO       CONSTANT GED_PARAMETROS.COD_PRODUCTO%TYPE  := 1;
CN_CODESTOR       CONSTANT SP_ORDENES_REPARACION.COD_ESTADO_ORDEN%TYPE := 14;
CN_CODESTORING	  CONSTANT SP_ORDENES_REPARACION.COD_ESTADO_ORDEN%TYPE := 2;

CV_PROCEQUI       GA_EQUIPABOSER.IND_PROCEQUI%TYPE;
TV_VALPARAM       GED_PARAMETROS.VAL_PARAMETRO%TYPE;

TN_IMPCARGO       GA_EQUIPABOSER.IMP_CARGO%TYPE;
TN_TIPDTO         GA_EQUIPABOSER.TIP_DTO%TYPE;
TN_VALDTO         GA_EQUIPABOSER.VAL_DTO %TYPE;


GN_SECUENCIA	  NUMBER;
GN_NOMPROC		  CONSTANT GA_ERRORES.NOM_PROC%TYPE:='PV_OREP_BEUP_TG';
GN_OPERLOCAL	  GE_OPERADORA_SCL.COD_OPERADORA_SCL%TYPE;
GV_ACTABO		  GA_ACTABO.COD_ACTABO%TYPE:='VA';
GN_SQLCODE		  NUMBER;
GV_SQLERRM		  VARCHAR2(255);

TV_VALPARAM_ECU   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
CV_NOMPARAM_ECU    CONSTANT GED_PARAMETROS.NOM_PARAMETRO%TYPE :='APLIC_CARGOS_INDEM';
CV_TRUE           GED_PARAMETROS.VAL_PARAMETRO%TYPE :='TRUE' ;

ERROR_SEC EXCEPTION;

BEGIN

	TV_VALPARAM :='';

	TV_VALPARAM := GE_FN_DEVVALPARAM (CV_MODULO,CN_PRODUCTO,CV_NOMPARAM);

    GN_OPERLOCAL:= GE_FN_OPERADORA_SCL();

    TV_VALPARAM_ECU:= GE_FN_DEVVALPARAM (CV_MODULO,CN_PRODUCTO,CV_NOMPARAM_ECU);
    IF  (TV_VALPARAM_ECU = CV_TRUE) THEN --HABILITADO PARA ECUADOR


			BEGIN
				 GN_SECUENCIA     := '1';
				 IF GN_OPERLOCAL IS NOT NULL THEN
				 	BEGIN
						SELECT valor_texto
						  INTO CV_PROCEQUI
						  FROM GA_PARAMETROS_SISTEMA_VW
						 WHERE nom_parametro = CV_NOMPARAMIND
						   AND cod_operadora = GN_OPERLOCAL;

				 		   EXCEPTION
						   		WHEN NO_DATA_FOUND THEN
								      NULL;
									 GN_SECUENCIA := '2';
									 GN_SQLCODE   := SQLCODE;
			           				 GV_SQLERRM   := SQLERRM;
									 RAISE ERROR_SEC;
					END;
				 ELSE
				 	GV_SQLERRM := 'No se ha encontrado Operadora Local';
				 END IF;
			END;

			 TN_CODESTAD := :NEW.COD_ESTADO_ORDEN;
			 TV_SERIEREM := :NEW.NUM_SERIE_REEM;
			 TV_SERIE    := :NEW.NUM_SERIE;
			 TN_ABONADO  := :NEW.NUM_ABONADO;


		     IF TN_CODESTAD = CN_CODESTORING THEN

			       BEGIN
						SELECT a.imp_cargo
						, a.tip_dto
						, a.val_dto
						INTO  TN_IMPCARGO, TN_TIPDTO, TN_VALDTO
						FROM  GA_EQUIPABOSER a
						WHERE a.num_abonado   = TN_ABONADO
						AND   a.ind_procequi  = CV_PROCEQUI
						AND   NOT a.tip_terminal = TV_VALPARAM
						AND   a.num_serie     = TV_SERIE
						AND   a.fec_alta IN (SELECT MAX(b.fec_alta)
						  	  			     FROM   GA_EQUIPABOSER  b
						  				     WHERE  b.num_abonado  =  TN_ABONADO
										     AND    b.tip_terminal <> TV_VALPARAM
										     AND    b.ind_procequi =  CV_PROCEQUI
						                     AND    b.num_serie    = TV_SERIE
											 AND    b.imp_cargo IS NOT NULL);

						EXCEPTION
					   		WHEN NO_DATA_FOUND THEN
								 GN_SECUENCIA     := '3';
								 GN_SQLCODE := SQLCODE;
		           				 GV_SQLERRM := SQLERRM;
								 RAISE ERROR_SEC;
					END;

					IF 	TN_IMPCARGO IS NOT NULL THEN

					 	 UPDATE GA_EQUIPABOSER a
					     SET a.tip_dto = TN_TIPDTO
						 ,a.val_dto    = TN_VALDTO
						 ,a.imp_cargo  = TN_IMPCARGO
					     WHERE a.num_abonado = TN_ABONADO
						 AND   a.num_serie   = TV_SERIEREM
					     AND   a.fec_alta IN (SELECT MAX(b.fec_alta)
					  	  			          FROM   GA_EQUIPABOSER  b
					  				          WHERE  b.num_abonado  =  TN_ABONADO
					                          AND    b.num_serie    =  TV_SERIEREM );

					END IF;

		     END IF;


		     IF (TN_CODESTAD IS NOT NULL) AND (TN_CODESTAD = CN_CODESTOR ) THEN

			 	   BEGIN

						SELECT a.imp_cargo
						, a.tip_dto
						, a.val_dto
						INTO  TN_IMPCARGO, TN_TIPDTO, TN_VALDTO
						FROM  GA_EQUIPABOSER a
						WHERE a.num_abonado   = TN_ABONADO
						AND   a.ind_procequi  = CV_PROCEQUI
						AND   NOT a.tip_terminal = TV_VALPARAM
						AND   a.num_serie     = TV_SERIEREM
						AND   a.fec_alta IN (SELECT MAX(b.fec_alta)
						  	  			     FROM   GA_EQUIPABOSER  b
						  				     WHERE  b.num_abonado  =  TN_ABONADO
										     AND    b.tip_terminal <> TV_VALPARAM
										     AND    b.ind_procequi =  CV_PROCEQUI
						                     AND    b.num_serie    = TV_SERIEREM
											 AND    b.imp_cargo IS NOT NULL);

						EXCEPTION
					   		WHEN NO_DATA_FOUND THEN
								 GN_SECUENCIA     := '4';
								 GN_SQLCODE := SQLCODE;
		           				 GV_SQLERRM := SQLERRM;
								 RAISE ERROR_SEC;
					END;


					IF 	TN_IMPCARGO IS NOT NULL THEN

					 	 UPDATE GA_EQUIPABOSER a
					     SET a.tip_dto = TN_TIPDTO
						 ,a.val_dto    = TN_VALDTO
						 ,a.imp_cargo  = TN_IMPCARGO
					     WHERE a.num_abonado = TN_ABONADO
						 AND   a.num_serie   = TV_SERIE
					     AND   a.fec_alta IN (SELECT MAX(b.fec_alta)
					  	  			          FROM   GA_EQUIPABOSER  b
					  				          WHERE  b.num_abonado  =  TN_ABONADO
					                          AND    b.num_serie    =  TV_SERIE );

					END IF;

		     END IF;

			 IF (TN_CODESTAD <> CN_CODESTOR ) THEN

				TV_SERIE    := :OLD.NUM_SERIE_REEM;
				TV_SERIEREM := :NEW.NUM_SERIE_REEM;

				IF (TV_SERIE <> TV_SERIEREM) AND (TV_SERIE IS NOT NULL) THEN


				   BEGIN

							SELECT a.imp_cargo
							, a.tip_dto
							, a.val_dto
							INTO  TN_IMPCARGO, TN_TIPDTO, TN_VALDTO
							FROM  GA_EQUIPABOSER a
							WHERE a.num_abonado   = TN_ABONADO
							AND   a.ind_procequi  = CV_PROCEQUI
							AND   NOT a.tip_terminal = TV_VALPARAM
							AND   a.num_serie     = TV_SERIE
							AND   a.fec_alta IN (SELECT MAX(b.fec_alta)
							  	  			     FROM   GA_EQUIPABOSER  b
							  				     WHERE  b.num_abonado  =  TN_ABONADO
											     AND    b.tip_terminal <> TV_VALPARAM
											     AND    b.ind_procequi =  CV_PROCEQUI
							                     AND    b.num_serie    = TV_SERIE
												 AND    b.imp_cargo IS NOT NULL);

							EXCEPTION
						   		WHEN NO_DATA_FOUND THEN
									 GN_SECUENCIA     := '5';
									 GN_SQLCODE := SQLCODE;
			           				 GV_SQLERRM := SQLERRM;
									 RAISE ERROR_SEC;

					END;


							   IF TN_IMPCARGO IS NOT NULL THEN

							 	 UPDATE GA_EQUIPABOSER a
							     SET a.tip_dto = TN_TIPDTO
								 ,a.val_dto    = TN_VALDTO
								 ,a.imp_cargo  = TN_IMPCARGO
							     WHERE a.num_abonado = TN_ABONADO
								 AND   a.num_serie   = TV_SERIEREM
							     AND   a.fec_alta IN (SELECT MAX(b.fec_alta)
							  	  			          FROM   GA_EQUIPABOSER  b
							  				          WHERE  b.num_abonado  =  TN_ABONADO
							                          AND    b.num_serie    =  TV_SERIEREM );

							   END IF;
				END IF;
			 END IF;
    END IF;
EXCEPTION

	WHEN ERROR_SEC THEN
	     GV_SQLERRM := SUBSTR(GV_SQLERRM,1,255);
	     INSERT INTO GA_ERRORES
           (COD_ACTABO
		   ,CODIGO
		   ,FEC_ERROR
		   ,COD_PRODUCTO
		   ,NOM_PROC
		   ,COD_SQLCODE
		   ,COD_SQLERRM)
         VALUES
           (GV_ACTABO
		   , GN_SECUENCIA
		   , SYSDATE
		   , CN_PRODUCTO
		   , GN_NOMPROC
		   , GN_SQLCODE
		   , GV_SQLERRM);

WHEN OTHERS THEN
		GV_SQLERRM := SUBSTR(GV_SQLERRM,1,255);

		INSERT INTO GA_ERRORES
           (COD_ACTABO
		   ,CODIGO
		   ,FEC_ERROR
		   ,COD_PRODUCTO
		   ,NOM_PROC
		   ,NOM_TABLA
		   ,COD_ACT
		   ,COD_SQLCODE
		   ,COD_SQLERRM)
         VALUES
           (GV_ACTABO
		   , GN_SECUENCIA
		   , SYSDATE
		   , CN_PRODUCTO
		   , GN_NOMPROC
		   , 'Null'
		   , 'N'
		   , GN_SQLCODE
		   , GV_SQLERRM);

END PV_OREP_BEUP_TG;
/
SHOW ERRORS
