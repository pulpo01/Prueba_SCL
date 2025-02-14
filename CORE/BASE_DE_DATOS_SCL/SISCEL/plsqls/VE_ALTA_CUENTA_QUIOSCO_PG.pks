CREATE OR REPLACE PACKAGE ve_alta_cuenta_quiosco_pg IS
-----------------------------
-- DECLARACION DE CONSTANTES
-----------------------------
   cv_producto             CONSTANT VARCHAR2 (1)  := '1';
   cv_modulo_ga            CONSTANT VARCHAR2 (2)  := 'GA';
   cv_modulo_ge            CONSTANT VARCHAR2 (2)  := 'GE';
   cv_errornoclasif        CONSTANT VARCHAR2 (30) := 'Error no clasificado';
   cn_largoerrtec          CONSTANT NUMBER        := 4000;
   cn_largodesc            CONSTANT NUMBER        := 2000;
   cv_formatofecha         CONSTANT VARCHAR2 (10) := 'DD/MM/YYYY';
   -- nombre de parametros
   cv_nompar_formatosel2   CONSTANT VARCHAR2 (12) := 'FORMATO_SEL2';
   cv_nompar_formatosel7   CONSTANT VARCHAR2 (12) := 'FORMATO_SEL7';

------------------------
-- DECLARACION DE TIPOS
------------------------
   TYPE refcursor IS REF CURSOR;

----------------------------
-- DECLARACION DE VARIABLES
----------------------------

   ----------------------------
-- DECLARACION DE FUNCIONES
----------------------------

   ---------------------------------
-- DECLARACION DE PROCEDIMIENTOS
---------------------------------
   PROCEDURE ve_getcuenta_pr (
      ev_codcuenta      IN              VARCHAR2,
      sv_descuenta      OUT NOCOPY      VARCHAR2,
      sv_tipcuenta      OUT NOCOPY      VARCHAR2,
      sv_responsable    OUT NOCOPY      VARCHAR2,
      sv_codtipident    OUT NOCOPY      VARCHAR2,
      sv_numident       OUT NOCOPY      VARCHAR2,
      sv_coddirec       OUT NOCOPY      VARCHAR2,
      sv_fecalta        OUT NOCOPY      VARCHAR2,
      sv_indestado      OUT NOCOPY      VARCHAR2,
      sv_telcontacto    OUT NOCOPY      VARCHAR2,
      sv_indsector      OUT NOCOPY      VARCHAR2,
      sv_clascta        OUT NOCOPY      VARCHAR2,
      sv_codcatribut    OUT NOCOPY      VARCHAR2,
      sv_codcategoria   OUT NOCOPY      VARCHAR2,
      sv_codsector      OUT NOCOPY      VARCHAR2,
      sv_codsubcat      OUT NOCOPY      VARCHAR2,
      sv_indmultuso     OUT NOCOPY      VARCHAR2,
      sv_clipotencial   OUT NOCOPY      VARCHAR2,
      sv_razonsocial    OUT NOCOPY      VARCHAR2,
      sv_fecinvpac      OUT NOCOPY      VARCHAR2,
      sv_tipcomis       OUT NOCOPY      VARCHAR2,
      sv_usuarasesor    OUT NOCOPY      VARCHAR2,
      sv_fecnac         OUT NOCOPY      VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getcuentaidentif_pr (
      ev_codtipident    IN              VARCHAR2,
      ev_numident       IN              VARCHAR2,
      sv_codcuenta      OUT NOCOPY      VARCHAR2,
      sv_descuenta      OUT NOCOPY      VARCHAR2,
      sv_tipcuenta      OUT NOCOPY      VARCHAR2,
      sv_responsable    OUT NOCOPY      VARCHAR2,
      sv_coddirec       OUT NOCOPY      VARCHAR2,
      sv_fecalta        OUT NOCOPY      VARCHAR2,
      sv_indestado      OUT NOCOPY      VARCHAR2,
      sv_telcontacto    OUT NOCOPY      VARCHAR2,
      sv_indsector      OUT NOCOPY      VARCHAR2,
      sv_clascta        OUT NOCOPY      VARCHAR2,
      sv_codcatribut    OUT NOCOPY      VARCHAR2,
      sv_codcategoria   OUT NOCOPY      VARCHAR2,
      sv_codsector      OUT NOCOPY      VARCHAR2,
      sv_codsubcat      OUT NOCOPY      VARCHAR2,
      sv_indmultuso     OUT NOCOPY      VARCHAR2,
      sv_clipotencial   OUT NOCOPY      VARCHAR2,
      sv_razonsocial    OUT NOCOPY      VARCHAR2,
      sv_fecinvpac      OUT NOCOPY      VARCHAR2,
      sv_tipcomis       OUT NOCOPY      VARCHAR2,
      sv_usuarasesor    OUT NOCOPY      VARCHAR2,
      sv_fecnac         OUT NOCOPY      VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);

--------------------------------------------------------------------------------------------
--* CURSORES - LISTAS
--------------------------------------------------------------------------------------------
   PROCEDURE ve_getlistclasifcuenta_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE ve_getlistcuentas_pr (
      ev_criteriobusq   IN              VARCHAR2,
      ev_filtro         IN              VARCHAR2,
      ev_valorbusq      IN              VARCHAR2,
      ev_tipoidentif    IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);

--------------------------------------------------------------------------------------------
--* INSERTS y UPDATES
--------------------------------------------------------------------------------------------
   PROCEDURE ve_inscuenta_pr (
      ev_codcuenta      IN              VARCHAR2,
      ev_descuenta      IN              VARCHAR2,
      ev_tipcuenta      IN              VARCHAR2,
      ev_responsable    IN              VARCHAR2,
      ev_codtipident    IN              VARCHAR2,
      ev_numident       IN              VARCHAR2,
      ev_coddirec       IN              VARCHAR2,
      ev_indestado      IN              VARCHAR2,
      ev_telcontacto    IN              VARCHAR2,
      ev_indsector      IN              VARCHAR2,
      ev_clascta        IN              VARCHAR2,
      ev_codcatribut    IN              VARCHAR2,
      ev_codcategoria   IN              VARCHAR2,
      ev_codsector      IN              VARCHAR2,
      ev_codsubcat      IN              VARCHAR2,
      ev_indmultuso     IN              VARCHAR2,
      ev_clipotencial   IN              VARCHAR2,
      ev_razonsocial    IN              VARCHAR2,
      ev_fecinvpac      IN              VARCHAR2,
      ev_tipcomis       IN              VARCHAR2,
      ev_usuarasesor    IN              VARCHAR2,
      ev_fecnac         IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_inssubcuenta_pr (
      ev_codcuenta      IN              VARCHAR2,
      ev_codsubcuenta   IN              VARCHAR2,
      ev_dessubcuenta   IN              VARCHAR2,
      ev_coddirec       IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_updcategcuenta_pr (
      ev_codcuenta      IN              VARCHAR2,
      ev_codcategoria   IN              VARCHAR2,
      ev_codsubcateg    IN              VARCHAR2,
      ev_codmultuso     IN              VARCHAR2,
      ev_codcliepot     IN              VARCHAR2,
      ev_desrazon       IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);

--------------------------------------------------------------------------------------------
--* DELETEs
--------------------------------------------------------------------------------------------
   PROCEDURE ve_delcategctaspotenciales_pr (
      ev_numidentif   IN              VARCHAR2,
      sn_codretorno   OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY      ge_errores_pg.evento);
END ve_alta_cuenta_quiosco_pg; 
/

SHOW ERRORS
