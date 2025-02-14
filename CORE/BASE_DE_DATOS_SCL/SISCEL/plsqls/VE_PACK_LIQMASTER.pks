CREATE OR REPLACE PACKAGE VE_PACK_LIQMASTER IS
  --
  -- Retrofitted
  PROCEDURE ve_p_liqmaster_ppal(
  vp_liquidacion IN NUMBER ,
  vp_ctoliq IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_vendedor IN NUMBER ,
  vp_catcomis IN NUMBER ,
  vp_tipcomis IN VARCHAR2 ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE )
;
  --
  -- Retrofitted
  PROCEDURE ve_p_getmonhab(
  vp_liquidacion IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_tothabilit IN NUMBER ,
  vp_rango IN OUT NUMBER ,
  vp_sqlcode IN OUT VARCHAR2 ,
  vp_sqlerrm IN OUT VARCHAR2 )
;
  --
  -- Retrofitted
  PROCEDURE ve_p_getnumhab(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_numtothab IN OUT NUMBER ,
  vp_sqlcode IN OUT VARCHAR2 ,
  vp_sqlerrm IN OUT VARCHAR2 )
;
  --
  -- Retrofitted
  PROCEDURE ve_p_getnumbajhab(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_totbajas IN OUT NUMBER )
;
  --
  -- Retrofitted
  PROCEDURE ve_p_getplantarif(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_TotPlan OUT NUMBER )
;
  --
  -- Retrofitted
  PROCEDURE ve_p_getbonovol(
  vp_liquidacion IN NUMBER ,
  vp_ventasnetas IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_rango IN OUT NUMBER )
;
  --
  -- Retrofitted
  PROCEDURE ve_p_getpremios(
  vp_liquidacion IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_cumplimiento IN NUMBER ,
  vp_rango IN OUT NUMBER )
;
  --
  -- Retrofitted
  PROCEDURE ve_p_getmetaven(
  vp_liquidacion IN NUMBER ,
  vp_ctoliq IN NUMBER ,
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_fecfinliq IN DATE ,
  vp_meta IN OUT VE_METAVEND.NUM_META%TYPE ,
  vp_sqlcode IN OUT VARCHAR2 ,
  vp_sqlerrm IN OUT VARCHAR2 )
;
  --
  -- Retrofitted
  PROCEDURE ve_p_getsubsidios(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_totsubsidio IN OUT NUMBER )
;
  --
  -- Retrofitted
  PROCEDURE ve_p_getcambiosplan(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_ctoliq IN NUMBER ,
  vp_impcom IN OUT NUMBER )
;
  --
  -- Retrofitted
  PROCEDURE ve_p_getrenuncias(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_ctoliq IN NUMBER ,
  vp_tipcomis IN VARCHAR2 ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_totrenuncias IN OUT NUMBER )
;
  --
  -- Retrofitted
  PROCEDURE ve_p_bholding(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_totbono IN OUT NUMBER )
;
  --
  -- Retrofitted
  PROCEDURE ve_p_bresidual(
  vp_liquidacion IN NUMBER ,
  vp_vendedor IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_producto IN NUMBER ,
  vp_totbon IN OUT NUMBER ,
  vp_sqlcode IN OUT VARCHAR2 ,
  vp_sqlerrm IN OUT VARCHAR2 )
;
 EXCEPTION_ERROR exception;
--------------------------------------------------------
--Obtiene el nzmero de habilitaciones
--Obtiene el monto del cuadrante de habilitaciones
-- Calcula las bajas
-- Obtiene el importe del plan tarifario
-- Obtiene el bono por volumen
-- Obtiene los premios
-- Obtiene la meta para calcular cumplimiento en premios
-- Obtiene los subsidios
-- Obtiene el importe de los cambios de plan tarifarios
-- Obtiene las renuncias de un vendedor
-- Obtiene el bono holding
-- Obtiene el bono residual
END VE_PACK_LIQMASTER;
/
SHOW ERRORS
