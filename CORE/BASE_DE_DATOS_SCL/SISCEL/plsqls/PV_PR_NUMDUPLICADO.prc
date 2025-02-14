CREATE OR REPLACE PROCEDURE PV_PR_NUMDUPLICADO(
nNumCelular  IN  NUMBER,
nNumAbonado  IN  NUMBER,
sDuplicado   OUT VARCHAR2,
sError		 OUT VARCHAR2)
IS

-- Determina si esta duplicado o no

V_SITUACION VARCHAR2(3);

BEGIN

V_SITUACION := 'BAA';
sDuplicado := 'SI';
sError:='0';

  BEGIN
	     dbms_output.put_line('antes de reutil');
		 SELECT 'SI'
	     INTO sDuplicado
	     FROM GA_CELNUM_REUTIL --sNomTablaAbo
         WHERE NUM_CELULAR = nNumCelular;

  EXCEPTION
		WHEN NO_DATA_FOUND THEN
		sDuplicado := 'NO';

    	BEGIN
	     dbms_output.put_line('antes de abocel');
		 SELECT 'SI'
	     INTO sDuplicado
	     FROM GA_ABOCEL --sNomTablaAbo
         WHERE NUM_CELULAR = nNumCelular
         AND NUM_ABONADO != nNumAbonado
         AND COD_SITUACION !=  V_SITUACION;

	   EXCEPTION
		WHEN NO_DATA_FOUND THEN
		sDuplicado := 'NO';
		BEGIN

		     dbms_output.put_line('antes de aboamist');
       		 SELECT 'SI'
	     	 INTO sDuplicado
	     	 FROM GA_ABOAMIST --sNomTablaAbo
        	 WHERE NUM_CELULAR = nNumCelular
          	 AND NUM_ABONADO != nNumAbonado
          	 AND COD_SITUACION !=  V_SITUACION;

		EXCEPTION
	       WHEN NO_DATA_FOUND THEN
		   sDuplicado := 'NO';
	       BEGIN
   		     dbms_output.put_line('antes de alseries');
  		      SELECT 'SI'
          	    INTO sDuplicado
			    FROM AL_SERIES
			   WHERE NUM_TELEFONO = nNumCelular;

		   EXCEPTION
			  WHEN NO_DATA_FOUND THEN
				   sDuplicado := 'NO';
			       BEGIN
   		              dbms_output.put_line('antes de al_fic_series');
		              SELECT 'SI'
					    INTO sDuplicado
					    FROM AL_FIC_SERIES
					   WHERE NUM_TELEFONO = nNumCelular;

				   EXCEPTION
					  WHEN NO_DATA_FOUND THEN
						   sDuplicado := 'NO';
					       BEGIN
   		              dbms_output.put_line('antes de ga_resnumcel');
				              SELECT 'SI'
							    INTO sDuplicado
							    FROM GA_RESNUMCEL
							   WHERE NUM_CELULAR = nNumCelular;

						   EXCEPTION
							  WHEN NO_DATA_FOUND THEN
								   sDuplicado := 'NO';
							       BEGIN
								      dbms_output.put_line('antes ga_celnum_uso');
						              SELECT 'SI'
		  							    INTO sDuplicado
                					  	FROM GA_CELNUM_USO
                                       WHERE nNumCelular BETWEEN NUM_DESDE AND NUM_HASTA
                                         AND NUM_SIGUIENTE <= nNumCelular
                                         -- PAGC 22-11-2003
                                         AND NUM_HASTA!=NUM_SIGUIENTE;

								   EXCEPTION
									  WHEN NO_DATA_FOUND THEN
		  								   sDuplicado := 'NO';
										   sError:='0';
								   END;
					       END;
			       END;
	       END;
	  END;
	END;
   END;
END PV_PR_NUMDUPLICADO;
/
SHOW ERRORS
