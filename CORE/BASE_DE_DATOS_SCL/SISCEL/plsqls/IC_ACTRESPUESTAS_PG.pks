CREATE OR REPLACE PACKAGE ic_actrespuestas_pg IS

PROCEDURE ic_principal_pr(p_n_producto IN NUMBER, p_r_cmov icc_movimiento%ROWTYPE);

FUNCTION ic_nuevomodulo_fn (p_v_producto IN NUMBER,p_v_actabo IN VARCHAR2,p_v_modulo IN VARCHAR2,p_v_tecnologia IN VARCHAR2) RETURN BOOLEAN;

FUNCTION pv_retorna_version_fn RETURN VARCHAR2;

v_n_num_evento NUMBER(9) := -1;

END IC_ACTRESPUESTAS_PG;
/
SHOW ERRORS