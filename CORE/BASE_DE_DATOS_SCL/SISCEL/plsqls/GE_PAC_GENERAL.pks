CREATE OR REPLACE PACKAGE        GE_PAC_GENERAL IS
FUNCTION PARAM_GENERAL(NOMPARAMETRO IN  GED_PARAMETROS.NOM_PARAMETRO%type) RETURN GED_PARAMETROS.VAL_PARAMETRO%type;
FUNCTION REDONDEA(VP_ORIGINAL IN NUMBER, VP_PRECISION IN NUMBER ,VP_USO IN NUMBER) RETURN NUMBER;
PRAGMA RESTRICT_REFERENCES (PARAM_GENERAL, WNDS);
PRAGMA RESTRICT_REFERENCES (REDONDEA, WNDS);
END GE_PAC_GENERAL;
/
SHOW ERRORS
