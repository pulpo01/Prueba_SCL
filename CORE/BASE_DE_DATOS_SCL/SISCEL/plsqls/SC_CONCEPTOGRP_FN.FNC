CREATE OR REPLACE FUNCTION Sc_Conceptogrp_Fn ( p_nCod_Evento IN NUMBER
		 				   , p_vDominio1  IN VARCHAR2
						   , p_vConcepto1 IN VARCHAR2
						   , p_vDominio2  IN VARCHAR2 DEFAULT NULL
						   , p_vConcepto2 IN VARCHAR2 DEFAULT NULL
						   , p_vDominio3  IN VARCHAR2 DEFAULT NULL
						   , p_vConcepto3 IN VARCHAR2 DEFAULT NULL
						   , p_vDominio4  IN VARCHAR2 DEFAULT NULL
						   , p_vConcepto4 IN VARCHAR2 DEFAULT NULL

						   )
RETURN VARCHAR2
IS
	v_nDominio1 SC_DOMINIO_CTO.COD_DOMINIO_CTO%TYPE;
	v_nDominio2 SC_DOMINIO_CTO.COD_DOMINIO_CTO%TYPE;
	v_nDominio3 SC_DOMINIO_CTO.COD_DOMINIO_CTO%TYPE;
	v_nDominio4 SC_DOMINIO_CTO.COD_DOMINIO_CTO%TYPE;

	v_nDominioFin1 SC_DOMINIO_CTO.COD_DOMINIO_CTO%TYPE;
	v_nDominioFin2 SC_DOMINIO_CTO.COD_DOMINIO_CTO%TYPE;

	v_ConceptoFin1 SC_GRP_DOMINIO_DET.COD_CONCEPTO%TYPE;
	v_ConceptoFin2 SC_GRP_DOMINIO_DET.COD_CONCEPTO%TYPE;

	v_vConceptoGrp SC_GRP_DOMINIO_DET.COD_CTO_GRP%TYPE;
	v_nCodDominioCto SC_EVENTO.COD_DOMINIO_CTO%TYPE;
	v_nIndGrpDominio SC_EVENTO.IND_GRP_DOMINIO%TYPE;

	v_vConceptoOK SC_CONCEPTO.COD_CONCEPTO%TYPE;

	v_nNroDominios NUMBER;
	v_nAsignaciones NUMBER;
	v_nLenConceptoGrp  NUMBER;
	v_nLenConcepto1  NUMBER;
	v_nLenConcepto2  NUMBER;
	v_nLenConcepto3  NUMBER;
	v_nLenConcepto4  NUMBER;

BEGIN
	 BEGIN

	 	 --Codigo de Dominio y indicador de si es grupo de dominio
		 SELECT COD_DOMINIO_CTO, IND_GRP_DOMINIO
		   INTO v_nCodDominioCto, v_nIndGrpDominio
	       FROM SC_EVENTO
	      WHERE COD_EVENTO = p_nCod_Evento;

    	--Largo del conceptoGRP que se debe retornar
	    SELECT NVL(LEN_CONCEPTO,0)
		INTO   v_nLenConceptoGrp
		FROM SC_DOMINIO_CTO
		WHERE cod_dominio_cto IN (SELECT cod_dominio_cto
	 		  	  				  FROM SC_EVENTO
								  WHERE cod_evento = p_nCod_Evento);

		BEGIN
			 --Valida y formatea concepto de dominio
		 	SELECT COD_DOMINIO_CTO, NVL(LEN_CONCEPTO,0)
		 	  INTO v_nDominio1, v_nLenConcepto1
		 	  FROM SC_DOMINIO_CTO
		 	 WHERE DES_DOMINIO_CTO = TRIM(p_vDominio1);


			EXCEPTION
				 WHEN OTHERS THEN
				 v_nDominio1:=NULL;
		END;

		BEGIN
			 --Valida y formatea concepto de dominio
		 	SELECT COD_DOMINIO_CTO, NVL(LEN_CONCEPTO,0)
		 	  INTO v_nDominio2, v_nLenConcepto2
		 	  FROM SC_DOMINIO_CTO
		 	 WHERE DES_DOMINIO_CTO = p_vDominio2;

			EXCEPTION
				 WHEN OTHERS THEN
				 v_nDominio2:=NULL;
		END;

		BEGIN
			 --Valida y formatea concepto de dominio
		 	SELECT COD_DOMINIO_CTO, NVL(LEN_CONCEPTO,0)
		 	  INTO v_nDominio3, v_nLenConcepto3
		 	  FROM SC_DOMINIO_CTO
		 	 WHERE DES_DOMINIO_CTO = p_vDominio3;

			EXCEPTION
				 WHEN OTHERS THEN
				 v_nDominio3:=NULL;
		END;

		BEGIN
			 --Valida y formatea concepto de dominio
		 	SELECT COD_DOMINIO_CTO, NVL(LEN_CONCEPTO,0)
		 	  INTO v_nDominio4, v_nLenConcepto4
		 	  FROM SC_DOMINIO_CTO
		 	 WHERE DES_DOMINIO_CTO = p_vDominio4;

			EXCEPTION
				 WHEN OTHERS THEN
				 v_nDominio4:=NULL;
		END;



		IF v_nIndGrpDominio = 0 THEN
			IF v_nDominio1 = v_nCodDominioCto THEN
				v_vConceptoGrp := LPAD(p_vConcepto1,v_nLenConcepto1,'0');
		 	END IF;

		 	IF v_nDominio2 = v_nCodDominioCto THEN
				v_vConceptoGrp := LPAD(p_vConcepto2,v_nLenConcepto2,'0');
		 	END IF;

		 	IF v_nDominio3 = v_nCodDominioCto THEN
				v_vConceptoGrp := LPAD(p_vConcepto3,v_nLenConcepto3,'0');
		 	END IF;

			IF v_nDominio4 = v_nCodDominioCto THEN
				v_vConceptoGrp := LPAD(p_vConcepto4,v_nLenConcepto4,'0');
		 	END IF;

			SELECT COD_CONCEPTO
			  INTO v_vConceptoOK
			  FROM SC_CONCEPTO
			 WHERE COD_DOMINIO_CTO = v_nCodDominioCto
			   AND COD_CONCEPTO = LPAD(v_vConceptoGrp,v_nLenConceptoGrp,'0');
		 ELSE
			SELECT COUNT(1)
			  INTO v_nNroDominios
			  FROM SC_GRP_DOMINIO
			 WHERE COD_GRP_DOMINIO = v_nCodDominioCto;

			IF v_nNroDominios = 2 THEN

		        v_nAsignaciones := 0;

		        IF v_nDominio1 IS NOT NULL THEN
			        v_nDominioFin1 := v_nDominio1;
			        v_ConceptoFin1 := LPAD(p_vConcepto1,v_nLenConcepto1,'0');
			        v_nAsignaciones := 1;
			    END IF;

		        IF v_nDominio2 IS NOT NULL THEN
				    IF v_nAsignaciones = 0 THEN
				        v_nDominioFin1 := v_nDominio2;
				        v_ConceptoFin1 := LPAD(p_vConcepto2,v_nLenConcepto2,'0');
				        v_nAsignaciones := 1;
					ELSE
				        v_nDominioFin2 := v_nDominio2;
				        v_ConceptoFin2 := LPAD(p_vConcepto2,v_nLenConcepto2,'0');
				        v_nAsignaciones := 2;
					END IF;
				END IF;

				--Obtiene Concepto Agrupado cuando son 2 dominios simples
		        SELECT T1.COD_CTO_GRP
		          INTO v_vConceptoGrp
		       	  FROM SC_GRP_DOMINIO_DET T1, SC_GRP_DOMINIO_DET T2
		       	 WHERE T1.COD_GRP_DOMINIO = v_nCodDominioCto 		-- OBTENIDO DESDE SC_EVENTO.
		       	   AND T1.COD_DOMINIO_CTO = v_nDominioFin1  			-- PRIMER DOMINIO SIMPLE.
		       	   AND T1.COD_CONCEPTO    = v_ConceptoFin1      		-- CONCEPTO DEL PRIMER DOMINIO.
		       	   AND T2.COD_GRP_DOMINIO = v_nCodDominioCto 		-- OBTENIDO DESDE SC_EVENTO.
		       	   AND T2.COD_DOMINIO_CTO = v_nDominioFin2 			-- SEGUNDO DOMINIO SIMPLE.
		       	   AND T2.COD_CONCEPTO    = v_ConceptoFin2			-- CONCEPTO DEL SEGUNDO DOMINIO.
		       	   AND T2.COD_CTO_GRP     = T1.COD_CTO_GRP
			   AND ROWNUM <= 1;

			ELSIF v_nNroDominios = 3 THEN

				--Obtiene Concepto Agrupado cuando son 3 dominios simples
	            SELECT T1.COD_CTO_GRP
		          INTO v_vConceptoGrp
	              FROM SC_GRP_DOMINIO_DET T1, SC_GRP_DOMINIO_DET T2, SC_GRP_DOMINIO_DET T3
	             WHERE 1 = 1
	               AND T1.COD_GRP_DOMINIO = v_nCodDominioCto
	               AND T1.COD_DOMINIO_CTO = v_nDominio1
	               AND T1.COD_CONCEPTO    = LPAD(p_vConcepto1,v_nLenConcepto1,'0')
	               AND T2.COD_GRP_DOMINIO = v_nCodDominioCto
	               AND T2.COD_DOMINIO_CTO = v_nDominio2
	               AND T2.COD_CONCEPTO    = LPAD(p_vConcepto2,v_nLenConcepto2,'0')
	               AND T2.COD_CTO_GRP     = T1.COD_CTO_GRP
	               AND T3.COD_GRP_DOMINIO = v_nCodDominioCto
	               AND T3.COD_DOMINIO_CTO = v_nDominio3
	               AND T3.COD_CONCEPTO    = LPAD(p_vConcepto3,v_nLenConcepto3,'0')
	               AND T3.COD_CTO_GRP     = T1.COD_CTO_GRP
   		       AND ROWNUM <= 1;

			ELSIF v_nNroDominios = 4 THEN


	            SELECT T1.COD_CTO_GRP
		          INTO v_vConceptoGrp
	              FROM SC_GRP_DOMINIO_DET T1, SC_GRP_DOMINIO_DET T2, SC_GRP_DOMINIO_DET T3, SC_GRP_DOMINIO_DET T4
	             WHERE 1 = 1
	               AND T1.COD_GRP_DOMINIO = v_nCodDominioCto
	               AND T1.COD_DOMINIO_CTO = v_nDominio1
	               AND T1.COD_CONCEPTO    = LPAD(p_vConcepto1,v_nLenConcepto1,'0')
	               AND T2.COD_GRP_DOMINIO = v_nCodDominioCto
	               AND T2.COD_DOMINIO_CTO = v_nDominio2
	               AND T2.COD_CONCEPTO    = LPAD(p_vConcepto2,v_nLenConcepto2,'0')
	               AND T2.COD_CTO_GRP     = T1.COD_CTO_GRP
	               AND T3.COD_GRP_DOMINIO = v_nCodDominioCto
	               AND T3.COD_DOMINIO_CTO = v_nDominio3
	               AND T3.COD_CONCEPTO    = LPAD(p_vConcepto3,v_nLenConcepto3,'0')
	               AND T3.COD_CTO_GRP     = T1.COD_CTO_GRP
   	               AND T4.COD_GRP_DOMINIO = v_nCodDominioCto
	               AND T4.COD_DOMINIO_CTO = v_nDominio4
	               AND T4.COD_CONCEPTO    = LPAD(p_vConcepto4,v_nLenConcepto4,'0')
	               AND T4.COD_CTO_GRP     = T1.COD_CTO_GRP
		       AND ROWNUM <= 1;

			END IF;

		END IF;

		EXCEPTION
				 WHEN OTHERS THEN
				 v_vConceptoGrp:=NULL;
	END;

	--retorna Concepto de grupo formateado
	RETURN LPAD(v_vConceptoGrp,v_nLenConceptoGrp,'0');

END Sc_Conceptogrp_Fn;
/
SHOW ERRORS
