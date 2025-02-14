CREATE OR REPLACE PACKAGE PV_COMIS_OOSS_PG
IS
   TYPE refCursor IS REF CURSOR;
   
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CN_producto			   CONSTANT NUMBER        := 1;
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'PV';
   CN_ind_vta_externa	   CONSTANT NUMBER	 	  := 1;
   CN_ind_vta_interna	   CONSTANT	NUMBER		  := 0;


------------------------------------------------------------------------------------------------------

	PROCEDURE PV_OBTIENE_DATOS_VENDEDOR_PR(EO_pv_comis_ooss    	    IN OUT         	PV_COMIS_OOSS_QT,
	                                       SC_cursor OUT NOCOPY refCursor,
									       SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
									       SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
									       SN_num_evento            OUT NOCOPY	    ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
	PROCEDURE PV_REGISTRA_DATOS_COMIS_PR  (EO_pv_comis_ooss    	    IN          	PV_COMIS_OOSS_QT,
									       SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
									       SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
									       SN_num_evento            OUT NOCOPY	    ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------


END PV_COMIS_OOSS_PG;
/
SHOW ERROR
