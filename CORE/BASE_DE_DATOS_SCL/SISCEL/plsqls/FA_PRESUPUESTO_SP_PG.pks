CREATE OR REPLACE PACKAGE fa_presupuesto_sp_pg
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "FA_PRESUPUESTO_SP_PG"
          Lenguaje="PL/SQL"
          Fecha="30-07-2007"
          Versión="1.0"
          Diseñador=""
          Programador="rao"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción></Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
</Elemento>
</Documentación>
*/
IS
   cv_error_no_clasif   VARCHAR2 (50) := 'No es posible clasificar el error';
   cv_cod_modulo        VARCHAR2 (2)  := 'FA';
   cv_version           VARCHAR2 (2)  := '1';
   cn_num66             CONSTANT NUMBER                               := 66;
   cn_largoerrtec       CONSTANT NUMBER                              := 500;
   cn_largodesc         CONSTANT NUMBER                             := 1000;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE fa_presupuesto_i_pr (
      registro          IN              fa_presupuesto_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE fa_presupuesto_u_pr (
      registro          IN              fa_presupuesto_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE fa_presupuesto_s_pr (
      registro          IN OUT NOCOPY   fa_presupuesto_qt,
      sr_row_id         OUT NOCOPY      ROWID,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE fa_presupuesto_d_pr (
      registro          IN              fa_presupuesto_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE fa_cons_arch_fact_pr (
      en_num_proceso    IN              fa_interimpresion_td.num_proceso%TYPE,
      sv_rutafac        OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END fa_presupuesto_sp_pg;
/
SHOW ERRORS
