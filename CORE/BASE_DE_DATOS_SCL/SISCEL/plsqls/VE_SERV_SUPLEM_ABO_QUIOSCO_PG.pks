CREATE OR REPLACE PACKAGE               ve_serv_suplem_abo_quiosco_pg IS
   /*
   <Documentacion
   TipoDoc = "Package">
   <Elemento
      Nombre = "ve_serv_suplem_abo_quiosco_pg"
      Lenguaje="PL/SQL"
      Fecha="07-03-2007"
      Version="1.0"
      Dise?ador="wjrc"
      Programador="wjrc"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>Package para obtener los servicios suplementarios del abonado</Descripcion>
      <Parametros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parametros>
   </Elemento>
   </Documentacion>
   */

   --type REFCURSOR                 IS REF CURSOR;
   cv_error_no_clasif         CONSTANT VARCHAR2 (60) := 'Error no clasificado';
   cv_cod_modulo              CONSTANT VARCHAR2 (2)  := 'VE';
   cn_largoerrtec             CONSTANT NUMBER        := 4000;
   cn_largodesc               CONSTANT NUMBER        := 2000;
   cv_version                 CONSTANT VARCHAR2 (3)  := '1.0';
   cv_codmodulo_al            CONSTANT VARCHAR2 (2)  := 'AL';
   cv_codmodulo_ga            CONSTANT VARCHAR2 (2)  := 'GA';
   cv_codmodulo_ge            CONSTANT VARCHAR2 (2)  := 'GE';
   cv_codproducto             CONSTANT VARCHAR2 (1)  := '1';
   cv_sistema                 CONSTANT VARCHAR2 (1)  := '1';
   -- codigo actuacion venta
   cv_codact_fac              CONSTANT VARCHAR2 (2)  := 'FA';                                                                                                                                                                  -- codigo actuacion facturacion
   cv_codact_ven              CONSTANT VARCHAR2 (2)  := 'VO';
   cv_codact_aah              CONSTANT VARCHAR2 (2)  := 'HH';                                                                                                                                                         -- codigo actuacion alta abonado hibrido
   cv_codact_pre              CONSTANT VARCHAR2 (2)  := 'AM';
   cv_nompar_tipplanhib       CONSTANT VARCHAR2 (16) := 'TIP_PLAN_HIBRIDO';
   cv_nompar_tipplanpre       CONSTANT VARCHAR2 (16) := 'TIP_PLAN_PREPAGO';
   cv_nompar_tipplanpos       CONSTANT VARCHAR2 (16) := 'TIPOPOSTPAGO';
   cv_nompar_indautenti       CONSTANT VARCHAR2 (17) := 'IND_AUTENTICACION';
   cv_nompar_formafecha       CONSTANT VARCHAR2 (12) := 'FORMATO_SEL2';
   cv_nompar_friendfami       CONSTANT VARCHAR2 (10) := 'FRIEND_FAM';
   cv_nompar_tipterminalgsm   CONSTANT VARCHAR2 (15) := 'COD_SIMCARD_GSM';
   cv_codpro_servsup          CONSTANT VARCHAR2 (16) := 'COD_PROC_SERVSUP';
   cv_tecnologia              CONSTANT VARCHAR2 (3)  := 'GSM';
   cv_tipterminal_equi        CONSTANT VARCHAR2 (1)  := 'T';
   cv_tipterminal_simc        CONSTANT VARCHAR2 (1)  := 'G';
   -- * CONSTANTES DEFINIDAS EN CODIGO VB
   cv_indestado_altbd         CONSTANT VARCHAR2 (1)  := '1';                                                                                                                                                                             -- alta base de datos
   cv_indestado_altcen        CONSTANT VARCHAR2 (1)  := '2';                                                                                                                                                                                 -- alta centrales
   cv_indcomercial            CONSTANT VARCHAR2 (1)  := '1';
   cv_tipservicio_1           CONSTANT VARCHAR2 (1)  := '1';
   cv_tipservicio_2           CONSTANT VARCHAR2 (1)  := '2';
   cv_programa                CONSTANT VARCHAR2 (3)  := 'GAC';
   cv_versionprograma         CONSTANT VARCHAR2 (2)  := '13';
   cv_formato_fecha_sis       CONSTANT VARCHAR2 (17) := 'DDMMYYYY HH24MISS';
   cv_fechatope_ss            CONSTANT VARCHAR2 (10) := '31-12-3000';
   cv_horatope_ss             CONSTANT VARCHAR2 (10) := ' 23:59:00';                                                                                                                                                           -- conservar el especio delante
   cv_duracion_infinita       CONSTANT VARCHAR2 (1)  := 'I';
   cv_tipo_relacion           CONSTANT VARCHAR2 (2)  := '3';                                                                                                                                                               -- Para plan tarifario debe tomar 2
   cv_tipo_serv_normal        CONSTANT VARCHAR2 (1)  := '1';
   cv_estado_1                CONSTANT NUMBER        := 1;
   cv_estado_2                CONSTANT NUMBER        := 2;

   TYPE arregloparametros IS TABLE OF ged_parametros.val_parametro%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE refcursor IS REF CURSOR;

   PROCEDURE ve_procesossabonado_pr (
      ev_abonado        IN              VARCHAR2,
      ev_plan           IN              VARCHAR2,
      ev_numterminal    IN              VARCHAR2,
      ev_usuario        IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_ss_abonado_pr (
      ev_num_abonado    IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_ssabo_paracent_pr (
      en_numabonado     IN              ga_servsuplabo.num_abonado%TYPE,
      en_indestado      IN              ga_servsuplabo.ind_estado%TYPE,
      ev_codproducto    IN              VARCHAR2,
      ev_codmodulo      IN              VARCHAR2,
      ev_codsistema     IN              VARCHAR2,
      ev_codactuacion   IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_ssabo_nocent_pr (
      en_numabonado     IN              ga_servsuplabo.num_abonado%TYPE,
      en_indestado      IN              ga_servsuplabo.ind_estado%TYPE,
      ev_codproducto    IN              VARCHAR2,
      ev_codmodulo      IN              VARCHAR2,
      ev_codsistema     IN              VARCHAR2,
      ev_codactuacion   IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);
END ve_serv_suplem_abo_quiosco_pg;
/
SHOW ERRORS
