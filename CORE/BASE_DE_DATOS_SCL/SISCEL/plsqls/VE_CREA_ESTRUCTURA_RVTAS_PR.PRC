CREATE OR REPLACE PROCEDURE VE_CREA_ESTRUCTURA_RVTAS_PR (vp_transac IN NUMBER)
IS
--
-- Procedimiento de migracion de datos para la Red de Ventas
-- Se generan las estructuras de Red de Ventas , llenado de tabla VE_REDVENTAS_TD
-- Pamela Gonzalez (21-10-2003)

   v_vendedor        ve_vendedores.cod_vendedor%TYPE;
   v_nomVendedor     ve_vendedores.nom_vendedor%TYPE;
   v_tipcomis_vend   ve_tipcomis.cod_tipcomis%TYPE;
   v_padre           ve_vendedores.cod_vende_raiz%TYPE;
   v_CodtipoRed      ve_tipored_td.cod_tipored%TYPE;
   v_tipcomis_det	 ve_tipcomis.cod_tipcomis%TYPE;
   v_nivel_comis     ve_detalle_tipored_td.num_nivel%TYPE;
   v_cant            NUMBER(2);
   v_motivo          ve_casos_migracion_td.des_motivo%TYPE;
   v_error           NUMBER;
   ERROR_PROCESO     EXCEPTION;


   -- Obtengo los vendedores padre que estan vigentes
   CURSOR C_VENDEDOR_PADRE IS
   SELECT cod_vendedor, nom_vendedor, cod_tipcomis
   FROM ve_vendedores
   WHERE SYSDATE BETWEEN fec_contrato AND NVL(fec_fincontrato,SYSDATE)
   AND cod_vendedor = cod_vende_raiz;

   -- Obtengo los vendedores hijos que estan vigentes
   CURSOR C_VENDEDOR_HIJO IS
   SELECT cod_vendedor, nom_vendedor, cod_tipcomis, cod_vende_raiz
   FROM ve_vendedores
   WHERE SYSDATE BETWEEN fec_contrato AND NVL(fec_fincontrato,SYSDATE)
   AND cod_vendedor <> cod_vende_raiz;

   -- Obtengo los tipos de red y niveles donde se encuentra el padre
   CURSOR C_ESTRUCTURA (padre NUMBER) IS
   SELECT cod_tipored, num_nivel
   FROM ve_redventas_td
   WHERE cod_vendedor = padre
   AND SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE);

BEGIN

   v_error := 0;

   BEGIN
   DELETE VE_CASOS_MIGRACION_TD;
   EXCEPTION
      WHEN OTHERS THEN
	     v_error := 2;
         RAISE ERROR_PROCESO;
   END;

   OPEN C_VENDEDOR_PADRE;
   LOOP

        FETCH C_VENDEDOR_PADRE INTO v_vendedor, v_nomVendedor, v_tipcomis_vend;
        EXIT WHEN C_VENDEDOR_PADRE%NOTFOUND;

	    -- Obtengo el tipo de red donde el tipcomis esta en el primer nivel
		-- puede estar solo en uno

		BEGIN

		v_CodTipoRed := -1;
		v_nivel_comis := 1;
        SELECT cod_tipored
        INTO v_CodTipoRed
        FROM ve_detalle_tipored_td
        WHERE num_nivel = v_nivel_comis
		AND cod_tipcomis = v_tipcomis_vend;

		EXCEPTION
		   WHEN NO_DATA_FOUND THEN -- No existe
		   		v_error := 0;
				-- Inserto el registro
				v_motivo := 'No existe un tipo de red con la categoria de venta (' || v_tipcomis_vend || ') en el primer nivel';
   	  	   		INSERT INTO VE_CASOS_MIGRACION_TD (COD_VENDEDOR, NOM_VENDEDOR, DES_MOTIVO, DES_SOLUCION)
   	  	   		VALUES (v_vendedor, v_nomVendedor, v_motivo, 'Crear tipo de red con categoria de venta en el nivel 1');

           WHEN OTHERS THEN
		        v_error := 2;
           		RAISE ERROR_PROCESO;
	  	END;


		IF v_CodTipoRed IS NOT NULL AND v_CodTipoRed <> -1 THEN -- Existe

		   BEGIN

		   v_error := 0;
		   -- Valida si ya existe en la estructura de Red de Ventas
		   SELECT COUNT(1)
		   INTO v_cant
		   FROM ve_redventas_td
		   WHERE cod_tipored = v_CodTipoRed
		   AND cod_vendedor = v_vendedor
		   AND num_nivel = 1
		   AND SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE);

		   EXCEPTION
		     WHEN OTHERS THEN
			    v_error := 2;
           		RAISE ERROR_PROCESO;
	  	   END;

		   IF v_cant = 0 THEN -- No existe

			  BEGIN
		      -- Inserto el registro
   	  		  INSERT INTO VE_REDVENTAS_TD (COD_TIPORED, COD_VENDEDOR, FEC_DESDE, NUM_NIVEL, FEC_HASTA, NOM_USUARIO, COD_VENDE_PADRE)
   	  		  VALUES (v_CodTipoRed, v_vendedor, SYSDATE, v_nivel_comis, NULL, USER, v_vendedor);

			  EXCEPTION
           		WHEN OTHERS THEN
           			 v_error := 2;
					 RAISE ERROR_PROCESO;
	  	      END;
		   END IF;

		END IF;
	--    COMMIT;
	END LOOP;

    CLOSE C_VENDEDOR_PADRE;

	OPEN C_VENDEDOR_HIJO;

   	LOOP

        FETCH C_VENDEDOR_HIJO INTO v_vendedor, v_nomVendedor, v_tipcomis_vend, v_padre;
        EXIT WHEN C_VENDEDOR_HIJO%NOTFOUND;

		v_CodTipoRed := -1;
		v_nivel_comis := 0;
        v_error := 0;

		-- Valido si se encuentra su padre en la estructura
        OPEN C_ESTRUCTURA(v_padre);
		LOOP

        	FETCH C_ESTRUCTURA INTO v_CodTipoRed, v_nivel_comis;
        	EXIT WHEN C_ESTRUCTURA%NOTFOUND;

			v_tipcomis_det := '00';
			v_nivel_comis := v_nivel_comis + 1;

			BEGIN
			SELECT cod_tipcomis
			INTO v_tipcomis_det
			FROM ve_detalle_tipored_td
			WHERE cod_tipored = v_CodTipoRed
			AND num_nivel = v_nivel_comis;

			EXCEPTION
	    	WHEN NO_DATA_FOUND THEN -- No existe
			    v_error := 0;
				v_motivo := 'No existe una categoria de venta asignada en el nivel ' || v_nivel_comis || ' del tipo de red ' || v_CodTipoRed;
				-- Inserto el registro
   	  	   		INSERT INTO VE_CASOS_MIGRACION_TD (COD_VENDEDOR, NOM_VENDEDOR, DES_MOTIVO, DES_SOLUCION)
   	  	   		VALUES (v_vendedor, v_nomVendedor, v_motivo, 'Crear tipo de red con categoria de venta correspondiente');

			WHEN OTHERS THEN
              	v_error := 2;
				RAISE ERROR_PROCESO;
	  		END;

			-- Si coincide el modelo de categorias de venta por nivel
			IF v_tipcomis_det = v_tipcomis_vend THEN
			   IF v_tipcomis_det <> '00' THEN

			   	  BEGIN

				  v_error := 0;
				  -- Valida si ya existe en la estructura de Red de Ventas
			   	  SELECT COUNT(1)
			   	  INTO v_cant
			   	  FROM ve_redventas_td
			   	  WHERE cod_tipored = v_CodTipoRed
			   	  AND cod_vendedor = v_vendedor
				  AND SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE);

				  EXCEPTION
		     		WHEN OTHERS THEN
           				 v_error := 2;
						 RAISE ERROR_PROCESO;
	  	   		  END;

			   	  IF v_cant = 0 THEN -- No existe

				    BEGIN
					v_error := 0;
					-- Inserto el registro
   	  		   		INSERT INTO VE_REDVENTAS_TD (COD_TIPORED, COD_VENDEDOR, FEC_DESDE, NUM_NIVEL, FEC_HASTA, NOM_USUARIO, COD_VENDE_PADRE)
   	  				VALUES (v_CodTipoRed, v_vendedor, Sysdate, v_nivel_comis, NULL, USER, v_padre);

					EXCEPTION
         				WHEN OTHERS THEN
            				 v_error := 2;
							 RAISE ERROR_PROCESO;
	  				END;
			   	  END IF;
				END IF;
			ELSE
				IF v_tipcomis_det <> '00' THEN
				   BEGIN

				   v_error := 0;
				   v_motivo := 'No coincide la categoria de venta (' || v_tipcomis_det || ') asignada en el tipo de red: ' || v_CodTipoRed || ' con la categoria de venta (' || v_tipcomis_vend || ') del vendedor';

				   -- Inserto el registro
   	  	   		   INSERT INTO VE_CASOS_MIGRACION_TD (COD_VENDEDOR, NOM_VENDEDOR, DES_MOTIVO, DES_SOLUCION)
   	  	   		   VALUES (v_vendedor, v_nomVendedor, v_motivo, 'Crear tipo de red con categoria de venta correspondiente');

				   EXCEPTION
         				WHEN OTHERS THEN
            				 v_error := 2;
							 RAISE ERROR_PROCESO;
	  			   END;

				END IF;
			END IF;

		END LOOP;

    	CLOSE C_ESTRUCTURA;

		IF v_CodTipoRed = -1 THEN -- No Existe el padre
		   BEGIN
			v_error := 0;
			-- Inserto el registro
   	  	   	INSERT INTO VE_CASOS_MIGRACION_TD (COD_VENDEDOR, NOM_VENDEDOR, DES_MOTIVO, DES_SOLUCION)
   	  	   	VALUES (v_vendedor, v_nomVendedor, 'No existe el padre en la estructura de Red de Ventas', 'Insertar al padre en el nivel del tipo de red que corresponda');

			EXCEPTION
         		WHEN OTHERS THEN
            		v_error := 2;
					RAISE ERROR_PROCESO;
	  		END;

		END IF;


   	END LOOP;

    CLOSE C_VENDEDOR_HIJO;

	INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
    VALUES (vp_transac, v_error, NULL);

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      --COMMIT;
	  INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
      VALUES (vp_transac, v_error, NULL);
   WHEN ERROR_PROCESO THEN
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
      VALUES (vp_transac, v_error, NULL);
      --ROLLBACK;
   WHEN OTHERS THEN
      NULL;
END;
/
SHOW ERRORS
