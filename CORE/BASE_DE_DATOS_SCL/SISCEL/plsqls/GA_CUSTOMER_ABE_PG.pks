CREATE OR REPLACE PACKAGE GA_CUSTOMER_ABE_PG AS

---------------- 
-- PROCEDURES -- 
----------------

 PROCEDURE GA_OBTENERDATOSCLIENTE_PR   (EN_CODCLIENTE      IN  NUMBER,
                                        EV_FECHASISTEMA    IN  VARCHAR2,										
                                        SV_CODSUBCATEGORIA OUT NOCOPY VARCHAR2,
										SV_CODCATRIBUT     OUT NOCOPY VARCHAR2,
										SN_CODCATIMPOS     OUT NOCOPY NUMBER,
										SV_CODIDIOMA       OUT NOCOPY VARCHAR2,
 			                            SN_COD_RETORNO     OUT NOCOPY NUMBER, 
			                            SV_MENS_RETORNO    OUT NOCOPY VARCHAR2, 
			                            SN_NUM_EVENTO      OUT NOCOPY NUMBER); 
			   
 PROCEDURE GA_OBTSUBCATEGORIACLIENTE_PR (EN_CODCLIENTE      IN  NUMBER,
                                         SV_CODSUBCATEGORIA OUT NOCOPY VARCHAR2,
                                         SN_COD_RETORNO     OUT NOCOPY NUMBER, 
                                         SV_MENS_RETORNO    OUT NOCOPY VARCHAR2, 
                                         SN_NUM_EVENTO      OUT NOCOPY NUMBER);			   
			   
 PROCEDURE GA_OBTCATEGORIATRIBUTARIA_PR (EN_CODCLIENTE   IN  NUMBER,
                                         ED_FECHASISTEMA IN  DATE,
                                         SV_CODCATRIBUT  OUT NOCOPY VARCHAR2,
                                         SN_COD_RETORNO  OUT NOCOPY NUMBER, 
                                         SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
                                         SN_NUM_EVENTO   OUT NOCOPY NUMBER);
			   
 PROCEDURE GA_OBTCATEGORIAIMPOSITIVA_PR (EN_CODCLIENTE   IN  NUMBER,
                                         ED_FECHASISTEMA IN  DATE,
                                         SN_CODCATIMPOS  OUT NOCOPY NUMBER,
                                         SN_COD_RETORNO  OUT NOCOPY NUMBER, 
                                         SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
                                         SN_NUM_EVENTO   OUT NOCOPY NUMBER);
	 	   
 PROCEDURE GA_OBTENEROFICINA_PR (EV_NOMUSUARIO     IN  VARCHAR2,
                                 SV_CODOFICINA    OUT NOCOPY VARCHAR2,
								 SV_COD_REGION    OUT NOCOPY VARCHAR2,
								 SV_COD_PROVINCIA OUT NOCOPY VARCHAR2,
								 SV_COD_COMUNA    OUT NOCOPY VARCHAR2,								 
								 SN_CODVENDEDOR   OUT NOCOPY NUMBER,
                                 SN_COD_RETORNO   OUT NOCOPY NUMBER, 
                                 SV_MENS_RETORNO  OUT NOCOPY VARCHAR2, 
                                 SN_NUM_EVENTO    OUT NOCOPY NUMBER);
								 								
 PROCEDURE GA_OBTENERIDIOMACLIENTE_PR (EN_CODCLIENTE       IN  NUMBER,
                                       SV_CODIDIOMA        OUT NOCOPY VARCHAR2,
                                       SN_COD_RETORNO      OUT NOCOPY NUMBER, 
                                       SV_MENS_RETORNO     OUT NOCOPY VARCHAR2, 
                                       SN_NUM_EVENTO       OUT NOCOPY NUMBER);								
			   
PROCEDURE GA_OBTENERZONAIMPOSITIVA_PR (EV_CODOFICINA   IN  VARCHAR2,
                                       SN_CODZONAIMPO  OUT NOCOPY NUMBER,
                                       SN_COD_RETORNO  OUT NOCOPY NUMBER, 
                                       SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
                                       SN_NUM_EVENTO   OUT NOCOPY NUMBER);

END;
/
SHOW ERRORS