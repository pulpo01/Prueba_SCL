CREATE OR REPLACE FUNCTION        ge_fn_valida_identclie_mpr
(v_num_ident IN VARCHAR2, v_tip_ident IN VARCHAR2) RETURN VARCHAR2 IS
   long_string	  NUMBER;
   pos_guion1	  NUMBER;
   pos_guion2	  NUMBER;
   n_ident        NUMBER;
   v660			  VARCHAR2(3) := '660';
BEGIN
--
IF v_tip_ident = '01' or v_tip_ident = '05' THEN -- Seguro Social. Nota que debe seleccionar el ge_tipident.ind_tipident como codigo interno para los tipos de identificadores
   -- Obtiene el largo total del string original
   long_string := LENGTH(v_num_ident);
   -- Busca si tiene los guiones en las posiciones 3 y 7
   SELECT INSTR(v_num_ident,'-',1,1) AS pos_guion1,INSTR(v_num_ident,'-',1,2) AS pos_guion2
   INTO pos_guion1,pos_guion2
   FROM dual;
   --
   IF( pos_guion1 = 4 AND pos_guion2 = 7 )THEN-- Guiones correctamente ubicados
      IF ( long_string = 11 ) THEN -- Esta en formato MPR correcto
         N_IDENT := TO_NUMBER(REPLACE(V_NUM_IDENT,'-',''));
         RETURN v_num_ident;
      ELSE  -- Tiene los guiones, pero falla el largo MPR
         RETURN 'ERROR Largo con Guiones debe ser '||long_string||' <> '|| '11';
      END IF ;
   ELSIF (pos_guion1 = 0 AND pos_guion2 = 0) THEN -- No hay guiones
      IF ( long_string = 9 ) THEN -- Esta en formato correcto
         N_IDENT := TO_NUMBER(V_NUM_IDENT);
         RETURN SUBSTR(V_NUM_IDENT,1,3)||'-'||SUBSTR(V_NUM_IDENT,4,2)||'-'||SUBSTR(V_NUM_IDENT,6,4);
      ELSE -- No tiene guiones y no cumple el formato por el largo
         RETURN 'ERROR Largo sin Guiones debe ser '||long_string||' <> '|| '9' ;
      END IF  ;
   ELSE -- Hay guiones, pero en posiciones erroneas
      RETURN 'ERROR Guiones deben estar en las posiciones 3 y 7';
   END IF;
ELSE
   RETURN v_num_ident;
END IF;
----------------------------------------------------------------------------------------
EXCEPTION
WHEN OTHERS THEN
     RETURN 'ERROR ge_fn_valida_identclie_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
