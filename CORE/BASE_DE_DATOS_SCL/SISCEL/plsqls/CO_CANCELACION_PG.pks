CREATE OR REPLACE PACKAGE Co_Cancelacion_Pg
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : CO_CANCELACION_PG
-- * Descripci¢n        : Procedimientos Almacenados de Cancelaci¢n de Cr?ditos
-- * Fecha de creaci¢n  : 20-12-2004
-- * Responsable        : Area Cobranza
-- *************************************************************

   gn_i              NUMBER (6);
   gn_j              NUMBER (6);
   gn_k              NUMBER (6);
   gn_iniciocargos   NUMBER (6) := 1; --Para registrar desde qu? cargo no est  cancelado
   gb_salir          BOOLEAN    := FALSE;
   gn_numabonos      NUMBER (6);
   gn_numcargos      NUMBER (6);
   gn_numdecimal     NUMBER (1) := 0;
   error_exception   EXCEPTION;
   /* XO-200509070609 : Inicio : Responsable cambio : mfqg : fecha:16.09.2005 */
   /*                   Desc   :  Declaracion de variables globales */
   gd_feccancelacion DATE;
   gn_numtransaccion NUMBER (9);
   /* XO-200509070609 Fin   */


/* Estructura de Tabla a Utilizar para los totales x documento */
   TYPE gv_cobranza IS RECORD (
      num_secuenci   CO_CARTERA.num_secuenci%TYPE,
      monto          CO_CARTERA.importe_debe%TYPE
   );

-- declaracion de tabla PL/SQL
   TYPE tab_matriz IS TABLE OF gv_cobranza
      INDEX BY BINARY_INTEGER;

-- declaracion de matriz como variable del tipo tabla de registros tipo lv_cobranza
   gv_totdocumento   tab_matriz;

   PROCEDURE co_insertar_errores_pr (
      en_numtransaccion   IN   NUMBER,
      en_retorno          IN   NUMBER,
      ev_glosa            IN   VARCHAR2
   );

   PROCEDURE co_actualizacartera_pr (
      en_concepto         IN       co_cartera_qt,
      en_numtransaccion   IN             NUMBER,
      sn_retorno          OUT  NOCOPY    NUMBER,
      sv_glosa            OUT  NOCOPY    VARCHAR2
   );

   PROCEDURE co_cancelacarrier_pr (
      en_codcliente       IN             NUMBER,
      en_numtransaccion   IN             NUMBER,
      ev_tipcancelacion   IN             VARCHAR2 DEFAULT NULL,
      sn_retorno          OUT  NOCOPY    NUMBER,
      sv_glosa            OUT  NOCOPY    VARCHAR2
   );

   PROCEDURE co_cancelacreditos_pr (
      en_codcliente         IN       NUMBER,
      ed_feccancelacion     IN       DATE,
      en_numtransaccion     IN       NUMBER,
      en_indcarrier         IN OUT NOCOPY  NUMBER,
      en_estructuraabonos   IN             co_carteraconc_qt DEFAULT NULL,
      en_estructuracargos   IN             co_carteraconc_qt DEFAULT NULL,
      ev_tipcancelacion     IN             VARCHAR2 DEFAULT NULL,
      sn_retorno            OUT NOCOPY     NUMBER,
      sv_glosa              OUT NOCOPY     VARCHAR2
   );

/*  LOS SIGUIENTES PROCEDIMIENTOS ESTABAN EN EL BODY, PERO NO DEFINIDOS */
   PROCEDURE co_obtieneabonos_pr (
      en_codcliente       IN             NUMBER,
      sn_retorno          OUT NOCOPY     NUMBER,
      sv_glosa            IN OUT NOCOPY  VARCHAR2,
      se_abonos           IN OUT NOCOPY  co_carteraconc_qt,
      en_numtransaccion   IN             NUMBER
   );

   PROCEDURE co_obtienecargos_pr (
      en_codcliente       IN             NUMBER,
      sn_retorno          OUT  NOCOPY    NUMBER,
      ev_tipcancelacion   IN             VARCHAR2 DEFAULT NULL,
      sv_glosa            OUT  NOCOPY    VARCHAR2,
      se_cargos           IN OUT   NOCOPY co_carteraconc_qt,
      en_numtransaccion   IN              NUMBER
   );

   PROCEDURE co_cancelaconcepto_pr (
      en_estructuracargo   IN             co_cartera_qt,
      ed_feccancelacion    IN             DATE,
      en_numtransaccion    IN             NUMBER,
      sn_retorno           OUT  NOCOPY    NUMBER,
      sv_glosa             OUT  NOCOPY    VARCHAR2
   );

   PROCEDURE co_registrarelconcep_pr (
      en_estructuraabono   IN             co_cartera_qt,
      en_estructuracargo   IN             co_cartera_qt,
      en_numtransaccion    IN             NUMBER,
      sn_retorno           OUT  NOCOPY    NUMBER,
      sv_glosa             OUT  NOCOPY    VARCHAR2
   );

   PROCEDURE co_cancelacartera_pr (
      en_codcliente         IN       		NUMBER,
      ed_feccancelacion     IN       		DATE,
      en_numtransaccion     IN       		NUMBER,
      en_indcarrier         IN OUT   NOCOPY NUMBER,
      en_estructuraabonos   IN       		co_carteraconc_qt DEFAULT NULL,
      en_estructuracargos   IN       		co_carteraconc_qt DEFAULT NULL,
      ev_tipcancelacion     IN       		VARCHAR2 DEFAULT NULL,
      sn_retorno            OUT      NOCOPY NUMBER,
      sv_glosa              OUT      NOCOPY VARCHAR2
   );

/* LOS SIGUIENTES PROCEDIMIENTOS SE CREARON CON EL CAMBIO SOLICITADO */
   PROCEDURE co_sumaabonos_pr (
      en_estructuraabonos   IN              co_carteraconc_qt DEFAULT NULL,
      sn_totabono           OUT NOCOPY      NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   );

   PROCEDURE co_generatotalcargos_pr (
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_numtransaccion     IN              NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   );

   PROCEDURE co_ordenacargos_pr (
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_numtransaccion     IN              NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   );

   PROCEDURE co_cancela_total_pr (
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_estructuraabonos   IN OUT NOCOPY   co_carteraconc_qt,
      en_num_secuenci       IN              NUMBER,
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   );

   PROCEDURE co_cancela_parcial_100_pr (
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_estructuraabonos   IN OUT NOCOPY   co_carteraconc_qt,
      en_num_secuenci       IN              NUMBER,
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
      sn_ultreg             OUT NOCOPY      NUMBER,
      sn_sumadeuda          OUT NOCOPY      NUMBER,
      sn_resto              OUT NOCOPY      NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   );

   PROCEDURE co_cancela_parcial_resto_pr (
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_estructuraabonos   IN OUT NOCOPY   co_carteraconc_qt,
      en_num_secuenci       IN              NUMBER,
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
      en_ultreg             IN              NUMBER,
      en_sumadeuda          IN              NUMBER,
      en_resto              IN              NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   );

------------------------------------------------------------------------------------
   /*  Nuevo para pasocobros_ciclo  */
   PROCEDURE co_actualizacartera_pr (
      en_concepto         IN              co_cartera_qt,
      en_numtransaccion   IN              NUMBER,
	  en_decimales        IN NUMBER,
	  ed_feccancelacion     IN              DATE,
      sn_retorno          OUT NOCOPY      NUMBER,
      sv_glosa            OUT NOCOPY      VARCHAR2
   );

   /*  Nuevo para pasocobros_ciclo  */
   PROCEDURE co_cancelacarrier_pr (
      en_codcliente       IN             NUMBER,
      en_numtransaccion   IN             NUMBER,
	  en_decimales        IN             NUMBER,
      ev_tipcancelacion   IN             VARCHAR2 DEFAULT NULL,
      sn_retorno          OUT  NOCOPY    NUMBER,
      sv_glosa            OUT  NOCOPY    VARCHAR2
   );

   /*  Nuevo para pasocobros_ciclo  */
   PROCEDURE co_cancelacreditos_pr (
      en_codcliente         IN       NUMBER,
      ed_feccancelacion     IN       DATE,
      en_numtransaccion     IN       NUMBER,
	  en_decimales          IN       NUMBER,
      en_indcarrier         IN OUT NOCOPY  NUMBER,
      en_estructuraabonos   IN             co_carteraconc_qt DEFAULT NULL,
      en_estructuracargos   IN             co_carteraconc_qt DEFAULT NULL,
      ev_tipcancelacion     IN             VARCHAR2 DEFAULT NULL,
      sn_retorno            OUT NOCOPY     NUMBER,
      sv_glosa              OUT NOCOPY     VARCHAR2
   );
   /*  Nuevo para pasocobros_ciclo */
   PROCEDURE co_obtieneabonos_pr (
      en_codcliente       IN              NUMBER,
	  en_decimales        IN              NUMBER,
      sn_retorno          OUT NOCOPY      NUMBER,
      sv_glosa            IN OUT NOCOPY   VARCHAR2,
      se_abonos           IN OUT NOCOPY   co_carteraconc_qt,
      en_numtransaccion   IN              NUMBER
   );

   /*  Nuevo para pasocobros_ciclo */
   PROCEDURE co_obtienecargos_pr (
      en_codcliente       IN              NUMBER,
	  en_decimales        IN              NUMBER,
      sn_retorno          OUT NOCOPY      NUMBER,
      ev_tipcancelacion   IN              VARCHAR2 DEFAULT NULL,
      sv_glosa            OUT NOCOPY      VARCHAR2,
      se_cargos           IN OUT NOCOPY   co_carteraconc_qt,
      en_numtransaccion   IN              NUMBER
   );

   /*  Nuevo para pasocobros_ciclo */
   PROCEDURE co_cancelaconcepto_pr (
      en_estructuracargo   IN              co_cartera_qt,
      ed_feccancelacion    IN              DATE,
      en_numtransaccion    IN              NUMBER,
	  en_decimales         IN              NUMBER,
      sn_retorno           OUT NOCOPY      NUMBER,
      sv_glosa             OUT NOCOPY      VARCHAR2
   );

   /*  Nuevo para pasocobros_ciclo */
   PROCEDURE co_registrarelconcep_pr (
      en_estructuraabono   IN              co_cartera_qt,
      en_estructuracargo   IN              co_cartera_qt,
      en_numtransaccion    IN              NUMBER,
	  en_decimales         IN              NUMBER,
      sn_retorno           OUT NOCOPY      NUMBER,
      sv_glosa             OUT NOCOPY      VARCHAR2
   );

   /*  Nuevo para pasocobros_ciclo */
   PROCEDURE co_cancelacartera_pr (
      en_codcliente         IN       		NUMBER,
      ed_feccancelacion     IN       		DATE,
      en_numtransaccion     IN       		NUMBER,
	  en_decimales          IN              NUMBER,
      en_indcarrier         IN OUT   NOCOPY NUMBER,
      en_estructuraabonos   IN       		co_carteraconc_qt DEFAULT NULL,
      en_estructuracargos   IN       		co_carteraconc_qt DEFAULT NULL,
      ev_tipcancelacion     IN       		VARCHAR2 DEFAULT NULL,
      sn_retorno            OUT      NOCOPY NUMBER,
      sv_glosa              OUT      NOCOPY VARCHAR2
   );

   PROCEDURE co_cancela_total_pr (
    -- PasoCobrosCICLO
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_estructuraabonos   IN OUT NOCOPY   co_carteraconc_qt,
      en_num_secuenci       IN              NUMBER,
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
	  en_decimales          IN NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   );

   PROCEDURE co_cancela_parcial_100_pr (
   -- PasoCobrosCICLO
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_estructuraabonos   IN OUT NOCOPY   co_carteraconc_qt,
      en_num_secuenci       IN              NUMBER,
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
	  en_decimales          IN              NUMBER,
      sn_ultreg             OUT NOCOPY      NUMBER,
      sn_sumadeuda          OUT NOCOPY      NUMBER,
      sn_resto              OUT NOCOPY      NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   );

   /*  Nuevo para pasocobros_ciclo  */
   PROCEDURE co_cancela_parcial_resto_pr (
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_estructuraabonos   IN OUT NOCOPY   co_carteraconc_qt,
      en_num_secuenci       IN              NUMBER,
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
      en_ultreg             IN              NUMBER,
      en_sumadeuda          IN              NUMBER,
      en_resto              IN              NUMBER,
  	  en_decimales          IN              NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   );
-----------------------------------------------------------------------


END Co_Cancelacion_Pg;
/
SHOW ERRORS
