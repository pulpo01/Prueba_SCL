CREATE OR REPLACE PACKAGE PV_DATOSCLI_SB_PG AS
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';

   CV_ClasePlantarif_SRV   CONSTANT VARCHAR2(3)	  := 'SRV';
   CV_IndAplica_C		   CONSTANT VARCHAR2(1)	  := 'C';
   CV_TIP_RELACION_4	   CONSTANT NUMBER 		  := 4;
   CV_COD_PRODUCTO		   CONSTANT NUMBER 		  := 1;
   CV_TIP_RELACION_3	   CONSTANT NUMBER 		  := 3;
   CV_MODIF_TEMP_LC		   CONSTANT VARCHAR2(50)  := 'MODIFICACION TEMPORAL LC';

	 
	PROCEDURE PV_OBTIENE_DATOS_CLIE_PR(
      	   	  SO_Servsupl      IN OUT NOCOPY	PV_Servsupl_QT,
      		  SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      		  SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      		  SN_num_evento    OUT NOCOPY		ge_errores_pg.evento);
			 		 
end PV_DATOSCLI_SB_PG;
/
SHOW ERRORS