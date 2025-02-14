CREATE OR REPLACE PACKAGE ST_PROCESOS_PG AS
/******************************************************************************
   NAME:       STP_PROCESOS_PG
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2-6-2009             1. Created this package.
******************************************************************************/
TYPE RT_Obs        IS TABLE OF SP_OBSERVACIONES_ORDEN_TO%ROWTYPE;
/**********************************************************************************/
  FUNCTION ST_OPERADORA_LOCAL_FN 
  RETURN VARCHAR;

  FUNCTION  ST_CHEQUEOS_ORDEN_FN (EN_Orden IN sp_ordenes_reparacion.num_orden%type)
  RETURN VARCHAR;
  
  FUNCTION  ST_NOMBRE_REPORTE_FN (EN_CodReporte IN sp_qry_reportes.nom_reporte%type)
  RETURN VARCHAR;
  
  FUNCTION  ST_DIR_CLIENTE_FN (EV_CodSujeto IN VARCHAR2, 
                                EN_TipSujeto IN NUMBER, 
                                EN_CodTipdireccion IN  NUMBER, 
                                EN_CodDisplay IN NUMBER, 
                                EV_ValFac IN VARCHAR2 := '1' )
  RETURN VARCHAR;
  
  FUNCTION  ST_AVERIAS_ORDEN_FN (EN_Orden IN sp_ordenes_reparacion.num_orden%type)
  RETURN VARCHAR;  
  
  PROCEDURE  ST_HISTORICO_OBSERVACIONES_PR (EN_Orden IN sp_observaciones_orden_to.num_orden%type,
                                            EN_EstadoOrden IN sp_ordenes_reparacion.cod_estado_orden%type); 

END ST_PROCESOS_PG;
/
SHOW ERRORS