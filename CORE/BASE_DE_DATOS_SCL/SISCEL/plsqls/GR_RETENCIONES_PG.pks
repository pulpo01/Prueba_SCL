CREATE OR REPLACE PACKAGE GR_RETENCIONES_PG
AS

   type ref_cursor IS REF CURSOR;
   type COL1 is table of VARCHAR2(20) INDEX BY BINARY_INTEGER;
   type COL2 is table of NUMBER INDEX BY BINARY_INTEGER;



	PROCEDURE GR_CRITERIOPER_PR          ( v_CodModulo       IN  VARCHAR2,
   							               v_CodCriterio     IN  NUMBER,
   							               v_Vigencia        IN  VARCHAR2,
   							               v_Usuario         IN  VARCHAR2,
   							               Error		     OUT VARCHAR2,
   							               Evento            OUT VARCHAR2,
   							               DesError          OUT VARCHAR2  );


    PROCEDURE GR_TIPOABONADO_PR          ( v_NumAbonado      IN  NUMBER,
							 			   v_Usuario         IN  VARCHAR2,
							 			   v_NumContacto     IN  NUMBER,
							 			   nTipoAbonado      IN  NUMBER,
							 			   sRetorno          OUT VARCHAR2,
							 			   ERRORSEV          OUT VARCHAR2,
							 			   NEVENTO           OUT NUMBER,
							 			   ERRORDES          OUT VARCHAR2
							 			 );


	PROCEDURE GR_TOTCONTACTOSRET_PR      ( v_FecDesde        IN  VARCHAR2,
	   	  		  				    	   v_FecHasta        IN  VARCHAR2,
								    	   v_Usuario         IN  NUMBER,
								    	   v_Formato	     IN  VARCHAR2,
								    	   Tot_Contactos     OUT NUMBER,
								    	   Tot_PostPago      OUT NUMBER,
								    	   Tot_Prepago       OUT NUMBER);



PROCEDURE GR_GestionComisionistasRet_PR(TipComis IN Number,
		  							    v_FecDesde IN VARCHAR2,
										v_FecHasta IN VARCHAR2,
										v_Formato IN VARCHAR2,
										FecContacto out GR_TIPOS_PG.col1,
										Contactos out GR_TIPOS_PG.col2,
										RetenidosCon out GR_TIPOS_PG.col2,
										RetenidosPrep out GR_TIPOS_PG.col2,
										Fugados out GR_TIPOS_PG.col2
										);


END gr_retenciones_pg;
/
SHOW ERRORS
