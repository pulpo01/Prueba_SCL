CREATE OR REPLACE PACKAGE ga_consultas_touch_pg
/*
<Documentación
   TipoDoc = "Package">
   <Elemento
       Nombre = "GA_CONSULTAS_TOUCH_PG"
       Lenguaje="PL/SQL"
       Fecha="18-06-2005"
       Versión="1.0"
       Diseñador="Carlos Navarro H. - Marcelo Godoy S."
       Programador="Marcelo Godoy S. - Carlos Navarro H."
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripción>Package fachada para servicios TouchScreen</Descripción>
       <Parámetros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Parámetros>
    </Elemento>
   </Documentación>
*/
IS

   TYPE refcursor IS REF CURSOR;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_consumo_6meses_pr (
      en_num_celular    IN              ga_abocel.num_celular%TYPE,
      sc_cur_consumo    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_nomcliente_pr (
      en_num_celular    IN              NUMBER,
      sv_nom_cliente    OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------
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
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror
   );

----------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_numcelular_pr (
      en_num_celular    IN              NUMBER,
      sn_cod_retorno    OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2
   );

----------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_fonocontacto_pr (
      en_num_celular     IN              NUMBER,
      sv_fono_contacto   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      NUMBER,
      sv_mens_retorno    OUT NOCOPY      VARCHAR2
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_inserta_reg_atencion_pr (
      en_num_celular    IN       ga_abocel.num_celular%TYPE,
      en_cod_atencion   IN       ci_reg_atencion_clientes.cod_atencion%TYPE,
      ev_obs_atencion   IN       ci_reg_atencion_clientes.obs_atencion%TYPE,
      ev_nom_usuario    IN       ci_reg_atencion_clientes.nom_usuarora%TYPE,
      ev_cod_oficina    IN       ci_reg_atencion_clientes.cod_oficina%TYPE,
      sn_cod_retorno    OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT      NOCOPY ge_errores_td.det_msgerror%TYPE
   );

--------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_factura_touch_pr (
      en_num_celular    IN              NUMBER,
      sv_fec_ini        OUT NOCOPY      VARCHAR2,
      sv_fec_fin        OUT NOCOPY      VARCHAR2,
      sv_fec_emision    OUT NOCOPY      VARCHAR2,
      sv_fec_vencimie   OUT NOCOPY      VARCHAR2,
      sv_fec_susp       OUT NOCOPY      VARCHAR2,
      sn_saldo_ant      OUT NOCOPY      NUMBER,
      sn_saldo_act      OUT NOCOPY      NUMBER,
      sn_ult_pago       OUT NOCOPY      NUMBER,
      sn_tot_iptos      OUT NOCOPY      NUMBER,
      sn_tot_dctos      OUT NOCOPY      NUMBER,
      sn_tot_cargos     OUT NOCOPY      NUMBER,
      sn_tot_cargosme   OUT NOCOPY      NUMBER,
      sn_tot_cuotas     OUT NOCOPY      NUMBER,
      sn_tot_pagar      OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE
   );

----------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_producto_pr (
      en_num_celular    IN              NUMBER,
      sv_des_producto   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ga_version_fn
      RETURN VARCHAR2;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END ga_consultas_touch_pg;
/
SHOW ERRORS
