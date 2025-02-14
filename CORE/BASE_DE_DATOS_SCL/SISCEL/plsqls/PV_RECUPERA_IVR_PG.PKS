CREATE OR REPLACE PACKAGE          "PV_RECUPERA_IVR_PG"  
IS
       /* package con procedimientos para proyecto comunicacion IVR/SCL - Panama
          version 1.0
          modificaciones:.--->  */
--
-- Constantes Globales del Proceso y de Manejo de Error
   CN_0            CONSTANT NUMBER (1)    := 0;
   CN_1            CONSTANT NUMBER (1)    := 1;
   CN_3            CONSTANT NUMBER (1)    := 3;
   CN_25           CONSTANT NUMBER (2)    := 25;
   CV_activo       CONSTANT VARCHAR2 (3)  := 'AAA';
   CV_espacio      CONSTANT CHAR (1)      := ' ';
   CV_4            CONSTANT VARCHAR2 (1)  := '4';
   CV_modulo       CONSTANT VARCHAR2 (2)  := 'PV';
   CV_act          CONSTANT VARCHAR2 (1)  := 'S';
   CV_20101        CONSTANT VARCHAR2 (6)  := '-20101';
   CV_20102        CONSTANT VARCHAR2 (6)  := '-20102';
   CV_20103        CONSTANT VARCHAR2 (6)  := '-20103';
   CV_20104        CONSTANT VARCHAR2 (6)  := '-20104';
   CV_20105        CONSTANT VARCHAR2 (6)  := '-20105';
   CV_20106        CONSTANT VARCHAR2 (6)  := '-20106';
   CV_20107        CONSTANT VARCHAR2 (6)  := '-20107';
   CV_20108        CONSTANT VARCHAR2 (6)  := '-20108';
   CV_20109        CONSTANT VARCHAR2 (6)  := '-20109';
   CV_20110        CONSTANT VARCHAR2 (6)  := '-20110';
   CV_20111        CONSTANT VARCHAR2 (6)  := '-20111';
   CV_20112        CONSTANT VARCHAR2 (6)  := '-20112';
   CV_20113        CONSTANT VARCHAR2 (6)  := '-20113';
   CV_20114        CONSTANT VARCHAR2 (6)  := '-20114';
   CV_20115        CONSTANT VARCHAR2 (6)  := '-20115';
   CV_20116        CONSTANT VARCHAR2 (6)  := '-20116';
   CV_20117        CONSTANT VARCHAR2 (6)  := '-20117';
   CV_20118        CONSTANT VARCHAR2 (6)  := '-20118';
   CV_20119        CONSTANT VARCHAR2 (6)  := '-20119';
   CV_20120        CONSTANT VARCHAR2 (6)  := '-20120';
   CV_20121        CONSTANT VARCHAR2 (6)  := '-20121';

-- Variable Global para control de Error y de formato
   GV_formato GED_PARAMETROS.val_parametro%TYPE;
   GV_nomtabla              GA_ERRORES.nom_tabla%TYPE := ' ';
   GV_rutina                GA_ERRORES.nom_proc%TYPE  := ' ';

/* pv_rec_val_abonado_pr  corresponde al modulo principal del package   */
   PROCEDURE pv_rec_val_abonado_pr (
      EN_celular    IN       GA_ABOCEL.num_celular%TYPE,                           -- numero celular abonado
      EN_norden     IN       SP_ORDENES_REPARACION.num_orden%TYPE,                 -- numero de orden de reparacion
      SV_respuesta  OUT      NOCOPY VARCHAR2,                                  -- linea con detalle de consulta
      SN_codresul   OUT      NOCOPY NUMBER                                     -- codigo exito/fracaso consulta
   );

--
   PROCEDURE pv_obt_minutos_abonado_pr (
      EN_abonado    IN       GA_ABOCEL.num_abonado%TYPE,
      EN_cliente    IN       GA_ABOCEL.cod_cliente%TYPE,
      SN_valtot     OUT      NOCOPY TOL_ACUMBOLSA_GRAL.val_inicial%TYPE,
      SN_valcon     OUT      NOCOPY TOL_ACUMBOLSA_GRAL.val_consumido%TYPE,
      SN_valpen     OUT      NOCOPY TOL_ACUMBOLSA_GRAL.val_disponible%TYPE,
      SV_fechacie   OUT      NOCOPY VARCHAR2,
      SV_sqlcode    OUT      NOCOPY GA_ERRORES.cod_sqlcode%TYPE,
      SV_sqlerrm    OUT      NOCOPY GA_ERRORES.cod_sqlerrm%TYPE
   );

--
   PROCEDURE pv_obt_saldo_factura_pr (
      EN_abonado    IN       GA_ABOCEL.num_abonado%TYPE,
      EN_cliente    IN       GA_ABOCEL.cod_cliente%TYPE,
      SN_salfactu   OUT      NOCOPY fa_histdocu.tot_pagar%TYPE,
      SV_fecven     OUT      NOCOPY VARCHAR2,
      SV_sqlcode    OUT      NOCOPY GA_ERRORES.cod_sqlcode%TYPE,
      SV_sqlerrm    OUT      NOCOPY GA_ERRORES.cod_sqlerrm%TYPE
   );

--
   PROCEDURE pv_obt_estado_orden_pr (
      EN_norden     IN       SP_ORDENES_REPARACION.num_orden%TYPE,
      SV_estorden   OUT      NOCOPY SP_ESTADOS_ORDEN.des_estado_orden%TYPE,
      SV_sqlcode    OUT      NOCOPY GA_ERRORES.cod_sqlcode%TYPE,
      SV_sqlerrm    OUT      NOCOPY GA_ERRORES.cod_sqlerrm%TYPE
   );
--
END PV_RECUPERA_IVR_PG;
/
SHOW ERRORS
