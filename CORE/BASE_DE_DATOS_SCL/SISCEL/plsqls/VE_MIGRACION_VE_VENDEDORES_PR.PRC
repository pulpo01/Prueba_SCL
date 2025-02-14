CREATE OR REPLACE PROCEDURE VE_MIGRACION_VE_VENDEDORES_PR
IS
--
-- Procedimiento de migracion de datos desde la tabla antigua VE_VENDEDORES a la nueva
-- Pamela Gonzalez (28-07-2003)

   v_vendedor      ve_vendedores.cod_vendedor%TYPE;
   v_error         VARCHAR2 (1) := '0';
   v_cuenta        ge_clientes.cod_cuenta%TYPE;
   v_cliente       ge_clientes.cod_cliente%TYPE;
   v_direccion     ge_direcciones.cod_direccion%TYPE;
   v_plaza		   ge_ciudades.cod_plaza%TYPE;
   v_estado		   ve_estados_td.cod_estado%TYPE;
   v_cantEstados   Number(2);
   v_fec_alta      ve_vendedores.fec_contrato%TYPE;
   v_fec_baja	   ve_vendedores.fec_fincontrato%TYPE;
   ERROR_PROCESO   EXCEPTION;



   	CURSOR vendedor IS
    SELECT cod_vendedor, cod_cliente, cod_direccion, fec_contrato, fec_fincontrato
    FROM ve_vendedores;


BEGIN

   SELECT COUNT(1)
   INTO v_cantEstados
   FROM ve_estados_td;

   IF v_cantEstados = 0 THEN
    BEGIN
   	  INSERT INTO VE_ESTADOS_TD (COD_ESTADO, DES_ESTADO, IND_INVALIDA_VENTA, IND_INVALIDA_COMIS, FEC_DESDE, FEC_ULTMOD, NOM_USUARIO)
   	  VALUES (0, 'VIGENTE', 0, 0, Sysdate, sysdate, User);

   	  INSERT INTO VE_ESTADOS_TD (COD_ESTADO, DES_ESTADO, IND_INVALIDA_VENTA, IND_INVALIDA_COMIS, FEC_DESDE, FEC_ULTMOD, NOM_USUARIO)
   	  VALUES (1, 'NO VIGENTE', 1, 1, Sysdate, sysdate, User);

	  EXCEPTION
         WHEN OTHERS THEN
            RAISE ERROR_PROCESO;
	  END;
	  COMMIT;
   END IF;

   OPEN vendedor;

   LOOP

         FETCH vendedor INTO v_vendedor, v_cliente, v_direccion, v_fec_alta, v_fec_baja;
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
		        v_error := 2;
           		RAISE ERROR_PROCESO;
	  	 END;
         -- Veo si esta vigente o no

		 IF (SYSDATE BETWEEN v_fec_alta AND NVL(v_fec_baja,SYSDATE)) THEN
		 	v_estado := 0;

		 ELSE
		    v_estado := 1;
		 END IF;

		 BEGIN
		 UPDATE ve_vendedores
		 SET cod_cuenta = v_cuenta,
		 	 cod_plaza = v_plaza,
			 cod_estado = v_estado
		 WHERE cod_vendedor = v_vendedor;

         EXCEPTION
           WHEN OTHERS THEN
             RAISE ERROR_PROCESO;

         END;

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
