CREATE OR REPLACE
TYPE ICC_MOVIMIENTO_QT AS OBJECT (
        CARGA NUMBER(14,4),
        COD_ACTABO VARCHAR2(2),
        COD_ACTUACION NUMBER(5),
        COD_CENTRAL NUMBER(3),
        COD_CENTRAL_NUE NUMBER(3),
        COD_ENRUTAMIENTO NUMBER(4),
        COD_ESPEC_PROV VARCHAR2(10),
        COD_ESTADO NUMBER(3),
        COD_IDIOMA VARCHAR2(5),
        COD_MENSAJE NUMBER(3),
        COD_MODULO VARCHAR2(2),
        COD_PIN VARCHAR2(16),
        COD_PROD_CONTRATADO NUMBER(10),
        COD_SERVICIOS VARCHAR2(255),
        COD_SUSPREHA VARCHAR2(3),
        DES_MENSAJE VARCHAR2(512),
        DES_ORIGEN_PIN VARCHAR2(8),
        DES_RESPUESTA VARCHAR2(80),
        FEC_ACTIVACION DATE,
        FEC_EJECUCION DATE,
        FEC_EXPIRA DATE,
        FEC_INGRESO DATE,
        FEC_LECTURA DATE,
        ICC VARCHAR2(25),
        ICC_NUE VARCHAR2(25),
        IMEI VARCHAR2(20),
        IMEI_NUE VARCHAR2(20),
        IMSI VARCHAR2(15),
        IMSI_NUE VARCHAR2(15),
        IND_BAJATRANS NUMBER(2),
        IND_BLOQUEO NUMBER(1),
        NOM_USUARORA VARCHAR2(30),
        NUM_ABONADO NUMBER(8),
        NUM_CELULAR NUMBER(15),
        NUM_CELULAR_NUE NUMBER(15),
        NUM_INTENTOS NUMBER(3),
        NUM_LOTE_PIN NUMBER(9),
        NUM_MIN VARCHAR2(3),
        NUM_MIN_NUE VARCHAR2(3),
        NUM_MOVANT NUMBER(9),
        NUM_MOVIMIENTO NUMBER(9),
        NUM_MOVPOS NUMBER(9),
        NUM_MSNB VARCHAR2(12),
        NUM_MSNB_NUE VARCHAR2(12),
        NUM_PERSONAL VARCHAR2(4),
        NUM_PERSONAL_NUE VARCHAR2(4),
        NUM_SERIE VARCHAR2(25),
        NUM_SERIE_NUE VARCHAR2(25),
        NUM_SERIE_PIN VARCHAR2(16),
        PARAM1_MENS VARCHAR2(30),
        PARAM2_MENS VARCHAR2(30),
        PARAM3_MENS VARCHAR2(30),
        PIN VARCHAR2(13),
        PLAN VARCHAR2(3),
        STA CHAR(1),
        TIP_ENRUTAMIENTO NUMBER(2),
        TIP_TECNOLOGIA VARCHAR2(7),
        TIP_TERMINAL VARCHAR2(1),
        TIP_TERMINAL_NUE VARCHAR2(1),
        VALOR_PLAN NUMBER(14,4),
        -- Constructor por defecto
        CONSTRUCTOR FUNCTION ICC_MOVIMIENTO_QT RETURN SELF AS RESULT
)
/


CREATE OR REPLACE
TYPE BODY ICC_MOVIMIENTO_QT IS
        -- Constructor por defecto
        CONSTRUCTOR FUNCTION ICC_MOVIMIENTO_QT RETURN SELF AS RESULT AS
        BEGIN
                SELF.CARGA := NULL;
                SELF.COD_ACTABO := NULL;
                SELF.COD_ACTUACION := NULL;
                SELF.COD_CENTRAL := NULL;
                SELF.COD_CENTRAL_NUE := NULL;
                SELF.COD_ENRUTAMIENTO := NULL;
                SELF.COD_ESPEC_PROV := NULL;
                SELF.COD_ESTADO := NULL;
                SELF.COD_IDIOMA := NULL;
                SELF.COD_MENSAJE := NULL;
                SELF.COD_MODULO := NULL;
                SELF.COD_PIN := NULL;
                SELF.COD_PROD_CONTRATADO := NULL;
                SELF.COD_SERVICIOS := NULL;
                SELF.COD_SUSPREHA := NULL;
                SELF.DES_MENSAJE := NULL;
                SELF.DES_ORIGEN_PIN := NULL;
                SELF.DES_RESPUESTA := NULL;
                SELF.FEC_ACTIVACION := NULL;
                SELF.FEC_EJECUCION := NULL;
                SELF.FEC_EXPIRA := NULL;
                SELF.FEC_INGRESO := NULL;
                SELF.FEC_LECTURA := NULL;
                SELF.ICC := NULL;
                SELF.ICC_NUE := NULL;
                SELF.IMEI := NULL;
                SELF.IMEI_NUE := NULL;
                SELF.IMSI := NULL;
                SELF.IMSI_NUE := NULL;
                SELF.IND_BAJATRANS := NULL;
                SELF.IND_BLOQUEO := NULL;
                SELF.NOM_USUARORA := NULL;
                SELF.NUM_ABONADO := NULL;
                SELF.NUM_CELULAR := NULL;
                SELF.NUM_CELULAR_NUE := NULL;
                SELF.NUM_INTENTOS := NULL;
                SELF.NUM_LOTE_PIN := NULL;
                SELF.NUM_MIN := NULL;
                SELF.NUM_MIN_NUE := NULL;
                SELF.NUM_MOVANT := NULL;
                SELF.NUM_MOVIMIENTO := NULL;
                SELF.NUM_MOVPOS := NULL;
                SELF.NUM_MSNB := NULL;
                SELF.NUM_MSNB_NUE := NULL;
                SELF.NUM_PERSONAL := NULL;
                SELF.NUM_PERSONAL_NUE := NULL;
                SELF.NUM_SERIE := NULL;
                SELF.NUM_SERIE_NUE := NULL;
                SELF.NUM_SERIE_PIN := NULL;
                SELF.PARAM1_MENS := NULL;
                SELF.PARAM2_MENS := NULL;
                SELF.PARAM3_MENS := NULL;
                SELF.PIN := NULL;
                SELF.PLAN := NULL;
                SELF.STA := NULL;
                SELF.TIP_ENRUTAMIENTO := NULL;
                SELF.TIP_TECNOLOGIA := NULL;
                SELF.TIP_TERMINAL := NULL;
                SELF.TIP_TERMINAL_NUE := NULL;
                SELF.VALOR_PLAN := NULL;
                RETURN;
        END;
END;
/
SHOW ERRORS