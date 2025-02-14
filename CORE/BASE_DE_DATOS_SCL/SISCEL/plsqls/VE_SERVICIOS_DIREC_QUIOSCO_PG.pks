CREATE OR REPLACE PACKAGE ve_servicios_direc_quiosco_pg IS
-----------------------------
-- DECLARACION DE CONSTANTES
-----------------------------
   cv_modulo_ga       CONSTANT VARCHAR2 (2)  := 'GA';
   cv_errornoclasif   CONSTANT VARCHAR2 (30) := 'Error no clasificado';
   cn_largoerrtec     CONSTANT NUMBER        := 4000;
   cn_largodesc       CONSTANT NUMBER        := 2000;
   cn_region          CONSTANT NUMBER        := 0;
   cn_provincia       CONSTANT NUMBER        := 1;
   cn_ciudad          CONSTANT NUMBER        := 2;
   cn_comuna          CONSTANT NUMBER        := 3;
   cn_calle           CONSTANT NUMBER        := 4;
   cn_numero          CONSTANT NUMBER        := 5;
   cn_piso            CONSTANT NUMBER        := 6;
   cn_casilla         CONSTANT NUMBER        := 7;
   cn_observacion     CONSTANT NUMBER        := 8;
   cn_des_direc1      CONSTANT NUMBER        := 9;
   cn_des_direc2      CONSTANT NUMBER        := 10;
   cn_pueblo          CONSTANT NUMBER        := 11;
   cn_estado          CONSTANT NUMBER        := 12;
   cn_zip             CONSTANT NUMBER        := 13;

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
   PROCEDURE ve_getdireccion_pr (
      ev_codsujeto       IN              VARCHAR2,
      en_tipsujeto       IN              NUMBER,
      en_tipdireccion    IN              NUMBER,
      en_tipdisplay      IN              NUMBER,
      sv_cod_region      OUT NOCOPY      VARCHAR2,
      sv_cod_provincia   OUT NOCOPY      VARCHAR2,
      sv_cod_ciudad      OUT NOCOPY      VARCHAR2,
      sv_cod_comuna      OUT NOCOPY      VARCHAR2,
      sv_nom_calle       OUT NOCOPY      VARCHAR2,
      sv_num_calle       OUT NOCOPY      VARCHAR2,
      sv_num_piso        OUT NOCOPY      VARCHAR2,
      sv_num_casilla     OUT NOCOPY      VARCHAR2,
      sv_obs_direccion   OUT NOCOPY      VARCHAR2,
      sv_des_direc1      OUT NOCOPY      VARCHAR2,
      sv_des_direc2      OUT NOCOPY      VARCHAR2,
      sv_cod_pueblo      OUT NOCOPY      VARCHAR2,
      sv_cod_estado      OUT NOCOPY      VARCHAR2,
      sv_zip             OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getdireccioncodigo_pr (
      en_cod_direccion   IN              NUMBER,
      sv_cod_provincia   OUT NOCOPY      VARCHAR2,
      sv_cod_region      OUT NOCOPY      VARCHAR2,
      sv_cod_ciudad      OUT NOCOPY      VARCHAR2,
      sv_cod_comuna      OUT NOCOPY      VARCHAR2,
      sv_nom_calle       OUT NOCOPY      VARCHAR2,
      sv_num_calle       OUT NOCOPY      VARCHAR2,
      sv_num_piso        OUT NOCOPY      VARCHAR2,
      sv_num_casilla     OUT NOCOPY      VARCHAR2,
      sv_obs_direccion   OUT NOCOPY      VARCHAR2,
      sv_des_direc1      OUT NOCOPY      VARCHAR2,
      sv_des_direc2      OUT NOCOPY      VARCHAR2,
      sv_cod_pueblo      OUT NOCOPY      VARCHAR2,
      sv_cod_estado      OUT NOCOPY      VARCHAR2,
      sv_zip             OUT NOCOPY      VARCHAR2,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento);

--------------------------------------------------------------------------------------------
--* CURSORES - LISTAS
--------------------------------------------------------------------------------------------
   PROCEDURE ve_getlistconfigdirecciones_pr (
      ev_codoperadora   IN              ge_paramdiroperad.cod_operad%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getlistcomunas_pr (
      ev_codregion      IN              ge_ciucom.cod_region%TYPE,
      ev_codprovincia   IN              ge_ciucom.cod_provincia%TYPE,
      ev_codciudad      IN              ge_ciucom.cod_ciudad%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getlistestados_pr (
      ev_indorden      IN              VARCHAR2,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getlistpueblos_pr (
      ev_codestado     IN              ge_pueblos.cod_estado%TYPE,
      ev_indorden      IN              VARCHAR2,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getlistzip_pr (
      ev_codzona       IN              ge_zipcode_td.cod_zona%TYPE,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_listadoregiones_pr (
      ev_indorden       IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_listadoprovincias_pr (
      ev_codregion      IN              ge_regiones.cod_region%TYPE,
      ev_indorden       IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_listadociudades_pr (
      ev_codregion      IN              ge_regiones.cod_region%TYPE,
      ev_codprovincia   IN              ge_provincias.cod_provincia%TYPE,
      ev_indorden       IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

--------------------------------------------------------------------------------------------
--* INSERTS y UPDATES
--------------------------------------------------------------------------------------------
   PROCEDURE ve_upddireccion_pr (
      en_cod_direccion   IN              NUMBER,
      ev_cod_provincia   IN              VARCHAR2,
      ev_cod_region      IN              VARCHAR2,
      ev_cod_ciudad      IN              VARCHAR2,
      ev_cod_comuna      IN              VARCHAR2,
      ev_nom_calle       IN              VARCHAR2,
      ev_num_calle       IN              VARCHAR2,
      ev_num_piso        IN              VARCHAR2,
      ev_num_casilla     IN              VARCHAR2,
      ev_obs_direccion   IN              VARCHAR2,
      ev_des_direc1      IN              VARCHAR2,
      ev_des_direc2      IN              VARCHAR2,
      ev_cod_pueblo      IN              VARCHAR2,
      ev_cod_estado      IN              VARCHAR2,
      ev_zip             IN              VARCHAR2,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_deldireccion_pr (
      en_cod_direccion   IN              VARCHAR2,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_inserta_direccion_pr (
      en_cod_direccion   IN              NUMBER,
      ev_cod_provincia   IN              VARCHAR2,
      ev_cod_region      IN              VARCHAR2,
      ev_cod_ciudad      IN              VARCHAR2,
      ev_cod_comuna      IN              VARCHAR2,
      ev_nom_calle       IN              VARCHAR2,
      ev_num_calle       IN              VARCHAR2,
      ev_num_piso        IN              VARCHAR2,
      ev_num_casilla     IN              VARCHAR2,
      ev_obs_direccion   IN              VARCHAR2,
      ev_des_direc1      IN              VARCHAR2,
      ev_des_direc2      IN              VARCHAR2,
      ev_cod_pueblo      IN              VARCHAR2,
      ev_cod_estado      IN              VARCHAR2,
      ev_zip             IN              VARCHAR2,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_insdireccionusuario_pr (
      en_coddireccion   IN              NUMBER,
      ev_codusuario     IN              VARCHAR2,
      ev_tipdireccion   IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);
END ve_servicios_direc_quiosco_pg;
/

SHOW ERROR
