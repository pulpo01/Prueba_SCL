CREATE OR REPLACE PACKAGE PR_PRODUCTOS_CONTRATADOS_PG
IS

  TYPE refCursor IS REF CURSOR;
  CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
  CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'PF';
  CV_version              CONSTANT VARCHAR2 (2)  := '1';
  CN_LISTA_NULA 		  CONSTANT NUMBER        := 1;
  CV_ESTADO_OK 		  	  CONSTANT VARCHAR2 (3)  := 'OK';
  --**inicio JMO 16-11-2010 INC-155400
  CN_COD_PRODUCTO         CONSTANT NUMBER        := 1;
  CV_GE                   CONSTANT VARCHAR2 (2)  := 'GE';
  CV_APLICA_PLAN_ADIC_OO  CONSTANT VARCHAR2 (25) := 'APLICA_PLAN_ADIC_OO';
  --**fin JMO 16-11-2010 INC-155400


PROCEDURE PR_PRODUCTO_CONTR_FS_PR(EN_TIPO_COMPORTAMIENTO	  IN NUMBER,
		  						  EN_COD_CLIENTE_CONTRATANTE  IN NUMBER,
							  	  EN_NUM_ABONADO_CONTRATANTE  IN NUMBER,
						      	  SO_Lista_Productos  		  OUT NOCOPY	refCursor,
						      	  SV_mens_retorno     		  OUT NOCOPY    ge_errores_pg.msgerror);

PROCEDURE PR_PRODUCTO_CONTR_PR(EO_productos	        IN  		PR_PRODUCTOS_CONTS_TO_QT,
						       SO_Lista_Productos  OUT NOCOPY	refCursor,
						  	   SN_cod_retorno      OUT NOCOPY   ge_errores_pg.coderror,
						  	   SV_mens_retorno     OUT NOCOPY   ge_errores_pg.msgerror,
						  	   SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);

PROCEDURE PR_PRODUCTO_S_PR(EO_productos	  IN  			PR_PRODUCTOS_CONTS_TO_QT,
						  SO_Lista_Productos  OUT NOCOPY	refCursor,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);


PROCEDURE PR_DETALLE_S_PR(EO_lista_productos IN  			PR_PROD_CONTR_LST_QT,
		  				  SO_Lista_Productos  OUT NOCOPY	refCursor,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);

PROCEDURE PR_PAQUETE_S_PR(EO_productos	  IN  			PR_PRODUCTOS_CONTS_TO_QT,
						  SO_Lista_Productos  OUT NOCOPY	refCursor,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);


PROCEDURE PR_VENTA_S_PR(  EO_venta			  IN  			PR_VENTA_QT,
		  				  SO_Lista_Productos  OUT NOCOPY	refCursor,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);


PROCEDURE PR_PRODUCTO_D_PR(EO_lista_productos IN  			PR_PROD_CONTR_LST_QT,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);

PROCEDURE PR_PRODUCTO_U_PR(EO_producto 		IN  PR_PRODUCTO_DES_LST_QT,
					      SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);

PROCEDURE PR_CONTRATA_I_PR (
						  EO_productos	  IN  PR_PRODUCTOS_CONTS_TO_QT,
--						  SO_productos    OUT NOCOPY refCursor,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);

PROCEDURE PR_SECUENCIA_PRODUCTO_PR (EO_SECUENCIA			IN OUT NOCOPY	PR_SECUENCIA_QT,
								   SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						           SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						           SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);

PROCEDURE PR_ACTUALIZA_BONOS_PR( EN_PROD_CONTRATADO IN PR_PRODUCTOS_CONTRATADOS_TO.COD_PROD_CONTRATADO%type,
		  						 SN_cod_retorno     OUT NOCOPY  ge_errores_pg.coderror,
						         SV_mens_retorno    OUT NOCOPY  ge_errores_pg.msgerror,
						         SN_num_evento      OUT NOCOPY	ge_errores_pg.evento);
--
PROCEDURE PR_OBTIENE_CONTRATADOS_PR(EN_COD_PROD_OFERTADO IN pr_productos_contratados_to.cod_prod_ofertado%TYPE,
									EN_COD_CLIENTE 		 IN pr_productos_contratados_to.cod_prod_ofertado%TYPE,
									EN_NUM_ABONADO 		 IN pr_productos_contratados_to.cod_prod_ofertado%TYPE,
									SN_CANTIDAD_PROD	 OUT NOCOPY NUMBER,
									SN_cod_retorno     	 OUT NOCOPY  ge_errores_pg.coderror,
									SV_mens_retorno    	 OUT NOCOPY  ge_errores_pg.msgerror,
									SN_num_evento      	 OUT NOCOPY	ge_errores_pg.evento);

END PR_PRODUCTOS_CONTRATADOS_PG;
/
SHOW ERRORS 