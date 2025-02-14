CREATE OR REPLACE PACKAGE GE_SISTEMA_PG AS

TYPE refCursor IS REF CURSOR;

--------------
-- FUNTIONS --
--------------
FUNCTION GE_RECUPERARROL_FN (ev_id_user      IN  ge_seg_grpusuario.NOM_USUARIO%type,
			                 ev_programa     IN  ge_seg_perfiles.COD_PROGRAMA%type,
			                 en_version      IN  ge_seg_perfiles.NUM_VERSION%type,
                             SN_COD_RETORNO  OUT NOCOPY NUMBER,
							 SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                             SN_NUM_EVENTO   OUT NOCOPY NUMBER)
RETURN NUMBER;

FUNCTION GE_VERIFICAVERSION_FN (ev_cod_programa IN  ge_programas.COD_PROGRAMA%type,
                                en_num_version  IN  ge_programas.NUM_VERSION%type,
                                en_sub_version  IN  ge_programas.NUM_SUBVERSION%type,
                                sn_cod_retorno  OUT NOCOPY NUMBER,
                                sv_mens_retorno OUT NOCOPY VARCHAR2,
                                sn_num_evento   OUT NOCOPY NUMBER)
RETURN NUMBER;

FUNCTION GE_OBTENER_LETRA_FN (en_cod_tipdocum IN  ge_letras.COD_TIPDOCUM%type,
			   				  en_cod_catimpos IN  ge_letras.COD_CATIMPOS%type,
 			   				  sn_cod_retorno  OUT NOCOPY NUMBER,
			   				  sv_mens_retorno OUT NOCOPY VARCHAR2,
			   				  sn_num_evento   OUT NOCOPY NUMBER)
RETURN VARCHAR2;

FUNCTION GE_VALIDA_FECHA_VCTO_FN (ev_fecha_vencimiento IN  VARCHAR2,
                                  SN_COD_RETORNO       OUT NOCOPY NUMBER,
                                  SV_MENS_RETORNO      OUT NOCOPY VARCHAR2,
                                  SN_NUM_EVENTO        OUT NOCOPY NUMBER)
RETURN NUMBER;

FUNCTION GE_RECUPERAR_FECHA_SISTEMA_FN (SN_COD_RETORNO  OUT NOCOPY NUMBER,
			   						    SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
			   						    SN_NUM_EVENTO   OUT NOCOPY NUMBER)
RETURN VARCHAR2;

FUNCTION GE_VALIDA_MONEDA_FN (ev_cod_moneda   IN  GE_MONEDAS.COD_MONEDA%type,
                              SN_COD_RETORNO  OUT NOCOPY NUMBER,
                              SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                              SN_NUM_EVENTO   OUT NOCOPY NUMBER)
RETURN NUMBER;

FUNCTION GE_VALIDAMODVENTA_FN (EN_COD_MODVENTA IN GE_MODVENTA.COD_MODVENTA%TYPE,
		 					 SN_COD_RETORNO  OUT NOCOPY NUMBER,
			   			     SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
			   				 SN_NUM_EVENTO   OUT NOCOPY NUMBER)
 RETURN NUMBER;


----------------
-- PROCEDURES --
----------------
PROCEDURE GE_REC_PARAM_FECHA_PR (ev_cod_modulo     IN  ged_parametros.COD_MODULO%type,
	                             en_cod_producto   IN  ged_parametros.COD_PRODUCTO%type,
	                             SC_Fechas         OUT NOCOPY refCursor,
                                 SN_COD_RETORNO    OUT NOCOPY NUMBER,
							     SV_MENS_RETORNO   OUT NOCOPY VARCHAR2,
								 SN_NUM_EVENTO     OUT NOCOPY NUMBER);

PROCEDURE GE_OBT_CONF_INTERNACIONAL_PR (ev_cod_modulo   IN  ged_parametros.COD_MODULO%type,
	                                    en_cod_producto IN  ged_parametros.COD_PRODUCTO%type,
	                                    SC_Param        OUT NOCOPY refCursor,
                                        SN_COD_RETORNO  OUT NOCOPY NUMBER,
							            SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                                        SN_NUM_EVENTO   OUT NOCOPY NUMBER);

 PROCEDURE GE_PERIODOCONTABLE_PR(EV_FechaSistema    IN  VARCHAR2,
	                             SV_ESTADO_PERIODO OUT  VARCHAR2,
	                             SN_COD_RETORNO    OUT NOCOPY NUMBER,
							     SV_MENS_RETORNO   OUT NOCOPY VARCHAR2,
								 SN_NUM_EVENTO     OUT NOCOPY NUMBER);


 PROCEDURE GE_RECPARAMGENER_PR (ev_cod_modulo      IN ged_parametros.COD_MODULO%type,
	                            en_cod_producto    IN ged_parametros.COD_PRODUCTO%type,
								ev_nom_parametro   IN ged_parametros.NOM_PARAMETRO%type,
	                            Sv_val_parametro  OUT NOCOPY VARCHAR2,
								Sv_des_parametro  OUT NOCOPY VARCHAR2,
                                SN_COD_RETORNO    OUT NOCOPY NUMBER,
							    SV_MENS_RETORNO   OUT NOCOPY VARCHAR2,
								SN_NUM_EVENTO     OUT NOCOPY NUMBER);

 PROCEDURE GE_RECDATOSGENER_PR(  SN_COD_MISCELA  OUT FA_DATOSGENER.COD_MISCELA%TYPE,
 		   						 SV_COD_MONEFACT OUT FA_DATOSGENER.COD_MONEFACT%TYPE,
	                             SN_COD_RETORNO    OUT NOCOPY NUMBER,
							     SV_MENS_RETORNO   OUT NOCOPY VARCHAR2,
								 SN_NUM_EVENTO     OUT NOCOPY NUMBER);

PROCEDURE GE_RECCENTREMI_PR (EN_COD_OFICINA   IN AL_DOCUM_SUCURSAL.COD_OFICINA%TYPE,
		 				    EN_COD_TIPDOCUM  IN AL_DOCUM_SUCURSAL.COD_TIPDOCUM%TYPE,
							SN_COD_CENTREMI OUT  AL_DOCUM_SUCURSAL.COD_CENTREMI%TYPE,
		 					SN_COD_RETORNO  OUT NOCOPY NUMBER,
			   			    SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
			   				SN_NUM_EVENTO   OUT NOCOPY NUMBER) ;

PROCEDURE GE_RECMODGENER_PR (EV_COD_CATRIBUT    IN FA_GENCENTREMI.COD_CATRIBUT%TYPE,
		 				     EV_COD_MODVENTA    IN FA_GENCENTREMI.COD_MODVENTA%TYPE,
							 EN_COD_CENTREMI    IN FA_GENCENTREMI.COD_CENTREMI%TYPE,
							 EN_COD_TIPMOVIMIEN IN FA_GENCENTREMI.COD_TIPMOVIMIEN%TYPE,
							 SV_COD_MODGENER   OUT  FA_GENCENTREMI.COD_MODGENER%TYPE,
		 					 SN_COD_RETORNO    OUT NOCOPY NUMBER,
			   			     SV_MENS_RETORNO   OUT NOCOPY VARCHAR2,
			   				 SN_NUM_EVENTO     OUT NOCOPY NUMBER);

PROCEDURE GE_OBTENERCAMBIO_PR (EN_COD_MONEDA   IN GE_CONVERSION.COD_MONEDA%TYPE,
		 					  EV_FECHAINGRESO  IN VARCHAR2,
							  SN_CAMBIO       OUT GE_CONVERSION.CAMBIO%TYPE,
		 					  SN_COD_RETORNO  OUT NOCOPY NUMBER,
			   			      SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
			   				  SN_NUM_EVENTO   OUT NOCOPY NUMBER);

END;
/
SHOW ERRORS