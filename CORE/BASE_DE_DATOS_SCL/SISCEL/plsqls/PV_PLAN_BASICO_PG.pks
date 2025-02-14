CREATE OR REPLACE PACKAGE PV_PLAN_BASICO_PG
IS

   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (02) := 'GA';
   CV_programa               CONSTANT VARCHAR2 (03) := 'GPA';
   CV_AMI                      CONSTANT VARCHAR2 (03) := 'AMI';
   CV_perfil_proceso        CONSTANT VARCHAR2 (16) := 'COD_PROC_NOCOMER';
   CV_version              CONSTANT VARCHAR2 (02) := '1';
   CN_cero                   CONSTANT NUMBER        := 0;
   CN_uno                   CONSTANT NUMBER        := 1;
   CN_producto               CONSTANT NUMBER        := 1;
   CN_tip_relacion           CONSTANT NUMBER   (01) := 3;
   CN_ind_estado           CONSTANT NUMBER   (01) := 3;
   CN_hibrido               CONSTANT NUMBER   (01) := 3;
   CN_pospago               CONSTANT NUMBER   (01) := 2;
   CN_prepago               CONSTANT NUMBER   (01) := 1;
   CN_cod_nivel               CONSTANT NUMBER   (01) := 0;

----------------------------------------------------------------------------------------------------------
--1.- Metodo : RegistroHistoricoPlan (FE)
    PROCEDURE PV_REGISTRO_HIST_PLAN_PR (EO_FA_CICLFACT        IN               PV_FA_CICLFACT_QT,
                                        SN_cod_retorno       OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                        SV_mens_retorno      OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                        SN_num_evento       OUT NOCOPY     ge_errores_pg.evento);

----------------------------------------------------------------------------------------------------------
--3.- Metodo obtenerPlanesTarifarios(TipoPlanDestino) (Reg)   (PL-Nuevo)
      PROCEDURE PV_OBTIENE_PLANES_PR (EO_PlanesTarifarios      IN              PV_PLANES_TARIFARIOS_QT,
                                        SO_Planes_Prepago        OUT  NOCOPY     refCursor,
                                        SO_Planes_Pospago        OUT  NOCOPY     refCursor,
                                        SO_Planes_Hibrido        OUT  NOCOPY     refCursor,
                                        SO_Planes_Pospago_Rango  OUT  NOCOPY     refCursor,
                                        SN_cod_retorno           OUT  NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                        SV_mens_retorno          OUT  NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                        SN_num_evento            OUT  NOCOPY     ge_errores_pg.evento);
----------------------------------------------------------------------------------------------------------
--9.- Metodo obtenerPlanesTarifarios(TipoPlanDestino) (Reg)   (PL-Nuevo)
      PROCEDURE PV_OBTIENE_PLANES_PR (EO_PlanesTarifarios      IN              PV_PLANES_TARIFARIOS_QT,
                                      EV_Cod_Califica        IN              pv_calificacion_td.COD_CALIFICA%TYPE,
                                        SO_Planes_Prepago        OUT  NOCOPY     refCursor,
                                        SO_Planes_Pospago        OUT  NOCOPY     refCursor,
                                        SO_Planes_Hibrido        OUT  NOCOPY     refCursor,
                                        SO_Planes_Pospago_Rango  OUT  NOCOPY     refCursor,
                                        SN_cod_retorno           OUT  NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                        SV_mens_retorno          OUT  NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                        SN_num_evento            OUT  NOCOPY     ge_errores_pg.evento);                                        

----------------------------------------------------------------------------------------------------------
--4.- pv_plan_freedom_pk.pv_verifica_plan_freedom_fn del metodo validaFreedom (Reg)
    PROCEDURE PV_VALIDA_FREEDOM_PR(EO_CLIENTE                IN OUT NOCOPY              PV_CLIENTE_QT,
                                   SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento            OUT NOCOPY         ge_errores_pg.evento);

---------------------------------------------------------------------------------------------------------
--5.- Metodo obtenerServiciosDefaultPlan  (Pl-Nueva)
    PROCEDURE PV_OBTENE_SERVDEFAULT_PLAN_PR (EO_SERVDEFAULT_PLAN   IN              PV_SERVDEFAULT_PLAN_QT,
                                                SC_CurDesact          OUT NOCOPY    refCursor,
                                             SC_CurActi            OUT NOCOPY    refCursor,
                                             SN_cod_retorno        OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                             SV_mens_retorno       OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                             SN_num_evento         OUT NOCOPY    ge_errores_pg.evento);

----------------------------------------------------------------------------------------------------------
--6.- Método obtenerCicloFreedom     PL     PV_OBT_CICLO_FREEDOM_PRasoc_PR
    PROCEDURE PV_OBTENER_CICLO_FREEDOM_PR (SO_GA_ABONADO   IN OUT NOCOPY      GA_ABONADO_QT,
                                              SN_cod_retorno     OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                              SV_mens_retorno    OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                              SN_num_evento      OUT NOCOPY      ge_errores_pg.evento);



----------------------------------------------------------------------------------------------------------
--7- Metodo obtenerCatehPlan(Plan)   (PL-Nuevo)
      PROCEDURE PV_OBTENER_CATEG_PLAN_PR (EO_PlanesTarifarios      IN  OUT  NOCOPY     PV_PLANES_TARIFARIOS_QT,
                                        SN_cod_retorno           OUT  NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                        SV_mens_retorno          OUT  NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                        SN_num_evento            OUT  NOCOPY     ge_errores_pg.evento);

----------------------------------------------------------------------------------------------------------
--8- Metodo obtenerPlanComercial(Cliente)
      PROCEDURE PV_OBTENER_PLAN_COMERCIAL_PR (SO_CLIENTE               IN  OUT  NOCOPY     PV_CLIENTE_QT,
                                        SN_cod_retorno           OUT  NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                        SV_mens_retorno          OUT  NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                        SN_num_evento            OUT  NOCOPY     ge_errores_pg.evento);

----------------------------------------------------------------------------------------------------------
--(2).- Metodo  :  AnulaCargoBolsaDinamica
    PROCEDURE PV_ANU_CARGO_BOLSDINAMICA_PR(
      EO_BOLSAS_DINAMICAS  IN OUT             PV_BOLSAS_DINAMICAS_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY        ge_errores_pg.evento);

----------------------------------------------------------------------------------------------------------
--Metodo :  obtenerPlanTarifario(plan)
    PROCEDURE PV_OBTIENE_PLANTARIF_PR(
      EO_PLANTARIF               IN OUT                PV_PLANTARIF_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY        ge_errores_pg.evento);

END PV_PLAN_BASICO_PG; 
/
SHOW ERRORS
