CREATE OR REPLACE PROCEDURE        P_IC_ACTUALIZA_AKEYS
		  (VP_MOVIMIENTO    IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE,
           VP_CODACTABO		IN ICC_MOVIMIENTO.COD_ACTABO%TYPE,
		   VP_COMPORTA		IN NUMBER,
		   VP_CODSERVICIO	IN ICC_MOVIMIENTO.COD_SERVICIOS%TYPE,
		   VP_SERIE 		IN ICC_MOVIMIENTO.NUM_SERIE%TYPE,
		   VP_SERIENUEVA	IN ICC_MOVIMIENTO.NUM_SERIE_NUE%TYPE)
IS
--
-- Procedimiento para actualizar los estados de las series de
-- terminales de acuerdo a sus A-Keys
--
 v_posicion              NUMBER;
 v_nivel                 VARCHAR2(1);
 v_estado                NUMBER(2);
 v_proc					 VARCHAR2(21);
BEGIN
   v_proc := 'P_IC_ACTUALIZA_AKEYS';
   IF VP_COMPORTA = 0 THEN  -- Evalua
	  --Determinar si se encuentra el servicio 46
	  v_posicion := NULL;
   	  v_posicion := instr(VP_CODSERVICIO, '46');
   	  IF v_posicion <> 0 AND v_posicion IS NOT NULL THEN
		 v_nivel := substr(VP_CODSERVICIO, v_posicion + 5, 1) ;
		 IF v_nivel = 1 	  THEN --Activacion Servicio 46 (autenticacion)
			v_estado := 2;
		 ELSIF v_nivel = 0 THEN --Desactivacion Servicio 46(autenticacion)
			v_estado := 0;
		 END IF;
		 BEGIN
			UPDATE ICT_AKEYS
			SET COD_ESTADO = v_estado, FEC_ACTUALIZACION = SYSDATE
			WHERE NUM_ESN_HEX = VP_SERIE
			AND COD_ESTADO <> -1 ;
		 END;
	  END IF;
   ELSIF VP_COMPORTA = 1 THEN  -- Activa
   	  BEGIN
	  	 UPDATE ICT_AKEYS
   	  	 SET COD_ESTADO = 2, FEC_ACTUALIZACION = SYSDATE
	  	 WHERE NUM_ESN_HEX = VP_SERIE
      	 AND COD_ESTADO <> -1 ;
      END;
   ELSIF VP_COMPORTA = 2 THEN -- Desactiva
   	  BEGIN
	  	 UPDATE ICT_AKEYS
   	  	 SET COD_ESTADO = 0, FEC_ACTUALIZACION = SYSDATE
	  	 WHERE NUM_ESN_HEX = VP_SERIE
      	 AND COD_ESTADO <> -1 ;
      END;
   ELSIF VP_COMPORTA = 3 THEN -- Desactiva serie antigua / Activa nueva serie
   	  BEGIN
	  	 UPDATE ICT_AKEYS
   	  	 SET COD_ESTADO = 0, FEC_ACTUALIZACION = SYSDATE
	  	 WHERE NUM_ESN_HEX = VP_SERIE
      	 AND COD_ESTADO <> -1 ;
	  	 UPDATE ICT_AKEYS
   	  	 SET COD_ESTADO = 2, FEC_ACTUALIZACION = SYSDATE
	  	 WHERE NUM_ESN_HEX = VP_SERIENUEVA
      	 AND COD_ESTADO <> -1 ;
      END;
   ELSE
   	  RAISE_APPLICATION_ERROR(-20201,v_proc||' Comportamiento no contemplado en actualizacion de A-Keys');
   END IF;
EXCEPTION
   WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20203, v_proc||' '||SQLERRM);
END P_IC_ACTUALIZA_AKEYS;
/
SHOW ERRORS
