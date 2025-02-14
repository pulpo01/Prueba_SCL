CREATE OR REPLACE PACKAGE PV_PLAN_TARIF_CTASEG_CICLO_PG
    IS
    CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
    CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
    CV_version              CONSTANT VARCHAR2 (2)  := '1';

--------------------------------------------------------------------------------------
    PROCEDURE PV_PLAN_TARIF_CTASEG_CICLO_PR  (
      EV_PRODUCTO    IN NUMBER  ,
      EV_CLIENTE     IN NUMBER  ,
      EV_ABONADO     IN NUMBER  ,
      EV_TIPPLAN     IN VARCHAR2,
      EV_PLANTARIF   IN VARCHAR2,
      EV_CICLO       IN NUMBER  ,
      EV_FECSYS      IN DATE    ,
      EV_EMPRESA     IN NUMBER  ,
      EV_HOLDING     IN NUMBER  ,
      EV_TIPPLANTANT IN VARCHAR2,
      EV_GRUPO       IN NUMBER  ,
      SV_PROC        IN OUT NOCOPY VARCHAR2,
      SV_TABLA       IN OUT NOCOPY VARCHAR2,
      SV_ACT         IN OUT NOCOPY VARCHAR2,
      SV_SQLCODE     IN OUT NOCOPY VARCHAR2,
      SV_SQLERRM     IN OUT NOCOPY VARCHAR2,
      SV_ERROR       IN OUT NOCOPY VARCHAR2
      , EV_ACTABO    IN VARCHAR2 DEFAULT NULL -- COL|77090|30-01-2009|SAQL
      );

--------------------------------------------------------------------------------------
end PV_PLAN_TARIF_CTASEG_CICLO_PG ;
/
SHOW ERRORS
