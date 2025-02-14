CREATE OR REPLACE PROCEDURE P_Numcelular
(
VAR_NUMCELULAR IN GE_CLIENTES.NUM_CELULAR%TYPE,
VAR_NOMCLIE OUT GE_CLIENTES.NOM_CLIENTE%TYPE,
VAR_APELL1 OUT GE_CLIENTES.NOM_APECLIEN1%TYPE,
VAR_APELL2 OUT GE_CLIENTES.NOM_APECLIEN2%TYPE,
VAR_SITUAC OUT GA_ABOCEL.COD_SITUACION%TYPE,
VAR_ABONADO OUT GA_ABOCEL.NUM_ABONADO%TYPE,
VAR_NUMSERIE OUT GA_ABOCEL.NUM_SERIE%TYPE,
VAR_CODART OUT AL_ARTICULOS.COD_ARTICULO%TYPE,
VAR_DESART OUT AL_ARTICULOS.DES_ARTICULO%TYPE,
VAR_FUNCION OUT VARCHAR2,
VAR_TIPCLIE OUT VARCHAR2
)
IS
vDescError VARCHAR2(200);
vCLIENTE ge_clientes.COD_CLIENTE%TYPE := -1;
/*Inicio modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
vFECALTAPOS ga_abocel.FEC_ALTA%TYPE;
vFECALTAPRE ga_aboamist.FEC_ALTA%TYPE;
vSITUACPRE  ga_aboamist.COD_SITUACION%TYPE;
sNOMTABLA   VARCHAR2(11);
/*Fin modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/

BEGIN
    BEGIN
        -- Primero consulta GA_ABOCEL (modificado)
        SELECT  A.COD_CLIENTE, A.NOM_CLIENTE, A.NOM_APECLIEN1, A.NOM_APECLIEN2,B.COD_SITUACION,
                B.NUM_ABONADO, b.FEC_ALTA /*Modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
        INTO  VCLIENTE, VAR_NOMCLIE, VAR_APELL1, VAR_APELL2, VAR_SITUAC,VAR_ABONADO, vFECALTAPOS /*Modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
        FROM  GE_CLIENTES A, GA_ABOCEL B
        WHERE A.COD_CLIENTE = B.COD_CLIENTE
        AND   B.FEC_ALTA IN (SELECT MAX(B1.FEC_ALTA)
	  	             FROM  GA_ABOCEL B1
                             WHERE B1.NUM_CELULAR = VAR_NUMCELULAR)
        AND B.NUM_CELULAR =VAR_NUMCELULAR;
	/*Inicio modificaci?n TM-200502091261 - 17/02/2005 - Marcelo Miranda W.
        AND B.COD_SITUACION <> 'BAA';/*TM-200502091261 - 17/02/2005 - JJR.-*/
        /*Fin modificaci?n TM-200502091261 - 17/02/2005 - Marcelo Miranda W.*/

        sNOMTABLA := 'GA_ABOCEL'; /*Modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/

     	IF  vCLIENTE  <> -1 THEN
            VAR_TIPCLIE := 'C';
        END IF;

 	/*Inicio modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
        IF VAR_SITUAC = 'BAA' THEN
 		BEGIN
 			-- si esta en la GA_ABOCEL de baja, consulta en la GA_ABOAMIST
 			SELECT COD_SITUACION, FEC_ALTA
 			INTO  vSITUACPRE, vFECALTAPRE
 			FROM  GA_ABOAMIST
 			WHERE FEC_ALTA IN (SELECT MAX(B1.FEC_ALTA)
 			                   FROM GA_ABOAMIST B1
                       		   	   WHERE B1.NUM_CELULAR = VAR_NUMCELULAR)
            		AND NUM_CELULAR =VAR_NUMCELULAR;

 	        	IF (vSITUACPRE <> 'BAA') OR ((vSITUACPRE = 'BAA') AND (vFECALTAPOS < vFECALTAPRE)) THEN
 			    -- Se despliegan datos del abonado prepago GA_ABOAMIST
 			    SELECT A.COD_CLIENTE, A.NOM_CLIENTE, A.NOM_APECLIEN1,
 			  	       A.NOM_APECLIEN2,B.COD_SITUACION,B.NUM_ABONADO
                	    INTO  VCLIENTE, VAR_NOMCLIE, VAR_APELL1, VAR_APELL2, VAR_SITUAC,VAR_ABONADO
                	    FROM  GE_CLIENTES A, GA_ABOAMIST B
                	    WHERE A.COD_CLIENTE = B.COD_CLIENTE
                	    AND   B.FEC_ALTA IN (SELECT MAX(B1.FEC_ALTA)
 				                 FROM GA_ABOAMIST B1
                       		 	         WHERE B1.NUM_CELULAR = VAR_NUMCELULAR)
                	    AND B.NUM_CELULAR =VAR_NUMCELULAR;

			    sNOMTABLA := 'GA_ABOAMIST';
                            VAR_TIPCLIE := 'P';
			END IF;
	/*Fin modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
         	EXCEPTION
    	 	WHEN NO_DATA_FOUND THEN
    	 	        /*Inicio modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
         		/* Continue con los datos de la tabla GA_ABOCEL*/
 			    NULL;
 			WHEN OTHERS THEN
       			vDescError  := 'ERROR , SQLERRM : ' || SQLERRM;
			RAISE_APPLICATION_ERROR(-20005, vDescError);
 		END;
 		       /*Fin modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
        END IF;
	EXCEPTION /*Modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
   	 	WHEN NO_DATA_FOUND THEN /*Modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
		BEGIN /*Modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
		    -- sino esta en la GA_ABOCEL , consulta en la GA_ABOAMIST
		    SELECT  A.COD_CLIENTE, A.NOM_CLIENTE, A.NOM_APECLIEN1,
		            A.NOM_APECLIEN2,B.COD_SITUACION,B.NUM_ABONADO
            	    INTO VCLIENTE, VAR_NOMCLIE, VAR_APELL1, VAR_APELL2, VAR_SITUAC,VAR_ABONADO
            	    FROM GE_CLIENTES A, GA_ABOAMIST B
                    WHERE A.COD_CLIENTE = B.COD_CLIENTE
            	    AND B.FEC_ALTA IN (SELECT MAX(B1.FEC_ALTA)
			                   FROM GA_ABOAMIST B1
                               WHERE B1.NUM_CELULAR = VAR_NUMCELULAR)
            	    AND B.NUM_CELULAR =VAR_NUMCELULAR;

            	    /*Inicio modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
            	    /* AND B.COD_SITUACION <> 'BAA'; /*TM-200502091261 - 17/02/2005 - JJR.-*/
		       sNOMTABLA := 'GA_ABOAMIST';
	   	    /*Fin modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/

	            --IF vCLIENTE  <> -1 then
		         VAR_TIPCLIE := 'P';
                    -- END IF;
	       END; /*Modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
      END; /*Modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
	BEGIN /*Modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
		IF sNOMTABLA='GA_ABOCEL' THEN
		SELECT B.NUM_SERIE, B.COD_ARTICULO, C.DES_ARTICULO
        	INTO VAR_NUMSERIE, VAR_CODART, VAR_DESART
        	FROM GA_ABOCEL A, GA_EQUIPABOSER B,  AL_ARTICULOS C
        	WHERE A.NUM_SERIE = B.NUM_SERIE
        	AND B.FEC_ALTA IN (SELECT MAX(FEC_ALTA)
        	FROM GA_EQUIPABOSER D
        	WHERE A.NUM_SERIE = D.NUM_SERIE)
        	AND B.COD_ARTICULO = C.COD_ARTICULO
            AND A.NUM_ABONADO = VAR_ABONADO;
        /*Inicio Modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
        ELSE
		 SELECT B.NUM_SERIE, B.COD_ARTICULO, C.DES_ARTICULO
        	INTO VAR_NUMSERIE, VAR_CODART, VAR_DESART
        	FROM GA_ABOAMIST A, GA_EQUIPABOSER B,  AL_ARTICULOS C
        	WHERE A.NUM_SERIE = B.NUM_SERIE
        	AND B.FEC_ALTA IN (SELECT MAX(FEC_ALTA)
        	FROM GA_EQUIPABOSER D
        	WHERE A.NUM_SERIE = D.NUM_SERIE)
        	AND B.COD_ARTICULO = C.COD_ARTICULO
                AND A.NUM_ABONADO = VAR_ABONADO;
 	END IF;
	/*Fin Modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/

	EXCEPTION
	    WHEN NO_DATA_FOUND THEN
	    	/*Inicio Modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
	        	--IF vCLIENTE <> -1 THEN
            			vDescError  := 'NO EXISTEN DATOS DEL APARATO, PARA N? DE CELULAR INGRESADO : ' || SQLERRM || SQLCODE;
	        		RAISE_APPLICATION_ERROR(-20002, vDescError);
	        	--ELSE
            			--  vDescError  := 'NO EXISTE CLIENTE ASOCIADO AL N? DE CELULAR INGRESADO : ' || SQLERRM || SQLCODE;
	        		--  RAISE_APPLICATION_ERROR(-20003, vDescError);
	        	--END IF;
         WHEN OTHERS THEN
	  		vDescError  := 'ERROR AL PROCESAR LOS DATOS : ' || SQLERRM || SQLCODE;
	  	/*Fin Modificaci?n TM-200502091261 - 24/02/2005 - Marcelo Miranda W.*/
    END;

	-- Consulta por la direccion asociada al numero ingresado
    BEGIN
        VAR_FUNCION := GE_FN_OBTIENE_DIRCLIE(vCLIENTE,1,3,3);
        EXCEPTION
            WHEN OTHERS THEN
	        VAR_FUNCION:='DATOS DE DIRECCION NO EXISTEN PARA CELULAR INGRESADO';
	END;
-- Control de errores
EXCEPTION

	--WHEN NO_DATA_FOUND THEN

	--vDescError  := 'NO EXISTEN DATOS PARA NUMERO INGRESADO : ' || SQLERRM || SQLCODE;
    --RAISE_APPLICATION_ERROR(-20004, vDescError);

    WHEN OTHERS THEN
        vDescError  := 'ERROR , SQLERRM : ' || SQLERRM;
        -- RETURN vDescError ;
	    RAISE_APPLICATION_ERROR(-20005, vDescError);
END;
/
SHOW ERRORS
