CREATE OR REPLACE package Ge_IngresoPrepago_Pg
AS
------------------------------------------------------------------------------------------
/* Funcion que Inserta una Direccion de un cliente
   Desarrollada por : Carlos Navarro H.
   Area : Tecnologia							   */
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
    RETURN ge_direcciones.cod_direccion%TYPE;
------------------------------------------------------------------------------------------
/* Funcion que Inserta una Cuenta de un cliente
   Desarrollada por : Carlos Navarro H.
   Area : Tecnologia							   */
    FUNCTION  Ge_InsertarCuenta_FN (sNombre IN ga_cuentas.nom_responsable%TYPE,
    						  	    sApellido1 IN ga_cuentas.nom_responsable%TYPE,
    								sApellido2 IN ga_cuentas.nom_responsable%TYPE,
    								sCodTipident IN ga_cuentas.cod_tipident%TYPE,
    								sNumIdent IN ga_cuentas.num_ident%TYPE,
    								sCodDireccion IN ga_cuentas.cod_direccion%TYPE,
    								sFono1 IN ga_cuentas.tel_contacto%TYPE)
    RETURN ga_cuentas.cod_cuenta%TYPE;
------------------------------------------------------------------------------------------
/* Funcion que Inserta un cliente, en la tabla Ge_Clientes
   Desarrollada por : Carlos Navarro H.
   Area : Tecnologia							   */
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
    RETURN ge_clientes.cod_cliente%TYPE;
------------------------------------------------------------------------------------------
/* Funcion que Inserta un Plan Comercial de un cliente
   Desarrollada por : Carlos Navarro H.
   Area : Tecnologia							   */
	PROCEDURE  Ge_InsertarPlanComercial_PR (sCodCliente IN ga_cliente_pcom.cod_cliente%TYPE,
		                                    sUsr IN ga_cliente_pcom.nom_usuarora%TYPE);
------------------------------------------------------------------------------------------
/* Funcion que Inserta Tipos de Direcciones de un cliente
   Desarrollada por : Carlos Navarro H.
   Area : Tecnologia							   */
	PROCEDURE  Ge_InsertarDireccionCliente_PR (sCodCliente IN ga_direccli.cod_cliente%TYPE,
		                                       sCodDireccion IN ga_direccli.cod_direccion%TYPE);
------------------------------------------------------------------------------------------
/* Funcion que Inserta un Responsable Legal de un cliente
   Desarrollada por : Carlos Navarro H.
   Area : Tecnologia							   */
	PROCEDURE  Ge_InsertarResponsableLegal_PR (sCodCliente IN ga_respclientes.cod_cliente%TYPE,
											   sCodTipident IN  ga_respclientes.cod_tipident%TYPE,
    										   sNumIdent IN ga_respclientes.num_ident%TYPE,
    										   sNombre IN ga_respclientes.nom_responsable%TYPE,
    						  	    		   sApellido1 IN ga_respclientes.nom_responsable%TYPE,
    										   sApellido2 IN ga_respclientes.nom_responsable%TYPE);
------------------------------------------------------------------------------------------
/* Funcion que Inserta una Categoria Impositiva de un cliente
   Desarrollada por : Carlos Navarro H.
   Area : Tecnologia							   */
	PROCEDURE  Ge_InsertarCategImpositiva_PR (sCodCliente IN ge_catimpclientes.cod_cliente%TYPE,
											  sFormatoFecha IN VARCHAR2);
------------------------------------------------------------------------------------------
/* Funcion que Inserta una Categoria Tributaria de un cliente
   Desarrollada por : Carlos Navarro H.
   Area : Tecnologia							   */
	PROCEDURE  Ge_InsertarCategTributaria_PR (sCodCliente IN ga_catributclie.cod_cliente%TYPE,
											  sFormatoFecha IN VARCHAR2);
------------------------------------------------------------------------------------------
/* Funcion que Procesa un Usuario, o sea, si este existe, actualiza los datos, y sino lo
   agrega, todo esto en la tabla ga_usuamist
   Desarrollada por : Carlos Navarro H.
   Area : Tecnologia							   */
	FUNCTION  Ge_ProcesarUsuarioPrepago_FN (sNombre IN ga_usuamist.nom_usuario%TYPE,
    						  	            sApellido1 IN ga_usuamist.nom_apellido1%TYPE,
    								        sApellido2 IN ga_usuamist.nom_apellido2%TYPE,
    										sCodTipident IN  ga_usuamist.cod_tipident%TYPE,
    										sNumIdent IN ga_usuamist.num_ident%TYPE,
    										sNumAbonado IN ga_usuamist.num_abonado%TYPE,
    										sIndEstado IN ga_usuamist.ind_estado%TYPE)
    RETURN ga_usuamist.cod_usuario%TYPE;
------------------------------------------------------------------------------------------
/* Funcion que Actualiza un Abonado
   Desarrollada por : Carlos Navarro H.
   Area : Tecnologia
   Ultima Modificacion : 08 Enero del 2004	   */
	PROCEDURE  Ge_ActualizarAbonado_PR (sProceso IN VARCHAR2,
	                                    sCodCliente IN ga_aboamist.cod_cliente%TYPE,
										sCodCuenta IN ga_aboamist.cod_cuenta%TYPE,
										sCodUsuario IN ga_aboamist.cod_usuario%TYPE,
										sNumCelular IN ga_aboamist.num_celular%TYPE,
										sNumAbonado IN ga_aboamist.num_abonado%TYPE,
										sIndTelefono IN ga_aboamist.ind_telefono%TYPE,
										sFechaVenta IN VARCHAR2,
										sFormatoFecha IN VARCHAR2,
										sFormatoHora IN VARCHAR2);
------------------------------------------------------------------------------------------
/* Funcion que Inserta un Movimiento.
   Desarrollada por : Carlos Navarro H.
   Area : Tecnologia
   Ultima Modificacion : 08 Enero del 2004	   */
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
										 sFormatoHora IN VARCHAR2);
------------------------------------------------------------------------------------------
/* Funcion que Inserta un Cliente de Prepago, este procedimiento agrupa todas las funciones
   y procedimiento que insertan todos los datos del clientes, en las diferentes tablas
   que impliquen al cliente.
   Desarrollada por : Carlos Navarro H.
   Area : Tecnologia							   */
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
										 	 sFormatoHora IN VARCHAR2);
------------------------------------------------------------------------------------------
/* Funcion que Inserta un Cliente de Prepago, este procedimiento agrupa todas las funciones
   y procedimiento que insertan todos los datos del clientes, en las diferentes tablas
   que impliquen al cliente.
   Desarrollada por : Carlos Navarro H.
   Area : Tecnologia
   Ultima Modificacion : 08 Enero del 2004	   */
    PROCEDURE  Ge_ProcesarMovimiento_PR (sNumCelular IN icc_movimiento.num_celular%TYPE,
										 sProceso IN VARCHAR2);
------------------------------------------------------------------------------------------

END Ge_IngresoPrepago_Pg;
/
SHOW ERRORS
