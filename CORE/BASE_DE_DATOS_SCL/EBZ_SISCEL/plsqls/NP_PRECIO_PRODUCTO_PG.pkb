CREATE OR REPLACE PACKAGE BODY NP_PRECIO_PRODUCTO_PG AS

	PROCEDURE NP_INSERT_PEDIDO_DET_PR(
			EN_cod_pedido               IN npt_detalle_pedido.cod_pedido%TYPE,
			EN_lin_det_pedido           IN npt_detalle_pedido.lin_det_pedido%TYPE,
			EN_tip_stock                IN npt_detalle_pedido.tip_stock%TYPE,
			EN_cod_articulo             IN npt_detalle_pedido.cod_articulo%TYPE,
			EN_cod_uso                  IN npt_detalle_pedido.cod_uso%TYPE,
			EN_can_detalle_pedido       IN npt_detalle_pedido.can_detalle_pedido%TYPE,
			EN_mto_uni_det_pedido       IN npt_detalle_pedido.mto_uni_det_pedido%TYPE,
			EN_mto_des_det_pedido       IN npt_detalle_pedido.mto_des_det_pedido%TYPE,
			EN_ptj_des_det_pedido       IN npt_detalle_pedido.ptj_des_det_pedido%TYPE,
			EN_mto_net_det_pedido       IN npt_detalle_pedido.mto_net_det_pedido%TYPE,
			EV_cod_tecnologia			IN npt_detalle_pedido.cod_tecnologia%TYPE,
			SV_Error		  			OUT NOCOPY VARCHAR2
			)
		/*
		<Documentaci¾n TipoDoc = "PROCEDURE">
		<Elemento Nombre = "NP_INSERT_PEDIDO_DET_PR" Lenguaje="PL/SQL" Fecha="11-08-2005" Versi¾n="1.1.0" Dise±ador="Freddy Zabala" Programador="Claudio Astudillo" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripci¾n>Insertar detalle pedido</Descripci¾n>
		<Parßmetros>
		<Entrada>
			<param nom="EN_cod_pedido" Tipo="NUMBER">Codigo pedido</param>
			<param nom="EN_lin_det_pedido" Tipo="NUMBER">Linea pedido</param>
			<param nom="EN_tip_stock" Tipo="NUMBER">Tipo de Stock</param>
			<param nom="EN_cod_articulo" Tipo="NUMBER">Codigo Articulo</param>
			<param nom="EN_cod_uso" Tipo="NUMBER">Codigo Uso</param>
			<param nom="EN_can_detalle_pedido " Tipo="NUMBER">Cantidad Pedido</param>
			<param nom="EN_mto_uni_det_pedido" Tipo="NUMBER">Monto Unitario</param>
			<param nom="EN_mto_des_det_pedido" Tipo="NUMBER">Monto descuento</param>
			<param nom="EN_ptj_des_det_pedido Tipo="NUMBER">Porcentaje descuento</param>
			<param nom="EN_mto_net_det_pedido Tipo="NUMBER">Monto neto</param>
			<param nom="EV_cod_tecnologia" Tipo="VARCHAR2">Codigo tecnologia</param>
		</Entrada>
		<Salida>
			<param nom="SV_Error" Tipo="VARCHAR2">Error de salida</param>
		</Salida>
		</Parßmetros>
		</Elemento>
		</Documentaci¾n>
		*/
	AS

	ERROR_CONTROLADO EXCEPTION;
	v_aplicatec varchar2(10);
	v_cod_tecnologia varchar2(7);
	LV_error VARCHAR2(100);

	BEGIN
		 BEGIN
			 SELECT valor_parametro
			 INTO v_aplicatec
			 FROM npt_parametro
			 WHERE alias_parametro ='APLICA_TEC';
		 EXCEPTION
	   		WHEN OTHERS THEN
	   		LV_error := 'No se encontro parametro general';
	   		RAISE ERROR_CONTROLADO;
		END;


		 IF v_aplicatec <>'TRUE' or v_aplicatec = '' THEN
		 	BEGIN
			 	SELECT cod_tecnologia
				INTO v_cod_tecnologia
				FROM AL_TECNOARTICULO_TD
				WHERE cod_articulo = EN_cod_articulo;
			EXCEPTION
		   		WHEN OTHERS THEN
		   		LV_error := 'No se encontro tecnologia para el articulo';
		   		RAISE ERROR_CONTROLADO;
			END;
			BEGIN
				INSERT INTO npt_detalle_pedido (cod_pedido, lin_det_pedido, tip_stock, cod_articulo, cod_uso,
				can_detalle_pedido, mto_uni_det_pedido, mto_des_det_pedido,
				ptj_des_det_pedido, mto_net_det_pedido, tip_stock_orig, cod_tecnologia)
				VALUES (EN_cod_pedido, EN_lin_det_pedido, EN_tip_stock, EN_cod_articulo, EN_cod_uso,
				EN_can_detalle_pedido, EN_mto_uni_det_pedido, EN_mto_des_det_pedido,
				EN_ptj_des_det_pedido, EN_mto_net_det_pedido, EN_tip_stock, v_cod_tecnologia);
			EXCEPTION
		   		WHEN OTHERS THEN
		   		LV_error := 'No se pudo insertar el detalle del pedido';
		   		RAISE ERROR_CONTROLADO;
			END;

		 END IF;

		 IF v_aplicatec ='TRUE' THEN
		 	BEGIN
				INSERT INTO npt_detalle_pedido (cod_pedido, lin_det_pedido, tip_stock, cod_articulo, cod_uso,
				can_detalle_pedido, mto_uni_det_pedido, mto_des_det_pedido,
				ptj_des_det_pedido, mto_net_det_pedido, tip_stock_orig, cod_tecnologia)
				VALUES (EN_cod_pedido, EN_lin_det_pedido, EN_tip_stock, EN_cod_articulo, EN_cod_uso,
				EN_can_detalle_pedido, EN_mto_uni_det_pedido, EN_mto_des_det_pedido,
				EN_ptj_des_det_pedido, EN_mto_net_det_pedido, EN_tip_stock, EV_cod_tecnologia);
			EXCEPTION
		   		WHEN OTHERS THEN
		   		LV_error := 'No se pudo insertar el detalle del pedido';
		   		RAISE ERROR_CONTROLADO;
			END;

		 END IF;
	EXCEPTION
		    WHEN ERROR_CONTROLADO THEN
				SV_Error := LV_error;
            WHEN OTHERS THEN
				SV_Error := SQLCODE || '-' || SQLERRM;
	END;

----------------------------------------------------------------------------------------------------------------------

	PROCEDURE NP_INSERT_DETALLE_CARGO_PR(
			  EN_cod_pedido 	IN np_detalle_cargo_to.cod_pedido%TYPE,
			  EN_lin_det_pedido IN np_detalle_cargo_to.lin_det_pedido%TYPE,
			  EN_cod_producto 	IN np_detalle_cargo_to.cod_producto%TYPE,
			  EV_cod_servicio 	IN np_detalle_cargo_to.cod_servicio%TYPE,
			  EN_mto_cargo 		IN np_detalle_cargo_to.mto_cargo%TYPE,
			  SV_Error		  	OUT NOCOPY VARCHAR2
			  )
	AS
		/*
		<Documentaci¾n TipoDoc = "PROCEDURE">
		<Elemento Nombre = "NP_INSERT_DETALLE_CARGO_PR" Lenguaje="PL/SQL" Fecha="11-08-2005" Versi¾n="1.1.0" Dise±ador="Freddy Zabala" Programador="Claudio Astudillo" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripci¾n>Insertar detalle cargo ocacional</Descripci¾n>
		<Parßmetros>
		<Entrada>
			<param nom="EN_cod_pedido" Tipo="NUMBER">Codigo pedido</param>
			<param nom="EN_lin_det_pedido" Tipo="NUMBER">Linea pedido</param>
			<param nom="EN_cod_producto" Tipo="NUMBER">Codigo producto</param>
			<param nom="EV_cod_servicio" Tipo="NUMBER">Codigo Servicio</param>
			<param nom="EN_mto_cargo" Tipo="NUMBER">Monto cargo</param>
		</Entrada>
		<Salida>
			<param nom="SV_Error" Tipo="VARCHAR2">Error de salida</param>
		</Salida>
		</Parßmetros>
		</Elemento>
		</Documentaci¾n>
		*/
	BEGIN

	  INSERT INTO np_detalle_cargo_to
	  		 (cod_pedido,lin_det_pedido,cod_producto,cod_servicio,mto_cargo,fec_umod,nom_usuaora)
	  VALUES (EN_cod_pedido,EN_lin_det_pedido,EN_cod_producto,EV_cod_servicio,EN_mto_cargo,SYSDATE,USER);

	EXCEPTION
            WHEN OTHERS THEN
				SV_Error := 'No se pudo insertar el detalle del cargo ocacional';

	END;

----------------------------------------------------------------------------------------------------------------------


	PROCEDURE NP_MANTENER_CARGO_OCACIONAL_PR(
			  EN_cod_articulo IN np_cargo_ocacional_td.cod_articulo%TYPE,
			  EN_tip_stock 	  IN np_cargo_ocacional_td.tip_stock%TYPE,
			  EN_cod_uso 	  IN np_cargo_ocacional_td.cod_uso%TYPE,
			  EN_cod_producto IN np_cargo_ocacional_td.cod_producto%TYPE,
			  EN_cod_servicio IN np_cargo_ocacional_td.cod_servicio%TYPE,
			  EV_accion		  IN VARCHAR2,
			  SV_Error		  OUT NOCOPY VARCHAR2
			  )
		/*
		<Documentaci¾n TipoDoc = "PROCEDURE">
		<Elemento Nombre = "NP_MANTENER_CARGO_OCACIONAL_PR" Lenguaje="PL/SQL" Fecha="11-08-2005" Versi¾n="1.1.0" Dise±ador="Freddy Zabala" Programador="Claudio Astudillo" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripci¾n>Insertar cargos ocacionales</Descripci¾n>
		<Parßmetros>
		<Entrada>
			<param nom="EN_cod_articulo" Tipo="NUMBER">Codigo Articulo</param>
			<param nom="EN_tip_stock" Tipo="NUMBER">Tipo de Stock</param>
			<param nom="EN_cod_uso" Tipo="NUMBER">Codigo Uso</param>
			<param nom="EN_cod_producto" Tipo="NUMBER">Codigo Producto</param>
			<param nom="EN_cod_servicio" Tipo="NUMBER">Codigo Servicio</param>
			<param nom="EV_accion" Tipo="VARCHAR2">Tipo accion</param>
		</Entrada>
		<Salida>
			<param nom="SV_Error" Tipo="VARCHAR2">Error de salida</param>
		</Salida>
		</Parßmetros>
		</Elemento>
		</Documentaci¾n>
		*/
	AS
	  ERROR_CONTROLADO EXCEPTION;
	  LN_encontrado PLS_INTEGER;
	  LV_error VARCHAR2(100);
	BEGIN
		SV_Error := '';
		IF UPPER(EV_accion) = 'ELIMTODO' THEN
			SELECT count(1)
			INTO LN_encontrado
			FROM np_cargo_ocacional_td
			WHERE cod_articulo = EN_cod_articulo
			AND tip_stock = EN_tip_stock
			AND cod_uso = EN_cod_uso
			AND cod_producto = EN_cod_producto;
		ELSE
			SELECT count(1)
			INTO LN_encontrado
			FROM np_cargo_ocacional_td
			WHERE cod_articulo = EN_cod_articulo
			AND tip_stock = EN_tip_stock
			AND cod_uso = EN_cod_uso
			AND cod_producto = EN_cod_producto
			AND cod_servicio = EN_cod_servicio;
		END IF;

		 IF UPPER(EV_accion) = 'CREAR' THEN
		 	IF LN_encontrado = 0 THEN
			   BEGIN
				 	INSERT INTO np_cargo_ocacional_td
					 		(cod_articulo,tip_stock,cod_uso,cod_producto,cod_servicio,fec_umod,nom_usuaora)
					VALUES (EN_cod_articulo,EN_tip_stock,EN_cod_uso,EN_cod_producto,EN_cod_servicio,SYSDATE,USER);
			   EXCEPTION
			   		WHEN OTHERS THEN
			   		LV_error := 'No se pudo insertar el cargo ocacional';
			   		RAISE ERROR_CONTROLADO;
			   END;
			ELSE
				LV_error := 'El cargo ocacional ya existe para el articulo';
				RAISE ERROR_CONTROLADO;
			END IF;

		 ELSIF UPPER(EV_accion) = 'ELIMINAR' THEN
		 	IF LN_encontrado > 0 THEN
			   BEGIN
					DELETE np_cargo_ocacional_td
					WHERE cod_articulo = EN_cod_articulo
					AND tip_stock = EN_tip_stock
					AND cod_uso = EN_cod_uso
					AND cod_producto = EN_cod_producto
					AND cod_servicio = EN_cod_servicio;
			   EXCEPTION
			   		WHEN OTHERS THEN
			   		LV_error := 'No se pudo eliminar el cargo ocacional';
			   		RAISE ERROR_CONTROLADO;
			   END;
			ELSE
				LV_error := 'El cargo ocacional no existe para el articulo';
				RAISE ERROR_CONTROLADO;
			END IF;

		 ELSIF UPPER(EV_accion) = 'ELIMTODO' THEN
		 	IF LN_encontrado > 0 THEN
			   BEGIN
					DELETE np_cargo_ocacional_td
					WHERE cod_articulo = EN_cod_articulo
					AND tip_stock = EN_tip_stock
					AND cod_uso = EN_cod_uso
					AND cod_producto = EN_cod_producto;
			   EXCEPTION
			   		WHEN OTHERS THEN
			   		LV_error := 'No se pudo eliminar el cargo ocacional';
			   		RAISE ERROR_CONTROLADO;
			   END;
			END IF;
		 ELSE
		 	 LV_error := 'Parametro de Accion no valido';
		 	 RAISE ERROR_CONTROLADO;
		 END IF;

	EXCEPTION
		    WHEN ERROR_CONTROLADO THEN
				SV_Error := LV_error;
            WHEN OTHERS THEN
				SV_Error := SQLCODE || '-' || SQLERRM;
	END;

----------------------------------------------------------------------------------------------------------------------

	PROCEDURE NP_CARGO_OCACIONALES_PR(
			EN_cod_articulo             IN npt_detalle_pedido.cod_articulo%TYPE,
			EN_tip_stock                IN npt_detalle_pedido.tip_stock%TYPE,
			EN_cod_uso                  IN npt_detalle_pedido.cod_uso%TYPE,
			EN_cod_producto             IN ga_servicios.cod_producto%TYPE,
			SC_cargos					OUT NOCOPY  refCursor,
			SV_Error		  OUT NOCOPY VARCHAR2
			)
		/*
		<Documentaci¾n TipoDoc = "PROCEDURE">
		<Elemento Nombre = "NP_CARGO_OCACIONALES_PR" Lenguaje="PL/SQL" Fecha="11-08-2005" Versi¾n="1.1.0" Dise±ador="Freddy Zabala" Programador="Claudio Astudillo" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripci¾n>Cargos ocacionales del articulo</Descripci¾n>
		<Parßmetros>
		<Entrada>
			<param nom="EN_cod_articulo" Tipo="NUMBER">Codigo Articulo</param>
			<param nom="EN_tip_stock" Tipo="NUMBER">Tipo de Stock</param>
			<param nom="EN_cod_uso" Tipo="NUMBER">Codigo Uso</param>
			<param nom="EN_cod_producto" Tipo="NUMBER">Codigo Producto</param>
		</Entrada>
		<Salida>
			<param nom="SC_cargos" Tipo="CURSOR>Cargos ocacionales del articulo</param>
			<param nom="SV_Error" Tipo="VARCHAR2">Error de salida</param>
		</Salida>
		</Parßmetros>
		</Elemento>
		</Documentaci¾n>
		*/
	AS
	  ERROR_CONTROLADO EXCEPTION;
	  LV_plan_serv ga_tarifas.cod_planserv%TYPE;
	  LN_cod_tipserv ga_actuaserv.cod_tipserv%TYPE;
	  LV_cod_actabo ga_actuaserv.cod_actabo%TYPE;
	  LV_error VARCHAR2(100);
	BEGIN
		BEGIN
			SELECT valor_parametro
			INTO LV_plan_serv
			FROM npt_parametro
			where alias_parametro like 'PLAN_SERV';
	   EXCEPTION
	   		WHEN OTHERS THEN
	   		LV_error := 'No se encontro parametro de plan de servicio';
	   		RAISE ERROR_CONTROLADO;
	   END;

		BEGIN
			SELECT valor_parametro
			INTO LN_cod_tipserv
			FROM npt_parametro
			where alias_parametro like 'TIPO_SERV';
	   EXCEPTION
	   		WHEN OTHERS THEN
	   		LV_error := 'No se encontro parametro de tipo de servicio';
	   		RAISE ERROR_CONTROLADO;
	   END;

		BEGIN
			SELECT valor_parametro
			INTO LV_cod_actabo
			FROM npt_parametro
			where alias_parametro like 'COD_ACTABO';
	   EXCEPTION
	   		WHEN OTHERS THEN
	   		LV_error := 'No se encontro parametro codigo actuacion abonado';
	   		RAISE ERROR_CONTROLADO;
	   END;

		BEGIN
			OPEN SC_cargos FOR
				SELECT a.cod_servicio, c.des_servicio, b.imp_tarifa
				FROM ga_actuaserv a, ga_tarifas b, ga_servicios c, np_cargo_ocacional_td d
				WHERE a.cod_producto = EN_cod_producto
				AND a.cod_actabo = LV_cod_actabo
				AND a.cod_tipserv = LN_cod_tipserv
				AND b.cod_producto = a.cod_producto
				AND b.cod_actabo = a.cod_actabo
				AND b.cod_tipserv = a.cod_tipserv
				AND b.cod_servicio = a.cod_servicio
				AND b.cod_planserv = LV_plan_serv
				AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)
				AND c.cod_producto = a.cod_producto
				AND c.cod_servicio = a.cod_servicio
				AND d.cod_articulo = EN_cod_articulo
				AND d.cod_uso = EN_cod_uso
				AND d.tip_stock = EN_tip_stock
				AND c.cod_servicio = d.cod_servicio
				AND c.cod_producto = d.cod_producto;
	   EXCEPTION
	   		WHEN OTHERS THEN
	   		LV_error := 'No se pudieron recuperar los datos';
	   		RAISE ERROR_CONTROLADO;
	   END;

	EXCEPTION
		    WHEN ERROR_CONTROLADO THEN
				SV_Error := LV_error;
            WHEN OTHERS THEN
				SV_Error := SQLCODE || '-' || SQLERRM;
	END;

----------------------------------------------------------------------------------------------------------------------

	PROCEDURE NP_DESCRIPCION_CARGO_PR(SC_cargos	OUT NOCOPY  refCursor,
			  SV_Error		  OUT NOCOPY VARCHAR2)
		/*
		<Documentaci¾n TipoDoc = "PROCEDURE">
		<Elemento Nombre = "NP_DESCRIPCION_CARGO_PR" Lenguaje="PL/SQL" Fecha="11-08-2005" Versi¾n="1.1.0" Dise±ador="Freddy Zabala" Programador="Claudio Astudillo" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripci¾n>Descripcion de los cargos ocacionales</Descripci¾n>
		<Parßmetros>
		<Entrada>
		</Entrada>
		<Salida>
			<param nom="SC_cargos" Tipo="CURSOR>Cargos ocacionales del articulo</param>
			<param nom="SV_Error" Tipo="VARCHAR2">Error de salida</param>
		</Salida>
		</Parßmetros>
		</Elemento>
		</Documentaci¾n>
		*/
	AS
	  ERROR_CONTROLADO EXCEPTION;
	  LV_plan_serv ga_tarifas.cod_planserv%TYPE;
	  LN_cod_tipserv ga_actuaserv.cod_tipserv%TYPE;
	  LV_cod_actabo ga_actuaserv.cod_actabo%TYPE;
	  LV_error VARCHAR2(100);
	BEGIN
		BEGIN
			SELECT valor_parametro
			INTO LV_plan_serv
			FROM npt_parametro
			where alias_parametro like 'PLAN_SERV';
	   EXCEPTION
	   		WHEN OTHERS THEN
	   		LV_error := 'No se encontro parametro de plan de servicio';
	   		RAISE ERROR_CONTROLADO;
	   END;

		BEGIN
			SELECT valor_parametro
			INTO LN_cod_tipserv
			FROM npt_parametro
			where alias_parametro like 'TIPO_SERV';
	   EXCEPTION
	   		WHEN OTHERS THEN
	   		LV_error := 'No se encontro parametro de tipo de servicio';
	   		RAISE ERROR_CONTROLADO;
	   END;

		BEGIN
			SELECT valor_parametro
			INTO LV_cod_actabo
			FROM npt_parametro
			where alias_parametro like 'COD_ACTABO';
	   EXCEPTION
	   		WHEN OTHERS THEN
	   		LV_error := 'No se encontro parametro codigo actuacion abonado';
	   		RAISE ERROR_CONTROLADO;
	   END;

	   BEGIN
			OPEN SC_cargos FOR
				SELECT a.cod_servicio, c.des_servicio, b.imp_tarifa
				FROM ga_actuaserv a, ga_tarifas b, ga_servicios c
				WHERE a.cod_producto = 1
				AND a.cod_actabo = LV_cod_actabo
				AND a.cod_tipserv = LN_cod_tipserv
				AND b.cod_producto = a.cod_producto
				AND b.cod_actabo = a.cod_actabo
				AND b.cod_tipserv = a.cod_tipserv
				AND b.cod_servicio = a.cod_servicio
				AND b.cod_planserv = LV_plan_serv
				AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)
				AND c.cod_producto = a.cod_producto
				AND c.cod_servicio = a.cod_servicio;
	   EXCEPTION
	   		WHEN OTHERS THEN
	   		LV_error := 'No se pudieron recuperar los datos';
	   		RAISE ERROR_CONTROLADO;
	   END;

	EXCEPTION
		    WHEN ERROR_CONTROLADO THEN
				SV_Error := LV_error;
            WHEN OTHERS THEN
				SV_Error := SQLCODE || '-' || SQLERRM;
	END;

----------------------------------------------------------------------------------------------------------------------

	FUNCTION NP_VALOR_CARGO_FN(
			EN_cod_producto             IN ga_servicios.cod_producto%TYPE,
			EV_cod_servicio				IN ga_servicios.cod_servicio%TYPE
			) RETURN NUMBER
		/*
		<Documentaci¾n TipoDoc = "FUNCTION">
		<Elemento Nombre = "NP_CARGO_OCACIONALES_PR" Lenguaje="PL/SQL" Fecha="11-08-2005" Versi¾n="1.1.0" Dise±ador="Freddy Zabala" Programador="Claudio Astudillo" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripci¾n>Cargos ocacionales del articulo</Descripci¾n>
		<Parßmetros>
		<Entrada>
			<param nom="EN_cod_producto" Tipo="NUMBER">Codigo Producto</param>
			<param nom="EV_cod_servicio" Tipo="VARCHAR2">Codigo Servicio</param>
		</Entrada>
		<Salida>
			<param nom="NP_VALOR_CARGO_FN" Tipo="NUMBER>Cargos ocacionales del articulo</param>
		</Salida>
		</Parßmetros>
		</Elemento>
		</Documentaci¾n>
		*/
	AS
	  LV_plan_serv ga_tarifas.cod_planserv%TYPE;
	  LN_cod_tipserv ga_actuaserv.cod_tipserv%TYPE;
	  LV_cod_actabo ga_actuaserv.cod_actabo%TYPE;
	  LV_imp_tarifa ga_tarifas.imp_tarifa%TYPE;
	BEGIN
		SELECT valor_parametro
		INTO LV_plan_serv
		FROM npt_parametro
		where alias_parametro like 'PLAN_SERV';

		SELECT valor_parametro
		INTO LN_cod_tipserv
		FROM npt_parametro
		where alias_parametro like 'TIPO_SERV';

		SELECT valor_parametro
		INTO LV_cod_actabo
		FROM npt_parametro
		where alias_parametro like 'COD_ACTABO';

		SELECT b.imp_tarifa
		INTO LV_imp_tarifa
		FROM ga_actuaserv a, ga_tarifas b, ga_servicios c
		WHERE a.cod_producto = EN_cod_producto
		AND a.cod_actabo = LV_cod_actabo
		AND a.cod_tipserv = LN_cod_tipserv
		AND a.cod_servicio = EV_cod_servicio
		AND b.cod_producto = a.cod_producto
		AND b.cod_actabo = a.cod_actabo
		AND b.cod_tipserv = a.cod_tipserv
		AND b.cod_servicio = a.cod_servicio
		AND b.cod_planserv = LV_plan_serv
		AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)
		AND c.cod_producto = a.cod_producto
		AND c.cod_servicio = a.cod_servicio;

		RETURN LV_imp_tarifa;
	END;

END NP_PRECIO_PRODUCTO_PG;
/
SHOW ERRORS
