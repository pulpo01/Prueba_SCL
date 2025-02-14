CREATE OR REPLACE PACKAGE PR_VALIDACONTRBENEF_PG

IS

        CV_error_no_clasif       VARCHAR2 (50) := 'No es posible clasificar el error';
   	    CV_cod_modulo            VARCHAR2 (2)  := 'PV';
   	    CV_version               VARCHAR2 (2)  := '1';

		PROCEDURE  PR_OBTENERRESTRICIONPRODUC_PR(
			EN_tipo_plataforma		IN 	  pf_restricciones_prod_td.tipo_plataforma%TYPE,
			EV_ind_nivel_aplica		IN    pf_restricciones_prod_td.ind_nivel_aplica%TYPE,
			EV_tipo_comportamiento	IN    pf_restricciones_prod_td.tipo_comportamiento%TYPE,
			SN_min_ciclos			OUT NOCOPY pf_restricciones_prod_td.min_ciclos%TYPE,
			SN_max_cantidad			OUT NOCOPY pf_restricciones_prod_td.max_cantidad%TYPE,
			SN_max_monto			OUT NOCOPY pf_restricciones_prod_td.max_monto%TYPE,
			SN_resultado   			OUT NOCOPY	Number,
			SV_mensaje	   			OUT NOCOPY	ge_errores_pg.MsgError
		);


		PROCEDURE PR_VALIDACANTMODULOSCICLO_PR(
			EN_cod_cliente_con		IN	  pr_productos_contratados_to.COD_CLIENTE_CONTRATANTE%TYPE,
			EN_num_abonado_con		IN	  pr_productos_contratados_to.NUM_ABONADO_CONTRATANTE%TYPE,
			EV_tip_comport			IN	  pr_productos_contratados_to.TIPO_COMPORTAMIENTO%TYPE,
			EV_ind_condicion		IN	  pr_productos_contratados_to.IND_CONDICION_CONTRATACION%TYPE,
			ED_fecha_desde			IN	  pr_productos_contratados_to.FEC_PROCESO%TYPE,
			ED_fecha_hasta			IN	  pr_productos_contratados_to.FEC_PROCESO%TYPE,
			EN_max_cantidad			IN	  NUMBER,
			EN_cantidaAcon			IN	  NUMBER,
			SN_resultado    		OUT NOCOPY	Number,
			SV_mensaje	   			OUT NOCOPY	ge_errores_pg.MsgError
		);

		PROCEDURE PR_VALIDAMONTOMODULOSCICLO_PR(
			EN_cod_cliente_con		IN	  pr_productos_contratados_to.COD_CLIENTE_CONTRATANTE%TYPE,
			EN_num_abonado_con		IN	  pr_productos_contratados_to.NUM_ABONADO_CONTRATANTE%TYPE,
			EV_tip_comport			IN	  pr_productos_contratados_to.TIPO_COMPORTAMIENTO%TYPE,
			EV_ind_condicion		IN	  pr_productos_contratados_to.IND_CONDICION_CONTRATACION%TYPE,
			ED_fecha_desde			IN	  pr_productos_contratados_to.FEC_PROCESO%TYPE,
			ED_fecha_hasta			IN	  pr_productos_contratados_to.FEC_PROCESO%TYPE,
			EN_max_monto			IN	  NUMBER,
			EN_cantidaAcon			IN	  NUMBER,
			EN_cod_product			IN 	  pf_catalogo_ofertado_td.COD_PROD_OFERTADO%TYPE,
			EN_cod_canal			IN 	  pf_catalogo_ofertado_td.COD_CANAL%TYPE,
			SN_resultado    		OUT NOCOPY	Number,
			SV_mensaje	   			OUT NOCOPY	ge_errores_pg.MsgError
		);



END PR_VALIDACONTRBENEF_PG;
/
SHOW ERRORS
