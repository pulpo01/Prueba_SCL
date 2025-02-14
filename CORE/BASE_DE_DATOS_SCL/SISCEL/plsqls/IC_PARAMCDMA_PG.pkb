CREATE OR REPLACE PACKAGE BODY IC_PARAMCDMA_PG AS

----------------------------------------------------------------------------
-- IC_CODPLAN_FN --
----------------------------------------------------------------------------

  FUNCTION IC_CODPLAN_FN(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
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

       IF substr(v_tip_tecno,1,3) = 'CDM' THEN
		  IF  v_modulo = 'AL'
		  THEN
		     IF v_subtec = 'CD850'  THEN
		   	    v_out := 'F5';
		     ELSE
		   	    v_out := 'H5';
		     END IF;
		  ELSE
		  	v_out := v_plan;
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



-----------------------------------------------------------------------------------------
-- IC_TECNOLOGIA_CDMA_FN.
-----------------------------------------------------------------------------------------

  FUNCTION IC_TECNOLOGIA_CDMA_FN(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
	  v_out STRING(512);
	  v_switchid NUMBER(3);
	  v_nummin STRING(512);
	  v_piv STRING(10);
	  v_pivnum NUMBER(10);

	  error_proceso EXCEPTION;
	  error_proceso_nue EXCEPTION;

  BEGIN

	    v_out := '';
	    v_nummin := Ic_Pkg_Parametros.FN_TMM_nummin(V_NUM_MOV);

	    IF SQLCODE <> 0 THEN
	      RAISE error_proceso;
	    END IF;

	    v_piv := SUBSTR(v_nummin,1,7);
	    v_pivnum := TO_NUMBER(v_piv);

	    SELECT COUNT(1)
	    INTO v_switchid
	    FROM ICC_SWITCH_TO
	    WHERE v_pivnum BETWEEN COD_INFERIOR AND COD_SUPERIOR;
	    IF v_switchid>0 THEN
	       v_out := '1110';
	    ELSE
	       v_out := '1120';
	    END IF;

		RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
	  RETURN 'ERROR IC_TECNOLOGIA_CDMA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_TECNOLOGIA_CDMA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;


-----------------------------------------------------------------------------------------
-- IC_ICCDEC_FN. Entrega el ICC en formato decimal (EN CDMA la serie esta en Hexa).
-----------------------------------------------------------------------------------------

  FUNCTION IC_ICCDEC_FN(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    v_num_serie1 ICC_MOVIMIENTO.num_serie%TYPE;
    v_num_serie2 ICC_MOVIMIENTO.num_serie%TYPE;
    v_num_serie_nue ICC_MOVIMIENTO.num_serie_nue%TYPE;
    v_num_serie3 ICC_MOVIMIENTO.num_serie_nue%TYPE;
    v_num_serie4 ICC_MOVIMIENTO.num_serie_nue%TYPE;
    v_dec GA_ABOCEL.num_serie%TYPE;
	v_dec_new GA_ABOCEL.num_serie%TYPE;

    error_proceso EXCEPTION;
  BEGIN


    SELECT TO_CHAR(Ic_Pkg_Parametros.FN_GEN_HexToNum(SUBSTR(NVL(num_serie, CHR('00')),1,2)))
	       ,TO_CHAR(Ic_Pkg_Parametros.FN_GEN_HexToNum(SUBSTR(NVL(num_serie, CHR(0)),3)))
		   ,num_serie_nue
        INTO v_num_serie1, v_num_serie2, v_num_serie_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

	    -- Se asume serie hexadecimal => hay que convertirla a decimal --

        v_dec := SUBSTR('000'||v_num_serie1, LENGTH(v_num_serie1)+1, 3)||SUBSTR('00000000'||v_num_serie2, LENGTH(v_num_serie2)+1, 8);

		IF v_num_serie_nue IS NOT NULL THEN
		   v_num_serie3 := TO_CHAR(Ic_Pkg_Parametros.FN_GEN_HexToNum(SUBSTR(NVL(v_num_serie_nue, CHR('00')),1,2)));
		   v_num_serie4 := TO_CHAR(Ic_Pkg_Parametros.FN_GEN_HexToNum(SUBSTR(NVL(v_num_serie_nue, CHR(0)),3)));
		   v_dec_new := SUBSTR('000'||v_num_serie3, LENGTH(v_num_serie3)+1, 3)||SUBSTR('00000000'||v_num_serie4, LENGTH(v_num_serie4)+1, 8);

		   v_out := v_dec || '|' || v_dec_new;
		ELSE
		   v_out := v_dec || '|' || v_dec;
		END IF;

  RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR IC_ICCDEC_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_ICCDEC_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;


  END IC_PARAMCDMA_PG;
/
SHOW ERRORS
