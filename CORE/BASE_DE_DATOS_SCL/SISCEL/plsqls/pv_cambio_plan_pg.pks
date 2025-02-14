CREATE OR REPLACE PACKAGE PV_CAMBIO_PLAN_PG IS

CN_Version_Header VARCHAR2(10):='01.00.00';				 --COL-77303|18-02-2009|GEZ

--INI COL-77303|18-02-2009|GEZ
FUNCTION pv_version_body_fn RETURN VARCHAR2;

FUNCTION pv_version_header_fn RETURN VARCHAR2;

PROCEDURE pv_reproceso_cpu_alciclo_pr( EN_NumOs	   		    IN                       pv_iorserv.num_os%TYPE,
		  							   					   EN_NumAbonado       IN                       ga_abocel.num_abonado%TYPE,
														   EN_CodCliente           IN                       ga_abocel.cod_cliente%TYPE,
														   EV_CodOs                 IN                       pv_iorserv.cod_os%TYPE,
														   EV_CodPlantarifDes    IN                       ga_abocel.cod_plantarif%TYPE,
														   EV_Usuario                IN                      pv_iorserv.usuario%TYPE,
                                                           SV_Estado	            OUT NOCOPY 	     VARCHAR2,
                                                           SV_Proc	                 OUT NOCOPY 	  VARCHAR2,
	                                                       SN_CodMsg	          OUT NOCOPY 	   NUMBER,
	                                                       SN_Evento	            OUT NOCOPY 	    NUMBER,
	                                                       SV_Tabla                 OUT NOCOPY 	    VARCHAR2,
	                                                       SV_Act		              OUT NOCOPY 	  VARCHAR2,
	                                                       SV_Code	                OUT NOCOPY 	    VARCHAR2,
	                                                       SV_Errm	                OUT NOCOPY 	    VARCHAR2);

PROCEDURE pv_reprocesa_ooss_cpu_pr;

PROCEDURE pv_parseo_cpu_pr(  EV_CadenaDatos           IN                      VARCHAR2,
                                                SN_ClienteOri               OUT NOCOPY 	    NUMBER,
												SN_ClienteDes              OUT NOCOPY 	   NUMBER,
												SN_NumAboOri             OUT NOCOPY 	 NUMBER,
												SN_CuentaDes              OUT NOCOPY 	  NUMBER,
												SV_CodPlantarifDes       OUT NOCOPY 	 VARCHAR2,
												SV_AplicaTras              OUT NOCOPY 	   VARCHAR2,
												SD_FechaProg              OUT NOCOPY 	  DATE,
												SV_Usuario                  OUT NOCOPY 	     VARCHAR2,
		  				   		  				SV_Estado	                OUT NOCOPY 	    VARCHAR2,
                                                SV_Proc	                     OUT NOCOPY 	  VARCHAR2,
	                                            SN_CodMsg	              OUT NOCOPY 	   NUMBER,
	                                            SN_Evento	                OUT NOCOPY 	    NUMBER,
	                                            SV_Tabla                    OUT NOCOPY 	    VARCHAR2,
	                                            SV_Act		                 OUT NOCOPY 	  VARCHAR2,
	                                            SV_Code	                    OUT NOCOPY 	    VARCHAR2,
	                                            SV_Errm	                    OUT NOCOPY 	    VARCHAR2 );

--FIN COL-77303|18-02-2009|GEZ

END  PV_CAMBIO_PLAN_PG;
/
SHOW ERRORS
