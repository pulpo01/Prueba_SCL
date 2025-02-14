CREATE OR REPLACE FUNCTION        ge_fn_formatea_identclie_tmc (v_num_ident IN VARCHAR2, v_tip_ident IN VARCHAR2, v_bd_client NUMBER, v_ind_format IN NUMBER)
RETURN VARCHAR2 IS
--   error EXCEPTION;
   v_num_ident_sp VARCHAR2(100);
   long_string	  NUMBER;
   pos_guion	  NUMBER;
   v_sRut    	  VARCHAR2(100);
   v_idig	 	  VARCHAR2(100);
   iD			  VARCHAR2(100);
   rut            NUMBER;
   dv             VARCHAR2(1);
BEGIN
--
IF trim(v_tip_ident) = '01' THEN
	-- obtiene el largo total del string sin puntos ( con o sin guion )
	SELECT LENGTH(v_num_ident) INTO long_string FROM dual;
	--
	IF (long_string is null or long_string = 0) THEN
	   RETURN v_num_ident;
	END IF;
	-- busca si tiene el guion
	SELECT INSTR(v_num_ident,'-') INTO pos_guion FROM dual;
	--
	IF pos_guion = 0 THEN-- no hay guion
	   SELECT SUBSTR(v_num_ident,1,(long_string-1)) AS rut,
	       	  SUBSTR(v_num_ident,long_string,1) AS dv
	   INTO rut,
	   		dv
	   FROM dual;
	ELSE --(<> 0) -- si hay guion en la poscion pos_guion
	   IF ( pos_guion >= long_string ) THEN
	   	  RETURN 'ERROR';
	   ELSE
	   	  SELECT SUBSTR(v_num_ident,1,(pos_guion-1)) AS rut,
		       	 SUBSTR(v_num_ident,pos_guion+1,1) AS dv
		  INTO rut,
		       dv
		  FROM dual;
	   END IF;
	END IF;
	--
	IF v_bd_client = 1 THEN -- va hacia BD
	   IF v_ind_format = 1 THEN
	   	  --Devuelve con Guion
		  RETURN rut||'-'||dv;
	   ELSIF v_ind_format = 2 THEN
	      --Devuelve sin Guion
		  RETURN rut||dv;
	   ELSIF v_ind_format = 3 THEN
	      --Devuelve sin Guion
		  RETURN rut;
	   END IF;
	ELSE
	   IF (v_ind_format = 1 or v_ind_format = 2 or v_ind_format = 3) THEN
	   	  --Devuelve con Guion
		  RETURN rut||'-'||dv;
	   END IF;
	END IF;
ELSE
	RETURN v_num_ident;
END IF;
--*********************************************************
   EXCEPTION
   WHEN VALUE_ERROR THEN
   		RETURN 'Error Rut Contiene caracteres no numericos';

   WHEN INVALID_NUMBER THEN
   		RETURN 'Error Rut Contiene caracteres no numericos';

   WHEN OTHERS THEN
      RETURN 'ERROR ge_fn_valida_identclie_tmc, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
