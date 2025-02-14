CREATE OR REPLACE PROCEDURE P_ASIGNA_NUMERO_ORDENES2(
  p_orden IN al_ser_numeracion.num_numeracion%TYPE ,
  p_linea IN al_ser_numeracion.lin_numeracion%TYPE ,
  p_subalm IN ge_subalms.cod_subalm%TYPE ,
  p_central IN icg_central.cod_central%TYPE ,
  p_uso IN al_usos.cod_uso%TYPE ,
  p_producto al_series.cod_producto%type,
  p_cantidad IN OUT al_lin_numeracion.can_numera%type,
  p_cat IN ga_catnumer.cod_cat%TYPE ,
  p_error IN OUT PLS_INTEGER )
  IS

  v_producto     ge_datosgener.prod_celular%TYPE;
  v_dias         al_usos.num_dias_hibernacion%TYPE;
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
    WHERE cod_subalm  = p_subalm
    AND cod_producto  = p_producto
    AND cod_central   =p_central
    AND cod_cat       = p_cat
    AND cod_uso       =p_uso
    AND (fec_baja + p_dias <= TRUNC(SYSDATE) OR p_dias = 0)
    AND ind_equipado      = 1
    AND ROWNUM < p_cantidad + 1
	FOR UPDATE OF num_celular NOWAIT;
			 
    v_celular     al_celnum_reutil.num_celular%TYPE;
    v_numero      al_ser_numeracion.num_telefono%TYPE;
    v_serie      al_ser_numeracion.num_serie%TYPE;
	v_commit     pls_integer;
	
    BEGIN
        BEGIN
           v_dias := ge_fn_dias_hibernacion(p_uso);
		   dbms_output.put_line(to_char(v_dias));
           EXCEPTION
                     WHEN OTHERS THEN
                        p_error := 1;
        END;
		
        IF p_error = 0 THEN
		   IF p_cantidad > 0 THEN
		      v_commit:=0;
              OPEN c_tel_libres(p_subalm,p_producto,p_central,p_cat,p_uso,v_dias,p_cantidad);
              LOOP
              FETCH c_tel_libres INTO v_celular;
              EXIT WHEN c_tel_libres%NOTFOUND;
			  
					 SELECT num_serie 
					 INTO v_serie
		             FROM al_ser_numeracion
                     WHERE num_numeracion = p_orden
                     AND lin_numeracion = p_linea
                     AND ind_numerado > 0
                     AND cod_subalm  = p_subalm
                     AND cod_central = p_central
                     AND cod_cat     = p_cat
                     AND num_telefono IS NULL
					 AND rownum <2
                     FOR UPDATE OF num_serie NOWAIT;
					 
                     p_cantidad := p_cantidad -1;
                     DELETE al_celnum_reutil
                     WHERE num_celular = v_celular;
					 
                     UPDATE al_ser_numeracion
                     SET num_telefono = v_celular
                     WHERE num_numeracion=p_orden
			         AND lin_numeracion=p_linea
			         AND num_serie=v_serie;
					 
					 --v_commit:=v_commit+1;
					 
					 --IF v_commit = 100 THEN
					   --Confirmar cada 100 registros 
					   --COMMIT;
					   --v_commit:=0;
					 --END IF;  
              END LOOP;
			  --IF v_commit > 0 THEN
			    --Por si quedan transacciones pendientes que confirmar  
			  COMMIT;
			  --END IF;
              CLOSE c_tel_libres;
           END IF;
		END IF;   
EXCEPTION
        WHEN OTHERS THEN
             RAISE;
END;
/
SHOW ERRORS
