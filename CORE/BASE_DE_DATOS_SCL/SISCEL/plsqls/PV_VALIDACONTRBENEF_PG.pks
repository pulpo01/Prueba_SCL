CREATE OR REPLACE PACKAGE PV_VALIDACONTRBENEF_PG AS

	CV_TIPO_COMPORTAMIENTO   VARCHAR2 (4) := 'PMOD';
	CV_NIVEL_APLICA			 VARCHAR2 (1) := 'A';
	CN_CICLOFACTNOPERMITIDO	 NUMBER (10)  := 19010102;
	CV_CO_CARTERA			 VARCHAR(10) := 'CO_CARTERA';
	CV_COD_TIPDOCUM			 VARCHAR(12) := 'COD_TIPDOCUM';
	CV_ERROR_NO_CLASIF       VARCHAR2 (50) := 'No es posible clasificar el error';
   	cv_cod_modulo            VARCHAR2 (2)  := 'PV';
   	cv_version               VARCHAR2 (2)  := '1';
	CV_IND_FACTURADO 		 NUMBER(8) := 1;
	CV_ind_condicion		 VARCHAR2 (1) := 'O';

	PROCEDURE PV_OBTENERNUMABOCLIE_PR
	(
		EN_num_celular		IN		    GA_ABOCEL.num_celular%TYPE,
		SN_num_abonado		OUT 	    GA_ABOCEL.num_abonado%TYPE,
		SN_cod_cliente		OUT	 	    GA_ABOCEL.cod_cliente%TYPE,
		SN_cod_plantarif	OUT 	    GA_ABOCEL.cod_plantarif%TYPE,
		SN_cod_ciclo		OUT 	    GA_ABOCEL.cod_ciclo%TYPE,
		SN_resultado		OUT NOCOPY	Number,
		SV_mensaje			OUT NOCOPY	ge_errores_pg.MsgError
	);

	PROCEDURE PV_SITUACIONABON_PR
	(

	 	EN_num_abonado		IN	 		GA_ABOCEL.NUM_ABONADO%TYPE,
		EN_cod_os			IN			ci_tiporserv.cod_os%TYPE,
		SN_resultado		OUT NOCOPY	Number,
		SV_mensaje			OUT NOCOPY	ge_errores_pg.MsgError

	);

	PROCEDURE PV_TIPOPLANABO_PR
	(
		EN_cod_plantarif	IN	 		GA_ABOCEL.COD_PLANTARIF%TYPE,
		SN_cod_tiplan		OUT			TA_PLANTARIF.COD_TIPLAN%TYPE,
		SN_resultado		OUT NOCOPY	Number,
		SV_mensaje			OUT NOCOPY	ge_errores_pg.MsgError
	);

	PROCEDURE PV_MOROSIDADABO_PR
	(
	 	EN_cod_cliente		IN	CO_CARTERA.COD_CLIENTE%TYPE,
		SN_resultado		OUT NOCOPY	Number,
		SV_mensaje			OUT NOCOPY	ge_errores_pg.MsgError
	);

	PROCEDURE PV_VALIDACICLOFACT_PR(
		EN_cod_cliente_con	IN	ga_infaccel.COD_CLIENTE%TYPE,
		EN_num_abonado_con  IN	ga_infaccel.NUM_ABONADO%TYPE,
		EN_cod_ciclo		IN	fa_ciclfact.COD_CICLO%TYPE,
		SN_cod_ciclfact		OUT NOCOPY	fa_ciclfact.cod_ciclfact%TYPE,
		SD_fec_desdeocargos	OUT NOCOPY	fa_ciclfact.fec_desdeocargos%TYPE,
		SD_fec_hastaocargos	OUT NOCOPY	fa_ciclfact.fec_hastaocargos%TYPE,
		SN_resultado		OUT NOCOPY	Number,
		SV_mensaje			OUT NOCOPY	ge_errores_pg.MsgError
	);

	PROCEDURE  PV_VALIDACICLOPERMANENCIA_PR(
		EN_cod_cliente	IN	 fa_histdocu.COD_CLIENTE%TYPE,
		EN_min_ciclos	IN	 NUMBER,
		SN_resultado   OUT NOCOPY	Number,
		SV_mensaje	   OUT NOCOPY	ge_errores_pg.MsgError
	);

	PROCEDURE PV_VALCONTRANTEBENEFICIARIO_PR(
		EN_num_celular_con IN	ga_abocel.NUM_CELULAR%TYPE,
		EN_num_celular_ben IN	ga_abocel.NUM_CELULAR%TYPE,
		EN_cod_producto    IN	number,
		EN_can_producto    IN	number,
		EN_canal		   IN	Varchar2,
		SN_resultado   	   OUT NOCOPY	Number,
		SV_mensaje	   	   OUT NOCOPY	ge_errores_pg.MsgError
	);
/****************************************************************************************************************************/
PROCEDURE PV_VALIDAPOSPAGO_PR ( EV_PARAM_ENTRADA IN         VARCHAR2,
								SV_RESULTADO     OUT NOCOPY VARCHAR2,
								SV_MENSAJE       OUT NOCOPY ga_transacabo.des_cadena%TYPE
							);
/****************************************************************************************************************************/
END PV_VALIDACONTRBENEF_PG;
/
SHOW ERRORS
