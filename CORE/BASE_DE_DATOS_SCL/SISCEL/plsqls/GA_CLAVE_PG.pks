CREATE OR REPLACE PACKAGE        ga_clave_pg
/*
<Documentación
   TipoDoc = "Package">
   <Elemento
       Nombre = "GA_CLAVE_PG" 
       Lenguaje="PL/SQL"
       Fecha="18-06-2005"
       Versión="1.0"
       Diseñador="Carlos Navarro H. - Marcelo Godoy S."
       Programador="Marcelo Godoy S. - Carlos Navarro H."
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripción>Package negocio de consulta y modificación de clave</Descripción>
       <Parámetros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Parámetros>
    </Elemento>
   </Documentación>
*/
IS
   --Constantes Globales
   cv_error_no_clasif   CONSTANT VARCHAR2 (60) := 'Error no clasificado';
   cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'GA';
   cn_cod_producto      CONSTANT NUMBER        := 1;
   cn_largoerrtec       CONSTANT NUMBER        := 4000;
   cn_largodesc         CONSTANT NUMBER        := 2000;
   cv_cod_actuacion     CONSTANT VARCHAR2 (2)  := 'IV';
   cv_param_grupo_gsm   CONSTANT VARCHAR2 (20) := 'GRUPO_TEC_GSM';
   cv_version           CONSTANT VARCHAR2 (5)  := '1.0';
   cv_clave_bloqueada   CONSTANT VARCHAR2 (7)  := '0000000';
   cv_mens_atendio      CONSTANT VARCHAR2 (23) := 'Celular: ';
   cn_abonado_prepago   CONSTANT VARCHAR2 (1)    := 1;
   cn_abonado_pospago   CONSTANT VARCHAR2 (1)    := 2;
   cn_abonado_hibrido   CONSTANT VARCHAR2 (1)    := 3; -- COL|45656|05-11-2007|SAQL
   --Variables Globales
   gv_des_tipabonado             ged_codigos.des_valor%TYPE;
   gv_param_entrada              VARCHAR2 (500);
   --Estructura de ga_segmentacion.ga_origen_cliente_pr
   gn_num_abonado                ga_abocel.num_abonado%TYPE;
   gn_cod_cliente                ga_abocel.cod_cliente%TYPE;
   gv_nom_abocli                 VARCHAR2 (91);
   gv_cod_situacion              ga_abocel.cod_situacion%TYPE;
   gn_cod_cuenta                 ga_abocel.cod_cuenta%TYPE;
   gv_cod_clave                  VARCHAR2 (7);
   gv_cod_plantarif              ga_abocel.cod_plantarif%TYPE;
   gv_cod_tecnología             ga_abocel.cod_tecnologia%TYPE;
   gv_cod_perfil                 ge_valores_cli.des_valor%TYPE;
   gv_tip_plantarif              ga_abocel.tip_plantarif%TYPE;
   gv_des_plantarif              ta_plantarif.des_plantarif%TYPE;
   gn_cod_ciclo                  ga_abocel.cod_ciclo%TYPE;
   gn_fono_contacto              VARCHAR2 (15);
   gv_num_serie                  ga_abocel.num_serie%TYPE;
   gv_num_imei                   ga_abocel.num_imei%TYPE;
   gv_num_min_mdn                ga_abocel.num_min_mdn%TYPE;
   gv_num_min                    ga_abocel.num_min%TYPE;
   gv_num_seriehex               ga_abocel.num_seriehex%TYPE;
   gv_num_seriemec               ga_abocel.num_seriemec%TYPE;
   gv_tip_terminal               ga_abocel.tip_terminal%TYPE;
   gv_tip_abonado                ta_plantarif.cod_tiplan%TYPE;
   gv_cod_estado                 ga_abocel.cod_estado%TYPE;
   gn_cod_producto               ga_abocel.cod_producto%TYPE;
   gv_nom_responsable            ga_cuentas.nom_responsable%TYPE;
   --Fin estructura de ga_segmentacion.ga_origen_cliente_pr

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_modifica_abonado_pr (
      ev_clave          IN              ga_abocel.cod_password%TYPE,
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      ev_cod_tipmodi    IN              ga_modabocel.cod_tipmodi%TYPE,
      ev_tip_terminal   IN              ga_abocel.tip_terminal%TYPE,
      ev_serie          IN              ga_abocel.num_serie%TYPE,
      ev_numseriehex    IN              ga_abocel.num_seriehex%TYPE,
      ev_seriemec       IN              ga_abocel.num_seriemec%TYPE,
      ev_tipo_abonado   IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_cambio_clave_pr (
      en_num_celular    IN              NUMBER,
      ev_clave          IN              VARCHAR2,
      ev_clave_new      IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2,
      sn_num_evento     OUT NOCOPY      NUMBER
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_bloqueo_clave_pr (
      en_num_celular    IN              NUMBER,
      ev_clave          IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2,
      sn_num_evento     OUT NOCOPY      NUMBER
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_clave_pr (
      en_num_celular      IN              NUMBER,
      sn_clave            OUT NOCOPY      NUMBER,
      sv_tip_tarifario    OUT NOCOPY      VARCHAR2,
      sn_estado_cliente   OUT NOCOPY      NUMBER,
      sn_ind_prepago      OUT NOCOPY      NUMBER,
      sn_cod_retorno      OUT NOCOPY      NUMBER,
      sv_mens_retorno     OUT NOCOPY      VARCHAR2,
      sn_num_evento       OUT NOCOPY      NUMBER
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_desbloqueo_clave_pr (
      en_num_celular    IN              NUMBER,
      ev_clave          IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2,
      sn_num_evento     OUT NOCOPY      NUMBER
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ga_clave_pg;
/
SHOW ERRORS
