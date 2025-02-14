CREATE OR REPLACE PROCEDURE VE_MIGRACION_HISVENDEDORES_PR
IS
--
-- Procedimiento de migracion de datos desde la tabla antigua VE_HISVENDEDORES a la nueva
-- Pamela Gonzalez (29-07-2003)

   v_vendedor      ve_vendedores.cod_vendedor%TYPE;
   v_cuenta        ge_clientes.cod_cuenta%TYPE;
   v_cliente       ge_clientes.cod_cliente%TYPE;
   v_direccion     ge_direcciones.cod_direccion%TYPE;
   v_plaza		   ge_ciudades.cod_plaza%TYPE;
   v_estado		   ve_estados_td.cod_estado%TYPE;
   v_password      ve_vendedores.COD_PASSWORD%TYPE;
   v_indPass	   ve_vendedores.IND_PASSWORD%TYPE;
   v_fecha_alta    ve_vendedores.FEC_CONTRATO%TYPE;
   v_fecha_baja    ve_vendedores.FEC_FINCONTRATO%TYPE;
   ERROR_PROCESO   EXCEPTION;

   CURSOR vendedor IS
   SELECT cod_vendedor, cod_cliente, cod_direccion, fec_contrato
   FROM ve_hisvendedores;

BEGIN

   OPEN vendedor;

   LOOP

         FETCH vendedor INTO v_vendedor, v_cliente, v_direccion, v_fecha_alta;
         EXIT WHEN vendedor%NOTFOUND;

         -- Si el cliente no es nulo en la tabla de origen
         IF v_cliente IS NOT NULL THEN
		  	-- Obtengo la cuenta asociada al cliente
         BEGIN
         	SELECT cod_cuenta
         	INTO v_cuenta
         	FROM ge_clientes
         	WHERE cod_cliente = v_cliente;

		  EXCEPTION
			 	WHEN NO_DATA_FOUND THEN -- No existe
					 v_cuenta := 1;
           	 	WHEN OTHERS THEN
             		 RAISE ERROR_PROCESO;

          END;
		 END IF;

		 -- Obtengo la plaza
         BEGIN
		 SELECT a.cod_plaza
		 INTO v_plaza
		 FROM ge_ciudades a, ge_direcciones b
		 WHERE a.cod_ciudad = b.cod_ciudad and
		 	   a.cod_region = b.cod_region and
			   a.cod_provincia = b.cod_provincia and
			   b.cod_direccion = v_direccion;

		  EXCEPTION
			 	WHEN NO_DATA_FOUND THEN -- No existe
					 v_plaza := '1';
           	 	WHEN OTHERS THEN
             		 RAISE ERROR_PROCESO;

         	END;

         -- Obtengo el estado, codigo e indicador de password y la fecha de fin de contrato asociado

		 SELECT cod_estado, cod_password, ind_password, fec_fincontrato
		 INTO v_estado, v_password, v_indPass, v_fecha_baja
		 FROM ve_vendedores
		 WHERE cod_vendedor = v_vendedor;

	     IF v_fecha_baja IS NULL THEN
		 	v_fecha_baja := SYSDATE;
		 END IF;

		 -- Actualizo el registro con los datos obtenidos
         BEGIN
		 UPDATE ve_hisvendedores
		 SET cod_cuenta = v_cuenta,
		     cod_plaza = v_plaza,
			 cod_estado = v_estado,
			 cod_password = v_password,
			 ind_password = v_indPass,
			 fec_pasohist = v_fecha_baja,
			 nom_usuario = USER
		 WHERE cod_vendedor = v_vendedor and
			   fec_contrato = v_fecha_alta;

         EXCEPTION
           WHEN OTHERS THEN
             RAISE ERROR_PROCESO;

         END;
		 COMMIT;
   END LOOP;


   CLOSE vendedor;

   COMMIT;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      COMMIT;
   WHEN ERROR_PROCESO
   THEN
      ROLLBACK;
   WHEN OTHERS
   THEN
      NULL;
END;
/
SHOW ERRORS
