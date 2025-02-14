CREATE OR REPLACE FUNCTION Fn_Tmm_Codplan_prueba(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    V_OUT        STRING(512);
    V_CODE       STRING(5);
    V_PLAN       ICC_MOVIMIENTO.PLAN%TYPE;
    V_TIP_TECNO  ICC_MOVIMIENTO.tip_tecnologia%TYPE;
	v_subtec     ICC_MOVIMIENTO.tip_tecnologia%TYPE;
	v_modulo     ICC_MOVIMIENTO.cod_modulo%TYPE;
	v_actabo	 ICC_MOVIMIENTO.cod_actabo%TYPE;
    error_proceso EXCEPTION;
	error_homologacion EXCEPTION;
  BEGIN

--        SELECT NVL(PLAN, CHR(0)), NVL(TIP_TECNOLOGIA, CHR(0)) INTO v_plan, v_tip_tecno
--        FROM ICC_MOVIMIENTO
--        WHERE num_movimiento = v_num_mov;

	   SELECT NVL(b.PLAN, CHR(0)), NVL(b.TIP_TECNOLOGIA, CHR(0)), c.tecnologia, b.cod_modulo, b.cod_actabo
	   INTO v_plan, v_tip_tecno, v_subtec, v_modulo, v_actabo
       FROM ICC_MOVIMIENTO b, (SELECT a.cod_central,
	   DECODE(SUBSTR(a.nom_central,1,4),'C190','CD1900','C850','CD850','GSM') AS tecnologia
       FROM icg_central a) c
       WHERE b.num_movimiento = v_num_mov
	   AND c.cod_central =  b.cod_central;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

       IF v_tip_tecno = 'CDMA' THEN

          IF  v_modulo = 'AL' THEN
		      v_out := Pv_Homologacionplan_Fn(v_plan);

		   IF v_subtec = 'CD850'  THEN
		   	    v_out := v_out||'B';
		   ELSE
		   	    v_out := v_out||'A';
		   END IF;
		  ELSE
		  	v_out := v_plan;
		  END IF;

    		  v_code := SUBSTR(v_out,1,4);
              IF v_code = 'ORA-' THEN
                 RAISE error_homologacion;
              END IF;
       ELSE
          v_out := v_plan;
       END IF;

       v_out := v_out || '|' || v_out;
       RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
	  RETURN 'ERROR FN_TMM_codplan, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN error_homologacion THEN
      RETURN 'ERROR FN_TMM_codplan, SLQERRM:' || v_out;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_codplan, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;
/
SHOW ERRORS
