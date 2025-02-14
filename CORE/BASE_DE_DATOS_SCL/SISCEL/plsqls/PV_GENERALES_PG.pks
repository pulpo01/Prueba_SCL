CREATE OR REPLACE PACKAGE PV_GENERALES_PG
IS
--------------------------------------------------------------------------------------------------------------------------------------------------
   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_programa			   CONSTANT VARCHAR2 (03) := 'GPA';
   CV_version              CONSTANT VARCHAR2 (2)  :=  '1';
   CN_IND_ESTADO		   CONSTANT NUMBER   (1)  :=    3;
   CV_gsFormato2	   	   CONSTANT VARCHAR  (20) := 'FORMATO_SEL2';
   CV_gsFormato4	   	   CONSTANT VARCHAR  (20) := 'FORMATO_SEL4';
   CV_gsFormato_sel1	   CONSTANT VARCHAR  (20) := 'DD/MM/YYYY';
   CV_gsFormato_sel2	   CONSTANT VARCHAR  (20) := 'YYYYMMDD HH24MI';
   CV_SEQ_NEXTVAL		   CONSTANT VARCHAR  (30) := 'GA_SEQ_NUMDIASNUM.NEXTVAL';
   CV_SITUA_BAA			   CONSTANT VARCHAR2 (3) := 'BAA';
   CV_SITUA_BAP			   CONSTANT VARCHAR2 (3) := 'BAP';
   TYPE tipoArray          IS VARRAY(999) OF VARCHAR2(30);
   TYPE numeroOS		   IS RECORD (num_os ci_orserv.num_os%type);
   TYPE listaNumOS		   IS TABLE OF numeroOS INDEX BY PLS_INTEGER;
 ---------------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_OBTIENE_GED_PARAMETROS_PR (
										EO_GED_PARAMETROS		IN OUT NOCOPY	PV_GED_PARAMETROS_QT,
										SN_cod_retorno    		OUT    NOCOPY   ge_errores_td.cod_msgerror%TYPE,
										SV_mens_retorno   		OUT    NOCOPY   ge_errores_td.det_msgerror%TYPE,
										SN_num_evento     		OUT    NOCOPY	ge_errores_pg.evento);
 ---------------------------------------------------------------------------------------------------------------------

    PROCEDURE PV_OBTIENE_GED_PARAM_SIMPL_PR (EO_GED_PARAMETROS	IN OUT NOCOPY	PV_GED_PARAMETROS_QT,
									      SN_cod_retorno       OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
									      SV_mens_retorno      OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
									      SN_num_evento        OUT NOCOPY	ge_errores_pg.evento);
 ---------------------------------------------------------------------------------------------------------------------

	PROCEDURE PV_FORMATO_FEC_PR (
										EO_FORMATO_FEC			IN OUT NOCOPY	PV_FORMATO_FEC_QT,
										SN_cod_retorno    		OUT    NOCOPY   ge_errores_td.cod_msgerror%TYPE,
										SV_mens_retorno   		OUT    NOCOPY   ge_errores_td.det_msgerror%TYPE,
										SN_num_evento     		OUT    NOCOPY	ge_errores_pg.evento);
 ---------------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_OBTIENE_SECUENCIA_PR (EO_SECUENCIA			IN OUT NOCOPY	PV_SECUENCIA_QT,
									   SN_cod_retorno   	OUT    NOCOPY   ge_errores_td.cod_msgerror%TYPE,
									   SV_mens_retorno  	OUT    NOCOPY   ge_errores_td.det_msgerror%TYPE,
									   SN_num_evento    	OUT    NOCOPY	ge_errores_pg.evento);

---------------------------------------------------------------------------------------------------------------------
   PROCEDURE PV_OBTIENE_GED_CODIGOS_PR(SO_GEDCODIGOS		IN OUT NOCOPY   PV_TIPOS_PG.TIP_GED_CODIGOS,
   			 						   SO_cursor            OUT    NOCOPY	refCursor,
									   SN_cod_retorno   	OUT    NOCOPY   ge_errores_td.cod_msgerror%TYPE,
									   SV_mens_retorno  	OUT    NOCOPY   ge_errores_td.det_msgerror%TYPE,
									   SN_num_evento    	OUT    NOCOPY	ge_errores_pg.evento);

---------------------------------------------------------------------------------------------------------------------
   FUNCTION PV_obtiene_version_FN(SV_Version       OUT NOCOPY   ge_programas.num_version%TYPE,
		 					   SV_SubVersion    OUT NOCOPY   ge_programas.num_subversion%TYPE,
		 					   SN_cod_retorno   OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
					      	   SV_mens_retorno  OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
					      	   SN_num_evento    OUT NOCOPY	 ge_errores_pg.evento)
	RETURN BOOLEAN ;
---------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_SECUENCIA_PR (EO_SECUENCIA	IN OUT NOCOPY	PV_SECUENCIA_QT,
								   EN_NUM_VECES IN NUMBER,
								   SO_numerosOS    OUT NOCOPY refcursor,
  							       SN_cod_retorno  OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
								   SV_mens_retorno OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
								   SN_num_evento   OUT NOCOPY	ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_DATOS_OFICINA(EO_OFICINA      IN OUT NOCOPY PV_OFICINA_QT,
  							       SN_cod_retorno  OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
								   SV_mens_retorno OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
								   SN_num_evento   OUT NOCOPY	ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_ABONADOS_SECUENCIA_PR (EO_CLIENTE		IN PV_CLIENTE_QT,
		  						   	EO_SECUENCIA	IN PV_SECUENCIA_QT,
									   SO_numerosOS    OUT NOCOPY refcursor,
	  							       SN_cod_retorno  OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
									   SV_mens_retorno OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
									   SN_num_evento   OUT NOCOPY	ge_errores_pg.evento);

END PV_GENERALES_PG;
/
SHOW ERRORS
