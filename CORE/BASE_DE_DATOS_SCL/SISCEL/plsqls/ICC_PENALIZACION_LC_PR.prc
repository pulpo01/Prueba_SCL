CREATE OR REPLACE PROCEDURE ICC_PENALIZACION_LC_PR(
vp_num_abo IN ga_abocel.num_abonado%TYPE, -- numero abonado a suspender
vp_cod_mod IN ge_modulos.cod_modulo%TYPE, -- codigo modulo que suspende
vp_cod_sus IN ga_suspreha.cod_servicio%TYPE -- codigo suspension
) IS
--v_err OUT VARCHAR2
--    Funcion:	  		Inserta los servicios a suspender en la tabla ICC_PENALIZACION
--                              para permitir la posterior rehabilitacion de estos ultimos.
--    Fecha:			26-05-2004
--    Modificaciones:
v_cod_act icg_actuacion.cod_actuacion%TYPE;
v_cod_ser_act ICG_ACTUACION.COD_SERVICIO%TYPE; -- contenido: cadena con uno o mas servicios con su nivel
v_cod_ser_pen ICC_PENALIZACION.COD_SERVICIO%TYPE; -- contenido : servicio
v_cod_niv_pen ICC_PENALIZACION.COD_NIVEL%TYPE;
v_cod_niv_rea icc_penalizacion.cod_nivel_rea%TYPE;

v_cod_ser_aux VARCHAR2(6);
v_len NUMBER;
v_cnt NUMBER;
v_ini NUMBER := 1;

v_err VARCHAR2(255);

BEGIN
-- Obtiene el codigo de actuacion de suspension
  BEGIN
    SELECT cod_actuacion_susp
	INTO v_cod_act
    FROM icg_susprehamod
    WHERE cod_producto = 1
    AND cod_modulo =  vp_cod_mod
    AND cod_suspreha = vp_cod_sus;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    v_err := 'Sin actuacion de suspension para codigo de suspension especificado';
    RAISE_APPLICATION_ERROR(-20001, 'IC_PR_PENALIZACION/' || v_err, TRUE);
  END;

-- Obtiene los servicios suplementarios a suspender
  BEGIN
    SELECT COD_SERVICIO
    INTO v_cod_ser_act
    FROM ICG_ACTUACION
    WHERE COD_PRODUCTO = 1
    AND COD_MODULO = vp_cod_mod
    AND COD_ACTUACION = v_cod_act;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    v_err := 'Sin servicios de suspension para la actuacion especificada';
    RAISE_APPLICATION_ERROR(-20002, 'IC_PR_PENALIZACION/' || v_err, TRUE);
  END;

  v_len := LENGTH(v_cod_ser_act);

  IF MOD(v_len, 6) <> 0 THEN
  	v_err := 'Cadena de servicios de actuacion sin formato esperado';
    RAISE_APPLICATION_ERROR(-20003, 'IC_PR_PENALIZACION/' || v_err, TRUE);
  END IF;

    FOR v_cnt IN 1..(v_len / 6) LOOP

    v_cod_ser_aux := SUBSTR(v_cod_ser_act, v_ini, 6);
    v_cod_ser_pen := TO_NUMBER(SUBSTR(v_cod_ser_aux, 1, 2));
    v_cod_niv_pen := TO_NUMBER(SUBSTR(v_cod_ser_aux, 3, 4));


    -- Obtiene el nivel del servicio para su rhabilitacion posteriror

      BEGIN
        SELECT COD_NIVEL
        INTO v_cod_niv_rea
        FROM GA_SERVSUPLABO
        WHERE NUM_ABONADO = vp_num_abo
        AND IND_ESTADO < 3
        AND FEC_BAJABD IS  NULL
        AND FEC_BAJACEN IS NULL
        AND COD_SERVSUPL = v_cod_ser_pen;
      EXCEPTION
	    WHEN NO_DATA_FOUND THEN v_cod_niv_rea := 5;
        WHEN OTHERS THEN
		  IF SQLCODE = -1422 THEN
  	        v_err := 'Abonado posee el servicio duplicado';
            RAISE_APPLICATION_ERROR(-20005, 'IC_PR_PENALIZACION/' || v_err, TRUE);
		  END IF;
      END;


    INSERT INTO ICC_PENALIZACION(NUM_ABONADO,
                                 COD_MODULO,
                                 COD_SUSPREHA,
                                 FEC_INGRESO,
                                 COD_SERVICIO,
                                 TIP_SUSPENSION,
                                 COD_NIVEL,
                                 COD_NIVEL_REA)
                          VALUES(vp_num_abo,
		                         vp_cod_mod,
                                 vp_cod_sus,
                                 SYSDATE,
                                 v_cod_ser_pen,
                                 'ST',
                                 v_cod_niv_pen,
		                         v_cod_niv_rea);

    v_ini := v_ini + 6;

  END LOOP;

EXCEPTION WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(-20099, 'IC_PR_PENALIZACION/' || SQLERRM, TRUE);

END ICC_PENALIZACION_LC_PR;
/
SHOW ERRORS
