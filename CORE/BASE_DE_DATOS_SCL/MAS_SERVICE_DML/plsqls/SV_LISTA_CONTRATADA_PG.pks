CREATE OR REPLACE PACKAGE SV_LISTA_CONTRATADA_PG

IS

  TYPE refCursor IS REF CURSOR;
  CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
  CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'SE';
  CV_version              CONSTANT VARCHAR2 (2)  := '1';
  CN_LISTA_NULA constant number:=1;


  PROCEDURE SV_PRODUCTO_D_PR(EO_lista_productos IN  SV_PROD_CONTR_LST_QT,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);

  PROCEDURE SV_PRODUCTO_S_PR(EO_producto IN  SV_PROD_CONTRA_QT,
						  SO_PERFIL_LISTA_CUR  	OUT NOCOPY	refCursor,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);

PROCEDURE SV_PRODUCTO_S_FS_PR(EN_COD_PROD_CONTRATADO   IN NUMBER,
						      SO_PERFIL_LISTA_CUR  	OUT NOCOPY	refCursor,
						      SV_mens_retorno     	OUT NOCOPY  ge_errores_pg.msgerror);

 PROCEDURE SV_CONTRATA_I_PR(EO_LIST_CONTRAT    IN  SV_LISTA_CONTRA_TO_LST_QT,
						                    	  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						                          SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						                          SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);

PROCEDURE SV_CONTRATA_U_PR(EO_Lista_Cont 	  IN 	        SV_LISTA_CONTRA_TO_QT,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);

PROCEDURE SV_PRODUCTO_U_PR(EO_Lista_Cont 		  IN    SV_PROD_CONTR_LST_QT,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);

PROCEDURE SV_PRODUCTO_CANT_PR(EO_producto              IN   SV_PROD_CONTRA_QT,
										  	   			 CANT_PROD_CONT   OUT NUMBER,
														 SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						                                 SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						                                SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);

END SV_LISTA_CONTRATADA_PG;
/
SHOW ERRORS
