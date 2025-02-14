CREATE OR REPLACE FUNCTION ge_fn_valida_identclie_tmc (v_num_ident IN VARCHAR2, v_tip_ident IN VARCHAR2)
RETURN VARCHAR2 IS
--   error EXCEPTION;
   v_num_ident_sp VARCHAR2(100);
   long_string    NUMBER;
   pos_guion      NUMBER;
   v_sRut         VARCHAR2(100);
   v_idig                 VARCHAR2(100);
   k                      NUMBER;
   total                  NUMBER;
   j                      NUMBER;
   iD                     VARCHAR2(100);
   rut            NUMBER;
   dv             VARCHAR2(1);
   l              NUMBER;
BEGIN
IF trim(v_tip_ident) ='01' THEN
   --
   -- elimina los puntos, si los hubiera
   v_num_ident_sp:=REPLACE (v_num_ident,'.','');
   -- obtiene el largo total del string sin puntos ( con o sin guion )
   long_string:=LENGTH(v_num_ident_sp);
   -- busca si tiene el guion
   pos_guion:=INSTR(v_num_ident_sp,'-');

   IF pos_guion = 0 THEN-- no hay guion
   		rut:=SUBSTR(v_num_ident_sp,1,(long_string-1));
		dv:=SUBSTR(v_num_ident_sp,long_string,1);
   ELSE --(<> 0) -- si hay guion en la poscion pos_guion
      IF ( pos_guion >= long_string ) or (long_string - pos_guion > 1) THEN
          RETURN 'ERROR';
      ELSE
		  rut:=SUBSTR(v_num_ident_sp,1,(pos_guion-1));
		  dv:=SUBSTR(v_num_ident_sp,pos_guion+1,1);
      END IF;
   END IF;

   IF long_string < 3 THEN
       RETURN 'ERROR:Rut Invalido, faltan caracteres';
   ELSE
        v_sRut := v_num_ident_sp;

        k := 2;
        total := 0;

        FOR j IN REVERSE 1 .. LENGTH(Trim(rut))
        LOOP
                        IF k > 7 THEN
                           k := 2;
                        END IF;

                           l := TO_NUMBER(SUBSTR(rut, j, 1));
                           total := total + l * k;
                           k := k + 1;
        END LOOP ;

        IF MOD(total,11) = 0 THEN
           iD := '0';
        ELSE
           IF 11 - (MOD(total,11)) = 10 THEN
                  iD := 'K';
           ELSIF 11 - (MOD(total,11)) = 0 THEN
                  iD := '0';
           ELSE
                  iD := TO_CHAR(11 - (MOD(total,11)));
           END IF;
        END IF;

        IF dv = iD  THEN
           RETURN rut || '-' || dv;
        ELSE
           RETURN 'ERROR:NO Valido';
        END IF;
   END IF;
ELSE
        RETURN v_num_ident;
END IF;


--*********************************************************
   EXCEPTION

   WHEN VALUE_ERROR THEN
                RETURN 'ERROR:Rut Contiene caracteres no numericos';

   WHEN INVALID_NUMBER THEN
                RETURN 'ERROR:Rut Contiene caracteres no numericos';

   WHEN OTHERS THEN
      RETURN 'ERROR ge_fn_valida_identclie_tmc, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
