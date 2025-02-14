CREATE OR REPLACE package body Ge_IngresoPrepago_Pg
AS
---------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION  Ge_InsertarDireccion_FN (sProvincia IN ge_direcciones.cod_provincia%TYPE,
    								   sRegion IN ge_direcciones.cod_region%TYPE,
    								   sCiudad IN ge_direcciones.cod_ciudad%TYPE,
    								   sComuna IN ge_direcciones.cod_comuna%TYPE,
    								   sNomCalle IN ge_direcciones.nom_calle%TYPE,
    								   sNumCalle IN ge_direcciones.num_calle%TYPE,
    								   sNumPiso IN ge_direcciones.num_piso%TYPE,
    								   sCasilla IN ge_direcciones.num_casilla%TYPE,
    								   sComentario IN ge_direcciones.obs_direccion%TYPE,
    								   sDirec1 IN ge_direcciones.des_direc1%TYPE,
    								   sDirec2 IN ge_direcciones.des_direc2%TYPE,
    								   sZip IN ge_direcciones.zip%TYPE)
    RETURN ge_direcciones.cod_direccion%TYPE
    AS
    vCodDireccion ge_direcciones.cod_direccion%TYPE;
    v_comando_sql  VARCHAR2(2000);
    MENS_ERROR VARCHAR2(100);
    ERROR_PARAM EXCEPTION;
    BEGIN
    	-- Validacion de Parametros Obligatorios. --
    	IF sProvincia IS NULL THEN
    		MENS_ERROR := ' Provincia';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sRegion IS NULL THEN
    		MENS_ERROR := ' Region';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sCiudad IS NULL THEN
    		MENS_ERROR := ' Ciudad';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sComuna IS NULL THEN
    		MENS_ERROR := ' Comuna';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sNomCalle IS NULL THEN
    		MENS_ERROR := ' Nombre de Calle';
    		RAISE ERROR_PARAM;
    	END IF;

	    SELECT ge_seq_direcciones.NEXTVAL INTO vCodDireccion FROM dual;

		v_comando_sql := 'INSERT INTO ge_direcciones (cod_direccion, cod_provincia, cod_region, cod_ciudad, ';
		v_comando_sql := v_comando_sql || 'cod_comuna, nom_calle, num_calle, num_piso, num_casilla, obs_direccion, des_direc1, ';
		v_comando_sql := v_comando_sql || 'des_direc2, zip) VALUES(' || vCodDireccion || ', ''' || sProvincia || ''', ''' || sRegion || ''', ''';
		v_comando_sql := v_comando_sql || sCiudad || ''', ''' || sComuna || ''', ''' || sNomCalle || ''', ';

		IF sNumCalle IS NULL   THEN v_comando_sql := v_comando_sql || 'NULL, '; ELSE v_comando_sql := v_comando_sql || '''' || sNumCalle || ''', ';   END IF;
		IF sNumPiso IS NULL    THEN v_comando_sql := v_comando_sql || 'NULL, '; ELSE v_comando_sql := v_comando_sql || '''' || sNumPiso || ''', ';    END IF;
		IF sCasilla IS NULL    THEN v_comando_sql := v_comando_sql || 'NULL, '; ELSE v_comando_sql := v_comando_sql || '''' || sCasilla || ''', ';    END IF;
		IF sComentario IS NULL THEN v_comando_sql := v_comando_sql || 'NULL, '; ELSE v_comando_sql := v_comando_sql || '''' || sComentario || ''', '; END IF;
		IF sDirec1 IS NULL     THEN v_comando_sql := v_comando_sql || 'NULL, '; ELSE v_comando_sql := v_comando_sql || '''' || sDirec1 || ''', ';     END IF;
		IF sDirec2 IS NULL     THEN v_comando_sql := v_comando_sql || 'NULL, '; ELSE v_comando_sql := v_comando_sql || '''' || sDirec2 || ''', ';     END IF;
		IF sZIP IS NULL        THEN v_comando_sql := v_comando_sql || 'NULL)';  ELSE v_comando_sql := v_comando_sql || '''' || sZIP || ''')';         END IF;

		EXECUTE IMMEDIATE v_comando_sql;

	    RETURN vCodDireccion;
	EXCEPTION
	  	WHEN ERROR_PARAM THEN
	  	 	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Insertar la Direccion del Cliente, falta parametro obligatorio: "' || MENS_ERROR || '".(' || SQLERRM || ')');
	  	WHEN OTHERS THEN
	     	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Insertar la Direccion del Cliente. (' || SQLERRM || ')');
		 	RETURN -1;
    END Ge_InsertarDireccion_FN;
--------------------------------------------------------------------------------------------------------------------------------------------------
	FUNCTION  Ge_InsertarCuenta_FN (sNombre IN ga_cuentas.nom_responsable%TYPE,
    						  	    sApellido1 IN ga_cuentas.nom_responsable%TYPE,
    								sApellido2 IN ga_cuentas.nom_responsable%TYPE,
    								sCodTipident IN ga_cuentas.cod_tipident%TYPE,
    								sNumIdent IN ga_cuentas.num_ident%TYPE,
    								sCodDireccion IN ga_cuentas.cod_direccion%TYPE,
    								sFono1 IN ga_cuentas.tel_contacto%TYPE)
    RETURN ga_cuentas.cod_cuenta%TYPE
    AS
    vCodCuenta ga_cuentas.cod_cuenta%type;
    v_comando_sql  VARCHAR2(2000);
    vTemp VARCHAR2(2000);
    vDesCuenta VARCHAR2(40);
    MENS_ERROR VARCHAR2(100);
    ERROR_PARAM EXCEPTION;
    BEGIN
        -- Validacion de Parametros Obligatorios. --
    	IF sNombre IS NULL THEN
    		MENS_ERROR := ' Nombre';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sCodTipident IS NULL THEN
    		MENS_ERROR := ' Tipo de Identidicacion';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sNumIdent IS NULL THEN
    		MENS_ERROR := ' Numero de Identificacion';
    		RAISE ERROR_PARAM;
    	END IF;

    	vTemp := sNombre || ' ' || sApellido1 || ' ' || sApellido2;
    	vDesCuenta := substr(vTemp, 1, 40);
	    SELECT ga_seq_cuentas.NEXTVAL INTO vCodCuenta FROM dual;

		v_comando_sql := 'INSERT INTO ga_cuentas (cod_cuenta,des_cuenta,tip_cuenta,nom_responsable,cod_tipident,';
		v_comando_sql := v_comando_sql || ' num_ident,cod_direccion,fec_alta,ind_estado,tel_contacto,ind_sector, cod_clascta,';
		v_comando_sql := v_comando_sql || ' cod_catribut, cod_categoria, cod_sector, ind_multuso, ind_cliepotencial)';
		v_comando_sql := v_comando_sql || ' VALUES(' || vCodCuenta || ', ''' || vDesCuenta || ''', ''P'', ''' || vDesCuenta || ''', ''';
		v_comando_sql := v_comando_sql || sCodTipident || ''', ''' || sNumIdent || ''', ' || sCodDireccion || ', SYSDATE, ''S'', ';
		IF sFono1 IS NULL THEN
			v_comando_sql := v_comando_sql || 'NULL, ';
		ELSE
			v_comando_sql := v_comando_sql || '''' || sFono1 || ''', ';
		END IF;
		v_comando_sql := v_comando_sql || 'NULL, NULL, ''B'', 0, NULL, '' '', '' '')';

		EXECUTE IMMEDIATE v_comando_sql;

	    RETURN vCodCuenta;
	EXCEPTION
		WHEN ERROR_PARAM THEN
	  	 	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Insertar la Cuenta del Cliente, falta parametro obligatorio: "' || MENS_ERROR || '".(' || SQLERRM || ')');
	  	 	RETURN -1;
	  	WHEN OTHERS THEN
	     	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Insertar la Cuenta del Cliente. (' || SQLERRM || ')');
		 	RETURN -1;
    END Ge_InsertarCuenta_FN;
--------------------------------------------------------------------------------------------------------------------------------------------------
	FUNCTION  Ge_InsertarCliente_FN (sNombre IN ge_clientes.nom_cliente%TYPE,
    						  	    sApellido1 IN ge_clientes.nom_apeclien1%TYPE,
    								sApellido2 IN ge_clientes.nom_apeclien2%TYPE,
    								sCodTipident IN  ge_clientes.cod_tipident%TYPE,
    								sNumIdent IN ge_clientes.num_ident%TYPE,
    								sCodOperadora IN  ge_clientes.cod_operadora%TYPE,
    								sCodCuenta IN ge_clientes.cod_cuenta%TYPE,
    								sUsr IN ge_clientes.nom_usuarora%TYPE,
    								sFono1 IN ge_clientes.tef_cliente1%TYPE,
    								sFono2 IN ge_clientes.tef_cliente2%TYPE,
    								sActividad IN ge_clientes.cod_actividad%TYPE,
    								sEstadoCivil IN ge_clientes.ind_estcivil%TYPE,
    								sFechaNacimiento IN VARCHAR2,
    								sSexo IN ge_clientes.ind_sexo%TYPE,
    								sNumGrupoFam IN ge_clientes.num_int_grup_fam%TYPE,
    								sFormatoFecha IN VARCHAR2)
    RETURN ge_clientes.cod_cliente%TYPE
    AS
    vCodCliente ge_clientes.cod_cliente%TYPE;
    vCodABC ge_clientes.cod_abc%TYPE;
    vCod123 ge_clientes.cod_123%TYPE;
    vCodCalcli ge_clientes.cod_calclien%TYPE;
    vCodPais ge_clientes.cod_pais%TYPE;
    vCodAmiCicl ge_clientes.cod_ciclo%TYPE;
    v_comando_sql  VARCHAR2(2000);
    MENS_ERROR VARCHAR2(100);
    ERROR_PARAM EXCEPTION;
    BEGIN
    	-- Validacion de Parametros Obligatorios. --
    	IF sNombre IS NULL THEN
    		MENS_ERROR := ' Nombre';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sUsr IS NULL THEN
    		MENS_ERROR := ' Nombre Usuario';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sCodTipident IS NULL THEN
    		MENS_ERROR := ' Tipo de Identidicacion';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sNumIdent IS NULL THEN
    		MENS_ERROR := ' Numero de Identificacion';
    		RAISE ERROR_PARAM;
    	END IF;

    	SELECT val_parametro INTO vCodABC FROM ged_parametros
    	WHERE nom_parametro = 'COD_ABC' AND cod_modulo = 'GA' AND cod_producto = 1;

	    SELECT val_parametro INTO vCod123 FROM ged_parametros
	    WHERE nom_parametro = 'COD_123' AND cod_modulo = 'GA' AND cod_producto = 1;

	    SELECT val_parametro INTO vCodCalcli FROM ged_parametros
	    WHERE nom_parametro = 'COD_CALCLIEN' AND cod_modulo = 'GA' AND cod_producto = 1;

	    SELECT val_parametro INTO vCodPais FROM ged_parametros
	    WHERE nom_parametro = 'COD_PAIS' AND cod_modulo = 'GA' AND cod_producto = 1;

	    SELECT val_parametro INTO vCodAmiCicl FROM ged_parametros
	    WHERE nom_parametro = 'COD_AMI_CICLO' AND cod_modulo = 'GA' AND cod_producto = 1;

	    SELECT ge_seq_clientes.NEXTVAL INTO vCodCliente FROM dual;

	    v_comando_sql := 'INSERT INTO ge_clientes (cod_cliente, nom_cliente, cod_tipident, num_ident, cod_calclien, ';
	    v_comando_sql := v_comando_sql || 'ind_situacion, fec_alta, ind_factur, ind_traspaso, ind_agente, fec_ultmod, nom_usuarora, ';
	    v_comando_sql := v_comando_sql || 'ind_alta, cod_cuenta, ind_acepvent, cod_abc, cod_123, cod_actividad, cod_pais, ';
	    v_comando_sql := v_comando_sql || 'tef_cliente1, num_abocel, tef_cliente2, nom_apeclien1, nom_apeclien2, cod_ciclo, ';
	    v_comando_sql := v_comando_sql || 'cod_categoria, ind_estcivil, fec_nacimien, ind_sexo, num_int_grup_fam,cod_operadora) ';
	    v_comando_sql := v_comando_sql || 'VALUES(' || vCodCliente || ', ''' || sNombre || ''', ''' || sCodTipident || ''', ''' || sNumIdent || ''', ''';
	    v_comando_sql := v_comando_sql || vCodCalcli || ''', ''C'', SYSDATE, 0, ''S'', ''S'', SYSDATE, ''' || sUsr || ''', ''T'', ' || sCodCuenta || ', 1, ''' || vCodABC || ''', ' || vCod123 || ', ';

	    IF sActividad IS NULL THEN  v_comando_sql := v_comando_sql || 'NULL, '; ELSE  v_comando_sql := v_comando_sql || sActividad || ', '; END IF;
	    v_comando_sql := v_comando_sql || '''' || vCodPais || ''', ';
	    IF  sFono1 IS NULL THEN v_comando_sql := v_comando_sql || 'NULL, '; ELSE v_comando_sql := v_comando_sql || '''' || sFono1 || ''', '; END IF;
	    v_comando_sql := v_comando_sql || '''1'', ';
	    IF sFono2 IS NULL THEN v_comando_sql := v_comando_sql || 'NULL, '; ELSE v_comando_sql := v_comando_sql || '''' || sFono2 || ''', '; END IF;
	    IF sApellido1 IS NULL THEN v_comando_sql := v_comando_sql || 'NULL, '; ELSE v_comando_sql := v_comando_sql || '''' || sApellido1 || ''', '; END IF;
	    IF sApellido2 IS NULL THEN v_comando_sql := v_comando_sql || 'NULL, '; ELSE v_comando_sql := v_comando_sql || '''' || sApellido2 || ''', '; END IF;
	    v_comando_sql := v_comando_sql || vCodAmiCicl || ', 0, ';
	    IF sEstadoCivil IS NULL THEN v_comando_sql := v_comando_sql || 'NULL, '; ELSE  v_comando_sql := v_comando_sql || '''' || substr(sEstadoCivil, 1, 1) || ''', '; END IF;
	    IF sFechaNacimiento IS NULL THEN v_comando_sql := v_comando_sql || 'NULL, '; ELSE v_comando_sql := v_comando_sql || 'TO_DATE(''' || sFechaNacimiento || ''', ''' || sFormatoFecha || '''), '; END IF;
	    IF sSexo IS NULL THEN v_comando_sql := v_comando_sql || 'NULL, '; ELSE v_comando_sql := v_comando_sql || '''' || sSexo || ''', '; END IF;
	    IF sNumGrupoFam IS NULL THEN v_comando_sql := v_comando_sql || 'NULL, '; ELSE v_comando_sql := v_comando_sql || sNumGrupoFam || ', '; END IF;
	    v_comando_sql := v_comando_sql || '''' || sCodOperadora || ''')';

	    EXECUTE IMMEDIATE v_comando_sql;

	    RETURN vCodCliente;
    EXCEPTION
    	WHEN ERROR_PARAM THEN
	  	 	RAISE_APPLICATION_ERROR (-20002, 'No se pudo insertar el Cliente, en la tabla Ge_Clientes, falta parametro obligatorio: "' || MENS_ERROR || '".(' || SQLERRM || ')');
	  	 	RETURN -1;
	  	WHEN OTHERS THEN
	     	RAISE_APPLICATION_ERROR (-20002,'No se pudo insertar el Cliente, en la tabla Ge_Clientes. (' || SQLERRM || ')');
		 	RETURN -1;
    END Ge_InsertarCliente_FN;
------------------------------------------------------------------------------------------
	PROCEDURE  Ge_InsertarPlanComercial_PR (sCodCliente IN ga_cliente_pcom.cod_cliente%TYPE,
		                                    sUsr IN ga_cliente_pcom.nom_usuarora%TYPE)
	AS
	vPlanComercial ga_cliente_pcom.cod_plancom%TYPE;
	MENS_ERROR VARCHAR2(100);
    ERROR_PARAM EXCEPTION;
    BEGIN
    	-- Validacion de Parametros Obligatorios. --
    	IF sUsr IS NULL THEN
    		MENS_ERROR := ' Nombre Usuario';
    		RAISE ERROR_PARAM;
    	END IF;

		SELECT val_parametro INTO vPlanComercial FROM ged_parametros
		WHERE nom_parametro = 'PLAN_COMERCIAL' AND cod_modulo = 'GA' AND cod_producto = 1;

		INSERT INTO ga_cliente_pcom (cod_cliente, cod_plancom, fec_desde, nom_usuarora, fec_hasta)
		VALUES(sCodCliente, vPlanComercial, SYSDATE, sUsr, NULL);

	EXCEPTION
		WHEN ERROR_PARAM THEN
	  	 	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Insertar el Plan Comercial del Cliente, falta parametro obligatorio: "' || MENS_ERROR || '".(' || SQLERRM || ')');
	  	WHEN OTHERS THEN
	     	RAISE_APPLICATION_ERROR (-20002,'No se pudo Insertar el Plan Comercial del Cliente. (' || SQLERRM || ')');
    END Ge_InsertarPlanComercial_PR;
------------------------------------------------------------------------------------------
	PROCEDURE  Ge_InsertarDireccionCliente_PR (sCodCliente IN ga_direccli.cod_cliente%TYPE,
		                                    sCodDireccion IN ga_direccli.cod_direccion%TYPE)
	AS
	i INTEGER;
	iTipDirec INTEGER;
	MENS_ERROR VARCHAR2(100);
    ERROR_PARAM EXCEPTION;
	BEGIN
    	-- Validacion de Parametros Obligatorios. --
    	IF sCodCliente IS NULL THEN
    		MENS_ERROR := ' Codigo Cliente';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sCodDireccion IS NULL THEN
    		MENS_ERROR := ' Codigo Direccion';
    		RAISE ERROR_PARAM;
    	END IF;

	    iTipDirec := 1;
		FOR i IN 1..3 LOOP
		    INSERT INTO Ga_Direccli (cod_cliente, cod_tipdireccion, cod_direccion)
		    VALUES(sCodCliente, iTipDirec, sCodDireccion);
		    iTipDirec := iTipDirec + 1;
		END LOOP;
	EXCEPTION
		WHEN ERROR_PARAM THEN
	  	 	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Insertar el Tipo de Direccion del Cliente, falta parametro obligatorio: "' || MENS_ERROR || '".(' || SQLERRM || ')');
	  	WHEN OTHERS THEN
	     	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Insertar el Tipo de Direccion del Cliente. (' || SQLERRM || ')');
    END Ge_InsertarDireccionCliente_PR;
------------------------------------------------------------------------------------------
	PROCEDURE  Ge_InsertarResponsableLegal_PR (sCodCliente IN ga_respclientes.cod_cliente%TYPE,
											   sCodTipident IN  ga_respclientes.cod_tipident%TYPE,
    										   sNumIdent IN ga_respclientes.num_ident%TYPE,
    										   sNombre IN ga_respclientes.nom_responsable%TYPE,
    						  	    		   sApellido1 IN ga_respclientes.nom_responsable%TYPE,
    										   sApellido2 IN ga_respclientes.nom_responsable%TYPE)
	AS
	vTemp VARCHAR2(2000);
    vNombre VARCHAR2(40);
    MENS_ERROR VARCHAR2(100);
    ERROR_PARAM EXCEPTION;
    BEGIN
    	-- Validacion de Parametros Obligatorios. --
    	IF sCodCliente IS NULL THEN
    		MENS_ERROR := ' Codigo Cliente';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sNombre IS NULL THEN
    		MENS_ERROR := ' Nombre';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sCodTipident IS NULL THEN
    		MENS_ERROR := ' Tipo de Identidicacion';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sNumIdent IS NULL THEN
    		MENS_ERROR := ' Numero de Identificacion';
    		RAISE ERROR_PARAM;
    	END IF;

    	vTemp := sNombre || ' ' || sApellido1 || ' ' || sApellido2;
    	vNombre := substr(vTemp, 1, 40);

    	INSERT INTO ga_respclientes (cod_cliente, num_orden, cod_tipident, num_ident, nom_responsable)
    	VALUES(sCodCliente, 1, sCodTipident, sNumIdent, vNombre);

	EXCEPTION
		WHEN ERROR_PARAM THEN
	  	 	RAISE_APPLICATION_ERROR (-20002, 'No se pudo insertar el Responsable Legal del Cliente, falta parametro obligatorio: "' || MENS_ERROR || '".(' || SQLERRM || ')');
	  	WHEN OTHERS THEN
	     	RAISE_APPLICATION_ERROR (-20002, 'No se pudo insertar el Responsable Legal del Cliente. (' || SQLERRM || ')');
    END Ge_InsertarResponsableLegal_PR;
------------------------------------------------------------------------------------------
	PROCEDURE  Ge_InsertarCategImpositiva_PR (sCodCliente IN ge_catimpclientes.cod_cliente%TYPE,
											  sFormatoFecha IN VARCHAR2)
	AS
	MENS_ERROR VARCHAR2(100);
    ERROR_PARAM EXCEPTION;
    BEGIN
    	-- Validacion de Parametros Obligatorios. --
    	IF sCodCliente IS NULL THEN
    		MENS_ERROR := ' Codigo Cliente';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sFormatoFecha IS NULL THEN
    		MENS_ERROR := ' Formato de Fecha';
    		RAISE ERROR_PARAM;
    	END IF;

		INSERT INTO Ge_Catimpclientes (cod_cliente, fec_desde, fec_hasta, cod_catimpos)
		VALUES(sCodCliente, SYSDATE, TO_DATE('01-01-3000', sFormatoFecha), 1);
	EXCEPTION
		WHEN ERROR_PARAM THEN
	  	 	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Insertar la Categoria Impositiva del Cliente, falta parametro obligatorio: "' || MENS_ERROR || '".(' || SQLERRM || ')');
	  	WHEN OTHERS THEN
	     	RAISE_APPLICATION_ERROR (-20002,'No se pudo Insertar la Categoria Impositiva del Cliente. (' || SQLERRM || ')');
    END Ge_InsertarCategImpositiva_PR;
------------------------------------------------------------------------------------------
	PROCEDURE  Ge_InsertarCategTributaria_PR (sCodCliente IN ga_catributclie .cod_cliente%TYPE,
											  sFormatoFecha IN VARCHAR2)
	AS
	MENS_ERROR VARCHAR2(100);
    ERROR_PARAM EXCEPTION;
    BEGIN
    	-- Validacion de Parametros Obligatorios. --
    	IF sCodCliente IS NULL THEN
    		MENS_ERROR := ' Codigo Cliente';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sFormatoFecha IS NULL THEN
    		MENS_ERROR := ' Formato de Fecha';
    		RAISE ERROR_PARAM;
    	END IF;
	   	INSERT INTO ga_catributclie (cod_cliente, fec_desde, fec_hasta, cod_catribut)
	   	VALUES(sCodCliente, SYSDATE, TO_DATE('01-01-3000', sFormatoFecha), 'B');
	EXCEPTION
		WHEN ERROR_PARAM THEN
	  	 	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Insertar la Categoria Tributaria del Cliente, falta parametro obligatorio: "' || MENS_ERROR || '".(' || SQLERRM || ')');
	  	WHEN OTHERS THEN
	     	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Insertar la Categoria Tributaria del Cliente. (' || SQLERRM || ')');
    END Ge_InsertarCategTributaria_PR;
------------------------------------------------------------------------------------------
	FUNCTION  Ge_ProcesarUsuarioPrepago_FN (sNombre IN ga_usuamist.nom_usuario%TYPE,
    						  	    		sApellido1 IN ga_usuamist.nom_apellido1%TYPE,
    										sApellido2 IN ga_usuamist.nom_apellido2%TYPE,
    										sCodTipident IN  ga_usuamist.cod_tipident%TYPE,
    										sNumIdent IN ga_usuamist.num_ident%TYPE,
    										sNumAbonado IN ga_usuamist.num_abonado%TYPE,
    										sIndEstado IN ga_usuamist.ind_estado%TYPE)
    RETURN ga_usuamist.cod_usuario%TYPE
    AS
    vCodUsuario ga_usuamist.cod_usuario%TYPE;
    v_comando_sql  VARCHAR2(2000);
    iUsuario INTEGER;
    MENS_ERROR VARCHAR2(100);
    ERROR_PARAM EXCEPTION;
    BEGIN
    	-- Validacion de Parametros Obligatorios. --
    	IF sNombre IS NULL THEN
    		MENS_ERROR := ' Nombre';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sCodTipident IS NULL THEN
    		MENS_ERROR := ' Tipo de Identidicacion';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sNumIdent IS NULL THEN
    		MENS_ERROR := ' Numero de Identificacion';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sNumAbonado IS NULL THEN
    		MENS_ERROR := ' Numero de Abonado';
    		RAISE ERROR_PARAM;
    	END IF;

        iUsuario := 1;
    	BEGIN
	   		SELECT a.cod_usuario INTO vCodUsuario FROM ga_usuamist a
	   		WHERE a.num_abonado = sNumAbonado;
	   	EXCEPTION
	   		WHEN NO_DATA_FOUND THEN
	   			iUsuario := 0;
	  		WHEN OTHERS THEN
	     		RAISE_APPLICATION_ERROR (-20002,SQLERRM);
    	END;

	   	IF  iUsuario = 1 THEN
	   		v_comando_sql := 'UPDATE ga_usuamist SET nom_usuario = ''' || sNombre || ''', ';
	   	    IF sApellido1 IS NULL THEN
	   	        v_comando_sql := v_comando_sql || 'nom_apellido1 = '' '', ';
	   	    ELSE
	   	    	v_comando_sql := v_comando_sql || 'nom_apellido1 = ''' || substr(sApellido1, 1, 20) || ''', ';
	   	    END IF;
	   	    v_comando_sql := v_comando_sql || 'fec_alta = SYSDATE, cod_tipident = ''' || sCodTipident || ''', ';
	   	    v_comando_sql := v_comando_sql || 'num_ident = ''' || sNumIdent || ''', ind_estado = ''' || sIndEstado || ''', ';
	   	    IF sApellido2 IS NULL THEN
	   	        v_comando_sql := v_comando_sql || 'nom_apellido2 = '' '', ';
	   	    ELSE
	   	    	v_comando_sql := v_comando_sql || 'nom_apellido2 = ''' || substr(sApellido2, 1, 20) || ''', ';
	   	    END IF;
	   	    v_comando_sql := v_comando_sql || 'fec_nacimien = NULL, cod_estcivil = NULL, ind_sexo = NULL, ';
	   	    v_comando_sql := v_comando_sql || 'ind_tipotrab = NULL, nom_empresa = NULL, cod_actemp = NULL, ';
	   	    v_comando_sql := v_comando_sql || 'cod_ocupacion = NULL, num_percargo = NULL, imp_bruto = NULL, ';
	   	    v_comando_sql := v_comando_sql || 'ind_procoper = NULL, cod_operador = NULL, nom_conyuge = NULL, ';
	   	    v_comando_sql := v_comando_sql || 'cod_pinusuar = NULL ';
	   	    v_comando_sql := v_comando_sql || 'WHERE num_abonado = ' || sNumAbonado || ' AND cod_usuario = ' || vCodUsuario;
	   	ELSE
	   		SELECT ga_seq_usuarios.NEXTVAL INTO vCodUsuario FROM dual;

	   	    v_comando_sql := 'INSERT INTO ga_usuamist ( cod_usuario,num_abonado,nom_usuario, nom_apellido1, ';
	   	    v_comando_sql := v_comando_sql || 'fec_alta, cod_tipident, num_ident, ind_estado, nom_apellido2, fec_nacimien, ';
	   	    v_comando_sql := v_comando_sql || 'cod_estcivil,ind_sexo, ind_tipotrab, nom_empresa, cod_actemp, cod_ocupacion, ';
	   	    v_comando_sql := v_comando_sql || 'num_percargo, imp_bruto, ind_procoper, cod_operador, nom_conyuge, cod_pinusuar ) ';
	   	    v_comando_sql := v_comando_sql || 'VALUES(' || vCodUsuario || ', ' || sNumAbonado || ', ''' || sNombre || ''', ';
	   	    IF sApellido1 IS NULL THEN
	   	        v_comando_sql := v_comando_sql || ''' '', ';
	   	    ELSE
	   	        v_comando_sql := v_comando_sql || '''' || substr(sApellido1, 1, 20) || ''', ';
	   	    END IF;
	   	    v_comando_sql := v_comando_sql || 'SYSDATE, ''' || sCodTipident || ''', ''' || sNumIdent || ''', ''C'', ';
	   	    IF sApellido2 IS NULL THEN
	   	        v_comando_sql := v_comando_sql || ''' '', ';
	   	    ELSE
	   	        v_comando_sql := v_comando_sql || '''' || substr(sApellido2, 1, 20) || ''', ';
	   	    END IF;
	   	    v_comando_sql := v_comando_sql || 'NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ';
	   	    v_comando_sql := v_comando_sql || 'NULL, NULL, NULL, NULL)';
	   	END IF;

	   	EXECUTE IMMEDIATE v_comando_sql;
	   	RETURN vCodUsuario;
	EXCEPTION
		WHEN ERROR_PARAM THEN
	  	 	RAISE_APPLICATION_ERROR (-20002, 'No se pudo procesar al Usuario(ga_usuamist), falta parametro obligatorio: "' || MENS_ERROR || '".(' || SQLERRM || ')');
	  	WHEN OTHERS THEN
	     	RAISE_APPLICATION_ERROR (-20002,'No se pudo procesar al Usuario(ga_usuamist). (' || SQLERRM || ')');
    END Ge_ProcesarUsuarioPrepago_FN;
------------------------------------------------------------------------------------------
	PROCEDURE Ge_ActualizarAbonado_PR (sProceso IN VARCHAR2,
									   sCodCliente IN ga_aboamist.cod_cliente%TYPE,
			 						   sCodCuenta IN ga_aboamist.cod_cuenta%TYPE,
									   sCodUsuario IN ga_aboamist.cod_usuario%TYPE,
									   sNumCelular IN ga_aboamist.num_celular%TYPE,
									   sNumAbonado IN ga_aboamist.num_abonado%TYPE,
									   sIndTelefono IN ga_aboamist.ind_telefono%TYPE,
									   sFechaVenta IN VARCHAR2,
									   sFormatoFecha IN VARCHAR2,
									   sFormatoHora IN VARCHAR2)
	AS
	v_comando_sql  VARCHAR2(2000);
	MENS_ERROR VARCHAR2(100);
    ERROR_PARAM EXCEPTION;
    BEGIN
    	-- Validacion de Parametros Obligatorios. --
    	IF sProceso IS NULL THEN
    		MENS_ERROR := ' Proceso';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sNumCelular IS NULL THEN
    		MENS_ERROR := ' Numero Celular';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sNumAbonado IS NULL THEN
    		MENS_ERROR := ' Numero de Abonado';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF NOT sCodCliente IS NULL AND sCodCuenta IS NULL THEN
    		MENS_ERROR := ' Codigo Cuenta';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF NOT sCodCuenta IS NULL AND sCodCliente IS NULL THEN
    		MENS_ERROR := ' Codigo Cliente';
    		RAISE ERROR_PARAM;
    	END IF;

		v_comando_sql := 'UPDATE ga_aboamist SET ';
		IF sProceso = 0 THEN
		BEGIN
		    IF NOT sIndTelefono IS NULL THEN
			    v_comando_sql := v_comando_sql || 'ind_telefono = ' || sIndTelefono || ', ';
		    END IF;
		END;
		ELSIF sProceso = 1 THEN
		BEGIN
		    IF NOT sCodCliente IS NULL AND NOT sCodCuenta IS NULL THEN
		    BEGIN
			    IF sFechaVenta IS NULL THEN
				    v_comando_sql := v_comando_sql || 'fec_acepventa = SYSDATE, ';
			    ELSE
				    v_comando_sql := v_comando_sql || 'fec_acepventa = TO_DATE(''' || sFechaVenta || ''', ''' || sFormatoFecha || ' ' || sFormatoHora || '''), ';
			    END IF;
			    v_comando_sql := v_comando_sql || 'cod_cliente  = ' || sCodCliente || ', cod_cuenta = ' || sCodCuenta || ', ';
			END;
		    END IF;

		    IF  NOT sCodUsuario IS NULL THEN
			    v_comando_sql := v_comando_sql || 'cod_usuario = ' || sCodUsuario || ', ';
		    END IF;
		END;
		END IF;

		v_comando_sql := v_comando_sql || 'fec_ultmod = SYSDATE ';
		v_comando_sql := v_comando_sql || 'WHERE num_abonado = ' || sNumAbonado || ' AND num_celular = ' || sNumCelular;

		EXECUTE IMMEDIATE v_comando_sql;
	EXCEPTION
		WHEN ERROR_PARAM THEN
	  	 	RAISE_APPLICATION_ERROR (-20002, 'No se pudo actualizar el Abonado, falta parametro obligatorio: "' || MENS_ERROR || '".(' || SQLERRM || ')');
	  	WHEN OTHERS THEN
	     	RAISE_APPLICATION_ERROR (-20002, 'No se pudo actualizar el Abonado, (' || SQLERRM || ')');
    END Ge_ActualizarAbonado_PR;
------------------------------------------------------------------------------------------
	PROCEDURE  Ge_InsertarMovimiento_PR (sNumAbonado IN icc_movimiento.num_abonado%TYPE,
										 sNumCelular IN icc_movimiento.num_celular%TYPE,
	    								 sCarga IN icc_movimiento.carga%TYPE,
										 sCodTecnologia IN icc_movimiento.tip_tecnologia%TYPE,
										 sCodTecnologiaGsm IN icc_movimiento.tip_tecnologia%TYPE,
										 sCodActuacion IN icc_movimiento.cod_actuacion%TYPE,
										 sCodActabo IN icc_movimiento.cod_actabo%TYPE,
										 sCodCentral IN icc_movimiento.cod_central%TYPE,
										 sTipterminal IN icc_movimiento.tip_terminal%TYPE,
										 sNumSerieHex IN icc_movimiento.num_serie%TYPE,
										 sNumImsi IN icc_movimiento.imsi%TYPE,
										 sNumImei IN icc_movimiento.imei%TYPE,
										 sNumSerie IN icc_movimiento.icc%TYPE,
										 sSta IN icc_movimiento.sta%TYPE,
										 sUsr IN icc_movimiento.nom_usuarora%TYPE,
										 sFechaVenta IN VARCHAR2,
										 iDiasVigencia IN INTEGER,
										 sFormatoFecha IN VARCHAR2,
										 sFormatoHora IN VARCHAR2)
	AS
	v_comando_sql  VARCHAR2(2000);
	MENS_ERROR VARCHAR2(100);
    ERROR_PARAM EXCEPTION;
    BEGIN
    	-- Validacion de Parametros Obligatorios. --
    	IF sNumCelular IS NULL THEN
    		MENS_ERROR := ' Numero Celular';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sNumAbonado IS NULL THEN
    		MENS_ERROR := ' Numero de Abonado';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sCarga IS NULL THEN
    		MENS_ERROR := ' Carga';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sCodTecnologia IS NULL THEN
    		MENS_ERROR := ' Tecnologia';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sCodTecnologiaGsm IS NULL THEN
    		MENS_ERROR := ' Tecnologia GSM';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sCodActuacion IS NULL THEN
    		MENS_ERROR := ' Codigo Actuacion Central';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sCodActabo IS NULL THEN
    		MENS_ERROR := ' Codigo Actuacion Abonado';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sCodCentral IS NULL THEN
    		MENS_ERROR := ' Codigo Central';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sTipterminal IS NULL THEN
    		MENS_ERROR := ' Tipo Terminal';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sNumSerieHex IS NULL THEN
    		MENS_ERROR := ' Numero Serie Hex';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sNumImsi IS NULL THEN
    		MENS_ERROR := ' Numero Imsi';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sNumSerie IS NULL THEN
    		MENS_ERROR := ' Numero Serie';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sSta IS NULL THEN
    		MENS_ERROR := ' Codigo Sta';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sUsr IS NULL THEN
    		MENS_ERROR := ' Nombre Usuario';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF iDiasVigencia IS NULL THEN
    		MENS_ERROR := ' Dias de Vigencia';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sFormatoFecha IS NULL THEN
    		MENS_ERROR := ' Formato Fecha';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sFormatoHora IS NULL THEN
    		MENS_ERROR := ' Formato Hora';
    		RAISE ERROR_PARAM;
    	END IF;

		v_comando_sql := v_comando_sql || 'INSERT INTO icc_movimiento (num_movimiento, num_abonado, cod_estado, cod_actabo,';
		v_comando_sql := v_comando_sql || ' cod_modulo, num_intentos, cod_central_nue, des_respuesta, cod_actuacion, nom_usuarora,';
		v_comando_sql := v_comando_sql || ' fec_ingreso, tip_terminal, cod_central, fec_lectura, ind_bloqueo, fec_ejecucion,';
		v_comando_sql := v_comando_sql || ' tip_terminal_nue, num_movant, num_celular, num_movpos, num_serie, num_personal,';
		v_comando_sql := v_comando_sql || ' num_celular_nue, num_serie_nue, num_personal_nue, num_msnb, num_msnb_nue, cod_suspreha,';
		v_comando_sql := v_comando_sql || ' cod_servicios, num_min, num_min_nue, sta, cod_mensaje, param1_mens, param2_mens,';
		v_comando_sql := v_comando_sql || ' param3_mens, carga, fec_expira, tip_tecnologia ';
		IF sCodTecnologia = sCodTecnologiaGsm THEN
	    	v_comando_sql := v_comando_sql || ', imsi, imei, icc ';
		END IF;
		v_comando_sql := v_comando_sql || ')';
		v_comando_sql := v_comando_sql || ' VALUES(icc_seq_nummov.NEXTVAL, ' || sNumAbonado || ', 1, ''' || sCodActabo || ''', ''AC'', 0, NULL,';
		v_comando_sql := v_comando_sql || ' ''pendiente'', ' || sCodActuacion || ', ''' || sUsr || ''', SYSDATE, ''' || sTipterminal || ''', ';
		v_comando_sql := v_comando_sql || sCodCentral || ', NULL, 0, NULL, NULL, NULL, ' || sNumCelular || ', NULL, ''' || sNumSerieHex || ''', NULL,';
		v_comando_sql := v_comando_sql || ' NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''730'', NULL, ''' || sSta || ''', NULL, NULL, NULL, NULL';
		v_comando_sql := v_comando_sql || ', ' || sCarga || ', ';
		IF sFechaVenta IS NULL THEN
		    v_comando_sql := v_comando_sql || 'NULL';
		ELSE
		    v_comando_sql := v_comando_sql || 'TO_DATE(''' || sFechaVenta || ''', ''' || sFormatoFecha || ' ' || sFormatoHora || ''')  +  ' || iDiasVigencia;
		END IF;
		v_comando_sql := v_comando_sql || ', ''' || sCodTecnologia || ''', ';
		IF sCodTecnologia = sCodTecnologiaGsm THEN
	    	v_comando_sql := v_comando_sql || sNumImsi || ', ';
	    	IF sNumImei IS NULL THEN
	    		v_comando_sql := v_comando_sql || 'NULL';
	    	ELSE
	    		v_comando_sql := v_comando_sql || sNumImei;
	    	END IF;
	    	v_comando_sql := v_comando_sql || ', ' || sNumSerie;
		END IF;
		v_comando_sql := v_comando_sql || ')';

		EXECUTE IMMEDIATE v_comando_sql;

	EXCEPTION
		WHEN ERROR_PARAM THEN
	  	 	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Insertar el Movimiento, falta parametro obligatorio: "' || MENS_ERROR || '".(' || SQLERRM || ')');
	  	WHEN OTHERS THEN
	    	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Insertar el Movimiento. (' || SQLERRM || ')');
    END Ge_InsertarMovimiento_PR;
------------------------------------------------------------------------------------------
	PROCEDURE  Ge_ProcesarClientePrepago_PR (sNumAbonado IN icc_movimiento.num_abonado%TYPE,
										     sNumCelular IN icc_movimiento.num_celular%TYPE,
										     sNombre IN ge_clientes.nom_cliente%TYPE,
    						  	    		 sApellido1 IN ge_clientes.nom_apeclien1%TYPE,
    										 sApellido2 IN ge_clientes.nom_apeclien2%TYPE,
    										 sCodTipident IN  ge_clientes.cod_tipident%TYPE,
    										 sNumIdent IN ge_clientes.num_ident%TYPE,
    										 sCodOperadora IN  ge_clientes.cod_operadora%TYPE,
    										 sIndTelefono IN ga_aboamist.ind_telefono%TYPE,
    										 sUsr IN ge_clientes.nom_usuarora%TYPE,
    										 sFono1 IN ge_clientes.tef_cliente1%TYPE,
    										 sFono2 IN ge_clientes.tef_cliente2%TYPE,
    										 sActividad IN ge_clientes.cod_actividad%TYPE,
    										 sEstadoCivil IN ge_clientes.ind_estcivil%TYPE,
    										 sFechaNacimiento IN VARCHAR2,
    										 sSexo IN ge_clientes.ind_sexo%TYPE,
    										 sNumGrupoFam IN ge_clientes.num_int_grup_fam%TYPE,
    										 sProvincia IN ge_direcciones.cod_provincia%TYPE,
    								   		 sRegion IN ge_direcciones.cod_region%TYPE,
    								   		 sCiudad IN ge_direcciones.cod_ciudad%TYPE,
    								   		 sComuna IN ge_direcciones.cod_comuna%TYPE,
    								   		 sNomCalle IN ge_direcciones.nom_calle%TYPE,
    								   		 sNumCalle IN ge_direcciones.num_calle%TYPE,
    								   		 sNumPiso IN ge_direcciones.num_piso%TYPE,
    								   		 sCasilla IN ge_direcciones.num_casilla%TYPE,
    								   	 	 sComentario IN ge_direcciones.obs_direccion%TYPE,
    								   		 sDirec1 IN ge_direcciones.des_direc1%TYPE,
    								   		 sDirec2 IN ge_direcciones.des_direc2%TYPE,
    								   		 sZip IN ge_direcciones.zip%TYPE,
											 sIndEstado IN ga_usuamist.ind_estado%TYPE,
										 	 sFechaVenta IN VARCHAR2,
										 	 sFormatoFecha IN VARCHAR2,
										 	 sFormatoHora IN VARCHAR2)
	AS
	vCodDireccion ge_direcciones.cod_direccion%TYPE;
	vCodCuenta ga_cuentas.cod_cuenta%TYPE;
	vCodCliente ge_clientes.cod_cliente%TYPE;
	vCodUsuario ga_usuamist.cod_usuario%TYPE;
	BEGIN

		vCodDireccion := ge_insertardireccion_fn(sProvincia, sRegion, sCiudad, sComuna, sNomCalle, sNumCalle, sNumPiso, sCasilla, sComentario, sDirec1, sDirec2, sZip);
		vCodCuenta := ge_insertarcuenta_fn(sNombre, sApellido1, sApellido2, sCodTipident, sNumIdent, vCodDireccion, sFono1);
		vCodCliente := ge_insertarcliente_fn(sNombre, sApellido1, sApellido2, sCodTipident, sNumIdent, sCodOperadora, vCodCuenta, sUsr, sFono1, sFono2, sActividad, sEstadoCivil, sFechaNacimiento, sSexo, sNumGrupoFam, sFormatoFecha);
		ge_insertarplancomercial_pr(vCodCliente, sUsr);
		ge_insertardireccioncliente_pr(vCodCliente, vCodDireccion);
		ge_insertarresponsablelegal_pr(vCodCliente, sCodTipident, sNumIdent, sNombre, sApellido1, sApellido2);
		ge_insertarcategimpositiva_pr(vCodCliente, sFormatoFecha);
		ge_insertarcategtributaria_pr(vCodCliente, sFormatoFecha);
		vCodUsuario := ge_procesarusuarioprepago_fn(sNombre, sApellido1, sApellido2, sCodTipident, sNumIdent, sNumAbonado, sIndEstado);
		ge_actualizarabonado_pr(1, vCodCliente, vCodCuenta, vCodUsuario, sNumCelular, sNumAbonado, null, sFechaVenta, sFormatoFecha, sFormatoHora);

	END	Ge_ProcesarClientePrepago_PR;
------------------------------------------------------------------------------------------
	PROCEDURE  Ge_ProcesarMovimiento_PR (sNumCelular IN icc_movimiento.num_celular%TYPE,
										 sProceso IN VARCHAR2)
	AS
	vCodCentral icc_movimiento.cod_central%TYPE;
	vCodTecnologiaGSM icc_movimiento.tip_tecnologia%TYPE;
	vNumSerie icc_movimiento.num_serie%TYPE;
	vTipTerminal icc_movimiento.tip_terminal%TYPE;
	vNumSerieHex ga_aboamist.num_seriehex%TYPE;
	vNumAbonado icc_movimiento.num_abonado%TYPE;
	vNumImei icc_movimiento.imei%TYPE;
	vNumImsi icc_movimiento.imsi%TYPE;
	vCodTecnologia icc_movimiento.tip_tecnologia%TYPE;
	vCodActuacion icc_movimiento.cod_actuacion%TYPE;
	vCodActabo icc_movimiento.cod_actabo%TYPE;
	vSta icc_movimiento.sta%TYPE;
	vIndicadorTelefono ga_aboamist.ind_telefono%TYPE;
	vCarga ga_plantillas_kit.carga_inicial%TYPE;
	vDiasVigencia ga_plantillas_kit.dias_vigencia%TYPE;
	vFechaVenta VARCHAR2(20);
	vUsr ga_aboamist.nom_usuarora%TYPE;
	vCodOperadora ge_clientes.cod_operadora%TYPE;
	vEstadoPrepago ga_aboamist.ind_telefono%TYPE;
	vFormatoFecha VARCHAR2(20);
	vFormatoHora VARCHAR2(20);
	vFormato VARCHAR2(200);
	vCodCampo VARCHAR2(10);
	vCodModulo VARCHAR2(10);
	vCodProducto NUMBER(1);
	ERROR_IMSI EXCEPTION;
	ERROR_CODACTUACION EXCEPTION;
	ERROR_ACTABONADO EXCEPTION;
	ERROR_INSERTAMOV EXCEPTION;
	ERROR_INDTELEFONO EXCEPTION;
	ERROR_TECNOLOG EXCEPTION;
	ERROR_INFOEQUIPO EXCEPTION;
	ERROR_INFO EXCEPTION;
	ERROR_FORMAT EXCEPTION;
	ERROR_PARAM EXCEPTION;
	MENS_ERROR VARCHAR2(100);
	v_comando_sql  VARCHAR2(2000);
	vTemp VARCHAR2(2000);


    BEGIN
        -- DEFINICION DE CONSTANTES
        vCodCAmpo := 'IMSI';
        vCodModulo := 'GA';
        vCodProducto := 1;
        vNumImsi := NULL;

    	-- Validacion de Parametros Obligatorios. --
    	IF sProceso IS NULL THEN
    		MENS_ERROR := ' Accion Bloque/Desbloqueo';
    		RAISE ERROR_PARAM;
    	END IF;
    	IF sNumCelular IS NULL THEN
    		MENS_ERROR := ' Numero Celular';
    		RAISE ERROR_PARAM;
    	END IF;

    	IF UPPER(sProceso) = 'A' THEN
    	    vIndicadorTelefono := 7;
    	ELSIF UPPER(sProceso) = 'B' THEN
    		vIndicadorTelefono := 6;
    	END IF;

    	-- Rescatamos Informacion de Carga y Dias de Vigencia
    	BEGIN
    		SELECT DISTINCT d.carga_inicial, d.dias_vigencia
    		INTO vCarga, vDiasVigencia
			FROM ga_aboamist a, ga_equipaboser b, al_componente_kit c, ga_plantillas_kit d
			WHERE a.num_celular = sNumCelular
			AND a.num_abonado = b.num_abonado
			AND a.num_serie = b.num_serie
			AND b.num_serie = c.num_serie
			AND b.cod_articulo = c.cod_articulo
			AND c.cod_kit = d.cod_kit
			AND c.cod_articulo = d.cod_articulo
			AND d.fec_inicio <= a.fec_acepventa
			AND d.fec_termino >= a.fec_acepventa;
        EXCEPTION
        	WHEN NO_DATA_FOUND THEN
	  			vCarga := 0;
	  			vDiasVigencia := 0;
        	WHEN OTHERS THEN
	     		RAISE ERROR_INFO;
        END;

        -- Rescatamos Formato de Fecha
        BEGIN
        	SELECT val_parametro INTO vFormatoFecha
			FROM ged_parametros
			WHERE cod_modulo = 'GE'
			AND cod_producto = 1
			AND nom_parametro = 'FORMATO_SEL2';
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
	  			RAISE ERROR_FORMAT;
	  		WHEN OTHERS THEN
	     		RAISE ERROR_FORMAT;
        END;

        -- Rescatamos Formato de Hora
        BEGIN
        	SELECT val_parametro INTO vFormatoHora
			FROM ged_parametros
			WHERE cod_modulo = 'GE'
			AND cod_producto = 1
			AND nom_parametro = 'FORMATO_SEL7';
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
	  			RAISE ERROR_FORMAT;
	  		WHEN OTHERS THEN
	     		RAISE ERROR_FORMAT;
        END;

		vFormato := vFormato || vFormatoFecha || ' ' || vFormatoHora;

        -- Rescatamos Informacion del Abonado
        BEGIN
    		SELECT DISTINCT TO_CHAR(a.fec_acepventa, vFormato), a.nom_usuarora, a.ind_telefono, b.cod_operadora
    		INTO vFechaVenta, vUsr, vEstadoPrepago, vCodOperadora
			FROM ga_aboamist a, ge_clientes b
			WHERE a.num_celular = sNumCelular
			AND a.cod_cliente = b.cod_cliente;
        EXCEPTION
        	WHEN NO_DATA_FOUND THEN
	  			RAISE ERROR_INFO;
	  		WHEN OTHERS THEN
	     		RAISE ERROR_INFO;
        END;

		-- Rescatamos la Tecnoligia GSM
		BEGIN
			SELECT val_parametro INTO vCodTecnologiaGSM FROM ged_parametros
			WHERE nom_parametro = 'TECNOLOGIA_GSM' AND cod_modulo = vCodModulo AND cod_producto = vCodProducto;
		EXCEPTION
        	WHEN NO_DATA_FOUND THEN
	  			RAISE ERROR_TECNOLOG;
	  		WHEN OTHERS THEN
	     		RAISE ERROR_TECNOLOG;
        END;

		-- Rescatamos Informacion del Equipo: Serie, Central, Terminal, Abonado, etc...
		BEGIN
			SELECT a.num_serie, a.cod_central, a.tip_terminal, a.num_seriehex, a.num_abonado,
			a.num_imei, a.cod_tecnologia
			INTO vNumSerie,	vCodCentral, vTipTerminal, vNumSerieHex, vNumAbonado, vNumImei, vCodTecnologia
			FROM ga_aboamist a
			WHERE a.num_celular = sNumCelular AND a.cod_situacion <> 'BAA' AND a.cod_situacion <> 'BAP';
		EXCEPTION
        	WHEN NO_DATA_FOUND THEN
	  			RAISE ERROR_INFOEQUIPO;
	  		WHEN OTHERS THEN
	     		RAISE ERROR_INFOEQUIPO;
        END;

        -- Si la Tecnologia es igual a la TecnologiaGSM, rescatamos el numero IMSI
		IF vCodTecnologia = vCodTecnologiaGSM THEN
		    BEGIN
    			vNumImsi := FRECUPERSIMCARD_FN ( vNumSerie, TRIM(vCodCampo) );
    		EXCEPTION
    			WHEN OTHERS THEN
    				RAISE ERROR_IMSI;
    		END;
    		IF vNumImsi IS NULL THEN
		        RAISE ERROR_IMSI;
		    END IF;
		END IF;



		IF vCodOperadora = 'MPR' THEN
	       	IF vEstadoPrepago = 7 THEN
        		IF UPPER(sProceso) = 'B' THEN
        		BEGIN
	    			vCodActabo := 'VB';
        			vSta := 'S';
	    			vIndicadorTelefono := 8;
	    		END;
				END IF;
    		ELSE
    			IF vEstadoPrepago = 6 THEN
					IF UPPER(sProceso) = 'A' THEN
					BEGIN
					    vIndicadorTelefono := 8;
	    				IF vCarga <> 0 THEN
							vCodActabo := 'VD';
        					vSta := 'N';
                		ELSE
                      		vCodActabo := 'VA';
        					vSta := 'N';
	   					END IF;
	   				END;
            		END IF;
    			END IF;
    		END IF;

    		-- Rescatamos el Codigo de Actuacion en Centrales --
        	BEGIN
        		SELECT a.cod_actcen INTO vCodActuacion FROM ga_actabo a
        		WHERE a.cod_producto = vCodProducto
        		AND a.cod_modulo = vCodModulo
        		AND a.cod_actabo = vCodActabo
        		AND NVL(a.cod_tecnologia, vCodTecnologia) = vCodTecnologia;
        	EXCEPTION
        		WHEN NO_DATA_FOUND THEN
	  				RAISE ERROR_CODACTUACION;
	  			WHEN OTHERS THEN
	     			RAISE ERROR_CODACTUACION;
        	END;
		ELSE
    		IF UPPER(sProceso) = 'A' AND vEstadoPrepago = 7 AND vCarga <> 0 THEN
        		vIndicadorTelefono := 8;
    		END IF;

		    IF UPPER(sProceso) = 'A' THEN
		    BEGIN
        		vCodActabo := 'VA';
        		vSta := 'N';
        		IF vEstadoPrepago = 7 THEN
					vCodActabo := 'TR';
        		END IF;
        	END;
    		END	IF;

    		IF UPPER(sProceso) = 'B' THEN
    		BEGIN
        		vCodActabo := 'VB';
        		vSta := 'S';
        	END;
    		END IF;

    		-- Rescatamos el Codigo de Actuacion en Centrales --
        	BEGIN
        		SELECT a.cod_actcen INTO vCodActuacion FROM ga_actabo a
        		WHERE a.cod_producto = vCodProducto
        		AND a.cod_modulo = vCodModulo
        		AND a.cod_actabo = vCodActabo
        		AND NVL(a.cod_tecnologia, vCodTecnologia) = vCodTecnologia;
        	EXCEPTION
        		WHEN NO_DATA_FOUND THEN
	  				RAISE ERROR_CODACTUACION;
	  			WHEN OTHERS THEN
	     			RAISE ERROR_CODACTUACION;
        	END;
		END IF;

		-- Actualizamos el Abonado --
		BEGIN
			GE_ACTUALIZARABONADO_PR(0, null, null, null, sNumcelular, vNumAbonado, vIndicadorTelefono, null, null, null);
		EXCEPTION
        	WHEN OTHERS THEN
	    		RAISE ERROR_ACTABONADO;
        END;

        -- Insertamos el Movimiento en la Central
        BEGIN
			GE_INSERTARMOVIMIENTO_PR(vNumAbonado, sNumCelular, vCarga, vCodTecnologia, vCodTecnologiaGsm, vCodActuacion, vCodActabo,
									 vCodCentral, vTipterminal, vNumSerieHex, vNumImsi, vNumImei, vNumSerie, vSta, vUsr, vFechaVenta, vDiasVigencia , vFormatoFecha, vFormatoHora);
		EXCEPTION
        	WHEN OTHERS THEN
	    		RAISE ERROR_INSERTAMOV;
        END;
	EXCEPTION
	  WHEN ERROR_PARAM THEN
	   	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Procesar el Movimiento, falta parametro obligatorio: "' || MENS_ERROR || '".(' || SQLERRM || ')');
	  WHEN ERROR_ACTABONADO THEN
	  	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Actualizar al Abonado');
	  WHEN ERROR_INSERTAMOV THEN
	  	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Insertar el Movimiento');
	  WHEN ERROR_CODACTUACION THEN
	  	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Rescatar el Codigo de Actuacion en Central');
	  WHEN ERROR_IMSI THEN
	  	RAISE_APPLICATION_ERROR (-20002, 'No se pudo Rescatar el Numero Imsi');
	  WHEN ERROR_INDTELEFONO THEN
	  	RAISE_APPLICATION_ERROR (-20002, 'No se pudo obtener el Estado Actual del Telefono');
	  WHEN ERROR_TECNOLOG THEN
	  	RAISE_APPLICATION_ERROR (-20002, 'No se pudo obtener la Tecnologia GSM del Equipo');
	  WHEN ERROR_INFOEQUIPO THEN
	  	RAISE_APPLICATION_ERROR (-20002, 'No se pudo obtener la informacion del Equipo (Cod_Central, Num_Serie, etc...)');
	  WHEN ERROR_INFO THEN
	  	RAISE_APPLICATION_ERROR (-20002, 'No se pudo obtener la informacion de Celular (Carga, Estado, Operadora, etc...');
	  WHEN ERROR_FORMAT THEN
	  	RAISE_APPLICATION_ERROR (-20002, 'No se pudo obtener la informacion de los Formatos de Fecha y Hora');
	  WHEN OTHERS THEN
	    RAISE_APPLICATION_ERROR (-20002, 'No se pudo Procesar el Movimiento');
	END Ge_ProcesarMovimiento_PR;
------------------------------------------------------------------------------------------
END Ge_IngresoPrepago_Pg;
/
SHOW ERRORS
