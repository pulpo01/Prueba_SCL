CREATE OR REPLACE PACKAGE BODY PV_MASCARA_NUM_PERSONAL_PG AS

PROCEDURE PV_MASCARA_ACTUALIZA_NUMCEL_PR(
          EV_NUM_CELULAR_PER   IN VARCHAR2,
	      EV_NUM_CELULAR_COR   IN VARCHAR2,
	      EV_ACTABO            IN VARCHAR2)
IS


BEGIN

GA_NUMCEL_PERSONAL_PG.GA_ACTLZA_NUMCEL_PERSONAL_PR(EV_NUM_CELULAR_PER,EV_NUM_CELULAR_COR,EV_ACTABO);

END PV_MASCARA_ACTUALIZA_NUMCEL_PR;
END PV_MASCARA_NUM_PERSONAL_PG;
/
SHOW ERRORS
