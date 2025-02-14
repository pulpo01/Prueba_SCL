CREATE OR REPLACE PACKAGE            EBZ_PAC_GA_DTOS_GENERALES
 AS
    TYPE tDes_cuenta is TABLE of ga_cuentas.DES_CUENTA%type
    INDEX BY BINARY_INTEGER;
        TYPE tNom_Responsable is TABLE of ga_cuentas.NOM_RESPONSABLE%type
    INDEX BY BINARY_INTEGER;
        TYPE tNum_ident is TABLE of ga_cuentas.NUM_IDENT%type
    INDEX BY BINARY_INTEGER;
        TYPE tDireccion is TABLE of varchar2(70)
    INDEX BY BINARY_INTEGER;
        TYPE tFec_Alta is TABLE of varchar2(11)
    INDEX BY BINARY_INTEGER;
        TYPE tCatTribut is TABLE of varchar2(10)
    INDEX BY BINARY_INTEGER;
        TYPE tCelular is TABLE of ga_abocel.NUM_CELULAR%type
    INDEX BY BINARY_INTEGER;
        TYPE tNumSerie is TABLE of ga_abocel.NUM_SERIE%type
    INDEX BY BINARY_INTEGER;
        TYPE tModeloEquipo is TABLE of al_articulos.DES_ARTICULO%type
    INDEX BY BINARY_INTEGER;
        TYPE tMarcaEquipo is TABLE of al_fabricantes.DES_FABRICANTE%type
    INDEX BY BINARY_INTEGER;
        TYPE tPlanTarifario is TABLE of ta_plantarif.DES_PLANTARIF%type
    INDEX BY BINARY_INTEGER;
        TYPE tCantidad is TABLE of number(6)
    INDEX BY BINARY_INTEGER;
	    TYPE tCodCliente is TABLE of ge_clientes.COD_CLIENTE%type
    INDEX BY BINARY_INTEGER;
        TYPE tTelefono is TABLE of ge_clientes.TEF_CLIENTE1%type
    INDEX BY BINARY_INTEGER;
        TYPE tCiclo is TABLE of ge_clientes.COD_CICLO%type
    INDEX BY BINARY_INTEGER;
        TYPE tEmail is TABLE of ge_clientes.NOM_EMAIL%type
    INDEX BY BINARY_INTEGER;
        TYPE t_respuesta          is table of number(1) INDEX BY BINARY_INTEGER;
		TYPE t_error          is table of varchar2(80)  INDEX BY BINARY_INTEGER;
		TYPE t_usuario 	  		  is table of number(6) INDEX BY BINARY_INTEGER;
		TYPE t_n_usuario		  is table of varchar2(30) INDEX BY BINARY_INTEGER;
		TYPE t_tipo_user		  is table of varchar2(1) INDEX BY BINARY_INTEGER;
		TYPE t_num_ident		  is table of varchar2(11) INDEX BY BINARY_INTEGER;

    PROCEDURE GA_DTOS_CUENTAS(codigo in varchar2, Des_Cuenta out tDes_cuenta,
                              Nom_responsable out tNom_Responsable, Num_ident out tNum_ident,
                              Direccion out tDireccion, Fec_alta out tFec_Alta,
                              Cod_cattribut out tCatTribut);
--    PROCEDURE GA_DTOS_CLIENTES(codigo in number, NombreCliente out tNom_Responsable,
--                               Num_ident out tNum_ident, CantAbonados out tCantidad,
--                               Cod_cliente out tCodCliente, Fec_alta out tFec_Alta,
--                               Telefono out tTelefono, ciclo out Tciclo,
--                              Cod_cattribut out tCatTribut, NombreEjecutivo out tNom_Responsable,
--                               CelularEjecutivo out tCelular, DireccionEjecutivo out tDireccion,
--                               EmailEjecutivo out tEmail);

	PROCEDURE GA_DTOS_CLIENTES(codigo in number, NombreCliente out tNom_Responsable,
                               Num_ident out tNum_ident, CantAbonados out tCantidad,
                               Cod_cliente out tCodCliente, Fec_alta out tFec_Alta,
                               Telefono out tTelefono, ciclo out Tciclo,
                               Cod_cattribut out tCatTribut, NombreEjecutivo out tNom_Responsable,
                               CelularEjecutivo out tCelular, DireccionEjecutivo out tDireccion,
                               EmailEjecutivo out tEmail,TelefonoCelularEje out ttelefono,
							   TelefonoFijoEje out ttelefono);
    PROCEDURE GA_DTOS_ABONADOS(codigo in varchar2, Num_ident out tNum_ident,
                               Direccion out tDireccion, Celular out tCelular,
                               NumSerie out tNumSerie, ModeloEquipo out tModeloEquipo,
                               MarcaEquipo out tMarcaEquipo, Fec_alta out tFec_Alta,
                               PlanTarif out tPlanTarifario);
    PROCEDURE GA_VERIF_CLI (identificacion in  varchar2,
                            tip_ide        in  varchar2,
                            valor          in  number,
                            estado         out t_respuesta
                           );
    PROCEDURE GA_CLI_OSITE  (identificacion 	 in varchar2,
						   	 t_identifica		 in varchar2,
							 usuario			 out t_usuario,
							 n_usuario		 out t_n_usuario,
							 tipo_user		 out t_tipo_user,
							 num_ident		 out t_num_ident,
							 error			 out t_error
							 );

END EBZ_PAC_GA_DTOS_GENERALES;
/
SHOW ERRORS
