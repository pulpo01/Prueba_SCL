CREATE OR REPLACE PACKAGE PV_DATOS_ABONADO2_PG
IS
   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_cod_modulo_GE        CONSTANT VARCHAR2 (2)  := 'GE';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CV_gsFormato2	   	   CONSTANT VARCHAR2 (20) := 'FORMATO_SEL2';
   CV_gsFormato4	   	   CONSTANT VARCHAR2 (20) := 'FORMATO_SEL4';
   CV_val_prm_estado	   CONSTANT VARCHAR2 (15) := 'EST_RESPCENTRAL';
   CV_tip_plan_hibrido	   CONSTANT	VARCHAR2 (20) := 'TIP_PLAN_HIBRIDO';
   CV_cod_usucontrolada    CONSTANT VARCHAR2 (30) := 'COD_USOCONTROLADA';

   CV_val_prm_maxint	   CONSTANT VARCHAR  (12) := 'MAX_INTENTOS';
   CV_formato_fecha		   CONSTANT VARCHAR  (22) := 'dd-mm-yyyy hh24:mi:ss';
   CV_cod_aplic			   CONSTANT VARCHAR2 (3)  := 'PVA';
   CV_cod_actabo           CONSTANT VARCHAR2 (2)  := 'BA';
   CV_situacion			   CONSTANT VARCHAR2 (3)  := 'CPP';
   CN_producto			   CONSTANT NUMBER        := 1;

   CV_ACTABO_TERRENO	   CONSTANT VARCHAR2(3)	  := 'VT';
   CV_ACTABO_OFICINA	   CONSTANT VARCHAR2(3)	  := 'VO';
   CV_ACTABO_HIBRIDO	   CONSTANT VARCHAR2(3)	  := 'HH';

------------------------------------------------------------------------------------------------------

	PROCEDURE PV_OBTIENE_DATOS_ABONADO_PR(SO_Abonado         	IN OUT NOCOPY	GA_Abonado2_QT,
									      SN_cod_retorno           OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
									      SV_mens_retorno          OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
									      SN_num_evento            OUT NOCOPY	ge_errores_pg.evento);
    PROCEDURE PV_OBTIENE_CELDA_ABONADO_PR (EN_NumAbonado           IN           GA_ABOCEL.NUM_ABONADO%TYPE,
								       SV_CodCelda             OUT NOCOPY   GA_ABOCEL.COD_CELDA%TYPE, 
                                       SN_cod_retorno          OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
								       SV_mens_retorno         OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
								       SN_num_evento           OUT NOCOPY	ge_errores_pg.evento);                                          
------------------------------------------------------------------------------------------------------


END PV_DATOS_ABONADO2_PG;
/
SHOW ERROR
