CREATE OR REPLACE PROCEDURE SISCEL.Ic_Pr_Penalizacion(
/*
<NOMBRE>       : Ic_Pr_Penalizacion</NOMBRE>
<FECHACREA>    : 12-2006<FECHACREA/>
<MODULO >      : IC</MODULO >
<AUTOR >       : ANONIMO</AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Inserta los servicios a suspender en la tabla ICC_PENALIZACION</DESCRIPCION>
<FECHAMOD >    : 23/01/2007 </FECHAMOD >
<DESCMOD >     : Se modifica la forma de actualizar la tabla icc_penalizacion cuando se aplican rehabilitaciones Inc 36137</DESCMOD>
<VERSIONMOD >  : 1.1</VERSIONMOD >
<FECHAMOD >    : 16/09/2008 </FECHAMOD >
<DESCMOD >     : Se modifica la forma de actualizar la tabla icc_penalizacion cuando se aplican rehabilitaciones Inc 68064</DESCMOD>
<VERSIONMOD >  : 1.2</VERSIONMOD >

*/

vp_num_abo IN ga_abocel.num_abonado%TYPE, -- numero abonado a suspender
vp_cod_mod IN ge_modulos.cod_modulo%TYPE, -- codigo modulo que suspende
vp_cod_sus IN icg_susprehamod.cod_suspreha%TYPE, -- codigo suspension
vp_cod_sus_reha IN NUMBER,                       -- Flag suspencion o rehabilitacion CH-2527 Soporte RyC 01-03-2005 capc
EV_cod_actuacion IN icg_actuacion.cod_actuacion%TYPE default null ) IS -- Nuevo parametro para trabajo de rehabilitacion Inc. 36137
--v_err OUT VARCHAR2
--    Funcion:	  		Inserta los servicios a suspender en la tabla ICC_PENALIZACION
--                      para permitir la posterior rehabilitación de estos ultimos.
--    Fecha:			29.05.2003
--    Modificaciones:
v_cod_act icg_actuacion.cod_actuacion%TYPE;
v_cod_ser_act ICG_ACTUACION.COD_SERVICIO%TYPE; -- contenido: cadena con uno o mas servicios con su nivel
v_cod_ser_pen ICC_PENALIZACION.COD_SERVICIO%TYPE; -- contenido : servicio
v_cod_niv_pen ICC_PENALIZACION.COD_NIVEL%TYPE;
v_cod_niv_rea icc_penalizacion.cod_nivel_rea%TYPE;
LV_tip_suspension icc_penalizacion.tip_suspension%TYPE;
LN_cod_nivel_rea icc_penalizacion.cod_nivel_rea%TYPE;

v_cod_ser_aux VARCHAR2(6);
v_len NUMBER;
v_cnt NUMBER;
v_ini NUMBER := 1;
v_logica_inv NUMBER; --CH-2527 Soporte RyC 01-03-2005 capc

v_err VARCHAR2(255);

BEGIN
    -- Obtiene el codigo de actuacion de suspension
    IF EV_cod_actuacion IS NULL THEN
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
    ELSE
        v_cod_act := EV_cod_actuacion;
    END IF;

    -- Obtiene los servicios suplementarios a suspender
    BEGIN
        SELECT COD_SERVICIO
        INTO v_cod_ser_act
        FROM ICG_ACTUACION
        WHERE COD_PRODUCTO = 1
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

	    IF vp_cod_sus_reha = 1 THEN --se genera suspencion CH-2527 Soporte RyC 01-03-2005 capc

    	    -- Obtiene el nivel con el que fue suspendido
    	    SELECT NVL(MIN(COD_NIVEL), -1)
    	    INTO v_cod_niv_rea
    	    FROM ICC_PENALIZACION
    	    WHERE NUM_ABONADO = vp_num_abo
    	    AND COD_SERVICIO = v_cod_ser_pen
    	    AND COD_MODULO = vp_cod_mod
    	    AND TIP_SUSPENSION != 'UR' ; --CH-2527 Soporte RyC 01-03-2005 capc

    	    -- Obtiene el nivel del servicio para su rhabilitacion posteriror
    	    IF v_cod_niv_rea = -1 THEN
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
		            WHEN NO_DATA_FOUND THEN
          	            v_cod_niv_rea := 0;
        	        WHEN OTHERS THEN
		  	            IF SQLCODE = -1422 THEN
	  	                    v_err := 'Abonado posee el servicio duplicado';
            	            RAISE_APPLICATION_ERROR(-20005, 'IC_PR_PENALIZACION/' || v_err, TRUE);
		  	            END IF;
      	        END;
    	    END IF;

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
	    ELSIF  vp_cod_sus_reha = 2 THEN
	        -- Para Rehabilitaciones CH-2527 Soporte RyC 01-03-2005 capc

    	    --Obtiene Logica Inversa / Normal
    	    SELECT INSTR(NVL(VAL_PARAMETRO,-1),v_cod_ser_pen,1,1)
    	    INTO v_logica_inv
    	    FROM GED_PARAMETROS
		    WHERE COD_MODULO ='IC'
		    AND COD_PRODUCTO =1
 		    AND NOM_PARAMETRO ='SERV.SUSP.COMERCIAL';

    	    IF v_logica_inv > 0 THEN -- Servicios de Logica Inversa
    		    -- Obtiene el nivel con el que fue suspendido
    		    SELECT NVL(MIN(COD_NIVEL), -1)
    		    INTO v_cod_niv_rea
    		    FROM ICC_PENALIZACION
    		    WHERE NUM_ABONADO = vp_num_abo
    		    AND COD_SERVICIO = v_cod_ser_pen ;

    	    ELSE  --Servicios Normales

    	   	    -- Obtiene el nivel con el que fue suspendido
    		    SELECT NVL(MAX(COD_NIVEL), -1)
    		    INTO v_cod_niv_rea
    		    FROM ICC_PENALIZACION
    		    WHERE NUM_ABONADO = vp_num_abo
    		    AND COD_SERVICIO = v_cod_ser_pen ;

    	    END IF;


            -- INICIO 36137 23-01-2007

            IF v_cod_niv_rea = -1 THEN
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
		            WHEN NO_DATA_FOUND THEN
          	            v_cod_niv_rea := 0;
        	        WHEN OTHERS THEN
		  	            IF SQLCODE = -1422 THEN
	  	                    v_err := 'Abonado posee el servicio duplicado';
            	            RAISE_APPLICATION_ERROR(-20006, 'IC_PR_PENALIZACION/' || v_err, TRUE);
		  	            END IF;
      	        END;
            END IF;

    		UPDATE ICC_PENALIZACION
    		   SET TIP_SUSPENSION = 'UR'
    		 WHERE NUM_ABONADO = vp_num_abo
    		   AND COD_MODULO = vp_cod_mod
    		   AND COD_SUSPREHA = vp_cod_sus
    		   AND COD_SERVICIO = v_cod_ser_pen
    		   AND COD_NIVEL = v_cod_niv_rea
    		   AND ROWNUM < 2;

    		BEGIN
    		    SELECT TIP_SUSPENSION, COD_NIVEL_REA
    		    INTO LV_tip_suspension, LN_cod_nivel_rea
    		    FROM ICC_PENALIZACION A
    		    WHERE NUM_ABONADO = vp_num_abo
    		    AND COD_SERVICIO = v_cod_ser_pen
    		    AND FEC_INGRESO = (SELECT MIN(FEC_INGRESO)
    		                      FROM ICC_PENALIZACION
    		                      WHERE NUM_ABONADO = A.NUM_ABONADO
    		                      AND COD_SERVICIO = A.COD_SERVICIO
    		    );
    		EXCEPTION WHEN NO_DATA_FOUND THEN
    		    NULL;
    		END;

    		IF LV_tip_suspension = 'UR' THEN
    		    UPDATE ICC_PENALIZACION A
    		    SET COD_NIVEL_REA = LN_cod_nivel_rea
    		    WHERE NUM_ABONADO = vp_num_abo
    		    AND COD_SERVICIO = v_cod_ser_pen
    		    AND TIP_SUSPENSION <> 'UR'
    		    AND FEC_INGRESO = (SELECT MIN(FEC_INGRESO)
    		                       FROM ICC_PENALIZACION
    		                       WHERE NUM_ABONADO = A.NUM_ABONADO
    		                       AND COD_SERVICIO = A.COD_SERVICIO
    		                       AND TIP_SUSPENSION <> 'UR'
    		    );
    		END IF;

    		DELETE FROM ICC_PENALIZACION
    		WHERE NUM_ABONADO = vp_num_abo
    		AND COD_MODULO = vp_cod_mod
    		AND COD_SUSPREHA = vp_cod_sus
    		AND COD_SERVICIO = v_cod_ser_pen
    		AND COD_NIVEL = v_cod_niv_rea
    		AND TIP_SUSPENSION = 'UR';

            -- Fin 36137

    		v_ini := v_ini + 6;
    	END IF;

	END LOOP;

EXCEPTION WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(-20099, 'IC_PR_PENALIZACION/' || SQLERRM, TRUE);

END Ic_Pr_Penalizacion;
/
SHOW ERROR