CREATE OR REPLACE PACKAGE ve_portabilidad_impuesto_pg AS
-----------------------------
-- DECLARACION DE CONSTANTES
-----------------------------
   cv_modulo_ga         CONSTANT VARCHAR2 (2)  := 'GA';
   cv_paramcategimpos   CONSTANT VARCHAR2 (14) := 'CATIMP_ER_DFLT';

-------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_obtenerimpuesto_clie_fn (
      en_cod_vendedor   IN   ve_vendedores.cod_vendedor%TYPE)
      RETURN NUMBER;
-------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtenerimpuesto_clie_pr(
    en_cod_vendedor       IN  ve_vendedores.cod_vendedor%TYPE,
    sn_valor_imp          OUT NOCOPY      NUMBER,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento
   );
-------------------------------------------------------------------------------------------------------------------------------
END ve_portabilidad_impuesto_pg;
/

SHOW ERRORS
