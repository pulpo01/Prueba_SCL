CREATE OR REPLACE PACKAGE        ga_consulta_direccion_pg
/*
<Documentación
   TipoDoc = "Package">
   <Elemento
       Nombre = "GA_CONSULTA_DIRECCION_PG"
       Lenguaje="PL/SQL"
       Fecha="18-06-2005"
       Versión="2.0"
       Diseñador="Carlos Navarro H. - Marcelo Godoy S."
       Programador="Marcelo Godoy S. - Carlos Navarro H."
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripción>Package negocio de consulta de dirección de facturacion</Descripción>
       <Parámetros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Parámetros>
    </Elemento>
   </Documentación>
*/

IS
   --Estructura de ga_segmentacion.ga_origen_cliente_pr
   gn_num_abonado                 ga_abocel.num_abonado%TYPE;
   gn_cod_cliente                 ga_abocel.cod_cliente%TYPE;
   gv_nom_abocli                  VARCHAR2 (91);
   gv_cod_situacion               ga_abocel.cod_situacion%TYPE;
   gn_cod_cuenta                  ga_abocel.cod_cuenta%TYPE;
   gv_cod_clave                   VARCHAR2 (7);
   gv_cod_plantarif               ga_abocel.cod_plantarif%TYPE;
   gv_cod_tecnología              ga_abocel.cod_tecnologia%TYPE;
   gv_cod_perfil                  VARCHAR2 (5);
   gv_tip_plantarif               ga_abocel.tip_plantarif%TYPE;
   gn_cod_ciclo                   ga_abocel.cod_ciclo%TYPE;
   gn_fono_contacto               VARCHAR2 (15);
   gv_num_serie                   ga_abocel.num_serie%TYPE;
   gv_num_imei                    ga_abocel.num_imei%TYPE;
   gv_num_min_mdn                 ga_abocel.num_min_mdn%TYPE;
   gv_num_min                     ga_abocel.num_min%TYPE;
   gv_num_seriehex                ga_abocel.num_seriehex%TYPE;
   gv_num_seriemec                ga_abocel.num_seriemec%TYPE;
   gv_tip_terminal                ga_abocel.tip_terminal%TYPE;
   gv_tip_abonado                 ta_plantarif.cod_tiplan%TYPE;
   gv_des_plantarif               ta_plantarif.des_plantarif%TYPE;
   --Fin estructura de ga_segmentacion.ga_origen_cliente_pr

   --Constantes Globales
   CV_cod_tipdireccion   CONSTANT VARCHAR2 (1)    := '1'; --Facturacion
   CV_error_no_clasif    CONSTANT VARCHAR2 (60)   := 'Error no clasificado';
   CV_cod_modulo         CONSTANT VARCHAR2 (2)    := 'GA';
   CV_tip_direccion      CONSTANT VARCHAR2 (13)   := 'TIP_DIRECCION';
   CN_cod_producto       CONSTANT NUMBER          := 1;
   CN_largoerrtec        CONSTANT NUMBER          := 1000;
   CN_largodesc          CONSTANT NUMBER          := 2000;
   CV_mens_atendio       CONSTANT VARCHAR2 (23)   := 'Se atendió al celular: ';
   CV_nom_usuario        ci_reg_atencion_clientes.nom_usuarora%TYPE := USER;
   CV_version            CONSTANT VARCHAR2(2) := '2';
   CV_subversion         CONSTANT VARCHAR2(2) := '0';

   TYPE refcursor IS REF CURSOR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_direccion_pr (
      en_num_celular      IN              ga_abocel.num_celular%TYPE,
      en_cod_tipdir       IN              ge_tipdireccion.cod_tipdireccion%TYPE,
      sv_des_tipdir       OUT NOCOPY      ge_tipdireccion.des_tipdireccion%TYPE,
      sv_nom_calle        OUT NOCOPY      ge_direcciones.nom_calle%TYPE,
      sv_num_calle        OUT NOCOPY      ge_direcciones.num_calle%TYPE,
      sv_num_piso         OUT NOCOPY      ge_direcciones.num_piso%TYPE,
      sv_cod_region       OUT NOCOPY      ge_direcciones.cod_region%TYPE,
      sv_des_region       OUT NOCOPY      ge_regiones.des_region%TYPE,
      sv_cod_provincia    OUT NOCOPY      ge_direcciones.cod_provincia%TYPE,
      sv_des_provincia    OUT NOCOPY      ge_provincias.des_provincia%TYPE,
      sv_cod_ciudad       OUT NOCOPY      ge_direcciones.cod_ciudad%TYPE,
      sv_des_ciudad       OUT NOCOPY      ge_ciudades.des_ciudad%TYPE,
      sv_cod_comuna       OUT NOCOPY      ge_direcciones.cod_comuna%TYPE,
      sv_des_comuna       OUT NOCOPY      ge_comunas.des_comuna%TYPE,
      sv_cod_postal       OUT NOCOPY      ge_direcciones.zip%TYPE,
      sv_observacion      OUT NOCOPY      ge_direcciones.obs_direccion%TYPE,
      sv_des_dir1         OUT NOCOPY      ge_direcciones.des_direc1%TYPE,
      sv_des_dir2         OUT NOCOPY      ge_direcciones.des_direc2%TYPE,
      sn_cod_cliente      OUT NOCOPY      ge_clientes.cod_cliente%TYPE,
      sv_nom_cliente      OUT NOCOPY      VARCHAR2,
      sv_cod_tecnologia   OUT NOCOPY      ga_abocel.cod_tecnologia%TYPE,
      sd_fec_activ        OUT NOCOPY      ga_abocel.fec_activacion%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_direcfact_pr (
      en_num_celular      IN              ga_abocel.num_celular%TYPE,
      sv_des_tipdir       OUT NOCOPY      ge_tipdireccion.des_tipdireccion%TYPE,
      sv_nom_calle        OUT NOCOPY      ge_direcciones.nom_calle%TYPE,
      sv_num_calle        OUT NOCOPY      ge_direcciones.num_calle%TYPE,
      sv_num_piso         OUT NOCOPY      ge_direcciones.num_piso%TYPE,
      sv_cod_region       OUT NOCOPY      ge_direcciones.cod_region%TYPE,
      sv_des_region       OUT NOCOPY      ge_regiones.des_region%TYPE,
      sv_cod_provincia    OUT NOCOPY      ge_direcciones.cod_provincia%TYPE,
      sv_des_provincia    OUT NOCOPY      ge_provincias.des_provincia%TYPE,
      sv_cod_ciudad       OUT NOCOPY      ge_direcciones.cod_ciudad%TYPE,
      sv_des_ciudad       OUT NOCOPY      ge_ciudades.des_ciudad%TYPE,
      sv_cod_comuna       OUT NOCOPY      ge_direcciones.cod_comuna%TYPE,
      sv_des_comuna       OUT NOCOPY      ge_comunas.des_comuna%TYPE,
      sv_cod_postal       OUT NOCOPY      ge_direcciones.zip%TYPE,
      sv_observacion      OUT NOCOPY      ge_direcciones.obs_direccion%TYPE,
      sv_des_dir1         OUT NOCOPY      ge_direcciones.des_direc1%TYPE,
      sv_des_dir2         OUT NOCOPY      ge_direcciones.des_direc2%TYPE,
      sn_cod_cliente      OUT NOCOPY      ge_clientes.cod_cliente%TYPE,
      sv_nom_cliente      OUT NOCOPY      VARCHAR2,
      sv_cod_tecnologia   OUT NOCOPY      ga_abocel.cod_tecnologia%TYPE,
      sd_fec_activ        OUT NOCOPY      ga_abocel.fec_activacion%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_obtiene_direccli_pr (
      en_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      ev_tipdireccion   IN              ge_tipdireccion.cod_tipdireccion%TYPE,
      sn_coddireccion   OUT NOCOPY      ge_direcciones.cod_direccion%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_obtiene_desdirec_pr (
      en_cod_direccion   IN              ge_direcciones.cod_direccion%TYPE,
      en_cod_tipdirec    IN              ge_tipdireccion.cod_tipdireccion%TYPE,
      sv_nom_calle       OUT NOCOPY      ge_direcciones.nom_calle%TYPE,
      sv_num_calle       OUT NOCOPY      ge_direcciones.num_calle%TYPE,
      sv_num_piso        OUT NOCOPY      ge_direcciones.num_piso%TYPE,
      sn_cod_region      OUT NOCOPY      ge_direcciones.cod_region%TYPE,
      sv_des_region      OUT NOCOPY      ge_regiones.des_region%TYPE,
      sn_cod_provincia   OUT NOCOPY      ge_direcciones.cod_provincia%TYPE,
      sv_des_provincia   OUT NOCOPY      ge_provincias.des_provincia%TYPE,
      sn_cod_ciudad      OUT NOCOPY      ge_direcciones.cod_ciudad%TYPE,
      sv_des_ciudad      OUT NOCOPY      ge_ciudades.des_ciudad%TYPE,
      sn_cod_comuna      OUT NOCOPY      ge_direcciones.cod_comuna%TYPE,
      sv_des_comuna      OUT NOCOPY      ge_comunas.des_comuna%TYPE,
      sv_cod_postal      OUT NOCOPY      ge_direcciones.zip%TYPE,
      sv_observacion     OUT NOCOPY      ge_direcciones.obs_direccion%TYPE,
      sv_des_direcc1     OUT NOCOPY      ge_direcciones.des_direc1%TYPE,
      sv_des_direcc2     OUT NOCOPY      ge_direcciones.des_direc2%TYPE,
      sv_des_tipdirec    OUT NOCOPY      ge_tipdireccion.des_tipdireccion%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ga_consulta_direccion_pr (
   EN_cod_direccion    IN 		  ge_direcciones.cod_direccion%TYPE,
   SV_obs_direccion    OUT NOCOPY ge_direcciones.obs_direccion%TYPE,
   SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
   SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
   SN_num_evento       OUT NOCOPY ge_errores_pg.Evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  FUNCTION ga_version_fn  RETURN VARCHAR2;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ga_consulta_direccion_pg;
/
SHOW ERRORS
