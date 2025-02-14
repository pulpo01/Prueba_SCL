CREATE OR REPLACE PROCEDURE AL_NUMERACION_ALTERNATIVA_PR (p_orden al_cab_numeracion.num_numeracion%type) 
IS

v_terminalGSM    al_articulos.tip_terminal%type;
v_estadoReserva  al_series.cod_estado%type;
v_estadoTemporal al_series.cod_estado%type;
v_estadoTransito al_series.cod_estado%type;
v_estadoReservaVta al_series.cod_estado%type;


v_subalm     al_ser_numeracion.cod_subalm%type;
v_central    al_ser_numeracion.cod_central%type;
v_cat        al_ser_numeracion.cod_cat%type;
v_uso        al_lin_numeracion.cod_uso%type;
v_numeracion al_ser_numeracion.ind_numerado%type;
v_stock      al_lin_numeracion.tip_stock%type;
v_cantnum    al_lin_numeracion.can_numera%type;
v_bodega     al_cab_numeracion.cod_bodega%type;
v_estado     al_lin_numeracion.cod_estado%type;
v_articulo   al_lin_numeracion.cod_articulo%type;
v_serie_OONN al_ser_numeracion.num_serie%type ;
v_plan       al_ser_numeracion.plan%type;
v_carga      al_ser_numeracion.carga%type;
v_producto   al_ser_numeracion.cod_producto%type;
v_telefono   al_ser_numeracion.num_telefono%type;
v_num_asig   al_ser_numeracion.num_telefono%type;
v_serie      al_ser_numeracion.num_serie%type;

v_terminal   al_articulos.tip_terminal%type;
v_hlr        icg_central.cod_hlr%type;

v_ind             tmp_numeracion_alter.ind_serie%type;
v_serieBuenas     al_lin_numeracion.can_numera%type;
v_nrosSistema     al_lin_numeracion.can_numera%type;
v_seriesNumeradas al_lin_numeracion.can_numera%type;

   CURSOR c_validaseries(p_orden al_cab_numeracion.num_numeracion%type,
                         p_serie al_ser_numeracion.num_serie%type)
   IS
	  SELECT num_numeracion, num_serie
	  FROM tmp_numeracion_alter
	  WHERE num_numeracion=p_orden
	  AND   num_serie not in (p_serie);

v_validaseries c_validaseries%ROWTYPE;
   
squery     VARCHAR(600);
v_valida   PLS_INTEGER;
v_validaSer al_ser_numeracion.num_serie%type;
v_error    PLS_INTEGER;
v_error_msg VARCHAR(150);
sEstado     VARCHAR(2);

v_err    NUMBER;
v_cant   NUMBER;

BEGIN
	 v_error:=0;
	 sEstado:='NU';
	 v_ind:=0;
     SELECT val_parametro
	 INTO v_terminalGSM
	 FROM ged_parametros
	 WHERE cod_modulo='AL'
	   AND cod_producto=1
	   AND nom_parametro='COD_SIMCARD_GSM';
	   
	 SELECT cod_estado_res, cod_estado_tem, cod_estado_tra, cod_estado_rvt
	 INTO  v_estadoReserva, v_estadoTemporal, v_estadoTransito, v_estadoReservaVta
     FROM al_datos_generales; 
   
     BEGIN
    	 --Datos asociados a la Orden de Numeracion
         SELECT a.cod_bodega, a.tip_numeracion, b.cod_estado,c.cod_subalm, c.cod_central, c.cod_cat,
                b.cod_articulo,  b.cod_uso, c.num_serie, b.tip_stock, b.can_numera, c.plan, c.carga, 
    		    c.cod_producto, c.num_telefono
         INTO  v_bodega, v_numeracion, v_estado, v_subalm, v_central, v_cat, v_articulo, 
            v_uso, v_serie_OONN, v_stock, v_cantnum, v_plan, v_carga, v_producto, v_telefono			 
         FROM al_cab_numeracion a, al_lin_numeracion b, al_ser_numeracion c
         WHERE a.num_numeracion =p_orden
         AND   b.lin_numeracion=1
         AND   a.num_numeracion=b.num_numeracion
         AND   b.num_numeracion=c.num_numeracion
         AND   b.lin_numeracion=c.lin_numeracion;
	 EXCEPTION
	   WHEN no_data_found THEN
	      v_error:=1;
	      v_error_msg:= 'Revise Orden de Numeracion nro: '||to_char(p_orden) ||' falta serie inicial ' ;
	      raise_application_error (-20155,v_error_msg);
	 END; 	

	 IF v_error = 0 THEN
    	  --Valido Existencia de Numeros suficientes 
    	  v_nrosSistema:=0;
    	  SELECT count(1) 
    	  INTO v_nrosSistema
          FROM al_celnum_reutil 
          WHERE cod_subalm = v_subalm
          AND cod_central  = v_central
          AND cod_cat      = v_cat
          AND cod_uso     IN (v_uso, ge_fn_uso_sin_uso) 
          AND (fec_baja + ge_fn_dias_hibernacion(cod_uso) <= TRUNC(SYSDATE) OR ge_fn_dias_hibernacion(cod_uso) = 0) 
          AND ind_equipado = 1  
    	  ;
    	  IF (v_nrosSistema > 0  AND v_nrosSistema >= v_cantnum)  THEN
		  
        	  SELECT tip_terminal
        	  INTO v_terminal
        	  FROM al_articulos
        	  WHERE cod_articulo=v_articulo;

        	  v_hlr:=null;
        	  IF v_terminalGSM= v_terminal THEN
          	    SELECT cod_hlr
        		INTO v_hlr
        		FROM icg_central
        		WHERE cod_central=v_central;
        	  END IF;

        	  v_serieBuenas:=0;
        	  --Validacion de todas las series cargadas   
			  OPEN c_validaseries(p_orden,v_serie_OONN);
			  LOOP
              FETCH c_validaseries INTO v_validaseries;
              EXIT WHEN c_validaseries%NOTFOUND;
        	  
             	  v_ind:=0; --Inicializo indicador de serie valida    
             	  BEGIN
				    v_serie:=v_validaseries.num_serie;
					--dbms_output.put_line('Serie:'||v_serie||'****');
					
					
				    IF (v_terminalGSM = v_terminal AND v_hlr is not null) THEN
                      SELECT  a.num_serie
					  INTO v_validaSer
					  FROM al_series a
					  WHERE a.num_serie = v_serie
                      AND a.cod_bodega =v_bodega 
					  AND a.cod_articulo    = v_articulo
                      AND a.tip_stock = v_stock 
					  AND a.cod_uso = v_uso 
					  AND a.cod_estado   =v_estado
                      AND a.cod_hlr   = v_hlr
                      AND a.cod_estado not in (v_estadoReserva , v_estadoTemporal, v_estadoTransito,v_estadoReservaVta)
        	          AND a.ind_telefono <> 8
                      AND not exists (SELECT d.num_serie 
					                  FROM al_cab_numeracion c , al_lin_numeracion b, al_ser_numeracion d
                                      WHERE c.cod_estado ='NU' 
                        			  AND d.num_numeracion >= 0 AND d.lin_numeracion >= 0
                                      AND c.num_numeracion = b.num_numeracion AND b.num_numeracion=d.num_numeracion
                                      AND b.lin_numeracion=d.lin_numeracion AND d.num_serie = a.num_serie )
                      AND a.num_telefono is null
					  ; 
	                 ELSE
                         SELECT  a.num_serie 
						 INTO v_validaSer
   					     FROM al_series a
   					     WHERE a.num_serie = v_serie
                         AND a.cod_bodega =v_bodega 
   					     AND a.cod_articulo    = v_articulo
                         AND a.tip_stock = v_stock 
   					     AND a.cod_uso = v_uso 
   					     AND a.cod_estado   =v_estado
                         AND a.cod_estado not in (v_estadoReserva , v_estadoTemporal, v_estadoTransito,v_estadoReservaVta)
           	             AND a.ind_telefono <> 8
                         AND not exists (SELECT d.num_serie 
   					                     FROM al_cab_numeracion c , al_lin_numeracion b, al_ser_numeracion d
                                         WHERE c.cod_estado ='NU' 
                           	    	     AND d.num_numeracion >= 0 AND d.lin_numeracion >= 0
                                         AND c.num_numeracion = b.num_numeracion AND b.num_numeracion=d.num_numeracion
                                         AND b.lin_numeracion=d.lin_numeracion AND d.num_serie = a.num_serie)
                         AND a.num_telefono is null
   					     ; 
					 END IF;
                  EXCEPTION 
             		  WHEN no_data_found THEN
					       --dbms_output.put_line('No pasa validacion: ' ||v_validaseries.num_serie);	
                           v_ind:=1; --No existe serie para las condiciones dadas mas arriba
             	  END;

             	  IF v_ind <> 0 THEN
             		 --Actualizo indicador de validacion de tabla temporal
                      UPDATE tmp_numeracion_alter
             		  SET ind_serie=v_ind
             		  WHERE num_numeracion=p_orden
             		   AND	num_serie=v_validaseries.num_serie;
            	  ELSE
            		  v_serieBuenas:=v_serieBuenas + 1;
             	  END IF;
        	  END LOOP;
			  CLOSE c_validaseries;
			  
			  --dbms_output.put_line('Cantidad de Series Validas:'||to_char(v_serieBuenas)); 

			  IF v_serieBuenas > 0 THEN
                  --dbms_output.put_line('Insercion de series validadadas en al_ser_numeracion');
                  --Insercion de series validadadas en al_ser_numeracion 
            	  INSERT INTO al_ser_numeracion (num_serie,num_numeracion,lin_numeracion,ind_numerado,cod_producto,num_telefono,cod_central, cod_subalm, cod_cat, carga, plan)
            	  SELECT num_serie, num_numeracion, 1, v_numeracion, v_producto, null, v_central, v_subalm, v_cat, v_carga, v_plan
            	  FROM tmp_numeracion_alter
            	  WHERE num_numeracion=p_orden
    			    AND num_serie not in (v_serie_OONN)
                    AND ind_serie=0;
            	  
            	  --Actualizacion cantidad de series en al_lin_numeracion  
                  IF v_serieBuenas<>v_cantnum THEN
            	    UPDATE al_lin_numeracion
            		SET can_numera=v_serieBuenas+1
            		WHERE num_numeracion=p_orden
            		 AND  lin_numeracion=1;
            	  END IF;
            
            	  --Entro al Proceso de Numeracion  
      		      --dbms_output.put_line('Entro al Proceso de Numeracion');
    			  v_err:=0;
    			  v_cant:=v_serieBuenas;
    			  --al_pac_numeracion.p_asigna_numero_ordenes(p_orden,1,v_subalm,v_central,v_uso,v_cant,v_cat,v_err);
				  --P_al_asigna_numero_ordenes(to_char(p_orden),1,v_subalm,to_char(v_central),to_char(v_uso),to_char(v_cant),to_char(v_cat));
				  p_asigna_numero_ordenes(p_orden,1,v_subalm,v_central,v_uso,v_cant,v_cat,v_err);
				  
     			  IF v_err <> 0 THEN
         	          v_error_msg:= 'Error al_pac_numeracion.p_asigna_numero_ordenes.'||' Orden:'||to_char(p_orden)||' SubAlm:'||v_subalm||' Central:'||to_char(v_central)||' Uso:'||to_char(v_uso)||' Categoria:'||to_char(v_cat) ;
         	          raise_application_error (-20100,v_error_msg);
     			  ELSE
    			      --dbms_output.put_line('COMMIT');
                 	  --Confirmo lo anterior 
                	  COMMIT;
    			  END IF;
			  END IF;	  
         ELSE
		    v_error:=2;
	        v_error_msg:= 'No hay Suficientes Numeros.Se requieren: '|| to_char(v_nrosSistema) ||' y hay : '|| to_char(v_cantnum) ;
	        raise_application_error (-20100,v_error_msg);
    	 END IF;	
	 END IF;    
 EXCEPTION
   WHEN OTHERS THEN
	    raise_application_error (-20100,to_char(SQLCODE)||' - '||SQLERRM);	 
END;
/
SHOW ERRORS
