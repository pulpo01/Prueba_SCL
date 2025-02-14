CREATE OR REPLACE PACKAGE er_integracion_impuesto_pg
AS
-----------------------------
-- DECLARACION DE CONSTANTES
-----------------------------
   cv_modulo_ga         CONSTANT VARCHAR2 (2)  := 'GA';
   cv_paramcategimpos   CONSTANT VARCHAR2 (14) := 'CATIMP_ER_DFLT';

-------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_obtenerimpuesto_num_fn (
      ev_tipident     IN ge_clientes.cod_tipident%TYPE,
      ev_numident     IN ge_clientes.num_ident%TYPE,
	  en_cod_vendedor IN  ve_vendedores.cod_vendedor%TYPE
   ) RETURN NUMBER;

-------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_obtenerimpuesto_clie_fn (
      en_cod_cliente IN ge_clientes.cod_cliente%TYPE,
	  en_cod_vendedor IN  ve_vendedores.cod_vendedor%TYPE
   ) RETURN NUMBER;
-------------------------------------------------------------------------------------------------------------------------------
END er_integracion_impuesto_pg;
/
SHOW ERRORS
