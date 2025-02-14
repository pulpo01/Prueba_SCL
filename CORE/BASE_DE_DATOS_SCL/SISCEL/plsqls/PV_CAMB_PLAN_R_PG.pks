CREATE OR REPLACE PACKAGE PV_CAMB_PLAN_R_PG IS
 PROCEDURE PV_TRASPASO_PR (
							    ncodCliOrig     IN NUMBER,
								nCodCliDest     IN NUMBER,
								ncod_Cuentad    IN NUMBER,
								nNumAbonado     IN NUMBER,
								scod_SubCuentad IN VARCHAR2,
								scod_plantarif  IN VARCHAR2,
								ncod_producto   IN NUMBER,
								susuarora       IN VARCHAR2,
								scod_actabo     IN VARCHAR2,
								ncod_Cuentao    IN NUMBER,
								scodtipcontrato IN VARCHAR2,
								snumcontrato	IN VARCHAR2,
								snum_anexo      IN VARCHAR2,
								scod_usuario    IN VARCHAR2,
								scod_usuariod   IN VARCHAR2,
								stiptraspaso    IN VARCHAR2,
								snum_celular    IN VARCHAR2,
								scod_empresad   IN NUMBER,
								scod_empresa    IN NUMBER,
								scod_subcuenta  IN VARCHAR2,
								serror	       out VARCHAR2,
								scod_per       out VARCHAR2,
							    sdes_per       out VARCHAR2,
							 	scod_ora       out VARCHAR2,
							    sdes_trace     out VARCHAR2,
								nCodPlanCo     out VARCHAR2
							 	 );

   PROCEDURE PV_DUPARRIENDO_PR(
                                nNumAboAnt      IN  NUMBER,
								COD_CLIENTENEW  IN  NUMBER,
								serror			out VARCHAR2,
								scod_per        out VARCHAR2,
    							sdes_per        out VARCHAR2,
 								scod_ora        out VARCHAR2,
    							sdes_trace      out VARCHAR2
                            	);

   PROCEDURE PV_DUPCONTABO_PR(
                            	nCodCuenta      IN  INTEGER,
								nCodProducto    IN  INTEGER,
								sCodTipcontrato IN  VARCHAR2,
								sNumContrato    IN  VARCHAR2,
								sNumAnexo		IN  VARCHAR2,
								nCuenta         IN  INTEGER,
								serror			out VARCHAR2,
								scod_per        out VARCHAR2,
							    sdes_per        out VARCHAR2,
							 	scod_ora        out VARCHAR2,
							    sdes_trace      out VARCHAR2
                            	);

   PROCEDURE PV_UPROAMING_PR(
                            	nNumAbonado     IN  INTEGER,
								nNumTerminal    IN  INTEGER,
								nCodCliOrig     IN  INTEGER,
								nCodCliDest     IN  INTEGER,
								serror			out VARCHAR2,
								scod_per        out VARCHAR2,
							    sdes_per        out VARCHAR2,
							 	scod_ora        out VARCHAR2,
							    sdes_trace      out VARCHAR2
                            	);

   PROCEDURE PV_TRASDISTCLIP2_PR (
							    nCodCliOrig     IN NUMBER,
								nCodCliDest     IN NUMBER,
								ncod_Cuentad    IN NUMBER,
							    ncod_CuentaO    IN NUMBER,
							    nCod_Usuario    IN NUMBER,
								nCod_Usuarioo	IN NUMBER,
								nNumAbonado     IN NUMBER,
								ncod_producto   IN NUMBER,
							    nNumTerminal    IN NUMBER,
								iTipTraspaso    IN VARCHAR2,
							    nCodEmpresaDest IN NUMBER,
								nCodEmpresaOrig IN NUMBER,
								scod_SubCuentad IN VARCHAR2,
								scod_SubCuentaO IN VARCHAR2,
								snom_usuarora   IN VARCHAR2,
								scod_actabo     IN VARCHAR2,
								serror	       out VARCHAR2,
								scod_per       out VARCHAR2,
							    sdes_per       out VARCHAR2,
							 	scod_ora       out VARCHAR2,
							    sdes_trace     out VARCHAR2,
								nCodPlanCo     OUT VARCHAR2
							 	 );
	 PROCEDURE PV_TRASPABO_PR (
							    nCodCliOrig     IN NUMBER,
								nCodCliDest     IN NUMBER,
								ncod_Cuentad    IN NUMBER,
							    -- scod_SubCuentad IN NUMBER, -- COL 68278|22-07-2008|SAQL
							    scod_SubCuentad IN VARCHAR2, -- COL 68278|22-07-2008|SAQL
								ncod_CuentaO    IN NUMBER,
							    -- scod_SubCuentaO IN NUMBER, -- COL 68278|22-07-2008|SAQL
							    scod_SubCuentaO IN VARCHAR2, -- COL 68278|22-07-2008|SAQL
								nCod_Usuario    IN NUMBER,
								nCod_Usuarioo	IN NUMBER,
								nNumAbonadonue  IN NUMBER,
								ncod_producto   IN NUMBER,
							    nNumTerminal    IN NUMBER,
							    snom_usuarora   IN VARCHAR2,
								iIndTipTraspaso IN NUMBER,
								scod_actabo     IN VARCHAR2,
								serror			out VARCHAR2,
								scod_per        out VARCHAR2,
							    sdes_per        out VARCHAR2,
							 	scod_ora        out VARCHAR2,
							    sdes_trace      out VARCHAR2
							 	 );


   PROCEDURE PV_UPNUMABOCLI_PR (
							    nCodCliOrig     IN NUMBER,
								nCodCliDest     IN NUMBER,
								iTipTraspaso    IN VARCHAR2,
								nCodEmpresaDest IN NUMBER,
								nCodEmpresaOrig IN NUMBER,
								serror			out VARCHAR2,
								scod_per        out VARCHAR2,
							    sdes_per        out VARCHAR2,
							 	scod_ora        out VARCHAR2,
							    sdes_trace      out VARCHAR2
							 	 );

	PROCEDURE PV_REASIGNACLI_PR (
							    nCodCliOrig     IN NUMBER,
								nCodCliDest     IN NUMBER,
								nNumAbonadonue  IN NUMBER,
								ncod_producto   IN NUMBER,
								snom_usuarora   IN VARCHAR2,
								scod_actabo     IN VARCHAR2,
							 	serror		   out VARCHAR2,
								scod_per       out VARCHAR2,
							    sdes_per       out VARCHAR2,
							 	scod_ora       out VARCHAR2,
							    sdes_trace     out VARCHAR2
							 	 );

END PV_CAMB_PLAN_R_PG;
/
SHOW ERRORS
