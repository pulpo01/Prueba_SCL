CREATE OR REPLACE PACKAGE PV_CICLOS_FACTURACION_PG
IS
   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CN_IND_FACTURACION	   CONSTANT NUMBER   (01) :=  0;

-------------------------------------------------------------------------------------------
PROCEDURE PV_ELIM_GA_FINCICLO_PR(EO_CICLOS_FAC            IN          PV_CICLOS_FACTURACION_QT,
                                 SN_cod_retorno           OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                 SV_mens_retorno          OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                 SN_num_evento            OUT NOCOPY  ge_errores_pg.evento);

-------------------------------------------------------------------------------------------
PROCEDURE PV_OBTENER_FECHA_CICLO_PR (EO_FA_CICLFACT       IN OUT NOCOPY	PV_FA_CICLFACT_QT,
                                     SN_cod_retorno       OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno      OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                     SN_num_evento        OUT NOCOPY    ge_errores_pg.evento);

-------------------------------------------------------------------------------------------
function PV_VALIDAR_PERIODOFACT_FN (EO_GA_ABONADO         IN          GA_ABONADO_QT,
                                    SN_cod_retorno        OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno       OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento         OUT NOCOPY  ge_errores_pg.evento) RETURN VARCHAR2;

-------------------------------------------------------------------------------------------
PROCEDURE PV_getDiasProrrateo_PR(EV_codCiclo      IN         VARCHAR2,
                                 EV_formatoFecha  IN         VARCHAR2,
                                 SV_diasProrrateo OUT NOCOPY VARCHAR2,
                                 SV_cantDias      OUT NOCOPY VARCHAR2,
                                 SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                 SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);
-------------------------------------------------------------------------------------------

END PV_CICLOS_FACTURACION_PG;
/
SHOW ERRORS
