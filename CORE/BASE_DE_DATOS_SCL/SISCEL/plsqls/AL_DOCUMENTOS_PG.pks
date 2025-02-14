CREATE OR REPLACE PACKAGE AL_DOCUMENTOS_PG
IS
   CV_nom_param   CONSTANT VARCHAR2 (20) := 'PREFIJO_DOCUMENTO';
   CV_par1        CONSTANT VARCHAR2 (20) := 'DO/OF'; -- TMM-> Estructura parametro Tipo documento Abrevido / Oficina
   CV_par2        CONSTANT VARCHAR2 (20) := 'DO';    -- COL-> Estructura parametro Oficina
   CV_par3        CONSTANT VARCHAR2 (20) := 'MT/OF'; -- ECU-> Estructura parametro Matriz / Oficina  / Tipo documento Abrevido
   CV_par4        CONSTANT VARCHAR2 (20) := 'OF';    -- TMC-> Estructura parametro Oficina
   CN_uno         CONSTANT PLS_INTEGER := 1;
   CV_par5        CONSTANT VARCHAR2 (20) := 'DOC/SE';    -- TMG-> Estructura parametro Documento / Serie
   CV_par6        CONSTANT VARCHAR2 (20) := 'DOC/SE/ET';    -- TMS-> Estructura parametro Documento / Serie /Etiqueta
   FUNCTION AL_PREF_DOCUMOFIC_FN (
      EV_cod_oficina    IN   ge_oficinas.cod_oficina%TYPE,
      EN_cod_tipdocum   IN   ge_tipdocumen.cod_tipdocum%TYPE,
      EN_num_solfolios  IN   number default 0 ) --p-mix-09003
      RETURN VARCHAR2;
END AL_DOCUMENTOS_PG; 
/
SHOW ERRORS
