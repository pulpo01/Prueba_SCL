CREATE OR REPLACE PACKAGE CU_VALIDACONTRBENEF_PG

IS

  CV_ERROR_NO_CLASIF       VARCHAR2 (50) := 'No es posible clasificar el error';
  CV_cod_modulo            VARCHAR2 (2)  := 'PV';
  CV_version               VARCHAR2 (2)  := '1';


  PROCEDURE CU_VALVETADOSCONTRA_PR(
  		EN_cod_cliente in cu_vetados_prod_to.COD_CLIENTE%TYPE,
		EN_num_abonado  in cu_vetados_prod_to.NUM_ABONADO%TYPE,
		SN_resultado   OUT NOCOPY	Number,
		SV_mensaje	   OUT NOCOPY	ge_errores_pg.MsgError
  );

  PROCEDURE CU_VALIDABENEFICIARIO_PR(
  		EN_cod_cliente 		 in cu_vetados_prod_to.COD_CLIENTE%TYPE,
		EN_num_abonado_con   in cu_vetados_prod_to.NUM_ABONADO%TYPE,
		EN_num_abonado_ben   in cu_vetados_prod_to.NUM_ABONADO%TYPE,
		SN_resultado   		 OUT NOCOPY	Number,
		SV_mensaje	   		 OUT NOCOPY	ge_errores_pg.MsgError
  );


END CU_VALIDACONTRBENEF_PG;
/
SHOW ERRORS
