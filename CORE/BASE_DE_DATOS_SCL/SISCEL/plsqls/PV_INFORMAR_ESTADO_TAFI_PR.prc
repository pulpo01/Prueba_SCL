CREATE OR REPLACE PROCEDURE Pv_Informar_Estado_Tafi_Pr(
	   	  		  p_modulo 	   IN VARCHAR2,
				  p_idtarea	   IN NUMBER,
				  p_abonado	   IN NUMBER,
				  p_movimiento IN NUMBER,
				  p_estado	   IN VARCHAR2,
				  p_glosa	   IN VARCHAR2
)
IS

v_codestado 	  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_GestorContac 	  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_GestorReten 	  GED_PARAMETROS.VAL_PARAMETRO%TYPE;

v_cod_modulo	  PV_MOV_IDGESTOR_TO.COD_MODULO%TYPE;
v_id_gestor		  PV_MOV_IDGESTOR_TO.ID_GESTOR%TYPE;

v_existe 		  NUMBER(1);
v_contotal 		  NUMBER(9);
v_confinal 		  NUMBER(9);
p_iError		  NUMBER(9);
p_vdescerror      VARCHAR2(255);
p_iEvento		  NUMBER(9);

BEGIN


	 SELECT VAL_PARAMETRO
	   INTO v_GestorContac
       FROM GED_PARAMETROS
      WHERE COD_MODULO = 'GA'
	    AND COD_PRODUCTO = 1
		AND NOM_PARAMETRO = 'COD_GESCONT';


	 SELECT VAL_PARAMETRO
	   INTO v_GestorReten
       FROM GED_PARAMETROS
      WHERE COD_MODULO = 'GA'
	    AND COD_PRODUCTO = 1
		AND NOM_PARAMETRO =  'COD_GESRETE';


	IF p_modulo IS NOT NULL AND p_idtarea IS NOT NULL THEN

	   SELECT VAL_PARAMETRO
		   INTO v_codestado
	       FROM GED_PARAMETROS
	      WHERE COD_MODULO = 'GA'
		    AND COD_PRODUCTO = 1
			AND NOM_PARAMETRO = 'COD_' || p_modulo || '_' ||  P_ESTADO;

	   IF P_ESTADO = 'ASIGNADA' THEN

	      IF v_GestorContac= p_modulo THEN
		     -- gc_ModificacionApunte_PR(p_idtarea,v_codestado,p_glosa);
			 Gc_Contactos_Pg.GC_ModificacionTareas_PR(5, v_codestado, NULL,1,p_idtarea, NULL, p_glosa, USER );
 	      ELSIF v_GestorReten = p_modulo THEN
		      --gr_OOSS_RET_PR(p_idtarea,v_codestado);
			 Gr_IORetenciones_Pg.GR_OSSRET_PR(p_idtarea, v_codestado,p_iError,p_vdescerror,p_iEvento);
		  END IF;

	   ELSIF P_ESTADO = 'CERRADA' THEN

	   	  BEGIN

			 SELECT 1
			   INTO v_existe
			   FROM PV_MOV_IDGESTOR_TO
			  WHERE COD_MODULO = p_modulo
			    AND ID_GESTOR = p_idtarea;

	   	  EXCEPTION
		  	   WHEN NO_DATA_FOUND THEN
				      IF v_GestorContac= p_modulo THEN
					     --gc_ModificacionApunte_PR(p_idtarea,v_codestado,p_glosa);
						 Gc_Contactos_Pg.GC_ModificacionTareas_PR(5, v_codestado, NULL,1,p_idtarea, NULL, p_glosa, USER );
			 	      ELSIF v_GestorReten = p_modulo THEN
					     --gr_OOSS_RET_PR(p_idtarea,v_codestado);
						 Gr_IORetenciones_Pg.GR_OSSRET_PR(p_idtarea, v_codestado,p_iError,p_vdescerror,p_iEvento);
					  END IF;

	   	  END;

	   END IF;

	ELSIF p_movimiento IS NOT NULL AND p_abonado IS NOT NULL THEN

	   	  BEGIN


			 UPDATE PV_MOV_IDGESTOR_TO
			    SET cod_estado = '2'
			  WHERE num_movimiento = p_movimiento;

			 SELECT COD_MODULO, ID_GESTOR
			   INTO v_cod_modulo, v_id_gestor
			   FROM PV_MOV_IDGESTOR_TO
			  WHERE num_movimiento = p_movimiento;

		 	 SELECT VAL_PARAMETRO
			   INTO v_codestado
		       FROM GED_PARAMETROS
		      WHERE COD_MODULO = 'GA'
			    AND COD_PRODUCTO = 1
				AND NOM_PARAMETRO = 'COD_' || v_cod_modulo || '_' ||  P_ESTADO;

		  	 SELECT COUNT(*)
			   INTO v_contotal
		   	   FROM PV_MOV_IDGESTOR_TO
			  WHERE id_gestor = v_id_gestor;

		  	 SELECT COUNT(*)
			   INTO v_confinal
		   	   FROM PV_MOV_IDGESTOR_TO
			  WHERE id_gestor = v_id_gestor
			    AND LTRIM(RTRIM(cod_estado)) = '2';

			 IF v_contotal = v_confinal THEN
			    IF v_GestorContac= v_cod_modulo THEN
				   --gc_ModificacionApunte_PR(v_id_gestor,v_codestado,p_glosa);
				   Gc_Contactos_Pg.GC_ModificacionTareas_PR(5, v_codestado, NULL,1,v_id_gestor, NULL, p_glosa, USER );
		 	    ELSIF v_GestorReten = v_cod_modulo THEN
				   --gr_OOSS_RET_PR(v_id_gestor,v_codestado);
				   Gr_IORetenciones_Pg.GR_OSSRET_PR(v_id_gestor, v_codestado,p_iError,p_vdescerror,p_iEvento);
				END IF;

			    DELETE PV_MOV_IDGESTOR_TO
				 WHERE COD_MODULO = v_cod_modulo
				   AND ID_GESTOR = v_id_gestor;

			 END IF;

	   	  EXCEPTION
		  	   WHEN NO_DATA_FOUND THEN
			   		NULL;
	   	  END;

	    END IF;

EXCEPTION

		 WHEN OTHERS THEN
		 	  NULL;

END;
/
SHOW ERRORS
