CREATE OR REPLACE FUNCTION        ge_fn_formatea_identclie_mpr (v_num_ident IN VARCHAR2, v_tip_ident IN VARCHAR2, v_bd_client NUMBER, v_ind_format IN NUMBER)
RETURN VARCHAR2 IS
--   error EXCEPTION;
   long_string    NUMBER;
   pos_guion1     NUMBER;
   pos_guion2     NUMBER;
BEGIN
--
-- obtiene el largo total del string sin puntos ( con o sin guion )
SELECT LENGTH(v_num_ident) INTO long_string FROM dual;
--
IF (long_string is null or long_string = 0) THEN
   RETURN v_num_ident;
END IF;

-- busca si tiene el guion
SELECT INSTR(v_num_ident,'-',1,1) AS pos_guion1,
           INSTR(v_num_ident,'-',1,2) AS pos_guion2
INTO pos_guion1,
         pos_guion2
FROM dual;
--
--
IF v_bd_client = 1 THEN -- va hacia BD
   IF v_ind_format = 2 or v_ind_format = 3 THEN
          --Devuelve sin Guiones
          IF ( pos_guion1 = 3 AND pos_guion2 = 7 )THEN-- Encontramos los guiones
                 RETURN SUBSTR(V_NUM_IDENT,1,2)||SUBSTR(V_NUM_IDENT,4,3)||SUBSTR(V_NUM_IDENT,8,4);
          ELSIF (pos_guion1 = 0 AND pos_guion2 = 0) THEN -- no hay guiones
                 RETURN v_num_ident;
          END IF;
   ELSE --v_ind_format <> 3
      --Devuelve con Guiones
          IF ( pos_guion1 = 3 AND pos_guion2 = 7 )THEN-- Encontramos los guiones
                 RETURN v_num_ident;
          ELSIF (pos_guion1 = 0 AND pos_guion2 = 0) THEN -- no hay guiones
                 RETURN SUBSTR(V_NUM_IDENT,1,2)||'-'||SUBSTR(V_NUM_IDENT,3,3)||'-'||SUBSTR(V_NUM_IDENT,6,4);
          END IF;
   END IF;
ELSE -- Va Hacia Cliente
   --Devuelve con Guiones
        IF ( pos_guion1 = 3 AND pos_guion2 = 7 )THEN-- Encontramos los guiones
           RETURN v_num_ident;
        ELSIF (pos_guion1 = 0 AND pos_guion2 = 0) THEN -- no hay guiones
           RETURN SUBSTR(V_NUM_IDENT,1,2)||'-'||SUBSTR(V_NUM_IDENT,3,3)||'-'||SUBSTR(V_NUM_IDENT,6,4);
        END IF;
END IF;
--*********************************************************
   EXCEPTION
   WHEN VALUE_ERROR THEN
                RETURN 'Error ID Contiene caracteres no numericos';

   WHEN INVALID_NUMBER THEN
                RETURN 'Error ID Contiene caracteres no numericos';

   WHEN OTHERS THEN
      RETURN 'ERROR ge_fn_formatea_identclie_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
