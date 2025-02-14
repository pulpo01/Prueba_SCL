CREATE OR REPLACE PACKAGE GA_SERVICIOS_WIMAX_PG IS

    CV_error_no_clasif   CONSTANT VARCHAR2(30) := 'Error no clasificado';
    cn_largoerrtec       CONSTANT NUMBER        := 4000;
    cn_largodesc         CONSTANT NUMBER        := 2000;
    cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'VE';
    CV_PRODUCTO          CONSTANT VARCHAR(1)   := '1';
    CV_tipodireccion     CONSTANT VARCHAR2(1)  := '1';
    CV_MODULO_GA         CONSTANT VARCHAR2(2)  := 'GA';
    CV_MODULO_GE         CONSTANT VARCHAR2(2)  := 'GE';
    CV_MODULO_AL         CONSTANT VARCHAR2(2)  := 'AL';
    CV_CODACT_VEN         CONSTANT VARCHAR2(2)  := 'VO';               -- codigo actuacion : venta oficina
    CV_FORMATO_FECHA     CONSTANT VARCHAR2(12) := 'FORMATO_SEL2';
    CV_FORMATO_FECHA_SIS CONSTANT VARCHAR2(17)  := 'DDMMYYYY HH24MISS';
    CV_NOMPAR_MONEDAPESO CONSTANT VARCHAR2(15) := 'COD_MONEDA_PESO';
    CV_NOMPAR_SERVHABILI CONSTANT VARCHAR2(18) := 'COD_SERVICIO_HABIL';
    CV_NOMPAR_INDTELOUT  CONSTANT VARCHAR2(11) := 'IND_TEL_OUT';

    CV_SERVOCASIONAL     CONSTANT VARCHAR(1)   := '1';
    CV_SERVSUPLEMENTARIO CONSTANT VARCHAR2(1)  := '2';
    CN_INDBLOQUEO         CONSTANT NUMBER       := 1;
    CN_ESTADO              CONSTANT NUMBER       := 0;
    CI_TRUE              CONSTANT PLS_INTEGER  := 1;
    CI_FALSE             CONSTANT PLS_INTEGER  := 0;
    CV_IND_VENTA_EXTERNA CONSTANT NUMBER       := 1;
    CV_IND_TIPO_VENTA    CONSTANT VARCHAR2(1)  := 'V' ;
    CV_TIP_VENTA_OFICINA CONSTANT VARCHAR2(1)  := 'O' ;
    CV_FORM_PRESU_VTA      CONSTANT VARCHAR2(15)  := 'FrmPresuVenta';
    CV_BAJA_ABONADO      CONSTANT VARCHAR2(3)  := 'BAA';
    CV_BAJA_ABONADOPDTE  CONSTANT VARCHAR2(3)  := 'BAP';
    CV_RECHAZADA         CONSTANT VARCHAR2(2)  := 'RE';
    CV_INDALTA           CONSTANT VARCHAR2(1)  := 'M';  --INC 45391
    CN_ESTADO_DOC         CONSTANT NUMBER       := 900;
    CN_ESTADO_PROC         CONSTANT NUMBER       := 3;
    CV_REPONE_CELULAR    CONSTANT VARCHAR(1)   := 'R';  --Indica reposición de numero celular
    CV_REPONE_CEL_RES    CONSTANT VARCHAR(1)   := 'S';  --Indica reposición de num celular reservado
    CV_CAUSA_ELIMIN      CONSTANT VARCHAR2(5)  := '00003';
    CN_CERO              CONSTANT NUMBER(1)    := 0;  
    
    TYPE refcursor                  IS REF CURSOR;
    TYPE ARRAY_PARAMETROS_    IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;

FUNCTION getNombreCliente_FN 
                            (EN_numMovimiento IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
                            RETURN VARCHAR2; 
FUNCTION getMacAddress_FN
                            (EN_numMovimiento IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
                            RETURN VARCHAR2;
FUNCTION getDireccionUsuario_fn
                            (EN_numMovimiento IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
                            RETURN VARCHAR2;
FUNCTION getTipoZona_fn
                            (EN_numMovimiento IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
                            RETURN VARCHAR2;                                                                                                                                                                      

END GA_SERVICIOS_WIMAX_PG; 
/
SHOW ERRORS