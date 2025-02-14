CREATE OR REPLACE FUNCTION GE_FN_EJECUTA_RUTINA (v_modulo VARCHAR2, v_correlativo NUMBER, v_param_entrada VARCHAR2) RETURN VARCHAR2
IS
-- Funcion que llama a otras rutinas en forma dinamica
-- Creación : 11 de marzo de 2002
-- Modificación : 23 de mayo de 2002
-- Autor Doris Soto A.
-- Modificacion: 05-04-2004 GMGE -- Se corrige error producido al parametrizar funciones de modulo CR
-- Nuevo envia a Ecuador 10-10-2008
/*
<NOMBRE>       : GE_FN_EJECUTA_RUTINA</NOMBRE>
<FECHACREA>    : <FECHACREA/>
<MODULO >      : IC</MODULO >
<AUTOR >       : Doris Soto A.</AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Funcion que llama a otras rutinas en forma dinamica</DESCRIPCION>
<FECHAMOD >    : 19/05/2006 </FECHAMOD >
<DESCMOD >     : Se homologan modificaciones realizadas en la función GE_FN_EJECUTA_RUTINA_BIND Incidencia MA-200605190935
                 Realizado por Maria Lorena Rojo</DESCMOD>
*/


   error_proceso EXCEPTION;
   v_nom_rutina   ged_plantillarutinas.nom_rutina%TYPE;
   v_flg_estado   ged_plantillarutinas.flg_estado%TYPE;
   v_cod_rutina   ged_plantillarutinas.cod_rutina%TYPE;
   v_param_salida VARCHAR2(2000) := '';
   v_param_entrada_cte VARCHAR2(2000);
   v_comando_sql  VARCHAR2(2000);
   v_glserror     VARCHAR2(100);
   PARAMETRO VARCHAR2(2000);
   contador   NUMBER(3):=0;
   pos      NUMBER(3):=0;
	P1						   VARCHAR2(100);
	P2						   VARCHAR2(100);
	P3						   VARCHAR2(100);
	P4						   VARCHAR2(100);
	P5						   VARCHAR2(100);
	P6						   VARCHAR2(100);
	P7						   VARCHAR2(100);
	P8						   VARCHAR2(100);
	P9						   VARCHAR2(100);
	P10						   VARCHAR2(100);
BEGIN
-- Selecciona rutina a ejecutar y valida su existencia
   SELECT nom_rutina, flg_estado, cod_rutina
   INTO v_nom_rutina, v_flg_estado, v_cod_rutina
   FROM ged_plantillarutinas
   WHERE cod_operadora = ge_fn_operadora_scl()
     AND cod_modulo = v_modulo
     AND num_correlativo = v_correlativo;
   IF SQLCODE <> 0 THEN
      v_param_salida := 'ERROR GE_FN_EJECUTA_RUTINA: ged_plantillarutinas';
      RAISE error_proceso;
   END IF;
   IF v_flg_estado = 'TRUE' THEN
--    Llama a la otra rutina diferenciando Funcion, PL sin parametros y PL con parametros
      IF v_cod_rutina = 'FC' AND v_param_entrada IS NOT NULL THEN -- 5-4-2004 GMGE
        BEGIN
            PARAMETRO:=v_param_entrada;
        	contador:=1;
        	pos:=0;
        	v_param_entrada_cte:=':P1';
            pos:=INSTR(PARAMETRO,',');
            IF POS = 0 THEN
        	   P1:=PARAMETRO;
            ELSE
-- MA-200605190935
        	   LOOP
        			IF CONTADOR = 1 THEN
        			   P1:=REPLACE(LPAD(PARAMETRO,POS-1),'''','');
        			   IF INSTR(PARAMETRO,',') = 0 THEN EXIT; END IF;
        			END IF;
        			IF CONTADOR = 2 THEN
        			   P2:=REPLACE(LPAD(PARAMETRO,POS-1),'''','');
        			   IF INSTR(PARAMETRO,',') = 0 THEN EXIT; END IF;
        			END IF;
        			IF CONTADOR = 3 THEN
        			   P3:=REPLACE(LPAD(PARAMETRO,POS-1),'''','');
        			   IF INSTR(PARAMETRO,',') = 0 THEN EXIT; END IF;
        			END IF;
        			IF CONTADOR = 4 THEN
        			   P4:=REPLACE(LPAD(PARAMETRO,POS-1),'''','');
        			   IF INSTR(PARAMETRO,',') = 0 THEN EXIT; END IF;
        			END IF;
        			IF CONTADOR = 5 THEN
        			   P5:=REPLACE(LPAD(PARAMETRO,POS-1),'''','');
        			   IF INSTR(PARAMETRO,',') = 0 THEN EXIT; END IF;
        			END IF;
        			IF CONTADOR = 6 THEN
        			   P6:=REPLACE(LPAD(PARAMETRO,POS-1),'''','');
        			   IF INSTR(PARAMETRO,',') = 0 THEN EXIT; END IF;
        			END IF;
        			IF CONTADOR = 7 THEN
        			   P7:=REPLACE(LPAD(PARAMETRO,POS-1),'''','');
        			   IF INSTR(PARAMETRO,',') = 0 THEN EXIT; END IF;
        			END IF;
        			IF CONTADOR = 8 THEN
        			   P8:=REPLACE(LPAD(PARAMETRO,POS-1),'''','');
        			   IF INSTR(PARAMETRO,',') = 0 THEN EXIT; END IF;
        			END IF;
        			IF CONTADOR = 9 THEN
        			   P9:=REPLACE(LPAD(PARAMETRO,POS-1),'''','');
        			   IF INSTR(PARAMETRO,',') = 0 THEN EXIT; END IF;
        			END IF;
        			IF CONTADOR = 10 THEN
        			   P10:=REPLACE(LPAD(PARAMETRO,POS-1),'''','');
        			   IF INSTR(PARAMETRO,',') = 0 THEN EXIT; END IF;
        			END IF;
        			PARAMETRO:=SUBSTR(PARAMETRO,pos+1);
        			pos:=INSTR(PARAMETRO,',');
        			IF pos = 0 THEN
        			   pos:=LENGTH(PARAMETRO)+1;
        			END IF;
        			contador:=contador + 1;
        			v_param_entrada_cte:=v_param_entrada_cte||',:P'||contador;
        			IF contador > 10 THEN
      				   v_param_salida := 'ERROR GE_FN_EJECUTA_RUTINA: ged_plantillarutinas no acepta mas de 10 PAR';
      				   RAISE error_proceso;
        			   EXIT;
        			END IF;
              END LOOP;
-- MA-200605190935
        	END IF;
        END;
        v_comando_sql:='SELECT '||v_nom_rutina||'('||v_param_entrada_cte||') FROM dual';
		IF CONTADOR = 1 THEN
         EXECUTE IMMEDIATE v_comando_sql INTO v_param_salida USING P1;
		END IF ;
		IF CONTADOR = 2 THEN
         EXECUTE IMMEDIATE v_comando_sql INTO v_param_salida USING P1,P2;
		END IF ;
		IF CONTADOR = 3 THEN
         EXECUTE IMMEDIATE v_comando_sql INTO v_param_salida USING P1,P2,P3;
		END IF ;
		IF CONTADOR = 4 THEN
         EXECUTE IMMEDIATE v_comando_sql INTO v_param_salida USING P1,P2,P3,P4;
		END IF ;
		IF CONTADOR = 5 THEN
         EXECUTE IMMEDIATE v_comando_sql INTO v_param_salida USING P1,P2,P3,P4,P5;
		END IF ;
		IF CONTADOR = 6 THEN
         EXECUTE IMMEDIATE v_comando_sql INTO v_param_salida USING P1,P2,P3,P4,P5,P6;
		END IF ;
		IF CONTADOR = 7 THEN
         EXECUTE IMMEDIATE v_comando_sql INTO v_param_salida USING P1,P2,P3,P4,P5,P6,P7;
		END IF ;
		IF CONTADOR = 8 THEN
         EXECUTE IMMEDIATE v_comando_sql INTO v_param_salida USING P1,P2,P3,P4,P5,P6,P7,P8;
		END IF ;
		IF CONTADOR = 9 THEN
         EXECUTE IMMEDIATE v_comando_sql INTO v_param_salida USING P1,P2,P3,P4,P5,P6,P7,P8,P9;
		END IF ;
		IF CONTADOR = 10 THEN
         EXECUTE IMMEDIATE v_comando_sql INTO v_param_salida USING P1,P2,P3,P4,P5,P6,P7,P8,P9,P10;
		END IF ;
      ELSIF v_cod_rutina = 'PL' THEN -- sin parametros
         IF TRIM(v_param_entrada) = '' OR v_param_entrada IS NULL THEN
            v_param_entrada_cte := ':v_param_salida';
            v_comando_sql:= 'BEGIN ' || v_nom_rutina||'('|| v_param_entrada_cte ||'); END;';
            EXECUTE IMMEDIATE v_comando_sql USING OUT v_param_salida;
         ELSE --con 1 parametro compuesto entrada y uno compuesto salida
            v_param_entrada_cte := ':v_param_entrada,:v_param_salida';
			v_comando_sql:= 'BEGIN ' || v_nom_rutina||'('|| v_param_entrada_cte ||'); END;';
            EXECUTE IMMEDIATE v_comando_sql USING IN v_param_entrada, OUT v_param_salida;
         END IF;
		--  05-04-2004 EJECUCION DE FUNCION SIN PARAMETRO DE ENTRADA
      ELSIF v_cod_rutina = 'FC' THEN
		    v_comando_sql:='SELECT ' ||v_nom_rutina|| ' FROM dual';
			EXECUTE IMMEDIATE v_comando_sql INTO v_param_salida;
		-- 	05-04-2004
	  ELSE
            v_param_salida := 'ERROR GE_FN_EJECUTA_RUTINA: No está habilitado para la ejecución de ProC';
            RAISE error_proceso;
	  END IF;
   END IF;
   RETURN v_param_salida;
-- Control de errores
   EXCEPTION
   WHEN error_proceso THEN
      RETURN v_param_salida;
   WHEN NO_DATA_FOUND THEN
      RETURN 'ERROR GE_FN_EJECUTA_RUTINA: No existe esta combinación de datos';
   WHEN OTHERS THEN
      RETURN 'ERROR GE_FN_EJECUTA_RUTINA, SQLERRM : ' || SQLERRM;
END;
/
SHOW ERRORS
