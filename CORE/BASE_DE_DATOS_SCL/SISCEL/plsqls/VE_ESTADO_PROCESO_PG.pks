CREATE OR REPLACE PACKAGE VE_estado_proceso_PG IS
/*
<Documentación TipoDoc = "PACKAGE"
 <Elemento Nombre = "VE_PROGRESO_PROCESO_PG"
           Lenguaje="PL/SQL"
           Fecha="08-01-2007"
           Versión="1.0"
           Diseñador="Héctor Hermosilla Blanco"
           Programador="Héctor Hermosilla Blanco"
           Ambiente="DEIMOS_ECU">
  <Retorno>NA</Retorno>
   <Descripción> Encabezado de VE_PROGRESO_PROCESO_PG</Descripción>>
    <Parámetros>
    </Parámetros>
 </Elemento>
</Documentación>
*/

  CV_cod_producto     CONSTANT VARCHAR2(1)  := '1';
  CV_error_no_clasif  CONSTANT VARCHAR2(30) := 'Error no clasificado';
  CV_codmodulo        CONSTANT VARCHAR2(2)  := 'GA';
  TYPE refcursor          IS REF CURSOR;

  PROCEDURE VE_recuperaprogreso_PR(EV_cod_proceso       IN ve_estadoproceso_to.cod_proceso%TYPE,
                                   SN_num_progactual    OUT NOCOPY ve_estadoproceso_to.num_progresoactual%TYPE,
                                   SN_num_subprocactual OUT NOCOPY ve_estadoproceso_to.num_subprocactual%TYPE,
                                   SN_num_totalsubproc  OUT NOCOPY ve_estadoproceso_to.num_totalsubproc%TYPE,
                                   SN_cod_error         OUT NOCOPY ve_estadoproceso_to.cod_error%TYPE,
                                   SV_des_error         OUT NOCOPY ve_estadoproceso_to.des_error%TYPE,
                                                               SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento        OUT NOCOPY ge_errores_pg.Evento
  );

  PROCEDURE VE_insertaproceso_PR(EV_cod_proceso       IN ve_estadoproceso_to.cod_proceso%TYPE,
                                 EN_num_progactual    IN ve_estadoproceso_to.num_progresoactual%TYPE,
                                 EN_num_subprocactual IN ve_estadoproceso_to.num_subprocactual%TYPE,
                                 EN_num_totalsubproc  IN ve_estadoproceso_to.num_totalsubproc%TYPE,
                                                             SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento        OUT NOCOPY ge_errores_pg.Evento
  );
  PROCEDURE VE_modificaproceso_PR(EV_cod_proceso       IN ve_estadoproceso_to.cod_proceso%TYPE,
                                  EN_num_progactual    IN ve_estadoproceso_to.num_progresoactual%TYPE,
                                  EN_num_subprocactual IN ve_estadoproceso_to.num_subprocactual%TYPE,
                                  EN_num_totalsubproc  IN ve_estadoproceso_to.num_totalsubproc%TYPE,
                                                                  EN_cod_error         IN ve_estadoproceso_to.cod_error%TYPE,
                                                                  EV_des_error         IN ve_estadoproceso_to.des_error%TYPE,
                                                              SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento        OUT NOCOPY ge_errores_pg.Evento
  );

  PROCEDURE VE_EliminaProceso_PR(EV_cod_proceso       IN  ve_estadoproceso_to.cod_proceso%TYPE,
                                     SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);
END VE_estado_proceso_PG;


/
SHOW ERRORS
