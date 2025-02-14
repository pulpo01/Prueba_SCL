CREATE OR REPLACE PACKAGE ga_cons_atlantida_pg
/*
<Documentación
   TipoDoc = "Package">
   <Elemento
       Nombre = "GA_CONS_ATLANTIDA_PG"
       Lenguaje="PL/SQL"
       Fecha="02-06-2006"
       Versión="1.0"
       Diseñador="Carlos Navarro H."
       Programador="Carlos Navarro H."
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripción>Package de llamada a Servicios Atlantida</Descripción>
       <Parámetros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Parámetros>
    </Elemento>
   </Documentación>
*/
IS
   SUBTYPE ga_cod_servicio IS ga_servsupl.cod_servicio%TYPE;
   SUBTYPE ga_des_servicio IS ga_servsupl.des_servicio%TYPE;
   SUBTYPE ga_num_celular  IS ga_abocel.num_celular%TYPE;
   SUBTYPE ga_cod_cliente  IS ge_clientes.cod_cliente%TYPE;

   cv_error_no_clasif   VARCHAR2 (50) := 'No es posible clasificar el error';
   cv_nom_columna               VARCHAR2 (15) := 'COD_SERVICIO';
   cv_nom_tabla                 VARCHAR  (20) := 'GAD_SERVSUP_PLAN';
   cv_cod_modulo        VARCHAR2 (2)  := 'GA';
   cv_situacion_baja    VARCHAR2 (3)  := 'BAA';
   cn_cod_producto      NUMBER        := 1;
   cv_version           VARCHAR2 (2)  := '1';
   cn_cantidad_reg              NUMBER            := 1;
   cv_tip_relacion              VARCHAR2 (2)  := '3';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_cons_atlantida_abonado_pr (
      en_num_celular    IN              ga_abocel.num_celular%TYPE,
      sv_servicio       OUT NOCOPY      VARCHAR2,
      sv_cod_servicio   OUT NOCOPY      ga_servsupl.cod_servicio%TYPE,
      sv_des_servicio   OUT NOCOPY      ga_servsupl.des_servicio%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_cons_atlantida_cliente_pr (
      en_cod_cliente    IN              ge_clientes.cod_cliente%TYPE,
      sv_servicio       OUT NOCOPY      VARCHAR2,
      sv_cod_servicio   OUT NOCOPY      ga_servsupl.cod_servicio%TYPE,
      sv_des_servicio   OUT NOCOPY      ga_servsupl.des_servicio%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
END ga_cons_atlantida_pg;
/
SHOW ERRORS
