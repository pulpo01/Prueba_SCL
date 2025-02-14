CREATE OR REPLACE FUNCTION Fn_Tmm_Nummin_Prueba(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING
IS
    v_out STRING(512);
	v_cod_modulo   ICC_MOVIMIENTO.COD_MODULO%TYPE;
	v_num_abonado  ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
	v_fec_ingreso  ICC_MOVIMIENTO.FEC_INGRESO%TYPE;
    v_num_cel     VARCHAR2(512);
    v_num_cel_nue VARCHAR2(512);
    v_nummin      VARCHAR2(512);
    v_nummin_nue  VARCHAR2(512);
    v_dummy       VARCHAR2(512);
    v_dummy_nue   VARCHAR2(512);
    error_proceso EXCEPTION;
    error_negocio_0 EXCEPTION;
    error_negocio_1 EXCEPTION;
    error_negocio_2 EXCEPTION;
    error_negocio_3 EXCEPTION;
    error_GE_FN_MIN_DE_MDN EXCEPTION;
    error_GE_FN_MIN_DE_MDN_nue EXCEPTION;

BEGIN

   SELECT NVL(TO_CHAR(num_celular), CHR(0)), NVL(TO_CHAR(NUM_CELULAR_NUE), CHR(0)),
          NUM_ABONADO, fec_ingreso, cod_modulo
   INTO v_num_cel, v_num_cel_nue, v_num_abonado, v_fec_ingreso, v_cod_modulo
   FROM ICC_MOVIMIENTO
   WHERE num_movimiento = v_num_mov;

   IF SQLCODE <> 0 THEN
      RAISE error_proceso;
   END IF;

   IF v_cod_modulo = 'AL' THEN


      v_dummy := Ge_Fn_Min_De_Mdn(v_num_cel);

      IF v_dummy=0 THEN
         RAISE error_negocio_0;
      ELSIF v_dummy=1 THEN
         RAISE error_negocio_1;
      ELSIF v_dummy=2 THEN
         RAISE error_negocio_2;
      ELSIF v_dummy=3 THEN
         RAISE error_negocio_3;
      ELSIF v_dummy<0 THEN
         RAISE error_GE_FN_MIN_DE_MDN;
      END IF;

      v_nummin:= (v_dummy);

      IF v_num_cel_nue <> CHR(0) THEN
         V_dummy_nue := Ge_Fn_Min_De_Mdn(v_num_cel_nue);

          IF v_dummy_nue =0 THEN
             RAISE error_negocio_0;
          ELSIF v_dummy_nue=1 THEN
              RAISE error_negocio_1;
          ELSIF v_dummy_nue=2 THEN
             RAISE error_negocio_2;
          ELSIF v_dummy_nue=3 THEN
             RAISE error_negocio_3;
          ELSIF v_dummy_nue<0 THEN
             RAISE error_GE_FN_MIN_DE_MDN_nue;
          END IF;

          v_nummin_nue:= (v_dummy_nue);
      ELSE
	      v_nummin_nue:= v_nummin;
      END IF;

   ELSE

      v_nummin_nue := Fn_Recupera_Num_Min(v_num_abonado);

      BEGIN
       v_nummin := Fn_Recupera_Num_Min_Ant (v_num_abonado, v_fec_ingreso);
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
	        v_nummin := v_nummin_nue;
      END;

   END IF;

  v_out := v_nummin || '|' || v_nummin_nue;

  RETURN v_out;

EXCEPTION
    WHEN error_proceso THEN
         RETURN 'ERROR FN_TMM_nummin, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN error_GE_FN_MIN_DE_MDN THEN
        RETURN 'ERROR DE PROCESO EN GE_FN_MIN_DE_MDN (MDN), :' || v_dummy;
    WHEN error_GE_FN_MIN_DE_MDN_nue THEN
        RETURN 'ERROR DE PROCESO EN GE_FN_MIN_DE_MDN (MDN_NUE), :' || v_dummy || ':'|| v_dummy_nue;
    WHEN error_negocio_0 THEN
        RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, :' || v_dummy || ':'|| v_dummy_nue || ' : No existe el numero de MDN';
    WHEN error_negocio_1 THEN
        RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, :' || v_dummy || ':'|| v_dummy_nue || ' : Error en el largo del MDN';
    WHEN error_negocio_2 THEN
        RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, :' || v_dummy || ':'|| v_dummy_nue || ' : Error de formato (contiene caracteres no numericos)';
    WHEN error_negocio_3 THEN
        RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, :' || v_dummy || ':'|| v_dummy_nue || ' : Error comienza con cero';
    WHEN OTHERS THEN
        RETURN 'ERROR FN_TMM_nummin, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;
/
SHOW ERRORS
