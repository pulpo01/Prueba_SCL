CREATE OR REPLACE PACKAGE GA_CONVERSION_MONETARIA_PG IS

    CV_error_no_clasif   CONSTANT VARCHAR2(30) := 'Error no clasificado';
    cn_largoerrtec       CONSTANT NUMBER       := 4000;
    cn_largodesc         CONSTANT NUMBER       := 2000;
    cv_cod_modulo        CONSTANT VARCHAR2(2)  := 'VE';
    CV_PRODUCTO          CONSTANT VARCHAR2(1)  := '1';
    CV_tipodireccion     CONSTANT VARCHAR2(1)  := '1';
    CV_MODULO_GA         CONSTANT VARCHAR2(2)  := 'GA';
    CV_MODULO_GE         CONSTANT VARCHAR2(2)  := 'GE';
    CV_MODULO_AL         CONSTANT VARCHAR2(2)  := 'AL';
    CV_CODACT_VEN        CONSTANT VARCHAR2(2)  := 'VO';               -- codigo actuacion : venta oficina
    CV_FORMATO_FECHA     CONSTANT VARCHAR2(12) := 'FORMATO_SEL2';
    CV_FORMATO_FECHA_SIS CONSTANT VARCHAR2(17) := 'DDMMYYYY HH24MISS';
    CV_NOMPAR_MONEDAPESO CONSTANT VARCHAR2(15) := 'COD_MONEDA_PESO';
    CV_NOMPAR_SERVHABILI CONSTANT VARCHAR2(18) := 'COD_SERVICIO_HABIL';
    CV_NOMPAR_INDTELOUT  CONSTANT VARCHAR2(11) := 'IND_TEL_OUT';

    
    CV_SERVOCASIONAL     CONSTANT VARCHAR2(1)  := '1';
    CV_SERVSUPLEMENTARIO CONSTANT VARCHAR2(1)  := '2';
    CN_INDBLOQUEO        CONSTANT NUMBER       := 1;
    CN_ESTADO            CONSTANT NUMBER       := 0;
    CI_TRUE              CONSTANT PLS_INTEGER  := 1;
    CI_FALSE             CONSTANT PLS_INTEGER  := 0;
    CV_IND_VENTA_EXTERNA CONSTANT NUMBER       := 1;
    CV_IND_TIPO_VENTA    CONSTANT VARCHAR2(1)  := 'V' ;
    CV_TIP_VENTA_OFICINA CONSTANT VARCHAR2(1)  := 'O' ;
    CV_FORM_PRESU_VTA    CONSTANT VARCHAR2(15) := 'FrmPresuVenta';
    CV_BAJA_ABONADO      CONSTANT VARCHAR2(3)  := 'BAA';
    CV_BAJA_ABONADOPDTE  CONSTANT VARCHAR2(3)  := 'BAP';
    CV_RECHAZADA         CONSTANT VARCHAR2(2)  := 'RE';
    CV_INDALTA           CONSTANT VARCHAR2(1)  := 'M';  --INC 45391
    CN_ESTADO_DOC        CONSTANT NUMBER       := 900;
    CN_ESTADO_PROC       CONSTANT NUMBER       := 3;
    CV_REPONE_CELULAR    CONSTANT VARCHAR2(1)  := 'R';  --Indica reposición de numero celular
    CV_REPONE_CEL_RES    CONSTANT VARCHAR2(1)  := 'S';  --Indica reposición de num celular reservado
    CV_CAUSA_ELIMIN      CONSTANT VARCHAR2(5)  := '00003';
    CN_CERO              CONSTANT NUMBER(1)    := 0;  
    
    TYPE refcursor                  IS REF CURSOR;
    TYPE ARRAY_PARAMETROS_    IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;
    
    /*Inicio modificaciones JM*/
    CV_version           CONSTANT VARCHAR2(3)  := '1.0';
    CN_ESTADO_OK         CONSTANT NUMBER(2)    := 0;
    CN_ERROR_CATEGORIA   CONSTANT NUMBER(2)    := 5;--Error código de categoria no existe
    CV_ERROR_CATEGORIA   CONSTANT VARCHAR2(50) := 'Categoria del cliente a modificar no existe';
    CN_CLIE_SINABONADO   CONSTANT NUMBER(2)    := 6;--Error cliente no tiene abonado activo
    CV_CLIE_SINABONADO   CONSTANT VARCHAR2(50) := 'Cliente no posee abonados activos';
    CN_CLIE_MOROSO       CONSTANT NUMBER(2)    := 7;--Cliente moroso
    CV_CLIE_MOROSO       CONSTANT VARCHAR2(50) := 'Cliente moroso';
    CN_CLIE_DUPLICADO    CONSTANT NUMBER(2)    := 8;--Error Cliente Duplicado
    CV_CLIE_DUPLICADO    CONSTANT VARCHAR2(50) := 'Cliente duplicado';
	CN_IND_FACTURADO     CONSTANT NUMBER(1)    := 1;--Indicador Facturado
	CV_CO_CARTERA        CONSTANT VARCHAR2(10) := 'CO_CARTERA'; -- Nombre tabla de ged_codigos
    CV_TIP_DOCUM         CONSTANT VARCHAR2(12) := 'COD_TIPDOCUM';-- Nombre columna de ged_codigos
    
    /*Fin modificaciones JM*/ 


FUNCTION GA_CONVIERTE_MONTO_FN ( EV_COD_MONEDA     IN  VARCHAR,
                                 EN_COD_CLIENTE    IN  NUMBER,
                                 EN_MONTO_ORIGEN   IN  NUMBER,
                                 EV_FECHA_ORIGEN   IN  VARCHAR2)  RETURN NUMBER;
       
PROCEDURE GA_CONVIERTE_MONTO_PR (EN_COD_CLIENTE    IN  NUMBER,
                                 EN_MONTO_ORIGEN   IN  NUMBER,
                                 EV_FECHA_ORIGEN   IN  VARCHAR2,
                                 EN_MONTO_DESTINO  OUT NOCOPY NUMBER,
                                 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) ;
                                 
/*Inicio modificaciones JM*/
PROCEDURE GA_CARGA_CLIE_CTG_PR   (EN_ID_PROCESO            IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                                  EN_COD_CLIENTE		   IN ge_cliente_tasa_opp_to.cod_cliente%TYPE,
                                  EN_COD_CATEGORIA_CAMBIO  IN ge_cliente_tasa_opp_to.cod_categoria_cambio%TYPE,
                                  EN_NUM_LINEA_ARCHIVO     IN ge_cliente_tasa_opp_to.num_linea_archivo%TYPE,
                                  EN_COD_ESTADO            IN ge_cliente_tasa_opp_to.cod_estado%TYPE,
                                  EV_DES_ESTADO            IN ge_cliente_tasa_opp_to.des_estado%TYPE,
                                  SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                  SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                  SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento );
PROCEDURE GA_VALIDA_CLIE_CTG_PR (EN_ID_PROCESO            IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                                SN_COD_RETORNO           OUT NOCOPY   ge_errores_pg.CodError,
                                SV_MENS_RETORNO          OUT NOCOPY   ge_errores_pg.MsgError,
                                SN_NUM_EVENTO            OUT NOCOPY   ge_errores_pg.evento );                                      
                                      
PROCEDURE GA_EJECUTA_MOD_PR (EN_ID_PROCESO            IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                             SN_COD_RETORNO           OUT NOCOPY   ge_errores_pg.CodError,
                             SV_MENS_RETORNO          OUT NOCOPY   ge_errores_pg.MsgError,
                             SN_NUM_EVENTO            OUT NOCOPY   ge_errores_pg.evento );  
                             
PROCEDURE GA_BUSCAR_REGISTROS_PR(EN_ID_PROCESO   IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                                 SC_REG_CLIE_LN  OUT NOCOPY      refcursor);                                                                 
/*Fin modificaciones JM*/                                                                       
END GA_CONVERSION_MONETARIA_PG;
/
SHOW ERROR