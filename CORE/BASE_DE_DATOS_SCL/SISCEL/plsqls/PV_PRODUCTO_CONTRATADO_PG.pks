CREATE OR REPLACE PACKAGE Pv_Producto_Contratado_Pg
IS
   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   GV_Nom_Secuencia		   CONSTANT VARCHAR2 (30) := 'GA_SEQ_NUMDIASNUM';
   GV_Nom_Cod_Optaamistar  CONSTANT VARCHAR2 (30) := 'COD_OPTAAMISTAR';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_COD_ACTABO		   CONSTANT VARCHAR2 (2)  := 'FA';
   CV_version              CONSTANT VARCHAR2 (2)  :=  '1';
   CV_COD_TIPSERV		   CONSTANT VARCHAR2 (2)  :=  '2';
   CN_IND_ESTADO		   CONSTANT NUMBER   (1)  := 3;
   CN_COD_NIVEL		       CONSTANT NUMBER   (1)  := 0;
   CN_producto			   CONSTANT NUMBER   (1)  := 1;
   CN_prepago			   CONSTANT NUMBER   (1)  := 1;
   CN_pospago			   CONSTANT NUMBER   (1)  := 2;
   CN_Ind_Vigencia		   CONSTANT NUMBER   (1)  := 1;

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.- Metodo : RegistraReordenamientoPlan
   PROCEDURE PV_REG_REORDENAMIENTO_PLAN_PR (EO_REG_REORD_PLAN	   IN 	  			PV_REG_REORD_PLAN_QT,
										     SN_cod_retorno        	   OUT 	  NOCOPY    ge_errores_td.cod_msgerror%TYPE,
										     SV_mens_retorno       	   OUT 	  NOCOPY    ge_errores_td.det_msgerror%TYPE,
										     SN_num_evento         	   OUT 	  NOCOPY	ge_errores_pg.evento);

	---------------------------------------------------------------------------------------------------------
	-- 2.- Metodo :  registroCambPlanComer       Existente
	PROCEDURE PV_REG_CAMB_PLAN_COMER_PR (EO_REG_CAMB_PLAN_COMER	   IN 	  		 	PV_REG_CAMB_PLAN_COMER_QT,
								     SN_cod_retorno        	   OUT 	  NOCOPY    ge_errores_td.cod_msgerror%TYPE,
								     SV_mens_retorno       	   OUT 	  NOCOPY    ge_errores_td.det_msgerror%TYPE,
								     SN_num_evento         	   OUT 	  NOCOPY	ge_errores_pg.evento);


	---------------------------------------------------------------------------------------------------------
   -- 3   metodo actualizaIntarcelAcciones (FE)
	PROCEDURE PV_VAL_DESAC_LIST_FREC_PR(EO_ICGENERICA_TO   IN 	  		 	PV_ICGENERICA_TO_QT,
								     SN_cod_retorno        OUT 	  NOCOPY    ge_errores_td.cod_msgerror%TYPE,
								     SV_mens_retorno       OUT 	  NOCOPY    ge_errores_td.det_msgerror%TYPE,
								     SN_num_evento         OUT 	  NOCOPY	ge_errores_pg.evento);

	---------------------------------------------------------------------------------------------------------
	-- 5   Método registraDesActSerFre
	PROCEDURE PV_REG_DESACT_SERV_FREC_PR(EO_DESACT_SERVFREC	   IN OUT	  		 	PV_DESACT_SERVFREC_QT,
								     SN_cod_retorno        OUT 	  NOCOPY    ge_errores_td.cod_msgerror%TYPE,
								     SV_mens_retorno       OUT 	  NOCOPY    ge_errores_td.det_msgerror%TYPE,
								     SN_num_evento         OUT 	  NOCOPY	ge_errores_pg.evento);


	---------------------------------------------------------------------------------------------------------
	-- 6.	  Método:  registroCambPlanServ
	PROCEDURE PV_REG_CAMB_PLAN_SERV_PR(EO_REG_CAMB_PLAN_SERV	   IN 	  		 	PV_REG_CAMB_PLAN_SERV_QT,
									     SN_cod_retorno        	   OUT 	  NOCOPY    ge_errores_td.cod_msgerror%TYPE,
									     SV_mens_retorno       	   OUT 	  NOCOPY    ge_errores_td.det_msgerror%TYPE,
									     SN_num_evento         	   OUT 	  NOCOPY	ge_errores_pg.evento);


	---------------------------------------------------------------------------------------------------------
	-- 7  Metodo :  validaCuentaPersonal
	FUNCTION PV_VALIDA_CUENTA_PERSONAL_FN(EO_NUMCEL_PERS		   IN	         PV_NUMCEL_PERS_QT,
								      SN_cod_retorno           	   OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
								      SV_mens_retorno          	   OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
								      SN_num_evento            	   OUT NOCOPY	 ge_errores_pg.evento)
    RETURN VARCHAR2;

	---------------------------------------------------------------------------------------------------------
	--8.- Metodo  :  	Obterner cambio de Plantarifario Servicio    PV_OBTENER_CAMB_PLAN_SERV_PR
	PROCEDURE PV_OBTENER_CAMB_PLAN_SERV_PR (EO_OBT_CAMB_PLAN_SERV	IN OUT		    PV_OBT_CAMB_PLAN_SERV_QT,
										    SN_cod_retorno       	   OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
										    SV_mens_retorno      	   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
										    SN_num_evento        	   OUT NOCOPY	ge_errores_pg.evento);

----------------------------------------------------------------------------------------------------------
	--9.- Metodo  :     obtenerCausaBaja   				 			 PV_OBTENER_CAUSA_BAJA_PR
	PROCEDURE PV_OBTENER_CAUSA_BAJA_PR (SO_CAUSABAJA               OUT NOCOPY	refCursor,
										SN_cod_retorno       	   OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
										SV_mens_retorno      	   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
										SN_num_evento        	   OUT NOCOPY	ge_errores_pg.evento);

----------------------------------------------------------------------------------------------------------
    --  10.- Metodo :  registraTraspasoPlan
PROCEDURE PV_REG_TRASPASO_PLAN_PR (EO_TRASPASO_PLAN	   IN	  PV_TRASPASO_PLAN_QT,
				   SN_cod_retorno     	   OUT 	  NOCOPY    ge_errores_td.cod_msgerror%TYPE,
				   SV_mens_retorno     	   OUT 	  NOCOPY    ge_errores_td.det_msgerror%TYPE,
				   SN_num_evento       	   OUT 	  NOCOPY    ge_errores_pg.evento);

END Pv_Producto_Contratado_Pg;
/
SHOW ERRORS
