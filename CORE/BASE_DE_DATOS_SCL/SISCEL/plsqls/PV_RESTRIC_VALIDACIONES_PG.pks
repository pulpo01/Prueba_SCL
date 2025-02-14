CREATE OR REPLACE PACKAGE PV_RESTRIC_VALIDACIONES_PG
IS

   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CN_producto			   CONSTANT NUMBER        := 1;


     TYPE T_CURSORGETPOS IS RECORD (
	    NUM_MOVIMIENTO      NUMBER(8),
		COD_ACTABO          VARCHAR2(2),
        IND_FACTUR          VARCHAR2(1),
        DES_SERV            VARCHAR2(255),
        NUM_UNIDADES        NUMBER(6),
        COD_CONCEPTO        NUMBER(4),
        IMP_CARGO           NUMBER(14,4),
        COD_ARTICULO        NUMBER(6),
        COD_BODEGA          NUMBER(6),
        NUM_SERIE           VARCHAR2(25),
        IND_EQUIPO          VARCHAR2(1),
        COD_CLIENTE         NUMBER(8),
        NUM_ABONADO         NUMBER(8),
        TIP_DTO             VARCHAR2(1),
        VAL_DTO             NUMBER(14,4),
        COD_CONCEPTO_DTO    NUMBER(4),
        NUM_CELULAR         NUMBER(15),
        COD_PLANCOM         NUMBER(6),
        CLASE_SERVICIO_ACT  VARCHAR2(255),
        CLASE_SERVICIO_DES  VARCHAR2(255),
        PARAM1_MENS         VARCHAR2(255),
        PARAM2_MENS         VARCHAR2(255),
        PARMA3_MENS         VARCHAR2(255),
        CLASE_SERVICIO      VARCHAR2(255),
        DES_MONEDA          VARCHAR2(255),
        COD_MONEDA          VARCHAR2(3),
        COD_CICLO           NUMBER(2),
        FACT_CONT           NUMBER(1),
        VAL_MIN             NUMBER(14,4),
        VAL_MAX             NUMBER(14,4),
        P_DESC              NUMBER(1),
        COD_ERROR           NUMBER(1),
        DES_ERROR           VARCHAR2(255)
	);

   TYPE  TC_cursordatos IS TABLE OF T_CURSORGETPOS
          INDEX BY BINARY_INTEGER;

---------------------------------------------------------------------------------------------------------
--1.- Metodo  : validaServicioActDesc(CadenaSSPlanOrigen, CadenaSSPlanDestino)     (PL nuevo)
	PROCEDURE PV_VALIDA_SERV_ACTDEC_PR (EO_VALIDA_SERV_ACTDEC   IN				PV_VALIDA_SERV_ACTDEC_QT,
									    SV_record              OUT 	NOCOPY	    refcursor,
									    SN_cod_retorno          OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
									    SV_mens_retorno         OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
									    SN_num_evento           OUT NOCOPY		ge_errores_pg.evento);
---------------------------------------------------------------------------------------------------------

END PV_RESTRIC_VALIDACIONES_PG;
/
SHOW ERRORS
