CREATE OR REPLACE PACKAGE GE_Auditoria_PG
IS

    CV_version	     CONSTANT  VARCHAR2(10):='1.0';
    TYPE ntNumTicket IS TABLE OF ge_cola_peticiones_to.num_ticket%TYPE INDEX BY BINARY_INTEGER;
    TYPE ntLineaComp IS TABLE OF ge_cola_peticiones_to.linea_comando%TYPE INDEX BY BINARY_INTEGER;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE GE_AgregaAuditoria_PR(neNumTransaccion IN OUT ge_auditoria_to.num_ticket%TYPE,
            veEstado         IN     ge_auditoria_to.estado_solicitud%TYPE,
            veUsuario        IN     ge_auditoria_to.usuario%TYPE,
            neNumProceso     IN     ge_auditoria_to.num_proceso%TYPE,
            veParametrosIn   IN     ge_auditoria_to.parametros_in%TYPE,
            veCodPlataforma  IN     ge_auditoria_to.cod_plataforma%TYPE,
            veCodServicio    IN     ge_auditoria_to.cod_servicio%TYPE,
            veCodTransaccion IN     ge_auditoria_to.cod_transaccion%TYPE,
            ERRORCOD         OUT NOCOPY  ge_errores_pg.coderror,
            ERRORNEG         OUT NOCOPY  ge_errores_pg.msgerror,
            NEVENTO          OUT NOCOPY  ge_errores_pg.Evento
           );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE GE_ModificaAuditoria_PR(veEtadoSolicitud IN  ge_auditoria_to.estado_solicitud%TYPE,
           neEvento         IN  ge_auditoria_to.evento%TYPE,
           neCodMsgerror    IN  ge_auditoria_to.cod_msgerror%TYPE,
           neNumTransaccion IN  ge_auditoria_to.num_ticket%TYPE,
           neNumProceso     IN  ge_auditoria_to.num_proceso%TYPE,
           neCodTransaccion IN  ge_auditoria_to.cod_transaccion%TYPE,
           ERRORCOD         OUT NOCOPY  ge_errores_pg.coderror,
           ERRORNEG         OUT NOCOPY  ge_errores_pg.msgerror,
           NEVENTO          OUT NOCOPY  ge_errores_pg.Evento
             );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE GE_ConsultaBitacora_PR(neNumTicket       IN  ge_auditoria_to.num_ticket%TYPE,
            vsEstadoSolicitud OUT NOCOPY  ge_auditoria_to.estado_solicitud%TYPE,
            dsFechaSol        OUT NOCOPY  ge_auditoria_to.fecha_solicitud%TYPE,
            dsFechaCierre     OUT NOCOPY  ge_auditoria_to.fecha_cierre_solicitud%TYPE,
            dsFechaEstado     OUT NOCOPY  ge_auditoria_to.fecha_estado%TYPE,
            vsDetError        OUT NOCOPY  ge_errores_pg.msgerror,
            ERRORCOD          OUT NOCOPY  ge_errores_pg.coderror,
            ERRORNEG          OUT NOCOPY  ge_errores_pg.msgerror,
            NEVENTO           OUT NOCOPY  ge_errores_pg.Evento
         );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE GE_ActualizarCantidadSeries_PR(neNumTicket IN  ge_auditoria_to.num_ticket%TYPE,
            ERRORCOD    OUT NOCOPY  ge_errores_pg.coderror,
            ERRORNEG    OUT NOCOPY  ge_errores_pg.msgerror,
            NEVENTO     OUT NOCOPY  ge_errores_pg.Evento
           );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    PROCEDURE GE_EjecutaProcesoEncolado_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END GE_Auditoria_PG;
/
SHOW ERRORS
