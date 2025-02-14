CREATE OR REPLACE TRIGGER PV_SINI_BEUP_TG
BEFORE UPDATE ON GA_SINIESTROS
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

  nAbonado		   ga_abocel.num_abonado%type;
  sCodTecnologia   ga_abocel.cod_tecnologia%type;
  sCodOperadora	   PV_SERIELN_INT_TO.COD_OPERADORA%type;

  -- homologacion HD-200405250815 (Inc. CH-200404281852_18052004) 25-08-2004 HPG
  sCodModelo     al_articulos.cod_modelo%TYPE;
  sDesFabricante al_fabricantes.des_fabricante%TYPE;
  -- Fin Homologacion HPG

  v_proceso        VARCHAR2(25);
  s_tabla		   VARCHAR2(15);

  nCant			   NUMBER(2);
  nError		   NUMBER(2);
  nTraza		   NUMBER(2);
  nSecuencia	   NUMBER(9);
  sMsgTraza		   VARCHAR2(100);
  sDiasForma	   VARCHAR2(20);
  sSimCard	   VARCHAR2(1);
  sAplicaLN	   GED_PARAMETROS.VAL_PARAMETRO%TYPE;

--	 Autor     : Christian Estay M. (Posventa)
--   Fecha     : 10/11/2003
--	 Comentario; Realiza la Inscripcion en la lista Negra de la Serie Informada por
--	 			 Otras Operadoras(EXTERNAS).

BEGIN
	SELECT UPPER(VAL_PARAMETRO)
	INTO sAplicaLN
	FROM GED_PARAMETROS
	WHERE NOM_PARAMETRO = 'APLIC_OPER_LN'
	AND COD_MODULO = 'GA'
	AND COD_PRODUCTO = 1;

	IF sAplicaLN ='TRUE' THEN

		 nTraza := 0;

		 BEGIN

		   SELECT VAL_PARAMETRO
		     INTO sDiasForma
			 FROM GED_PARAMETROS
			WHERE NOM_PARAMETRO = 'NUM_DIAS_FORM_SINIES'
			  AND COD_MODULO = 'GA'
			  AND COD_PRODUCTO = 1;

		   SELECT rtrim(ltrim(VAL_PARAMETRO))
		     INTO sSimCard
			 FROM GED_PARAMETROS
			WHERE NOM_PARAMETRO = 'COD_SIMCARD_GSM'
			  AND COD_MODULO = 'AL'
			  AND COD_PRODUCTO = 1;

			 IF :NEW.COD_ESTADO = 'FO' AND  trunc(sysdate) <= (trunc(:NEW.FEC_SINIESTRO) + to_number(sDiasForma))
			    and :NEW.TIP_TERMINAL <> sSimCard  THEN

	   		     SELECT count(*)
				   INTO nCant
			       FROM ged_codigos
			      WHERE nom_tabla = 'GA_LNCELU'
			        AND nom_columna = 'COD_CAUSA'
				    AND cod_valor = :NEW.COD_CAUSA;

				IF nCant > 0 THEN

				    SELECT VAL_PARAMETRO
					  INTO sCodOperadora
				  	  FROM GED_PARAMETROS
					 WHERE NOM_PARAMETRO = 'COD_OPERTMOVIL'
					   AND COD_MODULO = 'GA'
					   AND COD_PRODUCTO = 1;

				 	BEGIN
					     SELECT COD_TECNOLOGIA
						   INTO sCodTecnologia
						   FROM GA_ABOCEL
						  WHERE NUM_ABONADO = :NEW.NUM_ABONADO;

				 		  s_tabla := 'C';

				 	EXCEPTION
						WHEN NO_DATA_FOUND THEN
					 		 s_tabla := 'P';

						     SELECT COD_TECNOLOGIA
							   INTO sCodTecnologia
							   FROM GA_ABOAMIST
							  WHERE NUM_ABONADO = :NEW.NUM_ABONADO;
					END;

					SELECT PV_LNINT_SQ.NEXTVAL
					  INTO nSecuencia
		  			  FROM DUAL;

					-- homologacion HD-200405250815 (Inc. CH-200404281852_18052004) 25-08-2004 HPG
					SELECT b.cod_modelo, c.des_fabricante
					INTO sCodModelo, sDesFabricante
					FROM ga_equipaboser a, al_articulos b, al_fabricantes c
					WHERE a.num_abonado = :NEW.NUM_ABONADO
					AND a.num_serie= :NEW.NUM_SERIE
					AND b.cod_articulo=a.cod_articulo
					AND c.cod_fabricante=b.cod_fabricante
					AND a.fec_alta = (SELECT MAX(d.fec_alta) FROM ga_equipaboser d
					                  WHERE d.num_abonado=a.num_abonado
					                  AND d.num_serie = a.num_serie);
					-- Fin homologacion HPG


				 	INSERT INTO PV_SERIELN_INT_TO(NUM_SECUENCIA, COD_ACCION, COD_OPERADORA, FEC_INGRESO, COD_MARCA,
						   					 COD_MODELO, COD_TECNOLOGIA, TIP_ABONADO, NUM_SERIE, FEC_CONSPOL,
											 NUM_CONSPOL, COD_CAUSA)
							      -- homologacion HD-200405250815 (Inc. CH-200404281852_18052004) 25-08-2004 HPG
							      VALUES(nSecuencia,'I',sCodOperadora,sysdate,sDesFabricante,
								         sCodModelo,sCodTecnologia,s_tabla,:NEW.NUM_SERIE,:NEW.FEC_FORMALIZA,
								      --VALUES(nSecuencia,'I',sCodOperadora,sysdate,0,
								      --         sCodModelo,sCodTecnologia,s_tabla,:NEW.NUM_SERIE,:NEW.FEC_FORMALIZA,
							      -- Fin homologacion HPG
											:NEW.NUM_CONSTPOL,:NEW.COD_CAUSA);
				END IF;

			 END IF;

	     EXCEPTION
		     WHEN NO_DATA_FOUND THEN
			      RAISE_APPLICATION_ERROR  (-20002,'ERROR AL INSETAR EN PV_SERIELN_INT_TO : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);

		 END;
	END IF;


EXCEPTION
    WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN TRIGGER : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);

END PV_SINI_BEUP_TG;
/
SHOW ERRORS
