CREATE OR REPLACE PACKAGE pv_baja_abonado_pg IS

CN_Version_Header VARCHAR2(10):='01.00.00';				 --COL-79523|06-03-2009|GEZ

--INI COL-79523|06-03-2009|GEZ
FUNCTION pv_version_body_fn RETURN VARCHAR2;

FUNCTION pv_version_header_fn RETURN VARCHAR2;

PROCEDURE pv_valida_baja_batch_pr( EN_NumOs                IN                            pv_iorserv.num_os%TYPE,
		  											    SV_Mensaje              OUT NOCOPY 		      VARCHAR2,
														SV_MensajeCorto      OUT NOCOPY 		   VARCHAR2,
														SV_Estado	             OUT NOCOPY 		   VARCHAR2,
														SV_Proc	                  OUT NOCOPY 			VARCHAR2,
														SN_CodMsg	           OUT NOCOPY 			 NUMBER,
														SN_Evento	             OUT NOCOPY 		   NUMBER,
														SV_Tabla	             OUT NOCOPY 		   VARCHAR2,
														SV_Act		               OUT NOCOPY 			 VARCHAR2,
														SV_Code	                 OUT NOCOPY 		   VARCHAR2,
														SV_Errm	                 OUT NOCOPY 		   VARCHAR2
														);
--FIN COL-79523|06-03-2009|GEZ

END pv_baja_abonado_pg;
/
SHOW ERRORS
