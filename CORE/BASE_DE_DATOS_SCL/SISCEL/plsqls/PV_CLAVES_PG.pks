CREATE OR REPLACE PACKAGE PV_CLAVES_PG IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : PV_CLAVES_PG
-- * Descripcion        : Procedimientos Almacenados para procesar temas de Cambio de Clave
-- * Fecha de creacion  : 13-01-2003 20:45
-- * Responsable        : Area Postventa
-- *************************************************************

        PROCEDURE PV_MODCLAVE_PR (
                nTIP_CLAVE      IN  NUMBER,
                vCLAVE          IN  VARCHAR2,
                vSUJETO         IN  VARCHAR2,
                nTIP_SUJETO     IN  VARCHAR2,
                nIND_DEFAULT    IN  VARCHAR2,
                nTABLA                  IN  VARCHAR2,
                nCOD_ACTABO     IN  VARCHAR2,
                ERROR_APLIC             out VARCHAR2,
                ERROR_GLOSA     out VARCHAR2, -- CODIGO ERROR DEL ALGORITMO
            ERROR_ORA       out VARCHAR2, -- GLOSA ASOCIADA AL ERROR DEL ALGORITMO
                ERROR_ORA_GLOSA out VARCHAR2,
            TRACE           out VARCHAR2
                );

        PROCEDURE PV_VAL_SERVICIOS_CLAVE_PR (
            vNUM_ABONADO    IN  VARCHAR2,
                vCOD_ACTABO     IN  VARCHAR2,
                ERROR_APLIC             out VARCHAR2,
                ERROR_GLOSA     out VARCHAR2, -- CODIGO ERROR DEL ALGORITMO
            ERROR_ORA       out VARCHAR2, -- GLOSA ASOCIADA AL ERROR DEL ALGORITMO
                ERROR_ORA_GLOSA out VARCHAR2,
            TRACE           out VARCHAR2
            );


        PROCEDURE PV_ICC_MOV_PR (
                nNUM_ABONADO    IN  NUMBER,
                vTEC_ABONADO    IN  VARCHAR2, -- TECNOLOGIA ABONADO_
                nTABLA                  IN  VARCHAR2,
                nCOD_ACTABO     IN  VARCHAR2,
                nCADENA                 IN  NUMBER,   --CONFIRMAR EL LARGO
                ERROR_APLIC             out VARCHAR2,
                ERROR_GLOSA     out VARCHAR2,
                ERROR_ORA       out VARCHAR2,
                ERROR_ORA_GLOSA out VARCHAR2,
                TRACE           out VARCHAR2
                        );

        PROCEDURE PV_AD_SS_CLAVE_PR(
                   nNUM_ABONADO                 IN NUMBER,                                                              -- Numero del abonado
                   vCADENANUEV                  IN GA_ABOCEL.CLASE_SERVICIO%TYPE,               -- Cadena del servicio a agregar
                   vCOD_SERVICIONUEV    IN GA_SERVSUPLABO.COD_SERVICIO%TYPE,    -- Nuevo Codigo de servicio
                   vACTUACION                   IN VARCHAR2,                                                    -- Codigo de Actuacion
                   nCOD_ERROR                   OUT NUMBER,                                                             -- Codigo de Error
                   sMEN_ERROR                   OUT VARCHAR2                                                    -- Mensaje de Error
                   );


END PV_CLAVES_PG;
/
SHOW ERRORS
