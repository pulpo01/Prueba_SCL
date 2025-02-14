CREATE OR REPLACE PROCEDURE        VE_P_VENTASREAL(
  vp_Vendedor IN NUMBER ,
  vp_CatComis IN NUMBER ,
  vp_Producto IN NUMBER ,
  vp_FecIniLiq IN DATE ,
  vp_FecFinLiq IN DATE ,
  vp_TotHabVen OUT NUMBER ,
  vp_Error IN VARCHAR2 )
IS
v_TotHabilitaciones NUMBER := 0;
BEGIN
v_TotHabilitaciones := 0;
-- Habilitaciones para un Agente de Sucursal o Master Dealer
IF vp_CatComis = 4 or vp_CatComis = 1 THEN
 SELECT COUNT(*)
 INTO  v_TotHabilitaciones
 FROM VE_VENTALIN
 WHERE COD_VENDE_RAIZ = vp_Vendedor
 AND COD_PRODUCTO = vp_Producto
 AND IND_OPERACION = 'V'
 AND FEC_ACEPTVENTA BETWEEN vp_FecIniLiq AND vp_FecFinLiq;
ELSE
-- para el resto de tipos de vendedores
 SELECT COUNT(*)
 INTO  v_TotHabilitaciones
 FROM VE_VENTALIN
 WHERE COD_VENDEDOR = vp_Vendedor
 AND COD_PRODUCTO = vp_Producto
 AND IND_OPERACION = 'V'
 AND FEC_ACEPTVENTA BETWEEN vp_FecIniLiq AND vp_FecFinLiq;
END IF;
vp_TotHabVen := v_TotHabilitaciones;
END;
/
SHOW ERRORS
