CREATE OR REPLACE PACKAGE PR_PROCESOS_PROD_TO_PG

IS

  TYPE refCursor IS REF CURSOR;
  CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
  CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'PR';
  CV_version              CONSTANT VARCHAR2 (2)  := '1' ;
  CN_LISTA_NULA constant number:=1;


      PROCEDURE  PR_PROCESOS_PROD_I_PR(EO_PROC_PROD    IN  		  PR_PROCESOS_PROD_TD_QT,
	  			 					   EO_DTO	   IN		  BLOB,
								 	   EO_COD_PROCESO  OUT NOCOPY PR_PROCESOS_PROD_TD.COD_PROCESO%TYPE,
									   SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
									   SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
									   SN_num_evento   OUT NOCOPY ge_errores_pg.evento);

      PROCEDURE  PR_PROCESOS_PROD_U_PR( EO_PROC_PROD  IN  PR_PROCESOS_PROD_TD_QT,
	  			 						EO_DTO		 IN			BLOB,
	  						            SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						 				SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
										SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);

	  FUNCTION PR_PROCESOS_PROD_S_FN(
			            EO_NUM_PROCESO 	 	IN PR_PROCESOS_PROD_TD.NUM_PROCESO%TYPE,
			            EO_ORIGEN_PROCESO	IN PR_PROCESOS_PROD_TD.ORIGEN_PROCESO%TYPE)
	  RETURN VARCHAR2;

   --obtieneProcesoProducto
      PROCEDURE  PR_PROCESOS_PROD_SBLOB_PR( EO_PROC_PROD  IN  PR_PROCESOS_PROD_TD_QT,
          EO_DTO       OUT BLOB,
                  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
         SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
         SN_num_evento       OUT NOCOPY ge_errores_pg.evento); 
         
      --actualizaProceso
   PROCEDURE  PR_PROCESOS_PROD_ACTUALIZA_PR( EO_PROC_PROD  IN  PR_PROCESO_PRODUCTO_QT,
             EO_DTO   IN   BLOB,
                     SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
           SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
          SN_num_evento       OUT NOCOPY ge_errores_pg.evento);
          
 FUNCTION PV_PR_PROCESO_PRODUCTO_QT_FN
        RETURN PR_PROCESO_PRODUCTO_QT; 
  
   --obtieneListaProcesosPendientes 
      PROCEDURE  PR_LISTA_PROCESOS_PEND_PR(SO_PROCESOS   OUT NOCOPY refCursor,
                     SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
           SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
          SN_num_evento       OUT NOCOPY ge_errores_pg.evento);

 --consultaProcesoProducto
 PROCEDURE PR_CONS_PROCESO_PR( EO_PROC_PROD  IN OUT PR_PROCESO_PRODUCTO_QT,
                     SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
           SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
          SN_num_evento       OUT NOCOPY ge_errores_pg.evento);                    

 --eliminaProcesoProducto
 PROCEDURE PR_ELIM_PROCESO_PR( EO_PROC_PROD  IN PR_PROCESO_PRODUCTO_QT,
               SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
           SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
          SN_num_evento       OUT NOCOPY ge_errores_pg.evento);         
END PR_PROCESOS_PROD_TO_PG;
/
SHOW ERRORS
