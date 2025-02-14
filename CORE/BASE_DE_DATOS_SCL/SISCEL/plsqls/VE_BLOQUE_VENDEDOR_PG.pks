CREATE OR REPLACE PACKAGE ve_bloque_vendedor_pg
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "GE_CARTA_PG"
          Lenguaje="PL/SQL"
          Fecha="13-08-2007"
          Versión="1.0"
          Diseñador= "Marcelo Godoy"
        Programador="Marcelo Godoy"
          Ambiente Desarrollo="BD">
      <Descripción>Package servicios base para dirección</Descripción>
  </Elemento>
</Documentación>
*/
IS
   TYPE refcursor IS REF CURSOR;

   cv_error_no_clasif   CONSTANT VARCHAR2 (50)
                                       := 'No es posible clasificar el error';
   cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'VE';
   cv_version           CONSTANT VARCHAR2 (2)  := '1';
   ind_bloqueo          CONSTANT NUMBER (1)    := '1';
   ind_desbloqueo       CONSTANT NUMBER (1)    := '0';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_rec_estado_vendedor_pr (
      en_cod_vendedor    IN              ve_vendedores.cod_vendedor%TYPE,
      sb_ve_indbloqueo   OUT NOCOPY      BOOLEAN,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_bloqueo_vendedor_pr (
      en_cod_vendedor   IN              ve_vendedores.cod_vendedor%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE ve_rest_usu_vendedor_pr (
	    ev_param_entrada         IN               VARCHAR2,
        sn_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento            OUT NOCOPY		  ge_errores_pg.evento
	);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ve_bloque_vendedor_pg;
/
SHOW ERRORS
