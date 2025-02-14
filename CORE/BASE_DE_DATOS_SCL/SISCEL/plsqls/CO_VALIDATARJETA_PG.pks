CREATE OR REPLACE PACKAGE Co_Validatarjeta_Pg IS

FUNCTION CO_RETORNA_VERSION_GENERAL_FN RETURN VARCHAR2;

FUNCTION Co_Validatarjeta_Fn (
	EV_cod_tarjeta     IN VARCHAR2,
	EV_num_tarjeta     IN VARCHAR2
) RETURN VARCHAR2;

FUNCTION Co_Validalargo_Fn (
	EV_cod_tarjeta    IN   VARCHAR2,
	EV_num_tarjeta    IN   VARCHAR2
) RETURN VARCHAR2;

FUNCTION Co_Validaprefijo_Fn (
	EV_cod_tarjeta    IN   VARCHAR2,
	EV_num_tarjeta    IN   VARCHAR2
)RETURN VARCHAR2;

FUNCTION Co_ValidaBin_Fn (
	EV_cod_tarjeta    IN   VARCHAR2,
	EV_num_tarjeta    IN   VARCHAR2
)RETURN VARCHAR2;

END Co_Validatarjeta_Pg;
/
SHOW ERRORS
