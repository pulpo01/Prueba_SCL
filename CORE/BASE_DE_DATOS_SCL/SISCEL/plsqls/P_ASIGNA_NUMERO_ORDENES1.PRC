CREATE OR REPLACE PROCEDURE p_asigna_numero_ordenes1(
  v_numeracion IN al_ser_numeracion.num_numeracion%TYPE ,
  v_linea IN al_ser_numeracion.lin_numeracion%TYPE ,
  v_subalm IN ge_subalms.cod_subalm%TYPE ,
  v_central IN icg_central.cod_central%TYPE ,
  v_uso IN al_usos.cod_uso%TYPE ,
  v_nro_reutil IN OUT NUMBER ,
  v_cat IN ga_catnumer.cod_cat%TYPE ,
  v_error IN OUT PLS_INTEGER )
  IS
    v_ind_equipado ga_celnum_reutil.ind_equipado%TYPE;
    v_rownum       NUMBER(4);
    v_producto     ge_datosgener.prod_celular%TYPE;
    v_dias         al_usos.num_dias_hibernacion%TYPE;
    v_uso_sin_uso al_celnum_reutil.cod_uso%TYPE;
	v_cantidad al_lin_numeracion.can_numera%type;	
		
   
		  
          CURSOR c_tel_libres(p_subalm al_series.cod_subalm%type,
                                		   p_producto al_series.cod_producto%type,
                                           p_central al_series.cod_central%type,
                                           p_cat al_series.cod_cat%type,
										   p_uso al_series.cod_uso%type,
										   p_dias al_usos.num_dias_hibernacion%type,
										   p_cantidad al_lin_numeracion.can_numera%type) 
		  IS
               SELECT num_celular
               FROM al_celnum_reutil
              WHERE cod_subalm        = p_subalm
              AND cod_producto      = p_producto
              AND cod_central       =p_central
              AND cod_cat           = p_cat
              AND cod_uso     =p_uso
              AND (fec_baja + p_dias <= TRUNC(SYSDATE) OR p_dias = 0)
             AND ind_equipado      = 1
             AND ROWNUM < p_cantidad + 1
			 FOR UPDATE OF num_celular NOWAIT;
			 
			 

    v_celular     al_celnum_reutil.num_celular%TYPE;
    v_numero      al_ser_numeracion.num_telefono%TYPE;
    v_serie      al_ser_numeracion.num_serie%TYPE;
    v_zero        NUMBER := 0;
	
    BEGIN
        v_ind_equipado := 1;
		v_cantidad:=v_nro_reutil;
        al_pac_numeracion.p_select_celular (v_producto,
                          v_error);
        BEGIN
           v_dias := ge_fn_dias_hibernacion(v_uso);
           v_uso_sin_uso := nvl(ge_fn_uso_sin_uso,v_uso);
           EXCEPTION
                     WHEN OTHERS THEN
                        v_error := 1;
        END;
		
        IF v_error = 0 THEN
		   IF v_nro_reutil > 0 THEN
		   
              OPEN c_tel_libres(v_subalm,v_producto,v_central,v_cat,v_uso,v_dias,v_cantidad);
              LOOP

              FETCH c_tel_libres INTO v_celular;
              EXIT WHEN c_tel_libres%NOTFOUND;
			   
              BEGIN
					 SELECT num_serie 
					 INTO v_serie
		             FROM al_ser_numeracion
                     WHERE num_numeracion = v_numeracion
                     AND lin_numeracion = v_linea
                     AND ind_numerado > 0
                     AND cod_subalm  = v_subalm
                     AND cod_central = v_central
                     AND cod_cat     = v_cat
                     AND num_telefono IS NULL
					 AND rownum <2
                     FOR UPDATE OF num_serie NOWAIT;
					 
                     v_nro_reutil := v_nro_reutil -1;
                     DELETE al_celnum_reutil
                     WHERE num_celular = v_celular;
					 
                     UPDATE al_ser_numeracion
                     SET num_telefono = v_celular
                     WHERE num_numeracion=v_numeracion
			         AND lin_numeracion=v_linea
			         AND num_serie=v_serie;
					 
              EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                                 NULL;
                   WHEN OTHERS THEN
                          IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                             -- Vamos a por otro numero de telefono
                              NULL;
                          ELSE
                               RAISE;
                         END IF;
              END;
              END LOOP;
			  IF c_tel_libres%NOTFOUND THEN
                     v_nro_reutil := 0;
                     CLOSE c_tel_libres;
              END IF;
           END IF;
		END IF;   
		   
        EXCEPTION
        WHEN OTHERS THEN
             IF v_error = 7 THEN
                 RAISE_APPLICATION_ERROR (-20175, 'Error Numeracion Alternativa');
             ELSE
                 v_error := 1;
				 RAISE_APPLICATION_ERROR (-20175, 'Error Numeracion2 Alternativa'||SQLERRM);
             END IF;
    END p_asigna_numero_ordenes1;
/
SHOW ERRORS
