CREATE OR REPLACE PACKAGE ve_ctrl_lineas_prepago_pg
IS
FUNCTION ve_busca_rol_fn(EV_nom_usuario VARCHAR2) RETURN NUMBER;
FUNCTION ve_supera_limite_fn(EN_cod_cliente NUMBER,EV_cod_tipident VARCHAR2,EV_num_ident VARCHAR2,EN_cod_cuenta NUMBER)  RETURN VARCHAR2;
FUNCTION ve_supera_limite2_fn(EN_cod_cliente NUMBER,EV_cod_tipident VARCHAR2,EV_num_ident VARCHAR2,EN_cod_cuenta NUMBER)  RETURN VARCHAR2;
PROCEDURE ve_registra_excepcion_vta_pr(EN_numtransa IN NUMBER,EN_num_venta IN NUMBER,EN_cod_causa IN NUMBER);
END ve_ctrl_lineas_prepago_pg;
/
SHOW ERRORS
