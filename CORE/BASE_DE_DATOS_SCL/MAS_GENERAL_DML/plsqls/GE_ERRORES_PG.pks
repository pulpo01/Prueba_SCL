CREATE OR REPLACE PACKAGE ge_errores_pg
AS
    SUBTYPE coderror IS ge_errores_td.cod_msgerror%TYPE;
    SUBTYPE msgerror IS ge_errores_td.det_msgerror%TYPE;
    SUBTYPE evento IS ge_evento_detalle_to.evento%TYPE;
    SUBTYPE desevent IS ge_evento_detalle_to.descripcion_error%TYPE;
    SUBTYPE vquery IS ge_evento_detalle_to.QUERY%TYPE;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION grabar (
        nevento         IN    NUMBER, --Secuencia de evento
        vcodprograma    IN    VARCHAR2, --Codigo de Programa
        vdescripcion    IN    VARCHAR2, --Descripciæn del Error o Evento
        vverprograma    IN    VARCHAR2, --Version de la aplicacion
        vnomusuario     IN    VARCHAR2, --Nombre de Usuario
        vnumproceso     IN    VARCHAR2, --Numero de proceso Oracle
        vmaquina        IN    VARCHAR2, --Nombre de la mﬂquina del usuario (PC)
        vservicio       IN    VARCHAR2, --Nombre o cædigo de servicio
        vquery          IN    VARCHAR2, --Query
        vcoderror       IN    VARCHAR2, --Codigo de Error Oracle
        vdeserror       IN    VARCHAR2 --Descripciæn del Error Oracle
    )
        RETURN NUMBER;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

    FUNCTION grabarpl (
        nevento         IN    NUMBER, --Secuencia de evento
        vcodprograma    IN    VARCHAR2, --Codigo de Programa
        vdescripcion    IN    VARCHAR2, --Descripciæn del Error o Evento
        vverprograma    IN    VARCHAR2, --Version de la aplicacion
        vnomusuario     IN    VARCHAR2, --Nombre de Usuario
        nompgpl         IN    VARCHAR2, --Nombre PL o PG
        vquery          IN    VARCHAR2, --Ruta de Ejecucio, Query
        vcoderror       IN    VARCHAR2, --Codigo de Error Oracle
        vdeserror       IN    VARCHAR2 --Descripciæn del Error Oracle
    )
        RETURN NUMBER;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION mensajeerror (
        necodmsgerror    IN OUT NOCOPY    NUMBER,
        vsdetmsgerror    OUT NOCOPY       VARCHAR2
    )
        RETURN BOOLEAN;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ge_errores_pg;
/
SHOW ERRORS
